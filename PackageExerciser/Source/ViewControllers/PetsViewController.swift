import UIKit

class PetsViewController: UITableViewController {
    var data: [PetViewModel]! {
        didSet { DispatchQueue.main.async { self.tableView.reloadData() } }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pets"
    }

    final override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 0
    }

    final override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "generic")
        let vm = data[indexPath.row]
        cell.textLabel?.text = vm.name
        cell.detailTextLabel?.text = vm.dob
        return cell
    }
}
