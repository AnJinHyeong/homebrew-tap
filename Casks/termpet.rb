# 텀펫 설치:  brew install --cask anjinhyeong/tap/termpet
# version / sha256 은 TermPet 저장소의 Scripts/release.sh 가 자동으로 갱신한다.
cask "termpet" do
  version "0.5.10"
  sha256 "e9eb07abd0ac77c5cfb80af9310943a3938ec5da6e078c1d93970510aae0c7c1"

  url "https://github.com/AnJinHyeong/TermPet/releases/download/v#{version}/TermPet-#{version}.zip"
  name "텀펫"
  name "TermPet"
  desc "Menu bar desktop pet that tells you when Claude Code or long terminal commands finish"
  homepage "https://github.com/AnJinHyeong/TermPet"

  depends_on macos: :sonoma

  app "TermPet.app"

  # 개인용 ad-hoc 서명 앱이라 Apple 공증이 없다 → 다운로드 격리 표시를 지워야 "손상됨" 경고 없이 열린다
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/TermPet.app"],
                          writable_paths: ["TermPet.app"], writable_base: :appdir
  end

  uninstall quit: "com.termpet.TermPet"

  zap trash: [
    "~/.termpet",
    "~/Library/Application Support/TermPet",
    "~/Library/Preferences/com.termpet.TermPet.plist",
  ]
end
