# 전구 (전자기기를 구매하다)

---

서비스 소개
---

- 제품 상태 검증을 통한 전자기기 구매 플랫폼

## 사용기술

- `Swift 5`,  `Xcode 12`
- `RxSwift`, `Moya`, `Alamofire`, `multipart/form-data`
- `MVVM Pattern`, `Delegate Pattern`
- `kakaoPay`, `kakaoLocalAPI`

## 수행 역할

- API 호출 후 처리되는 로직을 비동기화 하여 상황에 맞게 응답 값을 UI에 출력
- 카카오페이를 연동하여 결제 진행

## 개발 기간

- 2021.03.05 ~ 2021.06.08

## 주요 기능

- #### 상품 등록

- #### 카카오페이를 이용한 상품 구매

- #### 관심 상품 등록 및 해제
---

## 2021 03 04

- #### 상품등록 페이지

  - 탭바 아이템 중 추가 아이템을 클릭하면 새로운 뷰(상품추가 페이지)를 띄움 
  - viewWillAppear에 탭바의 첫 번째 페이지(메인 페이지)로 이동하는 코드 추가
  - 현재 : 추가버튼 클릭 - 메인 페이지로 이동 - 상품추가 페이지 출력
  - 수정해야할 부분 : 추가버튼 클릭 - 상품추가 페이지 출력 - 추가 완료 후 메인 페이지로 이동
  - 완료 버튼을 누르면 완료 팝업 메시지 출력 (확인을 누르면 추가 페이지를 닫음)

---

## 2021 03 05

- #### 메인 페이지

  - 사용 프로토콜

    - ###### `UITableViewDelegate`

    - ###### `UITableViewDataSource`

  - 상품의 상태(새상품, 중고), 예약 여부, 정품여부에 따라 글자의 색상 변경

    ~~~ swift
    // 정품인증이 확인된 상품의 색상 변경 
    if products[indexPath.row].isGenuine {
                cell.grade.text! = cell.grade.text! + "  정품인증"
      
                let attributedStr = NSMutableAttributedString(string: cell.grade.text!)
                attributedStr.addAttribute(.foregroundColor, value: #colorLiteral(red: 0.1567805707, green: 0.5004235506, blue: 0.7245382667, alpha: 1), range: (cell.grade.text as! NSString).range(of: "정품인증"))
    
                cell.grade.attributedText = attributedStr
            }
    ~~~

- 각 상품을 클릭하면 해당하는 디테일뷰로 데이터(상품 정보, 설명 등)를 전달하고 화면전환

- 클릭할 때마다 서버에 요청하여 해당 상품 정보를 가져오는 방식으로 바꿀까 생각중

---

## 2021 03 06

- #### 상품등록 페이지

  - 사용 프로토콜 

    - ###### `UIImagePickerControllerDelegate`

    - ###### `UINavigationControllerDelegate`

    - ###### `UICollectionViewDataSource`

    - ###### `UICollectionViewDelegate`

  - 각 카메라버튼을 클릭하면 카메라가 실행됨

  - 카메라로 촬영한 사진들을 상품등록 페이지로 가져옴

  - 사진 : 총 8장 / 시연 영상 : 1개 / 시리얼 넘버 사진 : 1장 (시리얼 넘버촬영은 건너뛰기가 가능)

  - 컬렉션 뷰(Horizontal) 셀은 가져온 사진 수만큼 생성

  - 각 컬렉션 뷰 셀에는 사진을 삭제할 수 있는 버튼이 있음

  - 셀에 있는 버튼을 클릭하여 사진 삭제

    - 셀 클래스 파일에 클로저 추가 

      ~~~ swift
      class imageCell: UICollectionViewCell {
          var delete : (() -> ()) = {}
          
          @IBOutlet weak var image: UIImageView!
          @IBOutlet weak var removeButton: UIButton!
        
          // 버튼을 클릭하면 delete() 클로저 실행
          @IBAction func removeCell(_ sender: Any) {
              delete()
          }
      }
      ~~~

    - 셀을 정의 할 때 delete 추가

      ~~~ swift
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
              let cell = TableMain.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! imageCell
              
              cell.delete = { [unowned self] in
                 
                  self.dataArray.remove(at: indexPath.row)
                  self.TableMain.reloadData()
                  self.countLabel.text = "\(dataArray.count) / 8"
              }
              return cell
          }
      ~~~

