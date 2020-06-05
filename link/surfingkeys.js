mapkey("p", "Open the clipboard's URL in the current tab", function () {
  Front.getContentFromClipboard(function (response) {
    window.location.href = response.data;
  });
});
map("P", "cc");
map("gi", "i");
map("F", "gf");
map("gf", "w");
map("`", "'");
// save default key `t` to temp key `>_t`
map(">_t", "t");
// create a new key `t` for default key `on`
map("t", "on");
// create a new key `o` for saved temp key `>_t`
map("o", ">_t");
map("H", "S");
map("L", "D");
map("gt", "R");
map("gT", "E");
map("K", "R");
map("J", "E");
Hints.style(
  "border: solid 2px #4C566A; color:#A3BE8C; background: initial; background-color: #3B4252;"
);
Hints.style(
  "border: solid 2px #4C566A !important; padding: 1px !important; color: #E5E9F0 !important; background: #3B4252 !important;",
  "text"
);
Visual.style("marks", "background-color: #A3BE8C99;");
Visual.style("cursor", "background-color: #88C0D0;");
settings.theme = `
:root {
  --font: 'Jetbrains Mono', Ubuntu, sans;
  --font-size: 12;
  --font-weight: bold;
  --fg: #E5E9F0;
  --bg: #3B4252;
  --bg-dark: #2E3440;
  --border: #4C566A;
  --main-fg: #88C0D0;
  --accent-fg: #A3BE8C;
  --info-fg: #5E81AC;
  --select: #4C566A;
};

/* ---------- Generic ---------- */

.sk_theme {
background: var(--bg);
color: var(--fg);
  background-color: var(--bg);
  border-color: var(--border);
  font-family: var(--font);
  font-size: var(--font-size);
  font-weight: var(--font-weight);
}
input {
  font-family: var(--font);
  font-weight: var(--font-weight);
}
.sk_theme tbody {
  color: var(--fg);
}
.sk_theme input {
  color: var(--fg);
}
/* Hints */
#sk_hints .begin {
  color: var(--accent-fg) !important;
}
#sk_tabs .sk_tab {
  background: var(--bg-dark);
  border: 1px solid var(--border);
  color: var(--fg);
}
#sk_tabs .sk_tab_hint {
  background: var(--bg);
  border: 1px solid var(--border);
  color: var(--accent-fg);
}
.sk_theme #sk_frame {
  background: var(--bg);
  opacity: 0.2;
  color: var(--accent-fg);
}
/* ---------- Omnibar ---------- */
/* Uncomment this and use settings.omnibarPosition = 'bottom' for Pentadactyl/Tridactyl style bottom bar */
/* .sk_theme#sk_omnibar {
  width: 100%;
  left: 0;
} */
.sk_theme {
  background: var(--bg-dark);
}
.sk_theme li,
 {
  background: var(--bg-dark);
}
.sk_theme .title {
  color: var(--accent-fg);
}
.sk_theme .url {
  color: var(--main-fg);
}
.sk_theme .annotation {
  color: var(--accent-fg);
}
.sk_theme .omnibar_highlight {
  color: var(--accent-fg);
}
.sk_theme .omnibar_timestamp {
  color: var(--info-fg);
}
.sk_theme .omnibar_visitcount {
  color: var(--accent-fg);
}
.sk_theme #sk_omnibarSearchResult > ul > li:nth-child(2n+1){
  background: var(--bg-dark) !important;
}
.sk_theme #sk_omnibarSearchResult > ul > li {
  background: var(--bg-dark) !important;
}
.sk_theme  #omnibarSearchResult>ul>li:nth-child(odd) {
  background: var(--bg-dark) !important;
}
.sk_theme #sk_omnibarSearchResult ul li.focused {
  background: var(--bg-dark);
}
.sk_theme #sk_omnibarSearchArea {
  border-top-color: var(--border);
  border-bottom-color: var(--border);
}
.sk_theme #sk_omnibarSearchArea input,
.sk_theme #sk_omnibarSearchArea span {
  font-size: var(--font-size);
}
.sk_theme .separator {
  color: var(--accent-fg);
}
/* ---------- Popup Notification Banner ---------- */
#sk_banner {
  font-family: var(--font);
  font-size: var(--font-size);
  font-weight: var(--font-weight);
  background: var(--bg);
  border-color: var(--border);
  color: var(--fg);
  opacity: 0.9;
}
/* ---------- Popup Keys ---------- */
#sk_keystroke {
  background-color: var(--bg);
}
.sk_theme kbd .candidates {
  color: var(--info-fg);
}
.sk_theme span.annotation {
  color: var(--accent-fg);
}
/* ---------- Popup Translation Bubble ---------- */
#sk_bubble {
  background-color: var(--bg) !important;
  color: var(--fg) !important;
  border-color: var(--border) !important;
}
#sk_bubble * {
  color: var(--fg) !important;
}
#sk_bubble div.sk_arrow div:nth-of-type(1) {
  border-top-color: var(--border) !important;
  border-bottom-color: var(--border) !important;
}
#sk_bubble div.sk_arrow div:nth-of-type(2) {
  border-top-color: var(--bg) !important;
  border-bottom-color: var(--bg) !important;
}
/* ---------- Search ---------- */
#sk_status,
#sk_find {
  font-size: var(--font-size);
  border-color: var(--border);
}
.sk_theme kbd {
  background: var(--bg-dark);
  border-color: var(--border);
  box-shadow: none;
  color: var(--fg);
}
.sk_theme .feature_name span {
  color: var(--main-fg);
}
/* ---------- ACE Editor ---------- */
#sk_editor {
  background: var(--bg-dark) !important;
  height: 50% !important;
  /* Remove this to restore the default editor size */
}
.ace_dialog-bottom {
  border-top: 1px solid var(--bg) !important;
}
.ace-chrome .ace_print-margin,
.ace_gutter,
.ace_gutter-cell,
.ace_dialog {
  background: var(--bg) !important;
}
.ace-chrome {
  color: var(--fg) !important;
}
.ace_gutter,
.ace_dialog {
  color: var(--fg) !important;
}
.ace_cursor {
  color: var(--fg) !important;
}
.normal-mode .ace_cursor {
  background-color: var(--fg) !important;
  border: var(--fg) !important;
  opacity: 0.7 !important;
}
.ace_marker-layer .ace_selection {
  background: var(--select) !important;
}
.ace_editor,
.ace_dialog span,
.ace_dialog input {
  font-family: var(--font);
  font-size: var(--font-size);
  font-weight: var(--font-weight);
}
`;

