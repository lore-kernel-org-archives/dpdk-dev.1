Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2E5606A31C
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 15:27:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6F9DF40283;
	Tue, 20 Oct 2026 17:27:06 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 5EF634025A
 for <dev@dpdk.org>; Tue, 20 Oct 2026 17:27:04 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 3914C2033E;
 Tue, 20 Oct 2026 17:27:04 +0200 (CEST)
Content-class: urn:content-classes:message
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH] stack: fix pile GCC memcpy warnings
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Tue, 20 Oct 2026 17:27:02 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65ACE@smartserver.smartshare.dk>
In-Reply-To: <20261020073430.04ce3bb4@phoenix.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] stack: fix pile GCC memcpy warnings
Thread-Index: Ad1goCIfzH7sZ10gRdyZJQ2LtWha4gABl62A
References: <20261020084944.3188987-1-mb@smartsharesystems.com>
 <20261020073430.04ce3bb4@phoenix.local>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>
Cc: <dev@dpdk.org>, "Thomas Monjalon" <thomas@monjalon.net>,
 "Konstantin Ananyev" <konstantin.ananyev@huawei.com>,
 "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>,
 "Bruce Richardson" <bruce.richardson@intel.com>,
 "Ali Alnubani" <alialnu@nvidia.com>
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

PiBGcm9tOiBTdGVwaGVuIEhlbW1pbmdlciA8c3RlcGhlbkBuZXR3b3JrcGx1bWJlci5vcmc+DQo+
IERhdGU6IFR1ZSwgMjAgT2N0IDIwMjYgMDc6MjY6NDIgLTA3MDANCj4gU3ViamVjdDogW1BBVENI
XSBidWlsZDogZGlzYWJsZSBHQ0Mgc3RyaW5nIG9wIHdhcm5pbmdzIHdoZW4gdW5vcHRpbWl6ZWQN
Cj4gDQo+IFdpdGhvdXQgb3B0aW1pemF0aW9uIEdDQydzIC1Xc3RyaW5nb3Atb3ZlcmZsb3cgYW5k
IC1Xc3RyaW5nb3Atb3ZlcnJlYWQNCj4gYXJlIGZsb3ctaW5zZW5zaXRpdmU6IHRoZXkgY2hlY2sg
YSBtZW1jcHkoKSBhZ2FpbnN0IHRoZSBvYmplY3Qgc2l6ZQ0KPiBldmVuIG9uIHBhdGhzIHRoYXQg
YXJlIGRlYWQgZm9yIHRoZSBpbmxpbmVkIGFyZ3VtZW50cy4gVGhpcyBicmVha3MNCj4gZGVidWcg
YnVpbGRzIG9mIGFwcC90ZXN0IHdpdGggLVdlcnJvciBvbiBsaWIvc3RhY2svcnRlX3N0YWNrX3Bp
bGUuaCwNCj4gYW5kIGhhcyByZXF1aXJlZCBsb2NhbCBwcmFnbWEgd29ya2Fyb3VuZHMgZWxzZXdo
ZXJlLg0KPiANCj4gRGlzYWJsZSBib3RoIHdhcm5pbmdzIHdoZW4gb3B0aW1pemF0aW9uIGlzIDAu
IFRoZXkgc3RheSBlbmFibGVkIGZvcg0KPiBvcHRpbWl6ZWQgYnVpbGRzLCB3aGVyZSB0aGUgYW5h
bHlzaXMgaXMgZmxvdy1zZW5zaXRpdmUuDQo+IA0KPiBCdWd6aWxsYSBJRDogMjA2MQ0KPiANCj4g
UmVwb3J0ZWQtYnk6IEFsaSBBbG51YmFuaSA8YWxpYWxudUBudmlkaWEuY29tPg0KPiBTaWduZWQt
b2ZmLWJ5OiBTdGVwaGVuIEhlbW1pbmdlciA8c3RlcGhlbkBuZXR3b3JrcGx1bWJlci5vcmc+DQo+
IC0tLQ0KPiAgY29uZmlnL21lc29uLmJ1aWxkIHwgNiArKysrKysNCj4gIDEgZmlsZSBjaGFuZ2Vk
LCA2IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9jb25maWcvbWVzb24uYnVpbGQg
Yi9jb25maWcvbWVzb24uYnVpbGQNCj4gaW5kZXggNzQ1MDk3ZThhYS4uYWM5MGI5ZDRmYSAxMDA2
NDQNCj4gLS0tIGEvY29uZmlnL21lc29uLmJ1aWxkDQo+ICsrKyBiL2NvbmZpZy9tZXNvbi5idWls
ZA0KPiBAQCAtMzc4LDYgKzM3OCwxMiBAQCBpZiBjYy5oYXNfYXJndW1lbnQoJy1Xbm8tY29tbWEn
KQ0KPiAgICAgIG5vX2NvbW1hX2NmbGFnID0gJy1Xbm8tY29tbWEnDQo+ICBlbmRpZg0KPiANCj4g
KyMgR0NDJ3Mgc3RyaW5nL21lbW9yeSBhY2Nlc3Mgd2FybmluZ3MgYXJlIGZsb3ctaW5zZW5zaXRp
dmUgd2l0aG91dA0KPiArIyBvcHRpbWl6YXRpb24gYW5kIHByb2R1Y2UgZmFsc2UgcG9zaXRpdmVz
IG9uIGRlYWQgcGF0aHMgb2YgaW5saW5lZA0KPiBjb2RlLg0KPiAraWYgZ2V0X29wdGlvbignb3B0
aW1pemF0aW9uJykgPT0gJzAnIGFuZCBjYy5nZXRfaWQoKSA9PSAnZ2NjJw0KPiArICAgIGdsb2Jh
bF9jZmxhZ3MgKz0gWyctV25vLXN0cmluZ29wLW92ZXJmbG93JywgJy1Xbm8tc3RyaW5nb3AtDQo+
IG92ZXJyZWFkJ10NCj4gKytlbmRpZg0KPiArDQo+ICBmb3JlYWNoIGFyZzogZ2xvYmFsX2NmbGFn
cw0KPiAgICAgIGlmIGNjLmhhc19hcmd1bWVudChhcmcpDQo+ICAgICAgICAgIGFkZF9wcm9qZWN0
X2FyZ3VtZW50cyhhcmcsIGxhbmd1YWdlOiAnYycpDQo+IC0tDQo+IDIuNTMuMA0KDQoNCkFsc28g
Jy1XYXJyYXktYm91bmRzJz8NCg0KQ29uc2lkZXIgbWFraW5nIGl0IGEgc2VyaWVzLCBhbmQgYWxz
byByZW1vdmUgZXhpc3Rpbmcgb3ZlcmZsb3cvb3ZlcnJlYWQgcHJhZ21hcyBpbiB0aGUgY29kZSAo
aWYgdmlhYmxlKToNCmxpYi9yaW5nL3J0ZV9yaW5nX2VsZW1fcHZ0LmgNCmxpYi9lYWwvcHBjL2lu
Y2x1ZGUvcnRlX21lbWNweS5oDQoNCldpdGggb3Igd2l0aG91dCBzdWdnZXN0ZWQgY2hhbmdlcywN
CkFja2VkLWJ5OiBNb3J0ZW4gQnLDuHJ1cCA8bWJAc21hcnRzaGFyZXN5c3RlbXMuY29tPg0KDQo=
