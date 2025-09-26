Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65E7CAC5AC
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Sep 2025 08:16:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D78CA4067B;
	Fri, 26 Sep 2025 10:16:30 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id A96A64025D;
 Fri, 26 Sep 2025 10:16:29 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cY3MJ3WfQz6L5SF;
 Fri, 26 Sep 2025 16:16:28 +0800 (CST)
Received: from dubpeml100002.china.huawei.com (unknown [7.214.144.156])
 by mail.maildlp.com (Postfix) with ESMTPS id 4ADAD1402FB;
 Fri, 26 Sep 2025 16:16:29 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml100002.china.huawei.com (7.214.144.156) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 26 Sep 2025 09:16:28 +0100
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Fri, 26 Sep 2025 09:16:28 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>, Thomas Monjalon
 <thomas@monjalon.net>, Kai Ji <kai.ji@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Stephen Hemminger
 <stephen@networkplumber.org>, Bruce Richardson <bruce.richardson@intel.com>,
 David Marchand <david.marchand@redhat.com>, "stable@dpdk.org"
 <stable@dpdk.org>, Pablo de Lara <pablo.de.lara.guarch@intel.com>, Fan Zhang
 <fanzhang.oss@gmail.com>, Akhil Goyal <gakhil@marvell.com>
Subject: RE: [EXTERNAL] [dpdk-dev v1] cryptodev: introduce constant-time
 memory comparison
Thread-Topic: [EXTERNAL] [dpdk-dev v1] cryptodev: introduce constant-time
 memory comparison
Thread-Index: AQHcLgZbZIPJMbu4/k+2rD9qRJYYJLSjovUAgACrgQCAANAhsIAAALjA
Date: Fri, 26 Sep 2025 08:16:28 +0000
Message-ID: <3877a725bc76423dbce731218d58fdc8@huawei.com>
References: <20250925102223.145471-1-kai.ji@intel.com>
 <CO6PR18MB4484264974305D4A6B065A76D81FA@CO6PR18MB4484.namprd18.prod.outlook.com>
 <3819475.yaVYbkx8dN@thomas> <aeb7d0327c7741a18ff7e3e23a4d8f60@huawei.com>
In-Reply-To: <aeb7d0327c7741a18ff7e3e23a4d8f60@huawei.com>
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

DQoNCj4gDQo+IA0KPiA+IDI1LzA5LzIwMjUgMTI6MzMsIEFraGlsIEdveWFsOg0KPiA+ID4gPiAr
LyoqDQo+ID4gPiA+ICsgKiBDb25zdGFudC10aW1lIG1lbW9yeSBjb21wYXJpc29uIGZvciBjcnlw
dG9ncmFwaGljIHVzZS4NCj4gPiA+ID4gKyAqIFJldHVybnMgMCBpZiB0aGUgbWVtb3J5IHJlZ2lv
bnMgYXJlIGVxdWFsLCBub256ZXJvIG90aGVyd2lzZS4NCj4gPiA+ID4gKyAqIFJ1bnMgaW4gY29u
c3RhbnQgdGltZSB3aXRoIHJlc3BlY3QgdG8gdGhlIGxlbmd0aCB0byBwcmV2ZW50IHRpbWluZw0K
PiBhdHRhY2tzLg0KPiA+ID4gPiArICoNCj4gPiA+ID4gKyAqIEBwYXJhbSBhDQo+ID4gPiA+ICsg
KiAgIFBvaW50ZXIgdG8gdGhlIGZpcnN0IG1lbW9yeSByZWdpb24uDQo+ID4gPiA+ICsgKiBAcGFy
YW0gYg0KPiA+ID4gPiArICogICBQb2ludGVyIHRvIHRoZSBzZWNvbmQgbWVtb3J5IHJlZ2lvbi4N
Cj4gPiA+ID4gKyAqIEBwYXJhbSBuDQo+ID4gPiA+ICsgKiAgIE51bWJlciBvZiBieXRlcyB0byBj
b21wYXJlLg0KPiA+ID4gPiArICogQHJldHVybg0KPiA+ID4gPiArICogICAwIGlmIG1lbW9yeSBy
ZWdpb25zIGFyZSBlcXVhbCwgbm9uemVybyBvdGhlcndpc2UuDQo+ID4gPiA+ICsgKi8NCj4gPiA+
ID4gKyNkZWZpbmUgcnRlX2NvbnN0dGltZV9tZW1jbXAoYSwgYiwgbikgX19leHRlbnNpb25fXyAo
eyBcDQo+ID4gPiA+ICsJY29uc3Qgdm9sYXRpbGUgdWludDhfdCAqX19wYSA9IChjb25zdCB2b2xh
dGlsZSB1aW50OF90ICopKGEpOyBcDQo+ID4gPiA+ICsJY29uc3Qgdm9sYXRpbGUgdWludDhfdCAq
X19wYiA9IChjb25zdCB2b2xhdGlsZSB1aW50OF90ICopKGIpOyBcDQo+ID4gPiA+ICsJdWludDhf
dCBfX3Jlc3VsdCA9IDA7IFwNCj4gPiA+ID4gKwlmb3IgKHNpemVfdCBfX2kgPSAwOyBfX2kgPCAo
bik7IF9faSsrKSBcDQo+ID4gPiA+ICsJCV9fcmVzdWx0IHw9IF9fcGFbX19pXSBeIF9fcGJbX19p
XTsgXA0KPiA+ID4gPiArCV9fcmVzdWx0OyBcDQo+ID4gPiA+ICt9KQ0KPiA+ID4NCj4gPiA+IEkg
YmVsaWV2ZSB0aGlzIGlzIG5vdCB0aGUgcmlnaHQgcGxhY2UgdG8gYWRkIHRoaXMgZGVmaW5lLg0K
PiA+ID4gSXQgc2hvdWxkIGJlIHNvbWV3aGVyZSBpbiBjb21tb24gZWFsIGlmIGl0IGlzIGFscmVh
ZHkgbm90IHRoZXJlLg0KPiA+DQo+ID4gWWVzIGluZGVlZC4NCj4gPiBjcnlwdG9kZXYgaXMgdGhl
IEFQSSBmb3IgbWFuYWdpbmcgY3J5cHRvIGRldmljZXMuDQo+ID4gQSBuZXcgbWVtY21wIGZ1bmN0
aW9uIHdvdWxkIGJlIGJldHRlciBob3N0ZWQgaW4gbGliYywNCj4gPiBhbmQgaW4gRUFMIGZvciBj
b21wYXRpYmlsaXR5IHdpdGggYWxsIHN1cHBvcnRlZCBsaWJjLg0KPiA+DQo+ID4gSSBtZWFuIHBs
ZWFzZSBhZGQgaXQgaW4gRUFMLCBhbmQgcHJvcG9zZSBpdCB0byBnbGliYyBhcyB3ZWxsLg0KPiAN
Cj4gU3R1cGlkIHE6IHdoYXQncyB3cm9uZyB3aXRoIHN0YW5kYXJkIEMgbWVtY21wKCkgZnVuY3Rp
b24/DQoNCkFoLCBzb3JyeSwgZGlkbid0IHJlYWQgcHJvcGVybHkuDQpQbGVhc2UgZGlzcmVnYXJk
LCBhbmQgeWVzIC0gbWlnaHQgYmUgRUFMIGlzIHRoZSByaWdodCBwbGFjZSBmb3IgaXQuDQoNCg==
