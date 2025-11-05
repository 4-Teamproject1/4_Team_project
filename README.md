# 4_TEAM_PROJECT
[산업구조변화대응 특화훈련] 공공데이터를 활용한 웹앱개발자 양성 과정 중 진행한 팀 프로젝트 과제입니다.

## 👨‍🏫 프로젝트 소개
학회나 공모전에 참여하는 사람들을 위해 학회일정에 맞는 숙소와 교통편을 찾아서 추천해주고, 학회 및 공모전 일정을 제공하는 사이트를 제작해보았습니다.

## ⏲️ 개발 기간
- 2024.04.08(월) ~ 2024.05.13(월)
- 주제 선정
- 피그마 제작
- github 협업 세팅
- 역할분담
- 발표평가

## 🧑‍🤝‍🧑 개발자 소개
- **고의성** : 조장, 백엔드(아고다 및 숙소 크롤링/필터링), DB 설계, 발표
- **정다운** : 백엔드(기차 및 버스 크롤링, 관리자 설정, 문의사항, 학회/공모전 검색, DB 설계)
- **오지현** : 백엔드(학회 및 공모전 크롤링, 학회/공모전 필터링, 즐겨찾기, 조회수, 회원탈퇴, DB 설계)
- **김선경** : 프론트엔드(전체 총괄), 벡엔드(문의사항)
![개발자소개](https://github.com/4-Teamproject1/4_Team_project/assets/140681352/8ffed082-d94a-48bd-b528-6c4fa8164753)

## 💻 개발환경 및 사용기술
- **개발환경** : Windows10
- **개발도구** : MAVEN, Spring Tool Suit 4, SqlYog, selenium
- **개발언어 및 프레임워크** : HTTP, CSS, java(jdk1.7), javaScript, jQuery, Tailwind, daisyUI, SpringBoot
- **DB** : MySql
- **ORM** : MyBatis

## 📝 프로젝트 아키텍쳐

![](https://velog.velcdn.com/images/jihyeon2434/post/429e7dcb-5e58-4ee3-8d79-8f56f5010f94/image.png)
![](https://velog.velcdn.com/images/jihyeon2434/post/159ea9db-8c0f-40c3-bab5-cef00f105f28/image.png)

## 📌 주요 기능
[벡앤드]
- 학회/공모전 정보 등록
하이브레인넷에서 제공하는 학회/공모전 리스트(제목, 기간, 장소 등)를 크롤링으로 가져온다.  

- 숙소 정보 등록
선정한 주요 지역별 숙소 리스트를 아고다에서 크롤링 해서 가져온다.

- 실시간 버스편 정보 목록화 
크롤링하는 날짜 기준 한달 간의 실시간 버스 목록을 고속버스 예매 사이트에서 크롤링 해서 갖고온다. 

- 실시간 기차편 정보 목록화
크롤링 하는 날짜 기준 한달 간의 실시간 기차 목록을 네이버 길찾기 사이트에서 크롤링 해서 가져온다.

- 학회/공모전 즐겨찾기 및 내일정 추가
내가 즐겨찾기 한 학회나 공모전이 행사일정에 맞게 내 달력에 추가된다. 

- 내 문의글 작성 및 목록화
로그인 한 회원이 마이페이지에서 내 문의글 작성 시, 작성한 회원이 작성한 글이 리스트화 된다. 
삭제는 관리자만이 할 수 있게 설계했다. 


- 숙소 정보 추천
방법1. 메인페이지 서치박스에서 선택한 학회에 맞춰, 1차적으로 학회 DB에서 선택 학회의 날짜, 지역이 세팅된다. 검색 버튼을 누르면 도착 지역 맞춤 숙소 데이터 리스트가 추천숙소 페이지에 보여진다. 
방법2. 추천숙소 페이지 서치박스에서 출발/도착지를 선택하면, 도착 지역 맞춤 숙소 데이터 리스트가 추천 숙소 페이지에 보여진다. 


- 버스 정보 추천
출발역을 입력하면, 출발역에서 갈 수 있는 도착역이 세팅되고, 도착역 중 하나를 선택하고, 날짜를 선택하면, 선택한 도착역/날짜 기준으로 버스예매사이트에서 실시간으로 크롤링한 데이터가 리스트 형식으로 보여준다. 

[프론트]
- 메인페이지 목록 슬라이드 
메인페이지 서치박스의 검색창을 클릭했을 때, 저장한 리스트가 나오도록 만들었다. 

- 마이페이지 달력
오늘날짜 기준으로 해당 월이 나오도록 세팅이 된 달력을 마이페이지 내일정에 보여준다. 
예시로 저장해둔 학회/공모전 데이터 날짜에 맞게 달력에 세팅된다. 



## ✒️ 크롤링
크롤링 사이트 
- [하이브레인넷](https://www.hibrain.net/?gad_source=1&gclid=CjwKCAjw9IayBhBJEiwAVuc3fhQsHRNTHgdATnqSQoFxhqCJed0N41lGFhDH4sJ7SF2MqHnpirnDOhoC-t0QAvD_BwE)
- [네이버 길찾기](https://map.naver.com/p/directions/-/-/-/car?c=15.00,0,0,0,dh)
- [고속버스 통합예매](https://www.kobus.co.kr/main.do)
- [아고다](https://www.agoda.com/ko-kr/?site_id=1922887&tag=eeeb2a37-a3e0-4932-8325-55d6a8ba95a4&gad_source=1&gad_campaignid=21035050206&gbraid=0AAAAAD-GdVmlr5QcnpuU_CRvkGH8SJqI_&device=c&network=g&adid=734266400825&rand=7972794221814467279&aud=kwd-304551434341&gclid=Cj0KCQiA5abIBhCaARIsAM3-zFUiPVOHb-m_di9kze4IeuwCgwHQxpRnfsD1pxNWjOEHdhwvy2lKrNEaAjgXEALw_wcB&pslc=1&ds=tD%2FgbZM8KXG4EAHA)

## 📘 가이드북
https://docs.google.com/document/d/1bRU-8DwDhtbp_6cgmxjIbRylNQPqAjn0UMryIpBVOyY/edit?usp=sharing

## 📕개발기술서
https://docs.google.com/document/d/1qHpVj7aLqlEoNKrpqa3zXmq6pdo3Tg0sWLbLQB9IV6E/edit
