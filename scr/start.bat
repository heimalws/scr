@echo off & title 一键设置指定图片目录为屏幕保护 By lws
 
::设置屏幕保护程序路径，为了保证正常，此项请勿修改(已屏蔽)

echo %~dp0
set d=%~dp0
set f=scr/ssMyPics.scr

set "ScrFile=%d%%f%"

 
::设置包含图片文件夹的主目录路径，留空为当前脚本所在目录
set img=img
set "ImageDir=%d%%img%"
 
::设置显示屏保时的等待时间（分钟），有效值（1-9999）
set TimeOut=5
 
::设置是否启用登录屏幕，1 启用，0 禁用
set Login=1
 
::是否立即生效，1 立即（系统将会注销当前帐户），其它数字下次开机后生效
set Effective=1
 
::设置图片更换频率（毫秒），有效值（6000 - 180000）
set Interval=30000
 
::设置图片在屏幕上显示的尺寸大小（%），有效值（25 - 100）
set Percent=100
 
::设置是否拉伸图片，1 允许，0 拒绝
set Stretch=0
 
::设置是否显示图片名，1 显示，0 隐藏
set ShowName=0
 
::设置是否禁用过渡效果，1 禁用，0 启用
set Transition=0
 
::设置是否使用键盘滚动浏览，1 启用，0 禁用
set Control=1
 
::1 跳转，0 忽略
set Pay=1
 
 
 

 
if not exist "%ScrFile%" (
    color 0C & title 缺失图片收藏幻灯片（ssMyPics.scr）屏幕保护程序 By lws
    pause>nul
    goto GotoFileUrl
)
 
>nul 2>&1 "%SystemRoot%\System32\cacls.exe" "%SystemRoot%\System32\config\SYSTEM"
if '%errorlevel%' NEQ '0' (
    echo 正在请求临时管理员权限...
    goto UACPrompt
) else ( goto Setting )
 
:UACPrompt
start "" mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c ""%~0"" ::","","runas",1)(window.close)&&exit
 
:Setting
cd /d "%~dp0" & color 0a
if not defined ImageDir set "ImageDir=%cd%"
if not exist "%ImageDir%" (
    color 0C & title 路径不存在 By lws
    echo 设置的图片主目录路径不存在
    ping 127.0.0.1 -n "4">nul
    exit
)
 
set /a TimeOut*=60
set "Key=HKCU\Control Panel"
set "SSS=Screen Saver.Slideshow"
reg add "%key%\Desktop" /v SCRNSAVE.EXE /t REG_SZ /d "%ScrFile%" /f
reg add "%key%\Desktop" /v ScreenSaveTimeOut /t REG_SZ /d "%TimeOut%" /f
reg add "%key%\Desktop" /v ScreenSaverIsSecure /t REG_SZ /d "%Login%" /f
reg add "%key%\%SSS%" /v ChangeInterval /t REG_DWORD /d %Interval% /f
reg add "%key%\%SSS%" /v MaxScreenPercent /t REG_DWORD /d %Percent% /f
reg add "%key%\%SSS%" /v AllowStretching /t REG_DWORD /d %Stretch% /f
reg add "%key%\%SSS%" /v DisplayFilename /t REG_DWORD /d %ShowName% /f
reg add "%key%\%SSS%" /v DisableTransitions /t REG_DWORD /d %Transition% /f
reg add "%key%\%SSS%" /v AllowKeyboardControl /t REG_DWORD /d %Control% /f
reg add "%key%\%SSS%" /v ImageDirectory /t REG_SZ /d "%ImageDir%" /f
 
:End
echo, & echo,
if %Effective% equ 1 (
    echo 按下任意键，系统将注销当前帐户，再次登录后，相关设置即可生效。
    echo 在注销前，请先保存您尚未保存的数据，以免注销后数据丢失。
    pause>nul
    shutdown /l >nul 2>nul
) else (
    echo 按下任意键，将直接退出脚本，但屏幕保护设置页面的参数可能不会有变化。
    echo 但有可能设置已经生效，建议注销帐户或重启电脑，以便正常生效。
    pause>nul
)
if %Pay% equ 1 goto ToMe
exit

:GotoFileUrl
@echo off & cls & Title 跳转页面 By lws
color 0A & mode 60,4
echo 即将跳转至以下网址页面：
set "wA=ht"&set "wB=tps"&set "wC=://"&set "wD=pan"
set "wE=bai"&set "wF=du"&set "wG=com"&set "wH=/s/"
set "PCode=1oo2jPt7VanrX7iV99biS6Q"
set "P_PSW="
set "PUrl=%wA%%wB%%wC%%wD%.%wE%%wF%.%wG%%wH%%PCode%"
echo, & echo     %PUrl%
ping 127.0.0.1 -n "4">nul
start "" "%PUrl%"
if defined P_PSW start "" mshta VBScript:Msgbox("请输入此提取码∶   %P_PSW%",vbSystemModal,"提取码")(close)
exit