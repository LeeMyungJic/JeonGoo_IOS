//
//  DetailViewController.swift
//  JeonGoo
//
//  Created by 이명직 on 2021/03/05.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var grade: UILabel!
    @IBOutlet weak var detail: UILabel!
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var likeBtn: UIButton!
    
    var getName: String?
    var getGrade: String?
    var getDetail: String?
    var getCount: String?
    var getLikes: String?
    var getPrice: String?
    
    var isLiked = false
    
    var imageStr = ["macbookPro", "macbookAir", "photo"]
    @IBOutlet weak var likes: UILabel!
    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var images: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func pageChanged(_ sender: Any) {
        images.image = UIImage(named: imageStr[pageControl.currentPage])
    }
    @IBAction func clickLike(_ sender: Any) {
        if isLiked {
            isLiked = false
            likeBtn.setImage(UIImage(named: "like1"), for: .normal)
        }
        else {
            isLiked = true
            likeBtn.setImage(UIImage(named: "like2"), for: .normal)
        }
    }
    
    
    
}
