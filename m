Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AABC83F03
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Jul 2025 15:08:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3A6E540267;
	Thu,  3 Jul 2025 17:08:07 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id D44D740264;
 Thu,  3 Jul 2025 17:08:05 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bY0Vv4gR4z6L5C6;
 Thu,  3 Jul 2025 23:07:35 +0800 (CST)
Received: from frapeml100001.china.huawei.com (unknown [7.182.85.63])
 by mail.maildlp.com (Postfix) with ESMTPS id 09FFE140371;
 Thu,  3 Jul 2025 23:08:05 +0800 (CST)
Received: from frapeml500002.china.huawei.com (7.182.85.205) by
 frapeml100001.china.huawei.com (7.182.85.63) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 3 Jul 2025 17:08:04 +0200
Received: from frapeml500002.china.huawei.com ([7.182.85.205]) by
 frapeml500002.china.huawei.com ([7.182.85.205]) with mapi id 15.01.2507.039;
 Thu, 3 Jul 2025 17:08:04 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: David Marchand <david.marchand@redhat.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>, "Bruce
 Richardson" <bruce.richardson@intel.com>, Robin Jarry <rjarry@redhat.com>
Subject: RE: [PATCH v2 02/10] test/telemetry: fix test calling all commands
Thread-Topic: [PATCH v2 02/10] test/telemetry: fix test calling all commands
Thread-Index: AQHb5EY4znvM8M6LkkyM82eIHpHGJ7QSdYHggAKKJICAADJ2MIALLBCAgAAu3EA=
Date: Thu, 3 Jul 2025 15:08:04 +0000
Message-ID: <21dbcf5642584dcb8f05059556dd04e6@huawei.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250623135242.461965-1-david.marchand@redhat.com>
 <20250623135242.461965-3-david.marchand@redhat.com>
 <08ce2412f18d477199d3e02fdcf9bcd4@huawei.com>
 <CAJFAV8wb9ec_O2Dj8vX8YF9ksXzSDgCGefCaNEFs7HfeKhWjMA@mail.gmail.com>
 <afe059471e604b5c9319cb7312e69c23@huawei.com>
 <CAJFAV8xryLsxkLJMCDT5-o4s2-fMU5G2bcX066WEXaT=aXQG6Q@mail.gmail.com>
