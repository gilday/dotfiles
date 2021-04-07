ssm() {
  aws ssm start-session --target $1
}

ssm-tunnel() {
  aws ssm start-session --target $1 \
    --document-name AWS-StartPortForwardingSession \
    --parameters "{\"portNumber\":[\"$2\"],\"localPortNumber\":[\"$2\"]}" &> /dev/null &
}
