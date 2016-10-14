//
//  LogInViewController.swift
//  KHEShop1
//
//  Created by Bunmeng on 10/7/16.
//  Copyright © 2016 Bunmeng. All rights reserved.
//

import UIKit

let urlLogInUser : String = "http://36.37.219.75/kheshop/cs-mobile-login.php"
class LogInViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func logIn(_ sender: AnyObject) {
        let userName : String = userNameTextField.text!
        let passWord : String = passwordTextField.text!
        
        self.logIn(userName: userName, password: passWord)
       
    }
    
    func logIn(userName:String, password:String) {
        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: NSURL(string: urlLogInUser) as! URL)
        request.httpMethod = "POST"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        let paramString = "username=\(userName)&pwd=\(password)"
        request.httpBody = paramString.data(using: String.Encoding.utf8)
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            if (error != nil) {
                print(error!.localizedDescription)
            }
           // else
           // {
           //  self.performSegue(withIdentifier: "To_Profile", sender:self)
           // }
            do{
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
               print("JSon data is \(json!)")
                
            }catch{
                print("No data")
            }
            
        }
        task.resume()
       
    }

    func hideKeyboard() {
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboard()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
