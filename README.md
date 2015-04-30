# SAP Web IDE Local Install in Docker
The purpose of this project is to easily and quickly run SAP Web IDE in a stand-alone, repeatable environment regardless of platform or other dependencies. This is achieved by building a Docker container with the following pre-installed:
- Debian Linux (Wheezy)
- Oracle Java JRE 8
- Eclipse Orion
- Eclipse Director
- SAP Web IDE 1.8 Local Install

This is part of a general exploration of microservices and DevOps concepts in the context of SAP Mobile technologies. This is not a "proper" microservice, however, as a microservice implementation of SAP Web IDE would be decomposed into finer-grained services.
## Important
This is intended for experimental and demo purposes only. It is not intended for production use. The resulting Docker container should not be distributed or posted on a public repository as it contains proprietary components.
## Contents
* [Quick Setup](#quick-setup)
* [Build the Container](#build-the-container)
* [Run the Container](#run-the-container)
* [Issues](#issues)
* [Todo](#todo)

## Quick Setup
1. The only thing you need on the target machine is the Docker runtime. On a Mac or Windows machine, [install Boot2Docker](https://docs.docker.com/installation/#installation 'Docker Installation').
2. Create a directory on your computer for building the Docker container. On my system I used:

        mkdir ~/SAP
        mkdir ~/SAP/sapwebide-docker
        cd ~/SAP/sapwebide-docker

3. Download the [SAP Web IDE Local Install](https://store.sap.com/sap/cp/ui/resources/store/html/SolutionDetails.html?pid=0000013489&catID=&pcntry=US&sap-language=EN&_cp_id=id-1413816705087-0 'SAP Web IDE Local Install Trial'). Click on the "Trial Version" button and you will be prompted to provide contact information, and you'll receive a download link in your email. You can download the SAP Web IDE Developer Guide [here](http://www.sdn.sap.com/irj/scn/index?rid=/library/uuid/d010835c-b539-3210-6eb6-906c58d3c573&overridelayout=true 'SAP Web IDE Developer Guide'). Do not unzip the SAP_Web_IDE_Local_Inst.zip file. Just place it in your sapwebide-docker directory.
4. While you're at it, make sure you sign up for a free trial account on the [SAP HANA Cloud Platform](http://hcp.sap.com/developers/TutorialCatalog/nat100_01_native_hana_getting_hana_trial.html 'SAP HCP Free Trial'). Although the HANA Cloud Platform is not used for this local install, you will be able to use the online version of the SAP Web IDE and try things that you can't do on a local install.
5. Download, clone or cut & paste the Dockerfile. Dockerfile (no extension) is a text file that tells Docker how to build your container. If you're familiar with Git, you can clone the sapwebide-docker repository. But that isn't really necessary- it consists of only the one text file. You can simply [download the Dockerfile from GitHub](https://raw.githubusercontent.com/ericsolberg/sapwebide-docker/master/Dockerfile 'Dockerfile'), or cut & paste the contents into a text editor of your choice and save as Dockerfile in your project directory.

## Build the Container

Your project directory should contain two files:

* SAP_Web_IDE_Local_Inst.zip
* Dockerfile

To build your container, first launch Boot2Docker by clicking on the Boot2Docker app icon (I put mine on the launch bar). Then make sure you're in your project directory:

    cd ~/SAP/sapwebide-docker
Build the sapwebide-docker container:

    docker build -t sapwebide-docker .
There will be a lot of console output as the container is built, including some warning messages and various messages in red. You should be able to ignore these as long as the build is successful. It may take some time to download all of the components the first time, but if you rebuild the container it will usually be faster as Docker caches interim steps. The final line of output should be similar to:

    Successfully built <container id>
You've successfully built the container and it is ready to run!
## Run the Container
If you're continuing from the step above, you should still be running in Boot2Docker. If you've come back in, be sure to launch Boot2Docker first. From the Boot2Docker console, type:

    docker run -p 80:8080 -d sapwebide-docker
This tells Docker to run your container.  The -p option maps port 80 on your machine to the SAP Web IDE default port (8080) inside the container. The -d option tells Docker to run the container detached (no console input). Docker should respond with a long instance ID:

    4ac62bc4fbb035541a8e61526d38520e44291f692ab001bfb38288ab781e731a
Of course, your instance ID will be different. Verify your instance is running:

    docker ps
Output:

    CONTAINER ID        IMAGE                     COMMAND             CREATED              STATUS              PORTS                  NAMES
    <container-id>      sapwebide-docker:latest   "./orion"           About a minute ago   Up About a minute   0.0.0.0:80->8080/tcp   pensive_bartik
On a Linux machine, you should now be able to connect to SAP Web IDE on localhost. But with Boot2Docker, the host is actually the Boot2Docker virtual machine, which has its own IP address. To get this IP address, type:

    Boot2Docker ip
Output:

    The VM's Host only interface IP address is: 192.168.59.103
Use this IP address to connect to SAP Web IDE by pointing your browser to:

    http://192.168.59.103/webide/index.html
Of course, you need to change the IP address above to the one reported by `Boot2Docker ip`.
> Note: Using VirtualBox, you can map this port to a local port on your machine.
> This is optional but if you do, you can access SAP Web IDE through http://localhost/webide/index.html

### Important
Do not create any projects/content in SAP Web IDE that you intend to save. Anything you save will be lost when you shut down and re-start your container. Mapping projects to a local volume or GitHub are on the todo list.

### Shutting Down
To shut down your container, use the `docker kill` command. You can use the instance ID reported from `docker ps`:

    docker kill <container-id>
### Running the container interactively
Your container is a fully self-contained Debian Linux system. If you want to poke around inside the container, one way to do this is to use the command:

    docker run -i -t -p 80:8080 sapwebide-docker /bin/bash
This will give you a bash prompt inside your container. At this point, SAP Web IDE will not be running. To manually launch SAP Web IDE, type:

    cd $WEBIDE_DIR/eclipse
    ./orion
Typing exit at the osgi> prompt will take you back out to your container, and typing exit again will shut down your container and return to Boot2Docker.
## Issues
Currently, I've just managed to get SAP Web IDE up and running. There are several more steps to make it fully functional and even more to make it useful. In the mean time, be aware:
- As noted above, anything you edit or create in your container will be lost when you shut down.
- There aren't any back end connections defined, so you can't accomplish very much. You can configure those yourself inside the running container, but you'll want to learn how to add those changes to the container build so your changes aren't lost.
- Running your app currently doesn't work. This is because SAP Web IDE launches the app preview on a randomly assigned port. You can easily map ports from the Container to the VM (as we did with port 80:8080), but the randomly assigned port comes from a broad range. Docker does support mapping ranges of ports (i.e. -p 45000-55000:45000-55000) but I found that this takes a very long time (and probably resources) as Docker loops through and maps every port in that range. It would be better if SAP Web IDE used the same port and just mapped the preview into a unique URL (mental note... submit a feature request to SAP Web IDE).

## Todo
1. Map project storage to a local volume for project persistence
2. Document a simple way to configure service destinations
3. Figure out a good way to map ports for app preview
4. Enable GitHub integration for a fully reproducible environment with persistent configuration and projects
5. Incorporate the Hybrid Application Toolkit (HAT), Android tools and/or links to locally installed HAT (for Android and iOS) and this will actually become a useful tool for portable app construction and demonstration.