In-Reply-To: <CAJFAV8xryLsxkLJMCDT5-o4s2-fMU5G2bcX066WEXaT=aXQG6Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.137.64]
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
aWQubWFyY2hhbmRAcmVkaGF0LmNvbT4NCj4gU2VudDogVGh1cnNkYXkgMyBKdWx5IDIwMjUgMTU6
MTANCj4gDQo+IE9uIFRodSwgSnVuIDI2LCAyMDI1IGF0IDExOjUz4oCvQU0gTWFyYXQgS2hhbGls
aSA8bWFyYXQua2hhbGlsaUBodWF3ZWkuY29tPg0KPiB3cm90ZToNCj4gPiA+IEBAIC0xNSw3ICsx
NSw3IEBAIGNhbGxfYWxsX3RlbGVtZXRyeSgpIHsNCj4gPiA+ICAgICAgdGVsZW1ldHJ5X3Njcmlw
dD0kcm9vdGRpci91c2VydG9vbHMvZHBkay10ZWxlbWV0cnkucHkNCj4gPiA+ICAgICAgZWNobyA+
JHRtcG91dHB1dA0KPiA+ID4gICAgICBlY2hvICJUZWxlbWV0cnkgY29tbWFuZHMgbG9nOiIgPj4k
dG1wb3V0cHV0DQo+ID4gPiAtICAgIGZvciBjbWQgaW4gJChlY2hvIC8gfCAkdGVsZW1ldHJ5X3Nj
cmlwdCB8IGpxIC1yICcuWyIvIl1bXScpDQo+ID4gPiArICAgIGVjaG8gLyB8ICR0ZWxlbWV0cnlf
c2NyaXB0IHwganEgLXIgJy5bIi8iXVtdJyB8IHdoaWxlIHJlYWQgY21kDQo+ID4gPiAgICAgIGRv
DQo+ID4gPiAgICAgICAgICBmb3IgaW5wdXQgaW4gJGNtZCAkY21kLDAgJGNtZCx6DQo+ID4gPiAg
ICAgICAgICBkbw0KPiA+ID4gQEAgLTI1LDQgKzI1LDUgQEAgY2FsbF9hbGxfdGVsZW1ldHJ5KCkg
ew0KPiA+ID4gICAgICBkb25lDQo+ID4gPiAgfQ0KPiA+ID4NCj4gPiA+IC0oc2xlZXAgMSAmJiBj
YWxsX2FsbF90ZWxlbWV0cnkgJiYgZWNobyBxdWl0KSB8ICRADQo+ID4gPiArISBzZXQgLW8gfCBn
cmVwIC1xIHBpcGVmYWlsIHx8IHNldCAtbyBwaXBlZmFpbA0KPiA+ID4gKyhzZXQgLWU7ICEgc2V0
IC1vIHwgZ3JlcCAtcSBwaXBlZmFpbCB8fCBzZXQgLW8gcGlwZWZhaWw7IHNsZWVwIDEgJiYNCj4g
PiA+IGNhbGxfYWxsX3RlbGVtZXRyeSAmJiBlY2hvIHF1aXQpIHwgJEANCj4gPg0KPiA+IEkgMTAw
JSBhZ3JlZSB3aXRoIHRoZSBpZGVhLCBidXQgc2FkbHkgSSdtIG5vdCBmYW1pbGlhciB3aXRoIHNo
ZWxsIHNjcmlwdGluZw0KPiBlbm91Z2ggdG8gc3VnZ2VzdCBvciByZXZpZXcgdGhpcyBkaWZmLiBJ
cyBgZm9yIGNtZCBpbmAgYWx3YXlzIGVxdWl2YWxlbnQgdG8NCj4gYHdoaWxlIHJlYWQgY21kYD8g
SXMgQ0kgZXZlciBleGVjdXRpbmcgaXQgaW4gYmFzaCBmb3Igb3VyIGF0dGVtcHQgdG8gc2V0DQo+
IHBpcGVmYWlsIHRvIGJlIGp1c3RpZmllZD8gSXMgaXQgaWRpb21hdGljPyBJIGhvcGUgc29tZW9u
ZSBlbHNlIGhlcmUgY2FuIGhlbHANCj4gd2l0aCB0aGlzLg0KPiANCj4gLSBGcm9tIG15IGV4cGVy
aW1lbnQsIHRoZSBkaWZmZXJlbmNlIGJldHdlZW4gJ2ZvciBjbWQgaW4gJCh4eHgpJyBhbmQNCj4g
J3h4eCB8IHdoaWxlIHJlYWQgY21kJyBpcyB0aGF0IGFuIGVycm9yIGlzIG5vdCBwcm9wYWdhdGVk
IGluIHRoZQ0KPiBmb3JtZXIgY2FzZS4NCj4gDQo+IEkgc3VwcG9zZSBpdCBoYXMgdG8gZG8gd2l0
aCB0aGUgZm9yIGxvb3AsIGFzIGRlc2NyaWJlZCBpbiBQT1NJWDoNCj4gIiIiDQo+IEV4aXQgU3Rh
dHVzDQo+IA0KPiBJZiB0aGVyZSBpcyBhdCBsZWFzdCBvbmUgaXRlbSBpbiB0aGUgbGlzdCBvZiBp
dGVtcywgdGhlIGV4aXQgc3RhdHVzIG9mDQo+IGEgZm9yIGNvbW1hbmQgc2hhbGwgYmUgdGhlIGV4
aXQgc3RhdHVzIG9mIHRoZSBsYXN0IGNvbXBvdW5kLWxpc3QNCj4gZXhlY3V0ZWQuIElmIHRoZXJl
IGFyZSBubyBpdGVtcywgdGhlIGV4aXQgc3RhdHVzIHNoYWxsIGJlIHplcm8uDQo+ICIiIg0KPiAN
Cj4gT24gZXJyb3Igb2YgdGhlIGNvbW1hbmQsIHRoZXJlIGlzIG5vIGl0ZW0gaW4gdGhlIGxpc3Qg
b2YgdGhlIGZvciBsb29wLA0KPiBzbyB0aGUgbG9vcCBpcyBvdmVyYWxsIGV2YWx1YXRlZCBhcyBh
IHN1Y2Nlc3MuDQoNCkJUVyB3aGF0IHdvdWxkIGJlIHRoZSBiZWhhdmlvdXIgb2YgdGhlIG5ldyBj
b2RlIGZvciB0aGUgZW1wdHkgaW5wdXQ/DQoNCj4gLSBBcyBmYXIgYXMgdGhlIENJIGlzIGNvbmNl
bmVkLCB0aGUgdW5pdCB0ZXN0cyBhcmUgcnVuIG9uIHZhcmlvdXMNCj4gZGlzdHJpYnV0aW9ucywg
aW5jbHVkaW5nIEZlZG9yYSBhdCBVTkguDQo+IFNpbmNlIHRoZSBkZWZhdWx0IHNoZWxsIGZvciBG
ZWRvcmEgaXMgYmFzaCwgdGhlbiBhbiBlcnJvciB3b3VsZCBiZSBjYXVnaHQNCj4gdGhlcmUuDQo+
IA0KPiANCj4gPg0KPiA+IFBlcmhhcHMgdGhpcyBzaG91bGQganVzdCBiZSByZS13cml0dGVuIGlu
IFB5dGhvbi4gSXQgZGVwZW5kcyBvbiBhIFB5dGhvbg0KPiBzY3JpcHQgYW55d2F5Lg0KPiANCj4g
TWF5YmUuDQo+IFRob3VnaCBpZiB3ZSBnbyB0aGF0IHdheSwgd2Ugd291bGQgbmVlZCBzb21lIHJl
ZmFjdG9yaW5nIG9mIHRoZQ0KPiB0ZWxlbWV0cnkgY2xpZW50IHNjcmlwdCwgZGVmaW5pbmcgc29t
ZSBweXRob24gY2xhc3MgZXRjLi4uDQoNCkkgZ3Vlc3MgaXQncyBhIGJhbGFuY2UgYmV0d2VlbiBl
ZmZvcnQgYW5kIGdhaW4sIGFuZCB3ZSBhcmUgbm90IG1ha2luZyBpdCB3b3JzZSAoaXQgd2lsbCBz
dGlsbCBuZWVkIHRvIHBhc3MgQ0kgd2hlcmUgd2UgY2FuIGRvdWJsZSBjaGVjayB0aGUgYmVoYXZp
b3VyKS4uLiBJIG5vdyBzdXBwb3J0IHRoaXMgY2hhbmdlLCB0aGFua3MgZm9yIGRldGFpbGVkIGV4
cGxhbmF0aW9ucyBhbmQgcmVzZWFyY2guDQoNCkFja2VkLWJ5OiBNYXJhdCBLaGFsaWxpIDxtYXJh
dC5raGFsaWxpQGh1YXdlaS5jb20+DQo=