---

## 2021 03 16

- #### 메인 페이지 (상품 검색기능 추가)

  - 사용 프로토콜 

    - ###### `UISearchBarDelegate`

  - ViewDidLoad에 가져온 상품리스트와 필터링 리스트를 일치시킨다.

  - searchBarSearchButtonClicked()을 사용하여 검색된 단어가 있으면 필터링을 시작한다.

  - 서버와 연동하면 이 부분(필터링)은 제거할 예정 -> 서버에 필터링 요청해서 받아오기

  ~~~ swift
  func setSearchBar(){
              
              searchBar.placeholder = "Search"
              // 좌측에 이미지넣기
  searchBar.setImage(resize(getImage: UIImage(named: "search")!, size: 20), for: UISearchBar.Icon.search, state: .normal)
              
              
              if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
                  // 서치바 백그라운드 컬러 지정
                  textfield.backgroundColor = UIColor.white
                  // 플레이스홀더 색상 지정
                  textfield.attributedPlaceholder = NSAttributedString(string: textfield.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
                  // 서치바 텍스트 색상 지정
                  textfield.textColor = UIColor.black
              
              }
          }
  ~~~

  ~~~swift
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
          
          dismissKeyboard()
         
          guard let searchStr = searchBar.text, searchStr.isEmpty == false else {
              self.searchData = self.products
              return
          }
          print("검색어 : \(searchStr)")
      
          self.searchData = self.products.filter{
              (product: Product) -> Bool in
              product.name.contains(searchStr)
              
      }
          DispatchQueue.main.async {
              self.TableMain.reloadData()
          }   
      }
  ~~~

---

## 2021 03 19

- #### 마이 페이지 하위 뷰 (MVVM 패턴 적용 및 URL로 이미지 가져오기)

  - 원래는 서버에서 가져와야 하지만 아직 서버구축이 안 되어 있으므로 임의로 데이터 추가

  - Model 추가 - 사용할 데이터들을 가져온다

    ~~~ swift
    class Model: NSObject {
        func getProducts(subURL: String) -> [MyProduct] {
            var products = [MyProduct]()
            products.append(MyProduct(image: "http://movie.phinf.naver.net/20171201_181/1512109983114kcQVl_JPEG/movie_image.jpg?type=m99_141_2", name: "macbookPro", price: 3000000, like: 32, grade: "A등급", status: "검수중"))
            products.append(MyProduct(image: "http://movie2.phinf.naver.net/20170925_296/150631600340898aUX_JPEG/movie_image.jpg?type=m99_141_2", name: "macbookAir", price: 1890000, like: 21, grade: "B등급", status: "판매중"))
            products.append(MyProduct(image: "http://movie2.phinf.naver.net/20170928_85/1506564710105ua5fS_PNG/movie_image.jpg?type=m99_141_2", name: "airpod", price: 260000, like: 14, grade: "A등급", status: "검수중"))
    
            
            return products
        }
    }
    ~~~

  - ViewModel 추가 - Model에서 가져온 데이터들을 view에 적용시킬 수 있도록 준비

  - subURL은 구매/판매/관심 3가지로 요청 URL이 3가지이다. 각각 맞는 데이터를 가져오기 위해 추가했다. 

    ~~~ swift
    class MyProductViewModel: NSObject {
        let model:Model = Model()
        var productsData = [MyProduct]()
        
        override init() {
            let data1 = model.getProducts(subURL: "")
            let data2 = NSMutableArray()
            for i in 0..<data1.count {
                let productData = data1
                let name = productData[i].name
                let image = productData[i].image
                let price = productData[i].price
                let like = productData[i].like
                let grade = productData[i].grade
                let status = productData[i].status
                
                productsData.append(MyProduct(image: image, name: name, price: price, like: like, grade: grade, status: status))
            }
            //productsData = NSArray(array: data2)
        }
    }
    ~~~

  - 이제 데이터를 셀에서 사용하면 된다

    ~~~ swift
    let productsModel = MyProductViewModel()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return productsModel.productsData.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let getProduct = productsModel.productsData[indexPath.row] as! MyProduct
            
            let cell = TableMain.dequeueReusableCell(withIdentifier: "SaleListCell") as! SaleListCell
            
            cell.name.text = getProduct.name
            cell.grade.text = getProduct.grade
            cell.price.text = "\(getProduct.price)원"
            cell.stateLabel.text = getProduct.status
            
            // URL로 이미지 가져오기 !
            let url = URL(string: getProduct.image)
            var image : UIImage?
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url!)
                DispatchQueue.main.async {
                    cell.productImage.image = UIImage(data: data!)
                    
                }
            }
            
            return cell
        }
    ~~~

