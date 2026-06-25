Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF2DCDB479
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 06:08:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D54040280;
	Thu, 25 Jun 2026 08:08:02 +0200 (CEST)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by mails.dpdk.org (Postfix) with ESMTP id 495F04025F
 for <dev@dpdk.org>; Thu, 25 Jun 2026 08:08:00 +0200 (CEST)
Received: from LAPTOP-ARGRBVTN (unknown [101.207.145.153])
 by APP-01 (Coremail) with SMTP id qwCowACXO9S9xTxqbk0qAw--.52934S2;
 Thu, 25 Jun 2026 14:07:58 +0800 (CST)
Date: Thu, 25 Jun 2026 14:07:57 +0800
From: "liujie5@linkdatatechnology.com" <liujie5@linkdatatechnology.com>
To: liujie5 <liujie5@linkdatatechnology.com>, 
 stephen <stephen@networkplumber.org>
Cc: dev <dev@dpdk.org>
Subject: Re: [PATCH v7 00/23] net/sxe2: added Linkdata sxe2 ethernet driver
References: <20260624020249.3687380-1-liujie5@linkdatatechnology.com>, 
 <20260625054108.51381-1-liujie5@linkdatatechnology.com>
X-Priority: 3
X-Has-Attach: no
X-Mailer: Foxmail 7.2.25.542[cn]
Mime-Version: 1.0
Message-ID: <202606251407575951656@linkdatatechnology.com>
Content-Type: multipart/alternative;
 boundary="----=_001_NextPart756487230228_=----"
X-CM-TRANSID: qwCowACXO9S9xTxqbk0qAw--.52934S2
X-Coremail-Antispam: 1UD129KBjvJXoW3JF1UJFW7CFyfWF15Zr4xJFb_yoWxKw4kpF
 48ZryfZr13JFW3Gw4fJa1fZFyYg3WxJryjkrWa9a4fXFykAFyUCrs0gFy5CwnFyr13JF1S
 vrZIyr1UGan5Aw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9q14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
 0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVCF0I0E4I0vr24lYx0E2Ix0cI8I
 cVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjc
 xG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFcxC0VAYjxAxZF0Ew4CEw7xC
 0wACY4xI67k04243AVC20s07MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
 4UMI8I3I0E5I8CrVAFwI0_JrI_JrWlx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
 67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
 x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
 z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr1l6VACY4xI67k042
 43AbIYCTnIWIevJa73UjIFyTuYvjfUOdb1UUUUU
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

------=_001_NextPart756487230228_=----
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: base64

