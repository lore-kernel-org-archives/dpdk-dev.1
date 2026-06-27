Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355D7C43458
	for <dpdk-dev@archiver.kernel.org>; Sat, 27 Jun 2026 04:00:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 090AA40272;
	Sat, 27 Jun 2026 06:00:53 +0200 (CEST)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by mails.dpdk.org (Postfix) with ESMTP id 500A140265
 for <dev@dpdk.org>; Sat, 27 Jun 2026 06:00:50 +0200 (CEST)
Received: from LAPTOP-ARGRBVTN (unknown [101.207.145.153])
 by APP-01 (Coremail) with SMTP id qwCowACXOtPuSj9qx+WBAw--.60317S2;
 Sat, 27 Jun 2026 12:00:47 +0800 (CST)
Date: Sat, 27 Jun 2026 12:00:47 +0800
From: "liujie5@linkdatatechnology.com" <liujie5@linkdatatechnology.com>
To: stephen <stephen@networkplumber.org>
Cc: dev <dev@dpdk.org>
Subject: Re: Re: [PATCH v9 19/23] net/sxe2: add mbuf validation in Tx debug
 mode
References: <220260625133139.207632-1-liujie5@linkdatatechnology.com>, 
 <20260626064751.361466-1-liujie5@linkdatatechnology.com>, 
 <20260626112114.1eddd05e@phoenix.local>
X-Priority: 3
X-Has-Attach: no
X-Mailer: Foxmail 7.2.25.542[cn]
Mime-Version: 1.0
Message-ID: <202606271200459896791@linkdatatechnology.com>
Content-Type: multipart/alternative;
 boundary="----=_001_NextPart517335866614_=----"
X-CM-TRANSID: qwCowACXOtPuSj9qx+WBAw--.60317S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWFW3GrWrWFyUtF1DuFWDXFb_yoW7Jry3p3
 y8Kry5ZFs5Jr4I9wn2yw48CF1Fvw4kJF45Was8Gry7Awn8Xry0kFW3tFyYva43Cr4Fqw1F
 va90qr9rC3WDuaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUBCb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4
 A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVCF0I0E
 4I0vr24l5I8CrVC2j2CEjI02ccxYII8I67AEr4CY67k08wAv7VC0I7IYx2IY67AKxVWUJV
 WUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAK
 I48JM4xvF2IEb7IF0Fy264kE64k0F24lFcxC0VAYjxAxZF0Ex2IqxwCF04k20xvY0x0EwI
 xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r106r1rMI8I3I0E7480
 Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7
 IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k2
 6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
 AFwI0_Jr0_Gr1l6VACY4xI67k04243AbIYCTnIWIevJa73UjIFyTuYvjxUg8u4UUUUU
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

------=_001_NextPart517335866614_=----
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: base64

