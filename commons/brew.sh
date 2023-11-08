#! /bin/bash

include_in_global_brewfile() {
  echo "instance_eval(File.read('$1'))" >> "${HOME}/.Brewfile"
}
