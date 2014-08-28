#! /bin/bash
xcodebuild -workspace ObjcModelValidation.xcworkspace -scheme ObjcModelValidation -sdk iphonesimulator -destination platform='iOS Simulator',OS=7.1,name='iPhone Retina (4-inch)' clean build test | xcpretty -tc
