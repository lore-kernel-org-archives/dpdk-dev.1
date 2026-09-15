Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA498C88E53
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 12:03:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 61C7642E00;
	Tue, 15 Sep 2026 14:02:27 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 727CC42DDF
 for <dev@dpdk.org>; Tue, 15 Sep 2026 14:02:21 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 57C281A0053;
 Tue, 15 Sep 2026 14:02:21 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2089E1A0009;
 Tue, 15 Sep 2026 14:02:21 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id B88F618000BA;
 Tue, 15 Sep 2026 20:02:19 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v3-S3 09/10] drivers: resolve dpaa2 endpoint in the net driver
Date: Tue, 15 Sep 2026 17:32:07 +0530
Message-ID: <20260915120208.4185877-10-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915120208.4185877-1-prashant.gupta_3@nxp.com>
References: <20260915113459.4166621-1-prashant.gupta_3@nxp.com>
 <20260915120208.4185877-1-prashant.gupta_3@nxp.com>
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

The DPRC object driver walked every device on the bus and, for each DPNI,
issued dprc_get_connection() to find the object it is wired to. Two
things are wrong with that. The bus keeps the result in
struct rte_dpaa2_device even though only the net driver consumes it, and
a failure to resolve one DPNI's endpoint aborted the creation of the
whole container. The endpoint name was also formatted from endpoint2
outside the DPNI branch, so non-DPNI devices got a name built from
uninitialised or stale data.

Move the lookup to dpaa2_dev_init(), which already knows it is dealing
with a DPNI and can fail the probe of that one port. This also fills in
priv->ep_dev_type, priv->ep_object_id and priv->ep_name, which the net
driver reads for MAC-level operations, recycle/loopback configuration and
rte_pmd_dpaa2_ep_name(), but which nothing assigned. dpsw endpoints are
now recognised, and dpdmux/dpsw names carry the interface index because
those endpoints are per-interface.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/bus/fslmc/bus_fslmc_driver.h     |  3 --
 drivers/bus/fslmc/portal/dpaa2_hw_dprc.c | 45 +++---------------
 drivers/net/dpaa2/dpaa2_ethdev.c         | 59 +++++++++++++++++++++++-
 drivers/net/dpaa2/dpaa2_recycle.c        | 15 +++---
 4 files changed, 71 insertions(+), 51 deletions(-)

diff --git a/drivers/bus/fslmc/bus_fslmc_driver.h b/drivers/bus/fslmc/bus_fslmc_driver.h
index b4a5a86318..0d431fdd19 100644
--- a/drivers/bus/fslmc/bus_fslmc_driver.h
+++ b/drivers/bus/fslmc/bus_fslmc_driver.h
@@ -104,10 +104,7 @@ struct rte_dpaa2_device {
 	struct rte_device device;           /**< Inherit core device */
 	enum rte_dpaa2_dev_type dev_type;   /**< Device Type */
 	uint16_t object_id;                 /**< DPAA2 Object ID */
-	enum rte_dpaa2_dev_type ep_dev_type;   /**< Endpoint Device Type */
 	struct dpaa2_dprc_dev *container;
-	uint16_t ep_object_id;                 /**< Endpoint DPAA2 Object ID */
-	char ep_name[RTE_DEV_NAME_MAX_LEN];
 	struct rte_intr_handle *intr_handle; /**< Interrupt handle */
 	char name[FSLMC_OBJECT_MAX_LEN];    /**< DPAA2 Object name*/
 	struct rte_dma_dev *dmadev;          /**< DMA device */
diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dprc.c b/drivers/bus/fslmc/portal/dpaa2_hw_dprc.c
index 868ed646af..6441297ecf 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dprc.c
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dprc.c
@@ -27,7 +27,6 @@ rte_dpaa2_create_dprc_device(int vdev_fd __rte_unused,
 	struct rte_dpaa2_device *obj)
 {
 	struct dpaa2_dprc_dev *dprc_node;
-	struct dprc_endpoint endpoint1, endpoint2;
 	struct rte_dpaa2_device *dev;
 	int ret, dprc_id = obj->object_id;
 
@@ -49,45 +48,13 @@ rte_dpaa2_create_dprc_device(int vdev_fd __rte_unused,
 		return ret;
 	}
 
-	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus) {
-		/** DPRC is always created before it's children are created.*/
+	/* DPRC is always created before its children are created, so every
+	 * device scanned so far belongs to this container. Endpoint lookup is
+	 * left to the object drivers, which know how many interfaces their
+	 * object has and can report a failure to their own caller.
+	 */
+	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus)
 		dev->container = dprc_node;
-		if (dev->dev_type == DPAA2_ETH) {
-			int link_state;
-
-			memset(&endpoint1, 0, sizeof(struct dprc_endpoint));
-			memset(&endpoint2, 0, sizeof(struct dprc_endpoint));
-			strcpy(endpoint1.type, "dpni");
-			endpoint1.id = dev->object_id;
-			ret = dprc_get_connection(&dprc_node->dprc,
-						CMD_PRI_LOW,
-						dprc_node->token,
-						&endpoint1, &endpoint2,
-						&link_state);
-			if (ret) {
-				DPAA2_BUS_ERR("dpni.%d connection failed!",
-					dev->object_id);
-				dprc_close(&dprc_node->dprc, CMD_PRI_LOW,
-					   dprc_node->token);
-				rte_free(dprc_node);
-				return ret;
-			}
-
-			if (!strcmp(endpoint2.type, "dpmac"))
-				dev->ep_dev_type = DPAA2_MAC;
-			else if (!strcmp(endpoint2.type, "dpni"))
-				dev->ep_dev_type = DPAA2_ETH;
-			else if (!strcmp(endpoint2.type, "dpdmux"))
-				dev->ep_dev_type = DPAA2_MUX;
-			else
-				dev->ep_dev_type = DPAA2_UNKNOWN;
-
-			dev->ep_object_id = endpoint2.id;
-		} else {
-			dev->ep_dev_type = DPAA2_UNKNOWN;
-		}
-		sprintf(dev->ep_name, "%s.%d", endpoint2.type, endpoint2.id);
-	}
 
 	TAILQ_INSERT_TAIL(&dprc_dev_list, dprc_node, next);
 
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index f7cdbbf7d7..1552d2a25f 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -26,6 +26,7 @@
 #include <dpaa2_hw_pvt.h>
 #include <dpaa2_hw_mempool.h>
 #include <dpaa2_hw_dpio.h>
