class nginx {

  package { 'nginx':
  ensure => present,
  }
  
  file { '/var/www':
  ensure => directory,
  }
  
  file { '/etc/nginx/nginx.conf':
  ensure => file,
#  require => Package['nginx'],
  source => 'puppet:///modules/nginx/nginx.conf',
  }
  
  file { '/etc/nginx/conf.d/default.conf':
  ensure => file,
#  require => Package['nginx'],
  source => 'puppet:///modules/nginx/default.conf',
  }
  
  file { '/var/www/index.html':
  ensure => file,
  source => 'puppet:///modules/nginx/index.html',
  }
  
  service { 'nginx':
  ensure => running,
  enable => true,
  require => File['/etc/nginx/nginx.conf'],
  }
}
