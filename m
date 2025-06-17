Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C9E2C71136
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 16:39:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C8C140E38;
	Tue, 17 Jun 2025 18:39:34 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 87142402C5
 for <dev@dpdk.org>; Tue, 17 Jun 2025 18:39:32 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bMCFs0vqMz6HHqk;
 Wed, 18 Jun 2025 00:37:21 +0800 (CST)
Received: from frapeml100004.china.huawei.com (unknown [7.182.85.167])
 by mail.maildlp.com (Postfix) with ESMTPS id A75661402F5;
 Wed, 18 Jun 2025 00:39:31 +0800 (CST)
Received: from frapeml500002.china.huawei.com (7.182.85.205) by
 frapeml100004.china.huawei.com (7.182.85.167) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 17 Jun 2025 18:39:31 +0200
Received: from frapeml500002.china.huawei.com ([7.182.85.205]) by
 frapeml500002.china.huawei.com ([7.182.85.205]) with mapi id 15.01.2507.039;
 Tue, 17 Jun 2025 18:39:31 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Jerin Jacob <jerinjacobk@gmail.com>
CC: Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>, 
 Nithin Dabilpuram <ndabilpuram@marvell.com>, Zhirun Yan
 <yanzhirun_163@163.com>, Pavan Nikhilesh <pbhagavatula@marvell.com>,
 "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH v2 2/2] lib/graph: default-align rte_graph_cluster_stats
Thread-Topic: [PATCH v2 2/2] lib/graph: default-align rte_graph_cluster_stats
Thread-Index: AQHb35qbEhTUzhsGtk2Rms1nqJghJrQHWAeAgAAiR4D//+PJgIAAIfAA
Date: Tue, 17 Jun 2025 16:39:31 +0000
Message-ID: <f09fa980a01443ebaec61ad7fbe5f436@huawei.com>
References: <20250617151339.28794-1-marat.khalili@huawei.com>
 <20250617151339.28794-2-marat.khalili@huawei.com>
 <CALBAE1M2Ux9Kr2GvS7BjNLn8nM_DvjWnkhp2pwdESKq-WJeRiw@mail.gmail.com>
 <df33e20237384492bd1fafbdd2e71c56@huawei.com>
 <CALBAE1Mggs++Wi34uxFU_hp8fOhn9=Nfuy+dAOTU83JucsWTdA@mail.gmail.com>
