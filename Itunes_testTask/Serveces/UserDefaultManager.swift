//
//  UserDefaultManager.swift
//  Itunes_testTask
//
//  Created by Павел Яковенко on 08.02.2023.
//

import Foundation

class DataBase {
    
    static let shared = DataBase()
    
    enum SettingKeys: String {
        case users
    }
    
    let defaults = UserDefaults.standard
    let userKey = SettingKeys.users.rawValue
    
    var users: [User] {
        get {
            if let data = defaults.value(forKey: userKey) as? Data {
                return try! PropertyListDecoder().decode([User].self, from: data) // PropertyListDecoder - Декодер списка свойств
            } else {
                return [User]()
            }
        }
        
        set {
            if let data = try? PropertyListEncoder().encode(newValue) { // PropertyListEncoder - Кодировщик списка свойств
                defaults.set(data, forKey: userKey)
            }
        }
    }
    
    func saveUser(firstName: String, secondName: String, phone: String, email: String, password: String) {
        
        let user = User(firstName: firstName, secondName: secondName, phone: phone, email: email, password: password)
        users.insert(user, at: 0)
    }
}
