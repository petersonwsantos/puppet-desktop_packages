class desktop_packages (

  Boolean                     $choco_install_location_manage     = false , 
  Stdlib::Absolutepath        $choco_install_location_path               , 
  Boolean                     $choco_install_log_output          = false , 

  Boolean                     $chocolateyconfig_proxy_manage     = false ,
  String                      $chocolateyconfig_proxy_server     = undef ,
  String                      $chocolateyconfig_proxyUser        = undef ,
  String                      $chocolateyconfig_proxyPassword    = undef ,

  Enum['enabled','disabled']  $chocolateyfeature_autouninstaller = enabled ,
  Bolean                      $chocolateyfeature_viruscheck      = false   ,

  Boolean                     $package_manage                    = true  ,
  Hash                        $package_list                      = {}    , 

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

  
