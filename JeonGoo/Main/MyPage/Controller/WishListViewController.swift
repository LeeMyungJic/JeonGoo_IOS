//
//  WishListViewController.swift
//  JeonGoo
//
//  Created by 이명직 on 2021/03/10.
//

import UIKit

class WishListCell: UITableViewCell {
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var grade: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var status: UILabel!
    
}

class WishListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var productViewModel = ProductViewModel()
    var getProducts = [productData]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = TableMain.dequeueReusableCell(withIdentifier: "WishListCell") as! WishListCell
        cell.name.text = getProducts[indexPath.row].productDetailDto.name
        cell.grade.text = setGrade(value: getProducts[indexPath.row].productDetailDto.productGrade)
        cell.price.text = "\(getProducts[indexPath.row].productDetailDto.price)원"

//        let url = URL(string: getProduct.image)
//        var image : UIImage?
//        DispatchQueue.global().async {
//            let data = try? Data(contentsOf: url!)
//            DispatchQueue.main.async {
//                cell.productImage.image = ImageResize(getImage: UIImage(data: data!)!, size: 70)
//
//            }
//        }
        
        return cell
    }
    
    func getProductsData() {
        productViewModel.findInterestedProduct { state in
            self.getProducts = self.productViewModel.Products
            self.TableMain.reloadData()
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getProductsData()
        
        TableMain.delegate = self
        TableMain.dataSource = self
    }

    @IBOutlet weak var TableMain: UITableView!
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}
