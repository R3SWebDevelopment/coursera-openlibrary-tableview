//
//  BookDetail.swift
//  CourseraOpenLibrarySearchTableView
//
//  Created by Ricardo Tercero Solis on 05/08/18.
//  Copyright © 2018 R3S Web Development. All rights reserved.
//

import UIKit

class BookDetail: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var authors: UITextField!
    @IBOutlet weak var cover: UIImageView!
    
    var bookName: String = ""
    var bookAuthors : String = ""
    var bookCover : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.name.text = self.bookName
        self.authors.text = self.bookAuthors
        self.cover.image = self.bookCover
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setDetail(name: String, authors: String, cover: UIImage?) {
        self.bookName = name
        self.bookAuthors = authors
        self.bookCover = cover
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
