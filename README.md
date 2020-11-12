# README GitHub

This project is part of the OpenClassrooms Learning Program and available on [GitHub](https://github.com/raphpay/CountOnMe).

The main purpose of this project is to improve an existing application. The application is a simple calculator app, with the basic operations.

## Features

The application allow the user to make a calculation of two, three or more operands. The application keeps track of the calculation priority and do the special operations ( multiplication and division ) before the normal ones ( addition and substraction ).

## Architecture

The architecture of the application was initially not MVC. The goal was to refactor it and create a MVC application, with a maintainable model, a simple controller and a basic view.

### Model

The model is a simple file named `Calcul.swift`.

Only five properties and one function are not private : 

- Properties :
    - `equation` : The overall equation
    - `result` : The result of the equation
- Computed Properties :
    - `canAddOperator` : Whether the user can add or not an operator
    - `isFinished` : Return whether the calculation is finished ?
    - `resultIsADouble` : Return whether the result is a double.
- Method :
    - `Calculate(operation: String)` : Takes the logic of the calculation with as a parameter the equation.

All the private properties and methods are here in support of the main method described below. 

### Controller :

The purpose of the controller is to take care of the actions of the user. 

It calls the calculation method only when the user tap the equal button.

When a user tap a number or an operator, the text view is updated with the right value.

### Test

The tests is based on BDD ( Behavior Driven Development ) and was created following the TDD logic ( Test Driven Development ).

### Extension

The extension created is here to add a functionality to the view controller : present an alert controller, with default title and message.

## Notes

The application is only available on iPhone, and in portrait mode.