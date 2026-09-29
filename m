Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3BCC9832A
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 14:21:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D6E642DE3;
	Tue, 29 Sep 2026 16:21:26 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 36CE040E0A
 for <dev@dpdk.org>; Tue, 29 Sep 2026 16:21:23 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0EDA91A00EC;
 Tue, 29 Sep 2026 16:21:23 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id CD80F1A00D5;
 Tue, 29 Sep 2026 16:21:22 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 9A117180006C;
 Tue, 29 Sep 2026 22:21:21 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Subject: [PATCH v5-S1 1/5] bus/fslmc: defer bus initialization to probe
Date: Tue, 29 Sep 2026 19:51:13 +0530
Message-ID: <20260929142117.3109066-2-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929142117.3109066-1-prashant.gupta_3@nxp.com>
References: <20260922092158.2340839-1-prashant.gupta_3@nxp.com>
 <20260929142117.3109066-1-prashant.gupta_3@nxp.com>
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

The fslmc bus initialization (register the sequence number mbuf
dynfield, set up the VFIO group, DMA map the memory segments) needs the
DPDK heap and the memory segment list in shared (hugepage) memory for
multi-process sharing. But these are not available during the bus scan
(EAL runs rte_bus_scan() before memzone, memory and malloc heap init),
so it fails there.

Device discovery does not need it, and get_iommu_class() only checks
sysfs paths to report the IOVA mode, so the init is not needed in scan.
Move it back to probe.

Fixes: cdefd2e980bd ("drivers/bus: initialize NXP bus specifics in scan")

Signed-off-by: Prashant Gupta <prashant.gupta_3@nxp.com>
---
 drivers/bus/fslmc/fslmc_bus.c | 92 +++++++++++++++++++----------------
 1 file changed, 51 insertions(+), 41 deletions(-)

diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index 3626b12316..1c638a2d82 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -368,46 +368,6 @@ rte_fslmc_scan(void)
 	/* If debugging is enabled, device list is dumped to log output */
 	dump_device_list();
 
-	/* Bus initialization - only if devices were found */
-	if (!TAILQ_EMPTY(&rte_fslmc_bus.device_list)) {
-		static const struct rte_mbuf_dynfield dpaa2_seqn_dynfield_desc = {
-			.name = DPAA2_SEQN_DYNFIELD_NAME,
-			.size = sizeof(dpaa2_seqn_t),
-			.align = alignof(dpaa2_seqn_t),
-		};
-
-		dpaa2_seqn_dynfield_offset =
-			rte_mbuf_dynfield_register(&dpaa2_seqn_dynfield_desc);
-		if (dpaa2_seqn_dynfield_offset < 0) {
-			DPAA2_BUS_ERR("Failed to register mbuf field for dpaa sequence number");
-			return 0;
-		}
-
-		ret = fslmc_vfio_setup_group();
-		if (ret) {
-			DPAA2_BUS_ERR("Unable to setup VFIO %d", ret);
-			return 0;
-		}
-
-		/* Map existing segments as well as, in case of hotpluggable memory,
-		 * install callback handler.
-		 */
-		if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
-			ret = fslmc_vfio_dmamap();
-			if (ret) {
-				DPAA2_BUS_ERR("Unable to DMA map existing VAs: (%d)", ret);
-				DPAA2_BUS_ERR("FSLMC VFIO Mapping failed");
-				return 0;
-			}
-		}
-
-		ret = fslmc_vfio_process_group();
-		if (ret) {
-			DPAA2_BUS_ERR("Unable to setup devices %d", ret);
-			return 0;
-		}
-	}
-
 	process_once = 1;
 
 	return 0;
@@ -423,6 +383,56 @@ rte_fslmc_scan(void)
 	return 0;
 }
 
+/* Bus initialization needs the DPDK heap and DMA mapping of the memory
+ * segments, which EAL only sets up after the bus scan, so it is done here.
+ */
+static int
+rte_fslmc_probe(struct rte_bus *bus)
+{
+	static const struct rte_mbuf_dynfield dpaa2_seqn_dynfield_desc = {
+		.name = DPAA2_SEQN_DYNFIELD_NAME,
+		.size = sizeof(dpaa2_seqn_t),
+		.align = alignof(dpaa2_seqn_t),
+	};
+	int ret;
+
+	if (TAILQ_EMPTY(&rte_fslmc_bus.device_list))
+		return 0;
+
+	dpaa2_seqn_dynfield_offset =
+		rte_mbuf_dynfield_register(&dpaa2_seqn_dynfield_desc);
+	if (dpaa2_seqn_dynfield_offset < 0) {
+		DPAA2_BUS_ERR("Failed to register mbuf field for dpaa sequence number");
+		return dpaa2_seqn_dynfield_offset;
+	}
+
+	ret = fslmc_vfio_setup_group();
+	if (ret) {
+		DPAA2_BUS_ERR("Unable to setup VFIO %d", ret);
+		return ret;
+	}
+
+	/* Map existing segments as well as, in case of hotpluggable memory,
+	 * install callback handler.
+	 */
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
+		ret = fslmc_vfio_dmamap();
+		if (ret) {
+			DPAA2_BUS_ERR("Unable to DMA map existing VAs: (%d)", ret);
+			DPAA2_BUS_ERR("FSLMC VFIO Mapping failed");
+			return ret;
+		}
+	}
+
+	ret = fslmc_vfio_process_group();
+	if (ret) {
+		DPAA2_BUS_ERR("Unable to setup devices %d", ret);
+		return ret;
+	}
+
+	return rte_bus_generic_probe(bus);
+}
+
 static bool
 fslmc_bus_match(const struct rte_driver *drv, const struct rte_device *dev)
 {
@@ -544,7 +554,7 @@ fslmc_bus_unplug_device(struct rte_device *rte_dev)
 
 struct rte_bus rte_fslmc_bus = {
 	.scan = rte_fslmc_scan,
-	.probe = rte_bus_generic_probe,
+	.probe = rte_fslmc_probe,
 	.cleanup = rte_fslmc_close,
 	.parse = rte_fslmc_parse,
 	.dev_compare = fslmc_dev_compare,
