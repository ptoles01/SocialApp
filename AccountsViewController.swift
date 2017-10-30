//
//  AccountsTableViewController.swift
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
        
        
        let accountType : ACAccountType = accountStore!.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
        
        
        accountStore?.requestAccessToAccountsWithType(accountType, options: nil,
                                                      completion: { granted, error in
                                                        
                                                        if(granted)
                                                        {
                                                            self.twitterAccounts = self.accountStore!.accountsWithAccountType(accountType)
                                                            
                                                            
                                                            if (self.twitterAccounts!.count == 0)
                                                            {
                                                                let noAccountsAlert : UIAlertController = UIAlertController(title: "No Accounts Found",
                                                                    message: "No Twitter accounts were found.",
                                                                    preferredStyle: UIAlertControllerStyle.Alert)
                                                                
                                                                let dismissButton : UIAlertAction = UIAlertAction(title: "Okay",
                                                                style: UIAlertActionStyle.Cancel) {
                                                                    alert in
                                                                    noAccountsAlert.dismissViewControllerAnimated(true, completion: nil)
                                                                }
                                                                
                                                                noAccountsAlert.addAction(dismissButton)
                                                                
                                                                dispatch_async(dispatch_get_main_queue()) {
                                                                    self.presentViewController(noAccountsAlert, animated: true, completion: nil) }
                                                                
                                                                
                                                                
                                                            }
                                                            else
                                                            {
                                                                dispatch_async(dispatch_get_main_queue()) {
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
    
    
    
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int)
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




/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */


