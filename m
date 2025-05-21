Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACD7C2D0CD
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 05:13:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 936CB40E6E;
	Wed, 21 May 2025 07:13:10 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 107E840E34;
 Wed, 21 May 2025 07:13:09 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id BE0BB202E9;
 Wed, 21 May 2025 07:13:08 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH] eal: fix return value of lcore role
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Wed, 21 May 2025 07:13:05 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FC79@smartserver.smartshare.dk>
In-Reply-To: <20250520201726.7420-1-pbhagavatula@marvell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] eal: fix return value of lcore role
Thread-Index: AdvJxEJCZlExCWqdSQeqiJ58RIByfAASpivg
References: <20250520201726.7420-1-pbhagavatula@marvell.com>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: <pbhagavatula@marvell.com>, <anatoly.burakov@intel.com>,
 <erik.g.carrillo@intel.com>, <jerinj@marvell.com>,
 "Tyler Retzlaff" <roretzla@linux.microsoft.com>
Cc: <dev@dpdk.org>,
	<stable@dpdk.org>
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

PiBGcm9tOiBQYXZhbiBOaWtoaWxlc2ggPHBiaGFnYXZhdHVsYUBtYXJ2ZWxsLmNvbT4NCj4gDQo+
IFVwZGF0ZSBydGVfbGNvcmVfaGFzX3JvbGUoKSB0byByZXR1cm4gZmFsc2UgaW5zdGVhZCBvZiBh
DQo+IG5lZ2F0aXZlIHZhbHVlIGZvciBpbnZhbGlkIGxjb3JlIElEcywgcmVtb3ZpbmcgdGhlIG5l
ZWQNCj4gZm9yIGNhbGxlcnMgdG8gcHJlLXZhbGlkYXRlIHRoZSBJRC4NCj4gDQo+IEZpeGVzOiBi
MGExNTAyYTI3N2MgKCJlYWw6IG1ha2Ugc2VtYW50aWNzIG9mIGxjb3JlIHJvbGUgZnVuY3Rpb24g
bW9yZQ0KPiBpbnR1aXRpdmUiKQ0KPiBDYzogc3RhYmxlQGRwZGsub3JnDQo+IA0KPiBTdWdnZXN0
ZWQtYnk6IE1vcnRlbiBCcsO4cnVwIDxtYkBzbWFydHNoYXJlc3lzdGVtcy5jb20+DQo+IFNpZ25l
ZC1vZmYtYnk6IFBhdmFuIE5pa2hpbGVzaCA8cGJoYWdhdmF0dWxhQG1hcnZlbGwuY29tPg0KPiAt
LS0NCj4gIGxpYi9lYWwvY29tbW9uL2VhbF9jb21tb25fbGNvcmUuYyB8IDIgKy0NCj4gIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2xpYi9lYWwvY29tbW9uL2VhbF9jb21tb25fbGNvcmUuYw0KPiBiL2xpYi9lYWwvY29tbW9u
L2VhbF9jb21tb25fbGNvcmUuYw0KPiBpbmRleCAyOTQyNjcxNzdkLi45ZGQ2YzcyMDU1IDEwMDY0
NA0KPiAtLS0gYS9saWIvZWFsL2NvbW1vbi9lYWxfY29tbW9uX2xjb3JlLmMNCj4gKysrIGIvbGli
L2VhbC9jb21tb24vZWFsX2NvbW1vbl9sY29yZS5jDQo+IEBAIC04Nyw3ICs4Nyw3IEBAIHJ0ZV9s
Y29yZV9oYXNfcm9sZSh1bnNpZ25lZCBpbnQgbGNvcmVfaWQsIGVudW0NCj4gcnRlX2xjb3JlX3Jv
bGVfdCByb2xlKQ0KPiAgCXN0cnVjdCBydGVfY29uZmlnICpjZmcgPSBydGVfZWFsX2dldF9jb25m
aWd1cmF0aW9uKCk7DQo+IA0KPiAgCWlmIChsY29yZV9pZCA+PSBSVEVfTUFYX0xDT1JFKQ0KPiAt
CQlyZXR1cm4gLUVJTlZBTDsNCj4gKwkJcmV0dXJuIDA7DQo+IA0KPiAgCXJldHVybiBjZmctPmxj
b3JlX3JvbGVbbGNvcmVfaWRdID09IHJvbGU7DQo+ICB9DQo+IC0tDQo+IDIuNDMuMA0KDQpSZXZp
ZXdlZC1ieTogTW9ydGVuIEJyw7hydXAgPG1iQHNtYXJ0c2hhcmVzeXN0ZW1zLmNvbT4NCg0K
