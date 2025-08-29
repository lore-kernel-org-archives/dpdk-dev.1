Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D751CA0FF7
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 Aug 2025 08:24:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A79EC402C1;
	Fri, 29 Aug 2025 10:24:20 +0200 (CEST)
Received: from lf-2-38.ptr.blmpb.com (lf-2-38.ptr.blmpb.com [101.36.218.38])
 by mails.dpdk.org (Postfix) with ESMTP id 7CCC7402AF
 for <dev@dpdk.org>; Fri, 29 Aug 2025 10:24:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1756455854; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=lwAsaGX6r4caMT0MVLsaIr9V4zJk7KRuVkG8/nhNHjU=;
 b=eVKqsIalm+ZSgdt9dhHzb5cTvawyLhyeML6xyNPtNGJoJHL+/9sEJVrRB5+akx/g47ZgjP
 kP+0XzpjGAVgHhKo1A9c44znitNjJz7Lg9AqlappK5h2MFxtKMAL98ES1P38yJJQOdIaa1
 ztyVpqWcQ3K4mN09bOEh1CCRpAZp5bxUysfabtMbNh1MVfI3vZC94MIkvDAGHxLlxlwCHy
 Nz9NG12i/QWbPOCj8aG2oLRcE5gkPqr+Dl+9+cYkDRiQj0sQADyyS/f9mrla3qLg+9YrPW
 uxypE2xHzRgJ9WQrUpQwlhfM4XjJjR5b4T35IUuVtnh+14+wZKXbGlFUo4ikPQ==
From: "Renyong Wan" <wanry@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
X-Mailer: git-send-email 2.25.1
Subject: [PATCH 03/14] net/xsc: support module EEPROM dump
Message-Id: <20250829082411.24369-4-wanry@yunsilicon.com>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+268b163ad+8beef6+dpdk.org+wanry@yunsilicon.com>
To: <dev@dpdk.org>
In-Reply-To: <20250829082406.24369-1-wanry@yunsilicon.com>
References: <20250829082406.24369-1-wanry@yunsilicon.com>
X-Original-From: Renyong Wan <wanry@yunsilicon.com>
Content-Transfer-Encoding: 7bit
Cc: <thomas@monjalon.net>, <stephen@networkplumber.org>, 
 <qianr@yunsilicon.com>, <nana@yunsilicon.com>, <zhangxx@yunsilicon.com>, 
 <xudw@yunsilicon.com>, <jacky@yunsilicon.com>, <weihg@yunsilicon.com>, 
 <zhenghy@yunsilicon.com>
Date: Fri, 29 Aug 2025 16:24:12 +0800
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn
 with ESMTPS; Fri, 29 Aug 2025 16:24:12 +0800
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

Add support for querying and reading the EEPROM of SFP/QSFP modules.

Signed-off-by: Rong Qian <qianr@yunsilicon.com>
Signed-off-by: Renyong Wan <wanry@yunsilicon.com>
---
 doc/guides/nics/features/xsc.ini |   1 +
 drivers/net/xsc/xsc_cmd.h        |  15 +++
 drivers/net/xsc/xsc_dev.c        | 185 +++++++++++++++++++++++++++++++
 drivers/net/xsc/xsc_dev.h        |  63 +++++++++++
 drivers/net/xsc/xsc_ethdev.c     | 107 ++++++++++++++++++
 5 files changed, 371 insertions(+)

diff --git a/doc/guides/nics/features/xsc.ini b/doc/guides/nics/features/xsc.ini
index 3b02289764..46c56fc921 100644
--- a/doc/guides/nics/features/xsc.ini
+++ b/doc/guides/nics/features/xsc.ini
@@ -16,6 +16,7 @@ Inner L4 checksum    = Y
 Basic stats          = Y
 Stats per queue      = Y
 FW version           = Y
+Module EEPROM dump   = Y
 Linux                = Y
 ARMv8                = Y
 x86-64               = Y
