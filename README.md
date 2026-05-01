# Election Guide AI 🗳️ (Google Antigravity Submission)

A modern, AI-powered Flutter application designed to guide citizens through the election process, track important dates, and manage essential documents.

---

### 🏛️ Chosen Vertical: Civic Education & Voter Assistance
Our solution focuses on the **Civic Tech** persona. The app is designed for citizens who need clear, accessible, and smart guidance during the election cycle—reducing misinformation and increasing voter participation.

---

### 💡 Approach and Logic
The core of "Election Guide AI" is a **User-Centric Hub**. 
1.  **Dynamic Logic**: The AI Assistant doesn't just provide static text; it analyzes user intent (e.g., registration vs. voting day logistics) to provide context-aware instructions.
2.  **Privacy-First Vault**: We implemented a "Digital Vault" using local encryption (Shared Preferences), ensuring that sensitive data like Voter IDs are never uploaded to the cloud—demonstrating **Security and Efficiency**.
3.  **Data-Driven UI**: Real-time news and countdown timelines ensure the user always has the most current information.

### 🧠 How the Solution Works
*   **The Smart Assistant**: Built with a `ChatController` that mimics logical decision-making. It categorizes user queries into "Civic Action Items" and guides the user to the correct app module (Vault, Candidate Info, or Timelines).
*   **Accessible Interface**: Uses **Google Fonts (Poppins)** for high readability and **Semantic Labels** for screen-reader compatibility.
*   **Scalable Architecture**: Controllers are separated from views to maintain clean, testable, and maintainable code.

### ⚙️ Google Services Integration
*   **Google Fonts Service**: Integrated for professional typography.
*   **Material 3**: Fully utilized for modern, accessible UI components.
*   **Flutter (Google SDK)**: Leveraged for high-performance cross-platform rendering.

### 📝 Assumptions Made
*   Users have access to their physical documents once to scan/reference them in the vault.
*   Election news is fetched from an external API (simulated for the demo).
*   Local storage is sufficient for document status metadata (Digital Vault).

---

## 🚀 Setup & Installation
1.  **Clone the repository**:
    ```bash
    git clone [Your-Repo-URL]
    ```
2.  **Install Dependencies**:
    ```bash
    flutter pub get
    ```
3.  **Generate Assets**:
    ```bash
    dart run flutter_launcher_icons
    ```
4.  **Run**:
    ```bash
    flutter run
    ```

### 📏 Repository Standards
*   **Size**: Optimized assets to keep the repo size **< 10 MB**.
*   **Branch**: All development maintained on a **single branch**.
*   **Code Quality**: Lints applied and comments added for maintainability.

---
*Developed for the Google Antigravity Challenge.*
