Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A93C43458
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Jul 2026 12:51:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 55F0940BA4;
	Fri,  3 Jul 2026 14:50:12 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 5ED4440B97
 for <dev@dpdk.org>; Fri,  3 Jul 2026 14:50:10 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 436B41A001F;
 Fri,  3 Jul 2026 14:50:10 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0C19C1A0004;
 Fri,  3 Jul 2026 14:50:10 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 9B188180004C;
 Fri,  3 Jul 2026 20:50:08 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	david.marchand@redhat.com,
	dev@dpdk.org
Subject: [PATCH v7 12/16] bus/dpaa: improve log macro and fix bus detection
Date: Fri,  3 Jul 2026 18:19:46 +0530
Message-Id: <20260703124950.1895871-13-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260703124950.1895871-1-hemant.agrawal@nxp.com>
References: <20260702053359.3243907-1-hemant.agrawal@nxp.com>
 <20260703124950.1895871-1-hemant.agrawal@nxp.com>
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

Replace DPAA_BUS_LOG(LEVEL, ...) calls with shorthand macros
(DPAA_BUS_INFO, DPAA_BUS_ERR, DPAA_BUS_WARN, DPAA_BUS_DEBUG) for
consistency across the driver.

Make dpaa_bus_dev_compare() a pure comparator: move the sysfs path
check, dpaa_bus.detected assignment, and pthread_key_create() call
back to rte_dpaa_bus_scan() where they belong. Having side effects
in a comparator causes incorrect behavior when the function is called
multiple times -- it returns 0 (match) for all calls after the first.

Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/bus/dpaa/base/fman/fman.c |  9 ++++-----
 drivers/bus/dpaa/dpaa_bus.c       | 12 ++++++------
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/bus/dpaa/base/fman/fman.c b/drivers/bus/dpaa/base/fman/fman.c
index 55f466d751..67f77265ca 100644
--- a/drivers/bus/dpaa/base/fman/fman.c
+++ b/drivers/bus/dpaa/base/fman/fman.c
@@ -119,7 +119,7 @@ _fman_init(const struct device_node *fman_node, int fd)
 	ip_rev_1 = in_be32((uint8_t *)fman->ccsr_vir + FMAN_IP_REV_1);
 	fman->ip_rev = ip_rev_1 >> FMAN_IP_REV_1_MAJOR_SHIFT;
 	fman->ip_rev &=	FMAN_IP_REV_1_MAJOR_MASK;
-	DPAA_BUS_LOG(NOTICE, "FMan version is 0x%02x", fman->ip_rev);
+	DPAA_BUS_INFO("FMan version is 0x%02x", fman->ip_rev);
 
 	if (fman->ip_rev >= FMAN_V3) {
 		/*
@@ -795,8 +795,7 @@ fman_if_init(const struct device_node *dpa_node, int fd)
 	fman_if_vsp_init(__if);
 
 	/* Parsing of the network interface is complete, add it to the list */
-	DPAA_BUS_LOG(DEBUG, "Found %s, Tx Channel = %x, FMAN = %x,"
-		    "Port ID = %x",
+	DPAA_BUS_DEBUG("Found %s, Tx Channel = %x, FMAN = %x, Port ID = %x",
 		    dname, __if->__if.tx_channel_id, __if->__if.fman->idx,
 		    __if->__if.mac_idx);
 
@@ -1109,14 +1108,14 @@ fman_init(void)
 
 	fd = open(FMAN_DEVICE_PATH, O_RDWR);
 	if (unlikely(fd < 0)) {
-		DPAA_BUS_LOG(ERR, "Unable to open %s: %s", FMAN_DEVICE_PATH, strerror(errno));
+		DPAA_BUS_ERR("Unable to open %s: %s", FMAN_DEVICE_PATH, strerror(errno));
 		return fd;
 	}
 	fman_ccsr_map_fd = fd;
 
 	parent_node = of_find_compatible_node(NULL, NULL, "fsl,dpaa");
 	if (!parent_node) {
-		DPAA_BUS_LOG(ERR, "Unable to find fsl,dpaa node");
+		DPAA_BUS_ERR("Unable to find fsl,dpaa node");
 		return -ENODEV;
 	}
 
diff --git a/drivers/bus/dpaa/dpaa_bus.c b/drivers/bus/dpaa/dpaa_bus.c
index 54779f82f7..73a7e73a0b 100644
--- a/drivers/bus/dpaa/dpaa_bus.c
+++ b/drivers/bus/dpaa/dpaa_bus.c
@@ -54,6 +54,9 @@
 /* At present we allow up to 4 push mode queues as default - as each of
  * this queue need dedicated portal and we are short of portals.
  */
+#define DPAA_DEV_PATH1 "/sys/devices/platform/soc/soc:fsl,dpaa"
+#define DPAA_DEV_PATH2 "/sys/devices/platform/fsl,dpaa"
+
 #define DPAA_MAX_PUSH_MODE_QUEUE 8
 #define DPAA_DEFAULT_PUSH_MODE_QUEUE 4
 
@@ -667,8 +670,6 @@ static int rte_dpaa_setup_intr(struct rte_intr_handle *intr_handle)
 	return 0;
 }
 
-#define DPAA_DEV_PATH1 "/sys/devices/platform/soc/soc:fsl,dpaa"
-#define DPAA_DEV_PATH2 "/sys/devices/platform/fsl,dpaa"
 
 static int
 rte_dpaa_bus_scan(void)
@@ -715,12 +716,11 @@ rte_dpaa_bus_scan(void)
 		dpaa_bus.svr_ver = 0;
 	}
 	if (dpaa_bus.svr_ver == SVR_LS1046A_FAMILY) {
-		DPAA_BUS_LOG(INFO, "This is LS1046A family SoC.");
+		DPAA_BUS_INFO("This is LS1046A family SoC.");
 	} else if (dpaa_bus.svr_ver == SVR_LS1043A_FAMILY) {
-		DPAA_BUS_LOG(INFO, "This is LS1043A family SoC.");
+		DPAA_BUS_INFO("This is LS1043A family SoC.");
 	} else {
-		DPAA_BUS_LOG(WARNING,
-			"This is Unknown(%08x) DPAA1 family SoC.",
+		DPAA_BUS_WARN("This is Unknown(%08x) DPAA1 family SoC.",
 			dpaa_bus.svr_ver);
 	}
 
-- 
2.25.1

