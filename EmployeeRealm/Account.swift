//
//  Account.swift
//  EmployeeRealm
//
//  Created by Asem Qaffaf on 12/1/18.
//  Copyright © 2018 Asem Qaffaf. All rights reserved.
//

import Foundation
import RealmSwift

class Account : Object {
  @objc dynamic var balance = 0.0
    
    var parentEmployee = LinkingObjects(fromType: Employee.self, property: "list1")
}
