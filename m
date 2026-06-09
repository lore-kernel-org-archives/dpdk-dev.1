Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01CCFCD8CA4
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 09:36:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A73D402BE;
	Tue,  9 Jun 2026 11:36:30 +0200 (CEST)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by mails.dpdk.org (Postfix) with ESMTP id 704134025E
 for <dev@dpdk.org>; Tue,  9 Jun 2026 11:36:28 +0200 (CEST)
Received: from LAPTOP-ARGRBVTN (unknown [101.207.145.153])
 by APP-01 (Coremail) with SMTP id qwCowADnjdaX3idqYrb+AA--.5117S2;
 Tue, 09 Jun 2026 17:36:24 +0800 (CST)
From: "liujie5@linkdatatechnology.com" <liujie5@linkdatatechnology.com>
To: "Thomas Monjalon" <thomas@monjalon.net>
Cc: stephen <stephen@networkplumber.org>, 
	dev <dev@dpdk.org>
Subject: Re: Re: [PATCH v14 00/20] net/sxe2: added Linkdata sxe2 ethernet
 driver
Date: Tue, 9 Jun 2026 17:36:24 +0800
References: <20260608074257.3043531-21-liujie5@linkdatatechnology.com>, 
 <20260609013951.3359199-1-liujie5@linkdatatechnology.com>, 
 <T4eYjXumTvWFDg9HUrMwEA@monjalon.net>
In-Reply-To: <20260609013951.3359199-1-liujie5@linkdatatechnology.com>
X-Priority: 3
X-Has-Attach: no
X-Mailer: Foxmail 7.2.25.542[cn]
Mime-Version: 1.0
Message-ID: <202606091736207808470@linkdatatechnology.com>
Content-Type: multipart/alternative;
 boundary="----=_001_NextPart163285302842_=----"
X-CM-TRANSID: qwCowADnjdaX3idqYrb+AA--.5117S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFyDtr18uF4kCw4xtry5Jwb_yoW8Kw4DpF
 W8K34Fkws5JF17Zr4vva1xuFyF93yFqa4Uu3Z8W3yDtwn8XF18KryIq340qw1xCr1rW3WF
 9a12v3Z8G3Z5ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9ab7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
 C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVCF
 0I0E4I0vr24lYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeV
 CFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACY4xI67k04243AVAKzVAKj4xxMx8G
 jcxK6IxK0xIIj40E5I8CrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
 C20s026c02F40E14v26r106r1rMI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
 wI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
 v20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
 jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UMVCEFcxC0VAYjxAxZF
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

------=_001_NextPart163285302842_=----
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64

MDkvMDYvMjAyNiAwMzozOSwgbGl1amllNUBsaW5rZGF0YXRlY2hub2xvZ3kuY29tOg0KPiBGcm9t
OiBKaWUgTGl1IDxsaXVqaWU1QGxpbmtkYXRhdGVjaG5vbG9neS5jb20+DQo+IA0KPiBUaGlzIHBh
dGNoIHNldCBpbXBsZW1lbnRzIGNvcmUgZnVuY3Rpb25hbGl0eSBmb3IgdGhlIFNYRTIgUE1ELA0K
PiBpbmNsdWRpbmcgYmFzaWMgZHJpdmVyIGZyYW1ld29yaywgZGF0YSBwYXRoIHNldHVwLCBhbmQg
YWR2YW5jZWQNCj4gb2ZmbG9hZCBmZWF0dXJlcyAoVkxBTiwgUlNTLFRNLCBQVFAgZXRjLikuDQo+
IA0KPiBWMTQ6DQo+ICAtIEFkZHJlc3NlZCBBSSBjb21tZW50cw0KDQpQbGVhc2UgY291bGQgeW91
IHNlbmQgeW91ciBuZXcgc2VyaWVzIGFzIGEgcmVwbHkgb2YgdGhlIHYxIGNvdmVyIGxldHRlcj8N
Ckl0IHdvdWxkIGF2b2lkIGhhdmluZyBhIGxhcmdlIGluZGVudCBpbiBtYWlsIGNsaWVudHMuDQoN
CkFsc28gSSdtIHN0aWxsIHdhaXRpbmcgZm9yIGEgcmVwbHkgdG8gbXkgcXVlc3Rpb24gYWJvdXQg
dGhlIG5lZWQNCmZvciBkcml2ZXJzL2NvbW1vbi9zeGUyLy4NCkknbSBub3QgZ29pbmcgdG8gcHVs
bCBhbnkgc3hlMiBwYXRjaCBpbnRvIG1haW4gdW50aWwgeW91IGV4cGxhaW4uDQoNCg==

------=_001_NextPart163285302842_=----
Content-Type: text/html;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html><head></head><body><div class=3D"">Hi Thomas Monjalon,<br><br>Thank =
you for your review and for guiding me on the mailing list workflow.<br><b=
r>&gt; Please could you send your new series as a reply of the v1 cover le=
tter?<br>&gt; It would avoid having a large indent in mail clients.<br><br=
>Got it. I will configure git send-email with "--in-reply-to" bound to the=
 <br>v1 cover letter Message-ID for the next version of this patch set. <b=
