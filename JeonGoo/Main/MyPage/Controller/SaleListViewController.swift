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
    var edit : (() -> ()) = {}
    var reason : (() -> ()) = {}
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var grade: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var deleteBtn: CustomButton!
    @IBOutlet weak var editBtn: CustomButton!
    @IBOutlet weak var certificationFailedBtn: UIButton!
    
    @IBAction func didTapDelete(_ sender: Any) {
        delete()
    }
    @IBAction func didTapEdit(_ sender: Any) {
        edit()
    }
    @IBAction func didTapReason(_ sender: Any) {
        reason()
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
        cell.certificationFailedBtn.isHidden = true
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
        cell.delete = { [unowned self] in
            self.showDeleteWarningMessage(index: indexPath.row)
        }
        cell.edit = { [unowned self] in
            self.showEditWarningMessage()
        }
        cell.reason = { [unowned self] in
            let popUp = self.storyboard?.instantiateViewController(identifier: "ReasonViewController")
            
            popUp!.modalPresentationStyle = .overCurrentContext
            popUp!.modalTransitionStyle = .crossDissolve
            
            let temp = popUp as! ReasonViewController
            temp.getReason = self.getProducts[indexPath.row].productDetailDto.certificationFailedReason
            
            self.present(popUp!, animated: true, completion: nil)
        }
        return cell
    }
    
    func getData() {
        getProducts = [productData]()
        productViewModel.findByUserId { state in
            print(state)
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
    
    fileprivate func showEditWarningMessage() {
        let msgalert = UIAlertController(title: "주의", message: "상품을 수정하면 검수를 다시 진행해야 합니다. 그래도 진행하시겠습니까?", preferredStyle: .alert)
        
        let YES = UIAlertAction(title: "확인", style: .default, handler: { (action) -> Void in
            self.moveEditPage()
        })
        let CANCEL = UIAlertAction(title: "취소", style: .default)
        msgalert.addAction(YES)
        msgalert.addAction(CANCEL)
        self.present(msgalert, animated: true, completion: nil)
    }
    
    fileprivate func showDeleteWarningMessage(index: Int) {
        let msgalert = UIAlertController(title: "주의", message: "상품을 삭제하시겠습니까?", preferredStyle: .alert)
        
        let YES = UIAlertAction(title: "확인", style: .default, handler: { (action) -> Void in
            self.deleteProduct(index: index)
        })
        let CANCEL = UIAlertAction(title: "취소", style: .default)
        msgalert.addAction(YES)
        msgalert.addAction(CANCEL)
        self.present(msgalert, animated: true, completion: nil)
    }
    
    fileprivate func moveEditPage() {
        let popUp = self.storyboard?.instantiateViewController(identifier: "adViewController")
        
        popUp!.modalPresentationStyle = .overCurrentContext
        popUp!.modalTransitionStyle = .crossDissolve
        
        let temp = popUp as! adViewController
        
        self.present(temp, animated: true, completion: nil)
    }
    
    fileprivate func deleteProduct(index: Int) {
        SaleListViewController.selectedId = self.getProducts[index].productDetailDto.id
        self.productViewModel.removeProduct { state in
            switch state {
            case .success: self.showSuccessAlert()
                self.getProducts.remove(at: index)
                self.TableMain.reloadData()
            case .failure: self.showPostErrorAlert()
            case .serverError: self.showPostErrorAlert()
            }
        }
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
                    DetailViewController.productId = getProducts[indexPath.row].productDetailDto.id
                }
            }
        }
    }
    
    @IBOutlet weak var TableMain: UITableView!
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func didTapModifyBtn(_ sender: Any) {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "adViewController") as? adViewController else {
            return
        }
        self.present(vc, animated: true, completion: nil)
    }
}
