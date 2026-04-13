Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A37F34C4C
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Apr 2026 12:24:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E8E1402CC;
	Mon, 13 Apr 2026 14:24:57 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 375D54021E;
 Mon, 13 Apr 2026 14:24:56 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fvRRt69pfzHnH45;
 Mon, 13 Apr 2026 20:24:42 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (unknown [7.214.147.241])
 by mail.maildlp.com (Postfix) with ESMTPS id EA4C340584;
 Mon, 13 Apr 2026 20:24:54 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml500001.china.huawei.com (7.214.147.241) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 13 Apr 2026 13:24:54 +0100
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Mon, 13 Apr 2026 13:24:54 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, Anatoly Burakov
 <anatoly.burakov@intel.com>, Thomas Monjalon <thomas@monjalon.net>
Subject: RE: [PATCH 2/2] ip_frag: randomize hash seed
Thread-Topic: [PATCH 2/2] ip_frag: randomize hash seed
Thread-Index: AQHcx3ONwpClXHCYgkmYKeKtfanD27Xc8g9Q
Date: Mon, 13 Apr 2026 12:24:54 +0000
Message-ID: <0a3e479bf9d64970a87c1173f29c53cc@huawei.com>
References: <20260408161947.285185-1-stephen@networkplumber.org>
 <20260408161947.285185-3-stephen@networkplumber.org>
In-Reply-To: <20260408161947.285185-3-stephen@networkplumber.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.146.52]
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



