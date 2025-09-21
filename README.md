# auto-sub-extractor

## Git LFS 사용법

이 프로젝트는 큰 파일(mp4, wav, ggml-base.bin)을 포함하므로 Git LFS를 사용합니다.

### 1️⃣ Git LFS 설치 (한 번만)
git lfs install

### 2️⃣ LFS로 관리할 파일 지정 (한 번만)
git lfs track "*.mp4"
git lfs track "*.wav"
git lfs track "ggml-base.bin"

### 3️⃣ 파일 커밋 & 푸시
파일을 추가하고 커밋한 후 푸시:
git add .
git commit -m "Add files via LFS"
git push origin main

⚠️ 주의: VS Code GUI에서 푸시하면 LFS 파일이 제대로 올라가지 않을 수 있으므로 터미널에서 직접 푸시 권장.
