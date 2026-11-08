# Chay thu du an QLST1 tren may: nap CSDL vao MySQL 8, bien dich, chay tren Tomcat cua xampp (cong 8089).
# Cach dung: nhap dup chay_thu.bat (hoac: powershell -ExecutionPolicy Bypass -File chay_thu.ps1)
param([string]$MatKhau, [switch]$GiuCSDL)
$ErrorActionPreference = 'Stop'

# ---- cau hinh (sua neu may khac) ----
$MYSQL       = 'C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe'
$TOMCAT_HOME = 'C:\xampp\tomcat'
$JAVA_HOME   = 'C:\Program Files\Java\jdk-21'
$PORT        = 8089                                   # 8080 dang bi Apache cua xampp dung
$RUN         = Join-Path $env:USERPROFILE 'QLST1_chaythu'   # thu muc chay (duong dan khong dau)
# --------------------------------------

$ROOT = Split-Path -Parent $MyInvocation.MyCommand.Path
$PRJ  = Join-Path $ROOT 'QLST1'
foreach ($f in @($MYSQL, "$TOMCAT_HOME\bin\catalina.bat", "$JAVA_HOME\bin\javac.exe")) {
    if (-not (Test-Path $f)) { throw "Khong tim thay: $f (sua phan cau hinh dau file chay_thu.ps1)" }
}

if (Get-NetTCPConnection -State Listen -LocalPort $PORT -ErrorAction SilentlyContinue) {
    throw "Cong $PORT dang duoc dung (QLST1 dang chay?). Dong cua so 'QLST1 - Tomcat' roi chay lai."
}
if (-not $PSBoundParameters.ContainsKey('MatKhau')) {
    $sec = Read-Host -AsSecureString 'Mat khau MySQL cua tai khoan root'
    $MatKhau = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($sec))
}

# 1. Nap CSDL qlst1 (schema xoa va tao lai CSDL qlst1, nen moi lan nap lai la du lieu mau tu dau)
$nap = 'K'
if (-not $GiuCSDL) { $nap = Read-Host 'Nap lai CSDL qlst1 tu dau? (Enter = co; K = giu du lieu cu)' }
New-Item -ItemType Directory -Force $RUN | Out-Null
if ($nap -notmatch '^[Kk]') {
    $all = Join-Path $RUN 'qlst1_all.sql'
    $utf8 = New-Object System.Text.UTF8Encoding($false)
    $text = ''
    foreach ($n in @('qlst1_schema.sql', 'qlst1_procedures.sql', 'qlst1_data.sql')) {
        $text += [IO.File]::ReadAllText((Join-Path $PRJ "database\$n"), $utf8) + "`n"
    }
    [IO.File]::WriteAllText($all, $text, $utf8)
    $env:MYSQL_PWD = $MatKhau
    cmd /c "`"$MYSQL`" -u root --default-character-set=utf8mb4 < `"$all`""
    $code = $LASTEXITCODE
    Remove-Item Env:MYSQL_PWD
    if ($code -ne 0) { throw 'Nap CSDL that bai (kiem tra mat khau MySQL)' }
    Write-Host 'Da nap CSDL qlst1 (35 bang, procedure, du lieu mau).' -ForegroundColor Green
}