> Both ipv4_frag_hash() and ipv6_frag_hash() use CRC32 (x86/ARM)
> or jhash with a fixed, publicly known prime seed (0xeaad8405).
> An attacker who can send crafted IP fragments can precompute hash
> collisions, causing all fragments to land in the same bucket.
> After bucket_entries concurrent flows collide, new flows are  dropped.
>=20
> Fix by using a random hash seed added at table creation time.
>=20
> Fixes: 416707812c03 ("ip_frag: refactor reassembly code into a proper lib=
rary")
> Cc: stable@dpdk.org
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/ip_frag/ip_frag_internal.c   | 18 ++++++++----------
>  lib/ip_frag/ip_reassembly.h      |  1 +
>  lib/ip_frag/rte_ip_frag_common.c |  1 +
>  3 files changed, 10 insertions(+), 10 deletions(-)
>=20
> diff --git a/lib/ip_frag/ip_frag_internal.c b/lib/ip_frag/ip_frag_interna=
l.c
> index 7cbef647df..382f42d0e1 100644
> --- a/lib/ip_frag/ip_frag_internal.c
> +++ b/lib/ip_frag/ip_frag_internal.c
> @@ -9,8 +9,6 @@
>=20
>  #include "ip_frag_common.h"
>=20
> -#define	PRIME_VALUE	0xeaad8405
> -
>  #define	IP_FRAG_TBL_POS(tbl, sig)	\
>  	((tbl)->pkt + ((sig) & (tbl)->entry_mask))
>=20
> @@ -38,7 +36,7 @@ ip_frag_tbl_reuse(struct rte_ip_frag_tbl *tbl, struct
> rte_ip_frag_death_row *dr,
>=20
>=20
>  static inline void
> -ipv4_frag_hash(const struct ip_frag_key *key, uint32_t *v1, uint32_t *v2=
)
> +ipv4_frag_hash(const struct ip_frag_key *key, uint32_t *v1, uint32_t *v2=
,
> uint32_t seed)
>  {
>  	uint32_t v;
>  	const uint32_t *p;
> @@ -46,12 +44,12 @@ ipv4_frag_hash(const struct ip_frag_key *key, uint32_=
t
> *v1, uint32_t *v2)
>  	p =3D (const uint32_t *)&key->src_dst;
>=20
>  #if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM64)
> -	v =3D rte_hash_crc_4byte(p[0], PRIME_VALUE);
> +	v =3D rte_hash_crc_4byte(p[0], seed);
>  	v =3D rte_hash_crc_4byte(p[1], v);
>  	v =3D rte_hash_crc_4byte(key->id, v);
>  #else
>=20
> -	v =3D rte_jhash_3words(p[0], p[1], key->id, PRIME_VALUE);
> +	v =3D rte_jhash_3words(p[0], p[1], key->id, seed);
>  #endif /* RTE_ARCH_X86 */
>=20
>  	*v1 =3D  v;
> @@ -59,7 +57,7 @@ ipv4_frag_hash(const struct ip_frag_key *key, uint32_t =
*v1,
> uint32_t *v2)
>  }
>=20
>  static inline void
> -ipv6_frag_hash(const struct ip_frag_key *key, uint32_t *v1, uint32_t *v2=
)
> +ipv6_frag_hash(const struct ip_frag_key *key, uint32_t *v1, uint32_t *v2=
,
> uint32_t seed)
>  {
>  	uint32_t v;
>  	const uint32_t *p;
> @@ -67,7 +65,7 @@ ipv6_frag_hash(const struct ip_frag_key *key, uint32_t =
*v1,
> uint32_t *v2)
>  	p =3D (const uint32_t *) &key->src_dst;
>=20
>  #if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM64)
> -	v =3D rte_hash_crc_4byte(p[0], PRIME_VALUE);
> +	v =3D rte_hash_crc_4byte(p[0], seed);
>  	v =3D rte_hash_crc_4byte(p[1], v);
>  	v =3D rte_hash_crc_4byte(p[2], v);
>  	v =3D rte_hash_crc_4byte(p[3], v);
> @@ -78,7 +76,7 @@ ipv6_frag_hash(const struct ip_frag_key *key, uint32_t =
*v1,
> uint32_t *v2)
>  	v =3D rte_hash_crc_4byte(key->id, v);
>  #else
>=20
> -	v =3D rte_jhash_3words(p[0], p[1], p[2], PRIME_VALUE);
> +	v =3D rte_jhash_3words(p[0], p[1], p[2], seed);
>  	v =3D rte_jhash_3words(p[3], p[4], p[5], v);
>  	v =3D rte_jhash_3words(p[6], p[7], key->id, v);
>  #endif /* RTE_ARCH_X86 */
> @@ -301,9 +299,9 @@ ip_frag_lookup(struct rte_ip_frag_tbl *tbl,
>=20
>  	/* different hashing methods for IPv4 and IPv6 */
>  	if (key->key_len =3D=3D IPV4_KEYLEN)
> -		ipv4_frag_hash(key, &sig1, &sig2);
> +		ipv4_frag_hash(key, &sig1, &sig2, tbl->seed);
>  	else
> -		ipv6_frag_hash(key, &sig1, &sig2);
> +		ipv6_frag_hash(key, &sig1, &sig2, tbl->seed);
>=20
>  	p1 =3D IP_FRAG_TBL_POS(tbl, sig1);
>  	p2 =3D IP_FRAG_TBL_POS(tbl, sig2);
> diff --git a/lib/ip_frag/ip_reassembly.h b/lib/ip_frag/ip_reassembly.h
> index 54afed5417..9e1666ef67 100644
> --- a/lib/ip_frag/ip_reassembly.h
> +++ b/lib/ip_frag/ip_reassembly.h
> @@ -79,6 +79,7 @@ struct rte_ip_frag_tbl {
>  	uint32_t bucket_entries; /* hash associativity. */
>  	uint32_t nb_entries;     /* total size of the table. */
>  	uint32_t nb_buckets;     /* num of associativity lines. */
> +	uint32_t seed;		 /* hash function init value */
>  	struct ip_frag_pkt *last;     /* last used entry. */
>  	struct ip_pkt_list lru;       /* LRU list for table entries. */
>  	struct ip_frag_tbl_stat stat; /* statistics counters. */
> diff --git a/lib/ip_frag/rte_ip_frag_common.c
> b/lib/ip_frag/rte_ip_frag_common.c
> index 79ac45289b..00bf9476de 100644
> --- a/lib/ip_frag/rte_ip_frag_common.c
> +++ b/lib/ip_frag/rte_ip_frag_common.c
> @@ -79,6 +79,7 @@ rte_ip_frag_table_create(uint32_t bucket_num, uint32_t
> bucket_entries,
>  	tbl->nb_buckets =3D bucket_num;
>  	tbl->bucket_entries =3D bucket_entries;
>  	tbl->entry_mask =3D (tbl->nb_entries - 1) & ~(tbl->bucket_entries  - 1)=
;
> +	tbl->seed =3D rte_rand();
>=20
>  	TAILQ_INIT(&(tbl->lru));
>  	return tbl;
> --

Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

> 2.53.0

