// SPDX-License-Identifier: MIT
// Power by: VeBank

pragma solidity ^0.8.0;

import "./TokenVesting.sol";

// IMPORTANT: The monthly unvesting is unleaseed at the end of each month (30 days), so that the Cliff is substracted by 1 month.
// Vesting schedule and wallet base on tokenomics at 15/07/2022.

/**
 * @dev PrivateSaleVBVesting will be locked at for 6 months.
 * Hence, the vestingDuration should be 24 months.
 * The Cliff is 6 months (the first monthly claim will be enabled 6*30 days after the TGE)
 */
contract PrivateVBVesting is TokenVesting {
  constructor(
    address _token,
    address _owner,
    uint256 _TGETimeStamp,
    uint256 _SECONDS_PER_MONTH
  ) TokenVesting(_token, _owner, _TGETimeStamp, 24, 0, (5 * _SECONDS_PER_MONTH), _SECONDS_PER_MONTH) {}
}


/**
 * @dev PublicSaleVBVesting (IDO) will be claimed 20% at TGE.
 * Hence, the vestingDuration should be 5 months.
 * The Cliff is 0.
 */
contract PublicVBVesting is TokenVesting {
  constructor(
    address _token,
    address _owner,
    uint256 _TGETimeStamp,
    uint256 _SECONDS_PER_MONTH
  ) TokenVesting(_token, _owner, _TGETimeStamp, 5, 20, 0, _SECONDS_PER_MONTH) {}
}


/**
 * @dev CoreTeamVBVesting will be blocked for 9 months.
 * Hence, the vestingDuration should be 60 months.
 * The Cliff is 9 months (the first monthly claim will be enabled 9*30 days after the TGE).
 */
contract CoreTeamVBVesting is TokenVesting {
  constructor(
    address _token,
    address _owner,
    uint256 _TGETimeStamp,
    uint256 _SECONDS_PER_MONTH
  ) TokenVesting(_token, _owner, _TGETimeStamp, 60, 0, (8 * _SECONDS_PER_MONTH), _SECONDS_PER_MONTH) {}
}


// /**
//  * @dev IncentiveVBVesting will be released quaterly as Emissions Schedule By Month (detail in file).
//  * Tokens released 2.65% at TGE for the first quanter and released in next 19 quaters, totally 5 years.
//  * Tokens released before each quater.
//  */
// contract IncentiveVBVesting is TokenVesting {
//   constructor(
//     address _token,
//     address _owner,
//     uint256 _TGETimeStamp,
//     uint256 _SECONDS_PER_MONTH
//   ) TokenVesting(_token, _owner, _TGETimeStamp, 57, 0, (8 * _SECONDS_PER_MONTH), _SECONDS_PER_MONTH) {}
// }


/**
 * @dev ReserveVBVesting vesting monthly in 60 months.
 * The vestingDuration should be 60 months.
 * The Cliff is 0. TGE 0.
 */
contract ReserveVBVesting is TokenVesting {
  constructor(
    address _token,
    address _owner,
    uint256 _TGETimeStamp,
    uint256 _SECONDS_PER_MONTH
  ) TokenVesting(_token, _owner, _TGETimeStamp, 60, 0, 0, _SECONDS_PER_MONTH) {}
}


/**
 * @dev LiquidityVBVesting will be unblocked 100% to add pools at TGE.
 */
contract LiquidityVBVesting is TokenVesting {
  constructor(
    address _token,
    address _owner,
    uint256 _TGETimeStamp,
    uint256 _SECONDS_PER_MONTH
  ) TokenVesting(_token, _owner, _TGETimeStamp, 1, 100, 0, _SECONDS_PER_MONTH) {}
}


/**
 * @dev MarketingVBVesting will be unblocked 30% at TGE.
 * Hence, the vestingDuration should be 24 months.
 * Cliff is 0.
 */
