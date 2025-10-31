# 缩略图生成器
# 自动检测当前目录及子目录下的图片文件，生成缩略图

Add-Type -AssemblyName System.Drawing

# 配置参数
$ThumbnailSize = 200  # 缩略图尺寸
$Quality = 85         # JPEG质量 (1-100)
$SupportedFormats = @('.png', '.jpg', '.jpeg', '.bmp', '.gif')

function Write-Log {
    param($Message, $Color = "White")
    Write-Host "[$(Get-Date -Format 'HH:mm:ss')] $Message" -ForegroundColor $Color
}

function Get-ImageFormat {
    param($Extension)
    switch ($Extension.ToLower()) {
        '.png' { return [System.Drawing.Imaging.ImageFormat]::Png }
        '.jpg' { return [System.Drawing.Imaging.ImageFormat]::Jpeg }
        '.jpeg' { return [System.Drawing.Imaging.ImageFormat]::Jpeg }
        '.bmp' { return [System.Drawing.Imaging.ImageFormat]::Bmp }
        '.gif' { return [System.Drawing.Imaging.ImageFormat]::Gif }
        default { return [System.Drawing.Imaging.ImageFormat]::Jpeg }
    }
}

function Get-FileExtension {
    param($FilePath)
    $lastDot = $FilePath.LastIndexOf('.')
    if ($lastDot -ge 0) {
        return $FilePath.Substring($lastDot)
    }
    return ""
}

function Create-Thumbnail {
    param(
        [string]$SourcePath,
        [string]$DestinationPath,
        [int]$Size
    )
    
    try {
        # 加载原始图片
        $originalImage = [System.Drawing.Image]::FromFile($SourcePath)
        
        # 计算缩略图尺寸，保持宽高比
        $originalWidth = $originalImage.Width
        $originalHeight = $originalImage.Height
        
        if ($originalWidth -gt $originalHeight) {
            $newWidth = $Size
            $newHeight = [int](($originalHeight * $Size) / $originalWidth)
        } else {
            $newHeight = $Size
            $newWidth = [int](($originalWidth * $Size) / $originalHeight)
        }
        
        # 创建缩略图
        $thumbnail = New-Object System.Drawing.Bitmap($newWidth, $newHeight)
        $graphics = [System.Drawing.Graphics]::FromImage($thumbnail)
        
        # 设置高质量缩放
        $graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
        $graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
        $graphics.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
        $graphics.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality
        
        # 绘制缩略图
        $graphics.DrawImage($originalImage, 0, 0, $newWidth, $newHeight)
        
        # 保存缩略图
        $extension = Get-FileExtension $DestinationPath
        $format = Get-ImageFormat $extension
        $thumbnail.Save($DestinationPath, $format)
        
        # 清理资源
        $graphics.Dispose()
        $thumbnail.Dispose()
        $originalImage.Dispose()
        
        return $true
    }
    catch {
        Write-Log "处理图片失败: $($_.Exception.Message)" "Red"
        return $false
    }
}

# 主程序
Write-Log "=== 缩略图生成器启动 ===" "Green"
Write-Log "当前工作目录: $(Get-Location)" "Cyan"

# 获取当前目录
$CurrentDir = Get-Location

# 递归查找所有图片文件
$ImageFiles = Get-ChildItem -Path $CurrentDir -Recurse -File | Where-Object {
    $ext = Get-FileExtension $_.Name
    $SupportedFormats -contains $ext.ToLower()
}

if ($ImageFiles.Count -eq 0) {
    Write-Log "未找到支持的图片文件" "Yellow"
    Write-Log "支持的格式: $($SupportedFormats -join ', ')" "Yellow"
    Read-Host "按回车键退出"
    exit
}

Write-Log "找到 $($ImageFiles.Count) 个图片文件" "Green"

$ProcessedCount = 0
$SkippedCount = 0

foreach ($ImageFile in $ImageFiles) {
    # 生成缩略图文件名
    $BaseName = [System.IO.Path]::GetFileNameWithoutExtension($ImageFile.Name)
    $Extension = Get-FileExtension $ImageFile.Name
    $ThumbnailName = "${BaseName}_thumbnail${Extension}"
    $ThumbnailPath = Join-Path $ImageFile.Directory.FullName $ThumbnailName
    
    # 检查缩略图是否已存在
    if (Test-Path $ThumbnailPath) {
        Write-Log "跳过 (已存在): $($ImageFile.Name)" "Yellow"
        $SkippedCount++
        continue
    }
    
    Write-Log "处理: $($ImageFile.Name)" "White"
    
    if (Create-Thumbnail -SourcePath $ImageFile.FullName -DestinationPath $ThumbnailPath -Size $ThumbnailSize) {
        Write-Log "生成成功: $ThumbnailName" "Green"
        $ProcessedCount++
    }
}

Write-Log "=== 处理完成 ===" "Green"
Write-Log "成功处理: $ProcessedCount 个文件" "Green"
Write-Log "跳过文件: $SkippedCount 个文件" "Yellow"

Read-Host "按回车键退出"