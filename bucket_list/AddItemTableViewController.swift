//
//  AddItemTableViewController.swift
//  bucket_list
//
//  Created by Ruslan Suvorov on 3/13/18.
//  Copyright © 2018 Ruslan Suvorov. All rights reserved.
//

import UIKit

class AddItemTableViewController: UITableViewController {
    
    weak var delegate: AddItemTableViewControllerDelegate?
    
    var item: String?
    var indexPath: NSIndexPath?

    @IBAction func cancelButtonPressed(_ sender: Any) {
        delegate?.cancelButtonPressed(by: self)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        let text = itemTextField.text!
        delegate?.itemSaved( by: self, with: text, at: indexPath )
    }
    
    
    @IBOutlet weak var itemTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemTextField.text = item
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    
//    // MARK: - Table view data source
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

}
