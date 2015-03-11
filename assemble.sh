#!/bin/bash
scriptDir="${SCRIPT_DIR}"
tmpDir="${scriptDir}/tmp"
mkdir -p "${scriptDir}"

smarkdownVersion="${SMARKDOWN_VERSION}"
echo "smarkdownVersion=${smarkdownVersion}"
libDir="${SMARKDOWN_LIB_DIR}"
echo "libDir=${libDir}"
modulesFile="${SMARKDOWN_MODULES_FILE}"
echo "modulesFile=${modulesFile}"
declare -a modules
readarray -t modules < "${modulesFile}"

echo "Downloading modules"
for m in "${modules[@]}"; do
	if [[ $m == \#* ]]; then
		echo "Skipping line: ${m}"
	else
		echo "Downloading module ${m}"
		url="https://repo1.maven.org/maven2/com/java-adventures/smarkdown/${m}/${smarkdownVersion}/${m}-${smarkdownVersion}.jar"
		echo "url=${url}"
		curl ${url} -o "${libDir}/${m}.jar"
	fi
done

echo "Installing thirdparty stuff"
${SMARKDOWN_THIRDPARTY_FILE}

echo "WAR file content"
find $SMARKDOWN_APP_DIR 

cd $SMARKDOWN_APP_DIR && jar -cf /opt/jboss/wildfly/standalone/deployments/smarkdown.war *