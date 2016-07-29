class nginx::params {
    case $::osfamily {
    'redhat' : {
      $package = 'nginx'
      $owner   = 'root'
      $group   = 'root'
      $default_docroot = '/var/www'
      $confdir = '/etc/nginx'
      $logdir  = '/var/log/nginx'
      $user    = 'nginx'
    }
    'debian' : {
      $package = 'nginx'
      $owner   = 'root'
      $group   = 'root'
      $default_docroot = '/var/www'
      $confdir = '/etc/nginx'
      $logdir  = '/var/log/nginx'
      $user    = 'www-data'
    }
    'windows' : {
      $package = 'nginx-service'
      $owner   = 'Administrator'
      $group   = 'Administrators'
      $default_docroot = 'C:/ProgramData/nginx/html'
      $confdir = 'C:/ProgramData/nginx'
      $logdir  = 'C:/ProgramData/nginx/logs'
      $user    = 'nobody'
    }
    default   : {
      fail("Module ${module_name} is not supported on ${::osfamily}")
    }
  }    
}
