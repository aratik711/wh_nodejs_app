#!/bin/bash

##Add hosts
IP=$1
HOSTNAME=$2


ALIAS=(${HOSTNAME//./ })
sudo sed -i -e '$a'$IP' '$HOSTNAME' '$ALIAS'' /etc/hosts







