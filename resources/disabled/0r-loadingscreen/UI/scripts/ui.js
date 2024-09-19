let galleryData = [];

let keyboardData = [];
let preferedSong = "https://www.youtube.com/watch?v=N-kGE-7oOws";
var Youtube = (function () {
  'use strict';

  var video, results;

var getThumb = function (url, size) {
      if (url === null) {
          return '';
      }
      size    = (size === null) ? 'big' : size;
      results = url.match('[\\?&]v=([^&#]*)');
      video   = (results === null) ? url : results[1];

      if (size === 'small') {
          return 'http://img.youtube.com/vi/' + video + '/2.jpg';
      }
      return 'http://img.youtube.com/vi/' + video + '/0.jpg';
  };

  return {
      thumb: getThumb
  };
}());

let rpvideoPlayer;

let rpvideoExpanded = false;
let galleryExpanded = false;
let animationOnHold = false;
let colormodeEnabled = false;

let videoacikamk = false 

let colors = [];

let currentSong = null;
let currentRPVideo = null;
let playerInterval = null;
let sliderSaveTimeout = null;
async function controlRPVideo(expand) {
  console.log("controlRPVideo", expand);
  if (animationOnHold) return;

  if (expand) {
    $(".rpvideo").children().css('fill', 'white')
    if (galleryExpanded) {
      $(".menu-box-hero-photo").trigger("click");
    }

    rpvideoExpanded = true;
    animationOnHold = true;
    videoacikamk = true;
    songPlayer.pauseVideo();
    $(".rpvideo-box").css({
      "height": "65vh",
      "width": "59vw",
      "position": "fixed",
      "top": "8%",
      "left": "-6%",
      // "transform": "translate(-50%, -50%)",
      "z-index": "100"
    });
    
    $(".rpvideo-box-text").css("display", "none");
    $(".rpvideo-box .menu-box-icon").css("display", "none");

    $(".rpvideo-thumbnail").addClass("rpvideo-thumbnail-expanding");

    setTimeout(() => {
      $(".rpvideo-thumbnail").css("display", "none");
      $("#rpvideoPlayer").removeClass("rpvideo-hidden");

      // rpvideoPlayer.playVideo();

      $(".rpvideo-thumbnail").removeClass("rpvideo-thumbnail-expanding");

      animationOnHold = false;
    }, 450);
  } else {
    console.log("alo")
    $(".rpvideo").children().css('fill', 'gray')
    songPlayer.playVideo();
    rpvideoExpanded = false;
    animationOnHold = true;
    videoacikamk = false;
    $(".rpvideo-thumbnail").removeAttr("style");

    $(".rpvideo-thumbnail").addClass("rpvideo-thumbnail-collapsing");

    $(".rpvideo-box-text").removeAttr("style");
    $(".rpvideo-box .menu-box-icon").removeAttr("style");

    $(".rpvideo-box").removeAttr("style");
    $(".interactive-menu").removeAttr("style");

    $("#rpvideoPlayer").addClass("rpvideo-hidden");

    setTimeout(() => {
      $(".rpvideo-thumbnail").removeClass("rpvideo-thumbnail-collapsing");
      animationOnHold = false;
    }, 650);
  }
}

let tag = document.createElement("script");
tag.src = "https://www.youtube.com/iframe_api";

let firstScriptTag = document.getElementsByTagName("script")[0];
firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

function onYouTubeIframeAPIReady() {
  rpvideoPlayer = new YT.Player("rpvideoPlayer", {
    videoId: getVideoId(currentRPVideo) || "K4DyBUG242c",
    width: "0.001",
    height: "0.001",
    playerVars: {
      playsinline: 0,
      color: "white",
      loop: 1,
    },
    events: {
      onReady: onPlayerReady,
      onStateChange: onPlayerStateChange,
    },
  });

  songPlayer = new YT.Player("songPlayer", {
    videoId: currentSong || getVideoId(preferedSong),
    width: "0.001",
    height: "0.001",
    playerVars: {
      playsinline: 0,
      color: "white",
      loop: 1,
    },
    events: {
      onReady: onSongPlayerReady,
      onStateChange: onSongPlayerStateChange,
    },
  });
}

