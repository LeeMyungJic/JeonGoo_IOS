//
//  ItemRegister3ViewController.swift
//  JeonGoo
//
//  Created by 이명직 on 2021/03/04.
//

import UIKit
import MobileCoreServices

class ItemRegister3ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var TableMain: UICollectionView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var cameraBtn: UIButton!
    
    var dataArray = [String]()
    var imageData = [UIImage]()
    var flagImageSave = false
    let imagePicker = UIImagePickerController()
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = TableMain.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! imageCell
        
        // 콜백 클로저로 셀 삭제
        cell.delete = { [unowned self] in
           
            self.dataArray.remove(at: indexPath.row)
            self.TableMain.reloadData()
            self.countLabel.text = "\(dataArray.count) / 8"
        }
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = TableMain.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.scrollDirection = .horizontal

        imagePicker.delegate = self
        
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
    @IBAction func camera(_ sender: Any) {
        //dataArray.append("\(dataArray.count)")
        //countLabel.text = "\(dataArray.count) / 8"
        //self.TableMain.reloadData()
        
        openCamera()
    }
    
    func openCamera(){
        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
            flagImageSave = true // 사진 저장 플래그를 true로 설정
            
            imagePicker.delegate = self // 이미지 피커의 델리케이트를 self로 설정
            imagePicker.sourceType = .camera // 이미지 피커의 소스 타입을 Camera로 설정
            imagePicker.mediaTypes = [kUTTypeImage as String] // 미디어 타입을 kUTTypeImage로 설정
            imagePicker.allowsEditing = false // 편집을 허용하지 않음
            
            // 뷰 컨트롤러를 imagePicker로 대체
            present(imagePicker, animated: true, completion: nil)
        } else {
            // 카메라를 사용할 수 없을 때 경고 창 출력
            myAlert("Camera inaccessable", message: "Application cannot access the camera.")
        }
    }
    
    // 사진 촬영이나 선택이 끝났을 때 호출되는 델리게이트 메서드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // 미디어 종류 확인
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! NSString
        // 미디어가 사진이면
        if mediaType.isEqual(to: kUTTypeImage as NSString as String){
            // 사진을 가져옴
            let captureImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            
            if flagImageSave { // flagImageSave가 true일 때
                // 사진을 포토 라이브러리에 저장
                UIImageWriteToSavedPhotosAlbum(captureImage, self, nil, nil)
            }
            imageData.append(captureImage)
            self.countLabel.text = "\(imageData.count) / 8"
            self.TableMain.reloadData()
        }
        // 현재의 뷰(이미지 피커) 제거
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // 사진 촬영이나 선택을 취소했을 때 호출되는 델리게이트 메서드
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // 현재의 뷰(이미지 피커) 제거
        self.dismiss(animated: true, completion: nil)
    }
    
    func myAlert(_ title: String,message: String) {
        // Alert show
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
}


