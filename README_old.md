
---
## Idea 1
Master-Slave Gnosis SAFE architecture
1 master gnosis safe and n child safes. Child safe reads from master safe and only performs actions if data is synchronized from master safe

**BRIDGE DOESN'T WORK**
--> we just pretend it works and pretend we are the bridge

### Tasks
- [ ] Extend Gnosis SAFE 1.3.0
    - add sendState() fn on master safe
    - add readState() verification on slave safe
    - tests
- [ ] Axelar / LayerZero / whtv
    - [ ] make sure we can verify message comes from master safe
- [ ] frontend
  - [ ] Simple react app
  - [ ] 
- [ ] bounty hunt:
  - add kyc as requirement
  - add zkme as requirement
  - deploy on Mantle
  - ~api3?~

### Architecture
Polygon Mumbai <> Optimism Goerli (pretend mantle is optimism)


---
1. look at bridges: Kai - hyperlane, hugo axelar
2. choose bridge
3. 


----

## Idea 2
crosschain data transfer registry mumbo jumbo smth

### Architecture decisions
- 2 testnet chains that are not mantle
- we do NOT refresh data on each dst contract read (assumption data doesn't have to be fresh)

### Tasks to do
- [x] src chain registry contract - Kai
- [ ] dst chain receiver registry contract - Kai / Hugo
- [ ] figure out crosschain calls - Hugo
- [ ] (opt) bitmap for gas efficiency - maybe Hugo - WONTDO (not necessary)
- [ ] (opt) permissionless property adding - maybe Kai 
- [ ] demo js script - Hugo
- [ ] logistics: video, presentation, devfolio submission - together

### DEMO page:
2 panels. 1 source chain, 1 destination chain.
One big button saying "PORT OVER YOUR DATA"
1. user clicks button
2. user signs tx
3. processing
4. data is ported over, we check destination contract on chain 2


### hiccups:
- orbiter does NOT work
- 