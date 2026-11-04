# FieldTechy – iOS Application

## Overview

**FieldTechy** is a field service management application designed to simplify job management and communication between clients and field engineers.

The iOS application is developed using **Swift and UIKit**, providing a native iOS experience with an intuitive and user-friendly interface.

The application supports two primary user roles:

- **Client:** Create jobs, manage service requests, track job status, make payments, and communicate with engineers.
- **Engineer:** Manage assigned jobs, explore recommended opportunities, update job progress, manage earnings, and maintain their profile.

## Technology Stack

| Technology | Purpose |
|---|---|
| Swift | iOS application programming language |
| UIKit | Native iOS UI development |
| Storyboard / XIB | Interface design and screen management |
| Programmatic UI | Dynamic UI development |
| REST API | Backend communication |
| URLSession | Network communication |
| CocoaPods / Swift Package Manager | Dependency management |
| Git | Version control |
| Bitbucket / GitHub | Source code management |
| Xcode | iOS development and debugging |

## Application Modules

### 1. Client Module

- Client onboarding and authentication
- Client dashboard
- Create and post jobs
- Job payment and payment confirmation
- View and manage posted jobs
- Dispatch, full-time, and scheduled jobs
- View engineer profiles
- Wallet management
- Add balance and withdraw funds
- Add payment cards
- Transaction history
- Dispute management
- Account and privacy settings
- Language preferences
- Help and support
- Account deletion

### 2. Engineer Module

- Engineer registration and onboarding
- Engineer dashboard
- Recommended jobs
- View and manage jobs
- Job search and filtering
- Wishlist management
- Engineer profile management
- Wallet and earnings management
- Add balance and withdrawal
- Transaction history
- Dispute management
- Settings and account management
- Privacy and security settings
- Help and support

## Project Setup

### Prerequisites

Make sure the following tools are installed:

- macOS
- Xcode
- Swift
- iOS Simulator
- CocoaPods (if required by project dependencies)
- Git
- Bitbucket / GitHub access

### Installation

**Step 1: Clone the repository**

```bash
git clone <repository-url>
```

**Step 2: Navigate to the project directory**

```bash
cd FieldTechy_iOS
```

**Step 3: Install dependencies**

If the project uses CocoaPods:

```bash
pod install
```

If dependencies are managed through Swift Package Manager, open the project in Xcode and allow packages to resolve.

**Step 4: Open the Xcode workspace**

For CocoaPods projects:

```bash
open FieldTechy.xcworkspace
```

For projects without CocoaPods:

```bash
open FieldTechy.xcodeproj
```

**Step 5: Build and run the application**

1. Open the project in Xcode.
2. Select the appropriate build scheme.
3. Choose an iOS Simulator or connected physical device.
4. Click the Run button or press `Cmd + R`.

## Build and Archive

To build the application using Xcode:

1. Open the project in Xcode.
2. Select **Product → Build** or press `Cmd + B`.
3. Select **Any iOS Device (arm64)** as the build destination.
4. Select **Product → Archive** to generate an archive.
5. Use the Organizer window to validate and distribute the application.

The generated archive can be used for TestFlight testing and App Store distribution.

## Development Guidelines

- Follow Swift coding conventions and UIKit best practices.
- Use reusable UI components wherever possible.
- Maintain a consistent application theme and design system.
- Follow proper naming conventions for classes, files, and variables.
- Organize code using appropriate architectural patterns such as MVVM.
- Separate UI components, business logic, and API integration.
- Use appropriate view controllers for screen management.
- Handle API responses, errors, and exceptions appropriately.
- Implement proper memory management using ARC.
- Ensure responsive layouts across different iPhone screen sizes.
- Test application functionality before pushing code.
- Write meaningful Git commit messages.

## Git Workflow

The project uses Git for source code management.

Example workflow:

```bash
# Check current branch
git branch

# Switch to Development
git switch Development

# Get latest changes
git pull origin Development

# Create a feature branch
git switch -c feature/feature-name

# Stage changes
git add .

# Commit changes
git commit -m "Implement feature description"

# Push changes
git push -u origin feature/feature-name
```

## Repository Structure

The application source code is maintained in the project directory.

Typical iOS project structure:

```text
FieldTechy_iOS/
│
├── FieldTechy/
│   ├── AppDelegate.swift
│   ├── SceneDelegate.swift
│   │
│   ├── Resources/
│   │   ├── Assets.xcassets/
│   │   ├── LaunchScreen.storyboard
│   │   └── Info.plist
│   │
│   ├── Base/
│   │   ├── BaseViewController.swift
│   │   └── BaseStepVC.swift
│   │
│   ├── Client/
│   │   ├── Dashboard/
│   │   ├── Jobs/
│   │   ├── Wallet/
│   │   ├── Disputes/
│   │   └── Settings/
│   │
│   ├── Engineer/
│   │   ├── Dashboard/
│   │   ├── Jobs/
│   │   ├── Profile/
│   │   ├── Wallet/
│   │   └── Settings/
│   │
│   ├── Components/
│   ├── Extensions/
│   ├── Models/
│   ├── Services/
│   ├── Utilities/
│   └── ViewControllers/
│
├── FieldTechy.xcodeproj/
├── FieldTechy.xcworkspace/    # If CocoaPods is used
├── Podfile                    # If CocoaPods is used
├── README.md
└── .gitignore
```

*Note: The above structure is a reference. Adjust it according to the actual project directory.*

## Contribution

1. Pull the latest changes from the Development branch.
2. Create a separate feature branch for your changes.
3. Implement the required functionality.
4. Test your changes on the iOS Simulator or physical device.
5. Commit and push your changes.
6. Raise a Pull Request for code review and merging.

## License

This project is proprietary software developed for FieldTechy.

Unauthorized copying, distribution, or modification is prohibited without prior authorization.

---

**Developed and maintained by Teceze Technologies.**
