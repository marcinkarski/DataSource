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
}

class Label: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        font = UIFont.systemFont(ofSize: 34, weight: .light)
        textAlignment = .left
        textColor = .gray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let item = items[section].sectionTitle
        let label = Label()
        label.text = item
        let view = UIView()
        view.addSubview(label)
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 16).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16).isActive = true
        view.backgroundColor = .white
        return view
    }
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
        return "Popular"
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
