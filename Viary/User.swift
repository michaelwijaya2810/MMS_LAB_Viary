import CoreData

@objc(User)
class User: NSManagedObject{
    @NSManaged var userID: NSNumber!
    @NSManaged var username: String!
    @NSManaged var pin: String!
    @NSManaged var email: String!
}
