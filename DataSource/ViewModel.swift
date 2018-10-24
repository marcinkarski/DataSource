import UIKit

enum ViewModelItemType {
    case about
    case top
    case category
}

protocol ViewModelItem {
    var type: ViewModelItemType { get }
    var sectionTitle: String { get }
    var rowCount: Int { get }
}

class ViewModel: NSObject {
    
    var items = [ViewModelItem]()
    
    override init() {
        super.init()
        guard let data = dataFromFile("ServerData"), let model = Model(data: data) else { return }
        
        if let about = model.about {
            let aboutItem = ViewModelAboutItem(about: about)
            items.append(aboutItem)
        }
        let top = model.top
        if !model.top.isEmpty {
            let topItem = ViewModelTopItem(top: top)
            items.append(topItem)
        }
        let category = model.category
        if !category.isEmpty {
            let categoryItem = ViewModelCategoryItem(category: category)
            items.append(categoryItem)
        }
    }
}

extension ViewModel: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.section]
        switch item.type {
        case .about:
            if let cell = tableView.dequeueReusableCell(withIdentifier: AboutCell.identifier, for: indexPath) as? AboutCell {
                cell.item = item
                return cell
            }
        case .top:
            if let item = item as? ViewModelTopItem, let cell = tableView.dequeueReusableCell(withIdentifier: TopCell.identifier, for: indexPath) as? TopCell {
                let top = item.top[indexPath.row]
                cell.item = top
                return cell
            }
        case .category:
            if let item = item as? ViewModelCategoryItem, let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.identifier, for: indexPath) as? CategoryCell {
                cell.item = item.category[indexPath.row]
                return cell
            }
        }
        return UITableViewCell()
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return items[section].sectionTitle
//    }
}

class ViewModelAboutItem: ViewModelItem {
    var type: ViewModelItemType {
        return .about
    }
    
    var sectionTitle: String {
        return "About"
    }
    
    var rowCount: Int {
        return 1
    }
    
    var about: String
    
    init(about: String) {
        self.about = about
    }
}

class ViewModelTopItem: ViewModelItem {
    var type: ViewModelItemType {
        return .top
    }
    
    var sectionTitle: String {
        return "Top"
    }
    
    var rowCount: Int {
        return top.count
    }
    
    var top: [Top]
    
    init(top: [Top]) {
        self.top = top
    }
}

class ViewModelCategoryItem: ViewModelItem {
    var type: ViewModelItemType {
        return .category
    }
    
    var sectionTitle: String {
        return "Island"
    }
    
    var rowCount: Int {
        return category.count
    }
    
    var category: [Category]
    
    init(category: [Category]) {
        self.category = category
    }
}
