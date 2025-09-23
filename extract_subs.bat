@echo off
:: 링크 입력
echo 링크를 붙여넣으세요 (Ctrl+V):
set /p url=

:: 파일명 입력 (확장자 제외)
echo 저장할 파일명 입력:
set /p filename=

:: subs 폴더 생성 (없으면 새로 만들기)
if not exist "subs" mkdir "subs"

echo 파일명: %filename%
echo 다운로드 및 자막 추출 중...

:: 영상 다운로드
yt-dlp -o "%filename%.mp4" "%url%"

:: 오디오 추출
ffmpeg -i "%filename%.mp4" -ar 16000 -ac 1 "%filename%.wav"

:: 텍스트 변환 (whisper) - 사용 가능한 옵션만으로 반복 문제 해결
.\whisper-cli.exe -m ggml-large-v3.bin -l ko "%filename%.wav" --output-txt --temperature 0.0 --no-timestamps --flash-attn --threads 8 --beam-size 1 --best-of 1

:: 생성된 텍스트 파일을 subs 폴더로 이동
move "%filename%.wav.txt" "subs\%filename%.txt"

:: 임시 WAV 파일 삭제
del "%filename%.wav"

echo 완료! MP4 영상은 그대로, 자막은 subs 폴더 안에 %filename%.txt 생성됨
pause