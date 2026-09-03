# EthereumFaucet

A compact EVM testnet faucet project built with Hardhat 3.

## Features
- Configurable claim amount
- Per-address cooldown
- Owner-controlled settings and emergency withdrawal
- Receives native testnet ETH directly
- No private key is stored in the repository

## Quick start
```bash
npm install
cp .env.example .env
npm run compile
npm run deploy
```

Use this only with testnet funds unless you have independently audited the contract for your intended environment.