SGkgU3RlcGhlbiwNCg0KSW50cm9kdWNlIHRoZSAnc3hlMl90eHJ4X2NoZWNrX21idWYnIGhlbHBl
ciBmdW5jdGlvbiB0byB2YWxpZGF0ZQ0Kb3V0Z29pbmcgbWJ1ZiB0dW5uZWwgdHlwZSBmbGFncyB3
aGVuIFJURV9FVEhERVZfREVCVUdfVFggaXMgZW5hYmxlZC4NClRoZSBmdW5jdGlvbiBjaGVja3Mg
dGhhdCB0aGUgUlRFX01CVUZfRl9UWF9UVU5ORUxfeCBmbGFnIGluIG1idWYNCm9sX2ZsYWdzIG1h
dGNoZXMgdGhlIGFjdHVhbCB0dW5uZWwgcHJvdG9jb2wgZGV0ZWN0ZWQgaW4gdGhlIHBhY2tldA0K
KEdUUCwgVlhMQU4sIFZYTEFOLUdQRSwgR2VuZXZlLCBHUkUsIG9yIElQSVApLg0KDQpUaGUgdmFs
aWRhdGlvbiB1c2VzIG9ubHkgVURQIHBvcnQgbWF0Y2hpbmcgYW5kIEw0IHByb3RvY29sIGRldGVj
dGlvbjsNCml0IGRvZXMgTk9UIHJlLWRlcml2ZSBoZWFkZXIgbGVuZ3RocyBvciBjaGVja3N1bSBm
aWVsZHMgYWxyZWFkeQ0KdmVyaWZpZWQgYnkgcnRlX3ZhbGlkYXRlX3R4X29mZmxvYWQoKSBhbmQg
cnRlX25ldF9pbnRlbF9ja3N1bV9wcmVwYXJlKCkuDQoNCkFsbCBjb2RlIGlzIHdyYXBwZWQgaW5z
aWRlIFJURV9FVEhERVZfREVCVUdfVFggY29uZGl0aW9uYWwgY29tcGlsYXRpb24NCnRvIGVuc3Vy
ZSB6ZXJvIG92ZXJoZWFkIGluIHByb2R1Y3Rpb24gYnVpbGRzLg0KDQoNCmxpdWppZTVAbGlua2Rh
dGF0ZWNobm9sb2d5LmNvbQ0KIA0KRnJvbTogU3RlcGhlbiBIZW1taW5nZXINCkRhdGU6IDIwMjYt
MDYtMjcgMDI6MjENClRvOiBsaXVqaWU1DQpDQzogZGV2DQpTdWJqZWN0OiBSZTogW1BBVENIIHY5
IDE5LzIzXSBuZXQvc3hlMjogYWRkIG1idWYgdmFsaWRhdGlvbiBpbiBUeCBkZWJ1ZyBtb2RlDQpP
biBGcmksIDI2IEp1biAyMDI2IDE0OjQ3OjUxICswODAwDQpsaXVqaWU1QGxpbmtkYXRhdGVjaG5v
bG9neS5jb20gd3JvdGU6DQogDQo+IEZyb206IEppZSBMaXUgPGxpdWppZTVAbGlua2RhdGF0ZWNo
bm9sb2d5LmNvbT4NCj4gDQo+IEludHJvZHVjZSB0aGUgYHN4ZTJfdHhyeF9jaGVja19tYnVmYCBo
ZWxwZXIgZnVuY3Rpb24gdG8gdmFsaWRhdGUgb3V0Z29pbmcNCj4gbWJ1ZnMgd2hlbiBgUlRFX0VU
SERFVl9ERUJVR19UWGAgaXMgZW5hYmxlZC4gVGhpcyBoZWxwcyBkZXZlbG9wZXJzIGNhdGNoDQo+
IG1hbGZvcm1lZCBtYnVmcyAoZS5nLiwgaW52YWxpZCBzZWdtZW50IGxlbmd0aHMsIGJhZCBvZmZs
b2FkIGZsYWdzLCBvcg0KPiB1bmFsaWduZWQgYnVmZmVycykgYmVmb3JlIHBhc3NpbmcgdGhlbSB0
byB0aGUgaGFyZHdhcmUgcmluZ3MsIGF2b2lkaW5nDQo+IHBvdGVudGlhbCBoYXJkd2FyZSBoYW5n
cyBvciBzaWxlbnQgcGFja2V0IGRyb3BzLg0KPiANCj4gVGhlIHZhbGlkYXRpb24gaXMgZnVsbHkg
d3JhcHBlZCBpbnNpZGUgYFJURV9FVEhERVZfREVCVUdfVFhgIGNvbmRpdGlvbmFsDQo+IGNvbXBp
bGF0aW9uIGJsb2NrcyB0byBlbnN1cmUgemVybyBwZXJmb3JtYW5jZSBvdmVyaGVhZCBpbiBzdGFu
ZGFyZA0KPiBwcm9kdWN0aW9uIGJ1aWxkcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEppZSBMaXUg
PGxpdWppZTVAbGlua2RhdGF0ZWNobm9sb2d5LmNvbT4NCj4gLS0tDQogDQpJIGRvbid0IHRoaW5r
IEkgd2FzIGNsZWFyIGVub3VnaCBiZWZvcmUsIHRoZSB2ZXJib3NlIGRlc2NyaXB0aW9uIGlzOg0K
IA0KIA0KQ3VycmVudCBzdGF0ZSAodjkpOg0KIA0KVGhlIG5ldyBzeGUyX3R4cnhfY2hlY2tfbWJ1
ZigpIGhlbHBlciBhZGRlZCBpbiAxOS8yMyBpcyBjYWxsZWQgb25seQ0KZnJvbSBzeGUyX3R4X3Br
dHNfcHJlcGFyZSgpLCB3aGljaCBpcyB0aGUgZHJpdmVyJ3MgdHhfcHJlcGFyZQ0KY2FsbGJhY2su
IEl0IGlzIG5vdCBjYWxsZWQgZnJvbSBhbnkgdHhfYnVyc3QgcGF0aCAoc3hlMl90eF9wa3RzLCB0
aGUNCnZlYyBwYXRocywgdGhlIHBvbGwgcGF0aCkuDQogDQpUaGUgY29tbWl0IG1lc3NhZ2UgY2xh
aW1zIHRoZSB2YWxpZGF0aW9uIGlzICJmdWxseSB3cmFwcGVkIGluc2lkZQ0KUlRFX0VUSERFVl9E
RUJVR19UWCBjb25kaXRpb25hbCBjb21waWxhdGlvbiBibG9ja3MgdG8gZW5zdXJlIHplcm8NCnBl
cmZvcm1hbmNlIG92ZXJoZWFkIGluIHN0YW5kYXJkIHByb2R1Y3Rpb24gYnVpbGRzLiIgVGhpcyBp
cyBub3Qgd2hhdA0KdGhlIGNvZGUgZG9lcy4gVGhlcmUgaXMgbm8gI2lmZGVmIFJURV9FVEhERVZf
REVCVUdfVFggYW55d2hlcmUgaW4gdGhlDQpuZXcgZmlsZSBvciBhcm91bmQgdGhlIG5ldyBjYWxs
IHNpdGUuIEluIGZhY3QgdGhlIHBhdGNoICpyZW1vdmVzKiBhbg0KZXhpc3RpbmcgI2lmZGVmIFJU
RV9FVEhERVZfREVCVUdfVFggdGhhdCBwcmV2aW91c2x5IGdhdGVkDQpydGVfdmFsaWRhdGVfdHhf
b2ZmbG9hZCgpIGluIHRoZSBzYW1lIGxvb3AsIG1ha2luZyB0aGF0IGFsd2F5cy1vbiB0b28uDQog
DQpUaGUgbmV3IGZ1bmN0aW9uIGlzIG1hcmtlZCBfX3J0ZV91bnVzZWQgYm90aCBpbiB0aGUgaGVh
ZGVyDQpkZWNsYXJhdGlvbiBhbmQgaW4gdGhlIC5jIGRlZmluaXRpb24sIGV2ZW4gdGhvdWdoIGl0
IGhhcyBleGFjdGx5IG9uZQ0KY2FsbGVyLiBUaGF0IGF0dHJpYnV0ZSB3YXMgbGlrZWx5IGEgbGVm
dG92ZXIgZnJvbSBhbiBlYXJsaWVyIGRyYWZ0DQp3aGVyZSB0aGUgZnVuY3Rpb24gd2FzIG9ubHkg
Y29uZGl0aW9uYWxseSByZWZlcmVuY2VkLg0KIA0KVGhlIHZhbGlkYXRpb24gaXRzZWxmICg1OTUg
bGluZXMpIHJlLWRlcml2ZXMgb3V0ZXIvaW5uZXIgTDIvTDMvTDQNCmxlbmd0aHMgZnJvbSB0aGUg
cGFja2V0IGJ5dGVzIGFuZCBjb21wYXJlcyB0aGVtIGFnYWluc3Qgd2hhdCB0aGUgbWJ1Zg0KaGVh
ZGVyIGRlY2xhcmVzIC0gaS5lLiwgaXQncyB2ZXJpZnlpbmcgdGhhdCB0aGUgYXBwbGljYXRpb24N
CmNvcnJlY3RseSBzZXQgbWJ1Zi0+bDJfbGVuLCBsM19sZW4sIG91dGVyX2wyX2xlbiwgZXRjLiBi
ZWZvcmUNCnN1Ym1pdHRpbmcuIE11Y2ggb2YgdGhpcyBvdmVybGFwcyB3aGF0IHJ0ZV92YWxpZGF0
ZV90eF9vZmZsb2FkKCkgYW5kDQpydGVfbmV0X2ludGVsX2Nrc3VtX3ByZXBhcmUoKSBhbHJlYWR5
IGNoZWNrLCBib3RoIG9mIHdoaWNoIGFyZSBjYWxsZWQNCmluIHRoZSBzYW1lIHR4X3ByZXBhcmUg
bG9vcC4NCiANCkRlc2lyZWQgc3RhdGU6DQogDQp0eF9idXJzdCBzaG91bGQgbm90IGNvbnRhaW4g
dmFsaWRhdGlvbiBjaGVja3MgZm9yIGFwcGxpY2F0aW9uIGVycm9ycy4NClRoZSBmYXN0IHBhdGgg
cnVucyBvbmNlIHBlciBwYWNrZXQgYXQgbGluZSByYXRlLCBhbmQgYW55IGJyYW5jaCB0aGF0DQpl
eGlzdHMgdG8gY2F0Y2ggYSBjYWxsZXIgYnVnIGlzIHBhaWQgb24gZXZlcnkgd2VsbC1iZWhhdmVk
IHBhY2tldA0KZm9yZXZlci4gRm9yIGRyaXZlciBhc3N1bXB0aW9ucyB0aGF0IGFuIGFwcGxpY2F0
aW9uIG11c3Qgc2F0aXNmeSwNCnRoZSB0aHJlZSBzZW5zaWJsZSBvcHRpb25zIGFyZToNCiANCiAg
MS4gUlRFX0FTU0VSVCgpIC0gY29tcGlsZXMgb3V0IGluIHJlbGVhc2UgYnVpbGRzLCBzdXJmYWNl
cyB0aGUNCiAgICAgYXNzdW1wdGlvbiB0byBzdGF0aWMgYW5hbHl6ZXJzLCBhbmQgZmlyZXMgZm9y
IHVzZXJzIHJ1bm5pbmcNCiAgICAgZGVidWcgYnVpbGRzLg0KIA0KICAyLiB1bmxpa2VseSgpIHdp
dGggZHJvcC1hbmQtY291bnRlciAtIGlmIHRoZSBjaGVjayBpcyBjaGVhcCBhbmQNCiAgICAgdGhl
IGFzc3VtcHRpb24gY2FuIGJlIHZpb2xhdGVkIGluIHByb2R1Y3Rpb24uIFRoZSBiYWQgcGFja2V0
DQogICAgIGlzIGRyb3BwZWQsIGEgcXVldWUgc3RhdCBpcyBpbmNyZW1lbnRlZCwgYnV0IHRoZSBi
dXJzdCBsb29wDQogICAgIGNvbnRpbnVlcy4NCiANCiAgMy4gRG9jdW1lbnQgdGhlIGFzc3VtcHRp
b24gaW4gdGhlIEFQSSBjb250cmFjdCBhbmQgZG9uJ3QgY2hlY2sgaXQNCiAgICAgYXQgcnVudGlt
ZS4NCiANCnR4X3ByZXBhcmUgaXMgd2hlcmUgdmFsaWRhdGlvbiBiZWxvbmdzLCBhbmQgYW4gdW5j
b25kaXRpb25hbCBjaGVjaw0KdGhlcmUgaXMgYWNjZXB0YWJsZSAtIHR4X3ByZXBhcmUgaXMgb3B0
LWluLCBhbmQgYW4gYXBwbGljYXRpb24gdGhhdA0KY2FsbHMgaXQgaGFzIGFscmVhZHkgYWdyZWVk
IHRvIHBheSBmb3IgaW5zcGVjdGlvbi4gVGhlIDU5NS1saW5lDQpmdW5jdGlvbiBhcyB3cml0dGVu
IGlzIG1vc3RseSBmaW5lIGluIHRoYXQgY29udGV4dC4gV2hhdCdzIHdyb25nIGlzOg0KIA0KICAo
YSkgVGhlIGNvbW1pdCBtZXNzYWdlIHNheXMgb25lIHRoaW5nIGFuZCB0aGUgY29kZSBkb2VzIGFu
b3RoZXIuDQogICAgICBUaGUgYXV0aG9yIHNob3VsZCBlaXRoZXIgYWRkIHRoZSAjaWZkZWYgUlRF
X0VUSERFVl9ERUJVR19UWA0KICAgICAgdGhleSBjbGFpbWVkIHRvIGFkZCwgb3IgcmV3cml0ZSB0
aGUgY29tbWl0IG1lc3NhZ2UgdG8gZGVzY3JpYmUNCiAgICAgIHdoYXQgdGhlIHBhdGNoIGFjdHVh
bGx5IGRvZXMuDQogDQogIChiKSBEcml2ZXItc3BlY2lmaWMgdHhfcHJlcGFyZSB2YWxpZGF0aW9u
IHNob3VsZCBjb3ZlciBzeGUyLQ0KICAgICAgc3BlY2lmaWMgaGFyZHdhcmUgY29uc3RyYWludHMg
KGRlc2NyaXB0b3IgY291bnQgbGltaXRzLCBidWZmZXINCiAgICAgIGFsaWdubWVudCwgc2VnbWVu
dCBzaXplIGxpbWl0cykgLSBub3QgcmVkbyB0aGUgZ2VuZXJpYyBvZmZsb2FkLQ0KICAgICAgZmxh
ZyBhbmQgbGVuZ3RoLWNvbnNpc3RlbmN5IGNoZWNrcyB0aGF0IHJ0ZV92YWxpZGF0ZV90eF9vZmZs
b2FkKCkNCiAgICAgIGFuZCBydGVfbmV0X2ludGVsX2Nrc3VtX3ByZXBhcmUoKSBwZXJmb3JtLiBB
cyBjdXJyZW50bHkgd3JpdHRlbiwNCiAgICAgIGV2ZXJ5IHBhY2tldCBnb2luZyB0aHJvdWdoIHR4
X3ByZXBhcmUgZ2V0cyBpdHMgb2ZmbG9hZCBmbGFncw0KICAgICAgdmFsaWRhdGVkIHJvdWdobHkg
dHdpY2UuDQogDQogIChjKSBfX3J0ZV91bnVzZWQgb24gdGhlIGZ1bmN0aW9uIHNob3VsZCBiZSBk
cm9wcGVkLg0KIA0KIA0KUmVkbyB0aGlzIHdpdGggb25lIG9mIHRoZSBhYm92ZSBhbmQgcmVzdWJt
aXQNCg==

