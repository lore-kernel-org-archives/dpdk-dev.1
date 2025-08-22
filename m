Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 084A2CA0EEB
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 Aug 2025 03:46:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C3F49402A2;
	Fri, 22 Aug 2025 05:46:53 +0200 (CEST)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by mails.dpdk.org (Postfix) with ESMTP id 72EC540292
 for <dev@dpdk.org>; Fri, 22 Aug 2025 05:46:51 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.88.163])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4c7Qz174wrz2Dc7s;
 Fri, 22 Aug 2025 11:43:57 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
 by mail.maildlp.com (Postfix) with ESMTPS id D53B81800B2;
 Fri, 22 Aug 2025 11:46:48 +0800 (CST)
Received: from kwepemn100018.china.huawei.com (7.202.194.123) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 22 Aug 2025 11:46:48 +0800
Received: from kwepemn500008.china.huawei.com (7.202.194.149) by
 kwepemn100018.china.huawei.com (7.202.194.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 22 Aug 2025 11:46:48 +0800
Received: from kwepemn500008.china.huawei.com ([7.202.194.149]) by
 kwepemn500008.china.huawei.com ([7.202.194.149]) with mapi id 15.02.1544.011; 
 Fri, 22 Aug 2025 11:46:48 +0800
From: "wangfeifei (J)" <wangfeifei40@huawei.com>
To: "dev@dpdk.org" <dev@dpdk.org>, Stephen Hemminger
 <stephen@networkplumber.org>, Fengchengwen <fengchengwen@huawei.com>,
 huangdengdui <huangdengdui@h-partners.com>
CC: "Caoshui (waterman)" <waterman.cao@huawei.com>, zengweiliang zengweiliang
 <zengweiliang.zengweiliang@huawei.com>, "Dumin(Dumin,KunPeng)"
 <dumin3@huawei.com>, Sunhuayi <sunhuayi@huawei.com>, "Gongfan (Eric, Chip)"
 <gongfan1@huawei.com>
Subject: Huawei roadmap for 25.11
Thread-Topic: Huawei roadmap for 25.11
Thread-Index: AdwTFEj5INdbv4LWShqoRWiPnIIWSA==
Date: Fri, 22 Aug 2025 03:46:48 +0000
Message-ID: <8eb9492c358c4e6196f8d1e20c4dd11e@huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [100.105.34.252]
Content-Type: multipart/alternative;
 boundary="_000_8eb9492c358c4e6196f8d1e20c4dd11ehuaweicom_"
MIME-Version: 1.0
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

--_000_8eb9492c358c4e6196f8d1e20c4dd11ehuaweicom_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

UGxlYXNlIGZpbmQgYmVsb3cgSHVhd2VpIHJvYWRtYXAgZm9yIDI1LjExo7oNCg0KDQoxLiAgICAg
TmV3IHBtZCBkcml2ZXIgobBoaW5pYzOhsSBzdXBwb3J0IDEwMEdicHMvMjAwR2JwcyBIdWF3ZWkg
U1B4IHNlcmllcyBOZXR3b3JrIEFkYXB0ZXJzLg0KDQoyLiAgICAgTmV3IERNQSBkcml2ZXIgd2hp
Y2ggYmFzZWQgb24gVUFDQ0UgYnVzLg0KDQozLiAgICAgUmVmYWN0b3IgRE1BIHBlcmYgYXBwbGlj
YXRpb24NCg0KQmVzdCBSZWdhcmRzDQpGZWlmZWkNCg0K

--_000_8eb9492c358c4e6196f8d1e20c4dd11ehuaweicom_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:=B5=C8=CF=DF;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@=B5=C8=CF=DF";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:=B5=C8=CF=DF;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin:0cm;
	text-align:justify;
	text-justify:inter-ideograph;
	text-indent:21.0pt;
	font-size:10.5pt;
	font-family:=B5=C8=CF=DF;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:=B5=C8=CF=DF;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:=B5=C8=CF=DF;}
/* Page Definitions */
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:907108118;
	mso-list-type:hybrid;
	mso-list-template-ids:-387939262 1783634584 67698713 67698715 67698703 676=
98713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:18.0pt;
	text-indent:-18.0pt;}
@list l0:level2
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%2\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:42.0pt;
	text-indent:-21.0pt;}
@list l0:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:63.0pt;
	text-indent:-21.0pt;}
@list l0:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:84.0pt;
	text-indent:-21.0pt;}
@list l0:level5
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%5\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:105.0pt;
	text-indent:-21.0pt;}
@list l0:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:126.0pt;
	text-indent:-21.0pt;}
@list l0:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:147.0pt;
	text-indent:-21.0pt;}
@list l0:level8
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%8\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:168.0pt;
	text-indent:-21.0pt;}
@list l0:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:189.0pt;
	text-indent:-21.0pt;}
ol
	{margin-bottom:0cm;}
ul
	{margin-bottom:0cm;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"ZH-CN" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word;text-justify-trim:punctuation">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US">Please find below Huawei roadma=
p for 25.11</span>=A3=BA<span lang=3D"EN-US"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:18.0pt;text-indent:-18.0=
pt;mso-list:l0 level1 lfo1">
<![if !supportLists]><span lang=3D"EN-US"><span style=3D"mso-list:Ignore">1=
.<span style=3D"font:7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&=
nbsp;
</span></span></span><![endif]><span lang=3D"EN-US">New pmd driver </span>=
=A1=B0<span lang=3D"EN-US">hinic3</span>=A1=B1<span lang=3D"EN-US"> support=
 100Gbps/200Gbps Huawei SPx series Network Adapters.<o:p></o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:18.0pt;text-indent:-18.0=
pt;mso-list:l0 level1 lfo1">
<![if !supportLists]><span lang=3D"EN-US"><span style=3D"mso-list:Ignore">2=
.<span style=3D"font:7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&=
nbsp;
</span></span></span><![endif]><span lang=3D"EN-US">New DMA driver which ba=
sed on UACCE bus.<o:p></o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:18.0pt;text-indent:-18.0=
pt;mso-list:l0 level1 lfo1">
<![if !supportLists]><span lang=3D"EN-US"><span style=3D"mso-list:Ignore">3=
.<span style=3D"font:7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&=
nbsp;
</span></span></span><![endif]><span lang=3D"EN-US">Refactor DMA perf appli=
cation<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Best Regards<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Feifei<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
</div>
</body>
</html>

--_000_8eb9492c358c4e6196f8d1e20c4dd11ehuaweicom_--
