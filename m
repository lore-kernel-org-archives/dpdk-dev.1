Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3170FC5B56A
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Aug 2026 11:59:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D499427C1;
	Tue, 11 Aug 2026 13:58:08 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 9E86C427C0
 for <dev@dpdk.org>; Tue, 11 Aug 2026 13:58:04 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 819362001A0;
 Tue, 11 Aug 2026 13:58:04 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4B480200190;
 Tue, 11 Aug 2026 13:58:04 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id C34C618000B0;
 Tue, 11 Aug 2026 19:58:02 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v8 23/26] drivers: improve shutdown fq with channel
Date: Tue, 11 Aug 2026 17:27:28 +0530
Message-Id: <20260811115731.3421032-24-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260811115731.3421032-1-hemant.agrawal@nxp.com>
References: <20260703124950.1895871-1-hemant.agrawal@nxp.com>
 <20260811115731.3421032-1-hemant.agrawal@nxp.com>
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

Fix hardcode of channel by parsing dts and shutdown
fq according to channel type.
Clean CGRID and other queue parameters

Signed-off-by: Jun Yang <jun.yang@nxp.com>
Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/bus/dpaa/base/qbman/qman.c |  9 ++++---
 drivers/net/dpaa/dpaa_ethdev.c     | 43 ++++++++++++++++++++++++++----
 2 files changed, 43 insertions(+), 9 deletions(-)

diff --git a/drivers/bus/dpaa/base/qbman/qman.c b/drivers/bus/dpaa/base/qbman/qman.c
index 092dbc9fd7..738a8db6b8 100644
--- a/drivers/bus/dpaa/base/qbman/qman.c
+++ b/drivers/bus/dpaa/base/qbman/qman.c
@@ -2916,10 +2916,9 @@ qman_shutdown_fq(struct qman_fq *fq)
 		}
 		res = mcr->result; /* Make a copy as we reuse MCR below */
 
