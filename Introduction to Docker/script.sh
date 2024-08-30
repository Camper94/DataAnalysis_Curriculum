#Script_Name : script.py
#Description : Introduction to Shell
#Author : Sofiane Boumelit
#Date : August 27, 2024

#Chapter I : Using Docker Containers
#Description : You'll go from starting and stopping your first container to seeing how to clean your environment 
#by removing all containers and images. 
#You'll see how to debug issues by running commands inside a container or executing bash commands in 
#a container interactively. All of this is done using the Docker Command Line Interface.

#Running your first container
#Now that you know how to start and stop containers, look at running containers, and much more, 
#let's get your hands dirty! We'll start off by just running a container that outputs some text 
#so we can see that it successfully ran. 
#In other words, it's your turn to run a hello-world container!
#Using the terminal, enter the command to run the hello-world image.
docker run hello-world

#Running a container in the background
#You got some projects set up already on your machine, 
#but an urgent request has come in to fix a bug in your data ingestion pipeline. 
#The pipeline is used to store data from different sources into a Postgres database. 
#To search for the issue, you want to set up the project locally together with a Postgres database 
#in a Docker container to ensure that fixing this bug doesn't affect anything else you are working on.

#Using the terminal, enter the command to run the postgres image in the background.
docker run -d postgres
#Make sure the container is running by listing all containers and verifying that you see a Postgres container running.
docker ps

#An interactive container
#Another bug has popped up in the data ingestion pipeline; this time, 
#however, you got some pointers on where the issue might be. 
#Your colleagues tell you the application cannot start inside its Ubuntu container. 
#To debug the issue you want to start an Ubuntu container and try to run the application yourself 
#to find out what's going wrong.

#Select the right combination of commands to:

#Run an ubuntu container and get an interactive shell inside of the container.
#Close the container to go back to the host after you got an interactive shell in 
#the container and found the issue with the pipeline.
#You can use the shell to try out the possible commands.
docker run -it ubuntu and exit

#Helping a colleague
#You're working on a project of your own and have quite a few containers running 
#when your colleague asks you to debug an issue he's having. 
#You've got some time to help your colleague, 
#but you want to make sure you can find his container among all the ones you already have running.

#Using the terminal, enter the command to run the my_project image detached 
#from your shell while giving it the colleague_project name.
#To run an image in detached mode use the -d flag, 
#without using this flag the image will run connected to your shell making it unusable. 
#If this happens you can refresh the page.

#Using the terminal, enter the command to run the my_project image detached from your shell while giving it the 
#colleague_project name.
#To run an image in detached mode use the -d flag, without using this flag the image will run 
#connected to your shell making it unusable. 
#If this happens you can refresh the page.
docker run -d --name colleague_project my_project

#The container should be running now. 
#Make sure it is by filtering the running containers using the name colleague_project you gave the container.
docker ps -f "name=colleague_project"

#Now that you're sure the container is running look at the logs using the container's name, colleague_project.
docker logs colleague_project

#Cleaning up containers
#You were able to find the issue with your colleague's container and help him fix it. 
#Before you return to your project, you want to clean up the container you just started to help your colleague.
#Using the terminal, enter the command to stop the colleague_project container.
docker stop colleague_project
#Now that the container is stopped use the terminal to remove the container.
docker comtainer rm colleague_project

#Pulling your first image
#Let's get some practice working with images. To start, we've removed the hello-world image from your session. 
#Make it accessible locally again by downloading it from docker-hub.
#Using the terminal, enter the command to download the hello-world container.
docker pull hello-world

#Pulling a specific tag
#You were helping a colleague by looking at an issue they were having with installing some of their tools on the ubuntu image. 
#You couldn't reproduce the issues so far, and just realized you might be trying on a different version of Ubuntu.
#Using the terminal, enter the command to see all images available on your machine.
docker images

#Seems like you are not using the same version as your colleague, who is using the 22.04 tag of ubuntu. 
#Pull the right version, 22.04, of the ubuntu image.
docker pull ubuntu:22.04

#Cleaning up images
#The project you were working on is done. 
#You had to use and try several docker containers and images and would like to clear up some space on 
#your system before starting your next project. 
#You remember using the ubuntu image last and know you won't need it for your next project.
#Using the terminal, enter the command to remove the ubuntu image.
docker image rm ubuntu
#The ubuntu image failed to remove since it still has a container using it. 
#To be sure you can clean up your images, remove all stopped containers.
docker image prune -a
