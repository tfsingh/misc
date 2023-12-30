use anyhow::{Context, Result};
use clap::Parser;
use std::io::{self, Write};

#[derive(Parser)]
struct Cli {
    query: String,
    path: std::path::PathBuf,
}

fn main() -> Result<()> {
    let args = Cli::parse();

    let content = std::fs::read_to_string(&args.path)
        .with_context(|| format!("couldn't read file `{}`", args.path.display()))?;

    let stdout = io::stdout().lock();
    let mut handle = io::BufWriter::new(stdout);

    for line in content.lines() {
        if line.contains(&args.query) {
            println!("{}", line);
        }
    }

    Ok(())
}
