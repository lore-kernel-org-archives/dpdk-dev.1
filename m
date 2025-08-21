Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E197ACA0EF8
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 Aug 2025 15:03:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 53EC440664;
	Thu, 21 Aug 2025 17:02:57 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 2375A402B1
 for <dev@dpdk.org>; Thu, 21 Aug 2025 17:02:53 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 03B42215A3;
 Thu, 21 Aug 2025 17:02:53 +0200 (CEST)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Thu, 21 Aug 2025 17:02:52 +0200
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Ivan Malov <ivan.malov@arknetworks.am>,
 Chengwen Feng <fengchengwen@huawei.com>
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH v5 3/3] mbuf: no need to reset all fields on reinitialized
 mbufs
Date: Thu, 21 Aug 2025 15:02:50 +0000
Message-ID: <20250821150250.16959-4-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250821150250.16959-1-mb@smartsharesystems.com>
References: <20250821150250.16959-1-mb@smartsharesystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 21 Aug 2025 15:02:52.0666 (UTC)
 FILETIME=[AAFD15A0:01DC12AC]
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
such mbufs was added.

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
---
 lib/mbuf/rte_mbuf.h | 39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/lib/mbuf/rte_mbuf.h b/lib/mbuf/rte_mbuf.h
index 49c93ab356..3517ca6858 100644
--- a/lib/mbuf/rte_mbuf.h
+++ b/lib/mbuf/rte_mbuf.h
@@ -954,6 +954,35 @@ static inline void rte_pktmbuf_reset_headroom(struct rte_mbuf *m)
 					(uint16_t)m->buf_len);
 }
 
+/**
+ * Reset the fields of a packet mbuf to their default values.
+ *
+ * The caller must ensure that the mbuf is direct and properly
+ * reinitialized (refcnt=1, next=NULL, nb_segs=1), as done by
+ * rte_pktmbuf_prefree_seg().
+ *
+ * This function should be used with care, when optimization is required.
+ * For standard needs, prefer rte_pktmbuf_reset().
+ *
+ * @param m
+ *   The packet mbuf to be reset.
+ */
+static inline void rte_mbuf_raw_reset(struct rte_mbuf *m)
+{
+	m->pkt_len = 0;
+	m->tx_offload = 0;
+	m->vlan_tci = 0;
+	m->vlan_tci_outer = 0;
+	m->port = RTE_MBUF_PORT_INVALID;
+
+	m->ol_flags &= RTE_MBUF_F_EXTERNAL;
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
@@ -997,7 +1026,7 @@ static inline struct rte_mbuf *rte_pktmbuf_alloc(struct rte_mempool *mp)
 {
 	struct rte_mbuf *m;
 	if ((m = rte_mbuf_raw_alloc(mp)) != NULL)
-		rte_pktmbuf_reset(m);
+		rte_mbuf_raw_reset(m);
 	return m;
 }
 
@@ -1033,19 +1062,19 @@ static inline int rte_pktmbuf_alloc_bulk(struct rte_mempool *pool,
 	switch (count % 4) {
 	case 0:
 		while (idx != count) {
-			rte_pktmbuf_reset(mbufs[idx]);
+			rte_mbuf_raw_reset(mbufs[idx]);
 			idx++;
 			/* fall-through */
 	case 3:
-			rte_pktmbuf_reset(mbufs[idx]);
+			rte_mbuf_raw_reset(mbufs[idx]);
 			idx++;
 			/* fall-through */
 	case 2:
-			rte_pktmbuf_reset(mbufs[idx]);
+			rte_mbuf_raw_reset(mbufs[idx]);
 			idx++;
 			/* fall-through */
 	case 1:
-			rte_pktmbuf_reset(mbufs[idx]);
+			rte_mbuf_raw_reset(mbufs[idx]);
 			idx++;
 			/* fall-through */
 		}
-- 
2.43.0

