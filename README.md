# Self-Budgeting Tool

## Overview
The Self-Budgeting Tool is a comprehensive web application designed to empower users with complete control over their finances. Track income, expenses, recurring and fixed costs, savings, loans, and more in one intuitive interface. Make informed decisions and achieve your financial goals with ease.

## Features

### Income and Expenses Tracking
- Seamlessly record and categorize your daily income and expenses for an apparent financial health overview.

### Recurring and Fixed Costs Management
- Easily set up and monitor your recurring payments and fixed costs, ensuring you never miss a payment.

### Savings Tracker
- Set savings goals and track your progress, helping you prioritize and manage your finances to reach your objectives.

### Loans Management
- Keep track of your loans, interest rates, and repayment schedules in one place to stay on top of your debts.

### Financial Reporting
- Generate detailed reports and insights into your financial habits, aiding in better decision-making and planning.

### Technology Stack

#### Frontend: [Vue.js](https://vuejs.org/)
Vue.js is a progressive JavaScript framework used to build more maintainable and testable code bases.

#### Backend: [Flask](https://palletsprojects.com/p/flask/)
Flask is a lightweight WSGI web application framework. It is designed to make getting started quick and easy, with the ability to scale up to complex applications. Flask is described as a microframework for Python, based on Werkzeug, Jinja 2, and good intentions.

#### Database: [MySQL](https://www.mysql.com/)
MySQL is the world's most popular open-source database. With its proven performance, reliability, and ease-of-use, MySQL has become the leading database choice for web-based applications.

### High Level Design 

![HLD Diagram of the self-budgeting tool](https://github.com/devzero-inc/self-budgeting-tool/assets/93814858/7793862a-5595-4b53-aee2-53213dbbed0e)

### Working of the Self-Budgeting Tool

#### User Interaction

**Frontend Interaction**: Users engage with the Self-Budgeting Tool through a Vue.js-based frontend. This framework facilitates a dynamic and responsive user interface, allowing users to effortlessly manage their finances, track their expenses, and set savings goals. The intuitive design ensures that users can easily navigate through different financial tools and features offered by the application.

#### System Operations

**Backend Communication**: When users perform actions such as recording expenses, setting up savings goals, or managing loans, these actions trigger requests to the backend, which is powered by Flask. Flask's lightweight and efficient nature allows for the quick and effective handling of these requests, ensuring a smooth operational flow within the application.

#### Data Management and Responses

**Database Interactions**: All financial data, including income records, expenses, savings goals, and loan information, is stored and managed in a MySQL database. This ensures reliable data storage and retrieval, supporting the core functionalities of the Self-Budgeting Tool.

**Caching and Performance Optimization**: While not specified in the initial setup, implementing caching with tools such as Redis could significantly enhance the application's performance. It would be particularly beneficial for quickly accessing frequently used data, such as monthly expense summaries or savings progress reports.

**Response Handling**: After the backend processes a request, including data storage, updates, or retrieval, it generates a response that is sent back to the frontend via the middleware. The Vue.js application then updates the user interface accordingly, reflecting the new or modified data. This ensures that users have real-time access to their financial information, contributing to a seamless and efficient user experience.
