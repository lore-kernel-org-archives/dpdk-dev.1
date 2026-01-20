Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B789C9830C
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 15:40:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A3ADD40E0C;
	Tue, 20 Jan 2026 16:40:25 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id AD56A4026F
 for <dev@dpdk.org>; Tue, 20 Jan 2026 16:40:24 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dwWjT3vcLzJ46Cq;
 Tue, 20 Jan 2026 23:39:57 +0800 (CST)
Received: from dubpeml100002.china.huawei.com (unknown [7.214.144.156])
 by mail.maildlp.com (Postfix) with ESMTPS id 3368340539;
 Tue, 20 Jan 2026 23:40:22 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml100002.china.huawei.com (7.214.144.156) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 20 Jan 2026 15:40:21 +0000
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Tue, 20 Jan 2026 15:40:21 +0000
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>, "Stephen
 Hemminger" <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Honnappa Nagarahalli
 <honnappa.nagarahalli@arm.com>
Subject: RE: [PATCH v3 1/6] test/soring: fix buffer overflow warnings with LTO
Thread-Topic: [PATCH v3 1/6] test/soring: fix buffer overflow warnings with LTO
Thread-Index: AQHchrPsHHTVtFNIz06gtz3G6GMnp7VUiMQAgAWVQICAAKgGAIAAYD+AgAAHlYCAAAnHMA==
Date: Tue, 20 Jan 2026 15:40:21 +0000
Message-ID: <d9a4cead8c8e473e907f604b98370013@huawei.com>
References: <20251023194237.197681-1-stephen@networkplumber.org>
 <20260116064646.224254-1-stephen@networkplumber.org>
 <20260116064646.224254-2-stephen@networkplumber.org>
 <98CBD80474FA8B44BF855DF32C47DC35F65669@smartserver.smartshare.dk>
 <20260119144821.70e2ff35@phoenix.local>
 <98CBD80474FA8B44BF855DF32C47DC35F65674@smartserver.smartshare.dk>
 <20260120063413.72e0d725@phoenix.local>
 <98CBD80474FA8B44BF855DF32C47DC35F6567F@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F6567F@smartserver.smartshare.dk>
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