---

## 2021 03 20

- #### 상품등록 페이지 (촬영한 사진 및 동영상 가져오기)

- 앨범, 카메라, 마이크 접근 권한이 필요하다. 

![스크린샷 2021-03-21 오후 4.12.18](/Users/mingjic2/Desktop/스크린샷 2021-03-21 오후 4.12.18.png)

- 사진은 최대 8장까지 등록이 가능 - 사진촬영이 끝날 때마다 컬렉션뷰에 추가해준다

  ~~~ swift
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
  ...
    
  // imageData : 이미지를 담는 배열 ([UIImage]())  
  imageData.append(captureImage)
              DispatchQueue.main.async {
                  // 촬영 후 사진 개수 카운트 증가
                  self.countLabel.text = "\(self.imageData.count) / 8"
                  // 셀에 적용
                  self.TableMain.reloadData()
              }
  }
  ~~~

- 만약 촬영한 미디어를 저장하고 싶다면!

  ~~~ swift
  // 사진
  // 플래그가 true일 경우 앨범에 저장
  if flagImageSave { 
    							let captureImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
                  UIImageWriteToSavedPhotosAlbum(captureImage, self, nil, nil)
              }
  
  // 동영상
  // 플래그가 true일 경우 앨범에 저장
  if flagImageSave {
                  videoURL = (info[UIImagePickerController.InfoKey.mediaType] as! URL)
                 
                  UISaveVideoAtPathToSavedPhotosAlbum(videoURL.relativePath, self, nil, nil)
              }
  ~~~

- 동영상을 촬영해서 뷰에 추가시키고 싶다

---

## 2021 03 22

- #### 메인 페이지(상품 검색기능 수정, attributedText를 따로 클래스 파일로 분리)

- 대소문자 구분 없이 검색

  ~~~ swift
  self.searchData = self.products.filter{
              (product: Product) -> Bool in
    					// 대소문자 구분 없이 검색이 가능하도록 수정
              product.name.lowercased().contains(searchStr.lowercased())
  }
  ~~~

- Cancel 버튼 추가

  - 클릭하면 서치바 텍스트를 초기화시키고, 다시 모든 데이터를 출력한다

  ~~~ swift
  self.searchData = self.products
          DispatchQueue.main.async {
              self.TableMain.reloadData()
              self.searchBar.text = ""
  }
  ~~~

- attributedText를 따로 분리하였으나 뭔가 많이 잘못되었음을 느꼈다. 다시 수정해야겠다...

---

## 2021 03 23

- #### 중복 코드 제거 (자주 쓰이는 ImageResize 함수를 따로 분리해서 사용), LaunchScreen 추가

  ~~~ swift
  func ImageResize(getImage:UIImage, size:Double) -> UIImage {
      
      let wif = 70
      var new_image : UIImage!
      let size = CGSize(width:  size  , height: size )
      
      let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
      
      UIGraphicsBeginImageContextWithOptions(size, false, 1.0)
      getImage.draw(in: rect)
      
      new_image = UIGraphicsGetImageFromCurrentImageContext()!
      UIGraphicsEndImageContext()
      
      return new_image
  }
  ~~~