diff --git a/drivers/net/xsc/xsc_cmd.h b/drivers/net/xsc/xsc_cmd.h
index 433dcd0afa..82244d4011 100644
--- a/drivers/net/xsc/xsc_cmd.h
+++ b/drivers/net/xsc/xsc_cmd.h
@@ -23,6 +23,7 @@ enum xsc_cmd_opcode {
 	XSC_CMD_OP_RTR2RTS_QP		= 0x504,
 	XSC_CMD_OP_QP_2RST		= 0x50A,
 	XSC_CMD_OP_CREATE_MULTI_QP	= 0x515,
+	XSC_CMD_OP_ACCESS_REG		= 0x805,
 	XSC_CMD_OP_MODIFY_NIC_HCA	= 0x812,
 	XSC_CMD_OP_MODIFY_RAW_QP	= 0x81f,
 	XSC_CMD_OP_EXEC_NP		= 0x900,
@@ -384,4 +385,18 @@ struct xsc_cmd_modify_nic_hca_mbox_out {
 	uint8_t rsvd[4];
 };
 
+struct xsc_cmd_access_reg_mbox_in {
+	struct xsc_cmd_inbox_hdr hdr;
+	uint8_t rsvd0[2];
+	rte_be16_t register_id;
+	rte_be32_t arg;
+	rte_be32_t data[];
+};
+
+struct xsc_cmd_access_reg_mbox_out {
+	struct xsc_cmd_outbox_hdr hdr;
+	uint8_t rsvd[8];
+	rte_be32_t data[];
+};
+
 #endif /* _XSC_CMD_H_ */
diff --git a/drivers/net/xsc/xsc_dev.c b/drivers/net/xsc/xsc_dev.c
index 66f98d2327..2c55306d35 100644
--- a/drivers/net/xsc/xsc_dev.c
+++ b/drivers/net/xsc/xsc_dev.c
@@ -411,3 +411,188 @@ xsc_dev_fw_version_get(struct xsc_dev *xdev, char *fw_version, size_t fw_size)
 
 	return 0;
 }
