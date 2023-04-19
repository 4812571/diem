#![no_main]

use libfuzzer_sys::fuzz_target;
use ir_to_bytecode::parser::parse_script;
use move_symbol_pool::Symbol;

fuzz_target!(|data: &[u8]| {
    let source = String::from_utf8_lossy(data);
    let symbol = Symbol::from("fuzz");
    let _ = parse_script(symbol, &source);
});