import UIKit
import CoreData
var viaryList = [Note]()
class ViaryTableView: UITableViewController{
    
    var firstLoad = true
    func nonDeletedViary()->[Note]{
        var noDeletedViary = [Note]()
        for viary in viaryList {
            if(viary.deletedDate == nil){
                noDeletedViary.append(viary)
            }
        }
        return noDeletedViary
    }
    
    override func viewDidLoad() {
        if(firstLoad){
            firstLoad = false
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
            do {
                let results: NSArray = try context.fetch(request) as NSArray
                for result in results {
                    let viary = result as! Note
                    viaryList.append(viary)
                }
            } catch {
                print ("Fetch Failed")
            }
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viaryCell = tableView.dequeueReusableCell(withIdentifier: "viaryCellID", for: indexPath) as! ViaryCell
        let thisViary: Note!
        thisViary = nonDeletedViary()[indexPath.row]
        viaryCell.titleLabel.text = thisViary.title
        viaryCell.descLabel.text = thisViary.dateAdded
        return viaryCell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nonDeletedViary().count
    }
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "editViary", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "editViary"){
            let indexPath = tableView.indexPathForSelectedRow!
            let viaryDetail = segue.destination as? ViaryDetailVC
            let  selectedViary: Note!
            selectedViary = nonDeletedViary()[indexPath.row]
            viaryDetail!.selectedViary = selectedViary
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
}