+
+static int
+xsc_dev_access_reg(struct xsc_dev *xdev, void *data_in, int size_in,
+		   void *data_out, int size_out, uint16_t reg_num)
+{
+	struct xsc_cmd_access_reg_mbox_in *in;
+	struct xsc_cmd_access_reg_mbox_out *out;
+	int ret = -1;
+
+	in = malloc(sizeof(*in) + size_in);
+	if (in == NULL) {
+		rte_errno = ENOMEM;
+		PMD_DRV_LOG(ERR, "Failed to malloc access reg mbox in memory");
+		return -rte_errno;
+	}
+	memset(in, 0, sizeof(*in) + size_in);
+
+	out = malloc(sizeof(*out) + size_out);
+	if (out == NULL) {
+		rte_errno = ENOMEM;
+		PMD_DRV_LOG(ERR, "Failed to malloc access reg mbox out memory");
+		goto alloc_out_fail;
+	}
+	memset(out, 0, sizeof(*out) + size_out);
+
+	memcpy(in->data, data_in, size_in);
+	in->hdr.opcode = rte_cpu_to_be_16(XSC_CMD_OP_ACCESS_REG);
+	in->arg = 0;
+	in->register_id = rte_cpu_to_be_16(reg_num);
+
+	ret = xsc_dev_mailbox_exec(xdev, in, sizeof(*in) + size_in, out,
+				   sizeof(*out) + size_out);
+	if (ret != 0 || out->hdr.status != 0) {
+		rte_errno = ENOEXEC;
+		PMD_DRV_LOG(ERR, "Failed to access reg");
+		goto exit;
+	}
+
+	memcpy(data_out, out->data, size_out);
+
+exit:
+	free(out);
+
+alloc_out_fail:
+	free(in);
+	return ret;
+}
+
+static int
+xsc_dev_query_mcia(struct xsc_dev *xdev,
+		   struct xsc_module_eeprom_query_params *params,
+		   uint8_t *data)
+{
+	struct xsc_dev_reg_mcia in = { };
+	struct xsc_dev_reg_mcia out = { };
+	int ret;
+	void *ptr;
+	uint16_t size;
+
+	size = RTE_MIN(params->size, XSC_EEPROM_MAX_BYTES);
+	in.i2c_device_address = params->i2c_address;
+	in.module = params->module_number & 0x000000FF;
+	in.device_address = params->offset;
+	in.page_number = params->page;
+	in.size = size;
+
+	ret = xsc_dev_access_reg(xdev, &in, sizeof(in), &out, sizeof(out), XSC_REG_MCIA);
+	if (ret != 0)
+		return ret;
+
+	ptr = out.dword_0;
+	memcpy(data, ptr, size);
+
+	return size;
+}
+
+static void
+xsc_dev_sfp_eeprom_params_set(uint16_t *i2c_addr, uint32_t *page_num, uint16_t *offset)
+{
+	*i2c_addr = XSC_I2C_ADDR_LOW;
+	*page_num = 0;
+
+	if (*offset < XSC_EEPROM_PAGE_LENGTH)
+		return;
+
+	*i2c_addr = XSC_I2C_ADDR_HIGH;
+	*offset -= XSC_EEPROM_PAGE_LENGTH;
+}
+
+static int
+xsc_dev_qsfp_eeprom_page(uint16_t offset)
+{
+	if (offset < XSC_EEPROM_PAGE_LENGTH)
+		/* Addresses between 0-255 - page 00 */
+		return 0;
+
+	/*
+	 * Addresses between 256 - 639 belongs to pages 01, 02 and 03
+	 * For example, offset = 400 belongs to page 02:
+	 * 1 + ((400 - 256)/128) = 2
+	 */
+	return 1 + ((offset - XSC_EEPROM_PAGE_LENGTH) / XSC_EEPROM_HIGH_PAGE_LENGTH);
+}
+
+static int
+xsc_dev_qsfp_eeprom_high_page_offset(int page_num)
+{
+	/* Page 0 always start from low page */
+	if (!page_num)
+		return 0;
+
+	/* High page */
+	return page_num * XSC_EEPROM_HIGH_PAGE_LENGTH;
+}
+
+static void
+xsc_dev_qsfp_eeprom_params_set(uint16_t *i2c_addr, uint32_t *page_num, uint16_t *offset)
+{
+	*i2c_addr = XSC_I2C_ADDR_LOW;
+	*page_num = xsc_dev_qsfp_eeprom_page(*offset);
+	*offset -=  xsc_dev_qsfp_eeprom_high_page_offset(*page_num);
+}
+
+static int
+xsc_dev_query_module_id(struct xsc_dev *xdev, uint32_t module_num, uint8_t *module_id)
+{
+	struct xsc_dev_reg_mcia in = { 0 };
+	struct xsc_dev_reg_mcia out = { 0 };
+	int ret;
+	uint8_t *ptr;
+
+	in.i2c_device_address = XSC_I2C_ADDR_LOW;
+	in.module = module_num & 0x000000FF;
+	in.device_address = 0;
+	in.page_number = 0;
+	in.size = 1;
+
+	ret = xsc_dev_access_reg(xdev, &in, sizeof(in), &out, sizeof(out), XSC_REG_MCIA);
+	if (ret != 0)
+		return ret;
+
+	ptr = out.dword_0;
+	*module_id = ptr[0];
+	return 0;
+}
+
+int
+xsc_dev_query_module_eeprom(struct xsc_dev *xdev, uint16_t offset,
+			    uint16_t size, uint8_t *data)
+{
+	struct xsc_module_eeprom_query_params query = { 0 };
+	uint8_t module_id;
+	int ret;
+
+	query.module_number = xdev->hwinfo.mac_phy_port;
+	ret = xsc_dev_query_module_id(xdev, query.module_number, &module_id);
+	if (ret != 0)
+		return ret;
+
+	switch (module_id) {
+	case XSC_MODULE_ID_SFP:
+		xsc_dev_sfp_eeprom_params_set(&query.i2c_address, &query.page, &offset);
+		break;
+	case XSC_MODULE_ID_QSFP:
+	case XSC_MODULE_ID_QSFP_PLUS:
+	case XSC_MODULE_ID_QSFP28:
+	case XSC_MODULE_ID_QSFP_DD:
+	case XSC_MODULE_ID_DSFP:
+	case XSC_MODULE_ID_QSFP_PLUS_CMIS:
+		xsc_dev_qsfp_eeprom_params_set(&query.i2c_address, &query.page, &offset);
+		break;
+	default:
+		PMD_DRV_LOG(ERR, "Module ID not recognized: 0x%x", module_id);
+		return -EINVAL;
+	}
+
+	if (offset + size > XSC_EEPROM_PAGE_LENGTH)
+		/* Cross pages read, read until offset 256 in low page */
+		size = XSC_EEPROM_PAGE_LENGTH - offset;
+
+	query.size = size;
+	query.offset = offset;
+
+	return xsc_dev_query_mcia(xdev, &query, data);
+}
diff --git a/drivers/net/xsc/xsc_dev.h b/drivers/net/xsc/xsc_dev.h
index 274d6c6a2e..5cf19aaf3d 100644
--- a/drivers/net/xsc/xsc_dev.h
+++ b/drivers/net/xsc/xsc_dev.h
@@ -28,6 +28,12 @@
 #define XSC_DEV_REPR_ID_INVALID	0x7FFFFFFF
 
 #define XSC_FW_VERS_LEN			64
