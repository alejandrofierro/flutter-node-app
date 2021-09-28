# Node & Flutter App

##Why?

The purpose of this excercise is to evaluate your knowledge on NodeJS and Flutter.

###What is the problem to be solved?

As a user I need an application that can help me to track potential customers for my business, so I need a way to keep track of customer information on my phone. Think of this as a Contact App

The information wil NOT be stored on my phone but on the "cloud".

###Requirements

##### Backend

- NodeJS Application acting as a backend exposing an API to serve /customer data
- CRUD API for customers
- Data can be stored in memory, no need to use any Database
- Customer info must contain:
	- Id
	- Customer Name	
	- Phone
	- Email
	- Probability to become a customer (Rate 1 to 5) where 1 is the lowest priority

##### Frontend
- Flutter App consuming our NodeJS API
	- Login Screen
		-	This screen will have a username field, a password field and a button to login to our application. Once Logged In the user will be redirected to the Contact List Screen
	- Contact List Screen
		 - This screen should show a dynamic list view for all existing customers coming from our API
		 - This screen should show a button that allows the user to create a new Customer entry
	- Contact View/Edit/Create Screen
		- This screen should be opened once the user selects a customer from the Contact List Screen and show all the info related to the specific customer
		- This screen should be opened if the user clicked the new Customer button present in the Contact List Screen  allowing the user to create a new customer entry
		- This screen should allow the user to EDIT any info from the customer except for the ID
		- This screen should show a SAVE button that allows the user to save the customer details
		- This screen should show a DELETE button that allows the user to delete that particular customer from the database.

### Notes
- There are two folders at the root of the project one for the backend project and the other for the frontend.
- For the username/password on the mobile app please only allow the following combination for user/pwd  (No need to use any database for user management)
	- user: alex
	- pass: al3x
- You can use whatever web app framework you want for NodeJS (Express is recommended)
- No need to add certificates or create a production ready applications, as a product owner I should be able to run both applications on the same network and they should be able to communicate (Specific documentation from your side is needed in order to configure how the mobile app should connect to the nodejs app)
- Not enforced on this evaluation but gives you extra credits are:
	- Docker
	- API Protection strategies
	- Usage of BloC pattern (Or similar state management system)


