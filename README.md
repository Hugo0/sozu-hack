# sozu-hack
repo for sozu house hackathon

Deployed Addresses: 
- [Goerli](https://goerli.etherscan.io/address/0x9fa4cfab777274aedbd7a5c39b733c3e4534844f)
- [Optimism Goerli](https://goerli-optimism.etherscan.io/address/0xfe5CD4EB9748C62B6B3edd36FA6c033c95D2f685)


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
- [ ] src chain registry contract - Kai
- [ ] dst chain receiver registry contract - Kai / Hugo
- [ ] figure out crosschain calls - Hugo
- [ ] (opt) bitmap for gas efficiency - maybe Hugo
- [ ] (opt) permissionless property adding - maybe Kai
- [ ] demo js script - Hugo
- [ ] logistics: video, presentation, devfolio submission - together











