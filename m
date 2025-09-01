Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49659CA1002
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Sep 2025 11:13:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B766406BB;
	Mon,  1 Sep 2025 13:12:22 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.3])
 by mails.dpdk.org (Postfix) with ESMTP id 0B3074066D
 for <dev@dpdk.org>; Mon,  1 Sep 2025 13:12:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=9PkBeB2g7zcWsBEBAQ79qXsbQJMOk7qUyqU2pc7Gw7o=;
 b=UAasKMztm77d7BE8rYzdqmLIs+jkexAWSOm9aitMhEob6lrYrfV8upVoOo492o
 mdf8r1mH+adi9eITe2Yu/hDC41l5YSlrDrWwatcRmiuUs6NtKOa3uJd5sblHW15q
 xEXW8krodDqMpmtXNdpED7JzVhuIfLRBRG7gN1PDlK7eA=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp1 (Coremail) with SMTP id Ac8vCgDnT6lXf7Vo9Y1rAQ--.56050S12;
 Mon, 01 Sep 2025 19:12:15 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Cc: Yi Chen <chenyi221@huawei.com>, Xin Wang <wangxin679@h-partners.com>,
 Feifei Wang <wangfeifei40@huawei.com>
Subject: [V7 08/17] net/hinic3: add module about hardware operation
Date: Mon,  1 Sep 2025 19:10:41 +0800
Message-ID: <20250901111102.9280-9-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20250901111102.9280-1-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250901111102.9280-1-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Ac8vCgDnT6lXf7Vo9Y1rAQ--.56050S12
X-Coremail-Antispam: 1Uf129KBjvAXoWDXFWxXryUtr4DGF1xCFW3KFg_yoW7XrWDto
 WfJr43Kr10qr1xCw4j9w10kFsxXryq93Z5AwsxKFZrX3WxCFy8KFy3Jw4fta40vrWYkFnr
 uFWxt3yrtwnrKwn3n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUxzBTUUUUU
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiJge7Cmi1UtK7MgAAsE
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

From: Yi Chen <chenyi221@huawei.com>

Add code and data structure for hardware operation, including
configuration, query, initialization and release.

Signed-off-by: Yi Chen <chenyi221@huawei.com>
Signed-off-by: Xin Wang <wangxin679@h-partners.com>
Reviewed-by: Feifei Wang <wangfeifei40@huawei.com>
---
 drivers/net/hinic3/base/hinic3_hw_cfg.c  | 193 ++++++++
 drivers/net/hinic3/base/hinic3_hw_cfg.h  | 117 +++++
 drivers/net/hinic3/base/hinic3_hw_comm.c | 448 ++++++++++++++++++
 drivers/net/hinic3/base/hinic3_hw_comm.h | 365 +++++++++++++++
 drivers/net/hinic3/base/hinic3_hwdev.c   | 557 +++++++++++++++++++++++
 drivers/net/hinic3/base/hinic3_hwdev.h   | 180 ++++++++
 drivers/net/hinic3/base/meson.build      |   3 +
 7 files changed, 1863 insertions(+)
 create mode 100644 drivers/net/hinic3/base/hinic3_hw_cfg.c
 create mode 100644 drivers/net/hinic3/base/hinic3_hw_cfg.h
 create mode 100644 drivers/net/hinic3/base/hinic3_hw_comm.c
 create mode 100644 drivers/net/hinic3/base/hinic3_hw_comm.h
 create mode 100644 drivers/net/hinic3/base/hinic3_hwdev.c
 create mode 100644 drivers/net/hinic3/base/hinic3_hwdev.h

