Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A88FC5AC7A
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Aug 2026 03:48:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 69F9D40671;
	Fri,  7 Aug 2026 05:48:38 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id E57C4402AC
 for <dev@dpdk.org>; Fri,  7 Aug 2026 05:48:34 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C981220010D;
 Fri,  7 Aug 2026 05:48:34 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 915D420010E;
 Fri,  7 Aug 2026 05:48:34 +0200 (CEST)
Received: from lsv03457.swis.in-blr01.nxp.com (lsv03457.swis.in-blr01.nxp.com
 [92.120.147.250])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 1B2CD18000B1;
 Fri,  7 Aug 2026 11:48:34 +0800 (+08)
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com,
	Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v2 04/14] net/enetc: extend link speed code field to 8-bit for
 PF-to-VF message
Date: Fri,  7 Aug 2026 09:18:19 +0530
Message-Id: <20260807034829.1030307-5-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260807034829.1030307-1-g.singh@nxp.com>
References: <20260806112836.707921-1-g.singh@nxp.com>
 <20260807034829.1030307-1-g.singh@nxp.com>
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

The PF-to-VF message is only 16-bit wide, where the upper 8-bit is the
class_id and the lower 8-bit carries the message content. For the
link speed message, the lower 4-bit was previously occupied by the cookie
field, leaving only 4-bit for the speed code, which allows at most
15 distinct speed values.

As the NETC IP evolves and supports more and more link speeds, 15 speed
values are clearly insufficient. Since the cookie field is designed
for non-blocking messages and has no meaningful use in link speed
messages, remove it and expand the speed code field from 4-bit to 8-bit,
allowing up to 255 speed values (ENETC_SPEED_MAX = 0xff).

Instead of enumerating every speed value greater than 5Gbps
explicitly, introduce a formula-based approach:

	speed_code = (link_speed - 5000) / 1000 + ENETC_SPEED_5000

This removes the explicit enum entries for 10G, 25G, 50G and 100G,
and replaces the individual switch-case branches with a generic
implementation to get the speed, making it easy to support any
future high speed without modifying the enum or the switch statement.

For backward compatibility with a PF running an older kernel (before
6.18.37) that still uses the legacy 4-bit speed code / 4-bit cookie
message layout, add a "vf_link_legacy" devarg. When set to 1, the VF
extracts the message result from the upper 4 bits of the lower byte
and decodes speeds greater than 5Gbps using the legacy fixed class
codes (10G/25G/50G/100G). The default (0) uses the new 8-bit layout.

	Usage: -a <pci_addr>,vf_link_legacy=1

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 doc/guides/rel_notes/release_26_11.rst |   1 +
 drivers/net/enetc/enetc.h              |  32 ++++-
 drivers/net/enetc/enetc4_vf.c          | 175 +++++++++++++++++++++----
 3 files changed, 175 insertions(+), 33 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 0dd08e0259..d7961d3c85 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -63,6 +63,7 @@ New Features
   * Added KEEP_CRC Rx offload support for the ENETC4 PMD to preserve the Ethernet FCS.
   * Added TCP Segmentation Offload (TSO) support for the ENETC4 VF.
   * Added Receive Segment Coalesce (RSC / hardware LRO) support for ENETC4 PF and VF.
+  * Extended the PF-to-VF link speed code field from 4-bit to 8-bit in ENETC4.
 
 Removed Items
 -------------
