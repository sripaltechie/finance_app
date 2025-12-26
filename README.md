Chanda Finance Mobile
A professional Flutter application designed as a mobile extension for the Chit Fund & Financial ERP System. This app provides field agents and administrators with real-time access to financial collections, customer data, and daily accounting reports while on the move.
📱 Mobile Features
Field Collection Management: Specialized modules for collectors to log daily chit amounts and payments directly from the field.
Real-time Reports: Access to Daybook, Collection Reports, and Last Payment details instantly.
Customer Insights: Complete customer list with deep-links to their financial history and "Asalu" (Principal) details.
Transaction Controls: Full CRUD support for Cash Entries (Dr/Cr) and Chit (Chiti) modifications.
Clean Architecture: Implements the Repository Pattern with MVVM to ensure predictable data flow and easy maintenance.
🛠 Tech Stack
Framework: Flutter (Dart)
State Management: Provider (inferred from architectural patterns)
Network Layer: HTTP with custom BaseApiServices and NetworkApiService wrappers.
Architecture: MVVM (Model-View-ViewModel) + Repository Pattern.
Data Parsing: Specialized Models for Asalu, Chiti, Daybook, and CollectionReport.
📂 Repository Structure (Data Layer)
The mobile app is organized into specialized repositories that interact with the Slim PHP API:
lib/
├── data/
│   ├── network/            # Network handling & API service wrappers
│   └── response/           # Generic API Response handlers (Success/Error)
├── model/                  # Data models (ChitiModel, DaybookModel, etc.)
├── res/
│   └── components/         # App URLs & Global constants
└── repository/             # Business Logic Layer
    ├── asalu_repository.dart       # Principal/Loan management
    ├── auth_repository.dart        # Login & User Session
    ├── chiti_repository.dart       # Chit Fund operations
    ├── daybook_repository.dart     # Daily ledger access
    ├── drcr_repository.dart        # Cash entry management
    └── collection_repository.dart  # Field collection tracking


🚀 Getting Started
1. Prerequisites
Flutter SDK (Latest Stable)
Android Studio / Xcode
The Backend API must be running and accessible via a public URL or local network.
2. Configuration
Open lib/res/components/app_url.dart and update the baseUrl to point to your PHP Slim API:
static var baseUrl = '[https://your-domain.com/api](https://your-domain.com/api)'; 


3. Build & Run
flutter pub get
flutter run


🔌 API Integration Details
The Flutter app communicates with the backend using the following repository logic:
Authentication: Uses AuthRepository for login/signup, handling API keys for secure sessions.
Data Fetching: Uses a custom ApiResponse class to handle three states: Loading, Completed, and Error.
Error Handling: Centralized error interceptors in NetworkApiService to handle status codes (400, 401, 500, etc.).
🛡 Security
API Key Header: Every request automatically attaches the authenticated user's API Key.
Input Validation: Strict client-side validation for financial amounts and dates before submission to the API.
Developed for efficient field-level financial operations.
