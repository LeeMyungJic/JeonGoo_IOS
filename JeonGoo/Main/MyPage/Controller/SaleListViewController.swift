//
//  SaleListViewController.swift
//  JeonGoo
//
//  Created by 이명직 on 2021/03/10.
//

import UIKit
import Moya
class SaleListCell: UITableViewCell {
    
    var delete : (() -> ()) = {}
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var grade: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var deleteBtn: CustomButton!
    @IBAction func didTapDelete(_ sender: Any) {
        delete()
    }
}

class SaleListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    static var selectedId = 0
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
        cell.delete = { [unowned self] in
            SaleListViewController.selectedId = self.getProducts[indexPath.row].productDetailDto.id
            self.productViewModel.removeProduct { state in
                switch state {
                case .success: self.showSuccessAlert()
                case .failure: self.showPostErrorAlert()
                case .serverError: self.showPostErrorAlert()
                }
            }
            self.getProducts.remove(at: indexPath.row)
            self.TableMain.reloadData()
        }
        
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
    
    func getData() {
        getProducts = [productData]()
        productViewModel.findByUserId(id: MyPageViewController.userId!) { state in
            
            self.getProducts = self.productViewModel.Products
            self.TableMain.reloadData()
        }
    }
    
    fileprivate func showPostErrorAlert() {
        showAlertController(withTitle: "삭제 실패", message: "서버가 불안정합니다.", completion: nil)
    }
    
    fileprivate func showSuccessAlert() {
        let msgalert = UIAlertController(title: "삭제 성공", message: "상품을 삭제하였습니다", preferredStyle: .alert)
        
        let YES = UIAlertAction(title: "확인", style: .default)
        msgalert.addAction(YES)
        present(msgalert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TableMain.delegate = self
        TableMain.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        getData()
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
    
    @IBOutlet weak var TableMain: UITableView!
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
