# MVVM-Sample-App
iOS15, CleanArchitecture, MVVM, Swift-Concurrency Without Library Using Movie API

[API Documentation - YTS YIFY](https://yts.mx/api#list_movies)

## 기술 스택

`iOS15`, `SwiftUI`, `Combine`, `Async/Await`, `MVVM`, `Clean Architecture`

## 프로젝트 구조

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/739fe66e-faf4-44f9-8d7e-7a31ffa0f771/Untitled.png)

MVVM과 Clean Architecture을 사용한 구조를 계획했기 때문에,  `DataLayer`, `DomainLayer`, `PresentaionLayer` 총 세개의 `Layer`로 나눴다. 각 레이어는 아키텍쳐의 규칙에 맞는 역할을 하는 파일들을 넣었고, 이외에도 각 화면에 필요한 의존성을 주입시킬 AppDIContainer와, 화면 전반에서 사용하게될 기능들이 있는 CommonUtils 폴더와, 공통 컴포넌트와 View에대한 Util을 가지고있는 UiUtils 폴더로 구성된 Utils 폴더가 추가적으로 존재한다.

## 네트워크

서버와 통신하는 로직은 별도의 네트워킹 라이브러리를 사용하지 않고 Swift Concurrency `Async/Await`을 사용하여 구현하였다. Utils - CommonUtils - NetworkUtil에 네트워크 관련 코드들을 구현하였는데, 같은 폴더에 작성한 NetworkError Enum에 따른 Network 통신시 발생하는 오류(decoding, bad request, server error)등을 예외처리하여 상황에 맞게 throw한다.

```swift
switch response.statusCode {
    case 200...299:
        guard let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else {
            throw NetworkError.decodingError
        }
        return decodedResponse
    case 400...499:
        throw NetworkError.badRequestError
    case 500...599 :
        throw NetworkError.serverError
    default:
        throw NetworkError.unknownError
}
```

정상적으로 동작할 경우 Decodable 프로토콜을 채택하는 제너릭타입에 따라 Response를 리턴해준다.

실제로 호출할 시 info.plist에 작성한 BASE_URL에 추가적인 URL 정보와 파라미터 유무, HTTP method 유형을 작성해 네트워크 호출을 시도한다.

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/3698c85b-94fa-4470-8cb8-763e8109caaa/Untitled.png)

## 화면 구조

화면구조는 하단 탭바가 총 세가지의 뷰를 가지고 있는 구조이다. 탭바의 상태를 관리하기 위해 ViewRouter를 생성하여 사용한다.

루트뷰(iOS_questApp) - MainView - BottomTabView - 3가지 탭 화면(MovieListView, SearchView, BookmarkView) 로 구성되어있다.

### Common

1. AsyncImageLoader : iOS15부터 사용 가능한 AsyncImage 기능을 사용하여 URL을 비동기로 받아와 화면에 뿌려주는 역할을 한다. 이 기능을 한번더 컴포넌트화 시켜 이미지의 가로, 세로, radius 값등을 옵셔널로 받아 각기 다른 이미지의 크기와 모양을 컴포넌트화 시켜 사용하였다.
2. RefreshableScrollView : 기존에 존재하는 refreshable modifier는 버그도 아직 존재하고, 기능적으로 한계가 있어 ScrollView의 offset을 계산하여 pull to refresh하는 RefreshableScrollView를 컴포넌트화 시켰다. 추가적인 기능으로 refresh 했을때 haptic이 동작하도록 구현했다.
3. NavigationBackButton : NavigationLink로 Detail 화면으로 이동했을때 navigationLeadingButton이 navigationTitle을 가리는 경우가 있어서 default NavigationBar를 Disable하고 toolbar를 이용하여 새로만들었다. NavigationBackButton은 화면을 뒤로가는 역할을 하는 커스텀 버튼이다.

### ViewModifier

