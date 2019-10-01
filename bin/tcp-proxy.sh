#!/bin/sh -e
# https://howto.lintel.in/listen-arbitrary-port-print-data-coming-using-netcat/

if [ $# != 3 ]
then
    echo "usage: $0 <src-port> <dst-host> <dst-port>"
    exit 0
fi

TMP=`mktemp -d`
BACK=$TMP/pipe.back
SENT=$TMP/pipe.sent
RCVD=$TMP/pipe.rcvd
trap 'rm -rf "$TMP"' EXIT
mkfifo -m 0600 "$BACK" "$SENT" "$RCVD"
sed 's/^/ => /' <"$SENT" &
sed 's/^/<=  /' <"$RCVD" &
nc -lk "$1" <"$BACK" | tee "$SENT" | nc "$2" "$3" | tee "$RCVD" >"$BACK"
