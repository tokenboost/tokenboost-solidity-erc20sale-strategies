#!/bin/bash

truffle exec scripts/setup_allowed_token_supply_strategy_renderer.js --network $1 &&
truffle exec scripts/setup_cap_strategy_renderer.js --network $1 &&
truffle exec scripts/setup_claimable_token_distribution_strategy_renderer.js --network $1 &&
truffle exec scripts/setup_fixed_price_strategy_renderer.js --network $1 &&
truffle exec scripts/setup_individual_cap_strategy_renderer.js --network $1 &&
truffle exec scripts/setup_manual_start_finish_strategy_renderer.js --network $1 &&
truffle exec scripts/setup_minted_token_supply_strategy_renderer.js --network $1 &&
truffle exec scripts/setup_soft_hard_cap_strategy_renderer.js --network $1 &&
truffle exec scripts/setup_timed_start_finish_strategy_renderer.js --network $1 &&
truffle exec scripts/setup_transferred_token_supply_strategy_renderer.js --network $1 &&
truffle exec scripts/setup_whitelist_strategy_renderer.js --network $1 &&
truffle exec scripts/setup_veriff_kyc_strategy_renderer.js --network $1