1. loadingViewHandler : API 호출 중 화면에 호출 중이라는 상태를 알리기 위하여 ViewModifier, ViewExtension을 사용하여 loadingViewHandler를 구현하였다. View쪽에 loading상태를 표시하기위한 코드가 많아지면 가독성이 떨어질것을 우려하여 ViewModifier로 분리하였고, 사용하는 View쪽에서는 isLoading이라는 상태만 넘겨주면 된다.

```swift
content
	.loadingViewHandler(isLoading: viewModel.isLoading)
```

1. errorViewHandler : loadingViewHandler와 같은 맥락으로 API호출시 발생하는 Error에 대한 사용자에 대한 알림이다. error 값이 modifier에 전달될 경우 Error에 따른 message가 노출이 되고 재시도 버튼이 나타난다. 

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/82749818-b20f-4930-8295-134ea8c07dfb/Untitled.png)

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/8eaf8a8a-20bc-4fac-b42c-018c96908712/Untitled.png)

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/c11cee8d-46bc-4479-9b49-8d7dec63730a/Untitled.png)

```swift
content
	.errorViewHandler(error: viewModel.error) {
            viewModel.clearError()
            viewModel.getMovieList()
        }
```

error 값과, 재시도 버튼을 눌렀을때의 행동을 가진 델리게이트 클로저만 넘겨주면 된다.

### BottomTabView

하단에서 화면의 Routing을 하게될 TabView는 세가지 탭을 가지고 있다. 

선택된 탭은 아이콘 아래 빨간색 점이 나타나 현재 선택된 탭을 알리는 역할을 한다.

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/2e715098-4cb6-48d2-9d99-a8a8d81e5871/Untitled.png)

### MovieListView

MovieListView는 API호출을 통한 `MovieEntity`들로 이루어져있다. RefreshableScrollView안에 구현된 MovieListView는 기본적으로 `Pull to refresh`가 가능하다. MovieItem은 최적화와 Paging처리를 위해 LazyVStack안에 구현 되었다.

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/122b8fc7-471b-484f-8b34-e73e3341c786/Untitled.png)

### MovieItemView

MovieEntity를 파라미터로 갖는 MovieItemView는 다음의 컴포넌트들로 구성되어있다.

1. profileView : 프로필이미지, 제목이 포함되어 있다.
2. 메인 커버이미지 : 가로 너비를 꽉 채우고있는 이 커버이미지에 인스타그램 좋아요 애니메이션을 적용하여 **연속으로 2번 탭**할 경우 북마크에 추가된 상태가 아니라면 이미지 가운데에 하트가 1초간 나타났다 사라지며 북마크에 추가된다. 이기능도 ViewModifier를 사용하여 복잡한 코드를 노출시키지 않았고, 북마크 여부 파라미터와 애니메이션 동작을 위한 로컬변수를 바인딩하여 구현하였다. 

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/0580ca01-7981-436e-b90c-24f38ba9fdd6/Untitled.png)

북마크에 추가되어있지 않은 상태에서 연속으로 두번 탭하여 사용할 수 있다. 북마크를 제거할땐 적용되지 않게 하였다. 이유는 북마크 제거인데 하트 아이콘이 뜨는게 어색해서 비활성화 했다.

1. buttonArea : 좌측에는 북마크의 상태에 따라 북마크 추가, 제거를 할 수 있는 버튼이 있고, 우측에는 해당 영화의 DetailView로 이동하는 버튼이 있다.
2. genreView : 해당 영화가 어떤 장르인지 해시태그 처럼 구현했다.
3. descriptionView : 영화에 대한 설명이 나타나고, 기본적으로 linelimit을 1로 줘 1줄만 표시되고,  나머지 내용은 …으로 대체되지만 우측의 `more` 버튼을 눌러 나머지 내용을 확인할 수 있다.

각 View는 가독성을 위하여 함수로 분리하여 선언형UI의 장점을 최대화 하였다. 

간단한 View는 같은 struct 내부에 작성하였지만 과하게 복잡한 View는 따로 파일을 분리하는 방식으로 구현하였다.

가장 밖에 onAppear를 통해 만약 viewmodel이 가지고있는 리스트중 마지막 항목이라면 기존 페이지에 1을 더한 값을 호출하여 기존 리스트에 Append시키는 로직이 포함되어 있다.