SGkgc3RlcGhlbiwNCg0KUGxlYXNlIGlnbm9yZSB2NyBwYXRjaC9zZXJpZXMuIEkgZm91bmQgYW4g
aXNzdWUgYW5kIHdpbGwgc2VuZCBhIHJldmlzZWQgdmVyc2lvbiAodjgpIHNob3J0bHkuDQoNCg0K
DQpsaXVqaWU1QGxpbmtkYXRhdGVjaG5vbG9neS5jb20NCiANCkZyb206IGxpdWppZTUNCkRhdGU6
IDIwMjYtMDYtMjUgMTM6NDENClRvOiBzdGVwaGVuDQpDQzogZGV2OyBKaWUgTGl1DQpTdWJqZWN0
OiBbUEFUQ0ggdjcgMDAvMjNdIG5ldC9zeGUyOiBhZGRlZCBMaW5rZGF0YSBzeGUyIGV0aGVybmV0
IGRyaXZlcg0KRnJvbTogSmllIExpdSA8bGl1amllNUBsaW5rZGF0YXRlY2hub2xvZ3kuY29tPg0K
IA0KVGhpcyBwYXRjaCBzZXQgaW1wbGVtZW50cyBjb3JlIGZ1bmN0aW9uYWxpdHkgZm9yIHRoZSBT
WEUyIFBNRCwNCmluY2x1ZGluZyBiYXNpYyBkcml2ZXIgZnJhbWV3b3JrLCBkYXRhIHBhdGggc2V0
dXAsIGFuZCBhZHZhbmNlZA0Kb2ZmbG9hZCBmZWF0dXJlcyAoVkxBTiwgUlNTLFRNLCBQVFAgZXRj
LikuDQogDQpWNzoNCi0gQWRkIHN1cHBvcnQgZm9yIGZsb3cgZHVwbGljYXRlIHBhdHRlcm4uDQog
DQpKaWUgTGl1ICgyMyk6DQogIG5ldC9zeGUyOiByZW1vdmUgc29mdHdhcmUgc3RhdGlzdGljcyBk
ZXZhcmdzDQogIG5ldC9zeGUyOiBhZGQgUnggZnJhbWV3b3JrIGFuZCBwYWNrZXQgdHlwZXMgY2Fs
bGJhY2sNCiAgbmV0L3N4ZTI6IHN1cHBvcnQgQVZYNTEyIHZlY3Rvcml6ZWQgcGF0aCBmb3IgUngg
YW5kIFR4DQogIG5ldC9zeGUyOiBhZGQgQVZYMiB2ZWN0b3IgZGF0YSBwYXRoIGZvciBSeCBhbmQg
VHgNCiAgbmV0L3N4ZTI6IGFkZCBsaW5rIHVwZGF0ZSBjYWxsYmFjaw0KICBuZXQvc3hlMjogc3Vw
cG9ydCBMMiBmaWx0ZXJpbmcgYW5kIE1BQyBjb25maWcNCiAgZHJpdmVyczogc3VwcG9ydCBSU1Mg
ZmVhdHVyZQ0KICBuZXQvc3hlMjogc3VwcG9ydCBUTSBoaWVyYXJjaHkgYW5kIHNoYXBpbmcNCiAg
bmV0L3N4ZTI6IHN1cHBvcnQgSVBzZWMgaW5saW5lIHByb3RvY29sIG9mZmxvYWQNCiAgbmV0L3N4
ZTI6IHN1cHBvcnQgc3RhdGlzdGljcyBhbmQgbXVsdGktcHJvY2Vzcw0KICBkcml2ZXJzOiBpbnRl
cnJ1cHQgaGFuZGxpbmcNCiAgbmV0L3N4ZTI6IGFkZCBORU9OIHZlYyBSeC9UeCBidXJzdCBmdW5j
dGlvbnMNCiAgZHJpdmVyczogYWRkIHN1cHBvcnQgZm9yIFZGIHJlcHJlc2VudG9ycw0KICBuZXQv
c3hlMjogYWRkIHN1cHBvcnQgZm9yIGN1c3RvbSBVRFAgdHVubmVsIHBvcnRzDQogIG5ldC9zeGUy
OiBzdXBwb3J0IGZpcm13YXJlIHZlcnNpb24gcmVhZGluZw0KICBuZXQvc3hlMjogaW1wbGVtZW50
IGdldCBtb25pdG9yIGFkZHJlc3MNCiAgY29tbW9uL3N4ZTI6IGFkZCBzaGFyZWQgU0ZQIG1vZHVs
ZSBkZWZpbml0aW9ucw0KICBuZXQvc3hlMjogc3VwcG9ydCBTRlAgbW9kdWxlIGluZm8gYW5kIEVF
UFJPTSBhY2Nlc3MNCiAgbmV0L3N4ZTI6IGFkZCBtYnVmIHZhbGlkYXRpb24gaW4gVHggZGVidWcg
bW9kZQ0KICBjb21tb24vc3hlMjogYWRkIGNhbGxiYWNrIGZvciBtZW1vcnkgZXZlbnQgaGFuZGxp
bmcNCiAgbmV0L3N4ZTI6IGFkZCBwcml2YXRlIGRldmFyZ3MgcGFyc2luZw0KICBuZXQvc3hlMjog
aW1wbGVtZW50IHByaXZhdGUgZHVtcCBpbmZvDQogIG5ldC9zeGUyOiB1cGRhdGUgc3hlMiBmZWF0
dXJlIG1hdHJpeCBkb2NzDQogDQpkb2MvZ3VpZGVzL25pY3MvZmVhdHVyZXMvc3hlMi5pbmkgICAg
ICAgICAgfCAgIDU2ICsNCmRvYy9ndWlkZXMvbmljcy9zeGUyLnJzdCAgICAgICAgICAgICAgICAg
ICB8ICAxNjggKysNCmRyaXZlcnMvY29tbW9uL3N4ZTIvc3hlMl9jb21tb24uYyAgICAgICAgICB8
ICAxNTYgKysNCmRyaXZlcnMvY29tbW9uL3N4ZTIvc3hlMl9jb21tb24uaCAgICAgICAgICB8ICAg
IDQgKw0KZHJpdmVycy9jb21tb24vc3hlMi9zeGUyX2Zsb3dfcHVibGljLmggICAgIHwgIDYzMyAr
KysrKysrDQpkcml2ZXJzL2NvbW1vbi9zeGUyL3N4ZTJfaW9jdGxfY2hubC5jICAgICAgfCAgMTc4
ICstDQpkcml2ZXJzL2NvbW1vbi9zeGUyL3N4ZTJfaW9jdGxfY2hubF9mdW5jLmggfCAgIDE4ICsN
CmRyaXZlcnMvY29tbW9uL3N4ZTIvc3hlMl9tc2cuaCAgICAgICAgICAgICB8ICAxMTggKysNCmRy
aXZlcnMvbmV0L3N4ZTIvbWVzb24uYnVpbGQgICAgICAgICAgICAgICB8ICAgNTIgKw0KZHJpdmVy
cy9uZXQvc3hlMi9zeGUyX2NtZF9jaG5sLmMgICAgICAgICAgIHwgMTU4NyArKysrKysrKysrKysr
KystDQpkcml2ZXJzL25ldC9zeGUyL3N4ZTJfY21kX2NobmwuaCAgICAgICAgICAgfCAgMTM5ICsr
DQpkcml2ZXJzL25ldC9zeGUyL3N4ZTJfZHJ2X2NtZC5oICAgICAgICAgICAgfCAgNTIzICsrKysr
LQ0KZHJpdmVycy9uZXQvc3hlMi9zeGUyX2R1bXAuYyAgICAgICAgICAgICAgIHwgIDI4NyArKysN
CmRyaXZlcnMvbmV0L3N4ZTIvc3hlMl9kdW1wLmggICAgICAgICAgICAgICB8ICAgMTIgKw0KZHJp
dmVycy9uZXQvc3hlMi9zeGUyX2V0aGRldi5jICAgICAgICAgICAgIHwgMTQ4NSArKysrKysrKysr
KysrKy0NCmRyaXZlcnMvbmV0L3N4ZTIvc3hlMl9ldGhkZXYuaCAgICAgICAgICAgICB8ICAxMTEg
Ky0NCmRyaXZlcnMvbmV0L3N4ZTIvc3hlMl9ldGhkZXZfcmVwci5jICAgICAgICB8ICA2MDkgKysr
KysrDQpkcml2ZXJzL25ldC9zeGUyL3N4ZTJfZXRoZGV2X3JlcHIuaCAgICAgICAgfCAgIDMyICsN
CmRyaXZlcnMvbmV0L3N4ZTIvc3hlMl9maWx0ZXIuYyAgICAgICAgICAgICB8ICA4OTUgKysrKysr
KysrDQpkcml2ZXJzL25ldC9zeGUyL3N4ZTJfZmlsdGVyLmggICAgICAgICAgICAgfCAgMTAwICsN
CmRyaXZlcnMvbmV0L3N4ZTIvc3hlMl9mbG93LmMgICAgICAgICAgICAgICB8IDEzOTQgKysrKysr
KysrKysrKysNCmRyaXZlcnMvbmV0L3N4ZTIvc3hlMl9mbG93LmggICAgICAgICAgICAgICB8ICAg
MzAgKw0KZHJpdmVycy9uZXQvc3hlMi9zeGUyX2Zsb3dfZGVmaW5lLmggICAgICAgIHwgIDE0NCAr
Kw0KZHJpdmVycy9uZXQvc3hlMi9zeGUyX2Zsb3dfcGFyc2VfYWN0aW9uLmMgIHwgMTE4MiArKysr
KysrKysrKysNCmRyaXZlcnMvbmV0L3N4ZTIvc3hlMl9mbG93X3BhcnNlX2FjdGlvbi5oICB8ICAg
MjMgKw0KZHJpdmVycy9uZXQvc3hlMi9zeGUyX2Zsb3dfcGFyc2VfZW5naW5lLmMgIHwgIDEwNiAr
Kw0KZHJpdmVycy9uZXQvc3hlMi9zeGUyX2Zsb3dfcGFyc2VfZW5naW5lLmggIHwgICAxMyArDQpk
cml2ZXJzL25ldC9zeGUyL3N4ZTJfZmxvd19wYXJzZV9wYXR0ZXJuLmMgfCAxOTM1ICsrKysrKysr
KysrKysrKysrKysNCmRyaXZlcnMvbmV0L3N4ZTIvc3hlMl9mbG93X3BhcnNlX3BhdHRlcm4uaCB8
ICAgNDYgKw0KZHJpdmVycy9uZXQvc3hlMi9zeGUyX2lwc2VjLmMgICAgICAgICAgICAgIHwgMTU2
NSArKysrKysrKysrKysrKysrDQpkcml2ZXJzL25ldC9zeGUyL3N4ZTJfaXBzZWMuaCAgICAgICAg
ICAgICAgfCAgMjU0ICsrKw0KZHJpdmVycy9uZXQvc3hlMi9zeGUyX2lycS5jICAgICAgICAgICAg
ICAgIHwgMTAyNiArKysrKysrKysrDQpkcml2ZXJzL25ldC9zeGUyL3N4ZTJfaXJxLmggICAgICAg
ICAgICAgICAgfCAgIDI1ICsNCmRyaXZlcnMvbmV0L3N4ZTIvc3hlMl9tYWMuYyAgICAgICAgICAg
ICAgICB8ICA1MzAgKysrKysrDQpkcml2ZXJzL25ldC9zeGUyL3N4ZTJfbWFjLmggICAgICAgICAg
ICAgICAgfCAgIDg0ICsNCmRyaXZlcnMvbmV0L3N4ZTIvc3hlMl9tcC5jICAgICAgICAgICAgICAg
ICB8ICA0MTQgKysrKysNCmRyaXZlcnMvbmV0L3N4ZTIvc3hlMl9tcC5oICAgICAgICAgICAgICAg
ICB8ICAgNjcgKw0KZHJpdmVycy9uZXQvc3hlMi9zeGUyX3F1ZXVlLmMgICAgICAgICAgICAgIHwg
ICAxNyArLQ0KZHJpdmVycy9uZXQvc3hlMi9zeGUyX3F1ZXVlLmggICAgICAgICAgICAgIHwgICAx
NSArLQ0KZHJpdmVycy9uZXQvc3hlMi9zeGUyX3Jzcy5jICAgICAgICAgICAgICAgIHwgIDU4NCAr
KysrKysNCmRyaXZlcnMvbmV0L3N4ZTIvc3hlMl9yc3MuaCAgICAgICAgICAgICAgICB8ICAgODEg
Kw0KZHJpdmVycy9uZXQvc3hlMi9zeGUyX3J4LmMgICAgICAgICAgICAgICAgIHwgICA5MyArLQ0K
ZHJpdmVycy9uZXQvc3hlMi9zeGUyX3J4LmggICAgICAgICAgICAgICAgIHwgICAgMiArDQpkcml2
ZXJzL25ldC9zeGUyL3N4ZTJfc2VjdXJpdHkuYyAgICAgICAgICAgfCAgMzM1ICsrKysNCmRyaXZl
cnMvbmV0L3N4ZTIvc3hlMl9zZWN1cml0eS5oICAgICAgICAgICB8ICAgNzcgKw0KZHJpdmVycy9u
ZXQvc3hlMi9zeGUyX3N0YXRzLmMgICAgICAgICAgICAgIHwgIDU4NiArKysrKysNCmRyaXZlcnMv
bmV0L3N4ZTIvc3hlMl9zdGF0cy5oICAgICAgICAgICAgICB8ICAgMzkgKw0KZHJpdmVycy9uZXQv
c3hlMi9zeGUyX3N3aXRjaGRldi5jICAgICAgICAgIHwgIDMzMiArKysrDQpkcml2ZXJzL25ldC9z
eGUyL3N4ZTJfc3dpdGNoZGV2LmggICAgICAgICAgfCAgIDMzICsNCmRyaXZlcnMvbmV0L3N4ZTIv
c3hlMl90bS5jICAgICAgICAgICAgICAgICB8IDExNTEgKysrKysrKysrKysrDQpkcml2ZXJzL25l
dC9zeGUyL3N4ZTJfdG0uaCAgICAgICAgICAgICAgICAgfCAgIDc2ICsNCmRyaXZlcnMvbmV0L3N4
ZTIvc3hlMl90eC5jICAgICAgICAgICAgICAgICB8ICAgIDcgKw0KZHJpdmVycy9uZXQvc3hlMi9z
eGUyX3R4cnguYyAgICAgICAgICAgICAgIHwgMTk1OCArKysrKysrKysrKysrKysrKysrLQ0KZHJp
dmVycy9uZXQvc3hlMi9zeGUyX3R4cnguaCAgICAgICAgICAgICAgIHwgICAgOCArDQpkcml2ZXJz
L25ldC9zeGUyL3N4ZTJfdHhyeF9jaGVja19tYnVmLmMgICAgfCAgNTk1ICsrKysrKw0KZHJpdmVy
cy9uZXQvc3hlMi9zeGUyX3R4cnhfY2hlY2tfbWJ1Zi5oICAgIHwgICAzOCArDQpkcml2ZXJzL25l
dC9zeGUyL3N4ZTJfdHhyeF9wb2xsLmMgICAgICAgICAgfCAgMjg0ICsrLQ0KZHJpdmVycy9uZXQv
c3hlMi9zeGUyX3R4cnhfdmVjLmMgICAgICAgICAgIHwgICA0NiArLQ0KZHJpdmVycy9uZXQvc3hl
Mi9zeGUyX3R4cnhfdmVjLmggICAgICAgICAgIHwgICAzOCArLQ0KZHJpdmVycy9uZXQvc3hlMi9z
eGUyX3R4cnhfdmVjX2F2eDIuYyAgICAgIHwgIDc0NyArKysrKysrKw0KZHJpdmVycy9uZXQvc3hl
Mi9zeGUyX3R4cnhfdmVjX2F2eDUxMi5jICAgIHwgIDg2NyArKysrKysrKysNCmRyaXZlcnMvbmV0
L3N4ZTIvc3hlMl90eHJ4X3ZlY19jb21tb24uaCAgICB8ICAgNTQgKy0NCmRyaXZlcnMvbmV0L3N4
ZTIvc3hlMl90eHJ4X3ZlY19uZW9uLmMgICAgICB8ICA2ODkgKysrKysrKw0KZHJpdmVycy9uZXQv
c3hlMi9zeGUyX3R4cnhfdmVjX3NzZS5jICAgICAgIHwgICAzOCArLQ0KZHJpdmVycy9uZXQvc3hl
Mi9zeGUyX3ZzaS5jICAgICAgICAgICAgICAgIHwgIDE0NiArKw0KZHJpdmVycy9uZXQvc3hlMi9z
eGUyX3ZzaS5oICAgICAgICAgICAgICAgIHwgICAxMiArLQ0KZHJpdmVycy9uZXQvc3hlMi9zeGUy
dmZfcmVncy5oICAgICAgICAgICAgIHwgICA4NSArDQo2NyBmaWxlcyBjaGFuZ2VkLCAyNDc2MSBp
bnNlcnRpb25zKCspLCAyNzMgZGVsZXRpb25zKC0pDQpjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVy
cy9jb21tb24vc3hlMi9zeGUyX2Zsb3dfcHVibGljLmgNCmNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2
ZXJzL2NvbW1vbi9zeGUyL3N4ZTJfbXNnLmgNCmNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL25l
dC9zeGUyL3N4ZTJfZHVtcC5jDQpjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9uZXQvc3hlMi9z
eGUyX2R1bXAuaA0KY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbmV0L3N4ZTIvc3hlMl9ldGhk
ZXZfcmVwci5jDQpjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9uZXQvc3hlMi9zeGUyX2V0aGRl
dl9yZXByLmgNCmNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL25ldC9zeGUyL3N4ZTJfZmlsdGVy
LmMNCmNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL25ldC9zeGUyL3N4ZTJfZmlsdGVyLmgNCmNy
ZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL25ldC9zeGUyL3N4ZTJfZmxvdy5jDQpjcmVhdGUgbW9k
ZSAxMDA2NDQgZHJpdmVycy9uZXQvc3hlMi9zeGUyX2Zsb3cuaA0KY3JlYXRlIG1vZGUgMTAwNjQ0
IGRyaXZlcnMvbmV0L3N4ZTIvc3hlMl9mbG93X2RlZmluZS5oDQpjcmVhdGUgbW9kZSAxMDA2NDQg
ZHJpdmVycy9uZXQvc3hlMi9zeGUyX2Zsb3dfcGFyc2VfYWN0aW9uLmMNCmNyZWF0ZSBtb2RlIDEw
MDY0NCBkcml2ZXJzL25ldC9zeGUyL3N4ZTJfZmxvd19wYXJzZV9hY3Rpb24uaA0KY3JlYXRlIG1v
ZGUgMTAwNjQ0IGRyaXZlcnMvbmV0L3N4ZTIvc3hlMl9mbG93X3BhcnNlX2VuZ2luZS5jDQpjcmVh
dGUgbW9kZSAxMDA2NDQgZHJpdmVycy9uZXQvc3hlMi9zeGUyX2Zsb3dfcGFyc2VfZW5naW5lLmgN
CmNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL25ldC9zeGUyL3N4ZTJfZmxvd19wYXJzZV9wYXR0
ZXJuLmMNCmNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL25ldC9zeGUyL3N4ZTJfZmxvd19wYXJz
ZV9wYXR0ZXJuLmgNCmNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL25ldC9zeGUyL3N4ZTJfaXBz
ZWMuYw0KY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbmV0L3N4ZTIvc3hlMl9pcHNlYy5oDQpj
cmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9uZXQvc3hlMi9zeGUyX2lycS5jDQpjcmVhdGUgbW9k
ZSAxMDA2NDQgZHJpdmVycy9uZXQvc3hlMi9zeGUyX21hYy5jDQpjcmVhdGUgbW9kZSAxMDA2NDQg
ZHJpdmVycy9uZXQvc3hlMi9zeGUyX21hYy5oDQpjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9u
ZXQvc3hlMi9zeGUyX21wLmMNCmNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL25ldC9zeGUyL3N4
ZTJfbXAuaA0KY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbmV0L3N4ZTIvc3hlMl9yc3MuYw0K
Y3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbmV0L3N4ZTIvc3hlMl9yc3MuaA0KY3JlYXRlIG1v
ZGUgMTAwNjQ0IGRyaXZlcnMvbmV0L3N4ZTIvc3hlMl9zZWN1cml0eS5jDQpjcmVhdGUgbW9kZSAx
MDA2NDQgZHJpdmVycy9uZXQvc3hlMi9zeGUyX3NlY3VyaXR5LmgNCmNyZWF0ZSBtb2RlIDEwMDY0
NCBkcml2ZXJzL25ldC9zeGUyL3N4ZTJfc3RhdHMuYw0KY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZl
cnMvbmV0L3N4ZTIvc3hlMl9zdGF0cy5oDQpjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9uZXQv
c3hlMi9zeGUyX3N3aXRjaGRldi5jDQpjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9uZXQvc3hl
Mi9zeGUyX3N3aXRjaGRldi5oDQpjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9uZXQvc3hlMi9z
eGUyX3RtLmMNCmNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL25ldC9zeGUyL3N4ZTJfdG0uaA0K
Y3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbmV0L3N4ZTIvc3hlMl90eHJ4X2NoZWNrX21idWYu
Yw0KY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbmV0L3N4ZTIvc3hlMl90eHJ4X2NoZWNrX21i
dWYuaA0KY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbmV0L3N4ZTIvc3hlMl90eHJ4X3ZlY19h
dngyLmMNCmNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL25ldC9zeGUyL3N4ZTJfdHhyeF92ZWNf
YXZ4NTEyLmMNCmNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL25ldC9zeGUyL3N4ZTJfdHhyeF92
ZWNfbmVvbi5jDQpjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9uZXQvc3hlMi9zeGUydmZfcmVn
cy5oDQogDQotLSANCjIuNTIuMA0K

