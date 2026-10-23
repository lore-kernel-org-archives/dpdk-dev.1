Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2758D606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:44:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3FE5F40A89;
	Fri, 23 Oct 2026 15:44:01 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 1C8CE4069F
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:43:57 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id EFB7B200034;
 Fri, 23 Oct 2026 15:43:56 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BBE4D200020;
 Fri, 23 Oct 2026 15:43:56 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id B87FF18000B7;
 Fri, 23 Oct 2026 21:43:55 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v4-S3 05/65] net/dpaa2: unify debug dump via log based helpers
Date: Fri, 23 Oct 2026 19:12:45 +0530
Message-ID: <20261023134346.37727-6-prashant.gupta_3@nxp.com>
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

The dpaa2 PMD printed debug output through several unrelated paths: the
flow dump used a raw printf, and the Rx error queue dump used
rte_hexdump() straight to stderr with sprintf-built titles. None of
these went through the DPDK logging framework, so they could not be
filtered and bypassed any configured log stream.

Route all debug dumps through the dpaa2 dump helpers instead. Point
DPAA2_FLOW_DUMP at dpaa2_dump_print(), and add a dpaa2_dump_hex_print()
helper that emits a buffer as hex using the same path. Convert the Rx
error packet dump to use these helpers, rename dump_err_pkts() to
dpaa2_dev_rx_err_pkts_dump() for consistency with the other datapath
helpers, use rte_pktmbuf_mtod() for the segment payload, and simplify
the surrounding code.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/net/dpaa2/dpaa2_flow.c     |  4 +--
 drivers/net/dpaa2/dpaa2_pmd_logs.h | 17 ++++++++++
 drivers/net/dpaa2/dpaa2_rxtx.c     | 51 +++++++++++++-----------------
 3 files changed, 41 insertions(+), 31 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_flow.c b/drivers/net/dpaa2/dpaa2_flow.c
index 979ab4cae0..d9ca7211c7 100644
--- a/drivers/net/dpaa2/dpaa2_flow.c
+++ b/drivers/net/dpaa2/dpaa2_flow.c
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright 2018-2022 NXP
+ * Copyright 2018-2026 NXP
  */
 
 #include <sys/queue.h>
@@ -196,7 +196,7 @@ static const struct rte_flow_item_pppoe dpaa2_flow_item_pppoe_mask = {
 #endif
 
 
-#define DPAA2_FLOW_DUMP printf
+#define DPAA2_FLOW_DUMP dpaa2_dump_print
 
 static inline void
 dpaa2_prot_field_string(uint32_t prot, uint32_t field,
diff --git a/drivers/net/dpaa2/dpaa2_pmd_logs.h b/drivers/net/dpaa2/dpaa2_pmd_logs.h
index 8b699bb5af..51fdabf94b 100644
--- a/drivers/net/dpaa2/dpaa2_pmd_logs.h
+++ b/drivers/net/dpaa2/dpaa2_pmd_logs.h
@@ -51,4 +51,21 @@ dpaa2_dump_print(const char *fmt, ...)
 	rte_vlog(RTE_LOG_NOTICE, RTE_LOGTYPE_USER1, fmt, ap);
 	va_end(ap);
 }
+
+#define DPAA2_DUMP_HEX_LINE_SIZE 32
+
+static inline void
+dpaa2_dump_hex_print(const uint8_t *buf, size_t len)
+{
+	size_t i;
+
+	for (i = 0; i < len; i++) {
+		dpaa2_dump_print("%02x ", buf[i]);
+
+		if (!((i + 1) % DPAA2_DUMP_HEX_LINE_SIZE))
+			dpaa2_dump_print("\n");
+	}
+	if (len % DPAA2_DUMP_HEX_LINE_SIZE)
+		dpaa2_dump_print("\n");
+}
 #endif /* _DPAA2_PMD_LOGS_H_ */
diff --git a/drivers/net/dpaa2/dpaa2_rxtx.c b/drivers/net/dpaa2/dpaa2_rxtx.c
index d3512d56f9..060f525233 100644
--- a/drivers/net/dpaa2/dpaa2_rxtx.c
+++ b/drivers/net/dpaa2/dpaa2_rxtx.c
@@ -675,13 +675,14 @@ return 0;
 }
 
 static void
