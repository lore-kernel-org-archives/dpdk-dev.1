Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDADCCD183
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 10:29:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C3D0B427C4;
	Thu, 16 Oct 2025 12:28:26 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id AACA741157
 for <dev@dpdk.org>; Thu, 16 Oct 2025 12:28:12 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 906651A271F;
 Thu, 16 Oct 2025 12:28:12 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5B49D1A26F1;
 Thu, 16 Oct 2025 12:28:12 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id DE563180007B;
 Thu, 16 Oct 2025 18:28:11 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: dev@dpdk.org,
	stephen@networkplumber.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v2 13/15] net/dpaa2: optimize to prefetch next parser result
Date: Thu, 16 Oct 2025 15:58:03 +0530
Message-ID: <20251016102805.2453687-14-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251016102805.2453687-1-prashant.gupta_3@nxp.com>
References: <20251014064035.1312896-1-prashant.gupta_3@nxp.com>
 <20251016102805.2453687-1-prashant.gupta_3@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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

From: Jun Yang <jun.yang@nxp.com>

Prefetch next parser result for either VA or PA mode.
This prefetch doesn't perform on LX2160A.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/net/dpaa2/dpaa2_rxtx.c | 64 ++++++++++++++++------------------
 1 file changed, 30 insertions(+), 34 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_rxtx.c b/drivers/net/dpaa2/dpaa2_rxtx.c
index 2b55165361..7cbd3f33ae 100644
--- a/drivers/net/dpaa2/dpaa2_rxtx.c
+++ b/drivers/net/dpaa2/dpaa2_rxtx.c
@@ -525,6 +525,23 @@ eth_mbuf_to_sg_fd(struct rte_mbuf *mbuf,
 	return 0;
 }
 
+static inline void
+dpaa2_dev_prefetch_next_psr(const struct qbman_result *dq)
+{
+	const struct qbman_fd *fd;
+	const struct dpaa2_annot_hdr *annotation;
+	uint64_t annot_iova;
+
+	dq++;
+
+	fd = qbman_result_DQ_fd(dq);
+	annot_iova = DPAA2_GET_FD_ADDR(fd) + DPAA2_FD_PTA_SIZE;
+	annotation = DPAA2_IOVA_TO_VADDR(annot_iova);
+
+	/** Prefetch from word3 to parse next header.*/
+	rte_prefetch0(&annotation->word3);
+}
+
 static void
 eth_mbuf_to_fd(struct rte_mbuf *mbuf,
 	       struct qbman_fd *fd,
@@ -850,18 +867,11 @@ dpaa2_dev_prefetch_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 			if (unlikely((status & QBMAN_DQ_STAT_VALIDFRAME) == 0))
 				continue;
 		}
-		fd = qbman_result_DQ_fd(dq_storage);
-
-#ifndef RTE_LIBRTE_DPAA2_USE_PHYS_IOVA
-		if (dpaa2_svr_family != SVR_LX2160A) {
-			const struct qbman_fd *next_fd =
-				qbman_result_DQ_fd(dq_storage + 1);
-			/* Prefetch Annotation address for the parse results */
-			rte_prefetch0(DPAA2_IOVA_TO_VADDR((DPAA2_GET_FD_ADDR(
-				next_fd) + DPAA2_FD_PTA_SIZE + 16)));
-		}
-#endif
+		if (dpaa2_svr_family != SVR_LX2160A)
+			/** Packet type is parsed from FRC for LX2160A.*/
+			dpaa2_dev_prefetch_next_psr(dq_storage);
 
+		fd = qbman_result_DQ_fd(dq_storage);
 		if (unlikely(DPAA2_FD_GET_FORMAT(fd) == qbman_fd_sg))
 			bufs[num_rx] = eth_sg_fd_to_mbuf(fd, eth_data->port_id);
 		else
@@ -1064,22 +1074,11 @@ dpaa2_dev_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 					QBMAN_DQ_STAT_VALIDFRAME) == 0))
 					continue;
 			}
-			fd = qbman_result_DQ_fd(dq_storage);
-
-#ifndef RTE_LIBRTE_DPAA2_USE_PHYS_IOVA
-			if (dpaa2_svr_family != SVR_LX2160A) {
-				const struct qbman_fd *next_fd =
-					qbman_result_DQ_fd(dq_storage + 1);
-
-				/* Prefetch Annotation address for the parse
-				 * results.
-				 */
-				rte_prefetch0((DPAA2_IOVA_TO_VADDR(
-					DPAA2_GET_FD_ADDR(next_fd) +
-					DPAA2_FD_PTA_SIZE + 16)));
-			}
-#endif
+			if (dpaa2_svr_family != SVR_LX2160A)
+				/** Packet type is parsed from FRC for LX2160A.*/
+				dpaa2_dev_prefetch_next_psr(dq_storage);
 
+			fd = qbman_result_DQ_fd(dq_storage);
 			if (unlikely(DPAA2_FD_GET_FORMAT(fd) == qbman_fd_sg))
 				bufs[num_rx] = eth_sg_fd_to_mbuf(fd,
 							eth_data->port_id);
@@ -1120,7 +1119,7 @@ uint16_t dpaa2_dev_tx_conf(void *queue)
 	int ret, num_tx_conf = 0, num_pulled;
 	uint8_t pending, status;
 	struct qbman_swp *swp;
-	const struct qbman_fd *fd, *next_fd;
+	const struct qbman_fd *fd;
 	struct qbman_pull_desc pulldesc;
 	struct qbman_release_desc releasedesc;
 	uint32_t bpid;
@@ -1188,14 +1187,11 @@ uint16_t dpaa2_dev_tx_conf(void *queue)
 					QBMAN_DQ_STAT_VALIDFRAME) == 0))
 					continue;
 			}
-			fd = qbman_result_DQ_fd(dq_storage);
-
-			next_fd = qbman_result_DQ_fd(dq_storage + 1);
-			/* Prefetch Annotation address for the parse results */
-			rte_prefetch0((void *)(size_t)
-				(DPAA2_GET_FD_ADDR(next_fd) +
-				 DPAA2_FD_PTA_SIZE + 16));
+			if (dpaa2_svr_family != SVR_LX2160A)
+				/** Packet type is parsed from FRC for LX2160A.*/
+				dpaa2_dev_prefetch_next_psr(dq_storage);
 
+			fd = qbman_result_DQ_fd(dq_storage);
 			bpid = DPAA2_GET_FD_BPID(fd);
 
 			/* Create a release descriptor required for releasing
-- 
2.43.0

