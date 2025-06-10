Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9D1C5B543
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 09:14:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5AF7542E70;
	Tue, 10 Jun 2025 11:14:16 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 3CF2A41109
 for <dev@dpdk.org>; Tue, 10 Jun 2025 11:14:14 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1AABD1A0479;
 Tue, 10 Jun 2025 11:14:14 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C37941A067B;
 Tue, 10 Jun 2025 11:14:13 +0200 (CEST)
Received: from lsv03379.swis.in-blr01.nxp.com (lsv03379.swis.in-blr01.nxp.com
 [92.120.147.188])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id A6C571800241;
 Tue, 10 Jun 2025 17:14:12 +0800 (+08)
From: vanshika.shukla@nxp.com
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [v3 01/10] bus/dpaa: avoid using same structure and variable name
Date: Tue, 10 Jun 2025 14:44:02 +0530
Message-Id: <20250610091411.2500413-2-vanshika.shukla@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250610091411.2500413-1-vanshika.shukla@nxp.com>
References: <20250602131526.3233959-1-vanshika.shukla@nxp.com>
 <20250610091411.2500413-1-vanshika.shukla@nxp.com>
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

From: Hemant Agrawal <hemant.agrawal@nxp.com>

rte_dpaa_bus was being used as structure and variable name both.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/bus/dpaa/dpaa_bus.c | 56 ++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/bus/dpaa/dpaa_bus.c b/drivers/bus/dpaa/dpaa_bus.c
index 5420733019..f5ce4a2761 100644
--- a/drivers/bus/dpaa/dpaa_bus.c
+++ b/drivers/bus/dpaa/dpaa_bus.c
@@ -54,7 +54,7 @@ struct rte_dpaa_bus {
 	int detected;
 };
 
-static struct rte_dpaa_bus rte_dpaa_bus;
+static struct rte_dpaa_bus s_rte_dpaa_bus;
 struct netcfg_info *dpaa_netcfg;
 
 /* define a variable to hold the portal_key, once created.*/
@@ -120,7 +120,7 @@ dpaa_add_to_device_list(struct rte_dpaa_device *newdev)
 	struct rte_dpaa_device *dev = NULL;
 	struct rte_dpaa_device *tdev = NULL;
 
-	RTE_TAILQ_FOREACH_SAFE(dev, &rte_dpaa_bus.device_list, next, tdev) {
+	RTE_TAILQ_FOREACH_SAFE(dev, &s_rte_dpaa_bus.device_list, next, tdev) {
 		comp = compare_dpaa_devices(newdev, dev);
 		if (comp < 0) {
 			TAILQ_INSERT_BEFORE(dev, newdev, next);
@@ -130,7 +130,7 @@ dpaa_add_to_device_list(struct rte_dpaa_device *newdev)
 	}
 
 	if (!inserted)
-		TAILQ_INSERT_TAIL(&rte_dpaa_bus.device_list, newdev, next);
+		TAILQ_INSERT_TAIL(&s_rte_dpaa_bus.device_list, newdev, next);
 }
 
 /*
@@ -176,7 +176,7 @@ dpaa_create_device_list(void)
 	struct fm_eth_port_cfg *cfg;
 	struct fman_if *fman_intf;
 
-	rte_dpaa_bus.device_count = 0;
+	s_rte_dpaa_bus.device_count = 0;
 
 	/* Creating Ethernet Devices */
 	for (i = 0; dpaa_netcfg && (i < dpaa_netcfg->num_ethports); i++) {
@@ -187,7 +187,7 @@ dpaa_create_device_list(void)
 			goto cleanup;
 		}
 
-		dev->device.bus = &rte_dpaa_bus.bus;
+		dev->device.bus = &s_rte_dpaa_bus.bus;
 		dev->device.numa_node = SOCKET_ID_ANY;
 
 		/* Allocate interrupt handle instance */
@@ -226,7 +226,7 @@ dpaa_create_device_list(void)
 		dpaa_add_to_device_list(dev);
 	}
 
