Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5E9CD98F2
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Jun 2026 11:35:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6AF464066D;
	Mon, 22 Jun 2026 13:35:31 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 552184060A
 for <dev@dpdk.org>; Mon, 22 Jun 2026 13:35:24 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3272D1A032F;
 Mon, 22 Jun 2026 13:35:24 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id F24721A032C;
 Mon, 22 Jun 2026 13:35:23 +0200 (CEST)
Received: from lsv03457.swis.in-blr01.nxp.com (lsv03457.swis.in-blr01.nxp.com
 [92.120.147.250])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 70905180007B;
 Mon, 22 Jun 2026 19:35:23 +0800 (+08)
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com,
	Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v2 7/9] net/enetc: add devargs to control VSI-PSI timeout and
 delay
Date: Mon, 22 Jun 2026 17:05:15 +0530
Message-Id: <20260622113517.1616028-8-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260622113517.1616028-1-g.singh@nxp.com>
References: <20260619184427.522518-1-g.singh@nxp.com>
 <20260622113517.1616028-1-g.singh@nxp.com>
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

Add two new devargs for ENETC4 VF:
- enetc4_vsi_timeout: VSI-PSI message wait timeout (iteration count)
- enetc4_vsi_delay: VSI-PSI message wait delay in microseconds

Store the values in struct enetc_eth_hw and use them in
enetc4_msg_vsi_send() instead of the hardcoded defaults.
Fall back to ENETC4_DEF_VSI_WAIT_TIMEOUT_UPDATE /
ENETC4_DEF_VSI_WAIT_DELAY_UPDATE when not set.

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 doc/guides/rel_notes/release_26_07.rst |  2 +
 drivers/net/enetc/enetc.h              |  2 +
 drivers/net/enetc/enetc4_vf.c          | 66 +++++++++++++++++++-------
 3 files changed, 53 insertions(+), 17 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index 783ad16..192623d 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -193,6 +193,8 @@ New Features
   * Added scatter-gather support for ENETC4 PFs and VFs.
   * Added devargs option ``enetc4_vsi_disable`` to disable VSI-PSI
     messaging.
+  * Added devargs options ``enetc4_vsi_timeout`` and ``enetc4_vsi_delay``
+    for VSI-PSI messaging timeout and delay.
 
 Removed Items
 -------------
diff --git a/drivers/net/enetc/enetc.h b/drivers/net/enetc/enetc.h
index 01da898..80844e9 100644
--- a/drivers/net/enetc/enetc.h
+++ b/drivers/net/enetc/enetc.h
@@ -112,6 +112,8 @@ struct enetc_eth_hw {
 	uint32_t num_rss;
 	uint32_t max_rx_queues;
 	uint32_t max_tx_queues;
+	uint32_t vsi_timeout; /* VSI-PSI message wait timeout (iterations) */
+	uint32_t vsi_delay;   /* VSI-PSI message wait delay (us) */
 };
 
 /*
diff --git a/drivers/net/enetc/enetc4_vf.c b/drivers/net/enetc/enetc4_vf.c
index 44c0dc0..d78e08e 100644
--- a/drivers/net/enetc/enetc4_vf.c
+++ b/drivers/net/enetc/enetc4_vf.c
@@ -10,6 +10,8 @@
 #include "enetc.h"
 
 #define ENETC4_VSI_DISABLE		"enetc4_vsi_disable"
+#define ENETC4_VSI_TIMEOUT		"enetc4_vsi_timeout"
+#define ENETC4_VSI_DELAY		"enetc4_vsi_delay"
 
 #define ENETC_CRC_TABLE_SIZE		256
 #define ENETC_POLY			0x1021
@@ -262,10 +264,13 @@ enetc4_process_psi_msg(struct rte_eth_dev *eth_dev, struct enetc_hw *enetc_hw)
 }
 
 static int
-enetc4_msg_vsi_send(struct enetc_hw *enetc_hw, struct enetc_msg_swbd *msg)
+enetc4_msg_vsi_send(struct enetc_eth_hw *hw, struct enetc_msg_swbd *msg)
 {
-	int timeout = ENETC4_DEF_VSI_WAIT_TIMEOUT_UPDATE;
-	int delay_us = ENETC4_DEF_VSI_WAIT_DELAY_UPDATE;
+	struct enetc_hw *enetc_hw = &hw->hw;
+	int timeout = hw->vsi_timeout ? (int)hw->vsi_timeout :
+					ENETC4_DEF_VSI_WAIT_TIMEOUT_UPDATE;
+	int delay_us = hw->vsi_delay ? (int)hw->vsi_delay :
+				       ENETC4_DEF_VSI_WAIT_DELAY_UPDATE;
 	uint8_t class_id = 0;
 	int err = 0;
 	int vsimsgsr;
@@ -382,7 +387,7 @@ enetc4_vf_set_mac_addr(struct rte_eth_dev *dev, struct rte_ether_addr *addr)
 					ENETC_CMD_ID_SET_PRIMARY_MAC, 0, 0, 0);
 
 	/* send the command and wait */