const rmSearchAliases = {
  s: ["g", "d", "b", "w", "s", "h"],
};

Object.keys(rmSearchAliases).forEach((k) => {
  rmSearchAliases[k].forEach((v) => {
    removeSearchAliasX(v, k);
  });
});

// ---- Settings ----//
settings.hintAlign = "left";
settings.omnibarSuggestionTimeout = 500;
settings.richHintsForKeystroke = 1;
settings.scrollStepSize = 140;

// ---- Functions ----//

const vimEditURL = () =>
  Front.showEditor(
    window.location.href,
    (data) => {
      window.location.href = data;
    },
    "url"
  );

const domainDossier = "http://centralops.net/co/DomainDossier.aspx";

const whois = () =>
  tabOpenLink(
    `${domainDossier}?dom_whois=true&addr=${window.location.hostname}`
  );

const dns = () =>
  tabOpenLink(`${domainDossier}?dom_dns=true&addr=${window.location.hostname}`);

const dnsVerbose = () =>
  tabOpenLink(
    `${domainDossier}?dom_whois=true&dom_dns=true&traceroute=true&net_whois=true&svc_scan=true&addr=${window.location.hostname}`
  );

const togglePdfViewer = () =>
  chrome.storage.local.get("noPdfViewer", (resp) => {
    if (!resp.noPdfViewer) {
      chrome.storage.local.set(
        {
          noPdfViewer: 1,
        },
        () => {
          Front.showBanner("PDF viewer disabled.");
        }
      );
    } else {
      chrome.storage.local.remove("noPdfViewer", () => {
        Front.showBanner("PDF viewer enabled.");
      });
    }
  });

const getURLPath = (count, domain) => {
  let path = window.location.pathname.slice(1);
  if (count) {
    path = path.split("/").slice(0, count).join("/");
  }
  if (domain) {
    path = `${window.location.hostname}/${path}`;
  }
  return path;
};

const copyURLPath = (count, domain) => () =>
  Clipboard.write(getURLPath(count, domain));

const editSettings = () => tabOpenLink("/pages/options.html");

const Hint = (selector, action = Hints.dispatchMouseClick) => () =>
  Hints.create(selector, action);

// ---- Mapkeys ----//
const ri = {
  repeatIgnore: true,
};

