Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C7DBCA5FA1
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 04:39:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3AF5240697;
	Tue, 29 Sep 2026 06:39:25 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 0695840276
 for <dev@dpdk.org>; Tue, 29 Sep 2026 06:39:24 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id C086A201FB;
 Tue, 29 Sep 2026 06:39:23 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v2] mbuf: avoid temporary array for bulk free
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Tue, 29 Sep 2026 06:39:21 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65A84@smartserver.smartshare.dk>
In-Reply-To: <20260929002527.7-1-hoangnamtran18122005@gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v2] mbuf: avoid temporary array for bulk free
Thread-Index: Ad1PqQ6Z78FG8ggGQPO0D2VQBXMa5QAItSYg
References: <20260922012856.30090-1-hoangnamtran18122005@gmail.com>
 <20260929002527.7-1-hoangnamtran18122005@gmail.com>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Nam Tran" <hoangnamtran18122005@gmail.com>
Cc: <dev@dpdk.org>,
	<stephen@networkplumber.org>
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

PiB2MjoNCg0KPiAtIENhcCBzYW1lLXBvb2wgcnVucyBhdCA2NCB0byByZXRhaW4gbWVtcG9vbC1j
YWNoZSBiZWhhdmlvci4NCg0KTkFLIQ0KV2h5IHdvdWxkIHlvdSBkbyB0aGF0Pw0KDQo+IC0gTW92
ZSB0aGUgc2FuaXR5IGNoZWNrIGFmdGVyIHRoZSBjaGFpbmVkLXBhY2tldCBmYWxsYmFjayBkZWNp
c2lvbi4NCj4gLSBBZGQgbWl4ZWQgZmxhdC9jaGFpbmVkIGFuZCBpbmRpcmVjdC1tYnVmIHJlZ3Jl
c3Npb24gY2FzZXMuDQo+IC0gUmVtb3ZlIHRoZSBlYXJsaWVyIHRpbWluZyBjbGFpbTsgdGhlIGNh
cHBlZCB2ZXJzaW9uIGhhcyBub3QgeWV0DQo+ICAgYmVlbiBiZW5jaG1hcmtlZCBvbiB4ODYgb3Ig
d2l0aCBhIGNhY2hlZCBtZW1wb29sLg0KPiANCj4gKwkJcnVuX2NvdW50Kys7DQo+ICsJCWlmIChy
dW5fY291bnQgPT0gUlRFX1BLVE1CVUZfRlJFRV9QRU5ESU5HX1NaKSB7DQo+ICsJCQlydGVfbWJ1
Zl9yYXdfZnJlZV9idWxrKHJ1bl9wb29sLA0KPiArCQkJCQkmbWJ1ZnNbcnVuX3N0YXJ0XSwgcnVu
X2NvdW50KTsNCj4gKwkJCXJ1bl9jb3VudCA9IDA7DQo+ICsJCX0NCg0KTkFLIHRvIHRoaXMgcGFy
dC4NCkZsdXNoaW5nIGEgbGFyZ2UgYnVsayBpbiBzbWFsbGVyIGJ1bGtzIG9mIDY0IG1idWZzIGlz
IG5vdCBuZWNlc3NhcnksIGFuZCBtYXkgcmVkdWNlIHBlcmZvcm1hbmNlLg0KDQo=
