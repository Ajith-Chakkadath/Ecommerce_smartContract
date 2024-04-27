
### Project Title: Ecommerce Smart Contract

#### Overview

This Solidity smart contract provides basic e-commerce functionality on the Ethereum blockchain. It allows sellers to list products for sale, buyers to purchase these products using Ether, and buyers to confirm the delivery of products. The contract includes basic features such as adding products, purchasing products, and confirming delivery. Additionally, the contract can be destroyed by the manager to prevent further interactions.

#### Features

- **Product Listing**: Sellers can list their products with a title, description, and price.
- **Purchase Products**: Buyers can purchase products by sending the correct amount of Ether.
- **Confirm Delivery**: Buyers can confirm the receipt of products, allowing funds to be released to the seller.
- **Contract Destruction**: The manager can destroy the contract, preventing any further interactions and transferring any remaining balance to the manager's address.

#### Contract Functions

- `addProducts(string memory _title, string memory _desc, uint _price)`: Adds a new product to the store.
- `buy(uint _productId) payable`: Allows a user to purchase a product by sending the exact product price in Ether.
- `confirmDelivery(uint _productId)`: Allows the buyer of a product to confirm its delivery, releasing payment to the seller.
- `destroy()`: Allows the manager to destroy the contract and transfer any remaining Ether to the manager's address.
- `fallback() payable`: Refunds any Ether sent to the contract outside of the defined functions.

#### Events

- `registered(string title, uint productId, address seller)`: Emitted when a new product is registered.
- `purchased(uint productId, address buyer)`: Emitted when a product is purchased.
- `delivered(uint productId)`: Emitted when delivery of a product is confirmed.

#### Requirements

- Solidity ^0.6.12
- Ethereum-compatible wallet

#### Setup and Deployment

1. **Install Dependencies**: Ensure that Node.js, Truffle, and Ganache are installed on your system.
2. **Compile the Contract**:
   ```shell
   truffle compile
   ```
3. **Deploy the Contract**:
   ```shell
   truffle migrate
   ```

#### Usage Example

To add a product:

```solidity
Ecommerce.addProducts("Product Title", "Description", 1 ether);
```

To purchase a product:

```solidity
Ecommerce.buy(1, {value: 1 ether});
```

To confirm delivery:

```solidity
Ecommerce.confirmDelivery(1);
```

#### Safety and Security

This contract is a basic example and does not implement advanced security measures such as pull payments or gas optimizations. Use at your own risk or consider extending its features for production use.

#### License

This project is licensed under the MIT License.


