# Gallery Art - BackEnd API

🔗 Frontend App (Live): https://gallery-art-f.vercel.app/

👋 Welcome to the GalleryArt Backend API!
This repository hosts the backend API for the ArtGallery web application. It's built to serve all the data and business logic required by the frontend, including user authentication, artwork management, personal galleries, and an interactive art quiz system. It provides a robust and scalable foundation for the application's features.

---

###  🚀 Technologies Used

The ArtGallery Backend API is built with a modern and efficient technology stack:

- Ruby on Rails (v8.0.2): A powerful and convention-over-configuration web application framework, providing the core structure for the API.

- PostgreSQL: A robust, open-source relational database system used for data storage.

- Neon (for PostgreSQL Hosting): A serverless PostgreSQL platform, likely used for hosting the production database, offering scalability and flexibility.

- JWT (JSON Web Tokens): Used for secure, stateless user authentication, allowing the frontend to make authenticated requests to protected endpoints.

### Key Gems from Gemfile:

- rails: The Rails framework itself.

- pg: PostgreSQL adapter for ActiveRecord, enabling communication with the PostgreSQL database.

- puma: A fast and concurrent web server for Ruby applications.

- bcrypt: Provides secure password hashing for user authentication.

- jwt: For encoding and decoding JSON Web Tokens, crucial for the authentication system.

- rack-cors: Handles Cross-Origin Resource Sharing (CORS), allowing the frontend application (hosted on a different domain) to safely make requests to this API.

- solid_cache, solid_queue, solid_cable: Rails' new built-in solutions for caching, background jobs, and Action Cable (WebSockets), indicating potential for performance optimization and real-time features.

- kamal: (Development/Deployment) A tool for deploying web apps anywhere, potentially used for Docker-based deployments.

- debug: (Development/Test) A powerful debugger for Ruby applications.

- brakeman: (Development/Test) A static analysis security vulnerability scanner for Rails applications.

- rubocop-rails-omakase: (Development/Test) A code linter and formatter for Ruby on Rails, ensuring code quality and consistency.

### 📦 API Endpoints

The API provides the following endpoints to interact with the ArtGallery application:

- Authentication
POST /signup

Controller: users#create

Description: Registers a new user account. Expects username, password, and password_confirmation.

- POST /login

Controller: sessions#create

Description: Authenticates a user. Expects username and password. Returns a JWT token upon successful login.

- DELETE /logout

Controller: sessions#destroy

Description: Logs out the current user by invalidating their session (and typically clearing the token on the frontend).

- GET /me

Controller: users#me

Description: Retrieves the details of the currently authenticated user, including their coins and personal_gallery information. (Requires authentication).

Artworks
- GET /artworks

Controller: artworks#index

Description: Fetches a list of all available artworks in the gallery.

- User Personal Gallery
Scope: /user_gallery

- POST /user_gallery/add_artwork/:artwork_id

Controller: user_galleries#add_artwork

Description: Adds a specific artwork (identified by artwork_id) to the authenticated user's personal gallery. (Requires authentication).

- GET /user_gallery

Controller: user_galleries#show

Description: Retrieves the artworks currently in the authenticated user's personal gallery. (Requires authentication).

- Quiz System
Scope: /quiz

- GET /quiz/question

Controller: quizzes#generate_question

Description: Generates and returns a new quiz question, including artwork details, options, and the correct_field for validation. (Requires authentication).

- POST /quiz/submit_answer

Controller: quizzes#submit_answer

Description: Submits a user's answer to a quiz question. Expects artwork_id, answer (the user's chosen option), and correct_field (e.g., 'title', 'artist_name'). Returns success status, a message, and the user's new_coins balance. (Requires authentication).

### 💡 Key Features

- CORS (Cross-Origin Resource Sharing): Properly configured to allow secure communication between the frontend application (potentially on a different domain) and this API.

- User Authentication: Implemented using JWT for secure and stateless user sessions, protecting sensitive endpoints.

- Database Management: Utilizes PostgreSQL for robust and efficient storage of user data, artworks, and gallery information.

- Quiz Generator: A dynamic system that generates unique art quiz questions, providing an interactive and rewarding experience for users.
  
---
📬 Contact
Created by Facundo Robert – GitHub

Feel free to reach out for collaboration or feedback!
---
