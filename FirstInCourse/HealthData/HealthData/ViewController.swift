//
//  ViewController.swift
//  HealthData
//
//  Created by Asif Habib on 28/06/23.
//

import UIKit
struct Message {
    var sender: String
    var body: String
}



class ViewController: UIViewController {
    @IBOutlet weak var TableView1: UITableView!
    var messages : [Message] = [
        Message(sender: "1@2.com", body: "hey"),
        Message(sender: "a@b.com", body: "hi")
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView1.dataSource = self
        TableView1.delegate = self
        TableView1.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "FirstRowCell")
        // Do any additional setup after loading the view.
    }


}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FirstRowCell", for: indexPath) as! CustomCell
        cell.textLabel?.text = "\(messages[indexPath.row].body)"
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        performSegue(withIdentifier: "FirstToSecond", sender: nil)
    }
}
