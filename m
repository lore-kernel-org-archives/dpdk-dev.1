Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4993C5DF7D
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 05:57:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BE8BD40A81;
	Fri, 21 Aug 2026 07:57:02 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 9CC7D40658
 for <dev@dpdk.org>; Fri, 21 Aug 2026 07:56:50 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7BA951A0251;
 Fri, 21 Aug 2026 07:56:50 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3FB2A1A024E;
 Fri, 21 Aug 2026 07:56:50 +0200 (CEST)
Received: from lsv03457.swis.in-blr01.nxp.com (lsv03457.swis.in-blr01.nxp.com
 [92.120.147.250])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id BB63218000BF;
 Fri, 21 Aug 2026 13:56:49 +0800 (+08)
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com,
	Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v12 09/15] net/enetc: refresh link speed on VF link-up
 interrupt
Date: Fri, 21 Aug 2026 11:26:37 +0530
Message-Id: <20260821055643.1359277-10-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260821055643.1359277-1-g.singh@nxp.com>
References: <20260819053415.645865-1-g.singh@nxp.com>
 <20260821055643.1359277-1-g.singh@nxp.com>
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
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 doc/guides/nics/enetc4.rst             |  10 +
 doc/guides/rel_notes/release_26_11.rst |   1 +
 drivers/net/enetc/enetc.h              |   2 +
 drivers/net/enetc/enetc4_ethdev.c      |  26 ++
 drivers/net/enetc/enetc4_vf.c          | 350 ++++++++++++++-----------
 5 files changed, 240 insertions(+), 149 deletions(-)

diff --git a/doc/guides/nics/enetc4.rst b/doc/guides/nics/enetc4.rst
index 9e32c525f5..ff694dd040 100644
--- a/doc/guides/nics/enetc4.rst
+++ b/doc/guides/nics/enetc4.rst
@@ -64,6 +64,16 @@ Key functionality includes:
 - Firmware version: The NETC IP version is reported via ``rte_eth_dev_fw_version_get``.
 - Registers dump: The station interface, port (PF only) and BD ring registers are dumped via ``rte_eth_dev_get_reg_info``.
 
+.. note::
+
+   The LRO (RSC) and TSO (LSO) offloads use a doubled 32B buffer descriptor
+   ring layout that the primary process selects only during queue setup. A
+   secondary process cannot observe that per-queue choice and always uses the
+   base descriptor stride, so running the Rx/Tx datapath from a secondary
+   process is not supported when LRO or TSO is enabled. The ``nc=1``
+   non-cacheable ring mode is stored in shared memory and is honoured by the
+   secondary.
+
 
 Prerequisites
 -------------
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
index eec0edc963..62a8690f10 100644
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
index 790fa910d5..bc0c58e97a 100644
--- a/drivers/net/enetc/enetc4_ethdev.c
+++ b/drivers/net/enetc/enetc4_ethdev.c
@@ -882,6 +882,7 @@ enetc4_dev_close(struct rte_eth_dev *dev)
 		if (dev->data->dev_conf.intr_conf.lsc != 0)
 			enetc4_vf_dev_intr(dev, false);
 		ret = enetc4_vf_dev_stop(dev);
+		pthread_mutex_destroy(&hw->vsi_lock);
 	} else {
 		ret = enetc4_dev_stop(dev);
 	}
@@ -1368,7 +1369,32 @@ enetc4_dev_init(struct rte_eth_dev *eth_dev)
 	struct enetc_hw *enetc_hw = &hw->hw;
 
 	PMD_INIT_FUNC_TRACE();
+
 	eth_dev->dev_ops = &enetc4_ops;
+
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY) {
+		/*
+		 * Secondary process: dev_ops is set above, but the fast-path
+		 * burst pointers must also be set here or
+		 * rte_eth_rx_burst()/rte_eth_tx_burst() would dereference NULL.
+		 * hw->nc_mode lives in the shared dev_private and has already
+		 * been set by the primary, so honour it to match the base BD
+		 * ring layout. The RSC (LRO) and LSO (TSO) bursts use doubled
+		 * 32B descriptor rings that the primary selects only at queue
+		 * setup; the secondary cannot observe that choice, so it always
+		 * uses the base (nc or cacheable) burst. Running the Rx/Tx
+		 * datapath from a secondary is therefore not supported when LRO
+		 * or TSO is enabled (see the ENETC4 NIC guide).
+		 */
+		if (hw->nc_mode) {
+			eth_dev->rx_pkt_burst = &enetc_recv_pkts_nc;
+			eth_dev->tx_pkt_burst = &enetc_xmit_pkts_nc;
+		} else {
+			eth_dev->rx_pkt_burst = &enetc_recv_pkts_cacheable;
+			eth_dev->tx_pkt_burst = &enetc_xmit_pkts_cacheable;
+		}
+		return 0;
+	}
 	enetc4_dev_hw_init(eth_dev);
 
 	si_cap = enetc_rd(enetc_hw, ENETC_SICAPR0);
