# Local Deployment Tool for Klaytn ServiceChain

<!-- vim-markdown-toc GFM -->

* [Deploying the local Network](#deploying-the-local-network)
	* [Prerequisites](#prerequisites)
	* [Starting the Klaytn ServiceChain Network](#starting-the-klaytn-servicechain-network)
		* [Chainging parameters](#chainging-parameters)
	* [Checking out the Status of the Network](#checking-out-the-status-of-the-network)
	* [Getting logs](#getting-logs)
	* [Stopping the Network](#stopping-the-network)
	* [Resuming the Network](#resuming-the-network)
	* [Terminate the Network](#terminate-the-network)
* [Developing Smart Contracts on the Local Network](#developing-smart-contracts-on-the-local-network)
	* [Using KlaytnIDE](#using-klaytnide)
* [FAQ](#FAQ)
	* [SCN is not working](#SCN-is-not-working)

<!-- vim-markdown-toc -->

# Deploying the local Network

## Prerequisites
Following packages are required.

1. [Docker](https://docs.docker.com/get-docker/)
1. [Docker-compose](https://docs.docker.com/compose/install/)

## Starting the Klaytn ServiceChain Network
Execute the following scripts:

```bash
$ ./1.prepare.sh
$ ./2.start.sh
```

It deploys a network consisting of one KCN, KPN, KEN, and KSCN each by default. You can see the logs about CN, PN, EN, SCN Nodes. If you can't find the SCN log, please refer to the [FAQ](#FAQ) below.


### Chainging parameters
You can change two parameters in `1.prepare.sh`.

| Parameter | Description |
|---|---|
|CHAIN_ID| The chain ID of the deployed chain. (Default:1000) |
|SCHAIN_ID| The service-chain ID of the deployed chain. (Default:2000) |
|NETWORK_ID| The network ID of the deployed chain. (Default:203) |
|NUM_CNS| Number of CNs of the network. (Default:1) |
|NUM_PNS| Number of PNs of the network. (Default:1) |
|NUM_ENS| Number of ENs of the network. (Default:1) |
|NUM_SCNS| Number of SCNs of the network. (Default:1) |

## Checking out the Status of the Network
To check out the local Klaytn network is working well, first check the status of the docker containers. To do that, execute the following command:

```bash
$ ./3.status.sh
```

## Getting logs
After executing `2.start.sh`, it prints logs for the klaytn network.
If you want to print out the logs in another shell, execute the following command:

```bash
$ ./4.logs.sh
```

## Stopping the Network
To stop the network to reduce resource utilzation of your machine, execute the following command:

```bash
$ ./5.stop.sh
```

## Resuming the Network
To resume the stopped network, execute the following command:

```bash
$ ./6.resume.sh
```

## Terminate the Network
To terminate all the resources in your machine, execute the following command:

```bash
$ ./7.terminate.sh
```

**Note** All the transactions and blocks you made will be lost.

# Developing Smart Contracts on the Local Network

## Using KlaytnIDE
[KlaytnIDE](https://ide.klaytn.com) is an IDE (Integrated Development Environment) for Klaytn.
By changing Environment on the "Run" tab to "Caver Provider" with `http://localhost:8551`,
you can easily connect to the local Klaytn network. Enjoy developing!

# FAQ

## Setting parenetOperator on CN
```bash
kcn attach --datadir ~/klaytn

personal.importRawKey('hexkey of SCN', '')
personal.unlockAccount( personal.listAccounts[0], '', 999999999)
klay.sendTransaction({from: personal.listAccounts[0] , to: "address of parentOperator", value: klay.toPeb(10000, 'KLAY')})

klay.getBalance( personal.listAccounts[0] )
klay.getBalance("address of parentOperator")
```


## Setting childOperator on SCN 
```bash
kscn attach --datadir ~/klaytn

personal.importRawKey('hexkey of SCN', '')
personal.unlockAccount( personal.listAccounts[0], '', 999999999)
klay.sendTransaction({from: personal.listAccounts[0], to: subbridge.childOperator, value: klay.toPeb(10000, 'KLAY')})

klay.getBalance( personal.listAccounts[0] )
klay.getBalance( subbridge.childOperator )

subbridge.anchoring( true )
subbridge.latestAnchoredBlockNumber
```


## SCN is not working
IF SCN is not generating blocks properly, try restarting SCN. 

```bash
$ docker-compose restart SCN-0
```