------=_001_NextPart756487230228_=----
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charse=
t=3Dus-ascii"><style>body { line-height: 1.5; }blockquote { margin-top: 0p=
x; margin-bottom: 0px; margin-left: 0.5em; }.fox_html_content_dummy_textar=
ea { position: absolute; overflow: hidden; width: 1px; height: 1px; opacit=
y: 0; }body { font-size: 14px; font-family: "Microsoft YaHei UI"; color: r=
gb(0, 0, 0); line-height: 1.5; }</style></head><body>=0A<div><span></span>=
Hi stephen,</div><div><br></div><div>Please ignore v7 patch/series. I foun=
d an issue and will send a revised version (v8) shortly.</div>=0A<div><br>=
</div><hr style=3D"width: 210px; height: 1px;" color=3D"#b5c4df" size=3D"1=
" align=3D"left">=0A<div><span><div style=3D"MARGIN: 10px; FONT-FAMILY: ve=
rdana; FONT-SIZE: 10pt"><div>liujie5@linkdatatechnology.com</div></div></s=
pan></div>=0A<blockquote style=3D"margin-Top: 0px; margin-Bottom: 0px; mar=
gin-Left: 0.5em; margin-Right: inherit"><div>&nbsp;</div><div style=3D"bor=
der:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm 0cm 0cm"><div st=
yle=3D"PADDING-RIGHT: 8px; PADDING-LEFT: 8px; FONT-SIZE: 12px;FONT-FAMILY:=
tahoma;COLOR:#000000; BACKGROUND: #efefef; PADDING-BOTTOM: 8px; PADDING-TO=
P: 8px"><div><b>From:</b>&nbsp;<a href=3D"mailto:liujie5@linkdatatechnolog=
y.com">liujie5</a></div><div><b>Date:</b>&nbsp;2026-06-25&nbsp;13:41</div>=
<div><b>To:</b>&nbsp;<a href=3D"mailto:stephen@networkplumber.org">stephen=
</a></div><div><b>CC:</b>&nbsp;<a href=3D"mailto:dev@dpdk.org">dev</a>; <a=
 href=3D"mailto:liujie5@linkdatatechnology.com">Jie Liu</a></div><div><b>S=
