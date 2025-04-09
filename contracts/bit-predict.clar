;; Title: BitPredict Pro: Trustless Bitcoin Price Prediction Markets on Stacks L2

;; Summary:
;; Decentralized, non-custodial prediction markets for BTC/USD price movements 
;; secured by Bitcoin and powered by Clarity smart contracts on Stacks Layer 2.

;; Description:
;; BitPredict Pro enables decentralized price speculation markets where participants
;; can stake STX tokens on Bitcoin's price trajectory within defined timeframes.
;; Features include:
;; - Bitcoin-native settlement using sats-denominated price feeds
;; - Stacks L2 execution with Bitcoin-finalized transactions
;; - Transparent market mechanics powered by Clarity's provable contracts
;; - Non-custodial design with direct user STX control
;; - Dynamic reward distribution with protocol fee automation
;; - Oracle-resistant resolution using trusted price feeds

;; Built for Bitcoin compliance:
;; - STX-denominated positions settle on Bitcoin via Stacks L2
;; - No synthetic assets - pure Bitcoin price speculation
;; - All transactions inherit Bitcoin's proof-of-work security
;; - Compliance-focused architecture with administrative safeguards

;; Constants
(define-constant contract-owner tx-sender) ;; Admin multisig address
(define-constant err-owner-only (err u100)) ;; Authorization error
(define-constant err-not-found (err u101)) ;; Data lookup error
(define-constant err-invalid-prediction (err u102)) ;; Invalid market position
(define-constant err-market-closed (err u103)) ;; Market lifecycle error
(define-constant err-market-not-started (err u107)) ;; Early participation attempt
(define-constant err-market-ended (err u108)) ;; Late participation attempt
(define-constant err-market-already-resolved (err u109)) ;; Duplicate resolution
(define-constant err-already-claimed (err u104)) ;; Reward claim error
(define-constant err-insufficient-balance (err u105)) ;; STX balance check
(define-constant err-invalid-parameter (err u106)) ;; Input validation

;; Economic Parameters
(define-data-var oracle-address principal 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM) ;; Trusted price feed
(define-data-var minimum-stake uint u1000000) ;; 1 STX minimum position
(define-data-var fee-percentage uint u2) ;; 2% protocol fee (bps)
(define-data-var market-counter uint u0) ;; Sequential market IDs

;; Market Data Structures
(define-map markets
  uint ;; market-id
  { ;; Bitcoin price market specification
    start-price: uint,    ;; BTC/USD opening price (sats)
    end-price: uint,     ;; BTC/USD closing price (sats)
    total-up-stake: uint, ;; Aggregate long positions
    total-down-stake: uint, ;; Aggregate short positions
    start-block: uint,   ;; Stacks block height - market open
    end-block: uint,     ;; Stacks block height - market close
    resolved: bool       ;; Settlement status
  }
)

(define-map user-predictions
  {market-id: uint, user: principal}
  { ;; Individual position tracking
    prediction: (string-ascii 4), ;; "up" or "down"
    stake: uint,                  ;; STX committed
    claimed: bool                 ;; Reward status
  }
)