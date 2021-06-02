//
//  ItemRegister2ViewController.swift
//  JeonGoo
//
//  Created by 이명직 on 2021/03/04.
//

import UIKit
import Alamofire

import Photos

class ItemRegister2ViewController: UIViewController {

    // MARK: --
    @IBOutlet weak var nextButton: CustomButton!
    
    @IBOutlet weak var newButton: RadioButton!
    @IBOutlet weak var oldButton: RadioButton!

    @IBOutlet weak var nameStr: UITextField!
    @IBOutlet weak var functionStr: UITextField!
    
    @IBOutlet weak var detailStr: UITextView!
    @IBOutlet weak var priceStr: UITextField!
    
    @IBOutlet weak var errorStr: UILabel!
    
    var imageDatas = [UIImage]()
    let productViewModel = ProductViewModel()
    
    var getData : NSData?
    // MARK: --
    override func viewDidLoad() {
        super.viewDidLoad()

        self.detailStr.layer.cornerRadius = 8
        self.detailStr.layer.borderWidth = 1
        self.detailStr.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        newButton?.alternateButton = [oldButton!]
        oldButton?.alternateButton = [newButton!]
        setEnabledButton(nextButton)
        
        // sample video test URL
        let videoImageUrl = ""

        print("DownLoad ...")
        DispatchQueue.global(qos: .background).async {
            if let url = URL(string: videoImageUrl),
                let urlData = NSData(contentsOf: url) {
                let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0];
                let filePath="\(documentsPath)/tempFile.mp4"
                DispatchQueue.main.async {
                    urlData.write(toFile: filePath, atomically: true)
                    PHPhotoLibrary.shared().performChanges({
                        PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: URL(fileURLWithPath: filePath))
                    }) { completed, error in
                        if completed {
                            print("Video is saved!")
                        }
                        else {
                            print("Video Save Error")
                        }
                    }
                }
                self.getData = urlData
            }
        }
    }
    
    // MARK: --
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        
        self.view.endEditing(true)
        if nameStr.text != "" && functionStr.text != "" && detailStr.text != "" && priceStr.text != "" {
            self.nextButton.isEnabled = true
            self.nextButton.backgroundColor = #colorLiteral(red: 1, green: 0.674518168, blue: 0, alpha: 1)
            self.errorStr.text = ""
        }
        else {
            self.nextButton.isEnabled = false
            self.nextButton.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            self.errorStr.text = "모든 항목을 입력해 주세요!"
        }
    }
    
    // MARK: --
    @IBAction func Cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // 다음 페이지는 카메라를 사용하는데 시뮬레이터라 에러발생으로 일단 next 버튼 누르면 상품을 등록하도록 구현
    @IBAction func next(_ sender: Any) {
        var productStatus = "USED"
        if newButton.isSelected {
            productStatus = "DISUSED"
        }
        let header: HTTPHeaders = ["Content-Type": "multipart/form-data"]
        
        let url = URL(string: NetworkController.baseURL + "/products/users/\(MyPageViewController.userId!)")
        
    
        let parameters = ["description": detailStr.text!, "name": nameStr.text!, "price": priceStr.text!, "serialNumber": "serial", "useStatus": productStatus] as [String : Any]
        
        imageDatas.append(UIImage(named: "macbookAir")!)
        imageDatas.append(UIImage(named: "macbookPro")!)
        
        var data = [Data]()
        for image in imageDatas {
            let imageData = image.jpegData(compressionQuality: 0.5)
            data.append(imageData!)
        }
        
        AF.upload(multipartFormData: { multipart in
            
            for (key, value) in parameters {
                multipart.append("\(value)".data(using: .utf8)!, withName: key, mimeType: "text/plain")
            }
            for item in data {
                let randomNo: UInt32 = arc4random_uniform(100000000) + 1;

                multipart.append(item, withName: "imageFiles", fileName: "File_name\(randomNo)", mimeType: "image/jpg")
            }
            
            let randomNo: UInt32 = arc4random_uniform(100000000) + 1;
            //multipart.append(self.getData! as Data, withName: "videoFile", fileName: "\(randomNo).mp4", mimeType: "video/mp4")
            multipart.append(data[0], withName: "videoFile", fileName: "\(randomNo).mp4", mimeType: "video/mp4")
        }, to: url!
        , headers: header).uploadProgress(queue: .main, closure: { progress in
            
        }).responseJSON(completionHandler: { data in
            switch data.result {
            case .success(_):
                do {
                    print("success")
                }
                
            case .failure(_):
                print("ERROR")
            }
        })
    }
}
