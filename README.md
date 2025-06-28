
# Meetmax

Meetmax is a Facebook-style social media app built using Flutter and Dart, designed to provide a clean and responsive user experience for posting content, commenting, and engaging with others. Local storage is implemented using Hive instead of Firebase.

---

## 🔧 How to Set Up, Run, and Test the Application

### ✅ Prerequisites
- Flutter SDK installed
- Dart installed
- Compatible editor like **VS Code** or **Android Studio**

### 🛠 Setup Instructions
1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/meetmax.git
   cd meetmax
   ```

2. **Get all dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

---

## 📁 Folder Structure

```
lib/
│
├── data/                       # Static app data or mock datasets
├── dummyModels/               # Mock data models
├── models/                    # Actual data models (User, Post, Comment)
├── screens/                   # All screen-level UI
│   ├── create_post_screen.dart
│   ├── current_user_profile_info.dart
│   ├── feed_screen.dart
│   ├── forgot_password_screen.dart
│   ├── login_screen.dart
│   └── signup_screen.dart
├── services/                  # Business logic layer
│   ├── auth_service.dart
│   ├── post_service.dart
│   └── user_service.dart
├── widgets/                   # Reusable UI components
│   ├── createPost/
│   ├── customButtonAndTextfield/
│   └── feed/
├── debug_helper.dart          # Debugging utilities
├── main.dart                  # Entry point
```

---

## 🛠 Tools & Technologies Used

- **Flutter**
- **Dart**
- **Hive** for local storage
- **FontAwesome** and **Material Icons** for UI

---

## ✨ Features

- ✅ Login and registration with proper validation and authentication
- ✅ Feed screen displaying all posts
- ✅ Create post functionality (supports text and image)
- ✅ Like and comment on posts in real time
- ✅ User profile page with basic info
- ✅ Forgot password screen with mock reset

---

## 🖼 Screenshots

| Signup Screen                            | Sign In Screen                          |
|------------------------------------------|-----------------------------------------|
| ![signup](assets/screenshots/SignUp.jpg) | ![login](assets/screenshots/SignIn.jpg) |

| Forgot Password                                  | Feed Screen                              |
|--------------------------------------------------|------------------------------------------|
| ![forgot](assets/screenshots/ForgotPassword.png) | ![feed](assets/screenshots/FeedPage.png) |

| Create Post                                  | Profile Screen                             |
|----------------------------------------------|--------------------------------------------|
| ![create](assets/screenshots/CreatePost.png) | ![profile](assets/screenshots/Profile.png) |

| Comments Section                             |
|----------------------------------------------|
| ![comments](assets/screenshots/Comments.png) |

> ⚠️ Make sure to replace image paths with actual screenshot images placed in a `screenshots/` directory inside your root project.

---

## 📄 Assumptions & Simulated Backend

- **Authentication & user management** are handled locally using `Hive`.
- No real backend/API – post/comment interactions are stored in local storage.
- Image uploading is simulated using file picker or device image selection.
- User sessions are preserved using local box storage.
- ⚠️ **Likes and comments will not work on dummy posts. They only function on real posts created by the user.**

---

## ✅ Notes
- This project is self-contained and does not require an internet connection.
- Designed for Android but should work cross-platform.

---
