Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7967EC5AC7A
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Aug 2026 11:26:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 669CE40BA4;
	Fri,  7 Aug 2026 13:26:34 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id BFE3A40A75
 for <dev@dpdk.org>; Fri,  7 Aug 2026 13:26:28 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A046D1A0116;
 Fri,  7 Aug 2026 13:26:28 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 698061A00A7;
 Fri,  7 Aug 2026 13:26:28 +0200 (CEST)
Received: from lsv03457.swis.in-blr01.nxp.com (lsv03457.swis.in-blr01.nxp.com
 [92.120.147.250])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id E5D821800088;
 Fri,  7 Aug 2026 19:26:27 +0800 (+08)
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com,
	Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v4 05/14] net/enetc: support firmware version get for VF
Date: Fri,  7 Aug 2026 16:56:14 +0530
Message-Id: <20260807112623.1402493-6-g.singh@nxp.com>
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

Implement the ``.fw_version_get`` eth_dev op for the ENETC4 VF PMD to
report the NETC IP revision.

The NETC IP major revision is read from the PCI revision ID register,
while the IP minor revision is retrieved from the PSI over VSI-PSI
messaging using the "Get IP version" command class (class ID 0xF0,
command ID 0x1). The version is reported in the "<major>.<minor>"
format.

The PSI firmware only implements the IP_MN command of this class, so
the major revision is obtained from the PCI revision ID, matching the
behaviour of the kernel PF/VF drivers.

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 doc/guides/nics/enetc4.rst             |   1 +
 doc/guides/nics/features/enetc4.ini    |   1 +
 doc/guides/rel_notes/release_26_11.rst |   1 +
 drivers/net/enetc/enetc.h              |  19 +++-
 drivers/net/enetc/enetc4_vf.c          | 135 +++++++++++++++++++++++++
 5 files changed, 155 insertions(+), 2 deletions(-)

diff --git a/doc/guides/nics/enetc4.rst b/doc/guides/nics/enetc4.rst
index e7f4348603..ea0e37896d 100644
--- a/doc/guides/nics/enetc4.rst
+++ b/doc/guides/nics/enetc4.rst
@@ -59,6 +59,7 @@ Key functionality includes:
   Segment Coalesce (RSC), enabled when the TCP LRO Rx offload flag is
   requested. RSC requires the FCS to be stripped, so it cannot be combined
   with the KEEP_CRC Rx offload.
+- Firmware version: The NETC IP version is reported via ``rte_eth_dev_fw_version_get``.
 
 
 Prerequisites
diff --git a/doc/guides/nics/features/enetc4.ini b/doc/guides/nics/features/enetc4.ini
index aae398e210..eaf474e7ba 100644
--- a/doc/guides/nics/features/enetc4.ini
+++ b/doc/guides/nics/features/enetc4.ini
@@ -16,6 +16,7 @@ VLAN filter          = Y
 RSS hash             = Y
 Packet type parsing  = Y
 Basic stats          = Y
+FW version           = Y
 L3 checksum offload  = Y
 L4 checksum offload  = Y
 CRC offload          = Y
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index d7961d3c85..5ac2bb4de0 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -64,6 +64,7 @@ New Features
   * Added TCP Segmentation Offload (TSO) support for the ENETC4 VF.
   * Added Receive Segment Coalesce (RSC / hardware LRO) support for ENETC4 PF and VF.
   * Extended the PF-to-VF link speed code field from 4-bit to 8-bit in ENETC4.
+  * Added firmware version reporting for the ENETC4 VF.
 
 Removed Items
 -------------
diff --git a/drivers/net/enetc/enetc.h b/drivers/net/enetc/enetc.h
index c983cb059e..b1428f1bca 100644
--- a/drivers/net/enetc/enetc.h
+++ b/drivers/net/enetc/enetc.h
@@ -170,7 +170,8 @@ enum enetc_msg_cmd_class_id {
 	ENETC_CLASS_ID_MAC_FILTER = 0x20,
 	ENETC_CLASS_ID_VLAN_FILTER = 0x21,
 	ENETC_CLASS_ID_LINK_STATUS = 0x80,
-	ENETC_CLASS_ID_LINK_SPEED = 0x81
+	ENETC_CLASS_ID_LINK_SPEED = 0x81,
+	ENETC_CLASS_ID_GET_IP_VER = 0xF0
 };
 
 /* Enum for command IDs */
