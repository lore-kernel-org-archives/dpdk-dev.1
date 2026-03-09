Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C93FCEF370D
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Mar 2026 08:32:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C270340281;
	Mon,  9 Mar 2026 09:32:41 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 71A1540261
 for <dev@dpdk.org>; Mon,  9 Mar 2026 09:32:39 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fTqxR5Z3CzJ47wk;
 Mon,  9 Mar 2026 16:31:55 +0800 (CST)
Received: from dubpeml500002.china.huawei.com (unknown [7.214.145.83])
 by mail.maildlp.com (Postfix) with ESMTPS id 6C7154056E;
 Mon,  9 Mar 2026 16:32:38 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml500002.china.huawei.com (7.214.145.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 9 Mar 2026 08:32:38 +0000
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Mon, 9 Mar 2026 08:32:37 +0000
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Robin Jarry <rjarry@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Bruce Richardson <bruce.richardson@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>, Yipeng Wang <yipeng1.wang@intel.com>
Subject: RE: [PATCH dpdk v3 0/2] hash: safe data replacement on overwrite
Thread-Topic: [PATCH dpdk v3 0/2] hash: safe data replacement on overwrite
Thread-Index: AQHcrUXi4ZBN5LlCak+VAMvKtWPN2bWl18/wgAABAQCAAAeFsA==
Date: Mon, 9 Mar 2026 08:32:37 +0000
Message-ID: <fe0d45e6bcbf443eb8261a3b45dd15a8@huawei.com>
References: <20260212213313.1376294-5-rjarry@redhat.com>
 <20260306084710.492520-4-rjarry@redhat.com>
 <540b570f12bb458997f4b8a1a4322dff@huawei.com>
 <DGY376Y34LNU.J0HOHBT3S7AM@redhat.com>
In-Reply-To: <DGY376Y34LNU.J0HOHBT3S7AM@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.81.203.174]
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

DQpIaSBSb2JpbiwNCg0KPiA+PiAqIFJlbW92ZWQgdGhlIHJ0ZV9oYXNoX3JlcGxhY2Vfa2V5X2Rh
dGEoKSBBUEkNCj4gPg0KPiA+IFRoYXQncyBhIHBpdHkgLSBJIHRoaW5rIGl0IGlzIGEgdXNlZnVs
IG9uZS4NCj4gPg0KPiA+PiB3aGljaCByZXF1aXJlZCB0byBidWJibGUNCj4gPj4gICBhIHBvdGVu
dGlhbCBvbGRfZGF0YSBwb2ludGVyIGZyb20gc2VhcmNoX2FuZF91cGRhdGUoKSB0byBhbGwNCj4g
Pj4gICBpbnRlcm1lZGlhdGUgY2FsbGVycyBkb3duIHRvIF9fcnRlX2hhc2hfYWRkX2tleV93aXRo
X2hhc2goKS4gSXQgbWFkZQ0KPiA+PiAgIGFuIGFscmVhZHkgY29tcGxleCBjb2RlIGV2ZW4gbW9y
ZSBvYnNjdXJlLg0KPiANCj4gSSBjYW4gc2VuZCBpdCBiYWNrIGJ1dCBpdCB3aWxsIG1ha2UgdGhl
IGNvZGUgY29tcGxleCBzaW5jZSBJIGNhbm5vdCBmcmVlDQo+IHRoZSBwb2ludGVyIGluIHRoZSBj
YWxsZXJzLiBJIG5lZWQgdG8gcGFzcyBpdCBkb3duIHRoZSBjYWxsIGNoYWluIHRvDQo+IG1ha2Ug
dGhlIGZyZWUtb3ItcmV0dXJuLW9sZC1kYXRhIGRlY2lzaW9uLg0KDQo+IExldCBtZSBrbm93IHdo
YXQgeW91IHByZWZlci4NCiANCk15IHRob3VnaHRzIGFyZToNCkkgdGhpbmsgd2hhdCB3ZSBoYXZl
IG5vdyBpbnNpZGUgcnRlX2hhc2ggLSBJcyBhIGJ1ZyB0aGF0IG5lZWRzIHRvIGJlIGZpeGVkLg0K
U28geW91ciB2MyBwYXRjaCBsb29rcyBnb29kIHRvIG1lOiBpdCBmaXhlcyB0aGUgbWVtb3J5IGxl
YWsuDQpUaGF0J3Mgd2h5IEkgYWNrLWVkIGl0IC0gSSB0aGluayBwYXRjaCBpcyBnb29kIHRvIGdv
IGFzIGl0IGlzLg0KDQpGcm9tIG90aGVyIGhhbmQgLSBydGVfaGFzaF9yZXBsYWNlX2tleV9kYXRh
KCkgLSBpcyBhICduaWNlIHRvIGhhdmUnIGZlYXR1cmUsIA0KQXQgaXQgaXMga2luZCBvZiBhIG5l
dyBBUEksIEkgdGhpbmsgaWYgd2UgZGVjaWRlIHRvIGdvIGFoZWFkIHdpdGggaXQgLSBpdCBjYW4g
YmUgZG9uZSBhcyBhIG5ldyBwYXRjaCBzZXJpZXMuDQpJZiB5b3UgaGF2ZSB0aW1lIHRvIHdvcmsg
b24gaXQgLSBwbGVhc2UgZ28gYWhlYWQsIEknbGwgYmUgaGFwcHkgdG8gcmV2aWV3IHRoZSBwYXRj
aC4NCkFsc28gQ0MtaW5nIHRvIGhhc2ggbGliIG1haW50YWluZXJzIC0gbGFkcyB3aGF0IGlzIHlv
dXIgb3BpbmlvbiBvbiB0aGF0IHN1YmplY3Q/DQoNCktvbnN0YW50aW4NCiANCg0K
