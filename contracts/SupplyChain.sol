// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

contract SupplyChain {
    enum State { Created, InTransit, Delivered }

    struct Product {
        uint id;
        string name;
        address owner;
        State state;
    }

    mapping(uint => Product) public products;
    uint public productCount;

    event ProductCreated(uint id, string name, address owner);
    event ProductInTransit(uint id);
    event ProductDelivered(uint id);

    function createProduct(string memory _name) public {
        productCount++;
        products[productCount] = Product(productCount, _name, msg.sender, State.Created);
        emit ProductCreated(productCount, _name, msg.sender);
    }

    function markInTransit(uint _id) public {
        require(products[_id].owner == msg.sender, "Only the owner can mark the product as in transit.");
        require(products[_id].state == State.Created, "Product must be in created state.");
        
        products[_id].state = State.InTransit;
        emit ProductInTransit(_id);
    }

    function markDelivered(uint _id) public {
        require(products[_id].owner == msg.sender, "Only the owner can mark the product as delivered.");
        require(products[_id].state == State.InTransit, "Product must be in transit state.");
        
        products[_id].state = State.Delivered;
        emit ProductDelivered(_id);
    }
}
