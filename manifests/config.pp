# windows_packages::config
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include windows_packages::config
class windows_packages::config inherits windows_packages {

  # include chocolatey

  # =================================
  # MANAGE CHOCOLATEY INSTALATION
  # =================================

  # Override default Chocolatey install location
  # ChocolateyInstall=C:\ProgramData\chocolatey
  if $windows_packages::choco_install_location_manage == true {
    class {'chocolatey':
      choco_install_location => $windows_packages::choco_install_location_path ,
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
  if $windows_packages::choco_install_log_output == true {
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
  # FEATURES CONFIGURATION
  # =======================

  # Uninstall from Programs and Features without requiring an explicit uninstall script.
  if $windows_packages::chocolateyfeature_autouninstaller != {} {
    chocolateyfeature {'autouninstaller':
      ensure => $windows_packages::chocolateyfeature_autouninstaller ,
    }
  }


  # ** ONLY ** Chocolatey Pro / Business for this feature.
  # Virus Check - Performs virus checking on downloaded files. (Licensed versions only.)
  if $windows_packages::windows_packages::chocolateyfeature_viruscheck == true {
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
  # Chocolatey defines valid exit codes as 0, 1605, 614, 1641, 3010. With this feature disabled, Chocolatey exits with a 0 or a 1
  # dafault enabled
  # chocolateyfeature {'usepackageexitcodes':
  #  ensure => enabled,
  #}



  # =======================
  # CONFIG CONFIGURATION
  # =======================

  # Unset cache location
  # Removes cache location setting, returning the setting to its default.
  # C:\ProgramData\chocolatey\.chocolatey
  # chocolateyconfig {'cachelocation':
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
  if $windows_packages::chocolateyconfig_proxy_manage == true {
    chocolateyconfig {'proxy':
      value  => $windows_packages::chocolateyconfig_proxy_server,
    }
    chocolateyconfig {'proxyUser':
      value  => $windows_packages::chocolateyconfig_proxyuser,
    }
    chocolateyconfig {'proxyPassword':
      value  => $windows_packages::chocolateyconfig_proxypassword,
    }
  }

}
