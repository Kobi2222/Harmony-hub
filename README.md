# **Harmony Hub:**<br> 
An E-Commerce Platform for Music Lovers
Welcome to the Harmony Hub project! This is the backend of an e-commerce platform designed specifically for music enthusiasts, offering a wide range of musical instruments, vinyl records, accessories, and exclusive artist merchandise.

# ****Table of Contents****<br>
Overview <br>
Ruby Version<br>
System Dependencies<br>
Database Setup****
Running the Application<br>
Starting the Rails Server<br>
Mail Catcher Setup<br>



# **Overview**
Harmony Hub is a vibrant online marketplace designed for music lovers of all kinds. Whether you're a beginner looking for your first instrument, a seasoned musician in search of rare finds, or an audiophile on the hunt for vintage vinyl, Harmony Hub has something for you. In addition to offering a diverse range of products, the platform fosters community engagement through user reviews, artist collaborations, and music-related discussions.

# **Ruby Version**
The application was built using Ruby 3.1.2. Please ensure you're using the correct version by running:

bash
Copy code
ruby -v <br>
If you're using rbenv or rvm, you can set the Ruby version accordingly:

bash
Copy code
rbenv install 3.1.2
rbenv global 3.1.2

# **System Dependencies**
Harmony Hub relies on the following system dependencies:

Ruby 3.1.2
Rails 6.x or newer
PostgreSQL 12 or newer
Redis (for caching and background job processing)
Mailcatcher (for local email development/testing)
Make sure the following tools are installed and properly configured on your system:

Ruby
Rails
PostgreSQL
Redis
Mailcatcher



# **Database Setup**
To set up the database, follow these steps:

Install the required gems:

bash
Copy code
bundle install
Set up the database:

bash
Copy code
rails db:create
rails db:migrate
rails db:seed
The rails db:seed command will populate the database with some sample products, categories, and users for testing.

# **Running the Application**
Once the setup is complete, you can start the Rails server to run the application locally.

Starting the Rails Server
To start the server, run the following command:

bash
Copy code
rails s
This will start the server on http://localhost:3000.

# **Mail Catcher Setup**
To catch outgoing emails locally for development and testing, run Mailcatcher by executing:

bash
Copy code
mailcatcher
Once started, you can access the mail catcher interface at http://127.0.0.1:1080.

This will allow you to view any emails sent by the application, including user registration confirmation, order notifications, etc.
