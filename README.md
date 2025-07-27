# 🍎 Apple Market
바로인턴 15기 과제 전형입니다.

<br>

## 📌 개요

- **과제 목표**: 당근마켓 스타일의 중고거래 앱 UI/UX를 Flutter로 구현
- **주요 기능**
  - 상품 목록 및 상세 페이지 구현
  - 스크롤 최상단 이동 버튼
  - 상품 삭제 기능
  - 좋아요 처리 기능

<br>

## 📷 구현 기능

| 메인 화면 | 상세 페이지 |
|-----------|-------------|
| <img width="400" height="900" alt="Screenshot_1753659969" src="https://github.com/user-attachments/assets/1d94b15b-a5cb-41ca-8ea1-f366c929e1a3" /> | <img width="400" height="900" alt="Screenshot_1753659985" src="https://github.com/user-attachments/assets/f412d138-5322-440f-883c-6d8c3bd9aaff" /> |

<br>

## 📁 프로젝트 구조
```
lib/
├── data/
│ └── models/
│
├── presentation/
│ ├── product_detail/
│ │ ├── product_detail_page.dart
│ │ ├── product_detail_view_model.dart
│ │ └── widgets/
│ │
│ └── product_list/
│ ├── product_list_page.dart
│ ├── product_list_view_model.dart
│ └── widgets/
│
├── provider/
│ └── products_provider.dart
│
├── util/
│ ├── format_description.dart
│ ├── format_price.dart
│ └── load_products.dart
│
└── main.dart
```