ubject:</b>&nbsp;[PATCH v7 00/23] net/sxe2: added Linkdata sxe2 ethernet d=
river</div></div></div><div><div>From: Jie Liu &lt;liujie5@linkdatatechnol=
ogy.com&gt;</div>=0A<div>&nbsp;</div>=0A<div>This patch set implements cor=
e functionality for the SXE2 PMD,</div>=0A<div>including basic driver fram=
ework, data path setup, and advanced</div>=0A<div>offload features (VLAN, =
RSS,TM, PTP etc.).</div>=0A<div>&nbsp;</div>=0A<div>V7:</div>=0A<div>	- Ad=
d support for flow duplicate pattern.</div>=0A<div>&nbsp;</div>=0A<div>Jie=
 Liu (23):</div>=0A<div>&nbsp; net/sxe2: remove software statistics devarg=
s</div>=0A<div>&nbsp; net/sxe2: add Rx framework and packet types callback=
</div>=0A<div>&nbsp; net/sxe2: support AVX512 vectorized path for Rx and T=
x</div>=0A<div>&nbsp; net/sxe2: add AVX2 vector data path for Rx and Tx</d=
iv>=0A<div>&nbsp; net/sxe2: add link update callback</div>=0A<div>&nbsp; n=
et/sxe2: support L2 filtering and MAC config</div>=0A<div>&nbsp; drivers: =
support RSS feature</div>=0A<div>&nbsp; net/sxe2: support TM hierarchy and=
 shaping</div>=0A<div>&nbsp; net/sxe2: support IPsec inline protocol offlo=
