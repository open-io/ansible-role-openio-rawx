[![Build Status](https://travis-ci.org/open-io/ansible-role-openio-rawx.svg?branch=master)](https://travis-ci.org/open-io/ansible-role-openio-rawx)
# Ansible role `rawx`

An Ansible role for OpenIO rawx.

Rawx is the storage service and is implemented as an apache webdav repository module.


## Requirements

- Ansible 2.4+

## Role Variables


| Variable   | Default | Comments (type)  |
| :---       | :---    | :---             |
| `openio_rawx_bind_address` | `hostvars[inventory_hostname]['ansible_' + openio_rawx_bind_interface]['ipv4']['address']` | The address that these rawx instances will run on |
| `openio_rawx_bind_interface` | `ansible_default_ipv4.alias` | The interface that these rawx instance will run on |
| `openio_rawx_bind_port_start_at` | `6200` | Port of the first instance. The instance's index is added to it |
| `openio_rawx_compression` | `"off"` | Enable compression |
| `openio_rawx_fsync` | `enabled enabled` | Do fsync on file close |
| `openio_rawx_fsync_dir` | `enabled` | Do fsync on chunk directory after renaming |
| `openio_rawx_hash_depth` | `1` | number of sub-directories in hash |
| `openio_rawx_hash_width` | `3` | number of characters in hash directory name |
| `openio_rawx_instances` | `list` | List of `dict` like {'path': '/mnt/sdb', 'location': 'hostname'} |
| `openio_rawx_location_ending` | `""` | Auto tune the location `device_inode` or `mount_point` are possible |
| `openio_rawx_mpm_min_spare_threads` | `75` | Minimum number of idle threads to handle request spikes |
| `openio_rawx_mpm_max_requests_per_child` | `0` | This directive sets the number of threads created by each child process |
| `openio_rawx_mpm_server_limit` | `16` | This directive in combination with ThreadLimit sets the maximum configured value for MaxRequestWorkers for the lifetime of the Apache httpd process |
| `openio_rawx_mpm_max_spare_threads` | `250` | Maximum number of idle threads |
| `openio_rawx_mpm_start_servers` | `3` | This directive sets the number of child server processes created on startup |
| `openio_rawx_mpm_threads_per_child` | `25` | This directive sets the number of threads created by each child process |
| `openio_rawx_namespace` | `"OPENIO"` | Namespace |
| `openio_rawx_version` | `'latest'` | Install a specific version |

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
    - role: gridinit
      openio_gridinit_namespace: "{{ NS }}"
    - role: rawx
      openio_rawx_namespace: "{{ NS }}"
      #openio_rawx_location_ending: "device_inode"
      openio_rawx_instances:
        - path: "/mnt/sdb1"
        - path: "/mnt/sdc1"
          location: "rack1.{{ ansible_hostname }}.sdc1"
        - path: "/mnt/sdd1"
```


```ini
[all]
node1 ansible_host=192.168.1.173
```
## Legacy
Historically, the port of a rawx is the 6004/tcp.
This is a problem for scaling. This role proposes to start at `6200`.

But you can find this legacy port like this:

```yaml
- role: rawx
  openio_rawx_bind_port_start_at: 6004
  openio_rawx_instances:
    - path: "/mnt/sdb1"
```

## Location

The administrator can declare the location of each service as a dot-separated string like room1.rack1.server2.volume4 (1 to 4 words)

http://docs.openio.io/arch-design/conscience.html#locations

By default, this role defines the location to `ansible_hostname`.
You can defines yourself the location like that :

```yaml
openio_rawx_instances:
  - path: "/mnt/sdb1"
  - path: "/mnt/sdc1"
    location: "rack1.{{ ansible_hostname }}"
  - path: "/mnt/sdd1"
```

With the `openio_rawx_location_ending`, you can add a suffix to your `ansible_hostname`

* `device_inode`: Add the filesystem id
* `mount_point`: Add the last folder of the mount point

> **Note:**
> - With the `mount_point` option, the location still valid if you replace the defective block device by mouting the new one to the same place

## Contributing

Issues, feature requests, ideas are appreciated and can be posted in the Issues section.

Pull requests are also very welcome.
The best way to submit a PR is by first creating a fork of this Github project, then creating a topic branch for the suggested change and pushing that branch to your own fork.
Github can then easily create a PR based on that branch.

## License

Apache License, Version 2.0

## Contributors

- [Cedric DELGEHIER](https://github.com/cdelgehier) (maintainer)
