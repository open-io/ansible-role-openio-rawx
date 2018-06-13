import os


class FilterModule(object):
    def filters(self):
        return {
            'device_inode': self.device_inode,
        }

    def device_inode(self, path):
        return os.stat(path).st_dev
