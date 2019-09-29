import Foundation
import BlackLabsDate

struct PetViewModel {
    let id: Int
    let name: String
    let dob: String
}

extension PetViewModel {
    init(pet: PetModel) {
        self.id = pet.id ?? -1
        self.name = pet.name
        let date = Date.parse(pet.dob, format: "MM/dd/yyyy")
        self.dob = date.dateString("MMMM dd, yyyy")
    }
}
