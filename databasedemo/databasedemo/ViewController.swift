//
//  ViewController.swift
//  databasedemo
//
//  Created by Darshan on 19/04/24.
//

import UIKit

class ViewController: UIViewController {
    
    var person : person!
    var isedit : Bool = false
    
    @IBOutlet weak var txtname : UITextField!
    @IBOutlet weak var txtage : UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isedit == true{
            
            txtname.text = person.name
            txtage.text = "\(person.age)"
        }
        
    }


    @IBAction func btnsubmit(_ sender : UIButton){
        
        if isedit == true{
            
            db.update(id: person.id, name: self.txtname.text ?? "", age: Int(self.txtage.text ?? "") ?? 0)
            
        }else{
            
            db.inserdata(name: self.txtname.text ?? "", age: Int(self.txtage.text ?? "") ?? 0)
            txtname.text = ""
            txtage.text = ""
            //db.showdata()
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnback(_ sender : UIButton){
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        self.navigationController?.popViewController(animated: true)
    }
    
  
}

