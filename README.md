# 전구 (전자기기를 구매하다)

💡 제품 상태 검증을 통한 전자기기 구매 플랫폼
---

- #### 제품 상태 검증을 통한 전자기기 구매 플랫폼

- #### 기술 스택

  - `Swift 5`,  `Xcode 12`

  - `Callback Closure`, `Delegate Pattern`, `MobileCoreServices`, `MVVM Pattern`

    

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
<img width="724" alt="스크린샷 2021-03-28 오후 6 24 55" src="https://user-images.githubusercontent.com/44960073/112747914-5de44d00-8ff3-11eb-9e4b-3b1099af925b.png">
<img width="724" alt="스크린샷 2021-03-28 오후 6 14 22" src="https://user-images.githubusercontent.com/44960073/112747915-5fae1080-8ff3-11eb-80dc-9c7b64be1451.png">

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

  
