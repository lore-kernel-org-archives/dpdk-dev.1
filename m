Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDEF2EC01CD
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 11:58:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BDEAB40268;
	Mon, 23 Mar 2026 12:57:59 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 533954025F;
 Mon, 23 Mar 2026 12:57:59 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4ffWr61hQCzHnH55;
 Mon, 23 Mar 2026 19:57:26 +0800 (CST)
Received: from frapema100004.china.huawei.com (unknown [7.182.19.128])
 by mail.maildlp.com (Postfix) with ESMTPS id 9015740569;
 Mon, 23 Mar 2026 19:57:57 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema100004.china.huawei.com (7.182.19.128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 23 Mar 2026 12:57:57 +0100
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Mon, 23 Mar 2026 12:57:57 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: David Marchand <david.marchand@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, Cristian Dumitrescu
 <cristian.dumitrescu@intel.com>
Subject: RE: [PATCH] pipeline: fix build with sanitizers or debug options
Thread-Topic: [PATCH] pipeline: fix build with sanitizers or debug options
Thread-Index: AQHcuG7ka7C3eVkoMUOXT5CXCn/Zn7W8BPFg
Date: Mon, 23 Mar 2026 11:57:57 +0000
Message-ID: <795dc7d0d3744a32aa88ed1e61afd765@huawei.com>
References: <20260320133309.1015506-1-david.marchand@redhat.com>
In-Reply-To: <20260320133309.1015506-1-david.marchand@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.137.74]
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYXZpZCBNYXJjaGFuZCA8ZGF2
aWQubWFyY2hhbmRAcmVkaGF0LmNvbT4NCj4gU2VudDogRnJpZGF5IDIwIE1hcmNoIDIwMjYgMTM6
MzMNCj4gVG86IGRldkBkcGRrLm9yZw0KPiBDYzogc3RhYmxlQGRwZGsub3JnOyBDcmlzdGlhbiBE
dW1pdHJlc2N1IDxjcmlzdGlhbi5kdW1pdHJlc2N1QGludGVsLmNvbT4NCj4gU3ViamVjdDogW1BB
VENIXSBwaXBlbGluZTogZml4IGJ1aWxkIHdpdGggc2FuaXRpemVycyBvciBkZWJ1ZyBvcHRpb25z
DQo+IA0KPiBTaW1pbGFyIHRvIGNvbW1pdCA4NGY1YWM5NDE4ZWEgKCJwaXBlbGluZTogZml4IGJ1
aWxkIHdpdGggQVNhbiIpLg0KPiANCj4gSGVyZSB3ZSBhcmUgYWdhaW4uIERlcGVuZGluZyBvbiBv
cHRpb25zIChsaWtlIGRlYnVnLCBvciBBU2FuLCBvciBVQlNhbiksDQo+IGNvbXBpbGF0aW9uIGNh
biBmYWlsIGJlY2F1c2Ugb2YgZHVtYiBjb25zdHJ1Y3QgbGlrZSBDSEVDSygwLCBYWFgpLg0KPiBE
dW1iLCBiZWNhdXNlIHN1Y2ggYW4gZXhwcmVzc2lvbiBtYWNybyBleHBhbmRzIGFzOiBpZiAoMCkg
cmV0dXJuIC1YWFg7DQo+IA0KPiAuLi9saWIvcGlwZWxpbmUvcnRlX3N3eF9waXBlbGluZS5jOiBJ
biBmdW5jdGlvbiDigJhpbnN0cl9tb3ZoX3RyYW5zbGF0ZeKAmToNCj4gLi4vbGliL3BpcGVsaW5l
L3J0ZV9zd3hfcGlwZWxpbmUuYzozNDYxOjE6IGVycm9yOiBjb250cm9sIHJlYWNoZXMgZW5kIG9m
DQo+IAlub24tdm9pZCBmdW5jdGlvbiBbLVdlcnJvcj1yZXR1cm4tdHlwZV0NCj4gIDM0NjEgfCB9
DQo+ICAgICAgIHwgXg0KPiANCj4gUmVtb3ZlIGFueSBzdWNoIGNhbGwgd2hlbiBhdCB0aGUgZW5k
IG9mIGZ1bmN0aW9ucywgdXNpbmcgYSByZWdleHA6DQo+ICVzL0NIRUNLKDAsIFwoLipcKSlcKDtc
bn1cKS9yZXR1cm4gLVwxXDIvDQo+IA0KPiBDYzogc3RhYmxlQGRwZGsub3JnDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBEYXZpZCBNYXJjaGFuZCA8ZGF2aWQubWFyY2hhbmRAcmVkaGF0LmNvbT4NCj4g
LS0tDQo+ICBsaWIvcGlwZWxpbmUvcnRlX3N3eF9waXBlbGluZS5jIHwgNiArKystLS0NCj4gIDEg
ZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvbGliL3BpcGVsaW5lL3J0ZV9zd3hfcGlwZWxpbmUuYyBiL2xpYi9waXBlbGluZS9y
dGVfc3d4X3BpcGVsaW5lLmMNCj4gaW5kZXggYTkxNTc4MTVlNC4uOGNlYjFmZTg4ZCAxMDA2NDQN
Cj4gLS0tIGEvbGliL3BpcGVsaW5lL3J0ZV9zd3hfcGlwZWxpbmUuYw0KPiArKysgYi9saWIvcGlw
ZWxpbmUvcnRlX3N3eF9waXBlbGluZS5jDQo+IEBAIC0yNTI0LDcgKzI1MjQsNyBAQCBpbnN0cl90
YWJsZV90cmFuc2xhdGUoc3RydWN0IHJ0ZV9zd3hfcGlwZWxpbmUgKnAsDQo+ICAJCXJldHVybiAw
Ow0KPiAgCX0NCj4gDQo+IC0JQ0hFQ0soMCwgRUlOVkFMKTsNCj4gKwlyZXR1cm4gLUVJTlZBTDsN
Cj4gIH0NCj4gDQo+ICBzdGF0aWMgaW5saW5lIHZvaWQNCj4gQEAgLTMwNDksNyArMzA0OSw3IEBA
IGluc3RyX2V4dGVybl90cmFuc2xhdGUoc3RydWN0IHJ0ZV9zd3hfcGlwZWxpbmUgKnAsDQo+ICAJ
CXJldHVybiAwOw0KPiAgCX0NCj4gDQo+IC0JQ0hFQ0soMCwgRUlOVkFMKTsNCj4gKwlyZXR1cm4g
LUVJTlZBTDsNCj4gIH0NCj4gDQo+ICBzdGF0aWMgaW5saW5lIHZvaWQNCj4gQEAgLTM0NTcsNyAr
MzQ1Nyw3IEBAIGluc3RyX21vdmhfdHJhbnNsYXRlKHN0cnVjdCBydGVfc3d4X3BpcGVsaW5lICpw
LA0KPiAgCQlyZXR1cm4gMDsNCj4gIAl9DQo+IA0KPiAtCUNIRUNLKDAsIEVJTlZBTCk7DQo+ICsJ
cmV0dXJuIC1FSU5WQUw7DQo+ICB9DQo+IA0KPiAgc3RhdGljIGlubGluZSB2b2lkDQo+IC0tDQo+
IDIuNTMuMA0KDQpTaG91bGQgd2Ugb25seSBmaXggdGhvc2UgYXQgdGhlIGVuZCBvZiBhIGZ1bmN0
aW9uPyBPdGhlciBjYXNlcyBtYXkgbm90IGNhdXNlDQppc3N1ZXMgaW1tZWRpYXRlbHksIGJ1dCBt
YXkgc3RpbGwgY29uZnVzZSBjb21waWxlcnMgYW5kIHJlYWRlcnMgaW4gdGhlIGZ1dHVyZS4NCg0K
V2UgYXJlIHVzaW5nIHRoZSBmb2xsb3dpbmcgaG90LXBhdGNoIGNvbW1hbmQgaW4gb3VyIENJOg0K
DQpgYGBiYXNoDQpzZWQgLXIgJ3MvXGJDSEVDS1woMCwgKFx3KylcKS9yZXR1cm4gLVwxL2cnIC1p
IGxpYi9waXBlbGluZS9ydGVfc3d4X3BpcGVsaW5lLmMNCmBgYA0KDQpBbmQgaXQgcGVyZm9ybXMg
NiByZXBsYWNlbWVudHMuDQo=