diff --git a/drivers/net/enetc/enetc4_vf.c b/drivers/net/enetc/enetc4_vf.c
index 3da84941a2..6dd3bc1f0b 100644
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
@@ -344,6 +462,23 @@ enetc4_process_psi_msg(struct rte_eth_dev *eth_dev, struct enetc_hw *enetc_hw)
 		case ENETC_LINK_UP:
 			ENETC_PMD_DEBUG("Link is up");
 			link.link_status = RTE_ETH_LINK_UP;
+			/* Re-query speed from PF so the cached value reflects
+			 * the current negotiated speed after link-up. This is a
+			 * mailbox round trip issued from the link-status
+			 * interrupt handler, which runs on the shared EAL
+			 * interrupt thread with the mailbox interrupt masked, so
+			 * it busy-waits up to (vsi_timeout * vsi_delay) us
+			 * (by default 100 * 2000 us = 200 ms). If this stall on
+			 * the EAL interrupt thread ever becomes a problem, reduce
+			 * the wait budget with the "enetc4_vsi_timeout" and
+			 * "enetc4_vsi_delay" devargs.
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
@@ -368,7 +503,8 @@ enetc4_process_psi_msg(struct rte_eth_dev *eth_dev, struct enetc_hw *enetc_hw)
 }
 
 static int
-enetc4_msg_vsi_send(struct enetc_eth_hw *hw, struct enetc_msg_swbd *msg)
+enetc4_msg_vsi_send(struct enetc_eth_hw *hw, struct enetc_msg_swbd *msg,
+		    int *vsimsgsr_out)
 {
 	struct enetc_hw *enetc_hw = &hw->hw;
 	int timeout = hw->vsi_timeout ? (int)hw->vsi_timeout :
@@ -379,6 +515,7 @@ enetc4_msg_vsi_send(struct enetc_eth_hw *hw, struct enetc_msg_swbd *msg)
 	int err = 0;
 	int vsimsgsr;
 
+	pthread_mutex_lock(&hw->vsi_lock);
 	enetc4_msg_vsi_write_msg(enetc_hw, msg);
 
 	do {
@@ -390,11 +527,13 @@ enetc4_msg_vsi_send(struct enetc_eth_hw *hw, struct enetc_msg_swbd *msg)
 
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
 
@@ -441,6 +580,9 @@ enetc4_msg_vsi_send(struct enetc_eth_hw *hw, struct enetc_msg_swbd *msg)
 		}
 	}
 
+	if (vsimsgsr_out != NULL)
+		*vsimsgsr_out = vsimsgsr;
+	pthread_mutex_unlock(&hw->vsi_lock);
 	return err;
 }
 
@@ -448,12 +590,12 @@ static int
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
@@ -492,13 +634,13 @@ enetc4_vf_set_mac_addr(struct rte_eth_dev *dev, struct rte_ether_addr *addr)
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
@@ -575,7 +717,7 @@ enetc4_vf_promisc_send_message(struct rte_eth_dev *dev, bool promisc_en)
 				ENETC_CMD_ID_SET_MAC_PROMISCUOUS, 0, 0, 0);
 
 	/* send the command and wait */
-	err = enetc4_msg_vsi_send(hw, msg);
+	err = enetc4_msg_vsi_send(hw, msg, NULL);
 	if (err) {
 		ENETC_PMD_ERR("VSI message send error");
 		goto end;
@@ -632,7 +774,7 @@ enetc4_vf_allmulti_send_message(struct rte_eth_dev *dev, bool mc_promisc)
 				ENETC_CMD_ID_SET_MAC_PROMISCUOUS, 0, 0, 0);
 
 	/* send the command and wait */
