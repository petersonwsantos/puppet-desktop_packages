# windows_packages::install
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include windows_packages::install
class windows_packages::install inherits windows_packages {

  if $windows_packages::package_list  != {} {

    $windows_packages::package_list .each | $k,$v | {
      package { $k:
        * => $v,
      }
    }

  }

}

