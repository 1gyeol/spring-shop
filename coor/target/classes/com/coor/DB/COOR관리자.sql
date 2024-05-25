CREATE USER cooradmin identified by 1234;

GRANT CONNECT, RESOURCE TO cooradmin;

--1.회원 테이블
DROP TABLE MEMBER_TBL;
CREATE TABLE MEMBER_TBL(
MB_ID               VARCHAR2(12) CONSTRAINT PK_MB_ID PRIMARY KEY,
MB_PW               CHAR(60)               NOT NULL, 
MB_NAME             VARCHAR2(20)           NOT NULL, 
MB_PHONE            VARCHAR2(11)           NOT NULL,
MB_ZIPCODE          CHAR(5)                NULL,
MB_ADDR             VARCHAR2(100)          NULL,
MB_DEADDR           VARCHAR2(100)          NULL,
MB_EMAIL            VARCHAR2(50)           NOT NULL, 
MB_BIRTH            CHAR(8)                NOT NULL, 
MB_REGDATE          DATE DEFAULT SYSDATE   NOT NULL,
MB_UPDATEDATE       DATE DEFAULT SYSDATE   NOT NULL,
MB_LASTDATE         DATE DEFAULT SYSDATE   NOT NULL
);

DROP TABLE MEMBER_DEL_LIST;

create TABLE MEMBER_DEL_LIST
as
select * from MEMBER_TBL
where 1 = 0;
ALTER TABLE MEMBER_DEL_LIST ADD MB_DELETEDATE DATE;
 
--trigger를 만들어줍니다. 
--delete후에 실행되게 만들었습니다.
--주의할점은 그냥 명령문 실행(CTRL+ENTER)할 경우 OLD 를 변수?로 인식해 오류가 납니다.
--따라서, 스크립트 실행(F5)로 트리거를 생성합니다.
DROP TRIGGER TR_MEMBER_DEL;
create or replace trigger TR_MEMBER_DEL 
    after delete
    on MEMBER_TBL
    for each row
begin
    DBMS_OUTPUT.PUT_LINE('Trigger 작동, 백업완료');
    insert into MEMBER_DEL_LIST values(:OLD.MB_ID, :OLD.MB_PW, :OLD.MB_NAME,:OLD.MB_PHONE,:OLD.MB_EMAIL,:OLD.MB_BIRTH,:OLD.MB_REGDATE,:OLD.MB_UPDATEDATE,:OLD.MB_LASTDATE,:OLD.MB_ZIPCODE,:OLD.MB_ADDR,:OLD.MB_DEADDR, SYSDATE);
end
;

INSERT INTO MEMBER_TBL(MB_ID, MB_PW, MB_NAME, MB_PHONE, MB_EMAIL, MB_BIRTH)
VALUES('test123','$2a$10$dQFCMr0udCI865eG6SoIcOaNr3Y/dgBX.R4qf6rX5KA3jciSnnNjG','테스트','01012341234','kwin722@naver.com','930722');
INSERT INTO MEMBER_TBL(MB_ID, MB_PW, MB_NAME, MB_PHONE, MB_EMAIL, MB_BIRTH)
VALUES('test1233','$2a$10$dQFCMr0udCI865eG6SoIcOaNr3Y/dgBX.R4qf6rX5KA3jciSnnNjG','테스트','01012341234','kwin722@naver.com','930722');

DELETE FROM MEMBER_TBL WHERE MB_ID = 'test1233';

COMMIT;

-- 2.카테고리 테이블
DROP TABLE CATEGORY_TBL;
CREATE TABLE CATEGORY_TBL(
        CAT_CODE            NUMBER    CONSTRAINT PK_CATEGORY PRIMARY KEY,   
        CAT_PRTCODE         NUMBER    NULL,           
        CAT_NAME            VARCHAR2(50)    NOT NULL,
        FOREIGN KEY(CAT_PRTCODE) REFERENCES CATEGORY_TBL(CAT_CODE)
);

--카테고리 생성
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (1,NULL,'MEN');
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (2,NULL,'WOMEN');

