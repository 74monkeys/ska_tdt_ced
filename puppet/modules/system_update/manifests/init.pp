# Class: system_update
#
# A OS Independent system package updater
#
# Parameters:
#
# Actions:
#   - Updates all packages on the system to latest versions
#
# Requires:
#
# Sample Usage:
#
class system_update(
  $system_update_command = $system_update::params::system_update_command,
) inherits system_update::params {
  exec { 'system-update':
      command => $system_update_command
  }

  Exec['system-update'] -> Package <| |>
}
