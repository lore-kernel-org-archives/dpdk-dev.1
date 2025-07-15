Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BF6C83F21
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Jul 2025 13:32:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CAE054028C;
	Tue, 15 Jul 2025 15:32:58 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 9FC674021E;
 Tue, 15 Jul 2025 15:32:57 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bhKpr5X2Wz6L5Gb;
 Tue, 15 Jul 2025 21:31:48 +0800 (CST)
Received: from frapeml100006.china.huawei.com (unknown [7.182.85.201])
 by mail.maildlp.com (Postfix) with ESMTPS id 8C153140144;
 Tue, 15 Jul 2025 21:32:56 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100006.china.huawei.com (7.182.85.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Jul 2025 15:32:56 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Tue, 15 Jul 2025 15:32:56 +0200
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: David Marchand <david.marchand@redhat.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>,
 "Yipeng Wang" <yipeng1.wang@intel.com>, Sameh Gobriel
 <sameh.gobriel@intel.com>, "Bruce Richardson" <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>, John McNamara
 <john.mcnamara@intel.com>
Subject: RE: [PATCH v2 08/10] hash: fix unaligned access in predictable RSS
Thread-Topic: [PATCH v2 08/10] hash: fix unaligned access in predictable RSS
Thread-Index: AQHb5EY+uzNGJsGlUUGvOTO5dcxbU7Qc/VpggArNbICAAMumoIAKfsYAgAA7qQA=
Date: Tue, 15 Jul 2025 13:32:56 +0000
Message-ID: <c7850966167843bdb9fdb2b3ff2c335c@huawei.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250623135242.461965-1-david.marchand@redhat.com>
 <20250623135242.461965-9-david.marchand@redhat.com>
 <70c7ba78c4324495bfd317e38e926958@huawei.com>
 <CAJFAV8zAz27vKfA_zry8h6oJYA-kKTpOyzTpt-_PCMTvKmL_WA@mail.gmail.com>
 <ab72d9487cfa40ce94e27f6f067278c6@huawei.com>
 <CAJFAV8xGBHUHD7MEymHJ4yovZUwiTGeZAoGPrZEJNtCvJ=h=Sg@mail.gmail.com>
In-Reply-To: <CAJFAV8xGBHUHD7MEymHJ4yovZUwiTGeZAoGPrZEJNtCvJ=h=Sg@mail.gmail.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2aWQgTWFyY2hhbmQg
PGRhdmlkLm1hcmNoYW5kQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIEp1bHkgMTUsIDIw
MjUgMTI6NTcgUE0NCj4gVG86IEtvbnN0YW50aW4gQW5hbnlldiA8a29uc3RhbnRpbi5hbmFueWV2
QGh1YXdlaS5jb20+DQo+IENjOiBkZXZAZHBkay5vcmc7IHN0YWJsZUBkcGRrLm9yZzsgWWlwZW5n
IFdhbmcgPHlpcGVuZzEud2FuZ0BpbnRlbC5jb20+OyBTYW1laCBHb2JyaWVsIDxzYW1laC5nb2Jy
aWVsQGludGVsLmNvbT47IEJydWNlDQo+IFJpY2hhcmRzb24gPGJydWNlLnJpY2hhcmRzb25AaW50
ZWwuY29tPjsgVmxhZGltaXIgTWVkdmVka2luIDx2bGFkaW1pci5tZWR2ZWRraW5AaW50ZWwuY29t
PjsgSm9obiBNY05hbWFyYQ0KPiA8am9obi5tY25hbWFyYUBpbnRlbC5jb20+DQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggdjIgMDgvMTBdIGhhc2g6IGZpeCB1bmFsaWduZWQgYWNjZXNzIGluIHByZWRp
Y3RhYmxlIFJTUw0KPiANCj4gT24gVHVlLCBKdWwgOCwgMjAyNSBhdCA3OjU44oCvUE0gS29uc3Rh
bnRpbiBBbmFueWV2DQo+IDxrb25zdGFudGluLmFuYW55ZXZAaHVhd2VpLmNvbT4gd3JvdGU6DQo+
ID4gPiA+IEp1c3Qgd29uZGVyIGRvIHlvdSBndXlzIGNvbnNpZGVyIGl0IGFzIGEgcmVhbCBvbmU/
DQo+ID4gPiA+IEFGQUlLLCBhbGwgYXJjaGl0ZWN0dXJlcyB0aGF0IHdlIGNhcmUgYWJvdXQgZG8g
c3VwcG9ydCB1bmFsaWduZWQgbG9hZCBmb3IgMzItYml0IGludGVnZXJzLg0KPiA+ID4NCj4gPiA+
IFdlbGwgdGhpcyBpcyB1bmRlZmluZWQgYmVoYXZpb3IsIHJlZ2FyZGxlc3Mgb2Ygd2hhdCB0aGUg
YXJjaGl0ZWN0dXJlIHN1cHBvcnQuDQo+ID4gPiBBbmQgdGhlIGNvbXBpbGVyIG1heSBlbmQgdXAg
Z2VuZXJhdGluZyB3cm9uZyBjb2RlLg0KPiA+DQo+ID4gUHJvYmFibHksIHRob3VnaCBBRkFJSywg
d2UgZG8gaGF2ZSBhIGxvdCBvZiBjb2RlIHRoYXQgbG9hZCAzMi1iaXQgdmFsdWVzIGZyb20gcG9z
c2libHkNCj4gPiBub24tYWxpZ25lZCBhZGRyZXNzZXMgKG5lYXJseSBhbGwgcGFja2V0IHBhcnNp
bmcgZG9lcyB0aGF0KS4NCj4gPiBJIHdvbmRlciB3aHkgaXQgb25seSBjb21wbGFpbmVkIG9ubHkg
YWJvdXQgdGhhdCBvbmU/DQo+IA0KPiBQcm9iYWJseSBiZWNhdXNlIHVuaXQgdGVzdHMgY292ZXJh
Z2UgaXMgKHRvbykgc21hbGwuDQo+IA0KPiANCj4gPiBCVFcsIHdvdWxkIG91ciAndW5hbGlnbmVk
X3VpbnQzMl90JyB0eXBlIGhlbHAgaGVyZT8NCj4gDQo+IFNpbmNlIG1vc3QgRFBESyBjb2RlIHJl
bHkgb24gYWxpZ25lZCB0eXBlcywgdXNpbmcgYW4gdW5hbGlnbmVkIHR5cGUNCj4gY2FuIHdvcmsg
aWYgd2UgaGF2ZSBhIGZ1bmN0aW9uIHRoYXQgc2VydmVzIGFzIGEgY29udmVyc2lvbiBmcm9tDQo+
IHVuYWxpZ25lZCB0byBhbGlnbmVkIHR5cGVzLg0KPiBJbiB0aGlzIGNvZGUsIHNpbmNlIHRoZSBu
ZXh0IG9wZXJhdGlvbiBpcyBhIGJ5dGUgc3dhcCBvcGVyYXRpb24gb24NCj4gMzJiaXRzLCBJIGRv
bid0IHRoaW5rIHdlIGhhdmUgbWFueSBvcHRpb24gYnV0IHRvIG1lbWNweSgpLg0KDQpbXSBGb3Ig
Y2xhcml0eSwgSSBhbSB0YWxraW5nIGFib3V0IHNvbWV0aGluZyBsaWtlIHRoYXQ6DQpodHRwczov
L2dvZGJvbHQub3JnL3ovdnY2cXpQTVR6DQogDQoNCg==
