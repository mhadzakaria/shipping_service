# Shipping Service

This is a Ruby on Rails application that provides shipping rate calculations.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

*   Ruby 3.4.4
*   PostgreSQL
*   Redis

### Installation

1.  Clone the repository:
    ```bash
    git clone https://github.com/dixy-design/shipping_service.git
    ```
2.  Install the gems:
    ```bash
    bundle install
    ```
3.  Create the database:
    ```bash
    rails db:create
    ```
4.  Run the database migrations:
    ```bash
    rails db:migrate
    ```

## Configuration

### Database

The database configuration is located in `config/database.yml`. By default, the application is configured to use PostgreSQL.

### Environment Variables

Create a `.env` file in the root of the project and add the following environment variables:

```
RAILS_MASTER_KEY=
```

You can obtain the master key from `config/master.key`.

## Usage

### Running the application

To start the Rails server, run the following command:

```bash
rails s
```

The application will be available at `http://localhost:3000`.

### API Documentation (Swagger)

This application provides interactive API documentation using Swagger UI.

To access the API documentation:

1.  Ensure your Rails server is running:
    ```bash
    rails s
    ```
2.  Open your web browser and navigate to:
    `http://localhost:3000/api-docs`

The documentation includes details about the available endpoints, their parameters, and expected response formats.

## Running Tests

To run the test suite, use the following command:

```bash
rspec
```