------=_001_NextPart517335866614_=----
Content-Type: text/html;
	charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charse=
t=3DISO-8859-1"><style>body { line-height: 1.5; }blockquote { margin-top: =
0px; margin-bottom: 0px; margin-left: 0.5em; }.fox_html_content_dummy_text=
area { position: absolute; overflow: hidden; width: 1px; height: 1px; opac=
ity: 0; }body { font-size: 14px; font-family: "Microsoft YaHei UI"; color:=
 rgb(0, 0, 0); line-height: 1.5; }</style></head><body>=0A<div><span style=
=3D"background-color: transparent;">Hi Stephen,</span><span></span></div><=
div><br></div><div><div>Introduce the 'sxe2_txrx_check_mbuf' helper functi=
on to validate</div><div>outgoing mbuf tunnel type flags when RTE_ETHDEV_D=
EBUG_TX is enabled.</div><div>The function checks that the RTE_MBUF_F_TX_T=
UNNEL_x flag in mbuf</div><div>ol_flags matches the actual tunnel protocol=
 detected in the packet</div><div>(GTP, VXLAN, VXLAN-GPE, Geneve, GRE, or =
IPIP).</div><div><br></div><div>The validation uses only UDP port matching=
 and L4 protocol detection;</div><div>it does NOT re-derive header lengths=
 or checksum fields already</div><div>verified by rte_validate_tx_offload(=
) and rte_net_intel_cksum_prepare().</div><div><br></div><div>All code is =
wrapped inside RTE_ETHDEV_DEBUG_TX conditional compilation</div><div>to en=
sure zero overhead in production builds.</div></div><hr style=3D"width: 21=
0px; height: 1px;" color=3D"#b5c4df" size=3D"1" align=3D"left">=0A<div><sp=
an><div style=3D"MARGIN: 10px; FONT-FAMILY: verdana; FONT-SIZE: 10pt"><div=
>liujie5@linkdatatechnology.com</div></div></span></div>=0A<blockquote sty=
le=3D"margin-Top: 0px; margin-Bottom: 0px; margin-Left: 0.5em; margin-Righ=
t: inherit"><div>&nbsp;</div><div style=3D"border:none;border-top:solid #B=
5C4DF 1.0pt;padding:3.0pt 0cm 0cm 0cm"><div style=3D"PADDING-RIGHT: 8px; P=
ADDING-LEFT: 8px; FONT-SIZE: 12px;FONT-FAMILY:tahoma;COLOR:#000000; BACKGR=
OUND: #efefef; PADDING-BOTTOM: 8px; PADDING-TOP: 8px"><div><b>From:</b>&nb=
sp;<a href=3D"mailto:stephen@networkplumber.org">Stephen Hemminger</a></di=
v><div><b>Date:</b>&nbsp;2026-06-27&nbsp;02:21</div><div><b>To:</b>&nbsp;<=
a href=3D"mailto:liujie5@linkdatatechnology.com">liujie5</a></div><div><b>=
CC:</b>&nbsp;<a href=3D"mailto:dev@dpdk.org">dev</a></div><div><b>Subject:=
</b>&nbsp;Re: [PATCH v9 19/23] net/sxe2: add mbuf validation in Tx debug m=
ode</div></div></div><div><div>On Fri, 26 Jun 2026 14:47:51 +0800</div>=0A=
<div>liujie5@linkdatatechnology.com wrote:</div>=0A<div>&nbsp;</div>=0A<di=
v>&gt; From: Jie Liu &lt;liujie5@linkdatatechnology.com&gt;</div>=0A<div>&=
gt; </div>=0A<div>&gt; Introduce the `sxe2_txrx_check_mbuf` helper functio=
n to validate outgoing</div>=0A<div>&gt; mbufs when `RTE_ETHDEV_DEBUG_TX` =
is enabled. This helps developers catch</div>=0A<div>&gt; malformed mbufs =
(e.g., invalid segment lengths, bad offload flags, or</div>=0A<div>&gt; un=
aligned buffers) before passing them to the hardware rings, avoiding</div>=
=0A<div>&gt; potential hardware hangs or silent packet drops.</div>=0A<div=
>&gt; </div>=0A<div>&gt; The validation is fully wrapped inside `RTE_ETHDE=
V_DEBUG_TX` conditional</div>=0A<div>&gt; compilation blocks to ensure zer=
o performance overhead in standard</div>=0A<div>&gt; production builds.</d=
iv>=0A<div>&gt; </div>=0A<div>&gt; Signed-off-by: Jie Liu &lt;liujie5@link=
datatechnology.com&gt;</div>=0A<div>&gt; ---</div>=0A<div>&nbsp;</div>=0A<=
div>I don't think I was clear enough before, the verbose description is:</=
div>=0A<div>&nbsp;</div>=0A<div>&nbsp;</div>=0A<div>Current state (v9):</d=
iv>=0A<div>&nbsp;</div>=0A<div>The new sxe2_txrx_check_mbuf() helper added=
 in 19/23 is called only</div>=0A<div>from sxe2_tx_pkts_prepare(), which i=
