use std::{env};
use miana::{Config, pull};

fn main() {
    let args = env::args().collect::<Vec<String>>();
    let config = Config::new(args);
    pull(&config).unwrap();
}
