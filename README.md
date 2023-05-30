## About

Transmission is a fast, easy, and free BitTorrent client. It comes in several flavors:
  * A native macOS GUI application
  * GTK+ and Qt GUI applications for Linux, BSD, etc.
  * A Qt-based Windows-compatible GUI application
  * A headless daemon for servers and routers
  * A web UI for remote controlling any of the above
  
Visit https://transmissionbt.com/ for more information.
## Building
```
 docker build -f Dockerfile.base . -t transmission:4.0.3.base
 docker build . -t transmission:4.0.3
```

## P.S .

This transmission is customas to announce that downloads are zero.