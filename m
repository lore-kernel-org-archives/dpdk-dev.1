Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E32CC83F09
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Jul 2025 17:58:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 874C240649;
	Tue,  8 Jul 2025 19:58:34 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 2027640292;
 Tue,  8 Jul 2025 19:58:31 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bc8084pqLz6D8qv;
 Wed,  9 Jul 2025 01:55:20 +0800 (CST)
Received: from frapeml500006.china.huawei.com (unknown [7.182.85.219])
 by mail.maildlp.com (Postfix) with ESMTPS id D45451402F5;
 Wed,  9 Jul 2025 01:58:30 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500006.china.huawei.com (7.182.85.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 8 Jul 2025 19:58:30 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Tue, 8 Jul 2025 19:58:30 +0200
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: David Marchand <david.marchand@redhat.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>,
 "Yipeng Wang" <yipeng1.wang@intel.com>, Sameh Gobriel
 <sameh.gobriel@intel.com>, "Bruce Richardson" <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>, John McNamara
 <john.mcnamara@intel.com>
Subject: RE: [PATCH v2 08/10] hash: fix unaligned access in predictable RSS
Thread-Topic: [PATCH v2 08/10] hash: fix unaligned access in predictable RSS
Thread-Index: AQHb5EY+uzNGJsGlUUGvOTO5dcxbU7Qc/VpggArNbICAAMumoA==
Date: Tue, 8 Jul 2025 17:58:29 +0000
Message-ID: <ab72d9487cfa40ce94e27f6f067278c6@huawei.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250623135242.461965-1-david.marchand@redhat.com>
 <20250623135242.461965-9-david.marchand@redhat.com>
 <70c7ba78c4324495bfd317e38e926958@huawei.com>
 <CAJFAV8zAz27vKfA_zry8h6oJYA-kKTpOyzTpt-_PCMTvKmL_WA@mail.gmail.com>
In-Reply-To: <CAJFAV8zAz27vKfA_zry8h6oJYA-kKTpOyzTpt-_PCMTvKmL_WA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.138.73]
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

