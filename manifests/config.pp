# Private class
class yum_cron::config {


  file { $yum_cron::config:
    ensure  => file,
    owner   => 0,
    group   => 0,
    mode    => '0644',
    content => epp('yum_cron/yum-cron.conf.epp'),

  }

  file { $yum_cron::config_cron:
    ensure  => file,
    owner   => 0,
    group   => 0,
    mode    => '0644',
    content => epp('yum_cron/0yum-hourly.cron.epp'),
  }


  if $yum_cron::ensure == 'present' {

    if $::operatingsystemmajrelease < '7' {
      Shellvar {
        ensure => present,
        target => $yum_cron::config_path,
        notify => $yum_cron::config_notify,
      }

      shellvar { 'yum_cron CHECK_ONLY':
        variable => 'CHECK_ONLY',
        value    => $yum_cron::check_only,
      }

      shellvar { 'yum_cron DOWNLOAD_ONLY':
        variable => 'DOWNLOAD_ONLY',
        value    => $yum_cron::download_only,
      }

      if $::operatingsystemmajrelease == '6' {
        shellvar { 'yum_cron DEBUG_LEVEL':
          variable => 'DEBUG_LEVEL',
          value    => $yum_cron::debug_level,
        }

        shellvar { 'yum_cron RANDOMWAIT':
          variable => 'RANDOMWAIT',
          value    => $yum_cron::randomwait,
        }

        shellvar { 'yum_cron MAILTO':
          variable => 'MAILTO',
          value    => $yum_cron::mailto,
        }

        shellvar { 'yum_cron SYSTEMNAME':
          variable => 'SYSTEMNAME',
          value    => $yum_cron::systemname,
        }

        shellvar { 'yum_cron DAYS_OF_WEEK':
          variable => 'DAYS_OF_WEEK',
          value    => $yum_cron::days_of_week,
        }

        shellvar { 'yum_cron CLEANDAY':
          variable => 'CLEANDAY',
          value    => $yum_cron::cleanday,
        }

        create_resources(shellvar, $yum_cron::extra_configs)
      }
    }

    if $::operatingsystem =~ /Scientific/ and $yum_cron::yum_autoupdate_ensure == 'disabled' {
      file_line { 'disable yum-autoupdate':
        path  => '/etc/sysconfig/yum-autoupdate',
        line  => 'ENABLED=false',
        match => '^ENABLED=.*',
      }
    }
  }
}
