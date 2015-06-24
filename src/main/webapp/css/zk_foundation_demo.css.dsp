<%@ taglib uri="http://www.zkoss.org/dsp/web/theme" prefix="t" %>
.main-section {
	background: #f9f9f9;
}
.inner-wrap > .tab-bar {
	position: absolute;
	background:  rgba(3,169,244,0.65);
	width: 2.8125rem;
	z-index: 100;
	left: -38px;
	${t:boxShadow('none')}	
}
.inner-wrap > .tab-bar > .left-small {
	border-right-color: rgb(3,169,244);
}
ul.off-canvas-list li a  {
	color: #333;
	font-family: "RobotoDraft","Roboto",sans-serif;
	border: 0;
	padding-left: 22px;
}
ul.off-canvas-list {
	border-top: 1px solid #e0e0e0;
}
.left-off-canvas-menu {
	background: #fff;
	color: #333;
	font-family: "RobotoDraft","Roboto",sans-serif;
	border-right: 1px solid #e0e0e0;
	overflow: visible;
}
ul.off-canvas-list > li a:hover  {
	background: #dedede;
}
ul.off-canvas-list > li.active a {
	background: #dedede;
}
.move-right > .inner-wrap > .tab-bar {
	left: 0px;
	${t:boxShadow('0 6px 10px rgba(0,0,0,.23),0 10px 30px rgba(0,0,0,.19)')}
}
.inner-wrap > .tab-bar:hover {
	left: 0px;
	${t:boxShadow('0 10px 18px rgba(0,0,0,.22),0 14px 45px rgba(0,0,0,.25)')}
}
ul.off-canvas-list > li {
	position: relative;
}
ul.off-canvas-list li a:hover + .template {
	display: block;
	${t:boxShadow('0 3px 10px rgba(0,0,0,.23),0 3px 10px rgba(0,0,0,.16)') };
	border: 1px solid #eee;
	background: #fff;
}
ul.off-canvas-list li:hover:after {
	font-family: FontAwesome;
	font-weight: normal;
	font-style: normal;
	-webkit-font-smoothing: antialiased;
	-moz-osx-font-smoothing: grayscale;
	content: "\f0d9";
	font-size: 64px;
	color: #fff;
	display: inline-block;
	position: absolute;
	right: -3px;
	top: -28px;
	z-index: 300;
}
.template {
	display: none;
	position: absolute;
	right: -248px;
	height: 200px;
	width: 248px;
	padding: 5px;
	top: 0px;
	z-index: 200;
	overflow: hidden;
}
.template .display {
	background-color: #dddddd;
	margin-bottom: 5px;
	display: block;
}
.template .display {
	background-color: #dddddd;
	margin-bottom: 5px;
	display: block;
}

.template>.row .column,.template>.row .columns {
	padding: 0 2.5px;
}

.template>.row .column:first-child,.template>.row .columns:first-child {
	padding-left: 15px;
}

.template>.row .column:last-child,.template>.row .columns:last-child {
	padding-right: 15px;
}

#logo {
	padding: 10px 15px;
	display: inline-block;
}
#container {
	position: relative;
}
#opensource {
	background: rgba(3,169,244,0.65);
	position: fixed;
	right: 20px;
	top: 60px;
	z-index: 1;
	margin: 0;
	padding: 15px;
	width: 56px;
	height: 56px;
	transition: box-shadow 0.28s cubic-bezier(0.4, 0, 0.2, 1);
	${t:boxShadow('0 6px 10px rgba(0,0,0,.23),0 10px 30px rgba(0,0,0,.19)')}
	${t:borderRadius('100%')};
	
}
#opensource .z-icon-external-link {
	font-size: 28px;
	margin: 1px;
}
#opensource:hover {
	${t:boxShadow('0 10px 18px rgba(0,0,0,.22),0 14px 45px rgba(0,0,0,.25)')}
}
pre {
	display: block;
	padding: 9.5px;
	margin: 0 0 10px;
	font-size: 13px;
	line-height: 1.42857143;
	color: #333;
	word-break: break-all;
	word-wrap: break-word;
	background-color: #f5f5f5;
	border: 1px solid #ccc;
	border-radius: 4px;
}
@media only screen and (max-width: 40em) { 
	#opensource {
		display: none;
	}
}