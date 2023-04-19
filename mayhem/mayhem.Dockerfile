# Build Stage
FROM ghcr.io/evanrichter/cargo-fuzz:latest AS builder

# Add source code to the build stage.
ADD . /src
WORKDIR /src

# Compile the fuzzers.
RUN cd language/compiler/ir-to-bytecode && cargo +nightly fuzz build

# Package stage
FROM ubuntu:latest

# Copy the compiled fuzzers to the final image.
COPY --from=builder /src/language/compiler/ir-to-bytecode/fuzz/target/x86_64-unknown-linux-gnu/release/fuzz_* /fuzzers/
