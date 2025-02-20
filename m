Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BB5C021B1
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 10:31:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1E2354014F;
	Thu, 20 Feb 2025 11:31:47 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id EC69D40041
 for <dev@dpdk.org>; Thu, 20 Feb 2025 11:31:44 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id C483C20A76;
 Thu, 20 Feb 2025 11:31:43 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH] bus: invoke TAILQ_REMOVE when bus cleanup
Date: Thu, 20 Feb 2025 11:31:43 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FA56@smartserver.smartshare.dk>
In-Reply-To: <20250220080906.49705-1-fengchengwen@huawei.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] bus: invoke TAILQ_REMOVE when bus cleanup
Thread-Index: AduDbrr3xkLgxV+2SVC90MegzRoxxwAE8XBA
References: <20250220080906.49705-1-fengchengwen@huawei.com>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Chengwen Feng" <fengchengwen@huawei.com>, <thomas@monjalon.net>,
 "Chenbo Xia" <chenbox@nvidia.com>, "Nipun Gupta" <nipun.gupta@amd.com>,
 "Long Li" <longli@microsoft.com>, "Wei Hu" <weh@microsoft.com>,
 "Kevin Laatz" <kevin.laatz@intel.com>,
 "Bruce Richardson" <bruce.richardson@intel.com>,
 "Huisong Li" <lihuisong@huawei.com>,
 "Zhangfei Gao" <zhangfei.gao@linaro.org>
Cc: <dev@dpdk.org>
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

PiBGcm9tOiBDaGVuZ3dlbiBGZW5nIFttYWlsdG86ZmVuZ2NoZW5nd2VuQGh1YXdlaS5jb21dDQo+
IFNlbnQ6IFRodXJzZGF5LCAyMCBGZWJydWFyeSAyMDI1IDA5LjA5DQo+IA0KPiBBbHRob3VnaCBl
YWxfYnVzX2NsZWFudXAoKSBpcyBub3QgaW52b2tlZCBmb3IgbXVsdGlwbGUgdGltZXMsIHRoaXMg
aXMgYQ0KPiBnb29kIHByb2dyYW1taW5nIGhhYml0IHRvIHJlbW92ZSB0aGUgZGV2aWNlIG9iamVj
dCBmcm9tIGxpc3Qgd2hlbg0KPiBjbGVhbnVwIGJ1cy4NCj4gDQo+IEZpeGVzOiAxY2FiMWE0MGVh
OWIgKCJidXM6IGNsZWFudXAgZGV2aWNlcyBvbiBzaHV0ZG93biIpDQo+IEZpeGVzOiA2MmI5MDZj
ZjA2YmEgKCJidXMvdWFjY2U6IGludHJvZHVjZSBVQUNDRSBidXMiKQ0KPiBGaXhlczogNjU3ODBl
YWRhOWQ5ICgiYnVzL3ZtYnVzOiBzdXBwb3J0IGNsZWFudXAiKQ0KPiBDYzogc3RhYmxlQGRwZGsu
b3JnDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaGVuZ3dlbiBGZW5nIDxmZW5nY2hlbmd3ZW5AaHVh
d2VpLmNvbT4NCj4gLS0tDQoNClRoYW5rIHlvdSBmb3IgY2xlYW5pbmcgdGhpcyB1cC4NCg0KQWNr
ZWQtYnk6IE1vcnRlbiBCcsO4cnVwIDxtYkBzbWFydHNoYXJlc3lzdGVtcy5jb20+DQoNCg==
