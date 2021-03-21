//
//  SaleListViewController.swift
//  JeonGoo
//
//  Created by 이명직 on 2021/03/10.
//

import UIKit
class SaleListCell: UITableViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var grade: UILabel!
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var stateLabel: UILabel!
}

class SaleListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let productsModel = MyProductViewModel()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productsModel.productsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let getProduct = productsModel.productsData[indexPath.row] as! MyProduct
        
        let cell = TableMain.dequeueReusableCell(withIdentifier: "SaleListCell") as! SaleListCell
        
        cell.name.text = getProduct.name
        cell.grade.text = getProduct.grade
        cell.price.text = "\(getProduct.price)원"
        cell.stateLabel.text = getProduct.status
        
        let url = URL(string: getProduct.image)
        var image : UIImage?
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                //image = UIImage(data: data!)
                cell.productImage.image = UIImage(data: data!)
                
            }
        }
        
        return cell
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
