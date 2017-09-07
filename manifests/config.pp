class desktop_packages::config  inherits desktop_packages {

  # include chocolatey 

  # =================================
  # MANAGE CHOCOLATEY INSTALATION   
  # =================================

  # Override default Chocolatey install location
  # ChocolateyInstall=C:\ProgramData\chocolatey
  if $choco_install_location_manage == true {
    class {'chocolatey':
      choco_install_location => $choco_install_location_path ,
    }
  }

  #chocolateysource {'chocolatey':
  #  ensure   => present,
  #  location => 'https://chocolatey.org/api/v2',
  #  priority => 1,
  #}

  # Use an internal chocolatey.nupkg for Chocolatey installation
  #class {'chocolatey':
  #  chocolatey_download_url         => 'https://internalurl/to/chocolatey.nupkg',
  #  use_7zip                        => false,
  #  choco_install_timeout_seconds   => 2700,
  #}
  # OR 
  #class {'chocolatey':
  #  chocolatey_download_url         => 'file:///c:/location/of/chocolatey.0.9.9.9.nupkg',
  #  use_7zip                        => false,
  #  choco_install_timeout_seconds   => 2700,
  #  chocolatey_version              => '0.9.9.9',
  #}

  # Disable the default community repository source
  #chocolateysource {'chocolatey':
  #    ensure => disabled,
  #}
     

  #Log chocolatey bootstrap installer script output
  if $choco_install_log_output == true {
    class {'chocolatey':
      log_output => true  ,
    }
  } 

  # =======================
  # SOURCES CONFIGURATION 
  # =======================

  # Set a priority on a source
  #chocolateysource {'chocolatey':
  #  ensure   => present,
  #  location => 'https://chocolatey.org/api/v2',
  #  priority => 1,
  #}

  # Disable the default community repository source
  #chocolateysource {'chocolatey':
  #  ensure => enabled,
  #}
  #chocolateysource {'chocolatey':
  #  ensure => disabled,
  #}

  # Add credentials to a source
  #chocolateysource {'sourcename':
  #  ensure   => present,
  #  location => 'https://internal/source',
  #  user     => 'username',
  #  password => 'password',
  #}

  # =======================
  # FEAATURES CONFIGURATION 
  # =======================

  # Uninstall from Programs and Features without requiring an explicit uninstall script.
  if $chocolateyfeature_autouninstaller != {} {
    chocolateyfeature {'autouninstaller':
      ensure => $chocolateyfeature_autouninstaller ,
    }
  }


  # ** ONLY ** Chocolatey Pro / Business for this feature.
  # Virus Check - Performs virus checking on downloaded files. (Licensed versions only.)
  if $chocolateyfeature_viruscheck == true {
    chocolateyfeature {'viruscheck':
      ensure => enabled,
    }
  }   
  else {
    chocolateyfeature {'viruscheck':
      ensure => disabled,
    } 
  }
  # Use Package Exit Codes - Allows package scripts to provide exit codes. 
  # With this enabled, Chocolatey uses package exit codes for exit when non-zero (this value can come from a dependency package). 
  # Chocolatey defines valid exit codes as 0, 1605, 1614, 1641, 3010. With this feature disabled, Chocolatey exits with a 0 or a 1 
  # dafault enabled
  #hocolateyfeature {'usepackageexitcodes':
  #  ensure => enabled,
  #}



  # =======================
  # CONFIG CONFIGURATION 
  # =======================

  # Unset cache location
  # Removes cache location setting, returning the setting to its default.
  # C:\ProgramData\chocolatey\.chocolatey
  #chocolateyconfig {'cachelocation':
  #  ensure => absent,
  #}

  #Set cache location
  # The cache location defaults to the TEMP directory. You can set an explicit directory to cache downloads to instead of the default.
  # chocolateyconfig {'cachelocation':
  # value  => "c:\\downloads",
  # }

  # Use an explicit proxy
  # When using Chocolatey behind a proxy, set proxy and optionally proxyUser and proxyPassword.
  # NOTE: The proxyPassword value is not verifiable.
  if $chocolateyconfig_proxy_manage == true {
    chocolateyconfig {'proxy':
      value  => $chocolateyconfig_proxy_server,
    }
    chocolateyconfig {'proxyUser':
      value  => $chocolateyconfig_proxyUser,
    }
    chocolateyconfig {'proxyPassword':
      value  => $chocolateyconfig_proxyPassword,
    }
  } 

}


