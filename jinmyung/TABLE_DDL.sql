
-- [ ���� ���̺� ] ����

CREATE TABLE USER_ACC
(
      USER_ID       VARCHAR2(20)    PRIMARY KEY                 -- ����� ���̵�
    , USER_PWD      VARCHAR2(100)   NOT NULL                    -- ����� ��й�ȣ
    , USER_DUNS_NO  VARCHAR2(9)     NOT NULL                    -- ����� ȸ�� ���� ��ȣ
    , USER_CMP_ENG  VARCHAR2(100)   NOT NULL                    -- ����� ȸ���(����)
    , USER_CMP_KOR  VARCHAR2(100)                               -- ����� ȸ���(�ѱ�)
    , USER_CEO_ENG  VARCHAR2(50)    NOT NULL                    -- ����� ��ǥ�ڸ�(����)
    , USER_CEO_KOR  VARCHAR2(50)                                -- ����� ��ǥ�ڸ�(�ѱ�)
    , USER_EML      VARCHAR2(100)   NOT NULL                    -- ����� �̸��� (�����)
    , USER_PUB_EML  VARCHAR2(100)   NOT NULL                    -- ����� �̸��� (ȸ�� ����)
    , USER_URL      VARCHAR2(200)   NOT NULL                    -- ����� ȸ�� URL
    , USER_ADR      VARCHAR2(200)   NOT NULL                    -- ����� �ּ� (����)
    , USER_NAME     VARCHAR2(30)    NOT NULL                    -- ����� �̸�(�����)
    , USER_PHONE    VARCHAR2(30)    NOT NULL                    -- ����� ��ȭ��ȣ(�����)
--    , USER_BUSINESS VARCHAR2(200)   CHECK (USER_BUSINESS IN     -- ����� ����
--                                    ('IMPORTER', 'EXPORTER', 'MANUFACTURER', 'DISTRIBUTOR')) 
--                                    NOT NULL    -- ������ �츮�� �����ߴ� �Ͱ� �޶� CHECK OPTION�� �����ؾ���
    , USER_KEYWORD  VARCHAR2(500)                               -- ����� ���� Ű����
    , USER_ROLE     VARCHAR2(20)    DEFAULT 'ROLE_USER'         -- ����� ���� ����
                                    CHECK (USER_ROLE IN
                                    ('ROLE_USER','ROLE_ADMIN'))
                                    NOT NULL
    -- �������� ��� ����
    -- ���� ����ȭ ���� -- ����(24.04.12)
);

-- user_id�� fk�� �޴� ���� [ ������ ���̺� ] ����
-- �ۼ��ڿ� �α��λ���ڰ� ���� �ุ ���
CREATE TABLE SENDED_EMAIL
(
      USER_ID           NUMBER          REFERENCES              -- ����� ���̵�
                                        USER_ACC(USER_ID)
                                        ON DELETE CASCADE
    , RECEIVER          VARCHAR2(50)    NOT NULL                -- ������ �޴� ���
    , REPLY_CONTENT     VARCHAR2(3000)  NOT NULL                -- ���� ����
    , REPLY_FILE        VARCHAR2(
    , SENDED_DATE       DATE
    -- ��Ÿ ��� ���
);


-- ���̾� ���� ���̺� ����
-- ���̾� ���ýÿ� ��ǥ�� ������ ���ʿ� ����ǰԲ�
-- �׸��� USER_ACC ���̺�� ID���� �����Ͽ� ���� ������ �α��ΰ����� ������ ��쿡�� ���
CREATE TABLE FAVORITE
(
      USER_ID           NUMBER          REFERENCES
                                        USER_ACC(USER_ID)
                                        ON DELETE CASCADE
    , RECEIVER          VARCHAR2(50)    NOT NULL
    , REPLY_CONTENT     VARCHAR2(3000)  NOT NULL
    , SENDED_DATE       DATE
    -- ��Ÿ ��� ���
);

-- ����ں� �ֱ� �˻�� ������ ���̺� ����
-- prepend�� ����Ͽ� ���� �ֱٿ� �˻��� �˻�� ���� �տ� ����ǰԲ� ����
CREATE TABLE SEARCH_LOG
(
      USER_ID           NUMBER          REFERENCES
                                        USER_ACC(USER_ID)
                                        ON DELETE CASCADE
    , USER_LOG          VARCHAR2(50)                        -- ����� �˻� ����
)

-- �������� ���̺� ����
-- ������ ����ڵ� Ȯ�� ���� -- ���� ����
-- �����ڸ� �ۼ� ���� ���� ����
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



-- �ӽ� ������ << ���� �ļ���


-- ���ǻ��� ���̺� ����
-- �ۼ��ڿ� �α��λ���ڰ� ���� �ุ ���
-- ������ = ��� ���ǻ����� Ȯ�� ����
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
); -- �ݵ�� USER_ACC�� ������ �� �����ų ��


-- ���� �亯(���)���̺� ����
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
); -- �ݵ�� BOARD�� ������ �� �����ų ��


-- ������ ����
CREATE SEQUENCE USER_ACC_SEQ;

CREATE SEQUENCE INQUIRY_SEQ;

CREATE SEQUENCE REPLY_SEQ;

-- ���̺� ����
-- ������ ������ ����

DROP TABLE USER_ACC;

DROP TABLE INQUIRY;

DROP TABLE REPLY;


