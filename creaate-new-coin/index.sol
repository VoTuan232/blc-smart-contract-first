contract FirstCoin {
    address public minter;
    mapping (address => uint) public balances;

    event sent(address from, address to, uint amount);

    // only cho người tạo 
    modifier onlyMinter {
        require(msg.sender == minter);
        _; // ko chạy nếu ko gọi 
    }

    modifier checkAmount(uint amount) {
        require(amount < 1e60);
        _;
    }

    modifier checkBalance(uint amount) {
        require(amount <= balances[msg.sender], "Ko du tien");
        _;
    }

    constructor() {
        minter = msg.sender;
    }

    // create coin, minter
    function mint(address receiver, uint amount) public onlyMinter checkAmount (amount) {
        // require(msg.sender == minter);
        // require(amount < 1e60);

        balances[receiver] += amount;
    }

    // transfers 
    function send(address receiver, uint amount) public checkBalance (amount) {
        // require(amount <= balances[msg.sender], "Ko du tien");
        balances[msg.sender] -= amount;
        balances[receiver] += amount;

        emit sent(msg.sender, receiver, amount);
    }
}