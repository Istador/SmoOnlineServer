# Super Mario Odyssey: Online Server

The official server for the [Super Mario Odyssey: Online](https://github.com/CraftyBoss/SuperMarioOdysseyOnline) mod.


## Windows Setup

1. Download latest build from [Releases](https://github.com/Sanae6/SmoOnlineServer/releases)
2. Run `Server.exe`
3. `settings.json` is autogenerated in step 2, modify it however you'd like.

## Building (Mac/Linux Setup)

Must have the [.NET 6 SDK](https://dotnet.microsoft.com/en-us/download) and Git installed.
Run these commands in your shell:
```shell
git clone https://github.com/Sanae6/SmoOnlineServer
cd SmoOnlineServer
# replace run with build to only build the server
dotnet run --project Server/Server.csproj -c Release
```
If you ran `dotnet build` instead of `dotnet run`, you can find the binary at `Server/bin/net6.0/Release/Server.exe`

## Run docker image

If you have [docker](https://docs.docker.com/) on your system, you can use the existing docker image.
That way you don't have to build this server yourself or manually handle executables.

```shell
docker  run  --rm  -it  -p 1027:1027  -v smoo-data:/data/  ghcr.io/sanae6/smo-online-server
```

To always check for and use the latest server version you can add `--pull=always` to the options.

## Commands

Run `help` to get what commands are available in the server console.
Run the `loadsettings` command in the console to update the settings without restarting.
Server address and port will require a server restart, but everything else should update when you run `loadsettings`.

[//]: # (TODO: Document all commands, possibly rename them too.)
