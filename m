Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B2CCCFA18
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 07:48:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7F7564026D;
	Tue, 11 Nov 2025 08:48:32 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 6832D4026A
 for <dev@dpdk.org>; Tue, 11 Nov 2025 08:48:31 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d5JYT0bHrzHnH4s;
 Tue, 11 Nov 2025 15:48:13 +0800 (CST)
Received: from dubpeml500002.china.huawei.com (unknown [7.214.145.83])
 by mail.maildlp.com (Postfix) with ESMTPS id C10401400D9;
 Tue, 11 Nov 2025 15:48:29 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml500002.china.huawei.com (7.214.145.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 11 Nov 2025 07:48:29 +0000
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Tue, 11 Nov 2025 07:48:29 +0000
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Wathsala Vithanage <wathsala.vithanage@arm.com>, David Marchand
 <david.marchand@redhat.com>
CC: Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>, "dev@dpdk.org"
 <dev@dpdk.org>, Ola Liljedahl <ola.liljedahl@arm.com>, Dhruv Tripathi
 <dhruv.tripathi@arm.com>
Subject: RE: [PATCH v2 1/1] ring: safe partial ordering for head/tail update
Thread-Topic: [PATCH v2 1/1] ring: safe partial ordering for head/tail update
Thread-Index: AQHcM8PjEkYGhEvMM0eJIFohOEcAbbS36DDQgAh4pACAJSK0gIAGbN4QgACURQCAANFuUA==
Date: Tue, 11 Nov 2025 07:48:29 +0000
Message-ID: <83bc82a468a743f6bc6df722d6b63a94@huawei.com>
References: <20251002174137.3612042-1-wathsala.vithanage@arm.com>
 <20251002174137.3612042-2-wathsala.vithanage@arm.com>
 <cfc073b8137541f1be3e01650d6bcf14@huawei.com>
 <566b4c6c-f081-4db8-bc8b-2a576a82e1c3@arm.com>
 <CAJFAV8yumnbPjakBAtkoqrZvWCo90F51Ri9Eje44sAmm_S43gw@mail.gmail.com>
 <7b9710689ad44caba2c9868967ac97d7@huawei.com>
 <76b57d51-502d-4b46-94d9-6c2dab85de7f@arm.com>
In-Reply-To: <76b57d51-502d-4b46-94d9-6c2dab85de7f@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.81.188.82]
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

DQoNCj4gPj4gT24gTW9uLCAxMyBPY3QgMjAyNSBhdCAyMDoxMCwgV2F0aHNhbGEgVml0aGFuYWdl
DQo+ID4+IDx3YXRoc2FsYS52aXRoYW5hZ2VAYXJtLmNvbT4gd3JvdGU6DQo+ID4+Pj4gTEdUTSwg
dGhvdWdoLiBJIHRoaW5rIHRoYXQgd2UgYWxzbyBuZWVkIHRvIG1ha2Ugc2ltaWxhciBjaGFuZ2Vz
IGluDQo+ID4+Pj4gcnRlX3JpbmdfaHRzX2VsZW1fcHZ0LmggYW5kIHJ0ZV9yaW5nX3J0c19lbGVt
X3B2dC5oOg0KPiA+Pj4+IGZvciBDQVMgdXNlICdhY3FfcmVsJyBvcmRlciBpbnN0ZWFkIG9mIHNp
bXBsZSAnYWNxdWlyZScuDQo+ID4+Pj4gTGV0IG1lIGtub3cgd291bGQgeW91IGhhdmUgYSBiYW5k
d2lkdGggdG8gZG8gdGhhdC4NCj4gPj4+IE15IGJhZCwgSSBmb3Jnb3QgdGhvc2UgdHdvIGNhc2Vz
LiBJIHdpbGwgc2VuZCBhIHYzLg0KPiA+PiBTaG91bGQgd2Ugd2FpdCBmb3IgdGhpcyB2Mz8NCj4g
Pj4gV2Ugd2FudCB0byBjbG9zZSByYzIgdGhpcyB3ZWVrLg0KPiA+Pg0KPiA+IEp1c3Qgc3VibWl0
dGVkIHYzIHdpdGggZGlzY3Vzc2VkIGV4dHJhIGNoYW5nZXMuDQo+ID4gQWxzbyBhZGRlZCBmaXhl
cywgY2MgdG8gc3RhYmxlLCBldGMuDQo+ID4gSG9wZSBpdCBzdGlsbCBjYW4gbWFrZSAyNS4xMQ0K
PiA+IFdhdGhzYWxhLCBwbHMgc2hvdXQgb3Igc3VibWl0IHY0IGlmIHlvdSBmZWVsIHNvbWV0aGlu
ZyBpcyBtaXNzaW5nLg0KPiA+IFRoYW5rcw0KPiA+IEtvbnN0YW50aW4NCj4gDQo+IFRoYW5rcyBL
b25zdGFudGluLCB5b3UgYmVhdCBtZSB0byB0aGUgcHVuY2guIEkgaGF2ZSBhIHNsaWdodGx5IGRp
ZmZlcmVudA0KPiB2ZXJzaW9uIHdpdGggY29tbWVudHMgZXhwbGFpbmluZyB0aGUgc3luY2hyb25p
emVzIHdpdGggcmVsYXRpb25zaGlwcy4gSWYNCj4geW91IGRvbid0IG1pbmQgSSBjYW4gc2VuZCBp
dCBhcyBWNC4NCg0KWWVwLCBzdXJlIGZlZWwgZnJlZSwgYnV0IHBsZWFzZSB0cnkgdG8gbWFrZSBp
dCBhc2FwLg0KT3RoZXJ3aXNlIHdlIHJpc2sgdG8gbWlzcyAyNS4xMSBkZWFkbGluZS4NCktvbnN0
YW50aW4NCg==
