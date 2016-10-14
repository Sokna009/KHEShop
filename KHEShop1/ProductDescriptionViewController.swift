//
//  ProductDescriptionViewController.swift
//  KHEShop1
//
//  Created by Bunmeng on 10/6/16.
//  Copyright © 2016 Bunmeng. All rights reserved.
//

import UIKit

let urlProductDetail : String = "http://36.37.219.75/kheshop-web-service/get-all-products-detail.php"
let imageURLPath : String = "http://36.37.219.75/kheshop/wp-content/uploads/"
class ProductDescriptionViewController: UIViewController {
    var product_id : String?
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var detailTextView: UITextView!
    
    @IBAction func addToCartButton(_ sender: UIBarButtonItem) {
    
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
//        let myImage = UIImage(named: "bunmeng.jpg")
//        print("my image is \(myImage)")
//        print("my image is \(myImage!)")
//        productImageView.image = myImage
//        self.getProductDescription(productID: product_id!)
    }

    override func viewWillAppear(_ animated: Bool) {
        self.getProductDescription(productID: product_id!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setProductID(product_id : String) {
        self.product_id = product_id
    }
    
    
    func getProductDescription(productID : String) {
        
        let url = NSURL(string: urlProductDetail)
        let request = NSMutableURLRequest(url: url! as URL)
        request.httpMethod = "POST"
        let paramString = "product_id=\(productID)"
        request.httpBody = paramString.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            if (error != nil) {
                print(error!.localizedDescription)
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                
                let products = json?["products"] as! NSArray
                let arrayOne = products[0] as! NSDictionary
                
                
                let description : String = "\(arrayOne["product_title"]!) \nCategory: \(arrayOne["category"]!) \nRegular Price: $\(arrayOne["regular_price"]!) \nSale Price: $\(arrayOne["sale_price"]!) \nDescription: \(arrayOne["product_description"]!)"
                let imagePath : String = imageURLPath + (arrayOne["image_path"]! as! String)
                let data = NSData(contentsOf: NSURL(string: imagePath) as! URL)
                
                DispatchQueue.main.async {
                    self.detailTextView.text = description
                    self.productImageView.image = UIImage(data: data! as Data)
                }
                
            }catch {
                print("no data")
            }
        }
        task.resume()
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//         
//    }
 

}
