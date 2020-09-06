# Samba Docker Container

Docker container that creates an SMB share.

***Note: As of 9/5/2020, this image does not appear to work anymore.***

## Running

```bash
docker run -d \
  -p 137:137/udp \
  -p 138:138/udp \
  -p 139:139 \
  -p 445:445 \
  -p 445:445/udp \
  --restart='always' \
  --hostname 'filer' \
  -v /media/stick:/share/stick \
  --name samba
  charlesmknox/samba:latest \
  -u "alice:abc123" \
  -u "bob:secret" \
  -s "Backup directory:/share/stick/backups:rw:alice,bob" \
  -s "Alice (private):/share/stick/data/alice:rw:alice" \
  -s "Bob (private):/share/stick/data/bob:rw:bob" \
  -s "Documents (readonly):/share/stick/data/documents:ro:alice,bob"
  -s "Public (readonly):/share/stick/data/public:ro:"
```

This example will bind `smbd` to docker host ip address
and mount two directories on docker host to container.
Additionally, the supplied hostname will be used for the NetBIOS name.
Two users will be created and given various access to four shares.
Omitting users from a share results in guest access.
The `public` share will have guest access and be browsable.

## Docker-compose Example

```yml
version: '2'
#volumes:
services:
  smbshare:
    image: charlesmknox/samba:latest
    restart: always
    ports:
      - 137:137/tcp
      - 137:137/udp
      - 138:138/tcp
      - 138:138/udp
      - 139:139
      - 445:445
      - 445:445/udp
    hostname: parenthostname
    volumes:
      - /mnt/smbsharefolder:/share/data
    command: -u "user:password" -u "user2:password" -s "smbsharename:/share/data:rw:user,user2"
```
