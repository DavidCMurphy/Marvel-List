Marvel List
==========================

A simple application that queries the [marvel api](https://developer.marvel.com/) for a list of marvel characters, displays them and allow the user to select a character to select one and view their details.

This application was built using the MVVM architecture with no third party frameworks. The goal here was to use generics and protocols to keep the bulk of the code free from concrete types and thus more reusable.

## Why this approach?

You will notice that the controllers and view models used to inject them with data are all generic, In fact in order to use the same application with a completely different dataset and endpoint you only need to conform to 3 protocols:

* ListModelProtocol

* DetailModelProtocol

* FetchProtocol

This flexibility is achieved through [composition rather than inheritance](https://en.wikipedia.org/wiki/Composition_over_inheritance) while still being entirely type safe.

The benefits of this approach can be seen in the testing strategy, to use the same model and controller with a different networking layer we simply have make a new conforming object and dependency inject it.

```swift
struct MockFetchResponse: FetchProtocol {
    
    typealias T = Response
    
    func fetch(_ url: String , _ type: T.Type, _ completion: @escaping (Result<T>) -> Void) {
        decodeFile( url, type, completion )
    }
}

let controller = CharacterListController( "TestResponse", ListViewModel(), MockFetchResponse() )

```

## Requirements

- iOS 10.0+
- Xcode 8.3.2+
- Swift 3.0+
