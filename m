Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BFBCD8C9D
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Jun 2026 05:44:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 601A240B9A;
	Mon,  8 Jun 2026 07:42:52 +0200 (CEST)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by mails.dpdk.org (Postfix) with ESMTP id C7C2D4065E
 for <dev@dpdk.org>; Mon,  8 Jun 2026 07:42:32 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-05 (Coremail) with SMTP id zQCowACnHvJBViZq3m2tEg--.175S18;
 Mon, 08 Jun 2026 13:42:29 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v12 16/20] net/sxe2: support SFP module info and EEPROM access
Date: Mon,  8 Jun 2026 13:42:15 +0800
Message-ID: <20260608054219.3000719-17-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260608054219.3000719-1-liujie5@linkdatatechnology.com>
References: <20260607013342.2579271-21-liujie5@linkdatatechnology.com>
 <20260608054219.3000719-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowACnHvJBViZq3m2tEg--.175S18
X-Coremail-Antispam: 1UD129KBjvAXoW3uF1kZF1xuFykXF43GryUWrg_yoW8GFyDuo
 WIgr45X34fZr17C3y8Wr1Iqry7Z3yrCF4rKw4F9r4DuanxCw1YkFy5tw43Za4qqF4qyF4U
 uws2kas2q39xJay8n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UjIYCTnIWjp_UUUY_7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
 j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s0DM28Irc
 Ia0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l
 84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r
 4UJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_
 Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x
 IIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_
 Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4kE6xkIj40Ew7xC0w
 CF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j
 6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64
 vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_
 Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42
 IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUYGYpUUUUU
X-Originating-IP: [118.112.177.181]
X-CM-SenderInfo: xolxyxrhv6zxpqngt3pdwhux5qro0w31of0z/
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

From: Jie Liu <liujie5@linkdatatechnology.com>

This patch implements 'get_module_info' and 'get_module_eeprom'
ops for the sxe2 PMD. These interfaces allow applications to retrieve
the type of the plugged-in optical module and read its internal
EEPROM data.

The implementation utilizes the shared SFP header definitions to
parse the module ID, connector type, and encoding. It supports
reading the standard 256-byte EEPROM maps (SFF-8472 for SFP and
SFF-8636 for QSFP) via hardware-specific access commands.

Key features:
- Identify module types (SFP/SFP+/QSFP/QSFP28).
- Support standard EEPROM data retrieval for diagnostic tools.
- Add boundary checks to ensure safe I2C memory access.

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/sxe2_cmd_chnl.c |  46 +++++
 drivers/net/sxe2/sxe2_cmd_chnl.h |   3 +
 drivers/net/sxe2/sxe2_drv_cmd.h  |  18 ++
 drivers/net/sxe2/sxe2_ethdev.c   | 298 +++++++++++++++++++++++++++++++
 drivers/net/sxe2/sxe2_ethdev.h   |   9 +
 5 files changed, 374 insertions(+)

diff --git a/drivers/net/sxe2/sxe2_cmd_chnl.c b/drivers/net/sxe2/sxe2_cmd_chnl.c
index 926eaee062..43e8c59487 100644
--- a/drivers/net/sxe2/sxe2_cmd_chnl.c
+++ b/drivers/net/sxe2/sxe2_cmd_chnl.c
@@ -1833,3 +1833,49 @@ int32_t sxe2_drv_srcvsi_prune_config(struct sxe2_adapter *adapter,
 
 	return ret;
 }
