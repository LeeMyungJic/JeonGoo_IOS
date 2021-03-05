//
//  ItemRegister3ViewController.swift
//  JeonGoo
//
//  Created by 이명직 on 2021/03/04.
//

import UIKit

class ItemRegister3ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var TableMain: UICollectionView!
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 13
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = TableMain.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! imageCell
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = TableMain.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.scrollDirection = .horizontal

        
        TableMain.delegate = self
        TableMain.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    @IBAction func Complete(_ sender: Any) {
        let msg = UIAlertController(title: "등록완료", message: "상품등록을 완료하였습니다", preferredStyle: .alert)
        
        
        let YES = UIAlertAction(title: "확인", style: .default, handler: { (action) -> Void in
           
            self.YesClick()
        })
        msg.addAction(YES)
        self.present(msg, animated: true, completion: nil)
    }
    
    func YesClick() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func Back(_ sender: Any) {
        
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