### MovieDetailView

MovieItemView의 Detail Button을 통해 MovieDetailView로 이동할 수 있다.

Navigation 상단에는 해당 영화의 Full Name과 공통 컴포넌트 BackButton이 있다.

1. movieCoverWithBackgroundView : 해당 영화의 BackgroundImage와 영화 포스터를 포함하는 View이다. BackgroundImage는 약간의 blur처리를 했고, 포스터는 radius를 줘 둥근 모양을 띄게 하였다.
2. GenreView : GenreView는 여러군데에서 사용될 가능성이 있어, 공통 컴포넌트로 분리하였다.
3. detailInfoView : 상단부터 제목, 러닝 타임이 있고, rating이라는 값을 10점 만점으로 주는데 이 값을 반올림하여 그 값만큼 별 이미지를 넣어보았다. MovieDetailEntity 모델에서 rating 값을 반올림하여 별의 개수를 리턴해주는 로직을 작성하여 별이미지를 출력할 수 있었다. 이 외에도 다운로드, 좋아요 수 시놉시스와 같은 정보들이 포함되어 있다.

### SearchView

SearchView는 searchable modifier를 통해 TextField가 Navigation을 가리는 자연스런 UI를 사용하였다.

1. emptyView : 검색된 결과가 없거나, 키워드가 비어있다면 화면 중앙에 돋보기 모양 아이콘과 텍스트로 검색을 유도하는 UI를 구현했다.
2. searchedMovieListView : 검색된 결과가 있을 경우 나타나며 MovieInfoRow가 리스트의 형태로 나타나며 각 항목을 선택하면 MovieDetailView로 이동한다. 검색에 사용되는 keyword는 타이핑할때마다 검색 API를 호출하는 것을 방지하기 위해 `Debounce`를 1.5초로 두어 검색 후 1.5초후 최종 키워드에 대해서만 검색 API가 동작하게 구현했다. 

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/e2a66e9f-d2ba-4b64-bfd7-e1fd72f7f389/Untitled.png)

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/b82766f5-0ff9-4ae2-a101-13cd6b59a645/Untitled.png)

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/a0ebd418-f38b-4354-88c7-1ed7052f747e/Untitled.png)

### BookmarkView

북마크 기능은 API에서 지원을 했지만 유저정보와 같은 기능도 구현을 했기에 UserDefaults를 사용하여 구현했다. UserDefaults에 struct 타입의 정보를 저장하려면 `@propertyWrapper`를 사용하여 구현해야 했다.

Utils - CommonUtils - PropertyWrapper - UserDefaultsWrapper에서 구현하였다.

UserDefaults의 정보를 가지고 있는 UserDefaultsStorage는 DataLayer의 Repository 폴더 내부 Local폴더에 작성이 되어있고, 서버에서오는 데이터와 다르게 앱 내부에서 사용하는 개념이기 때문에  Repository에서 리턴하여 DTO → Entity로의 변환을 거치지 않고, Entity Type 자체를 저장하여 별도의 변환 절차없이 값을 리턴하는 구조를 가지고 있다.

UserDefaultsStorage에서 북마크 추가, 제거, 조회, 북마크여부 등의 로직을 가지고 있고, 사용하는 View에서 이것을 사용하게 된다.

1. emptyView : SearchView와 동일하게 조회한 북마크가 없다면 emptyView를 노출시킨다.
2. bookmarkListView : 조회한 북마크를 리스트 형태로 출력하고 가장 우측에는 북마크를 제거할 수 있는 하트 버튼이 있다. 하트 버튼을 눌러서 북마크 리스트에서 곧바로 제거할 수 있고, SearchView에서 사용하는 MovieInfoRow를 공통 컴포넌트로 분리하여 BookmarkView에서도 사용하게끔 구현하였다.

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/2c9972c0-9575-44a1-8b26-750f30171723/Untitled.png)

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/48a40961-eff6-48ec-82fe-58d0a7da6238/Untitled.png)
