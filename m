Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBECC5CFCF
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 12:15:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 17EE642E10;
	Thu, 13 Aug 2026 14:14:18 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 31A28427D0
 for <dev@dpdk.org>; Thu, 13 Aug 2026 14:14:06 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 162DF20005C;
 Thu, 13 Aug 2026 14:14:06 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D4849200059;
 Thu, 13 Aug 2026 14:14:05 +0200 (CEST)
Received: from lsv03457.swis.in-blr01.nxp.com (lsv03457.swis.in-blr01.nxp.com
 [92.120.147.250])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 62A3518000B5;
 Thu, 13 Aug 2026 20:14:05 +0800 (+08)
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com,
	Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v9-1 12/14] net/enetc4: update VF link status to bitmask
 encoding
Date: Thu, 13 Aug 2026 17:43:56 +0530
Message-Id: <20260813121358.1321196-13-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260813121358.1321196-1-g.singh@nxp.com>
References: <20260812113317.693144-1-g.singh@nxp.com>
 <20260813121358.1321196-1-g.singh@nxp.com>
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

The PF-to-VF link status notification code was previously a two-value
enum (UP=0x0, DOWN=0x1). Change this to a bitmask so future bits can
carry additional state alongside the link up/down indication:

  ENETC_LINK_DOWN  BIT(0)  -- set when link is down

Link up is now encoded as the DOWN bit being clear, which keeps the
wire value for link-down identical (0x1) and ensures backward
compatibility with older kernel PFs.

Changes:
- enetc.h: replace enum link_status with a #define bitmask;
  drop ENETC_LINK_UP (no longer a named constant).
- enetc4_vf.c enetc4_process_psi_msg(): replace switch/case on
  ENETC_LINK_UP/DOWN with bitmask decode.
- enetc4_vf.c enetc4_vf_link_update(): same bitmask decode.

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 doc/guides/rel_notes/release_26_11.rst |  1 +
 drivers/net/enetc/enetc.h              |  8 +++----
 drivers/net/enetc/enetc4_vf.c          | 29 ++++++++------------------
 3 files changed, 14 insertions(+), 24 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 190d77ecee..47090068d0 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -73,6 +73,7 @@ New Features
   * Added stats reset for the ENETC4 VF using a software snapshot/delta approach.
   * Added per-queue MSI-X Rx interrupt support for the ENETC4 VF.
   * Added SI-based port VLAN insertion (Tx) and removal (Rx) for ENETC4 PF and VF.
+  * Updated ENETC4 VF link status reporting to use bitmask encoding.
 
 Removed Items
 -------------
diff --git a/drivers/net/enetc/enetc.h b/drivers/net/enetc/enetc.h
index 8e679e6aa2..9bf7cd43c6 100644
--- a/drivers/net/enetc/enetc.h
+++ b/drivers/net/enetc/enetc.h
@@ -237,10 +237,10 @@ enum vlan_status {
 	ENETC_VLAN_NO_RESOURCE = 0x3
 };
 
-enum link_status {
-	ENETC_LINK_UP = 0x0,
-	ENETC_LINK_DOWN = 0x1
-};
+/* Link status bitmask in PF-to-VF mailbox notification.
+ * Link up is encoded as the DOWN bit being clear.
+ */
+#define ENETC_LINK_DOWN  (1u << 0)
 
 enum speed {
 	ENETC_SPEED_UNKNOWN = 0x0,
diff --git a/drivers/net/enetc/enetc4_vf.c b/drivers/net/enetc/enetc4_vf.c
index 1fcacc84a0..56bc6a694f 100644
--- a/drivers/net/enetc/enetc4_vf.c
+++ b/drivers/net/enetc/enetc4_vf.c
@@ -507,8 +507,10 @@ enetc4_process_psi_msg(struct rte_eth_dev *eth_dev, struct enetc_hw *enetc_hw)
 	enetc4_msg_get_psi_msg(enetc_hw, msg);
 
 	if (msg->class_id == ENETC_CLASS_ID_LINK_STATUS) {
-		switch (msg->status) {
-		case ENETC_LINK_UP:
+		if (msg->status & ENETC_LINK_DOWN) {
+			ENETC_PMD_DEBUG("Link is down");
+			link.link_status = RTE_ETH_LINK_DOWN;
+		} else {
 			ENETC_PMD_DEBUG("Link is up");
 			link.link_status = RTE_ETH_LINK_UP;
 			/* Re-query speed from PF so the cached value reflects
@@ -520,14 +522,6 @@ enetc4_process_psi_msg(struct rte_eth_dev *eth_dev, struct enetc_hw *enetc_hw)
 				enetc4_decode_link_speed(msg->status,
 							hw->vf_link_legacy,
 							&link);
-			break;
-		case ENETC_LINK_DOWN:
-			ENETC_PMD_DEBUG("Link is down");
-			link.link_status = RTE_ETH_LINK_DOWN;
-			break;
-		default:
-			ENETC_PMD_ERR("Unknown link status 0x%x", msg->status);
-			break;
 		}
 		ret = rte_eth_linkstatus_set(eth_dev, &link);
 		if (!ret)
@@ -1209,19 +1203,13 @@ enetc4_vf_link_update(struct rte_eth_dev *dev, int wait_to_complete __rte_unused
 	}
 
 	if (reply_msg->class_id == ENETC_CLASS_ID_LINK_STATUS) {
-		switch (reply_msg->status) {
-		case ENETC_LINK_UP:
-			link.link_status = RTE_ETH_LINK_UP;
-			break;
-		case ENETC_LINK_DOWN:
+		if (reply_msg->status & ENETC_LINK_DOWN)
 			link.link_status = RTE_ETH_LINK_DOWN;
-			break;
-		default:
-			ENETC_PMD_ERR("Unknown link status");
-			break;
-		}
+		else
+			link.link_status = RTE_ETH_LINK_UP;
 	} else {
 		ENETC_PMD_ERR("Wrong reply message");
+		rte_free(reply_msg);
 		return -1;
 	}
 
@@ -1237,6 +1225,7 @@ enetc4_vf_link_update(struct rte_eth_dev *dev, int wait_to_complete __rte_unused
 					 hw->vf_link_legacy, &link);
 	} else {
 		ENETC_PMD_ERR("Wrong reply message");
+		rte_free(reply_msg);
 		return -1;
 	}
 
-- 
2.25.1

