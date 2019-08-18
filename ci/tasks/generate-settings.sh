#!/bin/bash

set -o errexit
set -o errtrace
set -o pipefail

# synopsis {{{
# Generates settings.xml and gradle.properties#
#
# }}}

[[ -z "${M2_HOME}" ]] && M2_HOME="${HOME}/.m2"
[[ -z "${M2_CACHE}" ]] && M2_CACHE="${ROOT_FOLDER}/maven"
[[ -z "${GRADLE_HOME}" ]] && GRADLE_HOME="${HOME}/.gradle"
[[ -z "${GRADLE_CACHE}" ]] && GRADLE_CACHE="${ROOT_FOLDER}/gradle"

echo "Generating symbolic links for caches"

[[ -d "${M2_CACHE}" && ! -d "${M2_HOME}" ]] && ln -s "${M2_CACHE}" "${M2_HOME}"

echo "Writing maven settings to [${M2_HOME}/settings.xml]"

cat > "${M2_HOME}/settings.xml" <<EOF

<?xml version="1.0" encoding="UTF-8"?>
<settings>
	<servers>
		<server>
			<id>\${M2_SETTINGS_REPO_ID}</id>
			<username>\${M2_SETTINGS_REPO_USERNAME}</username>
			<password>\${M2_SETTINGS_REPO_PASSWORD}</password>
		</server>
	</servers>
</settings>


EOF
echo "Settings xml written"
