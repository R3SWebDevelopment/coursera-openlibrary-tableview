//
//  BookSearch.swift
//  CourseraOpenLibrarySearchTableView
//
//  Created by Ricardo Tercero Solis on 05/08/18.
//  Copyright © 2018 R3S Web Development. All rights reserved.
//

import UIKit

class BookSearch: UIViewController {

    @IBOutlet weak var searchTerm: UITextField!
    var parentView: UIViewController?
    var activityIndicator = UIActivityIndicatorView()
    
    var strLabel = UILabel()
    
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.searchTerm.text = ""
    }
    
    @IBAction func cancelSearch(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func activityIndicator(_ title: String) {
        
        activityIndicator.removeFromSuperview()
        effectView.removeFromSuperview()
        
        strLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 160, height: 46))
        strLabel.text = title
        strLabel.font = .systemFont(ofSize: 14, weight: .medium)
        strLabel.textColor = UIColor(white: 0.9, alpha: 0.7)
        
        effectView.frame = CGRect(x: view.frame.midX - strLabel.frame.width/2, y: view.frame.midY - strLabel.frame.height/2 , width: 160, height: 46)
        effectView.layer.cornerRadius = 15
        effectView.layer.masksToBounds = true
        
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 46, height: 46)
        activityIndicator.startAnimating()
        
        effectView.contentView.addSubview(activityIndicator)
        effectView.contentView.addSubview(strLabel)
        view.addSubview(effectView)
    }
    
    @IBAction func doSearch(_ sender: UIButton) {
        
        let isbn = self.searchTerm.text!
        
        let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:" + isbn
        let url = URL(string: urls)
        
        let session = URLSession.shared
        
        let compleationHandler = {
            (data: Data?, resp: URLResponse?, error: Error?) -> Void in
            if let error = error {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Request Error", message: error.localizedDescription, preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    
                    self.present(alert, animated: true)
                }
            }
            else {
                do{
                    let jsonObject = try JSONSerialization.jsonObject(with: data!, options: [])
                    let json = jsonObject as! [String: Any]
                    let rootKey = "ISBN:" + isbn
                    if let root = json[rootKey]{
                        let bookData = root as! [String: Any]
                        let authors = bookData["authors"] as? Array<[String:Any]>
                        var authorNames = ""
                        for author in authors! {
                            authorNames += (author["name"] as? String)! + ","
                        }
                        var image :UIImage?
                        if let cover = bookData["cover"] as? [String: Any]{
                            if let coverUrl = cover["large"] as? String{
                                let url = URL(string: coverUrl)
                                let data = try? Data(contentsOf: url!)
                                
                                if let imageData = data {
                                    image = UIImage(data: imageData)
                                }
                            }else if let coverUrl = cover["medium"] as? String{
                                let url = URL(string: coverUrl)
                                let data = try? Data(contentsOf: url!)
                                
                                if let imageData = data {
                                    image = UIImage(data: imageData)
                                }
                            }else if let coverUrl = cover["small"] as? String{
                                let url = URL(string: coverUrl)
                                let data = try? Data(contentsOf: url!)
                                
                                if let imageData = data {
                                    image = UIImage(data: imageData)
                                }
                            }
                        }
                        
                        let parent = self.parentView as! TVC
                        parent.addBook(name: bookData["title"] as! String, authors: authorNames, cover: image)
                        DispatchQueue.main.async {
                            self.effectView.removeFromSuperview()
                            let alert = UIAlertController(title: "Buscando Libro", message: "El Libro ha sido encontrado", preferredStyle: .alert)
                            
                            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (_) in
                                self.dismiss(animated: true, completion: nil)
                            }))
                            
                            self.present(alert, animated: true)
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.effectView.removeFromSuperview()
                            let alert = UIAlertController(title: "Buscando Libro", message: "Libro no Encontrado", preferredStyle: .alert)
                            
                            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (_) in
                                self.dismiss(animated: true, completion: nil)
                            }))
                            
                            self.present(alert, animated: true)
                        }
                    }

                }catch _{
                    
                }
            }
        }
        
        session.dataTask(with: url!, completionHandler: compleationHandler).resume()
        activityIndicator("Buscando Libro")
        
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }


}
