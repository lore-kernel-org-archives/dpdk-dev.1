Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F1D2CCD1BC
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 14:04:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3EC724025E;
	Thu, 23 Oct 2025 16:04:50 +0200 (CEST)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by mails.dpdk.org (Postfix) with ESMTP id DA7DD40151
 for <dev@dpdk.org>; Thu, 23 Oct 2025 16:04:48 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.88.163])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4csnrB38ZZz11ST2;
 Thu, 23 Oct 2025 22:06:02 +0800 (CST)
Received: from kwepemk100007.china.huawei.com (unknown [7.202.194.55])
 by mail.maildlp.com (Postfix) with ESMTPS id 2A62D18001B;
 Thu, 23 Oct 2025 22:04:46 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 kwepemk100007.china.huawei.com (7.202.194.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 23 Oct 2025 22:04:44 +0800
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Thu, 23 Oct 2025 15:04:42 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>,
 "dev@dpdk.org" <dev@dpdk.org>, Stephen Hemminger
 <stephen@networkplumber.org>, Wathsala Vithanage
 <wathsala.vithanage@arm.com>, Fengchengwen <fengchengwen@huawei.com>, "Bruce
 Richardson" <bruce.richardson@intel.com>
Subject: RE: [PATCH v5] mbuf: optimize segment prefree
Thread-Topic: [PATCH v5] mbuf: optimize segment prefree
Thread-Index: AQHcQ/NUxCpzFpnLEUCegFLyVmlwCLTPa7AAgAAngXCAAC+rQA==
Date: Thu, 23 Oct 2025 14:04:42 +0000
Message-ID: <6a26d57153714d04865753fd557978dd@huawei.com>
References: <20250827213535.21602-1-mb@smartsharesystems.com>
 <20251023080136.165513-1-mb@smartsharesystems.com>
 <c556ea7b92a24bc09ac5240da39bc36c@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F654F7@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F654F7@smartserver.smartshare.dk>
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

DQoNCj4gPiBGcm9tOiBLb25zdGFudGluIEFuYW55ZXYgW21haWx0bzprb25zdGFudGluLmFuYW55
ZXZAaHVhd2VpLmNvbV0NCj4gPiBTZW50OiBUaHVyc2RheSwgMjMgT2N0b2JlciAyMDI1IDEwLjUx
DQo+ID4NCj4gPiA+IC0jZGVmaW5lIFJURV9NQlVGX0RJUkVDVChtYikgXA0KPiA+ID4gLQkoISgo
bWIpLT5vbF9mbGFncyAmIChSVEVfTUJVRl9GX0lORElSRUNUIHwgUlRFX01CVUZfRl9FWFRFUk5B
TCkpKQ0KPiA+ID4gKyAqDQo+ID4gPiArICogTm90ZTogTWFjcm8gb3B0aW1pemVkIGZvciBjb2Rl
IHNpemUuDQo+ID4gPiArICoNCj4gPiA+ICsgKiBUaGUgcGxhaW4gbWFjcm8gd291bGQgYmU6DQo+
ID4gPiArICogICAgICAjZGVmaW5lIFJURV9NQlVGX0RJUkVDVChtYikgXA0KPiA+ID4gKyAqICAg
ICAgICAgICghKChtYiktPm9sX2ZsYWdzICYgKFJURV9NQlVGX0ZfSU5ESVJFQ1QgfA0KPiA+IFJU
RV9NQlVGX0ZfRVhURVJOQUwpKSkNCj4gPiA+ICsgKg0KPiA+ID4gKyAqIFRoZSBmbGFncyBSVEVf
TUJVRl9GX0lORElSRUNUIGFuZCBSVEVfTUJVRl9GX0VYVEVSTkFMIGFyZSBib3RoIGluDQo+ID4g
dGhlDQo+ID4gPiBNU0IgKG1vc3Qgc2lnbmlmaWNhbnQNCj4gPiA+ICsgKiBieXRlKSBvZiB0aGUg
NjQtYml0IG9sX2ZsYWdzIGZpZWxkLCBzbyB3ZSBvbmx5IGNvbXBhcmUgdGhpcyBvbmUNCj4gPiBi
eXRlIGluc3RlYWQgb2YgYWxsDQo+ID4gPiA2NCBiaXRzLg0KPiA+ID4gKyAqDQo+ID4gPiArICog
RS5nLiwgR0NDIHZlcnNpb24gMTYuMC4wIDIwMjUxMDE5IChleHBlcmltZW50YWwpIGdlbmVyYXRl
cyB0aGUNCj4gPiBmb2xsb3dpbmcgY29kZQ0KPiA+ID4gZm9yIHg4Ni02NC4NCj4gPiA+ICsgKg0K
PiA+ID4gKyAqIFdpdGggdGhlIHBsYWluIG1hY3JvLCAxNyBieXRlcyBvZiBpbnN0cnVjdGlvbnM6
DQo+ID4gPiArICogICAgICBtb3ZhYnMgcmF4LDB4NjAwMDAwMDAwMDAwMDAwMCAgICAgICAvLyAx
MCBieXRlcw0KPiA+ID4gKyAqICAgICAgYW5kICAgIHJheCxRV09SRCBQVFIgW3JkaSsweDE4XSAg
ICAgLy8gNCBieXRlcw0KPiA+ID4gKyAqICAgICAgc2V0ZSAgIGFsICAgICAgICAgICAgICAgICAg
ICAgICAgICAgLy8gMyBieXRlcw0KPiA+ID4gKyAqIFdpdGggdGhpcyBvcHRpbWl6ZWQgbWFjcm8s
IG9ubHkgNyBieXRlcyBvZiBpbnN0cnVjdGlvbnM6DQo+ID4gPiArICogICAgICB0ZXN0ICAgQllU
RSBQVFIgW3JkaSsweDFmXSwweDYwICAgICAvLyA0IGJ5dGVzDQo+ID4gPiArICogICAgICBzZXRl
ICAgYWwgICAgICAgICAgICAgICAgICAgICAgICAgICAvLyAzIGJ5dGVzDQo+ID4gPiArICovDQo+
ID4gPiArI2lmIFJURV9CWVRFX09SREVSID09IFJURV9MSVRUTEVfRU5ESUFODQo+ID4gPiArLyog
T24gbGl0dGxlIGVuZGlhbiBhcmNoaXRlY3R1cmUsIHRoZSBNU0Igb2YgYSA2NC1iaXQgaW50ZWdl
ciBpcyBhdA0KPiA+IGJ5dGUgb2Zmc2V0IDcuICovDQo+ID4gPiArI2RlZmluZSBSVEVfTUJVRl9E
SVJFQ1QobWIpICAgICAhKCgoY29uc3QgY2hhciAqKSgmKG1iKS0NCj4gPiA+b2xfZmxhZ3MpKVs3
XSAmIDB4NjApDQo+ID4gPiArI2VsaWYgUlRFX0JZVEVfT1JERVIgPT0gUlRFX0JJR19FTkRJQU4N
Cj4gPiA+ICsvKiBPbiBiaWcgZW5kaWFuIGFyY2hpdGVjdHVyZSwgdGhlIE1TQiBvZiBhIDY0LWJp
dCBpbnRlZ2VyIGlzIGF0DQo+ID4gYnl0ZSBvZmZzZXQgMC4gKi8NCj4gPiA+ICsjZGVmaW5lIFJU
RV9NQlVGX0RJUkVDVChtYikgICAgICEoKChjb25zdCBjaGFyICopKCYobWIpLQ0KPiA+ID5vbF9m
bGFncykpWzBdICYgMHg2MCkNCj4gPg0KPiA+IEEgc3R1cGlkIHE6IHdoeSB0aGVuIG5vdCBzaW1w
bHkgZG86DQo+ID4gKG1iLT5vbF9mbGFncyA+PiA1NikgJiAweDYwDQo+ID4gdGhlbj8NCj4gPiBT
aG91bGQgaGVscCB0byBhbGwgdGhlc2UgTEUvQkUgY2FzdHMsIGV0Yy4NCj4gDQo+IEdDQyBpcyB0
b28gc3R1cGlkIGZvciB0aGF0IHRvby4NCj4gDQo+IFBsYXlpbmcgYXJvdW5kIHdpdGggR29kYm9s
dCBzaG93cyB0aGF0DQo+IAlyZXR1cm4gISgoY2hhcikocFszXSA+PiA1NikgJiAweDYwKTsNCj4g
YmVjb21lcw0KPiAJbW92enggIGVheCxCWVRFIFBUUiBbcmRpKzB4MWZdCS8vIDQgYnl0ZXMNCj4g
CXRlc3QgICBhbCwweDYwCQkJCS8vIDIgYnl0ZXMNCj4gSW5zdGVhZCBvZiBzaW1wbHkNCj4gCXRl
c3QgICBCWVRFIFBUUiBbcmRpKzB4MWZdLDB4NjAJLy8gNCBieXRlcw0KDQpBbmQgdGhlc2UgMiBl
eHRyYSBieXRlcyBpbiBpbnN0cnVjdGlvbnMsIGFyZSB0aGF0IHJlYWxseSB0aGF0IGNyaXRpY2Fs
Pw0KTXkgZ3Vlc3MsIHdlIHdvdWxkbid0IG5vdGljZSBhbnkgcmVhbCBkaWZmIGhlcmUuDQpCdXQg
aWYgaXQgcmVhbGx5IGlzLCBjYW4gSSBhc2sgeW91IHRvIGNyZWF0ZSBhIG5ldyBkZWZpbmUgZm9y
IDB4NjAsDQp0byBhdm9pZCBoYXJkY29kZWQgY29uc3RhbnRzIGluIHRoZSBjb2RlPw0KTWlnaHQg
YmUgc29tZXRoaW5nICBsaWtlDQojZGVmaW5lIFJURV9NQlVGX0ZfSU5ESVJFQ1RfRVhURVJOQUxf
MUIgLi4uDQpvciBzby4gDQpLb25zdGFudGluDQoNCj4gR29vZCBzdWdnZXN0aW9uLCB0aG91Z2gu
DQo+IA0KPiA+DQo+ID4gPiArI2VuZGlmDQo+ID4gPiArLyogVmVyaWZ5IHRoZSBvcHRpbWl6YXRp
b24gYWJvdmUuICovDQo+ID4gPiArc3RhdGljX2Fzc2VydCgoUlRFX01CVUZfRl9JTkRJUkVDVCB8
IFJURV9NQlVGX0ZfRVhURVJOQUwpID09DQo+ID4gPiBVSU5UNjRfQygweDYwKSA8PCAoNyAqIENI
QVJfQklUKSwNCj4gPiA+ICsJIihSVEVfTUJVRl9GX0lORElSRUNUIHwgUlRFX01CVUZfRl9FWFRF
Uk5BTCkgaXMgbm90IDB4NjAgYXQNCj4gPiBNU0IiKTsNCj4gPiA+DQo+ID4gPiAgLyoqIFVuaW5p
dGlhbGl6ZWQgb3IgdW5zcGVjaWZpZWQgcG9ydC4gKi8NCj4gPiA+ICAjZGVmaW5lIFJURV9NQlVG
X1BPUlRfSU5WQUxJRCBVSU5UMTZfTUFYDQo+ID4gPiAtLQ0KPiA+ID4gMi40My4wDQoNCg==
