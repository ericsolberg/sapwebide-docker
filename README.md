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
5. Download or cut & paste the [Dockerfile]().

### Issues
Issues...
### Todo
Todo...
