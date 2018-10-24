# Private class
class yum_cron::config {

  $randomwait = fqdn_rand(300)


  if $::operatingsystemmajrelease = '7' {

    file { $yum_cron::config:
      ensure  => file,
      owner   => 0,
      group   => 0,
      mode    => '0644',
      content => epp('yum_cron/yum-cron.conf.epp'),
      notify  => Service['yum-cron'],
    }

    file { $yum_cron::config_cron:
      ensure  => file,
      owner   => 0,
      group   => 0,
      mode    => '0644',
      content => epp('yum_cron/yum-cron.conf.epp'),
      notify  => Service['yum-cron'],
    }

    file { $yum_cron::config_cron_hourly:
      ensure  => file,
      owner   => 0,
      group   => 0,
      mode    => '0644',
      content => epp('yum_cron/0yum-hourly.cron.epp'),
    }
  }

  if $::operatingsystemmajrelease = '6' {

    file { $yum_cron::config:
      ensure  => file,
      owner   => 0,
      group   => 0,
      mode    => '0644',
      content => epp('yum_cron/yum-cron.epp'),
      notify  => Service['yum-cron'],
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