function onSongPlayerReady() {
  if (currentSong) {
    songPlayer.loadVideoById(getVideoId(currentSong), 0);
    adjustPlayerVolume();
  } else {
    songPlayer.playVideo();
    adjustPlayerVolume();
  }
}

// function updateSlider(slider) {
//   const value = (slider.value - slider.min) / (slider.max - slider.min) * 100;
//   slider.style.background = `linear-gradient(to right, red 0%, red ${value}%, #161717 ${value}%, #161717 100%)`;
//   console.log("sesads")
// }

// document.addEventListener("DOMContentLoaded", function() {
//   const slider = document.getElementById("input_audiovolume");
//   updateSlider(slider); // Initialize the slider background on load
// });

function adjustPlayerVolume() {
  console.log("adjusting volume");
  const sliderValue = $("#input_audiovolume").val();
  console.log(sliderValue);

  songPlayer?.setVolume(sliderValue);

  window.localStorage.setItem("player-volume", sliderValue);
}

function setVideosMinute() {
  const currentTime = songPlayer.getCurrentTime();
  const songDuration = songPlayer.getDuration();
  const sliderValue = $("#input_minute").val();
  console.log(currentTime);
  console.log(songDuration);
  songPlayer.seekTo(sliderValue);
  // rpvideoPlayer.seekTo(sliderValue);
  console.log("setVideosMinute");
  console.log(currentTime)
  console.log(songDuration)
}

function toggleNewsMenu() {
  // Eğer haber menüsü 'flex' olarak ayarlandıysa
  if ($(".news-menu").css("display") === "flex") {
    // Düğmenin içindeki öğelerin rengini beyaza çevir
    $(".newsbutton").children().css('fill', 'white');
    // Haber menüsünü gizle
    $(".news-menuAna").css("display", "none");
    $(".news-menu").css("display", "none");
  } else {
    // Düğmenin içindeki öğelerin rengini griye çevir
    $(".newsbutton").children().css('fill', 'gray');
    // Haber menüsünü göster
    $(".news-menuAna").css("display", "flex");
    $(".news-menu").css("display", "flex");
  }
}

function onSongPlayerStateChange(event) {
  if (event.data == YT.PlayerState.PLAYING) {
    $("#music-control-pause").attr("src", "images/icons/pause.svg");
    // console.log(`YOUTUBEURL: `)
    const title = songPlayer?.getVideoData()?.title;
    const artist = songPlayer?.getVideoData()?.author;
    // console
    let thumb = Youtube.thumb(songPlayer.getVideoUrl(), 'small');
    console.log(`currentSong: ${songPlayer.getVideoUrl()}`);
    if (thumb === '') {
      thumb = 'https://cdn.discordapp.com/attachments/991119965342142514/1244005483736465428/sd.jpg?ex=665389e3&is=66523863&hm=df86e2014d3c1dc27100c23769e10643de2163ec113d905210117efc2c53ec73&';
    }
    console.log(`fotograf thumb: ${thumb}`);

    // Resmi seç
    console.log(title);
    console.log(artist);
    $("#orospudusfudsfusdufdsfds").html (`${title} <br> <span>${artist}</span>`);
                  // // <img class="fotograf" src="images/icons/example-song.png" />
                  // console.log(thumb);
    $("#orospucocugu").attr("src", thumb);

    playerInterval = setInterval(() => {
      const currentTime = songPlayer.getCurrentTime();
      const songDuration = songPlayer.getDuration();

      const donePlaying = (currentTime / songDuration) * 100;

      $("#music-timepassed").text(
        `${Math.floor(currentTime / 60)}:${(currentTime % 60)?.toFixed(0)}`
      );
      $("#music-timeremaining").text(
        `-${Math.floor(Math.abs(songDuration - currentTime) / 60)}:${(
          Math.abs(songDuration - currentTime) % 60
        )?.toFixed(0)}`
      );

      $(".music-progbar-fill").css("width", `${donePlaying}%`);
    }, 1000);
  } else if (event.data == YT.PlayerState.PAUSED) {
    $("#music-control-pause").attr("src", "images/icons/play.svg");
    clearInterval(playerInterval);
    playerInterval = null;
  }
}

