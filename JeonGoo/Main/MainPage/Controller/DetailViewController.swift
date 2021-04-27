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
    // MARK: --
    var getId: Int?
    
    var getName: String?
    var getGrade: String?
    var getDetail: String?
    var getCount: String?
    var getLikes: String?
    var getPrice: String?
    
    var productProvider = MoyaProvider<ProductService>()
    var isLiked = false
    
    var imageStr = ["macbookPro", "macbookAir", "photo"]
    
    // MARK: --
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageControl.layer.zPosition = 999
        self.view.bringSubviewToFront(self.backButton)
        
        guard let nameStr = getName else {return}
        name.text = nameStr
        guard let gradeStr = getGrade else {return}
        grade.text = gradeStr
        guard let detailStr = getDetail else {return}
        detail.text = detailStr
        guard let countStr = getCount else {return}
        count.text = countStr
        guard let likesStr = getLikes else {return}
        likes.text = likesStr
        guard let priceStr = getPrice else {return}
        price.text = priceStr
        
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
        productProvider.request(.findById(productId: getId!)) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    if response.statusCode == 200 || response.statusCode == 201 {
                        do {
                            if let json = try JSONSerialization.jsonObject(with: response.data, options: .allowFragments) as? [String: AnyObject]
                            {
                                print(json)
                                if let temp = json["data"] as? NSDictionary {
                                    
                                    var id = 0
                                    var name = ""
                                    var price = 0
                                    var useStatus = ""
                                    var productGrade = ""
                                    var description = ""
                                    
                                    id = temp["id"] as! Int
                                    name = temp["name"] as! String
                                    let priceTemp = temp["price"] as! [String:Any]
                                    price = priceTemp["value"] as! Int
                                    useStatus = temp["useStatus"] as! String
                                    productGrade = temp["productGrade"] as! String
                                    description = temp["description"] as! String
                                    
                                    DispatchQueue.main.async {
                                        self?.name.text = name
                                        self?.price.text = "\(price)원"
                                        self?.detail.text = description
                                        self?.grade.text = productGrade
                                    }
                                }
                            }
                        }
                        catch {
                            
                        }
                    }
                    
                } catch {
                }
            case .failure:
                print("error")
            }
        }
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
        }
        else {
            isLiked = true
            likeBtn.setImage(UIImage(named: "like2"), for: .normal)
            temp.getString = "관심목록 추가"
        }
        self.present(popUp!, animated: false, completion: nil)
    }
}
