Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34031C5DF6E
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Aug 2026 06:35:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 004DC406B7;
	Mon, 17 Aug 2026 08:35:10 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 480DF402C4
 for <dev@dpdk.org>; Mon, 17 Aug 2026 08:35:01 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 24D9F1A01A4;
 Mon, 17 Aug 2026 08:35:01 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E259C1A01B6;
 Mon, 17 Aug 2026 08:35:00 +0200 (CEST)
Received: from lsv03457.swis.in-blr01.nxp.com (lsv03457.swis.in-blr01.nxp.com
 [92.120.147.250])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 6F36F1800226;
 Mon, 17 Aug 2026 14:35:00 +0800 (+08)
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com,
	Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v10 08/14] net/enetc: refresh link speed on VF link-up
 interrupt
Date: Mon, 17 Aug 2026 12:04:48 +0530
Message-Id: <20260817063454.3290854-9-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260817063454.3290854-1-g.singh@nxp.com>
References: <20260813121358.1321196-1-g.singh@nxp.com>
 <20260817063454.3290854-1-g.singh@nxp.com>
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

The interrupt-driven link-status path (enetc4_process_psi_msg) only
updated link_status when a PSI-to-VSI notification arrived; it never
re-queried the link speed from the PF.  As a result, after a link-down
followed by a link-up the cached link_speed showed the speed from the
previous session rather than the freshly negotiated one.

1. Introducing enetc4_decode_link_speed() - a shared helper that maps
   a PF-to-VF speed status code to the corresponding RTE_ETH_SPEED_NUM_*
   / RTE_ETH_LINK_*_DUPLEX values, handling both the current and the
   legacy (vf_link_legacy) 4-bit message layout.

2. Calling enetc4_vf_get_link_speed() inside enetc4_process_psi_msg()
   on ENETC_LINK_UP so the negotiated speed is fetched from the PF and
   decoded immediately, before rte_eth_linkstatus_set() is called and
   the LSC callback is fired.

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 doc/guides/rel_notes/release_26_11.rst |   1 +
 drivers/net/enetc/enetc.h              |   2 +
 drivers/net/enetc/enetc4_ethdev.c      |   6 +
 drivers/net/enetc/enetc4_vf.c          | 323 +++++++++++++------------
 4 files changed, 183 insertions(+), 149 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index ec223a93ba..1765adc1bc 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -69,6 +69,7 @@ New Features
   * Added firmware version reporting for the ENETC4 VF.
   * Added register dump support for ENETC4 PF and VF.
   * Added ring parameters support for the ENETC4 VF (rxq_info_get / txq_info_get).
+  * Refreshed VF link speed on the link-up interrupt in the ENETC4 VF driver.
 
 Removed Items
 -------------
diff --git a/drivers/net/enetc/enetc.h b/drivers/net/enetc/enetc.h
index fb286537a6..85826c5ab2 100644
--- a/drivers/net/enetc/enetc.h
+++ b/drivers/net/enetc/enetc.h
@@ -5,6 +5,7 @@
 #ifndef _ENETC_H_
 #define _ENETC_H_
 
+#include <pthread.h>
 #include <rte_time.h>
 #include <ethdev_pci.h>
 
