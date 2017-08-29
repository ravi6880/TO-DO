//
//  PendingTaskViewController.swift
//  TO-DO
//
//  Created by Ravi on 29/08/17.
//  Copyright © 2017 UMAI. All rights reserved.
//

import UIKit

class PendingTaskViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var newTaskTextField : UITextField!
    
    @IBOutlet weak var lblAlert: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        
       
        tableView.tableFooterView    = UIView.init(frame: CGRect.zero)
        tableView.rowHeight          = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44.0
        
        
        // Do any additional setup after loading the view.
        let addItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(addNewItem) );
        self.navigationItem.rightBarButtonItem = addItem;
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    
        self.refreshView()
        
    }
    
    
    func refreshView(){
        
        if GlobalArray.pendingTaskArray.count>0
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
        return GlobalArray.pendingTaskArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell.init(style: .value1, reuseIdentifier: "Cell")
        
        let taskObj : TaskClass = GlobalArray.pendingTaskArray.object(at: indexPath.row) as! TaskClass
        
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
        
        let taskObj : TaskClass = GlobalArray.pendingTaskArray.object(at: indexPath.row) as! TaskClass
        
        let alertController = UIAlertController(title: GlobalConstants.ChangeStatus, message:nil, preferredStyle: .alert)
        let doneButton = UIAlertAction(title: GlobalConstants.Done, style: .default, handler: { action in
            
            
            self.deleteTask(indexPath: indexPath)
            taskObj.status = true
            GlobalArray.doneTaskArray.add(taskObj)
            
            
        })
        alertController.addAction(doneButton)
        let pendingButton = UIAlertAction(title: GlobalConstants.Pending, style: .default, handler:{ action in
            
            
        })
        
        alertController.addAction(pendingButton)
        
        let cancelButton = UIAlertAction(title: GlobalConstants.Cancel, style: .cancel, handler:{ action in
            
            
        })
        
        alertController.addAction(cancelButton)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    // MARK: Delete Task & Update tableView Method
    func deleteTask(indexPath :IndexPath){
        
        GlobalArray.pendingTaskArray.removeObject(at: indexPath.row)
            self.refreshView()
        
    }
    
    
    // MARK: Add New Task Alert
    func addNewItem(){
        
        
        let alertController = UIAlertController(title: GlobalConstants.AppName, message:GlobalConstants.AddNewTask, preferredStyle: .alert)
        
        let cancelBtn = UIAlertAction(title: GlobalConstants.Cancel, style: .default, handler: nil)
        alertController.addAction(cancelBtn)
        
        let submitBtn = UIAlertAction(title: GlobalConstants.Submit, style: .default, handler:{ action in
            
            if ApplicationHelper.isEmptyOrWhitespace(string: self.newTaskTextField.text!)
            {
                ApplicationHelper.showAlertMessage(vc: self, titleStr: GlobalConstants.Alert, messageStr: GlobalConstants.validationMessage)
            }
            else
            {
                self.addNewTask()
                
            }
            
        })
        
        alertController.addAction(submitBtn)
        
        
        alertController.addTextField(configurationHandler: {(textField: UITextField!) in
            textField.placeholder = GlobalConstants.AddTaskPlaceHolder
            textField.clearButtonMode = .whileEditing

            self.newTaskTextField = textField
            
        })
        present(alertController, animated: true, completion: nil)
        
    }
    
    // MARK: Update Table after add new task
    func addNewTask()
    {
        let newTaskObj : TaskClass = TaskClass()
        newTaskObj.taskName = self.newTaskTextField.text!
        newTaskObj.status = false
        GlobalArray.pendingTaskArray.add(newTaskObj)
    
        self.refreshView()
        
        
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
