Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57347C982DB
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 17:16:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7EAD342E5B;
	Fri, 16 Jan 2026 18:16:19 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 672244026A;
 Fri, 16 Jan 2026 18:16:18 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 75F782061A;
 Fri, 16 Jan 2026 18:16:17 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v2] mbuf: fix packet copy
Date: Fri, 16 Jan 2026 18:16:15 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F6566E@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <20260116090616.52854216@phoenix.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v2] mbuf: fix packet copy
Thread-Index: AdyHCnJIjzBoS1dDQVeZ2gei9RGjQwAAEClA
References: <20251119120403.907511-1-mb@smartsharesystems.com><20260116111621.300891-1-mb@smartsharesystems.com>
 <20260116090616.52854216@phoenix.local>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>
Cc: <dev@dpdk.org>, <stable@dpdk.org>,
 "Konstantin Ananyev" <konstantin.ananyev@huawei.com>
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

PiBGcm9tOiBTdGVwaGVuIEhlbW1pbmdlciBbbWFpbHRvOnN0ZXBoZW5AbmV0d29ya3BsdW1iZXIu
b3JnXQ0KPiBTZW50OiBGcmlkYXksIDE2IEphbnVhcnkgMjAyNiAxOC4wNg0KPiANCj4gT24gRnJp
LCAxNiBKYW4gMjAyNiAxMToxNjoyMSArMDAwMA0KPiBNb3J0ZW4gQnLDuHJ1cCA8bWJAc21hcnRz
aGFyZXN5c3RlbXMuY29tPiB3cm90ZToNCj4gDQo+ID4gYnVmOiBmaXggcGFja2V0IGNvcHkNCj4g
Pg0KPiA+IFJlcXVlc3RzIGZvciBjb3B5aW5nIHRoZSBhdCB0aGUgZW5kIG9mIGEgcGFja2V0IGlu
Y29ycmVjdGx5IHJldHVybmVkDQo+IE5VTEwsDQo+ID4gYXMgaWYgY29weWluZyBwYXN0IHRoZSBl
bmQgb2YgYSBwYWNrZXQuDQo+ID4NCj4gPiBXaGVuIGFsbG9jYXRpbmcgdGhlIG1idWYgZm9yIHRo
ZSBjb3B5IGZyb20gYSBtZW1wb29sIHVzaW5nIHBpbm5lZA0KPiBleHRlcm5hbA0KPiA+IGJ1ZmZl
cnMsIHRoZSBleHRlcm5hbCBmbGFnIGluIHRoaXMgbWJ1ZiB3YXMgbm90IHByZXNlcnZlZC4NCj4g
Pg0KPiA+IEZpeGVzOiBjM2E5MGMzODFkYWEgKCJtYnVmOiBhZGQgYSBjb3B5IHJvdXRpbmUiKQ0K
PiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTW9ydGVuIEJyw7hydXAgPG1iQHNtYXJ0c2hhcmVzeXN0
ZW1zLmNvbT4NCj4gPiBBY2tlZC1ieTogS29uc3RhbnRpbiBBbmFueWV2IDxrb25zdGFudGluLmFu
YW55ZXZAaHVhd2VpLmNvbT4NCj4gPiAtLS0NCj4gPiB2MjoNCj4gPiAqIEltcHJvdmVkIGNvbW1l
bnQgYWJvdXQgcHJlc2VydmluZyBmbGFncyBmb3IgbmV3bHkgYWxsb2NhdGVkIG1idWYNCj4gPiAg
IHBvdGVudGlhbGx5IHVzaW5nIHBpbm5lZCBleHRlcm5hbCBidWZmZXIuDQo+ID4gKiBBZGRlZCBt
aXNzaW5nIHNwYWNlcyBpbiBleHByZXNzaW9uLiAoU3RlcGhlbikNCj4gPiAtLS0NCj4gPiAgbGli
L21idWYvcnRlX21idWYuYyB8IDEwICsrKysrKystLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDcg
aW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9saWIv
bWJ1Zi9ydGVfbWJ1Zi5jIGIvbGliL21idWYvcnRlX21idWYuYw0KPiA+IGluZGV4IDBkOTMxYzdh
MTUuLmE1ZDE2ZTRjOTcgMTAwNjQ0DQo+ID4gLS0tIGEvbGliL21idWYvcnRlX21idWYuYw0KPiA+
ICsrKyBiL2xpYi9tYnVmL3J0ZV9tYnVmLmMNCj4gPiBAQCAtNjc1LDcgKzY3NSw3IEBAIHJ0ZV9w
a3RtYnVmX2NvcHkoY29uc3Qgc3RydWN0IHJ0ZV9tYnVmICptLCBzdHJ1Y3QNCj4gcnRlX21lbXBv
b2wgKm1wLA0KPiA+ICAJX19ydGVfbWJ1Zl9zYW5pdHlfY2hlY2sobSwgMSk7DQo+ID4NCj4gPiAg
CS8qIGNoZWNrIGZvciByZXF1ZXN0IHRvIGNvcHkgYXQgb2Zmc2V0IHBhc3QgZW5kIG9mIG1idWYg
Ki8NCj4gPiAtCWlmICh1bmxpa2VseShvZmYgPj0gbS0+cGt0X2xlbikpDQo+ID4gKwlpZiAodW5s
aWtlbHkob2ZmID4gbS0+cGt0X2xlbikpDQo+ID4gIAkJcmV0dXJuIE5VTEw7DQo+ID4NCj4gDQo+
IEkgc3RpbGwgdGhpbmsgYXNraW5nIGZvciBhIGNvcHkgb2YgZGF0YSB0aGF0IGlzbid0IHRoZXJl
IHNob3VsZCByZXR1cm4NCj4gTlVMTA0KPiBub3QgYSB6ZXJvIGxlbmd0aCBtYnVmLiAgS2luZCBv
ZiBhY2FkZW1pYyBzaW5jZSBJIGRvbnQgdGhpbmsgYW55IGNvZGUNCj4gdXNlcw0KPiBub24temVy
byBvZmZzZXQgbm93Lg0KDQpZZXMsIEkgdG90YWxseSBhZ3JlZSBpdCdzIGtpbmQgb2YgYWNhZGVt
aWMuDQpCdXQgSSBpbnNpc3QgdGhhdCBpdCBpcyBhbiBvZmYtYnktb25lIGJ1Zywgc28gSSBmaXhl
ZCBpdC4NCg0KQ29uc2lkZXIgdGhlIGZ1bmN0aW9uIGRvY3VtZW50YXRpb246DQoNCiogQHBhcmFt
IG9mZnNldA0KICogICBUaGUgbnVtYmVyIG9mIGJ5dGVzIHRvIHNraXAgYmVmb3JlIGNvcHlpbmcu
DQogKiAgIElmIHRoZSBtYnVmIGRvZXMgbm90IGhhdmUgdGhhdCBtYW55IGJ5dGVzLCBpdCBpcyBh
biBlcnJvcg0KICogICBhbmQgTlVMTCBpcyByZXR1cm5lZC4NCg0KQW4gb2Zmc2V0IHJlc3VsdGlu
ZyBpbiBjb3B5aW5nIHplcm8gYnl0ZXMgaXMgbm90IGFuIGVycm9yIGFjY29yZGluZyB0byB0aGlz
Lg0KDQpBbHNvIGNvbnNpZGVyIHRoZSBjb21tZW50IGF0IHRoZSBjb21wYXJpc29uIGluIHRoZSBz
b3VyY2UgY29kZToNCi8qIGNoZWNrIGZvciByZXF1ZXN0IHRvIGNvcHkgYXQgb2Zmc2V0IHBhc3Qg
ZW5kIG9mIG1idWYgKi8NCg0KSXQgc2F5cyAicGFzdCB0aGUgZW5kIiwgbm90ICJhdCB0aGUgZW5k
Ii4uLiBhbHRob3VnaCBJJ20gbm90IGNvbmZpZGVudCBlbm91Z2ggaW4gbXkgRW5nbGlzaCBza2ls
bHMgdG8gZGV0ZXJtaW5lIGlmIHRoaXMgbWVhbnMgIj49IiBvciAiPiIuDQoNCg==
