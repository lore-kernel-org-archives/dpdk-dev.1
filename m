Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD1EC5AE59
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Jun 2025 17:16:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9721E40283;
	Thu,  5 Jun 2025 19:16:45 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 6DE3540150
 for <dev@dpdk.org>; Thu,  5 Jun 2025 19:16:43 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 2EAE820467;
 Thu,  5 Jun 2025 19:16:43 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Intel NIC mbuf fast free
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Thu, 5 Jun 2025 19:16:39 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FCCE@smartserver.smartshare.dk>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Intel NIC mbuf fast free
Thread-Index: AdvWPZl3JFoIFYWKQH2FZuzvP12Hpg==
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Anatoly Burakov" <anatoly.burakov@intel.com>
Cc: "Bruce Richardson" <bruce.richardson@intel.com>,
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

Anatoly,

I noticed you are consolidating the Intel NIC drivers into common code, =
which is good.

While you are at it, please also consider replacing some ancient code =
with functions doing the same:
https://git.dpdk.org/dpdk/tree/drivers/net/intel/common/tx.h#n157

Something like (untested):

static __rte_always_inline int
ci_tx_free_bufs_vec(struct ci_tx_queue *txq, ci_desc_done_fn desc_done, =
bool ctx_descs)
{
	int nb_free =3D 0;
	struct rte_mbuf *free[IETH_VPMD_TX_MAX_FREE_BUF];
	struct rte_mbuf *m;

	/* check DD bits on threshold descriptor */
	if (!desc_done(txq, txq->tx_next_dd))
		return 0;

	const uint32_t n =3D txq->tx_rs_thresh >> ctx_descs;

	/* first buffer to free from S/W ring is at index
	 * tx_next_dd - (tx_rs_thresh - 1)
	 */
	struct ci_tx_entry_vec *txep =3D txq->sw_ring_vec;
	txep +=3D (txq->tx_next_dd >> ctx_descs) - (n - 1);

-	if (txq->offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE && (n & 31) =
=3D=3D 0) {
-		struct rte_mempool *mp =3D txep[0].mbuf->pool;
-		void **cache_objs;
-		struct rte_mempool_cache *cache =3D rte_mempool_default_cache(mp, =
rte_lcore_id());
-
-		if (cache =3D=3D NULL)
-			goto normal;
-
-		cache_objs =3D &cache->objs[cache->len];
-
-		if (n > RTE_MEMPOOL_CACHE_MAX_SIZE) {
-			rte_mempool_ops_enqueue_bulk(mp, (void *)txep, n);
-			goto done;
-		}
-
-		/* The cache follows the following algorithm
-		 *   1. Add the objects to the cache
-		 *   2. Anything greater than the cache min value (if it
-		 *   crosses the cache flush threshold) is flushed to the ring.
-		 */
-		/* Add elements back into the cache */
-		uint32_t copied =3D 0;
-		/* n is multiple of 32 */
-		while (copied < n) {
-			memcpy(&cache_objs[copied], &txep[copied], 32 * sizeof(void *));
-			copied +=3D 32;
-		}
-		cache->len +=3D n;
-
-		if (cache->len >=3D cache->flushthresh) {
-			rte_mempool_ops_enqueue_bulk(mp, &cache->objs[cache->size],
-					cache->len - cache->size);
-			cache->len =3D cache->size;
-		}
-		goto done;
-	}
-
-normal:
-	m =3D rte_pktmbuf_prefree_seg(txep[0].mbuf);
-	if (likely(m)) {
-		free[0] =3D m;
-		nb_free =3D 1;
-		for (uint32_t i =3D 1; i < n; i++) {
-			m =3D rte_pktmbuf_prefree_seg(txep[i].mbuf);
-			if (likely(m)) {
-				if (likely(m->pool =3D=3D free[0]->pool)) {
-					free[nb_free++] =3D m;
-				} else {
-					rte_mempool_put_bulk(free[0]->pool, (void *)free, nb_free);
-					free[0] =3D m;
-					nb_free =3D 1;
-				}
-			}
-		}
-		rte_mempool_put_bulk(free[0]->pool, (void **)free, nb_free);
-	} else {
-		for (uint32_t i =3D 1; i < n; i++) {
-			m =3D rte_pktmbuf_prefree_seg(txep[i].mbuf);
-			if (m)
-				rte_mempool_put(m->pool, m);
-		}
-	}
-
-done:
+	if (txq->offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE)
+		rte_mempool_put_bulk(txep[0].mbuf->pool, (void **)txep, n);
+	else
+		rte_pktmbuf_free_bulk((void **)txep, n);
+
	/* buffers were freed, update counters */
	txq->nb_tx_free =3D (uint16_t)(txq->nb_tx_free + txq->tx_rs_thresh);
	txq->tx_next_dd =3D (uint16_t)(txq->tx_next_dd + txq->tx_rs_thresh);
	if (txq->tx_next_dd >=3D txq->nb_tx_desc)
		txq->tx_next_dd =3D (uint16_t)(txq->tx_rs_thresh - 1);

	return txq->tx_rs_thresh;
}

Note:
My suggestion relies on the ci_tx_entry_vec structure effectively being =
the same as an mbuf pointer.
The existing code path for RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE also relies =
on this.


-Morten

