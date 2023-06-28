use std::fs;
use std::error::Error;

enum Template {
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
    pub raw: [String]
}

impl Config {
    pub fn new(args: &[String]) -> Result<Config, &str> {
        // Check if the number of args is correct
        if args.len() < 3 {
            return Err("not enough arguments");
        }

        // Extracting the args from env::args
        let command = args[1].clone();
        let project_name = args[2].clone();
        let is_modular = args.contains("--modular");

        if command != "init" {
            return Err("command not found");
        }

        if project_name == "" {
            return Err("project name not found");
        }

        if args.contains("--template") {
            // get the index of the template flag
            let index = args.iter().position(|r| r == "--template").unwrap();
            
            // check if the template name is empty
            if args[index + 1] == "" {
                return Err("template name not found");
            }

            // get the template name
            let template_name = args[index + 1].clone();

            match template_name.as_str() {
                "hardatjs" | "hjs" => {
                    return Ok(Config { command, project_name, template: Template::HardhatJS, isModular: is_modular, raw: args.clone() });
                },
                "hardatts" | "hts" => {
                    return Ok(Config { command, project_name, template: Template::HardhatTs, isModular: is_modular, raw: args.clone() });
                },
                "hardatfoundry" | "hf" => {
                    return Ok(Config { command, project_name, template: Template::HardhatFoundry, isModular: is_modular, raw: args.clone() });
                },
                "foundry" | "f" => {
                    return Ok(Config { command, project_name, template: Template::Foundry, isModular: is_modular, raw: args.clone() });
                },
                _ => {
                    return Err("template not found");
                }
            }
            
        }
        // Return the Config struct
        Ok(Config { command, project_name, template: HardhatJS, isModular: false, raw: args.clone() })
    }
}




pub fn pull(config: Config) -> Result<(), Box<dyn Error>> { // the error type would be determined at run-time
    let contents = fs::read_to_string(config.filename)?;

    println!("With text:\n{}", contents);

    Ok(())
}



