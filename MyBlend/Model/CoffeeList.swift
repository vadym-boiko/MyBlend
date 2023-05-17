//
//  CoffeeList.swift
//  MyBlend
//
//  Created by Вадим Бойко on 25.01.2023.
//

import Foundation

// MARK: Клас списку кави
class CoffeeList {
    
    // Масив блендів
    var blends: [Blend] = []
    
    // Підраховую суму ваги усієї кави і перераховує коли та змінюється
    var totalWeight: Float? {
        var totalWeight: Float = 0
        var oldArr: [Blend]?
        if blends != oldArr {
            oldArr = blends
            for blend in blends {
                totalWeight += blend.weight
            }
        }
        return totalWeight
    }
    
    // Cловник із назвою кави її кількістю
    private var allCoffeeDictionary: Dictionary <String, Float> = [:]
    
    // Масив із строками значень словника више
    var allCoffeeArr: [String] {
        var array: [String] = []
        // Ініціалізація форматера
        let formatter: NumberFormatter = NumberFormatter()
        formatter.numberStyle = .decimal
        // Форматування і створення рядку
        for (key, value) in self.allCoffeeDictionary {
            if key.isEmpty || value == 0 {
                continue
            }
            array.append("\(key)  \(formatter.string(from: NSNumber(value: value))!)")
        }
        return array
    }

    // Метод який додає каву і обєднює якщо назва кави одинакова
    func addCoffee(_ coffee: Blend) {
        
        guard !self.blends.isEmpty else {
            blends.append(coffee)
            print("0")
            return
        }
        
        // виконує дію із кожним блендом !!!!!!!!!!!!!!!!!!!!!
        if let blendIndex = self.blends.firstIndex(where: {$0.name == coffee.name}) {
            blends[blendIndex].weight += coffee.weight
        } else {
            blends.append(coffee)
        }
        
    }
    
    // Метод який видаляє каву
    func deleteCofee(index: IndexPath) {
        blends.remove(at: Int("\(index.row)")!)
        self.sumCoffee()
    }
    
    
    
    // Підраховує відсоток і поміщає у словник види кави
    func sumCoffee() {
        // Oчищує словник
        self.allCoffeeDictionary.removeAll()
        
        
        
        // Цикл для окремого бленду в blends
        for blend in blends{
            // Цикл для властивостей кожного бленду
            for number in 1...3  {
                
                // Змінні кави і її відсотку
                // Присвоєння їм значень
                guard let currentCoffee: String = blend.value(forKey: "coffee" + String(number)) as? String else {
                    continue
                }
                guard let currentPercentage: Float = blend.value(forKey: "percentageOfCoffee" + String(number))  as? Float else {
                    continue
                }
                
                // Перевірка чи була кава вже додана і додавання кави
                if allCoffeeDictionary.keys.contains(currentCoffee){
                    allCoffeeDictionary[currentCoffee]! += ((blend.weight * currentPercentage) / 100 )
                } else {
                    allCoffeeDictionary[currentCoffee] = ((blend.weight * currentPercentage) / 100 )
                }
          }
      }
  }
    
}





