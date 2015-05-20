/ This script generates bar stats in real time. 
/ It connects to stock tp and generates tradeBar and quoteBar tables based on the updates

/ This function determines what to do with the new updates coming in from tickerplant.
/ First, we save the data in the respective trade or quote table
/ Then, we generate bar tables from the original table
.bstats.upd:{[t;d]
 $[t~`trade;`trade insert d;`quote insert d];
 `tradeBar set `time xasc 0! select maxPrice:max price, minPrice:min price, avgPrice:avg price, totalVol:sum size by sym,time:1 xbar time.minute from trade;
 `quoteBar set `time xasc 0! select maxAsk:max ask, maxBid:max bid, minAsk:min ask, minBid:min bid, maxAskSize:max askSize, minAskSize:min askSize, maxBidSize:max bidSize, minBidSize:min bidSize by sym, time:1 xbar time.minute from quote;
 };

/ This is the subscription function that subscribes to all the tables in the tickerplant
.bstats.sub:{[]
 h:hopen`::17002;
 h(`.u.sub;`;`);
 };

.bstats.init:{[]
 `upd set .bstats.upd;
 .bstats.sub[];
 };

.bstats.init[];
