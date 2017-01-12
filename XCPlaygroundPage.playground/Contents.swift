//: Playground - noun: a place where people can play

import UIKit
import XCPlayground

struct Person {
    let name: String
    let city: String
    init(name: String, city: String) {
        self.name = name
        self.city = city
    }
}

let people = [
    Person(name: "Shuichi", city: "Yokohama"),
    Person(name: "Kengo", city: "Kyoto"),
    Person(name: "Shogo", city: "Korea"),
    Person(name: "Tagahara", city: "Mars")
]

class MyTableViewController: UITableViewController {
    
    let items: [Person]
    let cellStyle: UITableViewCellStyle
    let configureCell: (_ cell: UITableViewCell, _ item: Person) -> ()
    
    init(style: UITableViewStyle, items: [Person], cellStyle: UITableViewCellStyle, editable: Bool, configureCell: @escaping (_ cell: UITableViewCell, _ item: Person) -> ()) {
        
        self.items = items
        self.cellStyle = cellStyle
        self.configureCell = configureCell
        
        super.init(style: style)
        
        if editable {
            navigationItem.leftBarButtonItem = UIBarButtonItem(
                title: "Edit",
                style: .plain,
                target: self,
                action: #selector(MyTableViewController.edit(_:))
            )
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items.count
    }
    
    func edit(_ sender: AnyObject) {
        
        tableView.isEditing = !tableView.isEditing
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: cellStyle, reuseIdentifier: nil)
        configureCell(cell, items[indexPath.row])
        
        return cell
    }
}


let tableVC = MyTableViewController(
    style: .plain,
    items: people,
    cellStyle: .subtitle,
    editable: true) { cell, item in
        
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = item.city
}

tableVC.title = "Person"

let navigationController = UINavigationController(rootViewController: tableVC)

navigationController.view.frame = CGRect(x: 0, y: 0, width: 320, height: 480)


XCPlaygroundPage.currentPage.needsIndefiniteExecution = true
XCPlaygroundPage.currentPage.liveView = navigationController.view


