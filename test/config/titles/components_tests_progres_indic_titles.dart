/* INSTRUCTIONS ABOUT 'REPO-REAL-DE-PRODUCAO'
  https://timm.preetz.name/articles/http-request-flutter-test
  By DEFAULT, HTTP request made in tests invoked BY flutter test
  result in an empty response (400).
  By DEFAULT, It is a good behavior to avoid external
  dependencies and hence reduce flakyness(FRAGILE) tests.
  THEREFORE:
  A) TESTS CAN NOT DO EXTERNAL-HTTP REQUESTS/CALLS;
  B) HENCE, THE TESTS CAN NOT USE 'REPO-REAL-DE-PRODUCAO'(no external calls)
  C) SO, THE TESTS ONLY WILL USE MockedRepoClass/MockedDatasource
   */
class ComponentsTestsProgresIndicTitles {
  static final String _GROUP_TITLE = 'Components';
  static final String _PROGR_INDIC = 'ProgresIndic';

  // @formatter:off
  //COMPONENTS-GROUP-TITLES----------------------------------------------------
  static get GROUP_TITLE => '$_GROUP_TITLE|$_PROGR_INDIC: Functional';

  //PROGRESS-INDICATOR-TEST-TITLES --------------------------------------------
  get PROGR_INDIC_TITLE => '$_PROGR_INDIC|View: Functional';
  get check_custom_progr_indic => 'Checking ProgrIndicator';
  get check_custom_progr_indic_emptydb => 'Checking ProgrIndicator with EmptyDB';
  // @formatter:on
}