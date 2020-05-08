//
//  EventsTableViewController.swift
//  TimeTill
//
//  Created by Kenneth Jones on 5/8/20.
//  Copyright © 2020 Kenneth Jones. All rights reserved.
//

import UIKit
import EventKit

class EventsTableViewController: UITableViewController {
    
    var titles: [String] = []
    var startDates: [Date] = []
    var store = EKEventStore()
    var events: [EKEvent] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        store.requestAccess(to: .event) { (granted, error) in
            if let error = error {
                NSLog("There was a error. Here it is: \(error)")
            }
            
            if granted {
                // The app works and the data is populated
                let calendars = self.store.calendars(for: .event)
                
                for (_, calendar) in calendars.enumerated() {
                    let predicate = self.store.predicateForEvents(withStart: Date(), end: Date(timeIntervalSinceNow: 1.261e+8), calendars: [calendar])
                    let matchingEvents = self.store.events(matching: predicate)
                    
                    for event in matchingEvents {
                        self.events.append(event)
                    }
                }
            } else {
                // Show an alert telling user to give permission to access calendar data
                // The app doesn't attempt to access calendar data until permission is given
                let alertController = UIAlertController(title: "Permission Required", message: "This app needs permission to access your calendar. You can give permission in Settings.", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Go to Settings", style: .default) { (_) in
                    self.openSettings()
                }
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                
                alertController.addAction(alertAction)
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print(events)
        
        self.tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(events)
        
        self.tableView.reloadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(events.count)
        if events.count == 0 {
            return 1
        } else {
            return events.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath)

        print(events.count)
        if events.count == 0 {
            // Configure cell saying yo we need permission to access calendar
        } else {
            // Configure normal cell
        }

        return cell
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
    
    // Function to open settings app if user initially denies calendar permission
    private func openSettings() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
            return
        }

        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                print("Settings opened: \(success)") // Prints true
            })
        }
    }

}
