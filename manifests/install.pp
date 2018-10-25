# Private class
class yum_cron::install {

  if $yum_cron::package_manage {

    package { $yum_cron::package_name:
      ensure => $yum_cron::package_ensure,
    }

  }
}
