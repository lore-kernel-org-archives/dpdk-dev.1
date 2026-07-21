Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA7FC44529
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Jul 2026 10:37:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E28D3402A7;
	Tue, 21 Jul 2026 12:37:29 +0200 (CEST)
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
 by mails.dpdk.org (Postfix) with ESMTP id 2685640289;
 Tue, 21 Jul 2026 12:37:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru 084912C0BB8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
 t=1784630247; bh=g0W16JmqEeZ/4GQEnnqrm1xvXymuAXwTGMGo2xzbpqg=;
 h=From:To:CC:Subject:Date:References:In-Reply-To:From;
 b=E7zw/CpDg6T7/gRFUy4kN/N5xS3AdtaUcOMK45wZR/1kJoqJzQW+owRugFCzb7f31
 jlRwMJhZJJoJ6DzCuu0pUew9cN8Xn52ql8p4IROy3i/AhT9q8yTjennEcToPfPfv0H
 rC0HpWlxJXjtdLC/lEmFXbuW/7AHb70Sc8lYXxOw=
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
 by mx0.infotecs.ru (Postfix) with ESMTP id 084912C0BB8;
 Tue, 21 Jul 2026 13:37:27 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs-nt BE5702C09EE
Received: from msk-exch-02.infotecs-nt (msk-exch-02.infotecs-nt [10.0.7.192])
 by mx0.infotecs-nt (Postfix) with ESMTP id BE5702C09EE;
 Tue, 21 Jul 2026 13:37:26 +0300 (MSK)
From: Sokolov Evgeny <Evgeny.Sokolov@infotecs.ru>
To: Thomas Monjalon <thomas@monjalon.net>, Chas Williams <3chas3@gmail.com>,
 "Min Hu (Connor)" <humin29@huawei.com>, Declan Doherty
 <declan.doherty@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>,
 "chas3@att.com" <chas3@att.com>
