Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FB1CD6E56
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 10:14:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1D3694025F;
	Mon,  1 Jun 2026 12:14:21 +0200 (CEST)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by mails.dpdk.org (Postfix) with ESMTP id A3B594025A
 for <dev@dpdk.org>; Mon,  1 Jun 2026 12:14:19 +0200 (CEST)
Received: from LAPTOP-ARGRBVTN (unknown [101.207.145.153])
 by APP-01 (Coremail) with SMTP id qwCowAAnztZ3Wx1qFKFWAA--.1593S2;
 Mon, 01 Jun 2026 18:14:16 +0800 (CST)
From: "liujie5@linkdatatechnology.com" <liujie5@linkdatatechnology.com>
To: "Thomas Monjalon" <thomas@monjalon.net>
Cc: dev <dev@dpdk.org>, stephen <stephen@networkplumber.org>, 
 "David Marchand" <david.marchand@redhat.com>
Subject: Re: Re: [PATCH v19 00/11]net/sxe2: fix logic errors and address
 feedback
Date: Mon, 1 Jun 2026 18:14:16 +0800
References: <20260519144810.3951202-12-liujie5@linkdatatechnology.com>, 
 <9XBXAO5XSSSHFRFv8zy4yQ@monjalon.net>, 
 <gMRpO5X1TMqg0ezYQiGHfg@monjalon.net>, 
 <Xwaj3QZYS3m2yOc8mSX1EQ@monjalon.net>
In-Reply-To: <gMRpO5X1TMqg0ezYQiGHfg@monjalon.net>
X-Priority: 3
X-Has-Attach: no
X-Mailer: Foxmail 7.2.25.542[cn]
Mime-Version: 1.0
Message-ID: <202606011814147750260@linkdatatechnology.com>
Content-Type: multipart/alternative;
 boundary="----=_001_NextPart361647888875_=----"
X-CM-TRANSID: qwCowAAnztZ3Wx1qFKFWAA--.1593S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF4kurWkGw4fGw1fKrW5GFg_yoW8tF4xpF
 WUKa1Fy3WDXF48uws7Zw48Za4Fg3s3Ca9xCr1rKrW7A345ZF1SyF17t3ZYvFWrCr4fXw1I
 vw4jvFyDWan0yFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9ab7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I
 8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG6xAI
 xVCFxsxG0wAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6x
 CaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4xvF2IEb7IF0Fy264kE64k0F24l7480
 Y4vEI4kI2Ix0rVAqx4xJMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI
 8I3I0E5I8CrVAFwI0_JrI_JrWlx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
 xVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI
 8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280
 aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UMVCEFcxC0VAYjxAxZF
 UvcSsGvfC2KfnxnUUI43ZEXa7IU8Tv35UUUUU==
X-Originating-IP: [101.207.145.153]
X-CM-SenderInfo: xolxyxrhv6zxpqngt3pdwhux5qro0w31of0z/
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

This is a multi-part message in MIME format.

------=_001_NextPart361647888875_=----
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64

MjYvMDUvMjAyNiAxNjoxMywgVGhvbWFzIE1vbmphbG9uOg0KPiAyMS8wNS8yMDI2IDE3OjE2LCBU
aG9tYXMgTW9uamFsb246DQo+ID4gSGVsbG8sDQo+ID4gDQo+ID4gMjAvMDUvMjAyNiAwNDoxNywg
bGl1amllNUBsaW5rZGF0YXRlY2hub2xvZ3kuY29tOg0KPiA+ID4gICBjb21tb24vc3hlMjogYWRk
IHN4ZTIgYmFzaWMgc3RydWN0dXJlcw0KPiA+IA0KPiA+IEFyZSB5b3UgcGxhbm5pbmcgdG8gYWRk
IGEgY3J5cHRvIG9yIGNvbXByZXNzIGRyaXZlcj8NCj4gPiBUaGlzIGlzIHVzdWFsbHkgdGhlIHJl
YXNvbiB0byBoYXZlIGEgY29tbW9uIGxpYnJhcnkuDQo+ID4gSWYgeW91IGRvbid0IGludGVuZCB0
byBzaGFyZSBzb21lIGNvZGUgYmV0d2VlbiBkaWZmZXJlbnQgZHJpdmVyLA0KPiA+IHRoZW4geW91
IHNob3VsZCBub3QgaGF2ZSBhIGNvbW1vbiBsaWJyYXJ5Lg0KPiANCj4gV2UgYXJlIGN1cmlvdXMg
YWJvdXQgeW91ciBwbGFucyBmb3Igc3hlMi4NCj4gUGxlYXNlLCBjb3VsZCB5b3UgcmVwbHk/DQo+
IFdpbGwgeW91IGFkZCBhbm90aGVyIGRyaXZlciBjbGFzcyB0byBzeGUyPw0KDQpJIHNlZSB5b3Ug
YXJlIHN1Ym1pdHRpbmcgcGF0Y2hlcw0KYnV0IHlvdSBkb24ndCB0YWtlIHRpbWUgdG8gYW5zd2Vy
IHF1ZXN0aW9ucy4NCg0KUGxlYXNlIHN0b3Agc2VuZGluZyBiZWZvcmUgYW5zd2VyaW5nLA0Kd2Ug
bmVlZCB0byBjb21tdW5pY2F0ZSwgb3RoZXJ3aXNlIGl0IHdvbid0IHdvcmsuDQoNCg==

