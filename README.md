# Rate Star
- 별점 라이브러리.

![Screen shot](https://github.com/orosys/Rate-star/blob/master/screen/GIF_20171222_134515.gif?raw=true)


**Link**
Android : https://github.com/orosys/Rate-star


**API**
>'RateStar'의 주요 API

```java
// Image 설정
rateStar = [[RateStar alloc] initWithStarImage:imageView repeat:5 space:10];
// 별점 값 설정
[rateStar setRateStar:2.5];
// 별점 값 가져오기
float rate = [rateStar getRateStar];
// 별점 반개 값 허용
[rateStar setEnableHalf:YES];
// 별 이미지 사이 공간
[rateStar setSpace:100];
// 별의 갯수 설정
[rateStar setRateCount:5];
// 비활성화 된 별의 투명도
[rateStar setBgAlpha:0.3];
```
