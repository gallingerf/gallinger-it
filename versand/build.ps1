# Erzeugt briefkopf.jpg (950x184) aus briefkopf.html via headless Edge.
# Inhalt/Design wird in briefkopf.html bearbeitet, dieses Script rendert nur.
#
# Hintergrund: Edge headless hat eine Mindest-Viewport-Hoehe und ignoriert
# --window-size=950,184. Daher rendern wir bei 950x600 und croppen auf 184px.

$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.Drawing

$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$htmlPath = Join-Path $here 'briefkopf.html'
$pngTmp   = Join-Path $here '_render.png'
$jpgPath  = Join-Path $here 'briefkopf.jpg'
$edge     = 'C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe'

if (-not (Test-Path $htmlPath)) { throw "briefkopf.html fehlt: $htmlPath" }
if (Test-Path $pngTmp)  { Remove-Item $pngTmp -Force }
if (Test-Path $jpgPath) { Remove-Item $jpgPath -Force }

$fileUri = ([Uri](Get-Item $htmlPath).FullName).AbsoluteUri

Start-Process -FilePath $edge -ArgumentList @(
  '--headless=new',
  '--disable-gpu',
  '--hide-scrollbars',
  '--force-device-scale-factor=1',
  '--window-size=950,600',
  "--screenshot=$pngTmp",
  '--virtual-time-budget=2000',
  $fileUri
) -Wait -WindowStyle Hidden | Out-Null

if (-not (Test-Path $pngTmp)) { throw "Screenshot fehlgeschlagen" }

$src = [System.Drawing.Image]::FromFile($pngTmp)
$bmp = New-Object System.Drawing.Bitmap 950, 184
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.Clear([System.Drawing.Color]::White)
$g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
$g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality

$rect = New-Object System.Drawing.Rectangle 0, 0, 950, 184
$g.DrawImage($src, $rect, $rect, [System.Drawing.GraphicsUnit]::Pixel)
$g.Dispose()
$src.Dispose()

$encoder = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() |
  Where-Object { $_.MimeType -eq 'image/jpeg' }
$encParams = New-Object System.Drawing.Imaging.EncoderParameters 1
$encParams.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter(
  [System.Drawing.Imaging.Encoder]::Quality, [int64]92)
$bmp.Save($jpgPath, $encoder, $encParams)
$bmp.Dispose()

Remove-Item $pngTmp -Force

$info = Get-Item $jpgPath
Write-Output "OK: $jpgPath ($([math]::Round($info.Length/1024,1)) KB, 950x184)"
