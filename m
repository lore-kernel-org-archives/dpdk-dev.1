Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0FBAC8303F
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 Aug 2025 08:24:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 85CFC40611;
	Fri, 29 Aug 2025 10:24:28 +0200 (CEST)
Received: from lf-1-20.ptr.blmpb.com (lf-1-20.ptr.blmpb.com [103.149.242.20])
 by mails.dpdk.org (Postfix) with ESMTP id C5635402AF
 for <dev@dpdk.org>; Fri, 29 Aug 2025 10:24:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1756455859; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=qEn2RLpyUl5kzpmwoIcDmNqYoO0ANm6Wwb/eWm7OMpM=;
 b=FUYaxImlP7so70BWvtSvVveJ3CyejV7QfCXcAz9VBkMzQVBNTMvOQzGKxG6fBopv0s5TQm
 5K+WMqlHr8LBmNudwiqWjRAtacosiOIOYWVQnQYl6sLCRm3zHB34Y9DaPZGJmK3QSkZ19s
 zMsLTlVhuOKV+j+fwz4HTdNO9oXFqk0lwr04D+yVIMjQT+Re2bbtir0QVEQSRcuzHoDB4j
 jva1lbBaCYXYtFkfPtpoOF4W7LqYHcSn6OmIhiVHKdlkbyWnrCW/S7vly3orhEx2xKZhAn
 sEWppxQrOddDlrMp1O22/Y6FrrbV1Mw0TkHyMa83BPiVsVrM6oblhdcWWYDsVA==
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn
 with ESMTPS; Fri, 29 Aug 2025 16:24:17 +0800
From: "Renyong Wan" <wanry@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
Message-Id: <20250829082415.24369-6-wanry@yunsilicon.com>
Subject: [PATCH 05/14] net/xsc: add link status support
Mime-Version: 1.0
X-Original-From: Renyong Wan <wanry@yunsilicon.com>
X-Lms-Return-Path: <lba+268b163b1+00f6f4+dpdk.org+wanry@yunsilicon.com>
References: <20250829082406.24369-1-wanry@yunsilicon.com>
Content-Transfer-Encoding: 7bit
To: <dev@dpdk.org>
Date: Fri, 29 Aug 2025 16:24:17 +0800
In-Reply-To: <20250829082406.24369-1-wanry@yunsilicon.com>
X-Mailer: git-send-email 2.25.1
Cc: <thomas@monjalon.net>, <stephen@networkplumber.org>, 
 <qianr@yunsilicon.com>, <nana@yunsilicon.com>, <zhangxx@yunsilicon.com>, 
 <xudw@yunsilicon.com>, <jacky@yunsilicon.com>, <weihg@yunsilicon.com>, 
 <zhenghy@yunsilicon.com>
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

Add support for getting and setting the link state.

Signed-off-by: Rong Qian <qianr@yunsilicon.com>
Signed-off-by: Renyong Wan <wanry@yunsilicon.com>
---
 doc/guides/nics/features/xsc.ini |  1 +
 drivers/net/xsc/xsc_cmd.h        | 73 +++++++++++++++++++-----
 drivers/net/xsc/xsc_dev.c        | 21 ++-----
 drivers/net/xsc/xsc_dev.h        | 11 ++--
 drivers/net/xsc/xsc_ethdev.c     | 34 +++++++----
 drivers/net/xsc/xsc_vfio.c       | 96 ++++++++++++++++++++++++++++++++
 6 files changed, 189 insertions(+), 47 deletions(-)

diff --git a/doc/guides/nics/features/xsc.ini b/doc/guides/nics/features/xsc.ini
index dfbfc88dbc..0d98296973 100644
--- a/doc/guides/nics/features/xsc.ini
+++ b/doc/guides/nics/features/xsc.ini
@@ -4,6 +4,7 @@
 ; Refer to default.ini for the full list of available PMD features.
 ;
 [Features]
+Link status          = Y
 MTU update           = Y
 TSO                  = Y
 Promiscuous mode     = Y
