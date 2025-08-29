Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B045CA0FF7
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 Aug 2025 08:25:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E6784065A;
	Fri, 29 Aug 2025 10:24:33 +0200 (CEST)
Received: from lf-2-37.ptr.blmpb.com (lf-2-37.ptr.blmpb.com [101.36.218.37])
 by mails.dpdk.org (Postfix) with ESMTP id 2BC2F40667
 for <dev@dpdk.org>; Fri, 29 Aug 2025 10:24:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1756455864; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=kYxB7suvbKEwYIYFLzj/74upsVooWCCJ3liVZRjG4cE=;
 b=g3QLRjHs63/vKrfa+GOV9qZ9hjxLUq4R8KX5yA11wKavai2WCMqbLZW5KzMcxLQ92lQJbX
 chmsDaJX/dPIb9mRwv5ofC54BewWG4KxPbE6Z6e+RIAGznfwAhWXXUTg8CcCPoNk/rWCSt
 wwXbzJGBVzkImQDEX9QovpvqxxZa6dtglDNRSGDFkeCPUD9Qz/mHvbzEjtnyVXamSScQ9G
 WxYMqZVvDdF06gfH9pCj3UTWzaloOGK9ti4Hu3LfiBXDuBBkcgZMF3TzB+MuSmgEA6RRqA
 awE8E2W3l+CRIlMGfqZqDkLuRX7xcBw/GxYk2ZDd6HvjCEbt/5eDPkZzDAS3Hw==
Date: Fri, 29 Aug 2025 16:24:22 +0800
Mime-Version: 1.0
X-Original-From: Renyong Wan <wanry@yunsilicon.com>
Subject: [PATCH 07/14] net/xsc: add FEC get and set support
Message-Id: <20250829082420.24369-8-wanry@yunsilicon.com>
To: <dev@dpdk.org>
References: <20250829082406.24369-1-wanry@yunsilicon.com>
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn
 with ESMTPS; Fri, 29 Aug 2025 16:24:21 +0800
X-Mailer: git-send-email 2.25.1
X-Lms-Return-Path: <lba+268b163b6+6186e1+dpdk.org+wanry@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: <thomas@monjalon.net>, <stephen@networkplumber.org>, 
 <qianr@yunsilicon.com>, <nana@yunsilicon.com>, <zhangxx@yunsilicon.com>, 
 <xudw@yunsilicon.com>, <jacky@yunsilicon.com>, <weihg@yunsilicon.com>, 
 <zhenghy@yunsilicon.com>
From: "Renyong Wan" <wanry@yunsilicon.com>
In-Reply-To: <20250829082406.24369-1-wanry@yunsilicon.com>
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

Add functions to get and set FEC mode for xsc PMD.

Signed-off-by: Rong Qian <qianr@yunsilicon.com>
Signed-off-by: Renyong Wan <wanry@yunsilicon.com>
---
 doc/guides/nics/features/xsc.ini |  1 +
 drivers/net/xsc/xsc_cmd.h        | 24 ++++++++++
 drivers/net/xsc/xsc_dev.c        | 75 ++++++++++++++++++++++++++++++++
 drivers/net/xsc/xsc_dev.h        | 16 +++++++
 drivers/net/xsc/xsc_ethdev.c     | 18 ++++++++
 5 files changed, 134 insertions(+)

diff --git a/doc/guides/nics/features/xsc.ini b/doc/guides/nics/features/xsc.ini
index d4498ed0a0..c6243c18df 100644
--- a/doc/guides/nics/features/xsc.ini
+++ b/doc/guides/nics/features/xsc.ini
@@ -12,6 +12,7 @@ Promiscuous mode     = Y
 RSS hash             = Y
 RSS key update       = Y
 RSS reta update      = Y
+FEC                  = Y
 L3 checksum offload  = Y
 L4 checksum offload  = Y
 Inner L3 checksum    = Y
