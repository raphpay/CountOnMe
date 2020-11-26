# README Github

This project is part of the OpenClassrooms Learning Program and available on [GitHub](https://github.com/raphpay/CountOnMe).

The main purpose of this project is to improve an existing application. The application is a simple calculator app, with the basic operations.

## Features

The application allow the user to make a calculation of two, three or more operands. The application keeps track of the calculation priority and do the special operations ( multiplication and division ) before the normal ones ( addition and substraction ).

## Architecture

The architecture of the application was initially not MVC. The goal was to refactor it and create a MVC application, with a maintainable model, a simple controller and a basic view.

### Model

The model is a simple file named `Calcul.swift`.

Here is the mini map of the file.

- **Properties :** All the accessible properties
- **Computed Properties :** The computed accessible properties
- **Private properties :** The private properties and computed properties
- **Methods :** The only accessible method
- **Calculation methods :** The methods relative to the calculation process
- **Helper Methods :**  Helpful methods to organize the properties **:**

### Controller :

Here is the mini map of the controller.

The purpose of the controller is to take care of the actions of the user. 

It calls the calculation method only when the user tap the equal button.

When a user tap a number or an operator, the text view is updated with the right value.

### Test

The tests is based on BDD ( Behavior Driven Development ) and was created following the TDD logic ( Test Driven Development ).

### Extension

The UIViewController extension created is here to add a functionality to the view controller : present an alert controller, with default title and message.

The Double extension created is here to explicitly round a number with a certain number of digits.

## Notes

The application is only available on iPhone, and in portrait mode.