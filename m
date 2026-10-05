Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DF1CA5FF0
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 08:55:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D008A40EA5;
	Mon,  5 Oct 2026 10:54:08 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id DA3A740B9D
 for <dev@dpdk.org>; Mon,  5 Oct 2026 10:53:48 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BE8BC1A0086;
 Mon,  5 Oct 2026 10:53:48 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 604A21A007A;
 Mon,  5 Oct 2026 10:53:48 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id DCE9D1800230;
 Mon,  5 Oct 2026 16:53:47 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Subject: [PATCH v20 23/27] bus/dpaa: improve log macro usages
Date: Mon,  5 Oct 2026 14:23:33 +0530
Message-Id: <20261005085337.1069213-24-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261005085337.1069213-1-hemant.agrawal@nxp.com>
References: <20261001112430.251845-1-hemant.agrawal@nxp.com>
 <20261005085337.1069213-1-hemant.agrawal@nxp.com>
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

Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/bus/dpaa/base/fman/fman.c         |  9 ++-
 drivers/bus/dpaa/base/fman/netcfg_layer.c |  8 +--
 drivers/bus/dpaa/dpaa_bus.c               | 86 +++++++++++------------
 drivers/bus/dpaa/rte_dpaa_logs.h          |  2 +
 4 files changed, 51 insertions(+), 54 deletions(-)

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
 
diff --git a/drivers/bus/dpaa/base/fman/netcfg_layer.c b/drivers/bus/dpaa/base/fman/netcfg_layer.c
index e4afa28131..9bc4447dd0 100644
--- a/drivers/bus/dpaa/base/fman/netcfg_layer.c
+++ b/drivers/bus/dpaa/base/fman/netcfg_layer.c
@@ -95,7 +95,7 @@ netcfg_acquire(void)
 	/* Initialise the Fman driver */
 	_errno = fman_init();
 	if (_errno) {
-		DPAA_BUS_LOG(ERR, "FMAN driver init failed (%d)", errno);
+		DPAA_BUS_ERR("FMAN driver init failed (%d)", errno);
 		close(skfd);
 		skfd = -1;
 		return NULL;
@@ -106,7 +106,7 @@ netcfg_acquire(void)
 		num_ports++;
 
 	if (!num_ports) {
-		DPAA_BUS_LOG(ERR, "FMAN ports not available");
+		DPAA_BUS_ERR("FMAN ports not available");
 		return NULL;
 	}
 	/* Allocate space for all enabled mac ports */
@@ -115,7 +115,7 @@ netcfg_acquire(void)
 
 	netcfg = rte_calloc(NULL, 1, size, 0);
 	if (unlikely(netcfg == NULL)) {
-		DPAA_BUS_LOG(ERR, "Unable to allocat mem for netcfg");
+		DPAA_BUS_ERR("Unable to allocate mem for netcfg");
 		goto error;
 	}
 
@@ -131,7 +131,7 @@ netcfg_acquire(void)
 	}
 
 	if (!num_cfg_ports) {
-		DPAA_BUS_LOG(ERR, "No FMAN ports found");
+		DPAA_BUS_ERR("No FMAN ports found");
 		goto error;
 	} else if (num_ports != num_cfg_ports)
 		netcfg->num_ethports = num_cfg_ports;
diff --git a/drivers/bus/dpaa/dpaa_bus.c b/drivers/bus/dpaa/dpaa_bus.c
index 5442f8f893..7e849b669f 100644
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
 
