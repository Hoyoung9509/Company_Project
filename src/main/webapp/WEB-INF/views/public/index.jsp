<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${companyName} - 아이들의 마음에 노래를 선물합니다</title>
    <link rel="stylesheet" href="/resources/css/style.css?v=37">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css">
</head>
<body>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<% if (_loginUser != null && "ADMIN".equals(_loginUser.getRole())) { %>
<a href="/admin/content/new?type=SERVICE&redirectTo=/" class="fab-add" title="서비스 등록">+</a>
<% } %>

<section class="home-gradient-band">
<canvas id="noteCanvas" class="home-hero-canvas"></canvas>

<div class="home-hero">
    <div class="home-hero-inner">
        <div class="home-hero-text">
            <h1>${companyName}</h1>
            <p>아이들의 마음에 노래를 선물합니다</p>
            <span class="home-hero-mascot-wrap">
                <img src="/resources/images/mascot.png" alt="JuniMusic 시그니처 캐릭터" class="home-hero-mascot">
            </span>
        </div>
    </div>
</div>

<c:if test="${not empty workList}">
<section class="home-showcase">
    <div class="home-showcase-panel">
        <h2>영상으로 만나보는<br>JuniMusic 작품들</h2>
        <p>JuniMusic의 사운드 콘텐츠로<br>완성된 동요와 영상을 지금 만나보세요</p>
        <a href="/works" class="btn-hero-secondary home-showcase-link">전체 작업물 보기</a>
    </div>
    <div class="home-showcase-slider">
        <div class="home-showcase-backdrop"></div>
        <div class="swiper home-showcase-swiper">
            <div class="swiper-wrapper">
                <c:forEach var="item" items="${workList}">
                    <c:choose>
                        <c:when test="${not empty item.youtubeId}">
                            <c:set var="thumbStyle" value="background-image:url('https://img.youtube.com/vi/${item.youtubeId}/mqdefault.jpg');"/>
                            <c:set var="maxresUrl" value="https://img.youtube.com/vi/${item.youtubeId}/maxresdefault.jpg"/>
                        </c:when>
                        <c:otherwise>
                            <c:set var="thumbStyle" value=""/>
                            <c:set var="maxresUrl" value=""/>
                        </c:otherwise>
                    </c:choose>
                    <div class="swiper-slide">
                        <a href="/works/${item.id}" class="home-showcase-slide" style="${thumbStyle}" data-maxres="${maxresUrl}">
                            <div class="home-showcase-overlay">
                                <c:if test="${not empty item.workCategoryName}">
                                    <span class="badge">${item.workCategoryName}</span>
                                </c:if>
                                <h3>${item.title}</h3>
                            </div>
                        </a>
                    </div>
                </c:forEach>
            </div>
            <div class="home-showcase-counter">
                <span class="current">01</span>
                <span class="counter-line"></span>
                <span class="total">01</span>
            </div>
        </div>
    </div>
</section>
</c:if>

<div class="section">
    <div class="home-services-head">
        <h2>서비스 소개</h2>
        <p>JuniMusic이 제공하는 맞춤형 동요 제작 서비스</p>
    </div>
    <c:choose>
        <c:when test="${empty contentList}">
            <p class="empty-msg">등록된 서비스가 없습니다.</p>
        </c:when>
        <c:otherwise>
            <div class="home-service-grid">
                <c:forEach var="item" items="${contentList}">
                    <div class="home-service-card">
                        <h3>${item.title}</h3>
                        <p>${item.body}</p>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<c:if test="${not empty processSteps}">
<section class="process-band">
    <div class="process-band-head">
        <h2>제작과정</h2>
        <p>JuniMusic의 체계적인 동요 제작 프로세스</p>
    </div>
    <div class="process-steps">
        <c:forEach var="s" items="${processSteps}" varStatus="loop">
            <div class="process-step">
                <span class="process-step-index"><c:if test="${loop.index < 9}">0</c:if>${loop.index + 1}</span>
                <h3>${s.title}</h3>
                <p>${s.description}</p>
            </div>
            <c:if test="${not loop.last}">
                <span class="process-arrow">&#8594;</span>
            </c:if>
        </c:forEach>
    </div>
</section>
</c:if>

<c:if test="${not empty staffList}">
<div class="section">
    <h2>우리 팀</h2>
    <div class="home-team-strip">
        <c:forEach var="p" items="${staffList}" begin="0" end="3">
            <a href="/team/${p.id}" class="home-team-item">
                <c:choose>
                    <c:when test="${not empty p.photoUrl}">
                        <div class="home-team-photo" style="background-image:url('${p.photoUrl}');"></div>
                    </c:when>
                    <c:otherwise>
                        <div class="home-team-photo"></div>
                    </c:otherwise>
                </c:choose>
                <p class="home-team-name">${p.name}</p>
                <p class="home-team-position">${p.position}</p>
            </a>
        </c:forEach>
    </div>
    <div class="home-team-more">
        <a href="/team" class="btn-secondary">팀 전체 보기</a>
    </div>
