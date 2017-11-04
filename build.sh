#!/usr/bin/env bash
set -eu
nix-shell -p gup bash python --run "gup all"

