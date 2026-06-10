Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CB7CD8CB2
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Jun 2026 11:31:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8153B4065A;
	Wed, 10 Jun 2026 13:31:51 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 7E22240269
 for <dev@dpdk.org>; Wed, 10 Jun 2026 13:31:49 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 5B74A20799
 for <dev@dpdk.org>; Wed, 10 Jun 2026 13:31:49 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v7] net/idpf: update for new mempool cache algorithm
Date: Wed, 10 Jun 2026 13:31:47 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65903@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v7] net/idpf: update for new mempool cache algorithm
Thread-Index: Adzx9YyJ47I4YFZzSaK4QgRcJeFqWgAZZa9AAZxWfmA=
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

UmVjaGVjay1yZXF1ZXN0OiBpb2wtdW5pdC1hcm02NC10ZXN0aW5nDQoNClVucmVsYXRlZCBDSSBm
YWlsdXJlLg0KDQpDSSBsb2c6DQoNCj09PT0gMjAgbGluZSBsb2cgb3V0cHV0IGZvciBVYnVudHUg
MjAuMDQgKGxwbV9hdXRvdGVzdCk6ID09PT0NCls3LzQwN10gQ29tcGlsaW5nIEMgb2JqZWN0IGxp
Yi9saWJydGVfbG9nLmEucC9sb2dfbG9nX2pvdXJuYWwuYy5vDQpbOC80MDddIExpbmtpbmcgc3Rh
dGljIHRhcmdldCBsaWIvbGlicnRlX2xvZy5hDQpbOS80MDddIEdlbmVyYXRpbmcgcnRlX2FyZ3Bh
cnNlX21hcCB3aXRoIGEgY3VzdG9tIGNvbW1hbmQNClsxMC80MDddIENvbXBpbGluZyBDIG9iamVj
dCBsaWIvbGlicnRlX2t2YXJncy5hLnAva3ZhcmdzX3J0ZV9rdmFyZ3MuYy5vDQpbMTEvNDA3XSBM
aW5raW5nIHN0YXRpYyB0YXJnZXQgbGliL2xpYnJ0ZV9rdmFyZ3MuYQ0KWzEyLzQwN10gQ29tcGls
aW5nIEMgb2JqZWN0IGxpYi9saWJydGVfYXJncGFyc2UuYS5wL2FyZ3BhcnNlX3J0ZV9hcmdwYXJz
ZS5jLm8NClsxMy80MDddIEdlbmVyYXRpbmcga3ZhcmdzLnN5bV9jaGsgd2l0aCBhIGN1c3RvbSBj
b21tYW5kICh3cmFwcGVkIGJ5IG1lc29uIHRvIGNhcHR1cmUgb3V0cHV0KQ0KWzE0LzQwN10gTGlu
a2luZyBzdGF0aWMgdGFyZ2V0IGxpYi9saWJydGVfYXJncGFyc2UuYQ0KWzE1LzQwN10gR2VuZXJh
dGluZyBsb2cuc3ltX2NoayB3aXRoIGEgY3VzdG9tIGNvbW1hbmQgKHdyYXBwZWQgYnkgbWVzb24g
dG8gY2FwdHVyZSBvdXRwdXQpDQpbMTYvNDA3XSBMaW5raW5nIHRhcmdldCBsaWIvbGlicnRlX2xv
Zy5zby4yNi4yDQpbMTcvNDA3XSBDb21waWxpbmcgQyBvYmplY3QgbGliL2xpYnJ0ZV90ZWxlbWV0
cnkuYS5wL3RlbGVtZXRyeV90ZWxlbWV0cnlfZGF0YS5jLm8NClsxOC80MDddIENvbXBpbGluZyBD
IG9iamVjdCBsaWIvbGlicnRlX3RlbGVtZXRyeS5hLnAvdGVsZW1ldHJ5X3RlbGVtZXRyeS5jLm8N
ClsxOS80MDddIEdlbmVyYXRpbmcgcnRlX3RlbGVtZXRyeV9tYXAgd2l0aCBhIGN1c3RvbSBjb21t
YW5kDQpGQUlMRUQ6IGxpYi90ZWxlbWV0cnlfZXhwb3J0cy5tYXANCi91c3IvYmluL3B5dGhvbjMg
Li4vYnVpbGR0b29scy9nZW4tdmVyc2lvbi1tYXAucHkgLS1saW5rZXIgZ251IC0tYWJpLXZlcnNp
b24gLi4vQUJJX1ZFUlNJT04gLS1vdXRwdXQgbGliL3RlbGVtZXRyeV9leHBvcnRzLm1hcCAtLXNv
dXJjZSAuLi9saWIvdGVsZW1ldHJ5L3RlbGVtZXRyeS5jIC4uL2xpYi90ZWxlbWV0cnkvdGVsZW1l
dHJ5X2RhdGEuYyAuLi9saWIvdGVsZW1ldHJ5L3RlbGVtZXRyeV9sZWdhY3kuYw0KU2VnbWVudGF0
aW9uIGZhdWx0IChjb3JlIGR1bXBlZCkNCg0K
