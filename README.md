# sozu-hack
repo for sozu house hackathon


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
- [ ] frontend
  - [ ] Simple react app
  - [ ] 
- [ ] bounty hunt:
  - add kyc as requirement
  - add zkme as requirement
  - deploy on Mantle
  - ~api3?~