function onPlayerReady() {
  $("#rpvideoPlayer").addClass("rpvideo-fullscreen").addClass("rpvideo-hidden");
}
function onPlayerStateChange(event) {
  if (event.data == YT.PlayerState.PAUSED) {
    controlRPVideo(false);
  }
}

function getGalleryImage(id) {
  let targetImage = null;
  for (let i = 0; i < galleryData.length; i++) {
    if (galleryData[i].id == id) targetImage = galleryData[i];
  }
  return targetImage;
}

function getKeyHelp(key) {
  let helpText = null;
  for (let i = 0; i < keyboardData.length; i++) {
    if (keyboardData[i].key == key) {
      helpText = keyboardData[i].helpText;
    }
  }

  return helpText;
}

async function wait(ms) {
  return new Promise((resolve) => {
    setTimeout(resolve, ms);
  });
}

$(document).ready(() => {

  $(".menu-box-photo").on("click", async function () {
    if (animationOnHold) return;

    if (rpvideoExpanded) {
      rpvideoPlayer.pauseVideo();
      controlRPVideo(false);
      await wait(700);
    }

    animationOnHold = true;

    const newImgLink = getGalleryImage($(this).attr("data-id")).image;
    const currentHeroImg = $(".menu-box-hero-photo").children("img");

    $(".interactive-menu").css("top", "7.5vh");
    $(".menu-box-hero-photo").css("display", "flex");

    if (currentHeroImg.length > 0) {
      currentHeroImg.attr("src", newImgLink).css("display", "none");

      currentHeroImg.css("display", "unset");

      animationOnHold = false;
    } else {
      $(".menu-box-hero-photo").append(`<img src="${newImgLink}" />`);

      setTimeout(() => {
        animationOnHold = false;
      }, 400);
    }

    galleryExpanded = true;
  });

  $(".menu-box-hero-photo").on("click", function (e) {
    $(".menu-box-hero-photo").children().remove();

    $(".menu-box-hero-photo").css("display", "none");

    $(".interactive-menu").removeAttr("style");

    galleryExpanded = false;
  });

  $(".keyboard-btn").on("click", function (e) {
    if ($(this).attr("not-clickable") !== undefined) return;

    const clickedKey =
      $(this).attr("key-id") ||
      ($(this).text().trim().length == 0 ? null : $(this).text());

    const helpText =
      getKeyHelp(clickedKey) ||
      "Unfortunately, there isn't any help available.";

    $(".keyboard-menu-help-key").children().remove();
    $(".keyboard-menu-help-key").text("");

    if ($(this).text().trim().length == 0 ? null : $(this).text()) {
      $(".keyboard-menu-help-key").text(clickedKey);
    } else {
      $(this).children().clone().appendTo(".keyboard-menu-help-key");
    }
    $(".keyboard-menu-help-description-text").text(helpText);
  });

  if (window.localStorage.getItem("player-volume")) {
    $("#input_audiovolume").val(window.localStorage.getItem("player-volume"));
    $("#input_audiovolume").css('background-size', window.localStorage.getItem("player-volume") + '% 100%');
  }

  // if (window.localStorage.getItem("background")) {
    const sliderValue = $("#input_minute").val();
    $("#input_minute").val("0");
    $("#input_minute").css('background-size', "0" + '% 100%');
    changeBackground(false);
  // }
});

