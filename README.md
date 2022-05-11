# vale: an e-commerce app made using flutterfire

![banner](https://raw.githubusercontent.com/lightlessdays/img/main/vale/banner.png)


## frontend

![frontend](https://github.com/lightlessdays/img/blob/main/vale/Untitled%20design%20(3).png)

The frontend of this app has been designed using Flutter framework created by Google. Before putting to code, I used Figma to create the UI. [Here](https://www.figma.com/file/fq20K5oit1tj1NIdoQd738/Vale?node-id=0%3A1) is the link to the initial UI created in Fimga.

The archtitechture used is MVC archtitechture. All the graphics have been created using Adobe Photoshop (including mockups of hats). To store images in user's device as cache, an external library [cached_network_image](https://pub.dev/packages/cached_network_image) has been used. 

## backend

![backend](https://raw.githubusercontent.com/lightlessdays/img/main/Untitled%20design.jpg)

This app has been written using Dart, YAML and XML. Majority of the backend is being handled using Firebase Firestore and Firebase Authentication. Each users' data and orders are stored in a NoSQL database (Cloud Firestore). CRUD operations require the user to connect to the internet. Payment Gateways have been built using Razorpay (these are mock payment gateways, so do no make any payment using those gateways). Also, Google Maps API has been integrated in the app in the Store Locator section.