r>Apologies for the inconvenience caused by the deep threading.<br><br>&gt=
; Also I'm still waiting for a reply to my question about the need<br>&gt;=
 for drivers/common/sxe2/.<br>&gt; I'm not going to pull any sxe2 patch in=
to main until you explain.<br><br>Regarding the necessity of the "drivers/=
common/sxe2/" directory, the sxe2 <br>hardware architecture is designed to=
 support both standard NIC and vDPA <br>(vHost Data Path Acceleration) fun=
ctionalities. <br><br>The code currently placed in "drivers/common/sxe2/" =
contains the foundational <br>Hardware Abstraction Layer (HAL), firmware i=
nterfaces (AdminQ), and common <br>register definitions. <br><br>Apart fro=
m the "net/sxe2" PMD in this series, we are actively implementing the <br>=
"vdpa/sxe2" driver, which will be submitted in a subsequent patch set. Bot=
h the <br>"net/sxe2" and "vdpa/sxe2" drivers strictly depend on this share=
d common HAL <br>layer to manage the same hardware core. Separating this c=
ode into "drivers/common/" <br>is essential to prevent massive code duplic=
ation between the net and vdpa <br>subsystems in the near future.<br><br>P=
lease let me know if this clarifies your concern. Once confirmed, I will <=
br>send out the updated v15 series as a reply to the v1 cover letter immed=
iately.<br><br>Best regards,<br>Jie Liu (liujie5@linkdatatechnology.com)</=
div><div>&nbsp;</div><hr style=3D"WIDTH: 210px; HEIGHT: 1px" color=3D"#b5c=
4df" size=3D"1" align=3D"left"><div><span><div style=3D"MARGIN: 10px; FONT=
-FAMILY: verdana; FONT-SIZE: 10pt"><div>liujie5@linkdatatechnology.com</di=
v></div></span></div><blockquote style=3D"margin-Top: 0px; margin-Bottom: =
0px; margin-Left: 0.5em; margin-Right: inherit"><div>&nbsp;</div><div styl=
e=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm 0cm 0cm"=
><div style=3D"PADDING-RIGHT: 8px; PADDING-LEFT: 8px; FONT-SIZE: 12px;FONT=
-FAMILY:tahoma;COLOR:#000000; BACKGROUND: #efefef; PADDING-BOTTOM: 8px; PA=
DDING-TOP: 8px"><div><b>From:</b>&nbsp;<a href=3D"mailto:thomas@monjalon.n=
et">Thomas Monjalon</a></div><div><b>Date:</b>&nbsp;2026-06-09&nbsp;16:42<=
/div><div><b>To:</b>&nbsp;<a href=3D"mailto:liujie5@linkdatatechnology.com=
">Jie Liu</a></div><div><b>CC:</b>&nbsp;<a href=3D"mailto:stephen@networkp=
lumber.org">stephen</a>; <a href=3D"mailto:dev@dpdk.org">dev</a></div><div=
><b>Subject:</b>&nbsp;Re: [PATCH v14 00/20] net/sxe2: added Linkdata sxe2 =
ethernet driver</div></div></div><div><div class=3D""><style>div.FoxDIV_20=
260609171540884 { font-size: 10.5pt; transform: translatez(0); overflow: a=
uto; }=0A</style><div style=3D"height:initial" class=3D"FoxDIV_20260609171=
540884"><div>09/06/2026 03:39, liujie5@linkdatatechnology.com:=0A</div>=0A=
<div class=3D"plaintext_qoute">&gt; From: Jie Liu &lt;liujie5@linkdatatech=
nology.com&gt;=0A</div>=0A<div class=3D"plaintext_qoute">&gt; =0A</div>=0A=
<div class=3D"plaintext_qoute">&gt; This patch set implements core functio=
nality for the SXE2 PMD,=0A</div>=0A<div class=3D"plaintext_qoute">&gt; in=
cluding basic driver framework, data path setup, and advanced=0A</div>=0A<=
div class=3D"plaintext_qoute">&gt; offload features (VLAN, RSS,TM, PTP etc=
.).=0A</div>=0A<div class=3D"plaintext_qoute">&gt; =0A</div>=0A<div class=
=3D"plaintext_qoute">&gt; V14:=0A</div>=0A<div class=3D"plaintext_qoute">&=
gt;&nbsp; - Addressed AI comments=0A</div>=0A<br>=0A<div>Please could you =
send your new series as a reply of the v1 cover letter?=0A</div>=0A<div>It=
 would avoid having a large indent in mail clients.=0A</div>=0A<br>=0A<div=
>Also I'm still waiting for a reply to my question about the need=0A</div>=
=0A<div>for drivers/common/sxe2/.=0A</div>=0A<div>I'm not going to pull an=
y sxe2 patch into main until you explain.=0A</div>=0A<br>=0A</div></div></=
div></blockquote></body></html>
------=_001_NextPart163285302842_=------

