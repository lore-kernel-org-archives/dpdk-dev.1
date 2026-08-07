Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B491C5AC7A
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Aug 2026 11:27:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB4EC40DFB;
	Fri,  7 Aug 2026 13:26:37 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id AAEE840A8A
 for <dev@dpdk.org>; Fri,  7 Aug 2026 13:26:29 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8B4FC2001CC;
 Fri,  7 Aug 2026 13:26:29 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 526142001C1;
 Fri,  7 Aug 2026 13:26:29 +0200 (CEST)
Received: from lsv03457.swis.in-blr01.nxp.com (lsv03457.swis.in-blr01.nxp.com
 [92.120.147.250])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id D01031800088;
 Fri,  7 Aug 2026 19:26:28 +0800 (+08)
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com,
	Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v4 08/14] net/enetc: refresh link speed on VF link-up interrupt
Date: Fri,  7 Aug 2026 16:56:17 +0530
Message-Id: <20260807112623.1402493-9-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260807112623.1402493-1-g.singh@nxp.com>
References: <20260807070241.1151161-1-g.singh@nxp.com>
 <20260807112623.1402493-1-g.singh@nxp.com>
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

Fix this by:

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
 drivers/net/enetc/enetc4_vf.c          | 197 +++++++++++++------------
 2 files changed, 107 insertions(+), 91 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 9e333edf4f..eca0dc1dea 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -67,6 +67,7 @@ New Features
   * Added firmware version reporting for the ENETC4 VF.
   * Added register dump support for ENETC4 PF and VF.
   * Added ring parameters support for the ENETC4 VF (rxq_info_get / txq_info_get).
+  * Refreshed VF link speed on the link-up interrupt in the ENETC4 VF driver.
 
 Removed Items
 -------------
diff --git a/drivers/net/enetc/enetc4_vf.c b/drivers/net/enetc/enetc4_vf.c
index 90b7b99e9a..ede11a7b61 100644
--- a/drivers/net/enetc/enetc4_vf.c
+++ b/drivers/net/enetc/enetc4_vf.c
@@ -324,9 +324,99 @@ enetc4_msg_get_psi_msg(struct enetc_hw *enetc_hw, struct enetc_psi_reply_msg *re
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
+		/* Any status here is > ENETC_SPEED_5000.  Reverse the formula:
+		 *   SPEED = (status - ENETC_SPEED_5000) * 1000 + 5000  (in Mbps)
+		 */
+		link->link_speed = (status - ENETC_SPEED_5000) * 1000 + 5000;
+		link->link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
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
@@ -345,6 +435,20 @@ enetc4_process_psi_msg(struct rte_eth_dev *eth_dev, struct enetc_hw *enetc_hw)
 		case ENETC_LINK_UP:
 			ENETC_PMD_DEBUG("Link is up");
 			link.link_status = RTE_ETH_LINK_UP;
+			/* Re-query speed from PF so the cached value reflects
+			 * the current negotiated speed after link-up.
+			 */
+			rte_free(msg);
+			msg = rte_zmalloc(NULL, sizeof(*msg), RTE_CACHE_LINE_SIZE);
+			if (msg) {
+				if (!enetc4_vf_get_link_speed(eth_dev, msg) &&
+				    msg->class_id == ENETC_CLASS_ID_LINK_SPEED)
+					enetc4_decode_link_speed(msg->status,
+							hw->vf_link_legacy,
+							&link);
+			} else {
+				ENETC_PMD_WARN("Failed to alloc msg for speed query");
+			}
 			break;
 		case ENETC_LINK_DOWN:
 			ENETC_PMD_DEBUG("Link is down");
@@ -1048,97 +1152,8 @@ enetc4_vf_link_update(struct rte_eth_dev *dev, int wait_to_complete __rte_unused
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
-			 * The PF only reports speeds that map to a well-known
-			 * RTE_ETH_SPEED_NUM_* value, so the computed value is a
-			 * valid DPDK speed. If a future speed not yet defined in
-			 * DPDK needs to be supported, the corresponding
-			 * RTE_ETH_SPEED_NUM_* value must first be added upstream.
-			 */
-			link.link_speed = (reply_msg->status - ENETC_SPEED_5000)
-					  * 1000 + 5000;
-			link.link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
-			break;
-		}
+		enetc4_decode_link_speed(reply_msg->status,
+					 hw->vf_link_legacy, &link);
 	} else {
 		ENETC_PMD_ERR("Wrong reply message");
 		return -1;
-- 
2.25.1

