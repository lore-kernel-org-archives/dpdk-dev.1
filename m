Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F04FC54FDF
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Jul 2026 09:23:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0AF504028A;
	Thu, 30 Jul 2026 11:23:39 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id C2AB140272
 for <dev@dpdk.org>; Thu, 30 Jul 2026 11:23:37 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=35Md185I0eIDr1yex903nZdyGsvfqbxlpxYdNL8nX5Q=;
 b=1Rzhgd3C9zJDenUywoqEgPW7DUqoM6YH1A2IL+SmGypXIKuiMfwAp98JC9THxfGSDkCaYuJ2s
 KS35uUUo4QvU/b8aErdtI34kSa2xFTx1BQMZVm9R7Hr2g9fg1mRmcs3paqbkMFlJBze7cHEnwtA
 hiS7aqce4+HYfRl+vhGNt34=
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4h9kJP05BzzJ46F5;
 Thu, 30 Jul 2026 17:23:01 +0800 (CST)
Received: from dubpeml100003.china.huawei.com (unknown [7.214.147.98])
 by mail.maildlp.com (Postfix) with ESMTPS id D5B9B40570;
 Thu, 30 Jul 2026 17:23:35 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml100003.china.huawei.com (7.214.147.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 30 Jul 2026 10:23:35 +0100
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Thu, 30 Jul 2026 10:23:35 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Marat Khalili <marat.khalili@huawei.com>
Subject: RE: [RFC 01/32] bpf: replace deprecated SMP barriers with C11 fences
Thread-Topic: [RFC 01/32] bpf: replace deprecated SMP barriers with C11 fences
Thread-Index: AQHdH4O3BdaOnH3nTku9uHFkg7OY0LaFymvw
Date: Thu, 30 Jul 2026 09:23:35 +0000
Message-ID: <8009cc6b2f19461ebb52566c322e15f0@huawei.com>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20260729175715.165120-2-stephen@networkplumber.org>
In-Reply-To: <20260729175715.165120-2-stephen@networkplumber.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.81.197.251]
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


> The use counter handshake is a store-load pattern, so rte_smp_mb()
> becomes a seq_cst thread fence; the read barrier in
> bpf_eth_cbi_unuse() becomes an acquire fence. Same code generated
> on x86 and arm64.
>=20
> Use relaxed loads and stores for the counter itself. With
> enable_stdatomic, the plain increment of an RTE_ATOMIC() field
> compiled to a seq_cst add, i.e. two locked operations per burst.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/bpf/bpf_pkt.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
>=20
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
> +		rte_atomic_load_explicit(&cbi->use, rte_memory_order_relaxed)
> + 1,
> +		rte_memory_order_relaxed);
>  	/* make sure no store/load reordering could happen */
> -	rte_smp_mb();
> +	rte_atomic_thread_fence(rte_memory_order_seq_cst);
>  }
>=20
>  /*
> @@ -92,8 +94,10 @@ static __rte_always_inline void
>  bpf_eth_cbi_unuse(struct bpf_eth_cbi *cbi)
>  {
>  	/* make sure all previous loads are completed */
> -	rte_smp_rmb();
> -	cbi->use++;
> +	rte_atomic_thread_fence(rte_memory_order_acquire);

Probably safer to use 'acq_release' order here?
We do want that all previous loads to be completed at that point. =20

> +	rte_atomic_store_explicit(&cbi->use,
> +		rte_atomic_load_explicit(&cbi->use, rte_memory_order_relaxed)
> + 1,
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

