// SPDX-License-Identifier:GPL-3.0
pragma solidity ^0.8.0;

contract Land_Registry {
    
    address public owner;             // owner is a variable with "address"  datatype whose scope is public(Accessible to everyone). 
    address public landInspector;
    // Used To store Land Details
    struct Land {
        uint landId;
        uint area;
        string city;
        string state;
        uint landPrice;
        uint propertyPID;
        address owner;
        bool isVerified;
    }
    // used to store Seller details
    struct Seller {
        string name;
        uint age;
        string city;
        string CNIC;
        string email;
        bool isVerified;
    }
    // used to store Buyer Details
    struct Buyer{
        string name;
        uint age;
        string city;
        string CNIC;
        string email;
        bool verified;

    }
    // used to store Land Inspector Details.
    struct LandInspector {
        string name;
        uint age;
        string designation;
    }
    mapping(address => Seller) public sellers;
    mapping(uint => Land) public lands;
    mapping(address => Buyer) public buyers;
    mapping(address => bool) public isBuyer;
    mapping(address => bool) public isSeller;
    mapping(address => bool) public isVerifiedBuyer;
    mapping(address => bool) public isVerifiedSeller;
    mapping(address => bool) public isVerifiedLand;
    mapping(address => bool) public isLandInspector;
    
    constructor() {
        owner = msg.sender;
        landInspector=msg.sender;
    }
    
    /**
     * @dev registerSeller is used to register seller.
     * Requirement:
     * - This function can be called by anyone
     * @param _name - _name
     * @param _age -  _age
     * @param _city - _city  
     * @param _CNIC -  _CNIC
     * @param _email -  _email
    
    */
    function registerSeller(string memory _name, uint _age, string memory _city, string memory _CNIC, string memory _email,bool  _isVerified) public {
        require(msg.sender != landInspector, "Land Inspector cannot register as seller.");
        require(buyers[msg.sender].verified == false, "Buyer aready registered with the same address");
        Seller memory newSeller = Seller(_name, _age, _city, _CNIC, _email,_isVerified);
        sellers[msg.sender] = newSeller;
    }
     
    /**
     * @dev verifySeller is used to verify   that seller is registered.
     * Requirement:
     * - Only Land Inspector can verify this.
     * @param _sellerAddress- _sellerAddress
     * Return: true (Seller is registered)
    */
    function verifySeller(address _sellerAddress) public {
        require(msg.sender == landInspector, "Only Land Inspector can verify seller.");
        sellers[_sellerAddress].isVerified = true;
    }
     /**
     * @dev rejectSeller is used to verify   that seller is not  registered.
     * Requirement:
     * - Only Land Inspector can verify this.
     * @param _sellerAddress- _sellerAddress
     * Return: false (Seller is not registered).
    */
    function rejectSeller(address _sellerAddress) public {
        require(msg.sender == landInspector, "Only Land Inspector can reject seller.");
        sellers[_sellerAddress].isVerified = false;
    }
     /**
     * @dev verifyLand is used to show that land is verified.
     * Requirement:
     * - Only Land Inspector can verify this.
     * @param _landId- _landId
     * Return: true (Verified Lnad).
    */
    function verifyLand(uint _landId) public {
        require(msg.sender == landInspector, "Only Land Inspector can verify land.");
        lands[_landId].isVerified = true;
    }
     /** 
     * @dev rejectLand is used to verify that land isnt  valid.
     * Requirement:
     * - Only Land Inspector can verify this.
     * @param _landId- _landId
     * Return: false (Seller is not registered).
    */
    function rejectLand(uint _landId) public {
        require(msg.sender == landInspector, "Only Land Inspector can reject land.");
        lands[_landId].isVerified = false;
    }
    /**
    * @dev addLand is used to add Land details.
     * Requirement:
     * - Only details of verified land can be added .
     * @param _landId- _landId
     * @param _area- _area
     * @param _city - _city
     * @param _state- _state
     * @param _landPrice _landPrice
     * @param _propertyPID- _propertyPID
       
    */
    function addLand(uint _landId, uint _area, string memory _city, string memory _state, uint _landPrice, uint _propertyPID) public {
        require(sellers[msg.sender].isVerified == true, "Only verified sellers can add land details.");
        Land memory newLand = Land(_landId, _area, _city, _state, _landPrice, _propertyPID, msg.sender, false);
        lands[_landId] = newLand;
    }
    /**
    * @dev updateSeller is used to update seller details.
     * Requirement:
     * Verified sellers can update their details only.
     * @param _name- _name
     * @param _age- _age
     * @param _city - _city
     * @param _CNIC- _CNIC
     * @param _email _email

    */
    function updateSeller(string memory _name, uint _age, string memory _city, string memory _CNIC, string memory _email) public {
        require(sellers[msg.sender].isVerified == true, "Only verified sellers can update their details.");
        sellers[msg.sender].name = _name;
        sellers[msg.sender].age = _age;
        sellers[msg.sender].city = _city;
        sellers[msg.sender].CNIC = _CNIC;
        sellers[msg.sender].email = _email;
    }
    /** 
     * @dev isSellerVerified is used to get verified seller info/id/address.
     
     * Return: true/false.
    */
    function isSellerVerified() public view returns(bool) {
        return sellers[msg.sender].isVerified;
    }
    /**
    * @dev getLandDetails is used to get land details.
     * @param _landId- _landId
     Return:
     * _landId
     *  _area
     *  _city
     *  _state
     *  _landPrice 
     * _propertyPID
     *_owner
     *  _isVerified
    */
    function getLandDetails(uint _landId) public view returns(uint, uint, string memory, string memory, uint, uint, address, bool) {
        Land memory land = lands[_landId];
        return (land.landId, land.area, land.city, land.state, land.landPrice, land.propertyPID, land.owner, land.isVerified);
    }
    /**
    * @dev getLandOwner is used to get address(account address) of land owner.
     * @param _landId- _landId
     Return:
     * address of land owner.
     
    */
    function getLandOwner1(uint _landId) public view returns(address) {
        return lands[_landId].owner;
    }

    /*
    * @dev registerBuyer is used to register a new buyer
     
     * @param _name- _name
     * @param _age- _age
     * @param _city - _city
     * @param _CNIC- _CNIC
     * @param _email _email

    */
    function registerBuyer(string memory _name, uint _age, string memory _city, string memory  _cnic, string memory _email,bool _verified) public {
        buyers[msg.sender] = Buyer(_name, _age, _city, _cnic, _email, _verified);
    }

    /**
     * @dev verifyBuyer is used to verify  that buyer is registered.
     * Requirement:
     * - Only Land Inspector can verify this.
     * @param _buyerAddress- _buyerAddress
     */
    function verifyBuyer(address _buyerAddress) public {
        require(msg.sender == address(landInspector), "Only land inspector can verify buyer.");
        buyers[_buyerAddress].verified = true;
    }
     /**
     * @dev rejectBuyer is used to verify  that buyer is not  register.
     * Requirement:
     * - Only Land Inspector can verify this.
     * @param _buyerAddress- _buyerAddress
     */
    function rejectBuyer(address _buyerAddress) public {
        require(msg.sender == address(landInspector), "Only land inspector can reject buyer.");
        buyers[_buyerAddress].verified = false;
    }
     /**
    * @dev updateBuyerDetails is used to update Buyer Details.
     * @param _name- _name
     * @param _age- _age
     * @param _cnic - _cnic
     * @param _email- _email
    */

    function updateBuyerDetails(string memory _name, uint _age, string memory _city, string memory  _cnic, string memory _email) public {
        buyers[msg.sender] = Buyer(_name, _age, _city, _cnic, _email, buyers[msg.sender].verified);
    }

    /**
     * @dev isBuyerVerified is used to verify  buyer.
     * @param _buyerAddress- _buyerAddress
     return: true/false.
     */
    function isBuyerVerified(address _buyerAddress) public view returns(bool) {
        return buyers[_buyerAddress].verified;
    }
    /**
     * @dev getCurrentLandOwner is used to get current owner of the land
     * @param _landId- _landId
     return: address of land owner
     */
    
    function getCurrentLandOwner(uint _landId) public view returns(address) {
        return lands[_landId].owner;
    }
    /*
     * @dev buyLand is used to buy a land.
     * Requirements: Land and buyer must be verified.
     * @param _landId- _landId
     
     */

    function buyLand(uint _landId) public payable {
    require(buyers[msg.sender].verified && lands[_landId].isVerified, "Both land and buyer must be verified.");
    require(msg.value >= lands[_landId].landPrice, "Insufficient payment.");
    address payable previousOwner = payable(lands[_landId].owner);
    lands[_landId].owner = msg.sender;
    previousOwner.transfer(msg.value);
}
    /*
     * @dev transferLand is used to tranfer land.
     * Requirements: only verified land owner can transfer the land.
     * @param _landId- _landId
     *@ param _newowner- _newowner
     */

    function transferLand(uint _landId, address _newOwner) public {
        require(msg.sender == lands[_landId].owner && lands[_landId].isVerified, "Only verified land owner can transfer the land.");
        lands[_landId].owner = _newOwner;
    }
    /*
     * @dev getLandowner12is used to to get land owner id. 
     */
    function getLandOwner12(uint _landId) public view returns(address) {
        return lands[_landId].owner;
    }
    function getLandIsVerified(uint _landId) public view returns (bool) {
        return lands[_landId].isVerified;
    }
    function getBuyerIsVerified(address _buyerAddress) public view returns (bool) {
        return buyers[_buyerAddress].verified;
    }
    function getLandInspector() public view returns ( string memory, uint, string memory) {
        require(isLandInspector[msg.sender], "Only the land inspector can access this information.");
        LandInspector memory inspector;
        inspector.name = "John Doe"; // replace with actual name
        inspector.age = 40; // replace with actual age
        inspector.designation = "Inspector"; // replace with actual designation
        return ( inspector.name, inspector.age, inspector.designation);
    }
    
    function getLandCity(uint landId) public view returns (string memory) {
        return lands[landId].city;
    }
    function getLandPrice(uint landId) public view returns (uint) {
        return lands[landId].landPrice;
    }
    function getArea(uint landId) public view returns (uint) {
        return lands[landId].area;
    }

    function isBuyer1() public view returns (bool) {
        return buyers[msg.sender].verified;
    }
    function isSeller1() public view returns (bool) {
        return sellers[msg.sender].isVerified;
    }


}
