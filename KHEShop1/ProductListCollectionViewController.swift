//
//  ProductListCollectionViewController.swift
//  KHEShop1
//
//  Created by Bunmeng on 10/6/16.
//  Copyright © 2016 Bunmeng. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"
let myImage = UIImage(named: "bunmeng.jpg")
let urlProductList : String = "http://36.37.219.75/kheshop-web-service/get-all-products-and-categories.php"
var productList = [ProductClass]()
var selectedIndex : Int32?

class ProductListCollectionViewController: UICollectionViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        getProductList()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getProductList() {
        let url = NSURL(string: urlProductList)
        let dataTask = URLSession.shared.dataTask(with: url! as URL) { (data, response, error) in
            if error != nil {
                print(error?.localizedDescription)
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                let products = json?["products"] as! NSArray
                var productLists : NSDictionary!
                
                for i in 0  ..< products.count {
                    productLists = products[i] as! NSDictionary
                    productList.append(ProductClass(product_id: productLists["ID"]! as! String, product_title: productLists["product_title"]! as! String, category: productLists["category"]! as! String, regular_price: productLists["regular_price"]! as! String, sale_price: productLists["sale_price"]! as! String, image_path: productLists["image_path"]! as! String))
                }
                
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
                
            } catch {
                print("No data")
            }
        }
        dataTask.resume()
        
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToProductDetail" {
            if let indexPath = getIndexPathForSelectedCell() {
                let productDescription = segue.destination as! ProductDescriptionViewController
                productDescription.product_id = productList[indexPath.row].product_id
            }
        }
    }

    func getIndexPathForSelectedCell() -> NSIndexPath? {
        var indexPath:NSIndexPath?
        
        if (collectionView?.indexPathsForSelectedItems!.count)!>0 {
            indexPath = collectionView?.indexPathsForSelectedItems![0] as NSIndexPath?
        }
        return indexPath
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return productList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as UICollectionViewCell
        
        cell.backgroundColor = UIColor.white

        let imageView = cell.viewWithTag(1) as! UIImageView
        let imagePath : String = imageURLPath + productList[indexPath.row].image_path
        let data = NSData(contentsOf: NSURL(string: imagePath) as! URL)
        imageView.image = UIImage(data: data! as Data)
        
        let description : String = "\(productList[indexPath.row].product_title)\nSale: $\(productList[indexPath.row].sale_price)\nRegular: $\(productList[indexPath.row].regular_price)"
        let textView = cell.viewWithTag(2) as! UITextView
        textView.text = description
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    
//     Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
 

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
