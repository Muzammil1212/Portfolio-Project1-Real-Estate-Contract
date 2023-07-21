# Portfolio-Project1-Real-Estate-Contract
Real Estate Contract

Abstract- Real estate in Pakistan as well as in many parts of the world is a very slow
and cumbersome process. There are also many intermediaries involved in the process of
land registration. Developing a system that not only accelerates the process of land
registration, but also makes it easier for Buyers, Sellers and Government registrars to
transfer the land ownership from seller to a new buyer, is only possible by creating a
distributed system that stores all the transactions made during the process of land
buying. 
Stepwise Approach For Creating Real Estate Contract:
Hint : Use Structs
Step 1: Land details(LandId; Area; city; state;LandPrice;propertyPID)
Step 2: Buyer details( Name; Age; City; CNIC;Email;
Note: Buyer Id/Key is your account Address (hint :- use mapping to store account
address with buyer details)
Step 3: Seller details(Name; Age; City; CNIC;Email)
Note: Seller and buyer account cannot be same
Step 4: LandInspector details( Id; Name; Age; Designation)
Note (who deploy the contract will be the land inspector and owner of this software)
(hint :- id is landInspector address)
Step 5: Mapping details
mapping(uint => Landreg) public lands;
mapping(uint => LandInspector) public InspectorMapping;
mapping(address => Seller) public SellerMapping;
mapping(address => Buyer) public BuyerMapping;
Note: (you may need to create more mapping,above is just for example)
Step 6 : First you need to registerSeller (seller details in step no 3).
Step 7: Land Inspector can either verify that seller or reject that seller.
Step 8: If seller is verified then seller upload land details (land details in
step no 1). If the seller is not verified by the Land Inspector they cannot
add the land details.
Step 9: LandInspector will also verify the land added by the seller by landID.
Step 10: We can also update the seller details.
Step 11: We can check if seller is verified or not (boolean)
Step 12: We can get land details by landID .
Step 13: We can check who is the owner of this land by landID
Step 14: First you need to registerBuyer(Buyer details in step no 2)
Step 15: If Buyer is registered then landInpector either verify that Buyer or reject
that buyer.
Step 16: We can also update the Buyer details.
Step 17: We can check if Buyer is verified or not (boolean).
Step 18: We can check who is the current owner of this land.
Step 19: Buyer can buy the land only if buyer and land both are verified .Buyer need
to give the amount and land Id that they want to buy.
Step 20 : Ownership will change from the current owner to the new Owner.
Step 19: Owner of the land can transfer their land to any address if the is land is
verified by LandInspector
Part 4:
We can individual check
LandsOwner
LandIsVerifed
SellerIsVerified
BuyerIsVerified
LandInspector
GetLandCity
GetLandPrice
GetArea
isBuyer(boolean)
isSeller(boolean)
