//
//  Employee.swift
//  EmployeeRealm
//
//  Created by Asem Qaffaf on 12/1/18.
//  Copyright © 2018 Asem Qaffaf. All rights reserved.
//

import Foundation
import RealmSwift
class Employee: Object {
    @objc dynamic var name = ""
    @objc dynamic var dateOFHire = Date()
    let list1 = List<Account>()
}
