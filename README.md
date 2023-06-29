# miana
This is a boilerplate-creating tool for diamond standard, it covers diamond standard with Hardhat(JavaScript), Hardhat(Type Script), Foundry, Foundry + Hardhat and the Modular flavour of all this code base. 

## How to use miana 
First things first, you need to install miana;

```
  cargo install miana
```

Miana has about 7 templates you can choose from 

```rust

pub const GIT_HARDHAT_JS: &str = "https://github.com/mudgen/diamond-3-hardhat.git";
pub const GIT_HARDHAT_TS: &str = "https://github.com/Timidan/diamond-3-hardhat-typechain.git";
pub const GIT_FOUNDRY_HARDHAT: &str = "https://github.com/Timidan/Foundry-Hardhat-Diamonds.git";
pub const GIT_FOUNDRY: &str = "https://github.com/FydeTreasury/Diamond-Foundry.git";
pub const GIT_MOD_FOUNDRY: &str = "https://github.com/developeruche/modularized-diamond-structure-foundry";
pub const GIT_MOD_FOUNDRY_HARDHAT: &str = "https://github.com/developeruche/modularized-diamond-structure-foundry";
pub const GIT_MOD_HARDHAT: &str = "https://github.com/developeruche/modularized-diamond-stucture-hardhat";

```

## Creating a Diamond Standard project 
Creating a the Diamond Standard project uses different flags to determine the exact type of project to scafold (hardhat typescript: hts, hardhat javascript: hjs, foundry: f)

`--modular` makes the project come with a special modular structure.

Examples:

1. Hardhat Typescript:
```sh
  miana init project_name --template hts
```

2. Hardhat JavaScript:
```sh
  miana init project_name --template hjs
```

3. Foundry:
```sh
  miana init project_name --template f
```

4. Modular Hardhat TypeScript:
```sh
  miana init project_name --template hts --modular
```

5. Modular Foundry:
```sh
  miana init project_name --template f --modular
```

### --template 

Here are more details on the templates

```
pub enum Template {
    HardhatJS, // hardatjs | hjs
    HardhatTs, // hardatts | hts
    HardhatFoundry, // hardatfoundry | hf
    Foundry // foundry | f
}
```

### --modular 

This is a flag you can pass in if you want a modular version of your selected template 
