Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F2ED58CBF
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 22:22:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EAE70402D6;
	Mon, 23 Mar 2026 23:22:33 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 2AE3440268
 for <dev@dpdk.org>; Mon, 23 Mar 2026 23:22:31 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4ffnjD4q8pzJ468N;
 Tue, 24 Mar 2026 06:22:24 +0800 (CST)
Received: from dubpeml100001.china.huawei.com (unknown [7.214.144.137])
 by mail.maildlp.com (Postfix) with ESMTPS id 9138740086;
 Tue, 24 Mar 2026 06:22:30 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml100001.china.huawei.com (7.214.144.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 23 Mar 2026 22:22:30 +0000
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Mon, 23 Mar 2026 22:22:30 +0000
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "rjarry@redhat.com" <rjarry@redhat.com>, "nsaxena16@gmail.com"
 <nsaxena16@gmail.com>, "mb@smartsharesystems.com" <mb@smartsharesystems.com>, 
 "adwivedi@marvell.com" <adwivedi@marvell.com>, "jerinjacobk@gmail.com"
 <jerinjacobk@gmail.com>, Maxime Leroy <maxime@leroys.fr>
Subject: RE: [RFC PATCH 1/4] fib: add multi-VRF support
Thread-Topic: [RFC PATCH 1/4] fib: add multi-VRF support
Thread-Index: AQHcuhKcJJxwCE+lqEy31K72rKhCrbW8QVYQgAA62oCAADV+QA==
Date: Mon, 23 Mar 2026 22:22:30 +0000
Message-ID: <8127950263884375b935be30eb39da9b@huawei.com>
References: <20260322154215.3686528-1-vladimir.medvedkin@intel.com>
 <20260322154215.3686528-2-vladimir.medvedkin@intel.com>
 <a97747eac5c242359b959e24f284bf5b@huawei.com>
 <5ef5dc7b-0048-4e1e-be1c-d94b5b8f3caf@intel.com>
In-Reply-To: <5ef5dc7b-0048-4e1e-be1c-d94b5b8f3caf@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.81.207.232]
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

