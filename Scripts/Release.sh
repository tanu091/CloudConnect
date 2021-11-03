######################
# Options
######################

REVEAL_ARCHIVE_IN_FINDER=false

FRAMEWORK_NAME="${PROJECT_NAME}"
#STEP 1 Getting framwork name same as target name .
echo 👍 1 Building framework  ${PROJECT_NAME} for Universal

SIMULATOR_LIBRARY_PATH="${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/${FRAMEWORK_NAME}.framework"

DEVICE_LIBRARY_PATH="${BUILD_DIR}/${CONFIGURATION}-iphoneos/${FRAMEWORK_NAME}.framework"

UNIVERSAL_LIBRARY_DIR="Universal"

Destination_Path="${UNIVERSAL_LIBRARY_DIR}/${FRAMEWORK_NAME}.framework"


######################
# Build Frameworks
######################

# Build Frameworks

xcodebuild -target "${PROJECT_NAME}" -scheme "${PROJECT_NAME}" -sdk iphonesimulator -configuration ${CONFIGURATION} OBJROOT="${OBJROOT}/DependentBuilds" EXCLUDED_ARCHS="arm64"

xcodebuild -target "${PROJECT_NAME}" -scheme "${PROJECT_NAME}" -sdk iphoneos -configuration ${CONFIGURATION}  OBJROOT="${OBJROOT}/DependentBuilds"

######################
# Create directory for universal
######################

rm -rf "${UNIVERSAL_LIBRARY_DIR}"

mkdir "${UNIVERSAL_LIBRARY_DIR}"

mkdir "${FRAMEWORK}"


######################
# Copy files Framework
######################

cp -r "${DEVICE_LIBRARY_PATH}/." "${Destination_Path}"


######################
# Make an universal binary
######################

lipo "${SIMULATOR_LIBRARY_PATH}/${FRAMEWORK_NAME}" "${DEVICE_LIBRARY_PATH}/${FRAMEWORK_NAME}" -create -output "${Destination_Path}/${FRAMEWORK_NAME}"

echo 👍 8 Belew commands will merge Simulator and Device Library swift module and create fat library, which we can use debug on device and Simulator

cp -r "${SIMULATOR_LIBRARY_PATH}/Modules/${FRAMEWORK_NAME}.swiftmodule/" "${Destination_Path}/Modules/${FRAMEWORK_NAME}.swiftmodule/"

echo ⛳✅ 9 Created Universal Lib at path:- ${Destination_Path}.

exit 0
