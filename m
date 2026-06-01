Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBE9CD5BD1
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 13:22:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4DFAB4027F;
	Mon,  1 Jun 2026 15:22:27 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 80CA34025A
 for <dev@dpdk.org>; Mon,  1 Jun 2026 15:22:25 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 598D0208EE;
 Mon,  1 Jun 2026 15:22:25 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH 4/7] app/test/mempool_perf: drop constant-values replay
Date: Mon, 1 Jun 2026 15:22:21 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F658CB@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <1047eaf3-f41e-49b9-a4cf-0eb7d46dc6c6@oktetlabs.ru>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 4/7] app/test/mempool_perf: drop constant-values replay
Thread-Index: AdzxoYXA/Eb1zs28SmGzTKA0f8O1MAAJVArg
References: <20260529171417.526892-1-stephen@networkplumber.org>
 <20260529171417.526892-5-stephen@networkplumber.org>
 <1047eaf3-f41e-49b9-a4cf-0eb7d46dc6c6@oktetlabs.ru>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>,
 "Stephen Hemminger" <stephen@networkplumber.org>, <dev@dpdk.org>
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

PiBGcm9tOiBBbmRyZXcgUnliY2hlbmtvIFttYWlsdG86YW5kcmV3LnJ5YmNoZW5rb0Bva3RldGxh
YnMucnVdDQo+IFNlbnQ6IE1vbmRheSwgMSBKdW5lIDIwMjYgMTAuMzUNCj4gDQo+IE9uIDUvMjkv
MjYgODoxMCBQTSwgU3RlcGhlbiBIZW1taW5nZXIgd3JvdGU6DQo+ID4gVGhlIHNlY29uZCBuZXN0
ZWQgbWF0cml4IHJlcGxheXMgZWFjaCAobl9nZXRfYnVsayA9PSBuX3B1dF9idWxrKQ0KPiA+IHBv
aW50IHdpdGggdXNlX2NvbnN0YW50X3ZhbHVlcz0xIHRvIGV4ZXJjaXNlIHRoZSBjb21waWxlLXRp
bWUNCj4gPiBjb25zdGFudCBidWxrLXNpemUgcGF0aHMgaW4gdGVzdF9sb29wKCkuICBUaGlzIHJv
dWdobHkgZG91YmxlcyB0aGUNCj4gPiB3b3JrIGZvciB0aGUgZ2V0L3B1dCBkaWFnb25hbCBhdCBl
dmVyeSBuX2tlZXAgd2l0aG91dCBhZGRpbmcgbmV3DQo+ID4gc2lnbmFsOiB0aGUgY3ljbGVzL29w
IHJlc3VsdCBmb3IgYSBjb25zdGFudCBidWxrIGlzIGludGVyZXN0aW5nIGluDQo+ID4gaXNvbGF0
ZWQgaW5saW5pbmcgc3R1ZGllcywgbm90IGluIHJvdXRpbmUgcmVncmVzc2lvbiBzd2VlcHMuDQo+
ID4NCj4gPiBEcm9wIHRoZSByZXBsYXkuICBUaGUgdXNlX2NvbnN0YW50X3ZhbHVlcyBzd2l0Y2gg
YW5kIGl0cyBicmFuY2hlcw0KPiA+IGluIHRlc3RfbG9vcCgpIGFyZSByZXRhaW5lZCBmb3Igbm93
IHNpbmNlIHRoZXkgYXJlIGV4ZXJjaXNlZCBieQ0KPiA+IGhhbmQgaW4gYW55IGxvY2FsIGJlbmNo
bWFya2luZy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFN0ZXBoZW4gSGVtbWluZ2VyIDxzdGVw
aGVuQG5ldHdvcmtwbHVtYmVyLm9yZz4NCj4gDQo+IEFzIGZhciBhcyBJIGNhbiBzZWUgeW91IGRl
bGV0ZSB0aGUgb25seSBwbGFjZSB3aGVyZSB1c2VfY29uc3RhbnRfdmFsdWVzDQo+IGlzIHNldCB0
byAxLiBJdCBsb29rcyBzdXNwaWNpb3VzIGFuZCBiYXNpY2FsbHkgcHJlc2VydmVzIGRlYWQgY29k
ZS4NCj4gU2luY2UgTW9ydGVuIGFkZGVkIHRoZSBjb2RlLCB0aGUgcGF0Y2ggc2hvdWxkIHdhaXQg
Zm9yIGhpcyBhcHByb3ZhbC4NCg0KSGF2aW5nIHVzZWQgdGhlIG1lbXBvb2wgcGVyZiB0ZXN0IGV4
dGVuc2l2ZWx5IG15c2VsZiwgSSBhZ3JlZSB0aGF0IGl0IGlzIHBhaW5mdWxseSBzbG93Lg0KTWVt
cG9vbHMgYXJlIHZlcnkgb2Z0ZW4gdXNlZCB3aXRoIGNvbnN0YW50IHJlcXVlc3Qgc2l6ZXMsIHNv
IHRlc3RpbmcgdGhlaXIgcGVyZm9ybWFuY2UgcmVtYWlucyByZWxldmFudCBmb3IgcmVncmVzc2lv
biBzd2VlcHMgdG9vLg0KTkFLIHRvIHRoaXMgY2hhbmdlLg0KDQpNYXliZSB0aGUgdGVzdGluZyBv
ZiBjb25zdGFudCB2YWx1ZXMgY291bGQgYmUgcmVkdWNlZCBieSB1c2luZyBhIHN1YnNldCBvZiB0
aGUgbm9uLWNvbnN0YW50IG1peCBvZiB2YWx1ZXMuDQoNCj4gDQo+ID4gLS0tDQo+ID4gICBhcHAv
dGVzdC90ZXN0X21lbXBvb2xfcGVyZi5jIHwgOCAtLS0tLS0tLQ0KPiA+ICAgMSBmaWxlIGNoYW5n
ZWQsIDggZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvYXBwL3Rlc3QvdGVzdF9t
ZW1wb29sX3BlcmYuYw0KPiBiL2FwcC90ZXN0L3Rlc3RfbWVtcG9vbF9wZXJmLmMNCj4gPiBpbmRl
eCAxOTU5MWFkMGM5Li5kZDJmMGJiYWNhIDEwMDY0NA0KPiA+IC0tLSBhL2FwcC90ZXN0L3Rlc3Rf
bWVtcG9vbF9wZXJmLmMNCj4gPiArKysgYi9hcHAvdGVzdC90ZXN0X21lbXBvb2xfcGVyZi5jDQo+
ID4gQEAgLTQyMywxNCArNDIzLDYgQEAgZG9fb25lX21lbXBvb2xfdGVzdChzdHJ1Y3QgcnRlX21l
bXBvb2wgKm1wLA0KPiB1bnNpZ25lZCBpbnQgY29yZXMsIGludCBleHRlcm5hbF9jYWMNCj4gPiAg
IAkJCQlyZXQgPSBsYXVuY2hfY29yZXMobXAsIGNvcmVzKTsNCj4gPiAgIAkJCQlpZiAocmV0IDwg
MCkNCj4gPiAgIAkJCQkJcmV0dXJuIC0xOw0KPiA+IC0NCj4gPiAtCQkJCS8qIHJlcGxheSB0ZXN0
IHdpdGggY29uc3RhbnQgdmFsdWVzICovDQo+ID4gLQkJCQlpZiAobl9nZXRfYnVsayA9PSBuX3B1
dF9idWxrKSB7DQo+ID4gLQkJCQkJdXNlX2NvbnN0YW50X3ZhbHVlcyA9IDE7DQo+ID4gLQkJCQkJ
cmV0ID0gbGF1bmNoX2NvcmVzKG1wLCBjb3Jlcyk7DQo+ID4gLQkJCQkJaWYgKHJldCA8IDApDQo+
ID4gLQkJCQkJCXJldHVybiAtMTsNCj4gPiAtCQkJCX0NCj4gPiAgIAkJCX0NCj4gPiAgIAkJfQ0K
PiA+ICAgCX0NCg0K