DQo+ID4+IEFkZCBWUkYgKFZpcnR1YWwgUm91dGluZyBhbmQgRm9yd2FyZGluZykgc3VwcG9ydCB0
byB0aGUgSVB2NA0KPiA+PiBGSUIgbGlicmFyeSwgYWxsb3dpbmcgbXVsdGlwbGUgaW5kZXBlbmRl
bnQgcm91dGluZyB0YWJsZXMNCj4gPj4gd2l0aGluIGEgc2luZ2xlIEZJQiBpbnN0YW5jZS4NCj4g
Pj4NCj4gPj4gSW50cm9kdWNlIG1heF92cmZzIGFuZCB2cmZfZGVmYXVsdF9uaCBmaWVsZHMgaW4g
cnRlX2ZpYl9jb25mDQo+ID4+IHRvIGNvbmZpZ3VyZSB0aGUgbnVtYmVyIG9mIFZSRnMgYW5kIHBl
ci1WUkYgZGVmYXVsdCBuZXh0aG9wcy4NCj4gPiBUaGFua3MgVmxhZGltaXIsIGFsbG93aW5nIG11
bHRpcGxlIFZSRnMgcGVyIHNhbWUgTFBNIHRhYmxlIHdpbGwNCj4gPiBkZWZpbml0ZWx5IGJlIGEg
dXNlZnVsIHRoaW5nIHRvIGhhdmUuDQo+ID4gVGhvdWdoLCBJIGhhdmUgdGhlIHNhbWUgY29uY2Vy
biBhcyBNYXhpbWU6DQo+ID4gbWVtb3J5IHJlcXVpcmVtZW50cyBhcmUganVzdCBvdmVyd2hlbG1p
bmcuDQo+ID4gU3R1cGlkIHEgLSB3aHkganVzdCBub3QgdG8gc3RvcmUgYSBwb2ludGVyIHRvIGEg
dmVjdG9yIG9mIG5leHQtaG9wcw0KPiA+IHdpdGhpbiB0aGUgdGFibGUgZW50cnk/DQo+IA0KPiBB
bSBJIHVuZGVyc3RhbmQgY29ycmVjdGx5LCBhIHZlY3RvciB3aXRoIG1heF9udW1iZXJfb2ZfdnJm
cyBlbnRyaWVzIGFuZA0KPiB1c2UgdnJmIGlkIHRvIGFkZHJlc3MgYSBuZXh0aG9wPw0KDQpZZXMu
DQoNCj4gWWVzLCB0aGlzIG1heSB3b3JrLg0KPiBCdXQsIGlmIHdlIGFyZSBnb2luZyB0byBkbyBh
biBleHRyYSBtZW1vcnkgYWNjZXNzLCBJJ2QgYmV0dGVyIHRvDQo+IG1haW50YWluIGFuIGludGVy
bmFsIGhhc2ggdGFibGUgd2l0aCA1IGJ5dGUga2V5cyB7MjRfYml0c19mcm9tX0xQTSwNCj4gMTZf
Yml0c192cmZfaWR9IHRvIHJldHJpZXZlIGEgbmV4dGhvcC4NCg0KSG1tLi4uIGFuZCB3aGF0IHRv
IGRvIHdpdGggZW50cmllcyBpbiB0Ymw4LCBJIG1lYW4gd2hhdCB3aWxsIGJlIHRoZSBrZXkgZm9y
IHRoZW0/DQpPciB5b3UgZG9uJ3QgcGxhbiB0byBwdXQgZW50cmllcyBmcm9tIHRibDggdG8gdGhh
dCBoYXNoIHRhYmxlPw0KDQo+ID4gQW5kIHdlIGNhbiBwcm92aWRlIHRvIHRoZSB1c2VyIHdpdGgg
YWJpbGl0eSB0byBzcGVjaWZ5IGN1c3RvbQ0KPiA+IGFsbG9jL2ZyZWUgZnVuY3Rpb24gZm9yIHRo
ZXNlIHZlY3RvcnMuDQo+ID4gVGhhdCB3b3VsZCBoZWxwIHRvIGF2b2lkIGFsbG9jYXRpbmcgaHVn
ZSBjaHVua3Mgb2YgbWVtb3J5IGF0IHN0YXJ0dXAuDQo+ID4gSSB1bmRlcnN0YW5kIHRoYXQgaXQg
d2lsbCBiZSBvbmUgZXh0cmEgbWVtb3J5IGRlcmVmZXJlbmNlLA0KPiA+IGJ1dCBwcm9iYWJseSBp
dCB3aWxsIGJlIG5vdCB0aGF0IGNyaXRpY2FsIGluIHRlcm1zIG9mIHBlcmZvcm1hbmNlIC4NCj4g
PiBBZ2FpbiBmb3IgYnVsayBmdW5jdGlvbiAgd2UgbWlnaHQgYmUgYWJsZSB0byBwaXBlbGluZSBs
b29rdXBzIGFuZA0KPiA+IGRlLXJlZmVyZW5jZXMgYW5kIGhpZGUgdGhhdCBleHRyYSBsb2FkIGxh
dGVuY3kuDQo+ID4NCj4gPj4gQWRkIGZvdXIgbmV3IGV4cGVyaW1lbnRhbCBBUElzOg0KPiA+PiAt
IHJ0ZV9maWJfdnJmX2FkZCgpIGFuZCBydGVfZmliX3ZyZl9kZWxldGUoKSB0byBtYW5hZ2Ugcm91
dGVzDQo+ID4+ICAgIHBlciBWUkYNCj4gPj4gLSBydGVfZmliX3ZyZl9sb29rdXBfYnVsaygpIGZv
ciBtdWx0aS1WUkYgYnVsayBsb29rdXBzDQo+ID4+IC0gcnRlX2ZpYl92cmZfZ2V0X3JpYigpIHRv
IHJldHJpZXZlIGEgcGVyLVZSRiBSSUIgaGFuZGxlDQo+ID4+DQo+ID4+IFNpZ25lZC1vZmYtYnk6
IFZsYWRpbWlyIE1lZHZlZGtpbiA8dmxhZGltaXIubWVkdmVka2luQGludGVsLmNvbT4NCj4gPj4g
LS0tDQo+ID4+ICAgbGliL2ZpYi9kaXIyNF84LmMgICAgICAgIHwgMjQxICsrKysrKysrKysrKysr
KystLS0tLS0NCj4gPj4gICBsaWIvZmliL2RpcjI0XzguaCAgICAgICAgfCAyNTUgKysrKysrKysr
KysrKysrKy0tLS0tLS0tDQo+ID4+ICAgbGliL2ZpYi9kaXIyNF84X2F2eDUxMi5jIHwgNDIwICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLQ0KPiA+PiAgIGxpYi9maWIvZGly
MjRfOF9hdng1MTIuaCB8ICA4MCArKysrKysrLQ0KPiA+PiAgIGxpYi9maWIvcnRlX2ZpYi5jICAg
ICAgICB8IDE1OCArKysrKysrKysrKystLS0NCj4gPj4gICBsaWIvZmliL3J0ZV9maWIuaCAgICAg
ICAgfCAgOTQgKysrKysrKystDQo+ID4+ICAgNiBmaWxlcyBjaGFuZ2VkLCA5ODggaW5zZXJ0aW9u
cygrKSwgMjYwIGRlbGV0aW9ucygtKQ0KPiA+Pg0KPiA8c25pcD4NCj4gDQo+IC0tDQo+IFJlZ2Fy
ZHMsDQo+IFZsYWRpbWlyDQo+IA0KDQo=
