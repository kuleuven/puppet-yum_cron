# Private class
class yum_cron::service {

  if $yum_cron::service_manage == true {

    service { 'yum-cron':
      ensure     => $yum_cron::service_ensure,
      enable     => $yum_cron::service_enable,
      name       => $yum_cron::service_name,
      provider   => $yum_cron::service_provider,
      hasstatus  => true,
      hasrestart => true,
    }
  }
}
