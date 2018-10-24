# == Class: yum_cron: See README.md for documentation
class yum_cron (
  $hostname,
  Boolean $apply_updates,
  Boolean $download_updates,
  Boolean $package_manage,
  Boolean $service_manage,
  Optional[Enum['undef', 'UNSET', 'absent', 'disabled']] $yum_autoupdate_ensure,
  Enum['yes','no'] $update_messages,
  Hash $extra_configs,
  Integer $output_width,
  Integer $random_sleep,
  Optional[Boolean] $service_enable,
  Optional[String] $package_ensure,
  Optional[String] $service_ensure,
  Optional[String] $service_provider,
  Pattern[/^(?:-)?[0-9]$/] $debug_level,
  Pattern[/^[0-6]$/] $cleanday,
  Pattern[/^[0-6]+$/] $days_of_week,
  Pattern[/^[0-9]+$/] $randomwait,
  #$randomwait = fqdn_rand(30)
  Stdlib::Absolutepath $config,
  Stdlib::Absolutepath $config_cron,
  Stdlib::Absolutepath $config_cron_hourly,
  String $email_from,
  String $email_host,
  String $email_to,
  String $emit_via,
  String $mailto,
  String $package_name,
  String $service_name,
  String $systemname,
  String $update_cmd,
){

  contain yum_cron::install
  contain yum_cron::config
  contain yum_cron::service

  Class['::yum_cron::install']
  -> Class['::yum_cron::config']
  ~> Class['::yum_cron::service']
}
