//
//  ViewController.swift
//  MyBlend
//
//  Created by Вадим Бойко on 18.12.2022.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    
// MARK: - Outlets and properties
    
    @IBOutlet weak var firstTable: UITableView!
    @IBOutlet weak var secondTable: UITableView!
    
    @IBOutlet weak var lable: UILabel!
    
    // Ініціалізація обєкту Coffee List
    var coffeeList = CoffeeList()
    
// MARK: - View controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Перезавантажує дані першої таблиці
        firstTable.reloadData()
        // Підраховує загальну суму кави
        coffeeList.sumCoffee()
        // Перезавантажує дані другої таблиці
        secondTable.reloadData()
        //Присвоює лейблу значення загальної ваги
        lable.text = "Total weight \(coffeeList.totalWeight ?? 0)"
    }

    
// MARK: - Functions

    
}




// MARK: - Extensions

// Data source and delegate extension
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    // Визначає кількість рядків
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Для першої таблиці
        if tableView == firstTable {
            return coffeeList.blends.count
        } else {
        // Для другої таблиці
            return coffeeList.allCoffeeArr.count
        }
    }
    
    
    // Створює та іменує комірки
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Для першої таблиці
        if tableView == firstTable {
            let cell = UITableViewCell()
            
            var configuration = cell.defaultContentConfiguration()
            // Вікористовує властивість blends обєкту  coffeeList
            configuration.text = self.coffeeList.blends[indexPath.row].name
            
            // Ініціалізація форматера
            let formatter: NumberFormatter = NumberFormatter()
            formatter.numberStyle = .decimal
            
            configuration.secondaryText = formatter.string(from: NSNumber(value: self.coffeeList.blends[indexPath.row].weight))!
            
            cell.contentConfiguration = configuration
            
            return cell
        } else {
        // Для другої таблиці
            let cell = UITableViewCell()
            
            var configuration = cell.defaultContentConfiguration()
            // Вікористовує властивість allCoffeeArr обєкту  coffeeList
            configuration.text = self.coffeeList.allCoffeeArr[indexPath.row]
    
            cell.contentConfiguration = configuration
            
            return cell
        }
    }
    
    
    // Налашктування свайпів
    
    // Метод якид повертає action для дії після свайпу зліва
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        guard tableView == firstTable else {
            return .none
        }
        
        let delete = UIContextualAction(style: .destructive, title: "Delete") {
                [weak self] (action, wiev, completionHandler) in
            self?.handleToDelete(index: indexPath)
            completionHandler(true)
        }
        
        delete.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    
    // Метод якид повертає action для дії після свайпу справа
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        guard tableView == firstTable else {
            return .none
        }
        
        let delete = UIContextualAction(style: .destructive, title: "Delete") {
                [weak self] (action, wiev, completionHandler) in
            self?.handleToDelete(index: indexPath)
            completionHandler(true)
        }
        delete.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    // Фукція яка виконується по свайпу
    private func handleToDelete(index: IndexPath) {
        coffeeList.deleteCofee(index: index)
        firstTable.reloadData()
        secondTable.reloadData()
    }
    
    
}
