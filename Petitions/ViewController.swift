    //
    //  ViewController.swift
    //  Petitions
    //
    //  Created by Abdulrahman on 10/2/21.
    //

import UIKit

class ViewController: UITableViewController {
    var petitions = [Petition]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.global(qos: .background).async {
            self.fetchJSON()
        }
    }
    
    @objc func fetchJSON(){
        var urlString: String = "https://hackingwithswift.com/samples/petitions-1.json"
        DispatchQueue.main.async {
            if self.navigationController?.tabBarItem.tag==0 {
                urlString = "https://hackingwithswift.com/samples/petitions-1.json"
            }
            else {
                urlString = "https://hackingwithswift.com/samples/petitions-2.json?"
            }
        }
       
        
        
        
            if let url = URL(string: urlString){
                if let data = try? Data(contentsOf: url){
                    parse(json: data)
                    return
                }
            }
        DispatchQueue.main.async {
            self.showError()
        }
    }
    
    @objc func showError(){
            
            let alertController = UIAlertController(title: "Loading Error", message:  "There was a problem loading the feed, pls check your connection and try again", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .default))
            present(alertController, animated: true)
      
    }
    func parse(json: Data){
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json){
            petitions = jsonPetitions.results
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
           
            
        } else {
            DispatchQueue.main.async {
                self.showError()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
        
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        detailViewController.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    
}

