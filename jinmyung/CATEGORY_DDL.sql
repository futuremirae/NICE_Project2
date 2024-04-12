
-- 테이블 생성

CREATE TABLE CTGY
(
      MAIN_NM   VARCHAR2(50) 
    , SUB_NM    VARCHAR2(50)
    , ITEM_NM   VARCHAR2(50)
    , MAIN_ID   VARCHAR2(50)
    , SUB_ID    VARCHAR2(50)
    , ITEM_ID   VARCHAR2(50)
);


CREATE TABLE MAIN_CTGY
(
      MAIN_NM   VARCHAR2(50)    REFERENCES
                                CTGY(MAIN_NM)
                                ON DELETE CASCADE
    , MAIN_ID   VARCHAR2(50)    REFERENCES
                                CTGY(MAIN_ID)
                                ON DELETE CASCADE
);


CREATE TABLE SUB_CTGY
(
      MAIN_ID   VARCHAR2(50)    REFERENCES
                                CTGY(MAIN_ID)
                                ON DELETE CASCADE
    , SUB_NM    VARCHAR2(50)    REFERENCES
                                CTGY(SUB_NM)
                                ON DELETE CASCADE
    , SUB_ID    VARCHAR2(50)    REFERENCES
                                CTGY(SUB_ID)
                                ON DELETE CASCADE
);

CREATE TABLE ITEM_NM
(
      SUB_ID    VARCHAR2(50)    REFERENCES
                                CTGY(SUB_ID)
                                ON DELETE CASCADE
    , ITEM_NM   VARCHAR2(50)    REFERENCES
                                CTGY(ITEM_NM)
                                ON DELETE CASCADE
    , ITEM_ID   VARCHAR2(50)    REFERENCES
                                CTGY(ITEM_ID)
                                ON DELETE CASCADE
);

-- 대륙 및 국가 컬럼 생성

CREATE TABLE REGION
(
      CONTINENT     VARCHAR2(50) 
    , COUNTRY       VARCHAR2(50)
    , CONTINENT_ID  VARCHAR2(50)
    , COUNTRY_ID    VARCHAR2(50)
);

-- 대륙 컬럼 생성
CREATE TABLE CONTINENT
(
      CONTINENT     VARCHAR2(50)    REFERENCES
                                    REGION(CONTINENT)
                                    ON DELETE CASCADE
    , CONTINENT_ID  VARCHAR2(50)    REFERENCES
                                    REGION(CONTINENT_ID)
                                    ON DELETE CASCADE
);

-- 대륙별 국가 컬럼 생성
CREATE TABLE CONTINENT
(
      COUNTRY       VARCHAR2(50)    REFERENCES
                                    REGION(COUNTRY)
                                    ON DELETE CASCADE
    , CONTINENT_ID  VARCHAR2(50)    REFERENCES
                                    REGION(CONTINENT_ID)
                                    ON DELETE CASCADE
    , COUNTRY_ID    VARCHAR2(50)    REFERENCES
                                    REGION(COUNTRY_ID)
                                    ON DELETE CASCADE
);

-- 테이블 삭제
-- 삭제는 생성의 역순

DROP TABLE CTGY;

DROP TABLE MAIN_CTGY;

DROP TABLE SUB_CTGY;

DROP TABLE ITEM_NM;



DROP TABLE REGION;

DROP TABLE CONTINENT;

DROP TABLE COUNTRY;