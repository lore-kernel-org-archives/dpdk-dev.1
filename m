Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE40C7115B
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Jun 2025 08:53:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8880E400D6;
	Mon, 23 Jun 2025 10:53:05 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id A00CB40041
 for <dev@dpdk.org>; Mon, 23 Jun 2025 10:53:01 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bQhYc4WD9z6L5dC;
 Mon, 23 Jun 2025 16:48:04 +0800 (CST)
Received: from frapeml500001.china.huawei.com (unknown [7.182.85.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 428A41402F6;
 Mon, 23 Jun 2025 16:53:00 +0800 (CST)
Received: from frapeml500002.china.huawei.com (7.182.85.205) by
 frapeml500001.china.huawei.com (7.182.85.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 23 Jun 2025 10:52:59 +0200
Received: from frapeml500002.china.huawei.com ([7.182.85.205]) by
 frapeml500002.china.huawei.com ([7.182.85.205]) with mapi id 15.01.2507.039;
 Mon, 23 Jun 2025 10:52:59 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Jerin Jacob <jerinjacobk@gmail.com>, Jerin Jacob <jerinj@marvell.com>
CC: Kiran Kumar K <kirankumark@marvell.com>, Nithin Dabilpuram
 <ndabilpuram@marvell.com>, Zhirun Yan <yanzhirun_163@163.com>, "Pavan
 Nikhilesh" <pbhagavatula@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH v2 2/2] lib/graph: default-align rte_graph_cluster_stats
Thread-Topic: [PATCH v2 2/2] lib/graph: default-align rte_graph_cluster_stats
Thread-Index: AQHb35qbEhTUzhsGtk2Rms1nqJghJrQHWAeAgAAiR4D//+PJgIAAIfAAgAj3PLA=
Date: Mon, 23 Jun 2025 08:52:59 +0000
Message-ID: <5f12c8f250084fa3bb40c994cf8ea095@huawei.com>
References: <20250617151339.28794-1-marat.khalili@huawei.com>
 <20250617151339.28794-2-marat.khalili@huawei.com>
 <CALBAE1M2Ux9Kr2GvS7BjNLn8nM_DvjWnkhp2pwdESKq-WJeRiw@mail.gmail.com>
 <df33e20237384492bd1fafbdd2e71c56@huawei.com>
 <CALBAE1Mggs++Wi34uxFU_hp8fOhn9=Nfuy+dAOTU83JucsWTdA@mail.gmail.com>
 <f09fa980a01443ebaec61ad7fbe5f436@huawei.com>
In-Reply-To: <f09fa980a01443ebaec61ad7fbe5f436@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.137.64]
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

R2VudGx5IHJlbWluZGluZyBhYm91dCB0aGlzIGlzc3VlLCBJIHN0aWxsIGhvcGUgdG8gc2VlIGdy
YXBoIHRlc3RzIHBhc3NpbmcgdW5kZXIgc2FuaXRpemVyLg0KDQpXZSBjYW5ub3QganVzdCByZW1v
dmUgX19ydGVfY2FjaGVfYWxpZ25lZCBmcm9tIHJ0ZV9ncmFwaF9jbHVzdGVyX3N0YXRzIHdpdGhv
dXQgcmVtb3ZpbmcgaXQgZnJvbSBydGVfZ3JhcGhfY2x1c3Rlcl9ub2RlX3N0YXRzIGJlY2F1c2Ug
b2YgaG93IEMgd29ya3MuIEJ1dCB3ZSBjYW4gcGVyaGFwcyB1c2UgcnRlX21hbGxvYyB0byBhbGln
biBvdXIgYWxsb2NhdGlvbnMgaW4gYSB3YXkgdGhhdCBtYXRjaGVzIHRoZSBkZWNsYXJhdGlvbi4g
V291bGQgaXQgYmUgYW4gb2sgc29sdXRpb24/DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogTWFyYXQgS2hhbGlsaSA8bWFyYXQua2hhbGlsaUBodWF3ZWkuY29tPg0KPiBT
ZW50OiBUdWVzZGF5IDE3IEp1bmUgMjAyNSAxNzo0MA0KPiBUbzogSmVyaW4gSmFjb2IgPGplcmlu
amFjb2JrQGdtYWlsLmNvbT4NCj4gQ2M6IEplcmluIEphY29iIDxqZXJpbmpAbWFydmVsbC5jb20+
OyBLaXJhbiBLdW1hciBLDQo+IDxraXJhbmt1bWFya0BtYXJ2ZWxsLmNvbT47IE5pdGhpbiBEYWJp
bHB1cmFtDQo+IDxuZGFiaWxwdXJhbUBtYXJ2ZWxsLmNvbT47IFpoaXJ1biBZYW4gPHlhbnpoaXJ1
bl8xNjNAMTYzLmNvbT47IFBhdmFuDQo+IE5pa2hpbGVzaCA8cGJoYWdhdmF0dWxhQG1hcnZlbGwu
Y29tPjsgZGV2QGRwZGsub3JnDQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggdjIgMi8yXSBsaWIvZ3Jh
cGg6IGRlZmF1bHQtYWxpZ24gcnRlX2dyYXBoX2NsdXN0ZXJfc3RhdHMNCj4gDQo+ID4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBKZXJpbiBKYWNvYiA8amVyaW5qYWNvYmtA
Z21haWwuY29tPg0KPiA+IFNlbnQ6IFR1ZXNkYXkgMTcgSnVuZSAyMDI1IDE2OjUwDQo+ID4NCj4g
PiA+ID4gPiAtc3RydWN0IF9fcnRlX2NhY2hlX2FsaWduZWQgcnRlX2dyYXBoX2NsdXN0ZXJfbm9k
ZV9zdGF0cyB7DQo+ID4gPiA+ID4gK3N0cnVjdCBydGVfZ3JhcGhfY2x1c3Rlcl9ub2RlX3N0YXRz
IHsNCj4gPiA+ID4NCj4gPiA+ID4gVGhpcyBpcyBhIGZhc3RwYXRoIHN0cnVjdHVyZS4gTm8gbmVl
ZCB0byBjaGFuZ2UgdGhlIGFsaWdubWVudCBoZXJlLg0KPiA+ID4NCj4gPiA+IHJ0ZV9ncmFwaF9j
bHVzdGVyX3N0YXRzIGluY2x1ZGVzIGl0LCBzbyB1bmZvcnR1bmF0ZWx5IHdvdWxkIHN0YXkgY2Fj
aGUtDQo+ID4gYWxpZ25lZCByZWdhcmRsZXNzIG9mIHRoZSBhdHRyaWJ1dGVzIHVubGVzcyB3ZSBt
YWtlDQo+ID4gcnRlX2dyYXBoX2NsdXN0ZXJfbm9kZV9zdGF0cyBkZWZhdWx0LWFsaWduZWQgYXMg
d2VsbC4gSWYgeW91IGFyZSBzdXJlIHRoYXQNCj4gPiB3ZSBuZWVkIHRvIGtlZXAgbm9kZSBvbmUg
Y2FjaGUtYWxpZ25lZCB3ZSBjYW4gcmV0dXJuIHRvIHJ0ZV9tYWxsb2MNCj4gPiBzb2x1dGlvbiAo
b3IgcG9zaXhfbWVtYWxpZ24sIGJ1dCBJIHdvdWxkIHByZWZlciBub3QgdG8gaGFuZC1jb2RlIGFs
aWduZWQNCj4gPiByZWFsbG9jKS4NCj4gPg0KPiA+IEkgdGhpbmssIGV4aXN0aW5nIGZvbGxvd2lu
ZyBjb2RlIHdpbGwgdGFrZSBjYXJlIG9mIHRoaXMuIEFyZSB5b3UNCj4gPiBzZWVpbmcgdGhlIHNh
bml0aXplciBpc3N1ZSBpZiB0aGUgY2hhbmdlIGlzIG9ubHkgdXBkYXRpbmcNCj4gPiBydGVfZ3Jh
cGhfY2x1c3Rlcl9zdGF0cyBhbGlnbm1lbnQ/DQo+IA0KPiBZZXMsIHN0aWxsIHNlZWluZyB0aGUg
c2FuaXRpemVyIGlzc3VlLiBBbmQgaWYgZmFpbHMgZXZlbiBiZWZvcmUgcmVhY2hpbmcgY2x1c3Rl
cnMsDQo+IG9uIHRoZSBzdHJ1Y3QgcnRlX2dyYXBoX2NsdXN0ZXJfc3RhdHMgaXRzZWxmIGJlY2F1
c2UgSSBiZWxpZXZlIGFsaWdubWVudA0KPiBwcm9wYWdhdGVzIGZyb20gbWVtYmVycyB0byBlbmNs
b3Npbmcgc3RydWN0cy4NCj4gDQo+ID4gICAgICAgICAvKiBGb3IgYSBnaXZlbiBjbHVzdGVyLCBt
YXggbm9kZXMgd2lsbCBiZSB0aGUgbWF4IG51bWJlciBvZiBncmFwaHMgKi8NCj4gPiAgICAgICAg
IGNsdXN0ZXJfbm9kZV9zaXplICs9IGNsdXN0ZXItPm5iX2dyYXBocyAqIHNpemVvZihzdHJ1Y3Qg
cnRlX25vZGUgKik7DQo+ID4gICAgICAgICBjbHVzdGVyX25vZGVfc2l6ZSA9IFJURV9BTElHTihj
bHVzdGVyX25vZGVfc2l6ZSwNCj4gPiBSVEVfQ0FDSEVfTElORV9TSVpFKTsNCj4gDQo+IFBsZWFz
ZSBjb3JyZWN0IG1lIGlmIEkgYW0gd3JvbmcsIEFGQUlVIGl0IGxvb2tzIGxpa2UgdGhpcyBpbiBt
ZW1vcnk6DQo+IC0gcnRlX2dyYXBoX2NsdXN0ZXJfc3RhdHMNCj4gLSBjbHVzdGVyX25vZGUNCj4g
ICAtIHJ0ZV9ncmFwaF9jbHVzdGVyX25vZGVfc3RhdHMNCj4gLSBydGVfbm9kZSAqW25iX2dyYXBo
c10NCj4gLSBwYWRkaW5nIG9mIHJ0ZV9ub2RlIHBvaW50ZXJzIGFycmF5IHRvIGNhY2hlbGluZQ0K
PiAtIGNsdXN0ZXJfbm9kZQ0KPiAgIC0gcnRlX2dyYXBoX2NsdXN0ZXJfbm9kZV9zdGF0cw0KPiAt
IHJ0ZV9ub2RlICpbbmJfZ3JhcGhzXS4uLg0KPiANCj4gY2x1c3Rlcl9ub2RlX3NpemUgY2FsY3Vs
YXRpb24gYWJvdmUgZW5zdXJlcyBjb3JyZWN0IGRpc3RhbmNlIGJldHdlZW4NCj4gY2x1c3Rlcl9u
b2RlIHN0cnVjdHMgZHVlIHRvIHByZXNlbmNlIG9mIHRoZSBydGVfbm9kZSBwb2ludGVycyBhcnJh
eXMgaW4NCj4gYmV0d2VlbiwgYnV0IGFsaWdubWVudCBvZiB0aGUgZmlyc3QgY2x1c3Rlcl9ub2Rl
IHN0aWxsIGRlcGVuZHMgb24gdGhlDQo+IGFsaWdubWVudCBvZiBydGVfZ3JhcGhfY2x1c3Rlcl9z
dGF0cywgYW5kIGVhY2ggb2YgdGhlIG5leHQgb25lcyBkZXBlbmRzIG9uDQo+IHRoZSBwcmV2aW91
cy4gV2UgY291bGQgb2YgY291cnNlIHJlLWFsaWduIHRoZSBmaXJzdCBvbmUgbWFudWFsbHkgKGlu
IGVhY2ggbG9vcCwNCj4gYWZ0ZXIgYWxsb2NhdGluZyBzb21lIGV4dHJhIHNwYWNlKSwgYnV0IHRv
IG1lIGl0IGxvb2tzIGxpa2UgdGhlIGpvYiBydGVfbWFsbG9jDQo+IGNvdWxkIGVhc2llciBkbyBm
b3IgdXMuIFdoYXQgZG8geW91IHRoaW5rIHdvdWxkIGJlIHRoZSByaWdodCB3YXkgZm9yd2FyZD8N
Cg==
