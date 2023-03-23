Pod::Spec.new do |s|
  s.name         = "StringContainsOperators"
  s.version      = "1.1.1"
  s.summary      = "A Swift library for creating and evaluating complex string predicates using custom operators."
  s.description  = "StringContainsOperators provides custom operators and an enum type to create complex string predicates, which can be evaluated using the contains() function. This library is designed to be easy to use and flexible, allowing developers to create powerful string matching logic with minimal code."
  s.homepage     = "https://github.com/Tavernari/StringContainsOperators"
  s.license      = "MIT"
  s.author       = { "Victor Carvalho Tavernari" => "victortavernari@gmail.com" }
  s.source       = { :git => "https://github.com/Tavernari/StringContainsOperators.git", :tag => "#{s.version}" }
  s.source_files = "Sources/**/*.swift"
  s.ios.deployment_target     = '11.0'
  s.osx.deployment_target     = '10.13'
end
