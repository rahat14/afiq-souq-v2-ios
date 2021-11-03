//
//  CartDbModel.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 4/11/21.
//

import Foundation
import RealmSwift
// 1
class CartDbMOdel: Object {
    // 2
    @objc dynamic var id = 0
    @objc dynamic var title = ""
    @objc dynamic var image = ""
    @objc dynamic var quantity = 1
    @objc dynamic var var_id = 0
    @objc dynamic var product_id = 0
    @objc dynamic var stock_limit_qty = 0
    @objc dynamic var unit_price  = 0.0
    @objc dynamic var sub_total  = 0.0
    
    // 3
    override static func primaryKey() -> String? {
        "id"
    }
}
