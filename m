Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24BEC021B1
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 09:41:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F39574014F;
	Thu, 20 Feb 2025 10:41:43 +0100 (CET)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by mails.dpdk.org (Postfix) with ESMTP id 36C1240041
 for <dev@dpdk.org>; Thu, 20 Feb 2025 10:41:41 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.19.163.17])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Yz7Tf2pfKz1wn8T;
 Thu, 20 Feb 2025 17:37:42 +0800 (CST)
Received: from kwepemf200009.china.huawei.com (unknown [7.202.181.235])
 by mail.maildlp.com (Postfix) with ESMTPS id F140D1A0188;
 Thu, 20 Feb 2025 17:41:38 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 kwepemf200009.china.huawei.com (7.202.181.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 20 Feb 2025 17:41:37 +0800
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Thu, 20 Feb 2025 10:41:35 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: "lihuisong (C)" <lihuisong@huawei.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "thomas@monjalon.net" <thomas@monjalon.net>, "david.hunt@intel.com"
 <david.hunt@intel.com>, "anatoly.burakov@intel.com"
 <anatoly.burakov@intel.com>, "sivaprasad.tummala@amd.com"
 <sivaprasad.tummala@amd.com>, liuyonglong <liuyonglong@huawei.com>, "Stephen
 Hemminger" <stephen@networkplumber.org>
Subject: RE: [PATCH] power: use hugepage memory for queue list entry structure
Thread-Topic: [PATCH] power: use hugepage memory for queue list entry structure
Thread-Index: AQHbUezKxRn4I6S/S0+UBKv0KpGojbNQN46AgAAaEkA=
Date: Thu, 20 Feb 2025 09:41:35 +0000
Message-ID: <60199571d93a4cf88d7ab9aa6a79611e@huawei.com>
References: <20241219075319.8874-1-lihuisong@huawei.com>
 <01d163c6-6d18-03e8-ac67-e7907d27bd08@huawei.com>
In-Reply-To: <01d163c6-6d18-03e8-ac67-e7907d27bd08@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.195.35.39]
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

