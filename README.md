# Auto Sub Extractor

영상에서 자막을 자동으로 추출하는 스크립트입니다.

## 사용 환경

* Windows
* yt-dlp 설치 필요
* ffmpeg 설치 필요
* whisper-cli 및 ggml 모델 필요

## 사용법

1. **영상 링크 입력**

```bat
@echo off
echo 링크를 붙여넣으세요 (Ctrl+V):
set /p url=
```

2. **파일명 및 자막 폴더 설정**

```bat
set today=%date%
set timestamp=%time:~0,2%%time:~3,2%%time:~6,2%
set timestamp=%timestamp: =0%
set filename=lecture_%today:~2,2%%today:~5,2%%today:~8,2%_%timestamp%
set subtitle_folder=subtitles
if not exist %subtitle_folder% mkdir %subtitle_folder%
```

3. **영상 다운로드, 음성 추출, 자막 생성**

```bat
yt-dlp -o "%filename%.mp4" "%url%"
ffmpeg -i "%filename%.mp4" -ar 16000 -ac 1 "%filename%.wav"
.\whisper-cli.exe -m ggml-base.bin -l ko "%filename%.wav" --output-txt -o "%subtitle_folder%\%filename%.txt"
```

4. **완료**

* 생성된 자막은 `subtitles` 폴더 안에 저장됩니다.
* 원본 영상은 삭제되지 않고 그대로 남습니다.

---

> **Tip:** 영상 파일과 자막 파일을 깃허브에 올릴 필요가 없으면 `.gitignore`에 확장자(`.mp4`, `.wav`, `.bin`)를 추가하세요.
