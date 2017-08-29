//
//  Constants.swift
//  TO-DO
//
//  Created by Ravi on 29/08/17.
//  Copyright © 2017 UMAI. All rights reserved.
//

import UIKit


struct GlobalConstants {
    
    static let AppName  : String = "To-Do"
    
    // Alert Button
    static let Alert  : String = "Alert"
    static let Ok     : String = "Ok"
    static let Cancel : String = "Cancel"
    static let Submit : String = "Submit"
    
    
    //Task Status
    static let Done        : String = "Done"
    static let Pending     : String = "Pending"
    
    
    
    // Alert Title
    static let   AddNewTask           : String = "Add New Task"
    static let AddTaskPlaceHolder     : String = "Task Name..."
    
    static let ChangeStatus           : String = "Change Task Status"
    static let validationMessage      : String = "Please enter the valid task name first!"

}



struct GlobalArray {
    
   static var doneTaskArray        : NSMutableArray = NSMutableArray()
   static var pendingTaskArray     : NSMutableArray = NSMutableArray()
    
    
}







