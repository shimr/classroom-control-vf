class profile::example {
  notify { 'This is the example profile!': }
  
  include apache
  include wordpress
 
}

