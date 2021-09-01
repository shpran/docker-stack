#!/usr/bin/env sh

INDENT='  ';

if grep -q '^[[:blank:]]\{2\}[a-z\/\-]\{1,\}' $SWAGGER_JSON; then
  INDENT='  ';
elif grep -q '^[[:blank:]]\{4\}[a-z\/\-]\{1,\}' $SWAGGER_JSON; then
  INDENT='    ';
fi


if grep -q "\- url: $SERVER_URL" $SWAGGER_JSON; then
  exit 1;
elif grep -q 'servers:' $SWAGGER_JSON; then
  sed -i.bak "s+servers:+servers:\\
$INDENT- url: $SERVER_URL+g" $SWAGGER_JSON;
elif grep -q 'paths:' $SWAGGER_JSON; then
  sed -i.bak "s+paths:+servers:\\
$INDENT- url: $SERVER_URL\\
\\
paths:+g" $SWAGGER_JSON;
else
  echo "
servers:
$INDENT- url: $SERVER_URL" >> $SWAGGER_JSON;
fi

rm -rf $SWAGGER_JSON.bak;