In-Reply-To: <CALBAE1Mggs++Wi34uxFU_hp8fOhn9=Nfuy+dAOTU83JucsWTdA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.137.63]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKZXJpbiBKYWNvYiA8amVyaW5q
YWNvYmtAZ21haWwuY29tPg0KPiBTZW50OiBUdWVzZGF5IDE3IEp1bmUgMjAyNSAxNjo1MA0KPiAN
Cj4gPiA+ID4gLXN0cnVjdCBfX3J0ZV9jYWNoZV9hbGlnbmVkIHJ0ZV9ncmFwaF9jbHVzdGVyX25v
ZGVfc3RhdHMgew0KPiA+ID4gPiArc3RydWN0IHJ0ZV9ncmFwaF9jbHVzdGVyX25vZGVfc3RhdHMg
ew0KPiA+ID4NCj4gPiA+IFRoaXMgaXMgYSBmYXN0cGF0aCBzdHJ1Y3R1cmUuIE5vIG5lZWQgdG8g
Y2hhbmdlIHRoZSBhbGlnbm1lbnQgaGVyZS4NCj4gPg0KPiA+IHJ0ZV9ncmFwaF9jbHVzdGVyX3N0
YXRzIGluY2x1ZGVzIGl0LCBzbyB1bmZvcnR1bmF0ZWx5IHdvdWxkIHN0YXkgY2FjaGUtDQo+IGFs
aWduZWQgcmVnYXJkbGVzcyBvZiB0aGUgYXR0cmlidXRlcyB1bmxlc3Mgd2UgbWFrZQ0KPiBydGVf
Z3JhcGhfY2x1c3Rlcl9ub2RlX3N0YXRzIGRlZmF1bHQtYWxpZ25lZCBhcyB3ZWxsLiBJZiB5b3Ug
YXJlIHN1cmUgdGhhdA0KPiB3ZSBuZWVkIHRvIGtlZXAgbm9kZSBvbmUgY2FjaGUtYWxpZ25lZCB3
ZSBjYW4gcmV0dXJuIHRvIHJ0ZV9tYWxsb2MNCj4gc29sdXRpb24gKG9yIHBvc2l4X21lbWFsaWdu
LCBidXQgSSB3b3VsZCBwcmVmZXIgbm90IHRvIGhhbmQtY29kZSBhbGlnbmVkDQo+IHJlYWxsb2Mp
Lg0KPiANCj4gSSB0aGluaywgZXhpc3RpbmcgZm9sbG93aW5nIGNvZGUgd2lsbCB0YWtlIGNhcmUg
b2YgdGhpcy4gQXJlIHlvdQ0KPiBzZWVpbmcgdGhlIHNhbml0aXplciBpc3N1ZSBpZiB0aGUgY2hh
bmdlIGlzIG9ubHkgdXBkYXRpbmcNCj4gcnRlX2dyYXBoX2NsdXN0ZXJfc3RhdHMgYWxpZ25tZW50
Pw0KDQpZZXMsIHN0aWxsIHNlZWluZyB0aGUgc2FuaXRpemVyIGlzc3VlLiBBbmQgaWYgZmFpbHMg
ZXZlbiBiZWZvcmUgcmVhY2hpbmcgY2x1c3RlcnMsIG9uIHRoZSBzdHJ1Y3QgcnRlX2dyYXBoX2Ns
dXN0ZXJfc3RhdHMgaXRzZWxmIGJlY2F1c2UgSSBiZWxpZXZlIGFsaWdubWVudCBwcm9wYWdhdGVz
IGZyb20gbWVtYmVycyB0byBlbmNsb3Npbmcgc3RydWN0cy4NCg0KPiAgICAgICAgIC8qIEZvciBh
IGdpdmVuIGNsdXN0ZXIsIG1heCBub2RlcyB3aWxsIGJlIHRoZSBtYXggbnVtYmVyIG9mIGdyYXBo
cyAqLw0KPiAgICAgICAgIGNsdXN0ZXJfbm9kZV9zaXplICs9IGNsdXN0ZXItPm5iX2dyYXBocyAq
IHNpemVvZihzdHJ1Y3QgcnRlX25vZGUgKik7DQo+ICAgICAgICAgY2x1c3Rlcl9ub2RlX3NpemUg
PSBSVEVfQUxJR04oY2x1c3Rlcl9ub2RlX3NpemUsDQo+IFJURV9DQUNIRV9MSU5FX1NJWkUpOw0K
DQpQbGVhc2UgY29ycmVjdCBtZSBpZiBJIGFtIHdyb25nLCBBRkFJVSBpdCBsb29rcyBsaWtlIHRo
aXMgaW4gbWVtb3J5Og0KLSBydGVfZ3JhcGhfY2x1c3Rlcl9zdGF0cw0KLSBjbHVzdGVyX25vZGUN
CiAgLSBydGVfZ3JhcGhfY2x1c3Rlcl9ub2RlX3N0YXRzDQotIHJ0ZV9ub2RlICpbbmJfZ3JhcGhz
XQ0KLSBwYWRkaW5nIG9mIHJ0ZV9ub2RlIHBvaW50ZXJzIGFycmF5IHRvIGNhY2hlbGluZQ0KLSBj
bHVzdGVyX25vZGUNCiAgLSBydGVfZ3JhcGhfY2x1c3Rlcl9ub2RlX3N0YXRzDQotIHJ0ZV9ub2Rl
ICpbbmJfZ3JhcGhzXS4uLg0KDQpjbHVzdGVyX25vZGVfc2l6ZSBjYWxjdWxhdGlvbiBhYm92ZSBl
bnN1cmVzIGNvcnJlY3QgZGlzdGFuY2UgYmV0d2VlbiBjbHVzdGVyX25vZGUgc3RydWN0cyBkdWUg
dG8gcHJlc2VuY2Ugb2YgdGhlIHJ0ZV9ub2RlIHBvaW50ZXJzIGFycmF5cyBpbiBiZXR3ZWVuLCBi
dXQgYWxpZ25tZW50IG9mIHRoZSBmaXJzdCBjbHVzdGVyX25vZGUgc3RpbGwgZGVwZW5kcyBvbiB0
aGUgYWxpZ25tZW50IG9mIHJ0ZV9ncmFwaF9jbHVzdGVyX3N0YXRzLCBhbmQgZWFjaCBvZiB0aGUg
bmV4dCBvbmVzIGRlcGVuZHMgb24gdGhlIHByZXZpb3VzLiBXZSBjb3VsZCBvZiBjb3Vyc2UgcmUt
YWxpZ24gdGhlIGZpcnN0IG9uZSBtYW51YWxseSAoaW4gZWFjaCBsb29wLCBhZnRlciBhbGxvY2F0
aW5nIHNvbWUgZXh0cmEgc3BhY2UpLCBidXQgdG8gbWUgaXQgbG9va3MgbGlrZSB0aGUgam9iIHJ0
ZV9tYWxsb2MgY291bGQgZWFzaWVyIGRvIGZvciB1cy4gV2hhdCBkbyB5b3UgdGhpbmsgd291bGQg
YmUgdGhlIHJpZ2h0IHdheSBmb3J3YXJkPw0K
