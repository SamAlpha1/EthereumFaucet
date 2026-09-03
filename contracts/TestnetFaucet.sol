// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract TestnetFaucet {
    address public immutable owner;
    uint256 public claimAmount;
    uint256 public cooldown;
    mapping(address => uint256) public lastClaimAt;

    event Claimed(address indexed account, uint256 amount);
    event Funded(address indexed sender, uint256 amount);
    event SettingsUpdated(uint256 claimAmount, uint256 cooldown);

    modifier onlyOwner() {
        require(msg.sender == owner, "only owner");
        _;
    }

    constructor(uint256 initialClaimAmount, uint256 initialCooldown) {
        owner = msg.sender;
        claimAmount = initialClaimAmount;
        cooldown = initialCooldown;
    }

    receive() external payable {
        emit Funded(msg.sender, msg.value);
    }

    function claim() external {
        require(address(this).balance >= claimAmount, "faucet empty");
        require(block.timestamp >= lastClaimAt[msg.sender] + cooldown, "cooldown active");
        lastClaimAt[msg.sender] = block.timestamp;
        (bool ok, ) = payable(msg.sender).call{value: claimAmount}("");
        require(ok, "transfer failed");
        emit Claimed(msg.sender, claimAmount);
    }

    function setSettings(uint256 nextClaimAmount, uint256 nextCooldown) external onlyOwner {
        require(nextClaimAmount > 0, "claim amount is zero");
        claimAmount = nextClaimAmount;
        cooldown = nextCooldown;
        emit SettingsUpdated(nextClaimAmount, nextCooldown);
    }

    function withdraw(uint256 amount) external onlyOwner {
        require(amount <= address(this).balance, "insufficient faucet balance");
        (bool ok, ) = payable(owner).call{value: amount}("");
        require(ok, "withdraw failed");
    }
}
