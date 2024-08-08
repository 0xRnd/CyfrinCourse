// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

contract SimpleStorage {
    uint myFavoriteNumber;

    struct Person {
        uint256 favoriteNumber;
        string name;
    }

    Person[] public listOfPeople;

    mapping(string => uint256) public nameToFavoriteNumber;

    function store(uint256 _myFavoriteNumber) public
    {
        myFavoriteNumber=_myFavoriteNumber;
    }

    function retrieve() public view returns(uint256){
        return myFavoriteNumber;
    }

    function addPerson(string memory _name, uint256 _favoriteNumber) public{
        listOfPeople.push(Person(_favoriteNumber,_name));
         nameToFavoriteNumber[_name] = _favoriteNumber;
     }
}

//published contract on zksync sepolia
//0xFaa9E0015037960B0A04Af606E976510E08AF23b