# 2. Chep giao dien + bien dich model, dao vao WEB-INF/classes
$app = Join-Path $RUN 'webapps\QLST1'
# giu lai anh mat hang da tai len o lan chay truoc
$anhCu = Join-Path $RUN 'anh_tai_len'
if (Test-Path (Join-Path $app 'images')) {
    if (Test-Path $anhCu) { Remove-Item -Recurse -Force $anhCu }
    Copy-Item -Recurse (Join-Path $app 'images') $anhCu
}
if (Test-Path $app) { Remove-Item -Recurse -Force $app }
Copy-Item -Recurse (Join-Path $PRJ 'WebContent') $app
if (Test-Path $anhCu) {
    Copy-Item -Force (Join-Path $anhCu '*') (Join-Path $app 'images') -ErrorAction SilentlyContinue
    Remove-Item -Recurse -Force $anhCu
}
$src = Join-Path $RUN 'src'
if (Test-Path $src) { Remove-Item -Recurse -Force $src }
Copy-Item -Recurse (Join-Path $PRJ 'src') $src
# ban sao cua DAO1.java dung mat khau vua nhap (file goc trong QLST1/src giu nguyen)
$dao1 = Join-Path $src 'dao\DAO1.java'
$lit = $MatKhau.Replace('\', '\\').Replace('"', '\"')
$t = [IO.File]::ReadAllText($dao1)
[IO.File]::WriteAllText($dao1, $t.Replace('"root", ""', '"root", "' + $lit + '"'), (New-Object System.Text.UTF8Encoding($false)))
$classes = Join-Path $app 'WEB-INF\classes'
New-Item -ItemType Directory -Force $classes | Out-Null
$files = Get-ChildItem -Recurse $src -Filter *.java | ForEach-Object { '"' + $_.FullName.Replace('\', '/') + '"' }
$argf = Join-Path $RUN 'javac_files.txt'
[IO.File]::WriteAllLines($argf, $files)
& "$JAVA_HOME\bin\javac.exe" -encoding UTF-8 --release 8 -nowarn -d $classes "@$argf"
if ($LASTEXITCODE -ne 0) { throw 'Bien dich loi' }
Remove-Item -Recurse -Force $src
Write-Host 'Da bien dich model + dao.' -ForegroundColor Green

# 3. Tomcat rieng (CATALINA_BASE) tren cong $PORT, khong dung vao cau hinh xampp
$base = $RUN
foreach ($d in @('conf', 'logs', 'temp', 'work')) { New-Item -ItemType Directory -Force (Join-Path $base $d) | Out-Null }
Copy-Item -Force "$TOMCAT_HOME\conf\*" (Join-Path $base 'conf') -Exclude 'Catalina'
$sx = Join-Path $base 'conf\server.xml'
$x = [IO.File]::ReadAllText($sx)
$x = $x.Replace('port="8005"', 'port="8015"').Replace('port="8080"', "port=`"$PORT`"").Replace('redirectPort="8443"', 'redirectPort="8449"')
$x = [Regex]::Replace($x, '<Connector protocol="AJP/1\.3"[\s\S]*?/>', '')
[IO.File]::WriteAllText($sx, $x)
$bat = Join-Path $base 'tomcat_qlst1.bat'
@"
@echo off
title QLST1 - Tomcat cong $PORT (dong cua so nay de tat)
set "CATALINA_HOME=$TOMCAT_HOME"
set "CATALINA_BASE=$base"
set "JAVA_HOME=$JAVA_HOME"
set "JRE_HOME="
set "JAVA_OPTS=-Dfile.encoding=UTF-8"
call "$TOMCAT_HOME\bin\catalina.bat" run
"@ | Set-Content -Encoding ASCII $bat
Start-Process cmd.exe -ArgumentList '/c', "`"$bat`""

Write-Host "Dang khoi dong Tomcat..."
$url = "http://localhost:$PORT/QLST1/view"
for ($i = 0; $i -lt 60; $i++) {
    Start-Sleep -Seconds 1
    try { Invoke-WebRequest -UseBasicParsing "$url/nhanvienkho/UIWarehouseMain1.jsp" -TimeoutSec 2 | Out-Null; break } catch {}
}
Write-Host ''
Write-Host "Module 1 (nhan vien kho):   $url/nhanvienkho/UIWarehouseMain1.jsp" -ForegroundColor Cyan
Write-Host "Module 2 (khach hang):      $url/khachhang/UICustomerMain1.jsp" -ForegroundColor Cyan
Write-Host 'Tat he thong: dong cua so "QLST1 - Tomcat".'
Start-Process "$url/nhanvienkho/UIWarehouseMain1.jsp"
