contract simpleAuction {
    // variable 
    uint public auctionEndTime;
    uint public highestBid;
    address public highestBidder;
    bool ended = false;
    address payable public beneficiary;


    mapping (address => uint) public pendingReturns;

    event highestBidIncrease(address bidder, uint amout);
    event auctionEnded(address winner, uint amout);

    constructor (uint _biddingTime, address payable _beneficiary) {
        beneficiary = _beneficiary;
        auctionEndTime = block.timestamp + _biddingTime;
    }

    // Function
    // Payable: lớp bảo mật 
    function bid() public payable {
        if (block.timestamp > auctionEndTime) {
            revert("Phien dau gia da ket thuc");
        }

        if (msg.value <= highestBid) {
            revert("Gia cua ban thap hon gia cao nhat");
        }

        if (highestBid != 0) {
            pendingReturns[highestBidder] += highestBid;
        }

        highestBidder = msg.sender;
        highestBid = msg.value;
        emit highestBidIncrease(highestBidder, highestBid);
    }

    function withdraw() public returns(bool) {
        uint amount = pendingReturns[msg.sender];

        if (amount > 0) {
            pendingReturns[msg.sender] = 0;
            if (!payable(msg.sender).send(amount)) {
                pendingReturns[msg.sender] = amount;
            }
        }

        return true;
    }

    function auctionEnd() public {
        if (ended) {
            revert("Thoi gian phien dau da ket thuc");
        }

        if (block.timestamp < auctionEndTime) {
            revert("Thoi gian phien dau gia chua ket thuc");
        }

        ended = true;
        emit auctionEnded(highestBidder, highestBid);

        beneficiary.transfer(highestBid);
    }
}