- #### 마에페이지 하위 뷰 CustomText 적용

---

## 2021 03 28

- #### 뷰에 UnderLine 추가하는 함수 생성

  ![스크린샷 2021-03-28 오후 6.24.55](/Users/mingjic2/Desktop/스크린샷 2021-03-28 오후 6.24.55.png)

  ![스크린샷 2021-03-28 오후 6.14.22](/Users/mingjic2/Desktop/스크린샷 2021-03-28 오후 6.14.22.png)

- y: target.frame.height - 10 부분이 아직 잘 이해가 안 간다. 그냥 target.frame.height로 했을 경우 라인이 안 보여서 수정. 

- 한 화면을 view로 나눈 경우와 stackView로 나눈 경우가 있기 때문에 함수도 나눠버림

- 뷰일 경우 맨 아래에 적용되기 때문에 나누고자 하는 부분의 위쪽에 추가하기

- 스택뷰일 경우 스택은 위부터 쌓이기 때문에 나누고자 하는 부분의 아래에 추가하기

- 다른 방법을 찾아봐야겠다...

  ~~~ swift
  // 뷰에 추가
  func MakeUnderLineInView(target: UIView) -> UIView {
      var lineView = UIView(frame: CGRect(x: 0, y: target.frame.height - 10, width: target.frame.size.width*0.93, height: 1.8))
      lineView.backgroundColor = #colorLiteral(red: 1, green: 0.674518168, blue: 0, alpha: 1)
      return lineView
  }
  
  // 스택뷰에 추가
  func MakeUnderLineInStackView(target: UIStackView) -> UIStackView {
      var lineView = UIStackView(frame: CGRect(x: 0, y: -10, width: target.frame.size.width*0.93, height: 1.8))
      lineView.backgroundColor = #colorLiteral(red: 1, green: 0.674518168, blue: 0, alpha: 1)
      return lineView
  }
  
  ~~~

  

- y: target.frame.height - 10 부분이 아직 잘 이해가 안 간다. 그냥 target.frame.height로 했을 경우 라인이 안 보여서 수정. 

- 한 화면을 view로 나눈 경우와 stackView로 나눈 경우가 있기 때문에 함수도 나눠버림

- 뷰일 경우 맨 아래에 적용되기 때문에 나누고자 하는 부분의 위쪽에 추가하기

- 스택뷰일 경우 스택은 위부터 쌓이기 때문에 나누고자 하는 부분의 아래에 추가하기

- 다른 방법을 찾아봐야겠다...

  ~~~ swift
  // 뷰에 추가
  func MakeUnderLineInView(target: UIView) -> UIView {
      var lineView = UIView(frame: CGRect(x: 0, y: target.frame.height - 10, width: target.frame.size.width*0.93, height: 1.8))
      lineView.backgroundColor = #colorLiteral(red: 1, green: 0.674518168, blue: 0, alpha: 1)
      return lineView
  }
  
  // 스택뷰에 추가
  func MakeUnderLineInStackView(target: UIStackView) -> UIStackView {
      var lineView = UIStackView(frame: CGRect(x: 0, y: -10, width: target.frame.size.width*0.93, height: 1.8))
      lineView.backgroundColor = #colorLiteral(red: 1, green: 0.674518168, blue: 0, alpha: 1)
      return lineView
  }
  
  ~~~



---

## 2021 04 07

