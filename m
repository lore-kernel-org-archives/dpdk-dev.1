Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B62606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Oct 2026 05:21:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 94EE340A6C;
	Fri, 30 Oct 2026 06:20:37 +0100 (CET)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTPS id BEF5240A7D
 for <dev@dpdk.org>; Fri, 30 Oct 2026 06:20:31 +0100 (CET)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8883A2000BC;
 Fri, 30 Oct 2026 06:20:31 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5DF772000CB;
 Fri, 30 Oct 2026 06:20:31 +0100 (CET)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 0AB011800224;
 Fri, 30 Oct 2026 13:20:29 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v5-S3 09/14] drivers: net/dpaa2: move DPNI endpoint lookup to
 PMD
Date: Fri, 30 Oct 2026 10:50:11 +0530
Message-ID: <20261030052016.3301766-10-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261030052016.3301766-1-prashant.gupta_3@nxp.com>
References: <20261023134346.37727-1-prashant.gupta_3@nxp.com>
 <20261030052016.3301766-1-prashant.gupta_3@nxp.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jun Yang <jun.yang@nxp.com>

The fslmc bus scan was doing a DPNI-specific endpoint lookup for every
DPAA2 device inside rte_dpaa2_create_dprc_device(): for each DPAA2_ETH
object it issued dprc_get_connection(dpni.<id>) and stored the result
(ep_dev_type / ep_object_id / ep_name) directly on the generic
rte_dpaa2_device. This had several problems:

  - It made the generic bus device carry DPNI-specific knowledge.
    Non-eth DPAA2 object types (DPCI, DPIO, DPSECI, DPDMAI, ...) that
    may also have endpoints never populated these fields, so the
    "endpoint" of any non-DPNI device was silently wrong.
  - DPDMUX and DPSW endpoints are per-interface (identified by
    endpoint.if_id in addition to the object id), but the bus code
    only ever formatted "<type>.<id>" and dropped if_id, producing
    an ambiguous ep_name for those connection types.
  - A dprc_get_connection() failure on any single DPNI aborted the
    whole DPRC scan and freed the dprc node, even if the failing
    DPNI was never going to be used by this process.
  - It coupled the bus scan to the MC command set exposed by
    fsl_dprc.h, and forced every DPAA2 user of the bus to carry
    those symbols even if it did not care about endpoints.

Move the DPNI endpoint lookup where it belongs: into the DPAA2 net
PMD, which is the only consumer today. The bus layer now just assigns
each device to its parent DPRC container during the scan and lets each
object driver decide whether (and how) to resolve its endpoint.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/bus/fslmc/bus_fslmc_driver.h     |  3 --
 drivers/bus/fslmc/portal/dpaa2_hw_dprc.c | 49 +++-----------------
 drivers/net/dpaa2/dpaa2_ethdev.c         | 59 +++++++++++++++++++++++-
 drivers/net/dpaa2/dpaa2_recycle.c        | 15 +++---
 4 files changed, 71 insertions(+), 55 deletions(-)

