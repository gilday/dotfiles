# JAVA_HOME

function setjdk() {
  unset JAVA_HOME # https://developer.apple.com/forums/thread/666681
  export JAVA_HOME=$(/usr/libexec/java_home -v $1)
}

if [[ "$OSTYPE" == darwin* ]]; then
  setjdk 17
  path+=$JAVA_HOME/bin
fi
# automatic java_home switch when .java-version detected
function chpwd() {
  if [[ "$OSTYPE" == darwin* && -f $PWD/.java-version ]]; then
    version=$(cat $PWD/.java-version)
    setjdk $version
  fi
}

# ANDROID
export ANDROID_HOME=$HOME/devtools/android-sdk
path+=$ANDROID_HOME/platform-tools
alias android-connect="mtpfs -o allow_other /media/GalaxyNexus"
alias android-disconnect="fusermount -u /media/GalaxyNexus"


# MAVEN
export M2_REPO="$HOME/.m2/repository"
export MAVEN_OPTS='-Djava.awt.headless=true' # http://stackoverflow.com/a/17951720/501368


# GRAALVM
export GRAALVM_HOME="$(/usr/libexec/java_home -v 17 -V 2>&1 | grep 'GraalVM' | egrep -o '((\/\S+)+)$')"
path+=$GRAALVM_HOME/bin


# JBOSS
export JBOSS_HOME="$HOME/devtools/wildfly"
path+=$JBOSS_HOME/bin


# PLAY
export PLAY_HOME="$HOME/devtools/play"
path+=$PLAY_HOME/bin

# ORACLE JDEVELOPER
export JDEVELOPER_HOME="$HOME/devtools/jdeveloper"
path+=$JDEVELOPER_HOME/jdev/bin
