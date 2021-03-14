@@echo off
rem author: Juan Camilo Florez 20210301
rem version: 1.4.1
rem The script is commented and self explanatory
rem usage only for builds: 
rem build_and_push.bat
rem usage only for builds and pushes: 
rem build_and_push.bat pyMraAbv9IzqSe00H10UuKdixKq06eWaRJUDSDtKhTw
rem realname name: k8stools
rem Openshift only accepts deployment configs names up to 24 chars long.
rem THESEARE24CHAR=123456789012345678901234
set COMPONENT_NAME=k8stools
set REGISTRY_PREFIX=docker-registry-default.apps.claro.co
set NAMESPACE=desarrolloem

set FULL_TAG=%REGISTRY_PREFIX%/%NAMESPACE%/%COMPONENT_NAME%
set AUTH_TOKEN=%1

echo "Build Image"
docker build -t %FULL_TAG% .

echo "Run locally"
docker stop %COMPONENT_NAME%
docker run --name %COMPONENT_NAME% --rm -d %FULL_TAG%

if defined AUTH_TOKEN (
  echo "Registry auth..."
  docker login -p %AUTH_TOKEN% -u unused %REGISTRY_PREFIX%

  echo "Push..."
  docker push %FULL_TAG% 
)