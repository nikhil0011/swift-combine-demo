
# SwiftCombineDemo, A Currency Exchange App

An app to list the popular currencies from source powered by an open API Service.

It also facilitates the user to input the amount of desired conversion and selection of target / base currency

We allow user to review the exchange transcation for 30 sec lock in timer.

On Confirmation we display the amount has been transfered to user account 
Note: We do preserve currencies list with CoreData storage for 5 hours.
 

## API Reference

#### Get all items

```http
  GET https://v6.exchangerate-api.com/v6/\(TOKEN)/latest/USD"
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
|  |  |  |



## Authors

- [@nikhilnangia](https://www.github.com/nikhil0011)

## Tech Stack

**Client:** Swift, iOS

**Server:** REST API

 - Clean Priniciple with MVVM
 - App has been built following the principles of CLEAN architechture.
 - App has been layered into 3 different components Usecase, Presnter and repository module 
 - Persistant storage is used to share core data context all over app.
 - Every entity is build with an repository pattern which provided access control for operation in form of managers to views.
 
## Running Tests

Tests for the following moduels have been added to project

- Service Class
- CoreDataManagers
**For Main Module::** 

- UseCase
- Network

