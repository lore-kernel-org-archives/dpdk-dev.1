Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D7ACCFA13
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Nov 2025 15:43:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AF675402B2;
	Mon, 10 Nov 2025 16:43:16 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 703DD40280
 for <dev@dpdk.org>; Mon, 10 Nov 2025 16:43:15 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d4v7T0DB4zJ46dN;
 Mon, 10 Nov 2025 23:42:45 +0800 (CST)
Received: from frapema100001.china.huawei.com (unknown [7.182.19.23])
 by mail.maildlp.com (Postfix) with ESMTPS id 7E436140257;
 Mon, 10 Nov 2025 23:43:14 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema100001.china.huawei.com (7.182.19.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 10 Nov 2025 16:43:14 +0100
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Mon, 10 Nov 2025 16:43:14 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Konstantin Ananyev <konstantin.ananyev@huawei.com>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [PATCH v4 4/5] bpf: add test for Rx and Tx filtering
Thread-Topic: [PATCH v4 4/5] bpf: add test for Rx and Tx filtering
Thread-Index: AQHcTaYr8infJ5PzIEaHh6dbuKWKhLTnThwwgACe+wCABChF0A==
Date: Mon, 10 Nov 2025 15:43:14 +0000
Message-ID: <0fcc2c24bbb34714822c13c03a2eda5c@huawei.com>
References: <20251030173732.246435-1-stephen@networkplumber.org>
 <20251104160843.304044-1-stephen@networkplumber.org>
 <20251104160843.304044-5-stephen@networkplumber.org>
 <9994a210520c4760bddc67df29999068@huawei.com>
 <20251107171031.5887f3b4@phoenix>
In-Reply-To: <20251107171031.5887f3b4@phoenix>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.137.70]
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

> > Does pkt point to packet data or an mbuf? I would think we need mbuf fu=
nctions
> > here to access data. Not sure why the test is not failing though, maybe=
 I
> > misunderstand it.
>=20
> The API for DPDK BPF gives option for packet data or mbuf.
> See rte_bpf_arg_type.
>=20
> This test uses packet data. Mostly because it is easier, using mbuf
> requires more overhead and BPF validator often doesn't like it.

Oh yes, I missed the bits in bpf_pkt.c that actually look at this and call=
=20
rte_pktmbuf_mtod if necessary.