@@ -123,6 +124,7 @@ struct enetc_eth_hw {
 	 * for PF kernel versions before 6.18.37. Set via vf_link_legacy devarg.
 	 */
 	uint8_t vf_link_legacy;
+	pthread_mutex_t vsi_lock; /* serializes all VSI-PSI mailbox transactions */
 };
 
 /*
diff --git a/drivers/net/enetc/enetc4_ethdev.c b/drivers/net/enetc/enetc4_ethdev.c
index 5d1c0ad828..5f0b530c2f 100644
--- a/drivers/net/enetc/enetc4_ethdev.c
+++ b/drivers/net/enetc/enetc4_ethdev.c
@@ -867,6 +867,7 @@ enetc4_dev_close(struct rte_eth_dev *dev)
 		if (dev->data->dev_conf.intr_conf.lsc != 0)
 			enetc4_vf_dev_intr(dev, false);
 		ret = enetc4_vf_dev_stop(dev);
+		pthread_mutex_destroy(&hw->vsi_lock);
 	} else {
 		ret = enetc4_dev_stop(dev);
 	}
@@ -1351,6 +1352,11 @@ enetc4_dev_init(struct rte_eth_dev *eth_dev)
 	struct enetc_hw *enetc_hw = &hw->hw;
 
 	PMD_INIT_FUNC_TRACE();
+
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY) {
+		eth_dev->dev_ops = &enetc4_ops;
+		return 0;
+	}
 	eth_dev->dev_ops = &enetc4_ops;
 	enetc4_dev_hw_init(eth_dev);
 
diff --git a/drivers/net/enetc/enetc4_vf.c b/drivers/net/enetc/enetc4_vf.c
index 3da84941a2..d245d7b0e8 100644
--- a/drivers/net/enetc/enetc4_vf.c
+++ b/drivers/net/enetc/enetc4_vf.c
@@ -270,15 +270,12 @@ enetc4_msg_vsi_write_msg(struct enetc_hw *hw,
 }
 
 static void
-enetc4_msg_vsi_reply_msg(struct enetc_hw *enetc_hw, struct enetc_psi_reply_msg *reply_msg)
+enetc4_msg_vsi_reply_msg(struct enetc_eth_hw *hw, int vsimsgsr,
+			 struct enetc_psi_reply_msg *reply_msg)
 {
-	struct enetc_eth_hw *hw = container_of(enetc_hw, struct enetc_eth_hw, hw);
-	int vsimsgsr;
 	int8_t class_id = 0;
 	uint8_t status = 0;
 
-	vsimsgsr = enetc_rd(enetc_hw, ENETC4_VSIMSGSR);
-
 	/* Extracting 8 bits of message result in class_id */
 	class_id |= ((ENETC_SIMSGSR_GET_MC(vsimsgsr) >> 8) & 0xff);
 
@@ -323,9 +320,130 @@ enetc4_msg_get_psi_msg(struct enetc_hw *enetc_hw, struct enetc_psi_reply_msg *re
 	reply_msg->status = status;
 }
 
