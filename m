Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E5ECCD1A5
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 09:21:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 307B64025E;
	Fri, 24 Oct 2025 11:21:44 +0200 (CEST)
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com
 [113.46.200.224])
 by mails.dpdk.org (Postfix) with ESMTP id 98EB240156
 for <dev@dpdk.org>; Fri, 24 Oct 2025 11:21:41 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=CYVlxbpA0WUjKjpgPrTPzm0g6XlOyPLpR0TxJ8kLFAE=;
 b=hC85BzNxAjhIyJfmdkpa58kW3wQsc0knVzybITX+qD6aUSsRJliHth6C4uZ7B7GkWsCIBx0qt
 BD4A76zldLbkmlpCpWh7uF2D5oExCvuFNPbQW6ppU73s2xB1gY+QccPRCN9Lt3xQFOMiHeMf7gB
 QtW7ppP4xXqAhK0+/tDkT80=
Received: from mail.maildlp.com (unknown [172.19.163.17])
 by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4ctHT60FBGz1cyPd;
 Fri, 24 Oct 2025 17:21:14 +0800 (CST)
Received: from kwepemk200009.china.huawei.com (unknown [7.202.194.75])
 by mail.maildlp.com (Postfix) with ESMTPS id C3E301A0188;
 Fri, 24 Oct 2025 17:21:39 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 kwepemk200009.china.huawei.com (7.202.194.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 24 Oct 2025 17:21:38 +0800
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Fri, 24 Oct 2025 10:21:36 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>, "Bruce
 Richardson" <bruce.richardson@intel.com>, Thomas Monjalon
 <thomas@monjalon.net>
CC: "dev@dpdk.org" <dev@dpdk.org>, Stephen Hemminger
 <stephen@networkplumber.org>, Wathsala Vithanage
 <wathsala.vithanage@arm.com>, Fengchengwen <fengchengwen@huawei.com>
Subject: RE: [PATCH v7] mbuf: optimize segment prefree
Thread-Topic: [PATCH v7] mbuf: optimize segment prefree
Thread-Index: AQHcRDjKDZgiVqK2tUaY10zSlJWeBrTQ9TOwgAAJHQCAAAbA4A==
Date: Fri, 24 Oct 2025 09:21:36 +0000
Message-ID: <1d47dfea2fcc4dfc8507dd0ba3cbe6ec@huawei.com>
References: <20250827213535.21602-1-mb@smartsharesystems.com>
 <20251023161851.328258-1-mb@smartsharesystems.com>
 <9abef7c705da4f9194fd95e1fdeb004c@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65503@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65503@smartserver.smartshare.dk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.158.0]
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

