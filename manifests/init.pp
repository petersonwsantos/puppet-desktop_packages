class desktop_packages (

  Boolean                     $package_manage                    = true ,
  Hash                        $package_list                      = {}, 
  Enum['enabled','disabled']  $chocolateyfeature_autouninstaller = enabled, 
  Boolean                     $chocolateyconfig_proxy_manage     = false ,
  String                      $chocolateyconfig_proxy_server     = undef ,
  String                      $chocolateyconfig_proxyUser        = undef ,
  String                      $chocolateyconfig_proxyPassword    = undef ,

) {

  if $::kernel == 'windows' {
    
    # Ensure Chocolatey is installed and configured:  
    include chocolatey   
    Package { provider => chocolatey, }
    
    contain desktop_packages::config
    contain desktop_packages::install

    Class['::desktop_packages::config']
    -> Class['::desktop_packages::install']

  }

}

  
