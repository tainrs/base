# tainrs/base:jammy

Ubuntu 22.04 (Jammy Jellyfish) base image designed specifically for Plex Media Server. Provides the same robust feature set as the Alpine variant while maintaining compatibility with Plex's Ubuntu requirement.

## Base Image

- **OS**: Ubuntu 22.04 (Jammy Jellyfish)
- **Architectures**: linux/amd64 (ARM64 not supported)
- **Image Size**: ~200-300MB

## Key Features

- **s6-overlay v3.2.1.0** - Init system with process supervision and graceful shutdown
- **Tailscale VPN** (optional) - Zero-config mesh networking with subnet routing and Funnel support (pre-configured for Plex port 32400)
- **Unbound DNS** (optional) - Recursive resolver with DNS-over-TLS using Cloudflare upstream (1.1.1.1)
- **Unrar 7.0.9** - Compiled from source for RAR archive extraction
- **User Management** - Configurable UID/GID via PUID/PGID environment variables with automatic permission handling
- **XDG Base Directory** - Compliant directory structure (/config/.config, /config/.cache, /config/.local/share)
- **Locale Support** - Pre-configured en_US.UTF-8 locale
- **Startup Banner** - Version tracking and GitHub revision status check

## Use Case

Built specifically for Plex Media Server, which requires an Ubuntu-based environment. The Jammy base provides full compatibility with Plex's official requirements while adding optional VPN and DNS features.

**Note**: Plex does not officially support ARM64 architecture, so this variant is AMD64-only. For lightweight media servers (Sonarr, Radarr, Lidarr, Prowlarr, Readarr) with ARM64 support, use the [Alpine variant](https://github.com/tainrs/base/blob/alpine/README.md).

## Documentation

For detailed usage examples, environment variables reference, and configuration guides, visit the full documentation:

**[https://tainrs.github.io/site/](https://tainrs.github.io/site/)**

## License

Licensed under the Apache License, Version 2.0. See [LICENSE](LICENSE) for details.
