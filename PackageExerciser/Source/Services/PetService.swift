import Foundation
import BlackLabsData

class PetService: DataService<PetModel> {
    init() {
        let base = "http://localhost:1234"
        let path = "pets"
        super.init(base: base, path: path)
    }
}