-		if (res == QM_MCR_RESULT_OK)
+		if (res == QM_MCR_RESULT_OK) {
 			drain_mr_fqrni(&p->p);
-
-		if (res == QM_MCR_RESULT_PENDING) {
+		} else if (res == QM_MCR_RESULT_PENDING) {
 			/*
 			 * Need to wait for the FQRN in the message ring, which
 			 * will only occur once the FQ has been drained.  In
@@ -2948,11 +2947,13 @@ qman_shutdown_fq(struct qman_fq *fq)
 						  QM_SDQCR_TYPE_ACTIVE |
 						  QM_SDQCR_CHANNELS_DEDICATED);
 			} else {
-				DPAA_BUS_ERR("Invalid channel 0x%x for FQ 0x%x",
+				/* Channel is in DCP portal range (e.g. FM0); not drainable here */
+				DPAA_BUS_ERR("DCP portal channel 0x%x for FQ 0x%x",
 					channel, fqid);
 				ret = -EBUSY;
 				goto out;
 			}
+
 			do {
 				/* Keep draining DQRR while checking the MR*/
 				qm_dqrr_drain_nomatch(&p->p);
diff --git a/drivers/net/dpaa/dpaa_ethdev.c b/drivers/net/dpaa/dpaa_ethdev.c
index c0bf1dc81d..89332c3582 100644
--- a/drivers/net/dpaa/dpaa_ethdev.c
+++ b/drivers/net/dpaa/dpaa_ethdev.c
@@ -527,7 +527,7 @@ static int dpaa_eth_dev_close(struct rte_eth_dev *dev)
 	struct rte_eth_link *link = &dev->data->dev_link;
 	struct dpaa_if *dpaa_intf = dev->data->dev_private;
 	struct qman_fq *fq;
-	int loop;
+	uint32_t fqid, loop;
 	int ret;
 
 	PMD_INIT_FUNC_TRACE();
@@ -603,25 +603,49 @@ static int dpaa_eth_dev_close(struct rte_eth_dev *dev)
 	/* Release RX congestion Groups */
 	if (dpaa_intf->cgr_rx) {
 		for (loop = 0; loop < dpaa_intf->nb_rx_queues; loop++) {
+			ret = qman_find_fq_by_cgrid(dpaa_intf->cgr_rx[loop].cgrid, &fqid);
+			if (!ret) {
+				/* Should be FQ not cleaned in previous program. */
+				DPAA_PMD_DEBUG("FQ(fqid=0x%x) with rx cgid=%d is still alive?",
+					fqid, dpaa_intf->cgr_rx[loop].cgrid);
+				ret = qman_shutdown_fq_by_fqid(fqid);
+				if (ret) {
+					DPAA_PMD_WARN("Failed(%d) to shutdown fq(fqid=0x%x)",
+						ret, fqid);
+				}
+			}
 			ret = qman_delete_cgr(&dpaa_intf->cgr_rx[loop]);
 			if (ret) {
 				DPAA_PMD_WARN("%s: delete rxq%d's cgr err(%d)",
 					dev->data->name, loop, ret);
 			}
 		}
+		qman_release_cgrid_range(dpaa_intf->cgr_rx[0].cgrid, dpaa_intf->nb_rx_queues);
 		rte_free(dpaa_intf->cgr_rx);
 		dpaa_intf->cgr_rx = NULL;
 	}
 
 	/* Release TX congestion Groups */
 	if (dpaa_intf->cgr_tx) {
-		for (loop = 0; loop < MAX_DPAA_CORES; loop++) {
+		for (loop = 0; loop < dpaa_intf->nb_tx_queues; loop++) {
+			ret = qman_find_fq_by_cgrid(dpaa_intf->cgr_tx[loop].cgrid, &fqid);
+			if (!ret) {
+				/* Should be FQ not cleaned in previous program. */
+				DPAA_PMD_DEBUG("FQ(fqid=0x%x) with tx cgid=%d is still alive?",
+					fqid, dpaa_intf->cgr_tx[loop].cgrid);
+				ret = qman_shutdown_fq_by_fqid(fqid);
+				if (ret) {
+					DPAA_PMD_WARN("Failed(%d) to shutdown fq(fqid=0x%x)",
+						ret, fqid);
+				}
+			}
 			ret = qman_delete_cgr(&dpaa_intf->cgr_tx[loop]);
 			if (ret) {
 				DPAA_PMD_WARN("%s: delete txq%d's cgr err(%d)",
 					dev->data->name, loop, ret);
 			}
 		}
+		qman_release_cgrid_range(dpaa_intf->cgr_tx[0].cgrid, dpaa_intf->nb_tx_queues);
 		rte_free(dpaa_intf->cgr_tx);
 		dpaa_intf->cgr_tx = NULL;
 	}
@@ -644,6 +668,9 @@ static int dpaa_eth_dev_close(struct rte_eth_dev *dev)
 	rte_free(dpaa_intf->tx_queues);
 	dpaa_intf->tx_queues = NULL;
 
+	rte_free(dpaa_intf->tx_conf_queues);
+	dpaa_intf->tx_conf_queues = NULL;
+
 	return ret;
 }
 
@@ -1139,9 +1166,6 @@ int dpaa_eth_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	DPAA_PMD_INFO("Rx queue setup for queue index: %d fq_id (0x%x)",
 			queue_idx, rxq->fqid);
 
-	/* Shutdown FQ before configure */
-	qman_shutdown_fq_by_fqid(rxq->fqid);
-
 	if (!fif->num_profiles) {
 		if (dpaa_intf->bp_info && dpaa_intf->bp_info->bp &&
 			dpaa_intf->bp_info->mp != mp) {
@@ -2499,6 +2523,13 @@ dpaa_dev_init(struct rte_eth_dev *eth_dev)
 
 		vsp_id = dev_vspids[loop];
 
+		/* Shutdown FQ before configure to clean the queue */
+		ret = qman_shutdown_fq_by_fqid(fqid);
+		if (ret < 0) {
+			DPAA_PMD_ERR("Failed shutdown %s:rxq-%d-fqid = 0x%08x",
+				dpaa_intf->name, loop, fqid);
+		}
+
 		if (dpaa_intf->cgr_rx)
 			dpaa_intf->cgr_rx[loop].cgrid = cgrid[loop];
 
@@ -2641,6 +2672,8 @@ dpaa_dev_init(struct rte_eth_dev *eth_dev)
 	return 0;
 
 free_tx:
+	rte_free(dpaa_intf->tx_conf_queues);
+	dpaa_intf->tx_conf_queues = NULL;
 	rte_free(dpaa_intf->tx_queues);
 	dpaa_intf->tx_queues = NULL;
 	dpaa_intf->nb_tx_queues = 0;
-- 
2.25.1