DQoNCj4gPiBGcm9tOiBTdGVwaGVuIEhlbW1pbmdlciBbbWFpbHRvOnN0ZXBoZW5AbmV0d29ya3Bs
dW1iZXIub3JnXQ0KPiA+IFNlbnQ6IFR1ZXNkYXksIDIwIEphbnVhcnkgMjAyNiAxNS4zNA0KPiA+
DQo+ID4gT24gVHVlLCAyMCBKYW4gMjAyNiAwOTo0OTo0NCArMDEwMA0KPiA+IE1vcnRlbiBCcsO4
cnVwIDxtYkBzbWFydHNoYXJlc3lzdGVtcy5jb20+IHdyb3RlOg0KPiA+DQo+ID4gPiA+IEZyb206
IFN0ZXBoZW4gSGVtbWluZ2VyIFttYWlsdG86c3RlcGhlbkBuZXR3b3JrcGx1bWJlci5vcmddDQo+
ID4gPiA+IFNlbnQ6IE1vbmRheSwgMTkgSmFudWFyeSAyMDI2IDIzLjQ4DQo+ID4gPiA+DQo+ID4g
PiA+IE9uIEZyaSwgMTYgSmFuIDIwMjYgMTA6MzI6NTIgKzAxMDANCj4gPiA+ID4gTW9ydGVuIEJy
w7hydXAgPG1iQHNtYXJ0c2hhcmVzeXN0ZW1zLmNvbT4gd3JvdGU6DQo+ID4gPiA+DQo+ID4gPiA+
ID4gPiBGcm9tOiBTdGVwaGVuIEhlbW1pbmdlciBbbWFpbHRvOnN0ZXBoZW5AbmV0d29ya3BsdW1i
ZXIub3JnXQ0KPiA+ID4gPiA+ID4gU2VudDogRnJpZGF5LCAxNiBKYW51YXJ5IDIwMjYgMDcuNDYN
Cj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBXaGVuIGJ1aWxkaW5nIHdpdGggTFRPIChMaW5rIFRp
bWUgT3B0aW1pemF0aW9uKSwgR0NDIHBlcmZvcm1zDQo+ID4gPiA+ID4gPiBhZ2dyZXNzaXZlIGNy
b3NzLWNvbXBpbGF0aW9uLXVuaXQgaW5saW5pbmcuIFRoaXMgY2F1c2VzIHRoZQ0KPiA+ID4gPiBj
b21waWxlcg0KPiA+ID4gPiA+ID4gdG8gYW5hbHl6ZSBhbGwgY29kZSBwYXRocyBpbiBfX3J0ZV9y
aW5nX2RvX2RlcXVldWVfZWxlbXMoKSwNCj4gPiA+ID4gaW5jbHVkaW5nDQo+ID4gPiA+ID4gPiB0
aGUgMTYtYnl0ZSBlbGVtZW50IHBhdGggKF9fcnRlX3JpbmdfZGVxdWV1ZV9lbGVtc18xMjgpLCBl
dmVuDQo+ID4gd2hlbg0KPiA+ID4gPiA+ID4gdGhlIHJ1bnRpbWUgZWxlbWVudCBzaXplIGlzIG9u
bHkgNCBieXRlcy4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBUaGUgc3RhdGljIGFuYWx5emVy
IHNlZXMgdGhhdCB0aGUgMTYtYnl0ZSBwYXRoIHdvdWxkIGNvcHkNCj4gPiA+ID4gPiA+IDMyIGVs
ZW1lbnRzICogMTYgYnl0ZXMgPSA1MTIgYnl0ZXMgaW50byBhIDEyOC1ieXRlIGJ1ZmZlcg0KPiA+
ID4gPiA+ID4gKHVpbnQzMl90WzMyXSksDQo+ID4gPiA+ID4gPiB0cmlnZ2VyaW5nIC1Xc3RyaW5n
b3Atb3ZlcmZsb3cgd2FybmluZ3MuDQo+ID4gPg0KPiA+ID4gVGhlIGVsZW1lbnQgc2l6ZSBpcyBu
b3QgYW4gaW5saW5lIGZ1bmN0aW9uIHBhcmFtZXRlciwgYnV0IGZldGNoZWQNCj4gPiBmcm9tIHRo
ZSAiZXNpemUiIGZpZWxkIGluIHRoZSBydGVfc29yaW5nIHN0cnVjdHVyZSwgc28gdGhlIGNvbXBp
bGVyDQo+ID4gY2Fubm90IHNlZSB0aGF0IHRoZSBlbGVtZW50IHNpemUgaXMgNCBieXRlcy4gQW5k
IHRodXMgaXQgbmVlZHMgdG8NCj4gPiBjb25zaWRlciBhbGwgcG9zc2libGUgZWxlbWVudCBzaXpl
cy4NCj4gPiA+DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gVGhlIGV4aXN0aW5nICNwcmFnbWEg
R0NDIGRpYWdub3N0aWMgc3VwcHJlc3Npb24gaW4NCj4gPiA+ID4gcnRlX3JpbmdfZWxlbV9wdnQu
aA0KPiA+ID4gPiA+ID4gZG9lc24ndCBoZWxwIGJlY2F1c2Ugd2l0aCBMVE8gdGhlIHdhcm5pbmcg
Y29udGV4dCBzaGlmdHMgdG8gdGhlDQo+ID4gPiA+IHRlc3QNCj4gPiA+ID4gPiA+IGZpbGUgd2hl
cmUgdGhlIGlubGluZWQgY29kZSBpcyBpbnN0YW50aWF0ZWQuDQo+ID4gPiA+ID4gPg0KPiA+ID4g
PiA+ID4gRml4IGJ5IHNpemluZyBhbGwgYnVmZmVycyBwYXNzZWQgdG8gc29yaW5nIGFjcXVpcmUv
ZGVxdWV1ZQ0KPiA+ID4gPiBmdW5jdGlvbnMNCj4gPiA+ID4gPiA+IGZvciB0aGUgd29yc3QtY2Fz
ZSBlbGVtZW50IHNpemUgKDE2IGJ5dGVzID0gNCAqDQo+ID4gc2l6ZW9mKHVpbnQzMl90KSkuDQo+
ID4gPiA+ID4gPiBUaGlzIHNhdGlzZmllcyB0aGUgc3RhdGljIGFuYWx5emVyIHdpdGhvdXQgY2hh
bmdpbmcgcnVudGltZQ0KPiA+ID4gPiBiZWhhdmlvci4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFVz
aW5nIHdpbGRseSBvdmVyc2l6ZWQgYnVmZmVycyBkb2Vzbid0IHNlZW0gbGlrZSBhIHJlY29tbWVu
ZGFibGUNCj4gPiA+ID4gc29sdXRpb24uDQo+ID4gPiA+ID4gSWYgdGhlIHJpbmcgbGlicmFyeSBp
cyBldmVyIHVwZGF0ZWQgdG8gc3VwcG9ydCBjYWNoZSBzaXplDQo+ID4gZWxlbWVudHMNCj4gPiA+
ID4gKDY0IGJ5dGUpLCB0aGUgYnVmZmVycyB3b3VsZCBoYXZlIHRvIGJlIG92ZXJzaXplIGJ5IGZh
Y3RvciAxNi4NCj4gPiA+ID4NCj4gPiA+ID4gVGhlIGFuYWx5c2lzIChmcm9tIEFJKSBpcyB0aGF0
IGNvbXBpbGVyIGlzIGdldHRpbmcgY29uZnVzZWQuDQo+ID4gPg0KPiA+ID4gVGhhdCB3b3VsZCBi
ZSBteSBhbmFseXNpcyB0b28uDQo+ID4gPg0KPiA+ID4gPiBTaW5jZSB0aGVyZSBpcyBubyBnb29k
DQo+ID4gPiA+IHdheSBvdGhlciB0aGFuIHR1cm5pbmcgb2YgTFRPIGZvciB0aGUgdGVzdCB0byB0
ZWxsIHRoZSBjb21waWxlcg0KPiA+ID4NCj4gPiA+IFRoZXJlIGlzIGFub3RoZXIgd2F5IHRvIHRl
bGwgdGhlIGNvbXBpbGVyOiBfX3J0ZV9hc3N1bWUoKQ0KPiA+DQo+ID4gVHJpZWQgdGhhdCBidXQg
aXQgZG9lc24ndCB3b3JrIGJlY2F1c2UgZG9lc24ndCBnZXQgcHJvcGFnYXRlZCBkZWVwDQo+ID4g
ZW5vdWdoIHRvIGltcGFjdCBoZXJlLg0KPiANCj4gRG9lcyB0aGlzIGZpeCBnZW5lcmFsbHkgaW1w
bHkgdGhhdCB3aGVuIHVzaW5nIExUTywgdXNpbmcgYW4gU09SSU5HIHdpdGggZWxlbWVudHMNCj4g
c21hbGxlciB0aGFuIDE2IGJ5dGVzIHJlcXVpcmVzIG92ZXJzaXplIGJ1ZmZlcnM/DQo+IFRoYXQn
cyBub3QgZ29vZC4gOi0oDQo+IA0KPiBUaGUgU09SSU5HIGlzIHN0aWxsIGV4cGVyaW1lbnRhbC4N
Cj4gTWF5YmUgdGhlIGVsZW1lbnQgc2l6ZSBhbmQgbWV0YWRhdGEgc2l6ZSBuZWVkIHRvIGJlIHBh
c3NlZCBhcyBwYXJhbWV0ZXJzIHRvDQo+IHRoZSBTT1JJTkcgZnVuY3Rpb25zLCBsaWtlIHRoZSBS
SU5HIGZ1bmN0aW9ucyB0YWtlIGVsZW1lbnQgc2l6ZSBhcyBwYXJhbWV0ZXINCj4gKGV4Y2VwdCB0
aGUgZnVuY3Rpb25zIHRoYXQgYXJlIGhhcmRjb2RlZCBmb3IgdXNpbmcgcG9pbnRlcnMgYXMgZWxl
bWVudCBzaXplKS4NCg0KUGVyc29uYWxseSwgSSBhbSBub3QgYSBiaWcgZmFuIG9mIHN1Y2ggaWRl
YS4uLg0KV29uZGVyIGlzIHRoYXQgcG9zc2libGUganVzdCB0byBkaXNhYmxlIExUTyBmb3Igc29y
aW5nLm8/DQpBbm90aGVyIHRob3VnaHQgLSBpZiBhbGwgdGhlIHByb2JsZW1zIGNvbWUgZnJvbSAx
MjggYml0IHZlcnNpb24gb2YgZW5xdWUvZGVxdWV1ZSwNCndvdWxkIHVzaW5nIG1lbWNweSgpIGlu
c3RlYWQgIG9mIHNwZWNpZmljIGZ1bmN0aW9ucyBoZWxwIHRvIG1pdGlnYXRlIHRoZSBwcm9ibGVt
PyAgDQoNCg0K
