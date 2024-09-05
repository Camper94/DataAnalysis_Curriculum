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

#Chapter II : Once you are able to manage images and containers, 
#it's time to know how to share images with colleagues or your entire company and to understand 
#how to create your own. Now, you'll build your own images using Dockerfiles. 
#Dockerfiles are text files that include everything needed for Docker to build an image. 
#You'll learn how to create images and will get an introduction to all the essential Dockerfile instructions 
#like FROM, RUN, COPY, and more. 
#By the end of this chapter, 
#you'll have insight into how Docker makes images and be able to create optimized Docker images from scratch.

#Sharing your work using Docker registry
#Your company is developing a new spam filter method. 
#You think you've found a good method and would like to share your results with your colleague 
#in a way that allows them to verify your results. 
#You've decided that using a Docker image with all your code and datasets is the right approach. 
#You've already created this image on your local machine and called it spam:v1. 
#The next step is to push this image to your company's registry docker.mycompany.com 
#so that your colleagues can build upon your work.

#Using the terminal, enter the command to tag the spam:v1 container so it can be pushed to docker.mycompany.com.
docker tag spam:v1 docker.mycompany.com/spam:v1
#Using the terminal, enter the command to push the docker.mycompany.com/spam:v1 image to the docker.mycompany.com registry.
docker image push docker.mycompany.com/spam:v1

#Saving an image to a file 
#After you pushed your image to the company's registry, 
#you got a lot of feedback from your colleagues. 
#You addressed the most important feedback and would like to share your new Docker image, spam:v2, 
#with just a few colleagues before you share it with the entire company again. 
#Save your new Docker image to a file called spam_updated.tar so you can email it to your colleagues Alice and Bob.
#Using the terminal, enter the command to save spam:v2 to a file called spam_updated.tar.
docker save -o spam_updated.tar spam:v2

#Receiving Docker Images
#Your company is still working on that new spam filter! 
#Your colleague Bob made possible improvements to your work and sent you a tar file. 
#Another colleague, Alice, has pushed her version to the company's dockerhub, docker.mycompany.com. 
#It's now up to you to run both containers and find out which runs fastest.
#Using the terminal, enter the command to pull the container your colleague Alice made, spam_alice:v3, 
#from the company's Docker Hub registry, docker.mycompany.com.
#Using the terminal, enter the command to pull the container your colleague Alice made, spam_alice:v3, 
#from the company's Docker Hub registry, docker.mycompany.com.
docker pull docker.mycompany.com/spam_alice:v3
#Run the container you just pulled, docker.mycompany.com/spam_alice:v3, to see how good its spam detection algorithm is.
docker run docker.mycompany.com/spam_alice:v3
#Using the terminal, enter the command to open the tar file your colleague Bob sent you, spam_bob.tar.
docker load -i spam_bob.tar
#Just like you did for Alice's container, run Bob's container, spam_bob:v3, to see how good its spam detection algorithm is.
docker run spam_bob:v3

#Building your first image
#Let's build your first image! We've created a Dockerfile for you, 
#and you can see it in your current working directory using the ls command. 
#You can look at its content using cat Dockerfile or using nano.
#Using the terminal, enter the command to build an image from the Dockerfile in your current working directory.
docker build .

#Well done! While it's possible to build an image without naming it, we usually want to give our image a name. 
#Using the terminal, enter the command to build an image called my_first_image from the Dockerfile in your current 
#working directory.
docker build my_first_image .

#Working in the command-line
#A Dockerfile is just a textfile and creating or editing it can be done using any text editor. 
#However since the default way to work with Docker is through the Command Line Interface, 
#it's convenient to also edit Dockerfiles using the command line. 
#Let's refresh our memory on how to navigate the file system and create or edit a Dockerfile with the command line.

#Create a file called Dockerfile in the current working directory.
#Use touch Dockerfile; the touch command will create an empty file for you.
#Or use nano Dockerfile, which will create an empty file but also open the nano text editor, 
#which you then have to save using CTRL+s after which you can exit with CTRL+x.
touch Dockerfile

#Now that you've created a new file let's add a line of text to it.
#Open the file using nano Dockerfile.
#add FROM ubuntu to the start of the file.
#Use CTRL+s to save your changes.
#Followed by CTRL+x to exit nano.
nano Dockerfile
CTRL+S
CTRL+X

