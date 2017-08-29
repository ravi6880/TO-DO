//
//  DoneTaskViewController.swift
//  TO-DO
//
//  Created by Ravi on 29/08/17.
//  Copyright © 2017 UMAI. All rights reserved.
//

import UIKit

class DoneTaskViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var lblAlert: UILabel!
    
    
     // MARK: ViewController Method
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
 
        
      
        tableView.tableFooterView    = UIView.init(frame: CGRect.zero)
        tableView.rowHeight          = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44.0
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.refreshView()
        
    }
    
    
    func refreshView(){
        
        if GlobalArray.doneTaskArray.count>0
        {
            self.lblAlert.isHidden = true
            self.tableView.reloadData()
            self.tableView.isHidden = false
            
        }
        else
        {
            self.tableView.isHidden = true
            self.lblAlert.isHidden = false
        }
        
    }
    
     // MARK: TableView Delegate , DataSource Method
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GlobalArray.doneTaskArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell.init(style: .value1, reuseIdentifier: "Cell")
        
        let taskObj : TaskClass = GlobalArray.doneTaskArray.object(at: indexPath.row) as! TaskClass
        
        cell.textLabel?.text       = taskObj.taskName.capitalized
        
        if taskObj.status == true
        {
            cell.detailTextLabel?.text =  GlobalConstants.Done
        }
        else
        {
            cell.detailTextLabel?.text =  GlobalConstants.Pending
        }

        
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
           self.deleteTask(indexPath: indexPath)
        }
    }
    
    
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
         let taskObj : TaskClass = GlobalArray.doneTaskArray.object(at: indexPath.row) as! TaskClass
        
        let alertController = UIAlertController(title: GlobalConstants.ChangeStatus, message:nil, preferredStyle: .alert)
        let doneButton = UIAlertAction(title: GlobalConstants.Done, style: .default, handler: { action in
            
           
            
        })
        alertController.addAction(doneButton)
        let pendingButton = UIAlertAction(title: GlobalConstants.Pending, style: .default, handler:{ action in
            
            self.deleteTask(indexPath: indexPath)
            taskObj.status = false
            GlobalArray.pendingTaskArray.add(taskObj)
            
        })
        
        
        let cancelButton = UIAlertAction(title: GlobalConstants.Cancel, style: .cancel, handler:{ action in
            
            
        })
        
        alertController.addAction(cancelButton)
        
        
        alertController.addAction(pendingButton)
       
        present(alertController, animated: true, completion: nil)
        
    }

    
    // MARK: Delete Task & Update tableView Method
    func deleteTask(indexPath :IndexPath){
        
        GlobalArray.doneTaskArray.removeObject(at: indexPath.row)
        self.refreshView()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
