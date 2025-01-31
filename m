Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EB3C0218D
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 07:54:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 73FB4402DC;
	Fri, 31 Jan 2025 08:54:28 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 951CC4026E
 for <dev@dpdk.org>; Fri, 31 Jan 2025 08:54:27 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 6FB3720783;
 Fri, 31 Jan 2025 08:54:26 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v18 00/26] remove use of VLAs for Windows
Date: Fri, 31 Jan 2025 08:54:24 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FA0C@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <1738274135-2086-1-git-send-email-andremue@linux.microsoft.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v18 00/26] remove use of VLAs for Windows
Thread-Index: AdtzYbjbVCgd1f17R1OTHKRH7V1J4gAUk0TQ
References: <1713397319-26135-1-git-send-email-roretzla@linux.microsoft.com>
 <1738274135-2086-1-git-send-email-andremue@linux.microsoft.com>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Andre Muezerie" <andremue@linux.microsoft.com>, <dev@dpdk.org>,
 <bruce.richardson@intel.com>
Cc: <konstantin.ananyev@huawei.com>, <thomas@monjalon.net>,
 <david.marchand@redhat.com>
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

PiBGcm9tOiBBbmRyZSBNdWV6ZXJpZSBbbWFpbHRvOmFuZHJlbXVlQGxpbnV4Lm1pY3Jvc29mdC5j
b21dDQo+IFNlbnQ6IFRodXJzZGF5LCAzMCBKYW51YXJ5IDIwMjUgMjIuNTUNCj4gDQo+IEFzIHBl
ciBndWlkYW5jZSB0ZWNobmljYWwgYm9hcmQgbWVldGluZyAyMDI0LzA0LzE3LiBUaGlzIHNlcmll
cw0KPiByZW1vdmVzIHRoZSB1c2Ugb2YgVkxBcyBmcm9tIGNvZGUgYnVpbHQgZm9yIFdpbmRvd3Mg
Zm9yIGFsbCAzDQo+IHRvb2xjaGFpbnMuIElmIHRoZXJlIGFyZSBhZGRpdGlvbmFsIG9wcG9ydHVu
aXRpZXMgdG8gY29udmVydCBWTEFzDQo+IHRvIHJlZ3VsYXIgQyBhcnJheXMgcGxlYXNlIHByb3Zp
ZGUgdGhlIGRldGFpbHMgZm9yIGluY29ycG9yYXRpb24NCj4gaW50byB0aGUgc2VyaWVzLg0KPiAN
Cj4gTVNWQyBkb2VzIG5vdCBzdXBwb3J0IFZMQXMsIHJlcGxhY2UgVkxBcyB3aXRoIHN0YW5kYXJk
IEMgYXJyYXlzDQo+IG9yIGFsbG9jYSgpLiBhbGxvY2EoKSBpcyBhdmFpbGFibGUgZm9yIGFsbCB0
b29sY2hhaW4vcGxhdGZvcm0NCj4gY29tYmluYXRpb25zIG9mZmljaWFsbHkgc3VwcG9ydGVkIGJ5
IERQREsuDQo+IA0KPiB2MTg6DQo+ICAqIGFkZCBub192bGFfY2ZsYWcgdG8gZXhhbXBsZXMgZGly
ZWN0b3JpZXMgdGhhdCBhcmUgbm90IFZMQS1mcmVlDQo+ICAqIGFkZCBub192bGFfY2ZsYWcgdG8g
ZHJpdmVycyBkaXJlY3RvcmllcyB0aGF0IGFyZSBub3QgVkxBLWZyZWUgYW5kDQo+ICAgIHdlcmUg
bWlzc2VkIGluIHYxNyBkdWUgdG8gbWlzc2luZyBsaWJzDQo+IA0KPiB2MTc6DQo+ICAqIGRlZmlu
ZSBub192bGFfY2ZsYWcgaW4gYSB0b3AgZGlyZWN0b3J5IChjb25maWcpDQo+ICAqIGFkZCBub192
bGFfY2ZsYWcgdG8gZGlyZWN0b3JpZXMgdGhhdCBhcmUgbm90IFZMQS1mcmVlDQo+ICAqIGFkZCAt
V3ZsYSBwcm9qZWN0LXdpZGUgKFZMQXMgbm90IGFsbG93ZWQgYnkgZGVmYXVsdCwgZXhjZXB0IGZv
cg0KPiAgICBkaXJlY3RvcmllcyB1c2luZyBub192bGFfY2ZsYWcpDQoNCm5pdDoNClRoZSBuYW1l
IG5vX3ZsYV9jZmxhZyBpcyBpbnZlcnRlZC4gSXQgc2hvdWxkIGJlIGUuZy4gbm9fd3ZsYV9jZmxh
ZyBvciBhbGxvd192bGFfY2ZsYWcuIEFsdGhvdWdoIHRoZSBsYXR0ZXIgbGFja3MgaW5kaWNhdGlv
biB0aGF0IGl0IGlzIGFuIGV4Y2VwdGlvbiwgaXQgY291bGQgYmUgbWVudGlvbmVkIGluIGEgY29t
bWVudCB3aGVyZSBpdCBpcyBkZWZpbmVkLiBNYXliZSBub193dmxhX2NmbGFnIGlzIGJldHRlci4N
Cg0K
