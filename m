Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6288104C00F
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Mar 2026 10:52:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D7184067C;
	Wed, 11 Mar 2026 11:52:14 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 5F6FF40431
 for <dev@dpdk.org>; Wed, 11 Mar 2026 11:52:13 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fW6xV182xzJ46rp;
 Wed, 11 Mar 2026 18:51:26 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (unknown [7.214.147.241])
 by mail.maildlp.com (Postfix) with ESMTPS id 3D2B740573;
 Wed, 11 Mar 2026 18:52:12 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml500001.china.huawei.com (7.214.147.241) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 11 Mar 2026 10:52:11 +0000
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Wed, 11 Mar 2026 10:52:11 +0000
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>, "Andrew
 Rybchenko" <andrew.rybchenko@oktetlabs.ru>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: mempool name size incorrect?
Thread-Topic: mempool name size incorrect?
Thread-Index: Adywl6pOeioOieCEStaA8yIKq8lxpwApEwiAAAFa5oAAANQbAA==
Date: Wed, 11 Mar 2026 10:52:11 +0000
Message-ID: <144d8fcf192645e3aa240fc43d85097c@huawei.com>
References: <98CBD80474FA8B44BF855DF32C47DC35F65773@smartserver.smartshare.dk>
 <f8381c90-d73c-446c-bb2f-2fe3bc921714@oktetlabs.ru>
 <98CBD80474FA8B44BF855DF32C47DC35F65777@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65777@smartserver.smartshare.dk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.81.206.31]
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

