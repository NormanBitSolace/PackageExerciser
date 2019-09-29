import UIKit
import BlackLabsViewController

/// `AppNavigator` is repsonsible for creating `UIViewController`s. It can load and present them independently (e.g. no `segue`s) because it owns the root `UINavigationController`.
class AppNavigator {
    let window: UIWindow!
    var rootNavigationController: UINavigationController!
    var topViewController: UIViewController? {
        return rootNavigationController.topViewController
    }

    init(scene: UIWindowScene) {
        window = UIWindow(windowScene: scene)
        window.backgroundColor = UIColor.white
    }

    func setRootViewController(_ vc: UIViewController) {
        rootNavigationController = UINavigationController(rootViewController: vc)
        window.rootViewController = rootNavigationController
        window.makeKeyAndVisible()
    }

    func loadPetsViewController() -> PetsViewController {
        if let vc: PetsViewController = UIViewController.loadStoryboard("Pets") {
            return vc
        }
        fatalError("Unable to load PetsViewController.")
    }
}
