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
    @IBOutlet weak var genuin: UILabel!
    
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
        if getProducts[indexPath.row].productDetailDto.productGrade == "NONE" {
            cell.grade.text = setGrade(value: getProducts[indexPath.row].productDetailDto.certificationStatus)
        }
        else {
            if getProducts[indexPath.row].productDetailDto.useStatus == "DISUSED" {
                cell.grade.text = "새상품"
                cell.grade.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
                
            }
            else {
                cell.grade.text = setGrade(value: getProducts[indexPath.row].productDetailDto.productGrade)
            }
        }
        
        if getProducts[indexPath.row].productDetailDto.certificationStatus == "COMPLETED" {
            cell.genuin.text = "정품"
            cell.genuin.textColor = #colorLiteral(red: 0.2930094004, green: 0.270149976, blue: 0.9494245648, alpha: 1)
        }
        
        cell.price.text = "\(getProducts[indexPath.row].productDetailDto.price)원"
        cell.status.text =
            setProductState(value: getProducts[indexPath.row].productDetailDto.salesStatus)
        cell.productImage.layer.cornerRadius = 10
        DispatchQueue.main.async {
            for i in self.getProducts[indexPath.row].productDetailDto.fileList {
                if i.filePath != "" && i.fileType == "IMAGE" {
                    let url = URL(string: i.filePath)
                    do {
                        let data = try Data(contentsOf: url!)
                        cell.productImage.image = UIImage(data: data)
                        break
                    }
                    catch {
                        
                    }
                }
                else {
                    cell.productImage.image = UIImage(named: "defaultImage")
                }
            }
        }
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier, "detail" == id {
            if let controller = segue.destination as? DetailViewController {
                if let indexPath = TableMain.indexPathForSelectedRow {
                    DetailViewController.productId = getProducts[indexPath.row].productDetailDto.id
                }
            }
        }
    }

    @IBOutlet weak var TableMain: UITableView!
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}
