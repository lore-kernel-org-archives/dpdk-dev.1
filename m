Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B93DC55171
	for <dpdk-dev@archiver.kernel.org>; Sun,  2 Aug 2026 06:39:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A66B40269;
	Sun,  2 Aug 2026 08:39:00 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 75D9E400D6
 for <dev@dpdk.org>; Sun,  2 Aug 2026 08:38:58 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 3FC8F208F4;
 Sun,  2 Aug 2026 08:38:58 +0200 (CEST)
Subject: RE: [RFC PATCH] pile stack and mempool driver (resend)
Date: Sun, 2 Aug 2026 08:38:57 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F659B1@smartserver.smartshare.dk>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
In-Reply-To: <20260801075934.2f69d3a7@phoenix.local>
X-MS-Has-Attach: 
Content-class: urn:content-classes:message
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC PATCH] pile stack and mempool driver (resend)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Thread-Index: Ad0hxmDOgKPr5LmgT4+9ONuqHvRpDQAgqsAQ
References: <20260801065358.981232-1-mb@smartsharesystems.com>
 <20260801075934.2f69d3a7@phoenix.local>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>
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

PiBGcm9tOiBTdGVwaGVuIEhlbW1pbmdlciBbbWFpbHRvOnN0ZXBoZW5AbmV0d29ya3BsdW1iZXIu
b3JnXQ0KPiBTZW50OiBTYXR1cmRheSwgMSBBdWd1c3QgMjAyNiAxNy4wMA0KPiANCj4gT24gU2F0
LCAgMSBBdWcgMjAyNiAwNjo1Mzo1OCArMDAwMA0KPiBNb3J0ZW4gQnLDuHJ1cCA8bWJAc21hcnRz
aGFyZXN5c3RlbXMuY29tPiB3cm90ZToNCj4gDQo+ID4gK19fcnRlX2RpYWdub3N0aWNfcHVzaA0K
PiA+ICsjcHJhZ21hIEdDQyBkaWFnbm9zdGljIGlnbm9yZWQgIi1XYXJyYXktYm91bmRzIg0KPiA+
ICsjcHJhZ21hIEdDQyBkaWFnbm9zdGljIGlnbm9yZWQgIi1Xc3RyaW5nb3Atb3ZlcnJlYWQiDQo+
IA0KPiBVZ2gsIG5vIHBsZWFzZSBkb24ndCBmaWdodCB0aGUgY29tcGlsZXIuDQo+IA0KPiA+ICsJ
aWYgKCEocy0+ZmxhZ3MgJiBSVEVfU1RBQ0tfRl9QSUxFKSkgew0KPiA+ICsJCXJldCA9IHJ0ZV9z
dGFja19wdXNoKHMsIG9ial90YWJsZSwgMiAqIFNUQUNLX1NJWkUpOw0KPiA+ICsJCWlmIChyZXQg
IT0gMCkgew0KPiA+ICsJCQlwcmludGYoIlslcygpOiV1XSBFeGNlc3Mgb2JqZWN0cyBwdXNoIHN1
Y2NlZWRlZFxuIiwNCj4gPiArCQkJICAgICAgIF9fZnVuY19fLCBfX0xJTkVfXyk7DQo+ID4gKwkJ
CWdvdG8gZmFpbF90ZXN0Ow0KPiA+ICsJCX0NCj4gPiAgCX0NCg0KWWVhaC4gSXQncyBhbHNvIGRp
ZmZpY3VsdCB0byBzbmVhayB0aG9zZSBwcmFnbWFzIHRocm91Z2ggdGhlIENJLg0KSSdsbCB0cnkg
dG8gcmV3b3JrIHRoZSB0ZXN0IGNhc2UgaW5zdGVhZCwgc28gdGhlIGNvbXBpbGVyIGNhbm5vdCBz
ZWUgdGhhdCB3ZSdyZSBvdmVyZmxvd2luZyB0aGUgc3RhY2suDQoNCg==
