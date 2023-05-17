//
//  BlendsList.swift
//  MyBlend
//
//  Created by Вадим Бойко on 16.03.2023.
//

import UIKit
import Foundation
import CoreData


class BlendsList {
    
    // Масив блендів
    var blends: [Blend]!
    // Контекст
    var context = { () -> NSManagedObjectContext? in
        var appDelagate = UIApplication.shared.delegate as? AppDelegate
        return appDelagate?.persistentContainer.viewContext
    }
    
    // Функція яка завантажує список із сховища
    func downloadList() {
        
        let fetchRequest: NSFetchRequest<Blend> = Blend.fetchRequest()
        
        do {
            self.blends = try context()!.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // Функція яка додає бленд
    func addBlend(blend: Blend) {
        blends.append(blend)
        self.saveList()
    }
    
    // Функція яка видаляє бленд
    func deleteCoffee(blend: Blend) {
        let appDelagate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelagate.persistentContainer.viewContext
        
        context.delete(blend)
        
        self.saveList()
        }
    
    // Функція яка повертає інформацію про бленд в рядку
    func blendInfo(index: Int) -> String {
        let blend = self.blends[index]
        var info: String = ""
        
        if blend.percentageOfCoffee1 != 0 && blend.coffee1 != nil {
            info += "\(blend.coffee1!) \(blend.percentageOfCoffee1)%"
        }
        
        if blend.percentageOfCoffee2 != 0 && blend.coffee2 != nil {
            info += ", \(blend.coffee2!) \(blend.percentageOfCoffee2)%"
        }
        
        if blend.percentageOfCoffee3 != 0 && blend.coffee3 != nil {
            info += ", \(blend.coffee3!) \(blend.percentageOfCoffee3)%"
        }
        
        return info
        
    
    }
    
    
    // Функція яка зберігає список в Core Data
    private func saveList () {
        let appDelagate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelagate.persistentContainer.viewContext
        
        if context.hasChanges {
                  do {
                      try context.save()
                  } catch {
                    context.rollback()
                      let nserror = error as NSError
                      fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                  }
        }
        
    }
    
    
    
}


