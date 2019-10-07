This repository implements a straightforward app with Swift Package Manager (SPM) dependencies. It is architected using:
1. **App Coordinator** - responsible for logic controlling view controller flow and data sources so view controller's are unaware of service and model layer.
1. **App Navigator** - responsible for instantiating view controllers and optionally associating them with storyboards.
1. **Data Services** - hide model and model access concerns behind API.
1. **View Model** - responsible for creating light weight view model objects so that UIView and subclasses can set properties without logic, combing models of different types, formatting, localization, etc. Buisness logic concerns like if a data service needs to be combined with DispatchGroup for parallel processing may be contained here too.

Separating these concerns out of `UIViewController` has additional value in making it much easier to test these concerns without UIKit dependencies or lifecycle concerns.

### App Coordinator

The `AppCoordinator` class encapsulates buisness logic which determines which screens are shown and in which order. This serves to make `UIViewController`s less complex as well as making them reusable. Using a `AppCoordinator` rather than segue relationships defined in `Interface Builder` and `UIViewController`'s `prepareForSegue` methods has many advantages:
1. `UIViewController`'s are reusable and easily re-orederable.
1. `UIViewController`'s dont' contain flow logic.
1. `UIViewController`'s dont' need to know about destination `UIViewController` types, delegates, or data requirements.
1. `UIViewController`'s dont' require access to data services or non view model model types.
1. `UIViewController`'s data access is not tied to it's lifecycle mehtods e.g. `viewDidLoad`.

In this app the cordinated decides which `UIViewController` to load first. It accesses the data service layer, can show a loading `UIViewController`, can decide where to navigated if data loading fails, can convert returned model to view model, and can hand off the view model without the `UIViewController` knowing about any of these concerns.

### App Navigator

The `AppNavigator` class encapsulates `UIViewController` loading, intializing, and and storyboard association. It creates and owns the app's root navigation controller. This means that it can load all subsequent `UIViewController` independently (no seques required). The `AppNavigator` also serves a logical place to encapsluate related details e.g. popover, modal, and child `UIViewController` concerns. As of iOS 13 the `SceneDelegate` uses dependency injection to insert the `AppNavigator` into the `AppCoordinator`.

### Data Services

Data storage details are hidden behind data service async API. The app is unaware of the backing store be it a remote database, remote REST API, or a local file or UserDefaults. This is another excellent candidate for Dependency Injection so tests can rely on expected data without network concerns. By making the API async it enables local storage to be called identically to remote which can have nice development and testing consequences.


### View Model

View Model serve as another approach to remove business logic, localization, and formatting from `UIView`. View Model also can combine multiple model types hiding such details from `UIView`. The goal is to have `UIView` set properties of the view model on themselves. View Model builders may also encapsulate data aquisition logic, e.g. when parallel data are made and view model is not valid to all concerns return.

