class desktop_packages (
  Boolean $package_manage, 
  Hash $package_list , 
  String $chocolateyfeature_autouninstaller, 
  Boolean $chocolateyconfig_proxy_manage,
  String $chocolateyconfig_proxy_server,
  String $chocolateyconfig_proxyUser,
  String $chocolateyconfig_proxyPassword,  
) {

  if $::kernel == 'windows' {
    Package { provider => chocolatey, }
  }

  contain desktop_packages::config
  contain desktop_packages::install

  Class['::desktop_packages::config']
  -> Class['::desktop_packages::install']

}


