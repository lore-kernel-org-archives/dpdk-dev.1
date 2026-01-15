Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DB6D4116C
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Jan 2026 10:53:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA8ED410E7;
	Thu, 15 Jan 2026 11:53:24 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 0215E406B7;
 Thu, 15 Jan 2026 11:53:22 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 0CB9D229AD;
 Thu, 15 Jan 2026 11:53:22 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: FW: [PATCH] mbuf: fix packet copy
Date: Thu, 15 Jan 2026 11:53:19 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65664@smartserver.smartshare.dk>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] mbuf: fix packet copy
Thread-Index: AdxZTJorOUhx0EXzTH2tsl7JhzajBgsv89bQ
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>
Cc: <dev@dpdk.org>,
	<stable@dpdk.org>
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

U3RlcGhlbiwNCg0KQXMgdGhlIGF1dGhvciBvZiBydGVfcGt0bWJ1Zl9jb3B5KCksIGNhbiB5b3Ug
cGxlYXNlIHJldmlldyB0aGlzIHBhdGNoPw0KDQpZb3UgbWlnaHQgZmluZCBteSBhbnN3ZXJzIHRv
IEtvbnN0YW50aW4ncyByZXZpZXcgaW5mb3JtYXRpdmU6DQpodHRwczovL3BhdGNod29yay5kcGRr
Lm9yZy9wcm9qZWN0L2RwZGsvcGF0Y2gvMjAyNTExMTkxMjA0MDMuOTA3NTExLTEtbWJAc21hcnRz
aGFyZXN5c3RlbXMuY29tLyMxODE5MTQNCg0KDQpWZW5saWcgaGlsc2VuIC8gS2luZCByZWdhcmRz
LA0KLU1vcnRlbiBCcsO4cnVwDQoNCg0KRnJvbTogTW9ydGVuIEJyw7hydXAgW21haWx0bzptYkBz
bWFydHNoYXJlc3lzdGVtcy5jb21dIA0KU2VudDogV2VkbmVzZGF5LCAxOSBOb3ZlbWJlciAyMDI1
IDEzLjA0DQoNClJlcXVlc3RzIGZvciBjb3B5aW5nIHRoZSBhdCB0aGUgZW5kIG9mIGEgcGFja2V0
IGluY29ycmVjdGx5IHJldHVybmVkIE5VTEwsDQphcyBpZiBjb3B5aW5nIHBhc3QgdGhlIGVuZCBv
ZiBhIHBhY2tldC4NCg0KV2hlbiBhbGxvY2F0aW5nIGNvcGllcyBmcm9tIGEgbWVtcG9vbCB1c2lu
ZyBwaW5uZWQgZXh0ZXJuYWwgYnVmZmVycywgdGhlDQpleHRlcm5hbCBmbGFnIHdhcyBub3QgcHJl
c2VydmVkIGluIHRoZXNlIG1idWZzLg0KDQpGaXhlczogYzNhOTBjMzgxZGFhICgibWJ1ZjogYWRk
IGEgY29weSByb3V0aW5lIikNCg0KU2lnbmVkLW9mZi1ieTogTW9ydGVuIEJyw7hydXAgPG1iQHNt
YXJ0c2hhcmVzeXN0ZW1zLmNvbT4NCi0tLQ0KIGxpYi9tYnVmL3J0ZV9tYnVmLmMgfCA2ICsrKy0t
LQ0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQoNCmRp
ZmYgLS1naXQgYS9saWIvbWJ1Zi9ydGVfbWJ1Zi5jIGIvbGliL21idWYvcnRlX21idWYuYw0KaW5k
ZXggMGQ5MzFjN2ExNS4uZTYzOWFmZjAzZSAxMDA2NDQNCi0tLSBhL2xpYi9tYnVmL3J0ZV9tYnVm
LmMNCisrKyBiL2xpYi9tYnVmL3J0ZV9tYnVmLmMNCkBAIC02NzUsNyArNjc1LDcgQEAgcnRlX3Br
dG1idWZfY29weShjb25zdCBzdHJ1Y3QgcnRlX21idWYgKm0sIHN0cnVjdCBydGVfbWVtcG9vbCAq
bXAsDQogCV9fcnRlX21idWZfc2FuaXR5X2NoZWNrKG0sIDEpOw0KIA0KIAkvKiBjaGVjayBmb3Ig
cmVxdWVzdCB0byBjb3B5IGF0IG9mZnNldCBwYXN0IGVuZCBvZiBtYnVmICovDQotCWlmICh1bmxp
a2VseShvZmYgPj0gbS0+cGt0X2xlbikpDQorCWlmICh1bmxpa2VseShvZmYgPiBtLT5wa3RfbGVu
KSkNCiAJCXJldHVybiBOVUxMOw0KIA0KIAltYyA9IHJ0ZV9wa3RtYnVmX2FsbG9jKG1wKTsNCkBA
IC02ODgsOCArNjg4LDggQEAgcnRlX3BrdG1idWZfY29weShjb25zdCBzdHJ1Y3QgcnRlX21idWYg
Km0sIHN0cnVjdCBydGVfbWVtcG9vbCAqbXAsDQogDQogCV9fcnRlX3BrdG1idWZfY29weV9oZHIo
bWMsIG0pOw0KIA0KLQkvKiBjb3BpZWQgbWJ1ZiBpcyBub3QgaW5kaXJlY3Qgb3IgZXh0ZXJuYWwg
Ki8NCi0JbWMtPm9sX2ZsYWdzID0gbS0+b2xfZmxhZ3MgJiB+KFJURV9NQlVGX0ZfSU5ESVJFQ1R8
UlRFX01CVUZfRl9FWFRFUk5BTCk7DQorCS8qIGNvcHkgZmxhZ3MgZXhjZXB0IGluZGlyZWN0IGFu
ZCBleHRlcm5hbCwgYW5kIHByZXNlcnZlIGZsYWdzIG9mIG5ld2x5IGFsbG9jYXRlZCBtYnVmICov
DQorCW1jLT5vbF9mbGFncyB8PSBtLT5vbF9mbGFncyAmIH4oUlRFX01CVUZfRl9JTkRJUkVDVHxS
VEVfTUJVRl9GX0VYVEVSTkFMKTsNCiANCiAJcHJldiA9ICZtYy0+bmV4dDsNCiAJbV9sYXN0ID0g
bWM7DQotLSANCjIuNDMuMA0KDQo=