+/* Forward declaration: defined later in this file */
+static int enetc4_vf_get_link_speed(struct rte_eth_dev *dev,
+				     struct enetc_psi_reply_msg *reply_msg);
+
+/*
+ * Decode a PF-to-VF link-speed status code into the link_speed and
+ * link_duplex fields of *link.  vf_link_legacy selects the older
+ * 4-bit code layout used by kernel PFs before v6.18.37.
+ */
+static void
+enetc4_decode_link_speed(uint8_t status, bool vf_link_legacy,
+			 struct rte_eth_link *link)
+{
+	switch (status) {
+	case ENETC_SPEED_UNKNOWN:
+		ENETC_PMD_DEBUG("Speed unknown");
+		link->link_speed = RTE_ETH_SPEED_NUM_NONE;
+		break;
+	case ENETC_SPEED_10_HALF_DUPLEX:
+		link->link_speed = RTE_ETH_SPEED_NUM_10M;
+		link->link_duplex = RTE_ETH_LINK_HALF_DUPLEX;
+		break;
+	case ENETC_SPEED_10_FULL_DUPLEX:
+		link->link_speed = RTE_ETH_SPEED_NUM_10M;
+		link->link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
+		break;
+	case ENETC_SPEED_100_HALF_DUPLEX:
+		link->link_speed = RTE_ETH_SPEED_NUM_100M;
+		link->link_duplex = RTE_ETH_LINK_HALF_DUPLEX;
+		break;
+	case ENETC_SPEED_100_FULL_DUPLEX:
+		link->link_speed = RTE_ETH_SPEED_NUM_100M;
+		link->link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
+		break;
+	case ENETC_SPEED_1000:
+		link->link_speed = RTE_ETH_SPEED_NUM_1G;
+		link->link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
+		break;
+	case ENETC_SPEED_2500:
+		link->link_speed = RTE_ETH_SPEED_NUM_2_5G;
+		link->link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
+		break;
+	case ENETC_SPEED_5000:
+		link->link_speed = RTE_ETH_SPEED_NUM_5G;
+		link->link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
+		break;
+	default:
+		if (vf_link_legacy) {
+			/* Legacy PF-to-VF message layout (older kernel PF):
+			 * speeds above 5Gbps use fixed 4-bit class codes.
+			 */
+			switch (status) {
+			case ENETC_SPEED_LEGACY_10G:
+				link->link_speed = RTE_ETH_SPEED_NUM_10G;
+				link->link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
+				break;
+			case ENETC_SPEED_LEGACY_25G:
+				link->link_speed = RTE_ETH_SPEED_NUM_25G;
+				link->link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
+				break;
+			case ENETC_SPEED_LEGACY_50G:
+				link->link_speed = RTE_ETH_SPEED_NUM_50G;
+				link->link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
+				break;
+			case ENETC_SPEED_LEGACY_100G:
+				link->link_speed = RTE_ETH_SPEED_NUM_100G;
+				link->link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
+				break;
+			case ENETC_SPEED_LEGACY_NOT_SUPPORTED:
+				ENETC_PMD_DEBUG("Speed not supported");
+				link->link_speed = RTE_ETH_SPEED_NUM_UNKNOWN;
+				break;
+			default:
+				ENETC_PMD_ERR("Unknown speed status");
+				link->link_speed = RTE_ETH_SPEED_NUM_UNKNOWN;
+				break;
+			}
+			break;
+		}
+		/* Any status here is > ENETC_SPEED_5000. Validate against
+		 * the set of speeds that the NETC IP is known to support.
+		 * An unrecognised code yields UNKNOWN rather than a
+		 * fabricated speed.
+		 */
+		switch ((status - ENETC_SPEED_5000) * 1000 + 5000) {
+		case RTE_ETH_SPEED_NUM_10G:
+			link->link_speed = RTE_ETH_SPEED_NUM_10G;
+			link->link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
+			break;
+		case RTE_ETH_SPEED_NUM_25G:
+			link->link_speed = RTE_ETH_SPEED_NUM_25G;
+			link->link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
+			break;
+		case RTE_ETH_SPEED_NUM_40G:
+			link->link_speed = RTE_ETH_SPEED_NUM_40G;
+			link->link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
+			break;
+		case RTE_ETH_SPEED_NUM_50G:
+			link->link_speed = RTE_ETH_SPEED_NUM_50G;
+			link->link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
+			break;
+		case RTE_ETH_SPEED_NUM_100G:
+			link->link_speed = RTE_ETH_SPEED_NUM_100G;
+			link->link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
+			break;
+		case RTE_ETH_SPEED_NUM_200G:
+			link->link_speed = RTE_ETH_SPEED_NUM_200G;
+			link->link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
+			break;
+		default:
+			ENETC_PMD_WARN("Unrecognized speed code 0x%x, "
+				       "reporting unknown", status);
+			link->link_speed = RTE_ETH_SPEED_NUM_UNKNOWN;
+			break;
+		}
+		break;
+	}
+}
+
 static void
 enetc4_process_psi_msg(struct rte_eth_dev *eth_dev, struct enetc_hw *enetc_hw)
 {
+	struct enetc_eth_hw *hw =
+		ENETC_DEV_PRIVATE_TO_HW(eth_dev->data->dev_private);
 	struct enetc_psi_reply_msg *msg;
 	struct rte_eth_link link;
 	int ret = 0;
@@ -344,6 +462,15 @@ enetc4_process_psi_msg(struct rte_eth_dev *eth_dev, struct enetc_hw *enetc_hw)
 		case ENETC_LINK_UP:
 			ENETC_PMD_DEBUG("Link is up");
 			link.link_status = RTE_ETH_LINK_UP;
+			/* Re-query speed from PF so the cached value reflects
+			 * the current negotiated speed after link-up.
+			 */
+			memset(msg, 0, sizeof(*msg));
+			if (!enetc4_vf_get_link_speed(eth_dev, msg) &&
+			    msg->class_id == ENETC_CLASS_ID_LINK_SPEED)
+				enetc4_decode_link_speed(msg->status,
+							hw->vf_link_legacy,
+							&link);
 			break;
 		case ENETC_LINK_DOWN:
 			ENETC_PMD_DEBUG("Link is down");
@@ -368,7 +495,8 @@ enetc4_process_psi_msg(struct rte_eth_dev *eth_dev, struct enetc_hw *enetc_hw)
 }
 
 static int
