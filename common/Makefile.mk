# Constants
DOCKERFILE=Dockerfile
DEPLOYFILE=deploy.sh
CONTAINER_PREFIX=lofar
SRC_DIR=../../../common

# Routines
include ${SRC_DIR}/routines-common.mk
include ${SRC_DIR}/routines-docker.mk
include ${SRC_DIR}/routines-script.mk

# Rules
include ${SRC_DIR}/rules.mk
