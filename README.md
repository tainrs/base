# tainrs/base

Base Docker images for the Tainrs container platform, providing a robust foundation with s6-overlay process supervision, optional Tailscale VPN integration, and DNS-over-TLS support.

## Variants

This repository provides two base image variants optimized for different use cases:

- **alpine**: Lightweight Alpine Linux 3.20 base image for media server applications (Sonarr, Radarr, Lidarr, Prowlarr, Readarr)
- **jammy**: Ubuntu 22.04 (Jammy Jellyfish) base image specifically designed for Plex Media Server

## Comparison

| Feature | Alpine | Jammy |
|---------|--------|-------|
| **Base OS** | Alpine Linux 3.20 | Ubuntu 22.04 (Jammy) |
| **Architectures** | linux/amd64, linux/arm64 | linux/amd64 only |
| **Image Size** | ~50-100MB | ~200-300MB |
| **Package Manager** | apk | apt-get |
| **Primary Use Case** | Lightweight media servers | Plex Media Server |
| **Locale Support** | Built-in | en_US.UTF-8 (pre-configured) |

## Key Features

Both variants include:

- **s6-overlay v3.2.1.0** - Process supervision with graceful shutdown handling
- **Tailscale VPN** (optional) - Zero-config mesh networking with Funnel support
- **Unbound DNS** (optional) - Recursive resolver with DNS-over-TLS (Cloudflare upstream)
- **Unrar 7.0.9** - Compiled from source for RAR archive extraction
- **User Management** - Configurable UID/GID (PUID/PGID) with automatic permission handling
- **XDG Compliance** - Standard directory structure (.config, .cache, .local/share)

## Documentation

- **Alpine variant**: [README.md](https://github.com/tainrs/base/blob/alpine/README.md)
- **Jammy variant**: [README.md](https://github.com/tainrs/base/blob/jammy/README.md)
- **Full documentation**: [https://tainrs.github.io/site/](https://tainrs.github.io/site/)

## License

Licensed under the Apache License, Version 2.0. See [LICENSE](LICENSE) for details.
