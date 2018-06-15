#!/bin/bash

## Karan Kapuria 

## Calculates the cost of instance based on uptime of instance. Just replace <hourly-price-of-instance> by the cost 

####---------------------------------------------------------
## 				Calculating Costs Instance 
####---------------------------------------------------------

UPTIME=$(cat /proc/uptime | awk '{print $1/3600}') 

COST=$(cat /proc/uptime|awk '{print ($1/3600)*<hourly-price-of-instance>}') 

echo -e $SAMPLE_NAME"\t"$UPTIME"\tSPOT_PRICE\t$"$COST >> COST.log