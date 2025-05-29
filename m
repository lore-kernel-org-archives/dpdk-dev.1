Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0083FC5AD49
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 May 2025 08:39:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF2804067D;
	Thu, 29 May 2025 10:39:33 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 0EAD4402C5;
 Thu, 29 May 2025 10:39:32 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b7KYC2nX5z6D9SP;
 Thu, 29 May 2025 16:39:27 +0800 (CST)
Received: from frapeml100006.china.huawei.com (unknown [7.182.85.201])
 by mail.maildlp.com (Postfix) with ESMTPS id 2C244140680;
 Thu, 29 May 2025 16:39:31 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100006.china.huawei.com (7.182.85.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 29 May 2025 10:39:30 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Thu, 29 May 2025 10:39:30 +0200
From: "Rui Ferreira (A)" <rui.ferreira1@h-partners.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>, "David
 Marchand" <david.marchand@redhat.com>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>
Subject: RE: [PATCH v2] fix eal/linux: unregister alarm callback before free
Thread-Topic: [PATCH v2] fix eal/linux: unregister alarm callback before free
Thread-Index: AQHbyyv76Nwh1/8UTESe8esGWSNbBbPmdnmAgALZRgA=
Date: Thu, 29 May 2025 08:39:30 +0000
Message-ID: <dcbff1c1ee8c48598294306fe80167ef@h-partners.com>
References: <20250520160150.50401-1-rui.ferreira1@h-partners.com>
 <20250522155944.65342-1-rui.ferreira1@h-partners.com>
 <1969712.QZUTf85G27@thomas>
In-Reply-To: <1969712.QZUTf85G27@thomas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.45.147.141]
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

SGkuIEknbGwgdHJ5IHRvIGhhdmUgYSBsb29rIGluIHRoZSBuZXh0IGNvdXBsZSBkYXlzLiANCg0K
QlINCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUaG9tYXMgTW9uamFs
b24gPHRob21hc0Btb25qYWxvbi5uZXQ+DQo+IFNlbnQ6IFR1ZXNkYXksIE1heSAyNywgMjAyNSAz
OjU0IFBNDQo+IFRvOiBSdWkgRmVycmVpcmEgKEEpIDxydWkuZmVycmVpcmExQGgtcGFydG5lcnMu
Y29tPg0KPiBDYzogZGV2QGRwZGsub3JnOyBzdGFibGVAZHBkay5vcmc7IERhdmlkIE1hcmNoYW5k
DQo+IDxkYXZpZC5tYXJjaGFuZEByZWRoYXQuY29tPjsgS29uc3RhbnRpbiBBbmFueWV2DQo+IDxr
b25zdGFudGluLmFuYW55ZXZAaHVhd2VpLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2Ml0g
Zml4IGVhbC9saW51eDogdW5yZWdpc3RlciBhbGFybSBjYWxsYmFjayBiZWZvcmUgZnJlZQ0KPiAN
Cj4gSGVsbG8sDQo+IA0KPiBEaWQgeW91IHNlZSB0aGUgY29tbWVudCBmcm9tIERhdmlkIGFib3V0
IGZpeGluZyBmb3IgV2luZG93cyBhbmQgRnJlZUJTRA0KPiBhdCB0aGUgc2FtZSB0aW1lPw0KPiBJ
IHRoaW5rIHlvdSBqdXN0IG5lZWQgdG8gYXBwbHkgdGhlIHNhbWUgbG9naWMgaW4gMyBkaWZmZXJl
bnQgcGxhY2VzLg0KPiBJZiB5b3UgY2Fubm90IHRlc3QgYWxsLCB0aGF0J3MgT0sgdG8gc3VibWl0
IHRoZSBjaGFuZ2VzIHdpdGhvdXQgZnVsbCBjb3ZlcmFnZQ0KPiB0ZXN0aW5nLg0KPiANCj4gVGhh
bmsgeW91DQo+IA0KPiANCj4gMjIvMDUvMjAyNSAxNzo1OSwgUnVpIEZlcnJlaXJhOg0KPiA+IFRo
aXMgd2FzIGZsYWdnZWQgYnkgQWRkcmVzcyBzYW5pdGl6ZXIgYXMgYSB1c2UgYWZ0ZXIgZnJlZS4g
VGhlDQo+ID4gaW50cl9oYW5kbGUgcHRyIGlzIHNoYXJlZCBiZXR3ZWVuIHRoZSBtYWluIHRocmVh
ZCBhbmQgdGhlIGludGVycnVwdA0KPiA+IHRocmVhZC4gVGhlIGludGVycnVwdCB0aHJlYWQgY2Fu
IGRlcmVmZXJlbmNlIHRoZSBwdHIgYWZ0ZXIgZnJlZSAoZnJvbQ0KPiA+IHRoZSBhbGFybSBjYWxs
YmFjaykuIGZyZWUgaXMgY2FsbGVkIHdoZW4gdGhlIG1haW4gdGhyZWFkIGNsZWFucyB1cC4NCj4g
Pg0KPiA+IFRoZSBpbnRlcnJ1cHQgdGhyZWFkIG5ldmVyIHRlcm1pbmF0ZXMgKGVhbF9pbnRyX3Ro
cmVhZF9tYWluKSBzbyB1c2UNCj4gPiBydGVfaW50cl9jYWxsYmFja191bnJlZ2lzdGVyX3N5bmMg
ZHVyaW5nIGNsZWFudXAgdG8gZW5zdXJlIHRoZQ0KPiA+IGNhbGxiYWNrIGlzIHJlbW92ZWQgYmVm
b3JlIGZyZWVpbmcgdGhlIHB0ci4NCj4gPg0KPiA+IFRvIGJlIG1vcmUgZGVmZW5zaXZlIGNsZWFy
IG91dCB0aGUgcG9pbnRlciBhbmQgcmVnaXN0cmF0aW9uIHZhcmlhYmxlDQo+ID4gaWYgd2UgY2Fu
IHVucmVnaXN0ZXIuDQo+ID4NCj4gPiBydGVfaW50cl9jYWxsYmFja191bnJlZ2lzdGVyX3N5bmMg
bWF5IChvcHRpb25hbGx5KSB1c2UgdHJhY2VzIHNvIHRoZQ0KPiA+IGFsYXJtIGNsZWFudXAgbXVz
dCBoYXBwZW4gYmVmb3JlIGVhbF90cmFjZV9maW5pIHRvIGF2b2lkIGFjY2Vzc2luZw0KPiA+IGZy
ZWVkIG1lbW9yeS4NCj4gPg0KPiA+IEJ1Z3ppbGxhIElEOiAxNjgzDQo+ID4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBSdWkgRmVycmVpcmEgPHJ1aS5mZXJyZWlyYTFAaC1wYXJ0bmVycy5jb20+DQo+ID4g
LS0tDQo+ID4gIC5tYWlsbWFwICAgICAgICAgICAgICAgICAgfCAxICsNCj4gPiAgbGliL2VhbC9s
aW51eC9lYWwuYyAgICAgICB8IDMgKystDQo+ID4gIGxpYi9lYWwvbGludXgvZWFsX2FsYXJtLmMg
fCA5ICsrKysrKysrLQ0KPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pDQo+IA0KPiANCg0K