- #### 중복되는 코드 제거 (다음 버튼, 선택 버튼)

  - 다음 버튼

    ~~~ swift
    // setButton 클래스 생성
    func setEnabledButton(_ button: UIButton) {
        button.isEnabled = false
        button.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    }
    
    ~~~

  - 선택 버튼

    ~~~ swift
    import UIKit
    
    class RadioButton: UIButton {
        // 선택할 버튼들을 넣는 배열
        var alternateButton:Array<RadioButton>?
        
        override func awakeFromNib() {
            self.layer.cornerRadius = 5
            self.layer.masksToBounds = true
            self.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
            self.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        }
        
        func unselectAlternateButtons() {
            if alternateButton != nil {
                self.isSelected = true
                
                for aButton:RadioButton in alternateButton! {
                    aButton.isSelected = false
                }
            } else {
                toggleButton()
            }
        }
        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            unselectAlternateButtons()
            super.touchesBegan(touches, with: event)
        }
        
        func toggleButton() {
            self.isSelected = !isSelected
        }
        
        override var isSelected: Bool {
            didSet {
                if isSelected {
                    self.layer.backgroundColor = #colorLiteral(red: 1, green: 0.674518168, blue: 0, alpha: 1)
                    
                } else {
                    self.layer.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
                }
            }
        }
    }
    
    
    // 사용 예시
    @IBOutlet weak var newButton: RadioButton!
    @IBOutlet weak var oldButton: RadioButton!
    
    newButton?.alternateButton = [oldButton!]
    oldButton?.alternateButton = [newButton!]
    ~~~


---

## 2021 04 14

- #### 상품 디테일 페이지

  - 관심 버튼 클릭 시 팝업 보여주기 (버튼 없이 시간이 지나면 사라지도록 구현)

    ~~~ swift
    // 시간이 지나면 사라지도록
    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000)) {
                self.dismiss(animated: true, completion: nil)
    }
    pageControl.layer.zPosition = 999
            self.view.bringSubviewToFront(self.backButton)
    ~~~

- #### 회원가입 페이지 - self.dismiss 두 번 사용하는 것 수정

  ~~~ swift
  // 네비게이션 컨트롤러의 루트 뷰로 이동
  self.navigationController?.popToRootViewController(animated: true)
  ~~~



---

## 2021 04 21

- #### 로그인 페이지 - 로그인 기능 구현 (Alamofire)

  ~~~ swift
  import Alamofire
  
  func Post(param: [String:Any], subURL: String, success: (()->Void)? = nil, fail: ((String)->Void)? = nil) {
      let url = NetworkController.baseURL + subURL
      print("url : \(url)")
      
      let call = AF.request(url, method: .post, parameters: param, encoding: JSONEncoding.default)
      
      call.responseJSON { res in
          let result = try! res.result.get()
          guard let jsonObject = result as? NSDictionary else {
              fail?("dasdsdas \(result)")
              return
          }
          
          let resultCode = jsonObject["statusCode"] as! Int
          print("code : \(resultCode)")
          if resultCode == 200{
              success?()
          }
          else {
              let msg = (jsonObject["error_msg"] as? String) ?? "에러"
              fail?(msg)
          }
      }
  }
  ~~~


---

## 2021 05 24