-enetc4_msg_vsi_send(struct enetc_eth_hw *hw, struct enetc_msg_swbd *msg)
+enetc4_msg_vsi_send(struct enetc_eth_hw *hw, struct enetc_msg_swbd *msg,
+		    int *vsimsgsr_out)
 {
 	struct enetc_hw *enetc_hw = &hw->hw;
 	int timeout = hw->vsi_timeout ? (int)hw->vsi_timeout :
@@ -379,6 +507,7 @@ enetc4_msg_vsi_send(struct enetc_eth_hw *hw, struct enetc_msg_swbd *msg)
 	int err = 0;
 	int vsimsgsr;
 
+	pthread_mutex_lock(&hw->vsi_lock);
 	enetc4_msg_vsi_write_msg(enetc_hw, msg);
 
 	do {
@@ -390,11 +519,13 @@ enetc4_msg_vsi_send(struct enetc_eth_hw *hw, struct enetc_msg_swbd *msg)
 
 	if (!timeout) {
 		ENETC_PMD_ERR("Message not processed by PSI");
+		pthread_mutex_unlock(&hw->vsi_lock);
 		return -ETIMEDOUT;
 	}
 	/* check for message delivery error */
 	if (vsimsgsr & ENETC4_VSIMSGSR_MS) {
 		ENETC_PMD_ERR("Transfer error when copying the data");
+		pthread_mutex_unlock(&hw->vsi_lock);
 		return -EIO;
 	}
 
@@ -441,6 +572,9 @@ enetc4_msg_vsi_send(struct enetc_eth_hw *hw, struct enetc_msg_swbd *msg)
 		}
 	}
 
+	if (vsimsgsr_out != NULL)
+		*vsimsgsr_out = vsimsgsr;
+	pthread_mutex_unlock(&hw->vsi_lock);
 	return err;
 }
 
@@ -448,12 +582,12 @@ static int
 enetc4_vf_set_mac_addr(struct rte_eth_dev *dev, struct rte_ether_addr *addr)
 {
 	struct enetc_eth_hw *hw = ENETC_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct enetc_hw *enetc_hw = &hw->hw;
 	struct enetc_msg_cmd_set_primary_mac *cmd;
 	struct enetc_msg_swbd *msg;
 	struct enetc_psi_reply_msg *reply_msg;
 	uint32_t msg_size;
 	int err = 0;
+	int vsimsgsr_mac_set = 0;
 
 	PMD_INIT_FUNC_TRACE();
 	reply_msg = rte_zmalloc(NULL, sizeof(*reply_msg), RTE_CACHE_LINE_SIZE);
@@ -492,13 +626,13 @@ enetc4_vf_set_mac_addr(struct rte_eth_dev *dev, struct rte_ether_addr *addr)
 					ENETC_CMD_ID_SET_PRIMARY_MAC, 0, 0, 0);
 
 	/* send the command and wait */
-	err = enetc4_msg_vsi_send(hw, msg);
+	err = enetc4_msg_vsi_send(hw, msg, &vsimsgsr_mac_set);
 	if (err) {
 		ENETC_PMD_ERR("VSI message send error");
 		goto end;
 	}
 
