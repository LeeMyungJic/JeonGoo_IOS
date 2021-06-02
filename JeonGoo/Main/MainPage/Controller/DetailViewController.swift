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
    var newLiked = true
    var oldLiked = true
    var likeValue: Int = 0
    var imageStr = [UIImage]()
    
    // MARK: --
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        getProductDetail()
        
        pageControl.layer.zPosition = 999
        self.view.bringSubviewToFront(self.backButton)
        
        // 언더라인
        self.detailStackView.addSubview(MakeUnderLineInStackView(target: detailStackView))
        self.priceStackView.addSubview(MakeUnderLineInStackView(target: priceStackView))
        
        
        pageControl.numberOfPages = imageStr.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.black
        
        images.isUserInteractionEnabled = true
        
        let left = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        let right = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        left.direction = .left
        right.direction = .right
        
        images.addGestureRecognizer(left)
        images.addGestureRecognizer(right)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if self.oldLiked != self.newLiked {
            switch newLiked{
            case false:
                productViewModel.removeInterestProduct(productId: DetailViewController.productId) { state in
                    print("관심 해제 : \(state)")
                }
            case true:
                productViewModel.setInterestProduct(productId: DetailViewController.productId) { state in
                    print("관심 등록 : \(state)")
                }
                
            }
        }
    }
    
    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
        if (sender.direction == .left && pageControl.currentPage != imageStr.count-1) {
            self.pageControl.currentPage += 1
        }
        
        if (sender.direction == .right && pageControl.currentPage != 0) {
            self.pageControl.currentPage -= 1
        }
        images.image = imageStr[pageControl.currentPage]
    }
    
    func getProductDetail() {
        productViewModel.findByProductId(id: DetailViewController.productId) { state in
            guard let getItem = self.productViewModel.Product else {
                return
            }
            DispatchQueue.main.async {
                
                for i in getItem.productDetailDto.fileList {
                    if i.filePath != "" && i.fileType == "IMAGE" {
                        let url = URL(string: i.filePath)
                        do {
                            let data = try Data(contentsOf: url!)
                            self.imageStr.append(UIImage(data: data)!)
                        }
                        catch {
                            
                        }
                        
                    }
                }
                if self.imageStr.count == 0 {
                    self.imageStr.append(UIImage(named: "defaultImage")!)
                }
                self.images.image = self.imageStr[0]
                self.pageControl.numberOfPages = self.imageStr.count
                
                self.name.text = getItem.productDetailDto.name
                self.price.text = "\(getItem.productDetailDto.price)원"
                self.detail.text = getItem.productDetailDto.description
                if getItem.productDetailDto.productGrade == "NONE" {
                    self.grade.text = setGrade(value: getItem.productDetailDto.certificationStatus)
                }
                else {
                    if getItem.productDetailDto.useStatus == "DISUSED" {
                        self.grade.text = "새상품"
                        self.grade.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
                        
                    }
                    else {
                        self.grade.text = setGrade(value: getItem.productDetailDto.productGrade)
                    }
                }
                self.id.setTitle(" \(getItem.userShowResponse.name)", for: .normal)
                self.likes.text = "관심 \(getItem.interestCount)"
                self.count.text = "조회 \(getItem.productDetailDto.hitCount)"
                self.likeValue = getItem.interestCount
                
                self.oldLiked = getItem.interested
                self.newLiked = getItem.interested
                switch getItem.interested {
                case false : self.likeBtn.setImage(UIImage(named: "like1"), for: .normal)
                case true : self.likeBtn.setImage(UIImage(named: "like2"), for: .normal)
                }
                
                if getItem.productDetailDto.salesStatus == "SOLD_OUT" {
                    self.purchaseBtn.isEnabled = false
                    self.purchaseBtn.setTitle("판매완료", for: .normal)
                    self.purchaseBtn.backgroundColor = #colorLiteral(red: 0.6666144729, green: 0.6666962504, blue: 0.6665866375, alpha: 1)
                }
            }
            
        }
    }
    
    
    // MARK: --
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func pageChanged(_ sender: Any) {
        images.image = imageStr[pageControl.currentPage]
    }
    @IBAction func clickLike(_ sender: Any) {
        
        let popUp = self.storyboard?.instantiateViewController(identifier: "LikePopUp")
        
        popUp!.modalPresentationStyle = .overCurrentContext
        popUp!.modalTransitionStyle = .crossDissolve
        
        let temp = popUp as! LikePopUp
        
        if newLiked {
            newLiked = false
            likeBtn.setImage(UIImage(named: "like1"), for: .normal)
            temp.getString = "관심목록 제거"
            self.likeValue -= 1
            self.likes.text = "관심 \(self.likeValue)"
        }
        else {
            newLiked = true
            likeBtn.setImage(UIImage(named: "like2"), for: .normal)
            temp.getString = "관심목록 추가"
            self.likeValue += 1
            self.likes.text = "관심 \(self.likeValue)"
        }
        self.present(popUp!, animated: false, completion: nil)
    }
}
