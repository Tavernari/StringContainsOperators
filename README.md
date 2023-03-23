# StringContainsOperators

StringContainsOperators is a Swift library for creating and evaluating complex string predicates using custom operators. This library provides an easy-to-use and flexible solution for matching strings against complex patterns.

## How to Use

The library provides three main components: custom operators, an enum type, and an extension to the String class.

## Custom Operators

StringContainsOperators provides two custom operators: || and &&. These operators are used to create OR and AND predicates, respectively, between two strings or between a string and another predicate.

For example, you can create an OR predicate between two strings as follows:

```swift
let predicate = "hello" || "world"
```
This creates a predicate that matches any string that contains either "hello" or "world". Similarly, you can create an AND predicate between two strings like this:

```swift
let predicate = "hello" && "world"
```
This creates a predicate that matches any string that contains both "hello" and "world".

## Enum Type

The resulting predicate is represented by an enum type called StringPredicate. This enum type can be either a base predicate, an OR predicate, or an AND predicate.

## Extension to String

The contains() function, which is an extension of the String class, is used to evaluate whether a given string satisfies a particular predicate. The function takes a StringPredicate as input and returns a boolean value indicating whether the predicate is true or false.

```swift
let result = "hello world".contains("hello" || "world")
print(result) // true
```

## How to Install

### SPM

You can install StringContainsOperators using Swift Package Manager (SPM). Simply add the following line to your dependencies in your Package.swift file:

```swift
.package(url: "https://github.com/Tavernari/StringContainsOperators.git", from: "1.0.0")
```

### Cocoapods

You can also install StringContainsOperators using CocoaPods. Simply add the following line to your Podfile:

```ruby
pod 'StringContainsOperators', '~> 1.0'
```

## Contributions

Contributions to StringContainsOperators are welcome! Before making a pull request, please open an issue to discuss your proposed changes. We follow the GitHub Flow for our development process.

Please note that this project is released with a Contributor Code of Conduct. By participating in this project you agree to abide by its terms.