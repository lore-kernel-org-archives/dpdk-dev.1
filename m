Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B1ACD4F26
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Jun 2026 12:30:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 016E040E34;
	Fri, 19 Jun 2026 14:29:44 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 5FDB640E32
 for <dev@dpdk.org>; Fri, 19 Jun 2026 14:29:39 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 377111A025F;
 Fri, 19 Jun 2026 14:29:39 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 016731A0253;
 Fri, 19 Jun 2026 14:29:39 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 78EB51800071;
 Fri, 19 Jun 2026 20:29:37 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	david.marchand@redhat.com,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH 09/18] bus/dpaa: add cgrid cleanup support
Date: Fri, 19 Jun 2026 17:59:07 +0530
Message-Id: <20260619122922.3774666-11-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260619122922.3774666-1-hemant.agrawal@nxp.com>
References: <20260619122922.3774666-1-hemant.agrawal@nxp.com>
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

Add qman_find_fq_by_cgid() to find frame queues associated with
a given CGID. This allows the driver to verify that all FQs
using a CGR are shut down before releasing the CGR ID, preventing
use-after-free of CGR resources.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/bus/dpaa/dpaa_bus_base_symbols.c |  1 +
 drivers/bus/dpaa/include/fsl_qman.h      |  3 +++
 drivers/net/dpaa/dpaa_ethdev.c           | 29 ++++++++++++++++++++++--
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/dpaa/dpaa_bus_base_symbols.c b/drivers/bus/dpaa/dpaa_bus_base_symbols.c
index 52abec2b4c..514ab7b1f1 100644
--- a/drivers/bus/dpaa/dpaa_bus_base_symbols.c
+++ b/drivers/bus/dpaa/dpaa_bus_base_symbols.c
@@ -56,6 +56,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(qman_reserve_fqid_range)
 RTE_EXPORT_INTERNAL_SYMBOL(qman_alloc_pool_range)
 RTE_EXPORT_INTERNAL_SYMBOL(qman_alloc_cgrid_range)
 RTE_EXPORT_INTERNAL_SYMBOL(qman_release_cgrid_range)
+RTE_EXPORT_INTERNAL_SYMBOL(qman_find_fq_by_cgrid)
 RTE_EXPORT_INTERNAL_SYMBOL(dpaa_intr_enable)
 RTE_EXPORT_INTERNAL_SYMBOL(dpaa_intr_disable)
 RTE_EXPORT_INTERNAL_SYMBOL(dpaa_get_ioctl_version_number)
diff --git a/drivers/bus/dpaa/include/fsl_qman.h b/drivers/bus/dpaa/include/fsl_qman.h
index bd46207232..20321ed355 100644
--- a/drivers/bus/dpaa/include/fsl_qman.h
+++ b/drivers/bus/dpaa/include/fsl_qman.h
@@ -1907,6 +1907,9 @@ static inline int qman_shutdown_fq_by_fqid(u32 fqid)
 	return qman_shutdown_fq(&fq);
 }
 
+__rte_internal
+int qman_find_fq_by_cgrid(u32 cgrid, u32 *fqid);
+
 /**
  * qman_reserve_fqid_range - Reserve the specified range of frame queue IDs
  * @fqid: the base FQID of the range to deallocate
diff --git a/drivers/net/dpaa/dpaa_ethdev.c b/drivers/net/dpaa/dpaa_ethdev.c
index 1615cf3892..e1856580b9 100644
--- a/drivers/net/dpaa/dpaa_ethdev.c
+++ b/drivers/net/dpaa/dpaa_ethdev.c
@@ -511,7 +511,7 @@ static int dpaa_eth_dev_close(struct rte_eth_dev *dev)
 	struct rte_eth_link *link = &dev->data->dev_link;
 	struct dpaa_if *dpaa_intf = dev->data->dev_private;
 	struct qman_fq *fq;
-	int loop;
+	uint32_t fqid, loop;
 	int ret;
 
 	PMD_INIT_FUNC_TRACE();
@@ -574,28 +574,53 @@ static int dpaa_eth_dev_close(struct rte_eth_dev *dev)
 	/* release configuration memory */
 	rte_free(dpaa_intf->fc_conf);
 
+	/** Release congestion Groups after releasing FQIDs*/
 	/* Release RX congestion Groups */
 	if (dpaa_intf->cgr_rx) {
 		for (loop = 0; loop < dpaa_intf->nb_rx_queues; loop++) {
+			ret = qman_find_fq_by_cgrid(dpaa_intf->cgr_rx[loop].cgrid, &fqid);
+			if (!ret) {
+				/** Should be FQ not cleaned in previous program.*/
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
+				/** Should be FQ not cleaned in previous program.*/
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
-- 
2.25.1

