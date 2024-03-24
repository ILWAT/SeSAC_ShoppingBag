# ShoppingBag
<p align="center"><img src="https://github.com/ILWAT/SeSAC_ShoppingBag/assets/87518434/ec0cc2f3-dac3-407d-93f0-1af97eda1dcb" width="20%"></img><img src="https://github.com/ILWAT/SeSAC_ShoppingBag/assets/87518434/0e117dd6-8813-4005-b0a4-0cb95cc3d387" width="20%"></img><img src="https://github.com/ILWAT/SeSAC_ShoppingBag/assets/87518434/7f1ebd80-afbf-4cd9-91a2-1e6a55794a83" width="20%"></img></p>

**🛒나만의 인터넷 쇼핑백**  

- 정렬 조건을 포함한 네이버 상품 검색 기능 제공
- 좋아요 목록 기기 저장
- 좋아요 목록 검색 기능
- 웹뷰를 통한 제품 상세보기 기능
----------

**📋핵심 기술**
- `MVC`을 채택하여 네트워크 Response Model 관리 및 View 전달 및 User Event의 처리
- 네이버 검색 `REST API`를 활용한 검색 결과 구현 및 `WKWebView`를 활용한 제품 상세정보 URL Present
- `UICollectionViewDataSourcePrefetching`을 활용한  Pagination으로 scroll 끊김 현상 방지
- `Repository Pattern`을 활용해 Realm CRUD 로직 구조화 및 상품 좋아요 동기화 처리
- `Kingfisher`를 통한 이미지 리소스 요청 및 DownSampling을 통한 메모리 최적화
- `#avaliable`을 통한 OS 버전별 deprecated 코드 분기를 통한 앱 안전성 향상
- `extension` + `NumberFormatter`를 활용한 순자 단위 표기 구현


## 🛠️개발
***🌎개발 환경***
> 개발 기간: 2023.09.07. ~ 09.11.  
> 개발 인원: 1인    
> Minimum Deployment: iOS 13.0+
---------
***⚙️기술 스택***
- **Framework**: `UIKit`
- **Design Pattern**: `MVC`,`Repository Pattern`, `Delegate Pattern`, `Singleton`,
- **Library**: `Alamofire`, `Kingfisher`, `SnapKit`, `Toast`, `Realm`






<!-- 

## ⚠Trouble Shooting

### Kingfisher Downsampling

|문제 상황|해결|
|:--:|:--:|
|||


- kingfisher를 통해 이미지를 받아오는 경우 아무 옵션 없이 사용하게 되면 요청한 이미지를 그대로 렌더링 및 캐싱하게 된다.
  ```Swift
    guard let imageURL = URL(string: data.image) else {return}
    productImageView.kf.setImage(with: imageURL) //받아오는 데이터 원본 그대로 렌더링
- 데이터 형식에서 이미지를 렌더링 하는 과정에서 
- .

  ```Swift
  extension KingfisherWrapper where Base: KFCrossPlatformImageView {
    @discardableResult
    public func setImageWithDownSampling(...) -> DownloadTask?
    {
        ...
        let processor = DownsamplingImageProcessor(size: CGSize(width: itemWidth, height: itemHeight))
        
        var newOprions: KingfisherOptionsInfo = options ?? []
        
        newOprions.append(.processor(processor))
        
        return setImage(
            with: resource,
            placeholder: placeholder,
            options: newOprions,
            progressBlock: nil,
            completionHandler: completionHandler
        )
    }
  }
## 📔회고
- 


#### 새싹의 2번째 평가과제(Recap Assignment)로 제출한 네이버 쇼핑 API를 활용해 장바구니를 구현하는 앱입니다.   

