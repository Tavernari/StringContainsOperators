![Swift](https://github.com/Tavernari/StringContainsOperators/actions/workflows/swift.yml/badge.svg?branch=main)
[![Maintainability](https://api.codeclimate.com/v1/badges/29ffa494572357c62162/maintainability)](https://codeclimate.com/github/Tavernari/StringContainsOperators/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/29ffa494572357c62162/test_coverage)](https://codeclimate.com/github/Tavernari/StringContainsOperators/test_coverage)

# 🐞 StringContainsOperators

StringContainsOperators is a Swift library that simplifies searching for multiple strings within a given text. By using custom infix operators and predicates, you can create complex and flexible search patterns that make it easy to find if strings exist in your text.

![Example](https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExMTQxZTA5NzMyNGQ0NjQ2YzY2YmI4OGY5ODZjNGJiNWViNmI0OWE3OSZjdD1n/aWYYLfaHwbQAtuuWAM/giphy.gif)

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
