1. Install a working copy of Escape from Tarkov with the BattleStateGames launcher

2. Install SPT as instructed in the SPT manuals

3. Launch the SPT server and client, and get to the faction select screen before closing both server and client

4. Create a Makefile.config file, it should look like this (without indentation)
    
    hostwanip = x.x.x.x
    gamepath = /absolute/path/to/spt/directory/without/slash/at/end

5. Run "make install" in WSL, in this directory

6. Again, launch the SPT server and client, and get to the faction select screen before closing both server and client

7. Run "make config"

8. If you intend to use the same installation as both server and client, also run "make config_server"
