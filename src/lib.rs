use git2::Repository;
use std::error::Error;
use std::fs;






pub const GIT_HARDHAT_JS: &str = "https://github.com/mudgen/diamond-3-hardhat.git";
pub const GIT_HARDHAT_TS: &str = "https://github.com/Timidan/diamond-3-hardhat-typechain.git";
pub const GIT_FOUNDRY_HARDHAT: &str = "https://github.com/Timidan/Foundry-Hardhat-Diamonds.git";
pub const GIT_FOUNDRY: &str = "https://github.com/FydeTreasury/Diamond-Foundry.git";

pub const GIT_MOD_FOUNDRY: &str = "https://github.com/developeruche/modularized-diamond-structure-foundry";
pub const GIT_MOD_FOUNDRY_HARDHAT: &str = "https://github.com/developeruche/modularized-diamond-structure-foundry";
pub const GIT_MOD_HARDHAT: &str = "https://github.com/developeruche/modularized-diamond-stucture-hardhat";




pub enum Template {
    HardhatJS, // hardatjs | hjs
    HardhatTs, // hardatts | hts
    HardhatFoundry, // hardatfoundry | hf
    Foundry // foundry | f
}


pub struct Config {
    pub command: String,
    pub project_name: String,
    pub template: Template,
    pub isModular: bool,
    pub raw: Vec<String>
}

impl Config {
    pub fn new(args: Vec<String>) -> Config {
        // Check if the number of args is correct
        if args.len() < 3 {
            panic!("not enough arguments");
        }
         let is_modular_flag = String::from("--modular");
         let template_flag = String::from("--template");

        // Extracting the args from env::args
        let command = args[1].clone();
        let project_name = args[2].clone();
        let is_modular = args.contains(&is_modular_flag);
        let template_name: String;

        if command != "init" {
            panic!("command not found");
        }

        if project_name == "" {
            panic!("project name not found");
        }

        if args.contains(&template_flag) {
            // get the index of the template flag
            let index = args.iter().position(|r| r == "--template").unwrap();
            
            if let Some(value) = args.get(index + 1) {
                if value == &String::from("") {
                    panic!("bad template name");
                }
                
                template_name = value.clone();
            } else {
                panic!("template name not found");
            }

            match template_name.as_str() {
                "hardhatjs" | "hjs" => {
                    return Config { command, project_name, template: Template::HardhatJS, isModular: is_modular, raw: args.clone() };
                },
                "hardhatts" | "hts" => {
                    return Config { command, project_name, template: Template::HardhatTs, isModular: is_modular, raw: args.clone() };
                },
                "hardhatfoundry" | "hf" => {
                    return Config { command, project_name, template: Template::HardhatFoundry, isModular: is_modular, raw: args.clone() };
                },
                "foundry" | "f" => {
                    return Config { command, project_name, template: Template::Foundry, isModular: is_modular, raw: args.clone() };
                },
                _ => {
                    panic!("template not found");
                }
            }
            
        }
        // Return the Config struct
        Config { command, project_name, template: Template::HardhatJS, isModular: false, raw: args.clone()}
    }
}




pub fn pull(config: &Config) -> Result<(), git2::Error> {
    

    match config.template {
        Template::Foundry => {
            if config.isModular {
                Repository::clone(GIT_MOD_FOUNDRY, config.project_name.clone())?;
            } else {
                Repository::clone(GIT_FOUNDRY, config.project_name.clone())?;
            }
        }
        Template::HardhatFoundry => {
            if config.isModular {
                Repository::clone(GIT_MOD_FOUNDRY_HARDHAT, config.project_name.clone())?;
            } else {
                Repository::clone(GIT_FOUNDRY_HARDHAT, config.project_name.clone())?;
            }
        }
        Template::HardhatJS => {
            if config.isModular {
                Repository::clone(GIT_MOD_HARDHAT, config.project_name.clone())?;
            } else {
                Repository::clone(GIT_HARDHAT_JS, config.project_name.clone())?;
            }
        }
        Template::HardhatTs => {
            if config.isModular {
                Repository::clone(GIT_MOD_HARDHAT, config.project_name.clone())?;
            } else {
                Repository::clone(GIT_HARDHAT_TS, config.project_name.clone())?;
            }
        }
    }



    let _git_path = format!("{}/.git", config.project_name);
    fs::remove_dir_all(_git_path).unwrap();

    println!("Happy hacking !!!");
    Ok(())
}



