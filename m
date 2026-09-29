Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9530ACA5FA1
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 12:44:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D84244113D;
	Tue, 29 Sep 2026 14:44:24 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id DD0A24026E
 for <dev@dpdk.org>; Tue, 29 Sep 2026 14:44:22 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id A933D20989;
 Tue, 29 Sep 2026 14:44:22 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v3 1/1] mbuf: add optional no-copy dynamic field storage
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Tue, 29 Sep 2026 14:44:20 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65A87@smartserver.smartshare.dk>
In-Reply-To: <3732a4ac-a585-4bb6-b08a-2b3dab6b782a@yandex.ru>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v3 1/1] mbuf: add optional no-copy dynamic field storage
Thread-Index: Ad1QChGsLQ7WK1i/S3Ke833sD1tiCwAADf8w
References: <179036466858.2.13982499480648014088.v2-0000-cover-letter.patch@cisco.com>
 <179061941387.2.17741463412422386825.v3-0000-cover-letter.patch@cisco.com>
 <179061941387.2.13690688541375502570.v3-0001-mbuf-add-optional-no-copy-dynamic-field-storage.patch@cisco.com>
 <3732a4ac-a585-4bb6-b08a-2b3dab6b782a@yandex.ru>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Konstantin Ananyev" <konstantin.v.ananyev@yandex.ru>,
 "Randy L Tice" <rtice@cisco.com>, <dev@dpdk.org>
Cc: "Bruce Richardson" <bruce.richardson@intel.com>,
 "Harman Kalra" <hkalra@marvell.com>,
 "Stephen Hemminger" <stephen@networkplumber.org>
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

