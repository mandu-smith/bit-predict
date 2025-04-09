# BitPredict Pro: Decentralized Bitcoin Price Prediction Markets

[![Built on Stacks](https://img.shields.io/badge/Built_on-Stacks_L2-5546ff.svg)](https://www.stacks.co)
[![Clarity Version](https://img.shields.io/badge/Clarity-2.0-blueviolet.svg)](https://clarity-lang.org)

A trustless protocol for creating Bitcoin price prediction markets with secure STX-denominated positions, offering transparent market mechanics and Bitcoin-settled outcomes through Stacks Layer 2 infrastructure.

## Key Features

### Market Mechanics

- **Time-Bound Markets**: Create prediction windows with exact start/end blocks
- **Dual Position System**: "Up" (Long) vs "Down" (Short) BTC price positions
- **Dynamic Liquidity Pools**: Separate pools for long/short positions
- **Satoshi-Priced Markets**: BTC/USD prices tracked in satoshis

### Protocol Economics

- **STX Collateralization**: All positions require STX stake (minimum configurable)
- **Performance Fees**: Protocol collects 2% fee on winning positions (adjustable)
- **Auto-Compounding Pool**: Fees automatically accumulate in protocol treasury

### Technical Implementation

- **Oracle Integration**: Trusted price feed resolution system
- **Block-Based Timing**: Market timelines tied to Stacks block heights
- **Non-Custodial Design**: Users retain STX control until market resolution
- **Provable Fairness**: All calculations on-chain via Clarity

## Contract Architecture

### Core Components

1. **Market Factory**

   - Sequential market ID generation
   - Configurable market parameters:
     - Start/end block heights
     - Initial BTC/USD price
     - Position tracking

2. **Prediction Engine**

   - STX stake management
   - Position allocation (long/short)
   - Real-time liquidity tracking

3. **Resolution System**

   - Oracle-based price settlement
   - Winner determination logic
   - Reward calculation algorithm

4. **Treasury Management**
   - Protocol fee collection
   - STX redistribution
   - Administrative controls

## Workflow Lifecycle

1. **Market Creation**  
   Admin creates market with:

   - `start-price` (sats)
   - `start-block` (Stacks height)
   - `end-block` (Stacks height)

2. **Position Entry**  
   Users `make-prediction` by:

   - Choosing long ("up") or short ("down")
   - Staking STX (≥ minimum requirement)
   - Before market start block

3. **Market Resolution**  
   Oracle triggers `resolve-market` with:

   - Final BTC/USD price
   - After market end block
   - Calculates price differential

4. **Reward Claiming**  
   Winners `claim-winnings`:
   - Pro-rata reward distribution
   - Automatic fee deduction
   - STX transfer to winners

## Administrative Controls

### Governance Functions

- `set-oracle-address`: Update price feed provider
- `set-minimum-stake`: Adjust minimum position size
- `set-fee-percentage`: Modify protocol fee (0-100%)
- `withdraw-fees`: Transfer protocol treasury

### Security Features

- Multi-sig admin protection
- Parameter change cooldowns
- Emergency freeze capability
- Oracle signature verification

## Integration Guide

### Key Contract Interactions

```clarity
;; Create 14-day BTC market starting at 30,000 USD
(create-market u30000 u82500 u83100)

;; Enter 5 STX long position in market 42
(make-prediction u42 "up" u5000000)

;; Resolve market with final price 35,000 USD
(resolve-market u42 u35000)

;; Claim winnings from successful prediction
(claim-winnings u42)
```

### Event Subscriptions

- `MarketCreated(uint, uint, uint)`
- `PredictionMade(principal, uint, uint)`
- `MarketResolved(uint, uint)`
- `RewardsClaimed(principal, uint, uint)`

## Risk Management

### User Protections

- Minimum position size enforcement
- Block height validation
- Resolved market lock
- Double-claim prevention

### Protocol Safeguards

- Oracle signature requirements
- Fee percentage caps
- Treasury withdrawal limits
- Market duration maximums

## Compliance Features

### Bitcoin Alignment

- STX as native collateral asset
- BTC price in satoshi units
- Stacks L2 transaction finality
- No wrapped/BTC-pegged assets

### Regulatory Considerations

- KYC/AML-compatible architecture
- Whitelisting capabilities
- Transaction history proofs
- Tax reporting support

## Development Setup

### Requirements

- Clarinet 2.0+
- Stacks.js 6.x
- Bitcoin testnet node
- Stacks node 3.0+
