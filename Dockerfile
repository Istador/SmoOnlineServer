################################################################################
##################################################################   build   ###

FROM  amd64/ubuntu:22.04  as  build

RUN   apt-get  update  \
  &&  apt-get  install  -y  curl  \
  &&  curl  --fail  -o ms.deb  https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb  \
  &&  dpkg  -i ms.deb  \
  &&  rm  -f  ms.deb  \
  &&  apt-get  update  \
  &&  apt-get  install  -y  dotnet-sdk-6.0  \
  &&  rm  -rf  /var/lib/apt/lists/*  \
;

WORKDIR  /app/

COPY  ./Server/  ./Server/
COPY  ./Shared/  ./Shared/

ARG TARGETOS
ARG TARGETARCH

RUN  DOTNET_CLI_TELEMETRY_OPTOUT=1  dotnet  publish  \
    ./Server/Server.csproj  \
    -c Release  \
    --self-contained  \
    -p:publishSingleFile=true  \
    --os $TARGETOS  \
    --arch musl-`echo $TARGETARCH | sed 's@amd@x@ ; s@/.*$@@'`  \
    -o ./out/  \
;

##################################################################   build   ###
################################################################################
################################################################   runtime   ###

FROM  alpine:3.16  as  runtime

RUN  apk  add  icu

WORKDIR  /data/

COPY  --from=build  /app/out/  /app/

ENTRYPOINT  /app/Server

EXPOSE  1027/tcp
VOLUME  /data/

################################################################   runtime   ###
################################################################################