ad</div>=0A<div>&nbsp; net/sxe2: support statistics and multi-process</div=
>=0A<div>&nbsp; drivers: interrupt handling</div>=0A<div>&nbsp; net/sxe2: =
add NEON vec Rx/Tx burst functions</div>=0A<div>&nbsp; drivers: add suppor=
t for VF representors</div>=0A<div>&nbsp; net/sxe2: add support for custom=
 UDP tunnel ports</div>=0A<div>&nbsp; net/sxe2: support firmware version r=
eading</div>=0A<div>&nbsp; net/sxe2: implement get monitor address</div>=
=0A<div>&nbsp; common/sxe2: add shared SFP module definitions</div>=0A<div=
>&nbsp; net/sxe2: support SFP module info and EEPROM access</div>=0A<div>&=
nbsp; net/sxe2: add mbuf validation in Tx debug mode</div>=0A<div>&nbsp; c=
ommon/sxe2: add callback for memory event handling</div>=0A<div>&nbsp; net=
/sxe2: add private devargs parsing</div>=0A<div>&nbsp; net/sxe2: implement=
 private dump info</div>=0A<div>&nbsp; net/sxe2: update sxe2 feature matri=
x docs</div>=0A<div>&nbsp;</div>=0A<div> doc/guides/nics/features/sxe2.ini=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 56 +<=
/div>=0A<div> doc/guides/nics/sxe2.rst&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |=
&nbsp; 168 ++</div>=0A<div> drivers/common/sxe2/sxe2_common.c&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 156 ++</div>=0A<div> dri=
vers/common/sxe2/sxe2_common.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; |&nbsp;&nbsp;&nbsp; 4 +</div>=0A<div> drivers/common/sxe2/sxe2_=
flow_public.h&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 633 +++++++</div>=0A<div> dr=
ivers/common/sxe2/sxe2_ioctl_chnl.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; =
178 +-</div>=0A<div> drivers/common/sxe2/sxe2_ioctl_chnl_func.h |&nbsp;&nb=
sp; 18 +</div>=0A<div> drivers/common/sxe2/sxe2_msg.h&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 118 ++</div>=
=0A<div> drivers/net/sxe2/meson.build&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 52 +</div>=
=0A<div> drivers/net/sxe2/sxe2_cmd_chnl.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; | 1587 +++++++++++++++-</div>=0A<div> drivers/=
net/sxe2/sxe2_cmd_chnl.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; |&nbsp; 139 ++</div>=0A<div> drivers/net/sxe2/sxe2_drv_cmd.h&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 52=
3 +++++-</div>=0A<div> drivers/net/sxe2/sxe2_dump.c&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 287 =
+++</div>=0A<div> drivers/net/sxe2/sxe2_dump.h&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 12 =
+</div>=0A<div> drivers/net/sxe2/sxe2_ethdev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 1485 ++++++++++++++-</div>=
=0A<div> drivers/net/sxe2/sxe2_ethdev.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 111 +-</div>=0A<div> drivers=
/net/sxe2/sxe2_ethdev_repr.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&n=
bsp; 609 ++++++</div>=0A<div> drivers/net/sxe2/sxe2_ethdev_repr.h&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 32 +</div>=0A<div> drivers=
/net/sxe2/sxe2_filter.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; |&nbsp; 895 +++++++++</div>=0A<div> drivers/net/sxe2=
/sxe2_filter.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; |&nbsp; 100 +</div>=0A<div> drivers/net/sxe2/sxe2_flow.c&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; | 1394 ++++++++++++++</div>=0A<div> drivers/net/sxe2/sxe2_flow.h&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; |&nbsp;&nbsp; 30 +</div>=0A<div> drivers/net/sxe2/sxe2_flow_define.=
h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 144 ++</div>=0A<div> d=
rivers/net/sxe2/sxe2_flow_parse_action.c&nbsp; | 1182 ++++++++++++</div>=
=0A<div> drivers/net/sxe2/sxe2_flow_parse_action.h&nbsp; |&nbsp;&nbsp; 23 =
+</div>=0A<div> drivers/net/sxe2/sxe2_flow_parse_engine.c&nbsp; |&nbsp; 10=
6 ++</div>=0A<div> drivers/net/sxe2/sxe2_flow_parse_engine.h&nbsp; |&nbsp;=
&nbsp; 13 +</div>=0A<div> drivers/net/sxe2/sxe2_flow_parse_pattern.c | 193=
5 +++++++++++++++++++</div>=0A<div> drivers/net/sxe2/sxe2_flow_parse_patte=
rn.h |&nbsp;&nbsp; 46 +</div>=0A<div> drivers/net/sxe2/sxe2_ipsec.c&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | =
1565 ++++++++++++++++</div>=0A<div> drivers/net/sxe2/sxe2_ipsec.h&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nb=
sp; 254 +++</div>=0A<div> drivers/net/sxe2/sxe2_irq.c&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 10=
26 ++++++++++</div>=0A<div> drivers/net/sxe2/sxe2_irq.h&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&=
nbsp;&nbsp; 25 +</div>=0A<div> drivers/net/sxe2/sxe2_mac.c&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 |&nbsp; 530 ++++++</div>=0A<div> drivers/net/sxe2/sxe2_mac.h&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; |&nbsp;&nbsp; 84 +</div>=0A<div> drivers/net/sxe2/sxe2_mp.c&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp; 414 +++++</div>=0A<div> drivers/net/sxe2/sxe2_mp.h&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 67 +</div>=0A<div> drivers/net/sxe2/sxe2_=
queue.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp;&nbsp; 17 +-</div>=0A<div> drivers/net/sxe2/sxe2_queue.=
h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; |&nbsp;&nbsp; 15 +-</div>=0A<div> drivers/net/sxe2/sxe2_rss.c&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; |&nbsp; 584 ++++++</div>=0A<div> drivers/net/sxe2/sxe2_rss.h&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; |&nbsp;&nbsp; 81 +</div>=0A<div> drivers/net/sxe2/sxe2_rx.c&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 93 +-</div>=0A<div> drivers/net/sxe2/sx=
e2_rx.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; 2 +</div>=0A<div> driver=
s/net/sxe2/sxe2_security.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; |&nbsp; 335 ++++</div>=0A<div> drivers/net/sxe2/sxe2_security=
.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbs=
p; 77 +</div>=0A<div> drivers/net/sxe2/sxe2_stats.c&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 586 ++++++=
</div>=0A<div> drivers/net/sxe2/sxe2_stats.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 39 +</div>=
=0A<div> drivers/net/sxe2/sxe2_switchdev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; |&nbsp; 332 ++++</div>=0A<div> drivers/net/sxe2/sxe=
2_switchdev.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp=
;&nbsp; 33 +</div>=0A<div> drivers/net/sxe2/sxe2_tm.c&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; | 1151 ++++++++++++</div>=0A<div> drivers/net/sxe2/sxe2_tm.h&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; |&nbsp;&nbsp; 76 +</div>=0A<div> drivers/net/sxe2/sxe2_tx.c&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; 7 +</div>=0A<div> drivers/net/sxe2/=
sxe2_txrx.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; | 1958 +++++++++++++++++++-</div>=0A<div> drivers/ne=
t/sxe2/sxe2_txrx.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; 8 +</div>=0A<div> drivers=
/net/sxe2/sxe2_txrx_check_mbuf.c&nbsp;&nbsp;&nbsp; |&nbsp; 595 ++++++</div=
>=0A<div> drivers/net/sxe2/sxe2_txrx_check_mbuf.h&nbsp;&nbsp;&nbsp; |&nbsp=
;&nbsp; 38 +</div>=0A<div> drivers/net/sxe2/sxe2_txrx_poll.c&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 284 ++-</div>=0A<div> dri=
vers/net/sxe2/sxe2_txrx_vec.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; |&nbsp;&nbsp; 46 +-</div>=0A<div> drivers/net/sxe2/sxe2_tx=
rx_vec.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbs=
p;&nbsp; 38 +-</div>=0A<div> drivers/net/sxe2/sxe2_txrx_vec_avx2.c&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; |&nbsp; 747 ++++++++</div>=0A<div> drivers/net/sxe2=
/sxe2_txrx_vec_avx512.c&nbsp;&nbsp;&nbsp; |&nbsp; 867 +++++++++</div>=0A<d=
iv> drivers/net/sxe2/sxe2_txrx_vec_common.h&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp=
; 54 +-</div>=0A<div> drivers/net/sxe2/sxe2_txrx_vec_neon.c&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; |&nbsp; 689 +++++++</div>=0A<div> drivers/net/sxe2/sxe2_tx=
rx_vec_sse.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 38 +-</div>=
=0A<div> drivers/net/sxe2/sxe2_vsi.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 146 ++</div>=
=0A<div> drivers/net/sxe2/sxe2_vsi.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 12 +-</=
div>=0A<div> drivers/net/sxe2/sxe2vf_regs.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 85 +</div>=0A<div>=
 67 files changed, 24761 insertions(+), 273 deletions(-)</div>=0A<div> cre=
