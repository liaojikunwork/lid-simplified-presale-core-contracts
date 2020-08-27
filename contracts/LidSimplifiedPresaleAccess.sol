pragma solidity 0.5.16;

import "@openzeppelin/upgrades/contracts/Initializable.sol";
import "@openzeppelin/contracts-ethereum-package/contracts/math/SafeMath.sol";
//TODO: Replace with abstract sc or interface. mocks should only be for testing
import "./mocks/LidStaking.sol";

contract LidSimplifiedPresaleAccess is Initializable {
    using SafeMath for uint;
    LidStaking private staking;

    uint[25] private decayCurve;

    function initialize(LidStaking _staking) external initializer {
        staking = _staking;
        //Precalculated
        decayCurve = [
            1000000,
            750000,
            562500,
            421875,
            316406,
            237305,
            177979,
            133484,
            100113,
            75085,
            56314,
            42235,
            31676,
            23757,
            17818,
            13363,
            10023,
            7517,
            5638,
            4228,
            3171,
            2378,
            1784,
            1338,
            0
        ];
    }

    function getAccessTime(address account, uint startTime) external view returns (uint accessTime) {
        uint stakeValue = staking.stakeValue(account);
        //TODO: Use linear interpolation to return the time that the account will have access.
        //Max distances should be 1 hour
        //Value high should be the lowest value on the decayCurve greater than the stake value.
        //Value low should be the highest value on the decayCurve lower than the stake value.
        //Consider binary search eg minime? Not sure
    }

    //Linearly interpolates between valueHigh and valueLow, based on distance starting from valueHigh (eg: 2 seconds after the hour)
    function interpolate(uint valueHigh, uint valueLow, uint maxDistance, uint distance) public pure returns (uint) {
        return valueHigh.sub(
            valueHigh.sub(valueLow).mul(maxDistance).div(distance)
        );
    }
}