- ###### 상품 등록 페이지 -> Alamofire를 사용하여 multipart/form-data 형식을 통해 상품 등록 구현

  ~~~ swift
  let header: HTTPHeaders = ["Content-Type": "multipart/form-data"]
          
          let url = URL(string: NetworkController.baseURL + "/products/users/\(MyPageViewController.userId!)")
          
          var images = [UIImage]()
      
  				// post 파라미터
          let parameters = ["description": detailStr.text!, "name": nameStr.text!, "price": priceStr.text!, "serialNumber": "serial", "useStatus": productStatus] as [String : Any]
          
  				// 시뮬레이터에서는 카메라가 동작하지 않기 때문에 임의로 이미지 추가
          images.append(UIImage(named: "macbookAir")!)
          images.append(UIImage(named: "macbookPro")!)
          
          var data = [Data]()
          for image in images {
              let imageData = image.jpegData(compressionQuality: 0.5)
              data.append(imageData!)
          }
          
          AF.upload(multipartFormData: { multipart in
              
              // 파라미터를 multipart/form-data 에 맞게 변환
              for (key, value) in parameters {
                  multipart.append("\(value)".data(using: .utf8)!, withName: key, mimeType: "text/plain")
              }
              var cnt = 1
              for item in data {
                  multipart.append(item, withName: "imageFiles", fileName: "File_name\(cnt)", mimeType: "image/jpg")
                  cnt += 1
              }
              // 파라미터에 "videoFile"가 필요하기 때문에 임의로 추가
              multipart.append(data[0], withName: "videoFile", fileName: "image.jpg", mimeType: "image/jpg")
              
              
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
  ~~~

---

## 2021 05 26

- ###### 상품 등록 페이지 - video 업로드 구현 / 미디어 이름 중복을 방지하기 위해 파일 이름에 random 값 부여

  - 시뮬레이터로 영상을 촬영할 수 없기 때문에 URL로 영상 다운로드 -> 다운로드한 영상을 업로드 하는 방식으로 구현

  ~~~ swift
  import Alamofire
  import Photos
  
  class ItemRegister2ViewController: UIViewController {
   
      // 이미지를 담을 배열
      var imageDatas = [UIImage]()
      let productViewModel = ProductViewModel()
      
      // URL로 영상 저장 후 getData에 넣기
      var getData : NSData?
    
      override func viewDidLoad() {
    
          // sample video test URL
          let videoImageUrl = "http://techslides.com/demos/sample-videos/small.mp4"
  
          // URL로 부터 동영상 저장 후 getData에 넣어줌
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
                      }
                  }
                  self.getData = urlData
              }
          }
          
      }
      @IBAction func next(_ sender: Any) {
          var productStatus = "USED"
          if newButton.isSelected {
              productStatus = "DISUSED"
          }
          let header: HTTPHeaders = ["Content-Type": "multipart/form-data"]
          
          let url = URL(string: NetworkController.baseURL + "/products/users/\(MyPageViewController.userId!)")
          
      
          let parameters = ["description": detailStr.text!, "name": nameStr.text!, "price": priceStr.text!, "serialNumber": "serial", "useStatus": productStatus] as [String : Any]
          
          // 임의의 사진 넣기
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
                  // 이름이 겹치지 않게 random 값을 넣어줌
                  let randomNo: UInt32 = arc4random_uniform(100000000) + 1;
  
                  multipart.append(item, withName: "imageFiles", fileName: "File_name\(randomNo)", mimeType: "image/jpg")
              }
              
              let randomNo: UInt32 = arc4random_uniform(100000000) + 1;
                                        
              // 저장한 동영상을 업로드                          
              multipart.append(self.getData! as Data, withName: "videoFile", fileName: "\(randomNo).mp4", mimeType: "video/mp4")
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
  
  ~~~

  

## Trouble Shooting

- ###### 뒤로가기 버튼 클릭이 안되고, pageControll이 가려지는 이슈

  - zPosition 값을 수정하여 해결

    ~~~ swift
    // z포지션을 수정하여 맨 앞에 보이도록 수정
    pageControl.layer.zPosition = 999
    // 버튼을 메인 뷰로 빼고 맨 앞으로 가져옴
    self.view.bringSubviewToFront(self.backButton)
    ~~~

- ###### 버튼 타입을 그대로(System) 두었을 때 발생하는 이슈 -> 버튼을 클릭하면 텍스트 부분의 색이 변한다

  - 타입을 Custom으로 변경하여 해결

  <img width="" alt="스크린샷 2021-04-08 오후 7 40 11" src="https://user-images.githubusercontent.com/44960073/114013442-7e898e00-98a2-11eb-967c-603ce8bc4fcf.png">

- ###### 테이블뷰 셀 인덱스에 맞지 않는 이미지가 출력되는 오류

  - else 문에 디폴트 이미지값을 넣어주는 코드 추가 

    ~~~ swift
    DispatchQueue.main.async {            for i in self.searchData[indexPath.row].productDetailDto.fileList {                if i.filePath != "" && i.fileType == "IMAGE" {                    let url = URL(string: i.filePath)                    do {                        let data = try Data(contentsOf: url!)                        cell.itemImage.image = UIImage(data: data)                        break                    }                    catch {                                            }                }                else {                    cell.itemImage.image = UIImage(named: "defaultImage")                }            }        }
    ~~~

    