Subject: RE: [PATCH] net/bonding: fix the log MAC address restore failure
Thread-Topic: [PATCH] net/bonding: fix the log MAC address restore failure
Thread-Index: AQHdB89lQ8ppYHCRQk2soIiCEnNxALZ36cBQ
Date: Tue, 21 Jul 2026 10:37:26 +0000
Message-ID: <41f4362c49a845319e8e2603ec56831c@infotecs.ru>
References: <20260629135841.1181247-1-Evgeny.Sokolov@infotecs.ru>
In-Reply-To: <20260629135841.1181247-1-Evgeny.Sokolov@infotecs.ru>
Accept-Language: ru-RU, en-US
Content-Language: ru-RU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.17.0.1]
x-exclaimer-md-config: 208ac3cd-1ed4-4982-a353-bdefac89ac0a
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: Evgeny.Sokolov@infotecs.ru
X-KSMG-AntiSpam-Info: LuaCore: 113 0.3.113
 b83a27b0bdff87150e3aba5d24ea90b4a220db99,
 {Tracking_from_domain_doesnt_match_to},
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; 127.0.0.199:7.1.2;
 infotecs.ru:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 204607 [Jul 21 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.22
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 3.0.0.9059,
 bases: 2026/07/21 08:43:00 #28477919
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 8
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

S2luZGx5IHJlbWluZGVyDQpTb3JyeSwgQnV0IG5vYm9keSBoYXMgcmV2aWV3ZWQgbXkgcGF0Y2gN
CkNvdWxkIHlvdSBwbGVhc2UgcmV2aWV3IHRoaXM/DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQpGcm9tOiBTb2tvbG92IEV2Z2VueSA8RXZnZW55LlNva29sb3ZAaW5mb3RlY3MucnU+IA0K
U2VudDogTW9uZGF5LCBKdW5lIDI5LCAyMDI2IDQ6NTkgUE0NClRvOiBUaG9tYXMgTW9uamFsb24g
PHRob21hc0Btb25qYWxvbi5uZXQ+OyBDaGFzIFdpbGxpYW1zIDwzY2hhczNAZ21haWwuY29tPjsg
TWluIEh1IChDb25ub3IpIDxodW1pbjI5QGh1YXdlaS5jb20+OyBEZWNsYW4gRG9oZXJ0eSA8ZGVj
bGFuLmRvaGVydHlAaW50ZWwuY29tPg0KQ2M6IGRldkBkcGRrLm9yZzsgc3RhYmxlQGRwZGsub3Jn
OyBjaGFzM0BhdHQuY29tOyBTb2tvbG92IEV2Z2VueSA8RXZnZW55LlNva29sb3ZAaW5mb3RlY3Mu
cnU+DQpTdWJqZWN0OiBbUEFUQ0hdIG5ldC9ib25kaW5nOiBmaXggdGhlIGxvZyBNQUMgYWRkcmVz
cyByZXN0b3JlIGZhaWx1cmUNCg0KTG9nIGFuIGVycm9yIHdoZW4gcnRlX2V0aF9kZXZfZGVmYXVs
dF9tYWNfYWRkcl9zZXQoKSBmYWlscyB3aGlsZSByZXN0b3JpbmcgdGhlIGRlZmF1bHQgTUFDIGFk
ZHJlc3Mgb2YgYSBtZW1iZXIgZGV2aWNlIHJlbW92ZWQgZnJvbSBhIGJvbmRpbmcgZGV2aWNlLg0K
VGhpcyBpbXByb3ZlcyB2aXNpYmlsaXR5IG9mIGZhaWx1cmVzIHdpdGhvdXQgY2hhbmdpbmcgdGhl
IGV4aXN0aW5nIGJlaGF2aW9yLg0KDQpGaXhlczogYWE3NzkxYmE4ZGUwICgibmV0L2JvbmRpbmc6
IGZpeCBzZXR0aW5nIHNsYXZlIE1BQyBhZGRyZXNzZXMiKQ0KQ2M6IGNoYXMzQGF0dC5jb20NCg0K
U2lnbmVkLW9mZi1ieTogRXZnZW55IFNva29sb3YgPEV2Z2VueS5Tb2tvbG92QGluZm90ZWNzLnJ1
Pg0KQ2M6IHN0YWJsZUBkcGRrLm9yZw0KLS0tDQogLm1haWxtYXAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfCAxICsNCiBkcml2ZXJzL25ldC9ib25kaW5nL3J0ZV9ldGhfYm9uZF9hcGku
YyB8IDggKysrKysrLS0NCiAyIGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhLy5tYWlsbWFwIGIvLm1haWxtYXANCmluZGV4IDhlMTE1
M2NlNTguLmRkYmFhZjc0NGYgMTAwNjQ0DQotLS0gYS8ubWFpbG1hcA0KKysrIGIvLm1haWxtYXAN
CkBAIC00NjEsNiArNDYxLDcgQEAgRXZhbiBTd2Fuc29uIDxldmFuLnN3YW5zb25AaW50ZWwuY29t
PiAgRXZnZW55IEVmaW1vdiA8ZXZnZW55LmVmaW1vdkBpbnRlbC5jb20+ICBFdmdlbnkgSW0gPGV2
Z2VueS5pbUBva3RldGxhYnMuY29tPiAgRXZnZW55IFNjaGVtZWlsaW4gPGV2Z2VueXNAYW1hem9u
LmNvbT4NCitFdmdlbnkgU29rb2xvdiA8RXZnZW55LlNva29sb3ZAaW5mb3RlY3MucnU+DQogRmFi
aW8gUHJpY29jbyA8ZmFiaW8ucHJpY29jb0BpbnRlbC5jb20+ICBGYWR5IEJhZGVyIDxmYWR5QG1l
bGxhbm94LmNvbT4gIEZhaWNrZXIgTW8gPGZhaWNrZXIubW9AdWNsb3VkLmNuPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9uZXQvYm9uZGluZy9ydGVfZXRoX2JvbmRfYXBpLmMgYi9kcml2ZXJzL25ldC9i
b25kaW5nL3J0ZV9ldGhfYm9uZF9hcGkuYw0KaW5kZXggOWU1ZGY2N2MxOC4uZGEyYjUzOGIzYyAx
MDA2NDQNCi0tLSBhL2RyaXZlcnMvbmV0L2JvbmRpbmcvcnRlX2V0aF9ib25kX2FwaS5jDQorKysg
Yi9kcml2ZXJzL25ldC9ib25kaW5nL3J0ZV9ldGhfYm9uZF9hcGkuYw0KQEAgLTcwNiw4ICs3MDYs
MTIgQEAgX19ldGhfYm9uZF9tZW1iZXJfcmVtb3ZlX2xvY2tfZnJlZSh1aW50MTZfdCBib25kaW5n
X3BvcnRfaWQsDQogCQkJJnJ0ZV9ldGhfZGV2aWNlc1tib25kaW5nX3BvcnRfaWRdLmRhdGEtPnBv
cnRfaWQpOw0KIA0KIAkvKiBSZXN0b3JlIG9yaWdpbmFsIE1BQyBhZGRyZXNzIG9mIG1lbWJlciBk
ZXZpY2UgKi8NCi0JcnRlX2V0aF9kZXZfZGVmYXVsdF9tYWNfYWRkcl9zZXQobWVtYmVyX3BvcnRf
aWQsDQotCQkJJmludGVybmFscy0+bWVtYmVyc1ttZW1iZXJfaWR4XS5wZXJzaXN0ZWRfbWFjX2Fk
ZHIpOw0KKwlpZiAocnRlX2V0aF9kZXZfZGVmYXVsdF9tYWNfYWRkcl9zZXQobWVtYmVyX3BvcnRf
aWQsDQorCQkJJmludGVybmFscy0+bWVtYmVyc1ttZW1iZXJfaWR4XS5wZXJzaXN0ZWRfbWFjX2Fk
ZHIpKSB7DQorCQlSVEVfQk9ORF9MT0coRVJSLA0KKwkJCQkiRmFpbGVkIHRvIHJlc3RvcmUgTUFD
IGFkZHJlc3Mgb24gbWVtYmVyIHBvcnQgJXUiLA0KKwkJCQltZW1iZXJfcG9ydF9pZCk7DQorCX0N
CiANCiAJLyogcmVtb3ZlIGFkZGl0aW9uYWwgTUFDIGFkZHJlc3NlcyBmcm9tIHRoZSBtZW1iZXIg
Ki8NCiAJbWVtYmVyX3JlbW92ZV9tYWNfYWRkcmVzc2VzKGJvbmRpbmdfZXRoX2RldiwgbWVtYmVy
X3BvcnRfaWQpOw0KLS0NCjIuNDcuMw0KDQo=
