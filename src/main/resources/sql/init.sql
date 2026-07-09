-- =============================================
-- contact 테이블 (문의 폼 저장)
-- =============================================
CREATE TABLE IF NOT EXISTS contact (
    id        BIGINT AUTO_INCREMENT PRIMARY KEY,
    name      VARCHAR(50)  NOT NULL,
    email     VARCHAR(100) NOT NULL,
    phone     VARCHAR(20),
    title     VARCHAR(200) NOT NULL,
    message   TEXT         NOT NULL,
    createdAt DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =============================================
-- content 샘플 데이터
-- id: UUID(), type: ENUM 대문자, updatedAt 필수
-- =============================================
INSERT INTO content (id, type, title, body, isPublished, updatedAt) VALUES
(UUID(), 'SERVICE',        '동요 앨범 제작',           '아이들의 눈높이에 맞춘 창작 동요를 기획부터 작사·작곡·녹음까지 제작합니다.', 1, NOW()),
(UUID(), 'SERVICE',        '유아 음악 교육 콘텐츠',    '어린이집·유치원에서 활용할 수 있는 발달 단계별 음악 교육 콘텐츠를 제공합니다.', 1, NOW()),
(UUID(), 'SERVICE',        '캐릭터 음원 · 뮤직비디오 제작', '아이들이 좋아하는 캐릭터와 함께하는 동요 음원과 뮤직비디오를 제작합니다.', 1, NOW()),
(UUID(), 'WORK',           '아침 인사송',              '하루를 활기차게 시작하는 인사 동요. 어린이집 아침 활동 시간에 많이 활용됩니다.', 1, NOW()),
(UUID(), 'WORK',           '우리 가족 사랑해',         '가족의 소중함을 노래하는 감성 동요. 부모와 아이가 함께 부르기 좋은 곡입니다.', 1, NOW()),
(UUID(), 'WORK',           '동물 친구들 체조송',       '동물 흉내를 내며 몸을 움직이는 신나는 체조 동요.', 1, NOW());