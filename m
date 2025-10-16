Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9791ACCD194
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 09:04:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B25040DD1;
	Thu, 16 Oct 2025 11:04:40 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 18A1940DD1
 for <dev@dpdk.org>; Thu, 16 Oct 2025 11:04:39 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id ED8E6206E3;
 Thu, 16 Oct 2025 11:04:37 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v6 3/7] mbuf: record mbuf operations history
Date: Thu, 16 Oct 2025 11:04:34 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F654D0@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <20251014124046.1032293-4-thomas@monjalon.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v6 3/7] mbuf: record mbuf operations history
Thread-Index: Adw9B84obcgmQKReQLO9ut5rgkxb0QBbqj1g
References: <20250616072910.113042-1-shperetz@nvidia.com>
 <20251014124046.1032293-1-thomas@monjalon.net>
 <20251014124046.1032293-4-thomas@monjalon.net>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Thomas Monjalon" <thomas@monjalon.net>,
	<dev@dpdk.org>
Cc: <shperetz@nvidia.com>, <viacheslavo@nvidia.com>,
 <bruce.richardson@intel.com>, <stephen@networkplumber.org>
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

PiArCS8qIENhbGN1bGF0ZSB0b3RhbCBhbGxvY2F0ZWQgbWJ1ZnMgKi8NCj4gKwl1aW50NjRfdCB0
b3RhbF9hbGxvY2F0ZWQgPQ0KPiArCQlzdGF0c1tSVEVfTUJVRl9ISVNUT1JZX09QX0xJQl9BTExP
Q10gKw0KPiArCQlzdGF0c1tSVEVfTUJVRl9ISVNUT1JZX09QX1BNRF9BTExPQ10gKw0KPiArCQlz
dGF0c1tSVEVfTUJVRl9ISVNUT1JZX09QX0FQUF9BTExPQ10gKw0KPiArCQlzdGF0c1tSVEVfTUJV
Rl9ISVNUT1JZX09QX1JYXSArDQo+ICsJCXN0YXRzW1JURV9NQlVGX0hJU1RPUllfT1BfVFhdICsN
Cj4gKwkJc3RhdHNbUlRFX01CVUZfSElTVE9SWV9PUF9UWF9QUkVQXSArDQo+ICsJCXN0YXRzW1JU
RV9NQlVGX0hJU1RPUllfT1BfVFhfQlVTWV0gKw0KPiArCQlzdGF0c1tSVEVfTUJVRl9ISVNUT1JZ
X09QX0VOUVVFVUVdICsNCj4gKwkJc3RhdHNbUlRFX01CVUZfSElTVE9SWV9PUF9ERVFVRVVFXTsN
Cg0KQXNzdW1pbmcgdGhlIHB1cnBvc2Ugb2YgdG90YWxfYWxsb2NhdGVkIGlzIHRvIGNvdW50IHRo
ZSBtYnVmcyBub3Qgc2l0dGluZyBhdmFpbGFibGUgaW4gdGhlIG1lbXBvb2wsIGl0J3Mgbm90IGNh
bGN1bGF0ZWQgY29ycmVjdGx5LiBFLmcuIFVTUjEgYW5kIFVTUjIgYXJlIG1pc3NpbmcuDQoNCklu
c3RlYWQgb2Ygc3VtbWluZyBzb21lIHNwZWNpZmljIHN0YXRlcywganVzdCBzdW0gYWxsIHN0YXRl
cyAoZm9yIG9wPTA7IG9wPE9QX01BWDsgb3ArKykgYW5kIHN1YnRyYWN0IE9QX05FVkVSIGFuZCBP
UF9MSUJfRlJFRS4NCg0K
