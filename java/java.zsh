# JAVA_HOME
if [[ "$OSTYPE" == darwin* ]]; then
    export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
    path+=$JAVA_HOME/bin
fi

# ANDROID
export ANDROID_HOME=$HOME/devtools/android-sdk
path+=$ANDROID_HOME/platform-tools
alias android-connect="mtpfs -o allow_other /media/GalaxyNexus"
alias android-disconnect="fusermount -u /media/GalaxyNexus"


# MAVEN
export M2_REPO="$HOME/.m2/repository"
export MAVEN_OPTS='-Djava.awt.headless=true' # http://stackoverflow.com/a/17951720/501368
export MAVEN_OPTS="-Xmx2048m -XX:MaxPermSize=256m -Xss1024k $MAVEN_OPTS"
alias mvnci="mvn clean install"


# JBOSS
export JBOSS_HOME="$HOME/devtools/wildfly"
path+=$JBOSS_HOME/bin


# PLAY
export PLAY_HOME="$HOME/devtools/play"
path+=$PLAY_HOME/bin