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
        cell.grade.text = setGrade(value: getProducts[indexPath.row].productDetailDto.productGrade)
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
    
    func getProduct() {
        productViewModel.findPurchasedProductByUserId{ state in
            self.getProducts = self.productViewModel.Products
            self.TableMain.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getProduct()
    }
    

    @IBOutlet weak var TableMain: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TableMain.delegate = self
        TableMain.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
