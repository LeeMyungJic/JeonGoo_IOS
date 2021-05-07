//
//  DetailViewController.swift
//  JeonGoo
//
//  Created by 이명직 on 2021/03/05.
//

import UIKit
import Moya

class DetailViewController: UIViewController {
    
    // MARK: --
    @IBOutlet weak var id: UIButton!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var grade: UILabel!
    @IBOutlet weak var detail: UILabel!
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var detailStackView: UIStackView!
    @IBOutlet weak var priceStackView: UIStackView!
    
    @IBOutlet weak var likeBtn: UIButton!
    
    @IBOutlet weak var likes: UILabel!
    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var images: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var purchaseBtn: CustomButton!
    // MARK: --
    static var productId = 0
    
    var getId: Int?
    
    var productViewModel = ProductViewModel()
    var isLiked = false
    var likeValue: Int = 0
    var viewValue: Int = 0
    
    var imageStr = ["macbookPro", "macbookAir", "photo"]
    
    // MARK: --
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DetailViewController.productId = self.getId!
        
        pageControl.layer.zPosition = 999
        self.view.bringSubviewToFront(self.backButton)
        
        // 언더라인
        self.detailStackView.addSubview(MakeUnderLineInStackView(target: detailStackView))
        self.priceStackView.addSubview(MakeUnderLineInStackView(target: priceStackView))
        
        
        grade.attributedText = CustomLabel.init().setLabel(text: self.grade.text!, code: 1).attributedText
        
        name.attributedText = CustomLabel.init().setLabel(text: self.name.text!, code: 2).attributedText
        
        
        pageControl.numberOfPages = imageStr.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.black
        images.image = UIImage(named: imageStr[0])
        
        images.isUserInteractionEnabled = true
        
        let left = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        let right = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        left.direction = .left
        right.direction = .right
        
        images.addGestureRecognizer(left)
        images.addGestureRecognizer(right)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getProductDetail()
    }
    
    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
        if (sender.direction == .left && pageControl.currentPage != imageStr.count-1) {
            self.pageControl.currentPage += 1
        }
        
        if (sender.direction == .right && pageControl.currentPage != 0) {
            self.pageControl.currentPage -= 1
        }
        images.image = UIImage(named: imageStr[pageControl.currentPage])
    }
    
    func getProductDetail() {
        productViewModel.findByProductId(id: self.getId!) { state in
            let getItem = self.productViewModel.Product
            DispatchQueue.main.async {
                self.name.text = getItem?.productDetailDto.name
                self.price.text = "\(getItem!.productDetailDto.price)원"
                self.detail.text = getItem?.productDetailDto.description
                self.grade.text = setGrade(value: getItem?.productDetailDto.productGrade ?? "Null")
                self.id.setTitle(" \(getItem!.userShowResponse.name)", for: .normal)
                if getItem?.productDetailDto.salesStatus == "SOLD_OUT" {
                    self.purchaseBtn.isEnabled = false
                    self.purchaseBtn.setTitle("판매완료", for: .normal)
                    self.purchaseBtn.backgroundColor = #colorLiteral(red: 0.6666144729, green: 0.6666962504, blue: 0.6665866375, alpha: 1)
                }
            }
            
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
    
    // MARK: --
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func pageChanged(_ sender: Any) {
        images.image = UIImage(named: imageStr[pageControl.currentPage])
    }
    @IBAction func clickLike(_ sender: Any) {
        
        let popUp = self.storyboard?.instantiateViewController(identifier: "LikePopUp")
        
        popUp!.modalPresentationStyle = .overCurrentContext
        popUp!.modalTransitionStyle = .crossDissolve
        
        let temp = popUp as! LikePopUp
        
        if isLiked {
            isLiked = false
            likeBtn.setImage(UIImage(named: "like1"), for: .normal)
            temp.getString = "관심목록 제거"
            self.likeValue -= 1
            self.likes.text = "관심 \(self.likeValue)"
        }
        else {
            isLiked = true
            likeBtn.setImage(UIImage(named: "like2"), for: .normal)
            temp.getString = "관심목록 추가"
            self.likeValue += 1
            self.likes.text = "관심 \(self.likeValue)"
        }
        self.present(popUp!, animated: false, completion: nil)
    }
    @IBAction func didTapPurchaseBtn(_ sender: Any) {
        productViewModel.purchaseProduct { state in
            switch state {
            case .success: self.showSuccessAlert()
            case .failure: self.showPostErrorAlert()
            case .serverError: self.showPostErrorAlert()
            }
        }
    }
}
