#!/bin/bash

THIS_DIR=$(pwd)/js
LAST_ARG="${@: -1}"
SECOND_LAST_ARG="${@: -3:1}"
THIRD_LAST_ARG="${@: -5:1}"

copy_resources() {
  OUTPUT_DIR="$1"
  mkdir $OUTPUT_DIR/drawable-mdpi
  cp "$THIS_DIR/app/image@1.5x.png" $OUTPUT_DIR/drawable-mdpi/image.png
  mkdir $OUTPUT_DIR/drawable-hdpi
  cp "$THIS_DIR/app/image@2x.png" $OUTPUT_DIR/drawable-hdpi/image.png
  mkdir $OUTPUT_DIR/drawable-xhdpi
  cp "$THIS_DIR/app/image@3x.png" $OUTPUT_DIR/drawable-xhdpi/image.png
}

case "$1" in
'bundle')
  OUTPUT_DIR="$SECOND_LAST_ARG"
  OUTPUT_FILE="$THIRD_LAST_ARG"
  cat $THIS_DIR/app/sample.android.js $THIS_DIR/app/helpers.js > $OUTPUT_FILE

  copy_resources $OUTPUT_DIR

  echo "source map" > $LAST_ARG

  exit 0
  ;;
'unbundle')
  RESOURCE_DIR="$LAST_ARG"
  APP_ENTRY_FILE="$SECOND_LAST_ARG"
  JS_MODULE_DIR=`dirname "$APP_ENTRY_FILE"`/js

  mkdir "$JS_MODULE_DIR"
  cp $THIS_DIR/app/sample.android.js > "$APP_ENTRY_FILE"
  cp $THIS_DIR/app/helpers.js "$JS_MODULE_DIR/helpers.js"

  copy_resources $RESOURCE_DIR
  exit 0
  ;;
'list-dependencies')
  OUTPUT_FILE="$LAST_ARG"
  echo $THIS_DIR/app/sample.android.js > $OUTPUT_FILE
  echo $THIS_DIR/app/helpers.js >> $OUTPUT_FILE
  echo $THIS_DIR/app/image@1.5x.png >> $OUTPUT_FILE
  echo $THIS_DIR/app/image@2x.png >> $OUTPUT_FILE
  echo $THIS_DIR/app/image@3x.png >> $OUTPUT_FILE
  exit 0
  ;;
*)
  echo "Invalid command"
  exit 1
esac
