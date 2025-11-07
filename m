Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C063CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 17:36:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CFA5340264;
	Fri,  7 Nov 2025 18:36:08 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id A918D4021F
 for <dev@dpdk.org>; Fri,  7 Nov 2025 18:36:06 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4d35j35Qfcz6L4sC;
 Sat,  8 Nov 2025 01:32:07 +0800 (CST)
Received: from frapema500002.china.huawei.com (unknown [7.182.19.148])
 by mail.maildlp.com (Postfix) with ESMTPS id 4A1E01402F3;
 Sat,  8 Nov 2025 01:36:06 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema500002.china.huawei.com (7.182.19.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 7 Nov 2025 18:36:05 +0100
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Fri, 7 Nov 2025 18:36:05 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: RE: [PATCH v4 2/5] bpf: use bulk free on filtered packets
Thread-Topic: [PATCH v4 2/5] bpf: use bulk free on filtered packets
Thread-Index: AQHcTaVoiKS+lNXgKUqB4d6rR1v8fbTnfqfA
Date: Fri, 7 Nov 2025 17:36:05 +0000
Message-ID: <7df88f151a35429aab8f20d0b81f360b@huawei.com>
References: <20251030173732.246435-1-stephen@networkplumber.org>
 <20251104160843.304044-1-stephen@networkplumber.org>
 <20251104160843.304044-3-stephen@networkplumber.org>
In-Reply-To: <20251104160843.304044-3-stephen@networkplumber.org>
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

> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Tuesday 4 November 2025 16:07
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>; Konstantin Ananyev <k=
onstantin.ananyev@huawei.com>
> Subject: [PATCH v4 2/5] bpf: use bulk free on filtered packets
>=20
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
[], uint32_t num,
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
> 2.51.0

Reviewed-by: Marat Khalili <marat.khalili@huawei.com>