@@ -210,7 +213,7 @@ dpaa_create_device_list(void)
 	for (i = 0; dpaa_netcfg && (i < dpaa_netcfg->num_ethports); i++) {
 		dev = calloc(1, sizeof(struct rte_dpaa_device));
 		if (!dev) {
-			DPAA_BUS_LOG(ERR, "Failed to allocate ETH devices");
+			DPAA_BUS_ERR("Failed to allocate ETH devices");
 			ret = -ENOMEM;
 			goto cleanup;
 		}
@@ -221,7 +224,7 @@ dpaa_create_device_list(void)
 		dev->intr_handle =
 			rte_intr_instance_alloc(RTE_INTR_INSTANCE_F_PRIVATE);
 		if (dev->intr_handle == NULL) {
-			DPAA_BUS_LOG(ERR, "Failed to allocate intr handle");
+			DPAA_BUS_ERR("Failed to allocate intr handle");
 			ret = -ENOMEM;
 			free(dev);
 			goto cleanup;
@@ -265,7 +268,7 @@ dpaa_create_device_list(void)
 	 */
 
 	if (dpaa_sec_available()) {
-		DPAA_BUS_LOG(INFO, "DPAA SEC devices are not available");
+		DPAA_BUS_INFO("DPAA SEC devices are not available");
 		goto qdma_dpaa;
 	}
 
@@ -273,8 +276,8 @@ dpaa_create_device_list(void)
 	for (i = 0; i < RTE_LIBRTE_DPAA_MAX_CRYPTODEV; i++) {
 		dev = calloc(1, sizeof(struct rte_dpaa_device));
 		if (!dev) {
-			DPAA_BUS_LOG(ERR, "Failed to allocate SEC devices");
-			ret = -1;
+			DPAA_BUS_ERR("Failed to allocate SEC devices");
+			ret = -ENOMEM;
 			goto cleanup;
 		}
 
@@ -282,7 +285,7 @@ dpaa_create_device_list(void)
 		dev->intr_handle =
 			rte_intr_instance_alloc(RTE_INTR_INSTANCE_F_PRIVATE);
 		if (dev->intr_handle == NULL) {
-			DPAA_BUS_LOG(ERR, "Failed to allocate intr handle");
+			DPAA_BUS_ERR("Failed to allocate intr handle");
 			ret = -ENOMEM;
 			free(dev);
 			goto cleanup;
@@ -297,7 +300,7 @@ dpaa_create_device_list(void)
 		 */
 		memset(dev->name, 0, RTE_ETH_NAME_MAX_LEN);
 		sprintf(dev->name, "dpaa_sec-%d", i+1);
-		DPAA_BUS_LOG(INFO, "%s cryptodev added", dev->name);
+		DPAA_BUS_INFO("%s cryptodev added", dev->name);
 		dev->device.name = dev->name;
 		dev->device.devargs = rte_bus_find_devargs(&rte_dpaa_bus, dev->name);
 		if (dev->device.devargs != NULL)
@@ -313,8 +316,8 @@ dpaa_create_device_list(void)
 	for (i = 0; i < RTE_DPAA_QDMA_DEVICES; i++) {
 		dev = calloc(1, sizeof(struct rte_dpaa_device));
 		if (!dev) {
-			DPAA_BUS_LOG(ERR, "Failed to allocate QDMA device");
-			ret = -1;
+			DPAA_BUS_ERR("Failed to allocate QDMA device");
+			ret = -ENOMEM;
 			goto cleanup;
 		}
 
@@ -323,7 +326,7 @@ dpaa_create_device_list(void)
 
 		memset(dev->name, 0, RTE_ETH_NAME_MAX_LEN);
 		sprintf(dev->name, "dpaa_qdma-%d", i+1);
-		DPAA_BUS_LOG(INFO, "%s qdma device added", dev->name);
+		DPAA_BUS_INFO("%s qdma device added", dev->name);
 		dev->device.name = dev->name;
 		dev->device.devargs = rte_bus_find_devargs(&rte_dpaa_bus, dev->name);
 		if (dev->device.devargs != NULL)
@@ -377,37 +380,35 @@ int rte_dpaa_portal_init(void *arg)
 	dpaa_seqn_dynfield_offset =
 		rte_mbuf_dynfield_register(&dpaa_seqn_dynfield_desc);
 	if (dpaa_seqn_dynfield_offset < 0) {
-		DPAA_BUS_LOG(ERR, "Failed to register mbuf field for dpaa sequence number");
+		DPAA_BUS_ERR("Failed to register mbuf field for dpaa sequence number");
 		return -rte_errno;
 	}
 
 	/* Initialise bman thread portals */
 	ret = bman_thread_init();
 	if (ret) {
-		DPAA_BUS_LOG(ERR, "bman_thread_init failed on core %u"
-			     " (lcore=%u) with ret: %d", cpu, lcore, ret);
+		DPAA_BUS_ERR("Failed(%d) to init bman thread on cpu%d/lcore%d",
+			ret, cpu, lcore);
 		return ret;
 	}
 
-	DPAA_BUS_LOG(DEBUG, "BMAN thread initialized - CPU=%d lcore=%d",
-		     cpu, lcore);
+	DPAA_BUS_DEBUG("BMAN thread initialized - CPU=%d lcore=%d", cpu, lcore);
 
 	/* Initialise qman thread portals */
 	ret = qman_thread_init();
 	if (ret) {
-		DPAA_BUS_LOG(ERR, "qman_thread_init failed on core %u"
-			    " (lcore=%u) with ret: %d", cpu, lcore, ret);
+		DPAA_BUS_ERR("Failed(%d) to init qman thread on cpu%d/lcore%d",
+			ret, cpu, lcore);
 		bman_thread_finish();
 		return ret;
 	}
 
-	DPAA_BUS_LOG(DEBUG, "QMAN thread initialized - CPU=%d lcore=%d",
-		     cpu, lcore);
+	DPAA_BUS_DEBUG("QMAN thread initialized - CPU=%d lcore=%d", cpu, lcore);
 
 	DPAA_PER_LCORE_PORTAL = rte_malloc(NULL, sizeof(struct dpaa_portal),
 				    RTE_CACHE_LINE_SIZE);
 	if (!DPAA_PER_LCORE_PORTAL) {
-		DPAA_BUS_LOG(ERR, "Unable to allocate memory");
+		DPAA_BUS_ERR("Unable to allocate memory");
 		bman_thread_finish();
 		qman_thread_finish();
 		return -ENOMEM;
@@ -420,15 +421,15 @@ int rte_dpaa_portal_init(void *arg)
 	ret = pthread_setspecific(dpaa_portal_key,
 				  (void *)DPAA_PER_LCORE_PORTAL);
 	if (ret) {
-		DPAA_BUS_LOG(ERR, "pthread_setspecific failed on core %u"
-			     " (lcore=%u) with ret: %d", cpu, lcore, ret);
+		DPAA_BUS_ERR("Failed(%d) to set portal per thread on cpu%u/lcore%u",
+			ret, cpu, lcore);
 		dpaa_portal_finish(NULL);
 
 		return ret;
 	}
 	dpaa_portals[lcore] = DPAA_PER_LCORE_PORTAL;
 
-	DPAA_BUS_LOG(DEBUG, "QMAN thread initialized");
+	DPAA_BUS_DEBUG("QMAN thread initialized");
 
 	return 0;
 }
@@ -444,7 +445,7 @@ rte_dpaa_portal_fq_init(void *arg, struct qman_fq *fq)
 	if (unlikely(!DPAA_PER_LCORE_PORTAL)) {
 		ret = rte_dpaa_portal_init(arg);
 		if (ret < 0) {
-			DPAA_BUS_LOG(ERR, "portal initialization failure");
+			DPAA_BUS_ERR("portal initialization failure");
 			return ret;
 		}
 	}
@@ -452,7 +453,7 @@ rte_dpaa_portal_fq_init(void *arg, struct qman_fq *fq)
 	/* Initialise qman specific portals */
 	ret = fsl_qman_fq_portal_init(fq->qp);
 	if (ret) {
-		DPAA_BUS_LOG(ERR, "Unable to init fq portal");
+		DPAA_BUS_ERR("Unable to init fq portal");
 		return -1;
 	}
 
@@ -474,7 +475,7 @@ dpaa_portal_finish(void *arg)
 	struct dpaa_portal *dpaa_io_portal = (struct dpaa_portal *)arg;
 
 	if (!dpaa_io_portal) {
-		DPAA_BUS_LOG(DEBUG, "Portal already cleaned");
+		DPAA_BUS_DEBUG("Portal already cleaned");
 		return;
 	}
 
@@ -617,24 +618,22 @@ rte_dpaa_bus_dev_build(void)
 	/* Load the device-tree driver */
 	ret = of_init();
 	if (ret) {
-		DPAA_BUS_LOG(ERR, "of_init failed with ret: %d", ret);
-		return -1;
+		DPAA_BUS_ERR("Failed(%d) to init device tree", ret);
+		return ret;
 	}
 
 	/* Get the interface configurations from device-tree */
 	dpaa_netcfg = netcfg_acquire();
 	if (!dpaa_netcfg) {
-		DPAA_BUS_LOG(ERR,
-			"netcfg failed: /dev/fsl_usdpaa device not available");
-		DPAA_BUS_WARN(
-			"Check if you are using USDPAA based device tree");
+		DPAA_BUS_ERR("netcfg failed: /dev/fsl_usdpaa device not available");
+		DPAA_BUS_WARN("Check if you are using USDPAA based device tree");
 		return -EINVAL;
 	}
 
-	DPAA_BUS_LOG(NOTICE, "DPAA Bus Detected");
+	DPAA_BUS_NOTICE("DPAA Bus Detected");
 
 	if (!dpaa_netcfg->num_ethports) {
-		DPAA_BUS_LOG(INFO, "NO DPDK mapped net interfaces available");
+		DPAA_BUS_INFO("NO DPDK mapped net interfaces available");
 		/* This is not an error */
 	}
 
@@ -642,11 +641,11 @@ rte_dpaa_bus_dev_build(void)
 	dump_netcfg(dpaa_netcfg, stdout);
 #endif
 
-	DPAA_BUS_LOG(DEBUG, "Number of ethernet devices = %d",
-		     dpaa_netcfg->num_ethports);
+	DPAA_BUS_DEBUG("Number of ethernet devices = %d",
+			     dpaa_netcfg->num_ethports);
 	ret = dpaa_create_device_list();
 	if (ret) {
-		DPAA_BUS_LOG(ERR, "Unable to create device list. (%d)", ret);
+		DPAA_BUS_ERR("Unable to create device list. (%d)", ret);
 		return ret;
 	}
 	return 0;
@@ -672,8 +671,6 @@ static int rte_dpaa_setup_intr(struct rte_intr_handle *intr_handle)
 	return 0;
 }
 
-#define DPAA_DEV_PATH1 "/sys/devices/platform/soc/soc:fsl,dpaa"
-#define DPAA_DEV_PATH2 "/sys/devices/platform/fsl,dpaa"
 
 static int
 rte_dpaa_bus_scan(void)
@@ -689,7 +686,7 @@ rte_dpaa_bus_scan(void)
 
 	if ((access(DPAA_DEV_PATH1, F_OK) != 0) &&
 	    (access(DPAA_DEV_PATH2, F_OK) != 0)) {
-		DPAA_BUS_LOG(DEBUG, "DPAA Bus not present. Skipping.");
+		DPAA_BUS_DEBUG("DPAA Bus not present. Skipping.");
 		return 0;
 	}
 
@@ -703,7 +700,7 @@ rte_dpaa_bus_scan(void)
 	 */
 	ret = pthread_key_create(&dpaa_portal_key, dpaa_portal_finish);
 	if (ret) {
-		DPAA_BUS_LOG(DEBUG, "Unable to create pthread key. (%d)", ret);
+		DPAA_BUS_DEBUG("Unable to create pthread key. (%d)", ret);
 		dpaa_clean_device_list();
 		return ret;
 	}
@@ -720,12 +717,11 @@ rte_dpaa_bus_scan(void)
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
 
diff --git a/drivers/bus/dpaa/rte_dpaa_logs.h b/drivers/bus/dpaa/rte_dpaa_logs.h
index 235c617edd..c6a225e5f7 100644
--- a/drivers/bus/dpaa/rte_dpaa_logs.h
+++ b/drivers/bus/dpaa/rte_dpaa_logs.h
@@ -30,6 +30,8 @@ extern int dpaa_logtype_bus;
 
 #define BUS_INIT_FUNC_TRACE() DPAA_BUS_DEBUG(" >>")
 
+#define DPAA_BUS_NOTICE(fmt, ...) \
+	DPAA_BUS_LOG(NOTICE, fmt, ## __VA_ARGS__)
 #define DPAA_BUS_INFO(fmt, ...) \
 	DPAA_BUS_LOG(INFO, fmt, ## __VA_ARGS__)
 #define DPAA_BUS_ERR(fmt, ...) \
-- 
2.25.1

