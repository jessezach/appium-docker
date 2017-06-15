# appium-docker
Docker image for appium

Enable parallel execution of mobile tests using appium docker.
- Ensure you have docker installed and daemon running.
- Pull the image. docker pull `jessezach/appium:latest`
- Pull selenium hub image. `docker pull selenium/hub`
- Create a hub container `docker run -d -p 5700:4444 --name selenium-hub selenium/hub`
- Create a config.json file containing the node config including hub url and port. Example:
`{
"capabilities": [
{
"browserName": "chrome",
"version": "4.4.4",
"maxInstances": 1,
"platform": "ANDROID",
"platformName": "ANDROID",
"deviceName": "Moto G"
}
],
"configuration": {
"cleanUpCycle": 2000,
"timeout":30000,
"proxy": "org.openqa.grid.selenium.proxy.DefaultRemoteProxy",
"url": "http://172.16.14.80:4723/wd/hub",
"host": "172.16.14.80",
"port": 4723,
"maxSession": 1,
"hubPort": 4444,
"hubHost": "172.16.14.80",
"register": true,
"registerCycle": 5000,
"role": "node"
}
}`
- Run the node container. You can mount a single device to the docker node. To get the bus and usb run ```lsusb``` on linux.
docker run -d -p 4723:4723 -t -i --device=/dev/bus/usb/001/112 -v /home/user/config.json:/root/config.json --name app jessezach/appium

Create multiple nodes and attach to the hub. Ensure that you change the appium port.
To dynamically attach an existing node to another hub, stop container `docker stop <container-id>` and modify the config.json with the new hub port and then run `docker start <container-id>`