DQoNCj4gPiBPbiAzLzEwLzI2IDU6MTAgUE0sIE1vcnRlbiBCcsO4cnVwIHdyb3RlOg0KPiA+ID4g
SXNuJ3QgdGhlIFJURV9NRU1QT09MX05BTUVTSVpFIHRvbyBzaG9ydD8NCj4gPiA+DQo+ID4gPiBM
b29raW5nIGF0IHRoZSBuYW1lcyBzaXplczoNCj4gPiA+DQo+ID4gPiBSVEVfTUVNWk9ORV9OQU1F
U0laRSA9IDMyLA0KPiA+ID4gUlRFX1JJTkdfTkFNRVNJWkUgPSBSVEVfTUVNWk9ORV9OQU1FU0la
RSAtIChzaXplb2YoIlJHXyIpPTQpICsgMSA9DQo+ID4gMjksDQo+ID4gPiBSVEVfTUVNUE9PTF9O
QU1FU0laRSA9IFJURV9SSU5HX05BTUVTSVpFIC0gKHNpemVvZigiTVBfIik9NCkgKyAxID0NCj4g
MjYNCj4gPiA+DQo+ID4gPiBSZWZlcnJpbmcgdG8gWzFdLCBJIHRoaW5rIGl0IHNob3VsZCBiZSBm
aXhlZCBhczoNCj4gPiA+IC0gI2RlZmluZSBSVEVfTUVNUE9PTF9OQU1FU0laRSAoUlRFX1JJTkdf
TkFNRVNJWkUgLSBcDQo+ID4gPiAJCQkgICAgICBzaXplb2YoUlRFX01FTVBPT0xfTVpfUFJFRklY
KSArIDEpDQo+ID4gPiArICNkZWZpbmUgUlRFX01FTVBPT0xfTkFNRVNJWkUgKFJURV9NRU1aT05F
X05BTUVTSVpFIC0gXA0KPiA+ID4gCQkJICAgICAgc2l6ZW9mKFJURV9NRU1QT09MX01aX1BSRUZJ
WCkgKyAxKQ0KPiA+ID4NCj4gPiA+IFRoZXJlIGlzIG5vIHJpbmcgaW52b2x2ZWQsIHNvIEkgZ3Vl
c3MgaXQgaXMgc29tZSBraW5kIG9mIGNvcHktcGFzdGUtDQo+ID4gc2VhcmNoLXJlcGxhY2UgZXJy
b3IuDQo+ID4gPg0KPiA+DQo+ID4gSSBndWVzcyByaW5nIGlzIGludm9sdmVkIGluIGZhY3Qgc2lu
Y2UgdGhlIGRlZmF1bHQgbWVtcG9vbCBkcml2ZXIgaXMNCj4gPiByaW5nLg0KPiA+DQo+ID4gU2Vl
IGRyaXZlcnMvbWVtcG9vbC9yaW5nL3J0ZV9tZW1wb29sX3JpbmcuYyByaW5nX2FsbG9jKCkuDQo+
ID4NCj4gPiBZZXMsIGl0IGlzIG5vdCBpZGVhbCwgYnV0IGF0IGxlYXN0IGl0IGV4cGxhaW5zIHdo
eSBSVEVfUklOR19OQU1FU0laRQ0KPiA+IGlzIHVzZWQuDQo+IA0KPiBUaGFua3MsIHRoYXQgZXhw
bGFpbnMgaXQuIEJhZCBsYXllciB2aW9sYXRpb24uLi4NCj4gTGV0J3MgaG9wZSBubyBmdXR1cmUg
bWVtcG9vbCBkcml2ZXIgYWRkcyBhbnl0aGluZyBsb25nZXIgdGhhbiAiUkdfIiB0byB0aGUNCj4g
bmFtZSBvZiBhbnkgbWVtem9uZSBpdCBjcmVhdGVzLg0KPiANCj4gTG9va2luZyBpbnRvIHRoZSBh
c3NvY2lhdGVkIHN0cmluZyBsZW5ndGggY2hlY2tzLCB1c2luZyBhIHRvbyBsb25nIG5hbWUgd2ls
bCBmYWlsDQo+IHdpdGggRU5BTUVUT09MT05HLg0KPiBTbywgdXNpbmcgYSBsb25nIG1lbXBvb2wg
bmFtZSBtaWdodCBzdWNjZWVkIHdpdGggc29tZSBtZW1wb29sIGRyaXZlcnMgYW5kDQo+IGZhaWwg
d2l0aCBvdGhlcnMuIDotKA0KPiANCj4gSSBndWVzcyB0aGVyZSdzIG5vIHNpbXBsZSBmaXggZm9y
IHRoYXQuDQo+IEFuZCBJIHdhcyB3cm9uZyB0byB0aGluayB0aGF0IHRoZSBSVEVfTUVNUE9PTF9O
QU1FU0laRSBzaG91bGQgYmUNCj4gaW5jcmVhc2VkIGZyb20gMjYgdG8gMjkuDQoNCkFzIGEgZ2Vu
ZXJpYyB0aG91Z2h0OiBtaWdodCBiZSBpdCBpcyB0aW1lIHRvIG1ha2UgdGhlIGxlbmd0aCBhY3Jv
c3MgdGhlc2UNCnN0cnVjdHMgKG1lbXBvb2wsIHJpbmcsIGV0Yy4pIGFyYml0cmFyeT8NCkF0IG91
ciBuZXh0IGJpZyBBUEkgYnJlYWthZ2Ugb3Igc28uDQoNCj4gPg0KPiA+ID4NCj4gPiA+IExvb2tp
bmcgYXQgdGhlIHJ0ZV9tZW1wb29sIHN0cnVjdHVyZSBbMl06DQo+ID4gPiBzdHJ1Y3QgX19ydGVf
Y2FjaGVfYWxpZ25lZCBydGVfbWVtcG9vbCB7DQo+ID4gPiAJY2hhciBuYW1lW1JURV9NRU1QT09M
X05BTUVTSVpFXTsgLyoqPCBOYW1lIG9mIG1lbXBvb2wuICovDQo+ID4gPiAJdW5pb24gew0KPiA+
ID4gCQl2b2lkICpwb29sX2RhdGE7ICAgICAgICAgLyoqPCBSaW5nIG9yIHBvb2wgdG8gc3RvcmUN
Cj4gPiBvYmplY3RzLiAqLw0KPiA+ID4gCQl1aW50NjRfdCBwb29sX2lkOyAgICAgICAgLyoqPCBF
eHRlcm5hbCBtZW1wb29sIGlkZW50aWZpZXIuDQo+ID4gKi8NCj4gPiA+IAl9Ow0KPiA+ID4NCj4g
PiA+DQo+ID4gPiBEdWUgdG8gdGhlIDgtYnl0ZSBhbGlnbm1lbnQgb2YgdGhlIHBvb2xfaWQgZmll
bGQgZm9sbG93aW5nIHRoZSBuYW1lDQo+ID4gZmllbGQsIGZpeGluZyB0aGUgbGVuZ3RoIGFzIHN1
Z2dlc3RlZCBkb2Vzbid0IGNoYW5nZSB0aGUgbWVtb3J5IGxheW91dA0KPiA+IGZvciA2NCBiaXQg
Q1BVIGFyY2hpdGVjdHVyZXMuDQo+ID4gPiBCdXQgaXQgZG9lcyBmb3IgMzIgYml0IENQVSBhcmNo
aXRlY3R1cmVzLCB3aGljaCB3aWxsIG9ubHkgNC1ieXRlDQo+ID4gYWxpZ24gdGhlIHBvb2xfaWQg
ZmllbGQuDQo+ID4gPg0KPiA+ID4gWzFdOiBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9kcGRr
L3YyNi4wMy0NCj4gPiByYzEvc291cmNlL2xpYi9tZW1wb29sL3J0ZV9tZW1wb29sLmgjTDEyOA0K
PiA+ID4gWzJdOiBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9kcGRrL3YyNi4wMy0NCj4gPiBy
YzEvc291cmNlL2xpYi9tZW1wb29sL3J0ZV9tZW1wb29sLmgjTDIzMA0KPiA+ID4NCj4gPiA+DQo+
ID4gPiBBbm90aGVyIHRoaW5nOg0KPiA+ID4gT24gMzIgYml0IENQVSBhcmNoaXRlY3R1cmVzLCB0
aGUgY2FjaGVfc2l6ZSBhbmQgbG9jYWxfY2FjaGUgZmllbGRzIGluDQo+ID4gdGhlIHJ0ZV9tZW1w
b29sIHN0cnVjdHVyZSBhcmUgbm90IGluIHRoZSBzYW1lIGNhY2hlIGxpbmUuDQo+ID4gPiBCdXQg
SSBndWVzcyB3ZSBkb24ndCByZWFsbHkgY2FyZSBhYm91dCAzMiBiaXQgQ1BVIGFyY2hpdGVjdHVy
ZXMuDQo+ID4gPg0KPiA+ID4NCj4gPiA+IFZlbmxpZyBoaWxzZW4gLyBLaW5kIHJlZ2FyZHMsDQo+
ID4gPiAtTW9ydGVuIEJyw7hydXANCj4gPiA+DQoNCg==
