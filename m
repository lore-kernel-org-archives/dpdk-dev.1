Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F14CCF2C4
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 20:11:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2B82340291;
	Fri, 16 Oct 2026 22:11:52 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id BA2754026C
 for <dev@dpdk.org>; Fri, 16 Oct 2026 22:11:50 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 46DC82080A;
 Fri, 16 Oct 2026 22:11:50 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v3 2/3] eal: increase memzone name size to 64
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Fri, 16 Oct 2026 22:11:48 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65AB8@smartserver.smartshare.dk>
In-Reply-To: <20261016153949.2965592-3-stephen@networkplumber.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v3 2/3] eal: increase memzone name size to 64
Thread-Index: Ad1dhKExnTI26/iEQYaPTU5AE7fQ/AAJSsTA
References: <20260921215733.404686-1-stephen@networkplumber.org>
 <20261016153949.2965592-1-stephen@networkplumber.org>
 <20261016153949.2965592-3-stephen@networkplumber.org>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>,
	<dev@dpdk.org>
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

A few minor comments inline below.

With our without suggested changes:
Acked-by: Morten Br=F8rup <mb@smartsharesystems.com>

> From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> Sent: Friday, 16 October 2026 17.39
>=20
> Memzone names are limited to 31 characters, and ring, mempool and
> stack names lose the length of their prefixes on top of that.
> A mempool name is limited to 25 characters, which leaves little room
> for libraries such as rib and fib that derive names from the name
> given by the application.
>=20
> Increase RTE_MEMZONE_NAMESIZE to 64. The derived ring, mempool,
> stack and RCU defer queue sizes follow.
>=20
> Reorder struct rte_ring and struct rte_mempool so the larger name
> does not push datapath fields into another cache line.
>=20
> For rte_ring, flags and the size fields come first, followed by the
> memzone pointer and the name. The cache alignment moves from the
> first field to the structure itself. struct rte_ring grows by one
> cache line.
>=20
> For rte_mempool the fields used in the datapath are gathered at the
> start: pool_data/pool_id, local_cache, ops_index and cache_size.

Add sizeof_cache_per_lcore after local_cache.

