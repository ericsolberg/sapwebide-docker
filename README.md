# SAP Web IDE Local Install in Docker
The purpose of this project is to easily and quicly run SAP Web IDE in a stand-alone, repeatable environment regardless of platform or other dependencies. This is achieved by building a Docker image with the following pre-installed:
- Oracle JRE 8
- Eclipse Orion
- Eclipse Director
- SAP Web IDE 1.8 Local Install

This is part of a general exploration of MicroServices and DevOps concepts in the context of SAP Mobile technologies. This is not a "proper" MicroService, however, as a MicroService implementation of SAP Web IDE would be decomposed into finger-grained services.
## Important
This is intended for experimental and demo purposes only. It is not intended for production use. The resulting Docker image should not be distributed as it contains proprietary components that may not be distributed.
## Contents
* Quick Setup
* Create the sapwebide-docker Image
* Running the sapwebide-docker Image
* Issues
* Todo

### Quick Setup
1. The only thing you need on the target machine is the Docker runtime. On a Mac or Windows machine, [install Boot2Docker](https://docs.docker.com/installation/#installation 'Docker Installation').
2. Create a directory on your computer for building the Docker image. On my system I used:

        mkdir ~/SAP
        mkdir ~/SAP/sapwebide-docker
        cd ~/SAP/sapwebide-docker

3. Download the [SAP Web IDE Local Install](https://store.sap.com/sap/cp/ui/resources/store/html/SolutionDetails.html?pid=0000013489&catID=&pcntry=US&sap-language=EN&_cp_id=id-1413816705087-0 'SAP Web IDE Local Install Trial'). Click on the "Trial Version" button and you will be prompted to provide contact information, and you'll receive a download link in your email. You can download the Developer Guide [here](http://www.sdn.sap.com/irj/scn/index?rid=/library/uuid/d010835c-b539-3210-6eb6-906c58d3c573&overridelayout=true 'SAP Web IDE Developer Guide'). Do not unzip the SAP_Web_IDE_Local_Inst.zip file. Just place it in your sapwebide-docker directory.
4. While you're at it, make sure you sign up for a free trial account on the [SAP HANA Cloud Platform](http://hcp.sap.com/developers/TutorialCatalog/nat100_01_native_hana_getting_hana_trial.html 'SAP HCP Free Trial'). Although the HANA Cloud Platform is not used in this local install, you will be able to use the online version of the SAP Web IDE and try things that you can't do on a local install.
5. Download, clone or cut & paste the Dockerfile. Dockerfile (no extension) is a text file that tells Docker how to build your image. If you're familiar with Git, you can clone the sapwebide-docker project. But that isn't really necessary- it consists of only the one text file. You can simply [download the Dockerfile from GitHub](https://raw.githubusercontent.com/ericsolberg/sapwebide-docker/master/Dockerfile 'Dockerfile'), or cut & paste the contents into a text editor of your choice and save as Dockerfile in your project directory.

### Create the sapwebide-docker Image

Your project directory should contain two files:

* SAP_Web_IDE_Local_Inst.zip
* Dockerfile

To build the docker image, launch Boot2Docker. You can click on the Boot2Docker app icon, or run Boot2Docker from Terminal:

    Boot2Docker
Make sure you're in your project directory:

    cd ~/SAP/sapwebide-docker
Build the sapwebide-docker image:

    docker build -t sapwebide-docker .
There will be a lot of console outpu as the image is built, including some warning messages and various messages in red. You should be able to ignore these as long as the image builds succesfully. It may take some time to download all of the components the first time, but if you rebuild the image it will usually be much faster as Docker caches interim steps. The final line of output should be similar to:

    Successfully built <image id>
You've succesfully build the image and it is ready to run!
### Issues
Issues...
### Todo
Todo...
