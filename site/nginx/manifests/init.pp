class nginx {
  case $::osfamily {
    'redhat' : {
      $package = 'nginx'
      $owner   = 'root'
      $group   = 'root'
      if $root {$docroot = $root} else {$docroot = '/var/www'}
      $confdir = '/etc/nginx'
      $logdir  = '/var/log/nginx'
      $user    = 'nginx'
    }
    'debian' : {
      $package = 'nginx'
      $owner   = 'root'
      $group   = 'root'
      if $root {$docroot = $root} else {$docroot = '/var/www'}
      $confdir = '/etc/nginx'
      $logdir  = '/var/log/nginx'
      $user    = 'www-data'
    }
    'windows' : {
      $package = 'nginx-service'
      $owner   = 'Administrator'
      $group   = 'Administrators'
      if $root {$docroot = $root} else {$docroot = 'C:/ProgramData/nginx/html'}
      $confdir = 'C:/ProgramData/nginx'
      $logdir  = 'C:/ProgramData/nginx/logs'
      $user    = 'nobody'
    }
    default   : {
      fail("Module ${module_name} is not supported on ${::osfamily}")
    }
  }
  
  package { $package:
    ensure => present,
  }
  File {
    owner => $owner,
    group => $group,
    mode => '0664',
  }
  file { $docroot:
    ensure => directory,
    mode   => '0775',
  }
  file { "${docroot}/index.html":
    ensure => file,
    source => 'puppet:///modules/nginx/index.html',
  }
  file { "${confdir}/nginx.conf":
    ensure  => file,
    content  => template('nginx/nginx.conf.erb'),
    require => Package[$package],
    notify  => Service['nginx'],
  }
  file { "${confdir}/conf.d":
    ensure => directory,
    mode   => '0775',
  }
  file { "${confdir}/conf.d/default.conf":
    ensure  => file,
    content  => template('nginx/default.conf.erb'),
    require => Package[$package],
    notify  => Service['nginx'],
  }
  service { 'nginx':
    ensure    => running,
    enable    => true,
  }
}
