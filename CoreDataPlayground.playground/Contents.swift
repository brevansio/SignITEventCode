//: Playground - noun: a place where people can play

import UIKit
import CoreData

func buildDataStack () {
    let mainContext = NSManagedObjectContext.init(concurrencyType: .mainQueueConcurrencyType)

    let modelURL = Bundle.main.url(forResource: "CoreDataExample", withExtension: "momd")!
    guard let objectModel = NSManagedObjectModel.init(contentsOf: modelURL) else {
        // Error
        return
    }

    let psc = NSPersistentStoreCoordinator.init(managedObjectModel: objectModel)
    mainContext.persistentStoreCoordinator = psc

    DispatchQueue.global(qos: .background).async {
        let options = [NSSQLitePragmasOption:["journal_mode":"DELETE"]]
        
        var storeURL = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first!
        storeURL.appendPathComponent("Database.sqlite")
        
        do{
            try psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: options)
        }
        catch {
            // Error
            return
        }
        
        DispatchQueue.main.sync {
            // Callback if needed
        }
    }
}
