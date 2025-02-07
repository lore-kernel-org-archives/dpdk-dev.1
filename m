Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA610C02194
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 14:23:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E4CD42DC1;
	Fri,  7 Feb 2025 15:23:43 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id D0D8942E00
 for <dev@dpdk.org>; Fri,  7 Feb 2025 15:23:41 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YqGNR5MvFz6L4xV;
 Fri,  7 Feb 2025 22:20:55 +0800 (CST)
Received: from frapeml100008.china.huawei.com (unknown [7.182.85.131])
 by mail.maildlp.com (Postfix) with ESMTPS id 9926A1400D8;
 Fri,  7 Feb 2025 22:23:40 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100008.china.huawei.com (7.182.85.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 7 Feb 2025 15:23:40 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Fri, 7 Feb 2025 15:23:40 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: David Marchand <david.marchand@redhat.com>, Andre Muezerie
 <andremue@linux.microsoft.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "thomas@monjalon.net"
 <thomas@monjalon.net>, "honnappa.nagarahalli@arm.com"
 <honnappa.nagarahalli@arm.com>
Subject: RE: [PATCH v22 00/27] remove use of VLAs for Windows
Thread-Topic: [PATCH v22 00/27] remove use of VLAs for Windows
Thread-Index: AQHbeDcwSpSc/vf1v0aa09+A8QveyLM6roeAgAE1MSA=
Date: Fri, 7 Feb 2025 14:23:40 +0000
Message-ID: <4810322be9134e939513693ae1e88884@huawei.com>
References: <1713397319-26135-1-git-send-email-roretzla@linux.microsoft.com>
 <1738805610-17507-1-git-send-email-andremue@linux.microsoft.com>
 <CAJFAV8zzqa50xJLTk2gb2eZR2fSXNaLX7rHkEx_jdJkERk7Asw@mail.gmail.com>
In-Reply-To: <CAJFAV8zzqa50xJLTk2gb2eZR2fSXNaLX7rHkEx_jdJkERk7Asw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.146.145]
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

SGkgRGF2aWQsDQoNCj4gPiBBcyBwZXIgZ3VpZGFuY2UgdGVjaG5pY2FsIGJvYXJkIG1lZXRpbmcg
MjAyNC8wNC8xNy4gVGhpcyBzZXJpZXMNCj4gPiByZW1vdmVzIHRoZSB1c2Ugb2YgVkxBcyBmcm9t
IGNvZGUgYnVpbHQgZm9yIFdpbmRvd3MgZm9yIGFsbCAzDQo+ID4gdG9vbGNoYWlucy4gSWYgdGhl
cmUgYXJlIGFkZGl0aW9uYWwgb3Bwb3J0dW5pdGllcyB0byBjb252ZXJ0IFZMQXMNCj4gPiB0byBy
ZWd1bGFyIEMgYXJyYXlzIHBsZWFzZSBwcm92aWRlIHRoZSBkZXRhaWxzIGZvciBpbmNvcnBvcmF0
aW9uDQo+ID4gaW50byB0aGUgc2VyaWVzLg0KPiA+DQo+ID4gTVNWQyBkb2VzIG5vdCBzdXBwb3J0
IFZMQXMsIHJlcGxhY2UgVkxBcyB3aXRoIHN0YW5kYXJkIEMgYXJyYXlzDQo+ID4gb3IgYWxsb2Nh
KCkuIGFsbG9jYSgpIGlzIGF2YWlsYWJsZSBmb3IgYWxsIHRvb2xjaGFpbi9wbGF0Zm9ybQ0KPiA+
IGNvbWJpbmF0aW9ucyBvZmZpY2lhbGx5IHN1cHBvcnRlZCBieSBEUERLLg0KPiANCj4gLSBJIGhh
dmUgb25lIGNvbmNlcm4gd3J0IHBhdGNoIDcuDQo+IFRoaXMgY2hhbmdlcyB0aGUgQVBJL0FCSSBv
ZiB0aGUgUkNVIGxpYnJhcnkuDQo+IEFCSSBjYW4ndCBiZSBicm9rZW4gaW4gdGhlIDI1LjAzIHJl
bGVhc2UuDQo+IA0KPiBTaW5jZSBNU1ZDIGJ1aWxkcyBkbyBub3QgaW5jbHVkZSBSQ1UgeWV0LCBJ
IHNraXBwZWQgdGhpcyBjaGFuZ2UgYW5kDQo+IGFkanVzdGVkIHRoaXMgbGlicmF5IG1lc29uLmJ1
aWxkLg0KPiANCj4gS29uc3RhbnRpbiwgZG8geW91IHRoaW5rIHBhdGNoIDcgY291bGQgYmUgcmV3
cml0dGVuIHRvIG1ha2UgdXNlIG9mDQo+IGFsbG9jYSgpIGFuZCBhdm9pZCBhbiBBUEkgY2hhbmdl
Pw0KPiBodHRwczovL3BhdGNod29yay5kcGRrLm9yZy9wcm9qZWN0L2RwZGsvcGF0Y2gvMTczODgw
NTYxMC0xNzUwNy04LWdpdC1zZW5kLWVtYWlsLWFuZHJlbXVlQGxpbnV4Lm1pY3Jvc29mdC5jb20v
DQoNCkkgYW0gbm90IGJpZyBmYW4gb2YgYWxsb2NhKCkgYXBwcm9hY2gsIGJ1dCB5ZXMgaXQgaXMg
c3VyZWx5IHBvc3NpYmxlLg0KQlRXLCB3aHkgaXQgaXMgY29uc2lkZXJlZCBhZCBBUEkvQUJJIGNo
YW5nZT8NCkJlY2F1c2Ugd2UgaW50cm9kdWNlIGV4dHJhIGxpbWl0IG9uIG1heCBhbGxvd2FibGUg
c2l6ZT8NCklmIHRoYXQgd291bGQgaGVscCBzb21laG93LCB3ZSBjYW4gbWFrZSBpdCBldmVuIGJp
Z2dlcjogMUsgb3Igc28uIA0KDQo+IA0KPiAtIFRoZXJlIGlzIGFsc28gc29tZSBWTEEgaW4gZXhh
bXBsZXMvbDJmd2QtY2F0LCBzbyBJIGhhZCB0byBhZGp1c3QNCj4gdGhpcyBleGFtcGxlIG1lc29u
LmJ1aWxkIGFjY29yZGluZ2x5Lg0KPiANCj4gU2VyaWVzIGFwcGxpZWQsIHRoYW5rcyBBbmRyw6ku
DQo+IA0KPiANCj4gLS0NCj4gRGF2aWQgTWFyY2hhbmQNCj4gDQoNCg==
