# Manifest that creates hiera config overrride
notice('MODULAR: disable_ovs/mangle_network_scheme_for_remove_ovs_usage.pp')

# Initial constants
$plugin_name     = 'fuel-plugin-disable-ovs'
$plugin_settings = hiera_hash("${plugin_name}", {})
$network_scheme  = hiera_hash("network_scheme", {})

# Mangle network_scheme for setup new gateway
if $plugin_settings['metadata']['enabled'] {
  if $plugin_settings['network_name'] == 'another' {
    $network_name = $plugin_settings['another_network_name']
  } else {
    $network_name = $plugin_settings['network_name']
  }
  $mangled_network_scheme = mangle_network_scheme_for_remove_ovs_usage(
    $network_scheme
  )
  file {"/etc/hiera/plugins/${plugin_name}.yaml":
    ensure  => file,
    content => inline_template(
      "<%= @mangled_network_scheme %>\n  use_ovs: false\n"
    )
  }
}
# vim: set ts=2 sw=2 et :