// --- Global mappings ---//
//  0: Help
//  1: Mouse Click
//  2: Scroll Page / Element
//  3: Tabs
//  4: Page Navigation
mapkey("gi", "#4Edit current URL with vim editor", vimEditURL, ri);
mapkey(
  "gI",
  "#4View image in new tab",
  Hint("img", (i) => tabOpenLink(i.src)),
  ri
);
//  5: Sessions
//  6: Search selected with
//  7: Clipboard
mapkey("yp", "#7Copy URL path of current page", copyURLPath(), ri);
mapkey(
  "yI",
  "#7Copy Image URL",
  Hint("img", (i) => Clipboard.write(i.src)),
  ri
);
//  8: Omnibar
//  9: Visual Mode
// 10: vim-like marks
// 11: Settings
mapkey(";se", "#11Edit Settings", editSettings, ri);
// 12: Chrome URLs
mapkey("gS", "#12Open Firefox settings", () =>
  tabOpenLink("about:preferences")
);
// 13: Proxy
// 14: Misc
mapkey("=w", "#14Lookup whois information for domain", whois, ri);
mapkey("=d", "#14Lookup dns information for domain", dns, ri);
mapkey("=D", "#14Lookup all information for domain", dnsVerbose, ri);
mapkey(";pd", "#14Toggle PDF viewer from SurfingKeys", togglePdfViewer, ri);
// 15: Insert Mode

// --- Site-specific mappings ---//
const siteleader = ",";

function mapsitekey(domainRegex, key, desc, f, opts = {}) {
  const o = Object.assign(
    {},
    {
      leader: siteleader,
    },
    opts
  );
  mapkey(`${o.leader}${key}`, desc, f, {
    domain: domainRegex,
  });
}

function mapsitekeys(d, maps, opts = {}) {
  const domain = d.replace(".", "\\.");
  const domainRegex = new RegExp(
    `^http(s)?://(([a-zA-Z0-9-_]+\\.)*)(${domain})(/.*)?`
  );
  maps.forEach((map) => {
    const [key, desc, f, subOpts = {}] = map;
    mapsitekey(domainRegex, key, desc, f, Object.assign({}, opts, subOpts));
  });
}

const fakeSpot = () =>
  tabOpenLink(`http://fakespot.com/analyze?url=${window.location.href}`);

mapsitekeys("amazon.com", [["fs", "Fakespot", fakeSpot]]);

mapsitekeys("yelp.com", [["fs", "Fakespot", fakeSpot]]);

const ytFullscreen = () =>
  document.querySelector(".ytp-fullscreen-button.ytp-button").click();

mapsitekeys(
  "youtube.com",
  [
    ["A", "Open video", Hint("*[id='video-title']")],
    ["C", "Open channel", Hint("*[id='byline']")],
    [
      "gH",
      "Goto homepage",
      () =>
        window.location.assign(
          "https://www.youtube.com/feed/subscriptions?flow=2"
        ),
    ],
    ["F", "Toggle fullscreen", ytFullscreen],
    ["<Space>", "Play/pause", Hint(".ytp-play-button")],
  ],
  {
    leader: "",
  }
);

const vimeoFullscreen = () =>
  document.querySelector(".fullscreen-icon").click();

mapsitekeys("vimeo.com", [["F", "Toggle fullscreen", vimeoFullscreen]]);

const ghStar = (toggle) => () => {
  const repo = window.location.pathname
    .slice(1)
    .split("/")
    .slice(0, 2)
    .join("/");
  const container = document.querySelector("div.starring-container");
  const status = container.classList.contains("on");

  let star = "★";
  let statusMsg = "starred";
  let verb = "is";

  if ((status && toggle) || (!status && !toggle)) {
    statusMsg = `un${statusMsg}`;
    star = "☆";
  }

  if (toggle) {
    verb = "has been";
    if (status) {
      container.querySelector(".starred>button").click();
    } else {
      container.querySelector(".unstarred>button").click();
    }
  }

  Front.showBanner(`${star} Repository ${repo} ${verb} ${statusMsg}!`);
};

const viewGodoc = () => tabOpenLink(`https://godoc.org/${getURLPath(2, true)}`);

mapsitekeys("github.com", [
  ["s", "Toggle Star", ghStar(true)],
  ["S", "Check Star", ghStar(false)],
  ["y", "Copy Project Path", copyURLPath(2)],
  ["Y", "Copy Project Path (including domain)", copyURLPath(2, true)],
  ["D", "View GoDoc for Project", viewGodoc],
]);