ate mode 100644 drivers/common/sxe2/sxe2_flow_public.h</div>=0A<div> creat=
e mode 100644 drivers/common/sxe2/sxe2_msg.h</div>=0A<div> create mode 100=
644 drivers/net/sxe2/sxe2_dump.c</div>=0A<div> create mode 100644 drivers/=
net/sxe2/sxe2_dump.h</div>=0A<div> create mode 100644 drivers/net/sxe2/sxe=
2_ethdev_repr.c</div>=0A<div> create mode 100644 drivers/net/sxe2/sxe2_eth=
dev_repr.h</div>=0A<div> create mode 100644 drivers/net/sxe2/sxe2_filter.c=
</div>=0A<div> create mode 100644 drivers/net/sxe2/sxe2_filter.h</div>=0A<=
div> create mode 100644 drivers/net/sxe2/sxe2_flow.c</div>=0A<div> create =
mode 100644 drivers/net/sxe2/sxe2_flow.h</div>=0A<div> create mode 100644 =
drivers/net/sxe2/sxe2_flow_define.h</div>=0A<div> create mode 100644 drive=
rs/net/sxe2/sxe2_flow_parse_action.c</div>=0A<div> create mode 100644 driv=
ers/net/sxe2/sxe2_flow_parse_action.h</div>=0A<div> create mode 100644 dri=
vers/net/sxe2/sxe2_flow_parse_engine.c</div>=0A<div> create mode 100644 dr=
ivers/net/sxe2/sxe2_flow_parse_engine.h</div>=0A<div> create mode 100644 d=
rivers/net/sxe2/sxe2_flow_parse_pattern.c</div>=0A<div> create mode 100644=
 drivers/net/sxe2/sxe2_flow_parse_pattern.h</div>=0A<div> create mode 1006=
