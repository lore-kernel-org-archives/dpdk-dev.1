Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7F8C44527
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Jul 2026 10:10:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 82679402A7;
	Mon, 20 Jul 2026 12:10:37 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 77A684028C
 for <dev@dpdk.org>; Mon, 20 Jul 2026 12:10:36 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 4EDFB20534;
 Mon, 20 Jul 2026 12:10:35 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: AVX512 block copy performance?
Date: Mon, 20 Jul 2026 12:10:34 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F6597E@smartserver.smartshare.dk>
In-Reply-To: <20210114063951.2580-4-leyi.rong@intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: AVX512 block copy performance?
X-MimeOLE: Produced By Microsoft Exchange V6.5
Thread-Index: AdbqQvXj4g1PAwopSbyd8MeQyimFX4xb1RQQ
References: <20201215021945.103396-1-leyi.rong@intel.com>
 <20210114063951.2580-1-leyi.rong@intel.com>
 <20210114063951.2580-4-leyi.rong@intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: <bruce.richardson@intel.com>,
 "Konstantin Ananyev" <konstantin.v.ananyev@yandex.ru>,
 "Vipin Varghese" <vipin.varghese@amd.com>
Cc: <dev@dpdk.org>, "Leyi Rong" <leyi.rong@intel.com>, <qi.z.zhang@intel.com>,
 <wenzhuo.lu@intel.com>, <ferruh.yigit@intel.com>,
 <bruce.richardson@intel.com>, <beilei.xing@intel.com>
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

> From: dev [mailto:dev-bounces@dpdk.org] On Behalf Of Leyi Rong
> Sent: Thursday, 14 January 2021 07.40
>=20
> Optimize Tx path by using AVX512 instructions and vectorize the
> tx free bufs process.
>=20
> Signed-off-by: Leyi Rong <leyi.rong@intel.com>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---

[...]

> +static __rte_always_inline int
> +i40e_tx_free_bufs_avx512(struct i40e_tx_queue *txq)
> +{
> +	struct i40e_vec_tx_entry *txep;
> +	uint32_t n;
> +	uint32_t i;
> +	int nb_free =3D 0;
> +	struct rte_mbuf *m, *free[RTE_I40E_TX_MAX_FREE_BUF_SZ];
> +
> +	/* check DD bits on threshold descriptor */
> +	if ((txq->tx_ring[txq->tx_next_dd].cmd_type_offset_bsz &
> +			rte_cpu_to_le_64(I40E_TXD_QW1_DTYPE_MASK)) !=3D
> +			rte_cpu_to_le_64(I40E_TX_DESC_DTYPE_DESC_DONE))
> +		return 0;
> +
> +	n =3D txq->tx_rs_thresh;
> +
> +	 /* first buffer to free from S/W ring is at index
> +	  * tx_next_dd - (tx_rs_thresh-1)
> +	  */
> +	txep =3D (void *)txq->sw_ring;
> +	txep +=3D txq->tx_next_dd - (n - 1);
> +
> +	if (txq->offloads & DEV_TX_OFFLOAD_MBUF_FAST_FREE && (n & 31) =3D=3D
> 0) {
> +		struct rte_mempool *mp =3D txep[0].mbuf->pool;
> +		void **cache_objs;
> +		struct rte_mempool_cache *cache =3D
> rte_mempool_default_cache(mp,
> +				rte_lcore_id());
> +
> +		if (!cache || cache->len =3D=3D 0)
> +			goto normal;
> +
> +		cache_objs =3D &cache->objs[cache->len];
> +
> +		if (n > RTE_MEMPOOL_CACHE_MAX_SIZE) {
> +			rte_mempool_ops_enqueue_bulk(mp, (void *)txep, n);
> +			goto done;
> +		}
> +
> +		/* The cache follows the following algorithm
> +		 *   1. Add the objects to the cache
> +		 *   2. Anything greater than the cache min value (if it
> +		 *   crosses the cache flush threshold) is flushed to the
> ring.
> +		 */
> +		/* Add elements back into the cache */
> +		uint32_t copied =3D 0;
> +		/* n is multiple of 32 */
> +		while (copied < n) {
> +			const __m512i a =3D _mm512_load_si512(&txep[copied]);
> +			const __m512i b =3D _mm512_load_si512(&txep[copied +
> 8]);
> +			const __m512i c =3D _mm512_load_si512(&txep[copied +
> 16]);
> +			const __m512i d =3D _mm512_load_si512(&txep[copied +
> 24]);
> +
> +			_mm512_storeu_si512(&cache_objs[copied], a);
> +			_mm512_storeu_si512(&cache_objs[copied + 8], b);
> +			_mm512_storeu_si512(&cache_objs[copied + 16], c);
> +			_mm512_storeu_si512(&cache_objs[copied + 24], d);
> +			copied +=3D 32;
> +		}

Do you have any indications about how this copy loop performs, compared =
to e.g. the 64-byte block copy in rte_memcpy() [1]?

[1]: =
https://github.com/DPDK/dpdk/blob/v26.07-rc4/lib/eal/x86/include/rte_memc=
py.h#L657

I'm wondering if it would be worth adding something similar to the =
mempool library, for speeding up mbuf alloc/free.

> +		cache->len +=3D n;
> +
> +		if (cache->len >=3D cache->flushthresh) {
> +			rte_mempool_ops_enqueue_bulk
> +				(mp, &cache->objs[cache->size],
> +				cache->len - cache->size);
> +			cache->len =3D cache->size;
> +		}
> +		goto done;
> +	}
> +
> +normal:
