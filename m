Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D2FCA5FA1
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 13:34:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C412D40ED1;
	Tue, 29 Sep 2026 15:34:28 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id D847B40E36
 for <dev@dpdk.org>; Tue, 29 Sep 2026 15:34:27 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id A016920989;
 Tue, 29 Sep 2026 15:34:27 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v3 1/1] mbuf: add optional no-copy dynamic field storage
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Tue, 29 Sep 2026 15:34:24 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65A88@smartserver.smartshare.dk>
In-Reply-To: <4b426d5e-d141-486a-b9e1-acd85c260507@yandex.ru>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v3 1/1] mbuf: add optional no-copy dynamic field storage
Thread-Index: Ad1QFDL+m2nlhhfJQtiJWNh7mLvFyAAAgeMw
References: <179036466858.2.13982499480648014088.v2-0000-cover-letter.patch@cisco.com>
 <179061941387.2.17741463412422386825.v3-0000-cover-letter.patch@cisco.com>
 <179061941387.2.13690688541375502570.v3-0001-mbuf-add-optional-no-copy-dynamic-field-storage.patch@cisco.com>
 <3732a4ac-a585-4bb6-b08a-2b3dab6b782a@yandex.ru>
 <98CBD80474FA8B44BF855DF32C47DC35F65A87@smartserver.smartshare.dk>
 <4b426d5e-d141-486a-b9e1-acd85c260507@yandex.ru>
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
YW5kZXgucnVdDQo+IFNlbnQ6IFR1ZXNkYXksIDI5IFNlcHRlbWJlciAyMDI2IDE1LjEzDQo+IA0K
PiAyOS4wOS4yMDI2IDEzOjQ0LCBNb3J0ZW4gQnLDuHJ1cCDQv9C40YjQtdGCOg0KPiA+PiBGcm9t
OiBLb25zdGFudGluIEFuYW55ZXYgW21haWx0bzprb25zdGFudGluLnYuYW5hbnlldkB5YW5kZXgu
cnVdDQo+ID4+IFNlbnQ6IFR1ZXNkYXksIDI5IFNlcHRlbWJlciAyMDI2IDE0LjAwDQo+ID4+DQo+
ID4+IDI4LjA5LjIwMjYgMTk6MTYsIFJhbmR5IEwgVGljZSDQv9C40YjQtdGCOg0KPiA+Pj4gRnJv
bTogUmFuZHkgTCBUaWNlIDxydGljZUBjaXNjby5jb20+DQo+ID4+PiBEYXRlOiBUaHUsIDAzIFNl
cCAyMDI2IDA5OjEzOjI4IC0wNDAwDQo+ID4+Pg0KPiA+Pj4gQWRkIGJ1aWxkLXRpbWUgc3VwcG9y
dCBmb3Igb3B0aW9uYWwgY2FjaGUtbGluZS1hbGlnbmVkIGR5bmFtaWMtDQo+IGZpZWxkDQo+ID4+
PiBzdG9yYWdlIGF0IHRoZSBlbmQgb2Ygc3RydWN0IHJ0ZV9tYnVmLg0KPiA+Pj4NCj4gPj4+IFRo
ZSBtYnVmX2R5bmZpZWxkM19zaXplIE1lc29uIG9wdGlvbiBzZXRzIFJURV9NQlVGX0RZTkZJRUxE
M19TSVpFDQo+IGluDQo+ID4+PiBydGVfYnVpbGRfY29uZmlnLmguIEEgbm9uLXplcm8gdmFsdWUg
ZW5hYmxlcyB0aGUgZXh0cmEgYXJlYSBhbmQNCj4gZ3Jvd3MNCj4gPj4+IGV2ZXJ5IG1idWYgYnkg
dGhlIGNvbmZpZ3VyZWQgYW1vdW50Lg0KPiA+PiBJIGFtIHN0cm9uZ2x5IG9wcG9zZWQgdG8gdGhh
dCBwYXRjaC4NCj4gPj4gSW5zaWRlIG1idWYgd2UgYWxyZWFkeSBkbyBoYXZlIHByaXZfc2l6ZSB0
aGF0IGFsbG93cyB1c2VyIHRvIHN0b3JlDQo+ID4+IGhpcy9oZXIgc3BlY2lmaWMNCj4gPj4gZGF0
YSBzdHJhaWdodCBhZnRlciBydGVfbWJ1ZiBpbiBhZGphY2VudCBtYW5uZXIuDQo+ID4+IEl0IHdv
cmtlZCB3ZWxsIHNvIGZhciBmb3IgbWFueSB1c2UtY2FzZXMgKGluY2x1ZGluZyBWUFApIGFuZCBJ
IGRvbid0DQo+ID4+IHNlZSBhbnkNCj4gPj4gcmVhc29uIHdoeSB0aGlzIGlzIG5vdCBlbm91Z2gu
DQo+ID4+ICAgRnJvbSBvdGhlciBzaWRlIC0gbWFraW5nIHNpemUgb2YgY29yZSBydGVfbWJ1ZiBj
b25maWd1cmFibGUgYXQNCj4gcnVuLQ0KPiA+PiB0aW1lLA0KPiA+PiB3aWxsIGFmZmVjdCBEUERL
IEFCSSBzdGFiaWxpdHkgaW4gYSBuZWdhdGl2ZSB3YXkuDQo+ID4+IEZybyBteSBwZXJzcGVjdGl2
ZSBpdCBpcyBtdWNoIHBsYXVzaWJsZSBpbiB0ZXJtcyBvZiBBQkkgc3RhYmlsaXR5DQo+IGFuZA0K
PiA+PiBwcmVkaWN0YWJpbGl0eQ0KPiA+PiB0byBoYXZlIGp1c3Qgb25lIGZpeGVkIGxheW91dCBm
b3IgdGhlIG1idWYuDQo+ID4+IEtvbnN0YW50aW4NCj4gPiBUaGUgcHJpdmF0ZSBkYXRhIGFyZWEg
KHByaXZfc2l6ZSkgaXMgaW5kZXBlbmRlbnQgcGVyIG1idWYgcG9vbCwgYW5kDQo+IHNlbGVjdGVk
IGF0IHJ1bi10aW1lIHdoZW4gY3JlYXRpbmcgZWFjaCBwb29sLiBBcyBSYW5keSBleHBsYWluZWQg
aW4gdGhlDQo+IFJGQywgdGhpcyBpcyB1bmF2YWlsYWJsZSBmb3IgbWJ1ZiBwb29scyBjcmVhdGVk
IGJ5IG90aGVyIGNvbXBvbmVudHMuDQo+IA0KPiBJIHRoaW5rIGl0IHNob3VsZCBiZSB0cml2aWFs
IHRvIGVuZm9yY2UgbWluaW1hbCBwcml2X3NpemUgYWNyb3NzIGFsbA0KPiBtYnVmIHBvb2xzIHdo
YXQgd2lsbCBiZSBvYmV5ZWQgYnkgZGlmZmVyZW50IGNvbXBvbmVudHMNCj4gKGFzIGxvbmcgYXMg
dGhleSBkbyB1c2UgcnRlX3BrdG1idWZfcG9vbF9jcmVhdGUoKSBhbmQgZnJpZW5kcyk6DQo+IDEp
IGludHJvZHVjZSBuZXcgRUFMIHBhcmFtZXRlciAnbWJ1Zi1taW4tcHJpdi1zaXplJyBvciBzbyAo
a2VlcCBkZWZhdWx0DQo+IGFzIHplcm8pDQo+IDIpIG1ha2UgcnRlX3BrdG1idWZfcG9vbF9jcmVh
dGVfYnlfb3BzKCkgYW5kDQo+IHJ0ZV9wa3RtYnVmX3Bvb2xfY3JlYXRlX2V4dGJ1ZigpIHRvIGNo
ZWNrIHRoYXQgaW5wdXQgcGFyYW10ZXINCj4gJ3ByaXZfc2l6ZScgR0UgdGhlbiB2YWx1ZSBzcGVj
aWZpZWQgYnkgRUFMIHBhcmFtZXRlciwgaWYgc28gdGhlbiByZXR1cm4NCj4gYW4gZXJyb3IuDQoN
ClRoZSBwcml2YXRlIGRhdGEgYXJlYSBjYW5ub3QgYmUgdXNlZC4NCkxldCdzIHNheSBvbmUgbW9k
dWxlIGNyZWF0ZXMgYW4gbWJ1ZiBwb29sIHdpdGggcHJpdl9zaXplIG9mIDgsIGFuZCB1c2VzIHRo
b3NlIDggYnl0ZXMsDQphbmQgc29tZSBzZWNvbmQgbW9kdWxlIGNyZWF0ZXMgYW4gbWJ1ZiBwb29s
IHdpdGggcHJpdl9zaXplIG9mIDE2LCBhbmQgdXNlcyB0aG9zZSAxNiBieXRlcy4NCg0KSG93IHNo
b3VsZCBhIG1vZHVsZSAob3IgdGhlIGFwcGxpY2F0aW9uKSBrbm93IGF0IHdoaWNoIG9mZnNldCB0
byBzdG9yZSBpdHMgcHJpdmF0ZSBkYXRhIHdpdGhvdXQgb3ZlcndyaXRpbmcgdGhlIHByaXZhdGUg
ZGF0YSBvZiBvdGhlciBtb2R1bGVzPw0KDQpUaGUgbWJ1ZiBkeW5hbWljIGZpZWxkJ3MgcmVnaXN0
cnkgbWFuYWdlcyBjZW50cmFsbHkgd2hlcmUgZWFjaCBtb2R1bGUgc2hvdWxkIHN0b3JlIGl0cyBv
d24gZGF0YSwgYW5kIHRoZSBkYXRhIGlzIGV2ZW4gYWNjZXNzaWJsZSBieSBvdGhlciBtb2R1bGVz
IChiZWNhdXNlIHRoZXkgY2FuIGZldGNoIHRoZSBvZmZzZXQgdG8gdGhlIGRhdGEgZnJvbSB0aGUg
cmVnaXN0cnkpLg0KDQo+IA0KPiA+DQo+ID4gTWJ1ZiBkeW5hbWljIGZpZWxkcyBhcmUgc2hhcmVk
IGFjcm9zcyBhbGwgbWJ1ZiBwb29scywgYW5kIHNlcnZlcyB0aGUNCj4gbmVlZCB3aXRoIGFuIGV4
aXN0aW5nIEFQSS4gU28gSSBhbSBzdHJvbmdseSBpbiBmYXZvciBvZiB1c2luZyB0aGUgbWJ1Zg0K
PiBkeW5hbWljIGZpZWxkcyBBUEkgZm9yIHRoaXMuDQo+ID4NCj4gPiBJIGFncmVlIHdpdGggS29u
c3RhbnRpbiB0aGF0IGl0IHdvdWxkIGJlIG9wdGltYWwgaWYgdGhlIHNpemUgb2YgdGhlDQo+IGFk
ZGVkIGR5bmZpZWxkcyBhcmVhIHdhcyBydW4tdGltZSBjb25maWd1cmFibGUgKGFzIGFuIEVBTCBz
dGFydHVwDQo+IHBhcmFtZXRlcikuDQo+ID4gSG93ZXZlciwgc3VjaCBhIG1vZGlmaWNhdGlvbiB0
byB0aGUgbWJ1ZiBsaWJyYXJ5IHdvdWxkIGFsc28gcmVxdWlyZQ0KPiB0aGF0IHRoZSBwZXJmb3Jt
YW5jZSBjb3N0IGluIHRoZSBkYXRhcGxhbmUgaXMgbmVnbGlnaWJsZS4gV2UgZG9uJ3Qgd2FudA0K
PiB0byBjb21wcm9taXNlIG9uIG1idWYgcGVyZm9ybWFuY2UgZm9yIGFwcGxpY2F0aW9ucyBub3Qg
dXNpbmcgdGhpcyBuZXcNCj4gZmVhdHVyZS4NCj4gPg0KPiA+IFJhbmR5LA0KPiA+IENvdWxkIHlv
dSBwbGVhc2UgZXhwbG9yZSBzdWNoIGFuIGFwcHJvYWNoPw0KPiA+DQo+ID4gLU1vcnRlbg0KDQo=
