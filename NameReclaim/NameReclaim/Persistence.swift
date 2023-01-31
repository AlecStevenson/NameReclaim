//
//  Persistence.swift
//  NameReclaim
//
//  Created by alec stevenson on 10/10/22.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        tempNum = 0
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        for _ in 0..<1 {
            let newItem = Item(context: viewContext)
            newItem.name = "Alec Stevenson"
            newItem.profile = "anstevenson1"
            newItem.photo = ""
            newItem.location = "916 S. College Ave"
            newItem.time = ""
            newItem.physical = "Tall Caucasian Male"
            newItem.details = "CS Student at DePauw University"
            newItem.storedImage = Data()
            tempNum += 1
            newItem.number = tempNum
            
        }
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "NameReclaim")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
