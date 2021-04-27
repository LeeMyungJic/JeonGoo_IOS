//
//  SaleListViewController.swift
//  JeonGoo
//
//  Created by 이명직 on 2021/03/10.
//

import UIKit
import Moya
class SaleListCell: UITableViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var grade: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
}

class SaleListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let productsModel = MyProductViewModel()
    let productProvider = MoyaProvider<ProductService>()
    
    var getProducts = [getProduct]()
    var userId : Int?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableMain.dequeueReusableCell(withIdentifier: "SaleListCell") as! SaleListCell
        
        cell.name.text = getProducts[indexPath.row].name
        cell.grade.text = getProducts[indexPath.row].productGrade.stringValue
        cell.price.text = "\(getProducts[indexPath.row].price)원"
        cell.stateLabel.text = getProducts[indexPath.row].useStatus.stringValue
        
//        let url = URL(string: getProduct.image)
//        var image : UIImage?
//        DispatchQueue.global().async {
//            let data = try? Data(contentsOf: url!)
//            DispatchQueue.main.async {
//                //image = UIImage(data: data!)
//                cell.productImage.image = ImageResize(getImage: UIImage(data: data!)!, size: 70)
//
//            }
//        }
        return cell
    }
    
    @IBOutlet weak var TableMain: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TableMain.delegate = self
        TableMain.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        getData()
    }
    
    func getData() {
        getProducts = [getProduct]()
        productProvider.request(.findByUserId(UserId: 1)) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    if response.statusCode == 200 || response.statusCode == 201 {
                        do {
                            if let json = try JSONSerialization.jsonObject(with: response.data, options: .allowFragments) as? [String: AnyObject]
                            {
                                print(json)
                                if let temp = json["data"] as? NSArray {

                                    for i in temp {
                                        var id = 0
                                        var name = ""
                                        var price = 0
                                        var useStatus = ""
                                        var productGrade = ""
                                        if let temp = i as? NSDictionary {
                                            id = temp["id"] as! Int
                                            name = temp["name"] as! String
                                            let priceTemp = temp["price"] as! [String:Any]
                                            price = priceTemp["value"] as! Int
                                            useStatus = temp["useStatus"] as! String
                                            productGrade = temp["productGrade"] as! String
                                            print(name)
                                        }
                                        self?.getProducts.append(getProduct(id: id, name: name, price: price, productGrade: .HIGH, useStatus: .USED))
                                    }

                                    DispatchQueue.main.async {
                                        self?.TableMain.reloadData()
                                    }
                                }
                            }
                        }
                        catch {
                        }
                    }
                }
                catch {
                }
            case .failure:
                print("error")
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier, "detail" == id {
            if let controller = segue.destination as? DetailViewController {
                if let indexPath = TableMain.indexPathForSelectedRow {
                    controller.getId = getProducts[indexPath.row].id
                    
                }
            }
        }
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
