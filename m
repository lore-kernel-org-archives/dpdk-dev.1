Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E3BCAC5AC
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Sep 2025 08:13:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 674F74066A;
	Fri, 26 Sep 2025 10:13:31 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 741024025D;
 Fri, 26 Sep 2025 10:13:29 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cY3Hr1CB7z6L5Zy;
 Fri, 26 Sep 2025 16:13:28 +0800 (CST)
Received: from dubpeml100001.china.huawei.com (unknown [7.214.144.137])
 by mail.maildlp.com (Postfix) with ESMTPS id F07421402ED;
 Fri, 26 Sep 2025 16:13:28 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml100001.china.huawei.com (7.214.144.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 26 Sep 2025 09:13:28 +0100
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Fri, 26 Sep 2025 09:13:28 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Thomas Monjalon <thomas@monjalon.net>, Kai Ji <kai.ji@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Stephen Hemminger
 <stephen@networkplumber.org>, Bruce Richardson <bruce.richardson@intel.com>,
 David Marchand <david.marchand@redhat.com>, "stable@dpdk.org"
 <stable@dpdk.org>, Pablo de Lara <pablo.de.lara.guarch@intel.com>, Fan Zhang
 <fanzhang.oss@gmail.com>, Akhil Goyal <gakhil@marvell.com>
Subject: RE: [EXTERNAL] [dpdk-dev v1] cryptodev: introduce constant-time
 memory comparison
Thread-Topic: [EXTERNAL] [dpdk-dev v1] cryptodev: introduce constant-time
 memory comparison
Thread-Index: AQHcLgZbZIPJMbu4/k+2rD9qRJYYJLSjovUAgACrgQCAANAhsA==
Date: Fri, 26 Sep 2025 08:13:28 +0000
Message-ID: <aeb7d0327c7741a18ff7e3e23a4d8f60@huawei.com>
References: <20250925102223.145471-1-kai.ji@intel.com>
 <CO6PR18MB4484264974305D4A6B065A76D81FA@CO6PR18MB4484.namprd18.prod.outlook.com>
 <3819475.yaVYbkx8dN@thomas>
In-Reply-To: <3819475.yaVYbkx8dN@thomas>
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

DQo+IDI1LzA5LzIwMjUgMTI6MzMsIEFraGlsIEdveWFsOg0KPiA+ID4gKy8qKg0KPiA+ID4gKyAq
IENvbnN0YW50LXRpbWUgbWVtb3J5IGNvbXBhcmlzb24gZm9yIGNyeXB0b2dyYXBoaWMgdXNlLg0K
PiA+ID4gKyAqIFJldHVybnMgMCBpZiB0aGUgbWVtb3J5IHJlZ2lvbnMgYXJlIGVxdWFsLCBub256
ZXJvIG90aGVyd2lzZS4NCj4gPiA+ICsgKiBSdW5zIGluIGNvbnN0YW50IHRpbWUgd2l0aCByZXNw
ZWN0IHRvIHRoZSBsZW5ndGggdG8gcHJldmVudCB0aW1pbmcgYXR0YWNrcy4NCj4gPiA+ICsgKg0K
PiA+ID4gKyAqIEBwYXJhbSBhDQo+ID4gPiArICogICBQb2ludGVyIHRvIHRoZSBmaXJzdCBtZW1v
cnkgcmVnaW9uLg0KPiA+ID4gKyAqIEBwYXJhbSBiDQo+ID4gPiArICogICBQb2ludGVyIHRvIHRo
ZSBzZWNvbmQgbWVtb3J5IHJlZ2lvbi4NCj4gPiA+ICsgKiBAcGFyYW0gbg0KPiA+ID4gKyAqICAg
TnVtYmVyIG9mIGJ5dGVzIHRvIGNvbXBhcmUuDQo+ID4gPiArICogQHJldHVybg0KPiA+ID4gKyAq
ICAgMCBpZiBtZW1vcnkgcmVnaW9ucyBhcmUgZXF1YWwsIG5vbnplcm8gb3RoZXJ3aXNlLg0KPiA+
ID4gKyAqLw0KPiA+ID4gKyNkZWZpbmUgcnRlX2NvbnN0dGltZV9tZW1jbXAoYSwgYiwgbikgX19l
eHRlbnNpb25fXyAoeyBcDQo+ID4gPiArCWNvbnN0IHZvbGF0aWxlIHVpbnQ4X3QgKl9fcGEgPSAo
Y29uc3Qgdm9sYXRpbGUgdWludDhfdCAqKShhKTsgXA0KPiA+ID4gKwljb25zdCB2b2xhdGlsZSB1
aW50OF90ICpfX3BiID0gKGNvbnN0IHZvbGF0aWxlIHVpbnQ4X3QgKikoYik7IFwNCj4gPiA+ICsJ
dWludDhfdCBfX3Jlc3VsdCA9IDA7IFwNCj4gPiA+ICsJZm9yIChzaXplX3QgX19pID0gMDsgX19p
IDwgKG4pOyBfX2krKykgXA0KPiA+ID4gKwkJX19yZXN1bHQgfD0gX19wYVtfX2ldIF4gX19wYltf
X2ldOyBcDQo+ID4gPiArCV9fcmVzdWx0OyBcDQo+ID4gPiArfSkNCj4gPg0KPiA+IEkgYmVsaWV2
ZSB0aGlzIGlzIG5vdCB0aGUgcmlnaHQgcGxhY2UgdG8gYWRkIHRoaXMgZGVmaW5lLg0KPiA+IEl0
IHNob3VsZCBiZSBzb21ld2hlcmUgaW4gY29tbW9uIGVhbCBpZiBpdCBpcyBhbHJlYWR5IG5vdCB0
aGVyZS4NCj4gDQo+IFllcyBpbmRlZWQuDQo+IGNyeXB0b2RldiBpcyB0aGUgQVBJIGZvciBtYW5h
Z2luZyBjcnlwdG8gZGV2aWNlcy4NCj4gQSBuZXcgbWVtY21wIGZ1bmN0aW9uIHdvdWxkIGJlIGJl
dHRlciBob3N0ZWQgaW4gbGliYywNCj4gYW5kIGluIEVBTCBmb3IgY29tcGF0aWJpbGl0eSB3aXRo
IGFsbCBzdXBwb3J0ZWQgbGliYy4NCj4gDQo+IEkgbWVhbiBwbGVhc2UgYWRkIGl0IGluIEVBTCwg
YW5kIHByb3Bvc2UgaXQgdG8gZ2xpYmMgYXMgd2VsbC4NCg0KU3R1cGlkIHE6IHdoYXQncyB3cm9u
ZyB3aXRoIHN0YW5kYXJkIEMgbWVtY21wKCkgZnVuY3Rpb24/DQogDQoNCg==
