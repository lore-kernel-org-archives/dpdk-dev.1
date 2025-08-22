Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5316CA0EFF
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 Aug 2025 12:47:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AF89540297;
	Fri, 22 Aug 2025 14:47:43 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 2228140297
 for <dev@dpdk.org>; Fri, 22 Aug 2025 14:47:40 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id EE38E216FD;
 Fri, 22 Aug 2025 14:47:39 +0200 (CEST)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Fri, 22 Aug 2025 14:47:39 +0200
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Ivan Malov <ivan.malov@arknetworks.am>,
 Chengwen Feng <fengchengwen@huawei.com>
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH v6 3/3] mbuf: no need to reset all fields on reinitialized
 mbufs
Date: Fri, 22 Aug 2025 12:47:31 +0000
Message-ID: <20250822124731.20633-4-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822124731.20633-1-mb@smartsharesystems.com>
References: <20250821150250.16959-1-mb@smartsharesystems.com>
 <20250822124731.20633-1-mb@smartsharesystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 22 Aug 2025 12:47:39.0659 (UTC)
 FILETIME=[F1AC35B0:01DC1362]
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

The 'next' and 'nb_segs' fields are already reset on newly allocated
reinitialized mbufs (a.k.a. raw mbufs), so a simpler reset function for
reinitialized mbufs was added.

The 'ol_flags' field must indicate whether the mbuf uses an external
buffer.
Unlike the normal packet mbuf reset function, which gets this information
from the mbuf itself (by masking the RTE_MBUF_F_EXTERNAL flag), the
simpler reset function gets this information from the mempool, thereby
reducing the number of read-modify-writes on the mbuf from two to one.
The remaining read-modify-write on the mbuf in the simpler reset function
is in rte_pktmbuf_reset_headroom(), where the 'buf_len' field is read
before writing the 'data_off' field.
And I am hoping that it will be possible to eliminate that one too.

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
---
 lib/mbuf/rte_mbuf.h | 43 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/lib/mbuf/rte_mbuf.h b/lib/mbuf/rte_mbuf.h
index 49c93ab356..92a1e8ba7e 100644
--- a/lib/mbuf/rte_mbuf.h
+++ b/lib/mbuf/rte_mbuf.h
@@ -954,6 +954,39 @@ static inline void rte_pktmbuf_reset_headroom(struct rte_mbuf *m)
 					(uint16_t)m->buf_len);
 }
 
+/**
+ * Reset the fields of a packet mbuf to their default values.
+ *
+ * The caller must ensure that the mbuf comes from the specified mempool,
+ * is direct and properly reinitialized (refcnt=1, next=NULL, nb_segs=1),
+ * as done by rte_pktmbuf_prefree_seg().
+ *
+ * This function should be used with care, when optimization is required.
+ * For standard needs, prefer rte_pktmbuf_reset().
+ *
+ * @param mp
+ *   The mempool to which the mbuf belongs.
+ * @param m
+ *   The packet mbuf to be reset.
+ */
+static inline void rte_mbuf_raw_reset(struct rte_mempool *mp, struct rte_mbuf *m)
+{
+	uint32_t flags = rte_pktmbuf_priv_flags(mp);
+
+	m->pkt_len = 0;
+	m->tx_offload = 0;
+	m->vlan_tci = 0;
+	m->vlan_tci_outer = 0;
+	m->port = RTE_MBUF_PORT_INVALID;
+
+	m->ol_flags = (flags & RTE_PKTMBUF_POOL_F_PINNED_EXT_BUF) ? RTE_MBUF_F_EXTERNAL : 0;
+	m->packet_type = 0;
+	rte_pktmbuf_reset_headroom(m);
+
+	m->data_len = 0;
+	__rte_mbuf_sanity_check(m, 1);
+}
+
 /**
  * Reset the fields of a packet mbuf to their default values.
  *
@@ -997,7 +1030,7 @@ static inline struct rte_mbuf *rte_pktmbuf_alloc(struct rte_mempool *mp)
 {
 	struct rte_mbuf *m;
 	if ((m = rte_mbuf_raw_alloc(mp)) != NULL)
-		rte_pktmbuf_reset(m);
+		rte_mbuf_raw_reset(mp, m);
 	return m;
 }
 
@@ -1033,19 +1066,19 @@ static inline int rte_pktmbuf_alloc_bulk(struct rte_mempool *pool,
 	switch (count % 4) {
 	case 0:
 		while (idx != count) {
-			rte_pktmbuf_reset(mbufs[idx]);
+			rte_mbuf_raw_reset(pool, mbufs[idx]);
 			idx++;
 			/* fall-through */
 	case 3:
-			rte_pktmbuf_reset(mbufs[idx]);
+			rte_mbuf_raw_reset(pool, mbufs[idx]);
 			idx++;
 			/* fall-through */
 	case 2:
-			rte_pktmbuf_reset(mbufs[idx]);
+			rte_mbuf_raw_reset(pool, mbufs[idx]);
 			idx++;
 			/* fall-through */
 	case 1:
-			rte_pktmbuf_reset(mbufs[idx]);
+			rte_mbuf_raw_reset(pool, mbufs[idx]);
 			idx++;
 			/* fall-through */
 		}
-- 
2.43.0

