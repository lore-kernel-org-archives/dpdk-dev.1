Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0DBCAC5B8
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Sep 2025 19:55:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 376614064A;
	Fri, 26 Sep 2025 21:55:29 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id B36A440277;
 Fri, 26 Sep 2025 21:55:27 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 7AB3F202CC;
 Fri, 26 Sep 2025 21:55:27 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v5 6/9] eal/arm: fix C++ build for 32-bit memcpy
Date: Fri, 26 Sep 2025 21:55:27 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F6547C@smartserver.smartshare.dk>
In-Reply-To: <20250926124103.750844-7-david.marchand@redhat.com>
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v5 6/9] eal/arm: fix C++ build for 32-bit memcpy
Thread-Index: Adwu4vejNYoBXGJqTnS4Bl+FWmXNSwAPHpQQ
References: <20241127112617.1331125-1-david.marchand@redhat.com>
 <20250926124103.750844-1-david.marchand@redhat.com>
 <20250926124103.750844-7-david.marchand@redhat.com>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "David Marchand" <david.marchand@redhat.com>,
	<dev@dpdk.org>
Cc: <bruce.richardson@intel.com>, <stable@dpdk.org>,
 "Wathsala Vithanage" <wathsala.vithanage@arm.com>,
 =?UTF-8?B?TWF0dGlhcyBSw7ZubmJsb20=?= <mattias.ronnblom@ericsson.com>
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

PiBGcm9tOiBEYXZpZCBNYXJjaGFuZCBbbWFpbHRvOmRhdmlkLm1hcmNoYW5kQHJlZGhhdC5jb21d
DQo+IFNlbnQ6IEZyaWRheSwgMjYgU2VwdGVtYmVyIDIwMjUgMTQuNDENCj4gDQo+IFRoaXMgd2Fz
IGNhdWdodCB3aGlsZSBjaGVja2luZyBBUk0gYXJjaCBoZWFkZXJzLg0KPiANCj4gSW4gZmlsZSBp
bmNsdWRlZCBmcm9tIGJ1aWxkdG9vbHMvY2hraW5jcy9jaGtpbmNzLQ0KPiBjcHAucC9ydGVfbWVt
Y3B5XzMyLmNwcDoxOg0KPiAvaG9tZS9ydW5uZXIvd29yay9kcGRrL2RwZGsvbGliL2VhbC9hcm0v
aW5jbHVkZS9ydGVfbWVtY3B5XzMyLmg6MzAyOjE6DQo+IAllcnJvcjogZXhwZWN0ZWQgZGVjbGFy
YXRpb24gYmVmb3JlIOKAmH3igJkgdG9rZW4NCj4gICAzMDIgfCB9DQo+ICAgICAgIHwgXg0KPiAN
Cj4gRml4ZXM6IDcxOTgzNGE2ODQ5ZSAoInVzZSBDIGxpbmthZ2Ugd2hlcmUgYXBwcm9wcmlhdGUg
aW4gaGVhZGVycyIpDQo+IENjOiBzdGFibGVAZHBkay5vcmcNCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IERhdmlkIE1hcmNoYW5kIDxkYXZpZC5tYXJjaGFuZEByZWRoYXQuY29tPg0KPiAtLS0NCg0KQWNr
ZWQtYnk6IE1vcnRlbiBCcsO4cnVwIDxtYkBzbWFydHNoYXJlc3lzdGVtcy5jb20+DQoNCg==
