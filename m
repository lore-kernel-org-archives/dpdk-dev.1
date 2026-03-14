Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2E6107BCFE
	for <dpdk-dev@archiver.kernel.org>; Sat, 14 Mar 2026 07:41:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B4C6402A3;
	Sat, 14 Mar 2026 08:41:31 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 6A7374027B
 for <dev@dpdk.org>; Sat, 14 Mar 2026 08:41:30 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 3BB8223F9D;
 Sat, 14 Mar 2026 08:41:30 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Intel PMD fast free layer violation
Date: Sat, 14 Mar 2026 08:41:27 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65793@smartserver.smartshare.dk>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
X-MimeOLE: Produced By Microsoft Exchange V6.5
Thread-Topic: Intel PMD fast free layer violation
Thread-Index: AdyzhfdZrcWVl7kpTV6fZ4ADhrzneA==
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>
Cc: <dev@dpdk.org>
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

Bruce,

I haven't looked at the Next-net-intel tree, so it might already have =
been fixed...

ci_tx_free_bufs_vec() in drivers/net/intel/common/tx.h has:

	/* is fast-free enabled? */
	struct rte_mempool *mp =3D
			likely(txq->fast_free_mp !=3D (void *)UINTPTR_MAX) ?
			txq->fast_free_mp :
			(txq->fast_free_mp =3D txep[0].mbuf->pool);

	if (mp !=3D NULL && (n & 31) =3D=3D 0) {
		void **cache_objs;
		struct rte_mempool_cache *cache =3D rte_mempool_default_cache(mp, =
rte_lcore_id());

		if (cache =3D=3D NULL)
			goto normal;

		cache_objs =3D &cache->objs[cache->len];

		if (n > RTE_MEMPOOL_CACHE_MAX_SIZE) {
			rte_mempool_ops_enqueue_bulk(mp, (void *)txep, n);
			goto done;
		}

		/* The cache follows the following algorithm
		 *   1. Add the objects to the cache
		 *   2. Anything greater than the cache min value (if it
		 *   crosses the cache flush threshold) is flushed to the ring.
		 */
		/* Add elements back into the cache */
		uint32_t copied =3D 0;
		/* n is multiple of 32 */
		while (copied < n) {
			memcpy(&cache_objs[copied], &txep[copied], 32 * sizeof(void *));
			copied +=3D 32;
		}
		cache->len +=3D n;

		if (cache->len >=3D cache->flushthresh) {
			rte_mempool_ops_enqueue_bulk(mp, &cache->objs[cache->size],
					cache->len - cache->size);
			cache->len =3D cache->size;
		}
		goto done;
	}

It should be replaced by:

	/* is fast-free enabled? */
	struct rte_mempool *mp =3D
			likely(txq->fast_free_mp !=3D (void *)UINTPTR_MAX) ?
			txq->fast_free_mp :
			(txq->fast_free_mp =3D txep[0].mbuf->pool);

	if (mp !=3D NULL) {
		rte_mbuf_raw_free_bulk(mp, txep, n);
		goto done;
	}

This removes a layer violation and adds the missing mbuf sanity checks =
and mbuf history marks due to that layer violation.
And it implements fast-free for bulks not a multiple of 32.

Venlig hilsen / Kind regards,
-Morten Br=F8rup

