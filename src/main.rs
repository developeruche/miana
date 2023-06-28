use std::{process, env};
use miner::Config;

fn main() {
    let args = env::args().collect::<Vec<String>>();

    let config = Config::new(args);


    println!("command: {:?}", config);
}