diff --git a/drivers/net/xsc/xsc_cmd.h b/drivers/net/xsc/xsc_cmd.h
index 82244d4011..207f4456d5 100644
--- a/drivers/net/xsc/xsc_cmd.h
+++ b/drivers/net/xsc/xsc_cmd.h
@@ -15,20 +15,22 @@
 #define XSC_CMD_QUERY_HCA_CAP_V1	1
 
 enum xsc_cmd_opcode {
-	XSC_CMD_OP_QUERY_HCA_CAP	= 0x100,
-	XSC_CMD_OP_CREATE_CQ		= 0x400,
-	XSC_CMD_OP_DESTROY_CQ		= 0x401,
-	XSC_CMD_OP_CREATE_QP		= 0x500,
-	XSC_CMD_OP_DESTROY_QP		= 0x501,
-	XSC_CMD_OP_RTR2RTS_QP		= 0x504,
-	XSC_CMD_OP_QP_2RST		= 0x50A,
-	XSC_CMD_OP_CREATE_MULTI_QP	= 0x515,
-	XSC_CMD_OP_ACCESS_REG		= 0x805,
-	XSC_CMD_OP_MODIFY_NIC_HCA	= 0x812,
-	XSC_CMD_OP_MODIFY_RAW_QP	= 0x81f,
-	XSC_CMD_OP_EXEC_NP		= 0x900,
-	XSC_CMD_OP_SET_MTU		= 0x1100,
-	XSC_CMD_OP_QUERY_ETH_MAC	= 0X1101,
+	XSC_CMD_OP_QUERY_HCA_CAP		= 0x100,
+	XSC_CMD_OP_CREATE_CQ			= 0x400,
+	XSC_CMD_OP_DESTROY_CQ			= 0x401,
+	XSC_CMD_OP_CREATE_QP			= 0x500,
+	XSC_CMD_OP_DESTROY_QP			= 0x501,
+	XSC_CMD_OP_RTR2RTS_QP			= 0x504,
+	XSC_CMD_OP_QP_2RST			= 0x50A,
+	XSC_CMD_OP_CREATE_MULTI_QP		= 0x515,
+	XSC_CMD_OP_ACCESS_REG			= 0x805,
+	XSC_CMD_OP_MODIFY_NIC_HCA		= 0x812,
+	XSC_CMD_OP_MODIFY_RAW_QP		= 0x81f,
+	XSC_CMD_OP_QUERY_LINK_INFO		= 0x832,
+	XSC_CMD_OP_EXEC_NP			= 0x900,
+	XSC_CMD_OP_SET_MTU			= 0x1100,
+	XSC_CMD_OP_QUERY_ETH_MAC		= 0X1101,
+	XSC_CMD_OP_SET_PORT_ADMIN_STATUS	= 0x1801,
 	XSC_CMD_OP_MAX
 };
 
@@ -399,4 +401,47 @@ struct xsc_cmd_access_reg_mbox_out {
 	rte_be32_t data[];
 };
 
+struct xsc_cmd_set_port_admin_status_mbox_in {
+	struct xsc_cmd_inbox_hdr hdr;
+	uint16_t admin_status;
+};
+
+struct xsc_cmd_set_port_admin_status_mbox_out {
+	struct xsc_cmd_outbox_hdr  hdr;
+	uint32_t status;
+};
+
+struct xsc_cmd_query_linkinfo_mbox_in {
+	struct xsc_cmd_inbox_hdr hdr;
+};
+
+struct xsc_cmd_linkinfo {
+	uint8_t status; /*link status: 0-down, 1-up */
+	uint8_t port;
+	uint8_t duplex;
+	uint8_t autoneg;
+	rte_be32_t linkspeed;
+	rte_be64_t supported;
+	rte_be64_t advertising;
+	rte_be64_t supported_fec;
+	rte_be64_t advertised_fec;
+	rte_be64_t supported_speed[2];
+	rte_be64_t advertising_speed[2];
+};
+
+struct xsc_cmd_query_linkinfo_mbox_out {
+	struct xsc_cmd_outbox_hdr hdr;
+	struct xsc_cmd_linkinfo ctx;
+};
+
+struct xsc_cmd_modify_linkinfo_mbox_in {
+	struct xsc_cmd_inbox_hdr hdr;
+	struct xsc_cmd_linkinfo ctx;
+};
+
+struct xsc_cmd_modify_linkinfo_mbox_out {
+	struct xsc_cmd_outbox_hdr hdr;
+	uint32_t status;
+};
+
 #endif /* _XSC_CMD_H_ */
diff --git a/drivers/net/xsc/xsc_dev.c b/drivers/net/xsc/xsc_dev.c
index 2c55306d35..28581459b9 100644
--- a/drivers/net/xsc/xsc_dev.c
+++ b/drivers/net/xsc/xsc_dev.c
@@ -64,30 +64,21 @@ xsc_dev_mailbox_exec(struct xsc_dev *xdev, void *data_in,
 }
 
 int
