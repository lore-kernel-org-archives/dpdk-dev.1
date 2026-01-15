Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF67D44C49
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Jan 2026 13:27:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 90794410F1;
	Thu, 15 Jan 2026 14:27:28 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 066E14003C;
 Thu, 15 Jan 2026 14:27:28 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 59D65229AD;
 Thu, 15 Jan 2026 14:27:27 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH] mbuf: fix packet copy
Date: Thu, 15 Jan 2026 14:27:26 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65665@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65664@smartserver.smartshare.dk>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] mbuf: fix packet copy
Thread-Index: AdxZTJorOUhx0EXzTH2tsl7JhzajBgsv89bQAAWKcQA=
References: <98CBD80474FA8B44BF855DF32C47DC35F65664@smartserver.smartshare.dk>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: <dev@dpdk.org>
Cc: <stable@dpdk.org>,
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

Rm9yd2FyZGluZyBhbiBlbWFpbCBpcyBhcHBhcmVudGx5IGEgYmFkIGlkZWE7IHBhdGNod29yayBw
aWNrZWQgaXQgdXAgYXMgYSBuZXcgcGF0Y2guDQoNClZlbmxpZyBoaWxzZW4gLyBLaW5kIHJlZ2Fy
ZHMsDQotTW9ydGVuIEJyw7hydXANCg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
IEZyb206IE1vcnRlbiBCcsO4cnVwIFttYWlsdG86bWJAc21hcnRzaGFyZXN5c3RlbXMuY29tXQ0K
PiBTZW50OiBUaHVyc2RheSwgMTUgSmFudWFyeSAyMDI2IDExLjUzDQo+IFRvOiBTdGVwaGVuIEhl
bW1pbmdlcg0KPiBDYzogZGV2QGRwZGsub3JnOyBzdGFibGVAZHBkay5vcmcNCj4gU3ViamVjdDog
Rlc6IFtQQVRDSF0gbWJ1ZjogZml4IHBhY2tldCBjb3B5DQo+IA0KPiBTdGVwaGVuLA0KPiANCj4g
QXMgdGhlIGF1dGhvciBvZiBydGVfcGt0bWJ1Zl9jb3B5KCksIGNhbiB5b3UgcGxlYXNlIHJldmll
dyB0aGlzIHBhdGNoPw0KPiANCj4gWW91IG1pZ2h0IGZpbmQgbXkgYW5zd2VycyB0byBLb25zdGFu
dGluJ3MgcmV2aWV3IGluZm9ybWF0aXZlOg0KPiBodHRwczovL3BhdGNod29yay5kcGRrLm9yZy9w
cm9qZWN0L2RwZGsvcGF0Y2gvMjAyNTExMTkxMjA0MDMuOTA3NTExLTEtDQo+IG1iQHNtYXJ0c2hh
cmVzeXN0ZW1zLmNvbS8jMTgxOTE0DQo+IA0KPiANCj4gVmVubGlnIGhpbHNlbiAvIEtpbmQgcmVn
YXJkcywNCj4gLU1vcnRlbiBCcsO4cnVwDQo+IA0KPiANCj4gRnJvbTogTW9ydGVuIEJyw7hydXAg
W21haWx0bzptYkBzbWFydHNoYXJlc3lzdGVtcy5jb21dDQo+IFNlbnQ6IFdlZG5lc2RheSwgMTkg
Tm92ZW1iZXIgMjAyNSAxMy4wNA0KPiANCj4gUmVxdWVzdHMgZm9yIGNvcHlpbmcgdGhlIGF0IHRo
ZSBlbmQgb2YgYSBwYWNrZXQgaW5jb3JyZWN0bHkgcmV0dXJuZWQNCj4gTlVMTCwNCj4gYXMgaWYg
Y29weWluZyBwYXN0IHRoZSBlbmQgb2YgYSBwYWNrZXQuDQo+IA0KPiBXaGVuIGFsbG9jYXRpbmcg
Y29waWVzIGZyb20gYSBtZW1wb29sIHVzaW5nIHBpbm5lZCBleHRlcm5hbCBidWZmZXJzLA0KPiB0
aGUNCj4gZXh0ZXJuYWwgZmxhZyB3YXMgbm90IHByZXNlcnZlZCBpbiB0aGVzZSBtYnVmcy4NCj4g
DQo+IEZpeGVzOiBjM2E5MGMzODFkYWEgKCJtYnVmOiBhZGQgYSBjb3B5IHJvdXRpbmUiKQ0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogTW9ydGVuIEJyw7hydXAgPG1iQHNtYXJ0c2hhcmVzeXN0ZW1zLmNv
bT4NCj4gLS0tDQo+ICBsaWIvbWJ1Zi9ydGVfbWJ1Zi5jIHwgNiArKystLS0NCj4gIDEgZmlsZSBj
aGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvbGliL21idWYvcnRlX21idWYuYyBiL2xpYi9tYnVmL3J0ZV9tYnVmLmMNCj4gaW5kZXggMGQ5
MzFjN2ExNS4uZTYzOWFmZjAzZSAxMDA2NDQNCj4gLS0tIGEvbGliL21idWYvcnRlX21idWYuYw0K
PiArKysgYi9saWIvbWJ1Zi9ydGVfbWJ1Zi5jDQo+IEBAIC02NzUsNyArNjc1LDcgQEAgcnRlX3Br
dG1idWZfY29weShjb25zdCBzdHJ1Y3QgcnRlX21idWYgKm0sIHN0cnVjdA0KPiBydGVfbWVtcG9v
bCAqbXAsDQo+ICAJX19ydGVfbWJ1Zl9zYW5pdHlfY2hlY2sobSwgMSk7DQo+IA0KPiAgCS8qIGNo
ZWNrIGZvciByZXF1ZXN0IHRvIGNvcHkgYXQgb2Zmc2V0IHBhc3QgZW5kIG9mIG1idWYgKi8NCj4g
LQlpZiAodW5saWtlbHkob2ZmID49IG0tPnBrdF9sZW4pKQ0KPiArCWlmICh1bmxpa2VseShvZmYg
PiBtLT5wa3RfbGVuKSkNCj4gIAkJcmV0dXJuIE5VTEw7DQo+IA0KPiAgCW1jID0gcnRlX3BrdG1i
dWZfYWxsb2MobXApOw0KPiBAQCAtNjg4LDggKzY4OCw4IEBAIHJ0ZV9wa3RtYnVmX2NvcHkoY29u
c3Qgc3RydWN0IHJ0ZV9tYnVmICptLCBzdHJ1Y3QNCj4gcnRlX21lbXBvb2wgKm1wLA0KPiANCj4g
IAlfX3J0ZV9wa3RtYnVmX2NvcHlfaGRyKG1jLCBtKTsNCj4gDQo+IC0JLyogY29waWVkIG1idWYg
aXMgbm90IGluZGlyZWN0IG9yIGV4dGVybmFsICovDQo+IC0JbWMtPm9sX2ZsYWdzID0gbS0+b2xf
ZmxhZ3MgJg0KPiB+KFJURV9NQlVGX0ZfSU5ESVJFQ1R8UlRFX01CVUZfRl9FWFRFUk5BTCk7DQo+
ICsJLyogY29weSBmbGFncyBleGNlcHQgaW5kaXJlY3QgYW5kIGV4dGVybmFsLCBhbmQgcHJlc2Vy
dmUgZmxhZ3Mgb2YNCj4gbmV3bHkgYWxsb2NhdGVkIG1idWYgKi8NCj4gKwltYy0+b2xfZmxhZ3Mg
fD0gbS0+b2xfZmxhZ3MgJg0KPiB+KFJURV9NQlVGX0ZfSU5ESVJFQ1R8UlRFX01CVUZfRl9FWFRF
Uk5BTCk7DQo+IA0KPiAgCXByZXYgPSAmbWMtPm5leHQ7DQo+ICAJbV9sYXN0ID0gbWM7DQo+IC0t
DQo+IDIuNDMuMA0KDQo=