s the driver's tx_prepare</div>=0A<div>callback. It is not called from any=
 tx_burst path (sxe2_tx_pkts, the</div>=0A<div>vec paths, the poll path).<=
/div>=0A<div>&nbsp;</div>=0A<div>The commit message claims the validation =
is "fully wrapped inside</div>=0A<div>RTE_ETHDEV_DEBUG_TX conditional comp=
ilation blocks to ensure zero</div>=0A<div>performance overhead in standar=
d production builds." This is not what</div>=0A<div>the code does. There i=
s no #ifdef RTE_ETHDEV_DEBUG_TX anywhere in the</div>=0A<div>new file or a=
round the new call site. In fact the patch *removes* an</div>=0A<div>exist=
ing #ifdef RTE_ETHDEV_DEBUG_TX that previously gated</div>=0A<div>rte_vali=
date_tx_offload() in the same loop, making that always-on too.</div>=0A<di=
v>&nbsp;</div>=0A<div>The new function is marked __rte_unused both in the =
header</div>=0A<div>declaration and in the .c definition, even though it h=
as exactly one</div>=0A<div>caller. That attribute was likely a leftover f=
rom an earlier draft</div>=0A<div>where the function was only conditionall=
y referenced.</div>=0A<div>&nbsp;</div>=0A<div>The validation itself (595 =
lines) re-derives outer/inner L2/L3/L4</div>=0A<div>lengths from the packe=
t bytes and compares them against what the mbuf</div>=0A<div>header declar=
es - i.e., it's verifying that the application</div>=0A<div>correctly set =
mbuf-&gt;l2_len, l3_len, outer_l2_len, etc. before</div>=0A<div>submitting=
. Much of this overlaps what rte_validate_tx_offload() and</div>=0A<div>rt=
e_net_intel_cksum_prepare() already check, both of which are called</div>=
=0A<div>in the same tx_prepare loop.</div>=0A<div>&nbsp;</div>=0A<div>Desi=
red state:</div>=0A<div>&nbsp;</div>=0A<div>tx_burst should not contain va=
lidation checks for application errors.</div>=0A<div>The fast path runs on=
ce per packet at line rate, and any branch that</div>=0A<div>exists to cat=
ch a caller bug is paid on every well-behaved packet</div>=0A<div>forever.=
 For driver assumptions that an application must satisfy,</div>=0A<div>the=
 three sensible options are:</div>=0A<div>&nbsp;</div>=0A<div>&nbsp; 1. RT=
