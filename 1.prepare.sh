#!/bin/bash
CHAIN_ID=1000
SCHAIN_ID=2000
NETWORK_ID=203
NUM_CNS=1
NUM_PNS=1
NUM_ENS=1
NUM_SCN=1

# Download klaytn docker image.
docker pull klaytn/klaytn:latest

# Generate docker-compose.yml for docker-compose.
docker run --rm -v ${PWD}:/homi-output klaytn/klaytn homi setup -o /homi-output \
	--docker-image-id klaytn/klaytn:latest \
	--chainID $CHAIN_ID --cn-num $NUM_CNS  --pn-num $NUM_PNS --en-num $NUM_ENS \
	--servicechain --serviceChainID $SCHAIN_ID --scn-num $NUM_SCN \
	--network-id $NETWORK_ID docker
