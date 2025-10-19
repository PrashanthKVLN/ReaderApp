# 📰 ReaderApp

An **iOS News Reader App** built with **Clean Architecture + MVVM + Dependency Injection**, featuring **offline caching** and **bookmarks** for a seamless reading experience.

---

## 🚀 Features

- ✅ Fetch latest news articles from API  
- 🔍 Search articles by title  
- 📌 Bookmark and unbookmark articles  
- 💾 Offline data caching using **Core Data**  
- 💡 Bookmarks persisted using **UserDefaults**  
- 🧠 Built with **Clean Architecture + MVVM**  
- 🧩 Uses **Dependency Injection** for scalable and testable architecture  

---

## 🧱 Architecture Overview

Presentation Layer (View + ViewModel)
↓
Domain Layer (Use Cases / Repository Protocols)
↓
Data Layer (Core Data + UserDefaults + Network)

## 📦 Data Flow

1. When the app launches, it fetches articles from the network.  
2. The fetched data is cached locally using **Core Data**.  
3. When offline, the app automatically loads the cached articles.  
4. Bookmarks are managed separately via **UserDefaults**, ensuring persistence across launches.  

---

## ⚙️ Tech Stack

- **Language:** Swift  
- **UI:** UIKit  
- **Architecture:** Clean Architecture + MVVM  
- **Networking:** URLSession  
- **Offline Caching:** Core Data  
- **Persistence:** UserDefaults (for Bookmarks)  
- **Dependency Injection:** Constructor-based DI

## 🧪 How to Run

1. Clone the repo  
   ```bash
   git clone https://github.com/PrashanthKVLN/ReaderApp.git
Open ReaderApp.xcodeproj in Xcode (v15+)

Run the app on iPhone Simulator (iOS 16 or later)

Turn off the internet and observe that cached articles are still displayed

