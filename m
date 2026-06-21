Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B571CCD98F2
	for <dpdk-dev@archiver.kernel.org>; Sun, 21 Jun 2026 15:23:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CB3F140670;
	Sun, 21 Jun 2026 17:22:52 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 0909940666
 for <dev@dpdk.org>; Sun, 21 Jun 2026 17:22:48 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E3AF2200250;
 Sun, 21 Jun 2026 17:22:47 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id ACB65200248;
 Sun, 21 Jun 2026 17:22:47 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 54FA4180004C;
 Sun, 21 Jun 2026 23:22:46 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	david.marchand@redhat.com,
	dev@dpdk.org
Subject: [PATCH v3 12/19] net/dpaa: optimize FM deconfig
Date: Sun, 21 Jun 2026 20:52:21 +0530
Message-Id: <20260621152228.2777171-13-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260621152228.2777171-1-hemant.agrawal@nxp.com>
References: <20260621101651.1081425-1-hemant.agrawal@nxp.com>
 <20260621152228.2777171-1-hemant.agrawal@nxp.com>
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
 drivers/net/dpaa/dpaa_ethdev.c | 37 +++++++++++++++++++++++++---------
 drivers/net/dpaa/dpaa_flow.c   |  9 +++++----
 2 files changed, 32 insertions(+), 14 deletions(-)

diff --git a/drivers/net/dpaa/dpaa_ethdev.c b/drivers/net/dpaa/dpaa_ethdev.c
index 5ef3fcdb48..e0b94b9178 100644
--- a/drivers/net/dpaa/dpaa_ethdev.c
+++ b/drivers/net/dpaa/dpaa_ethdev.c
@@ -528,10 +528,12 @@ static int dpaa_eth_dev_close(struct rte_eth_dev *dev)
 
 	/* DPAA FM deconfig */
 	if (!(default_q || fmc_q)) {
-		ret = dpaa_fm_deconfig(dpaa_intf, dev->process_private);
-		if (ret) {
-			DPAA_PMD_WARN("%s: FM deconfig failed(%d)",
-				dev->data->name, ret);
+		if (dpaa_intf->port_handle) {
+			ret = dpaa_fm_deconfig(dpaa_intf, dev->process_private);
+			if (ret) {
+				DPAA_PMD_WARN("%s: FM deconfig failed(%d)",
+					dev->data->name, ret);
+			}
 		}
 	}
 
@@ -577,6 +579,23 @@ static int dpaa_eth_dev_close(struct rte_eth_dev *dev)
 	rte_free(dpaa_intf->fc_conf);
 	dpaa_intf->fc_conf = NULL;
 
+	/** For FMCLESS mode of share MAC, deconfig FM to direct
+	 * ingress traffic to kernel before fq shutdown.
+	 */
+	if (!(default_q || fmc_q)) {
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
 	/** Release congestion Groups after releasing FQIDs*/
 	/* Release RX congestion Groups */
 	if (dpaa_intf->cgr_rx) {
@@ -649,12 +668,10 @@ static int dpaa_eth_dev_close(struct rte_eth_dev *dev)
 	rte_free(dpaa_intf->tx_conf_queues);
 	dpaa_intf->tx_conf_queues = NULL;
 
-	if (dpaa_intf->port_handle) {
-		ret = dpaa_fm_deconfig(dpaa_intf, fif);
-		if (ret) {
-			DPAA_PMD_WARN("%s: FM deconfig failed(%d)",
-				dev->data->name, ret);
-		}
+	ret = dpaa_fm_deconfig(dpaa_intf, fif);
+	if (ret) {
+		DPAA_PMD_WARN("%s: FM deconfig failed(%d)",
+			dev->data->name, ret);
 	}
 	if (fif->num_profiles) {
 		ret = dpaa_port_vsp_cleanup(dpaa_intf, fif);
diff --git a/drivers/net/dpaa/dpaa_flow.c b/drivers/net/dpaa/dpaa_flow.c
index 417b9b6fbb..559850ced7 100644
--- a/drivers/net/dpaa/dpaa_flow.c
+++ b/drivers/net/dpaa/dpaa_flow.c
@@ -724,6 +724,9 @@ int dpaa_fm_deconfig(struct dpaa_if *dpaa_intf,
 
 	PMD_INIT_FUNC_TRACE();
 
+	if (!dpaa_intf->port_handle)
+		return 0;
+
 	/* FM PORT Disable */
 	ret = fm_port_disable(dpaa_intf->port_handle);
 	if (ret != E_OK) {
@@ -783,10 +786,8 @@ int dpaa_fm_config(struct rte_eth_dev *dev, uint64_t req_dist_set)
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

