package Hydra::Plugin::DiscordNotification;

use utf8;
use strict;
use warnings;
use parent 'Hydra::Plugin';
use Hydra::Helper::CatalystUtils qw(showJobName showStatus);
use JSON::MaybeXS qw(encode_json);
use HTTP::Request;
use LWP::UserAgent;
use POSIX qw(strftime);

sub isEnabled {
    return -r ($ENV{HYDRA_DISCORD_WEBHOOK_FILE} // '');
}

sub buildStarted {
    my ($self, $build) = @_;
    $self->send_notification($build, 'Started', 0);
}

sub buildFinished {
    my ($self, $build, $dependents) = @_;
    my $status = $build->buildstatus == 3 ? 'Aborted' : showStatus($build);
    $self->send_notification($build, $status, 1);
}

sub send_notification {
    my ($self, $build, $status, $finished) = @_;
    my $file = $ENV{HYDRA_DISCORD_WEBHOOK_FILE};
    open my $fh, '<', $file or do {
        warn "Cannot read Hydra Discord webhook file: $!\n";
        return;
    };
    my $webhook = <$fh>;
    close $fh;
    $webhook //= '';
    $webhook =~ s/\s+\z//;
    unless ($webhook =~ m{\Ahttps://discord\.com/api/webhooks/}) {
        warn "Invalid Hydra Discord webhook URL\n";
        return;
    }

    my $url = $self->{config}->{base_uri} . '/build/' . $build->id;
    my $color = !$finished ? 0x3498db
        : $build->buildstatus == 0 ? 0x2ecc71
        : $build->buildstatus == 3 || $build->buildstatus == 4 ? 0xf1c40f
        : 0xe74c3c;
    my @fields = (
        { name => 'Job', value => substr(showJobName($build), 0, 1024), inline => 0 },
        { name => 'System', value => substr($build->system, 0, 1024), inline => 1 },
        { name => 'Build', value => $url, inline => 0 },
    );
    my $nixname = $build->nixname;
    push @fields, { name => 'Nix name', value => substr($nixname, 0, 1024), inline => 1 }
        if defined $nixname && length $nixname;
    for my $time_field (
        [ 'Queued', $build->timestamp ],
        [ 'Started', $build->starttime ],
        ($finished ? ([ 'Finished', $build->stoptime ]) : ()),
    ) {
        my ($label, $epoch) = @$time_field;
        push @fields, { name => $label, value => "<t:$epoch:f>", inline => 1 }
            if defined $epoch && $epoch > 0;
    }
    if ($finished && defined $build->starttime && defined $build->stoptime) {
        my $seconds = $build->stoptime - $build->starttime;
        if ($seconds >= 0) {
            my $duration = sprintf '%dh %dm %ds',
                int($seconds / 3600), int($seconds / 60) % 60, $seconds % 60;
            push @fields, { name => 'Duration', value => $duration, inline => 1 };
        }
    }
    my $event_time = ($finished ? $build->stoptime : $build->starttime) // time;
    my $embed = {
        title => "Build #" . $build->id . " · $status",
        color => $color,
        fields => \@fields,
        timestamp => strftime('%Y-%m-%dT%H:%M:%SZ', gmtime($event_time)),
        footer => { text => 'Hydra · Fate' },
    };
    my $request = HTTP::Request->new('POST', $webhook);
    $request->header('Content-Type' => 'application/json');
    $request->content(encode_json({
        username => 'Hydra',
        embeds => [ $embed ],
        allowed_mentions => { parse => [] },
    }));

    my $response = LWP::UserAgent->new(
        timeout => 10,
        agent => 'Hydra-Discord-Notification/1.0',
    )->request($request);
    warn "Hydra Discord notification failed: " . $response->status_line . ": "
        . substr($response->decoded_content, 0, 500) . "\n"
        unless $response->is_success;
}

1;
