Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709A5EA7943
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Feb 2026 22:47:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 39E99402EE;
	Wed,  4 Feb 2026 23:47:21 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id D3864400D5
 for <dev@dpdk.org>; Wed,  4 Feb 2026 23:47:19 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id D05CD22F1B;
 Wed,  4 Feb 2026 23:47:18 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v20] eal: RTE_PTR_ADD/SUB API improvements
Date: Wed, 4 Feb 2026 23:47:12 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F656ED@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <20260204061234.25610-1-scott.k.mitch1@gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v20] eal: RTE_PTR_ADD/SUB API improvements
Thread-Index: AdyVnUXErdH2C+kFSuKjM23ZS7mrzgAguI+A
References: <20260204024631.73059-1-scott.k.mitch1@gmail.com>
 <20260204061234.25610-1-scott.k.mitch1@gmail.com>
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

> +* eal: Improved pointer arithmetic macros to preserve pointer
> provenance and type qualifiers.
> +
> +  * ``RTE_PTR_ADD``, ``RTE_PTR_SUB``, ``RTE_PTR_ALIGN``,
> ``RTE_PTR_ALIGN_CEIL``,
> +    and ``RTE_PTR_ALIGN_FLOOR`` now preserve const/volatile =
qualifiers
> and use
> +    pointer arithmetic instead of integer casts to enable compiler
> optimizations. These
> +    macros do not nest infinitely and may require intermediate
> variables.
> +  * Passing NULL to ``RTE_PTR_ADD``, ``RTE_PTR_SUB``,
> ``RTE_PTR_ALIGN``,
> +    ``RTE_PTR_ALIGN_CEIL``, or ``RTE_PTR_ALIGN_FLOOR`` clarified as
> undefined behavior.
> +  * Existing code passing integer types as pointer to ``RTE_PTR_ADD``
> or ``RTE_PTR_SUB``
> +    should use native operators (e.g. + -). Use of ``RTE_PTR_ALIGN``,
> ``RTE_PTR_ALIGN_CEIL``
> +    or ``RTE_PTR_ALIGN_FLOOR`` should use ``RTE_ALIGN_CEIL`` or
> ``RTE_ALIGN_FLOOR``.

Clarify (for dummies):
"Use of RTE_PTR_ALIGN [...]
+ with integer types
should use [...]"


> --- a/drivers/common/cnxk/roc_platform.h
> +++ b/drivers/common/cnxk/roc_platform.h
> @@ -47,6 +47,8 @@
>  #define PLT_PTR_ADD		 RTE_PTR_ADD
>  #define PLT_PTR_SUB		 RTE_PTR_SUB
>  #define PLT_PTR_DIFF		 RTE_PTR_DIFF
> +#define PLT_PTR_UNQUAL		 RTE_PTR_UNQUAL

The PLT_PTR_UNQUAL macro is only used in =
drivers/common/cnxk/roc_cpt_debug.c; but I think it can be avoided by =
changing the frag_info variable from "struct cpt_frag_info_s =
*frag_info;" to "const struct cpt_frag_info_s *frag_info;". Then you =
don't need to add the PLT_PTR_UNQUAL macro.

> +#define PLT_INT_PTR(intptr)	 ((void *)(uintptr_t)(intptr))

Like I didn't like the RTE_INT_PTR macros, I also don't like the =
PLT_INT_PTR() macro. Please get rid of it.
If an address variable is uintptr_t type, can't you cast it to void* and =
still use PLT_PTR_ADD()?