-	rte_dpaa_bus.device_count += i;
+	s_rte_dpaa_bus.device_count += i;
 
 	/* Unlike case of ETH, RTE_LIBRTE_DPAA_MAX_CRYPTODEV SEC devices are
 	 * constantly created only if "sec" property is found in the device
@@ -259,7 +259,7 @@ dpaa_create_device_list(void)
 		}
 
 		dev->device_type = FSL_DPAA_CRYPTO;
-		dev->id.dev_id = rte_dpaa_bus.device_count + i;
+		dev->id.dev_id = s_rte_dpaa_bus.device_count + i;
 
 		/* Even though RTE_CRYPTODEV_NAME_MAX_LEN is valid length of
 		 * crypto PMD, using RTE_ETH_NAME_MAX_LEN as that is the size
@@ -274,7 +274,7 @@ dpaa_create_device_list(void)
 		dpaa_add_to_device_list(dev);
 	}
 
-	rte_dpaa_bus.device_count += i;
+	s_rte_dpaa_bus.device_count += i;
 
 qdma_dpaa:
 	/* Creating QDMA Device */
@@ -287,7 +287,7 @@ dpaa_create_device_list(void)
 		}
 
 		dev->device_type = FSL_DPAA_QDMA;
-		dev->id.dev_id = rte_dpaa_bus.device_count + i;
+		dev->id.dev_id = s_rte_dpaa_bus.device_count + i;
 
 		memset(dev->name, 0, RTE_ETH_NAME_MAX_LEN);
 		sprintf(dev->name, "dpaa_qdma-%d", i+1);
@@ -297,7 +297,7 @@ dpaa_create_device_list(void)
 
 		dpaa_add_to_device_list(dev);
 	}
-	rte_dpaa_bus.device_count += i;
+	s_rte_dpaa_bus.device_count += i;
 
 	return 0;
 
@@ -312,8 +312,8 @@ dpaa_clean_device_list(void)
 	struct rte_dpaa_device *dev = NULL;
 	struct rte_dpaa_device *tdev = NULL;
 
