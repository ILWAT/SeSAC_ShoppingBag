# SeSAC_ShoppingBag
#### 새싹의 2번째 평가과제(Recap Assignment)로 제출한 네이버 쇼핑 API를 활용해 장바구니를 구현하는 앱입니다.   

## 요구사항
|화면|핵심 요구사항|
|:---:|:---|
|<img src="https://github.com/ILWAT/SeSAC_ShoppingBag/assets/87518434/ec0cc2f3-dac3-407d-93f0-1af97eda1dcb" width="50%" height="50%"></img>|1. 검색데이터는 네이버 쇼핑 API 할용<br>2. 리턴키 입력으로 API 요청<br>3. 검색어 변경시 목록 리셋 후 다시 데이터 fetch<br>4. 30개를 기준으로 페이지네이션 처리<br>5. 셀선택시 상세화면<br>6. 좋아요 설정, 취소|
|<img src="https://github.com/ILWAT/SeSAC_ShoppingBag/assets/87518434/0e117dd6-8813-4005-b0a4-0cb95cc3d387" width="50%" height="50%"></img>|1. 검색 화면이나 상세 화면에서 좋아요를 설정한 전체 상품을 출력, 등록순 정렬(최근 추가 상품, 최상단 배치)<br>2. 서치바에서는 실시간 검색 기능<br>  - 데이터베이스에 저장된 좋아요 목록에서 실시간 검색 진행, 검색 쿼리는 title에 한함.<br>3.사용자가 좋아요를 설정하거나 취소 할 수 있습니다.<br>|
|<img src="https://github.com/ILWAT/SeSAC_ShoppingBag/assets/87518434/7f1ebd80-afbf-4cd9-91a2-1e6a55794a83" width="50%" height="50%"></img>|1.네비게이션 영역에 상품 타이틀과 상품의 좋아요 상태를 보여줍니다.<br>2. 사용자가 좋아요를 설정하거나 취소할 수 있습니다.|