> --- a/drivers/net/ena/ena_ethdev.c
> +++ b/drivers/net/ena/ena_ethdev.c
> @@ -2379,7 +2379,14 @@ static void *pci_bar_addr(struct rte_pci_device
> *dev, uint32_t bar)
>  {
>  	const struct rte_mem_resource *res =3D &dev->mem_resource[bar];
>  	size_t offset =3D res->phys_addr % rte_mem_page_size();
> -	void *vaddr =3D RTE_PTR_ADD(res->addr, offset);
> +	void *vaddr;
> +
> +	if (res->addr =3D=3D NULL) {
> +		PMD_INIT_LOG_LINE(ERR, "PCI BAR [%u] address is NULL",
> bar);
> +		return NULL;
> +	}
> +
> +	vaddr =3D RTE_PTR_ADD(res->addr, offset);

Note to other reviewers:
The added check for res->addr =3D=3D NULL looks like an unrelated =
change.
But it also tells the compiler that res->addr is not NULL when used with =
RTE_PTR_ADD().
So it's not an unrelated change.
Multiple places in this patch.


> --- a/drivers/net/intel/fm10k/fm10k.h
> +++ b/drivers/net/intel/fm10k/fm10k.h
> @@ -264,9 +264,9 @@ fm10k_pktmbuf_reset(struct rte_mbuf *mb, uint16_t
> in_port)
>  	mb->nb_segs =3D 1;
>=20
>  	/* enforce 512B alignment on default Rx virtual addresses */
> -	mb->data_off =3D (uint16_t)(RTE_PTR_ALIGN((char *)mb->buf_addr +
> -			RTE_PKTMBUF_HEADROOM, FM10K_RX_DATABUF_ALIGN)
> -			- (char *)mb->buf_addr);
> +	mb->data_off =3D (uint16_t)RTE_PTR_DIFF(RTE_PTR_ALIGN((char *)mb-
> >buf_addr +
> +			RTE_PKTMBUF_HEADROOM, FM10K_RX_DATABUF_ALIGN),
> +			(char *)mb->buf_addr);

Is using RTE_PTR_DIFF required here? Or can the code be unchanged?


> diff --git a/drivers/net/intel/fm10k/fm10k_rxtx_vec.c
> b/drivers/net/intel/fm10k/fm10k_rxtx_vec.c
> index 0eada7275e..a08af75bc7 100644
> --- a/drivers/net/intel/fm10k/fm10k_rxtx_vec.c
> +++ b/drivers/net/intel/fm10k/fm10k_rxtx_vec.c
> @@ -315,12 +315,12 @@ fm10k_rxq_rearm(struct fm10k_rx_queue *rxq)
>  		_mm_store_si128(RTE_CAST_PTR(__m128i *, &rxdp++->q),
> dma_addr1);
>=20
>  		/* enforce 512B alignment on default Rx virtual addresses
> */
> -		mb0->data_off =3D (uint16_t)(RTE_PTR_ALIGN((char *)mb0-
> >buf_addr
> -				+ RTE_PKTMBUF_HEADROOM, FM10K_RX_DATABUF_ALIGN)
> -				- (char *)mb0->buf_addr);
> -		mb1->data_off =3D (uint16_t)(RTE_PTR_ALIGN((char *)mb1-
> >buf_addr
> -				+ RTE_PKTMBUF_HEADROOM, FM10K_RX_DATABUF_ALIGN)
> -				- (char *)mb1->buf_addr);
> +		mb0->data_off =3D (uint16_t)RTE_PTR_DIFF(RTE_PTR_ALIGN((char
> *)mb0->buf_addr
> +				+ RTE_PKTMBUF_HEADROOM,
> FM10K_RX_DATABUF_ALIGN),
> +				(char *)mb0->buf_addr);
> +		mb1->data_off =3D (uint16_t)RTE_PTR_DIFF(RTE_PTR_ALIGN((char
> *)mb1->buf_addr
> +				+ RTE_PKTMBUF_HEADROOM,
> FM10K_RX_DATABUF_ALIGN),
> +				(char *)mb1->buf_addr);

Same: Is using RTE_PTR_DIFF required here?

> --- a/drivers/net/mlx4/mlx4_txq.c
> +++ b/drivers/net/mlx4/mlx4_txq.c
> @@ -114,7 +114,8 @@ txq_uar_uninit_secondary(struct txq *txq)
>  	void *addr;
>=20
>  	addr =3D ppriv->uar_table[txq->stats.idx];
> -	munmap(RTE_PTR_ALIGN_FLOOR(addr, page_size), page_size);
> +	if (addr)

Correction: if (addr !=3D NULL)

> +		munmap(RTE_PTR_ALIGN_FLOOR(addr, page_size), page_size);
>  }
>=20


