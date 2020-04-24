//
//  library.swift
//  CDProject
//
//  Created by Nathan on 4/24/20.
//  Copyright © 2020 Nathan. All rights reserved.
//

import UIKit
import CoreData

class library: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
     var books = [Books]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.rowHeight = 229;
        
        loadData() // loads in user CoreData into local array
        
        
        print("made it")
    }
    
    
    func loadData(){
        let fetchRequest: NSFetchRequest<Books> = Books.fetchRequest()
        do{
            let book = try persistenceService.context.fetch(fetchRequest)
            self.books = book
            print(String(self.books.count))
                   //self.user = user
                   
            }catch{}
    }
    
    @IBAction func addRow(_ sender: Any) {
        let alert = UIAlertController(title: "Add Book", message: nil, preferredStyle: .alert)
            alert.addTextField { (textField) in
                textField.placeholder = "title"
            }
            alert.addTextField { (textField) in
                textField.placeholder = "author"
            }
            alert.addTextField { (textField) in
                textField.placeholder = "date"
            
            }
        let action = UIAlertAction(title:"New User", style: .default) { (_) in
            let title = alert.textFields![0].text!
            let author = alert.textFields![1].text!
            let date      = alert.textFields![2].text!
            let book = Books(context: persistenceService.context)
            book.title = title
            book.author = author
            book.date = date
            persistenceService.saveContext()
            self.books.append(book)
            self.tableView.reloadData()
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    
}

extension library: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tapped!")
    }
    
}

extension library: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.books.count // number of rows in table view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! bookCell
        /*cell.textLabel?.text = "hello world"
        var image : UIImage = UIImage(named: "flower")!
        cell.imageView?.image = image */
        
        cell.title.text = "title: " + self.books[indexPath.row].title
        cell.author.text = "author: " + self.books[indexPath.row].author
        cell.date.text = "Date: " + self.books[indexPath.row].date
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            for book in books{
                if book.title == books[indexPath.row].title &&  book.author == books[indexPath.row].author && book.date == books[indexPath.row].date{
                    persistenceService.context.delete(book)
                    persistenceService.saveContext()
                    print("deleted")
                    break
                }
            }
            
            books.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            

            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
}
