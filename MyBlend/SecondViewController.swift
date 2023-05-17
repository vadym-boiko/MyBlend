//
//  SecondViewController.swift
//  MyBlend
//
//  Created by Вадим Бойко on 18.12.2022.
//

import UIKit
import CoreData



class SecondViewController: UIViewController {
    
    
    // MARK: - Outlets
    
    // Модель списку блендів
    var blendList = BlendsList()
    
    // Таблиця
    @IBOutlet var table: UITableView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Завантажує список зі сховища
        blendList.downloadList()
        // Змінює навчальний текст в панелі навігації
        changeNavigationBarTitle()
    
        
    }
    
    
    // MARK: - Actions
    
    
    @IBAction func addNewBlandButoon(_ sender: Any) {
        addNewBlendAlert()
    }
    
    
    // MARK: - Functions
    
    // Функція яка викликає алерт додавання кави на 1 сцену
    func addCoffeeAlert (index: Int) {
        // Cтворюємо алерт контролер
        let alertController = UIAlertController(title: "Enter the amount of coffee", message: nil, preferredStyle: .alert )
        
        // Додавання textField
        alertController.addTextField { textField in
        textField.placeholder = "Weight kg" }
        
        // Кнопка створення
        let createButton = UIAlertAction(title: "Add", style: .default) {
            _ in
            
            
            
            // Створення бленду
            let blend = self.blendList.blends[index]
            
            // Додавання параметру кількості кави
            blend.weight = Float(alertController.textFields?[0].text ?? "0") ?? 0
            
            // Передача кави на перший екран
            self.addCoffeeOnFirstScreen(blend)
        }
        // Кнопка відміни
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        // Додавння кнопок до AlertController
        alertController.addAction(cancelButton)
        alertController.addAction(createButton)
        
        // Показ алерта
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    // Функція яка додає каву на першу сцену
    func addCoffeeOnFirstScreen(_ blend: Blend) {
        
        self.navigationController?.viewControllers.forEach {  viewController in
            (viewController as? ViewController)?.coffeeList.addCoffee(blend)
            
        }
        
    }
    
    
    // Функція створення нового бленду
    func addNewBlendAlert () {
        // Створення алерту
        let alertController = UIAlertController(title: "Formulate the blend", message: "If there are fewer types of coffee, just leave the fields", preferredStyle: .alert )
        
        // Додавання текстових полів
        alertController.addTextField { textField in
        textField.placeholder = "Name" }
        
        alertController.addTextField { textField in
        textField.placeholder = "Сoffee 1" }
        
        alertController.addTextField { textField in
        textField.placeholder = "Precentage of coffee 1" }
        
        alertController.addTextField { textField in
        textField.placeholder = "Сoffee 2" }
        
        alertController.addTextField { textField in
        textField.placeholder = "Precentage of coffee 2" }
        
        alertController.addTextField { textField in
        textField.placeholder = "Сoffee 3" }
        
        alertController.addTextField { textField in
        textField.placeholder = "Precentage of coffee 3 " }
        // Cтворення кнопки додавання
        let createButton = UIAlertAction(title: "Add", style: .default) {_ in
            // Перевірка на інформацію в поляї
            if alertController.textFields?[0].text?.isEmpty == true || alertController.textFields?[1].text?.isEmpty == true || alertController.textFields?[2].text?.isEmpty == true {
                return
            }
            // Ініціювання бленду
            let blend = Blend(context: self.blendList.context()!)
            // Додавання назви бленду
            blend.name = alertController.textFields?[0].text
            // Додавання ігформації про каву 1
            blend.coffee1 = alertController.textFields?[1].text ?? ""
            blend.percentageOfCoffee1 = Int64(alertController.textFields?[2].text ?? "0") ?? 0
            
            // Додавання ігформації про каву 2
            if alertController.textFields?[3].text?.isEmpty == false && alertController.textFields?[4].text?.isEmpty == false {
                blend.coffee2 = alertController.textFields?[3].text ?? ""
                blend.percentageOfCoffee2 = Int64(alertController.textFields?[4].text ?? "0") ?? 0
            }
            
            // Додавання ігформації про каву 3
            if alertController.textFields?[5].text?.isEmpty == false && alertController.textFields?[6].text?.isEmpty == false {
                blend.coffee3 = alertController.textFields?[5].text ?? ""
                blend.percentageOfCoffee3 = Int64(alertController.textFields?[6].text ?? "0") ?? 0
            }
            
            if (blend.percentageOfCoffee1 + blend.percentageOfCoffee2 + blend.percentageOfCoffee3) != 100 {
                return
            }
            
            // Додавання готового бленду в список
            self.blendList.addBlend(blend: blend)
            self.table.reloadData()
        }
        
        // Кнопка відміни
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        // Додавння кнопок до AlertController
        alertController.addAction(cancelButton)
        alertController.addAction(createButton)
        
        // Показ алерта
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    
    // Функція яка змінює заголовок панелі навігації із появою блендів
    func changeNavigationBarTitle() {
        if !self.blendList.blends.isEmpty {
            self.navigationItem.title = "Tap the bland to add"
        }
    }
}

// MARK: - Extensions

// Data source extension
extension SecondViewController: UITableViewDataSource, UITableViewDelegate {
    
    // Визначає кількість рядків
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blendList.blends.count
    }
    
    // Створює та іменує комірки
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        var configuration = cell.defaultContentConfiguration()
        configuration.text = blendList.blends[indexPath.row].name
        configuration.secondaryText = blendList.blendInfo(index: indexPath.row)
        cell.contentConfiguration = configuration
        
        return cell
    }
    
    // Функція яка викликається при кліку на комірку
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        addCoffeeAlert(index: indexPath.row)
    }
    
    
    // Налашктування свайпів
    
    // Метод якид повертає action для дії після свайпу зліва
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        
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
        blendList.deleteCoffee(blend: blendList.blends[index.row])
        blendList.downloadList()
        table.reloadData()
    }
                
}




