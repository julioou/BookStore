import CoreData

//protocol StorageProtocol {
//    func add(_ book: BookModel)
//    func remove(_ book: BookModel)
//    func contains(_ book: BookModel)
//}

class StorageManager: ObservableObject {
    
    let container: NSPersistentContainer

    static let shared = StorageManager()

    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }

    static var preview: StorageManager = {
        let result = StorageManager(inMemory: true)
        let viewContext = result.viewContext

        let book = Book(context: viewContext)
        book.author = "Aleksandra Motyka"
        book.title = "The Witcher Volume 4: Of Flesh and Flame"
        book.overview = "Based on the hit games by CD Projekt Red!\n\nGeralt is summoned by an old acquaintance to help solve a mystery involving his daughter. Upon arriving to investigate the situation, however, Geralt is surprised to find Dandelion, and the duo unexpectedly find themselves transported to regions beyond. After arriving in a dangerous and enigmatic location by mistake, they are forced to hide their identities while faced with an impossible task. Geralt works side by side with a local woman to defeat the dark forces plaguing the land but soon discovers that the situation at hand, in which he believes to be helping with, only leads to more trouble for the witcher and results in all signs pointing towards him as the prime suspect."
        book.buyLink = "https://www.kobo.com/pt/pt/ebook/the-witcher-volume-4-of-flesh-and-flame"
        book.imageUrl = "https://cdn.kobo.com/book-images/cb230613-26e9-47e1-b622-27fb2c1cf00d/353/569/90/False/the-witcher-volume-4-of-flesh-and-flame.jpg"

        shared.saveContext()

        return result
    }()

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "MainStorage")

        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }


    func saveContext() {
        let context = viewContext

        if context.hasChanges {
            do {
                try context.save()
            } catch {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }

    func deleteAllData() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MainStorage")
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try viewContext.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                viewContext.delete(objectData)
            }
        } catch let error {
            print("Detele all data in MainStorage error :", error)
        }
    }
}

//extension StorageManager: StorageProtocol {
//
//    func add(_ book: BookModel) {
//        objectWillChange.send()
//        book.insert(resort.id)
//        saveContext()
//    }
//    
//    func remove(_ book: BookModel) {
//        objectWillChange.send()
//        book.remove(resort.id)
//                saveContext()
//    }
//    
//    func contains(_ book: BookModel) -> BookModel {
//        book.contains(resort.id)
//    }
//}
