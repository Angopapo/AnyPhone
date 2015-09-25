# AnyPhone
![alt tag](http://url/to/img.png)
Objective-C version of AnyPhone example created by Parse.

#### Requirements
* Parse Account -> Free
* Twilio Account -> Free Trial.

#### Setup
* Create a new Parse App, and set up a Cloud Code folder for the project.
* Copy the contents of the cloud/ folder from this repository into the cloud/ folder in your Cloud Code folder.
* Edit main.js to include your Twilio Account Sid, Auth Token, and phone number. Generate some random string to use as the password token.
* Pull all required iOS dependencies from Cocoapods by running pod install under AnyPhone folder.
* Open the AnyPhone/AnyPhone.xcworkspace, and put your Parse Application Id and Client Key in AppDelegate.m.
* Deploy your Cloud Code by running parse deploy from the root of your Cloud Code folder.

#### Improve
* Add brute-force protection, resetting the code after a few failed attempts
* Enhance the input validation to support more countries and number formats
