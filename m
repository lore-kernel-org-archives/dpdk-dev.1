Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9527ACD342F
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 May 2026 07:47:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8505740272;
	Tue,  5 May 2026 09:47:08 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 7810640270;
 Tue,  5 May 2026 09:47:07 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4g8rF651PhzJ46Ck;
 Tue,  5 May 2026 15:46:50 +0800 (CST)
Received: from dubpeml500002.china.huawei.com (unknown [7.214.145.83])
 by mail.maildlp.com (Postfix) with ESMTPS id C6E1F40570;
 Tue,  5 May 2026 15:47:05 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml500002.china.huawei.com (7.214.145.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 5 May 2026 08:47:05 +0100
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Tue, 5 May 2026 08:47:05 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>,
 "dev@dpdk.org" <dev@dpdk.org>, Konstantin Ananyev
 <konstantin.v.ananyev@yandex.ru>, Wathsala Vithanage
 <wathsala.vithanage@arm.com>, "stable@dpdk.org" <stable@dpdk.org>
CC: David Marchand <david.marchand@redhat.com>
Subject: RE: [PATCH] ring: add cache guard after ring elements table
Thread-Topic: [PATCH] ring: add cache guard after ring elements table
Thread-Index: AQHc0XkQlTcfmwaszE+wFaHNWAZ9L7X358TAgAAS8tCAArdBsIADNeMQgAE7FGA=
Date: Tue, 5 May 2026 07:47:05 +0000
Message-ID: <70a4b0baa49448d0b93d2088319afaf5@huawei.com>
References: <20260421102358.118204-1-mb@smartsharesystems.com>
 <e1fa27a3450f4bc5ab0c12bcfb07f694@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65835@smartserver.smartshare.dk>
 <452224d4ef25481b938a10b3d82b69a5@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65842@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65842@smartserver.smartshare.dk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.173.196]
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