-	RTE_TAILQ_FOREACH_SAFE(dev, &rte_dpaa_bus.device_list, next, tdev) {
-		TAILQ_REMOVE(&rte_dpaa_bus.device_list, dev, next);
+	RTE_TAILQ_FOREACH_SAFE(dev, &s_rte_dpaa_bus.device_list, next, tdev) {
+		TAILQ_REMOVE(&s_rte_dpaa_bus.device_list, dev, next);
 		rte_intr_instance_free(dev->intr_handle);
 		free(dev);
 		dev = NULL;
@@ -537,10 +537,10 @@ rte_dpaa_bus_scan(void)
 		return 0;
 	}
 
-	if (rte_dpaa_bus.detected)
+	if (s_rte_dpaa_bus.detected)
 		return 0;
 
-	rte_dpaa_bus.detected = 1;
+	s_rte_dpaa_bus.detected = 1;
 
 	/* create the key, supplying a function that'll be invoked
 	 * when a portal affined thread will be deleted.
@@ -564,7 +564,7 @@ rte_dpaa_driver_register(struct rte_dpaa_driver *driver)
 
 	BUS_INIT_FUNC_TRACE();
 
-	TAILQ_INSERT_TAIL(&rte_dpaa_bus.driver_list, driver, next);
+	TAILQ_INSERT_TAIL(&s_rte_dpaa_bus.driver_list, driver, next);
 }
 
 /* un-register a dpaa bus based dpaa driver */
@@ -574,7 +574,7 @@ rte_dpaa_driver_unregister(struct rte_dpaa_driver *driver)
 {
 	BUS_INIT_FUNC_TRACE();
 
-	TAILQ_REMOVE(&rte_dpaa_bus.driver_list, driver, next);
+	TAILQ_REMOVE(&s_rte_dpaa_bus.driver_list, driver, next);
 }
 
 static int
@@ -663,11 +663,11 @@ rte_dpaa_bus_probe(void)
 	struct rte_dpaa_driver *drv;
 	FILE *svr_file = NULL;
 	unsigned int svr_ver;
-	int probe_all = rte_dpaa_bus.bus.conf.scan_mode != RTE_BUS_SCAN_ALLOWLIST;
+	int probe_all = s_rte_dpaa_bus.bus.conf.scan_mode != RTE_BUS_SCAN_ALLOWLIST;
 	static int process_once;
 
 	/* If DPAA bus is not present nothing needs to be done */
-	if (!rte_dpaa_bus.detected)
+	if (!s_rte_dpaa_bus.detected)
 		return 0;
 
 	/* Device list creation is only done once */
@@ -690,7 +690,7 @@ rte_dpaa_bus_probe(void)
 	process_once = 1;
 
 	/* If no device present on DPAA bus nothing needs to be done */
-	if (TAILQ_EMPTY(&rte_dpaa_bus.device_list))
+	if (TAILQ_EMPTY(&s_rte_dpaa_bus.device_list))
 		return 0;
 
 	/* Register DPAA mempool ops only if any DPAA device has
@@ -705,7 +705,7 @@ rte_dpaa_bus_probe(void)
 		fclose(svr_file);
 	}
 
-	TAILQ_FOREACH(dev, &rte_dpaa_bus.device_list, next) {
+	TAILQ_FOREACH(dev, &s_rte_dpaa_bus.device_list, next) {
 		if (dev->device_type == FSL_DPAA_ETH) {
 			ret = rte_dpaa_setup_intr(dev->intr_handle);
 			if (ret)
@@ -717,8 +717,8 @@ rte_dpaa_bus_probe(void)
 	dpaax_iova_table_populate();
 
 	/* For each registered driver, and device, call the driver->probe */
-	TAILQ_FOREACH(dev, &rte_dpaa_bus.device_list, next) {
-		TAILQ_FOREACH(drv, &rte_dpaa_bus.driver_list, next) {
+	TAILQ_FOREACH(dev, &s_rte_dpaa_bus.device_list, next) {
+		TAILQ_FOREACH(drv, &s_rte_dpaa_bus.driver_list, next) {
 			ret = rte_dpaa_device_match(drv, dev);
 			if (ret)
 				continue;
@@ -765,7 +765,7 @@ rte_dpaa_find_device(const struct rte_device *start, rte_dev_cmp_t cmp,
 		dstart = RTE_DEV_TO_DPAA_CONST(start);
 		dev = TAILQ_NEXT(dstart, next);
 	} else {
-		dev = TAILQ_FIRST(&rte_dpaa_bus.device_list);
+		dev = TAILQ_FIRST(&s_rte_dpaa_bus.device_list);
 	}
 
 	while (dev != NULL) {
@@ -838,7 +838,7 @@ dpaa_bus_dev_iterate(const void *start, const char *str,
 		dstart = RTE_DEV_TO_DPAA_CONST(start);
 		dev = TAILQ_NEXT(dstart, next);
 	} else {
-		dev = TAILQ_FIRST(&rte_dpaa_bus.device_list);
+		dev = TAILQ_FIRST(&s_rte_dpaa_bus.device_list);
 	}
 
 	while (dev != NULL) {
@@ -853,7 +853,7 @@ dpaa_bus_dev_iterate(const void *start, const char *str,
 	return NULL;
 }
 
-static struct rte_dpaa_bus rte_dpaa_bus = {
+static struct rte_dpaa_bus s_rte_dpaa_bus = {
 	.bus = {
 		.scan = rte_dpaa_bus_scan,
 		.probe = rte_dpaa_bus_probe,
@@ -864,10 +864,10 @@ static struct rte_dpaa_bus rte_dpaa_bus = {
 		.unplug = dpaa_bus_unplug,
 		.dev_iterate = dpaa_bus_dev_iterate,
 	},
-	.device_list = TAILQ_HEAD_INITIALIZER(rte_dpaa_bus.device_list),
-	.driver_list = TAILQ_HEAD_INITIALIZER(rte_dpaa_bus.driver_list),
+	.device_list = TAILQ_HEAD_INITIALIZER(s_rte_dpaa_bus.device_list),
+	.driver_list = TAILQ_HEAD_INITIALIZER(s_rte_dpaa_bus.driver_list),
 	.device_count = 0,
 };
 
-RTE_REGISTER_BUS(FSL_DPAA_BUS_NAME, rte_dpaa_bus.bus);
+RTE_REGISTER_BUS(FSL_DPAA_BUS_NAME, s_rte_dpaa_bus.bus);
 RTE_LOG_REGISTER_DEFAULT(dpaa_logtype_bus, NOTICE);
-- 
2.25.1