#Using nano to edit a file is often the most intuitive way; 
#however, you can also use echo combined with a double pipe (>>) to append to files without opening them. 
#Let's use echo to append RUN apt-get update to our Dockerfile.
#Type the first part of the command, echo "RUN apt-get update" which will print the text between the quotes, 
#don't press enter yet.
#Then add the double pipe >>, which will redirect the output.
#Followed by Dockerfile to make the output of echo append to the Dockerfile.
#Now execute the command by pressing the enter key.
echo "RUN apt-get update" >> Dockerfile

#Well done! You successfully created and made changes to a file. 
#Often while working in the shell, you want to quickly check the contents of a file without making changes to it. 
#This is easily done using the cat command.
#Check the contents of the Dockerfile using the cat command, cat expects a filename as its first and only argument.
cat Dockerfile

#Editing a Dockerfile
#Let's get familiar with the RUN instruction. 
#We've created a Dockerfile for you. 
#You can look at its content using cat Dockerfile or using nano. 
#Like before, the Dockerfile already has a FROM instruction, but you'll be adding a RUN command this time.
#Add the correct instruction to the end of the Dockerfile 
#so that the mkdir my_app shell command is run when building the Dockerfile.
nano Dockerfile
RUN mkdir my_app

#Using the terminal, run the command to build an image called my_app from the Dockerfile in your current working directory.
docker build -t my_app .

#Creating your own Dockerfile
#While it's possible to download images for many use cases, an image might not always meet your exact needs. 
#In that case, you can create a new image based on an existing one that closely matches your requirements. 
#Let's go through the steps to create a Dockerfile from scratch, build on top of an existing Ubuntu image, 
#add your instructions, and then build it into a new image.
#Create a file called Dockerfile in the current working directory.
touch Dockerfile
#Add the first instruction to the Dockerfile so that it will build on top of the ubuntu image.
nano Dockerfile
FROM ubuntu
#Add instructions to the Dockerfile so that 
#it runs apt-get update and apt-get install -y python3 when building the Dockerfile.
nano Dockerfile
apt-get update
apt-get install -y python3
#Using the terminal, run the command to build an image called my_python_image 
#from the Dockerfile in your current working directory.
docker build -t my_python_image .

#Copying files into an image
#You've created an Ubuntu and python3-based image to run your data pipeline. 
#Update your Dockerfile so your image includes the pipeline.py file in which you defined the pipeline.
#To the end of the Dockerfile, add the Docker instruction, 
#which copies the pipeline.py file in your current working directory (/home/repl) to the /app folder in 
#the image you want to build.
nano Dockerfile
FROM ubuntu:22.04
RUN apt-get update
RUN apt-get -y install python3
COPY /home/repl/pipeline.py /app/pipeline.py/

#Copying folders
#After creating an ubuntu and python3 image with your pipeline python code in it, 
#you realize you actually need your entire pipeline_v3 project in the Docker image to be able to install its dependencies. 
#There is a Dockerfile in the current working directory to start from that already has python3 installed.
#Add the instruction to copy all pipeline_v3 project files into the /app directory in your Docker image. 
#You can find the files in the /pipeline_v3/ directory, which is in the current working directory on your local machine.
nano Dockerfile
COPY /pipeline_v3/ /app/pipeline_v3/

#Using the terminal, 
#run the command to build an image called pipeline_v3 from the Dockerfile in your current working directory.
docker build -t pipeline_v3 .

#Working with downloaded files
#Your previous image worked, and you were able to finalize your pipeline python code! 
#You can now create the next version of your image. 
#Let's create a Dockerfile from scratch, add instructions and then build it.

#Create a file called Dockerfile in the current working directory.
touch Dockerfile

#Add the first instruction to the Dockerfile so that it will build on top of the ubuntu image.
#Add instructions to the Dockerfile so that it runs apt-get update and apt-get install -y python3 curl unzip.
nano Dockerfile
FROM ubuntu
RUN apt-get update
RUN apt-get install -y python3 curl unzip

#Add instructions to the Dockerfile to:
#Download the zip file from https://assets.datacamp.com/production/repositories/6082/datasets/31a5052c6a5424cbb8d939a7a6eff9311957e7d0/pipeline_final.zip to /pipeline_final.zip.
#Unzip the file
#And remove the zip
#You can use three separate instructions or make it a single instruction to keep your image smaller.
nano Dockerfile
RUN curl https://assets.datacamp.com/production/repositories/6082/datasets/31a5052c6a5424cbb8d939a7a6eff9311957e7d0/pipeline_final.zip to /pipeline_final.zip
RUN unzip /pipeline_final.zip
RUN rm /pipeline_final.zip