function toggleMusicBox() {
  const shouldCollapse = $(".music-player-right-part").is(":visible");

  if (shouldCollapse) {
    $(".music-player-right-part").css("display", "none");
    $(".music-player").css({
      width: "unset",
      padding: "1vh",
      "flex-direction": "column",
    });
    $(".music-thumbnail img").css("height", "7vh");
    $(".new-update").css("width", "80%");
    $(".music-mini-progbar").css("display", "unset");

    $(".music-control-toggle").css("transform", "rotate(90deg)");
  } else {
    $(".music-player-right-part").removeAttr("style");
    $(".music-player").removeAttr("style");
    $(".music-thumbnail img").removeAttr("style");
    $(".new-update").removeAttr("style");
    $(".music-mini-progbar").removeAttr("style");

    $(".music-control-toggle").removeAttr("style");
  }
}

function sliderChanged(id, state) {
  switch (id) {
    case "darkmode":
      if (state) $(".container").attr("theme", "dark");
      else $(".container").attr("theme", "white");
      window.localStorage.setItem("darkmode", state);
      break;
    case "colormode":
      colormodeEnabled = state;
      colorInputChange();
      break;
  }
}

function sliderInputClick(e) {
  const isEnabled = $(e.currentTarget).attr("style");

  if (isEnabled) {
    $(e.currentTarget).removeAttr("style");
    sliderChanged($(e.currentTarget).attr("data-id"), false);
  } else {
    $(e.currentTarget).css("justify-content", "flex-end");
    sliderChanged($(e.currentTarget).attr("data-id"), true);
  }
}

function colorInputChange(event) {
  const color1 = `hsl(${$("#primary-color").val() * 3.6},100%,50%)`;
  const color2 = `hsl(${$("#secondary-color").val() * 3.6},100%,50%)`;

  colors = [$("#primary-color").val() * 3.6, $("#secondary-color").val() * 3.6];

  if (colormodeEnabled) {
    $(".theme-color").css(
      "background",
      `radial-gradient(circle at center, ${color1}, ${color2}, transparent 50%)`
    );
    $(".progressbar-filler").css(
      "background",
      `linear-gradient(90deg, ${color1}, ${color2})`
    );

    console.log(color1);
    $("#selamp").css(
      "color",
      `${color1}`
    );

    $("#input_audiovolume").css(
      "background",
      `${color1}`
    );
    $("#input_audiovolume").css(
      "color",
      `${color1}`
    );

    
    $("#input_minute").css(
      "background",
      `${color1}`
    );
    $("#input_minute").css(
      "color",
      `${color1}`
    );

    
    // $("#input_audiovolume").css(
    //   "border",
    //   `1px solid ${color1}`
    // );
  } else {
    $(".theme-color").removeAttr("style");
    $(".progressbar-filler").css("background", "white");
  }

  window.localStorage.setItem(
    "colormode",
    JSON.stringify({
      enabled: colormodeEnabled,
      colors: colors,
    })
  );
}

function toggleSettingsMenu() {
  if ($(".settings-menu").css("display") === "none") {
    $(".settingsbutton").children().css('fill', 'gray')
    $(".settings-menu").css("display", "block");
  } else {
    $(".settingsbutton").children().css('fill', 'white')
    $(".settings-menu").css("display", "none");
  }
}
 

function isURLValid(link) {
  let isValid = false;

  try {
    url = new URL(link);

    isValid = true;
  } catch {
    isValid = false;
  }

  return isValid;
}

async function isURLHeadedToAnImage(url) {
  return new Promise((resolve) => {
    $.get(url, function (data, success, dataType) {
      if (success) {
        const rawResponseHeaders = dataType
          ?.getAllResponseHeaders()
          ?.split("\n");
        let responseHeaders = {};

        rawResponseHeaders.forEach((rawResponseHead) => {
          rawResponseHead = rawResponseHead.split(":");
          responseHeaders[rawResponseHead[0]] = rawResponseHead[1]
            ?.replace("\r", "")
            ?.trim();
        });

        if (responseHeaders["content-type"]) {
          if (responseHeaders["content-type"].startsWith("image")) {
            resolve(true);
            return;
          }
        }
      }

      resolve(false);
    });
  });
}

