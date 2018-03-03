# windows_packages
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include windows_packages
class windows_packages(
  Boolean                        $choco_install_location_manage     = false,
  Boolean                        $choco_install_log_output          = false,
  Boolean                        $chocolateyconfig_proxy_manage     = false,
  String                         $chocolateyconfig_proxy_server     = undef,
  String                         $chocolateyconfig_proxyuser        = proxy_user,
  String                         $chocolateyconfig_proxypassword    = proxy_password,
  Enum['enabled','disabled']     $chocolateyfeature_autouninstaller = 'enabled',
  Boolean                        $chocolateyfeature_viruscheck      = false,
  Boolean                        $package_manage                    = true,
  Hash                           $package_list                      = {},
){
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
