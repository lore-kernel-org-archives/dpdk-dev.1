Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BE8606A31A
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 11:56:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 300E840283;
	Tue, 20 Oct 2026 13:56:36 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 53BC840144;
 Tue, 20 Oct 2026 13:56:34 +0200 (CEST)
Received: from LAPTOP-ARGRBVTN (unknown [101.207.145.153])
 by APP-03 (Coremail) with SMTP id rQCowADX3z3vVtdq8fpJCw--.7957S2;
 Tue, 20 Oct 2026 19:56:32 +0800 (CST)
Date: Tue, 20 Oct 2026 19:56:32 +0800
From: "liujie5@linkdatatechnology.com" <liujie5@linkdatatechnology.com>
To: checkpatch <checkpatch@dpdk.org>, 
	stephen <stephen@networkplumber.org>
Cc: dev <dev@dpdk.org>
Subject: Re: |WARNING| pw171747 [PATCH v1 1/1] bus/pci: add
 RTE_PCI_DRV_NEED_IOVA_AS_PA flag
References: <20261020115038.2832246-2-liujie5@linkdatatechnology.com>, 
 <20261020115134.9048C12631E@dpdk.org>
X-Priority: 3
X-Has-Attach: no
X-Mailer: Foxmail 7.2.25.563[cn]
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Message-ID: <202610201956309511011@linkdatatechnology.com>
Content-Type: multipart/alternative;
 boundary="----=_001_NextPart033814461834_=----"
X-CM-TRANSID: rQCowADX3z3vVtdq8fpJCw--.7957S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
 VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYy7k0a2IF6F4UM7kC6x804xWl14x267AK
 xVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
 A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j
 6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j6r4UM28EF7xvwVC2z280aVAFwI0_Gr
 1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY
 62kv0487Mc02F40E42I26xC2a48xMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67
 AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFcxC0VAYjxAx
 ZF0Ew4CEw7xC0wACY4xI67k04243AVC20s07MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
 Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_JrI_JrWlx2IqxVCjr7xvwVAFwI0_JrI_JrWl
 x4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
 1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_
 JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JwCE64
 xvF2IEb7IF0Fy7YxBIdaVFxhVjvjDU0xZFpf9x07j8b1nUUUUU=
X-CM-SenderInfo: xolxyxrhv6zxpqngt3pdwhux5qro0w31of0z/
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is a multi-part message in MIME format.

------=_001_NextPart033814461834_=----
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: base64

DQpIaSBzdGVwaGVuLA0KDQpQbGVhc2UgaWdub3JlIHYxIHBhdGNoL3Nlcmllcy4gSSBmb3VuZCBh
biBpc3N1ZSBhbmQgd2lsbCBzZW5kIGEgcmV2aXNlZCB2ZXJzaW9uICh2Mikgc2hvcnRseS4NCg0K
DQpsaXVqaWU1QGxpbmtkYXRhdGVjaG5vbG9neS5jb20NCiANCkZyb206IGNoZWNrcGF0Y2gNCkRh
dGU6IDIwMjYtMTAtMjAgMTk6NTENClRvOiB0ZXN0LXJlcG9ydA0KQ0M6IGxpdWppZTUNClN1Ympl
Y3Q6IHxXQVJOSU5HfCBwdzE3MTc0NyBbUEFUQ0ggdjEgMS8xXSBidXMvcGNpOiBhZGQgUlRFX1BD
SV9EUlZfTkVFRF9JT1ZBX0FTX1BBIGZsYWcNClRlc3QtTGFiZWw6IGNoZWNrcGF0Y2gNClRlc3Qt
U3RhdHVzOiBXQVJOSU5HDQpodHRwOi8vZHBkay5vcmcvcGF0Y2gvMTcxNzQ3DQogDQpfY29kaW5n
IHN0eWxlIGlzc3Vlc18NCiANCiANCkVSUk9SOk5PX0FVVEhPUl9TSUdOX09GRjogTWlzc2luZyBT
aWduZWQtb2ZmLWJ5OiBsaW5lIGJ5IG5vbWluYWwgcGF0Y2ggYXV0aG9yICdsaXVmZW5nMSA8bGl1
ZmVuZzFAc3Vnb24uY29tPicNCiANCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgMzMgbGlu
ZXMgY2hlY2tlZA0K

------=_001_NextPart033814461834_=----
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charse=
t=3Dus-ascii"><style>body { line-height: 1.5; }blockquote { margin-top: 0p=
x; margin-bottom: 0px; margin-left: 0.5em; }.fox_html_content_dummy_textar=
ea { position: absolute; overflow: hidden; width: 1px; height: 1px; opacit=
y: 0; }body { font-size: 14px; font-family: "Microsoft YaHei UI"; color: r=
gb(0, 0, 0); line-height: 1.5; }</style></head><body>=0A<div><span></span>=
<br></div>=0A<div><div>Hi stephen,</div><div><br></div><div>Please ignore =
v1 patch/series. I found an issue and will send a revised version (v2) sho=
rtly.</div></div><hr style=3D"width: 210px; height: 1px;" color=3D"#b5c4df=
" size=3D"1" align=3D"left">=0A<div><span><div style=3D"MARGIN: 10px; FONT=
-FAMILY: verdana; FONT-SIZE: 10pt"><div>liujie5@linkdatatechnology.com</di=
v></div></span></div>=0A<blockquote style=3D"margin-Top: 0px; margin-Botto=
m: 0px; margin-Left: 0.5em; margin-Right: inherit"><div>&nbsp;</div><div s=
tyle=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm 0cm 0=
cm"><div style=3D"PADDING-RIGHT: 8px; PADDING-LEFT: 8px; FONT-SIZE: 12px;F=
ONT-FAMILY:tahoma;COLOR:#000000; BACKGROUND: #efefef; PADDING-BOTTOM: 8px;=
 PADDING-TOP: 8px"><div><b>From:</b>&nbsp;<a href=3D"mailto:checkpatch@dpd=
k.org">checkpatch</a></div><div><b>Date:</b>&nbsp;2026-10-20&nbsp;19:51</d=
iv><div><b>To:</b>&nbsp;<a href=3D"mailto:test-report@dpdk.org">test-repor=
t</a></div><div><b>CC:</b>&nbsp;<a href=3D"mailto:liujie5@linkdatatechnolo=
gy.com">liujie5</a></div><div><b>Subject:</b>&nbsp;|WARNING| pw171747 [PAT=
CH v1 1/1] bus/pci: add RTE_PCI_DRV_NEED_IOVA_AS_PA flag</div></div></div>=
<div><div>Test-Label: checkpatch</div>=0A<div>Test-Status: WARNING</div>=
=0A<div>http://dpdk.org/patch/171747</div>=0A<div>&nbsp;</div>=0A<div>_cod=
ing style issues_</div>=0A<div>&nbsp;</div>=0A<div>&nbsp;</div>=0A<div>ERR=
OR:NO_AUTHOR_SIGN_OFF: Missing Signed-off-by: line by nominal patch author=
 'liufeng1 &lt;liufeng1@sugon.com&gt;'</div>=0A<div>&nbsp;</div>=0A<div>to=
tal: 1 errors, 0 warnings, 33 lines checked</div>=0A</div></blockquote>=0A=
</body></html>
------=_001_NextPart033814461834_=------

