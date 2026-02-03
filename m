Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B4DE83062
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Feb 2026 09:08:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 79EDC4042E;
	Tue,  3 Feb 2026 10:08:38 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 21A7D402D1
 for <dev@dpdk.org>; Tue,  3 Feb 2026 10:08:37 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id D5F53206EC;
 Tue,  3 Feb 2026 10:08:36 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v17 2/2] eal: RTE_PTR_ADD/SUB API improvements
Date: Tue, 3 Feb 2026 10:08:33 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F656E6@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <20260202052442.92192-3-scott.k.mitch1@gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v17 2/2] eal: RTE_PTR_ADD/SUB API improvements
Thread-Index: AdyUBEKdzgS6jRizQvSjTyCpikHiKwA5JxSA
References: <20260127052900.68045-1-scott.k.mitch1@gmail.com>
 <20260202052442.92192-1-scott.k.mitch1@gmail.com>
 <20260202052442.92192-3-scott.k.mitch1@gmail.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: <scott.k.mitch1@gmail.com>,
	<dev@dpdk.org>
Cc: <stephen@networkplumber.org>,
	<bruce.richardson@intel.com>
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

> RTE_PTR_ADD and RTE_PTR_SUB APIs have a few limitations:
> 1. ptr cast to uintptr_t drops pointer provenance and
> prevents compiler optimizations
> 2. return cast discards qualifiers (const, volatile)
> which may hide correctness/concurrency issues.
> 3. Accepts both "pointers" and "integers as pointers" which
> overloads the use case and constrains the implementation
> to address other challenges.
>=20
> This patch splits the API on two dimensions:
> 1. pointer types

Again, thank you for all the work you put into this, Scott!

> 2. integer types that represent pointers

Please get rid of all the RTE_INT_PTR macros.
IMO, these macros look too much like plain wrappers around simple +/- =
operators.
It seems they are only needed for the cnxk drivers; those drivers can =
probably be fixed in some other way.

>=20
> This split allows addressing each of the challenges above
> and provides distinct APIs for the distinct use cases.
> Examples:
> 1. Clang is able to optimize and improve __rte_raw_cksum
> (which uses RTE_PTR_ADD) by ~40% (100 bytes) to ~8x (1.5k bytes)
> TSC cycles/byte.
> 2. Refactoring discovered cases that dropped qualifiers (volatile)
> that the new API exposes.
>=20
> Signed-off-by: Scott Mitchell <scott.k.mitch1@gmail.com>
> ---

A few minor details follow.

>  static inline struct rte_mbuf *
>  rte_mbuf_from_indirect(struct rte_mbuf *mi)
>  {
> +	RTE_ASSERT(mi);

Preferred: RTE_ASSERT(mi !=3D NULL);

>  	return (struct rte_mbuf *)RTE_PTR_SUB(mi->buf_addr, sizeof(*mi) +
> mi->priv_size);
>  }
>=20
> @@ -289,6 +290,7 @@ rte_mbuf_to_baddr(struct rte_mbuf *md)
>  static inline void *
>  rte_mbuf_to_priv(struct rte_mbuf *m)
>  {
> +	RTE_ASSERT(m);

Preferred: RTE_ASSERT(m !=3D NULL);

>  	return RTE_PTR_ADD(m, sizeof(struct rte_mbuf));
>  }
>=20


> --- a/lib/mempool/rte_mempool.h
> +++ b/lib/mempool/rte_mempool.h
> @@ -376,6 +376,7 @@ struct __rte_cache_aligned rte_mempool {
>  static inline struct rte_mempool_objhdr *
>  rte_mempool_get_header(void *obj)
>  {
> +	RTE_ASSERT(obj);

Preferred: RTE_ASSERT(obj !=3D NULL);

>  	return (struct rte_mempool_objhdr *)RTE_PTR_SUB(obj,
>  		sizeof(struct rte_mempool_objhdr));
>  }
> @@ -399,6 +400,7 @@ static inline struct rte_mempool
> *rte_mempool_from_obj(void *obj)
>  static inline struct rte_mempool_objtlr *rte_mempool_get_trailer(void
> *obj)
>  {
>  	struct rte_mempool *mp =3D rte_mempool_from_obj(obj);
> +	RTE_ASSERT(mp);

Preferred: RTE_ASSERT(mp !=3D NULL);

>  	return (struct rte_mempool_objtlr *)RTE_PTR_ADD(obj, mp-
> >elt_size);
>  }
>=20
> @@ -1844,6 +1846,7 @@ rte_mempool_empty(const struct rte_mempool *mp)
>  static inline rte_iova_t
>  rte_mempool_virt2iova(const void *elt)
>  {
> +	RTE_ASSERT(elt);
>  	const struct rte_mempool_objhdr *hdr;

Preferred: RTE_ASSERT(elt !=3D NULL);
Also, it might be preferable adding the RTE_ASSERT() here instead of =
above.

>  	hdr =3D (const struct rte_mempool_objhdr *)RTE_PTR_SUB(elt,
>  		sizeof(*hdr));
