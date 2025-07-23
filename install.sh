#!/usr/bin/env bash

# =============================================================================
# Installation Script for Java Kickstart Template
#
# This script automates the setup of a new Java project from the kickstart
# template. It performs the following actions:
# 1. Asks for a project name.
# 2. Clones the template repository from GitHub.
# 3. Removes the original .git directory to detach from the template's history.
# 4. Initializes a new, clean Git repository.
# 5. Removes this installation script.
# 6. Prints final instructions for the user.
#
# Usage:
# curl -sSL https://raw.githubusercontent.com/tm4Bit/java_boilerplate/master/install.sh | bash
#
# Written by tm4Bit - 23.07.2025
# =============================================================================

# --- Configuration ---
REPO_URL="https://github.com/tm4Bit/java_boilerplate.git"
DEFAULT_PROJECT_NAME="java-kickstart"

# --- Color Definitions ---
GREEN='\033[0;32m'
BOLD_GREEN='\033[1;32m'
YELLOW='\033[0;33m'
BOLD_YELLOW='\033[1;33m'
BLUE='\033[0;34m'
BOLD_BLUE='\033[1;34m'
RED='\033[0;31m'
BOLD_RED='\033[1;31m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# --- Helper Functions ---
set -e

function print_header() {
    local header_text="$1"
    echo -e "\n${YELLOW}=====================================================${NC}"
    echo -e "${BOLD_GREEN} $header_text ${NC}"
    echo -e "${YELLOW}=====================================================${NC}"
}

function print_error() {
    echo -e "${BOLD_RED}Error: $1${NC}"
    exit 1
}

# --- Main Execution ---

clear
print_header "🚀 Java Kickstart Project Setup 🚀"
echo -e -n "${BOLD}Enter your new project name [default: $DEFAULT_PROJECT_NAME]: ${NC}" > /dev/tty
read PROJECT_NAME < /dev/tty
PROJECT_NAME=${PROJECT_NAME:-$DEFAULT_PROJECT_NAME}

if ! command -v git &> /dev/null; then
    print_error "Git is not installed. Please install Git to continue."
fi

if [ -d "$PROJECT_NAME" ]; then
    print_error "Directory '$PROJECT_NAME' already exists. Please choose a different name or remove the existing directory."
fi

print_header "1. Cloning Template"
echo -e "${GREEN}Cloning repository from $REPO_URL into './$PROJECT_NAME'...${NC}"
git clone --depth=1 "$REPO_URL" "$PROJECT_NAME" > /dev/null 2>&1
cd "$PROJECT_NAME"
echo -e "${BOLD_GREEN}Template cloned successfully!${NC}"

print_header "2. Cleaning Up"
echo -e "${YELLOW}Removing install.sh...${NC}"
rm -- "install.sh"
echo -e "${YELLOW}Removing template's .git directory...${NC}"
rm -rf .git
echo -e "${BOLD_GREEN}Cleanup complete.${NC}"

print_header "3. Initializing New Repository"
echo -e "${GREEN}Initializing a fresh Git repository...${NC}"
git init > /dev/null 2>&1
git add . > /dev/null 2>&1
git commit -m "Initial commit from java-kickstart template" > /dev/null 2>&1
echo -e "${BOLD_GREEN}New Git repository created successfully.${NC}"

print_header "🎉 Project '$PROJECT_NAME' is Ready! 🎉"
echo -e "${BOLD}Your new Java project is set up and ready to go!${NC}"
echo ""
echo -e "Navigate to your project directory:"
echo -e "${BOLD_BLUE}  cd $PROJECT_NAME${NC}"
echo ""
echo -e "To compile and run your application, grant execution permission and run the script:"
echo -e "${BOLD_BLUE}  chmod +x run.sh${NC}"
echo -e "${BOLD_BLUE}  ./run.sh${NC}"
echo ""
echo -e "Happy coding! 💻"
