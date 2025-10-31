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

**Made with ❤️ for photographers, designers, and anyone dealing with lots of images.**