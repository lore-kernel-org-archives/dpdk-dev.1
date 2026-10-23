Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0237E606A31B
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:47:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 81EB140EDF;
	Fri, 23 Oct 2026 15:44:39 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id A0C7F40E3B
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:44:27 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 84865200041;
 Fri, 23 Oct 2026 15:44:27 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4FC2420003F;
 Fri, 23 Oct 2026 15:44:27 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id D7D3918000B6;
 Fri, 23 Oct 2026 21:44:25 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v4-S3 32/65] event/dpaa2: fix Tx adapter enqueue for mixed
 destinations
Date: Fri, 23 Oct 2026 19:13:12 +0530
Message-ID: <20261023134346.37727-33-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023134346.37727-1-prashant.gupta_3@nxp.com>
References: <20260915120208.4185877-1-prashant.gupta_3@nxp.com>
 <20261023134346.37727-1-prashant.gupta_3@nxp.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jun Yang <jun.yang@nxp.com>

The "same destination" Tx adapter enqueue path assumed every event in a
burst targeted the same ethdev port and Tx queue, reading the port and
queue id only from the first mbuf (ev[0]) and pushing the whole burst
with rte_eth_tx_burst() to that single destination.

This assumption does not always hold: an event burst may carry mbufs
bound for different ports or queues. In that case, packets destined for
other ports/queues were sent to the destination of the first mbuf,
causing misdirected transmission.

Make the generic enqueue handler, which resolves the port and Tx queue
per mbuf and transmits through dpaa2_dev_tx_multi_txq_ordered(), the sole
implementation. The same-destination variant now simply forwards to it,
so both callbacks handle mixed destinations correctly.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/event/dpaa2/dpaa2_eventdev.c | 45 ++++++++--------------------
 1 file changed, 12 insertions(+), 33 deletions(-)

diff --git a/drivers/event/dpaa2/dpaa2_eventdev.c b/drivers/event/dpaa2/dpaa2_eventdev.c
index 03016d2a12..78a069b456 100644
--- a/drivers/event/dpaa2/dpaa2_eventdev.c
+++ b/drivers/event/dpaa2/dpaa2_eventdev.c
@@ -983,28 +983,28 @@ dpaa2_eventdev_tx_adapter_caps(const struct rte_eventdev *dev,
 }
 
 static uint16_t
-dpaa2_eventdev_txa_enqueue_same_dest(void *port,
+dpaa2_eventdev_txa_enqueue(void *port,
 	struct rte_event ev[], uint16_t nb_events)
 {
-	struct rte_mbuf *m[MAX_TX_RING_SLOTS], *m0;
-	uint16_t sent = 0, burst, i, port_id;
-	uint8_t qid;
+	void *txq[MAX_TX_RING_SLOTS];
+	struct rte_mbuf *m[MAX_TX_RING_SLOTS];
+	uint16_t sent = 0, burst, i, port_id, qid;
 
 	RTE_SET_USED(port);
 
-	m0 = ev[0].mbuf;
-	qid = rte_event_eth_tx_adapter_txq_get(m0);
-	port_id = m0->port;
-
 	/* The advertised enqueue depth is the EQCR size, which may exceed the
 	 * on-stack burst array, so transmit in ring-sized chunks.
 	 */
 	while (sent < nb_events) {
 		burst = RTE_MIN(nb_events - sent, (uint16_t)RTE_DIM(m));
-		for (i = 0; i < burst; i++)
+		for (i = 0; i < burst; i++) {
 			m[i] = ev[sent + i].mbuf;
+			port_id = m[i]->port;
+			qid = rte_event_eth_tx_adapter_txq_get(m[i]);
+			txq[i] = rte_eth_devices[port_id].data->tx_queues[qid];
+		}
 
-		i = rte_eth_tx_burst(port_id, qid, m, burst);
+		i = dpaa2_dev_tx_multi_txq_ordered(txq, m, burst);
 		sent += i;
 		if (i < burst)
 			break;
@@ -1014,31 +1014,10 @@ dpaa2_eventdev_txa_enqueue_same_dest(void *port,
 }
 
 static uint16_t
-dpaa2_eventdev_txa_enqueue(void *port,
+dpaa2_eventdev_txa_enqueue_same_dest(void *port,
 	struct rte_event ev[], uint16_t nb_events)
 {
-	void *txq[MAX_TX_RING_SLOTS];
-	struct rte_mbuf *m[MAX_TX_RING_SLOTS];
-	uint16_t sent = 0, burst, i;
-	uint8_t qid;
-
-	RTE_SET_USED(port);
-
-	while (sent < nb_events) {
-		burst = RTE_MIN(nb_events - sent, (uint16_t)RTE_DIM(m));
-		for (i = 0; i < burst; i++) {
-			m[i] = ev[sent + i].mbuf;
-			qid = rte_event_eth_tx_adapter_txq_get(m[i]);
-			txq[i] = rte_eth_devices[m[i]->port].data->tx_queues[qid];
-		}
-
-		i = dpaa2_dev_tx_multi_txq_ordered(txq, m, burst);
-		sent += i;
-		if (i < burst)
-			break;
-	}
-
-	return sent;
+	return dpaa2_eventdev_txa_enqueue(port, ev, nb_events);
 }
 
 static struct eventdev_ops dpaa2_eventdev_ops = {
-- 
2.43.0

