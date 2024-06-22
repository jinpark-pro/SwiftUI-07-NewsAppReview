# 네이버 검색

## SwiftUI, Combine 실습 프로젝트

- 개요
  - 이 과제는 SwiftUI, Combine 을 사용하여 간단한 뉴스 검색 앱을 만드는 것입니다. 학생들은 네이버 검색 API를 통해 뉴스를 검색하고 표시하는 앱을 구현하며 SwiftUI의 뷰 구성, Combine을 통한 데이터 바인딩을 실습합니다. 또한 추가 기능으로 이미지 로드, 오프라인 처리, 검색 기능을 구현합니다.
- 필수 요구사항
  1. 프로젝트 설정 및 API 키 준비
     - Xcode에서 새로운 SwiftUI 프로젝트를 생성한다.
     - 네이버 개발자 센터(https://developers.naver.com/)에서 애플리케이션을 등록하고 Client ID와 Client Secret을 발급받는다.
  2. 모델 생성
     - 뉴스 기사를 표현할 모델을 생성한다.
     - 모델은 NewsItem과 NewsResponse 구조체를 포함하며, Codable 프로토콜을 준수한다.
  3. 네트워크 서비스 생성 (Combine 사용)
     - Combine을 사용하여 네이버 검색 API에서 뉴스를 검색하는 NewsService 클래스를 생성한다.
     - searchNews 메소드는 AnyPublisher<[NewsItem], Error>를 반환해야 한다.
  4. 뷰 모델 생성
     - Combine을 사용하여 네트워크 데이터를 처리하는 NewsViewModel 클래스를 생성한다.
     - @Published 프로퍼티로 newsItems와 errorMessage를 선언한다.
     - searchNews 메소드를 통해 뉴스를 검색하고 newsItems를 업데이트 한다.
  5. SwiftUI 뷰 구성
     - 뉴스 검색 결과를 표시하는 ContentView를 생성한다.
     - 뷰는 @StateObject var viewModel = NewsViewModel()를 사용하여 뷰 모델을 참조한다.
     - TextField와 Button을 사용하여 검색어를 입력받고, List를 사용하여 newsItems를 표시한다.
- 추가 요구사항
  - 이미지 로드 (AsyncImage 사용)
    - AsyncImage를 사용하여 뉴스 썸네일 이미지를 로드하고 표시한다.
    - 이미지 로드 상태(성공, 실패, 로딩 중)를 처리한다.
  - 오프라인 처리
    - 네트워크 오류가 발생했을 때 사용자에게 오류 메시지를 표시한다.
    - errorMessage 프로퍼티를 사용하여 오류 메시지를 표시한다.
  - 검색 옵션 추가
  - 사용자가 검색 옵션(정렬 순서, 검색 기간 등)을 설정할 수 있는 기능을 추가한다.
  - Picker를 사용하여 검색 옵션을 선택하고, 이를 searchNews 메소드에 반영한다.