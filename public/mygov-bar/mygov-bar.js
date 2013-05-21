(function(){var t,e,r=function(t,e){return function(){return t.apply(e,arguments)}},o={}.hasOwnProperty,n=function(t,e){function r(){this.constructor=t}for(var n in e)o.call(e,n)&&(t[n]=e[n]);return r.prototype=e.prototype,t.prototype=new r,t.__super__=e.prototype,t};e={interval_id:void 0,last_hash:void 0,cache_bust:1,attached_callback:void 0,window:this,postMessage:function(t,e,r){return e?(r=r||parent,window.postMessage?r.postMessage(t,e.replace(/([^:]+:\/\/[^\/]+).*/,"$1")):e?r.location=e.replace(/#.*$/,"")+"#"+ +new Date+cache_bust++ +"&"+t:void 0):void 0},receiveMessage:function(t,e){var r,o;return window.postMessage?(t&&(r=function(r){return"string"==typeof e&&r.origin!==e||"[object Function]"===Object.prototype.toString.call(e)&&e(r.origin)===!1?!1:t(r)}),window.addEventListener?window[t?"addEventListener":"removeEventListener"]("message",r,!1):window[t?"attachEvent":"detachEvent"]("onmessage",r)):(o&&clearInterval(o),o=null,t?o=setInterval(function(){var e,r,o;return e=document.location.hash,o=/^#?\d+&/,e!==r&&o.test(e)?(r=e,t({data:e.replace(o,"")})):void 0},100):void 0)}},(void 0===t||null===t)&&(t=function(){function t(){this.receive=r(this.receive,this),this.show=r(this.show,this),this.onResize=r(this.onResize,this),"undefined"!=typeof MyGovConfig&&null!==MyGovConfig&&n(this.config,MyGovConfig),this.config.url=encodeURIComponent(document.location.href.replace(/\/$/,"")),this.config.load!==!1&&(this.show(),this.addEvent(window,"resize",this.onResize),this.onResize())}return t.prototype.rootUrl="https://discovery.my.usa.gov/mygov-bar",t.prototype.scrollTrigger="0",t.prototype.widthMinimized="45",t.prototype.minWidth="650",t.prototype.animationSpeed="500",t.prototype.config={},t.prototype.style={position:"fixed",bottom:0,left:0,background:"transparent",width:"100%",display:"block",height:"57px",border:0,"z-index":9999999,overflow:"hidden","-webkit-transition":"height 500ms, width 500ms","-moz-transition":"height 500ms, width 500ms","-ms-transition":"height 500ms, width 500ms","-o-transition":"height 500ms, width 500ms",transition:"height 500ms, width 500ms"},t.prototype.isLoaded=!1,t.prototype.id="myGovBar",t.prototype.el=!1,t.prototype.state="shown",t.prototype.addEvent=function(t,e,r){return t.addEventListener?t.addEventListener(e,r,!1):t.attachEvent?t.attachEvent("on"+e,r):void 0},t.prototype.onResize=function(){return window.innerWidth<this.minWidth&&"shown"===this.state?(this.maximize(),this.send("collapsed")):void 0},t.prototype.positionTop=function(){return null!=window.pageYOffset?window.pageYOffset:null!=html.scrollTop?html.scrollTop:null!=body.scrollTop?body.scrollTop:0},t.prototype.pageHeight=function(){return Math.max(Math.max(document.body.scrollHeight,document.documentElement.scrollHeight),Math.max(document.body.offsetHeight,document.documentElement.offsetHeight),Math.max(document.body.clientHeight,document.documentElement.clientHeight))},t.prototype.windowHeight=function(){return window.innerHeight||html.clientHeight||body.clientHeight||screen.availHeight},t.prototype.offsetBottom=function(){return 100*(this.positionTop()+this.windowHeight())/this.pageHeight()},t.prototype.configSerialized=function(){var t,e;return function(){var r,o;r=this.config,o=[];for(t in r)e=r[t],o.push(this.toParam(t,e));return o}.call(this).join("&")},t.prototype.toParam=function(t,e){var r;if(null!=e)return"object"!=typeof e?t+"="+e:function(){var o,n,i;for(i=[],o=0,n=e.length;n>o;o++)r=e[o],i.push(this.toParam(t,r));return i}.call(this).join("&")},t.prototype.load=function(t){var r,o,n;this.el=document.createElement("iframe"),this.el.name=this.id,this.el.id=this.id,this.el.src=this.rootUrl+"/mygov-bar.html#"+this.configSerialized(),n=this.style;for(r in n)o=n[r],this.el.style[r]=o;return document.body.appendChild(this.el),this.addPageMargin(),e.receiveMessage(this.receive,this.rootUrl.match(/([^:]+:\/\/.[^/]+)/)[1]),this.isLoaded=!0,null!=t?t():void 0},t.prototype.addPageMargin=function(){var t;return t=document.createElement("div"),t.id=this.id+"Margin",t.style.height=this.style.height,document.body.appendChild(t)},t.prototype.setWidth=function(t){return this.el.style.width=t},t.prototype.setHeight=function(t){return this.el.style.height=t},t.prototype.show=function(){if(!this.isLoaded)return this.load(this.show);if("shown"!==this.state)return this.el.style.display="block",this.setState("shown")},t.prototype.hide=function(){return"hidden"!==this.state?(this.setState("hidden"),this.minimize):void 0},t.prototype.maximize=function(){return this.setWidth("100%")},t.prototype.minimize=function(){return this.setWidth(this.width_minimized)},t.prototype.send=function(t){var r;return r=document.getElementById(this.id),e.postMessage(t,r.src,frames.myGovBar)},t.prototype.receive=function(t){switch(t=t.data.split("-"),t[0]){case"expanded":return this.maximize();case"hidden":return this.hide();case"height":return this.setHeight(t[1])}},t.prototype.setState=function(t){return this.state=t,this.send(t)},t}(),window.MyGovLoader=new t)}).call(this);