-	err = enetc4_msg_vsi_send(hw, msg);
+	err = enetc4_msg_vsi_send(hw, msg, NULL);
 	if (err) {
 		ENETC_PMD_ERR("VSI message send error");
 		goto end;
@@ -710,10 +852,10 @@ static int
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
@@ -738,13 +880,13 @@ enetc4_vf_get_link_status(struct rte_eth_dev *dev, struct enetc_psi_reply_msg *r
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
@@ -756,10 +898,10 @@ static int
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
@@ -784,13 +926,13 @@ enetc4_vf_get_link_speed(struct rte_eth_dev *dev, struct enetc_psi_reply_msg *re
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
@@ -809,12 +951,11 @@ static int
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
@@ -840,7 +981,7 @@ enetc4_vf_get_ip_minor_revision(struct rte_eth_dev *dev, uint8_t *ip_mn)
 			ENETC_CMD_ID_GET_IP_MN, 0, 0, 0);
 
 	/* send the command and wait */
-	err = enetc4_msg_vsi_send(hw, msg);
+	err = enetc4_msg_vsi_send(hw, msg, &vsimsgsr);
 	if (err) {
 		ENETC_PMD_ERR("VSI message send error");
 		goto end;
@@ -852,7 +993,6 @@ enetc4_vf_get_ip_minor_revision(struct rte_eth_dev *dev, uint8_t *ip_mn)
 	 * return code, so parse the full low byte here instead of using the
 	 * generic reply parser.
 	 */
-	vsimsgsr = enetc4_rd(enetc_hw, ENETC4_VSIMSGSR);
 	mc = ENETC_SIMSGSR_GET_MC(vsimsgsr);
 	class_id = (mc >> 8) & 0xff;
 
@@ -1051,126 +1191,8 @@ enetc4_vf_link_update(struct rte_eth_dev *dev, int wait_to_complete __rte_unused
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
@@ -1225,7 +1247,7 @@ enetc4_vf_vlan_promisc(struct rte_eth_dev *dev, bool promisc_en)
 				ENETC_CMD_ID_SET_VLAN_PROMISCUOUS, 0, 0, 0);
 
 	/* send the command and wait */
-	err = enetc4_msg_vsi_send(hw, msg);
+	err = enetc4_msg_vsi_send(hw, msg, NULL);
 	if (err) {
 		ENETC_PMD_ERR("VSI message send error");
 		goto end;
@@ -1243,12 +1265,12 @@ enetc4_vf_mac_addr_add(struct rte_eth_dev *dev, struct rte_ether_addr *addr,
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
 
@@ -1288,13 +1310,13 @@ enetc4_vf_mac_addr_add(struct rte_eth_dev *dev, struct rte_ether_addr *addr,
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
@@ -1332,12 +1354,12 @@ enetc4_vf_mac_addr_add(struct rte_eth_dev *dev, struct rte_ether_addr *addr,
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
 
@@ -1388,13 +1410,13 @@ static int enetc4_vf_vlan_filter_set(struct rte_eth_dev *dev, uint16_t vlan_id,
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
@@ -1504,7 +1526,7 @@ enetc4_vf_link_register_notif(struct rte_eth_dev *dev, bool enable)
 			cmd, 0, 0, 0);
 
 	/* send the command and wait */
-	err = enetc4_msg_vsi_send(hw, msg);
+	err = enetc4_msg_vsi_send(hw, msg, NULL);
 	if (err)
 		ENETC_PMD_ERR("VSI msg error for link status notification");
 
@@ -1685,9 +1707,34 @@ enetc4_vf_dev_init(struct rte_eth_dev *eth_dev)
 	int error = 0;
 	uint32_t si_cap;
 	struct enetc_hw *enetc_hw = &hw->hw;
+	pthread_mutexattr_t attr;
 
 	PMD_INIT_FUNC_TRACE();
 
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY) {
+		eth_dev->dev_ops = &enetc4_vf_ops;
+		/*
+		 * Secondary process: set the fast-path burst pointers here or
+		 * rte_eth_rx_burst()/rte_eth_tx_burst() would dereference NULL.
+		 * hw->nc_mode lives in the shared dev_private and has already
+		 * been set by the primary, so honour it to match the base BD
+		 * ring layout. The RSC (LRO) and LSO (TSO) bursts use doubled
+		 * 32B descriptor rings that the primary selects only at queue
+		 * setup; the secondary cannot observe that choice, so it always
+		 * uses the base (nc or cacheable) burst. Running the Rx/Tx
+		 * datapath from a secondary is therefore not supported when LRO
+		 * or TSO is enabled (see the ENETC4 NIC guide).
+		 */
+		if (hw->nc_mode) {
+			eth_dev->rx_pkt_burst = &enetc_recv_pkts_nc;
+			eth_dev->tx_pkt_burst = &enetc_xmit_pkts_nc;
+		} else {
+			eth_dev->rx_pkt_burst = &enetc_recv_pkts_cacheable;
+			eth_dev->tx_pkt_burst = &enetc_xmit_pkts_cacheable;
+		}
+		return 0;
+	}
+
 	/* check if VSI messaging should be disabled via devarg */
 	if (eth_dev->device->devargs) {
 		struct rte_kvargs *kvlist;
@@ -1742,6 +1789,11 @@ enetc4_vf_dev_init(struct rte_eth_dev *eth_dev)
 
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

