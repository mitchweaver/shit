# tor

Create a http proxy over tor the easy way!

## Ports

The exposed ports are:

| Port | Protocol |
| ---- | -------- |
| 9050 | SOCKS5 |
| 9051 | Tor control port |
| 8118 | HTTP(S) Proxy |

## How to use:

```
$ sudo docker-compose up -d
$ curl --proxy localhost:8118 https://check.torproject.org
```
