import UIKit
import CoreData
class ViaryDetailVC: UIViewController {

    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var descriptionTV: UITextView!
    
    var selectedViary: Note? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(selectedViary != nil){
            titleTF.text = selectedViary?.title
            descriptionTV.text = selectedViary?.desc
        }
    }

    @IBAction func saveAction(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        if(selectedViary == nil){
            let entity = NSEntityDescription.entity(forEntityName: "Note", in: context)
            let newViary = Note(entity: entity!, insertInto: context)
            newViary.id = viaryList.count as NSNumber
            newViary.title = titleTF.text
            newViary.desc = descriptionTV.text
            do{
                try context.save()
                viaryList.append(newViary)
                navigationController?.popViewController(animated: true)
            }
            catch{
                print("Context Save Error")
            }
        }else{
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
            do {
                let results: NSArray = try context.fetch(request) as NSArray
                for result in results {
                    let viary = result as! Note
                    if(viary == selectedViary){
                        viary.title = titleTF.text
                        viary.desc = descriptionTV.text
                        try context.save()
                        navigationController?.popViewController(animated: true)
                    }
                }
            } catch {
                print ("Fetch Failed")
            }
        }
        
    }
    @IBAction func DeleteViary(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        do {
            let results: NSArray = try context.fetch(request) as NSArray
            for result in results {
                let viary = result as! Note
                if(viary == selectedViary){
                    viary.deletedDate = Date()
                    try context.save()
                    navigationController?.popViewController(animated: true)
                }
            }
        } catch {
            print ("Fetch Failed")
        }
    }
    
    
}

