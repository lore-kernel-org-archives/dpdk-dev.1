Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E45CA0EFA
	for <dpdk-dev@archiver.kernel.org>; Sat, 23 Aug 2025 06:30:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DF4E940E40;
	Sat, 23 Aug 2025 08:30:15 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 84F19402D8
 for <dev@dpdk.org>; Sat, 23 Aug 2025 08:30:10 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 1A50F22D5D;
 Sat, 23 Aug 2025 08:30:10 +0200 (CEST)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Sat, 23 Aug 2025 08:30:09 +0200
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Ivan Malov <ivan.malov@arknetworks.am>,
 Chengwen Feng <fengchengwen@huawei.com>
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH v8 3/3] mbuf: optimize reset of reinitialized mbufs
Date: Sat, 23 Aug 2025 06:30:02 +0000
Message-ID: <20250823063002.24326-4-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250823063002.24326-1-mb@smartsharesystems.com>
References: <20250821150250.16959-1-mb@smartsharesystems.com>
 <20250823063002.24326-1-mb@smartsharesystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 23 Aug 2025 06:30:09.0390 (UTC)
 FILETIME=[5F7930E0:01DC13F7]
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

An optimized function for resetting a bulk of newly allocated
reinitialized mbufs (a.k.a. raw mbufs) was added.

Compared to the normal packet mbuf reset function, it takes advantage of
the following two details:
1. The 'next' and 'nb_segs' fields are already reset, so resetting them
has been omitted.
2. When resetting the mbuf, the 'ol_flags' field must indicate whether the
mbuf uses an external buffer, and the 'data_off' field must not exceed the
data room size when resetting the data offset to include the default
headroom.
Unlike the normal packet mbuf reset function, which reads the mbuf itself
to get the information required for resetting these two fields, this
function gets the information from the mempool.

This makes the function write-only of the mbuf, unlike the normal packet
mbuf reset function, which is read-modify-write of the mbuf.

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
---
 lib/mbuf/rte_mbuf.h | 74 ++++++++++++++++++++++++++++-----------------
 1 file changed, 46 insertions(+), 28 deletions(-)

diff --git a/lib/mbuf/rte_mbuf.h b/lib/mbuf/rte_mbuf.h
index 49c93ab356..6f37a2e91e 100644
--- a/lib/mbuf/rte_mbuf.h
+++ b/lib/mbuf/rte_mbuf.h
@@ -954,6 +954,50 @@ static inline void rte_pktmbuf_reset_headroom(struct rte_mbuf *m)
 					(uint16_t)m->buf_len);
 }
 
+/**
+ * Reset the fields of a bulk of packet mbufs to their default values.
+ *
+ * The caller must ensure that the mbufs come from the specified mempool,
+ * are direct and properly reinitialized (refcnt=1, next=NULL, nb_segs=1),
+ * as done by rte_pktmbuf_prefree_seg().
+ *
+ * This function should be used with care, when optimization is required.
+ * For standard needs, prefer rte_pktmbuf_reset().
+ *
+ * @param mp
+ *   The mempool to which the mbuf belongs.
+ * @param mbufs
+ *   Array of pointers to packet mbufs.
+ *   The array must not contain NULL pointers.
+ * @param count
+ *   Array size.
+ */
+static inline void
+rte_mbuf_raw_reset_bulk(struct rte_mempool *mp, struct rte_mbuf **mbufs, unsigned int count)
+{
+	uint64_t ol_flags = (rte_pktmbuf_priv_flags(mp) & RTE_PKTMBUF_POOL_F_PINNED_EXT_BUF) ?
+			RTE_MBUF_F_EXTERNAL : 0;
+	uint16_t data_off = RTE_MIN_T(RTE_PKTMBUF_HEADROOM, rte_pktmbuf_data_room_size(mp),
+			uint16_t);
+
+	for (unsigned int idx = 0; idx < count; idx++) {
+		struct rte_mbuf *m = mbufs[idx];
+
+		m->pkt_len = 0;
+		m->tx_offload = 0;
+		m->vlan_tci = 0;
+		m->vlan_tci_outer = 0;
+		m->port = RTE_MBUF_PORT_INVALID;
+
+		m->ol_flags = ol_flags;
+		m->packet_type = 0;
+		m->data_off = data_off;
+
+		m->data_len = 0;
+		__rte_mbuf_sanity_check(m, 1);
+	}
+}
+
 /**
  * Reset the fields of a packet mbuf to their default values.
  *
@@ -997,7 +1041,7 @@ static inline struct rte_mbuf *rte_pktmbuf_alloc(struct rte_mempool *mp)
 {
 	struct rte_mbuf *m;
 	if ((m = rte_mbuf_raw_alloc(mp)) != NULL)
-		rte_pktmbuf_reset(m);
+		rte_mbuf_raw_reset_bulk(mp, &m, 1);
 	return m;
 }
 
@@ -1018,38 +1062,12 @@ static inline struct rte_mbuf *rte_pktmbuf_alloc(struct rte_mempool *mp)
 static inline int rte_pktmbuf_alloc_bulk(struct rte_mempool *pool,
 	 struct rte_mbuf **mbufs, unsigned count)
 {
-	unsigned idx = 0;
 	int rc;
 
 	rc = rte_mbuf_raw_alloc_bulk(pool, mbufs, count);
 	if (unlikely(rc))
 		return rc;
-
-	/* To understand duff's device on loop unwinding optimization, see
-	 * https://en.wikipedia.org/wiki/Duff's_device.
-	 * Here while() loop is used rather than do() while{} to avoid extra
-	 * check if count is zero.
-	 */
-	switch (count % 4) {
-	case 0:
-		while (idx != count) {
-			rte_pktmbuf_reset(mbufs[idx]);
-			idx++;
-			/* fall-through */
-	case 3:
-			rte_pktmbuf_reset(mbufs[idx]);
-			idx++;
-			/* fall-through */
-	case 2:
-			rte_pktmbuf_reset(mbufs[idx]);
-			idx++;
-			/* fall-through */
-	case 1:
-			rte_pktmbuf_reset(mbufs[idx]);
-			idx++;
-			/* fall-through */
-		}
-	}
+	rte_mbuf_raw_reset_bulk(pool, mbufs, count);
 	return 0;
 }
 
-- 
2.43.0

