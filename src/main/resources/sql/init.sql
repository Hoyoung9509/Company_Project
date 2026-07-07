-- =============================================
-- contact 테이블 (문의 폼 저장)
-- =============================================
CREATE TABLE IF NOT EXISTS contact (
    id        BIGINT AUTO_INCREMENT PRIMARY KEY,
    name      VARCHAR(50)  NOT NULL,
    email     VARCHAR(100) NOT NULL,
    phone     VARCHAR(20),
    message   TEXT         NOT NULL,
    createdAt DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =============================================
-- content 샘플 데이터
-- id: UUID(), type: ENUM 대문자, updatedAt 필수
-- =============================================
INSERT INTO content (id, type, title, body, isPublished, updatedAt) VALUES
(UUID(), 'SERVICE',        '경영 컨설팅',              '기업의 전략 수립부터 실행까지 전문 컨설팅을 제공합니다.',        1, NOW()),
(UUID(), 'SERVICE',        'IT 솔루션',                '최신 기술 기반의 맞춤형 IT 솔루션을 제공합니다.',              1, NOW()),
(UUID(), 'SERVICE',        '디지털 전환',              '비즈니스의 디지털 전환을 체계적으로 지원합니다.',              1, NOW()),
(UUID(), 'CAREER',         '백엔드 개발자 (신입/경력)', 'Java/Spring Boot 기반 백엔드 개발자를 모집합니다.',           1, NOW()),
(UUID(), 'CAREER',         '프론트엔드 개발자',        'React/Vue.js 경험자 우대. 사용자 친화적인 UI 개발을 담당합니다.', 1, NOW()),
(UUID(), 'NOTICE_PUBLIC',  '신규 서비스 론칭',         '고객 여러분의 성원에 힘입어 새로운 서비스를 선보입니다.',        1, NOW()),
(UUID(), 'NOTICE_PUBLIC',  '창립 기념 이벤트 안내',    '창립 기념을 맞이하여 다양한 이벤트를 준비했습니다.',            1, NOW());