Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6512ACAC5B8
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Oct 2025 14:43:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BA8A540667;
	Mon,  6 Oct 2025 16:43:21 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 6EA32402B1
 for <dev@dpdk.org>; Mon,  6 Oct 2025 16:43:20 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 4AF4E202CC;
 Mon,  6 Oct 2025 16:43:20 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v8 0/3] mbuf: simplify handling of reinitialized mbufs
Date: Mon, 6 Oct 2025 16:43:18 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F654A0@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <20250823063002.24326-1-mb@smartsharesystems.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v8 0/3] mbuf: simplify handling of reinitialized mbufs
Thread-Index: AdwT92A/rH4zFbw9RMO9Ji8ZAalibwi1/BdQ
References: <20250821150250.16959-1-mb@smartsharesystems.com>
 <20250823063002.24326-1-mb@smartsharesystems.com>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: <dev@dpdk.org>, "Thomas Monjalon" <thomas@monjalon.net>,
 "Stephen Hemminger" <stephen@networkplumber.org>,
 "Bruce Richardson" <bruce.richardson@intel.com>,
 "Konstantin Ananyev" <konstantin.ananyev@huawei.com>,
 "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>,
 "Ivan Malov" <ivan.malov@arknetworks.am>,
 "Chengwen Feng" <fengchengwen@huawei.com>
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

UElORyBmb3IgcmV2aWV3IG9mIHRoaXMgc2VyaWVzLg0KDQpWZW5saWcgaGlsc2VuIC8gS2luZCBy
ZWdhcmRzLA0KLU1vcnRlbiBCcsO4cnVwDQoNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPiBGcm9tOiBNb3J0ZW4gQnLDuHJ1cCBbbWFpbHRvOm1iQHNtYXJ0c2hhcmVzeXN0ZW1zLmNv
bV0NCj4gU2VudDogU2F0dXJkYXksIDIzIEF1Z3VzdCAyMDI1IDA4LjMwDQo+IFRvOiBkZXZAZHBk
ay5vcmc7IFRob21hcyBNb25qYWxvbjsgU3RlcGhlbiBIZW1taW5nZXI7IEJydWNlIFJpY2hhcmRz
b247DQo+IEtvbnN0YW50aW4gQW5hbnlldjsgQW5kcmV3IFJ5YmNoZW5rbzsgSXZhbiBNYWxvdjsg
Q2hlbmd3ZW4gRmVuZw0KPiBDYzogTW9ydGVuIEJyw7hydXANCj4gU3ViamVjdDogW1BBVENIIHY4
IDAvM10gbWJ1Zjogc2ltcGxpZnkgaGFuZGxpbmcgb2YgcmVpbml0aWFsaXplZCBtYnVmcw0KPiAN
Cj4gVGhpcyBzZXJpZXMgY29udGFpbnMgdGhyZWUgY2hhbmdlczoNCj4gLSBzYW5pdHkgY2hlY2tp
bmcgYSByZWluaXRpYWxpemVkIG1idWYgKGEuay5hLiByYXcgbWJ1Zikgd2FzIGRlLWlubGluZWQN
Cj4gLSByZWluaXRpYWxpemVkIG1idWYgZnJlZSBhbmQgYWxsb2MgYnVsayBmdW5jdGlvbnMgd2Vy
ZSBwcm9tb3RlZCBhcw0KPiBzdGFibGUNCj4gLSByZXNldHRpbmcgZmllbGRzIG9mIHJlaW5pdGlh
bGl6ZWQgbWJ1ZnMgd2FzIG9wdGltaXplZCwgbWFraW5nIHRoZQ0KPiByZXNldA0KPiAgIG9wZXJh
dGlvbiB3cml0ZS1vbmx5IG9mIHRoZSBtYnVmLCBpbnN0ZWFkIG9mIHJlYWQtbW9kaWZ5LXdyaXRl
DQo+IA0KPiBNb3J0ZW4gQnLDuHJ1cCAoMyk6DQo+ICAgbWJ1ZjogZGUtaW5saW5lIHNhbml0eSBj
aGVja2luZyBhIHJlaW5pdGlhbGl6ZWQgbWJ1Zg0KPiAgIG1idWY6IHByb21vdGUgcmF3IGZyZWUg
YW5kIGFsbG9jIGJ1bGsgZnVuY3Rpb25zIGFzIHN0YWJsZQ0KPiAgIG1idWY6IG9wdGltaXplIHJl
c2V0IG9mIHJlaW5pdGlhbGl6ZWQgbWJ1ZnMNCj4gDQo+ICBsaWIvbWJ1Zi9ydGVfbWJ1Zi5jIHwg
IDYxICsrKysrKysrKysrKysrKw0KPiAgbGliL21idWYvcnRlX21idWYuaCB8IDE3NiArKysrKysr
KysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgMiBmaWxlcyBjaGFuZ2Vk
LCAxNjIgaW5zZXJ0aW9ucygrKSwgNzUgZGVsZXRpb25zKC0pDQo+IA0KPiAtLQ0KPiAyLjQzLjAN
Cg0K
