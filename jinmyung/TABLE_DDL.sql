
-- [ 계정 테이블 ] 생성

CREATE TABLE USER_ACC
(
      USER_ID       VARCHAR2(20)    PRIMARY KEY                 -- 사용자 아이디
    , USER_PWD      VARCHAR2(100)   NOT NULL                    -- 사용자 비밀번호
    , USER_DUNS_NO  VARCHAR2(9)     NOT NULL                    -- 사용자 회사 던스 번호
    , USER_CMP_ENG  VARCHAR2(100)   NOT NULL                    -- 사용자 회사명(영문)
    , USER_CMP_KOR  VARCHAR2(100)                               -- 사용자 회사명(한글)
    , USER_CEO_ENG  VARCHAR2(50)    NOT NULL                    -- 사용자 대표자명(영문)
    , USER_CEO_KOR  VARCHAR2(50)                                -- 사용자 대표자명(한글)
    , USER_EML      VARCHAR2(100)   NOT NULL                    -- 사용자 이메일 (담당자)
    , USER_PUB_EML  VARCHAR2(100)   NOT NULL                    -- 사용자 이메일 (회사 공용)
    , USER_URL      VARCHAR2(200)   NOT NULL                    -- 사용자 회사 URL
    , USER_ADR      VARCHAR2(200)   NOT NULL                    -- 사용자 주소 (영문)
    , USER_NAME     VARCHAR2(30)    NOT NULL                    -- 사용자 이름(담당자)
    , USER_PHONE    VARCHAR2(30)    NOT NULL                    -- 사용자 전화번호(담당자)
--    , USER_BUSINESS VARCHAR2(200)   CHECK (USER_BUSINESS IN     -- 사용자 업종
--                                    ('IMPORTER', 'EXPORTER', 'MANUFACTURER', 'DISTRIBUTOR')) 
--                                    NOT NULL    -- 업종도 우리가 생각했던 것과 달라서 CHECK OPTION도 수정해야함
    , USER_KEYWORD  VARCHAR2(500)                               -- 사용자 관심 키워드
    , USER_ROLE     VARCHAR2(20)    DEFAULT 'ROLE_USER'         -- 사용자 가입 구분
                                    CHECK (USER_ROLE IN
                                    ('ROLE_USER','ROLE_ADMIN'))
                                    NOT NULL
    -- 설립일은 없어서 제외
    -- 아직 정규화 안함 -- 진명(24.04.12)
);

