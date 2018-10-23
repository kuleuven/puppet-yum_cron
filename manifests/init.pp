# == Class: yum_cron: See README.md for documentation
class yum_cron (
  Boolean $apply_updates,
  Boolean $download_updates,
  Boolean $enable,
  Boolean $service_manage,
  Enum['present', 'absent'] $ensure,
  Enum['undef', 'UNSET', 'absent', 'disabled'] $yum_autoupdate_ensure,
  $hostname,
  Hash $extra_configs,
  Optional[Boolean] $service_enable,
  Optional[String] $package_ensure,
  Optional[String] $service_ensure,
  Optional[String] $service_provider,
  Stdlib::Absolutepath $config_path,
  String $package_name,
  String $service_name,
  # EL7/EL6 only options
  Pattern[/^(?:-)?[0-9]$/] $debug_level,
  Pattern[/^[0-9]+$/] $randomwait,
  String $mailto,
  String $systemname,
  # EL6 only options
  Pattern[/^[0-6]$/] $cleanday,
  Pattern[/^[0-6]+$/] $days_of_week,
  # EL7 only options
  String $update_cmd,
  Enum['yes','no'] $update_messages,
  String $email_host,
){

  case $ensure {
    'present': {
      $package_ensure_default   = 'present'
      if $enable {
        $service_ensure_default = 'running'
        $service_enable_default = true
        $config_notify          = Service['yum-cron']
      } else {
        $service_ensure_default = 'stopped'
        $service_enable_default = false
        $config_notify          = undef
      }
    }
    'absent': {
      $package_ensure_default = 'absent'
      $service_ensure_default = 'stopped'
      $service_enable_default = false
      $config_notify          = undef
    }
    default: {
      # Do nothing
    }
  }


  if $apply_updates {
    $apply_updates_str    = 'yes'
    $download_updates_str = 'yes'
    $check_only           = 'no'
    $download_only        = 'no'
  } else {
    $apply_updates_str  = 'no'
    $check_only         = 'yes'

    if $download_updates {
      $download_updates_str = 'yes'
      $download_only        = 'yes'
    } else {
      $download_updates_str = 'no'
      $download_only        = 'no'
    }
  }

  contain yum_cron::install
  contain yum_cron::config
  contain yum_cron::service

  Class['::yum_cron::install']
  -> Class['::yum_cron::config']
  ~> Class['::yum_cron::service']
}
