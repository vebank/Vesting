// SPDX-License-Identifier: MIT
// Power by: VeBank

pragma solidity ^0.8.0;

import "./TokenVesting.sol";

/** IMPORTANT: The monthly vesting is released at the end of each month (30 days), so that the Cliff is substracted by 1 month.
 * Use TokenVesting.addBeneficiary to add total amout for each beneficiary/wallet.
 * Use TokenVesting.claimVestedToken to claim the available tokens at a time.
 * Vesting schedule and wallet base on tokenomics at 25/08/2022.
 */


/**
 * @dev PrivateSaleVBVesting will be claimed 5% at TGE.
 * Hence, the vestingDuration should be 24 months.
 * The Cliff is 0.
 */
contract PrivateVBVesting is TokenVesting {
  constructor(
    address _token,
    address _owner,
    uint256 _TGETimeStamp,
    uint256 _SECONDS_PER_MONTH
  ) TokenVesting(_token, _owner, _TGETimeStamp, 24, 5, 0, _SECONDS_PER_MONTH) {}
}


/**
 * @dev PublicSaleVBVesting (IDO) will be claimed 5% at TGE.
 * Hence, the vestingDuration should be 6 months.
 * The Cliff is 0.
 */
contract PublicVBVesting is TokenVesting {
  constructor(
    address _token,
    address _owner,
    uint256 _TGETimeStamp,
    uint256 _SECONDS_PER_MONTH
  ) TokenVesting(_token, _owner, _TGETimeStamp, 6, 5, 0, _SECONDS_PER_MONTH) {}
}


/**
 * @dev StakeFarmVBVesting will be claimed 10% at TGE.
 * Hence, the vestingDuration should be 60 months.
 * The Cliff is 0.
 */
contract StakeFarmVBVesting is TokenVesting {
  constructor(
    address _token,
    address _owner,
    uint256 _TGETimeStamp,
    uint256 _SECONDS_PER_MONTH
  ) TokenVesting(_token, _owner, _TGETimeStamp, 60, 10, 0, _SECONDS_PER_MONTH) {}
}


/**
 * @dev LendVBVesting will be claimed 10% at TGE.
 * Hence, the vestingDuration should be 60 months.
 * The Cliff is 0.
 */
contract LendVBVesting is TokenVesting {
  constructor(
    address _token,
    address _owner,
    uint256 _TGETimeStamp,
    uint256 _SECONDS_PER_MONTH
  ) TokenVesting(_token, _owner, _TGETimeStamp, 60, 10, 0, _SECONDS_PER_MONTH) {}
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
 * @dev CoreTeamVBVesting will be blocked for 12 months (team & advisors).
 * Hence, the vestingDuration should be 36 months.
 * The Cliff is 12 months (the first monthly claim will be enabled 11*30 days after the TGE).
 */
contract CoreTeamVBVesting is TokenVesting {
  constructor(
    address _token,
    address _owner,
    uint256 _TGETimeStamp,
    uint256 _SECONDS_PER_MONTH
  ) TokenVesting(_token, _owner, _TGETimeStamp, 36, 0, (11 * _SECONDS_PER_MONTH), _SECONDS_PER_MONTH) {}
}


/**
 * @dev FutureExchangeVBVesting  vesting monthly in 36 months.
 * The vestingDuration should be 36 months.
 * The Cliff is 0. TGE 0.
 */
contract FutureExchangeVBVesting is TokenVesting {
  constructor(
    address _token,
    address _owner,
    uint256 _TGETimeStamp,
    uint256 _SECONDS_PER_MONTH
  ) TokenVesting(_token, _owner, _TGETimeStamp, 36, 0, 0, _SECONDS_PER_MONTH) {}
}


/**
 * @dev TreasuryVBVesting vesting monthly in 12 months.
 * The vestingDuration should be 12 months.
 * The Cliff is 0. TGE 0.
 */
contract TreasuryVBVesting is TokenVesting {
  constructor(
    address _token,
    address _owner,
    uint256 _TGETimeStamp,
    uint256 _SECONDS_PER_MONTH
  ) TokenVesting(_token, _owner, _TGETimeStamp, 12, 0, 0, _SECONDS_PER_MONTH) {}
}


/**
 * @dev MarketingVBVesting will be unblocked 50% at TGE.
 * Hence, the vestingDuration should be 24 months.
 * Cliff is 0.
 */
contract MarketingVBVesting is TokenVesting {
  constructor(
    address _token,
    address _owner,
    uint256 _TGETimeStamp,
    uint256 _SECONDS_PER_MONTH
  ) TokenVesting(_token, _owner, _TGETimeStamp, 24, 50, 0, _SECONDS_PER_MONTH) {}
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
  address public stakeFarmVBVesting;
  address public lendVBVesting;
  address public liquidityVBVesting;
  address public coreTeamVBVesting;
  address public futureExchangeVBVesting;
  address public treasuryVBVesting;
  address public marketingVBVesting;

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

    StakeFarmVBVesting _stakeFarmVBVesting = new StakeFarmVBVesting(
      VB_TOKEN_ADDRESS,
      owner,
      startAtTimeStamp,
      _SECONDS_PER_MONTH);
    stakeFarmVBVesting = address(_stakeFarmVBVesting);

    LendVBVesting _lendVBVesting = new LendVBVesting(
      VB_TOKEN_ADDRESS,
      owner,
      startAtTimeStamp,
      _SECONDS_PER_MONTH);
    lendVBVesting = address(_lendVBVesting);

    LiquidityVBVesting _liquidityVBVesting = new LiquidityVBVesting(
      VB_TOKEN_ADDRESS,
      owner,
      startAtTimeStamp,
      _SECONDS_PER_MONTH);
    liquidityVBVesting = address(_liquidityVBVesting);

    CoreTeamVBVesting _coreTeamVBVesting = new CoreTeamVBVesting(
      VB_TOKEN_ADDRESS,
      owner,
      startAtTimeStamp,
      _SECONDS_PER_MONTH);
    coreTeamVBVesting = address(_coreTeamVBVesting);

    FutureExchangeVBVesting _futureExchangeVBVesting = new FutureExchangeVBVesting(
      VB_TOKEN_ADDRESS,
      owner,
      startAtTimeStamp,
      _SECONDS_PER_MONTH);
    futureExchangeVBVesting = address(_futureExchangeVBVesting);

    TreasuryVBVesting _treasuryVBVesting = new TreasuryVBVesting(
      VB_TOKEN_ADDRESS,
      owner,
      startAtTimeStamp,
      _SECONDS_PER_MONTH);
    treasuryVBVesting = address(_treasuryVBVesting);

    MarketingVBVesting _marketingVBVesting = new MarketingVBVesting(
      VB_TOKEN_ADDRESS,
      owner,
      startAtTimeStamp,
      _SECONDS_PER_MONTH);
    marketingVBVesting = address(_marketingVBVesting);
  
  }
}
