# README 🔥

This architecture is split in differents layers/concepts 🏋️‍♀️: 
* `Context`
* `Coordinators`
* `ViewControllers`
* `ViewModels`
* `Repositories`
* `Network`
* `Tests`

## Intro

Since I've been learning swift with Xcode at OpenClassrooms online school, I had to create some projects to validate my classes and become graduated.


## How to build the app in simulator or device

To build this app, please make sure you have a correct internet connection because it uses api request to receive data from the network.
You can clone the repo on your device and open it in your terminal.
To avoid heavy file, we created a gitignore file to ignore Pods.
Please write $pod install in your terminal at the root of the project.
Then cmd + b.

## Architecture

### Context

Context is the main object injected everywhere in the app. It has the responsibility to provide a dependencies injected first in the `AppDelegate`. Every new dependency should be injected through it.


#### Coordinator:

The coordinator is a separate entity responsible for navigation in application flows. With the help of the screen, it creates, presents and dismisses `UIViewControllers`, by keeping them separate and independent.
The coordinator can, create and run child coordinators too.
Since a coordinator is responsible for the entire flow of a specific flow (or stack), do not create a coordinator per viewController.
The only way of using a coordinator, is to instantiate it (by injecting into it if necessary some specific objects) and call the start () method, and **that's all**. 
The entire logic will be encapsulated by delegation for the rest of the navigation.

In this app there is one MainCoordinator which coordinates from the mainTabBar then 3 separate coordinators which coordinate each screen.
Weather Coordinator for the screen weather
ConverterCoordinator for the screen converter
TranslatorCoordinator for the screen translator

#### Network:

As indicated by its name, this layer provides different tools to make request in an efficient way. First, you have to create a client `HTTPClient` and an `URLRequest` or an `HTTPRequest` (depending on the needs, this part should be improved). At this time `HTTPRequest` are used to fetch Json data and parsing their response in cobble objects. For much bigger data like audio or images, you'll need to use basically `URLRequest`. This logic is handled by the `URLSessionEngine`.

Since a request could be cancelled by many different operations (dequeuing a cell, dismissing a view, etc.), each request should be sent with a token provided by the caller. If the caller is deinit, so the token too, and finally the request is cancelled.

The most useful things in this layer are the `Promise<T>` tool ; Which will help you to make requests, waiting for them to response and handle them as easy as you could imagine. The result will be directly provided by the next layer: `Repository`.

#### Repository:

This layer is responsible for calling the `Network` layer, and managing the data from it, in order to present it to the viewModel.

You can see that on the top of each repository, a protocol `RepositoryType` will allow us to test everything by dependency injection.

#### ViewModel:

The `ViewModel` encapsulates the whole logic which doesn't have to be in the ViewController. It's divided in two parts :

* **Inputs**: Every event from the viewController needs to be implemented in the viewModel, since it's listening for them. The main event which always needs to be added is `viewDidLoad()`.
* **Outputs**: After `viewDidLoad()`, the viewController is listening for some changes from the `viewModel`. For this, the `viewModel` needs to provide a reactive var for each data/state needed. The main rule is to keep separate the UI logic between viewModel and viewController, so keep in mind that a viewModel can only `import Foundation` -> reactive var can't provide data from `UIKit` like `UIImage` for example.

If your viewModel needs a `Repository`, so you'll need to inject a `RepositoryType`, in order to mock it more easily in the tests.

#### ViewController:

The last layer and not the least important. But as it is mentioned in its name, a `ViewController` only exists for **control**. So, if you want to test it, you'll only provide UI test, since the logic is extracted in the corresponding `ViewModel`. I recomend to add a custom snapshot to test it correctly. (Not provided in this project).


#### Tests

Please make sure you have an internet connection, since some of them needs to make direct requests, these parts should be for sure splited in a better way later (like launching network test only if the connection is available etc..).

Press `cmd+u` and let the magic green life be.

Thank you for your time for reading this, I hope that you'll have as pleasure as me to read it and understand the different parts. 
