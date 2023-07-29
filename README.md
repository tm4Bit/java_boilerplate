<img 
  src="https://inforchannel.com.br/wp-content/uploads/2021/03/e2d2f80e-java-logo-1-1024x573.png" 
  alt="" 
  style="display: block; height: 150px; width:300px; margin: 0 auto"
/>

## Getting Started

This is a Java project template. Here is a guideline to help you get started to write Java code with just Neovim and the command line.

> If you're using jdtls remember to `git init`, so the language server could attach the buffer.

## Folder Structure

The workspace contains three folders by default, where:

- `src`: the folder to maintain sources
- `lib`: the folder to maintain dependencies
- `bin`: the folder where the bitcode is added when you run the java compiler(javac)

> If you want to customize the folder structure, just remember to adapter the command to compile and run the application.

### Class Template

* E.g. entities 

|         Class              |
|----------------------------|
| — Property: type           |
| — Property: type           |
| + method(): return         |
| + method(): reuturn        |

* E.g. service

|         Class              |
|----------------------------|
| — Property: type           |
| — Property: type           |
| + method(): return         |
| + method(): reuturn        |

## Command to run the application 

```sh
# First cd to the bin folder
~/project $ cd bin

# then run  the following command to compile and run the application
~/project/bin $ ../ && clear && javac -d bin src/**/*.java && cd bin && java application.Main
```
