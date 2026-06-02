Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16927CD6E4A
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Jun 2026 06:46:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4DC00402C4;
	Tue,  2 Jun 2026 08:46:03 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id A665940150
 for <dev@dpdk.org>; Tue,  2 Jun 2026 08:46:01 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 818C1208EE
 for <dev@dpdk.org>; Tue,  2 Jun 2026 08:46:01 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v7] net/idpf: update for new mempool cache algorithm
Date: Tue, 2 Jun 2026 08:45:59 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F658D0@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <20260601183621.252920-1-mb@smartsharesystems.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v7] net/idpf: update for new mempool cache algorithm
Thread-Index: Adzx9YyJ47I4YFZzSaK4QgRcJeFqWgAZZa9A
References: <20260408141315.904381-1-mb@smartsharesystems.com>
 <20260601183621.252920-1-mb@smartsharesystems.com>
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

UmVjaGVjay1yZXF1ZXN0OiBpb2wtdW5pdC1hcm02NC10ZXN0aW5nDQoNCkNJIHN1YnN5c3RlbSBs
b2c6DQoNClsxNzYvNDA3XSBDb21waWxpbmcgQyBvYmplY3QgbGliL2xpYnJ0ZV9jbWRsaW5lLmEu
cC9jbWRsaW5lX2NtZGxpbmUuYy5vDQpGQUlMRUQ6IGxpYi9saWJydGVfY21kbGluZS5hLnAvY21k
bGluZV9jbWRsaW5lLmMubw0KZ2NjLTEwIC1JbGliL2xpYnJ0ZV9jbWRsaW5lLmEucCAtSWxpYiAt
SS4uL2xpYiAtSWxpYi9jbWRsaW5lIC1JLi4vbGliL2NtZGxpbmUgLUlsaWIvZWFsL2NvbW1vbiAt
SS4uL2xpYi9lYWwvY29tbW9uIC1JLiAtSS4uIC1JY29uZmlnIC1JLi4vY29uZmlnIC1JbGliL2Vh
bC9pbmNsdWRlIC1JLi4vbGliL2VhbC9pbmNsdWRlIC1JbGliL2VhbC9saW51eC9pbmNsdWRlIC1J
Li4vbGliL2VhbC9saW51eC9pbmNsdWRlIC1JbGliL2VhbC9hcm0vaW5jbHVkZSAtSS4uL2xpYi9l
YWwvYXJtL2luY2x1ZGUgLUkuLi9rZXJuZWwvbGludXggLUlsaWIvZWFsIC1JLi4vbGliL2VhbCAt
SWxpYi9rdmFyZ3MgLUkuLi9saWIva3ZhcmdzIC1JbGliL2xvZyAtSS4uL2xpYi9sb2cgLUkuLi9s
aWIvbWV0cmljcyAtSWxpYi90ZWxlbWV0cnkgLUkuLi9saWIvdGVsZW1ldHJ5IC1JbGliL2FyZ3Bh
cnNlIC1JLi4vbGliL2FyZ3BhcnNlIC1JbGliL25ldCAtSS4uL2xpYi9uZXQgLUlsaWIvbWJ1ZiAt
SS4uL2xpYi9tYnVmIC1JbGliL21lbXBvb2wgLUkuLi9saWIvbWVtcG9vbCAtSWxpYi9yaW5nIC1J
Li4vbGliL3JpbmcgLWZkaWFnbm9zdGljcy1jb2xvcj1hbHdheXMgLXBpcGUgLURfRklMRV9PRkZT
RVRfQklUUz02NCAtV2FsbCAtV2ludmFsaWQtcGNoIC1XZXh0cmEgLVdlcnJvciAtc3RkPWMxMSAt
TzMgLWluY2x1ZGUgcnRlX2NvbmZpZy5oIC1XdmxhIC1XY2FzdC1xdWFsIC1XZGVwcmVjYXRlZCAt
V2Zvcm1hdCAtV2Zvcm1hdC1ub25saXRlcmFsIC1XZm9ybWF0LXNlY3VyaXR5IC1XbWlzc2luZy1k
ZWNsYXJhdGlvbnMgLVdtaXNzaW5nLXByb3RvdHlwZXMgLVduZXN0ZWQtZXh0ZXJucyAtV29sZC1z
dHlsZS1kZWZpbml0aW9uIC1XcG9pbnRlci1hcml0aCAtV3NoYWRvdyAtV3NpZ24tY29tcGFyZSAt
V3N0cmljdC1wcm90b3R5cGVzIC1XdW5kZWYgLVd3cml0ZS1zdHJpbmdzIC1Xbm8tcGFja2VkLW5v
dC1hbGlnbmVkIC1Xbm8tbWlzc2luZy1maWVsZC1pbml0aWFsaXplcnMgLURfR04NCiBVX1NPVVJD
RSAtZlBJQyAtbWFyY2g9YXJtdjguMi1hK2NyeXB0bytzdmUgLURBTExPV19FWFBFUklNRU5UQUxf
QVBJIC1EQUxMT1dfSU5URVJOQUxfQVBJIC1EUlRFX0xPR19ERUZBVUxUX0xPR1RZUEU9bGliLmNt
ZGxpbmUgLU1EIC1NUSBsaWIvbGlicnRlX2NtZGxpbmUuYS5wL2NtZGxpbmVfY21kbGluZS5jLm8g
LU1GIGxpYi9saWJydGVfY21kbGluZS5hLnAvY21kbGluZV9jbWRsaW5lLmMuby5kIC1vIGxpYi9s
aWJydGVfY21kbGluZS5hLnAvY21kbGluZV9jbWRsaW5lLmMubyAtYyAuLi9saWIvY21kbGluZS9j
bWRsaW5lLmMNCmdjYy0xMDogaW50ZXJuYWwgY29tcGlsZXIgZXJyb3I6IFNlZ21lbnRhdGlvbiBm
YXVsdCBzaWduYWwgdGVybWluYXRlZCBwcm9ncmFtIGNjMQ0KUGxlYXNlIHN1Ym1pdCBhIGZ1bGwg
YnVnIHJlcG9ydCwNCndpdGggcHJlcHJvY2Vzc2VkIHNvdXJjZSBpZiBhcHByb3ByaWF0ZS4NClNl
ZSA8ZmlsZTovLy91c3Ivc2hhcmUvZG9jL2djYy0xMC9SRUFETUUuQnVncz4gZm9yIGluc3RydWN0
aW9ucy4NCg0K