-	err = enetc4_msg_vsi_send(enetc_hw, msg);
+	err = enetc4_msg_vsi_send(hw, msg);
 	if (err) {
 		ENETC_PMD_ERR("VSI message send error");
 		goto end;
@@ -426,7 +431,6 @@ static int
 enetc4_vf_promisc_send_message(struct rte_eth_dev *dev, bool promisc_en)
 {
 	struct enetc_eth_hw *hw = ENETC_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct enetc_hw *enetc_hw = &hw->hw;
 	struct enetc_msg_cmd_set_promisc *cmd;
 	struct enetc_msg_swbd *msg;
 	uint32_t msg_size;
@@ -466,7 +470,7 @@ enetc4_vf_promisc_send_message(struct rte_eth_dev *dev, bool promisc_en)
 				ENETC_CMD_ID_SET_MAC_PROMISCUOUS, 0, 0, 0);
 
 	/* send the command and wait */
-	err = enetc4_msg_vsi_send(enetc_hw, msg);
+	err = enetc4_msg_vsi_send(hw, msg);
 	if (err) {
 		ENETC_PMD_ERR("VSI message send error");
 		goto end;
@@ -483,7 +487,6 @@ static int
 enetc4_vf_allmulti_send_message(struct rte_eth_dev *dev, bool mc_promisc)
 {
 	struct enetc_eth_hw *hw = ENETC_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct enetc_hw *enetc_hw = &hw->hw;
 	struct enetc_msg_cmd_set_promisc *cmd;
 	struct enetc_msg_swbd *msg;
 	uint32_t msg_size;
@@ -524,7 +527,7 @@ enetc4_vf_allmulti_send_message(struct rte_eth_dev *dev, bool mc_promisc)
 				ENETC_CMD_ID_SET_MAC_PROMISCUOUS, 0, 0, 0);
 
 	/* send the command and wait */
-	err = enetc4_msg_vsi_send(enetc_hw, msg);
+	err = enetc4_msg_vsi_send(hw, msg);
 	if (err) {
 		ENETC_PMD_ERR("VSI message send error");
 		goto end;
@@ -630,7 +633,7 @@ enetc4_vf_get_link_status(struct rte_eth_dev *dev, struct enetc_psi_reply_msg *r
 			ENETC_CMD_ID_GET_LINK_STATUS, 0, 0, 0);
 
 	/* send the command and wait */
-	err = enetc4_msg_vsi_send(enetc_hw, msg);
+	err = enetc4_msg_vsi_send(hw, msg);
 	if (err) {
 		ENETC_PMD_ERR("VSI message send error");
 		goto end;
@@ -676,7 +679,7 @@ enetc4_vf_get_link_speed(struct rte_eth_dev *dev, struct enetc_psi_reply_msg *re
 			ENETC_CMD_ID_GET_LINK_SPEED, 0, 0, 0);
 
 	/* send the command and wait */
-	err = enetc4_msg_vsi_send(enetc_hw, msg);
+	err = enetc4_msg_vsi_send(hw, msg);
 	if (err) {
 		ENETC_PMD_ERR("VSI message send error");
 		goto end;
@@ -819,7 +822,6 @@ static int
 enetc4_vf_vlan_promisc(struct rte_eth_dev *dev, bool promisc_en)
 {
 	struct enetc_eth_hw *hw = ENETC_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct enetc_hw *enetc_hw = &hw->hw;
 	struct enetc_msg_cmd_set_vlan_promisc *cmd;
 	struct enetc_msg_swbd *msg;
 	uint32_t msg_size;
@@ -858,7 +860,7 @@ enetc4_vf_vlan_promisc(struct rte_eth_dev *dev, bool promisc_en)
 				ENETC_CMD_ID_SET_VLAN_PROMISCUOUS, 0, 0, 0);
 
 	/* send the command and wait */
-	err = enetc4_msg_vsi_send(enetc_hw, msg);
+	err = enetc4_msg_vsi_send(hw, msg);
 	if (err) {
 		ENETC_PMD_ERR("VSI message send error");
 		goto end;
@@ -921,7 +923,7 @@ enetc4_vf_mac_addr_add(struct rte_eth_dev *dev, struct rte_ether_addr *addr,
 			ENETC_MSG_ADD_EXACT_MAC_ENTRIES, 0, 0, 0);
 
 	/* send the command and wait */
-	err = enetc4_msg_vsi_send(enetc_hw, msg);
+	err = enetc4_msg_vsi_send(hw, msg);
 	if (err) {
 		ENETC_PMD_ERR("VSI message send error");
 		goto end;
@@ -1021,7 +1023,7 @@ static int enetc4_vf_vlan_filter_set(struct rte_eth_dev *dev, uint16_t vlan_id,
 	}
 
 	/* send the command and wait */
-	err = enetc4_msg_vsi_send(enetc_hw, msg);
+	err = enetc4_msg_vsi_send(hw, msg);
 	if (err) {
 		ENETC_PMD_ERR("VSI message send error");
 		goto end;
@@ -1104,7 +1106,6 @@ static int
 enetc4_vf_link_register_notif(struct rte_eth_dev *dev, bool enable)
 {
 	struct enetc_eth_hw *hw = ENETC_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct enetc_hw *enetc_hw = &hw->hw;
 	struct enetc_msg_swbd *msg;
 	struct rte_eth_link link;
 	uint32_t msg_size;
@@ -1138,7 +1139,7 @@ enetc4_vf_link_register_notif(struct rte_eth_dev *dev, bool enable)
 			cmd, 0, 0, 0);
 
 	/* send the command and wait */
-	err = enetc4_msg_vsi_send(enetc_hw, msg);
+	err = enetc4_msg_vsi_send(hw, msg);
 	if (err)
 		ENETC_PMD_ERR("VSI msg error for link status notification");
 
@@ -1322,12 +1323,41 @@ enetc4_vf_dev_init(struct rte_eth_dev *eth_dev)
 		kvlist = rte_kvargs_parse(eth_dev->device->devargs->args,
 					  NULL);
 		if (kvlist) {
+			const char *val;
+
 			if (rte_kvargs_count(kvlist, ENETC4_VSI_DISABLE) != 0) {
 				ENETC_PMD_NOTICE("VSI messaging disabled by devarg");
 				eth_dev->dev_ops = &enetc4_vf_ops_no_vsi_m;
 			} else {
 				eth_dev->dev_ops = &enetc4_vf_ops;
 			}
+
+			/* parse optional VSI-PSI timeout devarg */
+			val = rte_kvargs_get(kvlist, ENETC4_VSI_TIMEOUT);
+			if (val) {
+				errno = 0;
+				hw->vsi_timeout = (uint32_t)strtoul(val, NULL, 0);
+				if (errno != 0 || hw->vsi_timeout == 0) {
+					ENETC_PMD_ERR("Invalid VSI Timeout value = %u",
+							hw->vsi_timeout);
+					return -1;
+				}
+				ENETC_PMD_NOTICE("VSI timeout set to %u", hw->vsi_timeout);
+			}
+
+			/* parse optional VSI-PSI delay devarg */
+			val = rte_kvargs_get(kvlist, ENETC4_VSI_DELAY);
+			if (val) {
+				errno = 0;
+				hw->vsi_delay = (uint32_t)strtoul(val, NULL, 0);
+				if (errno != 0 || hw->vsi_delay == 0) {
+					ENETC_PMD_ERR("Invalid VSI Delay value = %u",
+							hw->vsi_delay);
+					return -1;
+				}
+				ENETC_PMD_NOTICE("VSI delay set to %u us", hw->vsi_delay);
+			}
+
 			rte_kvargs_free(kvlist);
 		} else {
 			eth_dev->dev_ops = &enetc4_vf_ops;
@@ -1443,5 +1473,7 @@ RTE_PMD_REGISTER_PCI(net_enetc4_vf, rte_enetc4_vf_pmd);
 RTE_PMD_REGISTER_PCI_TABLE(net_enetc4_vf, pci_vf_id_enetc4_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_enetc4_vf, "* igb_uio | uio_pci_generic");
 RTE_PMD_REGISTER_PARAM_STRING(net_enetc4_vf,
-			      ENETC4_VSI_DISABLE "=<any>");
+			      ENETC4_VSI_DISABLE "=<any> "
+			      ENETC4_VSI_TIMEOUT "=<uint> "
+			      ENETC4_VSI_DELAY "=<uint>");
 RTE_LOG_REGISTER_DEFAULT(enetc4_vf_logtype_pmd, NOTICE);
-- 
2.25.1