async function changeBackground(shouldSave) {
  const url = $("#input_background").val()?.trim();

  if (isURLValid(url)) {
    const urllHeadedToAnImage = await isURLHeadedToAnImage(url);

    if (urllHeadedToAnImage)
      $(".wallpaper").css("background-image", `url(${url})`);

    if (shouldSave) window.localStorage.setItem("background", url);
  } else {
    if (!url) {
      $(".wallpaper").removeAttr("style");
      if (shouldSave) window.localStorage.removeItem("background");
    }

    $("#input_background").val("");
  }
}

function toggleKeyboardMenu() {
  // Eğer haber menüsü 'flex' olarak ayarlandıysa
  if ($(".keyboard-menu").css("display") === "none") {
    $(".keyboardbutton").children().css('fill', 'gray')
    $(".keyboard-menu").css("display", "block");
  } else {
    // Düğmenin içindeki öğelerin rengini griye çevir
    $(".newsbutton").children().css('fill', 'gray');
    // Haber menüsünü göster
    $(".keyboard-menu").css("display", "none");
  }
}


function toggleMusicState(event) {
  console.log("toggling music state");
  if (playerInterval) {
    songPlayer.pauseVideo();
    $(event.currentTarget).attr("src", "images/icons/play.svg");
    console.log("paused");
  } else {
    songPlayer.playVideo();
    adjustPlayerVolume();
    console.log("played");
    $(event.currentTarget).attr("src", "images/icons/pause.svg");
  }
}

