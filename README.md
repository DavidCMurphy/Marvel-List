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

The benefits of this approach can be seen in the testing strategy, to use the same model and controller with a different networking layer we simply have make a new conforming object and dependancy inject it.

```swift
struct MockFetchResponse: FetchProtocol {
    
    typealias T = Response
    
    func fetch(_ url: String , _ type: T.Type, _ completion: @escaping (Result<T>) -> Void) {
        decodeFile( url, type, completion )
    }
}

let controller = CharacterListController( "TestResponse", ListViewModel(), MockFetchResponse() )

```

## What are the drawbacks?

All this does require a fair bit of thought, if you dont adequately scope functions that accept a protocol with an associated type you might run into.

> error: protocol 'Cachable' can only be used as a generic constraint because it has Self or associated type requirements

Or if you want to store an instance of that conforming object. To get around you will see a few instances of a concept known as [type erasure](https://medium.com/swiftworld/swift-world-type-erasure-5b720bc0318a).

While a bit of boilerplate i feel the benefits outweigh the drawbacks here.

## What improvements can i make?

I would love to use a proper binding library for the view models instead of the Dynamic class which is a very simple abstraction on Swift 4 property observers with closures, i only implemented one to one bindings because it was only needed in this case.

I could go more crazy with protocols, the controllers could be alot more flexible by applying the same principles, an example would be possibly adding the refresh control on the ListController through a protocol.

Breaking down the controllers through protocols would make mocking UI functionality possible.

The routing could be made to conform to the Model view Coordinator pattern.

![](https://media.giphy.com/media/YiAgKeS1AVR6AYfjEI/giphy.gif)

## Requirements

- iOS 10.0+
- Xcode 8.3.2+
- Swift 3.0+