diff --git a/drivers/net/hinic3/base/hinic3_hw_cfg.c b/drivers/net/hinic3/base/hinic3_hw_cfg.c
new file mode 100644
index 0000000000..2687dfd389
--- /dev/null
+++ b/drivers/net/hinic3/base/hinic3_hw_cfg.c
@@ -0,0 +1,193 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd
+ */
+
+#include "hinic3_compat.h"
+#include "hinic3_mbox.h"
+#include "hinic3_mgmt.h"
+#include "hinic3_hw_cfg.h"
+#include "hinic3_hwif.h"
+
+static void
+parse_pub_res_cap(struct service_cap *cap,
+		  struct hinic3_cfg_cmd_dev_cap *dev_cap, enum func_type type)
+{
+	cap->host_id = dev_cap->host_id;
+	cap->ep_id = dev_cap->ep_id;
+	cap->er_id = dev_cap->er_id;
+	cap->port_id = dev_cap->port_id;
+
+	cap->svc_type = dev_cap->svc_cap_en;
+	cap->chip_svc_type = cap->svc_type;
+
+	cap->cos_valid_bitmap = dev_cap->valid_cos_bitmap;
+	cap->flexq_en = dev_cap->flexq_en;
+
+	cap->host_total_function = dev_cap->host_total_func;
+	cap->max_vf = 0;
+	if (type == TYPE_PF || type == TYPE_PPF) {
+		cap->max_vf = dev_cap->max_vf;
+		cap->pf_num = dev_cap->host_pf_num;
+		cap->pf_id_start = dev_cap->pf_id_start;
+		cap->vf_num = dev_cap->host_vf_num;
+		cap->vf_id_start = dev_cap->vf_id_start;
+	}
+
+	PMD_DRV_LOG(INFO, "Get public resource capability: ");
+	PMD_DRV_LOG(INFO,
+		    "host_id: 0x%x, ep_id: 0x%x, er_id: 0x%x, port_id: 0x%x",
+		    cap->host_id, cap->ep_id, cap->er_id, cap->port_id);
+	PMD_DRV_LOG(INFO, "host_total_function: 0x%x, max_vf: 0x%x",
+		    cap->host_total_function, cap->max_vf);
+	PMD_DRV_LOG(INFO,
+		    "host_pf_num: 0x%x, pf_id_start: 0x%x, host_vf_num: 0x%x, "
+		    "vf_id_start: 0x%x",
+		    cap->pf_num, cap->pf_id_start, cap->vf_num,
+		    cap->vf_id_start);
+}
+
+static void
+parse_l2nic_res_cap(struct service_cap *cap,
+		    struct hinic3_cfg_cmd_dev_cap *dev_cap)
+{
+	struct nic_service_cap *nic_cap = &cap->nic_cap;
+
+	nic_cap->max_sqs = dev_cap->nic_max_sq_id + 1;
+	nic_cap->max_rqs = dev_cap->nic_max_rq_id + 1;
+
+	PMD_DRV_LOG(INFO,
+		    "L2nic resource capbility, "
+		    "max_sqs: 0x%x, max_rqs: 0x%x",
+		    nic_cap->max_sqs, nic_cap->max_rqs);
+}
+
+static void
+parse_dev_cap(struct hinic3_hwdev *dev, struct hinic3_cfg_cmd_dev_cap *dev_cap,
+	      enum func_type type)
+{
+	struct service_cap *cap = &dev->cfg_mgmt->svc_cap;
+
+	parse_pub_res_cap(cap, dev_cap, type);
+
+	if (IS_NIC_TYPE(dev))
+		parse_l2nic_res_cap(cap, dev_cap);
+}
+
+static int
+get_cap_from_fw(struct hinic3_hwdev *hwdev, enum func_type type)
+{
+	struct hinic3_cfg_cmd_dev_cap dev_cap;
+	uint16_t out_len = sizeof(dev_cap);
+	int err;
+
+	memset(&dev_cap, 0, sizeof(dev_cap));
+	dev_cap.func_id = hinic3_global_func_id(hwdev);
+	err = hinic3_msg_to_mgmt_sync(hwdev, HINIC3_MOD_CFGM,
+				      HINIC3_CFG_CMD_GET_DEV_CAP, &dev_cap,
+				      sizeof(dev_cap), &dev_cap, &out_len, 0);
+	if (err || dev_cap.status || !out_len) {
+		PMD_DRV_LOG(ERR,
+			    "Get capability from FW failed, "
+			    "err: %d, status: 0x%x, out size: 0x%x",
+			    err, dev_cap.status, out_len);
+		return -EFAULT;
+	}
+
+	parse_dev_cap(hwdev, &dev_cap, type);
+	return 0;
+}
+
+static int
+get_dev_cap(struct hinic3_hwdev *hwdev)
+{
+	enum func_type type = HINIC3_FUNC_TYPE(hwdev);
+
+	switch (type) {
+	case TYPE_PF:
+	case TYPE_PPF:
+	case TYPE_VF:
+		if (get_cap_from_fw(hwdev, type) != 0)
+			return -EFAULT;
+		break;
+	default:
+		PMD_DRV_LOG(ERR, "Unsupported PCIe function type: %d", type);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int
+cfg_mbx_vf_proc_msg(struct hinic3_hwdev *hwdev, __rte_unused void *pri_handle,
+				struct hinic3_handler_info *handler_info)
+{
+	if (!hwdev)
+		return -EINVAL;
+
+	PMD_DRV_LOG(WARNING, "Unsupported cfg mbox vf event %d to process", handler_info->cmd);
+
+	return 0;
+}
+
+int
+hinic3_init_cfg_mgmt(struct hinic3_hwdev *hwdev)
+{
+	struct cfg_mgmt_info *cfg_mgmt = NULL;
+
+	cfg_mgmt = rte_zmalloc("cfg_mgmt", sizeof(*cfg_mgmt),
+			       HINIC3_MEM_ALLOC_ALIGN_MIN);
+	if (!cfg_mgmt)
+		return -ENOMEM;
+
+	memset(cfg_mgmt, 0, sizeof(struct cfg_mgmt_info));
+	hwdev->cfg_mgmt = cfg_mgmt;
+	cfg_mgmt->hwdev = hwdev;
+
+	return 0;
+}
+
+int
+hinic3_init_capability(struct hinic3_hwdev *hwdev)
+{
+	return get_dev_cap(hwdev);
+}
+
+void
+hinic3_deinit_cfg_mgmt(struct hinic3_hwdev *hwdev)
+{
+	rte_free(hwdev->cfg_mgmt);
+	hwdev->cfg_mgmt = NULL;
+}
+
+uint16_t
+hinic3_func_max_sqs(struct hinic3_hwdev *hwdev)
+{
+	if (!hwdev) {
+		PMD_DRV_LOG(INFO, "Hwdev is NULL for getting max_sqs");
+		return 0;
+	}
+
+	return hwdev->cfg_mgmt->svc_cap.nic_cap.max_sqs;
+}
+
+uint16_t
+hinic3_func_max_rqs(struct hinic3_hwdev *hwdev)
+{
+	if (!hwdev) {
+		PMD_DRV_LOG(INFO, "Hwdev is NULL for getting max_rqs");
+		return 0;
+	}
+
+	return hwdev->cfg_mgmt->svc_cap.nic_cap.max_rqs;
+}
+
+uint8_t
+hinic3_physical_port_id(struct hinic3_hwdev *hwdev)
+{
+	if (!hwdev) {
+		PMD_DRV_LOG(INFO, "Hwdev is NULL for getting physical port id");
+		return 0;
+	}
+
+	return hwdev->cfg_mgmt->svc_cap.port_id;
+}
diff --git a/drivers/net/hinic3/base/hinic3_hw_cfg.h b/drivers/net/hinic3/base/hinic3_hw_cfg.h
new file mode 100644
index 0000000000..e14c1c32fa
--- /dev/null
+++ b/drivers/net/hinic3/base/hinic3_hw_cfg.h
@@ -0,0 +1,117 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd
+ */
+
+#ifndef _HINIC3_HW_CFG_H_
+#define _HINIC3_HW_CFG_H_
+
+#include "hinic3_hwdev.h"
+#define CFG_MAX_CMD_TIMEOUT 30000 /**< ms */
+
+/* Number of PFs and VFs. */
+#define HOST_PF_NUM	   4
+#define HOST_VF_NUM	   0
+#define HOST_OQID_MASK_VAL 2
+
+#define L2NIC_SQ_DEPTH 4096
+#define L2NIC_RQ_DEPTH 4096
+
+enum intr_type { INTR_TYPE_MSIX, INTR_TYPE_MSI, INTR_TYPE_INT, INTR_TYPE_NONE };
+
+/* Service type relates define. */
+enum cfg_svc_type_en { CFG_SVC_NIC_BIT0 = 1 };
+
+struct nic_service_cap {
+	uint16_t max_sqs;
+	uint16_t max_rqs;
+};
+
+/* Device capability. */
+struct service_cap {
+	enum cfg_svc_type_en svc_type;	    /**< User input service type. */
+	enum cfg_svc_type_en chip_svc_type; /**< HW supported service type. */
+
+	uint8_t host_id;
+	uint8_t ep_id;
+	uint8_t er_id;   /**< PF/VF's ER. */
+	uint8_t port_id; /**< PF/VF's physical port. */
+
+	uint16_t host_total_function;
+	uint8_t pf_num;
+	uint8_t pf_id_start;
+	uint16_t vf_num; /**< Max numbers of vf in current host. */
+	uint16_t vf_id_start;
+
+	uint8_t flexq_en;
+	uint8_t cos_valid_bitmap;
+	uint16_t max_vf; /**< Max VF number that PF supported. */
+
+	struct nic_service_cap nic_cap; /**< NIC capability. */
+};
+
+struct cfg_mgmt_info {
+	void *hwdev;
+	struct service_cap svc_cap;
+};
+
+enum hinic3_cfg_cmd {
+	HINIC3_CFG_CMD_GET_DEV_CAP = 0,
+};
+
+struct hinic3_cfg_cmd_dev_cap {
+	uint8_t status;
+	uint8_t version;
+	uint8_t rsvd0[6];
+
+	uint16_t func_id;
+	uint16_t rsvd1;
+
+	/* Public resource. */
+	uint8_t host_id;
+	uint8_t ep_id;
+	uint8_t er_id;
+	uint8_t port_id;
+
+	uint16_t host_total_func;
+	uint8_t host_pf_num;
+	uint8_t pf_id_start;
+	uint16_t host_vf_num;
+	uint16_t vf_id_start;
+	uint32_t rsvd_host;
+
+	uint16_t svc_cap_en;
+	uint16_t max_vf;
+	uint8_t flexq_en;
+	uint8_t valid_cos_bitmap;
+	/* Reserved for func_valid_cos_bitmap. */
+	uint16_t rsvd_cos;
+
+	uint32_t rsvd[11];
+
+	/* l2nic */
+	uint16_t nic_max_sq_id;
+	uint16_t nic_max_rq_id;
+	uint32_t rsvd_nic[3];
+
+	uint32_t rsvd_glb[60];
+};
+
+#define IS_NIC_TYPE(dev) \
+	(((uint32_t)(dev)->cfg_mgmt->svc_cap.chip_svc_type) & CFG_SVC_NIC_BIT0)
+
+int hinic3_init_cfg_mgmt(struct hinic3_hwdev *hwdev);
+int hinic3_init_capability(struct hinic3_hwdev *hwdev);
+void hinic3_deinit_cfg_mgmt(struct hinic3_hwdev *hwdev);
+
+uint16_t hinic3_func_max_sqs(struct hinic3_hwdev *hwdev);
+uint16_t hinic3_func_max_rqs(struct hinic3_hwdev *hwdev);
+
+uint8_t hinic3_physical_port_id(struct hinic3_hwdev *hwdev);
+
+int cfg_mbx_ppf_proc_msg(struct hinic3_hwdev *hwdev, void *pri_handle,
+					struct hinic3_handler_info *handler_info);
+
+int cfg_mbx_vf_proc_msg(struct hinic3_hwdev *hwdev, void *pri_handle,
+					struct hinic3_handler_info *handler_info);
+
+#endif /* _HINIC3_HW_CFG_H_ */
diff --git a/drivers/net/hinic3/base/hinic3_hw_comm.c b/drivers/net/hinic3/base/hinic3_hw_comm.c
new file mode 100644
index 0000000000..b4096387f1
--- /dev/null
+++ b/drivers/net/hinic3/base/hinic3_hw_comm.c
@@ -0,0 +1,448 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd
+ */
+
+#include "hinic3_compat.h"
+#include "hinic3_cmd.h"
+#include "hinic3_cmdq.h"
+#include "hinic3_hw_comm.h"
+#include "hinic3_hwdev.h"
+#include "hinic3_hwif.h"
+#include "hinic3_mgmt.h"
+#include "hinic3_wq.h"
+
+/* Buffer sizes in hinic3_convert_rx_buf_size must be in ascending order. */
+const uint32_t hinic3_hw_rx_buf_size[] = {
+	HINIC3_RX_BUF_SIZE_32B,
+	HINIC3_RX_BUF_SIZE_64B,
+	HINIC3_RX_BUF_SIZE_96B,
+	HINIC3_RX_BUF_SIZE_128B,
+	HINIC3_RX_BUF_SIZE_192B,
+	HINIC3_RX_BUF_SIZE_256B,
+	HINIC3_RX_BUF_SIZE_384B,
+	HINIC3_RX_BUF_SIZE_512B,
+	HINIC3_RX_BUF_SIZE_768B,
+	HINIC3_RX_BUF_SIZE_1K,
+	HINIC3_RX_BUF_SIZE_1_5K,
+	HINIC3_RX_BUF_SIZE_2K,
+	HINIC3_RX_BUF_SIZE_3K,
+	HINIC3_RX_BUF_SIZE_4K,
+	HINIC3_RX_BUF_SIZE_8K,
+	HINIC3_RX_BUF_SIZE_16K,
+};
+
+int
+hinic3_get_interrupt_cfg(struct hinic3_hwdev *hwdev, struct interrupt_info *info)
+{
+	struct hinic3_cmd_msix_config msix_cfg;
+	uint16_t out_size = sizeof(msix_cfg);
+	int err;
+
+	if (!hwdev || !info)
+		return -EINVAL;
+
+	memset(&msix_cfg, 0, sizeof(msix_cfg));
+	msix_cfg.func_id = hinic3_global_func_id(hwdev);
+	msix_cfg.msix_index = info->msix_index;
+	msix_cfg.opcode = HINIC3_MGMT_CMD_OP_GET;
+
+	err = hinic3_msg_to_mgmt_sync(hwdev,
+		HINIC3_MOD_COMM, HINIC3_MGMT_CMD_CFG_MSIX_CTRL_REG,
+		&msix_cfg, sizeof(msix_cfg), &msix_cfg, &out_size, 0);
+	if (err || !out_size || msix_cfg.status) {
+		PMD_DRV_LOG(ERR,
+			    "Get interrupt config failed, "
+			    "err: %d, status: 0x%x, out size: 0x%x",
+			    err, msix_cfg.status, out_size);
+		return -EINVAL;
+	}
+
+	info->lli_credit_limit = msix_cfg.lli_credit_cnt;
+	info->lli_timer_cfg = msix_cfg.lli_tmier_cnt;
+	info->pending_limt = msix_cfg.pending_cnt;
+	info->coalesce_timer_cfg = msix_cfg.coalesce_timer_cnt;
+	info->resend_timer_cfg = msix_cfg.resend_timer_cnt;
+
+	return 0;
+}
+
+int
+hinic3_set_interrupt_cfg(struct hinic3_hwdev *hwdev, struct interrupt_info info)
+{
+	struct hinic3_cmd_msix_config msix_cfg;
+	struct interrupt_info temp_info;
+	uint16_t out_size = sizeof(msix_cfg);
+	int err;
+
+	if (!hwdev)
+		return -EINVAL;
+
+	temp_info.msix_index = info.msix_index;
+	err = hinic3_get_interrupt_cfg(hwdev, &temp_info);
+	if (err)
+		return -EIO;
+
+	memset(&msix_cfg, 0, sizeof(msix_cfg));
+	msix_cfg.func_id = hinic3_global_func_id(hwdev);
+	msix_cfg.msix_index = (uint16_t)info.msix_index;
+	msix_cfg.opcode = HINIC3_MGMT_CMD_OP_SET;
+
+	msix_cfg.lli_credit_cnt = temp_info.lli_credit_limit;
+	msix_cfg.lli_tmier_cnt = temp_info.lli_timer_cfg;
+	msix_cfg.pending_cnt = temp_info.pending_limt;
+	msix_cfg.coalesce_timer_cnt = temp_info.coalesce_timer_cfg;
+	msix_cfg.resend_timer_cnt = temp_info.resend_timer_cfg;
+
+	if (info.lli_set) {
+		msix_cfg.lli_credit_cnt = info.lli_credit_limit;
+		msix_cfg.lli_tmier_cnt = info.lli_timer_cfg;
+	}
+
+	if (info.interrupt_coalesce_set) {
+		msix_cfg.pending_cnt = info.pending_limt;
+		msix_cfg.coalesce_timer_cnt = info.coalesce_timer_cfg;
+		msix_cfg.resend_timer_cnt = info.resend_timer_cfg;
+	}
+
+	err = hinic3_msg_to_mgmt_sync(hwdev,
+		HINIC3_MOD_COMM, HINIC3_MGMT_CMD_CFG_MSIX_CTRL_REG,
+		&msix_cfg, sizeof(msix_cfg), &msix_cfg, &out_size, 0);
+	if (err || !out_size || msix_cfg.status) {
+		PMD_DRV_LOG(ERR,
+			    "Set interrupt config failed, "
+			    "err: %d, status: 0x%x, out size: 0x%x",
+			    err, msix_cfg.status, out_size);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+int
+hinic3_set_wq_page_size(struct hinic3_hwdev *hwdev, uint16_t func_idx, uint32_t page_size)
+{
+	struct hinic3_cmd_wq_page_size page_size_info;
+	uint16_t out_size = sizeof(page_size_info);
+	int err;
+
+	memset(&page_size_info, 0, sizeof(page_size_info));
+	page_size_info.func_idx = func_idx;
+	page_size_info.page_size = HINIC3_PAGE_SIZE_HW(page_size);
+	page_size_info.opcode = HINIC3_MGMT_CMD_OP_SET;
+
+	err = hinic3_msg_to_mgmt_sync(hwdev, HINIC3_MOD_COMM,
+				      HINIC3_MGMT_CMD_CFG_PAGESIZE,
+				      &page_size_info, sizeof(page_size_info),
+				      &page_size_info, &out_size, 0);
+	if (err || !out_size || page_size_info.status) {
+		PMD_DRV_LOG(ERR,
+			    "Set wq page size failed, "
+			    "err: %d, status: 0x%x, out_size: 0x%0x",
+			    err, page_size_info.status, out_size);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+int
+hinic3_func_reset(struct hinic3_hwdev *hwdev, uint64_t reset_flag)
+{
+	struct hinic3_reset func_reset;
+	struct hinic3_hwif *hwif = hwdev->hwif;
+	uint16_t out_size = sizeof(func_reset);
+	int err = 0;
+
+	PMD_DRV_LOG(INFO, "Function is reset");
+
+	memset(&func_reset, 0, sizeof(func_reset));
+	func_reset.func_id = HINIC3_HWIF_GLOBAL_IDX(hwif);
+	func_reset.reset_flag = reset_flag;
+	err = hinic3_msg_to_mgmt_sync(hwdev,
+		HINIC3_MOD_COMM, HINIC3_MGMT_CMD_FUNC_RESET, &func_reset,
+		sizeof(func_reset), &func_reset, &out_size, 0);
+	if (err || !out_size || func_reset.status) {
+		PMD_DRV_LOG(ERR,
+			    "Reset func resources failed, "
+			    "err: %d, status: 0x%x, out_size: 0x%x",
+			    err, func_reset.status, out_size);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+int
+hinic3_set_func_svc_used_state(struct hinic3_hwdev *hwdev, uint16_t svc_type, uint8_t state)
+{
+	struct comm_cmd_func_svc_used_state used_state;
+	uint16_t out_size = sizeof(used_state);
+	int err;
+
+	if (!hwdev)
+		return -EINVAL;
+
+	memset(&used_state, 0, sizeof(used_state));
+	used_state.func_id = hinic3_global_func_id(hwdev);
+	used_state.svc_type = svc_type;
+	used_state.used_state = state;
+
+	err = hinic3_msg_to_mgmt_sync(hwdev,
+		HINIC3_MOD_COMM, HINIC3_MGMT_CMD_SET_FUNC_SVC_USED_STATE,
+		&used_state, sizeof(used_state), &used_state, &out_size, 0);
+	if (err || !out_size || used_state.status) {
+		PMD_DRV_LOG(ERR,
+			    "Failed to set func service used state, "
+			    "err: %d, status: 0x%x, out size: 0x%x",
+			    err, used_state.status, out_size);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+int
+hinic3_convert_rx_buf_size(uint32_t rx_buf_sz, uint32_t *match_sz)
+{
+	uint32_t i, num_hw_types, best_match_sz;
+
+	if (unlikely(!match_sz || rx_buf_sz < HINIC3_RX_BUF_SIZE_32B))
+		return -EINVAL;
+
+	if (rx_buf_sz >= HINIC3_RX_BUF_SIZE_16K) {
+		best_match_sz = HINIC3_RX_BUF_SIZE_16K;
+		goto size_matched;
+	}
+
+	if (rx_buf_sz >= HINIC3_RX_BUF_SIZE_4K) {
+		best_match_sz = ((rx_buf_sz >> RX_BUF_SIZE_1K_LEN)
+				 << RX_BUF_SIZE_1K_LEN);
+		goto size_matched;
+	}
+
+	num_hw_types = sizeof(hinic3_hw_rx_buf_size) /
+		       sizeof(hinic3_hw_rx_buf_size[0]);
+	best_match_sz = hinic3_hw_rx_buf_size[0];
+	for (i = 0; i < num_hw_types; i++) {
+		if (rx_buf_sz == hinic3_hw_rx_buf_size[i]) {
+			best_match_sz = hinic3_hw_rx_buf_size[i];
+			break;
+		} else if (rx_buf_sz < hinic3_hw_rx_buf_size[i]) {
+			break;
+		}
+		best_match_sz = hinic3_hw_rx_buf_size[i];
+	}
+
+size_matched:
+	*match_sz = best_match_sz;
+
+	return 0;
+}
+
+static uint16_t
+get_hw_rx_buf_size(uint32_t rx_buf_sz)
+{
+	uint16_t num_hw_types = sizeof(hinic3_hw_rx_buf_size) /
+			   sizeof(hinic3_hw_rx_buf_size[0]);
+	uint16_t i;
+
+	for (i = 0; i < num_hw_types; i++) {
+		if (hinic3_hw_rx_buf_size[i] == rx_buf_sz)
+			return i;
+	}
+
+	PMD_DRV_LOG(WARNING, "Chip can't support rx buf size of %d", rx_buf_sz);
+
+	return DEFAULT_RX_BUF_SIZE; /**< Default 2K. */
+}
+
+int
+hinic3_set_root_ctxt(struct hinic3_hwdev *hwdev, uint32_t rq_depth,
+					uint32_t sq_depth, uint16_t rx_buf_sz)
+{
+	struct hinic3_cmd_root_ctxt root_ctxt;
+	uint16_t out_size = sizeof(root_ctxt);
+	int err;
+
+	if (!hwdev)
+		return -EINVAL;
+
+	memset(&root_ctxt, 0, sizeof(root_ctxt));
+	root_ctxt.func_idx = hinic3_global_func_id(hwdev);
+	root_ctxt.set_cmdq_depth = 0;
+	root_ctxt.cmdq_depth = 0;
+	root_ctxt.lro_en = 1;
+	root_ctxt.rq_depth = (uint16_t)rte_log2_u32(rq_depth);
+	root_ctxt.rx_buf_sz = get_hw_rx_buf_size(rx_buf_sz);
+	root_ctxt.sq_depth = (uint16_t)rte_log2_u32(sq_depth);
+
+	err = hinic3_msg_to_mgmt_sync(hwdev,
+		HINIC3_MOD_COMM, HINIC3_MGMT_CMD_SET_VAT, &root_ctxt,
+		sizeof(root_ctxt), &root_ctxt, &out_size, 0);
+	if (err || !out_size || root_ctxt.status) {
+		PMD_DRV_LOG(ERR,
+			    "Set root context failed, "
+			    "err: %d, status: 0x%x, out_size: 0x%x",
+			    err, root_ctxt.status, out_size);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+int
+hinic3_clean_root_ctxt(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_cmd_root_ctxt root_ctxt;
+	uint16_t out_size = sizeof(root_ctxt);
+	int err;
+
+	if (!hwdev)
+		return -EINVAL;
+
+	memset(&root_ctxt, 0, sizeof(root_ctxt));
+	root_ctxt.func_idx = hinic3_global_func_id(hwdev);
+
+	err = hinic3_msg_to_mgmt_sync(hwdev,
+		HINIC3_MOD_COMM, HINIC3_MGMT_CMD_SET_VAT, &root_ctxt,
+		sizeof(root_ctxt), &root_ctxt, &out_size, 0);
+	if (err || !out_size || root_ctxt.status) {
+		PMD_DRV_LOG(ERR,
+			    "Clean root context failed, "
+			    "err: %d, status: 0x%x, out_size: 0x%x",
+			    err, root_ctxt.status, out_size);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+int
+hinic3_set_cmdq_depth(struct hinic3_hwdev *hwdev, uint16_t cmdq_depth)
+{
+	struct hinic3_cmd_root_ctxt root_ctxt;
+	uint16_t out_size = sizeof(root_ctxt);
+	int err;
+
+	memset(&root_ctxt, 0, sizeof(root_ctxt));
+	root_ctxt.func_idx = hinic3_global_func_id(hwdev);
+	root_ctxt.set_cmdq_depth = 1;
+	root_ctxt.cmdq_depth = (uint8_t)rte_log2_u32(cmdq_depth);
+
+	err = hinic3_msg_to_mgmt_sync(hwdev,
+		HINIC3_MOD_COMM, HINIC3_MGMT_CMD_SET_VAT, &root_ctxt,
+		sizeof(root_ctxt), &root_ctxt, &out_size, 0);
+	if (err || !out_size || root_ctxt.status) {
+		PMD_DRV_LOG(ERR,
+			    "Set cmdq depth failed, "
+			    "err: %d, status: 0x%x, out_size: 0x%x",
+			    err, root_ctxt.status, out_size);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+int
+hinic3_get_mgmt_version(struct hinic3_hwdev *hwdev, char *mgmt_ver, int max_mgmt_len)
+{
+	struct hinic3_cmd_get_fw_version fw_ver;
+	uint16_t out_size = sizeof(fw_ver);
+	int err;
+
+	if (!hwdev || !mgmt_ver)
+		return -EINVAL;
+
+	memset(&fw_ver, 0, sizeof(fw_ver));
+	fw_ver.fw_type = HINIC3_FW_VER_TYPE_MPU;
+
+	err = hinic3_msg_to_mgmt_sync(hwdev, HINIC3_MOD_COMM,
+				      HINIC3_MGMT_CMD_GET_FW_VERSION, &fw_ver,
+				      sizeof(fw_ver), &fw_ver, &out_size, 0);
+	if (MSG_TO_MGMT_SYNC_RETURN_ERR(err, out_size, fw_ver.status)) {
+		PMD_DRV_LOG(ERR,
+			    "Get mgmt version failed, "
+			    "err: %d, status: 0x%x, out size: 0x%x",
+			    err, fw_ver.status, out_size);
+		return -EIO;
+	}
+
+	snprintf(mgmt_ver, max_mgmt_len, "%s", fw_ver.ver);
+	return 0;
+}
+
+int
+hinic3_get_board_info(struct hinic3_hwdev *hwdev, struct hinic3_board_info *info)
+{
+	struct hinic3_cmd_board_info board_info;
+	uint16_t out_size = sizeof(board_info);
+	int err;
+
+	if (!hwdev || !info)
+		return -EINVAL;
+
+	memset(&board_info, 0, sizeof(board_info));
+	err = hinic3_msg_to_mgmt_sync(hwdev,
+		HINIC3_MOD_COMM, HINIC3_MGMT_CMD_GET_BOARD_INFO,
+		&board_info, sizeof(board_info), &board_info, &out_size, 0);
+	if (err || board_info.status || !out_size) {
+		PMD_DRV_LOG(ERR,
+			    "Get board info failed, "
+			    "err: %d, status: 0x%x, out size: 0x%x",
+			    err, board_info.status, out_size);
+		return -EFAULT;
+	}
+
+	memcpy(info, &board_info.info, sizeof(*info));
+
+	return 0;
+}
+
+static int
+hinic3_comm_features_nego(struct hinic3_hwdev *hwdev,
+						uint8_t opcode, uint64_t *s_feature, uint16_t size)
+{
+	struct comm_cmd_feature_nego feature_nego;
+	uint16_t out_size = sizeof(feature_nego);
+	int err;
+
+	if (!hwdev || !s_feature || size > COMM_MAX_FEATURE_QWORD)
+		return -EINVAL;
+
+	memset(&feature_nego, 0, sizeof(feature_nego));
+	feature_nego.func_id = hinic3_global_func_id(hwdev);
+	feature_nego.opcode = opcode;
+	if (opcode == MGMT_MSG_CMD_OP_SET)
+		memcpy(feature_nego.s_feature, s_feature, (size * sizeof(uint64_t)));
+
+	err = hinic3_msg_to_mgmt_sync(hwdev, HINIC3_MOD_COMM,
+				      HINIC3_MGMT_CMD_FEATURE_NEGO,
+				      &feature_nego, sizeof(feature_nego),
+				      &feature_nego, &out_size, 0);
+	if (err || !out_size || feature_nego.head.status) {
+		PMD_DRV_LOG(ERR,
+			    "Failed to negotiate feature, "
+			    "err: %d, status: 0x%x, out size: 0x%x",
+			    err, feature_nego.head.status, out_size);
+		return -EINVAL;
+	}
+
+	if (opcode == MGMT_MSG_CMD_OP_GET)
+		memcpy(s_feature, feature_nego.s_feature, (size * sizeof(uint64_t)));
+
+	return 0;
+}
+
+int
+hinic3_get_comm_features(struct hinic3_hwdev *hwdev, uint64_t *s_feature, uint16_t size)
+{
+	return hinic3_comm_features_nego(hwdev, MGMT_MSG_CMD_OP_GET, s_feature,
+					 size);
+}
+
+int
+hinic3_set_comm_features(struct hinic3_hwdev *hwdev, uint64_t *s_feature, uint16_t size)
+{
+	return hinic3_comm_features_nego(hwdev, MGMT_MSG_CMD_OP_SET, s_feature,
+					 size);
+}
diff --git a/drivers/net/hinic3/base/hinic3_hw_comm.h b/drivers/net/hinic3/base/hinic3_hw_comm.h
new file mode 100644
index 0000000000..d74607f278
--- /dev/null
+++ b/drivers/net/hinic3/base/hinic3_hw_comm.h
@@ -0,0 +1,365 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd
+ */
+
+#ifndef _HINIC3_HW_COMM_H_
+#define _HINIC3_HW_COMM_H_
+
+#include "hinic3_hwdev.h"
+#define HINIC3_MGMT_CMD_OP_GET 0
+#define HINIC3_MGMT_CMD_OP_SET 1
+
+#define HINIC3_MSIX_CNT_LLI_TIMER_SHIFT	    0
+#define HINIC3_MSIX_CNT_LLI_CREDIT_SHIFT    8
+#define HINIC3_MSIX_CNT_COALESCE_TIMER_SHIFT 8
+#define HINIC3_MSIX_CNT_PENDING_SHIFT	    8
+#define HINIC3_MSIX_CNT_RESEND_TIMER_SHIFT  29
+
+#define HINIC3_MSIX_CNT_LLI_TIMER_MASK	   0xFFU
+#define HINIC3_MSIX_CNT_LLI_CREDIT_MASK	   0xFFU
+#define HINIC3_MSIX_CNT_COALESCE_TIMER_MASK 0xFFU
+#define HINIC3_MSIX_CNT_PENDING_MASK	   0x1FU
+#define HINIC3_MSIX_CNT_RESEND_TIMER_MASK  0x7U
+
+#define HINIC3_MSIX_CNT_SET(val, member)           \
+	(((val) & HINIC3_MSIX_CNT_##member##_MASK) \
+	 << HINIC3_MSIX_CNT_##member##_SHIFT)
+
+#define MSG_TO_MGMT_SYNC_RETURN_ERR(err, out_size, status) \
+	((err) || (status) || !(out_size))
+
+#define DEFAULT_RX_BUF_SIZE ((uint16_t)0xB)
+#define RX_BUF_SIZE_1K_LEN  ((uint16_t)0xA)
+
+enum hinic3_rx_buf_size {
+	HINIC3_RX_BUF_SIZE_32B = 0x20,
+	HINIC3_RX_BUF_SIZE_64B = 0x40,
+	HINIC3_RX_BUF_SIZE_96B = 0x60,
+	HINIC3_RX_BUF_SIZE_128B = 0x80,
+	HINIC3_RX_BUF_SIZE_192B = 0xC0,
+	HINIC3_RX_BUF_SIZE_256B = 0x100,
+	HINIC3_RX_BUF_SIZE_384B = 0x180,
+	HINIC3_RX_BUF_SIZE_512B = 0x200,
+	HINIC3_RX_BUF_SIZE_768B = 0x300,
+	HINIC3_RX_BUF_SIZE_1K = 0x400,
+	HINIC3_RX_BUF_SIZE_1_5K = 0x600,
+	HINIC3_RX_BUF_SIZE_2K = 0x800,
+	HINIC3_RX_BUF_SIZE_3K = 0xC00,
+	HINIC3_RX_BUF_SIZE_4K = 0x1000,
+	HINIC3_RX_BUF_SIZE_8K = 0x2000,
+	HINIC3_RX_BUF_SIZE_16K = 0x4000,
+};
+
+struct hinic3_cmd_msix_config {
+	uint8_t status;
+	uint8_t version;
+	uint8_t rsvd0[6];
+
+	uint16_t func_id;
+	uint8_t opcode;
+	uint8_t rsvd1;
+	uint16_t msix_index;
+	uint8_t pending_cnt;
+	uint8_t coalesce_timer_cnt;
+	uint8_t resend_timer_cnt;
+	uint8_t lli_tmier_cnt;
+	uint8_t lli_credit_cnt;
+	uint8_t rsvd2[5];
+};
+
+struct hinic3_dma_attr_table {
+	struct mgmt_msg_head head;
+
+	uint16_t func_id;
+	uint8_t entry_idx;
+	uint8_t st;
+	uint8_t at;
+	uint8_t ph;
+	uint8_t no_snooping;
+	uint8_t tph_en;
+	uint32_t rsvd1;
+};
+
+#define HINIC3_PAGE_SIZE_HW(pg_size) ((uint8_t)rte_log2_u32((uint32_t)((pg_size) >> 12)))
+
+struct hinic3_cmd_wq_page_size {
+	uint8_t status;
+	uint8_t version;
+	uint8_t rsvd0[6];
+
+	uint16_t func_idx;
+	uint8_t opcode;
+	/**
+	 * Real size is 4KB * 2^page_size, range(0~20) must be checked by
+	 * driver.
+	 */
+	uint8_t page_size;
+
+	uint32_t rsvd1;
+};
+
+struct hinic3_reset {
+	uint8_t status;
+	uint8_t version;
+	uint8_t rsvd0[6];
+
+	uint16_t func_id;
+	uint16_t rsvd1[3];
+	uint64_t reset_flag;
+};
+
+struct comm_cmd_func_svc_used_state {
+	uint8_t status;
+	uint8_t version;
+	uint8_t rsvd0[6];
+
+	uint16_t func_id;
+	uint16_t svc_type;
+	uint8_t used_state;
+	uint8_t rsvd[35];
+};
+
+struct hinic3_cmd_root_ctxt {
+	uint8_t status;
+	uint8_t version;
+	uint8_t rsvd0[6];
+
+	uint16_t func_idx;
+	uint8_t set_cmdq_depth;
+	uint8_t cmdq_depth;
+	uint16_t rx_buf_sz;
+	uint8_t lro_en;
+	uint8_t rsvd1;
+	uint16_t sq_depth;
+	uint16_t rq_depth;
+	uint64_t rsvd2;
+};
+
+enum hinic3_fw_ver_type {
+	HINIC3_FW_VER_TYPE_BOOT,
+	HINIC3_FW_VER_TYPE_MPU,
+	HINIC3_FW_VER_TYPE_NPU,
+	HINIC3_FW_VER_TYPE_SMU,
+	HINIC3_FW_VER_TYPE_CFG,
+};
+
+#define MGMT_MSG_CMD_OP_SET 1
+#define MGMT_MSG_CMD_OP_GET 0
+
+#define COMM_MAX_FEATURE_QWORD 4
+struct comm_cmd_feature_nego {
+	struct mgmt_msg_head head;
+
+	uint16_t func_id;
+	uint8_t opcode; /**< 1: set, 0: get. */
+	uint8_t rsvd;
+	uint64_t s_feature[COMM_MAX_FEATURE_QWORD];
+};
+
+#define HINIC3_FW_VERSION_LEN	    16
+#define HINIC3_FW_COMPILE_TIME_LEN  20
+#define HINIC3_MGMT_VERSION_MAX_LEN 32
+struct hinic3_cmd_get_fw_version {
+	uint8_t status;
+	uint8_t version;
+	uint8_t rsvd0[6];
+
+	uint16_t fw_type;
+	uint16_t rsvd1;
+	uint8_t ver[HINIC3_FW_VERSION_LEN];
+	uint8_t time[HINIC3_FW_COMPILE_TIME_LEN];
+};
+
+struct hinic3_cmd_clear_doorbell {
+	uint8_t status;
+	uint8_t version;
+	uint8_t rsvd0[6];
+
+	uint16_t func_idx;
+	uint16_t rsvd1[3];
+};
+
+struct hinic3_cmd_clear_resource {
+	uint8_t status;
+	uint8_t version;
+	uint8_t rsvd0[6];
+
+	uint16_t func_idx;
+	uint16_t rsvd1[3];
+};
+
+struct hinic3_cmd_board_info {
+	uint8_t status;
+	uint8_t version;
+	uint8_t rsvd0[6];
+
+	struct hinic3_board_info info;
+
+	uint32_t rsvd1[23];
+};
+
+struct interrupt_info {
+	uint32_t lli_set;
+	uint32_t interrupt_coalesce_set;
+	uint16_t msix_index;
+	uint8_t lli_credit_limit;
+	uint8_t lli_timer_cfg;
+	uint8_t pending_limt;
+	uint8_t coalesce_timer_cfg;
+	uint8_t resend_timer_cfg;
+};
+
+enum cfg_msix_operation {
+	CFG_MSIX_OPERATION_FREE = 0,
+	CFG_MSIX_OPERATION_ALLOC = 1,
+};
+
+struct comm_cmd_cfg_msix_num {
+	uint8_t status;
+	uint8_t version;
+	uint8_t rsvd0[6];
+
+	uint16_t func_id;
+	uint8_t op_code; /**< 1: alloc, 0: free. */
+	uint8_t rsvd1;
+
+	uint16_t msix_num;
+	uint16_t rsvd2;
+};
+
+int hinic3_get_interrupt_cfg(struct hinic3_hwdev *hwdev, struct interrupt_info *info);
+
+/**
+ * Set interrupt cfg.
+ *
+ * @param[in] dev
+ * Pointer to ethernet device structure.
+ * @param[in] info
+ * Interrupt info.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+int hinic3_set_interrupt_cfg(struct hinic3_hwdev *hwdev, struct interrupt_info info);
+
+int hinic3_set_wq_page_size(struct hinic3_hwdev *hwdev, uint16_t func_idx, uint32_t page_size);
+
+/**
+ * Send a reset command to hardware.
+ *
+ * @param[in] hwdev
+ * Pointer to hardware device structure.
+ * @param[in] reset_flag
+ * The flag that specifies the reset behavior.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+int hinic3_func_reset(struct hinic3_hwdev *hwdev, uint64_t reset_flag);
+
+/**
+ * Send a command to management module to set usage state of a specific service
+ * for given function.
+ *
+ * @param[in] hwdev
+ * Pointer to hardware device structure.
+ * @param[in] svc_type
+ * The service type to update.
+ * @param[in] state
+ * The state to set for the service.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+int hinic3_set_func_svc_used_state(struct hinic3_hwdev *hwdev, uint16_t svc_type, uint8_t state);
+
+/**
+ * Adjust the requested RX buffer size to the closest valid size supported by
+ * the hardware.
+ *
+ * @param[in] rx_buf_sz
+ * The requested RX buffer size.
+ * @param[out] match_sz
+ * The closest valid RX buffer size.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+int hinic3_convert_rx_buf_size(uint32_t rx_buf_sz, uint32_t *match_sz);
+
+/**
+ * Send a command to apply the settings.
+ *
+ * @param[in] hwdev
+ * Pointer to hardware device structure.
+ * @param[in] rq_depth
+ * The depth of the receive queue.
+ * @param[in] sq_depth
+ * The depth of the send queue.
+ * @param[in] rx_buf_sz
+ * The RX buffer size to set.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+int hinic3_set_root_ctxt(struct hinic3_hwdev *hwdev, uint32_t rq_depth, uint32_t sq_depth,
+			 uint16_t rx_buf_sz);
+
+/**
+ * Send a command to clear any previously set context.
+ *
+ * @param[in] hwdev
+ * Pointer to hardware device structure.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+int hinic3_clean_root_ctxt(struct hinic3_hwdev *hwdev);
+
+/**
+ * Send a command to set command queue depth.
+ *
+ * @param[in] hwdev
+ * Pointer to hardware device structure.
+ * @param[in] cmdq_depth
+ * The desired depth of the command queue, converted to logarithmic value
+ * before being set.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+int hinic3_set_cmdq_depth(struct hinic3_hwdev *hwdev, uint16_t cmdq_depth);
+
+/**
+ * Send a command to get firmware version.
+ *
+ * @param[in] hwdev
+ * Pointer to hardware device structure.
+ * @param[out] mgmt_ver
+ * The buffer to store the retrieved management firmware version.
+ * @param[in] max_mgmt_len
+ * The maximum length of the `mgmt_ver` buffer.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+int hinic3_get_mgmt_version(struct hinic3_hwdev *hwdev, char *mgmt_ver, int max_mgmt_len);
+
+/**
+ * Send a command to get board information.
+ *
+ * @param[in] hwdev
+ * Pointer to hardware device structure.
+ * @param[out] info
+ * The structure to store the retrieved board information.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+int hinic3_get_board_info(struct hinic3_hwdev *hwdev, struct hinic3_board_info *info);
+
+int hinic3_get_comm_features(struct hinic3_hwdev *hwdev, uint64_t *s_feature, uint16_t size);
+
+int hinic3_set_comm_features(struct hinic3_hwdev *hwdev, uint64_t *s_feature, uint16_t size);
+
+#endif /* _HINIC3_HW_COMM_H_ */
diff --git a/drivers/net/hinic3/base/hinic3_hwdev.c b/drivers/net/hinic3/base/hinic3_hwdev.c
new file mode 100644
index 0000000000..5bf8f6ed00
--- /dev/null
+++ b/drivers/net/hinic3/base/hinic3_hwdev.c
@@ -0,0 +1,557 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd
+ */
+
+#include <rte_vfio.h>
+
+#include "hinic3_compat.h"
+#include "hinic3_cmd.h"
+#include "hinic3_cmdq.h"
+#include "hinic3_csr.h"
+#include "hinic3_eqs.h"
+#include "hinic3_hw_cfg.h"
+#include "hinic3_hw_comm.h"
+#include "hinic3_hwdev.h"
+#include "hinic3_hwif.h"
+#include "hinic3_mbox.h"
+#include "hinic3_mgmt.h"
+#include "hinic3_wq.h"
+
+enum hinic3_pcie_nosnoop { HINIC3_PCIE_SNOOP = 0, HINIC3_PCIE_NO_SNOOP = 1 };
+
+enum hinic3_pcie_tph {
+	HINIC3_PCIE_TPH_DISABLE = 0,
+	HINIC3_PCIE_TPH_ENABLE = 1
+};
+
+#define HINIC3_DMA_ATTR_INDIR_IDX_SHIFT 0
+
+#define HINIC3_DMA_ATTR_INDIR_IDX_MASK 0x3FF
+
+#define HINIC3_DMA_ATTR_INDIR_IDX_SET(val, member)            \
+	(((uint32_t)(val) & HINIC3_DMA_ATTR_INDIR_##member##_MASK) \
+	 << HINIC3_DMA_ATTR_INDIR_##member##_SHIFT)
+
+#define HINIC3_DMA_ATTR_INDIR_IDX_CLEAR(val, member)      \
+	((val) & (~(HINIC3_DMA_ATTR_INDIR_##member##_MASK \
+		    << HINIC3_DMA_ATTR_INDIR_##member##_SHIFT)))
+
+#define HINIC3_DMA_ATTR_ENTRY_ST_SHIFT		0
+#define HINIC3_DMA_ATTR_ENTRY_AT_SHIFT		8
+#define HINIC3_DMA_ATTR_ENTRY_PH_SHIFT		10
+#define HINIC3_DMA_ATTR_ENTRY_NO_SNOOPING_SHIFT 12
+#define HINIC3_DMA_ATTR_ENTRY_TPH_EN_SHIFT	13
+
+#define HINIC3_DMA_ATTR_ENTRY_ST_MASK	       0xFF
+#define HINIC3_DMA_ATTR_ENTRY_AT_MASK	       0x3
+#define HINIC3_DMA_ATTR_ENTRY_PH_MASK	       0x3
+#define HINIC3_DMA_ATTR_ENTRY_NO_SNOOPING_MASK 0x1
+#define HINIC3_DMA_ATTR_ENTRY_TPH_EN_MASK      0x1
+
+#define HINIC3_DMA_ATTR_ENTRY_SET(val, member)                \
+	(((uint32_t)(val) & HINIC3_DMA_ATTR_ENTRY_##member##_MASK) \
+	 << HINIC3_DMA_ATTR_ENTRY_##member##_SHIFT)
+
+#define HINIC3_DMA_ATTR_ENTRY_CLEAR(val, member)          \
+	((val) & (~(HINIC3_DMA_ATTR_ENTRY_##member##_MASK \
+		    << HINIC3_DMA_ATTR_ENTRY_##member##_SHIFT)))
+
+#define HINIC3_PCIE_ST_DISABLE 0
+#define HINIC3_PCIE_AT_DISABLE 0
+#define HINIC3_PCIE_PH_DISABLE 0
+
+#define PCIE_MSIX_ATTR_ENTRY 0
+
+#define HINIC3_CHIP_PRESENT 1
+#define HINIC3_CHIP_ABSENT  0
+
+#define HINIC3_DEFAULT_EQ_MSIX_PENDING_LIMIT	0
+#define HINIC3_DEFAULT_EQ_MSIX_COALESCE_TIMER_CFG 0xFF
+#define HINIC3_DEFAULT_EQ_MSIX_RESEND_TIMER_CFG	7
+typedef void (*mgmt_event_cb)(struct hinic3_hwdev *hwdev, struct hinic3_handler_info *handler_info);
+
+struct mgmt_event_handle {
+	uint16_t cmd;
+	mgmt_event_cb proc;
+};
+
+bool
+hinic3_is_vfio_iommu_enable(const struct rte_eth_dev *rte_dev)
+{
+	return ((RTE_ETH_DEV_TO_PCI(rte_dev)->kdrv == RTE_PCI_KDRV_VFIO) &&
+		(rte_vfio_noiommu_is_enabled() != 1));
+}
+
+int
+vf_handle_pf_comm_mbox(struct hinic3_hwdev *hwdev, __rte_unused void *pri_handle,
+				struct hinic3_handler_info *handler_info)
+{
+	if (!hwdev)
+		return -EINVAL;
+
+	PMD_DRV_LOG(WARNING, "Unsupported pf mbox event %d to process", handler_info->cmd);
+
+	return 0;
+}
+
+static void
+fault_event_handler(__rte_unused struct hinic3_hwdev *hwdev,
+				__rte_unused struct hinic3_handler_info *handler_info)
+{
+	PMD_DRV_LOG(WARNING, "Unsupported fault event handler");
+}
+
+static void
+ffm_event_msg_handler(__rte_unused struct hinic3_hwdev *hwdev,
+				struct hinic3_handler_info *handler_info)
+{
+	struct ffm_intr_info *intr = handler_info->buf_in;
+
+	if (handler_info->in_size != sizeof(*intr)) {
+		PMD_DRV_LOG(ERR,
+			    "Invalid fault event report, "
+			    "length: %d, should be %zu",
+			    handler_info->in_size, sizeof(*intr));
+		return;
+	}
+
+	PMD_DRV_LOG(ERR,
+		    "node_id: 0x%x, err_type: 0x%x, err_level: %d, "
+		    "err_csr_addr: 0x%08x, err_csr_value: 0x%08x",
+		    intr->node_id, intr->err_type, intr->err_level,
+		    intr->err_csr_addr, intr->err_csr_value);
+
+	*handler_info->out_size = sizeof(*intr);
+}
+
+static const struct mgmt_event_handle mgmt_event_proc[] = {
+	{
+		.cmd = HINIC3_MGMT_CMD_FAULT_REPORT,
+		.proc = fault_event_handler,
+	},
+
+	{
+		.cmd = HINIC3_MGMT_CMD_FFM_SET,
+		.proc = ffm_event_msg_handler,
+	},
+};
+
+void
+pf_handle_mgmt_comm_event(struct hinic3_hwdev *hwdev, __rte_unused void *pri_handle,
+						struct hinic3_handler_info *handler_info)
+{
+	uint32_t i, event_num = RTE_DIM(mgmt_event_proc);
+
+	if (!hwdev)
+		return;
+
+	for (i = 0; i < event_num; i++) {
+		if (handler_info->cmd == mgmt_event_proc[i].cmd) {
+			if (mgmt_event_proc[i].proc)
+				mgmt_event_proc[i].proc(hwdev, handler_info);
+			return;
+		}
+	}
+
+	PMD_DRV_LOG(WARNING, "Unsupported mgmt cpu event %d to process", handler_info->cmd);
+}
+
+static int
+set_dma_attr_entry(struct hinic3_hwdev *hwdev,
+		    uint8_t entry_idx,  uint8_t st,
+		    uint8_t at,  uint8_t ph,
+		    enum hinic3_pcie_nosnoop no_snooping,
+		    enum hinic3_pcie_tph tph_en)
+{
+	struct hinic3_dma_attr_table attr;
+	uint16_t out_size = sizeof(attr);
+	int err;
+
+	memset(&attr, 0, sizeof(attr));
+	attr.func_id = hinic3_global_func_id(hwdev);
+	attr.entry_idx = entry_idx;
+	attr.st = st;
+	attr.at = at;
+	attr.ph = ph;
+	attr.no_snooping = no_snooping;
+	attr.tph_en = tph_en;
+
+	err = hinic3_msg_to_mgmt_sync(hwdev, HINIC3_MOD_COMM,
+				      HINIC3_MGMT_CMD_SET_DMA_ATTR, &attr,
+				      sizeof(attr), &attr, &out_size, 0);
+	if (err || !out_size || attr.head.status) {
+		PMD_DRV_LOG(ERR,
+			    "Set dma attribute failed, err: %d, status: 0x%x, "
+			    "out_size: 0x%x",
+			    err, attr.head.status, out_size);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/**
+ * Initialize the default dma attributes.
+ *
+ * @param[in] hwdev
+ * Pointer to hardware device structure.
+ *
+ * 0 on success, non-zero on failure.
+ */
+static int
+dma_attr_table_init(struct hinic3_hwdev *hwdev)
+{
+	return set_dma_attr_entry(hwdev,
+		PCIE_MSIX_ATTR_ENTRY, HINIC3_PCIE_ST_DISABLE,
+		HINIC3_PCIE_AT_DISABLE, HINIC3_PCIE_PH_DISABLE,
+		HINIC3_PCIE_SNOOP, HINIC3_PCIE_TPH_DISABLE);
+}
+
+static int
+init_aeqs_msix_attr(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_aeqs *aeqs = hwdev->aeqs;
+	struct interrupt_info info = {0};
+	struct hinic3_eq *eq = NULL;
+	uint16_t q_id;
+	int err;
+
+	info.lli_set = 0;
+	info.interrupt_coalesce_set = 1;
+	info.pending_limt = HINIC3_DEFAULT_EQ_MSIX_PENDING_LIMIT;
+	info.coalesce_timer_cfg = HINIC3_DEFAULT_EQ_MSIX_COALESCE_TIMER_CFG;
+	info.resend_timer_cfg = HINIC3_DEFAULT_EQ_MSIX_RESEND_TIMER_CFG;
+
+	for (q_id = 0; q_id < aeqs->num_aeqs; q_id++) {
+		eq = &aeqs->aeq[q_id];
+		info.msix_index = eq->eq_irq.msix_entry_idx;
+		err = hinic3_set_interrupt_cfg(hwdev, info);
+		if (err) {
+			PMD_DRV_LOG(ERR, "Set msix attr for aeq %d failed",
+				    q_id);
+			return -EFAULT;
+		}
+	}
+
+	return 0;
+}
+
+static int
+hinic3_comm_pf_to_mgmt_init(struct hinic3_hwdev *hwdev)
+{
+	int err;
+
+	/* VF does not support send msg to mgmt directly. */
+	if (hinic3_func_type(hwdev) == TYPE_VF)
+		return 0;
+
+	err = hinic3_pf_to_mgmt_init(hwdev);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static void
+hinic3_comm_pf_to_mgmt_free(struct hinic3_hwdev *hwdev)
+{
+	/* VF does not support send msg to mgmt directly. */
+	if (hinic3_func_type(hwdev) == TYPE_VF)
+		return;
+
+	hinic3_pf_to_mgmt_free(hwdev);
+}
+
+static int
+hinic3_comm_cmdqs_init(struct hinic3_hwdev *hwdev)
+{
+	int err;
+
+	err = hinic3_init_cmdqs(hwdev);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Init cmd queues failed");
+		return err;
+	}
+
+	err = hinic3_set_cmdq_depth(hwdev, HINIC3_CMDQ_DEPTH);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Set cmdq depth failed");
+		goto set_cmdq_depth_err;
+	}
+
+	return 0;
+
+set_cmdq_depth_err:
+	hinic3_free_cmdqs(hwdev);
+
+	return err;
+}
+
+static void
+hinic3_comm_cmdqs_free(struct hinic3_hwdev *hwdev)
+{
+	hinic3_free_cmdqs(hwdev);
+}
+
+static void
+hinic3_sync_mgmt_func_state(struct hinic3_hwdev *hwdev)
+{
+	hinic3_set_pf_status(hwdev->hwif, HINIC3_PF_STATUS_ACTIVE_FLAG);
+}
+
+static int
+get_func_misc_info(struct hinic3_hwdev *hwdev)
+{
+	int err;
+
+	err = hinic3_get_board_info(hwdev, &hwdev->board_info);
+	if (err) {
+		/* For the PF/VF of secondary host, return error. */
+		if (hinic3_pcie_itf_id(hwdev))
+			return err;
+
+		memset(&hwdev->board_info, 0xff,
+		       sizeof(struct hinic3_board_info));
+	}
+
+	err = hinic3_get_mgmt_version(hwdev, hwdev->mgmt_ver,
+				      HINIC3_MGMT_VERSION_MAX_LEN);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Get mgmt cpu version failed");
+		return err;
+	}
+
+	return 0;
+}
+
+static int
+init_mgmt_channel(struct hinic3_hwdev *hwdev)
+{
+	int err;
+
+	err = hinic3_aeqs_init(hwdev);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Init async event queues failed");
+		return err;
+	}
+
+	err = hinic3_comm_pf_to_mgmt_init(hwdev);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Init mgmt channel failed");
+		goto msg_init_err;
+	}
+
+	err = hinic3_func_to_func_init(hwdev);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Init mailbox channel failed");
+		goto func_to_func_init_err;
+	}
+
+	return 0;
+
+func_to_func_init_err:
+	hinic3_comm_pf_to_mgmt_free(hwdev);
+
+msg_init_err:
+	hinic3_aeqs_free(hwdev);
+
+	return err;
+}
+
+static void
+free_mgmt_channel(struct hinic3_hwdev *hwdev)
+{
+	hinic3_func_to_func_free(hwdev);
+	hinic3_comm_pf_to_mgmt_free(hwdev);
+	hinic3_aeqs_free(hwdev);
+}
+
+static int
+init_cmdqs_channel(struct hinic3_hwdev *hwdev)
+{
+	int err;
+
+	err = dma_attr_table_init(hwdev);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Init dma attr table failed");
+		goto dma_attr_init_err;
+	}
+
+	err = init_aeqs_msix_attr(hwdev);
+	if (err)
+		goto init_aeqs_msix_err;
+
+	/* Set default wq page_size. */
+	hwdev->wq_page_size = HINIC3_DEFAULT_WQ_PAGE_SIZE;
+	err = hinic3_set_wq_page_size(hwdev, hinic3_global_func_id(hwdev),
+				      hwdev->wq_page_size);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Set wq page size failed");
+		goto init_wq_pg_size_err;
+	}
+
+	err = hinic3_comm_cmdqs_init(hwdev);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Init cmd queues failed");
+		goto cmdq_init_err;
+	}
+
+	return 0;
+
+cmdq_init_err:
+	if (HINIC3_FUNC_TYPE(hwdev) != TYPE_VF)
+		hinic3_set_wq_page_size(hwdev, hinic3_global_func_id(hwdev),
+					HINIC3_HW_WQ_PAGE_SIZE);
+init_wq_pg_size_err:
+init_aeqs_msix_err:
+dma_attr_init_err:
+
+	return err;
+}
+
+static int
+hinic3_init_comm_ch(struct hinic3_hwdev *hwdev)
+{
+	int err;
+
+	err = init_mgmt_channel(hwdev);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Init mgmt channel failed");
+		return err;
+	}
+
+	err = get_func_misc_info(hwdev);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Get function msic information failed");
+		goto get_func_info_err;
+	}
+
+	err = hinic3_func_reset(hwdev, HINIC3_NIC_RES | HINIC3_COMM_RES);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Reset function failed");
+		goto func_reset_err;
+	}
+
+	err = hinic3_set_func_svc_used_state(hwdev, HINIC3_MOD_COMM, 1);
+	if (err)
+		goto set_used_state_err;
+
+	err = init_cmdqs_channel(hwdev);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Init cmdq channel failed");
+		goto init_cmdqs_channel_err;
+	}
+
+	hinic3_sync_mgmt_func_state(hwdev);
+
+	return 0;
+
+init_cmdqs_channel_err:
+	hinic3_set_func_svc_used_state(hwdev, HINIC3_MOD_COMM, 0);
+set_used_state_err:
+func_reset_err:
+get_func_info_err:
+	free_mgmt_channel(hwdev);
+
+	return err;
+}
+
+static void
+hinic3_uninit_comm_ch(struct hinic3_hwdev *hwdev)
+{
+	hinic3_set_pf_status(hwdev->hwif, HINIC3_PF_STATUS_INIT);
+
+	hinic3_comm_cmdqs_free(hwdev);
+
+	if (HINIC3_FUNC_TYPE(hwdev) != TYPE_VF)
+		hinic3_set_wq_page_size(hwdev, hinic3_global_func_id(hwdev),
+					HINIC3_HW_WQ_PAGE_SIZE);
+
+	hinic3_set_func_svc_used_state(hwdev, HINIC3_MOD_COMM, 0);
+
+	hinic3_func_to_func_free(hwdev);
+
+	hinic3_comm_pf_to_mgmt_free(hwdev);
+
+	hinic3_aeqs_free(hwdev);
+}
+
+int
+hinic3_init_hwdev(struct hinic3_hwdev *hwdev)
+{
+	int err;
+
+	hwdev->chip_fault_stats = rte_zmalloc("chip_fault_stats",
+					      HINIC3_CHIP_FAULT_SIZE,
+					      RTE_CACHE_LINE_SIZE);
+	if (!hwdev->chip_fault_stats) {
+		PMD_DRV_LOG(ERR, "Alloc memory for chip_fault_stats failed");
+		return -ENOMEM;
+	}
+
+	err = hinic3_init_hwif(hwdev);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Initialize hwif failed");
+		goto init_hwif_err;
+	}
+
+	err = hinic3_init_comm_ch(hwdev);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Init communication channel failed");
+		goto init_comm_ch_err;
+	}
+
+	err = hinic3_init_cfg_mgmt(hwdev);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Init cfg_mgnt failed");
+		goto init_cfg_err;
+	}
+
+	err = hinic3_init_capability(hwdev);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Init capability failed");
+		goto init_cap_err;
+	}
+
+	return 0;
+
+init_cap_err:
+	hinic3_deinit_cfg_mgmt(hwdev);
+init_cfg_err:
+	hinic3_uninit_comm_ch(hwdev);
+
+init_comm_ch_err:
+	hinic3_deinit_hwif(hwdev);
+
+init_hwif_err:
+	rte_free(hwdev->chip_fault_stats);
+
+	return -EFAULT;
+}
+
+void
+hinic3_free_hwdev(struct hinic3_hwdev *hwdev)
+{
+	hinic3_deinit_cfg_mgmt(hwdev);
+
+	hinic3_uninit_comm_ch(hwdev);
+
+	hinic3_deinit_hwif(hwdev);
+
+	rte_free(hwdev->chip_fault_stats);
+}
+
+const struct rte_memzone *
+hinic3_dma_zone_reserve(const struct rte_eth_dev *dev, const char *ring_name,
+			uint16_t queue_id, size_t size, unsigned int align,
+			int socket_id)
+{
+	return rte_eth_dma_zone_reserve(dev, ring_name, queue_id, size, align,
+					socket_id);
+}
+
+int
+hinic3_memzone_free(const struct rte_memzone *mz)
+{
+	return rte_memzone_free(mz);
+}
diff --git a/drivers/net/hinic3/base/hinic3_hwdev.h b/drivers/net/hinic3/base/hinic3_hwdev.h
new file mode 100644
index 0000000000..dd3288e33f
--- /dev/null
+++ b/drivers/net/hinic3/base/hinic3_hwdev.h
@@ -0,0 +1,180 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd
+ */
+
+#ifndef _HINIC3_HWDEV_H_
+#define _HINIC3_HWDEV_H_
+
+#include <ethdev_pci.h>
+#include "hinic3_mgmt.h"
+
+struct cfg_mgmt_info;
+
+struct hinic3_hwif;
+struct hinic3_aeqs;
+struct hinic3_mbox;
+struct hinic3_msg_pf_to_mgmt;
+
+#define MGMT_VERSION_MAX_LEN 32
+
+enum hinic3_set_arm_type {
+	HINIC3_SET_ARM_CMDQ,
+	HINIC3_SET_ARM_SQ,
+	HINIC3_SET_ARM_TYPE_NUM
+};
+
+struct hinic3_page_addr {
+	void *virt_addr;
+	uint64_t phys_addr;
+};
+
+struct ffm_intr_info {
+	uint8_t node_id;
+	/* Error level of the interrupt source. */
+	uint8_t err_level;
+	/* Classification by interrupt source properties. */
+	uint16_t err_type;
+	uint32_t err_csr_addr;
+	uint32_t err_csr_value;
+};
+
+struct link_event_stats {
+	RTE_ATOMIC(int32_t)link_down_stats;
+	RTE_ATOMIC(int32_t)link_up_stats;
+};
+
+enum hinic3_fault_err_level {
+	FAULT_LEVEL_FATAL,
+	FAULT_LEVEL_SERIOUS_RESET,
+	FAULT_LEVEL_SERIOUS_FLR,
+	FAULT_LEVEL_GENERAL,
+	FAULT_LEVEL_SUGGESTION,
+	FAULT_LEVEL_MAX
+};
+
+enum hinic3_fault_type {
+	FAULT_TYPE_CHIP,
+	FAULT_TYPE_UCODE,
+	FAULT_TYPE_MEM_RD_TIMEOUT,
+	FAULT_TYPE_MEM_WR_TIMEOUT,
+	FAULT_TYPE_REG_RD_TIMEOUT,
+	FAULT_TYPE_REG_WR_TIMEOUT,
+	FAULT_TYPE_PHY_FAULT,
+	FAULT_TYPE_MAX
+};
+
+struct fault_event_stats {
+	RTE_ATOMIC(int32_t)chip_fault_stats[22][FAULT_LEVEL_MAX];
+	RTE_ATOMIC(int32_t)fault_type_stat[FAULT_TYPE_MAX];
+	RTE_ATOMIC(int32_t)pcie_fault_stats;
+};
+
+struct hinic3_hw_stats {
+	RTE_ATOMIC(int32_t)heart_lost_stats;
+	struct link_event_stats link_event_stats;
+	struct fault_event_stats fault_event_stats;
+};
+
+#define HINIC3_CHIP_FAULT_SIZE (110 * 1024)
+#define MAX_DRV_BUF_SIZE       4096
+
+struct nic_cmd_chip_fault_stats {
+	uint32_t offset;
+	uint8_t chip_fault_stats[MAX_DRV_BUF_SIZE];
+};
+
+struct hinic3_board_info {
+	uint8_t board_type;
+	uint8_t port_num;
+	uint8_t port_speed;
+	uint8_t pcie_width;
+	uint8_t host_num;
+	uint8_t pf_num;
+	uint16_t vf_total_num;
+	uint8_t tile_num;
+	uint8_t qcm_num;
+	uint8_t core_num;
+	uint8_t work_mode;
+	uint8_t service_mode;
+	uint8_t pcie_mode;
+	uint8_t boot_sel;
+	uint8_t board_id;
+	uint32_t cfg_addr;
+	uint32_t service_en_bitmap;
+	uint8_t scenes_id;
+	uint8_t cfg_template_id;
+	uint16_t rsvd0;
+};
+
+struct hinic3_handler_info {
+	uint16_t cmd;
+	void *buf_in;
+	uint16_t in_size;
+	void *buf_out;
+	uint16_t *out_size;
+};
+
+struct hinic3_hwdev {
+	void *dev_handle; /**< Pointer to hinic3_nic_dev. */
+	struct rte_pci_device *pci_dev;	  /**< Pointer to rte_pci_device. */
+	struct rte_eth_dev *eth_dev;	  /**< Pointer to rte_eth_dev. */
+
+	uint16_t port_id;
+
+	uint32_t wq_page_size;
+
+	struct hinic3_hwif *hwif;
+	struct cfg_mgmt_info *cfg_mgmt;
+
+	struct hinic3_cmdqs *cmdqs;
+	struct hinic3_aeqs *aeqs;
+	struct hinic3_mbox *func_to_func;
+	struct hinic3_msg_pf_to_mgmt *pf_to_mgmt;
+	struct hinic3_hw_stats hw_stats;
+	uint8_t *chip_fault_stats;
+
+	struct hinic3_board_info board_info;
+	char mgmt_ver[MGMT_VERSION_MAX_LEN];
+
+	uint16_t max_vfs;
+	uint16_t link_status;
+};
+
+bool hinic3_is_vfio_iommu_enable(const struct rte_eth_dev *rte_dev);
+
+int vf_handle_pf_comm_mbox(struct hinic3_hwdev *hwdev, __rte_unused void *pri_handle,
+				struct hinic3_handler_info *handler_info);
+
+/**
+ * Handle management communication events for the PF.
+ *
+ * Processes the event based on the command, and calls the corresponding
+ * handler if supported.
+ *
+ * @param[in] handle
+ * Pointer to the hardware device context.
+ * @param[in] cmd
+ * Command associated with the management event.
+ * @param[in] buf_in
+ * Input buffer containing event data.
+ * @param[in] in_size
+ * Size of the input buffer.
+ * @param[out] buf_out
+ * Output buffer to store event response.
+ * @param[out] out_size
+ * Size of the output buffer.
+ */
+void pf_handle_mgmt_comm_event(struct hinic3_hwdev *hwdev, __rte_unused void *pri_handle,
+					struct hinic3_handler_info *handler_info);
+
+int hinic3_init_hwdev(struct hinic3_hwdev *hwdev);
+
+void hinic3_free_hwdev(struct hinic3_hwdev *hwdev);
+
+const struct rte_memzone *
+hinic3_dma_zone_reserve(const struct rte_eth_dev *dev, const char *ring_name,
+			uint16_t queue_id, size_t size, unsigned int align, int socket_id);
+
+int hinic3_memzone_free(const struct rte_memzone *mz);
+
+#endif /* _HINIC3_HWDEV_H_ */
diff --git a/drivers/net/hinic3/base/meson.build b/drivers/net/hinic3/base/meson.build
index 7742db4b77..881d1203c6 100644
--- a/drivers/net/hinic3/base/meson.build
+++ b/drivers/net/hinic3/base/meson.build
@@ -4,6 +4,9 @@
 sources = files(
         'hinic3_cmdq.c',
         'hinic3_eqs.c',
+        'hinic3_hw_cfg.c',
+        'hinic3_hw_comm.c',
+        'hinic3_hwdev.c',
         'hinic3_hwif.c',
         'hinic3_mgmt.c',
         'hinic3_nic_event.c',
-- 
2.47.0.windows.2

