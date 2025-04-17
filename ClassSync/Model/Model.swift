import CoreData

struct persistencecontroller {
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "ClassSync")
        
        container.loadPersistentStores(completionHandler: { (storeDescriptin, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error)")
            }
        })
    }
}