-xsc_dev_set_link_up(struct xsc_dev *xdev)
+xsc_dev_link_status_set(struct xsc_dev *xdev, uint16_t status)
 {
-	if (xdev->dev_ops->set_link_up == NULL)
+	if (xdev->dev_ops->link_status_set == NULL)
 		return -ENOTSUP;
 
-	return xdev->dev_ops->set_link_up(xdev);
+	return xdev->dev_ops->link_status_set(xdev, status);
 }
 
 int
-xsc_dev_set_link_down(struct xsc_dev *xdev)
+xsc_dev_link_get(struct xsc_dev *xdev, struct rte_eth_link *link)
 {
-	if (xdev->dev_ops->set_link_down == NULL)
+	if (xdev->dev_ops->link_get == NULL)
 		return -ENOTSUP;
 
-	return xdev->dev_ops->set_link_down(xdev);
-}
-
-int
-xsc_dev_link_update(struct xsc_dev *xdev, uint8_t funcid_type, int wait_to_complete)
-{
-	if (xdev->dev_ops->link_update == NULL)
-		return -ENOTSUP;
-
-	return xdev->dev_ops->link_update(xdev, funcid_type, wait_to_complete);
+	return xdev->dev_ops->link_get(xdev, link);
 }
 
 int
diff --git a/drivers/net/xsc/xsc_dev.h b/drivers/net/xsc/xsc_dev.h
index 5cf19aaf3d..e543b6892d 100644
--- a/drivers/net/xsc/xsc_dev.h
+++ b/drivers/net/xsc/xsc_dev.h
@@ -144,7 +144,6 @@ struct xsc_dev {
 	const struct xsc_dev_ops *dev_ops;
 	struct xsc_devargs devargs;
 	struct xsc_hwinfo hwinfo;
-	struct rte_eth_link pf_dev_link;
 	uint32_t link_speed_capa;
 	int vfos_logical_in_port;
 	int vfrep_offset;
@@ -199,9 +198,8 @@ struct xsc_dev_ops {
 	int (*dev_init)(struct xsc_dev *xdev);
 	int (*dev_close)(struct xsc_dev *xdev);
 	int (*get_mac)(struct xsc_dev *xdev, uint8_t *mac);
-	int (*set_link_up)(struct xsc_dev *xdev);
-	int (*set_link_down)(struct xsc_dev *xdev);
-	int (*link_update)(struct xsc_dev *xdev, uint8_t funcid_type, int wait_to_complete);
+	int (*link_status_set)(struct xsc_dev *xdev, uint16_t status);
+	int (*link_get)(struct xsc_dev *xdev, struct rte_eth_link *link);
 	int (*set_mtu)(struct xsc_dev *xdev, uint16_t mtu);
 	int (*destroy_qp)(void *qp);
 	int (*destroy_cq)(void *cq);
@@ -222,9 +220,8 @@ struct xsc_dev_ops {
 int xsc_dev_mailbox_exec(struct xsc_dev *xdev, void *data_in,
 			 int in_len, void *data_out, int out_len);
 void xsc_dev_ops_register(struct xsc_dev_ops *new_ops);
-int xsc_dev_set_link_up(struct xsc_dev *xdev);
-int xsc_dev_set_link_down(struct xsc_dev *xde);
-int xsc_dev_link_update(struct xsc_dev *xdev, uint8_t funcid_type, int wait_to_complete);
+int xsc_dev_link_status_set(struct xsc_dev *xdev, uint16_t status);
+int xsc_dev_link_get(struct xsc_dev *xdev, struct rte_eth_link *link);
 int xsc_dev_destroy_qp(struct xsc_dev *xdev, void *qp);
 int xsc_dev_destroy_cq(struct xsc_dev *xdev, void *cq);
 int xsc_dev_modify_qp_status(struct xsc_dev *xdev, uint32_t qpn, int num, int opcode);
diff --git a/drivers/net/xsc/xsc_ethdev.c b/drivers/net/xsc/xsc_ethdev.c
index efe1ad72f6..3574da91eb 100644
--- a/drivers/net/xsc/xsc_ethdev.c
+++ b/drivers/net/xsc/xsc_ethdev.c
@@ -389,7 +389,9 @@ xsc_ethdev_set_link_up(struct rte_eth_dev *dev)
 	struct xsc_ethdev_priv *priv = TO_XSC_ETHDEV_PRIV(dev);
 	struct xsc_dev *xdev = priv->xdev;
 
-	return xsc_dev_set_link_up(xdev);
+	if (xsc_dev_is_vf(xdev))
+		return -ENOTSUP;
+	return xsc_dev_link_status_set(xdev, RTE_ETH_LINK_UP);
 }
 
 static int
@@ -398,24 +400,26 @@ xsc_ethdev_set_link_down(struct rte_eth_dev *dev)
 	struct xsc_ethdev_priv *priv = TO_XSC_ETHDEV_PRIV(dev);
 	struct xsc_dev *xdev = priv->xdev;
 
-	return xsc_dev_set_link_down(xdev);
+	if (xsc_dev_is_vf(xdev))
+		return -ENOTSUP;
+	return xsc_dev_link_status_set(xdev, RTE_ETH_LINK_DOWN);
 }
 
 static int
-xsc_ethdev_link_update(struct rte_eth_dev *dev,
-		       int wait_to_complete)
+xsc_ethdev_link_update(struct rte_eth_dev *dev, int wait_to_complete)
 {
 	struct xsc_ethdev_priv *priv = TO_XSC_ETHDEV_PRIV(dev);
 	struct xsc_dev *xdev = priv->xdev;
+	struct rte_eth_link link = { };
 	int ret = 0;
 
-	ret = xsc_dev_link_update(xdev, priv->funcid_type, wait_to_complete);
-	if (ret == 0) {
-		dev->data->dev_link = xdev->pf_dev_link;
-		dev->data->dev_link.link_autoneg = !(dev->data->dev_conf.link_speeds &
-				  RTE_ETH_LINK_SPEED_FIXED);
-	}
-	return ret;
+	RTE_SET_USED(wait_to_complete);
+	ret = xsc_dev_link_get(xdev, &link);
+	if (ret != 0)
+		return ret;
+	rte_eth_linkstatus_set(dev, &link);
+
+	return 0;
 }
 
 static uint64_t
@@ -980,6 +984,14 @@ xsc_ethdev_init_representors(struct rte_eth_dev *eth_dev)
 		}
 	}
 