+#include <fsl_dprc.h>
 #include <mc/fsl_dpmng.h>
 #include <mc/fsl_dpcon.h>
 #include "dpaa2_ethdev.h"
@@ -3436,6 +3437,55 @@ dpaa2_get_devargs(struct rte_devargs *devargs, const char *key)
 	return 1;
 }
 
+/* Resolve the object this DPNI is wired to inside its DPRC container. The
+ * endpoint decides whether MAC-level operations (link, promisc, flow control)
+ * are available, and it is reported to the application by
+ * rte_pmd_dpaa2_ep_name().
+ */
+static int
+dpaa2_dev_ep_init(struct rte_dpaa2_device *dpaa2_dev,
+		  struct dpaa2_dev_priv *priv)
+{
+	struct dpaa2_dprc_dev *dprc_node = dpaa2_dev->container;
+	struct dprc_endpoint endpoint1, endpoint2;
+	int link_state, ret;
+
+	memset(&endpoint1, 0, sizeof(endpoint1));
+	memset(&endpoint2, 0, sizeof(endpoint2));
+	strlcpy(endpoint1.type, "dpni", sizeof(endpoint1.type));
+	endpoint1.id = dpaa2_dev->object_id;
+	ret = dprc_get_connection(&dprc_node->dprc, CMD_PRI_LOW,
+				  dprc_node->token, &endpoint1, &endpoint2,
+				  &link_state);
+	if (ret != 0)
+		return ret;
+
+	if (strcmp(endpoint2.type, "dpmac") == 0)
+		priv->ep_dev_type = DPAA2_MAC;
+	else if (strcmp(endpoint2.type, "dpni") == 0)
+		priv->ep_dev_type = DPAA2_ETH;
+	else if (strcmp(endpoint2.type, "dpdmux") == 0)
+		priv->ep_dev_type = DPAA2_MUX;
+	else if (strcmp(endpoint2.type, "dpsw") == 0)
+		priv->ep_dev_type = DPAA2_SW;
+	else
+		priv->ep_dev_type = DPAA2_UNKNOWN;
+
+	priv->ep_object_id = endpoint2.id;
+
+	/* dpdmux and dpsw endpoints are per-interface, so the interface index
+	 * is part of the name.
+	 */
+	if (priv->ep_dev_type == DPAA2_MUX || priv->ep_dev_type == DPAA2_SW)
+		snprintf(priv->ep_name, sizeof(priv->ep_name), "%s.%d.%d",
+			 endpoint2.type, endpoint2.id, endpoint2.if_id);
+	else
+		snprintf(priv->ep_name, sizeof(priv->ep_name), "%s.%d",
+			 endpoint2.type, endpoint2.id);
+
+	return 0;
+}
+
 static int
 dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 {
@@ -3527,6 +3577,13 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 		goto init_err;
 	}
 
