Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CFA5C44525
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 12:56:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2E53A427E1;
	Wed, 21 Jan 2026 13:56:28 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 2A003400EF
 for <dev@dpdk.org>; Wed, 21 Jan 2026 13:56:27 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dx41h43NkzHnGj1;
 Wed, 21 Jan 2026 20:55:52 +0800 (CST)
Received: from dubpeml100001.china.huawei.com (unknown [7.214.144.137])
 by mail.maildlp.com (Postfix) with ESMTPS id 4F08D4056A;
 Wed, 21 Jan 2026 20:56:26 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml100001.china.huawei.com (7.214.144.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 21 Jan 2026 12:56:25 +0000
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Wed, 21 Jan 2026 12:56:25 +0000
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>,
 "dev@dpdk.org" <dev@dpdk.org>, Honnappa Nagarahalli
 <honnappa.nagarahalli@arm.com>
Subject: RE: [PATCH v3 1/6] test/soring: fix buffer overflow warnings with LTO
Thread-Topic: [PATCH v3 1/6] test/soring: fix buffer overflow warnings with LTO
Thread-Index: AQHchrPsHHTVtFNIz06gtz3G6GMnp7VUiMQAgAWVQICAAKgGAIAAYD+AgAAHlYCAAAnHMIAAQJMAgAEijBA=
Date: Wed, 21 Jan 2026 12:56:25 +0000
Message-ID: <bbda56963fa74b86be402911610daf75@huawei.com>
References: <20251023194237.197681-1-stephen@networkplumber.org>
 <20260116064646.224254-1-stephen@networkplumber.org>
 <20260116064646.224254-2-stephen@networkplumber.org>
 <98CBD80474FA8B44BF855DF32C47DC35F65669@smartserver.smartshare.dk>
 <20260119144821.70e2ff35@phoenix.local>
 <98CBD80474FA8B44BF855DF32C47DC35F65674@smartserver.smartshare.dk>
 <20260120063413.72e0d725@phoenix.local>
 <98CBD80474FA8B44BF855DF32C47DC35F6567F@smartserver.smartshare.dk>
 <d9a4cead8c8e473e907f604b98370013@huawei.com>
 <20260120112728.146e63b4@phoenix.local>
In-Reply-To: <20260120112728.146e63b4@phoenix.local>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.138.220]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
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

