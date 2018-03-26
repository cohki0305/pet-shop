pragma solidity ^0.4.17;

import "truffle/Assert.sol";
// This smart contract gets the address of the deployed contract.
import "truffle/DeployedAddresses.sol";
import "../contracts/Adoption.sol";

contract TestAdoption {
  Adoption adoption = Adoption(DeployedAddresses.Adoption());

  function testUserCanAdoptPet() public {
    // this contract adopts a pet by itself
    uint returnedId = adoption.adopt(8);
    uint expected = 8;

    Assert.equal(returnedId, expected,  "Adoption of pet ID 8 should be recorded.");
  }

  function testGetAdopterAddressByPetId() public {
    // testUserCanAdoptPet()'s result is still remaining
    address expected = this;

    address adopter = adoption.adopters(8);
    Assert.equal(adopter, expected, "Owner of pet ID 8 should be recorded.");
  }

  function testGetAdopterAddressByPetIdArray() public {
    address expected = this;

    // The memory attribute tells Solidity to temporarily store the value in memory,
    // rather than saving it to the contract's storage.
    address[16] memory adopters = adoption.getAdopters();

    Assert.equal(adopters[8], expected, "Owner of pet ID 8 should be recorded.");
  }
}