</div>
</c:if>

<div class="home-cta-band">
    <h2>동요 제작이 필요하신가요?</h2>
    <p>기획부터 작곡, 녹음, 뮤직비디오까지 JuniMusic이 함께합니다</p>
    <a href="/contact" class="btn-hero-primary">문의하기</a>
</div>

</section>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
<script>
(function () {
    var swiperEl = document.querySelector('.home-showcase-swiper');
    if (!swiperEl || !window.Swiper) return;

    var slideCount = swiperEl.querySelectorAll('.swiper-slide').length;
    var totalEl = document.querySelector('.home-showcase-counter .total');
    var currentEl = document.querySelector('.home-showcase-counter .current');
    var backdropEl = document.querySelector('.home-showcase-backdrop');
    if (totalEl) totalEl.textContent = String(slideCount).padStart(2, '0');

    function syncBackdrop(swiper) {
        if (!backdropEl) return;
        var activeSlide = swiper.slides[swiper.activeIndex];
        var thumb = activeSlide && activeSlide.querySelector('.home-showcase-slide');
        backdropEl.style.backgroundImage = thumb ? thumb.style.backgroundImage : '';
    }

    var homeShowcaseSwiper = new Swiper('.home-showcase-swiper', {
        effect: 'fade',
        fadeEffect: { crossFade: true },
        speed: 700,
        rewind: true,
        autoplay: { delay: 2000, disableOnInteraction: false, pauseOnMouseEnter: true },
        on: {
            slideChange: function () {
                if (currentEl) currentEl.textContent = String(this.realIndex + 1).padStart(2, '0');
                syncBackdrop(this);
            }
        }
    });
    syncBackdrop(homeShowcaseSwiper);

    // mqdefault above is always available; opportunistically upgrade each slide to the
    // sharper maxresdefault where YouTube has one, silently keeping mqdefault otherwise.
    swiperEl.querySelectorAll('.home-showcase-slide[data-maxres]').forEach(function (slide) {
        var maxresUrl = slide.getAttribute('data-maxres');
        if (!maxresUrl) return;
        var probe = new Image();
        probe.onload = function () {
            // missing maxresdefault sometimes resolves to a small grey placeholder instead of a 404
            if (probe.naturalWidth <= 120) return;
            slide.style.backgroundImage = "url('" + maxresUrl + "')";
            syncBackdrop(homeShowcaseSwiper);
        };
        probe.src = maxresUrl;
    });
})();

(function () {
    var canvas = document.getElementById('noteCanvas');
    if (!canvas) return;
    var band = canvas.parentElement;
    var ctx = canvas.getContext('2d');
    var notes = [];
    var symbols = ['♪', '♫', '♬', '♩'];
    var NOTE_COUNT = 48;

    function resize() {
        canvas.width = band.offsetWidth;
        canvas.height = band.offsetHeight;
    }

    function createNote() {
        return {
            x: Math.random() * canvas.width,
            y: canvas.height + 20,
            size: 14 + Math.random() * 18,
            speed: 0.4 + Math.random() * 0.8,
            drift: (Math.random() - 0.5) * 0.6,
            symbol: symbols[Math.floor(Math.random() * symbols.length)],
            opacity: 0.15 + Math.random() * 0.25
        };
    }

    function seedNotes() {
        notes = [];
        for (var i = 0; i < NOTE_COUNT; i++) {
            var n = createNote();
            n.y = Math.random() * canvas.height;
            notes.push(n);
        }
    }

    function animate() {
        ctx.clearRect(0, 0, canvas.width, canvas.height);
        notes.forEach(function (n) {
            n.y -= n.speed;
            n.x += n.drift;
            if (n.y < -20) {
                Object.assign(n, createNote());
            }
            ctx.font = n.size + 'px sans-serif';
            ctx.fillStyle = 'rgba(255,255,255,' + n.opacity + ')';
            ctx.fillText(n.symbol, n.x, n.y);
        });
        requestAnimationFrame(animate);
    }

    resize();
    seedNotes();
    animate();

    // re-measure whenever the band's real content height settles (images, fonts, Swiper)
    if (window.ResizeObserver) {
        var lastHeight = canvas.height;
        new ResizeObserver(function () {
            resize();
            if (Math.abs(canvas.height - lastHeight) > 40) {
                lastHeight = canvas.height;
                seedNotes();
            }
        }).observe(band);
    } else {
        window.addEventListener('resize', resize);
        window.addEventListener('load', function () {
            resize();
            seedNotes();
        });
    }
})();
</script>

</body>
</html>
