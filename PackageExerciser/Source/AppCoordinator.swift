import UIKit
import BlackLabsData

/// `AppCoordinator` contains all navigational flow logic as well as hiding services from UI concerns.
final class AppCoordinator: NSObject {

    let navigator: AppNavigator

    init(appNavigator: AppNavigator) {
        self.navigator = appNavigator
        super.init()
    }

    func start() {
        let vc = navigator.loadPetsViewController()
        navigator.setRootViewController(vc)
        setPetData(vc)
    }

    private func setPetData(_ vc: PetsViewController) {
        // show loading
        PetService().get { pets in
            if let pets = pets {
                // All formatting, localization, etc. should be done when creating view model so UIView's can just set properties without logic
                let vmList = pets.compactMap { PetViewModel(pet: $0) }
                vc.data = vmList
                // hide loading
            }
        }
    }
}