-- cat_code 2   
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (3,1,'OUTWEARS');        
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (4,1,'KNITWEAR');    
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (5,1,'TOPS');    
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (6,1,'TROUSERS');    
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (7,1,'JEANS');
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (8,1,'BAGS');
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (9,1,'SHOES');
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (10,1,'ACCESSORIES');   
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (11,2,'OUTWEARS');        
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (12,2,'KNITWEAR');    
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (13,2,'TOPS');    
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (14,2,'TROUSERS');    
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (15,2,'JEANS');
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (16,2,'BAGS');
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (17,2,'SHOES');
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (18,2,'ACCESSORIES');
    
COMMIT;

SELECT * FROM CATEGORY_TBL;
SELECT * FROM CATEGORY_TBL WHERE CAT_PRTCODE = 1;
SELECT
    cat_code, cat_prtcode, cat_name
FROM
    CATEGORY_TBL
WHERE
    NOT cat_prtcode IS null;
    
SELECT cat_name  FROM CATEGORY_TBL WHERE cat_prtcode is null;

-- 3.COLLECTION_TBL
DROP TABLE COLLECTION_TBL;
CREATE TABLE COLLECTION_TBL(
    COL_NUM NUMBER                   CONSTRAINT PK_COLLECTION_NUM PRIMARY KEY,
    COL_NAME VARCHAR2(30)            NOT NULL,
    COL_CONTENT  CLOB                               NOT NULL,
    COL_SHOW     CHAR(1)        DEFAULT 'Y'         NOT NULL,
    COL_REGDATE     DATE        DEFAULT SYSDATE     NOT NULL,
    COL_UPDATEDATE  DATE        DEFAULT SYSDATE     NOT NULL
);

DROP SEQUENECE SEQ_COLLECTION_NUM;
CREATE SEQUENCE SEQ_COLLECTION_NUM;


SELECT
    col_num, col_name
FROM
    COLLECTION_TBL;
            
-- 4. PRODUCT_TBL   -
DROP TABLE PRODUCT_TBL;
CREATE TABLE PRODUCT_TBL(
    PRO_NUM         NUMBER      CONSTRAINT PK_PRO_NUM   PRIMARY KEY,
    CAT_CODE        NUMBER              NULL,
    PRO_NAME        VARCHAR2(50)        NOT NULL,
    PRO_PRICE       NUMBER              NOT NULL,
    PRO_DISCOUNT    NUMBER              NOT NULL,
    PRO_CONTENT     VARCHAR2(4000)      NOT NULL,
    PRO_IMG_CONTENT CLOB                NULL,
    PRO_UP_FOLDER   VARCHAR2(50)        NOT NULL,
    PRO_UP_IMG      VARCHAR2(100)       NOT NULL,
    PRO_AMOUNT      NUMBER              NOT NULL,
    PRO_BUY         CHAR(1)         DEFAULT 'Y'    NOT NULL,
    PRO_SHOW        CHAR(1)         DEFAULT 'Y'    NOT NULL,
    PRO_DATE        DATE       DEFAULT SYSDATE     NOT NULL,
    PRO_UPDATEDATE DATE        DEFAULT SYSDATE     NOT NULL,
    FOREIGN KEY(CAT_CODE) REFERENCES CATEGORY_TBL(CAT_CODE)
);

DROP SEQUENECE SEQ_PRO_NUM;
CREATE SEQUENCE SEQ_PRO_NUM;

