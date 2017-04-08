//
//  NEPhotoTableViewController.swift
//  CS51-Demo
//
//  Created by Nathan Eidelson on 3/26/17.
//  Copyright © 2017 Nathan Eidelson. All rights reserved.
//

import UIKit

class NEPhotoLogTableViewController: UITableViewController {
    // This could have also been stored in the PhotoLog model,
    // as a class variable.
    var photoLogs: [PhotoLog] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PhotoLog.fetchAll { (success) in
            self.photoLogs = PhotoLog.photoLogs
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // _ allows you to exclude the first parameter's name when calling this function.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.photoLogs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // This is the function you need to implement in order to style each individual cell.
        // Don't forget the reuse identifier, and make sure it matches the identifer you have set in the storyboard.
        let cell = tableView.dequeueReusableCell(withIdentifier: "photoTableCell", for: indexPath)

        let photoLog = PhotoLog.photoLogs[indexPath.row]
        cell.textLabel?.text = photoLog.name
        cell.imageView?.image = photoLog.image

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100;
    }
    
    @IBAction func onAddClick(_ sender: Any) {
        let NEPhotoLogDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "NEPhotoLogDetailViewController") as! NEPhotoLogDetailViewController
        
        let navigationController = UINavigationController(rootViewController: NEPhotoLogDetailViewController)
        
        self.present(navigationController, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "photoLogDetailPush" {
            let toViewController = segue.destination as! NEPhotoLogDetailViewController
            
            if let indexPath = self.tableView.indexPathForSelectedRow {
                toViewController.photoLog = self.photoLogs[indexPath.row]
            }
        }
    }
}
