var RatingPaws = {
    pos: ["first", "second", "third", "fourth", "fifth", "sixth"],
    //categories include ratings in "rate your dog" and "feedback"
    categories: ["breeder-label", "simpatico-label", "health-label", "train-label", "social-label", "energy-label", "behavior-label", "rateyourdog-label","findratingbreed-label","findratingbreeder-label","searchbreeder-label", "forum-label"],
    unselectedColor: "#bbb",
    selectedColor: "#3399FF",
    naColor: "#ff3333",
    setupCategory: function(label) {
        for (var i = 0; i < RatingPaws.pos.length; i++) {
            $('#'+label).val("N/A");
            $("#" + label + "-sixth").css("color", RatingPaws.naColor);
            // $("#"+label+"-"+RatingPaws.pos[i]).on(
            //     "mouseover", RatingPaws.changeColors(label, RatingPaws.pos[i])
            // );
            // $("#"+label+"-"+RatingPaws.pos[i]).on(
            //     "mouseout", RatingPaws.revertColors(label, RatingPaws.pos[i])
            // );
            // $("#"+label+"-"+RatingPaws.pos[i]).on(
            //     "click", RatingPaws.setValue(label, RatingPaws.pos[i])
            // );
            
            $("#"+label+"-"+RatingPaws.pos[i]).on({
                mouseover: RatingPaws.changeColors(label, RatingPaws.pos[i]),
                mouseout: RatingPaws.revertColors(label, RatingPaws.pos[i]),
                click: RatingPaws.setValue(label, RatingPaws.pos[i])
            });
        }
    },
    setValue: function(label, loc) {
        return function() {
            var val = RatingPaws.pos.indexOf(loc);
            //console.log(val);
            if (val == 5) {
                $('#'+label).val("N/A");
                $("#" + label + "-sixth").css("color", RatingPaws.naColor);
            } else {
                $('#'+label).val(RatingPaws.pos.indexOf(loc) + 1);
                RatingPaws.changeColors(label, loc, RatingPaws.selectedColor, true)();
            }
        }
    }, 
    setUnselectColor: function(label, i) {
        for (; i < RatingPaws.pos.length; i++) {
            $("#" + label + "-" + RatingPaws.pos[i]).css("color", RatingPaws.unselectedColor);
        }
    },
    changeColors: function(label, loc) {
        return function() {
            // var current_val = Number.parseInt($("#" + label).val());
            // var loc_val = RatingPaws.pos.indexOf(loc);
            if (loc == "sixth") {
                for (var i = 0; i < 5; i++) {
                    $("#" + label + "-" + RatingPaws.pos[i]).css("color", RatingPaws.unselectedColor);
                }
                $("#" + label + "-sixth").css("color", RatingPaws.naColor);
            } else {
                for (var i = 0; RatingPaws.pos.indexOf(loc) >= i; i++) {
                    $("#" + label + "-" + RatingPaws.pos[i]).css("color", RatingPaws.selectedColor);
                }
                // for (; i < RatingPaws.pos.length; i++) {
                //     $("#" + label + "-" + RatingPaws.pos[i]).css("color", RatingPaws.unselectedColor);
                // }
                RatingPaws.setUnselectColor(label, i);
            }
        };
    },
    revertColors: function(label, loc) {
        return function() {
            if ($("#" + label).val() == "N/A") {
                for (i = 0; i < 5; i++) {
                    $("#" + label + "-" + RatingPaws.pos[i]).css("color", RatingPaws.unselectedColor);
                }
                $("#" + label + "-sixth").css("color", RatingPaws.naColor);
            } else {
                var current_val = Number.parseInt($("#" + label).val());
                for (var i = 0; current_val > i; i++) {
                    $("#" + label + "-" + RatingPaws.pos[i]).css("color", RatingPaws.selectedColor);
                }
                // for (; i < RatingPaws.pos.length; i++) {
                //     $("#" + label + "-" + RatingPaws.pos[i]).css("color", RatingPaws.unselectedColor);
                // }
                RatingPaws.setUnselectColor(label, i);
            }
        };
    },
    setup: function() {
        for (var i = 0; i < RatingPaws.categories.length; i++) {
            RatingPaws.setupCategory(RatingPaws.categories[i]);
        }
    },
    // Iter3-2 (Gilbert Lo, Jeff Yu)
    preRate: function() {
        var pathArray = window.location.pathname.substring(1).split('/');
        if (pathArray.length == 3 && pathArray[2] === 'edit') {
            var pupId = parseInt(pathArray[1]);
            $.ajax({
                type: 'GET',
                url: '/pups/ratings',
                data: {
                    "pup_id": pupId
                },
                contentType: 'application/json',
                dataType: 'json',
                timeout: 5000,
                success: function(data) {
                    for (var key in data) {
                        if (data[key] > 0) {
                            var id =  "#" + key + "-label-" + RatingPaws.pos[data[key] - 1];
                            $(id).click();
                        }
                    }
                },
                error: function() {
                    console.log("fail to get hashtag");
                }
            })
        }
    }
    // End Iter3-2
}

// $(document).ready(RatingPaws.setup);
$(document).ready(function () {
    $(RatingPaws.setup);
    RatingPaws.preRate();
});

