FROM ubuntu:18.04

# This version comes from the WPILib releases page: https://github.com/wpilibsuite/allwpilib/releases
ENV WPILIB_VERSION=2019.2.1

# We need a way to download the release, I've chosen the *nix tool called wget
# Normally we'd clean up after ourselves by cleaning the package lists etc,
# but the ubuntu image does that for us
RUN apt-get update -q && apt-get install -qy wget

# Download the release, untar it, and then delete the tar file to save space
RUN wget -q https://github.com/wpilibsuite/allwpilib/releases/download/v$WPILIB_VERSION/WPILib_Linux-$WPILIB_VERSION.tar.gz \
    && mkdir -p /root/frc2019/ && tar -xzf WPILib_Linux-$WPILIB_VERSION.tar.gz -C /root/frc2019/ \
    && rm WPILib_Linux-$WPILIB_VERSION.tar.gz

# Set the Java home and path so that your code can find the FRC-provided JDK
ENV JAVA_HOME=/root/frc2019/jdk \
    PATH=/root/frc2019/jdk/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# I'm assuming here that you'll want to put your robot code in /robot
WORKDIR /robot

# Override this if you have a different way to run your tests
# This assumes you have a gradle wrapper called 'gradlew' in the root of your robot code
CMD ./gradlew test
