//
//  HomeViewController.swift
//  POSForIpad
//
//  Created by Hari on 14/08/20.
//  Copyright © 2020 Lancius. All rights reserved.
//

import UIKit
import Alamofire
class productCollectionCell : UICollectionViewCell
{
    @IBOutlet weak var nameOfProductLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
}
class categaryTableViewCell : UITableViewCell
{
    @IBOutlet weak var nameOfCatBt: UIButton!
    
    @IBOutlet weak var nameOfCatLabel: UILabel!
}
class cartHomeTableViewCell : UITableViewCell
{
    @IBOutlet weak var subBt: UIButton!
    @IBOutlet weak var plusBt: UIButton!
    @IBOutlet weak var subTotalLabel: UILabel!
    @IBOutlet weak var qtyLabel: UILabel!
    @IBOutlet weak var trustBt: UIButton!
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
}
class HomeViewController: UIViewController , UITableViewDelegate , UITableViewDataSource , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var categeryTableView: UITableView!
    @IBOutlet weak var productsCollectionView: UICollectionView!
    
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var grandTotalLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    var CartTableViewData = [NSDictionary]()
    var productCollectionViewData = [NSDictionary]()
    var categaryTableViewData = [NSDictionary]()
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.productCollectionViewData = [["name":"Atta" , "price":"10"] , ["name":"Britania" , "price":"20"] ,["name":"Sun Flower" , "price":"20"] , ["name":"Salaam Rice" , "price":"100"] , ["name":"Kalaar Rice" , "price":"90"] , ["name":"Maggi" , "price":"3"] , ["name":"Bambino" , "price":"2"] , ["name":"Veg Lamb" , "price":"10"]  , ["name":"Britania" , "price":"20"] , ["name":"Atta" , "price":"10"] , ["name":"Britania" , "price":"20"] ,["name":"Sun Flower" , "price":"20"] , ["name":"Salaam Rice" , "price":"100"] , ["name":"Kalaar Rice" , "price":"90"] , ["name":"Maggi" , "price":"3"] , ["name":"Bambino" , "price":"2"] , ["name":"Veg Lamb" , "price":"10"]  , ["name":"Britania" , "price":"20"]]
//        self.categaryTableViewData = [["name" : "Rice"] , ["name" : "Lentils"] , ["name" : "Flours"] , ["name" : "Oils Noodles"] , ["name" : "Ghee"] , ["name" : "Biscuits"] , ["name" : "Snacks"] , ["name" : "Frozen"] , ["name" : "Rice"] , ["name" : "Lentils"] , ["name" : "Flours"] , ["name" : "Oils Noodles"] , ["name" : "Ghee"] , ["name" : "Biscuits"] , ["name" : "Snacks"] , ["name" : "Frozen"] ]
//        self.CartTableViewData = [["name":"Atta" , "price":"10" , "qty" : "1"] , ["name":"Britania" , "price":"20" , "qty" : "5"] ,["name":"Sun Flower" , "price":"20"  , "qty" : "6"] , ["name":"Salaam Rice" , "price":"100"  , "qty" : "9"] , ["name":"Kalaar Rice" , "price":"90" , "qty" : "2"] , ["name":"Maggi" , "price":"3" , "qty" : "5"] , ["name":"Bambino" , "price":"2" , "qty" : "5"] , ["name":"Veg Lamb" , "price":"10" , "qty" : "2"]  , ["name":"Britania" , "price":"20" , "qty" : "10"] , ["name":"Atta" , "price":"10" , "qty" : "7"] , ["name":"Britania" , "price":"20" , "qty" : "8"] ,["name":"Sun Flower" , "price":"20" , "qty" : "1"]]
//
        
        self.cartTableView.delegate = self
        self.cartTableView.dataSource = self
        
        self.categeryTableView.delegate = self
        self.categeryTableView.dataSource = self
        
        self.productsCollectionView.delegate = self
        self.productsCollectionView.dataSource = self
        
        self.getCategoryListFromServer()
        // Do any additional setup after loading the view.
    }
    
    //MARK:- CollectionView Delegate
     
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.productCollectionViewData.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCollectionCellId", for: indexPath) as! productCollectionCell
        let item = self.productCollectionViewData[indexPath.row]
        /*  {
                  "id": "77",
                  "item_image": null,
                  "category_id": "23",
                  "image_code": "65208203",
                  "item_code": "IT0077",
                  "item_name": "Delio",
                  "category_name": "BISCUITS",
                  "lot_number": "55",
                  "unit_name": "Box",
                  "stock": "1000.00",
                  "alert_qty": "5",
                  "sales_price": "0.30",
                  "tax_name": null,
                  "tax": null,
                  "status": "1",
                  "brand_name": "5"
              },*/
        print(item)
        cell.nameOfProductLabel.text = "\(item["item_name"] ?? "")"
            //item["item_name"] as? String
        cell.priceLabel.text = "$\(item["sales_price"] ?? "")"
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.productsCollectionView.frame.size.width / 3 - 3, height: 100.0)
            //CGSize(width: 300, height: 100)
    }
    
    // MARK: - TableView Delegate
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 1
        {
            return CartTableViewData.count
        }
        else
        {
            return categaryTableViewData.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       if tableView.tag == 1
       {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartHomeTableViewCellId", for: indexPath) as! cartHomeTableViewCell
        let item = self.CartTableViewData[indexPath.row] as! [String : String]
        /*["name":"Britania" , "price":"20" , "qty" : "10"] , ["name":"Atta" , "price":"10" , "qty" : "7"] */
        cell.qtyLabel.text = item["qty"]
        cell.nameLabel.text = item["name"]
       // cell.qtyLabel.text = item["qty"]
        cell.priceLabel.text = "$ \(item["price"] ?? "")"
        cell.subTotalLabel.text = item["qty"]
        cell.plusBt.tag = indexPath.row
        cell.subBt.tag = indexPath.row
        cell.trustBt.tag = indexPath.row
        return cell
        }
        else
       {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categaryTableViewCellId", for: indexPath) as! categaryTableViewCell
        let item = self.categaryTableViewData[indexPath.row] as! [String : String]
       // let category_name = item["category_name"]!
       // print("\(category_name)")
       // cell.nameOfCatBt.setTitle(item["category_name"], for: .normal)
        cell.nameOfCatLabel.text = "\(item["category_name"] ?? "")"
            //as? String
        /*{
            "id": "24",
            "category_code": "CT0024",
            "category_name": "BREADS",
            "description": "",
            "company_id": null,
            "status": "1",
            "cat_image": "uploads/category/bread.png",
            "cat_url_slag": "breads"
        },*/
        
        return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    //MARK: - Button Action
    
    @IBAction func subAction(_ sender: UIButton) {
    }
    @IBAction func plusAction(_ sender: UIButton) {
    }
    @IBAction func trustInCartAction(_ sender: UIButton) {
    }
    func getCategoryListFromServer()
    {
        
     //   showActivityIndicatory(view: self.view, isStart: true, transView: self.transView)
       let url : URL = URL(string: BaseUrl + "categoryList")!
             // let headerData = ["" : ""]
              let headerData : HTTPHeaders = ["chickyToken" : "1234"]
                  //"user_type":"1","first_name":self.firstNameTF.text as Any, "last_name":self.lastNameTF.text as Any, "email":self.emailTF.text as Any, "password":self.passwordTf.text as Any, "user_typeVal":self.usertypeId as Any] as [String : Any]
              AF.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headerData, interceptor: nil).responseJSON { (response) in
                  
                  DispatchQueue.main.async {
                     // self.showActivityIndicatory(view: self.view, isStart: false, transView: self.transView)
                      let response1 = response.response
                      if response1?.statusCode == 200
                      {
                          do{
                            let jsonRespone = try JSONSerialization.jsonObject(with: response.data!, options: []) as! [String : Any]
                            DispatchQueue.main.async {
                                                                    print(jsonRespone)
                                self.categaryTableViewData = jsonRespone["list"] as! [NSDictionary]
                                self.categeryTableView.reloadData()
                           // let itemList = jsonRespone["list"] as? [NSDictionary]
                                let item = self.categaryTableViewData[0]
                        
                               let Cat_id = item["id"] ?? ""
                                self.getProductListFromServer(category_id: Cat_id as! String)
                                
                            
                            }
                          } catch let parsingError {
                              print("Error", parsingError)
                          }
                          
                      }
                  }
              }
    }
    //productList
    func getProductListFromServer(category_id : String)
    {
        let url : URL = URL(string: BaseUrl + "productList")!
               let parameter = ["category_id" : category_id]
               let headerData : HTTPHeaders = ["chickyToken" : "1234"]
                   //"user_type":"1","first_name":self.firstNameTF.text as Any, "last_name":self.lastNameTF.text as Any, "email":self.emailTF.text as Any, "password":self.passwordTf.text as Any, "user_typeVal":self.usertypeId as Any] as [String : Any]
               AF.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: headerData, interceptor: nil).responseJSON { (response) in
                   
                   DispatchQueue.main.async {
                      // self.showActivityIndicatory(view: self.view, isStart: false, transView: self.transView)
                       let response1 = response.response
                       if response1?.statusCode == 200
                       {
                           do{
                               let jsonRespone = try JSONSerialization.jsonObject(with: response.data!, options: []) as! [String : Any]
                               print(jsonRespone)
                            self.productCollectionViewData = jsonRespone["list"] as! [NSDictionary]
                            self.productsCollectionView.reloadData()
                         //   Alert.showBasic(titte: "Success", massage: "", vc: self)
                               
                               
                           } catch let parsingError {
                               print("Error", parsingError)
                           }
                           
                       }
                   }
               }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