const glToggleStar = () => {
  const repo = window.location.pathname
    .slice(1)
    .split("/")
    .slice(0, 2)
    .join("/");
  const btn = document.querySelector(".btn.star-btn > span");
  btn.click();
  const action = `${btn.textContent.toLowerCase()}red`;
  let star = "☆";
  if (action === "starred") {
    star = "★";
  }
  Front.showBanner(`${star} Repository ${repo} ${action}`);
};

mapsitekeys("gitlab.com", [
  ["s", "Toggle Star", glToggleStar],
  ["y", "Copy Project Path", copyURLPath(2)],
  ["Y", "Copy Project Path (including domain)", copyURLPath(2, true)],
  ["D", "View GoDoc for Project", viewGodoc],
]);

mapsitekeys("twitter.com", [
  ["f", "Follow user", Hint(".follow-button")],
  ["s", "Like tweet", Hint(".js-actionFavorite")],
  ["R", "Retweet", Hint(".js-actionRetweet")],
  ["c", "Comment/Reply", Hint(".js-actionReply")],
  ["t", "New tweet", Hint(".js-global-new-tweet")],
  ["T", "Tweet to", Hint(".NewTweetButton")],
  ["r", "Load new tweets", Hint(".new-tweets-bar")],
  ["g", "Goto user", Hint(".js-user-profile-link")],
]);

const redditCollapseNextComment = () => {
  const vis = Array.from(
    document.querySelectorAll(".noncollapsed.comment")
  ).filter((e) => isElementInViewport(e));
  if (vis.length > 0) {
    vis[0].querySelector(".expand").click();
  }
};

mapsitekeys("reddit.com", [
  ["x", "Collapse comment", Hint(".expand")],
  ["X", "Collapse next comment", redditCollapseNextComment],
  ["s", "Upvote", Hint(".arrow.up")],
  ["S", "Downvote", Hint(".arrow.down")],
  ["e", "Expand expando", Hint(".expando-button")],
  ["a", "View post (link)", Hint(".title")],
  ["c", "View post (comments)", Hint(".comments")],
]);

const hnGoParent = () => {
  const par = document.querySelector(".par>a");
  if (!par) {
    return;
  }
  window.location.assign(par.href);
};

const hnCollapseNextComment = () => {
  const vis = Array.from(document.querySelectorAll("a.togg")).filter(
    (e) => e.innerText === "[-]" && isElementInViewport(e)
  );
  if (vis.length > 0) {
    vis[0].click();
  }
};

mapsitekeys("news.ycombinator.com", [
  ["x", "Collapse comment", Hint(".togg")],
  ["X", "Collapse next comment", hnCollapseNextComment],
  ["s", "Upvote", Hint(".votearrow[title='upvote']")],
  ["S", "Downvote", Hint(".votearrow[title='downvote']")],
  ["a", "View post (link)", Hint(".storylink")],
  ["c", "View post (comments)", Hint("td > a[href*='item']:not(.storylink)")],
  ["p", "Go to parent", hnGoParent],
]);

const dribbbleAttachment = (cb) =>
  Hint(".attachments .thumb", (a) => cb(a.src.replace("/thumbnail/", "/")));

mapsitekeys("dribbble.com", [
  ["s", "Heart Shot", Hint(".toggle-fav, .like-shot")],
  ["a", "View shot", Hint(".dribbble-over, .gif-target, .more-thumbs a")],
  ["A", "View shot", Hint(".dribbble-over, .gif-target, .more-thumbs a")],
  ["v", "View attachment image", dribbbleAttachment((a) => tabOpenLink(a))],
  [
    "V",
    "Yank attachment image source URL",
    dribbbleAttachment((a) => Clipboard.write(a)),
  ],
  ["z", "Zoom shot", Hint(".single-img picture, .detail-shot img")],
]);

const behanceAddToCollection = () =>
  document.querySelector(".qa-action-collection").click();

mapsitekeys("behance.net", [
  ["s", "Appreciate project", Hint(".appreciation-button")],
  ["b", "Add project to collection", behanceAddToCollection],
  ["a", "View project", Hint(".rf-project-cover__title")],
  ["A", "View project", Hint(".rf-project-cover__title")],
]);

const wpToggleSimple = () => {
  window.location.hostname = window.location.hostname
    .split(".")
    .map((s, i) => {
      if (i === 0) {
        return s === "simple" ? "" : "simple";
      }
      return s;
    })
    .filter((s) => s !== "")
    .join(".");
};

mapsitekeys("wikipedia.org", [
  ["s", "Toggle simple version of current article", wpToggleSimple],
]);

// ---- Aliases ----//
map(",b", "T");
