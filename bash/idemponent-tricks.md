

From https://arslan.io/2019/07/03/how-to-write-idempotent-bash-scripts/

mkdir -p
ln -sfn source target  (-n for directory)
rm -f


### Modifying files
```
if ! grep -qF "/mnt/dev" /etc/fstab; then
  echo "/dev/sda1 /mnt/dev ext4 defaults 0 0" | sudo tee -a /etc/fstab
fi
```

```
if [ ! -f "/etc/conf/foo.txt" ]; then
 echo "complex set of rules" > /etc/conf/foo.txt
fi
```

Other types of checks
  - '-d' - directory
  - '-p' - pipe
  - '-x' - file with exec permission


Another example
```
# install 1password CLI
if ! [ -x "$(command -v op)" ]; then
  export OP_VERSION="v0.5.6-003"
  curl -sS -o 1password.zip https://cache.agilebits.com/dist/1P/op/pkg/${OP_VERSION}/op_linux_amd64_${OP_VERSION}.zip
  unzip 1password.zip op -d /usr/local/bin
  rm -f 1password.zip
fi
```

### Formatting FS

blkid "$VOLUME_NAME" || mkfs.ext4 "$VOLUME_NAME"

### Mounting

```
if ! mountpoint -q "$DATA_DIR"; then
  mount -o discard,defaults,noatime "$VOLUME_NAME" "$DATA_DIR"
fi
```