> The remaining fields, along with pool_config, mz and name, follow.
> Previously local_cache and ops_index were in the second cache line.
> struct rte_mempool stays 192 bytes.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  doc/guides/rel_notes/release_26_11.rst | 21 ++++++++++++++++++
>  lib/eal/include/rte_memzone.h          |  2 +-
>  lib/mempool/rte_mempool.h              | 30 =
++++++++++++++------------
>  lib/ring/rte_ring_core.h               |  9 ++++----
>  4 files changed, 42 insertions(+), 20 deletions(-)
>=20
> diff --git a/doc/guides/rel_notes/release_26_11.rst
> b/doc/guides/rel_notes/release_26_11.rst
> index be758a0c02..0d9465c9e2 100644
> --- a/doc/guides/rel_notes/release_26_11.rst
> +++ b/doc/guides/rel_notes/release_26_11.rst
> @@ -567,6 +567,27 @@ ABI Changes
>  * cryptodev: The struct ``rte_crypto_rsa_op_param``
>    was updated to include ``pss_salt``.
>=20
> +* **Increased memzone maximum name size.**
> +
> +  ``RTE_MEMZONE_NAMESIZE`` was increased from 32 to 64,
> +  and the derived ``RTE_RING_NAMESIZE``, ``RTE_MEMPOOL_NAMESIZE``,
> +  ``RTE_STACK_NAMESIZE`` and ``RTE_RCU_QSBR_DQ_NAMESIZE`` grew
> accordingly.
> +  This impacts the following structures:
> +
> +  * ``struct rte_memzone`` grew by 32 bytes.
> +
> +  * ``struct rte_ring`` grew by one cache line,
> +    and ``memzone`` and ``name`` were moved after the size fields
> +    to keep the datapath fields in the first cache line.
> +
> +  * ``struct rte_mempool`` is unchanged in size,
> +    but the fields were reordered so the datapath fields
> +    (``pool_data``/``pool_id``, ``local_cache``, ``ops_index``

Add ``sizeof_cache_per_lcore`` after ``local_cache``.

> +    and ``cache_size``) come first,
> +    and ``name``, ``pool_config`` and ``mz`` were moved after them.
> +
> +  * ``struct rte_stack`` grew by one cache line.
> +
>=20
>  Known Issues
>  ------------
> diff --git a/lib/eal/include/rte_memzone.h
> b/lib/eal/include/rte_memzone.h
> index 5a0e1b8a15..d5c92fe0ec 100644
> --- a/lib/eal/include/rte_memzone.h
> +++ b/lib/eal/include/rte_memzone.h
> @@ -47,7 +47,7 @@ extern "C" {
>   */
>  struct __rte_packed_begin rte_memzone {
>=20
> -#define RTE_MEMZONE_NAMESIZE 32       /**< Maximum length of memory
> zone name.*/
> +#define RTE_MEMZONE_NAMESIZE 64       /**< Maximum length of memory
> zone name.*/
>  	char name[RTE_MEMZONE_NAMESIZE];  /**< Name of the memory zone.
> */
>=20
>  	rte_iova_t iova;                  /**< Start IO address. */
> diff --git a/lib/mempool/rte_mempool.h b/lib/mempool/rte_mempool.h
> index b34cd893b1..1df8dbebf4 100644
> --- a/lib/mempool/rte_mempool.h
> +++ b/lib/mempool/rte_mempool.h
> @@ -237,34 +237,36 @@ struct __rte_cache_aligned rte_mempool_info {
>   * The RTE mempool structure.
>   */
>  struct __rte_cache_aligned rte_mempool {
> -	char name[RTE_MEMPOOL_NAMESIZE]; /**< Name of mempool. */
>  	union {
>  		void *pool_data;         /**< Ring or pool to store
> objects. */
>  		uint64_t pool_id;        /**< External mempool identifier.
> */
>  	};
> -	void *pool_config;               /**< optional args for ops
> alloc. */
> -	const struct rte_memzone *mz;    /**< Memzone where pool is
> alloc'd. */
> +	struct rte_mempool_cache *local_cache; /**< Per-lcore local cache
> */
> +	uint32_t sizeof_cache_per_lcore; /**< Multiplier for indexing
> into the local cache. */
> +	/**
> +	 * Index into rte_mempool_ops_table array of mempool ops
> +	 * structs, which contain callback function pointers.
> +	 * We're using an index here rather than pointers to the
> callbacks
> +	 * to facilitate any secondary processes that may want to use
> +	 * this mempool.
> +	 */
> +	int32_t ops_index;
> +	uint32_t cache_size;
> +	/**< Size of per-lcore default local cache. */

No need to wrap before comment; it fits on the same line, like before =
moving it.

> +
>  	unsigned int flags;              /**< Flags of the mempool. */
>  	int socket_id;                   /**< Socket id passed at create.
> */
>  	uint32_t size;                   /**< Max size of the mempool. */
> -	uint32_t cache_size;             /**< Size of per-lcore default
> local cache. */
>=20
>  	uint32_t elt_size;               /**< Size of an element. */
>  	uint32_t header_size;            /**< Size of header (before
> elt). */
>  	uint32_t trailer_size;           /**< Size of trailer (after
> elt). */
>=20
>  	unsigned private_data_size;      /**< Size of private data. */
> -	/**
> -	 * Index into rte_mempool_ops_table array of mempool ops
> -	 * structs, which contain callback function pointers.
> -	 * We're using an index here rather than pointers to the
> callbacks
> -	 * to facilitate any secondary processes that may want to use
> -	 * this mempool.
> -	 */
> -	int32_t ops_index;
>=20
> -	struct rte_mempool_cache *local_cache; /**< Per-lcore local cache
> */
> -	uint32_t sizeof_cache_per_lcore; /**< Multiplier for indexing
> into the local cache. */
> +	void *pool_config;               /**< optional args for ops
> alloc. */
> +	const struct rte_memzone *mz;    /**< Memzone where pool is
> alloc'd. */
> +	char name[RTE_MEMPOOL_NAMESIZE]; /**< Name of mempool. */
>=20
>  	uint32_t populated_size;         /**< Number of populated
> objects. */
>  	struct rte_mempool_objhdr_list elt_list; /**< List of objects in
> pool */
> diff --git a/lib/ring/rte_ring_core.h b/lib/ring/rte_ring_core.h
> index 6cd6ce9884..5425cdcef2 100644
> --- a/lib/ring/rte_ring_core.h
> +++ b/lib/ring/rte_ring_core.h
> @@ -113,15 +113,14 @@ struct rte_ring_hts_headtail {
>   * values in a modulo-32bit base: that's why the overflow of the
> indexes is not
>   * a problem.
>   */
> -struct rte_ring {
> -	alignas(RTE_CACHE_LINE_SIZE) char name[RTE_RING_NAMESIZE];
> -	/**< Name of the ring. */
> +struct __rte_cache_aligned rte_ring {
>  	int flags;               /**< Flags supplied at creation. */
> -	const struct rte_memzone *memzone;
> -			/**< Memzone, if any, containing the rte_ring */
>  	uint32_t size;           /**< Size of ring. */
>  	uint32_t mask;           /**< Mask (size-1) of ring. */
>  	uint32_t capacity;       /**< Usable size of ring */
> +	const struct rte_memzone *memzone;
> +			/**< Memzone, if any, containing the rte_ring */
> +	char name[RTE_RING_NAMESIZE]; /**< Name of the ring. */
>=20
>  	RTE_CACHE_GUARD;
>=20
> --
> 2.53.0

