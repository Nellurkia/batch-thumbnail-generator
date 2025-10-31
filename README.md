# 🖼️ Thumbnail Generator

A lightweight Windows tool for batch generating image thumbnails with high quality and automatic detection.

## ✨ Features

- 🔍 **Auto Detection**: Automatically scans current directory and all subdirectories for images
- 📁 **Batch Processing**: Process multiple images at once while maintaining folder structure  
- 🎨 **High Quality**: Uses advanced bicubic interpolation for crisp thumbnails
- 📏 **Smart Resize**: Maintains aspect ratio while resizing to 200x200px
- 🚫 **Skip Duplicates**: Automatically skips existing thumbnails to avoid reprocessing
- 💾 **Multiple Formats**: Supports PNG, JPG, JPEG, BMP, GIF
- ⚡ **No Dependencies**: Uses Windows built-in .NET Framework

## 🚀 Quick Start

1. Download `ThumbnailGenerator.exe` from [Releases](../../releases)
2. Place it in any folder containing images
3. Double-click to run
4. Thumbnails will be generated with `_thumbnail` suffix

## 📋 Example

```
📁 photos/
├── 📄 ThumbnailGenerator.exe
├── 📁 vacation/
│   ├── 🖼️ beach.jpg
│   ├── 🖼️ beach_thumbnail.jpg     ← Generated
│   ├── 🖼️ sunset.png
│   └── 🖼️ sunset_thumbnail.png    ← Generated
└── 📁 family/
    ├── 🖼️ party.jpg
    └── 🖼️ party_thumbnail.jpg      ← Generated
```

## ⚙️ Configuration

You can modify the PowerShell script to customize:

- **Thumbnail Size**: Change `$ThumbnailSize = 200` (default: 200px)
- **JPEG Quality**: Adjust `$Quality = 85` (range: 1-100)
- **Supported Formats**: Edit `$SupportedFormats` array

## 🛠️ Build from Source

### Prerequisites
- Windows PowerShell 5.0+
- ps2exe module

### Steps
```powershell
# Install ps2exe module
Install-Module -Name ps2exe -Force -Scope CurrentUser

# Clone repository
git clone https://github.com/yourusername/thumbnail-generator.git
cd thumbnail-generator

# Build executable
.\compile.bat
```

## 📝 Files Description

- `ThumbnailGenerator.ps1` - Main PowerShell script
- `ThumbnailGenerator.exe` - Compiled executable (ready to use)
- `compile.bat` - Build script for creating exe
- `build-exe.ps1` - PowerShell build script

## 🔧 Troubleshooting

**Script execution policy error?**
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

**No images found?**
- Ensure images are in supported formats: PNG, JPG, JPEG, BMP, GIF
- Check that files are not hidden or in system folders

**Permission denied?**
- Run as administrator if processing system directories
- Ensure destination folder is writable

## 📄 License

MIT License - feel free to use, modify, and distribute.

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## ⭐ Support

If this tool helped you, please give it a star! ⭐

---


**Made with ❤️ and Kiro, for site owners, server administrators, and anyone dealing with lots of images and wish to save traffic.**

# 缩略图生成器使用说明

## 功能特点
- 自动检测当前目录及所有子目录下的图片文件
- 支持格式：PNG、JPG、JPEG、BMP、GIF
- 生成200x200像素的缩略图（保持宽高比）
- 缩略图文件名格式：`原文件名_thumbnail.扩展名`
- 自动跳过已存在的缩略图，避免重复处理

## 使用方法

### 方法1：使用批处理文件（推荐）
1. 运行 `compile-simple.bat` 生成 `ThumbnailGenerator.bat`
2. 将 `ThumbnailGenerator.bat` 和 `ThumbnailGenerator.ps1` 复制到需要处理图片的目录
3. 双击 `ThumbnailGenerator.bat` 运行

### 方法2：编译为exe文件
1. 运行 `build-exe.bat`（需要管理员权限安装ps2exe模块）
2. 生成 `ThumbnailGenerator.exe`
3. 将exe文件放到任何包含图片的目录中运行

## 示例
```
assets/images/
├── ThumbnailGenerator.bat
├── ThumbnailGenerator.ps1
├── 20240406/
│   ├── pic1.png
│   ├── pic1_thumbnail.png  ← 自动生成
│   ├── pic2.jpg
│   └── pic2_thumbnail.jpg  ← 自动生成
└── 20240413/
    ├── photo.png
    └── photo_thumbnail.png  ← 自动生成
```

## 配置选项
可以修改 `ThumbnailGenerator.ps1` 中的参数：
- `$ThumbnailSize = 200`：缩略图尺寸
- `$Quality = 85`：JPEG质量（1-100）
- `$SupportedFormats`：支持的文件格式

## 注意事项
- 首次运行可能需要允许PowerShell脚本执行
- 处理大量图片时请耐心等待
- 缩略图会保存在原图片相同的目录中
