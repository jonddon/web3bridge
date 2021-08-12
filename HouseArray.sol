// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.2;

// A Street has 4 houses,each containing 3 flats that contains 5 rooms each.. 
// Each room can hold any number of people...
// Write a soldiity contract that calculates the total number of flats, 
// rooms and occupants in that street

contract HouseArray{
    
    uint[5][3][4] public Street;
    //Street = [[[2,2,2,2,2],[2,2,2,2,2],[2,2,2,2,2]], [[2,2,2,2,2],[2,2,2,2,2],[2,2,2,2,2]], [[2,2,2,2,2],[2,2,2,2,2],[2,2,2,2,2]], [[2,2,2,2,2],[2,2,2,2,2],[2,2,2,2,2]]]
    //Flat in house = [[2,2,2,2,2],[2,2,2,2,2],[2,2,2,2,2]]
    //room in Flat = [2,2,2,2,2]
    //people in room = 2
    
    
    uint public numOfHouses = Street.length;
    uint public numOfFlatsPerHouse = Street[0].length;
    uint public numOfRoomsPerFlat = Street[0][0].length;
    uint public numofPeoplePerRoom = Street[0][0][0];
    
    uint public totalNumOfFlat = numOfHouses * numOfFlatsPerHouse;
    uint public totalNumOfRoom = numOfHouses * numOfFlatsPerHouse * numOfRoomsPerFlat;
    uint public totalNumOfPeople = numOfHouses * numOfFlatsPerHouse * numOfRoomsPerFlat * numofPeoplePerRoom;
    
    
    
}
