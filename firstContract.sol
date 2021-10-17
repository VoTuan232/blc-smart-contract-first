contract firstContracct {
    uint256 saveData;
    
    function set(uint256 x) public {
        saveData = x;
    }
    
    function get() public view returns (uint256 x) {
        return saveData;
    }
}