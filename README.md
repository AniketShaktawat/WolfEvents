# WolfEvents

## Overview
This Event Management System serves as a comprehensive event ticketing platform where users can browse and reserve event tickets, submit reviews, and maintain their profiles. Admin privileges encompass overseeing events, attendees, tickets, and reviews. This README offers vital details regarding admin login credentials, system testing procedures, and utilization guidelines.

### Ruby Versions
This project utilizes Ruby version 3.3.2 and Rails version 6.1.7.

### Deployment
The application is deployed on NCSU VCL. It can be accessed at: http://152.7.177.47:8080/

## Preconfigured Admin
The seeds.rb file populates the database with initial data, including an Admin user, to facilitate testing and demonstration of features such as logging in as an admin, booking and canceling tickets, and writing reviews.

### Admin Credentials

email: admin@gmail.com <br>
password: admin_password

## Navigating the Application
1. **Registration and Login**

  To register as a new attendee, navigate to the Home page and select "Signup" to create your account. Afterwards, utilize the credentials you've just       created to log in. Please note that new admin registrations are not permitted. Instead, access the admin panel using the preconfigured login details       provided.
  
2. **Edit Attendee Profile**
  Upon logging in, you can access "My Profile" to modify your details and utilize "Delete Profile" to remove your account.

  Additionally, admin can navigate to the "Users" link to view all attendees. Within this section, admins have the capability to edit or delete               attendee accounts as needed.  
  
 3. **View Upcoming Events**
   The Home page displays a list of upcoming events that are open for booking under the "Events" section. Users can only view events scheduled for the        future with available seats.

   However, admin has unrestricted access to view all events, regardless of their date and availability. They possess the capability to Add, Edit, or          Delete events as needed. 

