Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E58C982EA
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Sep 2026 09:49:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 61C7840262;
	Wed, 23 Sep 2026 11:49:58 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 060764021E
 for <dev@dpdk.org>; Wed, 23 Sep 2026 11:49:56 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=qG39yapvf5RVpBh3J4XSXa739NDo/qd8r54Sfon78xc=;
 b=jQL2LvW5rVcOOVXjwaaxFmWoKcY2qQXv9IvlvSP9megAj9mHLer5Zt1iCNpyatCmNpVq3zsGg
 B+E7145gfveLo+umKiEGpY6FsLyRzIQyA6VwTR8JOnBIT3VoOSkQ8jBfAf1/eQLFRh8jo4xCYPt
 qOgGauMhGKNgjquGazSz3GA=
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4hqXHv2LCPzJ46Y5;
 Wed, 23 Sep 2026 17:49:47 +0800 (CST)
Received: from dubpeml100002.china.huawei.com (unknown [7.214.144.156])
 by mail.maildlp.com (Postfix) with ESMTPS id E1E0740569;
 Wed, 23 Sep 2026 17:49:51 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml100002.china.huawei.com (7.214.144.156) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 10:49:51 +0100
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.2562.046; 
 Wed, 23 Sep 2026 10:49:51 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Marat Khalili <qm2k21@gmail.com>, "wathsala.vithanage@arm.com"
 <wathsala.vithanage@arm.com>
Subject: RE: [PATCH v2 01/33] bpf: replace deprecated SMP barriers with C11
 fences
Thread-Topic: [PATCH v2 01/33] bpf: replace deprecated SMP barriers with C11
 fences
Thread-Index: AQHdSSve9hjKGpMm50G6VyQDsszbw7bb635A
Date: Wed, 23 Sep 2026 09:49:51 +0000
Message-ID: <bcf335212ccd482c8a27f73e94dd24be@huawei.com>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20260920181347.747210-1-stephen@networkplumber.org>
 <20260920181347.747210-2-stephen@networkplumber.org>
In-Reply-To: <20260920181347.747210-2-stephen@networkplumber.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.170.116]
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


> The use counter is a seqcount, not a reference count: odd means the
> datapath is inside the callback, even means it is not. The two
> barriers around it play different roles.
>=20
> In bpf_eth_cbi_inuse() the counter goes odd and the following loads
> of cb, bpf and jit must not be hoisted above that store. Ordering a
> store against later loads needs a full barrier, so rte_smp_mb()
> becomes a seq_cst thread fence.
>=20
> In bpf_eth_cbi_unuse() the read barrier becomes an acquire fence.
> What must not happen there is the critical section loads sinking
> past the store that makes the counter even, which is load/store
> ordering, and that is what a standalone acquire fence provides.

Hmm.., as I remember 'acquire' serves as a hoist barrier.
For sink barrier we do need 'release' semantics, no?=20

> acq_rel would additionally order prior stores, but the read side
> only loads from the cbi and so has nothing to publish; it would
> only upgrade dmb ishld to dmb ish on the datapath for no benefit.
>=20
> Same code generated on x86 and arm64.
>=20
> Use relaxed loads and stores for the counter itself. With
> enable_stdatomic, the plain increment of an RTE_ATOMIC() field
> compiled to a seq_cst add, i.e. two locked operations per burst.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/bpf/bpf_pkt.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
>=20
> diff --git a/lib/bpf/bpf_pkt.c b/lib/bpf/bpf_pkt.c
> index f072fdaaed..c7b1019239 100644
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

if we are using atomic_store anyway, might be we can unite it with explicit=
 barrier below? i.e:
rte_atomic_store_explicit(&cbi->use,
	rte_atomic_load_explicit(&cbi->use, rte_memory_order_relaxed) + 1,
	rte_memory_order_seq_cst);
?=09

I think Marat also mentioned such possibility here.

>  	/* make sure no store/load reordering could happen */
> -	rte_smp_mb();
> +	rte_atomic_thread_fence(rte_memory_order_seq_cst);
>  }
>=20
>  /*
> @@ -91,9 +93,16 @@ bpf_eth_cbi_inuse(struct bpf_eth_cbi *cbi)
>  static __rte_always_inline void
>  bpf_eth_cbi_unuse(struct bpf_eth_cbi *cbi)
>  {
> -	/* make sure all previous loads are completed */
> -	rte_smp_rmb();
> -	cbi->use++;
> +	/*
> +	 * Make sure all previous loads are completed before the counter
> +	 * goes even. Acquire is enough: the read side only loads from the
> +	 * cbi, so there are no stores to publish and acq_rel would just
> +	 * cost a stronger barrier on weakly ordered CPUs.
> +	 */
> +	rte_atomic_thread_fence(rte_memory_order_acquire);

As it is a sink barrier, I think it should be 'release'.
Again we probably unite it with atomic store below.
rte_atomic_store_explicit(&cbi->use,
	 rte_atomic_load_explicit(&cbi->use, rte_memory_order_relaxed) + 1,
	rte_memory_order_release);

> +	rte_atomic_store_explicit(&cbi->use,
> +		rte_atomic_load_explicit(&cbi->use, rte_memory_order_relaxed)
> + 1,
> +		rte_memory_order_relaxed);
>  }
>=20
>  /*
> @@ -105,9 +114,9 @@ bpf_eth_cbi_wait(const struct bpf_eth_cbi *cbi)
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
> @@ -439,7 +448,7 @@ bpf_eth_cbi_unload(struct bpf_eth_cbi *bc)
>  {
>  	/* mark this cbi as empty */
>  	bc->cb =3D NULL;
> -	rte_smp_mb();
> +	rte_atomic_thread_fence(rte_memory_order_seq_cst);

In fact, that one seems unnecessary here (and smb_mb() too).
As we call bpf_eth_cbi_wait() straight after that, and first thing it does =
- calls smb_mb() itself.
So we probably can just safely remove it here.

>=20
>  	/* make sure datapath doesn't use bpf anymore, then destroy bpf */
>  	bpf_eth_cbi_wait(bc);
> --
> 2.53.0

