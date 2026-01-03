# tainrs/base:alpine

Lightweight Alpine Linux base image for media server containers. Provides robust process supervision, optional VPN mesh networking, and secure DNS resolution in a minimal footprint.

## Base Image

- **OS**: Alpine Linux 3.20
- **Architectures**: linux/amd64, linux/arm64
- **Image Size**: ~50-100MB

## Key Features

- **s6-overlay v3.2.1.0** - Init system with process supervision and graceful shutdown
- **Tailscale VPN** (optional) - Zero-config mesh networking with subnet routing and Funnel support
- **Unbound DNS** (optional) - Recursive resolver with DNS-over-TLS using Cloudflare upstream (1.1.1.1)
- **Unrar 7.0.9** - Compiled from source for RAR archive extraction
- **User Management** - Configurable UID/GID via PUID/PGID environment variables with automatic permission handling
- **XDG Base Directory** - Compliant directory structure (/config/.config, /config/.cache, /config/.local/share)
- **Startup Banner** - Version tracking and GitHub revision status check

## Use Case

Optimized for lightweight media server applications including Sonarr, Radarr, Lidarr, Prowlarr, and Readarr. The Alpine Linux base provides a minimal attack surface and reduced resource footprint while maintaining full functionality.

## Documentation

For detailed usage examples, environment variables reference, and configuration guides, visit the full documentation:

**[https://tainrs.github.io/site/](https://tainrs.github.io/site/)**

## License

Licensed under the Apache License, Version 2.0. See [LICENSE](LICENSE) for details.
