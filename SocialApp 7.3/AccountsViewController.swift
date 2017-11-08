//
//  AccountsViewController.swift
//  SocialApp 7.3
//
//  Created by user131309 on 10/29/17.
//  Copyright © 2017 Patricia Toles. All rights reserved.
//

import UIKit
import Accounts

class AccountsViewController: UITableViewController {
    
    var twitterAccounts: NSArray?
    var accountStore : ACAccountStore?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        accountStore = ACAccountStore()
        
        
        let accountType : ACAccountType = accountStore!.accountType(withAccountTypeIdentifier: ACAccountTypeIdentifierTwitter)
        
        
        accountStore?.requestAccessToAccounts(with: accountType, options: nil,
                                              completion: { granted, error in
                                                
                                                if(granted)
                                                {
                                                    self.twitterAccounts = self.accountStore!.accounts(with: accountType) as NSArray?
                                                    
                                                    
                                                    if (self.twitterAccounts!.count == 0)
                                                    {
                                                        let noAccountsAlert : UIAlertController = UIAlertController(title: "No Accounts Found",
                                                                                                                    message: "No Twitter accounts were found.",
                                                                                                                    preferredStyle: UIAlertControllerStyle.alert)
                                                        
                                                        let dismissButton : UIAlertAction = UIAlertAction(title: "Okay",
                                                                                                          style: UIAlertActionStyle.cancel) {
                                                                                                            alert in
                                                                                                            noAccountsAlert.dismiss(animated: true, completion: nil)
                                                        }
                                                        
                                                        noAccountsAlert.addAction(dismissButton)
                                                        
                                                        DispatchQueue.main.async {
                                                            self.present(noAccountsAlert, animated: true, completion: nil) }
                                                        
                                                        
                                                        
                                                    }
                                                    else
                                                    {
                                                        DispatchQueue.main.async {
                                                            self.tableView.reloadData()
                                                            
                                                        }
                                                    }
                                                }
                                                
        })
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int {
            
            // Return the number of rows in the section.
            if let cellCount = self.twitterAccounts?.count {
                return cellCount
            } else {
                
                return 0
            }
    }
    
    
    
    
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


// MARK: - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation





// MARK: - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    if( segue.identifier == "ShowTweets")
    {
        
        if let path : IndexPath = self.tableView.indexPathForSelectedRow {
            
            if let account : ACAccount = self.twitterAccounts![path.row] as? ACAccount {
                let targetController = segue.destination as! FeedViewController
                targetController.selectedAccount = account
            }
            
        }
        
    }
    
    
}



