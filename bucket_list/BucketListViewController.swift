//
//  ViewController.swift
//  bucket_list
//
//  Created by Ruslan Suvorov on 3/12/18.
//  Copyright © 2018 Ruslan Suvorov. All rights reserved.
//

import UIKit
import CoreData

class BucketListViewController: UITableViewController, AddItemTableViewControllerDelegate {
    
//    var items = ["go to moon", "eat some chocolate", "jump a bit", "play tennis", "hang out"]
    var items = [BucketListItem]()
    
    var managedObjectContext = (UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllItems()
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
        cell.textLabel?.text = items[indexPath.row].text!
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected")
    }

    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue( withIdentifier: "AddItemSegue", sender: indexPath )
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        managedObjectContext.delete(item)
        do {
            try managedObjectContext.save()
        } catch {
            print( error )
        }
        items.remove( at: indexPath.row )
        tableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if (sender as? UIBarButtonItem) != nil {
            let navigationController = segue.destination as! UINavigationController
            let addItemTableViewController = navigationController.topViewController as! AddItemTableViewController
            addItemTableViewController.delegate = self
        } else if (sender as? NSIndexPath) != nil {
            let navigationController = segue.destination as! UINavigationController
            let addItemTableViewController = navigationController.topViewController as! AddItemTableViewController
            addItemTableViewController.delegate = self
            
            let indexPath = sender as! NSIndexPath
            let item = items[indexPath.row]
            addItemTableViewController.item = item.text!
            addItemTableViewController.indexPath = indexPath
        }
    }
    
    func fetchAllItems(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "BucketListItem")
        do {
            let result = try managedObjectContext.fetch( request )
            items = result as! [BucketListItem]
        } catch {
            print ( error )
        }
        
    }
        
    func cancelButtonPressed(by controller: AddItemTableViewController) {
        dismiss(animated: true, completion: nil)
    }

    func itemSaved( by controller: AddItemTableViewController, with text: String, at indexPath: NSIndexPath? ) {
        if let i = indexPath {
            items[i.row].text = text
//            let item = items[i.row]
            
        } else {
            let item = NSEntityDescription.insertNewObject( forEntityName: "BucketListItem", into: managedObjectContext ) as! BucketListItem
            item.text = text
            items.append( item )
        }
        
        do {
            try managedObjectContext.save()
        } catch {
            print (error)
        }
        
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
}

