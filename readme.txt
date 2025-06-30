1. Install a working copy of Escape from Tarkov with the BattleStateGames launcher
2. Install SPT as instructed in the SPT manuals
3. Create a Makefile.config file, it should look like this (without indentation)
    
    hostwanip = x.x.x.x
    gamepath = /absolute/path/to/spt/directory/without/slash/at/end

4. Run "make install" in WSL, in this directory
5. Run SPT once with the launcher
6. Run "make config"
7. If you intend to use the same installation as both server and client, also run "make config_server"
