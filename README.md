[![Build Status](https://travis-ci.org/open-io/ansible-role-openio-rawx.svg?branch=master)](https://travis-ci.org/open-io/ansible-role-openio-rawx)
# Ansible role `rawx`

An Ansible role for OpenIO rawx.

Rawx is the storage service and is implemented as an apache webdav repository module.


## Requirements

- Ansible 2.4+

## Role Variables


| Variable   | Default | Comments (type)  |
| :---       | :---    | :---             |
| `openio_rawx_bind_address` | `{ hostvars[inventory_hostname]['ansible_' + openio_rawx_bind_interface]['ipv4']['address'] }}` | ... |
| `openio_rawx_bind_interface` | `"{{ ansible_default_ipv4.alias }}"` | ... |
| `openio_rawx_bind_port` | `6200` | ... |
| `openio_rawx_compression` | `"off"` | ... |
| `openio_rawx_fsync` | `enabled` | ... |
| `openio_rawx_fsync_dir` | `enabled` | ... |
| `openio_rawx_gridinit_dir` | `"/etc/gridinit.d/{{ openio_rawx_namespace }}"` | ... |
| `openio_rawx_gridinit_file_prefix` | `""` | ... |
| `openio_rawx_golang` | `false` | ... |
| `openio_rawx_hash_depth` | `1` | ... |
| `openio_rawx_hash_width` | `3` | ... |
| `openio_rawx_location` | `"{{ ansible_hostname }}.{{ openio_rawx_serviceid }}"` | ... |
| `openio_rawx_location_ending` | `""` | ... |
| `openio_rawx_mpm_max_requests_per_child` | `0` | ... |
| `openio_rawx_mpm_max_spare_threads` | `256` | ... |
| `openio_rawx_mpm_min_spare_threads` | `32` | ... |
| `openio_rawx_mpm_server_limit` | `16` | ... |
| `openio_rawx_mpm_start_servers` | `1` | ... |
| `openio_rawx_mpm_threads_per_child` | `256` | ... |
| `openio_rawx_namespace` | `"/var/lib/oio/sds/{{ openio_rawx_namespace }}/rawx-{{ openio_rawx_serviceid }}"` | ... |
| `openio_rawx_pid_directory` | `"/run/rawx/{{ openio_rawx_namespace }}/rawx-{{ openio_rawx_serviceid }}"` | ... |
| `openio_rawx_provision_only` | `false` | ... |
| `openio_rawx_serviceid` | `"0"` | ... |
| `openio_rawx_volume` | `"/var/lib/oio/sds/{{ openio_rawx_namespace }}/rawx-{{ openio_rawx_serviceid }}"` | ... |

## Dependencies

No dependencies.

## Example Playbook

```yaml
- hosts: all
  become: true
  vars:
    NS: OPENIO
  roles:
    - role: repo
      openio_repository_products:
        sds:
          release: "18.10"
    - role: namespace
      openio_namespace_name: "{{ NS }}"
    - role: gridinit
      openio_gridinit_namespace: "{{ NS }}"
    - role: role_under_test
      openio_rawx_namespace: "{{ NS }}"
      openio_rawx_serviceid: "0"
      openio_rawx_bind_port: 6200
      openio_rawx_volume: "/var/lib/oio/sds/{{ openio_rawx_namespace }}/rawx-{{ openio_rawx_serviceid }}"
```


```ini
[all]
node1 ansible_host=192.168.1.173
```

## Location

The administrator can declare the location of each service as a dot-separated string like room1.rack1.server2.volume4 (1 to 4 words)

http://docs.openio.io/arch-design/conscience.html#locations

## Contributing

Issues, feature requests, ideas are appreciated and can be posted in the Issues section.

Pull requests are also very welcome.
The best way to submit a PR is by first creating a fork of this Github project, then creating a topic branch for the suggested change and pushing that branch to your own fork.
Github can then easily create a PR based on that branch.

## License

GNU AFFERO GENERAL PUBLIC LICENSE, Version 3

## Contributors

- [Cedric DELGEHIER](https://github.com/cdelgehier) (maintainer)
