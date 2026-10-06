Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F3BCA5FED
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 09:28:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D236E41101;
	Tue,  6 Oct 2026 11:27:24 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 4214940E09
 for <dev@dpdk.org>; Tue,  6 Oct 2026 11:27:12 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 27B232001AF;
 Tue,  6 Oct 2026 11:27:12 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E67572001A8;
 Tue,  6 Oct 2026 11:27:11 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 73371180022D;
 Tue,  6 Oct 2026 17:27:11 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Subject: [PATCH v21 14/27] net/dpaa: optimize FM deconfig
Date: Tue,  6 Oct 2026 14:56:50 +0530
Message-Id: <20261006092703.2138929-15-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261006092703.2138929-1-hemant.agrawal@nxp.com>
References: <20261005085337.1069213-1-hemant.agrawal@nxp.com>
 <20261006092703.2138929-1-hemant.agrawal@nxp.com>
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

Consolidate FM deconfiguration to avoid duplicate calls.
Move the fm_deconfig call to a single location and remove
redundant checks in the device close path.

Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/net/dpaa/dpaa_ethdev.c | 42 +++++++++++++++-------------------
 drivers/net/dpaa/dpaa_flow.c   |  9 ++++----
 2 files changed, 24 insertions(+), 27 deletions(-)

diff --git a/drivers/net/dpaa/dpaa_ethdev.c b/drivers/net/dpaa/dpaa_ethdev.c
index bf006fefc7..d1fb76224b 100644
--- a/drivers/net/dpaa/dpaa_ethdev.c
+++ b/drivers/net/dpaa/dpaa_ethdev.c
@@ -582,15 +582,6 @@ static int dpaa_eth_dev_close(struct rte_eth_dev *dev)
 		return -ENOENT;
 	}
 
-	/* DPAA FM deconfig */
-	if (!(default_q || fmc_q)) {
-		ret = dpaa_fm_deconfig(dpaa_intf, dev->process_private);
-		if (ret) {
-			DPAA_PMD_WARN("%s: FM deconfig failed(%d)",
-				dev->data->name, ret);
-		}
-	}
-
 	dpaa_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *dpaa_dev);
 	intr_handle = dpaa_dev->intr_handle;
 	__fif = container_of(fif, struct __fman_if, __if);
@@ -631,7 +622,26 @@ static int dpaa_eth_dev_close(struct rte_eth_dev *dev)
 clean_1:
 	/* release configuration memory */
 	rte_free(dpaa_intf->fc_conf);
+	dpaa_intf->fc_conf = NULL;
 
+	/* For FMCLESS mode of share MAC, deconfig FM to direct
+	 * ingress traffic to kernel before fq shutdown.
+	 */
+	if (!(default_q || fmc_q) && dpaa_intf->port_handle) {
+		ret = dpaa_fm_deconfig(dpaa_intf, dev->process_private);
+		if (ret) {
+			DPAA_PMD_WARN("%s: FM deconfig failed(%d)",
+				dev->data->name, ret);
+		}
+	}
+	if (fif->num_profiles) {
+		ret = dpaa_port_vsp_cleanup(dpaa_intf, fif);
+		if (ret) {
+			DPAA_PMD_WARN("%s: cleanup VSP failed(%d)",
+				dev->data->name, ret);
+		}
+	}
+	/* Release congestion Groups after releasing FQIDs */
 	/* Release RX congestion Groups */
 	if (dpaa_intf->cgr_rx) {
 		/* The CGRIDs are a contiguous range, so one scan of the FQID
@@ -685,20 +695,6 @@ static int dpaa_eth_dev_close(struct rte_eth_dev *dev)
 
 	rte_free(dpaa_intf->tx_queues);
 	dpaa_intf->tx_queues = NULL;
-	if (dpaa_intf->port_handle) {
-		ret = dpaa_fm_deconfig(dpaa_intf, fif);
-		if (ret) {
-			DPAA_PMD_WARN("%s: FM deconfig failed(%d)",
-				dev->data->name, ret);
-		}
-	}
-	if (fif->num_profiles) {
-		ret = dpaa_port_vsp_cleanup(dpaa_intf, fif);
-		if (ret) {
-			DPAA_PMD_WARN("%s: cleanup VSP failed(%d)",
-				dev->data->name, ret);
-		}
-	}
 
 	rte_free(dpaa_intf->tx_conf_queues);
 	dpaa_intf->tx_conf_queues = NULL;
diff --git a/drivers/net/dpaa/dpaa_flow.c b/drivers/net/dpaa/dpaa_flow.c
index f21950f64d..bfe294d21d 100644
--- a/drivers/net/dpaa/dpaa_flow.c
+++ b/drivers/net/dpaa/dpaa_flow.c
@@ -728,6 +728,9 @@ int dpaa_fm_deconfig(struct dpaa_if *dpaa_intf,
 
 	PMD_INIT_FUNC_TRACE();
 
+	if (!dpaa_intf->port_handle)
+		return 0;
+
 	/* FM PORT Disable */
 	ret = fm_port_disable(dpaa_intf->port_handle);
 	if (ret != E_OK) {
@@ -787,10 +790,8 @@ int dpaa_fm_config(struct rte_eth_dev *dev, uint64_t req_dist_set)
 	unsigned int i = 0;
 	PMD_INIT_FUNC_TRACE();
 
-	if (dpaa_intf->port_handle) {
-		if (dpaa_fm_deconfig(dpaa_intf, fif))
-			DPAA_PMD_ERR("DPAA FM deconfig failed");
-	}
+	if (dpaa_fm_deconfig(dpaa_intf, fif))
+		DPAA_PMD_ERR("DPAA FM deconfig failed");
 
 	if (!dev->data->nb_rx_queues)
 		return 0;
-- 
2.25.1

