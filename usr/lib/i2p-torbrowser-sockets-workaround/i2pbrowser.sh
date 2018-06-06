#!/bin/bash

## Copyright (C) 
## See the file COPYING for copying conditions.

## Deactivate tor-launcher,
## a Vidalia replacement as browser extension,
## to prevent running i2p over i2p.
## https://trac.torproject.org/projects/tor/ticket/6009
## https://gitweb.torproject.org/tor-launcher.git
export TOR_SKIP_LAUNCH=1

## The following TOR_SOCKS_HOST and TOR_SOCKS_PORT variables
## do not work flawlessly, due to an upstream bug in i2p Button:
##    "TOR_SOCKS_HOST, TOR_SOCKS_PORT regression"
##    https://trac.torproject.org/projects/tor/ticket/8336
## (As an alternative,
##    /home/user/tor-browser/Browser/i2pBrowser/Data/Browser/profile.default/user.js
## could be used.)
## Fortunately, this is not required for Whonix by default anymore,
## because systemd-socket-proxyd is configured to redirect
## Whonix-Workstation ports
##   127.0.0.1:9050 to Whonix-Gateway 10.152.152.10:9050
##   127.0.0.1:9051 to Whonix-Gateway 10.152.152.10:9051
##   127.0.0.1:9150 to Whonix-Gateway 10.152.152.10:9150
##   127.0.0.1:9151 to Whonix-Gateway 10.152.152.10:9151
#export TOR_SOCKS_HOST="10.152.152.10"
#export TOR_SOCKS_PORT="9150"
#export TOR_CONTROL_HOST="127.0.0.1"
#export TOR_CONTROL_PORT="9151"
## this is to satisfy i2p Button just filled up with anything
#export TOR_CONTROL_PASSWD='"password"'

## We are not using TOR_TRANSPROXY=1 because that would break i2p Browser's
## per tab stream isolation. (i2p Browser talks to a i2p SocksPort and sets a
## socks user name and i2p is using IsolateSOCKSAuth by i2p default.)
#export TOR_TRANSPROXY=1

## Environment variable to configure i2p Browser to use a pre existing unix
## domain socket file instead of creating its own one to avoid i2p over i2p and
## to keep it being able to connect.
## systemd-socket-proxyd is being used for creation of unix domain socket file
## /var/run/i2p-torbrowser-sockets-workaround/127.0.0.1_9150.sock and forwarding it to
## to Whonix-Gateway port 9150.
## https://phabricator.whonix.org/T192
## https://trac.torproject.org/projects/tor/ticket/20111#comment:5
export TOR_SOCKS_IPC_PATH="/var/run/i2p-torbrowser-sockets-workaround/127.0.0.1_9150.sock"
export TOR_CONTROL_IPC_PATH="/var/run/i2p-torbrowser-sockets-workaround/127.0.0.1_9151.sock"

## environment variable to skip i2pButton control port verification
## https://trac.torproject.org/projects/tor/ticket/13079
export TOR_SKIP_CONTROLPORTTEST=1

## Environment variable to disable the "i2pButton" ->
## "Open Network Settings..." menu item. It is not useful and confusing to have
## on a workstation, because i2p must be configured on the Whonix-Gateway, which is
## for security reasons forbidden from the Whonix-Gateway.
## https://trac.torproject.org/projects/tor/ticket/14100
export TOR_NO_DISPLAY_NETWORK_SETTINGS=1
