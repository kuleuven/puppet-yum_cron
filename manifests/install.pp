# Private class
class yum_cron::install {

  if $yum_cron::package_manage {

    package { $yum_cron::package_name:
      ensure => $yum_cron::package_ensure,
    }

    if $::operatingsystem =~ /Scientific/ and $yum_cron::yum_autoupdate_ensure == 'absent' {
      package { 'yum-autoupdate':
        ensure  => absent,
      }
    }
  }
}
