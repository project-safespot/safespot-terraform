# safespot-terraform

SafeSpot 팀 프로젝트 Terraform 레포지토리입니다.

## 구조
- `environments/dev/{domain}` : 실행 단위 (terraform init/plan/apply 위치)
- `modules/{domain}/{resource}` : 재사용 가능한 모듈

## Apply 순서
도메인 간 의존성이 있으므로 반드시 아래 순서를 지켜야 합니다.

network → data → compute → edge → messaging → application → cicd → observability

## 규칙
- 변수명은 snake_case 사용
- main 브랜치 직접 push 금지, PR로만 반영
- PR 승인 1명 이상 필요
- 담당 도메인 외 변경 시 CODEOWNERS 리뷰 필요

## 담당자
| 도메인 | 담당자 |
|---|---|
| network | jaeyoung, sohyun |
| data | danu, minjung |
| compute | minjung, seohyun |
| messaging | seohyun, minjung |
| edge | jaeyoung, seohyun |
| observability | sohyun |
| cicd | sohyun |