import UIKit

final class ViewController: TableViewController {
    
    private let viewModel = ViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        self.title = "DataSource"
        view.addSubview(tableView)
        tableView.register(AboutCell.self, forCellReuseIdentifier: AboutCell.identifier)
        tableView.register(TopCell.self, forCellReuseIdentifier: TopCell.identifier)
        tableView.register(CategoryCell.self, forCellReuseIdentifier: CategoryCell.identifier)
        tableView.dataSource = viewModel
        tableView.delegate = self
    }
}
