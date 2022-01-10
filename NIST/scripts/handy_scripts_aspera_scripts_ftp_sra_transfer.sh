#!/usr/bin/sh
## Script to recursively download or upload files from GIAB ftp site or SRA using aspera

####################################################
## USAGE & HELP MESSAGES
####################################################
## Usage message assignment
display_usage() { 
    echo "USAGE: "
    echo "bash ftp_sra_transfer.sh -m download|upload -r ftp|sra -d /path/to/remote/dir/ -l /path/to/local/dir/ "
    echo ""
    echo ""
    echo "NOTE: Flag -d is optional when uploading. When ftp is selected"
    echo "for -r the default upload directory is "
    echo "asp-sra@upload.ncbi.nlm.nih.gov:GIAB-incoming/NIST/"
    echo "When sra is selected for -r the default upload directory is"
    echo "subasp@upload.ncbi.nlm.nih.gov:uploads/"
    echo ""
    echo ""
    echo "NOTE: When providing path to -d, path begins at /ReferenceSamples"
    echo ""
    echo ""
    echo "NOTE: The following global keys must be set-"
    echo "Environmental variable [ASPERA_OPENKEY=] in bash profile must be set with Aspera openssh or pUTTY"
    echo "Environmental variable [GIAB_FTPKEY=] in bash profile must be set: Validated GIAB ftp rsa key"
    echo "See README for more details."
    echo ""
    echo "Please NOTE that flags and accepted params are case-sensitive at this time."
    }

## TRIGGER USAGE/HELP MESSAGE
## if less than two arguments supplied, display usage 
if [  $# -le 1 ]; then 
    display_usage
    exit 1
fi 
## check whether user had supplied -h or --help . If yes display usage 
if [[ ( $# == "--help") ||  $# == "-h" ]]; then 
    display_usage
    exit 0
fi

####################################################
## GATHER COMMANDS & ASSIGN VARS
####################################################
## FILE TRANSFER SPEED
l=200m
## COLLECT FLAGS
while getopts m:r:d:l: flag
do 
    case "${flag}" in 
        ## USER SELECTED UPLOAD OR DOWNLOAD
        m) MODE=${OPTARG};;
        ## REMOTE DATABASE - either SRA or FTP (GIAB FTP)
        r) REMOTE=${OPTARG};;
        ## SUBDIRECTORY OR FILE
        d) REMOTEDIR=${OPTARG};;
        ## LOCAL DESTINATION/SOURCE
        l) LOCALDIR=${OPTARG};;
        *) echo "Invalid option: -$flag" ;;
    esac
done 

####################################################
## MODE/REMOTE FLAG CHECK
####################################################
## If the MODE or REMOTE flags are not selected 
## properly, throw error message and quit.
if [[ "$MODE" != "download" && "$MODE" != "upload" ]]; then
    echo "Invalid option: -m MODE must be 'download' or 'upload'"
    exit 2
fi

if [[ "$REMOTE" != "sra" &&  "$REMOTE" != "ftp" ]]; then 
    echo "Invalid option: -r REMOTE must be 'sra' or 'ftp'"
    exit 2
fi

####################################################
## GLOBAL KEY CHECK
####################################################
## CHECK FOR MISSING ASPERA KEY GLOBAL VAR
if [ "$ASPERA_OPENKEY" == "" ]; then 
    echo "Environmental variable in bash profile must be set: Aspera openssh or pUTTY"
    exit 2 
fi
## CHECK FOR MISSING GIAB FTP KEY GLOBAL VAR
if [ "$GIAB_FTPKEY" == "" ]; then 
    echo "Environmental variable in bash profile must be set: Validated GIAB ftp rsa key"
    exit 2 
fi

####################################################
## ASSIGN VARS BASED ON MODE/REMOTE FLAG SELECTION
####################################################
## Assign variables based on selected MODE and REMOTE
## for aspera command below
if [ "$MODE" == "download" ] && [ "$REMOTE" == "ftp" ]; then
    ## FTP DOWNLOAD COMMAND ARGUMENTS
    KEY=${ASPERA_OPENKEY}
    SOURCE=anonftp@ftp-trace.ncbi.nlm.nih.gov:${REMOTEDIR}

    ## IF NO LOCAL DESTINATION DIR SPECIFIED
    ## USE CURRENT WORKING DIRECTORY
    if [[ -z ${LOCALDIR} ]]; then
        DEST=$PWD
    else
        DEST=${LOCALDIR}
    fi

elif [ "$MODE" == "download" ] && [ "$REMOTE" == "sra" ]; then
    ## SRA DOWNLOAD COMMAND ARGUMENTS
    KEY=${ASPERA_OPENKEY}
    SOURCE=anonftp@ftp.ncbi.nlm.nih.gov:${REMOTEDIR}

    ## IF NO LOCAL DESTINATION DIR SPECIFIED
    ## USE CURRENT WORKING DIRECTORY
    if [[ -z ${LOCALDIR} ]]; then
        DEST=$PWD
    else
        DEST=${LOCALDIR}
    fi

elif [ "$MODE" == "upload" ] && [ "$REMOTE" == "ftp" ]; then
    ## FTP UPLOAD COMMAND ARGUMENTS
    KEY=${GIAB_FTPKEY}
    SOURCE=${LOCALDIR}
    DEST=asp-sra@upload.ncbi.nlm.nih.gov:GIAB-incoming/NIST/${REMOTEDIR}

elif [ "$MODE" == "upload" ] && [ "$REMOTE" == "sra" ]; then

    echo "untested"
    ## SRA UPLOAD COMMAND ARGUMENTS
    KEY=${ASPERA_OPENKEY}
    SOURCE=${LOCALDIR}
    DEST=subasp@upload.ncbi.nlm.nih.gov:uploads/

else 
    echo "Invalid options: MODE and REMOTE combination - this error is not expected!!!!"
    exit 2   
fi

####################################################
## EXECUTE ASPERA COMMAND
####################################################
## Running transfer command
ascp \
    -i ${KEY} \
    -QTr \
    -k2 \
    -l${l} \
    ${SOURCE} \
    ${DEST}