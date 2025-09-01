Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B43CA0FFF
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Sep 2025 14:52:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 02AED402ED;
	Mon,  1 Sep 2025 16:52:52 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id CFA8B402EA
 for <dev@dpdk.org>; Mon,  1 Sep 2025 16:52:49 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id AB4CE2045E;
 Mon,  1 Sep 2025 16:52:49 +0200 (CEST)
Content-class: urn:content-classes:message
Subject: RE: [PATCH v3 4/4] hash: add support for common small key sizes
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Date: Mon, 1 Sep 2025 16:52:48 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FEA7@smartserver.smartshare.dk>
In-Reply-To: <20250826144922.74010-5-stephen@networkplumber.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v3 4/4] hash: add support for common small key sizes
Thread-Index: AdwWmKVgIZKP6ScRQJa36mVY2zmflAEt2TVw
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20250826144922.74010-1-stephen@networkplumber.org>
 <20250826144922.74010-5-stephen@networkplumber.org>
X-MimeOLE: Produced By Microsoft Exchange V6.5
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
b3JnXQ0KPiBTZW50OiBUdWVzZGF5LCAyNiBBdWd1c3QgMjAyNSAxNi40OQ0KPiANCj4gQWRkIG5l
dyBjb21wYXJlIGZ1bmN0aW9ucyBmb3IgY29tbW9uIHNtYWxsIGtleSBzaXplcy4NCj4gDQo+IEJ1
Z3ppbGxhIElEOiAxNzc1DQo+IFN1Z2dlc3RlZC1ieTogTW9ydGVuIEJyw7hydXAgPG1iQHNtYXJ0
c2hhcmVzeXN0ZW1zLmNvbT4NCj4gUmVwb3J0ZWQtYnk6IE1hdHRpYXMgUsO2bm5ibG9tIDxtYXR0
aWFzLnJvbm5ibG9tQGVyaWNzc29uLmNvbT4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFN0ZXBoZW4g
SGVtbWluZ2VyIDxzdGVwaGVuQG5ldHdvcmtwbHVtYmVyLm9yZz4NCj4gLS0tDQoNCkFja2VkLWJ5
OiBNb3J0ZW4gQnLDuHJ1cCA8bWJAc21hcnRzaGFyZXN5c3RlbXMuY29tPg0KDQo=
