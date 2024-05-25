<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="ko">
<head>
	<title>COOR - HELP</title>
    <%@ include file="/WEB-INF/views/include/common.jsp" %>
	<link rel="stylesheet" href="/resources/css/main.css">
</head>
<body>
	<div class="wrapper">

		<!--header-->
		<%@ include file="/WEB-INF/views/include/header.jsp" %>
		<!--header end-->

		<section>
			<div class="help">
				<div class="help-tab">
					<ul>
						<li class="tab-item active"><a href="#tab1">문의하기</a></li>
						<li class="tab-item"><a href="#tab2">이용안내</a></li> 
						<li class="tab-item"><a href="#tab3">교환/환불 안내 </a></li>
						<li class="tab-item"><a href="#tab4">멤버십 혜택 안내</a></li>
						<li class="tab-item"><a href="#tab5">A/S 서비스 </a></li>
					</ul>
				</div>
				<div class="help-content-wrap">
					<!-- 문의하기 -->
					<div id="tab1" class="help-content active">
						<div class="help-wrap">
							<h3 class="tit">일반문의</h3>
							<div class="cont">
								<div class="info">
									<p>상품 Q&amp;A 및 주문,결제 관련하여 문의 사항이 있으시거나 도움이 필요하신 경우 <br class="noMO">
										아래 문의하기를 통해 남겨주시면 영업일 기준 1-2일 내 답변드립니다.
									</p>
								</div>								
								<c:if test="${sessionScope.loginStatus == null}">
									<a href="/member/login" class="btn-black">문의하기</a>	
								</c:if>
								
								<c:if test="${sessionScope.loginStatus != null}">
									<a href="/help/contact" class="btn-black">문의하기</a>	
								</c:if>
							</div>
						</div>
						<div class="help-wrap">
							<h3 class="tit">A/S 문의</h3>
							<div class="cont">
								<div class="info">
									<p>상품의 AS가 필요하신 경우 상단의  A/S 서비스에서 규정 및 접수 방법을 참고하시어<br class="noMO">
										아래 문의하기를 통해 남겨주시면 영업일 기준 1-2일 내 답변드립니다.
									</p>
								</div>
								<a href="/help/contact" class="btn-black">문의하기</a>	
							</div>
						</div> 
						<div class="help-wrap">
							<h3 class="tit">마케팅 문의</h3>
							<div class="cont">
								<div class="info">
									<p>마케팅과 관련하여 궁금한 점이 있으실 경우 아래 이메일로 연락 주시기 바랍니다. <br>
										문의 내용과 연락처를 남겨 주시면 관련부서에서 확인 후 필요시 개별적으로 연락 드리겠습니다.
									</p>
								</div>
								<a href="/help/contact" class="btn-black">문의하기</a>	
							</div>
						</div>
						
						<div class="service-info">
							<div class="service-wrap">
								<h3 class="tit">대표번호: 1644-3028</h3>
								<p class="tit-sub">*근로자 보호 및 서비스 품질 향상을 위해 모든 통화 내용이 녹음됩니다.</p>
							</div>
							<div class="service-wrap">
								<h3 class="tit">온라인 고객 서비스 운영시간</h3>
								<ul class="tit-sub"><li>운영시간 : AM 11:00 - PM 17:00 (주말 및 공휴일 휴무)</li>
									<li>점심시간 : PM 12:00 - PM 13:00 </li>
								</ul></div>
						</div>
					</div>
					<!-- 문의하기 -->
					
					<!-- 이용안내 -->
					<div id="tab2" class="help-content">
						<div class="help-wrap">
							<h3 class="tit">결제안내</h3>
							<div class="cont">
								<div class="info">
									<p>카드 결제, 무통장 입금의 경우 입금 / 결제 확인 후 상품이 배송됩니다 <br>
										무통장 입금 시 주문자명과 입금자명이 다를 경우 배송이 지연될 수 있어 고객센터로 연락 부탁드리겠습니다.<br>
										무통장 입금의 경우 1일 이내 미입금 시 자동으로 취소 처리 됩니다.<br>
										무통장 미입금 후 대량 구매 시에 시스템 상 자동으로 취소 처리 됩니다.
									</p>
									<p>입금 계좌 : 신한은행 140-013-626881 (주) 커먼오리진스</p>
								</div>
							
							</div>
						</div>
						<div class="help-wrap">
							<h3 class="tit">배송안내</h3>
							<div class="cont">
								<div class="info">
									<p>배송 방법 : 롯데택배<br>
										배송 지역 : 전국 (제주, 도서/산간 지역 별도) <br>
										배송 비용 : 50000원 미만 3000원, 이상 무료 배송 <br>
										배송 기간 : 1시 이전 구매 시 당일 출고 후 1~3일 소요 (공휴일 제외)
									</p>
								</div>
								
							</div>
						</div>
						
						<div class="service-info">
							<div class="service-wrap">
								<h3 class="tit">대표번호: 1644-3028</h3>
								<p class="tit-sub">*근로자 보호 및 서비스 품질 향상을 위해 모든 통화 내용이 녹음됩니다.</p>
							</div>
							<div class="service-wrap">
								<h3 class="tit">온라인 고객 서비스 운영시간</h3>
								<ul class="tit-sub"><li>운영시간 : AM 11:00 - PM 17:00 (주말 및 공휴일 휴무)</li>
									<li>점심시간 : PM 12:00 - PM 13:00 </li>
								</ul></div>
						</div>
					</div>
					<!-- 이용안내 -->
					<!-- 교환환불 -->
					<div id="tab3" class="help-content">
						<div class="help-wrap">
							<h3 class="tit">배송 전 상품 교환 및 주문 취소</h3>
							<div class="cont">
								<div class="info">
									<p>상품 주문 후 교환 및 취소 원하시는 경우 "상품 준비" 상태에서만 가능하십니다.<br>
										"배송 준비 중", "배송 중" 상태에서는 상품 교환 및 취소가 어려운 점 양해 부탁드리겠습니다. 
									</p>
									<p>
										[교환 및 주문 취소 방법]<br>
										mypage - 주문 조회 - 교환 / 주문 취소에서 직접 취소 진행
									</p>
									<p>
										[미입금 건 주문 취소 방법]<br>
										mypage - 주문 조회 - 교환 / 주문 취소에서 직접 취소 진행
									</p>
								</div>
							</div>
						</div>
						<div class="help-wrap">
							<h3 class="tit">배송 완료 후 상품 교환 및 반품</h3>
							<div class="cont">
								<div class="info">
									<p>[교환접수]<br>
									mypage - 교환신청 - 교환 사유 선택 및 사유 기재 (교환 원하시는 사이즈 필수) 후 교환 신청
									</p>
									<p>
									[반품접수]<br>
									mypage - 반품신청 - 반품 사유 선택 및 사유 기재, 환불 계좌 등록 후 반품 신청
									</p>
									<p>
									[불량 및 오배송 접수]<br>
									동일한 방법으로 접수 부탁드리며 물류센터에 상품 입고 시 실물 검수하여 불량으로 확인될 경우 무상으로 교환/환불 도와드리고 있습니다.
									</p>
									<p>
										[상품 발송]<br>
										롯데택배 1588-2121 → ARS 자동 반품 접수 1번 → 운송장 번호 12자리 입력하여 회수 접수<br>
										타 택배사 이용 시 추가 비용이 청구되는 점 참고 부탁드리겠습니다.
									</p>
								</div>
							</div>
						</div>
						<div class="help-wrap">
							<h3 class="tit">교환 및 반품 배송비 안내</h3>
							<div class="cont">
								<div class="info">
									<p>교환 및 반품의 경우 제품 수령일로부터 7일 이내로 가능하십니다.
									</p>
								</div>
							</div>
						</div>
						<div class="help-wrap">
							<h3 class="tit">교환 및 반품 불가한 경우</h3>
							<div class="cont">
								<div class="info">
									<p>7일 이내로 상품이 당사로 도착하지 않을 경우<br>
									상품 택 제거, 분실 및 라벨 훼손 하였을 경우<br>
									착용 흔적, 오염, 냄새, 원단 손상으로 인해 판매가 어려운 경우<br>
									라벨에 기재되어 있는 세탁법 이용하지 않아 상품이 훼손된 경우<br>
									위의 해당될 경우 배송비 부담과 고객님께 재발송 처리되오니 양해 부탁드리겠습니다.
									</p>
								</div>
							</div>
						</div>
						<div class="help-wrap">
							<h3 class="tit">반품지 주소</h3>
							<div class="cont">
								<div class="info">
									<p>경기 광주시 도척면 마도로 244-42 (유정리) 쿠어 물류센터.
									</p>
								</div>
							</div>
						</div>
					</div>
					<!-- 교환환불 -->
					<!-- 멤버십혜택안내 -->
					<div id="tab4" class="help-content">
						<div class="help-wrap">
							<h3 class="tit">멤버십 혜택</h3>
							<div class="cont">
								<div class="info">
									<p>BRONZE (~ 500,000 적립금) : 구매금액 3% 적립 <br>
										기본 배송비 적용 (50,000 이상 주문 시 무료배송)  
									</p>
									<p>
										SILVER (5,00,001 ~ 1,000,001 적립금) : 구매금액 4% 적립 / 3% 상시 할인<br>
										기본 배송비 무료  
									</p>
									<p>
										GOLD (1,000,001 ~ 1,500,000 적립금) : 구매금액 5% 적립 / 5% 상시 할인<br>
										기본 배송비 무료  
									</p>
									<p>
										DIA (1,500,001 ~ ) : 구매금액 6% 적립 / 10% 상시 할인<br>
										배송비 포함 / 교환, 환불 무료
									</p>
								</div>
							</div>
						</div>
						<div class="help-wrap">
							<div class="cont">
								<div class="info">
									<p>신규 회원 가입 시 3,000원 적립금<br>
									생일 10% 할인 쿠폰 (생일 당일 지급, 쿠폰발행일 포함 7일 이내 사용)<br>
									결제완료 기준으로 등급 반영
									</p>
									
								</div>
							</div>
						</div>
						
						<div class="service-info">
							<div class="service-wrap">
								<h3 class="tit">대표번호: 1644-3028</h3>
								<p class="tit-sub">*근로자 보호 및 서비스 품질 향상을 위해 모든 통화 내용이 녹음됩니다.</p>
							</div>
							<div class="service-wrap">
								<h3 class="tit">온라인 고객 서비스 운영시간</h3>
								<ul class="tit-sub"><li>운영시간 : AM 11:00 - PM 17:00 (주말 및 공휴일 휴무)</li>
									<li>점심시간 : PM 12:00 - PM 13:00 </li>
								</ul></div>
						</div> 
					</div>
					<!-- 멤버십혜택안내 -->
					<!-- AS서비스 -->
					<div id="tab5" class="help-content">
						<div class="help-wrap">
							<h3 class="tit">A/S 서비스</h3>
							<div class="cont">
								<div class="info">
									<h3>COOR의 품질보증기간은 구입일로부터 1년 입니다.</h3>
									<p>구매일로부터 30일 이내 분은 무상 AS 서비스를 진행합니다. (교환 , 환불 , A/S) <br>
									AS 처리 기간은 본사 입고일 기준 2주 - 최대 4주 까지 소요될 수 있습니다.<br>(주말 및 공휴일이 제외된 기간)<br>
									AS중 기간 변동 및 예외사항 발생 시 고객님께 유선 안내를 드립니다.<br>
									사용자의 고의 또는 취급 및 보관상의 부주의로 인한 변형 및 품질 보증 기간 (1년) 이 지난 제품의 품질 이상에 대해서는 보상의 책임을 지지 않습니다.<br>
									내부 판정 시 제품 자체의 문제로 보기 어려운 경우 외부 기관의 심의에 따라 결과 확인 후 처리가 진행됩니다.
									</p>
								</div>
								
							</div>
						</div>
						<div class="help-wrap">
							<h3 class="tit">A/S 접수 안내</h3>
							<div class="cont">
								<div class="info">
									<p>CS 이메일 (cs@coor.kr) 또는 고객센터 (1644-3028)를 통해<br>불편하신 사항에 대하여 설명 및 사진 첨부하여 전달 부탁드립니다.<br></p>
								</div>
							</div>
						</div>
						<div class="help-wrap">
							<h3 class="tit"> CS 이메일을 통한 AS 접수 시 필수 기재 사항</h3>
							<div class="cont">
								<div class="info">
									<p>1. 주문 정보 (주문자 성함 / 연락처 / 구매처)<br>
									2. 주문 상품 / 사이즈 <br>
									3. 수선 시 요청사항 (사진첨부)<br>
									4.수선품 수령 주소 <br>
									위와 같은 내용으로 기재 후 전달 부탁드리며 영업일 기준 1-2일 내<br>
									AS 가능 여부 확인 후 안내드리고 있습니다.
									</p>
								</div>
							</div>
						</div>
						
						<div class="service-info">
							<div class="service-wrap">
								<h3 class="tit">대표번호: 1644-3028</h3>
								<p class="tit-sub">*근로자 보호 및 서비스 품질 향상을 위해 모든 통화 내용이 녹음됩니다.</p>
							</div>
							<div class="service-wrap">
								<h3 class="tit">온라인 고객 서비스 운영시간</h3>
								<ul class="tit-sub"><li>운영시간 : AM 11:00 - PM 17:00 (주말 및 공휴일 휴무)</li>
									<li>점심시간 : PM 12:00 - PM 13:00 </li>
								</ul></div>
						</div>
					</div>
					<!-- AS서비스 -->
					
				</div>
				
				<script>

				let help_tab = document.querySelectorAll(".tab-item");
				let help_content = document.querySelectorAll(".help-content");

				help_tab.forEach((item, index) => {
					item.addEventListener("click", (e) => {
					e.preventDefault();

					help_tab.forEach((content) => {
						content.classList.remove("active");
					});

					help_content.forEach((content) => {
						content.classList.remove("active");
					});
					
					help_tab[index].classList.add("active");
					help_content[index].classList.add("active");

					});
					
				});
					
				</script>
			</div>
		</section>	
		
		<!--footer start-->
		<%@ include file="/WEB-INF/views/include/footer.jsp" %>
		<!--footer end-->
	</div>

</body>
</html>