@@ -184,9 +185,18 @@ enum enetc_msg_cmd_id {
 	ENETC_CMD_ID_GET_LINK_STATUS = 0,
 	ENETC_CMD_ID_REGISTER_LINK_NOTIF = 1,
 	ENETC_CMD_ID_UNREGISTER_LINK_NOTIF = 2,
-	ENETC_CMD_ID_GET_LINK_SPEED = 0
+	ENETC_CMD_ID_GET_LINK_SPEED = 0,
+	/* Get IP version command IDs (class ID 0xF0) */
+	ENETC_CMD_ID_GET_IP_MJ = 0,
+	ENETC_CMD_ID_GET_IP_MN = 1,
+	ENETC_CMD_ID_GET_IP_INT = 2,
+	ENETC_CMD_ID_GET_IP_MNT = 3,
+	ENETC_CMD_ID_GET_IP_CFG = 4
 };
 
+/* IP_VER value returned when the version is not available */
+#define ENETC_IP_VER_NOT_AVAILABLE	0xFF
+
 enum mac_addr_status {
 	ENETC_INVALID_MAC_ADDR = 0x0,
 	ENETC_DUPLICATE_MAC_ADDR = 0X1,
@@ -274,6 +284,11 @@ struct enetc_msg_cmd_get_link_speed {
 	struct enetc_msg_cmd_header header;
 };
 
+/* Get IP version command message format (class ID 0xF0) */
+struct enetc_msg_cmd_get_ip_ver {
+	struct enetc_msg_cmd_header header;
+};
+
 struct enetc_msg_cmd_set_vlan_promisc {
 	struct enetc_msg_cmd_header header;
 	uint8_t op;
diff --git a/drivers/net/enetc/enetc4_vf.c b/drivers/net/enetc/enetc4_vf.c
index d34b8019ea..4b84a90cc9 100644
--- a/drivers/net/enetc/enetc4_vf.c
+++ b/drivers/net/enetc/enetc4_vf.c
@@ -5,6 +5,7 @@
 #include <stdbool.h>
 #include <rte_kvargs.h>
 #include <rte_random.h>
+#include <rte_bus_pci.h>
 #include <rte_kvargs.h>
 #include <dpaax_iova_table.h>
 #include "enetc_logs.h"
@@ -434,6 +435,7 @@ enetc4_msg_vsi_send(struct enetc_eth_hw *hw, struct enetc_msg_swbd *msg)
 		case ENETC_CLASS_ID_MAC_FILTER:
 		case ENETC_CLASS_ID_LINK_STATUS:
 		case ENETC_CLASS_ID_LINK_SPEED:
+		case ENETC_CLASS_ID_GET_IP_VER:
 			break;
 		default:
 			err = -EIO;
@@ -797,6 +799,138 @@ enetc4_vf_get_link_speed(struct rte_eth_dev *dev, struct enetc_psi_reply_msg *re
 	return err;
 }
 
+/*
+ * Get the NETC IP minor revision (IP_MN) from the PSI using the 'Get IP
+ * version' command class (class ID 0xF0, cmd_id 0x1). In the reply, the
+ * low 8 bits of the return code carry the minor revision and the upper 8
+ * bits carry the class code (0xF0). The PSI only implements the IP_MN
+ * command of this class; the major revision comes from the PCI revision.
+ */
+static int
+enetc4_vf_get_ip_minor_revision(struct rte_eth_dev *dev, uint8_t *ip_mn)
+{
+	struct enetc_eth_hw *hw = ENETC_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct enetc_hw *enetc_hw = &hw->hw;
+	struct enetc_msg_swbd *msg;
+	uint32_t msg_size;
+	uint16_t mc;
+	uint8_t class_id;
+	int vsimsgsr;
+	int err = 0;
+
+	msg = rte_zmalloc(NULL, sizeof(*msg), RTE_CACHE_LINE_SIZE);
+	if (!msg) {
+		ENETC_PMD_ERR("Failed to alloc msg");
+		return -ENOMEM;
+	}
+
+	msg_size = RTE_ALIGN(sizeof(struct enetc_msg_cmd_get_ip_ver),
+				ENETC_VSI_PSI_MSG_SIZE);
+	msg->vaddr = rte_zmalloc(NULL, msg_size, 0);
+	if (!msg->vaddr) {
+		ENETC_PMD_ERR("Failed to alloc memory for msg");
+		rte_free(msg);
+		return -ENOMEM;
+	}
+
+	msg->dma = rte_mem_virt2iova((const void *)msg->vaddr);
+	msg->size = msg_size;
+
+	/* COOKIE is 0 so that the command is executed as blocking on PSI */
+	enetc_msg_vf_fill_common_hdr(msg, ENETC_CLASS_ID_GET_IP_VER,
+			ENETC_CMD_ID_GET_IP_MN, 0, 0, 0);
+
+	/* send the command and wait */
+	err = enetc4_msg_vsi_send(hw, msg);
+	if (err) {
+		ENETC_PMD_ERR("VSI message send error");
+		goto end;
+	}
+
+	/*
+	 * For the IP version command class the class-specific field is
+	 * reused to carry the 8-bit version value in the lower byte of the
+	 * return code, so parse the full low byte here instead of using the
+	 * generic reply parser.
+	 */
+	vsimsgsr = enetc4_rd(enetc_hw, ENETC4_VSIMSGSR);
+	mc = ENETC_SIMSGSR_GET_MC(vsimsgsr);
+	class_id = (mc >> 8) & 0xff;
+
+	if (class_id != ENETC_CLASS_ID_GET_IP_VER) {
+		ENETC_PMD_ERR("Wrong reply message 0x%x", class_id);
+		err = -EIO;
+		goto end;
+	}
+
+	*ip_mn = mc & 0xff;
+	if (*ip_mn == ENETC_IP_VER_NOT_AVAILABLE) {
+		ENETC_PMD_DEBUG("IP minor revision not available");
+		err = -ENOTSUP;
+	}
+
+end:
+	/* free memory no longer required */
+	rte_free(msg->vaddr);
+	rte_free(msg);
+	return err;
+}
+
+/*
+ * Retrieve the NETC firmware/IP version and format it as
+ * "<major>.<minor>". The IP major revision is taken from the PCI
+ * revision ID register, and the IP minor revision is fetched from the
+ * PSI via VSI-PSI messaging ('Get IP version' command class). This
+ * mirrors the behaviour of the kernel PF/VF drivers, where the PSI only
+ * implements the IP_MN command of the 0xF0 class.
+ */
+static int
+enetc4_vf_fw_version_get(struct rte_eth_dev *dev, char *fw_version, size_t fw_size)
+{
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
+	uint8_t ip_mj = 0, ip_mn = 0;
+	int ret;
+
+	PMD_INIT_FUNC_TRACE();
+
+	if (fw_version == NULL)
+		return -EINVAL;
+
+	if (fw_size == 0)
+		return snprintf(NULL, 0, "%u.%u", ip_mj, ip_mn) + 1;
+
+	/* IP major revision is exposed through the PCI revision ID */
+	ret = rte_pci_read_config(pci_dev, &ip_mj, sizeof(ip_mj),
+			RTE_PCI_REVISION_ID);
+	if (ret != sizeof(ip_mj)) {
+		ENETC_PMD_ERR("Failed to read PCI revision ID");
+		return -EIO;
+	}
+
+	/* IP minor revision is fetched from the PSI via VSI-PSI messaging.
+	 * If the PSI reports the version as unavailable, fall back to a
+	 * partial version string so the caller still gets useful output.
+	 */
+	ret = enetc4_vf_get_ip_minor_revision(dev, &ip_mn);
+	if (ret && ret != -ENOTSUP) {
+		ENETC_PMD_ERR("Failed to get NETC minor revision");
+		return ret;
+	}
+
+	if (ret == -ENOTSUP)
+		ret = snprintf(fw_version, fw_size, "%u.unknown", ip_mj);
+	else
+		ret = snprintf(fw_version, fw_size, "%u.%u", ip_mj, ip_mn);
+	if (ret < 0)
+		return -EINVAL;
+
+	ret += 1; /* add trailing '\0' */
+	if ((size_t)ret > fw_size)
+		return ret;
+
+	return 0;
+}
+
 static int
 enetc4_vf_link_update_dummy(struct rte_eth_dev *dev __rte_unused,
 			    int wait_to_complete __rte_unused)
@@ -1306,6 +1440,7 @@ static const struct eth_dev_ops enetc4_vf_ops_no_vsi_m = {
 	.dev_close            = enetc4_dev_close,
 	.stats_get            = enetc4_vf_stats_get,
 	.dev_infos_get        = enetc4_vf_dev_infos_get,
+	.fw_version_get       = enetc4_vf_fw_version_get,
 	.mtu_set              = enetc4_vf_mtu_set,
 	.link_update	      = enetc4_vf_link_update_dummy,
 	.rx_queue_setup       = enetc4_rx_queue_setup,
-- 
2.25.1

