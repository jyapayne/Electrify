VERSION=$(cat files/version.txt)

rm -rf ElectrifyMac*
rm  files/error.log files/last_project_path.txt files/recent_files.txt
rm -rf files/downloads/*
rm -rf ElectrifyMac-CMD/files
pyinstaller --hidden-import PIL.Jpeg2KImagePlugin --hidden-import configobj --hidden-import pkg_resources --distpath ElectrifyMac-CMD --onefile -n electrify-mac command_line.py
cp -rf files ElectrifyMac-CMD/files/

rm -rf build dist Electrifycutable.app

#sudo python build_mac_setup.py py2app --iconfile icon.icns 
pyinstaller -w --hidden-import PIL.Jpeg2KImagePlugin --hidden-import PyQt4 --hidden-import PIL --hidden-import configobj --hidden-import pkg_resources --distpath ElectrifyMac --onefile -n Electrifycutable main.py

#sudo chown -R joey dist/Electrifycutable.app
#sudo chown -R joey dist/ build/
#mv dist/Electrifycutable.app Electrifycutable.app

mv ElectrifyMac/Electrifycutable.app .

#rm -rf Electrifycutable.app/Contents/Frameworks/QtDesigner*
#rm -rf Electrifycutable.app/Contents/Frameworks/QtXml*
#rm -rf Electrifycutable.app/Contents/Frameworks/QtWebKit*
#rm -rf Electrifycutable.app/Contents/Frameworks/QtScript*

cp icon.icns Electrifycutable.app/Contents/Resources/icon-windowed.icns
cp -rf files Electrifycutable.app/Contents/MacOS/

rm -rf build dist

/Applications/Keka.app/Contents/Resources/keka7z a -r ElectrifyMac-CMD.zip ElectrifyMac-CMD
/Applications/Keka.app/Contents/Resources/keka7z a -r ElectrifyMac-${VERSION}.zip Electrifycutable.app

python upload_release.py
