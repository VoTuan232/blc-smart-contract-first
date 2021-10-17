// Data types
// contract dataTypes {
//     bool myBoolean = true;
//     uint myUnsignInteger = 10;
//     int myInteger = -10;
//     string myString = "MyString";
//     address myAddress = msg.sender;
// }

// Enum
contract Game {
    uint countPlayer = 0;
    // Player[] public players;

    // quản lí nhiều giá trị ==> cần mapping
    mapping (address => Player) public players;

    enum Level {
        Beginner, 
        Intermediate,
        Advande
    }

    struct Player {
        address addressPlayer;
        string fullName;
        Level myLevel;
        uint age;
        string sex;
        uint createTime;
    }

    function addPlayer(string memory fullName, uint age, string memory sex) public {
        // players.push(Player(fullName, age, sex));

        // msg.sender : người sử dụng chức năng, địa chỉ ví người gửi 
        players[msg.sender] = Player(msg.sender, fullName, Level.Beginner, age, sex, block.timestamp);
        countPlayer += 1;
    }

    function getPlayerLevel(address addressPlayer) public view returns (Level) {
        return players[addressPlayer].myLevel;
    }

    function changePlayerLevel(address playerAddress) public {
        Player storage player = players[playerAddress];
        if (block.timestamp >= player.createTime + 20) {
            player.myLevel = Level.Intermediate;
        }
    }
}