------=_001_NextPart361647888875_=----
Content-Type: text/html;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html><head></head><body><div class=3D"">Hello Thomas,<br><br>My sincere a=
pologies for the delayed response and for continuing to submit patches wit=
hout answering your questions first. I did not mean to ignore the discussi=
on, and I appreciate your patience.<br><br>To answer your question regardi=
ng our plans for common/sxe2:<br><br>We do not currently plan to add other=
 driver classes like crypto or compress. However, the common/sxe2 director=
y was introduced to host our hardware abstraction layer (HAL) and base cod=
e, with the strategic goal of code reuse for future generations of our net=
work interface cards (e.g., sxe3, sxe4, etc.). <br><br>This base code hand=
les general hardware initialization, register maps, and management structu=
res that will remain consistent and shared across our upcoming chip iterat=
ions, rather than being specific only to the current sxe2 ethdev logic.<br=
><br>That being said, we want to align with DPDK's upstream policies. If t=
he community prefers to keep all net-only driver code within the net direc=
tory until a multi-class or multi-generation need officially arrives in th=
e upstream, I am fully open to refactoring the patches. I can merge the co=
mmon/sxe2 logic entirely into drivers/net/sxe2 for this release.<br><br>Pl=
ease let me know your thoughts on this approach, and I will wait for your =
guidance before sending the next version.<br><br>Best regards,<br>Liu Jie<=
/div><div>&nbsp;</div><hr style=3D"WIDTH: 210px; HEIGHT: 1px" color=3D"#b5=
c4df" size=3D"1" align=3D"left"><div><span><div style=3D"MARGIN: 10px; FON=
T-FAMILY: verdana; FONT-SIZE: 10pt"><div>liujie5@linkdatatechnology.com</d=
iv></div></span></div><blockquote style=3D"margin-Top: 0px; margin-Bottom:=
 0px; margin-Left: 0.5em; margin-Right: inherit"><div>&nbsp;</div><div sty=
le=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm 0cm 0cm=
"><div style=3D"PADDING-RIGHT: 8px; PADDING-LEFT: 8px; FONT-SIZE: 12px;FON=
T-FAMILY:tahoma;COLOR:#000000; BACKGROUND: #efefef; PADDING-BOTTOM: 8px; P=
ADDING-TOP: 8px"><div><b>From:</b>&nbsp;<a href=3D"mailto:thomas@monjalon.=
net">Thomas Monjalon</a></div><div><b>Date:</b>&nbsp;2026-06-01&nbsp;17:51=
</div><div><b>To:</b>&nbsp;<a href=3D"mailto:liujie5@linkdatatechnology.co=
m">Jie Liu</a></div><div><b>CC:</b>&nbsp;<a href=3D"mailto:dev@dpdk.org">d=
ev</a>; <a href=3D"mailto:stephen@networkplumber.org">stephen</a>; <a href=
=3D"mailto:david.marchand@redhat.com">David Marchand</a></div><div><b>Subj=
ect:</b>&nbsp;Re: [PATCH v19 00/11]net/sxe2: fix logic errors and address =
feedback</div></div></div><div><div class=3D""><style>div.FoxDIV_202606011=
75722368 { font-size: 10.5pt; transform: translatez(0); overflow: auto; }=
=0A</style><div style=3D"height:initial" class=3D"FoxDIV_20260601175722368=
"><div>26/05/2026 16:13, Thomas Monjalon:=0A</div>=0A<div class=3D"plainte=
xt_qoute">&gt; 21/05/2026 17:16, Thomas Monjalon:=0A</div>=0A<div class=3D=
"plaintext_qoute">&gt; &gt; Hello,=0A</div>=0A<div class=3D"plaintext_qout=
e">&gt; &gt; =0A</div>=0A<div class=3D"plaintext_qoute">&gt; &gt; 20/05/20=
26 04:17, liujie5@linkdatatechnology.com:=0A</div>=0A<div class=3D"plainte=
xt_qoute">&gt; &gt; &gt;&nbsp;&nbsp; common/sxe2: add sxe2 basic structure=
s=0A</div>=0A<div class=3D"plaintext_qoute">&gt; &gt; =0A</div>=0A<div cla=
ss=3D"plaintext_qoute">&gt; &gt; Are you planning to add a crypto or compr=
ess driver?=0A</div>=0A<div class=3D"plaintext_qoute">&gt; &gt; This is us=
ually the reason to have a common library.=0A</div>=0A<div class=3D"plaint=
ext_qoute">&gt; &gt; If you don't intend to share some code between differ=
ent driver,=0A</div>=0A<div class=3D"plaintext_qoute">&gt; &gt; then you s=
hould not have a common library.=0A</div>=0A<div class=3D"plaintext_qoute"=
>&gt; =0A</div>=0A<div class=3D"plaintext_qoute">&gt; We are curious about=
 your plans for sxe2.=0A</div>=0A<div class=3D"plaintext_qoute">&gt; Pleas=
e, could you reply?=0A</div>=0A<div class=3D"plaintext_qoute">&gt; Will yo=
u add another driver class to sxe2?=0A</div>=0A<br>=0A<div>I see you are s=
ubmitting patches=0A</div>=0A<div>but you don't take time to answer questi=
ons.=0A</div>=0A<br>=0A<div>Please stop sending before answering,=0A</div>=
=0A<div>we need to communicate, otherwise it won't work.=0A</div>=0A<br>=
=0A</div></div></div></blockquote></body></html>
------=_001_NextPart361647888875_=------

