//
//  TVC.swift
//  CourseraOpenLibrarySearchTableView
//
//  Created by Ricardo Tercero Solis on 05/08/18.
//  Copyright © 2018 R3S Web Development. All rights reserved.
//

import UIKit

class TVC: UITableViewController {
    
    struct Book {
        let name: String
        let authors: String
        let cover: UIImage?
        
        init(name: String, authors: String, cover: UIImage?) {
            self.name = name
            self.authors = authors
            self.cover = cover
        }
    }
    
    var books = Array<Book>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.books.append(Book(name: "Ricardo", authors: "Tercero Solis", cover: nil))
        self.books.append(Book(name: "Eduardo", authors: "Tercero Solis", cover: nil))
        self.books.append(Book(name: "Carlos", authors: "Tercero Solis", cover: nil))

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.books.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = self.books[indexPath.row].name
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let bookDetail = segue.destination as! BookDetail
        let ip = self.tableView.indexPathsForSelectedRows!
        let book = self.books[ip[0][1]]
        bookDetail.setDetail(name: book.name, authors: book.authors, cover: book.cover)
    }
    

}
