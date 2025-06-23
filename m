Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52265C77B7F
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Jun 2025 12:18:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F59B40649;
	Mon, 23 Jun 2025 14:18:15 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 91A1D40151
 for <dev@dpdk.org>; Mon, 23 Jun 2025 14:18:13 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bQn9G032mz6HK0n;
 Mon, 23 Jun 2025 20:15:46 +0800 (CST)
Received: from frapeml500003.china.huawei.com (unknown [7.182.85.28])
 by mail.maildlp.com (Postfix) with ESMTPS id 04CFF140446;
 Mon, 23 Jun 2025 20:18:13 +0800 (CST)
Received: from frapeml500002.china.huawei.com (7.182.85.205) by
 frapeml500003.china.huawei.com (7.182.85.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 23 Jun 2025 14:18:12 +0200
Received: from frapeml500002.china.huawei.com ([7.182.85.205]) by
 frapeml500002.china.huawei.com ([7.182.85.205]) with mapi id 15.01.2507.039;
 Mon, 23 Jun 2025 14:18:12 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: David Marchand <david.marchand@redhat.com>
CC: Jerin Jacob <jerinjacobk@gmail.com>, Jerin Jacob <jerinj@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>, Nithin Dabilpuram
 <ndabilpuram@marvell.com>, Zhirun Yan <yanzhirun_163@163.com>, "Pavan
 Nikhilesh" <pbhagavatula@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH v2 2/2] lib/graph: default-align rte_graph_cluster_stats
Thread-Topic: [PATCH v2 2/2] lib/graph: default-align rte_graph_cluster_stats
Thread-Index: AQHb35qbEhTUzhsGtk2Rms1nqJghJrQHWAeAgAAiR4D//+PJgIAAIfAAgAj3PLCAABbUgIAAIorQ
Date: Mon, 23 Jun 2025 12:18:12 +0000
Message-ID: <8c2db975f2be434cb86ebd00873607a8@huawei.com>
References: <20250617151339.28794-1-marat.khalili@huawei.com>
 <20250617151339.28794-2-marat.khalili@huawei.com>
 <CALBAE1M2Ux9Kr2GvS7BjNLn8nM_DvjWnkhp2pwdESKq-WJeRiw@mail.gmail.com>
 <df33e20237384492bd1fafbdd2e71c56@huawei.com>
 <CALBAE1Mggs++Wi34uxFU_hp8fOhn9=Nfuy+dAOTU83JucsWTdA@mail.gmail.com>
 <f09fa980a01443ebaec61ad7fbe5f436@huawei.com>
 <5f12c8f250084fa3bb40c994cf8ea095@huawei.com>
 <CAJFAV8y9WPa8xGFSPaAzhSvD-Fb8fr8QgFyQSGV2zDT=Bzgc7Q@mail.gmail.com>
In-Reply-To: <CAJFAV8y9WPa8xGFSPaAzhSvD-Fb8fr8QgFyQSGV2zDT=Bzgc7Q@mail.gmail.com>
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYXZpZCBNYXJjaGFuZCA8ZGF2
aWQubWFyY2hhbmRAcmVkaGF0LmNvbT4NCj4gU2VudDogTW9uZGF5IDIzIEp1bmUgMjAyNSAxMzow
OA0KPiANCj4gQ291bGQgeW91IHNwZW5kIHNvbWUgdGltZSBvbiByZXZpZXdpbmcgcGF0Y2hlcyBv
biB0aGUgdG9waWM/DQo+IExpa2UgZm9yIGV4YW1wbGU6DQo+IGh0dHBzOi8vcGF0Y2h3b3JrLmRw
ZGsub3JnL3Byb2plY3QvZHBkay9saXN0Lz9zZXJpZXM9MzU1MDkNCg0KU3VyZSwgd2lsbCBsb29r
IQ0KDQo+IHJ0ZV9tYWxsb2MgaXMgbm90IHJlcXVpcmVkLg0KPiBJIGhhdmUgYSBmaXggaW4gYW4g
YnJhbmNoIG9mIG1pbmUsIHRoYXQgbWFrZXMgdXNlIG9mIGFsaWduZWRfYWxsb2MNCj4gKHdoaWNo
IGlzIEMxMSksIHlvdSBuZWVkIHRvIG1hbnVhbGx5IGNvcHkgZGF0YSBpbiBzdGF0c19tZW1fcG9w
dWxhdGUuDQoNClN1cmUgYWxpZ25lZF9hbGxvYyBhbmQgbWFudWFsIGNvcHkgZm9yIHJlYWxsb2Mg
c2hvdWxkIHdvcmsgYXMgd2VsbC4gSSB3aWxsIHRoZW4gcmUtc3VibWl0IGFkZHJlc3NpbmcgeW91
ciBjb21tZW50cyB0byAxLzIgYW5kIGRyb3BwaW5nIDIvMiwgYW5kIHdpbGwgd2FpdCBmb3IgeW91
ciBmaXguIFRoYW5rcyBmb3IgdGhlIHJldmlld3MhDQo=
