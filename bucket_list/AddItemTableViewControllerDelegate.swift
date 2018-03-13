//
//  AddItemTableViewControllerDelegate.swift
//  bucket_list
//
//  Created by Ruslan Suvorov on 3/13/18.
//  Copyright © 2018 Ruslan Suvorov. All rights reserved.
//

import Foundation

protocol AddItemTableViewControllerDelegate: class {
    func itemSaved( by controller: AddItemTableViewController, with text: String, at indexPath: NSIndexPath? )
    func cancelButtonPressed( by controller: AddItemTableViewController )
}
