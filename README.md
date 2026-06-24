# recipe-recommendation

## Firebase Setup (Required)

After cloning the repository, follow these steps to run the app locally.

### 1. Install required CLIs (one-time setup)

Install Firebase CLI:
```bash
npm install -g firebase-tools
```

Install FlutterFire CLI:
```bash
dart pub global activate flutterfire_cli
```

Verify installations:
```bash
firebase --version
flutterfire --version
```

### 2. Login to Firebase

```bash
firebase login
```

Make sure you log in using the Google account that has access to the Firebase project.

### 3. Install Flutter dependencies

```bash
flutter pub get
```

### 4. Generate Firebase configuration locally

```bash
flutterfire configure
```

This command will:
- Ask you to select the Firebase project
- Generate local config files (not committed to git)

### 5. Run the application

```bash
flutter run
```

### Notes

- Firebase configuration files are intentionally not included in the repository
- Each developer must run `flutterfire configure` locally
- Do not commit generated Firebase config files
"# recipe-recommendation" 
