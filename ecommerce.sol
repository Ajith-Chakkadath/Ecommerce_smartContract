// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

contract Ecommerce {

  struct Product {
    string title;
    string desc;
    address payable seller;
    uint productId;
    uint price;
    address buyer;
    bool delivered;
  }

  uint public counter = 1;
  Product[] public products;
  address payable public manger;

  bool destroyed = false;

  modifier isnotDestroyed{
    require(!destroyed ,"The contract is destroyed!");
    _; // Call the next function

  }

  event registered(string title, uint productId, address seller);
  event purchased(uint productId, address buyer); // Renamed for clarity
  event delivered(uint productId);

  constructor(){
    manger = payable (msg.sender);
  }

  function addProducts(string memory _title, string memory _desc, uint _price) public isnotDestroyed{
    require(_price > 0, "Price must be greater than zero");
    Product memory newProduct; // Use a meaningful variable name
    newProduct.title = _title;
    newProduct.desc = _desc;
    newProduct.price = _price;
    newProduct.seller = payable(msg.sender);
    newProduct.productId = counter;
    products.push(newProduct);
    counter++;
    emit registered(_title, newProduct.productId, msg.sender);
  }

  function buy(uint _productId) payable public isnotDestroyed{
    require(products[_productId - 1].price == msg.value, "Please pay the exact amount");
    require(products[_productId - 1].seller != msg.sender, "Seller cannot buy the product");
    products[_productId - 1].buyer = msg.sender;
    emit purchased(_productId, msg.sender);  // Use renamed event
  }

  function confirmDelivery(uint _productId) public isnotDestroyed{ // Consider a more descriptive name
    require(products[_productId - 1].buyer == msg.sender, "Only buyer can confirm delivery");
    products[_productId - 1].delivered = true;
    products[_productId - 1].seller.transfer(products[_productId - 1].price);
    emit delivered(_productId);
  }
// function destroy() public {
//   require(msg.sender == manger , " Only manager can call the function");
//   selfdestruct(manger);
// }
  function destroy() public isnotDestroyed{
    require(manger == msg.sender);
    manger.transfer(address(this).balance);
    destroyed=true;
  }

  fallback() payable external { 
    payable(msg.sender).transfer(msg.value);
  }

}