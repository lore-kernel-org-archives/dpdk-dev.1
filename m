Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4ACC43458
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Jul 2026 20:08:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B2FE40289;
	Tue, 14 Jul 2026 22:08:33 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 8528E4026E
 for <dev@dpdk.org>; Tue, 14 Jul 2026 22:08:32 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 4377A2033E;
 Tue, 14 Jul 2026 22:08:32 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: mempool cache change
Date: Tue, 14 Jul 2026 22:08:30 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F6596D@smartserver.smartshare.dk>
In-Reply-To: <b54ad1f1692a0274da705d446972efd1@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: mempool cache change
Thread-Index: Ad0Tr9aWQsKEwKP8T8yAs2PIc5sPaQAG8h3g
X-MimeOLE: Produced By Microsoft Exchange V6.5
References: <b54ad1f1692a0274da705d446972efd1@mail.gmail.com>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Kishore Padmanabha" <kishore.padmanabha@broadcom.com>,
 "Thomas Monjalon" <thomas@monjalon.net>
Cc: <dev@dpdk.org>,
	"Wisam Jaddo" <wisamm@nvidia.com>
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

SGkgS2lzaG9yZSwNCg0KRm9yIHlvdXIgdGVzdGluZyBwdXJwb3NlcywgcGxlYXNlIGZvbGxvdyB0
aGUgZ3VpZGFuY2UgcHJvdmlkZWQgdG8gV2lzYW0gSmFkZG86DQpodHRwczovL2luYm94LmRwZGsu
b3JnL2Rldi85OENCRDgwNDc0RkE4QjQ0QkY4NTVERjMyQzQ3REMzNUY2NTk2NEBzbWFydHNlcnZl
ci5zbWFydHNoYXJlLmRrLw0KDQpUaGFuayB5b3UgZm9yIHRlc3RpbmchDQoNClZlbmxpZyBoaWxz
ZW4gLyBLaW5kIHJlZ2FyZHMsDQotTW9ydGVuIEJyw7hydXANCg0KRnJvbTogS2lzaG9yZSBQYWRt
YW5hYmhhIFttYWlsdG86a2lzaG9yZS5wYWRtYW5hYmhhQGJyb2FkY29tLmNvbV0gDQpTZW50OiBU
dWVzZGF5LCAxNCBKdWx5IDIwMjYgMTguNDkNClRvOiBUaG9tYXMgTW9uamFsb247IE1vcnRlbiBC
csO4cnVwDQpDYzogZGV2QGRwZGsub3JnDQpTdWJqZWN0OiBtZW1wb29sIGNhY2hlIGNoYW5nZQ0K
DQpIaSBUaG9tYXMsDQrCoA0KVGhlIHJlY2VudCBjaGFuZ2UgZG9uZSBhcyBwYXJ0IG9mIEJVRyBJ
RDogMTAyNywgd2l0aCBjb21taXQgaWTCoCBodHRwczovL2dpdC5kcGRrLm9yZy9kcGRrL2NvbW1p
dC8/aWQ9ZjVlMTMxMGYxNmUwOTA5ZTdlN2Y3MTgwNzEyMzY0NGM2M2IyM2NiYQ0KSXMgY2F1c2lu
ZyBwZXJmb3JtYW5jZSBkcm9wIGZvciB0aGUgYm54dCBOSUMgaW4gMjYuMDcgcmVsZWFzZS4NCsKg
DQpUaGUgc21hbGxlciwgc2hhbGxvd2VyIGNhY2hlIGluY3JlYXNlcyB0aGUgbWlzcyByYXRlLCBj
YXVzaW5nIHJlZmlsbHMgdG8gaGl0IHRoZSBzaGFyZWQgcmluZyBtb3JlIGZyZXF1ZW50bHkuwqAN
CkluIHRoZSBvbGQgY29kZSwgdGhlIGNhY2hlIG9ubHkgdG91Y2hlZCB0aGUgc2hhcmVkIHJpbmcg
d2hlbiBpdCBjbGltYmVkIHBhc3QgNzY4IGluc3RlYWQgb2YgNTEyLiBUaGF0IGV4dHJhIDI1NiBl
bGVtZW50cyBvZiBoZWFkcm9vbSBhbGxvd2VkIHNpZ25pZmljYW50bHkgbW9yZSBmcmVlcyB0byBy
ZW1haW4gbG9jYWwuDQrCoA0KQ291bGQgd2UgbWFrZSB0aGUgY2hhbmdlIGluIGNvbmZpZy9ydGVf
Y29uZmlnLmggZm9yIFJURV9NRU1QT09MX0NBQ0hFX01BWF9TSVpFIHRvIGJlIDc2OCBpbnN0ZWFk
IG9mIDUxMi4gU2luY2Ugd2UgdXNlIOKAk21iY2FjaGU9NTEyIGFzIGFyZ3VtZW50IGZvciB0aGUg
cGVyZm9ybWFuY2UgdGVzdHMuDQrCoA0KVGhhbmtzLA0KS2lzaG9yZQ0KwqANCsKgDQo=
