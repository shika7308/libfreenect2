rem This can only be run in a Git Shell or similar environments
rem with access to git.exe and msbuild.exe.

rmdir /s /q libusb_src libusb

git clone --depth 1 https://github.com/shika7308/libusb.git libusb_src || exit /b
pushd libusb_src

set CONFIG=Release
set YEAR=2019

msbuild msvc\libusb_dll_%YEAR%.vcxproj /p:Platform=x64 /p:Configuration=%CONFIG% /target:Rebuild || exit /b

mkdir ..\libusb\include\libusb-1.0
copy libusb\libusb.h ..\libusb\include\libusb-1.0
mkdir ..\libusb\MS64\dll
copy x64\%CONFIG%\dll\*.lib ..\libusb\MS64\dll
copy x64\%CONFIG%\dll\*.dll ..\libusb\MS64\dll
copy x64\%CONFIG%\dll\*.pdb ..\libusb\MS64\dll

popd