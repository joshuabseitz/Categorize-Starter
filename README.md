
# Categorize Starter

This is a starter project for the Categorize app, including Firebase Authentication with Apple Sign-In functionality. This project serves as a boilerplate to help you quickly set up the necessary infrastructure for user authentication and transaction categorization.

## Features

- Apple Sign-In for user authentication
- Firebase for user data storage
- SwiftUI interface

## Requirements

- Xcode 12 or later
- iOS 14 or later
- Firebase account

## Setup

### 1. Clone the Repository

```sh
git clone https://github.com/your-username/Categorize-Starter.git
cd Categorize-Starter
```

### 2. Configure Firebase

1. Go to the [Firebase Console](https://console.firebase.google.com/).
2. Create a new project.
3. Add an iOS app to your Firebase project.
4. Download the `GoogleService-Info.plist` file and add it to your Xcode project under the `Categorize` directory.
5. Enable Firebase Authentication in the Firebase Console.
6. Add the "Sign in with Apple" provider.

### 3. Configure Apple Sign-In

#### App ID Configuration

1. Go to the [Apple Developer Portal](https://developer.apple.com/account/).
2. Select "Certificates, Identifiers & Profiles."
3. Under "Identifiers," select your App ID or create a new one.
4. Ensure that the "Sign In with Apple" capability is enabled.
5. Click "Edit" and configure the "Sign In with Apple" settings. Ensure that the primary App ID is selected.

#### Xcode Project Configuration

1. Open your Xcode project.
2. Select your project in the Project Navigator.
3. Go to the "Signing & Capabilities" tab.
4. Click the "+" button and add the "Sign In with Apple" capability.
5. Ensure that your provisioning profile is updated with the new capability.

### 4. Configure URL Schemes

1. Open your `Info.plist` file.
2. Add the following URL scheme configuration:

```xml
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleTypeRole</key>
        <string>Editor</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>$(PRODUCT_BUNDLE_IDENTIFIER)</string>
        </array>
    </dict>
</array>
```

### 5. Install Dependencies

Ensure you have CocoaPods installed and then run:

```sh
pod install
```

### 6. Set Up .gitignore

Ensure that the `.gitignore` file is in the root of your project with the following contents:

```plaintext
# Xcode
.DS_Store
*/.DS_Store
*.swp
*.lock
.profile
*.mode1
*.mode1v3
*.mode2v3
*.pbxuser
!default.mode1v3
!default.mode2v3
!default.pbxuser
*.perspectivev3
xcuserdata
*.xccheckout
*.moved-aside
*.xcuserstate
DerivedData
.idea/
*.hmap
*.ipa
*.dSYM.zip
*.dSYM
*.xcodeproj/**
!*.xcodeproj/project.pbxproj
!*.xcodeproj/xcshareddata/xcschemes/*.xcscheme
!*.xcworkspace/contents.xcworkspacedata
!*.xcworkspace/xcshareddata/*
*.xcworkspace/*
*.xcworkspace/contents.xcworkspacedata

# Swift Package Manager
.build/
Packages
Package.pins
Package.resolved
.build/

# CocoaPods
Pods/
Podfile.lock
Podfile
!.gitignore

# Carthage
Carthage/Build/

# Accio dependency manager
accio/

# fastlane
fastlane/report.xml
fastlane/Preview.html
fastlane/screenshots/**/*.png
fastlane/test_output
fastlane/test_output/**/*.junit
.fastlane/

# Firebase
GoogleService-Info.plist

# Node.js
node_modules/
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# Build generated
.build/
bin/
obj/
*.dll
*.exe
*.so
*.dylib
*.class
*.war
*.jar
*.pyc
*.pyo
*.pyd
*.class
*.psd

# Logs
*.log

# Secrets
.env

# SwiftUI previews
.swiftpm/xcode/xcshareddata/xcschemes

# Temporary files
*.tmp
*.temp

# Others
.vscode/
*.bak
*.old
*.swp
*.log
*.swo
*.orig
*.rej
*.rej$
*.sublime-project
*.sublime-workspace
*.tmproj
```

### 7. Running the App

1. Open your Xcode project.
2. Build and run the app on a simulator or device.
3. Use the Apple Sign-In button to sign in with your Apple ID.

### 8. Future Plans

- Integrate Plaid for transaction import.
- Use encrypted iCloud/Core Data for enhanced security.
- Implement transaction categorization and management features.

### 9. Contributing

Contributions are welcome! Please submit a pull request or open an issue to discuss any changes or improvements.

### 10. License

This project is licensed under the MIT License. See the LICENSE file for details.