## 요구사항
|화면|핵심 요구사항|
|:---:|:---|
|<img src="https://github.com/ILWAT/SeSAC_ShoppingBag/assets/87518434/ec0cc2f3-dac3-407d-93f0-1af97eda1dcb" width="50%" height="50%"></img>|1. 검색데이터는 네이버 쇼핑 API 할용<br>2. 리턴키 입력으로 API 요청<br>3. 검색어 변경시 목록 리셋 후 다시 데이터 fetch<br>4. 30개를 기준으로 페이지네이션 처리<br>5. 셀선택시 상세화면<br>6. 좋아요 설정, 취소|
|<img src="https://github.com/ILWAT/SeSAC_ShoppingBag/assets/87518434/0e117dd6-8813-4005-b0a4-0cb95cc3d387" width="50%" height="50%"></img>|1. 검색 화면이나 상세 화면에서 좋아요를 설정한 전체 상품을 출력, 등록순 정렬(최근 추가 상품, 최상단 배치)<br>2. 서치바에서는 실시간 검색 기능<br>  - 데이터베이스에 저장된 좋아요 목록에서 실시간 검색 진행, 검색 쿼리는 title에 한함.<br>3.사용자가 좋아요를 설정하거나 취소 할 수 있습니다.<br>|
|<img src="https://github.com/ILWAT/SeSAC_ShoppingBag/assets/87518434/7f1ebd80-afbf-4cd9-91a2-1e6a55794a83" width="50%" height="50%"></img>|1.네비게이션 영역에 상품 타이틀과 상품의 좋아요 상태를 보여줍니다.<br>2. 사용자가 좋아요를 설정하거나 취소할 수 있습니다.| -->



<!--
## 🛠️개발
***🌎개발 환경***
> 개발 기간: 2024.01.02. ~ 03.01.  
> 개발 인원: 1인  
> 개발 언어: Swift  
> Minimum Deployment: iOS 16.0+: `UISheetPresentationController.Detent.custom`
---------
***⚙️기술 스택***
- **BaseSDK**: `UIKit`
- **Pattern**: `MVVM`, `Singleton`, `Input-Output Pattern`
- **Reactive Programming**: `RxSwift`
- **Package Management**: `SPM`, `CocoaPods`
- **CodeBaseUI**: `PHPickerViewController`, `SnapKit`, `Then`, `Toast`
- **Database**: `RealmSwift`
- **Network**: `Moya`, `SocketIO`, `Kingfisher`
- **Management**: `FireBase Cloud Messaging`  

## 🔥개발 Point
### 사이드 바 구현
- 사이드 바를 구현하기 위해 라이브러리를 사용할 수 있으나, 보편적인 사이드 바 구현 **라이브러리는 지원이 끊긴지 오래 되었음**에 따라 사이드 바 **직접 구현**을 선택.
- `UIView.animate()`를 통해 ViewWillAppear 시점과 viewWillDisappear 시점에서의 애니메이션을 구현.
- `UIPanGestureRecognizer`를 통해 뷰의 `Animate`를 적용하고 **View의 dismiss를 결정**할 수 있다.

### 채팅 로직
<img src="https://github.com/ILWAT/GrowingTalk/assets/87518434/756a373a-0bb1-4887-b3e2-51c894e70cca" width="60%"></img>
- 서버에서 채팅 내역에 대한 데이터를 받을 때, 모든 채팅 내역을 받게되면 채팅을 하면 할수록 서버 및 통신에 대해서 비용이 너무 커지게 된다.
- 그렇기 때문에 서버로부터 이미 받은 채팅 내역에 대해서는 로컬에 저장하여 CRD하는 방식으로 구현한 뒤, 로컬에서의 마지막 채팅을 기준으로 그 이후 채팅 내역을 받는 것으로 비용을 절감할 수 있다.
- 로컬 DB에 저장되어 있는 채팅내역, 서버 통신을 통해 채팅 내역을 받아오고 나면 `Socket`을 통해 실시간 데이터를 받아 채팅을 구현한다.
  



## ⚠Trouble Shooting
### 사이드바의 constraints + animate 문제: (`Main event loop`의 이해)
|문제 상황|정상|
|:--:|:--:|
|<img src="https://github.com/ILWAT/GrowingTalk/assets/87518434/6a4afd3b-0eb9-4001-b1e0-16a2aef8d715" width="20%"></img> |<img src="https://github.com/ILWAT/GrowingTalk/assets/87518434/da5ad0d6-a93c-457b-8363-b7465e8cede3" width="20%"></img>|

#### 문제점
- 사이드 바의 등장 애니메이션 효과를 적용하기 위해 사이드 바의 View 초기 위치를 너비만큼 현재 View로부터 음수 방향으로 Constraints를  viewDidLoad시점에 설정한 다음, ViewWillAppear 시점에 Constraints를 현재 View로 맞춰주어 UIView.animate() 메서드를 실행했으나, 뷰의 애니메이션이 **X 좌표 뿐만 아니라 Y좌표도 같이 Animation이 실행되는 문제점**이 발생
```Swift
private func sideBarAppearAnimation() {
      self.sideBarView.snp.updateConstraints { make in
            make.leading.equalTo(self.view)
        }
        UIView.animate(withDuration: 0.5, delay: 0) {
            self.view.layoutIfNeeded()
        }
}
```

