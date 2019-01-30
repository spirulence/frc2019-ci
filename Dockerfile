FROM ubuntu:18.04

# This version comes from the WPILib releases page: https://github.com/wpilibsuite/allwpilib/releases
ENV WPILIB_VERSION=2019.2.1 \
    WPILIB_RELEASE_URL=https://github.com/wpilibsuite/allwpilib/releases/download \
    GRADLE_ZIP=gradle-5.0-bin.zip \
    # Set the Java home and PATH so that your code can find the FRC-provided JDK and Gradle that we install
    JAVA_HOME=/root/frc2019/jdk \
    PATH=/root/frc2019/jdk/bin:/root/gradle/gradle-5.0/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# We need a way to download the release, I've chosen the *nix tool called wget
# We also need to be able to unzip Gradle
# Normally we'd clean up after ourselves by cleaning the package lists etc,
# but the ubuntu image does that for us
RUN apt-get update -q && apt-get install -qy wget unzip

# Download the WPILib release, untar it, and then delete the tar file to save space
RUN wget -q $WPILIB_RELEASE_URL/v$WPILIB_VERSION/WPILib_Linux-$WPILIB_VERSION.tar.gz \
    && mkdir -p /root/frc2019/ && tar -xzf WPILib_Linux-$WPILIB_VERSION.tar.gz -C /root/frc2019/ \
    && rm WPILib_Linux-$WPILIB_VERSION.tar.gz

# Download Gradle so that we don't need to download it again when we start the tests
RUN wget -q https://services.gradle.org/distributions/$GRADLE_ZIP \
    && unzip -q $GRADLE_ZIP -d /root/gradle \
    && rm $GRADLE_ZIP

# I'm assuming here that you'll want to put your robot code in /robot
WORKDIR /robot

# Override this if you have a different way to run your tests
# note that we're using our downloaded version of Gradle so as to not download it again
CMD gradle test
