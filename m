Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6323C71136
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 15:41:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E452741148;
	Tue, 17 Jun 2025 17:41:16 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 902AC402C5
 for <dev@dpdk.org>; Tue, 17 Jun 2025 17:41:15 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bM9yc13bXz6L5Sh;
 Tue, 17 Jun 2025 23:39:04 +0800 (CST)
Received: from frapeml100001.china.huawei.com (unknown [7.182.85.63])
 by mail.maildlp.com (Postfix) with ESMTPS id 9038B1402FE;
 Tue, 17 Jun 2025 23:41:14 +0800 (CST)
Received: from frapeml500002.china.huawei.com (7.182.85.205) by
 frapeml100001.china.huawei.com (7.182.85.63) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 17 Jun 2025 17:41:14 +0200
Received: from frapeml500002.china.huawei.com ([7.182.85.205]) by
 frapeml500002.china.huawei.com ([7.182.85.205]) with mapi id 15.01.2507.039;
 Tue, 17 Jun 2025 17:41:14 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Jerin Jacob <jerinjacobk@gmail.com>
CC: Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>, 
 Nithin Dabilpuram <ndabilpuram@marvell.com>, Zhirun Yan
 <yanzhirun_163@163.com>, Pavan Nikhilesh <pbhagavatula@marvell.com>,
 "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH v2 2/2] lib/graph: default-align rte_graph_cluster_stats
Thread-Topic: [PATCH v2 2/2] lib/graph: default-align rte_graph_cluster_stats
Thread-Index: AQHb35qbEhTUzhsGtk2Rms1nqJghJrQHWAeAgAAiR4A=
Date: Tue, 17 Jun 2025 15:41:14 +0000
Message-ID: <df33e20237384492bd1fafbdd2e71c56@huawei.com>
References: <20250617151339.28794-1-marat.khalili@huawei.com>
 <20250617151339.28794-2-marat.khalili@huawei.com>
 <CALBAE1M2Ux9Kr2GvS7BjNLn8nM_DvjWnkhp2pwdESKq-WJeRiw@mail.gmail.com>
In-Reply-To: <CALBAE1M2Ux9Kr2GvS7BjNLn8nM_DvjWnkhp2pwdESKq-WJeRiw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.137.63]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
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

> -----Original Message-----
> From: Jerin Jacob <jerinjacobk@gmail.com>
> Sent: Tuesday 17 June 2025 16:28
>=20
> > -struct __rte_cache_aligned rte_graph_cluster_node_stats {
> > +struct rte_graph_cluster_node_stats {
>=20
> This is a fastpath structure. No need to change the alignment here.

rte_graph_cluster_stats includes it, so unfortunately would stay cache-alig=
ned regardless of the attributes unless we make rte_graph_cluster_node_stat=
s default-aligned as well. If you are sure that we need to keep node one ca=
che-aligned we can return to rte_malloc solution (or posix_memalign, but I =
would prefer not to hand-code aligned realloc).

