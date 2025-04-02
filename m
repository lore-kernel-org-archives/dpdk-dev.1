Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18396C28B20
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Apr 2025 09:08:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 036CE402B5;
	Wed,  2 Apr 2025 11:08:02 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 6905C40275
 for <dev@dpdk.org>; Wed,  2 Apr 2025 11:08:01 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 278BA21791;
 Wed,  2 Apr 2025 11:08:01 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v2 4/4] mempool perf test: test random bulk sizes
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Wed, 2 Apr 2025 11:07:59 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FB8B@smartserver.smartshare.dk>
In-Reply-To: <3fd8b3ab-27e9-4972-850f-60466652e223@oktetlabs.ru>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v2 4/4] mempool perf test: test random bulk sizes
Thread-Index: AduiS//03U2nU+GMS8CpiCcsmyPC+wBYm3rA
References: <20250228164858.274204-1-mb@smartsharesystems.com>
 <20250331100343.213430-1-mb@smartsharesystems.com>
 <20250331100343.213430-5-mb@smartsharesystems.com>
 <3fd8b3ab-27e9-4972-850f-60466652e223@oktetlabs.ru>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>
Cc: "Bruce Richardson" <bruce.richardson@intel.com>,
	<dev@dpdk.org>
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

PiBGcm9tOiBBbmRyZXcgUnliY2hlbmtvIFttYWlsdG86YW5kcmV3LnJ5YmNoZW5rb0Bva3RldGxh
YnMucnVdDQo+IFNlbnQ6IE1vbmRheSwgMzEgTWFyY2ggMjAyNSAxNi40OQ0KPiANCj4gT24gMy8z
MS8yNSAxMzowMywgTW9ydGVuIEJyw7hydXAgd3JvdGU6DQo+ID4gQnVsayByZXF1ZXN0cyB0byBn
ZXQgb3IgcHV0IG9iamVjdHMgaW4gYSBtZW1wb29sIG9mdGVuIHZhcnkgaW4gc2l6ZS4NCj4gPiBB
IHNlcmllcyBvZiB0ZXN0cyB3aXRoIHBzZXVkbyByYW5kb20gcmVxdWVzdCBzaXplcywgdG8gbWl0
aWdhdGUgdGhlDQo+ID4gYmVuZWZpdHMgb2YgdGhlIENQVSdzIGR5bmFtaWMgYnJhbmNoIHByZWRp
Y3Rvciwgd2FzIGFkZGVkLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTW9ydGVuIEJyw7hydXAg
PG1iQHNtYXJ0c2hhcmVzeXN0ZW1zLmNvbT4NCj4gPiBBY2tlZC1ieTogQW5kcmV3IFJ5YmNoZW5r
byA8YW5kcmV3LnJ5YmNoZW5rb0Bva3RldGxhYnMucnU+DQo+IA0KPiBbc25pcF0NCj4gDQo+ID4g
QEAgLTE4MSw5ICsyNDAsOSBAQCBwZXJfbGNvcmVfbWVtcG9vbF90ZXN0KHZvaWQgKmFyZykNCj4g
PiAgIAl9DQo+ID4NCj4gPiAgIAkvKiBuX2dldF9idWxrIGFuZCBuX3B1dF9idWxrIG11c3QgYmUg
ZGl2aXNvcnMgb2Ygbl9rZWVwICovDQo+ID4gLQlpZiAoKChuX2tlZXAgLyBuX2dldF9idWxrKSAq
IG5fZ2V0X2J1bGspICE9IG5fa2VlcCkNCj4gPiArCWlmICghbl9tYXhfYnVsayAmJiAoKChuX2tl
ZXAgLyBuX2dldF9idWxrKSAqIG5fZ2V0X2J1bGspICE9DQo+IG5fa2VlcCkpDQo+IA0KPiBJTUhP
IG5fbWF4X2J1bGsgPT0gMCB3b3VsZCBiZSBlYXNpZXIgdG8gcmVhZCBhbmQgYXMgZmFyIGFzIEkg
cmVtZW1iZXINCj4gRFBESyBjb2Rpbmcgc3R5bGUgcmVjb21tZW5kcyB0aGUgc2FtZSBzdHlsZS4N
Cg0KR29vZCBjYXRjaGVzLiBBbGwgZml4ZWQgaW4gdjMuDQoNClRoYW5rIHlvdSBmb3IgdGhlIGRl
dGFpbGVkIHJldmlldywgQW5kcmV3Lg0KDQo=