#### 원인 및 해결
- 디버깅을 진행했을 때, viewWillAppear시점 전까지 사이드바 View의 초기 크기 및 위치가 모두 정해지지 않는 상태임을 확인
- `Main event loop`의 개념이 필요함.
  - 무작정 Constraints를 설정했다고 해서 바로 View에 Constraints가 적용되어 뷰의 위치와 크기가 결정되는 것이 아님.
  - `Main run loop`의 시점이 동작되어야 비로소 실질적 Constraints가 적용되어 뷰의 위치와 크기가 결정됨.
  - UIView.animate()는 Scope내에서의 View 변경사항을 그 이전과 비교하여 애니메이션을 실행하는 구조로 동작함.
  - 그렇기 때문에 ViewDidLoad() 실행 시점과 ViewWillAppear()가 실행되는 시점의 차이가 굉장히 짧은 경우, 실질적인 초기 Constraints가 적용되기 전에 Constratints가 덮어쓰기 되어 좌표(0, 0)과 Frame(0, 0)에 상태에서 최종 애니메이션이 실행되는 것이기에 이러한 문제가 발생.
  - Constraints가 덮어쓰기 되기 전에 `Main run loop`를 임의로 동작시켜 초기 뷰를 설정해 준 다음, Constraints를 바꾸어 animate를 실행하면 해당 문제가 해결됨.
```Swift
private func sideBarAppearAnimation() {
        self.view.layoutIfNeeded() //AutoLayout을 통해 뷰의 초기 위치와 크기를 잡았기에 애니메이션을 해당 메서드 실행 -> 뷰가 실제로 보여지기 전까지 초기 AutoLayout은 실행되지 않음.
        sideBarView.snp.updateConstraints { make in
            make.leading.equalTo(self.view)
        }
        UIView.animate(withDuration: 0.5, delay: 0) {
            self.view.layoutIfNeeded()
        }
    }
```

### 네비게이션 바의 UIBarButtonItem의 크기가 조절되지 않는 문제

|문제 상황|정상|
|:--:|:--:|
|<img width="341" alt="네비게이션 바 오류" src="https://github.com/ILWAT/GrowingTalk/assets/87518434/8990699d-9f56-41c7-9586-0292c19e1cd7">|<img width="314" alt="네비게이션 바 정상" src="https://github.com/ILWAT/GrowingTalk/assets/87518434/fc514b2e-e4da-4a34-885c-2f8681d8100f">|


- Left Bar Button Item을 기획 및 디자인에 맞추어 버튼 크기의 설정이 필요함.
  ```Swift
    let workSpaceImageButton = UIButton().then { view in
        view.frame = CGRect(origin: .zero, size: CGSize(width: 30, height: 30))
        let defaultImage = UIImage(named: "WorkSpace")
        view.setBackgroundImage(defaultImage, for: .normal)
        view.backgroundColor = .clear
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFit
    }

    lazy var workSpaceImageBarButton =  UIBarButtonItem(customView: workSpaceImageButton)

    ...

    navigationItem.setLeftBarButton(workSpaceImageBarButton, animated: true)

- 이 상황에서 버튼의 사이즈를 **Constraints 혹은 Frame으로 크기를 설정해 주어도 지정한 사이즈대로 구현되지 않는 문제** 발생.
- `UIButton`안의 image를 설정하는 경우, **설정한 image의 크기에 따라 button내 ImageView의 크기가 결정되고 button은 해당 imageView의 크기보다 작게 설정될 수 없기 때문에 해당 문제가 발생하는 것을 확인.**
- button 내 image를 설정하고 싶은 button의 사이즈보다 작게 resizing하여 button의 사이즈를 설정해주면 정상적으로 사이즈 조절이 가능.

  ```Swift
    let workSpaceImageButton = UIButton().then { view in
        view.frame = CGRect(origin: .zero, size: CGSize(width: 30, height: 30))
        let defaultImage = UIImage(named: "WorkSpace")?.resizingByRenderer(size: CGSize(width: 30, height: 30), tintColor: .BackgroundColor.backgroundPrimaryColor)
        view.setBackgroundImage(defaultImage, for: .normal)
        view.backgroundColor = .clear
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFit
    }
    
    lazy var workSpaceImageBarButton =  UIBarButtonItem(customView: workSpaceImageButton)
    
    ...

    navigationItem.setLeftBarButton(workSpaceImageBarButton, animated: true

-->


