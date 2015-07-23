# Constants
DOCKERFILE=Dockerfile
DEPLOYFILE=deploy.sh
OS=`basename ${PWD}`
IMAGE_PREFIX=test
SRC_DIR=../src

# Routines
include ${SRC_DIR}/routines-common.mk
include ${SRC_DIR}/routines-docker.mk
include ${SRC_DIR}/routines-script.mk

# Rules
include ${SRC_DIR}/rules.mk
