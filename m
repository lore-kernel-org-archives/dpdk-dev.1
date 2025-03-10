Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C50C282DE
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Mar 2025 09:35:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D9FB4021F;
	Mon, 10 Mar 2025 10:35:10 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 3E39840151
 for <dev@dpdk.org>; Mon, 10 Mar 2025 10:35:09 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id DD981206C7;
 Mon, 10 Mar 2025 10:35:08 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH] dma\ae4dma: added AMD user space DMA driver
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Mon, 10 Mar 2025 10:35:08 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FAD0@smartserver.smartshare.dk>
In-Reply-To: <20250309084526.972512-1-bhagyada.modali@amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] dma\ae4dma: added AMD user space DMA driver
Thread-Index: AduQz7CB1BeJrGmDS/O2Zlg5w/sFwAAznJdw
References: <20250309084526.972512-1-bhagyada.modali@amd.com>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Bhagyada Modali" <bhagyada.modali@amd.com>, <dev@dpdk.org>,
 ": Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>
Cc: <ssebasti@amd.com>, <rningoji@amd.com>,
 "Chengwen Feng" <fengchengwen@huawei.com>
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

PiAtLS0gYS9saWIvbWVtcG9vbC9ydGVfbWVtcG9vbC5oDQo+ICsrKyBiL2xpYi9tZW1wb29sL3J0
ZV9tZW1wb29sLmgNCj4gQEAgLTEzNiw3ICsxMzYsNyBAQCBzdHJ1Y3QgcnRlX21lbXBvb2xfb2Jq
c3ogew0KPiAgLyoqDQo+ICAgKiBBbGlnbm1lbnQgb2YgZWxlbWVudHMgaW5zaWRlIG1lbXBvb2wu
DQo+ICAgKi8NCj4gLSNkZWZpbmUgUlRFX01FTVBPT0xfQUxJR04JUlRFX0NBQ0hFX0xJTkVfU0la
RQ0KPiArI2RlZmluZSBSVEVfTUVNUE9PTF9BTElHTgk0MDk2DQoNCk5BSyENClRoaXMgd291bGQg
bmVhcmx5IGRvdWJsZSB0aGUgbWVtb3J5IGZvb3RwcmludCBvZiBvcmRpbmFyeSBtYnVmIHBvb2xz
ICh3aXRoIG9iamVjdCBzaXplIDIwNDgpLg0KQW5kIHRoZSBtZW1vcnkgZm9vdHByaW50IG9mIG1l
bXBvb2xzIGNvbnRhaW5pbmcgc21hbGwgb2JqZWN0cyB3b3VsZCBleHBsb2RlLg0KDQo+ICAjZW5k
aWYNCj4gDQo+ICAjZGVmaW5lIFJURV9NRU1QT09MX0FMSUdOX01BU0sJKFJURV9NRU1QT09MX0FM
SUdOIC0gMSkNCg0KDQo=
