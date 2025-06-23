Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07854C77B7C
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Jun 2025 15:39:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DFF3F4028D;
	Mon, 23 Jun 2025 17:39:58 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id BB22E40151
 for <dev@dpdk.org>; Mon, 23 Jun 2025 17:39:57 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 55FD420849;
 Mon, 23 Jun 2025 17:39:57 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v2 2/2] lib/graph: default-align rte_graph_cluster_stats
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Mon, 23 Jun 2025 17:39:53 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FD26@smartserver.smartshare.dk>
In-Reply-To: <CAJFAV8y9WPa8xGFSPaAzhSvD-Fb8fr8QgFyQSGV2zDT=Bzgc7Q@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v2 2/2] lib/graph: default-align rte_graph_cluster_stats
Thread-Index: AdvkN3eHRYzj7RDjSwS8fPmwejDrPwAHOKyw
References: <20250617151339.28794-1-marat.khalili@huawei.com>
 <20250617151339.28794-2-marat.khalili@huawei.com>
 <CALBAE1M2Ux9Kr2GvS7BjNLn8nM_DvjWnkhp2pwdESKq-WJeRiw@mail.gmail.com>
 <df33e20237384492bd1fafbdd2e71c56@huawei.com>
 <CALBAE1Mggs++Wi34uxFU_hp8fOhn9=Nfuy+dAOTU83JucsWTdA@mail.gmail.com>
 <f09fa980a01443ebaec61ad7fbe5f436@huawei.com>
 <5f12c8f250084fa3bb40c994cf8ea095@huawei.com>
 <CAJFAV8y9WPa8xGFSPaAzhSvD-Fb8fr8QgFyQSGV2zDT=Bzgc7Q@mail.gmail.com>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "David Marchand" <david.marchand@redhat.com>,
 "Marat Khalili" <marat.khalili@huawei.com>
Cc: "Jerin Jacob" <jerinjacobk@gmail.com>, "Jerin Jacob" <jerinj@marvell.com>,
 "Kiran Kumar K" <kirankumark@marvell.com>,
 "Nithin Dabilpuram" <ndabilpuram@marvell.com>,
 "Zhirun Yan" <yanzhirun_163@163.com>,
 "Pavan Nikhilesh" <pbhagavatula@marvell.com>, <dev@dpdk.org>
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
DQo+IFNlbnQ6IE1vbmRheSwgMjMgSnVuZSAyMDI1IDE0LjA4DQo+IA0KPiBPbiBNb24sIEp1biAy
MywgMjAyNSBhdCAxMDo1M+KAr0FNIE1hcmF0IEtoYWxpbGkgPG1hcmF0LmtoYWxpbGlAaHVhd2Vp
LmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBXZSBjYW5ub3QganVzdCByZW1vdmUgX19ydGVfY2Fj
aGVfYWxpZ25lZCBmcm9tIHJ0ZV9ncmFwaF9jbHVzdGVyX3N0YXRzDQo+IHdpdGhvdXQgcmVtb3Zp
bmcgaXQgZnJvbSBydGVfZ3JhcGhfY2x1c3Rlcl9ub2RlX3N0YXRzIGJlY2F1c2Ugb2YgaG93IEMg
d29ya3MuDQo+IEJ1dCB3ZSBjYW4gcGVyaGFwcyB1c2UgcnRlX21hbGxvYyB0byBhbGlnbiBvdXIg
YWxsb2NhdGlvbnMgaW4gYSB3YXkgdGhhdA0KPiBtYXRjaGVzIHRoZSBkZWNsYXJhdGlvbi4gV291
bGQgaXQgYmUgYW4gb2sgc29sdXRpb24/DQo+IA0KPiBydGVfbWFsbG9jIGlzIG5vdCByZXF1aXJl
ZC4NCj4gSSBoYXZlIGEgZml4IGluIGFuIGJyYW5jaCBvZiBtaW5lLCB0aGF0IG1ha2VzIHVzZSBv
ZiBhbGlnbmVkX2FsbG9jDQo+ICh3aGljaCBpcyBDMTEpLCB5b3UgbmVlZCB0byBtYW51YWxseSBj
b3B5IGRhdGEgaW4gc3RhdHNfbWVtX3BvcHVsYXRlLg0KDQpNU1ZDIGRvZXNuJ3Qgc3VwcG9ydCBh
bGlnbmVkX2FsbG9jKCkuDQpGb3IgTVNWQywgeW91IGhhdmUgdG8gdXNlIF9hbGlnbmVkX21hbGxv
YygpIGFuZCBfYWxpZ25lZF9mcmVlKCksIGxpa2UgaW4gdGhlICJsY29yZSB2YXJpYWJsZXMiIGxp
YnJhcnk6DQpodHRwczovL2VsaXhpci5ib290bGluLmNvbS9kcGRrL3YyNS4wMy9zb3VyY2UvbGli
L2VhbC9jb21tb24vZWFsX2NvbW1vbl9sY29yZV92YXIuYw0KDQo=
