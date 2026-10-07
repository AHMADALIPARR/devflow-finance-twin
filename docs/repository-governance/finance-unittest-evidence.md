# Finance unittest execution transcript

Captured on 2026-10-07 at the recorded baseline; this repeat captured the raw assertions without changing source. Runner time varies with host activity.

```text
test_cold_boot_write_read_verify (test_cold_boot_icp.TestColdBootFull.test_cold_boot_write_read_verify) ... ok
test_full_cold_boot (test_cold_boot_icp.TestColdBootFull.test_full_cold_boot) ... ok
test_cold_boot_then_anchor (test_cold_boot_icp.TestColdBootICPIntegration.test_cold_boot_then_anchor)
Full flow: cold boot → write records → anchor to ICP. ... ok
test_multiple_anchors (test_cold_boot_icp.TestColdBootICPIntegration.test_multiple_anchors)
Multiple anchor cycles maintain chain integrity. ... ok
test_proof_export_roundtrip (test_cold_boot_icp.TestColdBootICPIntegration.test_proof_export_roundtrip)
Export proof, verify it contains correct data. ... ok
test_phase1_deterministic (test_cold_boot_icp.TestColdBootPhase1.test_phase1_deterministic) ... ok
test_phase1_different_inputs (test_cold_boot_icp.TestColdBootPhase1.test_phase1_different_inputs) ... ok
test_phase1_returns_sha256_hash (test_cold_boot_icp.TestColdBootPhase1.test_phase1_returns_sha256_hash) ... ok
test_phase1_stores_rom_hash (test_cold_boot_icp.TestColdBootPhase1.test_phase1_stores_rom_hash) ... ok
test_phase2_creates_storage_file (test_cold_boot_icp.TestColdBootPhase2.test_phase2_creates_storage_file) ... ok
test_phase2_initializes_metadata (test_cold_boot_icp.TestColdBootPhase2.test_phase2_initializes_metadata) ... ok
test_phase2_loads_existing_state (test_cold_boot_icp.TestColdBootPhase2.test_phase2_loads_existing_state) ... ok
test_phase2_registers_svc_handlers (test_cold_boot_icp.TestColdBootPhase2.test_phase2_registers_svc_handlers) ... ok
test_phase3_completes_cold_boot (test_cold_boot_icp.TestColdBootPhase3.test_phase3_completes_cold_boot) ... ok
test_phase3_requires_phase2 (test_cold_boot_icp.TestColdBootPhase3.test_phase3_requires_phase2) ... ok
test_anchor_chain_linkage (test_cold_boot_icp.TestICPAnchor.test_anchor_chain_linkage) ... ok
test_anchor_rejects_zero_hash (test_cold_boot_icp.TestICPAnchor.test_anchor_rejects_zero_hash) ... ok
test_anchor_state (test_cold_boot_icp.TestICPAnchor.test_anchor_state) ... ok
test_export_proof (test_cold_boot_icp.TestICPAnchor.test_export_proof) ... ok
test_export_proof_invalid_index (test_cold_boot_icp.TestICPAnchor.test_export_proof_invalid_index) ... ok
test_get_canister_state (test_cold_boot_icp.TestICPAnchor.test_get_canister_state) ... ok
test_initialize_creates_genesis (test_cold_boot_icp.TestICPAnchor.test_initialize_creates_genesis) ... ok
test_quick_anchor (test_cold_boot_icp.TestICPAnchor.test_quick_anchor) ... ok
test_verify_chain_tampered (test_cold_boot_icp.TestICPAnchor.test_verify_chain_tampered) ... ok
test_verify_chain_valid (test_cold_boot_icp.TestICPAnchor.test_verify_chain_valid) ... ok
test_sync_empty_worm (test_cold_boot_icp.TestICPAnchorSync.test_sync_empty_worm) ... ok
test_sync_from_worm (test_cold_boot_icp.TestICPAnchorSync.test_sync_from_worm) ... ok
test_sync_nonexistent_file (test_cold_boot_icp.TestICPAnchorSync.test_sync_nonexistent_file) ... ICP Anchor: WORM file not found: /nonexistent/path.worm
ok
test_deserialize_bad_magic (test_cold_boot_icp.TestWORMRecord.test_deserialize_bad_magic) ... ok
test_deserialize_short_data (test_cold_boot_icp.TestWORMRecord.test_deserialize_short_data) ... ok
test_serialize_deserialize_roundtrip (test_cold_boot_icp.TestWORMRecord.test_serialize_deserialize_roundtrip) ... ok
test_chain_verify (test_stack.TestAuditLayer.test_chain_verify) ... ok
test_chain_verify_break (test_stack.TestAuditLayer.test_chain_verify_break) ... ok
test_generate_and_verify_seal (test_stack.TestAuditLayer.test_generate_and_verify_seal) ... ok
test_tampered_seal_detected (test_stack.TestAuditLayer.test_tampered_seal_detected) ... Seal verification FAILED for event evt_002: stored 0c7cf7f0e9e9dc30, computed a1d7292144b8b16c
ok
test_verify_empty_seal (test_stack.TestAuditLayer.test_verify_empty_seal) ... verify_seal called with invalid input
verify_seal called with invalid input
ok
test_chain_verify_empty_list (test_stack.TestEdgeCasesAudit.test_chain_verify_empty_list)
Chain verification with empty list succeeds. ... ok
test_chain_verify_single_seal (test_stack.TestEdgeCasesAudit.test_chain_verify_single_seal)
Chain verification works with a single seal. ... ok
test_seal_digest_is_64_hex_chars (test_stack.TestEdgeCasesAudit.test_seal_digest_is_64_hex_chars)
Seal digest is always a 64-character hex string. ... ok
test_seal_with_all_none_values (test_stack.TestEdgeCasesAudit.test_seal_with_all_none_values)
Seal generation handles None metadata gracefully. ... ok
test_seal_with_nested_metadata (test_stack.TestEdgeCasesAudit.test_seal_with_nested_metadata)
Seal handles deeply nested metadata. ... ok
test_clone_and_diverge (test_stack.TestEdgeCasesIntegration.test_clone_and_diverge)
Two twins from same storage, one continues, verify divergence. ... ok
test_interleaved_operations (test_stack.TestEdgeCasesIntegration.test_interleaved_operations)
Mixed operations in sequence maintain consistency. ... ok
test_rapid_create_and_verify (test_stack.TestEdgeCasesIntegration.test_rapid_create_and_verify)
Rapid account creation followed by verification. ... ok
test_roundtrip_serialization (test_stack.TestEdgeCasesIntegration.test_roundtrip_serialization)
Data survives WORM write/read/rebuild cycle. ... ok
test_verify_detects_injected_record (test_stack.TestEdgeCasesIntegration.test_verify_detects_injected_record)
Injecting a record with wrong prev_hash breaks verification. ... ok
test_deterministic_mode_reproducible (test_stack.TestEdgeCasesQuantum.test_deterministic_mode_reproducible)
Same seed produces identical entropy across instances. ... ok
test_entropy_length (test_stack.TestEdgeCasesQuantum.test_entropy_length)
Quantum entropy is always 64 hex chars (SHA-3-256). ... ok
test_full_weight_portfolio (test_stack.TestEdgeCasesQuantum.test_full_weight_portfolio)
Portfolio with weight 1.0 is valid. ... ok
test_hash_input_deterministic (test_stack.TestEdgeCasesQuantum.test_hash_input_deterministic)
Same input produces same hash. ... ok
test_hash_input_different_inputs (test_stack.TestEdgeCasesQuantum.test_hash_input_different_inputs)
Different inputs produce different hashes. ... ok
test_many_assets (test_stack.TestEdgeCasesQuantum.test_many_assets)
Portfolio with 50 assets works. ... ok
test_random_bytes_unique (test_stack.TestEdgeCasesQuantum.test_random_bytes_unique)
Two random byte calls return different values. ... ok
test_zero_weight_portfolio (test_stack.TestEdgeCasesQuantum.test_zero_weight_portfolio)
Portfolio with all zero weights is valid. ... ok
test_exact_balance_transaction (test_stack.TestEdgeCasesTwin.test_exact_balance_transaction)
Transaction that drains account to exactly zero. ... ok
test_fractional_cents_rounded (test_stack.TestEdgeCasesTwin.test_fractional_cents_rounded)
Values with more than 4 decimal places are rounded (HALF_EVEN). ... ok
test_get_account_balance (test_stack.TestEdgeCasesTwin.test_get_account_balance)
Safe balance lookup. ... ok
test_get_transaction (test_stack.TestEdgeCasesTwin.test_get_transaction)
Safe transaction lookup. ... ok
test_large_amount_transaction (test_stack.TestEdgeCasesTwin.test_large_amount_transaction)
Transaction near maximum balance limit. ... ok
test_many_accounts (test_stack.TestEdgeCasesTwin.test_many_accounts)
Create 100 accounts, all exist in state. ... ok
test_many_transactions (test_stack.TestEdgeCasesTwin.test_many_transactions)
Chain of 50 transactions maintains correct balances. ... ok
test_multiple_reversals_accumulate (test_stack.TestEdgeCasesTwin.test_multiple_reversals_accumulate)
Multiple different transactions can be reversed. ... ok
test_one_cent_transaction (test_stack.TestEdgeCasesTwin.test_one_cent_transaction)
Smallest possible transaction. ... ok
test_over_limit_amount_rejected (test_stack.TestEdgeCasesTwin.test_over_limit_amount_rejected)
Transaction exceeding maximum amount is rejected. ... ok
test_state_hash_changes_on_mutation (test_stack.TestEdgeCasesTwin.test_state_hash_changes_on_mutation)
State hash changes when operations are performed. ... ok
test_state_hash_deterministic (test_stack.TestEdgeCasesTwin.test_state_hash_deterministic)
Same operations produce identical state hashes. ... ok
test_verify_after_many_operations (test_stack.TestEdgeCasesTwin.test_verify_after_many_operations)
Verification succeeds after 200 operations. ... ok
test_concurrent_appends (test_stack.TestEdgeCasesWorm.test_concurrent_appends)
Multiple sequential appends maintain chain integrity. ... ok
test_deeply_nested_payload (test_stack.TestEdgeCasesWorm.test_deeply_nested_payload)
Deeply nested JSON payload is stored correctly. ... ok
test_empty_string_values (test_stack.TestEdgeCasesWorm.test_empty_string_values)
Empty string values in payload are allowed. ... ok
test_get_hash_after_many_records (test_stack.TestEdgeCasesWorm.test_get_hash_after_many_records)
Hash retrieval works correctly after many records. ... ok
test_large_payload (test_stack.TestEdgeCasesWorm.test_large_payload)
Record with 100KB payload succeeds. ... ok
test_null_values_in_payload (test_stack.TestEdgeCasesWorm.test_null_values_in_payload)
Null values in payload are preserved. ... ok
test_read_nonexistent_file (test_stack.TestEdgeCasesWorm.test_read_nonexistent_file)
Reading from a deleted file returns empty list. ... ok
test_special_float_values (test_stack.TestEdgeCasesWorm.test_special_float_values)
NaN and Infinity are rejected by JSON serialization with allow_nan=False. ... ok
test_storage_created_with_mode_600 (test_stack.TestEdgeCasesWorm.test_storage_created_with_mode_600)
New storage file is created (exists and is a file). ... ok
test_unicode_payload (test_stack.TestEdgeCasesWorm.test_unicode_payload)
Unicode characters in payload are preserved. ... ok
test_create_account (test_stack.TestFinanceTwin.test_create_account) ... ok
test_create_duplicate_account_rejected (test_stack.TestFinanceTwin.test_create_duplicate_account_rejected) ... ok
test_decision_seal_generated (test_stack.TestFinanceTwin.test_decision_seal_generated) ... ok
test_double_reverse_rejected (test_stack.TestFinanceTwin.test_double_reverse_rejected) ... ok
test_empty_actor_rejected (test_stack.TestFinanceTwin.test_empty_actor_rejected) ... ok
test_insufficient_funds_rejected (test_stack.TestFinanceTwin.test_insufficient_funds_rejected) ... ok
test_invalid_operation_rejected (test_stack.TestFinanceTwin.test_invalid_operation_rejected) ... ok
test_list_accounts (test_stack.TestFinanceTwin.test_list_accounts) ... ok
test_negative_balance_rejected (test_stack.TestFinanceTwin.test_negative_balance_rejected) ... ok
test_post_transaction (test_stack.TestFinanceTwin.test_post_transaction) ... ok
test_reverse_transaction (test_stack.TestFinanceTwin.test_reverse_transaction) ... ok
test_self_transaction_rejected (test_stack.TestFinanceTwin.test_self_transaction_rejected) ... ok
test_state_rebuild (test_stack.TestFinanceTwin.test_state_rebuild) ... ok
test_unknown_account_rejected (test_stack.TestFinanceTwin.test_unknown_account_rejected) ... ok
test_verify_consistency (test_stack.TestFinanceTwin.test_verify_consistency) ... ok
test_adversarial_tampering_detection (test_stack.TestIntegration.test_adversarial_tampering_detection)
Simulate file-level tampering and verify detection. ... ok
test_full_lifecycle (test_stack.TestIntegration.test_full_lifecycle)
End-to-end: create accounts, transact, verify, rebuild. ... ok
test_quantum_isolation (test_stack.TestIntegration.test_quantum_isolation)
Quantum output cannot mutate ledger directly. ... ok
test_decimal_input (test_stack.TestQuantizeMoney.test_decimal_input) ... ok
test_integer_input (test_stack.TestQuantizeMoney.test_integer_input) ... ok
test_negative_rejected (test_stack.TestQuantizeMoney.test_negative_rejected) ... ok
test_string_input (test_stack.TestQuantizeMoney.test_string_input) ... ok
test_zero_allowed (test_stack.TestQuantizeMoney.test_zero_allowed) ... ok
test_entropy_changes_per_seed (test_stack.TestQuantumLayer.test_entropy_changes_per_seed) ... ok
test_entropy_is_deterministic_with_seed (test_stack.TestQuantumLayer.test_entropy_is_deterministic_with_seed) ... ok
test_generate_random_bytes (test_stack.TestQuantumLayer.test_generate_random_bytes) ... ok
test_hash_input (test_stack.TestQuantumLayer.test_hash_input) ... ok
test_hash_input_sha256 (test_stack.TestQuantumLayer.test_hash_input_sha256) ... ok
test_hash_input_unsupported_algorithm (test_stack.TestQuantumLayer.test_hash_input_unsupported_algorithm) ... ok
test_optimization_circuit (test_stack.TestQuantumLayer.test_optimization_circuit) ... ok
test_optimization_empty_weights_rejected (test_stack.TestQuantumLayer.test_optimization_empty_weights_rejected) ... ok
test_optimization_invalid_weight_rejected (test_stack.TestQuantumLayer.test_optimization_invalid_weight_rejected) ... ok
test_random_bytes_invalid_length (test_stack.TestQuantumLayer.test_random_bytes_invalid_length) ... ok
test_allows_within_limit (test_stack.TestRateLimiter.test_allows_within_limit) ... ok
test_blocks_over_limit (test_stack.TestRateLimiter.test_blocks_over_limit) ... ok
test_append_and_read (test_stack.TestWormStorage.test_append_and_read) ... ok
test_corrupt_json_detected (test_stack.TestWormStorage.test_corrupt_json_detected) ... ok
test_empty_payload_rejected (test_stack.TestWormStorage.test_empty_payload_rejected) ... ok
test_empty_storage_returns_zero_hash (test_stack.TestWormStorage.test_empty_storage_returns_zero_hash) ... ok
test_hash_chaining (test_stack.TestWormStorage.test_hash_chaining) ... ok
test_integrity_valid_chain (test_stack.TestWormStorage.test_integrity_valid_chain) ... ok
test_non_dict_payload_rejected (test_stack.TestWormStorage.test_non_dict_payload_rejected) ... ok
test_record_count (test_stack.TestWormStorage.test_record_count) ... ok
test_tail (test_stack.TestWormStorage.test_tail) ... ok
test_tamper_detection (test_stack.TestWormStorage.test_tamper_detection) ... ok

----------------------------------------------------------------------
Ran 122 tests in 12.174s

OK

```
