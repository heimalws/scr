@echo off & title һ������ָ��ͼƬĿ¼Ϊ��Ļ���� By lws
 
::������Ļ��������·����Ϊ�˱�֤���������������޸�(������)

echo %~dp0
set d=%~dp0
set f=scr/ssMyPics.scr

set "ScrFile=%d%%f%"

 
::���ð���ͼƬ�ļ��е���Ŀ¼·��������Ϊ��ǰ�ű�����Ŀ¼
set img=img
set "ImageDir=%d%%img%"
 
::������ʾ����ʱ�ĵȴ�ʱ�䣨���ӣ�����Чֵ��1-9999��
set TimeOut=5
 
::�����Ƿ����õ�¼��Ļ��1 ���ã�0 ����
set Login=1
 
::�Ƿ�������Ч��1 ������ϵͳ����ע����ǰ�ʻ��������������´ο�������Ч
set Effective=1
 
::����ͼƬ����Ƶ�ʣ����룩����Чֵ��6000 - 180000��
set Interval=30000
 
::����ͼƬ����Ļ����ʾ�ĳߴ��С��%������Чֵ��25 - 100��
set Percent=100
 
::�����Ƿ�����ͼƬ��1 ����0 �ܾ�
set Stretch=0
 
::�����Ƿ���ʾͼƬ����1 ��ʾ��0 ����
set ShowName=0
 
::�����Ƿ���ù���Ч����1 ���ã�0 ����
set Transition=0
 
::�����Ƿ�ʹ�ü��̹��������1 ���ã�0 ����
set Control=1
 
::1 ��ת��0 ����
set Pay=1
 
 
 

 
if not exist "%ScrFile%" (
    color 0C & title ȱʧͼƬ�ղػõ�Ƭ��ssMyPics.scr����Ļ�������� By lws
    pause>nul
    goto GotoFileUrl
)
 
>nul 2>&1 "%SystemRoot%\System32\cacls.exe" "%SystemRoot%\System32\config\SYSTEM"
if '%errorlevel%' NEQ '0' (
    echo ����������ʱ����ԱȨ��...
    goto UACPrompt
) else ( goto Setting )
 
:UACPrompt
start "" mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c ""%~0"" ::","","runas",1)(window.close)&&exit
 
:Setting
cd /d "%~dp0" & color 0a
if not defined ImageDir set "ImageDir=%cd%"
if not exist "%ImageDir%" (
    color 0C & title ·�������� By lws
    echo ���õ�ͼƬ��Ŀ¼·��������
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
    echo �����������ϵͳ��ע����ǰ�ʻ����ٴε�¼��������ü�����Ч��
    echo ��ע��ǰ�����ȱ�������δ��������ݣ�����ע�������ݶ�ʧ��
    pause>nul
    shutdown /l >nul 2>nul
) else (
    echo �������������ֱ���˳��ű�������Ļ��������ҳ��Ĳ������ܲ����б仯��
    echo ���п��������Ѿ���Ч������ע���ʻ����������ԣ��Ա�������Ч��
    pause>nul
)
if %Pay% equ 1 goto ToMe
exit

:GotoFileUrl
@echo off & cls & Title ��תҳ�� By lws
color 0A & mode 60,4
echo ������ת��������ַҳ�棺
set "wA=ht"&set "wB=tps"&set "wC=://"&set "wD=pan"
set "wE=bai"&set "wF=du"&set "wG=com"&set "wH=/s/"
set "PCode=1oo2jPt7VanrX7iV99biS6Q"
set "P_PSW="
set "PUrl=%wA%%wB%%wC%%wD%.%wE%%wF%.%wG%%wH%%PCode%"
echo, & echo     %PUrl%
ping 127.0.0.1 -n "4">nul
start "" "%PUrl%"
if defined P_PSW start "" mshta VBScript:Msgbox("���������ȡ���   %P_PSW%",vbSystemModal,"��ȡ��")(close)
exit