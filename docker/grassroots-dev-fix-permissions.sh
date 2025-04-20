#!/bin/sh

UIDGUID=$1
shift

echo $UIDGUID

# This seems to be the best way to have volumes owned by the appropriate user.
chown -R $UIDGUID /app/node_modules
chown -R $UIDGUID /app/node_modules/grassroots-frontend
chown -R $UIDGUID /app/node_modules/grassroots-backend
# exec runuser -u appuser "$@"
su - $UNAME -c "$@"
