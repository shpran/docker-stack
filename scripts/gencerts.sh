#!/usr/bin/env bash

# >>>==================== COLOR DEFINITIONS ====================

RED='\033[1;31m'
GREEN='\033[0;32m'
BROWN='\033[0;33m'
BLUE='\033[1;34m'
PINK='\033[0;35m'
NC='\033[0m'

# <<<==================== END OF COLOR DEFINITIONS ====================

# >>>==================== CHECK FOR THE REQUIREMENTS ====================

echo -e "
${BROWN}====================>>> Step 1: Requirements verification <<<====================

${PINK}Checking for mkcert installation...${NC}
"

mkcert --version 2>&1 >/dev/null
MKCERT_IS_AVAILABLE=$?

if [[ $MKCERT_IS_AVAILABLE -ne 0 ]]; then
    echo -e "
${RED}mkcert is not installed! Aborting...${NC}
${BLUE}Follow the steps below to install mkcert: https://github.com/FiloSottile/mkcert#installation${NC}
";
    exit;
fi

echo -e "${GREEN}OK!
${PINK}Looking for ssl folder...${NC}"

SSL_FOLDER=$(dirname $0)/../config/ssl

if [[ ! -d ${SSL_FOLDER} ]]; then
    echo -e "${RED}ssl folder ${SSL_FOLDER} does not exist! Aborting...${NC}";
    exit;
fi

echo -e "${GREEN}OK!${NC}"

# <<<==================== END OF CHECK FOR THE REQUIREMENTS ====================

# >>>==================== GENERATING CERTIFICATES ====================

echo -e "
${BROWN}====================>>> Step 2: Certificates <<<====================

${PINK}Generating...${NC}
"

cd $SSL_FOLDER;
mkcert "*.docker.loc";
mkcert -install;
cd -;

echo -e "${GREEN}Done!${NC}"

# <<<==================== END OF GENERATING CERTIFICATES ====================