contract MarketingVBVesting is TokenVesting {
  constructor(
    address _token,
    address _owner,
    uint256 _TGETimeStamp,
    uint256 _SECONDS_PER_MONTH
  ) TokenVesting(_token, _owner, _TGETimeStamp, 24, 30, 0, _SECONDS_PER_MONTH) {}
}


/**
 * @dev AirdropRetroVBVesting will be unblocked 20% at TGE.
 * Hence, the vestingDuration should be 5 months.
 * Cliff is 0.
 */
contract AirdropRetroVBVesting is TokenVesting {
  constructor(
    address _token,
    address _owner,
    uint256 _TGETimeStamp,
    uint256 _SECONDS_PER_MONTH
  ) TokenVesting(_token, _owner, _TGETimeStamp, 5, 20, 0, _SECONDS_PER_MONTH) {}
}


/**
 * @dev VBVestingFactory is the main and is the only contract should be deployed.
 * Notice: remember to config the Token address and approriate startAtTimeStamp
 */
contract VBVestingFactory {

  // put the token address here
  // This should be included in the contract for transparency
  address public VB_TOKEN_ADDRESS = 0xe88c871CEA576DdD59FA91a744Eb6C6d5b93AB40;

  // put the startAtTimeStamp here
  // 1667343610 : Tuesday, November 1, 2022 11:00:10 PM.
  // To test all contracts, change this timestamp to time in the past.
  uint256 public startAtTimeStamp = 1660234560;

  // Each month equals 30 days: 30*24*60*60 = 2592000. Note: change this value to 300 to test on testnet
  uint256 internal constant _SECONDS_PER_MONTH = 2592000;

  // address to track other information
  address public owner;

  address public privateVBVesting;
  address public publicVBVesting;
  address public coreTeamVBVesting;
  address public reserveVBVesting;
  address public liquidityVBVesting;
  address public marketingVBVesting;
  address public airdropRetroVBVesting;

  constructor() {
    // Config specific address fo multiple purpose such as: owner, sender, DAO smart-contracts
    owner = msg.sender;


    PrivateVBVesting _privateVBVesting = new PrivateVBVesting(
      VB_TOKEN_ADDRESS,
      owner,
      startAtTimeStamp,
      _SECONDS_PER_MONTH);
    privateVBVesting = address(_privateVBVesting);

    PublicVBVesting _publicVBVesting = new PublicVBVesting(
      VB_TOKEN_ADDRESS,
      owner,
      startAtTimeStamp,
      _SECONDS_PER_MONTH);
    publicVBVesting = address(_publicVBVesting);

    CoreTeamVBVesting _coreTeamVBVesting = new CoreTeamVBVesting(
      VB_TOKEN_ADDRESS,
      owner,
      startAtTimeStamp,
      _SECONDS_PER_MONTH);
    coreTeamVBVesting = address(_coreTeamVBVesting);

    ReserveVBVesting _reserveVBVesting = new ReserveVBVesting(
      VB_TOKEN_ADDRESS,
      owner,
      startAtTimeStamp,
      _SECONDS_PER_MONTH);
    reserveVBVesting = address(_reserveVBVesting);

     LiquidityVBVesting _liquidityVBVesting = new LiquidityVBVesting(
      VB_TOKEN_ADDRESS,
      owner,
      startAtTimeStamp,
      _SECONDS_PER_MONTH);
    liquidityVBVesting = address(_liquidityVBVesting);

    MarketingVBVesting _marketingVBVesting = new MarketingVBVesting(
      VB_TOKEN_ADDRESS,
      owner,
      startAtTimeStamp,
      _SECONDS_PER_MONTH);
    marketingVBVesting = address(_marketingVBVesting);

    AirdropRetroVBVesting _airdropRetroVBVesting = new AirdropRetroVBVesting(
      VB_TOKEN_ADDRESS,
      owner,
      startAtTimeStamp,
      _SECONDS_PER_MONTH);
    airdropRetroVBVesting = address(_airdropRetroVBVesting);
  
  }
}
