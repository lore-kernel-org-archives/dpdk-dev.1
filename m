Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFAD3C55184
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Aug 2026 16:25:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E503340685;
	Tue,  4 Aug 2026 18:25:44 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 8B86B40616
 for <dev@dpdk.org>; Tue,  4 Aug 2026 18:25:43 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 64EBA2051A;
 Tue,  4 Aug 2026 18:25:43 +0200 (CEST)
Content-class: urn:content-classes:message
Subject: RE: [PATCH] eal/x86: optimize memcpy of small 64-byte blocks
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Tue, 4 Aug 2026 18:25:42 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F659B8@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <20260804085210.74763eb5@phoenix.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] eal/x86: optimize memcpy of small 64-byte blocks
Thread-Index: Ad0kKTl/2PoFAwIIT/yPym098RkhYgABI/2g
References: <20260804143305.1344327-1-mb@smartsharesystems.com>
 <20260804085210.74763eb5@phoenix.local>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>
Cc: <dev@dpdk.org>,
	"Bruce Richardson" <bruce.richardson@intel.com>
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
b3JnXQ0KPiBTZW50OiBUdWVzZGF5LCA0IEF1Z3VzdCAyMDI2IDE3LjUyDQo+IA0KPiBPbiBUdWUs
ICA0IEF1ZyAyMDI2IDE0OjMzOjA0ICswMDAwDQo+IE1vcnRlbiBCcsO4cnVwIDxtYkBzbWFydHNo
YXJlc3lzdGVtcy5jb20+IHdyb3RlOg0KPiANCj4gPiArCS8qIENvbW1vbiB3YXkgZm9yIHNtYWxs
IGNvcHkgc2l6ZSBvZiA2NC1ieXRlIGJsb2Nrcy4gVW5saWtlbHksIHNvDQo+IGNvbnN0YW50IHNp
emUgb25seSAqLw0KPiA+ICsJaWYgKF9fcnRlX2NvbnN0YW50KG4pICYmIChuICYgNjMpID09IDAg
JiYgbiA8PQ0KPiBSVEVfTUVNQ1BZX0JMT0NLXzY0X01BWCkgew0KPiA+ICsJCXZvaWQgKnJldCA9
IGRzdDsNCj4gPiArDQo+IA0KPiBNYXliZSBqdXN0IGxldCBjb21waWxlciBkZWNpZGUsIGl0IHdp
bGwgZ2VuZXJhdGUgdmVjdG9yIGluc3RydWN0aW9ucyBpbg0KPiBtb3N0IGNhc2VzLg0KPiANCj4g
CWlmIChfX3J0ZV9jb25zdGFudChuKSkNCj4gCQlyZXR1cm4gbWVtcGNweShkc3QsIHNyYywgbik7
DQoNCk1heWJlIGluIG1vc3QsIGJ1dCBub3QgaW4gYWxsOg0KaHR0cHM6Ly9nb2Rib2x0Lm9yZy96
L0t2ZEtxVDVyWQ0KDQo=
