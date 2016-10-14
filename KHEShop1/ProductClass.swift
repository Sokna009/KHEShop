//
//  ProductClass.swift
//  KHEShop1
//
//  Created by Bunmeng on 10/7/16.
//  Copyright © 2016 Bunmeng. All rights reserved.
//

import UIKit

class ProductClass: NSObject {

    var product_id : String
    var product_title : String
    var category : String
    var regular_price : String
    var sale_price : String
    var image_path : String
    
    init(product_id : String, product_title : String, category : String, regular_price : String, sale_price : String, image_path : String) {
        self.product_id = product_id ; self.product_title = product_title
        self.regular_price = regular_price ; self.sale_price = sale_price
        self.category = category ; self.image_path = image_path
    }
    
}
