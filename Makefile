# List of features to use when building.
FEATURES ?=

.PHONY: clean
clean: ## Perform a `cargo` clean.
	cargo clean

.PHONY: fmt
fmt: ## Perform a `rustfmt` formatting.
	cargo +nightly fmt --all

.PHONY: lint
lint: ## Perform a lint command to format and lint code. TODO - `make lint-rinf && \`
	make fmt && \
	make lint-other-targets

.PHONY: fix
fix: ## Perform a lint fix command to format.
	# make fix-lint-rinf && \
	make fix-lint-other-targets && \
	make fmt

.PHONY: test
test: ## Perform a workspace tests, including doc-tests.
	make test-rinf && \
	make test-doc

test-rinf:
	cargo test --all-features

test-doc:
	cargo test --doc --workspace --features "$(FEATURES)"

lint-rinf:
	cargo +nightly clippy \
    	--workspace \
    	# --bin "rinf" \
    	--lib \
    	--tests \
    	--benches \
    	--features "$(FEATURES)" \
    	-- -D warnings

lint-other-targets:
	cargo +nightly clippy \
    	--workspace \
    	--lib \
    	--tests \
    	--benches \
    	--all-features \
    	-- -D warnings

fix-lint-rinf:
	cargo +nightly clippy \
    	--workspace \
    	# --bin "rinf" \
    	--lib \
    	--tests \
    	--benches \
    	--features "$(FEATURES)" \
    	--fix \
    	--allow-staged \
    	--allow-dirty \
    	-- -D warnings

fix-lint-other-targets:
	cargo +nightly clippy \
    	--workspace \
    	--lib \
    	--tests \
    	--benches \
    	--all-features \
    	--fix \
    	--allow-staged \
    	--allow-dirty \
    	-- -D warnings
