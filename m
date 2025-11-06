Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE45ACCFA03
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 07:25:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 72F4940B98;
	Thu,  6 Nov 2025 08:25:48 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id AF72D4013F
 for <dev@dpdk.org>; Thu,  6 Nov 2025 08:25:46 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d2DHl0RnQzHnGh0;
 Thu,  6 Nov 2025 15:25:39 +0800 (CST)
Received: from dubpeml100002.china.huawei.com (unknown [7.214.144.156])
 by mail.maildlp.com (Postfix) with ESMTPS id DF82E1402A4;
 Thu,  6 Nov 2025 15:25:45 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml100002.china.huawei.com (7.214.144.156) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 6 Nov 2025 07:25:45 +0000
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Thu, 6 Nov 2025 07:25:45 +0000
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [PATCH v4 2/5] bpf: use bulk free on filtered packets
Thread-Topic: [PATCH v4 2/5] bpf: use bulk free on filtered packets
Thread-Index: AQHcTaVYo1aKttGjE0GT4suhniLp5rTlQaDQ
Date: Thu, 6 Nov 2025 07:25:45 +0000
Message-ID: <8f0189febcb74303addf8c5b2b8297e8@huawei.com>
References: <20251030173732.246435-1-stephen@networkplumber.org>
 <20251104160843.304044-1-stephen@networkplumber.org>
 <20251104160843.304044-3-stephen@networkplumber.org>
In-Reply-To: <20251104160843.304044-3-stephen@networkplumber.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.151.58]
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



> When rte_pktmbuf_free_bulk is faster because it does single
> mempool operation rather than per-packet.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/bpf/bpf_pkt.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/lib/bpf/bpf_pkt.c b/lib/bpf/bpf_pkt.c
> index 01f813c56b..087ac0f244 100644
> --- a/lib/bpf/bpf_pkt.c
> +++ b/lib/bpf/bpf_pkt.c
> @@ -177,8 +177,7 @@ apply_filter(struct rte_mbuf *mb[], const uint64_t rc=
[],
> uint32_t num,
>=20
>  	if (drop !=3D 0) {
>  		/* free filtered out mbufs */
> -		for (i =3D 0; i !=3D k; i++)
> -			rte_pktmbuf_free(dr[i]);
> +		rte_pktmbuf_free_bulk(dr, k);
>  	} else {
>  		/* copy filtered out mbufs beyond good ones */
>  		for (i =3D 0; i !=3D k; i++)
> --

Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

> 2.51.0

