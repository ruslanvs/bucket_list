//
//  ViewController.swift
//  bucket_list
//
//  Created by Ruslan Suvorov on 3/12/18.
//  Copyright © 2018 Ruslan Suvorov. All rights reserved.
//

import UIKit

class BucketListViewController: UITableViewController, AddItemTableViewControllerDelegate {
    
    var items = ["go to moon", "eat some chocolate", "jump a bit", "play tennis", "hang out"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListItemCell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected")
    }

    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue( withIdentifier: "EditItemSegue", sender: indexPath )
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        items.remove( at: indexPath.row )
        tableView.reloadData()
    }
    // NO TEST
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let s = sender as? UIBarButtonItem {
            let navigationController = segue.destination as! UINavigationController
            let addItemTableViewController = navigationController.topViewController as! AddItemTableViewController
            addItemTableViewController.delegate = self
        } else if let s = sender as? NSIndexPath {
            let navigationController = segue.destination as! UINavigationController
            let addItemTableViewController = navigationController.topViewController as! AddItemTableViewController
            addItemTableViewController.delegate = self
            
            let indexPath = sender as! NSIndexPath
            let item = items[indexPath.row]
            addItemTableViewController.item = item
            addItemTableViewController.indexPath = indexPath
        }
        
        // if segue.identifier == "AddItemSegue" {
        //     let navigationController = segue.destination as! UINavigationController
        //     let addItemTableViewController = navigationController.topViewController as! AddItemTableViewController
        //     addItemTableViewController.delegate = self
        // } else if segue.identifier == "EditItemSegue" {
        //     let navigationController = segue.destination as! UINavigationController
        //     let addItemTableViewController = navigationController.topViewController as! AddItemTableViewController
        //     addItemTableViewController.delegate = self
            
        //     let indexPath = sender as! NSIndexPath
        //     let item = items[indexPath.row]
        //     addItemTableViewController.item = item
        //     addItemTableViewController.indexPath = indexPath
        // }
    }
        
    func cancelButtonPressed(by controller: AddItemTableViewController) {
        dismiss(animated: true, completion: nil)
    }

    func itemSaved( by controller: AddItemTableViewController, with text: String, at indexPath: NSIndexPath? ) {
        if let i = indexPath {
            items[i.row] = text
        } else {
            items.append(text)
        }
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
}

