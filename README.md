# Pocker

[English](README.md) | [中文](README_zh.md)

Pocker is a container management tool developed with Flutter, focusing on providing a graphical interface for Podman containers. The project name "Pocker" is derived from the combination of "Podman" and "Docker", aiming to provide Podman users with a modern desktop management tool.

## Features

- 🐳 Podman Container Management
  - Container list view
  - Container creation, start, stop, and deletion
  - Container log viewing
  - Container resource monitoring
- 🖼️ Image Management
  - Image list view
  - Image pull and deletion
  - Image building
- 🔧 System Settings
  - Podman engine configuration
  - System tray support
  - Multi-language support

## System Requirements

- Flutter SDK ^3.7.0
- Podman installed and running
- Supported operating systems:
  - macOS
  - Linux
  - Windows

## Installation

1. Clone the repository:
```bash
git clone https://github.com/pocker-dev/pocker.git
cd pocker
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the project:
```bash
flutter run
```

## Development

The project uses the following main dependencies:

- `provider`: State management
- `easy_localization`: Internationalization support
- `desktop_window`: Desktop window management
- `system_info2`: System information retrieval
- `tray_manager`: System tray support

## Contributing

Pull requests and issues are welcome. Before submitting code, please ensure:

1. Code follows project coding standards
2. All tests pass
3. Commit messages are clear and descriptive

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details

## Acknowledgments

- [Podman](https://podman.io/)
- [Flutter](https://flutter.dev/)
- [Podman Desktop](https://podman-desktop.io/)