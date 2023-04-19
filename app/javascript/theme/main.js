(function ($) {
    "use strict";

    jQuery(document).ready(function ($) {

        /*-----------------------------------
            Nab (window remove class responsive)
        -----------------------------------*/
        if ($(window).width() < 992) {
            $(".mobile-style").removeClass("show");
        }

        /*-----------------------------------
            Search Suggestions js
        -----------------------------------*/
        $(document).on('keyup', '.keyup-input', function(event){
            var input_values = $(this).val();
            if(input_values.length > 0){
                $('.search-showHide').addClass('show');
            }else{
                $('.search-showHide').removeClass('show');
            }
        })
        // Removed Search Bar when closed icon Click
        $(document).on('click', '.closed-icon', function() {
            $('.search-showHide').removeClass("show")
        });

        /*-----------------------------------
            SideBar Menu
        -----------------------------------*/
        $('.sidebarBtn').on('click', function () {
            $('.showSidebar').slideToggle(300);
        });
        // MenuBtn click background color
        $('.sidebarBtn').on('click', function(){
            $(this).toggleClass('activeBg');
        })
        // Mobile Device Menu Responsive
        $(document).on('click', '.showSidebar .singleList', function() {
            $(this).siblings().removeClass('active');
            $(this).toggleClass('active');
        });

        /*-----------------------------------
            Custom Tab View
        -----------------------------------*/
        $('.customTab').on('click', function(evt) {
            evt.preventDefault();
            $(this).toggleClass('active');
            var sel = this.getAttribute('data-toggle-target');
            $('.customTab-content').removeClass('active').filter(sel).addClass('active');
        });

        /*-----------------------------------
           On Click Open Navbar right contents
        -----------------------------------*/
        $(document).on('click', '.click_show_icon', function() {
            $(".nav-right-content").toggleClass("active");
        });

        /*-----------------------------------
            Navbar Toggler Icon
        ------------------------------*/
        $(document).on('click', '.navbar-toggler', function() {
            $(this).toggleClass("active")
        });

        /*-----------------------------------
            Days active
        -----------------------------------*/
        $(".selectCategories li").click(function () {
            $(this).toggleClass('active').siblings().removeClass('active');
        });

        /*-----------------------------------
            Promo Setting
        -----------------------------------*/
        $('.singlePlan').click(function(){
            $(this).addClass('active');
            $(this).siblings().removeClass('active');
        })

        /*-----------------------------------
            Message active single
        -----------------------------------*/
        $('.singleUser').click(function(){
            $(this).addClass('active');
            $(this).siblings().removeClass('active');
        })

        /*-----------------------------------
            Chat popup
        -----------------------------------*/
        $('.chatBar').on('click', function () {
            $('.chatList-wrapper').slideToggle(300);
        });
         // chat click background color
        $('.chatBar').on('click', function(){
            $('.chat').toggleClass('activeBg');
        })

        /*-----------------------------------
            User Account
        -----------------------------------*/
        $('.userAccount').on('click', function () {
            $('.userAccount-wrapper').slideToggle(300);
        });

        /*-----------------------------------
        Popup Modal
        -----------------------------------*/
        $(document).on('click', '.close-icon, .body-overlay-desktop', function() {
            $('.modal-wrapper, .body-overlay-desktop').removeClass('active');
        });
        $(document).on('click', '.popup-modal', function() {
            $('.modal-wrapper, .body-overlay-desktop').addClass('active');
        });

        /*-----------------------------------
            WOW active
        -----------------------------------*/
        // new WOW().init();

        /*-----------------------------------
            Popup Modal
        -----------------------------------*/
        /* 6. Nice Selector */
        var nice_Select = $('.niceSelect');
        if(nice_Select.length){
            nice_Select.niceSelect();
        }

        /*-----------------------------------
            global slick slicer control
        -----------------------------------*/
        var globalSlickInit = $('.global-slick-init');
        if (globalSlickInit.length > 0) {

            //todo have to check slider item
            $.each(globalSlickInit, function (index, value) {
                if ($(this).children('div').length > 1) {

                    //todo configure slider settings object
                    var sliderSettings = {};
                    var allData = $(this).data();
                    var infinite = typeof allData.infinite == 'undefined' ? false : allData.infinite;
                    var arrows = typeof allData.arrows == 'undefined' ? false : allData.arrows;
                    var autoplay = typeof allData.autoplay == 'undefined' ? false : allData.autoplay;
                    var focusOnSelect = typeof allData.focusonselect == 'undefined' ? false : allData.focusonselect;
                    var swipeToSlide = typeof allData.swipetoslide == 'undefined' ? false : allData.swipetoslide;
                    var slidesToShow = typeof allData.slidestoshow == 'undefined' ? 1 : allData.slidestoshow;
                    var slidesToScroll = typeof allData.slidestoscroll == 'undefined' ? 1 : allData.slidestoscroll;
                    var speed = typeof allData.speed == 'undefined' ? '500' : allData.speed;
                    var dots = typeof allData.dots == 'undefined' ? false : allData.dots;
                    var cssEase = typeof allData.cssease == 'undefined' ? 'linear' : allData.cssease;
                    var prevArrow = typeof allData.prevarrow == 'undefined' ? '' : allData.prevarrow;
                    var nextArrow = typeof allData.nextarrow == 'undefined' ? '' : allData.nextarrow;
                    var centerMode = typeof allData.centermode == 'undefined' ? false : allData.centermode;
                    var centerPadding = typeof allData.centerpadding == 'undefined' ? false : allData.centerpadding;
                    var rows = typeof allData.rows == 'undefined' ? 1 : parseInt(allData.rows);
                    var autoplay = typeof allData.autoplay == 'undefined' ? false : allData.autoplay;
                    var autoplaySpeed = typeof allData.autoplayspeed == 'undefined' ? 2000 : parseInt(allData.autoplayspeed);
                    var lazyLoad = typeof allData.lazyload == 'undefined' ? false : allData.lazyload; // have to remove it from settings object if it undefined
                    var appendDots = typeof allData.appenddots == 'undefined' ? false : allData.appenddots;
                    var appendArrows = typeof allData.appendarrows == 'undefined' ? false : allData.appendarrows;
                    var asNavFor = typeof allData.asnavfor == 'undefined' ? false : allData.asnavfor;
                    var verticalSwiping = typeof allData.verticalswiping == 'undefined' ? false : allData.verticalswiping;
                    var vertical = typeof allData.vertical == 'undefined' ? false : allData.vertical;
                    var fade = typeof allData.fade == 'undefined' ? false : allData.fade;
                    var rtl = typeof allData.rtl == 'undefined' ? false : allData.rtl;
                    var responsive = typeof $(this).data('responsive') == 'undefined' ? false : $(this).data('responsive');

                    //slider settings object setup
                    sliderSettings.infinite = infinite;
                    sliderSettings.arrows = arrows;
                    sliderSettings.autoplay = autoplay;
                    sliderSettings.focusOnSelect = focusOnSelect;
                    sliderSettings.swipeToSlide = swipeToSlide;
                    sliderSettings.slidesToShow = slidesToShow;
                    sliderSettings.slidesToScroll = slidesToScroll;
                    sliderSettings.speed = speed;
                    sliderSettings.dots = dots;
                    sliderSettings.cssEase = cssEase;
                    sliderSettings.prevArrow = prevArrow;
                    sliderSettings.nextArrow = nextArrow;
                    sliderSettings.rows = rows;
                    sliderSettings.autoplaySpeed = autoplaySpeed;
                    sliderSettings.autoplay = autoplay;
                    sliderSettings.verticalSwiping = verticalSwiping;
                    sliderSettings.vertical = vertical;
                    sliderSettings.rtl = rtl;

                    if (centerMode != false) {
                        sliderSettings.centerMode = centerMode;
                    }
                    if (centerPadding != false) {
                        sliderSettings.centerPadding = centerPadding;
                    }
                    if (lazyLoad != false) {
                        sliderSettings.lazyLoad = lazyLoad;
                    }
                    if (appendDots != false) {
                        sliderSettings.appendDots = appendDots;
                    }
                    if (appendArrows != false) {
                        sliderSettings.appendArrows = appendArrows;
                    }
                    if (asNavFor != false) {
                        sliderSettings.asNavFor = asNavFor;
                    }
                    if (fade != false) {
                        sliderSettings.fade = fade;
                    }
                    if (responsive != false) {
                        sliderSettings.responsive = responsive;
                    }
                    $(this).slick(sliderSettings);
                }
            });
        }

        /*-----------------------------------
            MainSlider-1
        -----------------------------------*/
        function mainSlider() {
            var BasicSlider = $('.slider-active');
            BasicSlider.on('init', function (e, slick) {
            var $firstAnimatingElements = $('.single-slider:first-child').find('[data-animation]');
            doAnimations($firstAnimatingElements);
            });
            BasicSlider.on('beforeChange', function (e, slick, currentSlide, nextSlide) {
            var $animatingElements = $('.single-slider[data-slick-index="' + nextSlide + '"]').find('[data-animation]');
            doAnimations($animatingElements);
            });
            BasicSlider.slick({
            autoplay: true,
            autoplaySpeed: 3000,
            dots: false,
            fade: true,
            arrows: false,
            prevArrow: '<button type="button" class="slick-prev"><i class="ti-shift-left"></i></button>',
            nextArrow: '<button type="button" class="slick-next"><i class="ti-shift-right"></i></button>',
            responsive: [{
                breakpoint: 1024,
                settings: {
                    slidesToShow: 1,
                    slidesToScroll: 1,
                    infinite: true,
                }
                },
                {
                breakpoint: 991,
                settings: {
                    slidesToShow: 1,
                    slidesToScroll: 1,
                    arrows: false
                }
                },
                {
                breakpoint: 767,
                settings: {
                    slidesToShow: 1,
                    slidesToScroll: 1,
                    arrows: false
                }
                }
            ]
            });

            function doAnimations(elements) {
            var animationEndEvents = 'webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend';
            elements.each(function () {
                var $this = $(this);
                var $animationDelay = $this.data('delay');
                var $animationType = 'animated ' + $this.data('animation');
                $this.css({
                'animation-delay': $animationDelay,
                '-webkit-animation-delay': $animationDelay
                });
                $this.addClass($animationType).one(animationEndEvents, function () {
                $this.removeClass($animationType);
                });
            });
            }
        }
        mainSlider();
        /*-----------------------------------
            Mouse Cursor
        -----------------------------------*/
        var myCursor = $('.mouseCursor');
        if (myCursor.length) {
            if ($('body')) {
                const e = document.querySelector('.cursorInner'),
                    t = document.querySelector('.cursorOuter');
                let n, i = 0,
                    o = !1;
                window.onmousemove = function (s) {
                    o || (t.style.transform = "translate(" + s.clientX + "px, " + s.clientY + "px)"), e.style.transform = "translate(" + s.clientX + "px, " + s.clientY + "px)", n = s.clientY, i = s.clientX
                }, $('body').on("mouseenter", "a, .cursor-pointer", function () {
                    e.classList.add('cursor-hover'), t.classList.add('cursor-hover')
                }), $('body').on("mouseleave", "a, .cursor-pointer", function () {
                    $(this).is("a") && $(this).closest(".cursor-pointer").length || (e.classList.remove('cursor-hover'), t.classList.remove('cursor-hover'))
                }), e.style.visibility = "visible", t.style.visibility = "visible"
            }
        }

        /*-----------------------------------
            Datepicker
        -----------------------------------*/
        $('#datepicker1').datepicker();
        $('#datepicker2').datepicker();

        /*-----------------------------------
            Telephone country selector
        -----------------------------------*/
        if(document.getElementById('phone') != null){

            var input = document.querySelector("#phone");
            window.intlTelInput(input, { });

        }

        //18. Active Odometer Counter
        $('.odometer').appear(function (e) {
            var odo = jQuery(".odometer");
            odo.each(function () {
            var countNumber = jQuery(this).attr("data-count");
            jQuery(this).html(countNumber);
            });
        });

    });

    $(window).on('load', function () {
        /*------------------------------
            Preloader
        -------------------------------*/
        $('.preloader-inner').fadeOut(1000);
    });


}(jQuery));


