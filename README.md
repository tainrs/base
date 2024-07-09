# Base Docker Image

This repository contains a base Docker image designed to be the foundation for building other Docker images. This base image includes essential tools and configurations to streamline the development process.

## Table of Contents

- [Features](#features)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Usage](#usage)
- [Configuration](#configuration)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)

## Features

- **Lightweight**: Minimalistic design to ensure fast build times.
- **Configurable**: Easily extendable to include additional tools and libraries.
- **Secure**: Regular updates to address security vulnerabilities.
- **Multi-platform support**: Compatible with various architectures.

## Getting Started

### Prerequisites

- Docker installed on your machine. You can download it from [Docker's official website](https://www.docker.com/get-started).

### Installation

To build the Docker image locally, clone the repository and run the following command:

```bash
git clone https://github.com/tainrs/base.git
cd base
docker build -t base-image .
```

Alternatively, you can use the `build.sh` script to build the image:

```bash
git clone https://github.com/tainrs/base.git
cd base
./build.sh amd64
```

### Usage

You can use this base image as the starting point for your Docker projects. Here’s an example of a `Dockerfile` that extends this base image:

```Dockerfile
FROM base-image

# Install additional packages
RUN apt-get update && apt-get install -y \
    curl \
    vim

# Set up your application
COPY . /app
WORKDIR /app

# Run the application
CMD ["./run.sh"]
```

Build your custom image using:

```bash
docker build -t custom-image .
```

## Configuration

The base image can be customized by modifying the `Dockerfile` in this repository. You can add or remove packages, change environment variables, and configure other settings to suit your needs.

## Contributing

Contributions are welcome! Please follow these steps to contribute:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch`).
3. Make your changes.
4. Commit your changes (`git commit -m 'Add new feature'`).
5. Push to the branch (`git push origin feature-branch`).
6. Open a pull request.

Please ensure your code adheres to the coding standards and includes appropriate tests.

## License

This project is licensed under the GNU General Public License v3.0. See the [LICENSE](LICENSE) file for details.

## Contact

If you have any questions, feel free to reach out:

- **Maintainer**: B. van Wetten
- **Email**: [tainrs@bvw.email](mailto:tainrs@bvw.email)
