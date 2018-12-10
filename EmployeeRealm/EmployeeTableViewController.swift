//
//  EmployeeTableViewController.swift
//  EmployeeRealm
//
//  Created by Asem Qaffaf on 12/1/18.
//  Copyright © 2018 Asem Qaffaf. All rights reserved.
//

import UIKit
import RealmSwift

class EmployeeTableViewController: UITableViewController {
//EmployeeCell
    var arr: Results<Employee>!
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(realm.configuration.fileURL?.path)
        fetch()
  
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

   

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    
        return arr?.count ?? 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeCell", for: indexPath)
        if (arr?.count) != nil{
             cell.textLabel?.text = "\(arr[indexPath.row].dateOFHire)"
        }else{
            cell.textLabel?.text = "No Employee has been found"
        }
        
        return cell
    }
    

    //MARK: ---- ADD AND FETCH DATA
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        promptAlert()
    }
    
    
    
    func promptAlert()  {
        var itemTextField = UITextField()
        let alert = UIAlertController(title: "add a new Employee", message: "", preferredStyle: .alert)
        alert.addTextField { (TextField) in
            itemTextField = TextField
        }
        let action = UIAlertAction(title: "Add", style: .default) { (UIAlertAction) in
            if itemTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false{
            let item = Employee()
            item.name = itemTextField.text!
            item.dateOFHire = Date()
             
            self.save(emp: item)
            self.tableView.reloadData()
            }
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    func save(emp: Employee)  {
        do{
          try realm.write {
                realm.add(emp)
            }
        }catch{
            print("error saving Data \(error)")
        }
    }
    func fetch()  {
        arr = realm.objects(Employee.self)
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "AccountSegue", sender: self)
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
        let tb = segue.destination as! AccountTableViewController
    
        if let index = tableView.indexPathForSelectedRow{
        
            tb.parents = arr[index.row]
        }
//        tb.parents =
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