+	if (!xsc_dev_is_vf(priv->xdev)) {
+		ret = xsc_ethdev_set_link_up(eth_dev);
+		if (ret != 0) {
+			PMD_DRV_LOG(ERR, "Failed to set port %u link up", eth_dev->data->port_id);
+			goto destroy_reprs;
+		}
+	}
+
 	return 0;
 
 destroy_reprs:
diff --git a/drivers/net/xsc/xsc_vfio.c b/drivers/net/xsc/xsc_vfio.c
index f61cf92569..cc3660e259 100644
--- a/drivers/net/xsc/xsc_vfio.c
+++ b/drivers/net/xsc/xsc_vfio.c
@@ -31,6 +31,21 @@ enum xsc_cq_type {
 	XSC_CQ_TYPE_VIRTIO = 1,
 };
 
+enum xsc_speed_mode {
+	XSC_MODULE_SPEED_UNKNOWN,
+	XSC_MODULE_SPEED_10G,
+	XSC_MODULE_SPEED_25G,
+	XSC_MODULE_SPEED_40G_R4,
+	XSC_MODULE_SPEED_50G_R,
+	XSC_MODULE_SPEED_50G_R2,
+	XSC_MODULE_SPEED_100G_R2,
+	XSC_MODULE_SPEED_100G_R4,
+	XSC_MODULE_SPEED_200G_R4,
+	XSC_MODULE_SPEED_200G_R8,
+	XSC_MODULE_SPEED_400G_R8,
+	XSC_MODULE_SPEED_MAX,
+};
+
 struct xsc_vfio_cq {
 	const struct rte_memzone *mz;
 	struct xsc_dev *xdev;
@@ -43,6 +58,20 @@ struct xsc_vfio_qp {
 	uint32_t	qpn;
 };
 
+static const uint32_t xsc_link_speed[] = {
+	[XSC_MODULE_SPEED_UNKNOWN]  = RTE_ETH_SPEED_NUM_UNKNOWN,
+	[XSC_MODULE_SPEED_10G]      = RTE_ETH_SPEED_NUM_10G,
+	[XSC_MODULE_SPEED_25G]      = RTE_ETH_SPEED_NUM_25G,
+	[XSC_MODULE_SPEED_40G_R4]   = RTE_ETH_SPEED_NUM_40G,
+	[XSC_MODULE_SPEED_50G_R]    = RTE_ETH_SPEED_NUM_50G,
+	[XSC_MODULE_SPEED_50G_R2]   = RTE_ETH_SPEED_NUM_50G,
+	[XSC_MODULE_SPEED_100G_R2]  = RTE_ETH_SPEED_NUM_100G,
+	[XSC_MODULE_SPEED_100G_R4]  = RTE_ETH_SPEED_NUM_100G,
+	[XSC_MODULE_SPEED_200G_R4]  = RTE_ETH_SPEED_NUM_200G,
+	[XSC_MODULE_SPEED_200G_R8]  = RTE_ETH_SPEED_NUM_200G,
+	[XSC_MODULE_SPEED_400G_R8]  = RTE_ETH_SPEED_NUM_400G,
+};
+
 static void
 xsc_vfio_pcie_no_init(struct xsc_hwinfo *hwinfo)
 {
@@ -333,6 +362,71 @@ xsc_vfio_get_mac(struct xsc_dev *xdev, uint8_t *mac)
 	return 0;
 }
 
+static int
+xsc_vfio_modify_link_status(struct xsc_dev *xdev, uint16_t status)
+{
+	struct xsc_cmd_set_port_admin_status_mbox_in in = { };
+	struct xsc_cmd_set_port_admin_status_mbox_out out = { };
+	int ret = 0;
+
+	in.hdr.opcode = rte_cpu_to_be_16(XSC_CMD_OP_SET_PORT_ADMIN_STATUS);
+	in.admin_status = rte_cpu_to_be_16(status);
+
+	ret = xsc_vfio_mbox_exec(xdev, &in, sizeof(in), &out, sizeof(out));
+	if (ret != 0 || out.hdr.status != 0) {
+		PMD_DRV_LOG(ERR, "Failed to set link status, ret=%d, status=%d",
+			    ret, out.hdr.status);
+		return -ENOEXEC;
+	}
+
+	return ret;
+}
+
+static int
+xsc_vfio_link_status_set(struct xsc_dev *xdev, uint16_t status)
+{
+	if (status != RTE_ETH_LINK_UP && status != RTE_ETH_LINK_DOWN)
+		return -EINVAL;
+
+	return xsc_vfio_modify_link_status(xdev, status);
+}
+
+static uint32_t
+xsc_vfio_link_speed_translate(uint32_t mode)
+{
+	if (mode >= XSC_MODULE_SPEED_MAX)
+		return RTE_ETH_SPEED_NUM_NONE;
+
+	return xsc_link_speed[mode];
+}
+
+static int
+xsc_vfio_link_get(struct xsc_dev *xdev, struct rte_eth_link *link)
+{
+	struct xsc_cmd_query_linkinfo_mbox_in in = { };
+	struct xsc_cmd_query_linkinfo_mbox_out out = { };
+	struct xsc_cmd_linkinfo linkinfo;
+	int  ret;
+	uint32_t speed_mode;
+
+	in.hdr.opcode = rte_cpu_to_be_16(XSC_CMD_OP_QUERY_LINK_INFO);
+	ret = xsc_vfio_mbox_exec(xdev, &in, sizeof(in), &out, sizeof(out));
+	if (ret != 0 || out.hdr.status != 0) {
+		PMD_DRV_LOG(ERR, "Failed to get link info, ret=%d, status=%d",
+			    ret, out.hdr.status);
+		return -ENOEXEC;
+	}
+
+	linkinfo = out.ctx;
+	link->link_status = linkinfo.status ? RTE_ETH_LINK_UP : RTE_ETH_LINK_DOWN;
+	speed_mode = rte_be_to_cpu_32(linkinfo.linkspeed);
+	link->link_speed = xsc_vfio_link_speed_translate(speed_mode);
+	link->link_duplex = linkinfo.duplex;
+	link->link_autoneg =  linkinfo.autoneg;
+
+	return 0;
+};
+
 static int
 xsc_vfio_modify_qp_status(struct xsc_dev *xdev, uint32_t qpn, int num, int opcode)
 {
@@ -770,6 +864,8 @@ static struct xsc_dev_ops *xsc_vfio_ops = &(struct xsc_dev_ops) {
 	.dev_close = xsc_vfio_dev_close,
 	.set_mtu = xsc_vfio_set_mtu,
 	.get_mac = xsc_vfio_get_mac,
+	.link_status_set = xsc_vfio_link_status_set,
+	.link_get = xsc_vfio_link_get,
 	.destroy_qp = xsc_vfio_destroy_qp,
 	.destroy_cq = xsc_vfio_destroy_cq,
 	.modify_qp_status = xsc_vfio_modify_qp_status,
-- 
2.25.1
