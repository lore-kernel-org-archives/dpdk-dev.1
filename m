Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED7CCCF9E3
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 11:45:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E9ABB40615;
	Tue,  4 Nov 2025 12:45:58 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 1621540285
 for <dev@dpdk.org>; Tue,  4 Nov 2025 12:45:57 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 101722085B;
 Tue,  4 Nov 2025 12:45:56 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v2] mbuf: dump Tx offload metadata
Date: Tue, 4 Nov 2025 12:45:53 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F6552D@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <20251104100214.1818660-1-david.marchand@redhat.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v2] mbuf: dump Tx offload metadata
Thread-Index: AdxNciArfUoULMbrTyerijN7xaaClQADmciw
References: <20251031131159.1199221-1-david.marchand@redhat.com>
 <20251104100214.1818660-1-david.marchand@redhat.com>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "David Marchand" <david.marchand@redhat.com>,
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

PiBGcm9tOiBEYXZpZCBNYXJjaGFuZCBbbWFpbHRvOmRhdmlkLm1hcmNoYW5kQHJlZGhhdC5jb21d
DQo+IFNlbnQ6IFR1ZXNkYXksIDQgTm92ZW1iZXIgMjAyNSAxMS4wMg0KPiANCj4gV2hlbiBkZWJ1
Z2dpbmcgVFNPIGFuZCBvdGhlciBjaGVja3N1bSBvZmZsb2FkcywgZHVtcGluZyB0aGUgdmFyaW91
cw0KPiBsKl9sZW4gZmllbGRzIGFuZCBUU08gc2VnbWVudGF0aW9uIHNpemUgY2FuIGJlIGhlbHBm
dWwuDQo+IA0KPiBFeGFtcGxlIGluIE9WUyB0aGF0IGR1bXBzIGEgbWJ1ZiBvbiBydGVfZXRoX3R4
X3ByZXBhcmUgZmFpbHVyZToNCj4gDQo+IEJlZm9yZToNCj4gbmV0ZGV2X2RwZGsocG1kLWMzMC9p
ZDoxMSl8REJHfGRwZGswOiBGaXJzdCBpbnZhbGlkIHBhY2tldDoNCj4gZHVtcCBtYnVmIGF0IDB4
MjIwMWE5MTZjMCwgaW92YT0weDIyMDA4MDA1ODAsIGJ1Zl9sZW49Njg2NA0KPiAgIHBrdF9sZW49
NjgwNCwgb2xfZmxhZ3M9MHgzMTE0ODAwMDAwMDAwMTAyLCBuYl9zZWdzPTEsIHBvcnQ9NjU1MzUs
DQo+IHB0eXBlPTANCj4gICBzZWdtZW50IGF0IDB4MjIwMWE5MTZjMCwgZGF0YT0weDIyMDA4MDA1
YjIsIGxlbj02ODA0LCBvZmY9NTAsDQo+IHJlZmNudD0xDQo+ICAgRHVtcCBkYXRhIGF0IFsweDIy
MDA4MDA1YjJdLCBsZW49NjgwNA0KPiAuLi4NCj4gDQo+IEFmdGVyOg0KPiBuZXRkZXZfZHBkayhw
bWQtYzMwL2lkOjExKXxEQkd8ZHBkazA6IEZpcnN0IGludmFsaWQgcGFja2V0Og0KPiBkdW1wIG1i
dWYgYXQgMHgyMjAxYTkxNmMwLCBpb3ZhPTB4MjIwMDgwMDU4MCwgYnVmX2xlbj02ODY0LA0KPiBw
a3RfbGVuPTY4MDQNCj4gICBvdXRlcl9sMl9sZW49MTQsIG91dGVyX2wzX2xlbj00MCwgbDJfbGVu
PTM4LCBsM19sZW49NDAsIGw0X2xlbj0zMg0KPiAgIG9sX2ZsYWdzPTB4MzExNDgwMDAwMDAwMDEw
MiwgbmJfc2Vncz0xLCBwb3J0PTY1NTM1LCBwdHlwZT0wDQo+ICAgc2VnbWVudCBhdCAweDIyMDFh
OTE2YzAsIGRhdGE9MHgyMjAwODAwNWIyLCBsZW49NjgwNCwgb2ZmPTUwLA0KPiByZWZjbnQ9MQ0K
PiAgIER1bXAgZGF0YSBhdCBbMHgyMjAwODAwNWIyXSwgbGVuPTY4MDQNCj4gLi4uDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBEYXZpZCBNYXJjaGFuZCA8ZGF2aWQubWFyY2hhbmRAcmVkaGF0LmNvbT4N
Cj4gLS0tDQoNClJldmlld2VkLWJ5OiBNb3J0ZW4gQnLDuHJ1cCA8bWJAc21hcnRzaGFyZXN5c3Rl
bXMuY29tPg0KDQo=
