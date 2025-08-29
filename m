Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35686C8303F
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 Aug 2025 08:24:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A48F540656;
	Fri, 29 Aug 2025 10:24:29 +0200 (CEST)
Received: from lf-2-35.ptr.blmpb.com (lf-2-35.ptr.blmpb.com [101.36.218.35])
 by mails.dpdk.org (Postfix) with ESMTP id 5DBCC40611
 for <dev@dpdk.org>; Fri, 29 Aug 2025 10:24:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1756455862; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=VDBy59RsxsQo9vhK7Di/s+dTyOyjJRH+CB+w57cDne0=;
 b=a6lnF2DuDOVuVVhIYK5ikVZDWP1YT1+78WLule5GCMGMQ444M6tdJMqwKVgI5nuYrwYXrx
 RZkAS/50046SQpO3dYJdBSJlGHwN4LvYz0/5mkheX+MNAi/ShrsyF2utHyA/VsubydicTR
 zvqi0H40hoXenSK/tMKmCyryiQRG07Oc2Snpk+gw558mZO53kXdu7DoSgAKisnssbC0zSL
 JKckAwlwjcG55zHozgTu9shJi8hTRVDV+zsIgWI6GULXoOe/G5dLFrcpeBQa+GW0n4OIL2
 tXFALSxLDBdQ1u81bM2AxVnb9Wja4RljA1fBTK3NEz1msdQSIhneUJAdi3lk8w==
References: <20250829082406.24369-1-wanry@yunsilicon.com>
In-Reply-To: <20250829082406.24369-1-wanry@yunsilicon.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
X-Mailer: git-send-email 2.25.1
Cc: <thomas@monjalon.net>, <stephen@networkplumber.org>, 
 <qianr@yunsilicon.com>, <nana@yunsilicon.com>, <zhangxx@yunsilicon.com>, 
 <xudw@yunsilicon.com>, <jacky@yunsilicon.com>, <weihg@yunsilicon.com>, 
 <zhenghy@yunsilicon.com>
Date: Fri, 29 Aug 2025 16:24:19 +0800
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn
 with ESMTPS; Fri, 29 Aug 2025 16:24:19 +0800
Subject: [PATCH 06/14] net/xsc: add link status event support
From: "Renyong Wan" <wanry@yunsilicon.com>
Message-Id: <20250829082418.24369-7-wanry@yunsilicon.com>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+268b163b4+72205a+dpdk.org+wanry@yunsilicon.com>
X-Original-From: Renyong Wan <wanry@yunsilicon.com>
To: <dev@dpdk.org>
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

Add VFIO MSI-X interrupt support and handle Link Status Change events.

Signed-off-by: Rong Qian <qianr@yunsilicon.com>
Signed-off-by: Renyong Wan <wanry@yunsilicon.com>
---
 doc/guides/nics/features/xsc.ini |   1 +
 drivers/net/xsc/xsc_cmd.h        |  29 ++++
 drivers/net/xsc/xsc_defs.h       |   2 +
 drivers/net/xsc/xsc_dev.c        |  27 ++++
 drivers/net/xsc/xsc_dev.h        |  18 +++
 drivers/net/xsc/xsc_ethdev.c     |  30 ++++
 drivers/net/xsc/xsc_vfio.c       | 247 +++++++++++++++++++++++++++++++
 7 files changed, 354 insertions(+)

diff --git a/doc/guides/nics/features/xsc.ini b/doc/guides/nics/features/xsc.ini
index 0d98296973..d4498ed0a0 100644
--- a/doc/guides/nics/features/xsc.ini
+++ b/doc/guides/nics/features/xsc.ini
@@ -5,6 +5,7 @@
 ;
 [Features]
 Link status          = Y
+Link status event    = Y
 MTU update           = Y
 TSO                  = Y
 Promiscuous mode     = Y