+
+int32_t sxe2_drv_sfp_eeprom_read(struct sxe2_adapter *adapter, struct sxe2_sfp_read_info *sfp_info)
+{
+	int32_t ret = -1;
+	struct sxe2_drv_sfp_req req = {0};
+	struct sxe2_drv_sfp_resp *resp = NULL;
+	struct sxe2_drv_cmd_params cmd = {0};
+
+	resp = rte_zmalloc("read sfp data", sizeof(*resp) + sfp_info->len, 0);
+	if (!resp) {
+		PMD_LOG_ERR(DRV, "Alloc memory failed");
+		ret = -ENOMEM;
+		goto l_end;
+	}
+
+	req.is_wr = false;
+	req.is_qsfp = sfp_info->is_qsfp;
+	req.page_cnt = rte_cpu_to_le_16(sfp_info->page_cnt);
+	req.offset = rte_cpu_to_le_16(sfp_info->offset);
+	req.data_len = rte_cpu_to_le_16(sfp_info->len);
+	req.bus_addr = rte_cpu_to_le_16(sfp_info->bus_addr);
+
+	PMD_DEV_LOG_INFO(adapter, DRV, "is_qsfp=%u, page_cnt=%u, offset=%u, datalen=%u, "
+			 "bus_addr=%u", sfp_info->is_qsfp, sfp_info->page_cnt, sfp_info->offset,
+			 sfp_info->len, sfp_info->bus_addr);
+
+	sxe2_drv_cmd_params_fill(adapter, &cmd, SXE2_DRV_CMD_OPT_EEP_GET,
+				 &req, sizeof(req),
+				 resp, sizeof(*resp) + sfp_info->len);
+	ret = sxe2_drv_cmd_exec(adapter->cdev, &cmd);
+	if (ret) {
+		PMD_DEV_LOG_ERR(adapter, DRV, "Failed to read sfp, ret=%d", ret);
+		goto l_end;
+	}
+
+	ret = 0;
+	rte_memcpy(sfp_info->data, resp->data, sfp_info->len);
+
+l_end:
+	if (resp) {
+		rte_free(resp);
+		resp = NULL;
+	}
+
+	return ret;
+}
diff --git a/drivers/net/sxe2/sxe2_cmd_chnl.h b/drivers/net/sxe2/sxe2_cmd_chnl.h
index 97007c7cfa..988d4b458b 100644
--- a/drivers/net/sxe2/sxe2_cmd_chnl.h
+++ b/drivers/net/sxe2/sxe2_cmd_chnl.h
@@ -167,4 +167,7 @@ int32_t sxe2_drv_flow_fnav_query_stat(struct sxe2_adapter *adapter,
 int32_t sxe2_drv_srcvsi_prune_config(struct sxe2_adapter *adapter,
 		uint16_t *vsi_list, uint16_t vsi_cnt, bool set);
 
+int32_t sxe2_drv_sfp_eeprom_read(struct sxe2_adapter *adapter,
+		struct sxe2_sfp_read_info *sfp_info);
+
 #endif /* SXE2_CMD_CHNL_H */
diff --git a/drivers/net/sxe2/sxe2_drv_cmd.h b/drivers/net/sxe2/sxe2_drv_cmd.h
index f7acd20642..09b2f7d125 100644
--- a/drivers/net/sxe2/sxe2_drv_cmd.h
+++ b/drivers/net/sxe2/sxe2_drv_cmd.h
@@ -633,6 +633,24 @@ struct __rte_aligned(4) __rte_packed_begin sxe2_drv_udp_tunnel_resp {
 	uint8_t rsv;
 } __rte_packed_end;
 
+struct __rte_aligned(4) __rte_packed_begin sxe2_drv_sfp_req {
+	uint8_t is_wr;
+	uint8_t is_qsfp;
+	uint16_t bus_addr;
+	uint16_t page_cnt;
+	uint16_t offset;
+	uint16_t data_len;
+	uint16_t rvd;
+	uint8_t data[];
+} __rte_packed_end;
+
+struct __rte_aligned(4) __rte_packed_begin sxe2_drv_sfp_resp {
+	uint8_t is_wr;
+	uint8_t is_qsfp;
+	uint16_t data_len;
+	uint8_t data[];
+} __rte_packed_end;
+
 enum sxe2_drv_cmd_module {
 	SXE2_DRV_CMD_MODULE_HANDSHAKE = 0,
 	SXE2_DRV_CMD_MODULE_DEV = 1,
diff --git a/drivers/net/sxe2/sxe2_ethdev.c b/drivers/net/sxe2/sxe2_ethdev.c
index d1bc5b1500..60a5d8d7c9 100644
--- a/drivers/net/sxe2/sxe2_ethdev.c
+++ b/drivers/net/sxe2/sxe2_ethdev.c
@@ -41,6 +41,7 @@
 #include "sxe2_ethdev_repr.h"
 #include "sxe2vf_regs.h"
 #include "sxe2_switchdev.h"
+#include "sxe2_msg.h"
 
 #define SXE2_PCI_VENDOR_ID_1    0x1ff2
 #define SXE2_PCI_DEVICE_ID_PF_1 0x10b1
@@ -122,6 +123,10 @@ static int32_t sxe2_udp_tunnel_port_del(struct rte_eth_dev *dev,
 					struct rte_eth_udp_tunnel *tunnel_udp);
 static int32_t sxe2_fw_version_string_get(struct rte_eth_dev *dev,
 				      char *fw_version, size_t fw_size);
+static int32_t sxe2_get_module_info(struct rte_eth_dev *dev,
+				struct rte_eth_dev_module_info *info);
+static int32_t sxe2_get_module_eeprom(struct rte_eth_dev *dev,
+				  struct rte_dev_eeprom_info *info);
 
 static const struct eth_dev_ops sxe2_eth_dev_ops = {
 	.dev_configure              = sxe2_dev_configure,
@@ -186,6 +191,9 @@ static const struct eth_dev_ops sxe2_eth_dev_ops = {
 	.fw_version_get             = sxe2_fw_version_string_get,
 
 	.get_monitor_addr           = sxe2_get_monitor_addr,
+
+	.get_module_info            = sxe2_get_module_info,
+	.get_module_eeprom          = sxe2_get_module_eeprom,
 };
 
 static int32_t sxe2_dev_configure(struct rte_eth_dev *dev)
@@ -291,6 +299,296 @@ static int32_t sxe2_dev_start(struct rte_eth_dev *dev)
 	return ret;
 }
 
+static int32_t sxe2_sfp_type_get(struct sxe2_adapter *adapter, uint8_t *type)
+{
+	int32_t ret = -1;
+	struct sxe2_sfp_read_info sfp_info;
+
+	memset(&sfp_info, 0, sizeof(sfp_info));
+	sfp_info.bus_addr = SXE2_SFP_E2P_I2C_7BIT_ADDR0;
+	sfp_info.len = 1;
+	sfp_info.data = type;
+	sfp_info.offset = 0;
+	sfp_info.page_cnt = 0;
+	sfp_info.is_qsfp = false;
+
+	ret = sxe2_drv_sfp_eeprom_read(adapter, &sfp_info);
+	if (ret)
+		goto l_end;
+
+	ret = 0;
+	PMD_LOG_INFO(DRV, "Get sfp type success, type=%u", *type);
+
+l_end:
+	return ret;
+}
+
+static int32_t sxe2_sfp_module_info_get(struct sxe2_adapter *adapter,
+						  struct rte_eth_dev_module_info *info)
+{
+	int32_t ret = -1;
+	bool page_swap = false;
+	uint8_t sff8472_rev = 0;
+	uint8_t addr_mode = 0;
+	struct sxe2_sfp_read_info sfp_info;
+
+	memset(&sfp_info, 0, sizeof(sfp_info));
+	sfp_info.bus_addr = SXE2_SFP_E2P_I2C_7BIT_ADDR0;
+	sfp_info.is_qsfp = false;
+	sfp_info.len = 1;
+	sfp_info.data = &sff8472_rev;
+	sfp_info.offset = SXE2_MODULE_SFF_8472_COMP;
+	sfp_info.page_cnt = 0;
+
+	ret = sxe2_drv_sfp_eeprom_read(adapter, &sfp_info);
+	if (ret) {
+		ret = -EIO;
+		PMD_LOG_ERR(DRV, "Failed to read 8472 protocol, ret=%d", ret);
+		goto l_end;
+	}
+
+	sfp_info.data = &addr_mode;
+	sfp_info.offset = SXE2_MODULE_SFF_8472_SWAP;
+
+	ret = sxe2_drv_sfp_eeprom_read(adapter, &sfp_info);
+	if (ret) {
+		ret = -EIO;
+		PMD_LOG_ERR(DRV, "Failed to read A2 page, ret=%d", ret);
+		goto l_end;
+	}
+
+	if (addr_mode & SXE2_MODULE_SFF_ADDR_MODE) {
+		PMD_LOG_ERR(DRV, "address change required to access page 0xA2, "
+			    "but not supported. please report the module "
+			    "type to the driver maintainers.");
+		page_swap = true;
+	}
+
+	PMD_LOG_INFO(DRV, "Read sfp module info, sff_8472=%u, a2_page=%u, swap_page=%d",
+		     sff8472_rev, addr_mode, page_swap);
+
+	if (sff8472_rev == SXE2_MODULE_SFF_8472_UNSUP ||
+	    page_swap ||
+	    !(addr_mode & SXE2_MODULE_SFF_DDM_IMPLEMENTED)) {
+		info->type = SXE2_MODULE_SFF_8079;
+		info->eeprom_len = SXE2_MODULE_SFF_8079_LEN;
+	} else {
+		info->type = SXE2_MODULE_SFF_8472;
+		info->eeprom_len = SXE2_MODULE_SFF_8472_LEN;
+	}
+
+	ret = 0;
+
+l_end:
+	return ret;
+}
+
+static int32_t
+sxe2_qsfp_module_info_get(struct sxe2_adapter *adapter, struct rte_eth_dev_module_info *info)
+{
+	int32_t ret = -1;
+	uint8_t sff8636_rev = 0;
+	struct sxe2_sfp_read_info sfp_info;
+
+	memset(&sfp_info, 0, sizeof(sfp_info));
+	sfp_info.bus_addr = SXE2_SFP_E2P_I2C_7BIT_ADDR0;
+	sfp_info.is_qsfp = true;
+	sfp_info.len = 1;
+	sfp_info.data = &sff8636_rev;
+	sfp_info.offset = SXE2_MODULE_REVISION_ADDR;
+	sfp_info.page_cnt = 0;
+
+	ret = sxe2_drv_sfp_eeprom_read(adapter, &sfp_info);
+	if (ret) {
+		ret = -EIO;
+		PMD_LOG_ERR(DRV, "Failed to read 8636 protocol, ret=%d", ret);
+		goto l_end;
+	}
+
+	if (sff8636_rev > 0x02) {
+		info->type = SXE2_MODULE_SFF_8636;
+		info->eeprom_len = SXE2_MODULE_SFF_8636_MAX_LEN;
+	} else {
+		info->type = SXE2_MODULE_SFF_8436;
+		info->eeprom_len = SXE2_MODULE_SFF_8436_MAX_LEN;
+	}
+
+l_end:
+	return ret;
+}
+
+static int32_t
+sxe2_get_module_info(struct rte_eth_dev *dev, struct rte_eth_dev_module_info *info)
+{
+	int32_t ret = -1;
+	uint8_t type = 0;
+	struct sxe2_adapter *adapter = dev->data->dev_private;
+
+	ret = sxe2_sfp_type_get(adapter, &type);
+	if (ret) {
+		ret = -EIO;
+		PMD_LOG_ERR(DRV, "Failed to read sfp type, ret=%d", ret);
+		goto l_end;
+	}
+
+	switch (type) {
+	case SXE2_MODULE_SFF_SFP_TYPE:
+		ret = sxe2_sfp_module_info_get(adapter, info);
+		if (ret)
+			goto l_end;
+		break;
+	case SXE2_MODULE_TYPE_QSFP_PLUS:
+	case SXE2_MODULE_TYPE_QSFP28:
+		ret = sxe2_qsfp_module_info_get(adapter, info);
+		if (ret)
+			goto l_end;
+		break;
+	default:
+		ret = -ENXIO;
+		PMD_LOG_ERR(DRV, "Invalid sfp type, type=%d.", type);
+		goto l_end;
+	}
+
+	PMD_LOG_INFO(DRV, "sfp eeprom type=%x, eeprom len=%d.", info->type, info->eeprom_len);
+
+l_end:
+	return ret;
+}
+
+static int32_t
+sxe2_get_sfp_eeprom(struct sxe2_adapter *adapter, struct sxe2_sfp_read_info *sfp_info)
+{
+	int32_t ret = -1;
+	uint16_t ori_len = sfp_info->len;
+	uint16_t ori_offset = sfp_info->offset;
+
+	if ((ori_len + ori_offset) > SXE2_SFP_EEP_LEN_MAX) {
+		sfp_info->len = (uint16_t)(SXE2_SFP_EEP_LEN_MAX - ori_offset);
+		ret = sxe2_drv_sfp_eeprom_read(adapter, sfp_info);
+		if (ret)
+			goto l_end;
+		sfp_info->bus_addr = SXE2_SFP_E2P_I2C_7BIT_ADDR1;
+		sfp_info->len = (uint16_t)(ori_len - (SXE2_SFP_EEP_LEN_MAX - ori_offset));
+		sfp_info->data = (uint8_t *)(sfp_info->data) + (SXE2_SFP_EEP_LEN_MAX - ori_offset);
+		sfp_info->offset = 0;
+		sfp_info->page_cnt = 0;
+		ret = sxe2_drv_sfp_eeprom_read(adapter, sfp_info);
+	} else {
+		ret = sxe2_drv_sfp_eeprom_read(adapter, sfp_info);
+	}
+
+l_end:
+	if (ret)
+		PMD_LOG_ERR(DRV, "Failed to read sfp.");
+	return ret;
+}
+
+static int32_t
+sxe2_get_qsfp_eeprom(struct sxe2_adapter *adapter,
+					  struct sxe2_sfp_read_info *sfp_info)
+{
+	int32_t ret = -1;
+	uint16_t ori_len = sfp_info->len;
+	uint16_t ori_offset = sfp_info->offset;
+	uint16_t read_len = 0;
+	uint16_t remain_len = 0;
+
+	if ((ori_len + ori_offset) > SXE2_SFP_EEP_LEN_MAX) {
+		sfp_info->len = (uint16_t)(SXE2_SFP_EEP_LEN_MAX - ori_offset);
+		ret = sxe2_drv_sfp_eeprom_read(adapter, sfp_info);
+		if (ret)
+			goto l_end;
+
+		do {
+			read_len = read_len + sfp_info->len;
+			sfp_info->data = (uint8_t *)(sfp_info->data) + sfp_info->len;
+			sfp_info->offset = SXE2_QSFP_PAGE_OFST_START;
+			sfp_info->page_cnt++;
+			remain_len = (uint16_t)(ori_len - read_len);
+			sfp_info->len = (remain_len > SXE2_QSFP_PAGE_OFST_START) ?
+					SXE2_QSFP_PAGE_OFST_START : remain_len;
+			ret = sxe2_drv_sfp_eeprom_read(adapter, sfp_info);
+			if (ret)
+				goto l_end;
+		} while (remain_len > SXE2_QSFP_PAGE_OFST_START);
+	} else {
+		ret = sxe2_drv_sfp_eeprom_read(adapter, sfp_info);
+	}
+
+l_end:
+	if (ret)
+		PMD_LOG_ERR(DRV, "Failed to read sfp.");
+	return ret;
+}
+
+static int32_t
+sxe2_get_module_eeprom(struct rte_eth_dev *dev, struct rte_dev_eeprom_info *info)
+{
+	int32_t ret = -1;
+	uint8_t type = 0;
+	struct sxe2_adapter *adapter = dev->data->dev_private;
+	struct sxe2_sfp_read_info sfp_info;
+
+	memset(&sfp_info, 0, sizeof(sfp_info));
+
+	if (!info || !info->length || !info->data ||
+			info->offset >= SXE2_SFP_EEP_LEN_MAX) {
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	PMD_LOG_INFO(DRV, "Dump sfp eeprom info offset=0x%x, len=0x%x.",
+		     info->offset, info->length);
+
+	ret = sxe2_sfp_type_get(adapter, &type);
+	if (ret) {
+		ret = -EIO;
+		PMD_LOG_ERR(DRV, "Failed to read sfp type, ret=%d", ret);
+		goto l_end;
+	}
+
+	sfp_info.bus_addr = SXE2_SFP_E2P_I2C_7BIT_ADDR0;
+	sfp_info.len = info->length;
+	sfp_info.data = info->data;
+	sfp_info.offset = info->offset;
+	sfp_info.page_cnt = 0;
+
+	switch (type) {
+	case SXE2_MODULE_SFF_SFP_TYPE:
+		if (info->length > SXE2_SFP_EEP_LEN_MAX * 2) {
+			ret = -EINVAL;
+			PMD_LOG_ERR(DRV, "sfp read size[%u] > eeprom max size[%d], ret=%d",
+				    info->length, SXE2_SFP_EEP_LEN_MAX * 2, ret);
+			goto l_end;
+		}
+		sfp_info.is_qsfp = false;
+		ret = sxe2_get_sfp_eeprom(adapter, &sfp_info);
+		if (ret)
+			goto l_end;
+		break;
+	case SXE2_MODULE_TYPE_QSFP_PLUS:
+	case SXE2_MODULE_TYPE_QSFP28:
+		if (info->length > SXE2_MODULE_SFF_8636_MAX_LEN) {
+			ret = -EINVAL;
+			PMD_LOG_ERR(DRV, "sfp read size[%u] > eeprom max size[%d], ret=%d",
+				    info->length, SXE2_SFP_EEP_LEN_MAX * 2, ret);
+			goto l_end;
+		}
+		sfp_info.is_qsfp = true;
+		ret = sxe2_get_qsfp_eeprom(adapter, &sfp_info);
+		if (ret)
+			goto l_end;
+		break;
+	default:
+		ret = -ENXIO;
+		PMD_LOG_ERR(DRV, "Invalid sfp type, type=%d.", type);
+		goto l_end;
+	}
+
+l_end:
+	return ret;
+}
+
 static enum sxe2_udp_tunnel_protocol
 sxe2_udp_tunnel_type_rte_to_sxe2(enum rte_eth_tunnel_type rte_type)
 {
diff --git a/drivers/net/sxe2/sxe2_ethdev.h b/drivers/net/sxe2/sxe2_ethdev.h
index 32efa893d1..b103679c78 100644
--- a/drivers/net/sxe2/sxe2_ethdev.h
+++ b/drivers/net/sxe2/sxe2_ethdev.h
@@ -275,6 +275,15 @@ struct sxe2_sched_hw_cap {
 	uint8_t adj_lvl;
 };
 
+struct sxe2_sfp_read_info {
+	uint8_t *data;
+	uint16_t offset;
+	uint16_t len;
+	uint16_t bus_addr;
+	uint16_t page_cnt;
+	bool is_qsfp;
+};
+
 struct sxe2_link_context {
 	rte_spinlock_t link_lock;
 	bool link_up;
-- 
2.52.0

