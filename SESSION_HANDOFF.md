# Jigsaw Puzzle Session Handoff

## Current Project State

- Project path: `/Users/cheetar/work/jigsaw-puzzle2`
- Main app file: `index.html`
- Redirect file: `jigsaw-puzzle.html`
- This is now a 100-stage kids jigsaw puzzle app, not the earlier single-page demo.

## What Was Added

### Generated image assets in project root

- Existing base samples:
  - `zootopia-style-jigsaw-sample.png`
  - `toyroom-jigsaw-sample-1.png`
  - `toyroom-jigsaw-sample-2.png`
  - `winter-fairytale-jigsaw-sample-1.png`
  - `winter-fairytale-jigsaw-sample-2.png`

- New princess series:
  - `princess-fantasy-01.png` through `princess-fantasy-20.png`

- New emotion series:
  - `emotion-adventure-1.png` through `emotion-adventure-4.png`

- New space series:
  - `space-saga-1.png` through `space-saga-4.png`

## Code Changes Already Applied

### Image pool expanded

- `index.html` now includes all new assets in `IMAGE_POOL`.
- Added new families:
  - `princess`
  - `emotion`
  - `space`

Relevant area:
- `index.html` around `const IMAGE_POOL = [...]`

### World rotation updated

- `WORLD_DEFS.familyCycle` was updated so the 100 stages now rotate across:
  - `city`
  - `toy`
  - `winter`
  - `princess`
  - `emotion`
  - `space`

Relevant area:
- `index.html` around `const WORLD_DEFS = [...]`

### Theme mapping updated

- New families were mapped to existing body theme classes so UI styling still works.
- Mapping currently is:
  - `city -> theme-city`
  - `toy -> theme-toy`
  - `winter -> theme-winter`
  - `princess -> theme-winter`
  - `emotion -> theme-city`
  - `space -> theme-city`

Relevant area:
- `index.html` in `setThemeClass(family)`

### Audio mapping updated

- `AudioEngine.getThemeNotes()` now has note sets for:
  - `princess`
  - `emotion`
  - `space`

Relevant area:
- `index.html` in `AudioEngine.getThemeNotes(theme)`

### Home screen labels updated

- World names/descriptions were rewritten to better reflect the newly added image series.
- World tabs now show short labels such as:
  - `새싹 1`
  - `로열 2`
  - `게이트 10`
- Stage cards now show family labels:
  - `동물 도시`
  - `토이룸`
  - `겨울 동화`
  - `공주 판타지`
  - `감정 모험`
  - `우주 사가`

Relevant areas:
- `index.html` in `getFamilyLabel(family)`
- `index.html` in `renderWorldTabs()`
- `index.html` in `renderStageGrid()`

## Important Notes

- Browser validation was **not** run after the latest edits.
- There may be UX balancing issues because many new images were added but the stage/world progression logic still follows the original 100-stage structure.
- The app currently uses the new images in stage rotation; it does **not** yet expose a separate gallery/filter UI for manual image selection on the home screen.

## Suggested Next Steps

1. Run and verify the app in a browser.
2. Check that all stage thumbnails and puzzle loads work without broken image paths.
3. Review world naming and progression balance.
4. Optionally add:
   - family filter tabs on home
   - image gallery selection UI
   - dedicated worlds for princess/emotion/space
   - upload-your-own-image support in the current 100-stage app

## Recommended Resume Prompt

Use this in the new session:

```text
/Users/cheetar/work/jigsaw-puzzle2/SESSION_HANDOFF.md 파일부터 읽고 이어서 작업해줘.

프로젝트는 /Users/cheetar/work/jigsaw-puzzle2 이고 메인 파일은 index.html 이야.
이전 세션에서 princess/emotion/space 이미지 자산 28장을 추가했고, IMAGE_POOL/WORLD_DEFS/setThemeClass/getThemeNotes/renderWorldTabs/renderStageGrid 쪽 반영까지 끝난 상태야.

먼저 현재 index.html 구조를 확인하고, 브라우저 기준으로 깨질 수 있는 부분을 점검해줘.
그 다음 다음 작업을 진행해줘:
1. 새 이미지가 홈/게임 화면에서 정상 표시되는지 확인
2. 월드/스테이지 UX를 더 직관적으로 개선
3. 필요하면 공주/감정/우주 전용 월드 구성을 제안하고 바로 반영

작업 전 현재 상태를 짧게 요약하고, 필요한 수정은 직접 적용해줘.
```
