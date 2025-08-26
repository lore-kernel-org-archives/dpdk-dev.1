Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2F3CA0EFA
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 Aug 2025 06:58:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5639C4021E;
	Tue, 26 Aug 2025 08:58:07 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 3AD6240156
 for <dev@dpdk.org>; Tue, 26 Aug 2025 08:58:06 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id E57A22071D;
 Tue, 26 Aug 2025 08:58:05 +0200 (CEST)
Subject: RE: [PATCH v2 4/4] hash: add support for common small key sizes
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Date: Tue, 26 Aug 2025 08:58:04 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FE6D@smartserver.smartshare.dk>
Content-class: urn:content-classes:message
In-Reply-To: <20250822182110.27599-5-stephen@networkplumber.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v2 4/4] hash: add support for common small key sizes
X-MimeOLE: Produced By Microsoft Exchange V6.5
Thread-Index: AdwTkZLT6cUnAtKoTXKqWiC1anWstQCxSKvw
References: <20250821203646.133506-1-stephen@networkplumber.org>
 <20250822182110.27599-1-stephen@networkplumber.org>
 <20250822182110.27599-5-stephen@networkplumber.org>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>,
	<dev@dpdk.org>
Cc: =?UTF-8?B?TWF0dGlhcyBSw7ZubmJsb20=?= <mattias.ronnblom@ericsson.com>,
 "Yipeng Wang" <yipeng1.wang@intel.com>,
 "Sameh Gobriel" <sameh.gobriel@intel.com>,
 "Bruce Richardson" <bruce.richardson@intel.com>,
 "Vladimir Medvedkin" <vladimir.medvedkin@intel.com>
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

PiBGcm9tOiBTdGVwaGVuIEhlbW1pbmdlciBbbWFpbHRvOnN0ZXBoZW5AbmV0d29ya3BsdW1iZXIu
b3JnXQ0KPiBTZW50OiBGcmlkYXksIDIyIEF1Z3VzdCAyMDI1IDIwLjIwDQo+IA0KPiBBZGQgbmV3
IGNvbXBhcmUgZnVuY3Rpb25zIGZvciBjb21tb24gc21hbGwga2V5IHNpemVzLg0KPiANCj4gQnVn
emlsbGEgSUQ6IDE3NzUNCj4gU3VnZ2VzdGVkLWJ5OiBNb3J0ZW4gQnLDuHJ1cCA8bWJAc21hcnRz
aGFyZXN5c3RlbXMuY29tPg0KPiBSZXBvcnRlZC1ieTogTWF0dGlhcyBSw7ZubmJsb20gPG1hdHRp
YXMucm9ubmJsb21AZXJpY3Nzb24uY29tPg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU3RlcGhlbiBI
ZW1taW5nZXIgPHN0ZXBoZW5AbmV0d29ya3BsdW1iZXIub3JnPg0KPiAtLS0NCg0KQWNrZWQtYnk6
IE1vcnRlbiBCcsO4cnVwIDxtYkBzbWFydHNoYXJlc3lzdGVtcy5jb20+DQoNCg==