44 drivers/net/sxe2/sxe2_ipsec.c</div>=0A<div> create mode 100644 drivers/=
net/sxe2/sxe2_ipsec.h</div>=0A<div> create mode 100644 drivers/net/sxe2/sx=
e2_irq.c</div>=0A<div> create mode 100644 drivers/net/sxe2/sxe2_mac.c</div=
>=0A<div> create mode 100644 drivers/net/sxe2/sxe2_mac.h</div>=0A<div> cre=
ate mode 100644 drivers/net/sxe2/sxe2_mp.c</div>=0A<div> create mode 10064=
4 drivers/net/sxe2/sxe2_mp.h</div>=0A<div> create mode 100644 drivers/net/=
sxe2/sxe2_rss.c</div>=0A<div> create mode 100644 drivers/net/sxe2/sxe2_rss=
.h</div>=0A<div> create mode 100644 drivers/net/sxe2/sxe2_security.c</div>=
=0A<div> create mode 100644 drivers/net/sxe2/sxe2_security.h</div>=0A<div>=
 create mode 100644 drivers/net/sxe2/sxe2_stats.c</div>=0A<div> create mod=
e 100644 drivers/net/sxe2/sxe2_stats.h</div>=0A<div> create mode 100644 dr=
ivers/net/sxe2/sxe2_switchdev.c</div>=0A<div> create mode 100644 drivers/n=
et/sxe2/sxe2_switchdev.h</div>=0A<div> create mode 100644 drivers/net/sxe2=
/sxe2_tm.c</div>=0A<div> create mode 100644 drivers/net/sxe2/sxe2_tm.h</di=
v>=0A<div> create mode 100644 drivers/net/sxe2/sxe2_txrx_check_mbuf.c</div=
>=0A<div> create mode 100644 drivers/net/sxe2/sxe2_txrx_check_mbuf.h</div>=
=0A<div> create mode 100644 drivers/net/sxe2/sxe2_txrx_vec_avx2.c</div>=0A=
<div> create mode 100644 drivers/net/sxe2/sxe2_txrx_vec_avx512.c</div>=0A<=
div> create mode 100644 drivers/net/sxe2/sxe2_txrx_vec_neon.c</div>=0A<div=
> create mode 100644 drivers/net/sxe2/sxe2vf_regs.h</div>=0A<div>&nbsp;</d=
iv>=0A<div>-- </div>=0A<div>2.52.0</div>=0A</div></blockquote>=0A</body></=
html>
------=_001_NextPart756487230228_=------

