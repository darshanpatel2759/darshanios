//
//  DetailsViewController.swift
//  databasedemo
//
//  Created by Darshan on 20/04/24.
//

import UIKit

class DetailsViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var persontbl : UITableView!
    
    var arrofperson = [person]()
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //print(arrofperson)
    }
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        arrofperson = db.showdata()
        self.persontbl.reloadData()
        
    }

    @IBAction func btnAdd(_ sender : UIButton){
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrofperson.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "personcell") as! personcell
        cell.lblname.text = "Name : \(self.arrofperson[indexPath.row].name)"
        cell.lblage.text = "Age : \(self.arrofperson[indexPath.row].age) id : \(self.arrofperson[indexPath.row].id)"
        cell.btndel.tag = indexPath.row
        cell.btnedit.tag = indexPath.row
        cell.btnedit.addTarget(self, action: #selector(self.btnedit(_:)), for: .touchUpInside)
        cell.btndel.addTarget(self, action: #selector(self.btndel(_:)), for: .touchUpInside)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 122
    }
    @objc func btndel(_ sender : UIButton){
        
        db.delete(id: self.arrofperson[sender.tag].id)
        arrofperson = []
        arrofperson = db.showdata()
        self.persontbl.reloadData()
    }
    @objc func btnedit(_ sender : UIButton){
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        vc.isedit = true
        vc.person = self.arrofperson[sender.tag]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