function getVideoId(url) {
  var regExp =
    /^.*((youtu.be\/)|(v\/)|(\/u\/\w\/)|(embed\/)|(watch\?))\??v?=?([^#&?]*).*/;
  var match = url?.match(regExp);
  return match && match[7].length == 11 ? match[7] : false;
}

function changeSong(shouldSave) {
  const song = $("#input_song").val().trim();
  const youtubeRegEx = new RegExp(
    /^(?:https?:\/\/)?(?:m\.|www\.)?(?:youtu\.be\/|youtube\.com\/(?:embed\/|v\/|watch\?v=|shorts\/|watch\?.+&v=))((\w|-){11})(?:\S+)?$/
  );

  if (youtubeRegEx.test(song)) {
    songPlayer.loadVideoById(getVideoId(song), 0);

    if (shouldSave) window.localStorage.setItem("song", song);
  } else {
    if (!song) {
      songPlayer.loadVideoById(getVideoId(preferedSong), 0);
      if (shouldSave) window.localStorage.removeItem("song");
    }
  }
}

window.addEventListener("DOMContentLoaded", () => {
  let data = window.nuiHandoverData;


  $(document).ready(() => {
    if (data?.gallery) {
      newsData = data.gallery;
      let newsContent = "";  // Initialize an empty string to hold all news items

      for (let i = 0; i < newsData.length; i++) {
        const news = newsData[i];  // Correctly use newsData[i] instead of data.news[i]

        $(".news-menu-title").css('color', '#5E5E5E');
        $(this).parent().css('color', 'white');
        $(".news-menuAna").css('flex-direction', 'column');
        $(".news-menuAna").css('flex-wrap', 'unset');

        // Append each news item to the newsContent variable
        newsContent += `
          <div class="news">
            <div>
              <img class="newsFotograf" src="${news.image}" />
              <h2>${news.title}</h2>
              <p>${news.description}</p>
            </div>
          </div>
        `;
      }

      // Set the accumulated HTML content to .news-menuAna once after the loop
      $(".news-menuAna").html(newsContent);
    }


    $("#takim").click(function(){
      console.log("takim");
      console.log(JSON.stringify(data));
      if (data?.staffs) {
        staffData = data.staffs;
        let newsContent = "";  // Initialize an empty string to hold all news items

        for (let i = 0; i < staffData.length; i++) {
          const staff = staffData[i];  // Correctly use newsData[i] instead of data.news[i]

          $(".news-menu-title").css('color', '#5E5E5E');
          $(this).parent().css('color', 'white');
          $(".news-menuAna").css('flex-direction', 'row');
          $(".news-menuAna").css('flex-wrap', 'wrap');

          // Append each news item to the newsContent variable
          newsContent += `
          <div class="yetkili">
            <img src="${staff.avatar}">
            <p>${staff.username} <br> <span>${staff.role}</span></p>
          </div>
          `;
        }

        // Set the accumulated HTML content to .news-menuAna once after the loop
        $(".news-menuAna").html(newsContent);
      }
    });

    $("#news").click(function(){
      console.log("news");
      console.log(JSON.stringify(data));

      if (data?.gallery) {
        newsData = data.gallery;
        let newsContent = "";  // Initialize an empty string to hold all news items

        for (let i = 0; i < newsData.length; i++) {
          const news = newsData[i];  // Correctly use newsData[i] instead of data.news[i]

          $(".news-menu-title").css('color', '#5E5E5E');
          $(this).parent().css('color', 'white');
          $(".news-menuAna").css('flex-direction', 'column');
          $(".news-menuAna").css('flex-wrap', 'unset');

          // Append each news item to the newsContent variable
          newsContent += `
            <div class="news">
              <div>
                <img class="newsFotograf" src="${news.image}" />
                <h2>${news.title}</h2>
                <p>${news.description}</p>
              </div>
            </div>
          `;
        }

        // Set the accumulated HTML content to .news-menuAna once after the loop
        $(".news-menuAna").html(newsContent);
      }
    })
  
    
  $("#kurallar").click(function(){
    console.log("kurallar")
    console.log(JSON.stringify(data))
    if (data?.rules) {
      rulesData = data.rules;
      let newsContent = "";  // Initialize an empty string to hold all news items

      for (let i = 0; i < rulesData.length; i++) {
        const rule = rulesData[i];  // Correctly use newsData[i] instead of data.news[i]

        $(".news-menu-title").css('color', '#5E5E5E');
        $(this).parent().css('color', 'white');
        $(".news-menuAna").css('flex-direction', 'column');
        $(".news-menuAna").css('flex-wrap', 'unset');

        // Append each news item to the newsContent variable
        newsContent += `
          <div class="news">
            <div>
              <h2>${rule.title}</h2>
              <p>${rule.description}</p>
            </div>
          </div>
        `;
      }

      // Set the accumulated HTML content to .news-menuAna once after the loop
      $(".news-menuAna").html(newsContent);
    }
  });

    $("#gunbcellemeler").click(function() {
      console.log("gunbcellemeler");
      console.log(JSON.stringify(data));
      
      if (data?.update) {
        updateData = data.update;
        let newsContent = "";  // Initialize an empty string to hold all news items
  
        for (let i = 0; i < updateData.length; i++) {
          const update = updateData[i];  // Correctly use updateData[i] instead of data.update[i]
  
          $(".news-menu-title").css('color', '#5E5E5E');
          $(this).parent().css('color', 'white');
          $(".news-menuAna").css('flex-direction', 'column');
          $(".news-menuAna").css('flex-wrap', 'unset');
  
          // Append each news item to the newsContent variable
          newsContent += `
            <div class="news">
              <div>
                <img class="newsFotograf" src="${update.image}" />
                <h2>${update.title}</h2>
                <p>${update.description}</p>
              </div>
            </div>
          `;
        }
  
        // Set the accumulated HTML content to .news-menuAna once after the loop
        $(".news-menuAna").html(newsContent);
      }
    });
  });

  if (data?.keyboard) {
    keyboardData = data?.keyboard;

    for (let i = 0; i < keyboardData.length; i++) {
      const keyData = keyboardData[i];

      $(`.keyboard-btn`).each((_, btn) => {
        if (
          $(btn).text() == keyData.key ||
          $(btn).attr("key-id") == keyData.key
        ) {
          $(btn).css({
            background: "#8f8e8e",
            color: "black",
          });
        }
      });
    }
  }

  if (data?.player) {
    $("#player-id").text(data.player.id);
    $("#player_name").text(data.player.name);
    $(".character-photo").text(data?.player.name.slice(0, 1));
  }

  if (data?.defaultSong) {
    preferedSong = data.defaultSong;
  }

  let darkmode = window.localStorage.getItem("darkmode");
  if (darkmode != undefined && darkmode != null) {
    if (darkmode == "true") {
      $(".container").attr("theme", "dark");
      $("#darkmode-slider").css("justify-content", "flex-end");
    } else {
      $(".container").attr("theme", "white");
      $("#darkmode-slider").removeAttr("style");
    }
  } else {
    window.localStorage.setItem("darkmode", true);
  }

  let colormode = JSON.parse(window.localStorage.getItem("colormode"));
  if (colormode) {
    colormodeEnabled = colormode?.enabled || false;
    colors = colormode?.colors || [0, 0];

    if (colormodeEnabled) {
      $("#colormode-slider").css("justify-content", "flex-end");

      $(".theme-color").css(
        "background",
        `radial-gradient(circle at center, hsl(${colors[0]}, 100%, 50%), hsl(${colors[1]}, 100%, 50%), transparent 50%)`
      );

      $(".progressbar-filler").css(
        "background",
        `linear-gradient(90deg, hsl(${colors[0]}, 100%, 50%), hsl(${colors[1]}, 100%, 50%))`
      );
    } else {
      $("#colormode-slider").removeAttr("style");
      $(".theme-color").removeAttr("style");
      $(".progressbar-filler").css("background", "white");
    }

    $("#primary-color").val(colors[0] / 3.6);
    $("#secondary-color").val(colors[1] / 3.6);
  } else {
    window.localStorage.setItem(
      "colormode",
      JSON.stringify({
        enabled: false,
        colors: [0, 0],
      })
    );
  }

  let background = window.localStorage.getItem("background");
  if (background) {
    $("#input_background").val(background);
    changeBackground(false);
  }

  let song = window.localStorage.getItem("song");
  if (song) {
    $("#input_song").val(song);
    currentSong = song;
  }
});

window.addEventListener("message", function (e) {
  (handlers[e.data.eventName] || function () {})(e.data);
});

const handlers = {
  loadProgress(data) {
    $(".progressbar-filler").css("width", `${data.loadFraction * 100}%`);
  },
};

$(document).ready(function(){
  const rangeInputs = document.querySelectorAll('input[type="range"]')
const numberInput = document.querySelector('input[type="number"]')

function handleInputChange(e) {
  let target = e.target
  if (e.target.type !== 'range') {
    target = document.getElementById('range')
  } 
  const min = target.min
  const max = target.max
  const val = target.value
  let percentage = (val - min) * 100 / (max - min)
  
  // condition to check whether the document has RTL direction
  // you can move it to a variable, if document direction is dynamic
  if (document.documentElement.dir === 'rtl') {
    percentage = (max - val) 
  }
  
  target.style.backgroundSize = percentage + '% 100%'
}

rangeInputs.forEach(input => {
  input.addEventListener('input', handleInputChange)
})

numberInput.addEventListener('input', handleInputChange)

})

function prink() {
  console.log(rpvideoExpanded)
  if (videoacikamk) {
    controlRPVideo(false)
  } else {
    controlRPVideo(true)
  }
}