pragma solidity ^0.4.16;

contract GeneralWalletCompatibleToken {
    string public name;
    string public symbol;
    uint8 public decimals;

    mapping (address => uint256) public balanceOf;

    event Transfer(address _from, address _to, uint8 _value);

    function UnsecureGeneralWalletCompatibleToken(string tokenName, string tokenSymbol, uint8 decimalUnits, uint256 initialSupply) public {
        name = tokenName;
        symbol = tokenSymbol;
        decimals = decimalUnits;
        balanceOf[msg.sender] = initialSupply;
    }

    function transfer (address _to, uint256 _value) public {
        require(_value <=  balanceOf[msg.sender]);
        require(balanceOf[_to] + _value >= balanceOf[_to]);
        // 위의 코드 === if (balanceOf[_to] + _value >= balanceOf[_to]) revert();
        // solidity 0.4.13 버전부터 throw() 대신 revert()를 사용
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        emit Transfer(msg.sender,  _to, _value);
    }
}

contract CrowdFundWithUnsecureToken {
    UnsecureGeneralWalletCompatibleToken tokenReward;
    uint8 transferCount public;


    function transfer() external {
        transferCount++;
        tokenReward.transfer(msg.sender, 10);
    }

    // 함수 타입 테스트용 컨트랙트
    contract FunctionType {
        function (uint, uint) internal pure returns (uint) processor;

        function changeProcessorToAdd() public {
            processor = add;
        }

        function calculate(uint add, uint b) external view returns (uint) {
            returns processor(a, b);
        }

        function add(uint a, uint b) internal pure returns (uint) {
            return a + b;
        }
    }


}
