include Makefile.config

MAKEFLAGS += --no-print-directory

pluginpath = BepInEx/plugins
tspath = user/mods

dependencies:
	sudo apt install p7zip-full

install:
	if [ ! -f omit.txt ]; then make forceinstall; fi

forceinstall: clean download extract clean

config: config_fika config_thatslit 

config_fika:
	sed -i "s/sharedQuestProgression\"\: false/sharedQuestProgression\"\: true/" ${gamepath}/${tspath}/fika-server/assets/configs/fika.jsonc 
	sed -i "s/sentItemsLoseFIR\"\: true/sentItemsLoseFIR\"\: false/" ${gamepath}/${tspath}/fika-server/assets/configs/fika.jsonc 
	sed -i "s/showNonStandardProfile\"\: false/showNonStandardProfile\"\: true/" ${gamepath}/${tspath}/fika-server/assets/configs/fika.jsonc
	sed -i "s/Url\"\: \"https\:\/\/[0-9]\+.[0-9]\+.[0-9]\+.[0-9]\+:[0-9]\+/Url\"\: \"https\:\/\/${hostwanip}\:6969/" ${gamepath}/user/launcher/config.json

config_fika_server:
	sed -i "s/ip\"\: \"[0-9]\+.[0-9]\+.[0-9]\+.[0-9]\+/ip\"\: \"0.0.0.0/" ${gamepath}/SPT_Data/Server/configs/http.json
	sed -i "s/backendIp\"\: \"[0-9]\+.[0-9]\+.[0-9]\+.[0-9]\+/backendIp\"\: \"${hostwanip}/" ${gamepath}/SPT_Data/Server/configs/http.json

config_thatslit:
	sed -i "s/Lighting Info = true/Lighting Info = false/"      ${gamepath}/BepInEx/config/bastudio.thatslit.cfg
	sed -i "s/Weather Info = true/Weather Info = false/"        ${gamepath}/BepInEx/config/bastudio.thatslit.cfg
	sed -i "s/Equipment Info = true/Equipment Info = false/"    ${gamepath}/BepInEx/config/bastudio.thatslit.cfg
	sed -i "s/Foliage Info = true/Foliage Info = false/"        ${gamepath}/BepInEx/config/bastudio.thatslit.cfg
	sed -i "s/Terrain Info = true/Terrain Info = false/"        ${gamepath}/BepInEx/config/bastudio.thatslit.cfg
	sed -i "s/Resolution Level = [0-9]/Resolution Level = 3/"   ${gamepath}/BepInEx/config/bastudio.thatslit.cfg
	sed -i "s/Foliage Samples = [0-9]/Foliage Samples = 3/"     ${gamepath}/BepInEx/config/bastudio.thatslit.cfg

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
	wget -P downloads/ https://github.com/dwesterwick/SPTQuestingBots/releases/download/0.10.0/DanW-SPTQuestingBots.zip
	wget -P downloads/ https://github.com/tyfon7/UIFixes/releases/download/v4.2.1/Tyfon-UIFixes-4.2.1.zip
	# wget -P downloads/ https://github.com/schkuromi/flea-fir-only/releases/download/1.0.2/schkuromi-fleafironly.zip
	wget -P downloads/ https://github.com/project-fika/Fika-Plugin/releases/download/v1.2.8/Fika.Release.1.2.8.0.zip
	wget -P downloads/ https://github.com/project-fika/Fika-Server/releases/download/v2.4.8/fika-server-2.4.8.zip
	wget -P downloads/ https://github.com/Lacyway/SAIN/releases/download/v3.3.1/SAIN-3.3.1-Release.zip
	wget -P downloads/ https://github.com/DrakiaXYZ/SPT-Waypoints/releases/download/1.7.1/DrakiaXYZ-Waypoints-1.7.1.7z
	wget -P downloads/ https://github.com/DrakiaXYZ/SPT-BigBrain/releases/download/1.3.2/DrakiaXYZ-BigBrain-1.3.2.7z
	wget -P downloads/ https://github.com/peinwastaken/SPTLeftStanceWallFix/releases/download/1.0.1/LeftStanceWallFix.zip
	wget -P downloads/ https://github.com/Visasid/ThatsLit/releases/download/v3.4rc1/ThatsLit.zip
	wget -P downloads/ https://github.com/ehaugw/SPT-MeaningfulWeaponMasteries/raw/refs/heads/master/MeaningfulWeaponMasteries.zip
	wget -P downloads/ https://github.com/ehaugw/SPT-BetterZeroing/raw/refs/heads/master/BetterZeroing.zip
	# wget -P downloads/ https://github.com/ehaugw/SPT-ThatsLitSyncMirror/raw/refs/heads/master/ThatsLitSync_1.3100.3.zip
	# wget -P downloads/ https://github.com/ehaugw/SPT-NonUglyCPC/raw/refs/heads/master/non-ugly-cpc.zip
	wget -P downloads/ https://github.com/SleepingPills/HollywoodFX/releases/download/v1.6.7/HollywoodFX_1.6.7.zip
