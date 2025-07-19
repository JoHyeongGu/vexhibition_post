List<Briefing> briefingData = [
  Briefing(
    title: "1주차 개발: 환경 세팅",
    content: [
      BriefingImageData(
        image: "diversion_create.png",
        description: "Unreal Engine 맞춤형 버전 관리 툴인 Diversion에 프로젝트 업로드 및 공유",
      ),
      BriefingImageData(
        image: "debugging_img.png",
        description: "개발 환경 세팅 & 환경 변화에 대한 디버깅 작업",
      ),
      BriefingImageData(
        image: "UnVR_Check.gif",
        description: "VR 기기 없이 키보드, 마우스만으로 실행해 볼 수 있는 UnVR 유저 컨트롤러 제작",
      ),
    ],
  ),
  Briefing(
    title: "2주차 개발: UI 데이터 연동",
    content: [
      BriefingImageData(
        image: "unreal_see_backend.png",
        description: "LMS 홈페이지 (프로젝트 소개 페이지) 데이터와 연동",
      ),
      BriefingImageData(
        image: "Summery_UI.gif",
        description: "프로젝트 판넬에 대한 정보 UI 출력",
      ),
      BriefingImageData(
        image: "MultiPanel.gif",
        description: "유저와 판넬 간의 상호작용 기능 & 판넬 슬라이드 기능 추가",
      ),
    ],
  ),
  Briefing(
    title: "3주차 개발: 안내 로봇 제작",
    content: [
      BriefingImageData(
        image: "design_guide_bot.png",
        description: "프로젝트를 음성으로 설명해주는 안내 로봇 모델링 & 애니메이션 제작",
      ),
      BriefingImageData(
        image: "follow_guide_bot.gif",
        description: "안내 로봇이 사용자를 따라다니는 기능 구현",
      ),
      BriefingImageData(
        image: "https://youtu.be/gIHMtceJv2k?time=10",
        description: "TTS 기능을 활용하여 로봇이 프로젝트를 음성으로 설명해주는 기능 구현",
      ),
    ],
  ),
];

class BriefingImageData {
  late String image;
  String description = "";

  BriefingImageData({required String image, required this.description}) {
    this.image = image.contains("youtu.be")
        ? "youtube:${image.split("/").last}"
        : "assets/images/$image";
  }
}

class Briefing {
  String title;
  List<BriefingImageData> content;

  Briefing({required this.title, required this.content});
}
