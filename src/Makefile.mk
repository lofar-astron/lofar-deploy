# Constants
DOCKERFILE=Dockerfile
OS=`basename ${PWD}`
IMAGE_PREFIX=test
SRC_DIR=../src

# Routines
include ${SRC_DIR}/routines-common.mk
include ${SRC_DIR}/routines-docker.mk

# Rules
include ${SRC_DIR}/rules.mk