PiBPbiBUdWUsIDIwIEphbiAyMDI2IDE1OjQwOjIxICswMDAwDQo+IEtvbnN0YW50aW4gQW5hbnll
diA8a29uc3RhbnRpbi5hbmFueWV2QGh1YXdlaS5jb20+IHdyb3RlOg0KPiANCj4gPiA+ID4gRnJv
bTogU3RlcGhlbiBIZW1taW5nZXIgW21haWx0bzpzdGVwaGVuQG5ldHdvcmtwbHVtYmVyLm9yZ10N
Cj4gPiA+ID4gU2VudDogVHVlc2RheSwgMjAgSmFudWFyeSAyMDI2IDE1LjM0DQo+ID4gPiA+DQo+
ID4gPiA+IE9uIFR1ZSwgMjAgSmFuIDIwMjYgMDk6NDk6NDQgKzAxMDANCj4gPiA+ID4gTW9ydGVu
IEJyw7hydXAgPG1iQHNtYXJ0c2hhcmVzeXN0ZW1zLmNvbT4gd3JvdGU6DQo+ID4gPiA+DQo+ID4g
PiA+ID4gPiBGcm9tOiBTdGVwaGVuIEhlbW1pbmdlciBbbWFpbHRvOnN0ZXBoZW5AbmV0d29ya3Bs
dW1iZXIub3JnXQ0KPiA+ID4gPiA+ID4gU2VudDogTW9uZGF5LCAxOSBKYW51YXJ5IDIwMjYgMjMu
NDgNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBPbiBGcmksIDE2IEphbiAyMDI2IDEwOjMyOjUy
ICswMTAwDQo+ID4gPiA+ID4gPiBNb3J0ZW4gQnLDuHJ1cCA8bWJAc21hcnRzaGFyZXN5c3RlbXMu
Y29tPiB3cm90ZToNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gRnJvbTogU3RlcGhlbiBI
ZW1taW5nZXIgW21haWx0bzpzdGVwaGVuQG5ldHdvcmtwbHVtYmVyLm9yZ10NCj4gPiA+ID4gPiA+
ID4gPiBTZW50OiBGcmlkYXksIDE2IEphbnVhcnkgMjAyNiAwNy40Ng0KPiA+ID4gPiA+ID4gPiA+
DQo+ID4gPiA+ID4gPiA+ID4gV2hlbiBidWlsZGluZyB3aXRoIExUTyAoTGluayBUaW1lIE9wdGlt
aXphdGlvbiksIEdDQyBwZXJmb3Jtcw0KPiA+ID4gPiA+ID4gPiA+IGFnZ3Jlc3NpdmUgY3Jvc3Mt
Y29tcGlsYXRpb24tdW5pdCBpbmxpbmluZy4gVGhpcyBjYXVzZXMgdGhlDQo+ID4gPiA+ID4gPiBj
b21waWxlcg0KPiA+ID4gPiA+ID4gPiA+IHRvIGFuYWx5emUgYWxsIGNvZGUgcGF0aHMgaW4gX19y
dGVfcmluZ19kb19kZXF1ZXVlX2VsZW1zKCksDQo+ID4gPiA+ID4gPiBpbmNsdWRpbmcNCj4gPiA+
ID4gPiA+ID4gPiB0aGUgMTYtYnl0ZSBlbGVtZW50IHBhdGggKF9fcnRlX3JpbmdfZGVxdWV1ZV9l
bGVtc18xMjgpLCBldmVuDQo+ID4gPiA+IHdoZW4NCj4gPiA+ID4gPiA+ID4gPiB0aGUgcnVudGlt
ZSBlbGVtZW50IHNpemUgaXMgb25seSA0IGJ5dGVzLg0KPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+
ID4gPiA+ID4gVGhlIHN0YXRpYyBhbmFseXplciBzZWVzIHRoYXQgdGhlIDE2LWJ5dGUgcGF0aCB3
b3VsZCBjb3B5DQo+ID4gPiA+ID4gPiA+ID4gMzIgZWxlbWVudHMgKiAxNiBieXRlcyA9IDUxMiBi
eXRlcyBpbnRvIGEgMTI4LWJ5dGUgYnVmZmVyDQo+ID4gPiA+ID4gPiA+ID4gKHVpbnQzMl90WzMy
XSksDQo+ID4gPiA+ID4gPiA+ID4gdHJpZ2dlcmluZyAtV3N0cmluZ29wLW92ZXJmbG93IHdhcm5p
bmdzLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gVGhlIGVsZW1lbnQgc2l6ZSBpcyBub3QgYW4gaW5s
aW5lIGZ1bmN0aW9uIHBhcmFtZXRlciwgYnV0IGZldGNoZWQNCj4gPiA+ID4gZnJvbSB0aGUgImVz
aXplIiBmaWVsZCBpbiB0aGUgcnRlX3NvcmluZyBzdHJ1Y3R1cmUsIHNvIHRoZSBjb21waWxlcg0K
PiA+ID4gPiBjYW5ub3Qgc2VlIHRoYXQgdGhlIGVsZW1lbnQgc2l6ZSBpcyA0IGJ5dGVzLiBBbmQg
dGh1cyBpdCBuZWVkcyB0bw0KPiA+ID4gPiBjb25zaWRlciBhbGwgcG9zc2libGUgZWxlbWVudCBz
aXplcy4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gVGhlIGV4
aXN0aW5nICNwcmFnbWEgR0NDIGRpYWdub3N0aWMgc3VwcHJlc3Npb24gaW4NCj4gPiA+ID4gPiA+
IHJ0ZV9yaW5nX2VsZW1fcHZ0LmgNCj4gPiA+ID4gPiA+ID4gPiBkb2Vzbid0IGhlbHAgYmVjYXVz
ZSB3aXRoIExUTyB0aGUgd2FybmluZyBjb250ZXh0IHNoaWZ0cyB0byB0aGUNCj4gPiA+ID4gPiA+
IHRlc3QNCj4gPiA+ID4gPiA+ID4gPiBmaWxlIHdoZXJlIHRoZSBpbmxpbmVkIGNvZGUgaXMgaW5z
dGFudGlhdGVkLg0KPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gRml4IGJ5IHNpemlu
ZyBhbGwgYnVmZmVycyBwYXNzZWQgdG8gc29yaW5nIGFjcXVpcmUvZGVxdWV1ZQ0KPiA+ID4gPiA+
ID4gZnVuY3Rpb25zDQo+ID4gPiA+ID4gPiA+ID4gZm9yIHRoZSB3b3JzdC1jYXNlIGVsZW1lbnQg
c2l6ZSAoMTYgYnl0ZXMgPSA0ICoNCj4gPiA+ID4gc2l6ZW9mKHVpbnQzMl90KSkuDQo+ID4gPiA+
ID4gPiA+ID4gVGhpcyBzYXRpc2ZpZXMgdGhlIHN0YXRpYyBhbmFseXplciB3aXRob3V0IGNoYW5n
aW5nIHJ1bnRpbWUNCj4gPiA+ID4gPiA+IGJlaGF2aW9yLg0KPiA+ID4gPiA+ID4gPg0KPiA+ID4g
PiA+ID4gPiBVc2luZyB3aWxkbHkgb3ZlcnNpemVkIGJ1ZmZlcnMgZG9lc24ndCBzZWVtIGxpa2Ug
YSByZWNvbW1lbmRhYmxlDQo+ID4gPiA+ID4gPiBzb2x1dGlvbi4NCj4gPiA+ID4gPiA+ID4gSWYg
dGhlIHJpbmcgbGlicmFyeSBpcyBldmVyIHVwZGF0ZWQgdG8gc3VwcG9ydCBjYWNoZSBzaXplDQo+
ID4gPiA+IGVsZW1lbnRzDQo+ID4gPiA+ID4gPiAoNjQgYnl0ZSksIHRoZSBidWZmZXJzIHdvdWxk
IGhhdmUgdG8gYmUgb3ZlcnNpemUgYnkgZmFjdG9yIDE2Lg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4g
PiA+IFRoZSBhbmFseXNpcyAoZnJvbSBBSSkgaXMgdGhhdCBjb21waWxlciBpcyBnZXR0aW5nIGNv
bmZ1c2VkLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gVGhhdCB3b3VsZCBiZSBteSBhbmFseXNpcyB0
b28uDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IFNpbmNlIHRoZXJlIGlzIG5vIGdvb2QNCj4gPiA+
ID4gPiA+IHdheSBvdGhlciB0aGFuIHR1cm5pbmcgb2YgTFRPIGZvciB0aGUgdGVzdCB0byB0ZWxs
IHRoZSBjb21waWxlcg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gVGhlcmUgaXMgYW5vdGhlciB3YXkg
dG8gdGVsbCB0aGUgY29tcGlsZXI6IF9fcnRlX2Fzc3VtZSgpDQo+ID4gPiA+DQo+ID4gPiA+IFRy
aWVkIHRoYXQgYnV0IGl0IGRvZXNuJ3Qgd29yayBiZWNhdXNlIGRvZXNuJ3QgZ2V0IHByb3BhZ2F0
ZWQgZGVlcA0KPiA+ID4gPiBlbm91Z2ggdG8gaW1wYWN0IGhlcmUuDQo+ID4gPg0KPiA+ID4gRG9l
cyB0aGlzIGZpeCBnZW5lcmFsbHkgaW1wbHkgdGhhdCB3aGVuIHVzaW5nIExUTywgdXNpbmcgYW4g
U09SSU5HIHdpdGgNCj4gZWxlbWVudHMNCj4gPiA+IHNtYWxsZXIgdGhhbiAxNiBieXRlcyByZXF1
aXJlcyBvdmVyc2l6ZSBidWZmZXJzPw0KPiA+ID4gVGhhdCdzIG5vdCBnb29kLiA6LSgNCj4gPiA+
DQo+ID4gPiBUaGUgU09SSU5HIGlzIHN0aWxsIGV4cGVyaW1lbnRhbC4NCj4gPiA+IE1heWJlIHRo
ZSBlbGVtZW50IHNpemUgYW5kIG1ldGFkYXRhIHNpemUgbmVlZCB0byBiZSBwYXNzZWQgYXMgcGFy
YW1ldGVycw0KPiB0bw0KPiA+ID4gdGhlIFNPUklORyBmdW5jdGlvbnMsIGxpa2UgdGhlIFJJTkcg
ZnVuY3Rpb25zIHRha2UgZWxlbWVudCBzaXplIGFzDQo+IHBhcmFtZXRlcg0KPiA+ID4gKGV4Y2Vw
dCB0aGUgZnVuY3Rpb25zIHRoYXQgYXJlIGhhcmRjb2RlZCBmb3IgdXNpbmcgcG9pbnRlcnMgYXMg
ZWxlbWVudCBzaXplKS4NCj4gPg0KPiA+IFBlcnNvbmFsbHksIEkgYW0gbm90IGEgYmlnIGZhbiBv
ZiBzdWNoIGlkZWEuLi4NCj4gPiBXb25kZXIgaXMgdGhhdCBwb3NzaWJsZSBqdXN0IHRvIGRpc2Fi
bGUgTFRPIGZvciBzb3Jpbmcubz8NCj4gPiBBbm90aGVyIHRob3VnaHQgLSBpZiBhbGwgdGhlIHBy
b2JsZW1zIGNvbWUgZnJvbSAxMjggYml0IHZlcnNpb24gb2YNCj4gZW5xdWUvZGVxdWV1ZSwNCj4g
PiB3b3VsZCB1c2luZyBtZW1jcHkoKSBpbnN0ZWFkICBvZiBzcGVjaWZpYyBmdW5jdGlvbnMgaGVs
cCB0byBtaXRpZ2F0ZSB0aGUNCj4gcHJvYmxlbT8NCj4gPg0KPiA+DQo+IA0KPiBBIG11Y2ggc2lt
cGxlciBhbmQgY2xlYXIgc29sdXRpb24gaXMgdG8ganVzdCBnZXQgcmlkIG9mIF9fcnRlX2Fsd2F5
c19pbmxpbmUNCj4gYW5kIHVzZSBpbmxpbmUgaW5zdGVhZC4gVGhlIGNvbXBpbGVyIHN0aWxsIGlu
bGluZXMgYSBsb3QgYnV0IGl0IGNhbiBtYWtlIGl0cw0KPiBvd24gZGVjaXNpb24uDQo+IFRoZSBh
dHRyaWJ1dGUgYWx3YXlzX2lubGluZSBpcyBub3QgYWx3YXlzIGZhc3RlciwgaW4gZmFjdCBpbiBy
ZWFsIHdvcmxkDQo+IGFwcGxpY2F0aW9ucyBpdCBjYW4gbWFrZSB0aGluZ3Mgc2xvd2VyIGJlY2F1
c2UgcmVhbCBhcHBsaWNhdGlvbnMgZ2V0IGktY2FjaGUNCj4gbWlzc2VzIGFuZCBsb3RzIG9mIGlu
bGluZSBleHBhbnNpb24gbWFrZXMgaXQgd29yc2UuDQoNClNvdW5kcyBsaWtlIGEgY2xlYW4gYW5k
IHNhZmUgZml4Lg0KSSBhbHNvIGRvbid0IGV4cGVjdCBhbnkgcGVyZiBkZWdyYWRhdGlvbnMgd2l0
aCBzdWNoIGFwcHJvYWNoLCANCmJ1dCB3aWxsIHJ1biBzb21lIHBlcmYgdGVzdHMgd2l0aCBpdCB0
byBjb25maXJtLg0KVGhhbmtzDQo=
