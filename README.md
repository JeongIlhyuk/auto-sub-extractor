Relevant chats
1 result


README.md 파일을 만들어드릴게요!

markdown
# YouTube 자막 추출기

이 도구는 YouTube/강의 링크에서 영상을 다운로드하고 Whisper AI를 사용해 자막을 추출합니다.

## 사용법
1. `extract_subs.bat` 실행
2. 링크 붙여넣기 (Ctrl+V)
3. 파일명 입력
4. 자동 처리 완료

## 처리 과정
- 영상 다운로드 (yt-dlp)
- 오디오 추출 (ffmpeg)
- 음성 인식 (whisper)
- 자막 파일 생성 (subs 폴더)

## Whisper 모델 옵션

### 현재 사용 모델
- **ggml-large-v3.bin** (3.1GB) - 최고 정확도

### 대안 모델들
| 모델 | 크기 | 정확도 | 속도 | 용도 |
|------|------|--------|------|------|
| `ggml-large-v3-turbo.bin` | 1.6GB | 높음 | 빠름 | 균형점 |
| `ggml-large-v3.bin` | 3.1GB | 최고 | 느림 | 최고 정확도 |
| `ggml-medium.bin` | 1.5GB | 보통 | 보통 | 중간 성능 |
| `ggml-base.bin` | 142MB | 기본 | 빠름 | 빠른 처리 |

### 모델 변경법
`extract_subs.bat` 파일에서 모델명만 변경:
```batch
.\whisper-cli.exe -m [모델명] -l ko "%filename%.wav" --output-txt
Whisper-CLI 주요 옵션
성능 관련
batch
--flash-attn          # GPU 가속 (RTX 4060 권장)
--no-gpu             # GPU 비활성화
--threads N          # CPU 스레드 수 (기본: 4)
--processors N       # 프로세서 수 (기본: 1)
품질 관련
batch
--temperature N      # 샘플링 온도 (0-1, 기본: 0.2)
--beam-size N        # 빔 서치 크기 (기본: 5)
--best-of N          # 최선 후보 수 (기본: 5)
출력 관련
batch
--output-txt         # 텍스트 파일 출력
--output-srt         # SRT 자막 파일 출력
--output-vtt         # VTT 자막 파일 출력
--no-timestamps      # 타임스탬프 제거
언어/음성 처리
batch
-l ko               # 한국어 설정
--translate         # 영어로 번역
--diarize          # 화자 분리
GPU 가속 설정
RTX 4060 사용 시 권장 설정:

batch
.\whisper-cli.exe -m ggml-large-v3.bin -l ko "%filename%.wav" --output-txt --flash-attn --threads 8
예상 처리 시간 (RTX 4060 기준)
50분 영상: 15-25분 처리
GPU 가속 시: 10-15분 처리
turbo 모델 시: 5-10분 처리
모델 다운로드
PowerShell 사용
powershell
# large-v3 (3.1GB)
Invoke-WebRequest -Uri "https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-large-v3.bin" -OutFile "ggml-large-v3.bin"

# turbo 버전 (1.6GB)
Invoke-WebRequest -Uri "https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-large-v3-turbo.bin" -OutFile "ggml-large-v3-turbo.bin"
브라우저 다운로드
large-v3
turbo
시스템 요구사항
최소 RAM: 8GB (large-v3는 16GB 권장)
GPU: NVIDIA RTX 시리즈 (선택사항)
저장공간: 모델 크기 + 영상 크기
메모리 사용량 주의사항
large-v3: 프로세스당 ~8GB RAM 사용
동시 실행 제한: 32GB RAM 기준 2-3개까지만
medium 모델: 프로세스당 ~3GB (동시 실행 더 가능)
문제 해결
모델 파일 없음
error: The system cannot find the file specified.
→ 모델 파일을 먼저 다운로드하세요

GPU 옵션 오류
error: unknown argument: -ngl
→ --flash-attn 또는 --no-gpu 사용

메모리 부족
→ 더 작은 모델 사용 (medium/base)

반복 텍스트 문제
→ --temperature 0.2 --no-timestamps 옵션 추가