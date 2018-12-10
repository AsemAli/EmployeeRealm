//
//  AccountTableViewController.swift
//  EmployeeRealm
//
//  Created by Asem Qaffaf on 12/1/18.
//  Copyright © 2018 Asem Qaffaf. All rights reserved.
//

import UIKit
import RealmSwift
class AccountTableViewController: UITableViewController {

    //AccountSegue
    //AccountCell
    let realm = try! Realm()
    var arrAccount: Results<Account>!
    
    var parents : Employee?{
        didSet{
            fetchData()
//            print(parents?.name)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
//        print(parents.list1)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

  

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrAccount?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountCell", for: indexPath)

        if arrAccount != nil{
            cell.textLabel?.text = String(arrAccount[indexPath.row].balance)
        }
        else{
            cell.textLabel?.text = "no Account has been added here"
        }
        return cell
    }
 
    //MAKR: ADD AND FETCH DATA
    
    @IBAction func addAccountPressed(_ sender: UIBarButtonItem) {
        addedmenu()
    }
    func addedmenu(){

    
        
        var balanceText = UITextField()
        let alert = UIAlertController(title: "Add a new employee's balance", message: "", preferredStyle: .alert)
        
        alert.addTextField { (TextField) in
        TextField.keyboardType = .numberPad
            balanceText = TextField
        }
        let action = UIAlertAction(title: "Add", style: .default) { (UIAlertAction) in
            if balanceText.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == true{
                print("aa")
            }else {
                if let insanceBalance = Double(balanceText.text!){
                        let newiestAccount = Account()
                        newiestAccount.balance = insanceBalance
                        self.save(balance: newiestAccount)
                        

                    self.tableView.reloadData()
                                    }
            }
        }
    
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    func save(balance:  Account)  {
        
        do{
          try realm.write {
//                realm.add(balance)
            if let currentemp = parents{
                currentemp.list1.append(balance)
            }
            }
        }catch{
            print("error saving Files")
        }
    }
    func fetchData()  {
//        arrAccount = realm.objects(Account.self)
        arrAccount = parents?.list1.sorted(byKeyPath: "balance",ascending: true)
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