PiBGcm9tOiBLb25zdGFudGluIEFuYW55ZXYgW21haWx0bzprb25zdGFudGluLnYuYW5hbnlldkB5
YW5kZXgucnVdDQo+IFNlbnQ6IFR1ZXNkYXksIDI5IFNlcHRlbWJlciAyMDI2IDE0LjAwDQo+IA0K
PiAyOC4wOS4yMDI2IDE5OjE2LCBSYW5keSBMIFRpY2Ug0L/QuNGI0LXRgjoNCj4gPiBGcm9tOiBS
YW5keSBMIFRpY2UgPHJ0aWNlQGNpc2NvLmNvbT4NCj4gPiBEYXRlOiBUaHUsIDAzIFNlcCAyMDI2
IDA5OjEzOjI4IC0wNDAwDQo+ID4NCj4gPiBBZGQgYnVpbGQtdGltZSBzdXBwb3J0IGZvciBvcHRp
b25hbCBjYWNoZS1saW5lLWFsaWduZWQgZHluYW1pYy1maWVsZA0KPiA+IHN0b3JhZ2UgYXQgdGhl
IGVuZCBvZiBzdHJ1Y3QgcnRlX21idWYuDQo+ID4NCj4gPiBUaGUgbWJ1Zl9keW5maWVsZDNfc2l6
ZSBNZXNvbiBvcHRpb24gc2V0cyBSVEVfTUJVRl9EWU5GSUVMRDNfU0laRSBpbg0KPiA+IHJ0ZV9i
dWlsZF9jb25maWcuaC4gQSBub24temVybyB2YWx1ZSBlbmFibGVzIHRoZSBleHRyYSBhcmVhIGFu
ZCBncm93cw0KPiA+IGV2ZXJ5IG1idWYgYnkgdGhlIGNvbmZpZ3VyZWQgYW1vdW50Lg0KPiBJIGFt
IHN0cm9uZ2x5IG9wcG9zZWQgdG8gdGhhdCBwYXRjaC4NCj4gSW5zaWRlIG1idWYgd2UgYWxyZWFk
eSBkbyBoYXZlIHByaXZfc2l6ZSB0aGF0IGFsbG93cyB1c2VyIHRvIHN0b3JlDQo+IGhpcy9oZXIg
c3BlY2lmaWMNCj4gZGF0YSBzdHJhaWdodCBhZnRlciBydGVfbWJ1ZiBpbiBhZGphY2VudCBtYW5u
ZXIuDQo+IEl0IHdvcmtlZCB3ZWxsIHNvIGZhciBmb3IgbWFueSB1c2UtY2FzZXMgKGluY2x1ZGlu
ZyBWUFApIGFuZCBJIGRvbid0DQo+IHNlZSBhbnkNCj4gcmVhc29uIHdoeSB0aGlzIGlzIG5vdCBl
bm91Z2guDQo+ICBGcm9tIG90aGVyIHNpZGUgLSBtYWtpbmcgc2l6ZSBvZiBjb3JlIHJ0ZV9tYnVm
IGNvbmZpZ3VyYWJsZSBhdCBydW4tDQo+IHRpbWUsDQo+IHdpbGwgYWZmZWN0IERQREsgQUJJIHN0
YWJpbGl0eSBpbiBhIG5lZ2F0aXZlIHdheS4NCj4gRnJvIG15IHBlcnNwZWN0aXZlIGl0IGlzIG11
Y2ggcGxhdXNpYmxlIGluIHRlcm1zIG9mIEFCSSBzdGFiaWxpdHkgYW5kDQo+IHByZWRpY3RhYmls
aXR5DQo+IHRvIGhhdmUganVzdCBvbmUgZml4ZWQgbGF5b3V0IGZvciB0aGUgbWJ1Zi4NCj4gS29u
c3RhbnRpbg0KDQpUaGUgcHJpdmF0ZSBkYXRhIGFyZWEgKHByaXZfc2l6ZSkgaXMgaW5kZXBlbmRl
bnQgcGVyIG1idWYgcG9vbCwgYW5kIHNlbGVjdGVkIGF0IHJ1bi10aW1lIHdoZW4gY3JlYXRpbmcg
ZWFjaCBwb29sLiBBcyBSYW5keSBleHBsYWluZWQgaW4gdGhlIFJGQywgdGhpcyBpcyB1bmF2YWls
YWJsZSBmb3IgbWJ1ZiBwb29scyBjcmVhdGVkIGJ5IG90aGVyIGNvbXBvbmVudHMuDQoNCk1idWYg
ZHluYW1pYyBmaWVsZHMgYXJlIHNoYXJlZCBhY3Jvc3MgYWxsIG1idWYgcG9vbHMsIGFuZCBzZXJ2
ZXMgdGhlIG5lZWQgd2l0aCBhbiBleGlzdGluZyBBUEkuIFNvIEkgYW0gc3Ryb25nbHkgaW4gZmF2
b3Igb2YgdXNpbmcgdGhlIG1idWYgZHluYW1pYyBmaWVsZHMgQVBJIGZvciB0aGlzLg0KDQpJIGFn
cmVlIHdpdGggS29uc3RhbnRpbiB0aGF0IGl0IHdvdWxkIGJlIG9wdGltYWwgaWYgdGhlIHNpemUg
b2YgdGhlIGFkZGVkIGR5bmZpZWxkcyBhcmVhIHdhcyBydW4tdGltZSBjb25maWd1cmFibGUgKGFz
IGFuIEVBTCBzdGFydHVwIHBhcmFtZXRlcikuDQpIb3dldmVyLCBzdWNoIGEgbW9kaWZpY2F0aW9u
IHRvIHRoZSBtYnVmIGxpYnJhcnkgd291bGQgYWxzbyByZXF1aXJlIHRoYXQgdGhlIHBlcmZvcm1h
bmNlIGNvc3QgaW4gdGhlIGRhdGFwbGFuZSBpcyBuZWdsaWdpYmxlLiBXZSBkb24ndCB3YW50IHRv
IGNvbXByb21pc2Ugb24gbWJ1ZiBwZXJmb3JtYW5jZSBmb3IgYXBwbGljYXRpb25zIG5vdCB1c2lu
ZyB0aGlzIG5ldyBmZWF0dXJlLg0KDQpSYW5keSwNCkNvdWxkIHlvdSBwbGVhc2UgZXhwbG9yZSBz
dWNoIGFuIGFwcHJvYWNoPw0KDQotTW9ydGVuDQoNCg==