DQpIaSANCg0KPiANCj4gSGkgYWxsLA0KPiANCj4gS2luZGx5IHBpbmcgZm9yIHJldmlldy4NCj4g
DQo+IA0KPiDlnKggMjAyNC8xMi8xOSAxNTo1MywgSHVpc29uZyBMaSDlhpnpgZM6DQo+ID4gVGhl
IHF1ZXVlX2xpc3RfZW50cnkgc3RydWN0dXJlIGRhdGEgaXMgdXNlZCBpbiByeF9jYWxsYmFjayBv
ZiBpbyBwYXRoDQo+ID4gd2hlbiBlbmFibGUgUE1EIFBvd2VyIE1hbmFnZW1lbnQuIEhvd2V2ZXIg
aXRzIG1lbW9yeSBpcyBjdXJyZW50bHkgZnJvbQ0KPiA+IG5vcm1hbCBoZWFwIG1lbW9yeS4gRm9y
IGJldHRlciBwZXJmb3JtYW5jZSwgdXNlIGh1Z2VwYWdlIG1lbW9yeSB0bw0KPiA+IHJlcGxhY2Ug
aXQuDQoNCk1ha2Ugc2Vuc2UgdG8gbWUuDQpBY2tlZC1ieTogS29uc3RhbnRpbiBBbmFueWV2IDxr
b25zdGFudGluLmFuYW55ZXZAaHVhd2VpLmNvbT4NCg0KSSAgc3VwcG9zZSBpdCB3b3VsZCBhbHNv
IGhlbHAgaWYgeW91IGNhbiBwcm92aWRlIHNvbWUgbnVtYmVyczoNCmkuZS46IGhvdyBtdWNoIGV4
YWN0bHkgaXQgaXMgJ2JldHRlcic/DQpEaWQgeW91IHNlZSBhbnkgY2hhbmdlcyBpbiB0aHJvdWdo
cHV0L2xhdGVuY3kgbnVtYmVycywgZXRjLg0KDQo+ID4gU2lnbmVkLW9mZi1ieTogSHVpc29uZyBM
aSA8bGlodWlzb25nQGh1YXdlaS5jb20+DQo+ID4gLS0tDQo+ID4gICBsaWIvcG93ZXIvcnRlX3Bv
d2VyX3BtZF9tZ210LmMgfCAxMCArKysrKy0tLS0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgNSBp
bnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2xpYi9w
b3dlci9ydGVfcG93ZXJfcG1kX21nbXQuYyBiL2xpYi9wb3dlci9ydGVfcG93ZXJfcG1kX21nbXQu
Yw0KPiA+IGluZGV4IGEyZmZmM2I3NjUuLmM3YmY1N2E5MTAgMTAwNjQ0DQo+ID4gLS0tIGEvbGli
L3Bvd2VyL3J0ZV9wb3dlcl9wbWRfbWdtdC5jDQo+ID4gKysrIGIvbGliL3Bvd2VyL3J0ZV9wb3dl
cl9wbWRfbWdtdC5jDQo+ID4gQEAgLTk3LDcgKzk3LDcgQEAgcXVldWVfbGlzdF9maW5kKGNvbnN0
IHN0cnVjdCBwbWRfY29yZV9jZmcgKmNmZywgY29uc3QgdW5pb24gcXVldWUgKnEpDQo+ID4gICB9
DQo+ID4NCj4gPiAgIHN0YXRpYyBpbnQNCj4gPiAtcXVldWVfbGlzdF9hZGQoc3RydWN0IHBtZF9j
b3JlX2NmZyAqY2ZnLCBjb25zdCB1bmlvbiBxdWV1ZSAqcSkNCj4gPiArcXVldWVfbGlzdF9hZGQo
c3RydWN0IHBtZF9jb3JlX2NmZyAqY2ZnLCBjb25zdCB1bmlvbiBxdWV1ZSAqcSwgdW5zaWduZWQg
aW50IGxjb3JlX2lkKQ0KPiA+ICAgew0KPiA+ICAgCXN0cnVjdCBxdWV1ZV9saXN0X2VudHJ5ICpx
bGU7DQo+ID4NCj4gPiBAQCAtMTA1LDEwICsxMDUsMTAgQEAgcXVldWVfbGlzdF9hZGQoc3RydWN0
IHBtZF9jb3JlX2NmZyAqY2ZnLCBjb25zdCB1bmlvbiBxdWV1ZSAqcSkNCj4gPiAgIAlpZiAocXVl
dWVfbGlzdF9maW5kKGNmZywgcSkgIT0gTlVMTCkNCj4gPiAgIAkJcmV0dXJuIC1FRVhJU1Q7DQo+
ID4NCj4gPiAtCXFsZSA9IG1hbGxvYyhzaXplb2YoKnFsZSkpOw0KPiA+ICsJcWxlID0gcnRlX3pt
YWxsb2Nfc29ja2V0KE5VTEwsIHNpemVvZigqcWxlKSwgUlRFX0NBQ0hFX0xJTkVfU0laRSwNCj4g
PiArCQkJCSBydGVfbGNvcmVfdG9fc29ja2V0X2lkKGxjb3JlX2lkKSk7DQo+ID4gICAJaWYgKHFs
ZSA9PSBOVUxMKQ0KPiA+ICAgCQlyZXR1cm4gLUVOT01FTTsNCj4gPiAtCW1lbXNldChxbGUsIDAs
IHNpemVvZigqcWxlKSk7DQo+ID4NCj4gPiAgIAlxdWV1ZV9jb3B5KCZxbGUtPnF1ZXVlLCBxKTsN
Cj4gPiAgIAlUQUlMUV9JTlNFUlRfVEFJTCgmY2ZnLT5oZWFkLCBxbGUsIG5leHQpOw0KPiA+IEBA
IC01NzAsNyArNTcwLDcgQEAgcnRlX3Bvd2VyX2V0aGRldl9wbWdtdF9xdWV1ZV9lbmFibGUodW5z
aWduZWQgaW50IGxjb3JlX2lkLCB1aW50MTZfdCBwb3J0X2lkLA0KPiA+ICAgCQlnb3RvIGVuZDsN
Cj4gPiAgIAl9DQo+ID4gICAJLyogYWRkIHRoaXMgcXVldWUgdG8gdGhlIGxpc3QgKi8NCj4gPiAt
CXJldCA9IHF1ZXVlX2xpc3RfYWRkKGxjb3JlX2NmZywgJnFkYXRhKTsNCj4gPiArCXJldCA9IHF1
ZXVlX2xpc3RfYWRkKGxjb3JlX2NmZywgJnFkYXRhLCBsY29yZV9pZCk7DQo+ID4gICAJaWYgKHJl
dCA8IDApIHsNCj4gPiAgIAkJUE9XRVJfTE9HKERFQlVHLCAiRmFpbGVkIHRvIGFkZCBxdWV1ZSB0
byBsaXN0OiAlcyIsDQo+ID4gICAJCQkJc3RyZXJyb3IoLXJldCkpOw0KPiA+IEBAIC02NjQsNyAr
NjY0LDcgQEAgcnRlX3Bvd2VyX2V0aGRldl9wbWdtdF9xdWV1ZV9kaXNhYmxlKHVuc2lnbmVkIGlu
dCBsY29yZV9pZCwNCj4gPiAgIAkgKiBjYWxsYmFja3MgY2FuIGJlIGZyZWVkLiB3ZSdyZSBpbnRl
bnRpb25hbGx5IGNhc3RpbmcgYXdheSBjb25zdC1uZXNzLg0KPiA+ICAgCSAqLw0KPiA+ICAgCXJ0
ZV9mcmVlKCh2b2lkICopKHVpbnRwdHJfdClxdWV1ZV9jZmctPmNiKTsNCj4gPiAtCWZyZWUocXVl
dWVfY2ZnKTsNCj4gPiArCXJ0ZV9mcmVlKHF1ZXVlX2NmZyk7DQo+ID4NCj4gPiAgIAlyZXR1cm4g
MDsNCj4gPiAgIH0NCg==
