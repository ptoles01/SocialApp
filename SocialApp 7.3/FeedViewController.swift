//
//  FeedViewController.swift
//  SocialApp 7.3
//
//  Created by user131309 on 10/29/17.
//  Copyright © 2017 Patricia Toles. All rights reserved.
//

import UIKit
import Accounts
import Social

class FeedViewController: UITableViewController {
    
    // p. 253
    var selectedAccount : ACAccount!
    var tweets : NSMutableArray?
    var imageCache : NSCache<AnyObject, AnyObject>?
    var queue : OperationQueue?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = selectedAccount.accountDescription
        queue = OperationQueue()
        queue!.maxConcurrentOperationCount = 4
        retrieveTweets()
        
    }
    
    
    func retrieveTweets() {
        tweets?.removeAllObjects()
        if let account = selectedAccount {
            let requestURL =
                URL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json")
            
            if let request = SLRequest(forServiceType: SLServiceTypeTwitter,
                                       requestMethod: SLRequestMethod.GET,
                                       url: requestURL,
                                       parameters: [:]){
                
                request.account = account
                request.perform() {
                    responseData, urlResponse, error in
                    
                    if(urlResponse?.statusCode == 200) {
                        if(urlResponse?.statusCode == 200) {
                            do{
                                self.tweets = try JSONSerialization.jsonObject(with: responseData!, options: JSONSerialization.ReadingOptions.mutableContainers
                                    ) as? NSMutableArray
                                
                            }
                            catch let error as NSError{
                                print ("json eror: \(error.localizedDescription)")
                            }
                        }
                    }
                    
                    DispatchQueue.main.async() {
                        self.tableView.reloadData()
                    }
                }
                
            }
        }
        
        
        
        func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        // MARK: - Table view data source
        
        func numberOfSections(in tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return 0
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            return 0
        }
        
        /*
         override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
         
         // Configure the cell...
         
         return cell
         }
         */
        
        /*
         // Override to support conditional editing of the table view.
         override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
         // Return false if you do not want the specified item to be editable.
         return true
         }
         */
        
        /*
         // Override to support editing the table view.
         override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
         if editingStyle == .Delete {
         // Delete the row from the data source
         tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
         } else if editingStyle == .Insert {
         // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
         }
         }
         */
        
        /*
         // Override to support rearranging the table view.
         override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
         
         }
         */
        
        /*
         // Override to support conditional rearranging of the table view.
         override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
         // Return false if you do not want the item to be re-orderable.
         return true
         }
         */
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
         // Get the new view controller using segue.destinationViewController.
         // Pass the selected object to the new view controller.
         }
         */
        
    }
}
