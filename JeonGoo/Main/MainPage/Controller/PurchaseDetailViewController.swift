//
//  PurchaseDetailViewController.swift
//  JeonGoo
//
//  Created by 이명직 on 2021/06/02.
//

import UIKit
import Alamofire
import SwiftyJSON


class PurchaseDetailViewController: UIViewController  {
    
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var kakaoBtn: RadioButton!
    @IBOutlet weak var elseBtn: RadioButton!
    
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productDetail: UILabel!
    
    @IBOutlet weak var bottomView: UIView!
    
    let productViewModel = ProductViewModel()
    var sendPriceValue = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getProductDetail()
        kakaoBtn?.alternateButton = [elseBtn!]
        elseBtn?.alternateButton = [kakaoBtn!]
        
        bottomView.addBorder(toSide: .top, color: #colorLiteral(red: 1, green: 0.6852490902, blue: 0.1444164813, alpha: 1), borderWidth: 1.0)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier, "payment" == id {
            if let controller = segue.destination as? PaymentViewController {
                controller.getProductName = self.productName.text!
                controller.getProductPrice = self.sendPriceValue
            }
        }
    }
    
    fileprivate func getProductDetail() {
        productViewModel.findByProductId(id: DetailViewController.productId) { state in
            
            guard let getItem = self.productViewModel.Product else {
                return
            }
            
            self.productName.text = getItem.productDetailDto.name
            self.productPrice.text = "\(getItem.productDetailDto.price)원"
            self.sendPriceValue = getItem.productDetailDto.price
            self.totalPriceLabel.text = "\(getItem.productDetailDto.price)원"
            self.productDetail.text = getItem.productDetailDto.description
        }
    }
    
    fileprivate func showPostErrorAlert() {
        showAlertController(withTitle: "구매 실패", message: "서버가 불안정합니다.", completion: nil)
    }
    
    fileprivate func showSuccessAlert() {
        let msgalert = UIAlertController(title: "구매 성공", message: "상품을 구매하였습니다", preferredStyle: .alert)
        
        let YES = UIAlertAction(title: "확인", style: .default)
        msgalert.addAction(YES)
        present(msgalert, animated: true, completion: nil)
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    struct purchaseList {
        let name: String
        let price: Int
    }
}
