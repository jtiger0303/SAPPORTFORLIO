*&---------------------------------------------------------------------*
*& Report Z6WEEK_EXCEL003
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z6WEEK_ZEMPLOYEE_AUTO01.

INCLUDE Z6WEEK_ZEMPLOYEE_AUTO01_TOP.
INCLUDE Z6WEEK_ZEMPLOYEE_AUTO01_SEL.
INCLUDE Z6WEEK_ZEMPLOYEE_AUTO01_C01.
INCLUDE Z6WEEK_ZEMPLOYEE_AUTO01_F01.
INCLUDE Z6WEEK_ZEMPLOYEE_AUTO01_I01.
INCLUDE Z6WEEK_ZEMPLOYEE_AUTO01_O01.

*&=====================================================================*
*& INITIALIZATION
*&=====================================================================*
INITIALIZATION.
  PERFORM SET_FUNCTION_KEY.
  SY-TITLE = '엑셀 업로드 프로그램'. "제목 고정하고 싶을때"
** 샘플다운 버튼을 만든 부분

** 검색화면 전에 실행 / 검색화면 구성하는 부분이 들어간다.
*&=====================================================================*
*& AT SELECTION-SCREEN
*&=====================================================================*
AT SELECTION-SCREEN.
  PERFORM ACT_FUNCTION_KEY.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR P_FILE.
  PERFORM GET_FILE_PATH.

*&=====================================================================*
*& START-OF-SELECTION
*&=====================================================================*
START-OF-SELECTION.

IF r1 = 'X'.
    PERFORM CHECK_BEFORE_PROCESS.
* 파일 업로드 진행
    PERFORM UPLOAD_FROM_EXCEL.
    PERFORM GET_DATA. "오류 검증하는 부분"
ELSEIF r2 = 'X'.
    PERFORM GET_NEEDED_DATA.
ELSEIF r3 = 'X'.
    PERFORM DEL_DATA.
ENDIF.

*&=====================================================================*
*& END-OF-SELECTION
*&=====================================================================*
END-OF-SELECTION.
IF r1 ='X'.
  CALL SCREEN 100.
ELSEIF r2 = 'X'.
  IF GT_TABLE IS NOT INITIAL.
  CALL SCREEN 100.
  ELSE.
    MESSAGE '조회할 데이터가 없습니다.' TYPE 'I'.
  ENDIF.

ENDIF.
