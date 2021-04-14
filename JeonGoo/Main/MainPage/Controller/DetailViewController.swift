//
//  DetailViewController.swift
//  JeonGoo
//
//  Created by 이명직 on 2021/03/05.
//

import UIKit

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
    var getName: String?
    var getGrade: String?
    var getDetail: String?
    var getCount: String?
    var getLikes: String?
    var getPrice: String?
    
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
    
    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
        if (sender.direction == .left && pageControl.currentPage != imageStr.count-1) {
            self.pageControl.currentPage += 1
        }
        
        if (sender.direction == .right && pageControl.currentPage != 0) {
            self.pageControl.currentPage -= 1
        }
        images.image = UIImage(named: imageStr[pageControl.currentPage])
    }
    
    func lineDraw(viewLi:UIView)
    {
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor(red: 197/255, green: 197/255, blue: 197/255, alpha: 1.0).cgColor
        border.frame = CGRect(x: 0, y: viewLi.frame.size.height - width, width:  viewLi.frame.size.width, height: viewLi.frame.size.height)
        border.borderWidth = width
        viewLi.layer.addSublayer(border)
        viewLi.layer.masksToBounds = true
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