+#define XSC_DWORD_LEN			0x20
+#define XSC_I2C_ADDR_LOW		0x50
+#define XSC_I2C_ADDR_HIGH		0x51
+#define XSC_EEPROM_PAGE_LENGTH		256
+#define XSC_EEPROM_HIGH_PAGE_LENGTH	128
+#define XSC_EEPROM_MAX_BYTES		32
 
 enum xsc_queue_type {
 	XSC_QUEUE_TYPE_RDMA_RC		= 0,
@@ -41,6 +47,31 @@ enum xsc_queue_type {
 	XSC_QUEUE_TYPE_INVALID		= 0xFF,
 };
 
+enum xsc_reg_type {
+	XSC_REG_PMLP			= 0x0,
+	XSC_REG_PCAP			= 0x5001,
+	XSC_REG_PMTU			= 0x5003,
+	XSC_REG_PTYS			= 0x5004,
+	XSC_REG_PAOS			= 0x5006,
+	XSC_REG_PMAOS			= 0x5012,
+	XSC_REG_PUDE			= 0x5009,
+	XSC_REG_PMPE			= 0x5010,
+	XSC_REG_PELC			= 0x500e,
+	XSC_REG_NODE_DESC		= 0x6001,
+	XSC_REG_HOST_ENDIANNESS		= 0x7004,
+	XSC_REG_MCIA			= 0x9014,
+};
+
+enum xsc_module_id {
+	XSC_MODULE_ID_SFP		= 0x3,
+	XSC_MODULE_ID_QSFP		= 0xC,
+	XSC_MODULE_ID_QSFP_PLUS		= 0xD,
+	XSC_MODULE_ID_QSFP28		= 0x11,
+	XSC_MODULE_ID_QSFP_DD		= 0x18,
+	XSC_MODULE_ID_DSFP		= 0x1B,
+	XSC_MODULE_ID_QSFP_PLUS_CMIS	= 0x1E,
+};
+
 struct xsc_hwinfo {
 	uint32_t pcie_no; /* pcie number , 0 or 1 */
 	uint32_t func_id; /* pf glb func id */
@@ -132,6 +163,36 @@ struct xsc_dev {
 	int ctrl_fd;
 };
 
+struct xsc_module_eeprom_query_params {
+	uint16_t size;
+	uint16_t offset;
+	uint16_t i2c_address;
+	uint32_t page;
+	uint32_t bank;
+	uint32_t module_number;
+};
+
+struct xsc_dev_reg_mcia {
+	uint8_t module;
+	uint8_t status;
+	uint8_t i2c_device_address;
+	uint8_t page_number;
+	uint8_t device_address;
+	uint8_t size;
+	uint8_t dword_0[XSC_DWORD_LEN];
+	uint8_t dword_1[XSC_DWORD_LEN];
+	uint8_t dword_2[XSC_DWORD_LEN];
+	uint8_t dword_3[XSC_DWORD_LEN];
+	uint8_t dword_4[XSC_DWORD_LEN];
+	uint8_t dword_5[XSC_DWORD_LEN];
+	uint8_t dword_6[XSC_DWORD_LEN];
+	uint8_t dword_7[XSC_DWORD_LEN];
+	uint8_t dword_8[XSC_DWORD_LEN];
+	uint8_t dword_9[XSC_DWORD_LEN];
+	uint8_t dword_10[XSC_DWORD_LEN];
+	uint8_t dword_11[XSC_DWORD_LEN];
+};
+
 struct xsc_dev_ops {
 	TAILQ_ENTRY(xsc_dev_ops) entry;
 	enum rte_pci_kernel_driver kdrv;
@@ -184,5 +245,7 @@ int xsc_dev_qp_set_id_get(struct xsc_dev *xdev, int repr_id);
 int xsc_dev_set_mtu(struct xsc_dev *xdev, uint16_t mtu);
 int xsc_dev_get_mac(struct xsc_dev *xdev, uint8_t *mac);
 int xsc_dev_fw_version_get(struct xsc_dev *xdev, char *fw_version, size_t fw_size);
+int xsc_dev_query_module_eeprom(struct xsc_dev *xdev, uint16_t offset,
+				uint16_t size, uint8_t *data);
 
 #endif /* _XSC_DEV_H_ */
diff --git a/drivers/net/xsc/xsc_ethdev.c b/drivers/net/xsc/xsc_ethdev.c
index 9a70be0543..ffcf04a90c 100644
--- a/drivers/net/xsc/xsc_ethdev.c
+++ b/drivers/net/xsc/xsc_ethdev.c
@@ -2,6 +2,7 @@
  * Copyright 2025 Yunsilicon Technology Co., Ltd.
  */
 
+#include <rte_dev_info.h>
 #include <ethdev_pci.h>
 
 #include "xsc_log.h"
@@ -681,6 +682,110 @@ xsc_ethdev_fw_version_get(struct rte_eth_dev *dev, char *fw_version, size_t fw_s
 	return xsc_dev_fw_version_get(priv->xdev, fw_version, fw_size);
 }
 
+static int
+xsc_ethdev_get_module_info(struct rte_eth_dev *dev,
+			   struct rte_eth_dev_module_info *modinfo)
+{
+	int size_read = 0;
+	uint8_t data[4] = { 0 };
+	struct xsc_ethdev_priv *priv = TO_XSC_ETHDEV_PRIV(dev);
+
+	size_read = xsc_dev_query_module_eeprom(priv->xdev, 0, 3, data);
+	if (size_read < 3)
+		return -1;
+
+	/* data[0] = identifier byte */
+	switch (data[0]) {
+	case XSC_MODULE_ID_QSFP:
+		modinfo->type       = RTE_ETH_MODULE_SFF_8436;
+		modinfo->eeprom_len = RTE_ETH_MODULE_SFF_8436_MAX_LEN;
+		break;
+	case XSC_MODULE_ID_QSFP_PLUS:
+	case XSC_MODULE_ID_QSFP28:
+		/* data[1] = revision id */
+		if (data[0] == XSC_MODULE_ID_QSFP28 || data[1] >= 0x3) {
+			modinfo->type       = RTE_ETH_MODULE_SFF_8636;
+			modinfo->eeprom_len = RTE_ETH_MODULE_SFF_8636_MAX_LEN;
+		} else {
+			modinfo->type       = RTE_ETH_MODULE_SFF_8436;
+			modinfo->eeprom_len = RTE_ETH_MODULE_SFF_8436_MAX_LEN;
+		}
+		break;
+	case XSC_MODULE_ID_SFP:
+		modinfo->type       = RTE_ETH_MODULE_SFF_8472;
+		modinfo->eeprom_len = RTE_ETH_MODULE_SFF_8472_LEN;
+		break;
+	case XSC_MODULE_ID_QSFP_DD:
+	case XSC_MODULE_ID_DSFP:
+	case XSC_MODULE_ID_QSFP_PLUS_CMIS:
+		modinfo->type       = RTE_ETH_MODULE_SFF_8636;
+		/* Verify if module EEPROM is a flat memory. In case of flat
+		 * memory only page 00h (0-255 bytes) can be read. Otherwise
+		 * upper pages 01h and 02h can also be read. Upper pages 10h
+		 * and 11h are currently not supported by the driver.
+		 */
+		if (data[2] & 0x80)
+			modinfo->eeprom_len = RTE_ETH_MODULE_SFF_8636_LEN;
+		else
+			modinfo->eeprom_len = RTE_ETH_MODULE_SFF_8472_LEN;
+		break;
+	default:
+		PMD_DRV_LOG(ERR, "Cable type 0x%x not recognized",
+			    data[0]);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int
+xsc_ethdev_get_module_eeprom(struct rte_eth_dev *dev,
+			     struct rte_dev_eeprom_info *info)
+{
+	uint32_t i = 0;
+	uint8_t *data;
+	int size_read;
+	uint32_t offset = info->offset;
+	struct xsc_ethdev_priv *priv = TO_XSC_ETHDEV_PRIV(dev);
+
+	if (info->length == 0) {
+		PMD_DRV_LOG(ERR, "Failed to get module eeprom, eeprom length is 0");
+		rte_errno = EINVAL;
+		return -rte_errno;
+	}
+
+	data = malloc(info->length);
+	if (data == NULL) {
+		PMD_DRV_LOG(ERR, "Failed to get module eeprom, cannot allocate memory");
+		rte_errno = ENOMEM;
+		return -rte_errno;
+	}
+	memset(data, 0, info->length);
+
+	while (i < info->length) {
+		size_read = xsc_dev_query_module_eeprom(priv->xdev, offset,
+							info->length - i, data + i);
+		if (!size_read)
+			/* Done reading */
+			goto exit;
+
+		if (size_read < 0) {
+			PMD_DRV_LOG(ERR, "Failed to get module eeprom, size read=%d",
+				    size_read);
+			goto exit;
+		}
+
+		i += size_read;
+		offset += size_read;
+	}
+
+	memcpy(info->data, data, info->length);
+
+exit:
+	free(data);
+	return 0;
+}
+
 const struct eth_dev_ops xsc_eth_dev_ops = {
 	.dev_configure = xsc_ethdev_configure,
 	.dev_start = xsc_ethdev_start,
@@ -700,6 +805,8 @@ const struct eth_dev_ops xsc_eth_dev_ops = {
 	.rss_hash_update = xsc_ethdev_rss_hash_update,
 	.rss_hash_conf_get = xsc_ethdev_rss_hash_conf_get,
 	.fw_version_get = xsc_ethdev_fw_version_get,
+	.get_module_info = xsc_ethdev_get_module_info,
+	.get_module_eeprom = xsc_ethdev_get_module_eeprom,
 };
 
 static int
-- 
2.25.1
