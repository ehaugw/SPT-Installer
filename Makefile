include Makefile.wanip

MAKEFLAGS += --no-print-directory

gamepath = /mnt/c/Users/eivind/MYHOME/Applications/SPT_3_10
pluginpath = BepInEx/plugins
tspath = user/mods

dependencies:
	sudo apt install p7zip-full

install:
	if [ ! -f omit.txt ]; then make forceinstall; fi

forceinstall: clean download extract config_fika clean

config_fika:
	sed -i "s/sharedQuestProgression\"\: false/sharedQuestProgression\"\: true/" ${gamepath}/${tspath}/fika-server/assets/configs/fika.jsonc 
	sed -i "s/giftedItemsLoseFIR\"\: true/giftedItemsLoseFIR\"\: false/" ${gamepath}/${tspath}/fika-server/assets/configs/fika.jsonc 
config_fika_server:
	sed -i "s/ip\"\: \"[0-9]\+.[0-9]\+.[0-9]\+.[0-9]\+/ip\"\: \"0.0.0.0/" ${gamepath}/SPT_Data/Server/configs/http.json
	sed -i "s/backendIp\"\: \"[0-9]\+.[0-9]\+.[0-9]\+.[0-9]\+/backendIp\"\: \"${hostwanip}/" ${gamepath}/SPT_Data/Server/configs/http.json

extract:
	for file in $(shell ls downloads/*.zip) ; do \
		unzip $${file} -d ${gamepath}/ ; \
	done
	for file in $(shell ls downloads/*.7z) ; do \
		7za x $${file} -o${gamepath}/ ; \
	done

uninstall:
	rm -rf ${gamepath}/${tspath}
	mkdir -p ${gamepath}/${tspath}
	(cd ${gamepath} && find ${pluginpath}/* ! -name 'spt' -type d -exec rm -rf {} +)
	(cd ${gamepath} && find ${pluginpath}/* -maxdepth 0 ! -name 'spt' -type f -exec rm -rf {} +)
	rm -f ${gamepath}/Fika\ License.txt
	rm -f ${gamepath}/LiteNetLib\ License.txt
	rm -f ${gamepath}/Open.NAT\ License.txt
	rm -f ${gamepath}/SIT\ License.txt
	rm -f ${gamepath}/Readme.md
	rm -f ${gamepath}/BepInEx/config/com.janky.hollywoodfx.cfg

clean:
	rm -rf downloads

download:
	mkdir -p downloads
	wget -P downloads/ https://github.com/dwesterwick/SPTQuestingBots/releases/download/0.9.0/DanW-SPTQuestingBots.zip
	wget -P downloads/ https://github.com/tyfon7/UIFixes/releases/download/v3.1.2/Tyfon-UIFixes-3.1.2.zip
	wget -P downloads/ https://github.com/schkuromi/flea-fir-only/releases/download/1.0.2/schkuromi-fleafironly.zip
	wget -P downloads/ https://github.com/project-fika/Fika-Plugin/releases/download/v1.1.5.0/Fika.Release.1.1.5.0.zip
	wget -P downloads/ https://github.com/project-fika/Fika-Server/releases/download/v2.3.6/fika-server.zip
	wget -P downloads/ https://github.com/Solarint/SAIN/releases/download/v3.2.1-Release/SAIN-3.2.1-Release.7z
	wget -P downloads/ https://github.com/DrakiaXYZ/SPT-Waypoints/releases/download/1.6.2/DrakiaXYZ-Waypoints-1.6.2.7z
	wget -P downloads/ https://github.com/DrakiaXYZ/SPT-BigBrain/releases/download/1.2.0/DrakiaXYZ-BigBrain-1.2.0.7z
	wget -P downloads/ https://github.com/peinwastaken/SPTLeftStanceWallFix/releases/download/1.0.0/LeftStanceWallFix.zip
	# wget -P downloads/ https://github.com/No3371/SPT_ThatsLit/releases/download/1.3100.3/ThatsLit_1.3100.3.zip
	wget -P downloads/ https://github.com/ehaugw/SPT-MeaningfulWeaponMasteries/raw/refs/heads/master/MeaningfulWeaponMasteries.zip
	wget -P downloads/ https://github.com/ehaugw/SPT-BetterZeroing/raw/refs/heads/master/BetterZeroing.zip
	# wget -P downloads/ https://github.com/ehaugw/SPT-ThatsLitSyncMirror/raw/refs/heads/master/ThatsLitSync_1.3100.3.zip
	wget -P downloads/ https://github.com/ehaugw/SPT-NonUglyCPC/raw/refs/heads/master/non-ugly-cpc.zip
	wget -P downloads/ https://raw.githubusercontent.com/SleepingPills/HollywoodFX-Release/refs/heads/main/HollywoodFX_Alpha6.zip