#Using the terminal, run the command to build an image called pipeline from the Dockerfile in your current working directory.
docker build -t pipeline .

#Overriding the default command
#Overriding the start command of an image has many uses. 
#One of them is testing or debugging something in an image that already has a start command with a specific use case. 
#For example, the postgres image starts a database if you start it normally. 
#To be able to dive into the image and look at configuration files or debug an issue you're having; 
#you can start it with the bash command, an often available shell. 
#What is the command to start the postgres image interactively with a bash shell?
docker run -it postgres bash

#Pulling a specific tag
#You were helping a colleague by looking at an issue they were having with installing some of their tools
#on the ubuntu image. You couldn't reproduce the issues so far, 
#and just realized you might be trying on a different version of Ubuntu.
#Using the terminal, enter the command to see all images available on your machine.
docker ps
#Seems like you are not using the same version as your colleague, who is using the 22.04 tag of ubuntu. 
#Pull the right version, 22.04, of the ubuntu image.
docker pull ubuntu:22.04

#Adding a CMD
#While creating an image for your python pipeline, you had many issues debugging any problems that came up. 
#To be able to debug these easily,
#you decide to make an image based on the same version of ubuntu that starts python3 by default.
#Add the instruction so that your Docker image starts python3 by default.
nano Dockerfile
CMD python3

#Using the terminal, run the command to build an image 
#called pipeline_debug from the Dockerfile in your current working directory.
docker build -t pipeline_debug

#Let's test the image we just made. Using the terminal, enter the command to run the pipeline_debug image.
docker run pipeline_debug

#Docker caching
#Now that you understand Docker image layers and when they are cached, which of the following statements is correct?
#All of the above
#Docker builds Dockerfiles into images; 
#an image is composed of layers that correspond to specific Dockerfile instructions. 
#A layer can be re-used for Dockerfiles with identical instructions.
#When we build an image from a Dockerfile, every Dockerfile instruction is run, 
#and the changes it makes to the file system are saved. 
#The bundle of these changes to the file system is called a layer.
#Image layer caching can be complex, 
#but it allows us to understand how to greatly increase the speed with which we can iterate on,
#i.e., improve or fix bugs in our images.

#Ordering Dockerfile instructions
#When writing Dockerfiles, the order of your Dockerfile instructions determines 
#how long the build will take after updating any of the commands. 
#Do you understand how to make the most efficient Dockerfiles?
#FROM docker.io/library/ubuntu
#RUN apt-get update
#RUN apt-get install -y python3
#COPY /app/requirements.txt/app/requirements.txt
#COPY /app/pipeline.py/app/pipeline.py

#WORKDIR and USER
#Most Dockerfile instructions affect the file system. 
#However, the WORKDIR and USER change the behavior of subsequent Dockerfile instructions. 
#Let's see if you have a grasp on how these new instructions change the behavior of other instructions.
#`WORKDIR` allows us to change the path in which the command of the `CMD` instruction is run.
#After using `USER` in our Dockerfile, no instructions after 
#`USER` can use any other user than the one we set with `USER`, until the user is changed again.
#`USER` allows us to change the user with which the command of the `CMD` instruction is run.

#Setting the user
#You've finished the python code for the pipeline you were building and have gotten all 
#the feedback you need from colleagues. 
#To make your pipeline Docker image more foolproof, 
#you want to set the user to repl before the project files are copied into the image. 
#We've already added the RUN instruction to create a repl user for you.
#Using the terminal, open the Dockerfile in your current working directory and edit the third line to set the user to repl.
nano Dockerfile
FROM ubuntu:22.04
RUN useradd -m repl
USER repl
RUN mkdir/home/repl/projects/pipeline_final
COPY /home/repl/project /home/repl/projects/pipeline_final

#Setting the working directory
#Putting the finishing touches to your pipeline Docker image, 
#you want to make it clear that all pipeline project files in your 
#images will be in the repl users' home directory by setting the working directory to /home/repl.
#Using the terminal, open the Dockerfile in your current working directory and edit the 
#fourth line to make all next instructions run in /home/repl.
nano Dockerfile
FROM ubuntu:22.04
RUN useradd -m repl
USER repl
WORKDIR /home/repl/Dockerfile
RUN mkdir prjects/pipeline_final
COPY /home/repl/project projects/pipeline_final
