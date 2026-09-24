# Matrix Auth App (Flutter — Named Routes Lab)

Login → Sign-Up → Home, Matrix-themed (black bg + green "digital rain").

## Paano i-run
1. I-extract yung zip, buksan sa VS Code.
2. Sa terminal: `flutter pub get`
3. Tapos: `flutter run`

## Paano ito sumusunod sa requirements

| Requirement | Saan makikita |
|---|---|
| Named routes sa MaterialApp | `lib/main.dart` — `routes: { '/login', '/signup', '/home' }` |
| `pushNamed` | Login → Sign-Up button (`login_screen.dart`) |
| `pushReplacementNamed` | Login/Sign-Up → Home (para hindi na mabalikan yung form) |
| `pop` | Sign-Up → back to Login link |
| `pushNamedAndRemoveUntil` | Logout button (clears buong stack pabalik sa Login) |
| Data passing via route arguments | Name (Sign-Up) o email (Login) ipinapasa papunta sa Home screen, kinukuha gamit ang `ModalRoute.of(context)?.settings.arguments` |
| Login screen | email/username + password fields, Login button, link to Sign-Up |
| Sign-Up screen | full name, email, password, confirm password, Sign Up button, link back to Login |
| Home screen | welcome message gamit yung ipinasang name, Logout button |
| Consistent UI | Shared `MatrixRainBackground` widget + common theme sa `main.dart` ginagamit sa lahat ng 3 screens |

## File structure
```
lib/
  main.dart                     <- app entry + route table + theme
  widgets/
    matrix_rain_background.dart <- reusable animated background
  screens/
    login_screen.dart
    signup_screen.dart
    home_screen.dart
```

## Notes para sa defense
- Form validation gamit ang `GlobalKey<FormState>` sa bawat screen — kaya
  hindi makaka-proceed kung may blangkong field o mismatch na password.
- `pushReplacementNamed` sinadyang ginamit pagkatapos mag-login/sign-up
  (hindi `pushNamed`) para hindi na balikan ng back button yung form screen.
- `pushNamedAndRemoveUntil` naman sa Logout para talagang buo yung "clean slate"
  pabalik sa Login — clinclear yung buong navigation stack.
