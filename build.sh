#!/bin/bash

function build() {
  # Build Godot engine
  mkdir -p build
  cd build
  cmake..
  make
}

function test() {
  # Run Godot engine tests
  cd build
  make test
}

function package() {
  # Package Godot engine
  cd build
  make package
}

case "$1" in
  build)
    build
    ;;
  test)
    test
    ;;
  package)
    package
    ;;
  *)
    echo "Invalid command"
    exit 1
    ;;
esac
