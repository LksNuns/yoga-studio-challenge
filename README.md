# Yoga Studio Challenge

This is a Ruby on Rails API project designed to manage pay rates and calculate payments based on client counts. Below are instructions on how to run the project locally and how to interact with the API.

## Running the Project Locally

To get started with running the project locally, follow these steps:

1. **Clone the repository**:
   ```bash
   git clone git@github.com:LksNuns/yoga-studio-challenge.git
   cd yoga-studio-challenge
   ```

2. **Install dependencies**:
   Make sure you have Bundler installed, then run:
   ```bash
   bundle install
   ```

3. **Set up the database**:
   Since we are using SQLite, you can set up the database with:
   ```bash
   rails db:create
   rails db:migrate
   ```

4. **Run the server**:
   Start the Rails server with:
   ```bash
   rails server
   ```

   The server will be running at `http://localhost:3000`.

## GitHub Workflow for RSpec

This project includes a GitHub Actions workflow that runs RSpec tests for each pull request and push to the master branch. The workflow is defined in the `.github/workflows/rspec.yml` file. It ensures that all tests pass before any changes are merged into the master branch, maintaining the integrity of the codebase.

To view or modify the workflow, navigate to the `.github/workflows/rspec.yml` file in the repository.


## Demo
![Peek 2024-10-10 12-51](https://github.com/user-attachments/assets/ed6cc92e-864f-4e29-b441-8530b67e4732)

## Using the API

The API provides the following routes:

### 1. `POST /pay_rates`

- **Description**: Create a new pay rate, and bonus if desired.
- **Attributes**:
  - `rate_name` (string, required): The name of the pay rate.
  - `base_rate_per_client` (decimal, required): The base rate per client.
  - `pay_rate_bonus_attributes` (nested attributes, optional):
    - `rate_per_client` (decimal, required): The bonus rate per client.
    - `min_client_count` (integer, optional): The minimum client count for the bonus.
    - `max_client_count` (integer, optional): The maximum client count for the bonus.

### 2. `PUT /pay_rates/:id`

- **Description**: Update an existing pay rate.
- **Attributes**:
  - `id` (integer, required): The ID of the pay rate to update.
  - `rate_name` (string, optional): The new name of the pay rate.
  - `base_rate_per_client` (decimal, optional): The new base rate per client.
  - `pay_rate_bonus_attributes` (nested attributes, optional):
    - `id` (integer, required if updating): The ID of the bonus to update.
    - `rate_per_client` (decimal, optional): The new bonus rate per client.
    - `min_client_count` (integer, optional): The new minimum client count for the bonus.
    - `max_client_count` (integer, optional): The new maximum client count for the bonus.
    - `_destroy` (boolean, optional): Set to `true` to remove the bonus.

### 3. `GET /pay_rates/:pay_rate_id/payments`

- **Description**: Calculate the payment for a given pay rate and client count.
- **Attributes**:
  - `pay_rate_id` (integer, required): The ID of the pay rate.
  - `clients` (integer, required): The number of clients to calculate the payment for.

- **Response**: Returns the calculated payment in JSON format.

## Additional Information

- Ensure you have Ruby 3.x and Rails 7.x installed.
- Use Insomnia or a similar tool to test the API endpoints.
