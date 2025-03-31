# Pocker

[English](README.md) | [中文](README_zh.md)

Pocker 是一个使用 Flutter 开发的容器管理工具，专注于提供 Podman 容器的图形化管理界面。项目名称 "Pocker" 来源于 "Podman" 和 "Docker" 的组合，旨在为 Podman 用户提供一个现代化的桌面管理工具。

## 功能特性

- 🐳 Podman 容器管理
  - 容器列表查看
  - 容器创建、启动、停止、删除
  - 容器日志查看
  - 容器资源监控
- 🖼️ 镜像管理
  - 镜像列表查看
  - 镜像拉取、删除
  - 镜像构建
- 🔧 系统设置
  - Podman 引擎配置
  - 系统托盘支持
  - 多语言支持

## 系统要求

- Flutter SDK ^3.7.0
- Podman 已安装并运行
- 支持的操作系统：
  - macOS
  - Linux
  - Windows

## 安装说明

1. 克隆项目仓库：
```bash
git clone https://github.com/pocker-dev/pocker.git
cd pocker
```

2. 安装依赖：
```bash
flutter pub get
```

3. 运行项目：
```bash
flutter run
```

## 开发

项目使用以下主要依赖：

- `provider`: 状态管理
- `easy_localization`: 国际化支持
- `desktop_window`: 桌面窗口管理
- `system_info2`: 系统信息获取
- `tray_manager`: 系统托盘支持

## 贡献指南

欢迎提交 Pull Request 或创建 Issue。在提交代码前，请确保：

1. 代码符合项目的代码规范
2. 所有测试通过
3. 提交信息清晰明了

## 许可证

本项目采用 MIT 许可证 - 详见 [LICENSE](LICENSE) 文件

## 致谢

- [Podman](https://podman.io/)
- [Flutter](https://flutter.dev/)
- [Podman Desktop](https://podman-desktop.io/) 