-- user_id를 fk로 받는 보낸 [ 메일함 테이블 ] 생성
-- 작성자와 로그인사용자가 같은 행만 출력
CREATE TABLE SENDED_EMAIL
(
      USER_ID           NUMBER          REFERENCES              -- 사용자 아이디
                                        USER_ACC(USER_ID)
                                        ON DELETE CASCADE
    , RECEIVER          VARCHAR2(50)    NOT NULL                -- 메일을 받는 사람
    , REPLY_CONTENT     VARCHAR2(3000)  NOT NULL                -- 보낸 내용
    , REPLY_FILE        VARCHAR2(
    , SENDED_DATE       DATE
    -- 기타 양식 기억
);


-- 바이어 찜기능 테이블 생성
-- 바이어 선택시에 별표를 누르면 이쪽에 저장되게끔
-- 그리고 USER_ACC 테이블과 ID값을 공유하여 찜한 계정과 로그인계정이 동일한 경우에만 출력
CREATE TABLE FAVORITE
(
      USER_ID           NUMBER          REFERENCES
                                        USER_ACC(USER_ID)
                                        ON DELETE CASCADE
    , RECEIVER          VARCHAR2(50)    NOT NULL
    , REPLY_CONTENT     VARCHAR2(3000)  NOT NULL
    , SENDED_DATE       DATE
    -- 기타 양식 기억
);

-- 사용자별 최근 검색어를 저장할 테이블 생성
-- prepend를 사용하여 가장 최근에 검색한 검색어를 가장 앞에 노출되게끔 생성
CREATE TABLE SEARCH_LOG
(
      USER_ID           NUMBER          REFERENCES
                                        USER_ACC(USER_ID)
                                        ON DELETE CASCADE
    , USER_LOG          VARCHAR2(50)                        -- 사용자 검색 정보
)

-- 공지사항 테이블 생성
-- 미인증 사용자도 확인 가능 -- 이제 못봄
-- 관리자만 작성 수정 삭제 가능
CREATE TABLE NOTICE
(
      NOTICE_NO                   NUMBER          PRIMARY KEY
    , NOTICE_WRITER               VARCHAR2(20)    REFERENCES 
                                                  USER_ACC(USER_ID) 
                                                  ON DELETE CASCADE
    , NOTICE_TITLE                VARCHAR2(300)   NOT NULL
    , NOTICE_CONTENT              VARCHAR2(3000)  NOT NULL
    , NOTICE_CREATE_DATE          DATE            DEFAULT SYSDATE
                                                  NOT NULL
    , NOTICE_UPDATE_DATE          DATE
    , NOTICE_ORIGINALFILENAME     VARCHAR2(300)
    , NOTICE_SAVEDFILENAME        VARCHAR2(300)
    , NOTICE_APPROVAL            CHAR(1)         DEFAULT 1
                                                  CHECK(board_APPROVAL IN
                                                  ('USER', 'ADMIN'))
                                                  NOT NULL
);



-- 임시 보관함 << 가장 후순위


-- 문의사항 테이블 생성
-- 작성자와 로그인사용자가 같은 행만 출력
-- 관리자 = 모든 문의사항을 확인 가능
CREATE TABLE INQUIRY
(
      INQUIRY_NO                  NUMBER          PRIMARY KEY
    , INQUIRY_WRITER              VARCHAR2(20)    REFERENCES 
                                                  USER_ACC(USER_ID) 
                                                  ON DELETE CASCADE
    , INQUIRY_TITLE               VARCHAR2(300)   NOT NULL
    , INQUIRY_CONTENT             VARCHAR2(3000)  NOT NULL
    , INQUIRY_CREATE_DATE         DATE            DEFAULT SYSDATE
                                                  NOT NULL
    , INQUIRY_UPDATE_DATE         DATE
    , INQUIRY_ORIGINALFILENAME    VARCHAR2(300)
    , INQUIRY_SAVEDFILENAME       VARCHAR2(300)
    , INQUIRY_APPROVAL            CHAR(1)         DEFAULT 1
                                                  CHECK(board_APPROVAL IN
                                                  ('USER', 'ADMIN'))
                                                  NOT NULL
); -- 반드시 USER_ACC를 생성한 뒤 실행시킬 것


-- 문의 답변(댓글)테이블 생성
CREATE TABLE REPLY
(
    REPLY_NO            NUMBER          PRIMARY KEY
    , BOARD_NO          NUMBER          REFERENCES
                                        INQUIRY(INQUIRY_NO)
                                        ON DELETE CASCADE
    , REPLY_WRITER      VARCHAR2(20)    REFERENCES
                                        USER_ACC(USER_ID)
                                        ON DELETE CASCADE
    , REPLY_CONTENT     VARCHAR2(3000)  NOT NULL
    , REPLY_CREATE_DATE DATE            DEFAULT SYSDATE
                                        NOT NULL
    , REPLY_UPDATE_DATE DATE
); -- 반드시 BOARD를 생성한 뒤 실행시킬 것


-- 시퀀스 생성
CREATE SEQUENCE USER_ACC_SEQ;

CREATE SEQUENCE INQUIRY_SEQ;

CREATE SEQUENCE REPLY_SEQ;

-- 테이블 삭제
-- 삭제는 생성의 역순

DROP TABLE USER_ACC;

DROP TABLE INQUIRY;

DROP TABLE REPLY;