diff --git a/drivers/net/xsc/xsc_cmd.h b/drivers/net/xsc/xsc_cmd.h
index 777de1ce4a..2746131cf1 100644
--- a/drivers/net/xsc/xsc_cmd.h
+++ b/drivers/net/xsc/xsc_cmd.h
@@ -28,6 +28,8 @@ enum xsc_cmd_opcode {
 	XSC_CMD_OP_MODIFY_RAW_QP		= 0x81f,
 	XSC_CMD_OP_QUERY_EVENT_TYPE		= 0x831,
 	XSC_CMD_OP_QUERY_LINK_INFO		= 0x832,
+	XSC_CMD_OP_QUERY_FEC_PARAM		= 0x835,
+	XSC_CMD_OP_MODIFY_FEC_PARAM		= 0x836,
 	XSC_CMD_OP_ENABLE_MSIX			= 0x850,
 	XSC_CMD_OP_EXEC_NP			= 0x900,
 	XSC_CMD_OP_SET_MTU			= 0x1100,
@@ -473,4 +475,26 @@ struct xsc_cmd_msix_table_info_mbox_out {
 	uint32_t data;
 };
 
+struct xsc_cmd_query_fecparam_mbox_in {
+	struct xsc_cmd_inbox_hdr hdr;
+	uint8_t rsvd[2];
+};
+
+struct xsc_cmd_query_fecparam_mbox_out {
+	struct xsc_cmd_outbox_hdr hdr;
+	uint32_t active_fec;
+	uint32_t fec_cfg;
+	uint32_t status;
+};
+
+struct xsc_cmd_modify_fecparam_mbox_in {
+	struct xsc_cmd_inbox_hdr hdr;
+	uint32_t fec;
+};
+
+struct xsc_cmd_modify_fecparam_mbox_out {
+	struct xsc_cmd_outbox_hdr hdr;
+	uint32_t status;
+};
+
 #endif /* _XSC_CMD_H_ */
diff --git a/drivers/net/xsc/xsc_dev.c b/drivers/net/xsc/xsc_dev.c
index 815b67d7da..6b24ea98d0 100644
--- a/drivers/net/xsc/xsc_dev.c
+++ b/drivers/net/xsc/xsc_dev.c
@@ -614,3 +614,78 @@ xsc_dev_intr_handler_uninstall(struct xsc_dev *xdev)
 
 	return xdev->dev_ops->intr_handler_uninstall(xdev);
 }
+
+int
+xsc_dev_fec_get(struct xsc_dev *xdev, uint32_t *fec_capa)
+{
+	struct xsc_cmd_query_fecparam_mbox_in in = { };
+	struct xsc_cmd_query_fecparam_mbox_out out = { };
+	int ret = 0, fec;
+
+	in.hdr.opcode = rte_cpu_to_be_16(XSC_CMD_OP_QUERY_FEC_PARAM);
+	ret = xsc_dev_mailbox_exec(xdev, &in, sizeof(in), &out, sizeof(out));
+	if (ret != 0 || out.hdr.status != 0) {
+		PMD_DRV_LOG(ERR, "Failed to get fec, ret=%d, status=%u",
+			    ret, out.hdr.status);
+		rte_errno = ENOEXEC;
+		return -rte_errno;
+	}
+
+	fec = rte_be_to_cpu_32(out.active_fec);
+	switch (fec) {
+	case XSC_DEV_FEC_OFF:
+		fec = RTE_ETH_FEC_MODE_CAPA_MASK(NOFEC);
+		break;
+	case XSC_DEV_FEC_BASER:
+		fec = RTE_ETH_FEC_MODE_CAPA_MASK(BASER);
+		break;
+	case XSC_DEV_FEC_RS:
+		fec = RTE_ETH_FEC_MODE_CAPA_MASK(RS);
+		break;
+	default:
+		fec = RTE_ETH_FEC_MODE_CAPA_MASK(NOFEC);
+		break;
+	}
+
+	*fec_capa = fec;
+
+	return 0;
+}
+
+int
+xsc_dev_fec_set(struct xsc_dev *xdev, uint32_t mode)
+{
+	struct xsc_cmd_modify_fecparam_mbox_in in = { };
+	struct xsc_cmd_modify_fecparam_mbox_out out = { };
+	int ret = 0;
+
+	in.hdr.opcode = rte_cpu_to_be_16(XSC_CMD_OP_MODIFY_FEC_PARAM);
+	switch (mode) {
+	case RTE_ETH_FEC_MODE_CAPA_MASK(NOFEC):
+		mode = XSC_DEV_FEC_OFF;
+		break;
+	case RTE_ETH_FEC_MODE_CAPA_MASK(AUTO):
+		mode = XSC_DEV_FEC_AUTO;
+		break;
+	case RTE_ETH_FEC_MODE_CAPA_MASK(BASER):
+		mode = XSC_DEV_FEC_BASER;
+		break;
+	case RTE_ETH_FEC_MODE_CAPA_MASK(RS):
+		mode = XSC_DEV_FEC_RS;
+		break;
+	default:
+		PMD_DRV_LOG(ERR, "Failed to set fec, fec mode %u not support", mode);
+		return 0;
+	}
+
+	in.fec = rte_cpu_to_be_32(mode);
+	ret = xsc_dev_mailbox_exec(xdev, &in, sizeof(in), &out, sizeof(out));
+	if (ret != 0 || out.hdr.status != 0) {
+		PMD_DRV_LOG(ERR, "Failed to set fec param, ret=%d, status=%u",
+			    ret, out.hdr.status);
+		rte_errno = ENOEXEC;
+		return -rte_errno;
+	}
+
+	return 0;
+}
diff --git a/drivers/net/xsc/xsc_dev.h b/drivers/net/xsc/xsc_dev.h
index 86a0eee22e..e058ffdc21 100644
--- a/drivers/net/xsc/xsc_dev.h
+++ b/drivers/net/xsc/xsc_dev.h
@@ -35,6 +35,20 @@
 #define XSC_EEPROM_HIGH_PAGE_LENGTH	128
 #define XSC_EEPROM_MAX_BYTES		32
 
