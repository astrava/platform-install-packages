#!/bin/bash -e 
#===============================================================================
#          FILE: package_kaltura_web.sh
#         USAGE: ./package_kaltura_web.sh 
#   DESCRIPTION: 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Jess Portnoy (), <jess.portnoy@kaltura.com>
#  ORGANIZATION: Kaltura, inc.
#       CREATED: 01/10/14 08:46:43 EST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
SOURCES_RC=`dirname $0`/sources.rc
if [ ! -r $SOURCES_RC ];then
	echo "Could not find $SOURCES_RC"
	exit 1
fi
. $SOURCES_RC 
if [ ! -x `which svn 2>/dev/null` ];then
	echo "Need to install svn."
	exit 2
fi

for KDP3_VERSION in $KDP3_VERSIONS;do
	svn export --force --quiet $KDP3_URI/$KDP3_VERSION $SOURCE_PACKAGING_DIR/$KDP3_RPM_NAME/$KDP3_VERSION 
done
cd $SOURCE_PACKAGING_DIR
tar jcf $RPM_SOURCES_DIR/$KDP3_RPM_NAME.tar.bz2 $KDP3_RPM_NAME
echo "Packaged into $RPM_SOURCES_DIR/$KDP3_RPM_NAME.tar.bz2"
rpmbuild -ba $RPM_SPECS_DIR/$KDP3_RPM_NAME.spec
