contract FirstCoin {
    address public minter;
    mapping (address => uint) public balances;

    event sent(address from, address to, uint amount);

    constructor() {
        minter = msg.sender;
    }

    // create coin, minter
    function mint(address receiver, uint amount) public {
        require(msg.sender == minter);
        require(amount < 1e60);

        balances[receiver] += amount;
    }

    // transfers 
    function send(address receiver, uint amount) public {
        require(amount <= balances[msg.sender], "Ko du tien");
        balances[msg.sender] -= amount;
        balances[receiver] += amount;

        emit sent(msg.sender, receiver, amount);
    }
}