-- 상품등록 작업
-- 카테고리 MEN(코드: 1), OUTWEARS(코드:4)
INSERT INTO product_tbl (pro_num, cat_code, pro_name, pro_price, pro_discount, pro_content, pro_up_folder, pro_up_img, pro_amount) 
VALUES (1,4,'테스트1',10000,0.1,'상품 테스트','\2023\04\06\','abc.gif',10);

SELECT * FROM PRODUCT_TBL WHERE PRO_NUM = 1;

SELECT /*+INDEX_DESC(PRODUCT_TBL PK_PRO_NUM) */
   ROWNUM RN, pro_num, cat_code, pro_name, pro_price, pro_discount, pro_content, pro_up_folder, pro_up_img, pro_amount, pro_buy, pro_show, pro_date, pro_updatedate
FROM
    PRODUCT_TBL ;
    
    
    
SELECT 
RN, p.pro_num, p.cat_code, c.cat_prtcode, c.cat_name, p.pro_name, p.pro_price, p.pro_discount, p.pro_content, p.pro_up_folder, p.pro_up_img, p.pro_amount, p.pro_buy, p.pro_show, p.pro_date, p.pro_updatedate
FROM 
( 
SELECT /*+INDEX_DESC (PRODUCT_TBL PK_PRO_NUM)*/
    ROWNUM RN, pro_num, cat_code, pro_name, pro_price, pro_discount, pro_content, pro_up_folder, pro_up_img, pro_amount, pro_buy, pro_show, pro_date, pro_updatedate
FROM 
    PRODUCT_TBL  
WHERE
    pro_show = 'Y'
AND
    cat_code = 3
AND		
    ROWNUM <= (1 * 10) 
    
) p INNER JOIN CATEGORY_TBL c
ON
    p.cat_code = c.cat_code;
    
 
-- 장바구니 테이블
DROP TABLE CART_TBL;
CREATE TABLE CART_TBL(
    CART_CODE       NUMBER              CONSTRAINT PK_CART_CODE PRIMARY KEY,
    PRO_NUM         NUMBER              NOT NULL,
    MB_ID           VARCHAR2(20)        NOT NULL,
    CART_AMOUNT     NUMBER              NOT NULL,
    FOREIGN KEY(PRO_NUM) REFERENCES PRODUCT_TBL(PRO_NUM),
    FOREIGN KEY(MB_ID) REFERENCES MEMBER_TBL(MB_ID)
);

DROP SEQUENCE SEQ_CART_CODE;
CREATE SEQUENCE SEQ_CART_CODE;

SELECT 
    rownum num, c.cart_code, p.pro_discount, p.pro_up_folder, p.pro_up_img, p.pro_num, p.pro_name, p.pro_price, c.cart_amount , 
    CASE 
    WHEN p.pro_discount > 0 THEN ((p.pro_price * ((100 - p.pro_discount) / 100)) * c.cart_amount)
    ELSE p.pro_price * c.cart_amount
    END as unitprice
FROM 
    PRODUCT_TBL p INNER JOIN CART_TBL c
ON 
    p.pro_num = c.pro_num
WHERE 
    c.mb_id = 'kwin722';
    
    
SELECT 
    CASE
    WHEN p.pro_discount > 0 THEN (SUM((p.pro_price * ((100 - p.pro_discount) / 100)) * c.cart_amount))
    ELSE (SUM(p.pro_price * c.cart_amount))
    END as cart_tot_price
FROM 
    PRODUCT_TBL p INNER JOIN CART_TBL c
ON 
    p.pro_num = c.pro_num
WHERE 
    c.mb_id = 'kwin722';
   
drop table pro_test; 
create table pro_test(
    pro_num number not null,
    pro_discount number not null,
    pro_price number not null,
    pro_dis_price number null
);
drop sequence seq_pro_test;
create sequence seq_pro_test;


insert into pro_test
values(seq_pro_test.nextval, 10, 1000, case when pro_discount = 0 then #{pro_price} else  (#{pro_price} * (100 - #{pro_discount}) / 100) end);







SELECT 1000 * ((100 - 10) / 100)  AS dis_price FROM DUAL;
select CASE WHEN (p.pro_discount

select pro_num, cart_amount
from cart_tbl
where mb_id = 'test123';

-- 상품상세페이지에서 장바구니 담기 - MERGE 구문사용.
/*
주의? 장바구니에 동일한 상품이 존재하면, 수량이 변경(업데이트)작업 : UPDATE
                            존재하지 않으면, 상품을 장바구니에 추가 : INSERT
*/

MERGE INTO CART_TBL C
USING DUAL ON (C.MB_ID = ?) AND (C.PRO_NUM = ?)
WHEN MATCHED THEN
    UPDATE
        SET C.CAT_AMOUNT = C.CAT_AMOUNT + ?
WHERE NOT MATCHED THEN
    INSERT (C.CAT_CODE, C.PRO_NUM, C.MB_ID, C.CAT_AMOUNT)
    VALUES( ?,?,?,?);
    
-- 장바구니에 동일상품이 존재하는 지 여부만 확인    
SELECT COUNT(*) FROM CART_TBL WHERE (C.MB_ID = ?) AND (C.PRO_NUM = ?);
SELECT C.CAT_CODE FROM CART_TBL WHERE (C.MB_ID = ?) AND (C.PRO_NUM = ?);

INSERT INTO cart_tbl (cat_code,pro_num,mb_id,cat_amount) VALUES (1,1,'user01', 2 );
INSERT INTO cart_tbl (cat_code,pro_num,mb_id,cat_amount) VALUES (2,5,'user01', 3 );
INSERT INTO cart_tbl (cat_code,pro_num,mb_id,cat_amount) VALUES (3,7,'user01', 5 );
INSERT INTO cart_tbl (cat_code,pro_num,mb_id,cat_amount) VALUES (4,12,'user02', 1 );
INSERT INTO cart_tbl (cat_code,pro_num,mb_id,cat_amount) VALUES (5,30,'user02', 2 );

SELECT * FROM cart_tbl;
COMMIT;

/*
주문하기
 1) 장바구니 사용하고 장바구니에서 구매
 2) 장바구니 사용 안하고 바로구매
*/
-- 장바구니 리스트 조회
SELECT ROWNUM, p.pro_img, p.pro_name, p.pro_price, c.cart_amount, p.pro_price * c.cart_amount as unitprice 
FROM PRODUCT_TBL p INNER JOIN cart_tbl c
ON p.pro_num = c.pro_num
WHERE c.MB_ID = 'test123';

-- 장바구니에서 수량변경
-- 수량을 직접변경
UPDATE cart_tbl
    SET CART_AMOUNT = 10
WHERE CAT_CODE = 1;


-- 결제하기 : 트랜잭션처리.
/*
주문테이블 : 주문자, 배송지(수령인) 등 
주문상세테이블 : 단위 상품정보
장바구니테이블 : 로그인 사용자의 상품정보 삭제
회원테이블 포인트 적립.
*/
DROP TABLE ORDER_TBL;
--5.주문내용 테이블
CREATE TABLE ORDER_TBL(
        ORD_CODE            NUMBER                  CONSTRAINT PK_ORDER_TBL PRIMARY KEY,
        MB_ID               VARCHAR2(15)            NOT NULL,
        PRO_NUM             NUMBER                  NOT NULL,
        ORD_NAME            VARCHAR2(30)            NOT NULL,
        ORD_ZIPCODE         CHAR(5)                 NOT NULL,
        ORD_ADDR            VARCHAR2(50)            NOT NULL,
        ORD_DEADDR          VARCHAR2(50)            NOT NULL,
        ORD_TEL             VARCHAR2(20)            NOT NULL,
        ORD_PRICE           NUMBER                  NOT NULL,  -- 총주문금액. 선택
        ORD_CANCEL          CHAR(1) DEFAULT 'N'     NOT NULL,
        ORD_REGDATE         DATE DEFAULT SYSDATE    NOT NULL,
        ORD_CANCELDATE      DATE DEFAULT SYSDATE    NOT NULL,
        FOREIGN KEY(MB_ID) REFERENCES MEMBER_TBL(MB_ID),
        FOREIGN KEY(PRO_NUM) REFERENCES PRODUCT_TBL(PRO_NUM)
);
DROP SEQUENCE SEQ_ORDER_TBL;
CREATE SEQUENCE SEQ_ORDER_TBL;


SELECT 
    COUNT(*) 
FROM 
    ORDER_TBL
WHERE 
    mb_id = 'test123';
AND
    pro_num > 0;


SELECT
    ord_code, mb_id, ord_name, ord_price, pay_method, ord_regdate
FROM
    ORDER_TBL
WHERE
    mb_id = 'test123';
    
SELECT
    SUM(ord_price) as totalPrice, COUNT(*) as totalCount
FROM
    ORDER_TBL
WHERE
    mb_id = 'test123';
    
-- 상세주문 조회
SELECT /*+INDEX_DESC (o PK_ORDER_TBL)*/
	RN, o.ord_code, o.mb_id, o.ord_name, o.ord_price, o.pay_method, od.ordt_amount, o.ord_cancel, o.ord_canceldate, o.ord_regdate, p.pro_num, p.pro_up_folder, p.pro_up_img
FROM
    (
    SELECT
        ROWNUM RN, ord_code, mb_id, ord_name, ord_zipcode, ord_addr, ord_deaddr, ord_tel, ord_price, ord_cancel, ord_canceldate, ord_regdate, pay_method, pro_num
    FROM
        ORDER_TBL
    WHERE
        mb_id = 'test123'
    )
    o INNER JOIN ORDETAIL_TBL od
    ON	
        o.ord_code = od.ord_code
    INNER JOIN PRODUCT_TBL p
    ON
        od.pro_num = p.pro_num
    
    
-- 주문 취소
UPDATE
    ORDER_TBL
SET
    ord_cancel = 'Y', ord_canceldate = SYSDATE
WHERE
    ord_code = 66;
    
    

DROP TABLE ORDETAIL_TBL;
--6.주문상세 테이블
CREATE TABLE ORDETAIL_TBL(
        ORD_CODE        NUMBER      NOT NULL REFERENCES ORDER_TBL(ORD_CODE),
        PRO_NUM         NUMBER      NOT NULL REFERENCES PRODUCT_TBL(PRO_NUM),
        ORDT_AMOUNT       NUMBER      NOT NULL,
        ORDT_PRICE        NUMBER      NOT NULL,  -- 역정규화
        PRIMARY KEY (ORD_CODE ,PRO_NUM) 
);


-- 결제 테이블 
DROP TABLE PAYMENT_TBL;
CREATE TABLE PAYMENT_TBL(
    PAY_CODE NUMBER CONSTRAINT PK_PAY_CODE PRIMARY KEY,
    ORD_CODE    NUMBER          NOT NULL,
    MB_ID       VARCHAR2(20)    NOT NULL,
    PAY_METHOD  VARCHAR2(20)    NOT NULL,
    PAY_PRICE   NUMBER          NOT NULL,
    PAY_BANK    VARCHAR2(20)    NOT NULL,
    PAY_BANK_ACCOUNT    VARCHAR2(20)    NOT NULL,
    PAY_MEMO    VARCHAR2(50)    NOT NULL,
    PAY_DATE    DATE        DEFAULT SYSDATE NOT NULL,
    TID         VARCHAR2(20)    NOT NULL,
    FOREIGN KEY(ORD_CODE) REFERENCES ORDER_TBL(ORD_CODE),
    FOREIGN KEY(MB_ID) REFERENCES MEMBER_TBL(MB_ID)
);
-- 시퀀스
DROP SEQUENCE SEQ_PAYMENT_TBL;
CREATE SEQUENCE SEQ_PAYMENT_TBL;

-- 총주문금액
SELECT ORD_CODE, SUM(DT_AMOUNT * DT_PRICE) FROM ORDETAIL_TBL WHERE ORD_CODE = ?;

DROP TABLE REVIEW_TBL;
--7.리뷰 테이블
CREATE TABLE REVIEW_TBL(
        REW_NUM         NUMBER                      PRIMARY KEY,
        MB_ID         VARCHAR2(15)                NOT NULL,
        PRO_NUM         NUMBER                      NOT NULL,
        REW_CONTENT     VARCHAR2(200)               NOT NULL,
        REW_SCORE       NUMBER                      NOT NULL,
        REW_REGDATE     DATE DEFAULT SYSDATE        NOT NULL,
        FOREIGN KEY(MB_ID) REFERENCES MEMBER_TBL(MB_ID),
        FOREIGN KEY(PRO_NUM) REFERENCES PRODUCT_TBL(PRO_NUM)
);


-- 시퀀스 생성
DROP SEQUENCE SEQ_REVIEW_TBL;
CREATE SEQUENCE SEQ_REVIEW_TBL;

--상품후기 입력
SELECT * FROM ORDETAIL_TBL;

INSERT INTO review_tbl (rew_num,mb_id,pro_num,rew_content,rew_score)
    VALUES (SEQ_REVIEW_TBL.NEXTVAL, 'test123',5,'무난하다.', 4 );
INSERT INTO review_tbl (rew_num,mb_id,pro_num,rew_content,rew_score)
    VALUES (SEQ_REVIEW_TBL.NEXTVAL, 'test123',7,'아주 좋다.', 5 );
    
    
COMMIT;    
SELECT * FROM  review_tbl; 




-- 관리자 추가
DROP TABLE ADMIN_TBL;
CREATE TABLE ADMIN_TBL(
    ADMIN_ID            VARCHAR2(20)   CONSTRAINT PK_ADMIN_ID   PRIMARY KEY,
    ADMIN_PW            CHAR(60)            NOT NULL,
    ADMIN_NAME          VARCHAR2(20)        NOT NULL,
    ADMIN_DATE          DATE        DEFAULT SYSDATE     NOT NULL,
    ADMIN_VISIT_DATE     DATE        DEFAULT SYSDATE     NOT NULL
);

INSERT INTO ADMIN_TBL VALUES('admin', '$2a$10$dQFCMr0udCI865eG6SoIcOaNr3Y/dgBX.R4qf6rX5KA3jciSnnNjG','쿠어관리자',sysdate,sysdate);

SELECT /*+INDEX_DESC(PRODUCT_TBL PK_PRO_NUM)*/
    ROWNUM RN, p.pro_num, p.cat_code, c.cat_prtcode, c.cat_name, p.pro_name, p.pro_price, p.pro_discount, p.pro_content, p.pro_up_folder, p.pro_up_img, p.pro_amount, p.pro_show, p.pro_buy, p.pro_date, p.pro_updatedate
FROM
    PRODUCT_TBL p INNER JOIN CATEGORY_TBL c
ON
    p.cat_code = c.cat_code;
    
    
-- 문의하기
DROP TABLE CONTACT_TBL;
CREATE TABLE CONTACT_TBL(
    CONTACT_NUM        NUMBER      CONSTRAINT PK_CONTACT_CODE PRIMARY KEY,
    MB_ID               VARCHAR2(20)        NOT NULL,
    PRO_NUM             NUMBER              NULL,
    ORD_CODE            NUMBER              NULL,
    CONTACT_TYPE        CHAR                NOT NULL,
    CONTACT_TITLE   VARCHAR2(50)                  NOT NULL,
    CONTACT_CONTENT VARCHAR2(4000)                NOT NULL,
    CONTACT_RE      VARCHAR2(4000)                NULL, --답변
    CONTACT_STATUS  CHAR         DEFAULT 'N'           NOT NULL,
    CONTACT_REGDATE DATE         DEFAULT SYSDATE       NOT NULL,
    CONTACT_UPDATEDATE DATE         DEFAULT SYSDATE       NOT NULL,
    CONTACT_RE_DATE DATE         DEFAULT SYSDATE       NOT NULL,
    FOREIGN KEY(MB_ID) REFERENCES MEMBER_TBL(MB_ID)
);

DROP SEQUENCE SEQ_CONTACT_TBL;
CREATE SEQUENCE SEQ_CONTACT_TBL;

contact_num, mb_id, pro_num, ord_code, contact_type, contact_title, contact_content, contact_re, contact_status, contact_regdate, contact_updatedate, contact_re_date
