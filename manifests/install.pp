class desktop_packages::install inherits desktop_packages {

  # Ensure Chocolatey is installed and configured:	
  #include chocolatey  	

  if $package_list  != {} {
    $package_list .each | $k,$v | {
      package { $k:
        * => $v,
      }
    }
  }

}