-dump_err_pkts(struct dpaa2_queue *dpaa2_q)
+dpaa2_dev_rx_err_pkts_dump(struct dpaa2_queue *dpaa2_q)
 {
 	/* Function receive frames for a given device and VQ */
 	struct qbman_result *dq_storage;
 	uint32_t fqid = dpaa2_q->fqid;
-	int ret, num_rx = 0;
+	int ret, num_rx = 0, i;
 	uint8_t pending, status;
+	const uint8_t *buf;
 	struct qbman_swp *swp;
 	const struct qbman_fd *fd;
 	struct qbman_pull_desc pulldesc;
@@ -689,15 +690,13 @@ dump_err_pkts(struct dpaa2_queue *dpaa2_q)
 	uint32_t lcore_id = rte_lcore_id();
 	void *v_addr, *hw_annot_addr;
 	struct dpaa2_fas *fas;
-	struct rte_mbuf *mbuf;
-	char title[32];
+	struct rte_mbuf *mbuf, *seg;
 	struct dpaa2_dev_priv *priv = eth_data->dev_private;
 
 	if (unlikely(!DPAA2_PER_LCORE_DPIO)) {
 		ret = dpaa2_affine_qbman_swp();
 		if (ret) {
-			DPAA2_PMD_ERR("Failed to allocate IO portal, tid: %d",
-				rte_gettid());
+			DPAA2_PMD_ERR("Failed to allocate IO portal, tid: %d", rte_gettid());
 			return;
 		}
 	}
@@ -738,8 +737,7 @@ dump_err_pkts(struct dpaa2_queue *dpaa2_q)
 			pending = 0;
 			/* Check for valid frame. */
 			status = qbman_result_DQ_flags(dq_storage);
-			if (unlikely((status &
-				QBMAN_DQ_STAT_VALIDFRAME) == 0))
+			if (unlikely(!(status & QBMAN_DQ_STAT_VALIDFRAME)))
 				continue;
 		}
 		fd = qbman_result_DQ_fd(dq_storage);
@@ -759,27 +757,22 @@ dump_err_pkts(struct dpaa2_queue *dpaa2_q)
 			DPAA2_GET_FD_OFFSET(fd), DPAA2_GET_FD_ERR(fd),
 			fas->status);
 
-		if (mbuf) {
-			__rte_mbuf_sanity_check(mbuf, 1);
-			if (mbuf->nb_segs > 1) {
-				struct rte_mbuf *seg = mbuf;
-				int i = 0;
-
-				while (seg) {
-					sprintf(title, "Payload seg[%d]", i);
-					rte_hexdump(stderr, title,
-						(char *)seg->buf_addr + seg->data_off,
-						seg->data_len);
-					seg = seg->next;
-					i++;
-				}
-			} else {
-				rte_hexdump(stderr, "Payload",
-					(char *)mbuf->buf_addr + mbuf->data_off,
-					mbuf->data_len);
+		__rte_mbuf_sanity_check(mbuf, 1);
+		if (mbuf->nb_segs > 1) {
+			seg = mbuf;
+			i = 0;
+			while (seg) {
+				buf = rte_pktmbuf_mtod(seg, const uint8_t *);
+				dpaa2_dump_print("Payload seg[%d]\n", i);
+				dpaa2_dump_hex_print(buf, seg->data_len);
+				seg = seg->next;
+				i++;
 			}
-			rte_pktmbuf_free(mbuf);
+		} else {
+			buf = rte_pktmbuf_mtod(mbuf, const uint8_t *);
+			dpaa2_dump_hex_print(buf, mbuf->data_len);
 		}
+		rte_pktmbuf_free(mbuf);
 		dq_storage++;
 		num_rx++;
 	} while (pending);
@@ -812,7 +805,7 @@ dpaa2_dev_prefetch_rx_common(void *queue, struct rte_mbuf **bufs,
 	q_storage = dpaa2_q->q_storage[rte_lcore_id()];
 
 	if (unlikely(priv->flags & DPAA2_RX_ERROR_QUEUE_FLAG))
-		dump_err_pkts(priv->rx_err_vq);
+		dpaa2_dev_rx_err_pkts_dump(priv->rx_err_vq);
 
 	if (unlikely(!DPAA2_PER_LCORE_ETHRX_DPIO)) {
 		ret = dpaa2_affine_qbman_ethrx_swp();
@@ -1080,7 +1073,7 @@ dpaa2_dev_rx_common(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts,
 	struct dpaa2_dev_priv *priv = eth_data->dev_private;
 
 	if (!by_channel && unlikely(priv->flags & DPAA2_RX_ERROR_QUEUE_FLAG))
-		dump_err_pkts(priv->rx_err_vq);
+		dpaa2_dev_rx_err_pkts_dump(priv->rx_err_vq);
 
 	if (by_channel) {
 		if (unlikely(!DPAA2_PER_LCORE_ETHRX_DPIO)) {
-- 
2.43.0

