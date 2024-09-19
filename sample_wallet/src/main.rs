use std::path::PathBuf;

use bdk::bitcoin::Network;
use bdk::Wallet;
use clap::Parser;

#[derive(PartialEq, Clone, Debug, Parser)]
#[clap(version = option_env!("CARGO_PKG_VERSION").unwrap_or("unknown"))]
pub struct Args {
    /// Network to use (e.g. mainnet, testnet, signet, regtest)
    #[clap(
        name = "NETWORK",
        short = 'n',
        long = "network",
        default_value = "regtest",
    )]
    pub network: Network,

    /// Wallet descriptor
    #[clap(
        name = "DESCRIPTOR",
        short = 'd',
        long = "descriptor",
    )]
    pub descriptor: String,

    #[clap(
        name = "CHANGE_DESCRIPTOR",
        short = 'c',
        long = "change_descriptor",
    )]
    pub change_descriptor: String,
    /// RPC URL
    #[clap(name = "RPC_URL", long, default_value = "127.0.0.1:8332")]
    pub url: String,
    /// RPC auth cookie file
    #[clap(name = "RPC_COOKIE", long)]
    pub rpc_cookie: Option<PathBuf>,
    /// RPC auth username
    #[clap(name = "RPC_USER", long)]
    pub rpc_user: Option<String>,
    /// RPC auth password
    #[clap(name = "RPC_PASS", long)]
    pub rpc_pass: Option<String>,
}

fn main() {
    let mempool_signet_api = "https://mempool.space:60602";
    let args = Args::parse();

    let wallet = Wallet::new(descriptor, change_descriptor, network, database)

    println!("Hello, world!");
}
