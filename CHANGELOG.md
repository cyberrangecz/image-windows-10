# Changelog

## [qemu-0.6.0] - 2024-03-26
### Changed
- Windows license is activated by cloudbase-init
- Hibernation file is disabled
- Build is run with larger disk, which is then shrunk

## [qemu-0.5.0] - 2023-06-20
### Changed
- Update .NET to 4.8

## [qemu-0.4.3] - 2023-02-22
### Changed
- Use newer Windows ISO for newer Windows version
- Use newer cloudbase-init 1.1.4
- Resolves [(Issue #5)](https://gitlab.ics.muni.cz/muni-kypo-images/windows-10/-/issues/5)

## [qemu-0.4.2] - 2022-10-11
### Changed
- No changes, new build to install more windows updates

## [qemu-0.4.1] - 2021-12-01
### Changed
- Set `owner_specified.openstack.gui_access` to true

## [qemu-0.4.0], [vbox-0.3.0] - 2021-10-18
### Changed
- NTP server to ntp1.muni.cz
- Enabled RDP [(Issue #3)](https://gitlab.ics.muni.cz/muni-kypo-images/windows-10/-/issues/3)

## [vbox-0.2.0] - 2021-07-29
### Changed
- Allowed basic auth and http listener for winrm

## [vbox-0.1.0] - 2021-04-13
### Changed
- Disabled basic auth and http listener for winrm
- More windows updates will be installed
- Allowed ICMP ping for IPv4 and IPv6

## [qemu-0.3.0] - 2021-04-10
### Changed
- Disabled basic auth and http listener for winrm
- More windows updates will be installed
### Fixed
- Issue with password being changed on every reboot for `windows` user

## [qemu-0.2.0] - 2021-02-15
### Changed
- Allowed ICMP ping for IPv4 and IPv6
### Added
- This CHANGELOG file and versioning

## [qemu-0.1.0] - 2020-10-13
### Changed
- Started using [sysprep](https://docs.microsoft.com/en-us/windows-hardware/manufacture/desktop/sysprep--generalize--a-windows-installation)


[qemu-0.1.0]: https://gitlab.ics.muni.cz/muni-kypo-images/windows-10/-/tree/073b2753a8eef53c15a722edb5dd91475a7ccc38
[qemu-0.2.0]: https://gitlab.ics.muni.cz/muni-kypo-images/windows-10/-/tree/qemu-0.2.0
[qemu-0.3.0]: https://gitlab.ics.muni.cz/muni-kypo-images/windows-10/-/tree/qemu-0.3.0
[qemu-0.4.0]: https://gitlab.ics.muni.cz/muni-kypo-images/windows-10/-/tree/qemu-0.4.0
[qemu-0.4.1]: https://gitlab.ics.muni.cz/muni-kypo-images/windows-10/-/tree/qemu-0.4.1
[qemu-0.4.2]: https://gitlab.ics.muni.cz/muni-kypo-images/windows-10/-/tree/qemu-0.4.2
[qemu-0.4.3]: https://gitlab.ics.muni.cz/muni-kypo-images/windows-10/-/tree/qemu-0.4.3
[qemu-0.5.0]: https://gitlab.ics.muni.cz/muni-kypo-images/windows-10/-/tree/qemu-0.5.0
[qemu-0.6.0]: https://gitlab.ics.muni.cz/muni-kypo-images/windows-10/-/tree/qemu-0.6.0
[vbox-0.1.0]: https://gitlab.ics.muni.cz/muni-kypo-images/windows-10/-/tree/vbox-0.1.0
[vbox-0.2.0]: https://gitlab.ics.muni.cz/muni-kypo-images/windows-10/-/tree/vbox-0.2.0
[vbox-0.3.0]: https://gitlab.ics.muni.cz/muni-kypo-images/windows-10/-/tree/vbox-0.3.0