diff --git a/drivers/net/xsc/xsc_cmd.h b/drivers/net/xsc/xsc_cmd.h
index 207f4456d5..777de1ce4a 100644
--- a/drivers/net/xsc/xsc_cmd.h
+++ b/drivers/net/xsc/xsc_cmd.h
@@ -26,7 +26,9 @@ enum xsc_cmd_opcode {
 	XSC_CMD_OP_ACCESS_REG			= 0x805,
 	XSC_CMD_OP_MODIFY_NIC_HCA		= 0x812,
 	XSC_CMD_OP_MODIFY_RAW_QP		= 0x81f,
+	XSC_CMD_OP_QUERY_EVENT_TYPE		= 0x831,
 	XSC_CMD_OP_QUERY_LINK_INFO		= 0x832,
+	XSC_CMD_OP_ENABLE_MSIX			= 0x850,
 	XSC_CMD_OP_EXEC_NP			= 0x900,
 	XSC_CMD_OP_SET_MTU			= 0x1100,
 	XSC_CMD_OP_QUERY_ETH_MAC		= 0X1101,
@@ -444,4 +446,31 @@ struct xsc_cmd_modify_linkinfo_mbox_out {
 	uint32_t status;
 };
 
+struct xsc_cmd_event_resp {
+	uint8_t event_type;
+};
+
+struct xsc_cmd_event_query_type_mbox_in {
+	struct xsc_cmd_inbox_hdr hdr;
+	uint8_t rsvd[2];
+};
+
+struct xsc_cmd_event_query_type_mbox_out {
+	struct xsc_cmd_outbox_hdr hdr;
+	struct xsc_cmd_event_resp ctx;
+};
+
+struct xsc_cmd_msix_table_info_mbox_in {
+	struct xsc_cmd_inbox_hdr hdr;
+	uint16_t index;
+	uint8_t rsvd[6];
+};
+
+struct xsc_cmd_msix_table_info_mbox_out {
+	struct xsc_cmd_outbox_hdr hdr;
+	uint32_t addr_lo;
+	uint32_t addr_hi;
+	uint32_t data;
+};
+
 #endif /* _XSC_CMD_H_ */
diff --git a/drivers/net/xsc/xsc_defs.h b/drivers/net/xsc/xsc_defs.h
index 5b4e5b80d2..4b95a0521d 100644
--- a/drivers/net/xsc/xsc_defs.h
+++ b/drivers/net/xsc/xsc_defs.h
@@ -51,6 +51,8 @@
 #define XSC_VF_TX_DB_ADDR		0x8d0
 #define XSC_VF_CQ_DB_ADDR		0x8c4
 
+#define XSC_HIF_CMDQM_VECTOR_ID_MEM_ADDR	0x1034000
+
 enum xsc_nic_mode {
 	XSC_NIC_MODE_LEGACY,
 	XSC_NIC_MODE_SWITCHDEV,
diff --git a/drivers/net/xsc/xsc_dev.c b/drivers/net/xsc/xsc_dev.c
index 28581459b9..815b67d7da 100644
--- a/drivers/net/xsc/xsc_dev.c
+++ b/drivers/net/xsc/xsc_dev.c
@@ -587,3 +587,30 @@ xsc_dev_query_module_eeprom(struct xsc_dev *xdev, uint16_t offset,
 
 	return xsc_dev_query_mcia(xdev, &query, data);
 }
+
+int
+xsc_dev_intr_event_get(struct xsc_dev *xdev)
+{
+	if (xdev->dev_ops->intr_event_get == NULL)
+		return -ENOTSUP;
+
+	return xdev->dev_ops->intr_event_get(xdev);
+}
+
+int
+xsc_dev_intr_handler_install(struct xsc_dev *xdev, rte_intr_callback_fn cb, void *cb_arg)
+{
+	if (xdev->dev_ops->intr_handler_install == NULL)
+		return -ENOTSUP;
+
+	return xdev->dev_ops->intr_handler_install(xdev, cb, cb_arg);
+}
+
+int
+xsc_dev_intr_handler_uninstall(struct xsc_dev *xdev)
+{
+	if (xdev->dev_ops->intr_handler_uninstall == NULL)
+		return -ENOTSUP;
+
+	return xdev->dev_ops->intr_handler_uninstall(xdev);
+}
diff --git a/drivers/net/xsc/xsc_dev.h b/drivers/net/xsc/xsc_dev.h
index e543b6892d..86a0eee22e 100644
--- a/drivers/net/xsc/xsc_dev.h
+++ b/drivers/net/xsc/xsc_dev.h
@@ -72,6 +72,13 @@ enum xsc_module_id {
 	XSC_MODULE_ID_QSFP_PLUS_CMIS	= 0x1E,
 };
 
+enum xsc_intr_event_type {
+	XSC_EVENT_TYPE_NONE			= 0x0,
+	XSC_EVENT_TYPE_CHANGE_LINK		= 0x0001,
+	XSC_EVENT_TYPE_TEMP_WARN		= 0x0002,
+	XSC_EVENT_TYPE_OVER_TEMP_PROTECTION	= 0x0004,
+};
+
 struct xsc_hwinfo {
 	uint32_t pcie_no; /* pcie number , 0 or 1 */
 	uint32_t func_id; /* pf glb func id */
@@ -93,6 +100,8 @@ struct xsc_hwinfo {
 	uint16_t pcie1_pf_funcid_top;
 	uint16_t lag_port_start;
 	uint16_t raw_tpe_qp_num;
+	uint16_t msix_base;
+	uint16_t msix_num;
 	uint8_t send_seg_num;
 	uint8_t recv_seg_num;
 	uint8_t valid; /* 1: current phy info is valid, 0 : invalid */
@@ -160,6 +169,8 @@ struct xsc_dev {
 	void *jumbo_buffer_va;
 	uint64_t bar_len;
 	int ctrl_fd;
+	rte_intr_callback_fn intr_cb;
+	void *intr_cb_arg;
 };
 
 struct xsc_module_eeprom_query_params {
@@ -215,6 +226,10 @@ struct xsc_dev_ops {
 			    struct xsc_tx_qp_info *qp_info);
 	int (*mailbox_exec)(struct xsc_dev *xdev, void *data_in,
 			    int in_len, void *data_out, int out_len);
+	int (*intr_event_get)(struct xsc_dev *xdev);
+	int (*intr_handler_install)(struct xsc_dev *xdev, rte_intr_callback_fn cb,
+				    void *cb_arg);
+	int (*intr_handler_uninstall)(struct xsc_dev *xdev);
 };
 
 int xsc_dev_mailbox_exec(struct xsc_dev *xdev, void *data_in,
@@ -244,5 +259,8 @@ int xsc_dev_get_mac(struct xsc_dev *xdev, uint8_t *mac);
 int xsc_dev_fw_version_get(struct xsc_dev *xdev, char *fw_version, size_t fw_size);
 int xsc_dev_query_module_eeprom(struct xsc_dev *xdev, uint16_t offset,
 				uint16_t size, uint8_t *data);
+int xsc_dev_intr_event_get(struct xsc_dev *xdev);
+int xsc_dev_intr_handler_install(struct xsc_dev *xdev, rte_intr_callback_fn cb, void *cb_arg);
+int xsc_dev_intr_handler_uninstall(struct xsc_dev *xdev);
 
 #endif /* _XSC_DEV_H_ */
diff --git a/drivers/net/xsc/xsc_ethdev.c b/drivers/net/xsc/xsc_ethdev.c
index 3574da91eb..0884894a9b 100644
--- a/drivers/net/xsc/xsc_ethdev.c
+++ b/drivers/net/xsc/xsc_ethdev.c
@@ -4,6 +4,7 @@
 
 #include <rte_dev_info.h>
 #include <ethdev_pci.h>
+#include <rte_interrupts.h>
 
 #include "xsc_log.h"
 #include "xsc_defs.h"
@@ -378,6 +379,8 @@ xsc_ethdev_close(struct rte_eth_dev *dev)
 	xsc_rxq_stop(dev);
 
 	rte_free(priv->rss_conf.rss_key);
+	if (!xsc_dev_is_vf(priv->xdev))
+		xsc_dev_intr_handler_uninstall(priv->xdev);
 	xsc_dev_close(priv->xdev, priv->representor_id);
 	dev->data->mac_addrs = NULL;
 	return 0;
@@ -1007,6 +1010,25 @@ xsc_ethdev_init_representors(struct rte_eth_dev *eth_dev)
 	return ret;
 }
 
+static void
+xsc_ethdev_intr_handler(void *param)
+{
+	struct rte_eth_dev *eth_dev = param;
+	struct xsc_ethdev_priv *priv = TO_XSC_ETHDEV_PRIV(eth_dev);
+	int event_type;
+
+	event_type = xsc_dev_intr_event_get(priv->xdev);
+	switch (event_type) {
+	case XSC_EVENT_TYPE_CHANGE_LINK:
+		PMD_DRV_LOG(DEBUG, "Get intr event type=%04x", event_type);
+		xsc_ethdev_link_update(eth_dev, 0);
+		rte_eth_dev_callback_process(eth_dev, RTE_ETH_EVENT_INTR_LSC, NULL);
+		break;
+	default:
+		break;
+	}
+}
+
 static int
 xsc_ethdev_init(struct rte_eth_dev *eth_dev)
 {
@@ -1031,6 +1053,14 @@ xsc_ethdev_init(struct rte_eth_dev *eth_dev)
 		goto uninit_xsc_dev;
 	}
 
+	if (!xsc_dev_is_vf(priv->xdev)) {
+		ret = xsc_dev_intr_handler_install(priv->xdev, xsc_ethdev_intr_handler, eth_dev);
+		if (ret != 0) {
+			PMD_DRV_LOG(ERR, "Failed to install intr handler");
+			goto uninit_xsc_dev;
+		}
+	}
+
 	return 0;
 
 uninit_xsc_dev:
diff --git a/drivers/net/xsc/xsc_vfio.c b/drivers/net/xsc/xsc_vfio.c
index cc3660e259..34b2a4c58b 100644
--- a/drivers/net/xsc/xsc_vfio.c
+++ b/drivers/net/xsc/xsc_vfio.c
@@ -6,11 +6,15 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
+#include <linux/vfio.h>
+#include <sys/eventfd.h>
+#include <sys/ioctl.h>
 
 #include <rte_pci.h>
 #include <ethdev_pci.h>
 #include <rte_bus_pci.h>
 #include <rte_bitops.h>
+#include <rte_interrupts.h>
 
 #include "xsc_defs.h"
 #include "xsc_vfio_mbox.h"
@@ -22,10 +26,21 @@
 #define XSC_FEATURE_PCT_EXP_MASK	RTE_BIT32(19)
 #define XSC_HOST_PCIE_NO_DEFAULT	0
 #define XSC_SOC_PCIE_NO_DEFAULT		1
+#define XSC_MSIX_CPU_NUM_DEFAULT	2
 
 #define XSC_SW2HW_MTU(mtu)		((mtu) + 14 + 4)
 #define XSC_SW2HW_RX_PKT_LEN(mtu)	((mtu) + 14 + 256)
 
+#define XSC_MAX_INTR_VEC_ID		RTE_MAX_RXTX_INTR_VEC_ID
+#define XSC_MSIX_IRQ_SET_BUF_LEN (sizeof(struct vfio_irq_set) + \
+				  sizeof(int) * (XSC_MAX_INTR_VEC_ID))
+
+enum xsc_vector {
+	XSC_VEC_CMD		= 0,
+	XSC_VEC_CMD_EVENT	= 1,
+	XSC_EQ_VEC_COMP_BASE,
+};
+
 enum xsc_cq_type {
 	XSC_CQ_TYPE_NORMAL = 0,
 	XSC_CQ_TYPE_VIRTIO = 1,
@@ -133,6 +148,7 @@ xsc_vfio_hwinfo_init(struct xsc_dev *xdev)
 	memset(in, 0, cmd_len);
 	in->hdr.opcode = rte_cpu_to_be_16(XSC_CMD_OP_QUERY_HCA_CAP);
 	in->hdr.ver = rte_cpu_to_be_16(XSC_CMD_QUERY_HCA_CAP_V1);
+	in->cpu_num =  rte_cpu_to_be_16(XSC_MSIX_CPU_NUM_DEFAULT);
 	out = cmd_buf;
 
 	ret = xsc_vfio_mbox_exec(xdev, in, in_len, out, out_len);
@@ -171,6 +187,8 @@ xsc_vfio_hwinfo_init(struct xsc_dev *xdev)
 	xdev->hwinfo.chip_version = rte_be_to_cpu_32(hca_cap->chip_ver_l);
 	xdev->hwinfo.hca_core_clock = rte_be_to_cpu_32(hca_cap->hca_core_clock);
 	xdev->hwinfo.mac_bit = hca_cap->mac_bit;
+	xdev->hwinfo.msix_base = rte_be_to_cpu_16(hca_cap->msix_base);
+	xdev->hwinfo.msix_num = rte_be_to_cpu_16(hca_cap->msix_num);
 	xsc_vfio_pcie_no_init(&xdev->hwinfo);
 	xsc_vfio_fw_version_init(xdev->hwinfo.fw_ver, &hca_cap->fw_ver);
 
@@ -858,6 +876,232 @@ xsc_vfio_dev_init(struct xsc_dev *xdev)
 	return -1;
 }
 
+static int
+xsc_vfio_irq_info_get(struct rte_intr_handle *intr_handle)
+{
+	struct vfio_irq_info irq = { .argsz = sizeof(irq) };
+	int rc, vfio_dev_fd;
+
+	irq.index = VFIO_PCI_MSIX_IRQ_INDEX;
+
+	vfio_dev_fd = rte_intr_dev_fd_get(intr_handle);
+	rc = ioctl(vfio_dev_fd, VFIO_DEVICE_GET_IRQ_INFO, &irq);
+	if (rc < 0) {
+		PMD_DRV_LOG(ERR, "Failed to get IRQ info rc=%d errno=%d", rc, errno);
+		return rc;
+	}
+
+	PMD_DRV_LOG(INFO, "Flags=0x%x index=0x%x count=0x%x max_intr_vec_id=0x%x",
+		    irq.flags, irq.index, irq.count, XSC_MAX_INTR_VEC_ID);
+
+	if (rte_intr_max_intr_set(intr_handle, irq.count))
+		return -1;
+
+	return 0;
+}
+
+static int
+xsc_vfio_irq_init(struct rte_intr_handle *intr_handle)
+{
+	char irq_set_buf[XSC_MSIX_IRQ_SET_BUF_LEN];
+	struct vfio_irq_set *irq_set;
+	int len, rc, vfio_dev_fd;
+	int32_t *fd_ptr;
+	uint32_t i;
+
+	if (rte_intr_max_intr_get(intr_handle) > XSC_MAX_INTR_VEC_ID) {
+		PMD_DRV_LOG(ERR, "Max_intr=%d greater than XSC_MAX_INTR_VEC_ID=%d",
+			    rte_intr_max_intr_get(intr_handle),
+			    XSC_MAX_INTR_VEC_ID);
+		return -ERANGE;
+	}
+
+	len = sizeof(struct vfio_irq_set) +
+	      sizeof(int32_t) * rte_intr_max_intr_get(intr_handle);
+
+	irq_set = (struct vfio_irq_set *)irq_set_buf;
+	irq_set->argsz = len;
+	irq_set->start = 0;
+	irq_set->count = 10;
+	irq_set->flags = VFIO_IRQ_SET_DATA_EVENTFD | VFIO_IRQ_SET_ACTION_TRIGGER;
+	irq_set->index = VFIO_PCI_MSIX_IRQ_INDEX;
+
+	fd_ptr = (int32_t *)&irq_set->data[0];
+	for (i = 0; i < irq_set->count; i++)
+		fd_ptr[i] = -1;
+
+	vfio_dev_fd = rte_intr_dev_fd_get(intr_handle);
+	rc = ioctl(vfio_dev_fd, VFIO_DEVICE_SET_IRQS, irq_set);
+	if (rc)
+		PMD_DRV_LOG(ERR, "Failed to set irqs vector rc=%d", rc);
+
+	return rc;
+}
+
+static int
+xsc_vfio_irq_config(struct rte_intr_handle *intr_handle, unsigned int vec)
+{
+	char irq_set_buf[XSC_MSIX_IRQ_SET_BUF_LEN];
+	struct vfio_irq_set *irq_set;
+	int len, rc, vfio_dev_fd;
+	int32_t *fd_ptr;
+
+	if (vec > (uint32_t)rte_intr_max_intr_get(intr_handle)) {
+		PMD_DRV_LOG(INFO, "Vector=%d greater than max_intr=%d", vec,
+			    rte_intr_max_intr_get(intr_handle));
+		return -EINVAL;
+	}
+
+	len = sizeof(struct vfio_irq_set) + sizeof(int32_t);
+
+	irq_set = (struct vfio_irq_set *)irq_set_buf;
+	irq_set->argsz = len;
+
+	irq_set->start = vec;
+	irq_set->count = 1;
+	irq_set->flags = VFIO_IRQ_SET_DATA_EVENTFD | VFIO_IRQ_SET_ACTION_TRIGGER;
+	irq_set->index = VFIO_PCI_MSIX_IRQ_INDEX;
+
+	/* Use vec fd to set interrupt vectors */
+	fd_ptr = (int32_t *)&irq_set->data[0];
+	fd_ptr[0] = rte_intr_efds_index_get(intr_handle, vec);
+
+	vfio_dev_fd = rte_intr_dev_fd_get(intr_handle);
+	rc = ioctl(vfio_dev_fd, VFIO_DEVICE_SET_IRQS, irq_set);
+	if (rc)
+		PMD_DRV_LOG(INFO, "Failed to set_irqs vector=0x%x rc=%d", vec, rc);
+
+	return rc;
+}
+
+static int
+xsc_vfio_irq_register(struct rte_intr_handle *intr_handle,
+		  rte_intr_callback_fn cb, void *data, unsigned int vec)
+{
+	struct rte_intr_handle *tmp_handle;
+	uint32_t nb_efd, tmp_nb_efd;
+	int rc, fd;
+
+	if (rte_intr_max_intr_get(intr_handle) == 0) {
+		xsc_vfio_irq_info_get(intr_handle);
+		xsc_vfio_irq_init(intr_handle);
+	}
+
+	if (vec > (uint32_t)rte_intr_max_intr_get(intr_handle)) {
+		PMD_DRV_LOG(INFO, "Vector=%d greater than max_intr=%d", vec,
+			    rte_intr_max_intr_get(intr_handle));
+		return -EINVAL;
+	}
+
+	tmp_handle = intr_handle;
+	/* Create new eventfd for interrupt vector */
+	fd = eventfd(0, EFD_NONBLOCK | EFD_CLOEXEC);
+	if (fd == -1)
+		return -ENODEV;
+
+	if (rte_intr_fd_set(tmp_handle, fd))
+		return errno;
+
+	/* Register vector interrupt callback */
+	rc = rte_intr_callback_register(tmp_handle, cb, data);
+	if (rc) {
+		PMD_DRV_LOG(INFO, "Failed to register vector:0x%x irq callback.", vec);
+		return rc;
+	}
+
+	rte_intr_efds_index_set(intr_handle, vec, fd);
+	nb_efd = (vec > (uint32_t)rte_intr_nb_efd_get(intr_handle)) ?
+		 vec : (uint32_t)rte_intr_nb_efd_get(intr_handle);
+	rte_intr_nb_efd_set(intr_handle, nb_efd);
+
+	tmp_nb_efd = rte_intr_nb_efd_get(intr_handle) + 1;
+	if (tmp_nb_efd > (uint32_t)rte_intr_max_intr_get(intr_handle))
+		rte_intr_max_intr_set(intr_handle, tmp_nb_efd);
+
+	PMD_DRV_LOG(INFO, "Enable vector:0x%x for vfio (efds: %d, max:%d)",
+		    vec,
+		    rte_intr_nb_efd_get(intr_handle),
+		    rte_intr_max_intr_get(intr_handle));
+
+	/* Enable MSIX vectors to VFIO */
+	return xsc_vfio_irq_config(intr_handle, vec);
+}
+
+static int
+xsc_vfio_msix_enable(struct xsc_dev *xdev)
+{
+	struct xsc_cmd_msix_table_info_mbox_in in = { };
+	struct xsc_cmd_msix_table_info_mbox_out out = { };
+	int ret;
+
+	in.hdr.opcode = rte_cpu_to_be_16(XSC_CMD_OP_ENABLE_MSIX);
+	ret = xsc_vfio_mbox_exec(xdev, &in, sizeof(in), &out, sizeof(out));
+	if (ret != 0 || out.hdr.status != 0) {
+		PMD_DRV_LOG(ERR, "Failed to enable msix, ret=%d, stats=%d",
+			    ret, out.hdr.status);
+		return ret;
+	}
+
+	rte_write32(xdev->hwinfo.msix_base,
+		    (uint8_t *)xdev->bar_addr + XSC_HIF_CMDQM_VECTOR_ID_MEM_ADDR);
+
+	return 0;
+}
+
+static int
+xsc_vfio_event_get(struct xsc_dev *xdev)
+{
+	int ret;
+	struct xsc_cmd_event_query_type_mbox_in in = { };
+	struct xsc_cmd_event_query_type_mbox_out out = { };
+
+	in.hdr.opcode = rte_cpu_to_be_16(XSC_CMD_OP_QUERY_EVENT_TYPE);
+	ret = xsc_vfio_mbox_exec(xdev, &in, sizeof(in), &out, sizeof(out));
+	if (ret != 0 || out.hdr.status != 0) {
+		PMD_DRV_LOG(ERR, "Failed to query event type, ret=%d, stats=%d",
+			    ret, out.hdr.status);
+		return -1;
+	}
+
+	return out.ctx.event_type;
+}
+
+static int
+xsc_vfio_intr_handler_install(struct xsc_dev *xdev, rte_intr_callback_fn cb, void *cb_arg)
+{
+	int ret;
+	struct rte_intr_handle *intr_handle = xdev->pci_dev->intr_handle;
+
+	ret = xsc_vfio_irq_register(intr_handle, cb, cb_arg, XSC_VEC_CMD_EVENT);
+	if (ret != 0) {
+		PMD_DRV_LOG(ERR, "Failed to register vfio irq, ret=%d", ret);
+		return ret;
+	}
+
+	xdev->intr_cb = cb;
+	xdev->intr_cb_arg = cb_arg;
+
+	ret = xsc_vfio_msix_enable(xdev);
+	if (ret != 0) {
+		PMD_DRV_LOG(ERR, "Failed to enable vfio msix, ret=%d", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int
+xsc_vfio_intr_handler_uninstall(struct xsc_dev *xdev)
+{
+	if (rte_intr_fd_get(xdev->pci_dev->intr_handle) >= 0)
+		rte_intr_callback_unregister(xdev->pci_dev->intr_handle,
+					     xdev->intr_cb, xdev->intr_cb_arg);
+
+	rte_intr_instance_free(xdev->intr_handle);
+
+	return 0;
+}
+
 static struct xsc_dev_ops *xsc_vfio_ops = &(struct xsc_dev_ops) {
 	.kdrv = RTE_PCI_KDRV_VFIO,
 	.dev_init = xsc_vfio_dev_init,
@@ -874,6 +1118,9 @@ static struct xsc_dev_ops *xsc_vfio_ops = &(struct xsc_dev_ops) {
 	.tx_cq_create = xsc_vfio_tx_cq_create,
 	.tx_qp_create = xsc_vfio_tx_qp_create,
 	.mailbox_exec = xsc_vfio_mbox_exec,
+	.intr_event_get = xsc_vfio_event_get,
+	.intr_handler_install = xsc_vfio_intr_handler_install,
+	.intr_handler_uninstall = xsc_vfio_intr_handler_uninstall,
 };
 
 RTE_INIT(xsc_vfio_ops_reg)
-- 
2.25.1
