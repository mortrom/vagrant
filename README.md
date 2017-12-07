# vagrant
Various vagrant implementations

## Usage
1. Install vagrant and virtual box.  See Dependencies below.
2. Clone/fork this repo.
3. cd into the rancher-server directory.
4. vagrant up
5. In a browser enter <hostname>:8080
6. Wait for the Rancher GUI to appear - it may take a minute.
7. If a rancher host is required, cd to rancher-host and run vagrant up.
8. A host should appear on the hosts window of the GUI.
9. Done.

## Dependencies
These configurations have been tested with the following versions

  - vagrant - 1.9.1 - https://www.vagrantup.com/downloads.html
  - virtual box - 5.1.14 r112924 (Qt5.6.2) -  https://www.virtualbox.org/wiki/Downloads
  - macOS High Sierra - 10.13.1 - https://www.apple.com/au/macos

They will likely work with other versions/OS types but are untested.

## License
See [here](./LICENSE)
