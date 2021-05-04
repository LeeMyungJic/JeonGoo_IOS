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
    
    let productViewModel = ProductViewModel()
    
    var getProducts = [productData]()
    var userId : Int?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableMain.dequeueReusableCell(withIdentifier: "SaleListCell") as! SaleListCell
        
        cell.name.text = getProducts[indexPath.row].productDetailDto.name
        cell.grade.text = setGrade(value: getProducts[indexPath.row].productDetailDto.productGrade)
        cell.price.text = "\(getProducts[indexPath.row].productDetailDto.price)원"
        cell.stateLabel.text = getProducts[indexPath.row].productDetailDto.useStatus
        
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
        getProducts = [productData]()
        productViewModel.findByUserId(id: MyPageViewController.userId!) { state in
            
            self.getProducts = self.productViewModel.Products
            self.TableMain.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier, "detail" == id {
            if let controller = segue.destination as? DetailViewController {
                if let indexPath = TableMain.indexPathForSelectedRow {
                    controller.getId = getProducts[indexPath.row].productDetailDto.id
                }
            }
        }
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
