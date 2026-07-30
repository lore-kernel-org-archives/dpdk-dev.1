Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C2FC55162
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Jul 2026 08:48:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3AE1240274;
	Thu, 30 Jul 2026 10:48:46 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id D1A4A40272
 for <dev@dpdk.org>; Thu, 30 Jul 2026 10:48:43 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=RILM0Mpe3yyJ4pl87o3x9CJakoxaNoBvVWz+sSY2ABQ=;
 b=xD2R3PctJ2zGXMMVyeR8H7MT8d4XuiI8kyh7voku2ZKFRRA2sgso5nBYm0HTWdfpqTNO2l4Gt
 xm+iuxMZIz6bsNls2q6PdUtcRVCYUc1q5cBW97QPfIBs8Hr+AShB5qsoYmlOd0mPKykJBIcc9KU
 E+yTg/IRIb9MYz2NfHKBxDo=
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4h9jX70yyHzJ46bD;
 Thu, 30 Jul 2026 16:48:07 +0800 (CST)
Received: from frapema100002.china.huawei.com (unknown [7.182.19.63])
 by mail.maildlp.com (Postfix) with ESMTPS id EF4854057A;
 Thu, 30 Jul 2026 16:48:41 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema100002.china.huawei.com (7.182.19.63) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 30 Jul 2026 10:48:41 +0200
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Thu, 30 Jul 2026 10:48:41 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: RE: [RFC 01/32] bpf: replace deprecated SMP barriers with C11 fences
Thread-Topic: [RFC 01/32] bpf: replace deprecated SMP barriers with C11 fences
Thread-Index: AQHdH4O2ptQbX30vgEiaf+/z/N+qaraFv74w
Date: Thu, 30 Jul 2026 08:48:41 +0000
Message-ID: <a6a65fbd303f4ef3ba93fbe67d5ef022@huawei.com>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20260729175715.165120-2-stephen@networkplumber.org>
In-Reply-To: <20260729175715.165120-2-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.137.78]
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

> diff --git a/lib/bpf/bpf_pkt.c b/lib/bpf/bpf_pkt.c
> index f072fdaaed..a831b5ad86 100644
> --- a/lib/bpf/bpf_pkt.c
> +++ b/lib/bpf/bpf_pkt.c
> @@ -80,9 +80,11 @@ static struct bpf_eth_cbh tx_cbh =3D {
>  static __rte_always_inline void
>  bpf_eth_cbi_inuse(struct bpf_eth_cbi *cbi)
>  {
> -	cbi->use++;
> +	rte_atomic_store_explicit(&cbi->use,
> +		rte_atomic_load_explicit(&cbi->use, rte_memory_order_relaxed) + 1,
> +		rte_memory_order_relaxed);
>  	/* make sure no store/load reordering could happen */
> -	rte_smp_mb();
> +	rte_atomic_thread_fence(rte_memory_order_seq_cst);
>  }

I think this needs to be analyzed further by AI to see if a more canonical =
way
of doing things exists now. To me the whole construct above looks very stra=
nge.

>=20
>  /*
> @@ -92,8 +94,10 @@ static __rte_always_inline void
>  bpf_eth_cbi_unuse(struct bpf_eth_cbi *cbi)
>  {
>  	/* make sure all previous loads are completed */
> -	rte_smp_rmb();
> -	cbi->use++;
> +	rte_atomic_thread_fence(rte_memory_order_acquire);
> +	rte_atomic_store_explicit(&cbi->use,
> +		rte_atomic_load_explicit(&cbi->use, rte_memory_order_relaxed) + 1,
> +		rte_memory_order_relaxed);
>  }
>=20
>  /*
> @@ -105,9 +109,9 @@ bpf_eth_cbi_wait(const struct bpf_eth_cbi *cbi)
>  	uint32_t puse;
>=20
>  	/* make sure all previous loads and stores are completed */
> -	rte_smp_mb();
> +	rte_atomic_thread_fence(rte_memory_order_seq_cst);
>=20
> -	puse =3D cbi->use;
> +	puse =3D rte_atomic_load_explicit(&cbi->use, rte_memory_order_relaxed);
>=20
>  	/* in use, busy wait till current RX/TX iteration is finished */
>  	if ((puse & BPF_ETH_CBI_INUSE) !=3D 0) {
> @@ -439,7 +443,7 @@ bpf_eth_cbi_unload(struct bpf_eth_cbi *bc)
>  {
>  	/* mark this cbi as empty */
>  	bc->cb =3D NULL;
> -	rte_smp_mb();
> +	rte_atomic_thread_fence(rte_memory_order_seq_cst);
>=20
>  	/* make sure datapath doesn't use bpf anymore, then destroy bpf */
>  	bpf_eth_cbi_wait(bc);
> --
> 2.53.0

