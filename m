Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D04CD98F0
	for <dpdk-dev@archiver.kernel.org>; Sun, 21 Jun 2026 10:18:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A14F40674;
	Sun, 21 Jun 2026 12:17:18 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 4677040651
 for <dev@dpdk.org>; Sun, 21 Jun 2026 12:17:12 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2CECA20021D;
 Sun, 21 Jun 2026 12:17:12 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id EA61E200222;
 Sun, 21 Jun 2026 12:17:11 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 880151800071;
 Sun, 21 Jun 2026 18:17:10 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	david.marchand@redhat.com,
	dev@dpdk.org
Subject: [PATCH v2 13/19] bus/dpaa: improve log macro and fix bus detection
Date: Sun, 21 Jun 2026 15:46:45 +0530
Message-Id: <20260621101651.1081425-14-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260621101651.1081425-1-hemant.agrawal@nxp.com>
References: <20260619122922.3774666-1-hemant.agrawal@nxp.com>
 <20260621101651.1081425-1-hemant.agrawal@nxp.com>
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

Move bus detection (sysfs path check), portal key creation and
dpaa_bus.detected guard into dpaa_bus_dev_compare() so that bus
probe is properly gated on hardware presence.

Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/bus/dpaa/base/fman/fman.c |  9 ++++----
 drivers/bus/dpaa/dpaa_bus.c       | 35 ++++++++++++++++++++++++-------
 2 files changed, 32 insertions(+), 12 deletions(-)

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
index ee467b94d5..70da8074ae 100644
--- a/drivers/bus/dpaa/dpaa_bus.c
+++ b/drivers/bus/dpaa/dpaa_bus.c
@@ -560,13 +560,37 @@ rte_dpaa_bus_parse(const char *name, void *out)
 static int
 dpaa_bus_dev_compare(const char *name1, const char *name2)
 {
+	int ret = 0;
 	char devname1[32], devname2[32];
 
 	if (rte_dpaa_bus_parse(name1, devname1) != 0 ||
 			rte_dpaa_bus_parse(name2, devname2) != 0)
 		return 1;
 
-	return strncmp(devname1, devname2, sizeof(devname1));
+#define DPAA_DEV_PATH1 "/sys/devices/platform/soc/soc:fsl,dpaa"
+#define DPAA_DEV_PATH2 "/sys/devices/platform/fsl,dpaa"
+	if ((access(DPAA_DEV_PATH1, F_OK) != 0) &&
+	    (access(DPAA_DEV_PATH2, F_OK) != 0)) {
+		DPAA_BUS_DEBUG("DPAA Bus not present. Skipping.");
+		return 0;
+	}
+
+	if (dpaa_bus.detected)
+		return 0;
+
+	dpaa_bus.detected = 1;
+
+	/* create the key, supplying a function that'll be invoked
+	 * when a portal affined thread will be deleted.
+	 */
+	ret = pthread_key_create(&dpaa_portal_key, dpaa_portal_finish);
+	if (ret) {
+		DPAA_BUS_DEBUG("Unable to create pthread key. (%d)", ret);
+		dpaa_clean_device_list();
+		return ret;
+	}
+
+	return 0;
 }
 
 /* register a dpaa bus based dpaa driver */
@@ -667,8 +691,6 @@ static int rte_dpaa_setup_intr(struct rte_intr_handle *intr_handle)
 	return 0;
 }
 
-#define DPAA_DEV_PATH1 "/sys/devices/platform/soc/soc:fsl,dpaa"
-#define DPAA_DEV_PATH2 "/sys/devices/platform/fsl,dpaa"
 
 static int
 rte_dpaa_bus_scan(void)
@@ -715,12 +737,11 @@ rte_dpaa_bus_scan(void)
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

