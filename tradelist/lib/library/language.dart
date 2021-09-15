library github_language_colors;

import 'dart:collection';
import 'dart:convert';

class LanguageHelper {
  static Map<String, String> languageMap = getResource(githubLanguageColors);

  static Map<String, String> getResource(List list) {
    Map<String, String> map = HashMap();
    List<MapEntry<String, String>> mapEntryList = [];
    for (int i = 0, length = list.length; i < length; i++) {
      Map<String, String> tokens = list[i];
      String name = tokens['name'];
      String color = tokens['color'];
      if (color != null) {
        MapEntry<String, String> mapEntry = MapEntry(name, color);
        mapEntryList.add(mapEntry);
      }
    }
    map.addEntries(mapEntryList);
    return map;
  }

  static List<GithubLanguage> getGithubLanguages() {
    List<GithubLanguage> list =
    githubLanguageColors.map((v) => GithubLanguage.fromJson(v)).toList();
    return list;
  }

  static List<GithubLanguage> getGithubSpokenLanguages() {
    List<GithubLanguage> list =
    githubSpokenLanguage.map((v) => GithubLanguage.fromJson(v)).toList();
    return list;
  }

  static String getGithubLanguageColor(String language,
      {String defColor = ''}) {
    return languageMap[language] ?? defColor;
  }
}

class GithubLanguage {
  String name;
  String urlParam;
  String color;

  GithubLanguage.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        urlParam = json['urlParam'],
        color = json['color'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    void addIfNonNull(String fieldName, dynamic value) {
      if (value != null) {
        map[fieldName] = value;
      }
    }

    addIfNonNull('name', name);
    addIfNonNull('urlParam', urlParam);

    return map;
  }

  @override
  String toString() {
    return json.encode(this);
  }
}

const List githubLanguageColors = [
  {"name": "TRX 트론"},
  {"name": "XLM 스텔라루멘"},
  {"name": "DAWN 던프로토콜"},
  {"name": "VET 비체인"},
  {"name": "LINK 체인링크"},
  {"name": "OMG 오미세고"},
  {"name": "MOC 모스코인"},
  {"name": "HUM 휴먼스케이프"},
  {"name": "TON 톤"},
  {"name": "NEO 네오"},
  {"name": "GRS 그로스톨코인"},
  {"name": "GAS 가스"},
  {"name": "ONT 온톨로지"},
  {"name": "LTC 라이트코인"},
  {"name": "SXP 스와이프"},
  {"name": "SBD 스팀달러"},
  {"name": "XTZ 테조스"},
  {"name": "DOT 폴카닷"},
  {"name": "ATOM 코스모스"},
  {"name": "WAXP 왁스"},
  {"name": "BCH 비트코인캐시"},
  {"name": "ENJ 엔진코인"},
  {"name": "BTT 비트토렌트"},
  {"name": "BORA 보라"},
  {"name": "GLM 골렘"},
  {"name": "MED 메디블록"},
  {"name": "QTUM 퀀텀"},
  {"name": "AQT 알파쿼크"},
  {"name": "REP 어거"},
  {"name": "ADA 에이다"},
  {"name": "ETH 이더리움"},
  {"name": "KAVA 카바"},
  {"name": "ETC 이더리움클래식"},
  {"name": "DOGE 도지코인"},
  {"name": "ORBS 오브스"},
  {"name": "FCT2 피르마체인"},
  {"name": "BTG 비트코인골드"},
  {"name": "AXS 엑시인피니티"},
  {"name": "WAVES 웨이브"},
  {"name": "ONG 온톨로지가스"},
  {"name": "ELF 엘프"},
  {"name": "BSV 비트코인에스브이"},
  {"name": "CHZ 칠리즈"},
  {"name": "EOS 이오스"},
  {"name": "MANA 디센트럴랜드"},
  {"name": "BCHA 비트코인캐시에이비씨"},
  {"name": "BTC 비트코인"},
  {"name": "PLA 플레이댑"},
  {"name": "SAND 샌드박스"},
  {"name": "SRM 세럼"},
  {"name": "XRP 리플"},
  {"name": "FLOW 플로우"},
  {"name": "DKA 디카르고"},
  {"name": "UPP 센티넬프로토콜"},
  {"name": "STORJ 스토리지"},
  {"name": "XEM 넴"},
  {"name": "META 메타디움"},
  {"name": "AERGO 아르고"},
  {"name": "STX 스택스"},
  {"name": "MLK 밀크"},
  {"name": "TFUEL 쎄타퓨엘"},
  {"name": "SSX 썸씽"},
  {"name": "CBK 코박토큰"},
  {"name": "SC 시아코인"},
  {"name": "ANKR 앵커"},
  {"name": "HIVE 하이브"},
  {"name": "ZIL 질리카"},
  {"name": "STRAX 스트라티스"},
  {"name": "LSK 리스크"},
  {"name": "PUNDIX 펀디엑스"},
  {"name": "STRK 스트라이크"},
  {"name": "THETA 쎄타토큰"},
  {"name": "POWR 파워렛저"},
  {"name": "IOST 아이오에스티"},
  {"name": "MTL 메탈"},
  {"name": "STEEM 스팀"},
  {"name": "SNT 스테이터스네트워크토큰"},
  {"name": "HUNT 헌트"},
  {"name": "CRE 캐리프로토콜"},
  {"name": "MVL 엠블"},
  {"name": "KNC 카이버네트워크"},
  {"name": "CVC 시빅"},
  {"name": "ZRX 제로엑스"},
  {"name": "ICX 아이콘"},
  {"name": "JST 저스트"},
  {"name": "MBL 무비블록"},
  {"name": "LOOM 룸네트워크"},
  {"name": "HBAR 헤데라해시그래프"},
  {"name": "BAT 베이직어텐션토큰"},
  {"name": "ARDR 아더"},
  {"name": "ARK 아크"},
  {"name": "MFT 메인프레임"},
  {"name": "IQ 에브리피디아"},
  {"name": "QKC 쿼크체인"},
  {"name": "STPT 에스티피"},
  {"name": "RFR 리퍼리움"},
  {"name": "POLY 폴리매쓰"},
  {"name": "TT 썬더토큰"},
  {"name": "CRO 크립토닷컴체인"},
  {"name": "AHT 아하토큰"},
  {"name": "IOTA 아이오타"},




];

const List githubSpokenLanguage = [
  {"urlParam": "ㅅㄷ", "name": "샌드박스"},
  {"urlParam": "ㅍ", "name": "펀디엑스"},
  {"urlParam": "ㄹ", "name": "리플"},
  {"urlParam": "ㄷ", "name": "도지코인"},
  {"urlParam": "ㅋ", "name": "카바"},

];
