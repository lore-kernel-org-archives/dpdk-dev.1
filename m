Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A59ACD6E57
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Jun 2026 06:51:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 89DA3402C4;
	Tue,  2 Jun 2026 08:51:06 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id F2FCD40150
 for <dev@dpdk.org>; Tue,  2 Jun 2026 08:51:04 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id BD5EA208EE
 for <dev@dpdk.org>; Tue,  2 Jun 2026 08:51:04 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v7] mempool/dpaa: update for new mempool cache algorithm
Date: Tue, 2 Jun 2026 08:51:03 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F658D1@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <20260601183621.252920-2-mb@smartsharesystems.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v7] mempool/dpaa: update for new mempool cache algorithm
Thread-Index: Adzx9YyBW7/aBoedTt6J1tbv6hNShAAZkc0Q
References: <20260408141315.904381-1-mb@smartsharesystems.com>
 <20260601183621.252920-1-mb@smartsharesystems.com>
 <20260601183621.252920-2-mb@smartsharesystems.com>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: <dev@dpdk.org>
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

UmVjaGVjay1yZXF1ZXN0OiBpb2wtdW5pdC1hcm02NC10ZXN0aW5nDQoNCkNJIGxvZzoNCj09PT0g
VW5pdCB0ZXN0IHN1bW1hcnkgZm9yIFJlZCBIYXQgRW50ZXJwcmlzZSBMaW51eCA5LjcgKGRwZGtf
dW5pdF90ZXN0KTogPT09PQ0KWy4uLl0NCjUzLzE0NSBEUERLOmZhc3QtdGVzdHMgLyBlYWxfZmxh
Z3NfZmlsZV9wcmVmaXhfYXV0b3Rlc3QgICAgICAgICAgIEZBSUwgICAgICAgICAgICAgMC44OHMg
ICAoZXhpdCBzdGF0dXMgMjU1IG9yIHNpZ25hbCAxMjcgU0lHaW52YWxpZCkNCj4+PiBEUERLX1RF
U1Q9ZWFsX2ZsYWdzX2ZpbGVfcHJlZml4X2F1dG90ZXN0IE1BTExPQ19QRVJUVVJCXz0xOTIgL2hv
bWUtbG9jYWwvamVua2lucy1sb2NhbC9qZW5raW5zLWFnZW50L3dvcmtzcGFjZS9HZW5lcmljLVVu
aXQtVGVzdC1EUERLL2RwZGsvYnVpbGQvYXBwL2RwZGstdGVzdCAtLWZpbGUtcHJlZml4PWVhbF9m
bGFnc19maWxlX3ByZWZpeF9hdXRvdGVzdA0KWy4uLl0NCkVycm9yIChsaW5lIDE0MDcpIC0gZmFp
bGVkIHRvIHJ1biB3aXRoIC0tZmlsZS1wcmVmaXg9bWVtdGVzdDENClRlc3QgRmFpbGVkDQoNCg==
