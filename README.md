# frc2019-ci

Using Docker, build and test your robot's Java code in Continuous Integration for extra confidence.

Never heard of Continuous Integration? No worries. Essentially, it means constantly testing and 
verifying that your software does the right thing.

It's most useful when you have a team of three or more people all working
on software, because as your team grows, it becomes possible for changes that are benign on their own
to interact to cause bugs.

Using the resources in this repo, you can set up a CI pipeline for free with Travis
that will check every push and PR that your team writes to make sure the software
compiles and that the tests you've written complete successfully.

There are some other ways to use these files - notably, getting the toolset installed
and running with fewer steps than installing and modifying your local environment. More on that later.

## Docker basics

There's a `Dockerfile` in the root of this repo that tells a piece of software called Docker how to set up the FRC Java
environment. It's got a lot of comments and should be relatively easy to parse. Please tell me if it's not!

It runs inside a virtual environment based on Ubuntu 18.04 and when it's finished, you have something called an "image".
This is a frozen copy of the installed environment that can be run anywhere Docker can be run. Note that this image
doesn't include your code yet.

If you're just using this repo for CI, you don't even need Docker installed on your computer, as Travis will have it
already set up. In the case that you want to run this locally, you'll need to install a version of Docker for your OS.
See https://www.docker.com/products/docker-desktop for more details.

## Adding your code

For projects that are set up according to the 2019 FRC manuals like in https://wpilib.screenstepslive.com/s/currentCS/m/java/c/88899
you'll need to do a tiny bit of work. If you've got a Java environment set up some other way, you may need to do some more work.
File an issue against this repo and I'll see if I can accomodate your request or at least provide some more documentation.

That tiny bit of work consists of adapting the example files in the `example` folder to your project.

1. Copy the contents of the `example` directory into your project. `.travis.yml` will need to go at the root, but 
   `docker-compose.yml` and `Dockerfile` can go wherever you want.

2. Point Travis to your `docker-compose.yml` file. You'll need to modify `example/Dockerfile` in both places to have
   the right path.
   
3. Point docker-compose to your project's root directory. Change `context: ../` to be the right relative path to your
   project's root from where you put `docker-compose.yml`.
   
4. Point docker-compose to your project's `Dockerfile`. Change `dockerfile: example/Dockerfile` to wherever you copied
   the `Dockerfile`.
   
Now, when Travis gets notified of changes, it will pull the FRC environment from this repo's `Dockerfile`, add your code,
and then compile your code and run your unit tests.