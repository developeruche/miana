use std::fs;
use std::error::Error;

#[derive(Debug)]
pub enum Template {
    HardhatJS, // hardatjs | hjs
    HardhatTs, // hardatts | hts
    HardhatFoundry, // hardatfoundry | hf
    Foundry // foundry | f
}


#[derive(Debug)]
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




pub fn pull(config: Config) -> Result<(), Box<dyn Error>> { // the error type would be determined at run-time
    todo!("pull command not implemented yet");  
}



