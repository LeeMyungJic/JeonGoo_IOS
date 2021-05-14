//
//  BuyingListViewController.swift
//  JeonGoo
//
//  Created by 이명직 on 2021/03/10.
//

import UIKit

class BuyingListCell: UITableViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var grade: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var status: UILabel!
    
}

class BuyingListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let productViewModel = ProductViewModel()
    var getProducts = [productData]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableMain.dequeueReusableCell(withIdentifier: "BuyingListCell") as! BuyingListCell
        
        cell.name.text = getProducts[indexPath.row].productDetailDto.name
        if getProducts[indexPath.row].productDetailDto.productGrade == "NONE" {
            cell.grade.text = setGrade(value: getProducts[indexPath.row].productDetailDto.certificationStatus)
        }
        else {
            if getProducts[indexPath.row].productDetailDto.useStatus == "DISUSED" {
                cell.grade.text = "새상품"
                cell.grade.textColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
                
            }
            else {
                cell.grade.text = setGrade(value: getProducts[indexPath.row].productDetailDto.productGrade)
            }
        }
        cell.price.text = "\(getProducts[indexPath.row].productDetailDto.price)원"
        
//        let url = URL(string: getProduct.image)
//        var image : UIImage?
//
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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getProduct()
        
        TableMain.delegate = self
        TableMain.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier, "detail" == id {
            if let controller = segue.destination as? DetailViewController {
                if let indexPath = TableMain.indexPathForSelectedRow {
                    DetailViewController.productId = getProducts[indexPath.row].productDetailDto.id
                }
            }
        }
    }
    
    
    func getProduct() {
        productViewModel.findPurchasedProductByUserId{ state in
            self.getProducts = self.productViewModel.Products
            self.TableMain.reloadData()
        }
    }

    @IBOutlet weak var TableMain: UITableView!

    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