+enum xsc_dev_fec_config_bits {
+	XSC_DEV_FEC_NONE_BIT,
+	XSC_DEV_FEC_AUTO_BIT,
+	XSC_DEV_FEC_OFF_BIT,
+	XSC_DEV_FEC_RS_BIT,
+	XSC_DEV_FEC_BASER_BIT,
+};
+
+#define XSC_DEV_FEC_NONE	(1 << XSC_DEV_FEC_NONE_BIT)
+#define XSC_DEV_FEC_AUTO	(1 << XSC_DEV_FEC_AUTO_BIT)
+#define XSC_DEV_FEC_OFF		(1 << XSC_DEV_FEC_OFF_BIT)
+#define XSC_DEV_FEC_RS		(1 << XSC_DEV_FEC_RS_BIT)
+#define XSC_DEV_FEC_BASER	(1 << XSC_DEV_FEC_BASER_BIT)
+
 enum xsc_queue_type {
 	XSC_QUEUE_TYPE_RDMA_RC		= 0,
 	XSC_QUEUE_TYPE_RDMA_MAD		= 1,
@@ -262,5 +276,7 @@ int xsc_dev_query_module_eeprom(struct xsc_dev *xdev, uint16_t offset,
 int xsc_dev_intr_event_get(struct xsc_dev *xdev);
 int xsc_dev_intr_handler_install(struct xsc_dev *xdev, rte_intr_callback_fn cb, void *cb_arg);
 int xsc_dev_intr_handler_uninstall(struct xsc_dev *xdev);
+int xsc_dev_fec_get(struct xsc_dev *xdev, uint32_t *fec_capa);
+int xsc_dev_fec_set(struct xsc_dev *xdev, uint32_t mode);
 
 #endif /* _XSC_DEV_H_ */
diff --git a/drivers/net/xsc/xsc_ethdev.c b/drivers/net/xsc/xsc_ethdev.c
index 0884894a9b..261b49cff4 100644
--- a/drivers/net/xsc/xsc_ethdev.c
+++ b/drivers/net/xsc/xsc_ethdev.c
@@ -845,6 +845,22 @@ xsc_ethdev_get_module_eeprom(struct rte_eth_dev *dev,
 	return 0;
 }
 
+static int
+xsc_ethdev_fec_get(struct rte_eth_dev *dev, uint32_t *fec_capa)
+{
+	struct xsc_ethdev_priv *priv = TO_XSC_ETHDEV_PRIV(dev);
+
+	return xsc_dev_fec_get(priv->xdev, fec_capa);
+}
+
+static int
+xsc_ethdev_fec_set(struct rte_eth_dev *dev, uint32_t mode)
+{
+	struct xsc_ethdev_priv *priv = TO_XSC_ETHDEV_PRIV(dev);
+
+	return xsc_dev_fec_set(priv->xdev, mode);
+}
+
 const struct eth_dev_ops xsc_eth_dev_ops = {
 	.dev_configure = xsc_ethdev_configure,
 	.dev_start = xsc_ethdev_start,
@@ -868,6 +884,8 @@ const struct eth_dev_ops xsc_eth_dev_ops = {
 	.fw_version_get = xsc_ethdev_fw_version_get,
 	.get_module_info = xsc_ethdev_get_module_info,
 	.get_module_eeprom = xsc_ethdev_get_module_eeprom,
+	.fec_get = xsc_ethdev_fec_get,
+	.fec_set = xsc_ethdev_fec_set,
 };
 
 static int
-- 
2.25.1
