Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E89C61DC2
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Aug 2026 07:29:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0574640150;
	Thu, 27 Aug 2026 09:29:01 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 04BE84003C
 for <dev@dpdk.org>; Thu, 27 Aug 2026 09:28:59 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BDC811A0125;
 Thu, 27 Aug 2026 09:28:59 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 870881A0123;
 Thu, 27 Aug 2026 09:28:59 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 08A6E18000B6;
 Thu, 27 Aug 2026 15:28:57 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org, david.marchand@redhat.com,
 hemant.agrawal@nxp.com, dev@dpdk.org
Subject: [PATCH] bus/dpaa: defer bus initialization to probe
Date: Thu, 27 Aug 2026 12:58:54 +0530
Message-ID: <20260827072854.1015059-1-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
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

In the DPAA bus initialization: it builds the
device list, loads the QMAN/BMAN drivers, registers the platform mbuf
pool ops and populates the PA to VA translation table. All of it needs
the DPDK heap or a memzone for multi process scenarios.

get_iommu_class() for this bus only checks two sysfs paths, so the
initialization is not needed in scan to report the IOVA mode. Move it
back to probe.

Fixes: cdefd2e980bd ("drivers/bus: initialize NXP bus specifics in scan")

Signed-off-by: Prashant Gupta <prashant.gupta_3@nxp.com>
---
 drivers/bus/dpaa/dpaa_bus.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/bus/dpaa/dpaa_bus.c b/drivers/bus/dpaa/dpaa_bus.c
index 62dcc79534..85f6957466 100644
--- a/drivers/bus/dpaa/dpaa_bus.c
+++ b/drivers/bus/dpaa/dpaa_bus.c
@@ -740,10 +740,8 @@ static int rte_dpaa_setup_intr(struct rte_intr_handle *intr_handle)
 static int
 rte_dpaa_bus_scan(void)
 {
-	struct rte_dpaa_device *dev;
 	FILE *svr_file = NULL;
 	uint32_t svr_ver;
-	static int process_once;
 	char *penv;
 	int ret;
 
@@ -806,9 +804,29 @@ rte_dpaa_bus_scan(void)
 			dpaa_bus.max_push_rxq_num = DPAA_MAX_PUSH_MODE_QUEUE;
 	}
 
+	return 0;
+}
+
+/* Bus initialization needs the DPDK heap and a memzone, which EAL only sets
+ * up after the bus scan, so it is done here.
+ */
+static int
+rte_dpaa_bus_probe(struct rte_bus *bus)
+{
+	static int process_once;
+	struct rte_dpaa_device *dev;
+	int ret;
+
+	if (!dpaa_bus.detected)
+		return 0;
+
 	/* Device list creation is only done once */
 	if (!process_once) {
-		rte_dpaa_bus_dev_build();
+		ret = rte_dpaa_bus_dev_build();
+		if (ret) {
+			DPAA_BUS_ERR("Unable to build device list. (%d)", ret);
+			return ret;
+		}
 		/* One time load of Qman/Bman drivers */
 		ret = qman_global_init();
 		if (ret) {
@@ -822,8 +840,8 @@ rte_dpaa_bus_scan(void)
 				     ret);
 			return ret;
 		}
+		process_once = 1;
 	}
-	process_once = 1;
 
 	/* If no device present on DPAA bus nothing needs to be done */
 	if (TAILQ_EMPTY(&rte_dpaa_bus.device_list))
@@ -846,7 +864,8 @@ rte_dpaa_bus_scan(void)
 	dpaax_iova_table_populate();
 
 	dpaa_bus_global_init = 1;
-	return 0;
+
+	return rte_bus_generic_probe(bus);
 }
 
 /*
@@ -928,7 +947,7 @@ RTE_FINI_PRIO(dpaa_cleanup, 102)
 
 static struct rte_bus rte_dpaa_bus = {
 	.scan = rte_dpaa_bus_scan,
-	.probe = rte_bus_generic_probe,
+	.probe = rte_dpaa_bus_probe,
 	.parse = rte_dpaa_bus_parse,
 	.dev_compare = dpaa_bus_dev_compare,
 	.find_device = rte_bus_generic_find_device,
-- 
2.43.0