DQoNCj4gPiA+ID4gPiBBZGRlZCBjYWNoZSBndWFyZCBhZnRlciB0aGUgdGFibGUgaG9sZGluZyB0
aGUgcmluZyBlbGVtZW50cywgdG8NCj4gPiBhdm9pZA0KPiA+ID4gPiA+IGZhbHNlIHNoYXJpbmcg
Y29uZmxpY3RzIGNhdXNlZCBieSBuZXh0LWxpbmUgaGFyZHdhcmUgcHJlZmV0Y2hlcnMNCj4gPiB3
aGVuDQo+ID4gPiA+ID4gYWNjZXNzaW5nIGVsZW1lbnRzIGF0IHRoZSBlbmQgb2YgdGhlIHJpbmcg
dGFibGUuDQo+ID4gPiA+DQo+ID4gPiA+IEkgZG9uJ3Qgc2VlIGFueSBoYXJtIHdpdGggaXQsIGFu
ZCBpbiB0aGVvcnkgaXQgbWlnaHQgaGVscCBpbiBzb21lDQo+ID4gPiA+IGNhc2VzLi4uDQo+ID4g
PiA+IFRob3VnaCBJIHdvbmRlciBob3cgcmVhbCBpcyB0aGF0IHByb2JsZW0/DQo+ID4gPiA+IERp
ZCB5b3UgZXZlciBvYnNlcnZlIHN1Y2ggY29udGVudGlvbiB0byBoYXBwZW4/DQo+ID4gPg0KPiA+
ID4gSSBuZXZlciBvYnNlcnZlZCBhIHByb2JsZW0gd2l0aCB0aGlzLg0KPiA+ID4gVGhlIHJpc2sg
b2YgY29udGVudGlvbiBkZXBlbmRzIG9uIHdoYXQgaXMgYWxsb2NhdGVkIGluIHRoZSBtZW1vcnkN
Cj4gPiBhZnRlciB0aGUgcmluZy4NCj4gPiA+IFdoaWNoIGlzIGFwcGxpY2F0aW9uIHNwZWNpZmlj
Lg0KPiA+ID4NCj4gPiA+IEl0IHNlZW1zIGxpa2UgYSBwdXJlbHkgdGhlb3JldGljYWwgaXNzdWUs
IGJ1dCBzaG91bGQgYmUgZml4ZWQgYW55d2F5LA0KPiA+IHRvIGVsaW1pbmF0ZQ0KPiA+ID4gdGhh
dCByaXNrLg0KPiA+DQo+ID4gT2ssIGFzIEkgc2FpZCBJIHNlZSBubyBoYXJtIHdpdGggaXQuDQo+
ID4gU2hvdWxkIHdlIGRvY3VtZW50IHRoaXMgY2hhbmdlIHNvbWV3aGVyZT8gUk4gb3IgUEc/DQo+
IA0KPiBXZSBkb24ndCB3YW50IHRoZSByZWxlYXNlIG5vdGVzIG92ZXJmbG93aW5nIHdpdGggbWlu
b3IgZGV0YWlscy4NCj4gSU1PLCB0aGlzIGNoYW5nZSBpcyBiZWxvdyB0aGUgdGhyZXNob2xkIGZv
ciB3aGF0IHBlb3BsZSBtaWdodCBjYXJlIGFib3V0Lg0KPiBQZW9wbGUgaW50ZXJlc3RlZCBpbiB0
aGUgZGV0YWlsZWQgY2hhbmdlcyBiZXR3ZWVuIHJlbGVhc2VzIHNob3VsZCByZWFkIHRoZSBnaXQN
Cj4gbG9nLg0KDQpJIHN0aWxsIHRoaW5rIHdlIGRvIG5lZWQgZG9jdW1lbnQgc29tZXdoZXJlIHdo
eSB3ZSBkb2luZyBpdC4NCklmIHlvdSB0aGluayBSTiBvciBQRyBpcyBub3QgdGhlIHJpZ2h0IHBs
YWNlLCBsZXQncyBqdXN0IHB1dCBpdCBhcyBhIGNvbW1lbnQgZm9yIHRoYXQgcGFydGljdWxhciBm
dW5jdGlvbi4NCg0KPiBBbHNvLCBJIGRvbid0IHRoaW5rIGl0J3Mgd29ydGggYmFja3BvcnRpbmcs
IGJlY2F1c2UgSSBjb25zaWRlciBpdCB1bmxpa2VseSB0byBoYXZlDQo+IGFueSByZWFsIGVmZmVj
dC4NCj4gSW4gdGhlIGNvbnRleHQgb2YgYmFja3BvcnRpbmcsIGl0IGNvdWxkIGJlIGNvbnNpZGVy
ZWQgYSBwZXJmb3JtYW5jZQ0KPiBpbXByb3ZlbWVudCByYXRoZXIgdGhhbiBhIGJ1ZyBmaXguDQoN
CkkgZG9uJ3Qgc2VlIG11Y2ggcG9pbnQgdG8gYmFja3BvcnQgaXQuDQoNCj4gDQo+ID4gQWNrZWQt
Ynk6IEtvbnN0YW50aW4gQW5hbnlldiA8a29uc3RhbnRpbi5hbmFueWV2QGh1YXdlaS5jb20+DQo+
ID4NCj4gPiA+ID4NCj4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBNb3J0ZW4gQnLDuHJ1cCA8bWJA
c21hcnRzaGFyZXN5c3RlbXMuY29tPg0KPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+ICBsaWIvcmlu
Zy9ydGVfcmluZy5jIHwgMyArKysNCj4gPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0
aW9ucygrKQ0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2xpYi9yaW5nL3J0ZV9y
aW5nLmMgYi9saWIvcmluZy9ydGVfcmluZy5jDQo+ID4gPiA+ID4gaW5kZXggZjEwMDUwYTFjNC4u
OWNjYzYyY2Q0MiAxMDA2NDQNCj4gPiA+ID4gPiAtLS0gYS9saWIvcmluZy9ydGVfcmluZy5jDQo+
ID4gPiA+ID4gKysrIGIvbGliL3JpbmcvcnRlX3JpbmcuYw0KPiA+ID4gPiA+IEBAIC03Myw4ICs3
MywxMSBAQCBydGVfcmluZ19nZXRfbWVtc2l6ZV9lbGVtKHVuc2lnbmVkIGludCBlc2l6ZSwNCj4g
PiA+ID4gdW5zaWduZWQNCj4gPiA+ID4gPiBpbnQgY291bnQpDQo+ID4gPiA+ID4gIAkJcmV0dXJu
IC1FSU5WQUw7DQo+ID4gPiA+ID4gIAl9DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiArCXN0YXRpY19h
c3NlcnQoc2l6ZW9mKHN0cnVjdCBydGVfcmluZykgPT0NCj4gPiA+ID4gPiBSVEVfQ0FDSEVfTElO
RV9ST1VORFVQKHNpemVvZihzdHJ1Y3QgcnRlX3JpbmcpKSwNCj4gPiA+ID4gPiArCQkJIlNpemUg
b2Ygc3RydWN0IHJ0ZV9yaW5nIG5vdCBjYWNoZSBsaW5lDQo+ID4gYWxpZ25lZCIpOw0KPiA+ID4g
PiA+ICAJc3ogPSBzaXplb2Yoc3RydWN0IHJ0ZV9yaW5nKSArIChzc2l6ZV90KWNvdW50ICogZXNp
emU7DQo+ID4gPiA+ID4gIAlzeiA9IFJURV9BTElHTihzeiwgUlRFX0NBQ0hFX0xJTkVfU0laRSk7
DQo+ID4gPiA+ID4gKwlzeiArPSBSVEVfQ0FDSEVfR1VBUkRfTElORVMgKiBSVEVfQ0FDSEVfTElO
RV9TSVpFOw0KPiA+ID4gPiA+ICAJcmV0dXJuIHN6Ow0KPiA+ID4gPiA+ICB9DQo+ID4gPiA+ID4N
Cj4gPiA+ID4gPiAtLQ0KPiA+ID4gPiA+IDIuNDMuMA0KDQo=
