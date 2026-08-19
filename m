Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018BDC5B572
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Aug 2026 05:34:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 546E5406B8;
	Wed, 19 Aug 2026 07:34:31 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 7FD9840041
 for <dev@dpdk.org>; Wed, 19 Aug 2026 07:34:21 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6516A1A0225;
 Wed, 19 Aug 2026 07:34:21 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2E6A51A018E;
 Wed, 19 Aug 2026 07:34:21 +0200 (CEST)
Received: from lsv03457.swis.in-blr01.nxp.com (lsv03457.swis.in-blr01.nxp.com
 [92.120.147.250])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id B00D718000B1;
 Wed, 19 Aug 2026 13:34:20 +0800 (+08)
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com,
	Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v11 06/15] net/enetc: support firmware version get for VF
Date: Wed, 19 Aug 2026 11:04:06 +0530
Message-Id: <20260819053415.645865-7-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260819053415.645865-1-g.singh@nxp.com>
References: <20260817063454.3290854-1-g.singh@nxp.com>
 <20260819053415.645865-1-g.singh@nxp.com>
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
 doc/guides/nics/features/enetc4_vf.ini |   1 +
 doc/guides/rel_notes/release_26_11.rst |   1 +
 drivers/net/enetc/enetc.h              |  19 +++-
 drivers/net/enetc/enetc4_vf.c          | 139 +++++++++++++++++++++++++
 5 files changed, 159 insertions(+), 2 deletions(-)

diff --git a/doc/guides/nics/enetc4.rst b/doc/guides/nics/enetc4.rst
index 935cf90e6b..fa93f40b22 100644
--- a/doc/guides/nics/enetc4.rst
+++ b/doc/guides/nics/enetc4.rst
@@ -59,6 +59,7 @@ Key functionality includes:
   Segment Coalesce (RSC), enabled when the TCP LRO Rx offload flag is
   requested. RSC requires the FCS to be stripped, so it cannot be combined
   with the KEEP_CRC Rx offload.
+- Firmware version: The NETC IP version is reported via ``rte_eth_dev_fw_version_get``.
 
 
 Prerequisites
diff --git a/doc/guides/nics/features/enetc4_vf.ini b/doc/guides/nics/features/enetc4_vf.ini
index c4a3568e71..939cceacf2 100644
--- a/doc/guides/nics/features/enetc4_vf.ini
+++ b/doc/guides/nics/features/enetc4_vf.ini
@@ -16,6 +16,7 @@ VLAN filter          = Y
 RSS hash             = Y
 Packet type parsing  = Y
 Basic stats          = Y
+FW version           = Y
 L3 checksum offload  = Y
 L4 checksum offload  = Y
 CRC offload          = Y
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index ee4f455c67..d212cce000 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -66,6 +66,7 @@ New Features
   * Extended the PF-to-VF link speed code field from 4-bit to 8-bit in ENETC4.
     Users running a PF kernel older than 6.18.37 must pass ``vf_link_legacy=1``
     as a device argument, otherwise link speed reporting will be incorrect.
+  * Added firmware version reporting for the ENETC4 VF.
 
 Removed Items
 -------------
diff --git a/drivers/net/enetc/enetc.h b/drivers/net/enetc/enetc.h
index 39a07df59d..46804a05ba 100644
--- a/drivers/net/enetc/enetc.h
+++ b/drivers/net/enetc/enetc.h
@@ -169,7 +169,8 @@ enum enetc_msg_cmd_class_id {
 	ENETC_CLASS_ID_MAC_FILTER = 0x20,
 	ENETC_CLASS_ID_VLAN_FILTER = 0x21,
 	ENETC_CLASS_ID_LINK_STATUS = 0x80,
-	ENETC_CLASS_ID_LINK_SPEED = 0x81
+	ENETC_CLASS_ID_LINK_SPEED = 0x81,
+	ENETC_CLASS_ID_GET_IP_VER = 0xF0
 };
 
 /* Enum for command IDs */
@@ -183,9 +184,18 @@ enum enetc_msg_cmd_id {
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
@@ -271,6 +281,11 @@ struct enetc_msg_cmd_get_link_speed {
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
index 9c6070b6d4..41f915be18 100644
--- a/drivers/net/enetc/enetc4_vf.c
+++ b/drivers/net/enetc/enetc4_vf.c
@@ -3,6 +3,7 @@
  */
 
 #include <stdbool.h>
+#include <rte_bus_pci.h>
 #include <rte_kvargs.h>
 #include <rte_random.h>
 #include <dpaax_iova_table.h>
@@ -433,6 +434,7 @@ enetc4_msg_vsi_send(struct enetc_eth_hw *hw, struct enetc_msg_swbd *msg)
 		case ENETC_CLASS_ID_MAC_FILTER:
 		case ENETC_CLASS_ID_LINK_STATUS:
 		case ENETC_CLASS_ID_LINK_SPEED:
+		case ENETC_CLASS_ID_GET_IP_VER:
 			break;
 		default:
 			err = -EIO;
@@ -796,6 +798,142 @@ enetc4_vf_get_link_speed(struct rte_eth_dev *dev, struct enetc_psi_reply_msg *re
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
+	if (fw_size == 0) {
+		if (ret == -ENOTSUP)
+			return snprintf(NULL, 0, "%u.unknown", ip_mj) + 1;
+		else
+			return snprintf(NULL, 0, "%u.%u", ip_mj, ip_mn) + 1;
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
@@ -1354,6 +1492,7 @@ static const struct eth_dev_ops enetc4_vf_ops = {
 	.dev_close            = enetc4_dev_close,
 	.stats_get            = enetc4_vf_stats_get,
 	.dev_infos_get        = enetc4_vf_dev_infos_get,
+	.fw_version_get       = enetc4_vf_fw_version_get,
 	.mtu_set              = enetc4_vf_mtu_set,
 	.mac_addr_set         = enetc4_vf_set_mac_addr,
 	.mac_addr_add	      = enetc4_vf_mac_addr_add,
-- 
2.25.1

