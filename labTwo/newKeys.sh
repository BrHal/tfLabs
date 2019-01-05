#!/bin/bash
ssh-keygen -b 4096 -t rsa -N '' -f AnsibleKey -C "ansible key"
mv AnsibleKey AnsibleKey.pem
# cloud-init write-file requires b64 or multiline will fail yaml
base64 -w0 AnsibleKey.pem > AnsibleKey.pem.b64
ssh-keygen -b 4096 -t rsa -N '' -f AdminKey -C "admin key"
mv AdminKey AdminKey.pem
