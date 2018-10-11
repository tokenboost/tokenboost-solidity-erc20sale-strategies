#!/bin/bash

truffle exec scripts/update_allowed_token_supply_strategy_template.js --network $1 &&
truffle exec scripts/update_cap_strategy_template.js --network $1 &&
truffle exec scripts/update_claimable_token_distribution_strategy_template.js --network $1 &&
truffle exec scripts/update_fixed_price_strategy_template.js --network $1 &&
truffle exec scripts/update_individual_cap_strategy_template.js --network $1 &&
truffle exec scripts/update_manual_start_finish_startegy_template.js --network $1 &&
truffle exec scripts/update_minted_token_supply_strategy_template.js --network $1 &&
truffle exec scripts/update_soft_hard_cap_startegy_template.js --network $1 &&
truffle exec scripts/update_timed_start_finish_strategy_template.js --network $1 &&
truffle exec scripts/update_transferred_token_supply_strategy_template.js --network $1 &&
truffle exec scripts/update_whitelist_strategy_template.js --network $1 &&
truffle exec scripts/update_veriff_kyc_strategy_template.js --network $1