> --- a/lib/mbuf/rte_mbuf.c
> +++ b/lib/mbuf/rte_mbuf.c
> @@ -193,6 +193,7 @@ __rte_pktmbuf_init_extmem(struct rte_mempool *mp,
>=20
>  	RTE_ASSERT(ctx->ext < ctx->ext_num);
>  	RTE_ASSERT(ctx->off + ext_mem->elt_size <=3D ext_mem->buf_len);
> +	RTE_ASSERT(ext_mem->buf_ptr);
>=20
>  	m->buf_addr =3D RTE_PTR_ADD(ext_mem->buf_ptr, ctx->off);

Correction: RTE_ASSERT(ext_mem->buf_ptr !=3D NULL);

Do we also need __rte_assume(ext_mem->buf_ptr !=3D NULL) for when =
building without RTE_ENABLE_ASSERT?
If so, remember any other RTE_ASSERT()s ensuring non-NULL for =
RTE_PTR_ADD().


> diff --git a/lib/mempool/rte_mempool.c b/lib/mempool/rte_mempool.c
> index 3042d94c14..f1ff668205 100644
> --- a/lib/mempool/rte_mempool.c
> +++ b/lib/mempool/rte_mempool.c
> @@ -349,9 +349,9 @@ rte_mempool_populate_iova(struct rte_mempool *mp,
> char *vaddr,
>  	memhdr->opaque =3D opaque;
>=20
>  	if (mp->flags & RTE_MEMPOOL_F_NO_CACHE_ALIGN)
> -		off =3D RTE_PTR_ALIGN_CEIL(vaddr, 8) - vaddr;
> +		off =3D RTE_PTR_DIFF(RTE_PTR_ALIGN_CEIL(vaddr, 8), vaddr);
>  	else
> -		off =3D RTE_PTR_ALIGN_CEIL(vaddr, RTE_MEMPOOL_ALIGN) - vaddr;
> +		off =3D RTE_PTR_DIFF(RTE_PTR_ALIGN_CEIL(vaddr,
> RTE_MEMPOOL_ALIGN), vaddr);

Same: Is using RTE_PTR_DIFF required here?

>=20
>  	if (off > len) {
>  		ret =3D 0;
> @@ -425,8 +425,8 @@ rte_mempool_populate_virt(struct rte_mempool *mp,
> char *addr,
>=20
>  		/* populate with the largest group of contiguous pages */
>  		for (phys_len =3D RTE_MIN(
> -			(size_t)(RTE_PTR_ALIGN_CEIL(addr + off + 1, pg_sz) -
> -				(addr + off)),
> +			(size_t)RTE_PTR_DIFF(RTE_PTR_ALIGN_CEIL(addr + off +
> 1, pg_sz),
> +				addr + off),

Same: Is using RTE_PTR_DIFF required here?


> --- a/lib/mempool/rte_mempool_ops_default.c
> +++ b/lib/mempool/rte_mempool_ops_default.c
> @@ -117,7 +117,7 @@ rte_mempool_op_populate_helper(struct rte_mempool
> *mp, unsigned int flags,
>  	for (i =3D 0; i < max_objs; i++) {
>  		/* avoid objects to cross page boundaries */
>  		if (check_obj_bounds(va + off, pg_sz, total_elt_sz) < 0) {
> -			off +=3D RTE_PTR_ALIGN_CEIL(va + off, pg_sz) - (va +
> off);
> +			off +=3D RTE_PTR_DIFF(RTE_PTR_ALIGN_CEIL(va + off,
> pg_sz), va + off);

Same: Is using RTE_PTR_DIFF required here?

