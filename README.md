fuel-plugin-disable-ovs
=======================

**Table of Contents**

  * [Purpose](#purpose)
  * [Compatibility](#compatibility)
  * [How to build plugin](#how-to-build-plugin)
  * [How to install plugin](#how-to-install-plugin)
  * [Configuration](#configuration)
  * [How it works](#how-it-works)

## Purpose
The main purpose of this plugin is disable OVS usage in the host network topology. This plugin does not touch Neutron configuration.

## Compatibility

This plugin can be used with Fuel-9.0 and above.

## How to build plugin

* Install fuel plugin builder (fpb)
* Clone plugin repo and run fpb there:
```
# git clone https://github.com/xenolog/fuel-plugin-disable-ovs
# cd fuel-plugin-disable-ovs
# fpb --build .
```
* Check if file `fuel-plugin-disable-ovs-*.rpm` was created.
 
## How to install plugin

* Copy `fuel-plugin-disable-ovs-*.rpm` to master node
* Install `patch` utility and plugin
```
# yum install -y patch
# fuel plugins --install ./fuel-plugin-disable-ovs-1.0-1.0.1-1.noarch.rpm
```
* Check if plugin was installed
```
# fuel plugins --list
id | name                    | version | package_version | releases
---+-------------------------+---------+-----------------+--------------------------------------------
2  | fuel-plugin-disable-ovs | 1.0.1   | 4.0.0           | ubuntu (mitaka-9.0, mitaka-9.1, mitaka-9.2)
```
* Enable plugin in the `settings` tab of environment configuration page.

## Configuration
Plugin settings are available on Environment -> Settings -> Other page.  
You should enable plugin before deployment.

## How it works
General workflow

* Add one minor patch into l23network module if Fuel-9.0 detected. This patch already merged into Fuel-9.1.
* Override network_scheme for use 'lnx' provider, instead 'ovs'.