DQoNCj4gPiA+IFJlZmFjdG9yZWQgcnRlX3BrdG1idWZfcHJlZnJlZV9zZWcoKSBmb3IgYm90aCBw
ZXJmb3JtYW5jZSBhbmQNCj4gPiByZWFkYWJpbGl0eS4NCj4gPiA+DQo+ID4gPiBXaXRoIHRoZSBv
cHRpbWl6ZWQgUlRFX01CVUZfRElSRUNUKCkgbWFjcm8sIHRoZSBjb21tb24gbGlrZWx5IGNvZGUN
Cj4gPiBwYXRoDQo+ID4gPiBub3cgZml0cyB3aXRoaW4gb25lIGluc3RydWN0aW9uIGNhY2hlIGxp
bmUgb24geDg2LTY0IHdoZW4gYnVpbHQgd2l0aA0KPiA+IEdDQy4NCj4gPiA+DQo+ID4gPiBTaWdu
ZWQtb2ZmLWJ5OiBNb3J0ZW4gQnLDuHJ1cCA8bWJAc21hcnRzaGFyZXN5c3RlbXMuY29tPg0KPiA+
ID4gQWNrZWQtYnk6IEtvbnN0YW50aW4gQW5hbnlldiA8a29uc3RhbnRpbi5hbmFueWV2QGh1YXdl
aS5jb20+DQo+ID4gPiBBY2tlZC1ieTogQ2hlbmd3ZW4gRmVuZyA8ZmVuZ2NoZW5nd2VuQGh1YXdl
aS5jb20+DQo+ID4gPiBSZXZpZXdlZC1ieTogQnJ1Y2UgUmljaGFyZHNvbiA8YnJ1Y2UucmljaGFy
ZHNvbkBpbnRlbC5jb20+DQo+ID4gPiAtLS0NCj4gPiA+IHY3Og0KPiA+ID4gKiBHbyBiYWNrIHRv
IGxvbmcgbmFtZXMgaW5zdGVhZCBvZiBudW1lcmljYWwgdmFsdWUgaW4NCj4gPiBSVEVfTUJVRl9E
SVJFQ1QoKQ0KPiA+ID4gICBtYWNyby4NCj4gPiA+ICAgKEtvbnN0YW50aW4gQW5hbnlldikNCj4g
PiA+ICogVXBkYXRlZCBzdGF0aWNfYXNzZXJ0KCkgYWNjb3JkaW5nbHkuDQo+IA0KPiBbLi4uXQ0K
PiANCj4gPiA+ICAgKg0KPiA+ID4gICAqIElmIGEgbWJ1ZiBlbWJlZHMgaXRzIG93biBkYXRhIGFm
dGVyIHRoZSBydGVfbWJ1ZiBzdHJ1Y3R1cmUsIHRoaXMNCj4gPiBtYnVmDQo+ID4gPiAgICogY2Fu
IGJlIGRlZmluZWQgYXMgYSBkaXJlY3QgbWJ1Zi4NCj4gPiA+IC0gKi8NCj4gPiA+ICsgKg0KPiA+
ID4gKyAqIE5vdGU6IE1hY3JvIG9wdGltaXplZCBmb3IgY29kZSBzaXplLg0KPiA+ID4gKyAqDQo+
ID4gPiArICogVGhlIHBsYWluIG1hY3JvIHdvdWxkIGJlOg0KPiA+ID4gKyAqIFxjb2Rley5jfQ0K
PiA+ID4gKyAqICAgICAgI2RlZmluZSBSVEVfTUJVRl9ESVJFQ1QobWIpIFwNCj4gPiA+ICsgKiAg
ICAgICAgICAoISgobWIpLT5vbF9mbGFncyAmIChSVEVfTUJVRl9GX0lORElSRUNUIHwNCj4gPiA+
IFJURV9NQlVGX0ZfRVhURVJOQUwpKSkNCj4gPiA+ICsgKiBcZW5kY29kZQ0KPiA+ID4gKyAqDQo+
ID4gPiArICogVGhlIGZsYWdzIFJURV9NQlVGX0ZfSU5ESVJFQ1QgYW5kIFJURV9NQlVGX0ZfRVhU
RVJOQUwgYXJlIGJvdGggaW4NCj4gPiA+IHRoZSBNU0IgKG1vc3Qgc2lnbmlmaWNhbnQNCj4gPiA+
ICsgKiBieXRlKSBvZiB0aGUgNjQtYml0IG9sX2ZsYWdzIGZpZWxkLCBzbyB3ZSBvbmx5IGNvbXBh
cmUgdGhpcyBvbmUNCj4gPiBieXRlIGluc3RlYWQgb2YNCj4gPiA+IGFsbCA2NCBiaXRzLg0KPiA+
ID4gKyAqDQo+ID4gPiArICogRS5nLiwgR0NDIHZlcnNpb24gMTYuMC4wIDIwMjUxMDE5IChleHBl
cmltZW50YWwpIGdlbmVyYXRlcyB0aGUNCj4gPiBmb2xsb3dpbmcNCj4gPiA+IGNvZGUgZm9yIHg4
Ni02NC4NCj4gPiA+ICsgKg0KPiA+ID4gKyAqIFdpdGggdGhlIHBsYWluIG1hY3JvLCAxNyBieXRl
cyBvZiBpbnN0cnVjdGlvbnM6DQo+ID4gPiArICogXGNvZGUNCj4gPiA+ICsgKiAgICAgIG1vdmFi
cyByYXgsMHg2MDAwMDAwMDAwMDAwMDAwICAgICAgIC8vIDEwIGJ5dGVzDQo+ID4gPiArICogICAg
ICBhbmQgICAgcmF4LFFXT1JEIFBUUiBbcmRpKzB4MThdICAgICAvLyA0IGJ5dGVzDQo+ID4gPiAr
ICogICAgICBzZXRlICAgYWwgICAgICAgICAgICAgICAgICAgICAgICAgICAvLyAzIGJ5dGVzDQo+
ID4gPiArICogXGVuZGNvZGUNCj4gPiA+ICsgKiBXaXRoIHRoaXMgb3B0aW1pemVkIG1hY3JvLCBv
bmx5IDcgYnl0ZXMgb2YgaW5zdHJ1Y3Rpb25zOg0KPiA+ID4gKyAqIFxjb2RlDQo+ID4gPiArICog
ICAgICB0ZXN0ICAgQllURSBQVFIgW3JkaSsweDFmXSwweDYwICAgICAvLyA0IGJ5dGVzDQo+ID4g
PiArICogICAgICBzZXRlICAgYWwgICAgICAgICAgICAgICAgICAgICAgICAgICAvLyAzIGJ5dGVz
DQo+ID4gPiArICogXGVuZGNvZGUNCj4gPiA+ICsgKi8NCj4gPiA+ICsjaWZkZWYgX19ET1hZR0VO
X18NCj4gPiA+ICsjZGVmaW5lIFJURV9NQlVGX0RJUkVDVChtYikgXA0KPiA+ID4gKwkhKCgoY29u
c3QgY2hhciAqKSgmKG1iKS0+b2xfZmxhZ3MpKVtNU0JfT0ZGU0VUIC8qIDcgb3IgMCwNCj4gPiBk
ZXBlbmRpbmcgb24NCj4gPiA+IGVuZGlhbm5lc3MgKi9dICYgXA0KPiA+ID4gKwkoY2hhcikoKFJU
RV9NQlVGX0ZfSU5ESVJFQ1QgfCBSVEVfTUJVRl9GX0VYVEVSTkFMKSA+PiAoNyAqDQo+ID4gPiBD
SEFSX0JJVCkpKQ0KPiA+ID4gKyNlbHNlIC8qICFfX0RPWFlHRU5fXyAqLw0KPiA+ID4gKyNpZiBS
VEVfQllURV9PUkRFUiA9PSBSVEVfTElUVExFX0VORElBTg0KPiA+ID4gKy8qIE9uIGxpdHRsZSBl
bmRpYW4gYXJjaGl0ZWN0dXJlLCB0aGUgTVNCIG9mIGEgNjQtYml0IGludGVnZXIgaXMgYXQNCj4g
PiBieXRlIG9mZnNldCA3LiAqLw0KPiA+ID4gKyNkZWZpbmUgUlRFX01CVUZfRElSRUNUKG1iKSBc
DQo+ID4gPiArCSEoKChjb25zdCBjaGFyICopKCYobWIpLT5vbF9mbGFncykpWzddICYgXA0KPiA+
ID4gKwkoY2hhcikoKFJURV9NQlVGX0ZfSU5ESVJFQ1QgfCBSVEVfTUJVRl9GX0VYVEVSTkFMKSA+
PiAoNyAqDQo+ID4gPiBDSEFSX0JJVCkpKQ0KPiA+ID4gKyNlbGlmIFJURV9CWVRFX09SREVSID09
IFJURV9CSUdfRU5ESUFODQo+ID4gPiArLyogT24gYmlnIGVuZGlhbiBhcmNoaXRlY3R1cmUsIHRo
ZSBNU0Igb2YgYSA2NC1iaXQgaW50ZWdlciBpcyBhdA0KPiA+IGJ5dGUgb2Zmc2V0IDAuICovDQo+
ID4gPiAgI2RlZmluZSBSVEVfTUJVRl9ESVJFQ1QobWIpIFwNCj4gPiA+IC0JKCEoKG1iKS0+b2xf
ZmxhZ3MgJiAoUlRFX01CVUZfRl9JTkRJUkVDVCB8DQo+ID4gPiBSVEVfTUJVRl9GX0VYVEVSTkFM
KSkpDQo+ID4gPiArCSEoKChjb25zdCBjaGFyICopKCYobWIpLT5vbF9mbGFncykpWzBdICYgXA0K
PiA+ID4gKwkoY2hhcikoKFJURV9NQlVGX0ZfSU5ESVJFQ1QgfCBSVEVfTUJVRl9GX0VYVEVSTkFM
KSA+PiAoNyAqDQo+ID4gPiBDSEFSX0JJVCkpKQ0KPiA+ID4gKyNlbmRpZiAvKiBSVEVfQllURV9P
UkRFUiAqLw0KPiA+ID4gKyNlbmRpZiAvKiAhX19ET1hZR0VOX18gKi8NCj4gPiA+ICsvKiBWZXJp
ZnkgdGhlIG9wdGltaXphdGlvbiBhYm92ZS4gKi8NCj4gPiA+ICtzdGF0aWNfYXNzZXJ0KCgoUlRF
X01CVUZfRl9JTkRJUkVDVCB8IFJURV9NQlVGX0ZfRVhURVJOQUwpICYNCj4gPiA+IChVSU5UNjRf
QygweEZGKSA8PCAoNyAqIENIQVJfQklUKSkpID09DQo+ID4gPiArCShSVEVfTUJVRl9GX0lORElS
RUNUIHwgUlRFX01CVUZfRl9FWFRFUk5BTCksDQo+ID4gPiArCSIoUlRFX01CVUZfRl9JTkRJUkVD
VCB8IFJURV9NQlVGX0ZfRVhURVJOQUwpIGlzIG5vdCBhdCBNU0IiKTsNCj4gPiA+DQo+ID4gPiAg
LyoqIFVuaW5pdGlhbGl6ZWQgb3IgdW5zcGVjaWZpZWQgcG9ydC4gKi8NCj4gPiA+ICAjZGVmaW5l
IFJURV9NQlVGX1BPUlRfSU5WQUxJRCBVSU5UMTZfTUFYDQo+ID4gPiAtLQ0KPiA+DQo+ID4gTEdU
TSwgdGhhbmtzIGZvciByZWZhY3RvcmluZy4NCj4gDQo+IFRoYW5rIHlvdSBmb3IgcmV2aWV3aW5n
LCBLb25zdGFudGluLg0KPiANCj4gSSBoYWQgbm8gcHJlZmVyZW5jZSBmb3Igdjcgb3IgdjYsIGJ1
dCBCcnVjZSBhbmQgVGhvbWFzIHByZWZlcnJlZCB2Niwgc28gdjYgd2FzDQo+IGFwcGxpZWQuDQoN
ClllcywgSSBzYXcgVGhvbWFzIGVtYWlsLCBhZnRlciBJIHNlbnQgbXkgcmVwbHkgYWxyZWFkeS4N
Ckxvb2tzIGxpa2UgSSB3YXMgbGF0ZSB3aXRoIG15IHZvdGUuDQpNeSBwcmVmZXJlbmNlIHN0aWxs
IHdvdWxkIGJlIHRvIGF2b2lkIGhhcmQtY29kZWQgY29uc3RhbnRzIGluIHRoZSBjb2RlLA0KYnV0
IHNlZW1zIHRoYXQgaXQgaXMganVzdCBtZS4NCktvbnN0YW50aW4NCg0K