DQo+IE9uIFR1ZSwgSnVsIDEsIDIwMjUgYXQgMTA6MzbigK9BTSBLb25zdGFudGluIEFuYW55ZXYN
Cj4gPGtvbnN0YW50aW4uYW5hbnlldkBodWF3ZWkuY29tPiB3cm90ZToNCj4gPiA+IENhdWdodCBi
eSBVQlNhbjoNCj4gPiA+DQo+ID4gPiAuLi9saWIvaGFzaC9ydGVfdGhhc2guYzo0MjE6ODogcnVu
dGltZSBlcnJvcjogbG9hZCBvZiBtaXNhbGlnbmVkIGFkZHJlc3MNCj4gPiA+ICAgICAgIDB4MDAw
MTgxNmMyZGEzIGZvciB0eXBlICd1aW50MzJfdCcgKGFrYSAndW5zaWduZWQgaW50JyksDQo+ID4g
PiAgICAgICB3aGljaCByZXF1aXJlcyA0IGJ5dGUgYWxpZ25tZW50DQo+ID4gPg0KPiA+ID4gRml4
ZXM6IDI4ZWJmZjExYzJkYyAoImhhc2g6IGFkZCBwcmVkaWN0YWJsZSBSU1MiKQ0KPiA+ID4gQ2M6
IHN0YWJsZUBkcGRrLm9yZw0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IERhdmlkIE1hcmNo
YW5kIDxkYXZpZC5tYXJjaGFuZEByZWRoYXQuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgbGliL2hh
c2gvcnRlX3RoYXNoLmMgfCA2ICsrKy0tLQ0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2Vy
dGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2xpYi9o
YXNoL3J0ZV90aGFzaC5jIGIvbGliL2hhc2gvcnRlX3RoYXNoLmMNCj4gPiA+IGluZGV4IDZjNjYy
YmYxNGYuLjZkNGRiZWE2ZDcgMTAwNjQ0DQo+ID4gPiAtLS0gYS9saWIvaGFzaC9ydGVfdGhhc2gu
Yw0KPiA+ID4gKysrIGIvbGliL2hhc2gvcnRlX3RoYXNoLmMNCj4gPiA+IEBAIC00MTUsMTAgKzQx
NSwxMCBAQCBnZW5lcmF0ZV9zdWJrZXkoc3RydWN0IHJ0ZV90aGFzaF9jdHggKmN0eCwgc3RydWN0
IHRoYXNoX2xmc3IgKmxmc3IsDQo+ID4gPiAgc3RhdGljIGlubGluZSB1aW50MzJfdA0KPiA+ID4g
IGdldF9zdWJ2YWx1ZShzdHJ1Y3QgcnRlX3RoYXNoX2N0eCAqY3R4LCB1aW50MzJfdCBvZmZzZXQp
DQo+ID4gPiAgew0KPiA+ID4gLSAgICAgdWludDMyX3QgKnRtcCwgdmFsOw0KPiA+ID4gKyAgICAg
dWludDMyX3QgdG1wLCB2YWw7DQo+ID4gPg0KPiA+ID4gLSAgICAgdG1wID0gKHVpbnQzMl90ICop
KCZjdHgtPmhhc2hfa2V5W29mZnNldCA+PiAzXSk7DQo+ID4gPiAtICAgICB2YWwgPSBydGVfYmVf
dG9fY3B1XzMyKCp0bXApOw0KPiA+ID4gKyAgICAgbWVtY3B5KCZ0bXAsICZjdHgtPmhhc2hfa2V5
W29mZnNldCA+PiAzXSwgc2l6ZW9mKHRtcCkpOw0KPiA+ID4gKyAgICAgdmFsID0gcnRlX2JlX3Rv
X2NwdV8zMih0bXApOw0KPiA+DQo+ID4gSnVzdCB3b25kZXIgZG8geW91IGd1eXMgY29uc2lkZXIg
aXQgYXMgYSByZWFsIG9uZT8NCj4gPiBBRkFJSywgYWxsIGFyY2hpdGVjdHVyZXMgdGhhdCB3ZSBj
YXJlIGFib3V0IGRvIHN1cHBvcnQgdW5hbGlnbmVkIGxvYWQgZm9yIDMyLWJpdCBpbnRlZ2Vycy4N
Cj4gDQo+IFdlbGwgdGhpcyBpcyB1bmRlZmluZWQgYmVoYXZpb3IsIHJlZ2FyZGxlc3Mgb2Ygd2hh
dCB0aGUgYXJjaGl0ZWN0dXJlIHN1cHBvcnQuDQo+IEFuZCB0aGUgY29tcGlsZXIgbWF5IGVuZCB1
cCBnZW5lcmF0aW5nIHdyb25nIGNvZGUuDQoNClByb2JhYmx5LCB0aG91Z2ggQUZBSUssIHdlIGRv
IGhhdmUgYSBsb3Qgb2YgY29kZSB0aGF0IGxvYWQgMzItYml0IHZhbHVlcyBmcm9tIHBvc3NpYmx5
DQpub24tYWxpZ25lZCBhZGRyZXNzZXMgKG5lYXJseSBhbGwgcGFja2V0IHBhcnNpbmcgZG9lcyB0
aGF0KS4NCkkgd29uZGVyIHdoeSBpdCBvbmx5IGNvbXBsYWluZWQgb25seSBhYm91dCB0aGF0IG9u
ZT8gDQpCVFcsIHdvdWxkIG91ciAndW5hbGlnbmVkX3VpbnQzMl90JyB0eXBlIGhlbHAgaGVyZT8N
Cg0KPiBJIGNvdWxkIHJldmlzaXQgdGhpcyBjaGFuZ2Ugd2l0aCB0aGUgYWxpYXNpbmcgdHJpY2sg
KHVzZWQgZm9yIHJ0ZV9tZW1jcHkpLg0KPiANCj4gDQo+IC0tDQo+IERhdmlkIE1hcmNoYW5kDQo+
IA0KDQo=
