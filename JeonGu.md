# 전구 (전자기기를 구매하다)

---

- #### 제품 상태 검증을 통한 전자기기 구매 플랫폼

- #### 기술 스택

  -  `Swift 5`,  `Xcode 12`

  - `Callback Closure`, `Delegate Pattern`, `MobileCoreServices`

    

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

      



