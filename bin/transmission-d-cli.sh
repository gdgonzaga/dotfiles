#!/usr/bin/env bash

transmission-daemon
sleep 1
transmission-remote-cli
transmission-remote --exit