diff --git a/drivers/net/enetc/enetc.h b/drivers/net/enetc/enetc.h
index 67f8ce1919..c983cb059e 100644
--- a/drivers/net/enetc/enetc.h
+++ b/drivers/net/enetc/enetc.h
@@ -120,6 +120,10 @@ struct enetc_eth_hw {
 	uint32_t vsi_delay;   /* VSI-PSI message wait delay (us) */
 	uint32_t *txq_prior;  /* per-queue TX priority (TBMR priority bits) */
 	uint8_t nc_mode;      /* 1 = non-cacheable BD memory, use _nc ops */
+	/* 1 = legacy PF-to-VF link message layout (4-bit speed / 4-bit cookie),
+	 * for PF kernel versions before 6.18.37. Set via vf_link_legacy devarg.
+	 */
+	uint8_t vf_link_legacy;
 };
 
 /*
@@ -211,11 +215,29 @@ enum speed {
 	ENETC_SPEED_1000 = 0x5,
 	ENETC_SPEED_2500 = 0x6,
 	ENETC_SPEED_5000 = 0x7,
-	ENETC_SPEED_10G = 0x8,
-	ENETC_SPEED_25G = 0x9,
-	ENETC_SPEED_50G = 0xA,
-	ENETC_SPEED_100G = 0xB,
-	ENETC_SPEED_NOT_SUPPORTED = 0xF
+	/* Base speed class code used by the >5Gbps formula below */
+	/* Do not add enumeration values for any speed greater than
+	 * 5Gbps. For any speed greater than 5Gbps, its speed class
+	 * code should follow the formula below.
+	 *
+	 * SPEED = (link_speed - 5000) / 1000 + ENETC_SPEED_5000
+	 *
+	 * The unit of link_speed should be Mbps, the max SPEED
+	 * should <= ENETC_SPEED_MAX.
+	 */
+	ENETC_SPEED_MAX = 0xff,
+};
+
+/* Legacy speed class codes for backward compatibility with an older kernel PF
+ * (before 6.18.37) that encoded a 4-bit speed code and 4-bit cookie in the
+ * message's lower byte. Used only when the vf_link_legacy devarg is set.
+ */
+enum speed_legacy {
+	ENETC_SPEED_LEGACY_10G = 0x8,
+	ENETC_SPEED_LEGACY_25G = 0x9,
+	ENETC_SPEED_LEGACY_50G = 0xA,
+	ENETC_SPEED_LEGACY_100G = 0xB,
+	ENETC_SPEED_LEGACY_NOT_SUPPORTED = 0xF
 };
 
 /* PSI-VSI command header format */
diff --git a/drivers/net/enetc/enetc4_vf.c b/drivers/net/enetc/enetc4_vf.c
index be79a18a39..d34b8019ea 100644
--- a/drivers/net/enetc/enetc4_vf.c
+++ b/drivers/net/enetc/enetc4_vf.c
@@ -5,6 +5,7 @@
 #include <stdbool.h>
 #include <rte_kvargs.h>
 #include <rte_random.h>
+#include <rte_kvargs.h>
 #include <dpaax_iova_table.h>
 #include "enetc_logs.h"
 #include "enetc.h"
@@ -43,6 +44,12 @@ enetc4_vf_get_devarg_nc(struct rte_eth_dev *dev)
 #define ENETC_BYTE_SIZE			8
 #define ENETC_MSB_BIT			0x8000
 
+/* Backward-compat devarg for a PF running a kernel before 6.18.37, which uses
+ * the legacy PF-to-VF link message layout (4-bit speed code + 4-bit cookie).
+ * Usage: -a <pci_addr>,vf_link_legacy=1
+ */
+#define ENETC_VF_LINK_LEGACY		"vf_link_legacy"
+
 uint16_t enetc_crc_table[ENETC_CRC_TABLE_SIZE];
 bool enetc_crc_gen;
 
@@ -101,6 +108,59 @@ enetc_crc_calc(uint16_t crc, const uint8_t *buffer, size_t len)
 	return crc;
 }
 
+static int
+parse_vf_link_legacy(const char *key __rte_unused, const char *value,
+		     void *opaque)
+{
+	struct rte_eth_dev *dev = (struct rte_eth_dev *)opaque;
+	struct enetc_eth_hw *hw =
+			ENETC_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	char *endptr;
+	unsigned long val;
+
+	if (!value || *value == '\0') {
+		ENETC_PMD_WARN("Empty value for devarg %s, ignoring",
+			       ENETC_VF_LINK_LEGACY);
+		return -EINVAL;
+	}
+
+	errno = 0;
+	val = strtoul(value, &endptr, 0);
+	if (errno != 0 || *endptr != '\0' || val > 1) {
+		ENETC_PMD_WARN("Invalid value '%s' for devarg %s, expected 0 or 1",
+			       value, ENETC_VF_LINK_LEGACY);
+		return -EINVAL;
+	}
+
+	hw->vf_link_legacy = (uint8_t)val;
+
+	return 0;
+}
+
+static void
+enetc4_vf_get_devargs(struct rte_eth_dev *dev)
+{
+	struct rte_devargs *devargs;
+	struct rte_kvargs *kvlist;
+
+	devargs = dev->device->devargs;
+	if (!devargs)
+		return;
+
+	kvlist = rte_kvargs_parse(devargs->args, NULL);
+	if (!kvlist)
+		return;
+
+	if (rte_kvargs_count(kvlist, ENETC_VF_LINK_LEGACY)) {
+		if (rte_kvargs_process(kvlist, ENETC_VF_LINK_LEGACY,
+				       parse_vf_link_legacy, (void *)dev) < 0)
+			ENETC_PMD_WARN("Failed to parse devarg %s",
+				       ENETC_VF_LINK_LEGACY);
+	}
+
+	rte_kvargs_free(kvlist);
+}
+
 static int
 enetc4_vf_dev_infos_get(struct rte_eth_dev *dev,
 			struct rte_eth_dev_info *dev_info)