diff --git a/drivers/bus/fslmc/bus_fslmc_driver.h b/drivers/bus/fslmc/bus_fslmc_driver.h
index 26292e54bb..1cef0d7b4b 100644
--- a/drivers/bus/fslmc/bus_fslmc_driver.h
+++ b/drivers/bus/fslmc/bus_fslmc_driver.h
@@ -103,10 +103,7 @@ struct rte_dpaa2_device {
 	struct rte_device device;           /**< Inherit core device */
 	enum rte_dpaa2_dev_type dev_type;   /**< Device Type */
 	uint16_t object_id;                 /**< DPAA2 Object ID */
-	enum rte_dpaa2_dev_type ep_dev_type;   /**< Endpoint Device Type */
 	struct dpaa2_dprc_dev *container;
-	uint16_t ep_object_id;                 /**< Endpoint DPAA2 Object ID */
-	char ep_name[RTE_DEV_NAME_MAX_LEN];
 	struct rte_intr_handle *intr_handle; /**< Interrupt handle */
 	char name[FSLMC_OBJECT_MAX_LEN];    /**< DPAA2 Object name*/
 	const struct rte_fslmc_bus_info *bus_info;
diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dprc.c b/drivers/bus/fslmc/portal/dpaa2_hw_dprc.c
index 2234da0975..92238c174e 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dprc.c
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dprc.c
@@ -28,7 +28,6 @@ rte_dpaa2_create_dprc_device(int vdev_fd __rte_unused,
 	struct rte_dpaa2_device *obj)
 {
 	struct dpaa2_dprc_dev *dprc_node;
-	struct dprc_endpoint endpoint1, endpoint2;
 	struct rte_dpaa2_device *dev;
 	int ret, dprc_id = obj->object_id;
 
@@ -50,50 +49,14 @@ rte_dpaa2_create_dprc_device(int vdev_fd __rte_unused,
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
 
-		if (rte_bus_device_is_ignored(&rte_fslmc_bus, dev->device.name))
-			continue;
-
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
-
 	TAILQ_INSERT_TAIL(&dprc_dev_list, dprc_node, next);
 
 	return 0;
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 81118d02f8..0eafee8832 100644
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
@@ -3443,6 +3444,55 @@ populate_mac_addr(struct fsl_mc_io *dpni_dev,
 	return ret;
 }
 
+/* Resolve the object this DPNI is wired to inside its DPRC container. The
+ * endpoint decides whether MAC-level operations (link, promisc, flow control)
+ * are available, and it is reported to the application by
+ * rte_pmd_dpaa2_ep_name().
+ */
+static int
+dpaa2_dev_ep_init(struct rte_dpaa2_device *dpaa2_dev,
+	struct dpaa2_dev_priv *priv)
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
+		dprc_node->token, &endpoint1, &endpoint2, &link_state);
+	if (ret)
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
+	if (priv->ep_dev_type == DPAA2_MUX || priv->ep_dev_type == DPAA2_SW) {
+		snprintf(priv->ep_name, sizeof(priv->ep_name), "%s.%d.%d",
+			endpoint2.type, endpoint2.id, endpoint2.if_id);
+	} else {
+		snprintf(priv->ep_name, sizeof(priv->ep_name), "%s.%d",
+			endpoint2.type, endpoint2.id);
+	}
+
+	return 0;
+}
+
 static int
 dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 {
@@ -3525,6 +3575,13 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 		goto init_err;
 	}
 
+	ret = dpaa2_dev_ep_init(dpaa2_dev, priv);
+	if (ret) {
+		DPAA2_PMD_ERR("Failure in get dpni@%d endpoint, err code %d",
+			hw_id, ret);
+		goto init_err;
+	}
+
 	ret = dpni_get_api_version(dpni_dev, CMD_PRI_LOW, &priv->dpni_ver_major,
 			&priv->dpni_ver_minor);
 	if (ret) {
@@ -3731,7 +3788,7 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 	if (ret > 0)
 		DPAA2_PMD_INFO("soft parser is loaded");
 	DPAA2_PMD_INFO("%s: netdev created, connected to %s",
-		eth_dev->data->name, dpaa2_dev->ep_name);
+		eth_dev->data->name, priv->ep_name);
 
 	priv->speed_capa = dpaa2_dev_get_speed_capability(eth_dev);
 
diff --git a/drivers/net/dpaa2/dpaa2_recycle.c b/drivers/net/dpaa2/dpaa2_recycle.c
index 9b6ae3f515..37dbb47c9c 100644
--- a/drivers/net/dpaa2/dpaa2_recycle.c
+++ b/drivers/net/dpaa2/dpaa2_recycle.c
@@ -627,18 +627,18 @@ dpaa2_dev_recycle_config(struct rte_eth_dev *eth_dev)
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
@@ -667,8 +667,8 @@ dpaa2_dev_recycle_config(struct rte_eth_dev *eth_dev)
 		return 0;
 	}
 
-	if (dpaa2_dev->ep_dev_type == DPAA2_ETH &&
-		dpaa2_dev->object_id == dpaa2_dev->ep_object_id) {
+	if (priv->ep_dev_type == DPAA2_ETH &&
+		dpaa2_dev->object_id == priv->ep_object_id) {
 		priv->flags |= DPAA2_TX_DPNI_LOOPBACK_MODE;
 
 		return 0;
@@ -681,7 +681,6 @@ int
 dpaa2_dev_recycle_deconfig(struct rte_eth_dev *eth_dev)
 {
 	struct dpaa2_dev_priv *priv = eth_dev->data->dev_private;
-	struct rte_dpaa2_device *dpaa2_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *dpaa2_dev);
 	struct fsl_mc_io *dpni_dev = eth_dev->process_private;
 	struct dpni_port_cfg port_cfg;
 	int ret = 0;
@@ -691,7 +690,7 @@ dpaa2_dev_recycle_deconfig(struct rte_eth_dev *eth_dev)
 
 	if (priv->flags & DPAA2_TX_SERDES_LOOPBACK_MODE) {
 		if (dpaa2_svr_family == SVR_LS2088A) {
-			ret = ls_serdes_eth_lpbk(dpaa2_dev->ep_object_id, 0);
+			ret = ls_serdes_eth_lpbk(priv->ep_object_id, 0);
 			if (ret) {
 				DPAA2_PMD_WARN("Error(%d) to disable Serdes loopback",
 					ret);
@@ -699,7 +698,7 @@ dpaa2_dev_recycle_deconfig(struct rte_eth_dev *eth_dev)
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

