#!/bin/bash
set -ex

./setup_git_crypt.sh
openssl aes-256-cbc -K $encrypted_cafca427fc2f_key -iv $encrypted_cafca427fc2f_iv -in git-crypt-android-certificates.key.enc -out git-crypt-android-certificates.key -d
git clone https://github.com/Sage-Bionetworks/android-certificates ../android-certificates
pushd ../android-certificates
/tmp/git-crypt-ccdcc76f8e1a639847a8accd801f5a284194e43f/git-crypt unlock $TRAVIS_BUILD_DIR/git-crypt-android-certificates.key
popd
bundle exec fastlane internal alias:"$KEY_ALIAS" storepass:"$KEYSTORE_PASSWORD" keypass:"$KEY_PASSWORD" signed_apk_path:"app/build/outputs/apk/app-internal-release.apk"

exit $?