@@ -212,6 +272,7 @@ enetc4_msg_vsi_write_msg(struct enetc_hw *hw,
 static void
 enetc4_msg_vsi_reply_msg(struct enetc_hw *enetc_hw, struct enetc_psi_reply_msg *reply_msg)
 {
+	struct enetc_eth_hw *hw = container_of(enetc_hw, struct enetc_eth_hw, hw);
 	int vsimsgsr;
 	int8_t class_id = 0;
 	uint8_t status = 0;
@@ -221,8 +282,15 @@ enetc4_msg_vsi_reply_msg(struct enetc_hw *enetc_hw, struct enetc_psi_reply_msg *
 	/* Extracting 8 bits of message result in class_id */
 	class_id |= ((ENETC_SIMSGSR_GET_MC(vsimsgsr) >> 8) & 0xff);
 
-	/* Extracting 4 bits of message result in status */
-	status |= ((ENETC_SIMSGSR_GET_MC(vsimsgsr) >> 4) & 0xf);
+	/* Extracting message result in status. With an older kernel PF
+	 * (vf_link_legacy set) the lower byte holds a 4-bit cookie in the
+	 * low nibble and a 4-bit result in the high nibble, so extract the
+	 * upper 4 bits. Otherwise the full lower byte carries the result.
+	 */
+	if (hw->vf_link_legacy)
+		status |= ((ENETC_SIMSGSR_GET_MC(vsimsgsr) >> 4) & 0xf);
+	else
+		status |= (ENETC_SIMSGSR_GET_MC(vsimsgsr) & 0xff);
 
 	reply_msg->class_id = class_id;
 	reply_msg->status = status;
@@ -231,6 +299,7 @@ enetc4_msg_vsi_reply_msg(struct enetc_hw *enetc_hw, struct enetc_psi_reply_msg *
 static void
 enetc4_msg_get_psi_msg(struct enetc_hw *enetc_hw, struct enetc_psi_reply_msg *reply_msg)
 {
+	struct enetc_eth_hw *hw = container_of(enetc_hw, struct enetc_eth_hw, hw);
 	int vsimsgrr;
 	int8_t class_id = 0;
 	uint8_t status = 0;
@@ -240,8 +309,15 @@ enetc4_msg_get_psi_msg(struct enetc_hw *enetc_hw, struct enetc_psi_reply_msg *re
 	/* Extracting 8 bits of message result in class_id */
 	class_id |= ((ENETC_SIMSGSR_GET_MC(vsimsgrr) >> 8) & 0xff);
 
-	/* Extracting 4 bits of message result in status */
-	status |= ((ENETC_SIMSGSR_GET_MC(vsimsgrr) >> 4) & 0xf);
+	/* Extracting message result in status. With an older kernel PF
+	 * (vf_link_legacy set) the lower byte holds a 4-bit cookie in the
+	 * low nibble and a 4-bit result in the high nibble, so extract the
+	 * upper 4 bits. Otherwise the full lower byte carries the result.
+	 */
+	if (hw->vf_link_legacy)
+		status |= ((ENETC_SIMSGSR_GET_MC(vsimsgrr) >> 4) & 0xf);
+	else
+		status |= (ENETC_SIMSGSR_GET_MC(vsimsgrr) & 0xff);
 
 	reply_msg->class_id = class_id;
 	reply_msg->status = status;
@@ -731,6 +807,8 @@ enetc4_vf_link_update_dummy(struct rte_eth_dev *dev __rte_unused,
 static int
 enetc4_vf_link_update(struct rte_eth_dev *dev, int wait_to_complete __rte_unused)
 {
+	struct enetc_eth_hw *hw =
+			ENETC_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	struct enetc_psi_reply_msg *reply_msg;
 	struct rte_eth_link link;
 	int err;
@@ -809,28 +887,62 @@ enetc4_vf_link_update(struct rte_eth_dev *dev, int wait_to_complete __rte_unused
 			link.link_speed = RTE_ETH_SPEED_NUM_5G;
 			link.link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
 			break;
-		case ENETC_SPEED_10G:
-			link.link_speed = RTE_ETH_SPEED_NUM_10G;
-			link.link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
-			break;
-		case ENETC_SPEED_25G:
-			link.link_speed = RTE_ETH_SPEED_NUM_25G;
-			link.link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
-			break;
-		case ENETC_SPEED_50G:
-			link.link_speed = RTE_ETH_SPEED_NUM_50G;
-			link.link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
-			break;
-		case ENETC_SPEED_100G:
-			link.link_speed = RTE_ETH_SPEED_NUM_100G;
-			link.link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
-			break;
-		case ENETC_SPEED_NOT_SUPPORTED:
-			ENETC_PMD_DEBUG("Speed not supported");
-			link.link_speed = RTE_ETH_SPEED_NUM_UNKNOWN;
-			break;
 		default:
-			ENETC_PMD_ERR("Unknown speed status");
+			if (hw->vf_link_legacy) {
+				/* Legacy PF-to-VF message layout (older kernel
+				 * PF): speeds greater than 5Gbps are encoded
+				 * with fixed 4-bit class codes rather than the
+				 * formula below.
+				 */
+				switch (reply_msg->status) {
+				case ENETC_SPEED_LEGACY_10G:
+					link.link_speed = RTE_ETH_SPEED_NUM_10G;
+					link.link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
+					break;
+				case ENETC_SPEED_LEGACY_25G:
+					link.link_speed = RTE_ETH_SPEED_NUM_25G;
+					link.link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
+					break;
+				case ENETC_SPEED_LEGACY_50G:
+					link.link_speed = RTE_ETH_SPEED_NUM_50G;
+					link.link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
+					break;
+				case ENETC_SPEED_LEGACY_100G:
+					link.link_speed = RTE_ETH_SPEED_NUM_100G;
+					link.link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
+					break;
+				case ENETC_SPEED_LEGACY_NOT_SUPPORTED:
+					ENETC_PMD_DEBUG("Speed not supported");
+					link.link_speed = RTE_ETH_SPEED_NUM_UNKNOWN;
+					break;
+				default:
+					ENETC_PMD_ERR("Unknown speed status");
+					link.link_speed = RTE_ETH_SPEED_NUM_UNKNOWN;
+					break;
+				}
+				break;
+			}
+
+			/* Any status reaching here is greater than
+			 * ENETC_SPEED_5000, as all values from 0x0 to
+			 * ENETC_SPEED_5000 are handled by the cases above. Speeds
+			 * greater than 5Gbps are not enumerated and follow the
+			 * formula:
+			 *
+			 *   SPEED = (link_speed - 5000) / 1000 + ENETC_SPEED_5000
+			 *
+			 * where link_speed is in Mbps. Reverse it here to get the
+			 * actual link speed (RTE_ETH_SPEED_NUM_* values are in Mbps).
+			 *
+			 * The PF only reports speeds that map to a well-known
+			 * RTE_ETH_SPEED_NUM_* value, so the computed value is a
+			 * valid DPDK speed. If a future speed not yet defined in
+			 * DPDK needs to be supported, the corresponding
+			 * RTE_ETH_SPEED_NUM_* value must first be added upstream.
+			 */
+			link.link_speed = (reply_msg->status - ENETC_SPEED_5000)
+					  * 1000 + 5000;
+			link.link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
 			break;
 		}
 	} else {
@@ -839,10 +951,9 @@ enetc4_vf_link_update(struct rte_eth_dev *dev, int wait_to_complete __rte_unused
 	}
 
 	link.link_autoneg = 1;
-
 	rte_eth_linkstatus_set(dev, &link);
-
 	rte_free(reply_msg);
+
 	return 0;
 }
 
@@ -1421,6 +1532,12 @@ enetc4_vf_dev_init(struct rte_eth_dev *eth_dev)
 	if (rte_eal_iova_mode() == RTE_IOVA_PA)
 		dpaax_iova_table_populate();
 
+	/* Parse VF specific devargs (e.g. vf_link_legacy) before the first
+	 * link update so that PF-to-VF link messages are interpreted using
+	 * the correct (legacy or current) layout.
+	 */
+	enetc4_vf_get_devargs(eth_dev);
+
 	ENETC_PMD_DEBUG("port_id %d vendorID=0x%x deviceID=0x%x",
 			eth_dev->data->port_id, pci_dev->id.vendor_id,
 			pci_dev->id.device_id);
@@ -1514,5 +1631,7 @@ RTE_PMD_REGISTER_PARAM_STRING(net_enetc4_vf,
 			      ENETC4_VSI_DISABLE "=<any> "
 			      ENETC4_VSI_TIMEOUT "=<uint> "
 			      ENETC4_VSI_DELAY "=<uint> "
-			      ENETC4_NC_MEMORY "=<int>");
+			      ENETC4_NC_MEMORY "=<int> "
+			      ENETC_VF_LINK_LEGACY "=<0|1>");
+
 RTE_LOG_REGISTER_DEFAULT(enetc4_vf_logtype_pmd, NOTICE);
-- 
2.25.1

