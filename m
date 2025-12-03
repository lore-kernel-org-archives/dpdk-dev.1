Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD83D12D4B
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Dec 2025 11:41:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9C353402BD;
	Wed,  3 Dec 2025 12:41:12 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 1829C402B7
 for <dev@dpdk.org>; Wed,  3 Dec 2025 12:41:11 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id E1F8720B9F;
 Wed,  3 Dec 2025 12:41:10 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v3] net/ice: add MAC anti-spoof option
Date: Wed, 3 Dec 2025 12:41:09 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F655B7@smartserver.smartshare.dk>
In-Reply-To: <20251203104126.75935-1-anurag.mandal@intel.com>
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v3] net/ice: add MAC anti-spoof option
Thread-Index: AdxkQXyY7JrKz0dKR6OXXBUpY4/uYQAB9WXA
References: <20251113105914.34949-1-anurag.mandal@intel.com>
 <20251203104126.75935-1-anurag.mandal@intel.com>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Anurag Mandal" <anurag.mandal@intel.com>,
	<dev@dpdk.org>
Cc: <bruce.richardson@intel.com>,
	<anatoly.burakov@intel.com>
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

PiBAQCAtMTc2MSwxMyArMTc2MywzOSBAQCBpY2Vfc2V0dXBfdnNpKHN0cnVjdCBpY2VfcGYgKnBm
LCBlbnVtDQo+IGljZV92c2lfdHlwZSB0eXBlKQ0KPiAgCQkvKiBTb3VyY2UgUHJ1bmUgKi8NCj4g
IAkJaWYgKGFkLT5kZXZhcmdzLnNvdXJjZV9wcnVuZSAhPSAxKSB7DQo+ICAJCQkvKiBEaXNhYmxl
IHNvdXJjZSBwcnVuZSB0byBzdXBwb3J0IFZSUlANCj4gLQkJCSAqIHdoZW4gc291cmNlLXBydW5l
IGRldmFyZyBpcyBub3Qgc2V0DQo+ICsJCQkgKiB3aGVuIHNvdXJjZS1wcnVuZSBkZXZhcmdzIGlz
IG5vdCBzZXQNCj4gIAkJCSAqLw0KPiAgCQkJdnNpX2N0eC5pbmZvLnN3X2ZsYWdzID0NCj4gIAkJ
CQlJQ0VfQVFfVlNJX1NXX0ZMQUdfTE9DQUxfTEI7DQo+IC0JCQl2c2lfY3R4LmluZm8uc3dfZmxh
Z3MgfD0NCj4gKwkJfSBlbHNlIHsgLyogRW5hYmxlIFNvdXJjZSBQcnVuZSBpbiBSeCAqLw0KPiAr
CQkJdnNpX2N0eC5pbmZvLnN3X2ZsYWdzID0NCj4gIAkJCQlJQ0VfQVFfVlNJX1NXX0ZMQUdfU1JD
X1BSVU5FOw0KPiAgCQl9DQoNClRoaXMgbG9va3MgbGlrZSBhIGJ1ZyBmaXggcmVsYXRlZCB0byBT
b3VyY2UgUHJ1bmU/DQoNCg==
