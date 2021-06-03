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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        kakaoBtn?.alternateButton = [elseBtn!]
        elseBtn?.alternateButton = [kakaoBtn!]
        
        bottomView.addBorder(toSide: .top, color: #colorLiteral(red: 1, green: 0.6852490902, blue: 0.1444164813, alpha: 1), borderWidth: 1.0)
        getProductDetail()
        
    }
    
    fileprivate func getProductDetail() {
        productViewModel.findByProductId(id: DetailViewController.productId) { state in
            
            guard let getItem = self.productViewModel.Product else {
                return
            }
            
            self.productName.text = getItem.productDetailDto.name
            self.productPrice.text = "\(getItem.productDetailDto.price)원"
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
    
    @IBAction func didTabPurchase(_ sender: Any) {
        
        let headers: HTTPHeaders = [
            "Authorization": "KakaoAK d05457ec212e64c5f266ca54ee2728db"
        ]
        
        let parameters: [String: Any] = [
            "cid": "TC0ONETIME",
            "partner_order_id" : "partner_order_id",
            "partner_user_id" : "partner_user_id",
            "item_name" : productName.text,
            "quantity" : 1,
            "total_amount" : Int(productPrice.text ?? "0"),
            "tax_free_amount" : 0,
            "approval_url" : "",
            "cancel_url" : "",
            "fail_url" : ""
            
        ]
        
        AF.request("https://kapi.kakao.com/v1/payment/ready", method: .post,
                   parameters: parameters, headers: headers)
            .responseJSON(completionHandler: { response in
                switch response.result {
                case .success(let value):
                    print("통신 성공 !!")
                    
                    print(response.result)
                    if let detailsPlace = JSON(value)["documents"].array{
                        
                    }
                case .failure(let error):
                    print(error)
                }
            })
        
//        productViewModel.purchaseProduct { state in
//            switch state {
//            case .success: self.showSuccessAlert()
//            case .failure: self.showPostErrorAlert()
//            case .serverError: self.showPostErrorAlert()
//            }
//        }
    }
    
    
    
    struct purchaseList {
        let name: String
        let price: Int
    }
}
