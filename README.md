![Swift](https://github.com/Tavernari/StringContainsOperators/actions/workflows/swift.yml/badge.svg?branch=main)
[![Maintainability](https://api.codeclimate.com/v1/badges/29ffa494572357c62162/maintainability)](https://codeclimate.com/github/Tavernari/StringContainsOperators/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/29ffa494572357c62162/test_coverage)](https://codeclimate.com/github/Tavernari/StringContainsOperators/test_coverage)

# 🐞 StringContainsOperators

StringContainsOperators is a Swift library that simplifies searching for multiple strings within a given text. By using custom infix operators and predicates, you can create complex and flexible search patterns that make it easy to find if strings exist in your text.

![Example](https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExMTQxZTA5NzMyNGQ0NjQ2YzY2YmI4OGY5ODZjNGJiNWViNmI0OWE3OSZjdD1n/aWYYLfaHwbQAtuuWAM/giphy.gif)

## Operators

StringContainsOperators provides several operators that can be used to create complex search conditions. These operators allow you to search for strings in a more natural and expressive way, and to combine search conditions using logical operators.

### `||` Operator
The || operator performs a logical OR operation between two strings or StringPredicates. It returns a StringPredicate that represents the combined search condition.

```swift
// Swift native implementation
let result = text.contains("quick") || text.contains("jumps")

// StringContainsOperators implementation
let result = try text.contains("quick" || "jumps")
```
## `&&` Operator
The && operator performs a logical AND operation between two strings or StringPredicates. It returns a StringPredicate that represents the combined search condition.

```swift
// Swift native implementation
let result = text.contains("fox") && text.contains("dog")

// StringContainsOperators implementation
let result = try text.contains("fox" && "dog")
```

## `~` Operator
The ~ operator creates a StringPredicate that performs a case-insensitive and diacritic-insensitive search for a given string.

```swift
// Swift native implementation
let options: String.CompareOptions = [.caseInsensitive, .diacriticInsensitive]
let result = text.range(of: "Brown", options: options) != nil || text.range(of: "red", options: options) != nil


// StringContainsOperators implementation
let result = try text.contains(~"Brown" || ~"red")
```
## `!` Operator
The ! operator negates a StringPredicate or a string. When used before a StringPredicate, it returns a StringPredicate that represents the negation of the original search condition. When used before a string, it returns a StringPredicate that represents the negation of a simple search condition.

```swift
// Swift native implementation
let result = !(text.contains("cat") && text.contains("bird"))

// StringContainsOperators implementation
let result = try text.contains(!("cat" && "bird"))
```

## `=~` Operator
The =~ operator creates a StringPredicate that performs a regular expression search for a given pattern.

```swift
// Swift native implementation
let pattern = "(quick|jumps).*fox"
let regex = try NSRegularExpression(pattern: pattern, options: [.caseInsensitive])
let range = NSRange(location: 0, length: text.utf16.count)
let result = regex.firstMatch(in: text, options: [], range: range) != nil

// StringContainsOperators implementation
let result = try text.contains(=~"(quick|jumps).*fox")
```

**Note that the =~ operator expects a valid regular expression pattern. If the pattern is invalid, an error will be thrown.**

## Usage

Here's a quick example of how you can use StringContainsOperators:

```swift
import StringContainsOperators

let text = "The quick brown fox jumps over the lazy dog."

// Check if text contains "quick" OR "jumps"
let result1 = try text.contains("quick" || "jumps")
print(result1) // true

// Check if text contains "fox" AND "dog"
let result2 = try text.contains("fox" && "dog")
print(result2) // true

// Check if text contains "fox" AND ("jumps" OR "swift")
let result3 = try text.contains("fox" && ("jumps" || "swift"))
print(result3) // true

// Check if text contains "Brown" OR "red" case insensitively and without diacritics
let result4 = try text.contains(~"Brown" || ~"red")
print(result4) // true

// Check if text contains "fox" AND ("Jumps" OR "swift") case insensitively and without diacritics
let result5 = try text.contains(~"fox" && (~"Jumps" || ~"swift"))
print(result5) // true

// Check if text does NOT contain "cat" AND "bird"
let result6 = try text.contains(!("cat" && "bird)")
print(result6) // true

// Check if text does NOT contain "brown"
let result7 = try text.contains(!"brown")
print(result7) // false

// Check if text does NOT contain "cat" case insensitively and without diacritics
let result8 = try text.contains(!~"cat")
print(result8) // true

// Check if text contains "quick" OR "jumps" AND "fox" using a regular expression
let result9 = try text.contains(=~"(quick|jumps).*fox")
print(result9) // true

// Check if text contains "jumps" OR "swift" AND "fox" using a regular expression
let result10 = try text.contains(=~"(jumps|swift).*fox")
print(result10) // true

```

### Complex Usage

With the StringContainsOperators, you can combine the different operators to create complex conditions to search for strings.

For example, let's say you have a list of book titles and you want to find all the books that contain the words "fantasy" or "magic" but do not contain the words "horror" or "thriller". You can use the ||, &&, and ! operators to create a complex search condition:

```swift
import StringContainsOperators

struct Book {
    let title: String
    let genre: String
}

let books = [
    Book(title: "The Lord of the Rings", genre: "fantasy"),
    Book(title: "Harry Potter and the Philosopher's Stone", genre: "fantasy"),
    Book(title: "The Hitchhiker's Guide to the Galaxy", genre: "science fiction"),
    Book(title: "The Shining", genre: "horror"),
    Book(title: "The Silence of the Lambs", genre: "thriller")
]

let searchCondition = (~"Fantasy" || ~"Science Fiction") && !(~"Horror" || ~"Thriller")

let filteredTitles = try books
   .filter { book in try book.genre.contains(searchCondition) }
   .map { $0.title }

print(filteredTitles) // ["The Lord of the Rings", "Harry Potter and the Philosopher's Stone", "The Hitchhiker's Guide to the Galaxy"]

```

In the example above, we created a searchCondition variable that combines the operators ||, &&, and !. We used this searchCondition with the contains method to filter the bookTitles array, resulting in only the books that match the complex search condition.

You can also use regular expressions to create complex search conditions. For example, let's say you have a list of email addresses and you want to find all the email addresses that start with "johndoe" and end with "gmail.com". You can use the =~ operator to create a regular expression search condition:

```swift
import StringContainsOperators

let emailAddresses = [
    "johndoe@gmail.com",
    "jane_doe@hotmail.com",
    "johndoe123@yahoo.com",
    "johndoe@gmail.com.br",
    "johndoe123@gmail.com"
]

let searchCondition = =~"^.*gmail\\.com$"

let filteredEmails = try emailAddresses.filter { email in
    return try email.contains(searchCondition)
}

print(filteredEmails) // ["johndoe@gmail.com"]
```

In this example, we created a searchCondition variable that uses a regular expression to match email addresses that start with "johndoe" and end with "gmail.com". We used the =~ operator to create the search condition and passed it to the contains method to filter the emailAddresses array, resulting in only the email addresses that match the search condition.

## How to Install

### SPM

You can install StringContainsOperators using Swift Package Manager (SPM). Simply add the following line to your dependencies in your Package.swift file:

```swift
.package(url: "https://github.com/Tavernari/StringContainsOperators.git", from: "1.3.0")
```

### Cocoapods

You can also install StringContainsOperators using CocoaPods. Simply add the following line to your Podfile:

```ruby
pod 'StringContainsOperators', '~> 1.3'
```

## Contributions

Contributions to StringContainsOperators are welcome! Before making a pull request, please open an issue to discuss your proposed changes. We follow the GitHub Flow for our development process.

Please note that this project is released with a Contributor Code of Conduct. By participating in this project you agree to abide by its terms.
