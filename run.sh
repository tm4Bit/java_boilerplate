#!/usr/bin/env bash

# =============================================================================
# Script to Compile and Run Java Application
#
# This script automates the process of compiling Java source files and running
# 1. Cleans up the previous build directory (bin).
# 2. Compiles all Java source files found in the 'src' directory.
# 3. Runs the compiled Java application.
#
# Written by tm4Bit - 23.07.2025
# =============================================================================

# --- Configuration ---
# Directory containing the Java(.java) source files.
SRC_DIR="src"
# Directory where compiled classes (.class) will be placed.
BIN_DIR="bin"
# Main class to be executed, which contains the main() method.
MAIN_CLASS="application.Main"

# --- Color Definitions ---
# Define colors for terminal output
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

# --- Script Execution ---
set -e

function timestamp() {
	date +"%Y-%m-%d %H:%M:%S.$(awk "BEGIN {print $(date +%N) / 1000000 }")"
}

function print_error() {
	echo -e "${BOLD_RED}Error: $1${NC}"
	echo -e "${BOLD_YELLOW}Please check the source files and try again.${NC}"
	exit 1
}

function print_header() {
	local header_text="$1"
	echo -e "${YELLOW}==========================================${NC}"
	echo -e "${BOLD_GREEN}${header_text}${NC}"
	echo -e "${YELLOW}==========================================${NC}"
}

clear
print_header " Compilando e Executando Aplicação Java "

echo -e "${BOLD}[$(timestamp)]${NC} ${GREEN}  ${YELLOW}Cleaning up previous build directory: ${BOLD_BLUE}$BIN_DIR${NC}"
rm -rf "$BIN_DIR"
mkdir -p "$BIN_DIR"
echo -e "${BOLD}[$(timestamp)]${NC} ${GREEN}  ${YELLOW}Build directory cleaned and created: ${BOLD_BLUE}$BIN_DIR${NC}"

echo -e "${BOLD}[$(timestamp)]${NC} ${GREEN}  ${YELLOW}Compiling Java source files from: ${BOLD_BLUE}$SRC_DIR${NC}"

START_TIME_NANOS=$(date +%s%N) # Get current time in nanoseconds

# -d "$BIN_DIR": specifies the destination directory for compiled classes.
# -sourcepath "$SRC_DIR": specifies the source path for the Java compiler.
# $(find "$SRC_DIR" -name "*.java"): Finds all Java source files in the 'src' directory.
javac -d "$BIN_DIR" -sourcepath "$SRC_DIR" $(find "$SRC_DIR" -name "*.java")

END_TIME_NANOS=$(date +%s%N) # Get end time in nanoseconds
TOTAL_TIME_NANOS=$((END_TIME_NANOS - START_TIME_NANOS))

echo -e "${BOLD}[$(timestamp)]${NC} ${GREEN}  ${YELLOW}Compilation completed successfully in ${BOLD_GREEN}$(awk "BEGIN {print ${TOTAL_TIME_NANOS} / 1000000 }") ms${YELLOW}!${NC}\n"

print_header " Executing application "

echo -e "${BOLD}[$(timestamp)]${NC} ${GREEN}  ${YELLOW}Running the application with main class: ${BOLD_BLUE}$MAIN_CLASS${NC}"

echo -e "\n${BOLD}-------------------------------------------------------------------${NC}\n"

START_TIME_NANOS=$(date +%s%N) # Get current time in nanoseconds

# -cp "$BIN_DIR": Define the classpath to include the compiled classes in the 'bin' directory.
java -cp "$BIN_DIR" "$MAIN_CLASS"

END_TIME_NANOS=$(date +%s%N) # Get end time in nanoseconds
TOTAL_TIME_NANOS=$((END_TIME_NANOS - START_TIME_NANOS))

echo -e "\n${BOLD}-------------------------------------------------------------------${NC}\n"

echo -e "${BOLD}[$(timestamp)]${NC} ${GREEN}  ${YELLOW}Application executed successfully in ${BOLD_GREEN}$(awk "BEGIN {print ${TOTAL_TIME_NANOS} / 1000000 }") ms${YELLOW}!${NC}\n"
