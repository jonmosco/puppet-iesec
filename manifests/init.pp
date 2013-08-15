# == Class: iesec
#
# == Description
#
# Internet Explorer Enhanced Security
# Provides extra security for web browsing, disabling various controls such 
# as ActiveX
#
# == Parameters
#
# $iesec_admin
# accepts a boolean true or false
# true enables IESEC for the administrator account
# false disables IESEC for the administrator account
#
# $iesec_users
# accepts a boolean true or false
# true enables IESEC for all users
# false disables IESEC for all users
#
# == Authors
#
# Thomas Linkin <tom@puppetlabs.com>
# Jon Mosco <jonny.mosco@gmail.com>
#
class iesec (
  # Keep IE SEC enabled as a safe default
  $iesec_admin = true,
  $iesec_users = true,
) {

  if $::operatingsystem != 'Windows' {
    fail ("Class[iesec] can only be applied to Windows systems. It cannot be used on \"${::operatingsystem}.\"")
  }

  validate_bool($iesec_admin)
  validate_bool($iesec_users)

  if $iesec_admin {
    $_iesec_admin = '1'
  } else {
    $_iesec_admin = '0'
  }

  if $iesec_users {
    $_iesec_users = '1'
  } else {
    $_iesec_users = '0'
  }

  # Disable IE SEC for Admins
  registry_value { 'HKLM\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}\IsInstalled':
    type  => dword,
    data  => $_iesec_admin,
  }

  # Disable IE SEC for Users
  registry_value { 'HKLM\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}\IsInstalled':
    type  => dword,
    data  => $_iesec_users,
  }
}