E_ASSERT() - compiles out in release builds, surfaces the</div>=0A<div>&nb=
sp;&nbsp;&nbsp;&nbsp; assumption to static analyzers, and fires for users =
running</div>=0A<div>&nbsp;&nbsp;&nbsp;&nbsp; debug builds.</div>=0A<div>&=
nbsp;</div>=0A<div>&nbsp; 2. unlikely() with drop-and-counter - if the che=
ck is cheap and</div>=0A<div>&nbsp;&nbsp;&nbsp;&nbsp; the assumption can b=
e violated in production. The bad packet</div>=0A<div>&nbsp;&nbsp;&nbsp;&n=
bsp; is dropped, a queue stat is incremented, but the burst loop</div>=0A<=
div>&nbsp;&nbsp;&nbsp;&nbsp; continues.</div>=0A<div>&nbsp;</div>=0A<div>&=
nbsp; 3. Document the assumption in the API contract and don't check it</d=
iv>=0A<div>&nbsp;&nbsp;&nbsp;&nbsp; at runtime.</div>=0A<div>&nbsp;</div>=
=0A<div>tx_prepare is where validation belongs, and an unconditional check=
</div>=0A<div>there is acceptable - tx_prepare is opt-in, and an applicati=
on that</div>=0A<div>calls it has already agreed to pay for inspection. Th=
e 595-line</div>=0A<div>function as written is mostly fine in that context=
. What's wrong is:</div>=0A<div>&nbsp;</div>=0A<div>&nbsp; (a) The commit =
message says one thing and the code does another.</div>=0A<div>&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; The author should either add the #ifdef RTE_ETHDEV_DEB=
UG_TX</div>=0A<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; they claimed to add, or =
rewrite the commit message to describe</div>=0A<div>&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; what the patch actually does.</div>=0A<div>&nbsp;</div>=0A<div>&n=
bsp; (b) Driver-specific tx_prepare validation should cover sxe2-</div>=0A=
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; specific hardware constraints (descrip=
tor count limits, buffer</div>=0A<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; align=
ment, segment size limits) - not redo the generic offload-</div>=0A<div>&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; flag and length-consistency checks that rte_v=
alidate_tx_offload()</div>=0A<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; and rte_n=
et_intel_cksum_prepare() perform. As currently written,</div>=0A<div>&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; every packet going through tx_prepare gets its o=
ffload flags</div>=0A<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; validated roughly=
 twice.</div>=0A<div>&nbsp;</div>=0A<div>&nbsp; (c) __rte_unused on the fu=
nction should be dropped.</div>=0A<div>&nbsp;</div>=0A<div>&nbsp;</div>=0A=
<div>Redo this with one of the above and resubmit</div>=0A</div></blockquo=
te>=0A</body></html>
------=_001_NextPart517335866614_=------

