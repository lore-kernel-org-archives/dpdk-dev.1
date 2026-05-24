Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E43CD5BAB
	for <dpdk-dev@archiver.kernel.org>; Sun, 24 May 2026 09:35:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8EB4140B97;
	Sun, 24 May 2026 11:33:29 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 8A5E14066B
 for <dev@dpdk.org>; Sun, 24 May 2026 11:33:12 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowABXd97QxRJq+04kEg--.9115S18;
 Sun, 24 May 2026 17:33:08 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v1 16/23] net/sxe2: support SFP module info and EEPROM access
Date: Sun, 24 May 2026 17:32:52 +0800
Message-ID: <20260524093259.397506-17-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260524093259.397506-1-liujie5@linkdatatechnology.com>
References: <20260524093259.397506-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowABXd97QxRJq+04kEg--.9115S18
X-Coremail-Antispam: 1UD129KBjvAXoW3uF1fJFy7ZF4ftFykXw1DKFg_yoW8XF1fZo
 WxWr45Z34fZr17C3y8Wr1xXFy7Z3yruF4rGa1F9r4Duay3Cw15KFy5tw43ua4qqF4jyF4U
 uws2yas2q39xXay8n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UjIYCTnIWjp_UUUYM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
 j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s0DM28Irc
 Ia0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l
 84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r
 4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JVW8
 Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2I
 x0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8
 JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lw4CEc2x0rVAKj4xxMx
 AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_
 Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwI
 xGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8
 Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0x
 vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUB89_UUUUU=
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
 drivers/common/sxe2/sxe2_msg.h   |  21 ++-
 drivers/net/sxe2/sxe2_cmd_chnl.c |  46 +++++
 drivers/net/sxe2/sxe2_cmd_chnl.h |   3 +
 drivers/net/sxe2/sxe2_drv_cmd.h  |  18 ++
 drivers/net/sxe2/sxe2_ethdev.c   | 298 +++++++++++++++++++++++++++++++
 drivers/net/sxe2/sxe2_ethdev.h   |   9 +
 6 files changed, 384 insertions(+), 11 deletions(-)

diff --git a/drivers/common/sxe2/sxe2_msg.h b/drivers/common/sxe2/sxe2_msg.h
index a5270b2c13..57814ff8a4 100644
--- a/drivers/common/sxe2/sxe2_msg.h
+++ b/drivers/common/sxe2/sxe2_msg.h
@@ -7,7 +7,7 @@
 #define __SXE2_MSG_H__
 
 enum sfp_type_identifier {
-	SXE2_SFP_TYPE_UNKNOW       = 0x00,
+	SXE2_SFP_TYPE_UNKNOWN      = 0x00,
 	SXE2_SFP_TYPE_SFP          = 0x03,
 
 	SXE2_SFP_TYPE_QSFP_PLUS    = 0x0D,
@@ -29,21 +29,20 @@ enum sfp_bus_addr {
 };
 
 struct sxe2_sfp_req {
-	u8 is_wr;
-	u8 is_qsfp;
+	uint8_t is_wr;
+	uint8_t is_qsfp;
 	uint16_t bus_addr;
 	uint16_t page_cnt;
 	uint16_t offset;
 	uint16_t data_len;
 	uint16_t rvd;
-	u8 data[];
+	uint8_t data[];
 };
-
 struct sxe2_sfp_resp {
-	u8 is_wr;
-	u8 is_qsfp;
+	uint8_t is_wr;
+	uint8_t is_qsfp;
 	uint16_t data_len;
-	u8 data[];
+	uint8_t data[];
 };
 
 enum sfp_page_cnt {
@@ -106,12 +105,12 @@ enum sxe2_led_mode {
 
 
 typedef struct sxe2_led_ctrl {
-	u32 mode;
-	u32 duration;
+	uint32_t mode;
+	uint32_t duration;
 } sxe2_led_ctrl_s;
 
 typedef struct sxe2_led_ctrl_resp {
-	u32 ack;
+	uint32_t ack;
 } sxe2_led_ctrl_resp_s;
 #endif
 
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
index 43f28c8304..8ac485b331 100644
--- a/drivers/net/sxe2/sxe2_cmd_chnl.h
+++ b/drivers/net/sxe2/sxe2_cmd_chnl.h
@@ -167,4 +167,7 @@ int32_t sxe2_drv_flow_fnav_query_stat(struct sxe2_adapter *adapter,
 int32_t sxe2_drv_srcvsi_prune_config(struct sxe2_adapter *adapter,
 		uint16_t *vsi_list, uint16_t vsi_cnt, bool set);
 
+int32_t sxe2_drv_sfp_eeprom_read(struct sxe2_adapter *adapter,
+		struct sxe2_sfp_read_info *sfp_info);
+
 #endif /* __SXE2_CMD_CHNL_H__ */
diff --git a/drivers/net/sxe2/sxe2_drv_cmd.h b/drivers/net/sxe2/sxe2_drv_cmd.h
index 5b5ddf9960..b7c70b0ea7 100644
--- a/drivers/net/sxe2/sxe2_drv_cmd.h
+++ b/drivers/net/sxe2/sxe2_drv_cmd.h
@@ -630,6 +630,24 @@ struct sxe2_drv_tx_map_req {
 	uint8_t pool_idx;
 };
 
+struct sxe2_drv_sfp_req {
+	uint8_t is_wr;
+	uint8_t is_qsfp;
+	__le16 bus_addr;
+	__le16 page_cnt;
+	__le16 offset;
+	__le16 data_len;
+	__le16 rvd;
+	uint8_t data[];
+};
+
+struct sxe2_drv_sfp_resp {
+	uint8_t is_wr;
+	uint8_t is_qsfp;
+	__le16 data_len;
+	uint8_t data[];
+};
+
 enum sxe2_drv_cmd_module {
 	SXE2_DRV_CMD_MODULE_HANDSHAKE = 0,
 	SXE2_DRV_CMD_MODULE_DEV = 1,
diff --git a/drivers/net/sxe2/sxe2_ethdev.c b/drivers/net/sxe2/sxe2_ethdev.c
index 45e245740b..edcedbab45 100644
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
index d6c6a152e7..e7a8ee0dd5 100644
--- a/drivers/net/sxe2/sxe2_ethdev.h
+++ b/drivers/net/sxe2/sxe2_ethdev.h
@@ -274,6 +274,15 @@ struct sxe2_sched_hw_cap {
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
2.47.3