+	ret = dpaa2_dev_ep_init(dpaa2_dev, priv);
+	if (ret) {
+		DPAA2_PMD_ERR("Failure in get dpni@%d endpoint, err code %d",
+			      hw_id, ret);
+		goto init_err;
+	}
+
 	ret = dpni_get_api_version(dpni_dev, CMD_PRI_LOW, &priv->dpni_ver_major,
 				   &priv->dpni_ver_minor);
 	if (ret) {
@@ -3758,7 +3815,7 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 	priv->sp_protocol = dpaa2_dev->bus_info->sp_protocol;
 
 	DPAA2_PMD_INFO("%s: netdev created, connected to %s",
-		eth_dev->data->name, dpaa2_dev->ep_name);
+		eth_dev->data->name, priv->ep_name);
 
 	priv->speed_capa = dpaa2_dev_get_speed_capability(eth_dev);
 
diff --git a/drivers/net/dpaa2/dpaa2_recycle.c b/drivers/net/dpaa2/dpaa2_recycle.c
index 7569ea9c0d..94ec47a0ad 100644
--- a/drivers/net/dpaa2/dpaa2_recycle.c
+++ b/drivers/net/dpaa2/dpaa2_recycle.c
@@ -630,18 +630,18 @@ dpaa2_dev_recycle_config(struct rte_eth_dev *eth_dev)
 		return 0;
 	}
 
-	if (dpaa2_dev->ep_dev_type == DPAA2_MAC) {
+	if (priv->ep_dev_type == DPAA2_MAC) {
 		/** For dpmac-dpni connection,
 		 * try setting serdes loopback as recycle device at first.
 		 */
 		if (dpaa2_svr_family == SVR_LS2088A) {
-			ret = ls_serdes_eth_lpbk(dpaa2_dev->ep_object_id, 1);
+			ret = ls_serdes_eth_lpbk(priv->ep_object_id, 1);
 			if (!ret) {
 				priv->flags |= DPAA2_TX_SERDES_LOOPBACK_MODE;
 				return 0;
 			}
 		} else if (dpaa2_svr_family == SVR_LX2160A) {
-			ret = lx_serdes_eth_lpbk(dpaa2_dev->ep_object_id, 1);
+			ret = lx_serdes_eth_lpbk(priv->ep_object_id, 1);
 			if (!ret) {
 				priv->flags |= DPAA2_TX_SERDES_LOOPBACK_MODE;
 				return 0;
@@ -670,8 +670,8 @@ dpaa2_dev_recycle_config(struct rte_eth_dev *eth_dev)
 		return 0;
 	}
 
-	if (dpaa2_dev->ep_dev_type == DPAA2_ETH &&
-		dpaa2_dev->object_id == dpaa2_dev->ep_object_id) {
+	if (priv->ep_dev_type == DPAA2_ETH &&
+		dpaa2_dev->object_id == priv->ep_object_id) {
 		priv->flags |= DPAA2_TX_DPNI_LOOPBACK_MODE;
 
 		return 0;
@@ -684,7 +684,6 @@ int
 dpaa2_dev_recycle_deconfig(struct rte_eth_dev *eth_dev)
 {
 	struct dpaa2_dev_priv *priv = eth_dev->data->dev_private;
-	struct rte_dpaa2_device *dpaa2_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *dpaa2_dev);
 	struct fsl_mc_io *dpni_dev = eth_dev->process_private;
 	struct dpni_port_cfg port_cfg;
 	int ret = 0;
@@ -694,7 +693,7 @@ dpaa2_dev_recycle_deconfig(struct rte_eth_dev *eth_dev)
 
 	if (priv->flags & DPAA2_TX_SERDES_LOOPBACK_MODE) {
 		if (dpaa2_svr_family == SVR_LS2088A) {
-			ret = ls_serdes_eth_lpbk(dpaa2_dev->ep_object_id, 0);
+			ret = ls_serdes_eth_lpbk(priv->ep_object_id, 0);
 			if (ret) {
 				DPAA2_PMD_WARN("Error(%d) to disable Serdes loopback",
 					ret);
@@ -702,7 +701,7 @@ dpaa2_dev_recycle_deconfig(struct rte_eth_dev *eth_dev)
 				priv->flags &= ~DPAA2_TX_SERDES_LOOPBACK_MODE;
 			}
 		} else if (dpaa2_svr_family == SVR_LX2160A) {
-			ret = lx_serdes_eth_lpbk(dpaa2_dev->ep_object_id, 0);
+			ret = lx_serdes_eth_lpbk(priv->ep_object_id, 0);
 			if (ret) {
 				DPAA2_PMD_WARN("Error(%d) to disable Serdes loopback",
 					ret);
-- 
2.43.0

