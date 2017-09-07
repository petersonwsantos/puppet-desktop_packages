class desktop_packages::install inherits desktop_packages {

  #$package_manage = lookup('desktop_packages::package_manage', {value_type => Boolean, default_value => 'true' })
  #$package_list = lookup('desktop_packages::package_list', {value_type => Hash, default_value => {} })

  if $package_list  != {} {
    $package_list .each | $k,$v | {
      package { $k:
        * => $v,
      }
    }
  }

}
 


 