-	enetc4_msg_vsi_reply_msg(enetc_hw, reply_msg);
+	enetc4_msg_vsi_reply_msg(hw, vsimsgsr_mac_set, reply_msg);
 
 	if (reply_msg->class_id == ENETC_CLASS_ID_MAC_FILTER) {
 		switch (reply_msg->status) {
@@ -575,7 +709,7 @@ enetc4_vf_promisc_send_message(struct rte_eth_dev *dev, bool promisc_en)
 				ENETC_CMD_ID_SET_MAC_PROMISCUOUS, 0, 0, 0);
 
 	/* send the command and wait */
-	err = enetc4_msg_vsi_send(hw, msg);
+	err = enetc4_msg_vsi_send(hw, msg, NULL);
 	if (err) {
 		ENETC_PMD_ERR("VSI message send error");
 		goto end;
@@ -632,7 +766,7 @@ enetc4_vf_allmulti_send_message(struct rte_eth_dev *dev, bool mc_promisc)
 				ENETC_CMD_ID_SET_MAC_PROMISCUOUS, 0, 0, 0);
 
 	/* send the command and wait */
-	err = enetc4_msg_vsi_send(hw, msg);
+	err = enetc4_msg_vsi_send(hw, msg, NULL);
 	if (err) {
 		ENETC_PMD_ERR("VSI message send error");
 		goto end;
@@ -710,10 +844,10 @@ static int
 enetc4_vf_get_link_status(struct rte_eth_dev *dev, struct enetc_psi_reply_msg *reply_msg)
 {
 	struct enetc_eth_hw *hw = ENETC_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct enetc_hw *enetc_hw = &hw->hw;
 	struct enetc_msg_swbd *msg;
 	uint32_t msg_size;
 	int err = 0;
+	int vsimsgsr_link_st = 0;
 
 	msg = rte_zmalloc(NULL, sizeof(*msg), RTE_CACHE_LINE_SIZE);
 	if (!msg) {
@@ -738,13 +872,13 @@ enetc4_vf_get_link_status(struct rte_eth_dev *dev, struct enetc_psi_reply_msg *r
 			ENETC_CMD_ID_GET_LINK_STATUS, 0, 0, 0);
 
 	/* send the command and wait */
-	err = enetc4_msg_vsi_send(hw, msg);
+	err = enetc4_msg_vsi_send(hw, msg, &vsimsgsr_link_st);
 	if (err) {
 		ENETC_PMD_ERR("VSI message send error");
 		goto end;
 	}
 
-	enetc4_msg_vsi_reply_msg(enetc_hw, reply_msg);
+	enetc4_msg_vsi_reply_msg(hw, vsimsgsr_link_st, reply_msg);
 end:
 	/* free memory no longer required */
 	rte_free(msg->vaddr);
@@ -756,10 +890,10 @@ static int
 enetc4_vf_get_link_speed(struct rte_eth_dev *dev, struct enetc_psi_reply_msg *reply_msg)
 {
 	struct enetc_eth_hw *hw = ENETC_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct enetc_hw *enetc_hw = &hw->hw;
 	struct enetc_msg_swbd *msg;
 	uint32_t msg_size;
 	int err = 0;
+	int vsimsgsr_link_sp = 0;
 
 	msg = rte_zmalloc(NULL, sizeof(*msg), RTE_CACHE_LINE_SIZE);
 	if (!msg) {
@@ -784,13 +918,13 @@ enetc4_vf_get_link_speed(struct rte_eth_dev *dev, struct enetc_psi_reply_msg *re
 			ENETC_CMD_ID_GET_LINK_SPEED, 0, 0, 0);
 
 	/* send the command and wait */
-	err = enetc4_msg_vsi_send(hw, msg);
+	err = enetc4_msg_vsi_send(hw, msg, &vsimsgsr_link_sp);
 	if (err) {
 		ENETC_PMD_ERR("VSI message send error");
 		goto end;
 	}
 
-	enetc4_msg_vsi_reply_msg(enetc_hw, reply_msg);
+	enetc4_msg_vsi_reply_msg(hw, vsimsgsr_link_sp, reply_msg);
 end:
 	/* free memory no longer required */
 	rte_free(msg->vaddr);
@@ -809,12 +943,11 @@ static int
 enetc4_vf_get_ip_minor_revision(struct rte_eth_dev *dev, uint8_t *ip_mn)
 {
 	struct enetc_eth_hw *hw = ENETC_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct enetc_hw *enetc_hw = &hw->hw;
 	struct enetc_msg_swbd *msg;
 	uint32_t msg_size;
 	uint16_t mc;
 	uint8_t class_id;
-	int vsimsgsr;
+	int vsimsgsr = 0;
 	int err = 0;
 
 	msg = rte_zmalloc(NULL, sizeof(*msg), RTE_CACHE_LINE_SIZE);
@@ -840,7 +973,7 @@ enetc4_vf_get_ip_minor_revision(struct rte_eth_dev *dev, uint8_t *ip_mn)
 			ENETC_CMD_ID_GET_IP_MN, 0, 0, 0);
 
 	/* send the command and wait */
-	err = enetc4_msg_vsi_send(hw, msg);
+	err = enetc4_msg_vsi_send(hw, msg, &vsimsgsr);
 	if (err) {
 		ENETC_PMD_ERR("VSI message send error");
 		goto end;
@@ -852,7 +985,6 @@ enetc4_vf_get_ip_minor_revision(struct rte_eth_dev *dev, uint8_t *ip_mn)
 	 * return code, so parse the full low byte here instead of using the
 	 * generic reply parser.
 	 */
-	vsimsgsr = enetc4_rd(enetc_hw, ENETC4_VSIMSGSR);
 	mc = ENETC_SIMSGSR_GET_MC(vsimsgsr);
 	class_id = (mc >> 8) & 0xff;
 
@@ -1051,126 +1183,8 @@ enetc4_vf_link_update(struct rte_eth_dev *dev, int wait_to_complete __rte_unused
 	}
 
 	if (reply_msg->class_id == ENETC_CLASS_ID_LINK_SPEED) {
-		switch (reply_msg->status) {
-		case ENETC_SPEED_UNKNOWN:
-			ENETC_PMD_DEBUG("Speed unknown");
-			link.link_speed = RTE_ETH_SPEED_NUM_NONE;
-			break;
-		case ENETC_SPEED_10_HALF_DUPLEX:
-			link.link_speed = RTE_ETH_SPEED_NUM_10M;
-			link.link_duplex = RTE_ETH_LINK_HALF_DUPLEX;
-			break;
-		case ENETC_SPEED_10_FULL_DUPLEX:
-			link.link_speed = RTE_ETH_SPEED_NUM_10M;
-			link.link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
-			break;
-		case ENETC_SPEED_100_HALF_DUPLEX:
-			link.link_speed = RTE_ETH_SPEED_NUM_100M;
-			link.link_duplex = RTE_ETH_LINK_HALF_DUPLEX;
-			break;
-		case ENETC_SPEED_100_FULL_DUPLEX:
-			link.link_speed = RTE_ETH_SPEED_NUM_100M;
-			link.link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
-			break;
-		case ENETC_SPEED_1000:
-			link.link_speed = RTE_ETH_SPEED_NUM_1G;
-			link.link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
-			break;
-		case ENETC_SPEED_2500:
-			link.link_speed = RTE_ETH_SPEED_NUM_2_5G;
-			link.link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
-			break;
-		case ENETC_SPEED_5000:
-			link.link_speed = RTE_ETH_SPEED_NUM_5G;
-			link.link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
-			break;
-		default:
-			if (hw->vf_link_legacy) {
-				/* Legacy PF-to-VF message layout (older kernel
-				 * PF): speeds greater than 5Gbps are encoded
-				 * with fixed 4-bit class codes rather than the
-				 * formula below.
-				 */
-				switch (reply_msg->status) {
-				case ENETC_SPEED_LEGACY_10G:
-					link.link_speed = RTE_ETH_SPEED_NUM_10G;
-					link.link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
-					break;
-				case ENETC_SPEED_LEGACY_25G:
-					link.link_speed = RTE_ETH_SPEED_NUM_25G;
-					link.link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
-					break;
-				case ENETC_SPEED_LEGACY_50G:
-					link.link_speed = RTE_ETH_SPEED_NUM_50G;
-					link.link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
-					break;
-				case ENETC_SPEED_LEGACY_100G:
-					link.link_speed = RTE_ETH_SPEED_NUM_100G;
-					link.link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
-					break;
-				case ENETC_SPEED_LEGACY_NOT_SUPPORTED:
-					ENETC_PMD_DEBUG("Speed not supported");
-					link.link_speed = RTE_ETH_SPEED_NUM_UNKNOWN;
-					break;
-				default:
-					ENETC_PMD_ERR("Unknown speed status");
-					link.link_speed = RTE_ETH_SPEED_NUM_UNKNOWN;
-					break;
-				}
-				break;
-			}
-
-			/* Any status reaching here is greater than
-			 * ENETC_SPEED_5000, as all values from 0x0 to
-			 * ENETC_SPEED_5000 are handled by the cases above. Speeds
-			 * greater than 5Gbps are not enumerated and follow the
-			 * formula:
-			 *
-			 *   SPEED = (link_speed - 5000) / 1000 + ENETC_SPEED_5000
-			 *
-			 * where link_speed is in Mbps. Reverse it here to get the
-			 * actual link speed (RTE_ETH_SPEED_NUM_* values are in Mbps).
-			 *
-			 * Validate the computed value against the set of speeds
-			 * that the NETC IP is known to support (> 5Gbps).
-			 * An unrecognised code yields UNKNOWN rather than a
-			 * fabricated speed.
-			 */
-			switch ((reply_msg->status - ENETC_SPEED_5000)
-				* 1000 + 5000) {
-			case RTE_ETH_SPEED_NUM_10G:
-				link.link_speed = RTE_ETH_SPEED_NUM_10G;
-				link.link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
-				break;
-			case RTE_ETH_SPEED_NUM_25G:
-				link.link_speed = RTE_ETH_SPEED_NUM_25G;
-				link.link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
-				break;
-			case RTE_ETH_SPEED_NUM_40G:
-				link.link_speed = RTE_ETH_SPEED_NUM_40G;
-				link.link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
-				break;
-			case RTE_ETH_SPEED_NUM_50G:
-				link.link_speed = RTE_ETH_SPEED_NUM_50G;
-				link.link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
-				break;
-			case RTE_ETH_SPEED_NUM_100G:
-				link.link_speed = RTE_ETH_SPEED_NUM_100G;
-				link.link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
-				break;
-			case RTE_ETH_SPEED_NUM_200G:
-				link.link_speed = RTE_ETH_SPEED_NUM_200G;
-				link.link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
-				break;
-			default:
-				ENETC_PMD_WARN("Unrecognized speed code 0x%x, "
-					       "reporting unknown",
-					       reply_msg->status);
-				link.link_speed = RTE_ETH_SPEED_NUM_UNKNOWN;
-				break;
-			}
-			break;
-		}
+		enetc4_decode_link_speed(reply_msg->status,
+					 hw->vf_link_legacy, &link);
 	} else {
 		ENETC_PMD_ERR("Wrong reply message");
 		return -1;
@@ -1225,7 +1239,7 @@ enetc4_vf_vlan_promisc(struct rte_eth_dev *dev, bool promisc_en)
 				ENETC_CMD_ID_SET_VLAN_PROMISCUOUS, 0, 0, 0);
 
 	/* send the command and wait */
-	err = enetc4_msg_vsi_send(hw, msg);
+	err = enetc4_msg_vsi_send(hw, msg, NULL);
 	if (err) {
 		ENETC_PMD_ERR("VSI message send error");
 		goto end;
@@ -1243,12 +1257,12 @@ enetc4_vf_mac_addr_add(struct rte_eth_dev *dev, struct rte_ether_addr *addr,
 			uint32_t index __rte_unused, uint32_t pool __rte_unused)
 {
 	struct enetc_eth_hw *hw = ENETC_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct enetc_hw *enetc_hw = &hw->hw;
 	struct enetc_msg_cmd_set_primary_mac *cmd;
 	struct enetc_msg_swbd *msg;
 	struct enetc_psi_reply_msg *reply_msg;
 	uint32_t msg_size;
 	int err = 0;
+	int vsimsgsr_mac_add = 0;
 
 	PMD_INIT_FUNC_TRACE();
 
@@ -1288,13 +1302,13 @@ enetc4_vf_mac_addr_add(struct rte_eth_dev *dev, struct rte_ether_addr *addr,
 			ENETC_MSG_ADD_EXACT_MAC_ENTRIES, 0, 0, 0);
 
 	/* send the command and wait */
-	err = enetc4_msg_vsi_send(hw, msg);
+	err = enetc4_msg_vsi_send(hw, msg, &vsimsgsr_mac_add);
 	if (err) {
 		ENETC_PMD_ERR("VSI message send error");
 		goto end;
 	}
 
-	enetc4_msg_vsi_reply_msg(enetc_hw, reply_msg);
+	enetc4_msg_vsi_reply_msg(hw, vsimsgsr_mac_add, reply_msg);
 
 	if (reply_msg->class_id == ENETC_CLASS_ID_MAC_FILTER) {
 		switch (reply_msg->status) {
@@ -1332,12 +1346,12 @@ enetc4_vf_mac_addr_add(struct rte_eth_dev *dev, struct rte_ether_addr *addr,
 static int enetc4_vf_vlan_filter_set(struct rte_eth_dev *dev, uint16_t vlan_id, int on)
 {
 	struct enetc_eth_hw *hw = ENETC_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct enetc_hw *enetc_hw = &hw->hw;
 	struct enetc_msg_vlan_exact_filter *cmd;
 	struct enetc_msg_swbd *msg;
 	struct enetc_psi_reply_msg *reply_msg;
 	uint32_t msg_size;
 	int err = 0;
+	int vsimsgsr_vlan = 0;
 
 	PMD_INIT_FUNC_TRACE();
 
@@ -1388,13 +1402,13 @@ static int enetc4_vf_vlan_filter_set(struct rte_eth_dev *dev, uint16_t vlan_id,
 	}
 
 	/* send the command and wait */
-	err = enetc4_msg_vsi_send(hw, msg);
+	err = enetc4_msg_vsi_send(hw, msg, &vsimsgsr_vlan);
 	if (err) {
 		ENETC_PMD_ERR("VSI message send error");
 		goto end;
 	}
 
-	enetc4_msg_vsi_reply_msg(enetc_hw, reply_msg);
+	enetc4_msg_vsi_reply_msg(hw, vsimsgsr_vlan, reply_msg);
 
 	if (reply_msg->class_id == ENETC_CLASS_ID_VLAN_FILTER) {
 		switch (reply_msg->status) {
@@ -1504,7 +1518,7 @@ enetc4_vf_link_register_notif(struct rte_eth_dev *dev, bool enable)
 			cmd, 0, 0, 0);
 
 	/* send the command and wait */
-	err = enetc4_msg_vsi_send(hw, msg);
+	err = enetc4_msg_vsi_send(hw, msg, NULL);
 	if (err)
 		ENETC_PMD_ERR("VSI msg error for link status notification");
 
@@ -1685,9 +1699,15 @@ enetc4_vf_dev_init(struct rte_eth_dev *eth_dev)
 	int error = 0;
 	uint32_t si_cap;
 	struct enetc_hw *enetc_hw = &hw->hw;
+	pthread_mutexattr_t attr;
 
 	PMD_INIT_FUNC_TRACE();
 
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY) {
+		eth_dev->dev_ops = &enetc4_vf_ops;
+		return 0;
+	}
+
 	/* check if VSI messaging should be disabled via devarg */
 	if (eth_dev->device->devargs) {
 		struct rte_kvargs *kvlist;
@@ -1742,6 +1762,11 @@ enetc4_vf_dev_init(struct rte_eth_dev *eth_dev)
 
 	enetc4_dev_hw_init(eth_dev);
 
+	pthread_mutexattr_init(&attr);
+	pthread_mutexattr_setpshared(&attr, PTHREAD_PROCESS_SHARED);
+	pthread_mutex_init(&hw->vsi_lock, &attr);
+	pthread_mutexattr_destroy(&attr);
+
 	hw->nc_mode = 0;
 	enetc4_vf_get_devarg_nc(eth_dev);
 	if (hw->nc_mode) {
-- 
2.25.1

