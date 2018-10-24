import UIKit

class DataSource: NSObject {
    
    var items = [URLSessionDataTask]()
    
    func loadData(withUsername username: String) {
        loadProfile(withUsername: username)
    }
    
    func loadProfile(withUsername username: String) {
        let base: String = "https://api.github.com/users/"
        guard let url = URL(string: base + username) else { return }
        let service = APIService()
        let task = service.request(url) { [weak self] (result: Result<Profile>) in
            switch result {
            case .success(let profile):
                self?.profileView.configure(with: profile)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        items.append(task)
    }
    
    func fetchUser() {
        items.forEach { $0.cancel() }
        loadData(withUsername: selectedName)
        print(selectedName)
    }
    
//    let items: [Model] = {
//        let img1 = Model(name: "Puerto del Carmen", image: "img1")
//        let img2 = Model(name: "Roque Nublo", image: "img2")
//        let img3 = Model(name: "La Santa", image: "img3")
//        let img4 = Model(name: "Playa de Las Teresitas", image: "img4")
//        let img5 = Model(name: "Playa de La Tejita", image: "img5")
//        return [img1, img2, img3, img4, img5]
//    }()
}

extension DataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: TableCell.identifier, for: indexPath) as! TableCell
        cell.imageBox = item
        return cell
    }
}
