Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D51DCD3436
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 May 2026 01:46:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E33C640693;
	Thu,  7 May 2026 03:45:13 +0200 (CEST)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by mails.dpdk.org (Postfix) with ESMTP id B70DB4025A
 for <dev@dpdk.org>; Thu,  7 May 2026 03:45:04 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-05 (Coremail) with SMTP id zQCowAAnfhGb7vtpgu2XDw--.6790S7;
 Thu, 07 May 2026 09:45:01 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v11 5/9] drivers: add base driver probe skeleton
Date: Thu,  7 May 2026 09:44:45 +0800
Message-ID: <20260507014454.1370039-6-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260507014454.1370039-1-liujie5@linkdatatechnology.com>
References: <20260506113557.1151250-11-liujie5@linkdatatechnology.com>
 <20260507014454.1370039-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowAAnfhGb7vtpgu2XDw--.6790S7
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
 VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUOD7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E
 6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14
 v26r126s0DM28IrcIa0xkI8VCY1x0267AKxVW8JVW5JwA2ocxC64kIII0Yj41l84x0c7CE
 w4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6x
 kF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF
 7I0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487M2AExVAIFx02aVAFz4v204
 v7Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280
 aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67
 IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0F24lw4CEx2IqxVAFz4v204v26I0v724l42xK
 82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGw
 C20s026x8GjcxK67AKxVWUJVWUGwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48J
 MIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMI
 IF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
 87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU1PfHUUUUU
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

Initialize the eth_dev_ops for the sxe2 PMD. This includes the
implementation of mandatory ethdev operations such as dev_configure,
dev_start, dev_stop, and dev_infos_get.

Set up the basic infrastructure for device initialization to allow
the driver to be recognized as a valid ethernet device within the
DPDK framework.

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/common/sxe2/sxe2_ioctl_chnl.c      |  27 +
 drivers/common/sxe2/sxe2_ioctl_chnl_func.h |   9 +
 drivers/net/meson.build                    |   1 +
 drivers/net/sxe2/meson.build               |  28 +
 drivers/net/sxe2/sxe2_cmd_chnl.c           | 319 +++++++++++
 drivers/net/sxe2/sxe2_cmd_chnl.h           |  33 ++
 drivers/net/sxe2/sxe2_drv_cmd.h            | 398 +++++++++++++
 drivers/net/sxe2/sxe2_ethdev.c             | 633 +++++++++++++++++++++
 drivers/net/sxe2/sxe2_ethdev.h             | 295 ++++++++++
 drivers/net/sxe2/sxe2_irq.h                |  49 ++
 drivers/net/sxe2/sxe2_queue.c              |  39 ++
 drivers/net/sxe2/sxe2_queue.h              | 227 ++++++++
 drivers/net/sxe2/sxe2_txrx_common.h        | 541 ++++++++++++++++++
 drivers/net/sxe2/sxe2_txrx_poll.h          |  16 +
 drivers/net/sxe2/sxe2_vsi.c                | 211 +++++++
 drivers/net/sxe2/sxe2_vsi.h                | 205 +++++++
 16 files changed, 3031 insertions(+)
 create mode 100644 drivers/net/sxe2/meson.build
 create mode 100644 drivers/net/sxe2/sxe2_cmd_chnl.c
 create mode 100644 drivers/net/sxe2/sxe2_cmd_chnl.h
 create mode 100644 drivers/net/sxe2/sxe2_drv_cmd.h
 create mode 100644 drivers/net/sxe2/sxe2_ethdev.c
 create mode 100644 drivers/net/sxe2/sxe2_ethdev.h
 create mode 100644 drivers/net/sxe2/sxe2_irq.h
 create mode 100644 drivers/net/sxe2/sxe2_queue.c
 create mode 100644 drivers/net/sxe2/sxe2_queue.h
 create mode 100644 drivers/net/sxe2/sxe2_txrx_common.h
 create mode 100644 drivers/net/sxe2/sxe2_txrx_poll.h
 create mode 100644 drivers/net/sxe2/sxe2_vsi.c
 create mode 100644 drivers/net/sxe2/sxe2_vsi.h

diff --git a/drivers/common/sxe2/sxe2_ioctl_chnl.c b/drivers/common/sxe2/sxe2_ioctl_chnl.c
index db09dd3126..e22731065d 100644
--- a/drivers/common/sxe2/sxe2_ioctl_chnl.c
+++ b/drivers/common/sxe2/sxe2_ioctl_chnl.c
@@ -159,3 +159,30 @@ sxe2_drv_dev_handshark(struct sxe2_common_device *cdev)
 l_end:
 	return ret;
 }
+
+RTE_EXPORT_INTERNAL_SYMBOL(sxe2_drv_dev_munmap)
+s32
+sxe2_drv_dev_munmap(struct sxe2_common_device *cdev, void *virt, u64 len)
+{
+	s32 ret = SXE2_SUCCESS;
+
+	if (cdev->config.kernel_reset) {
+		ret = SXE2_ERR_PERM;
+		PMD_LOG_WARN(COM, "kernel reseted, need restart app.");
+		goto l_end;
+	}
+
+	PMD_LOG_DEBUG(COM, "Munmap virt=%p, len=0x%zx",
+		virt, len);
+
+	ret = munmap(virt, len);
+	if (ret < 0) {
+		PMD_LOG_ERR(COM, "Failed to munmap, virt=%p, len=0x%zx, err:%s",
+			virt, len, strerror(errno));
+		ret = SXE2_ERR_IO;
+		goto l_end;
+	}
+
+l_end:
+	return ret;
+}
diff --git a/drivers/common/sxe2/sxe2_ioctl_chnl_func.h b/drivers/common/sxe2/sxe2_ioctl_chnl_func.h
index 0c3cb9caea..376c5e3ac7 100644
--- a/drivers/common/sxe2/sxe2_ioctl_chnl_func.h
+++ b/drivers/common/sxe2/sxe2_ioctl_chnl_func.h
@@ -38,6 +38,15 @@ __rte_internal
 s32
 sxe2_drv_dev_handshark(struct sxe2_common_device *cdev);
 
+__rte_internal
+void
+*sxe2_drv_dev_mmap(struct sxe2_common_device *cdev, u8 bar_idx,
+		u64 len, u64 offset);
+
+__rte_internal
+s32
+sxe2_drv_dev_munmap(struct sxe2_common_device *cdev, void *virt, u64 len);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/drivers/net/meson.build b/drivers/net/meson.build
index c7dae4ad27..4e8ccb945f 100644
--- a/drivers/net/meson.build
+++ b/drivers/net/meson.build
@@ -58,6 +58,7 @@ drivers = [
         'rnp',
         'sfc',
         'softnic',
+        'sxe2',
         'tap',
         'thunderx',
         'txgbe',
diff --git a/drivers/net/sxe2/meson.build b/drivers/net/sxe2/meson.build
new file mode 100644
index 0000000000..98d0b7fc6d
--- /dev/null
+++ b/drivers/net/sxe2/meson.build
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+#执行子目录base，并获取目标对象
+
+if is_windows
+        build = false
+        reason = 'only supported on Linux'
+        subdir_done()
+endif
+
+cflags += ['-DSXE2_DPDK_DRIVER']
+cflags += ['-DFPGA_VER_ASIC']
+if arch_subdir != 'arm'
+        cflags += ['-Werror']
+endif
+
+cflags += ['-g']
+
+deps += ['common_sxe2', 'hash','cryptodev','security']
+
+sources += files(
+        'sxe2_ethdev.c',
+        'sxe2_cmd_chnl.c',
+        'sxe2_vsi.c',
+        'sxe2_queue.c',
+)
+
+allow_internal_get_api = true
diff --git a/drivers/net/sxe2/sxe2_cmd_chnl.c b/drivers/net/sxe2/sxe2_cmd_chnl.c
new file mode 100644
index 0000000000..b9749b0a08
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_cmd_chnl.c
@@ -0,0 +1,319 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#include "sxe2_ioctl_chnl_func.h"
+#include "sxe2_drv_cmd.h"
+#include "sxe2_cmd_chnl.h"
+#include "sxe2_ethdev.h"
+#include "sxe2_common_log.h"
+#include "sxe2_errno.h"
+
+static union sxe2_drv_trace_info sxe2_drv_trace_id;
+
+static void sxe2_drv_trace_id_alloc(u64 *trace_id)
+{
+	union sxe2_drv_trace_info *trace = NULL;
+	u64 trace_id_count = 0;
+
+	trace = &sxe2_drv_trace_id;
+
+	trace_id_count = trace->sxe2_drv_trace_id_param.count;
+	++trace_id_count;
+	trace->sxe2_drv_trace_id_param.count =
+			(trace_id_count & SXE2_DRV_TRACE_ID_COUNT_MASK);
+
+	*trace_id = trace->id;
+}
+
+static void __sxe2_drv_cmd_params_fill(struct sxe2_adapter *adapter,
+		struct sxe2_drv_cmd_params *cmd, u32 opc, const char *opc_str,
+		void *in_data, u32 in_len, void *out_data, u32 out_len)
+{
+	PMD_DEV_LOG_DEBUG(adapter, DRV, "cmd opcode:%s", opc_str);
+	cmd->timeout = SXE2_DRV_CMD_DFLT_TIMEOUT;
+	cmd->opcode  = opc;
+	cmd->vsi_id  = adapter->vsi_ctxt.dpdk_vsi_id;
+	cmd->repr_id = (adapter->repr_priv_data != NULL) ?
+			adapter->repr_priv_data->repr_id : 0xFFFF;
+	cmd->req_len = in_len;
+	cmd->req_data = in_data;
+	cmd->resp_len = out_len;
+	cmd->resp_data = out_data;
+
+	sxe2_drv_trace_id_alloc(&cmd->trace_id);
+}
+
+#define sxe2_drv_cmd_params_fill(adapter, cmd, opc, in_data, in_len, out_data, out_len) \
+	__sxe2_drv_cmd_params_fill(adapter, cmd, opc, #opc, in_data, in_len, out_data, out_len)
+
+
+s32 sxe2_drv_dev_caps_get(struct sxe2_adapter *adapter, struct sxe2_drv_dev_caps_resp *dev_caps)
+{
+	s32 ret = SXE2_SUCCESS;
+	struct sxe2_common_device *cdev = adapter->cdev;
+	struct sxe2_drv_cmd_params param = {0};
+
+	sxe2_drv_cmd_params_fill(adapter, &param, SXE2_DRV_CMD_DEV_GET_CAPS,
+			NULL, 0, dev_caps,
+			sizeof(struct sxe2_drv_dev_caps_resp));
+
+	ret = sxe2_drv_cmd_exec(cdev, &param);
+	if (ret)
+		PMD_DEV_LOG_ERR(adapter, DRV, "get dev caps failed, ret=%d", ret);
+
+	return ret;
+}
+
+s32 sxe2_drv_dev_info_get(struct sxe2_adapter *adapter,
+				struct sxe2_drv_dev_info_resp *dev_info_resp)
+{
+	s32 ret = SXE2_SUCCESS;
+	struct sxe2_common_device *cdev = adapter->cdev;
+	struct sxe2_drv_cmd_params param = {0};
+
+	sxe2_drv_cmd_params_fill(adapter, &param, SXE2_DRV_CMD_DEV_GET_INFO,
+			NULL, 0, dev_info_resp,
+			sizeof(struct sxe2_drv_dev_info_resp));
+
+	ret = sxe2_drv_cmd_exec(cdev, &param);
+	if (ret)
+		PMD_DEV_LOG_ERR(adapter, DRV, "get dev info failed, ret=%d", ret);
+
+	return ret;
+}
+
+s32 sxe2_drv_dev_fw_info_get(struct sxe2_adapter *adapter,
+				struct sxe2_drv_dev_fw_info_resp *dev_fw_info_resp)
+{
+	s32 ret = SXE2_SUCCESS;
+	struct sxe2_common_device *cdev = adapter->cdev;
+	struct sxe2_drv_cmd_params param = {0};
+
+	sxe2_drv_cmd_params_fill(adapter, &param, SXE2_DRV_CMD_DEV_GET_FW_INFO,
+			NULL, 0, dev_fw_info_resp,
+			sizeof(struct sxe2_drv_dev_fw_info_resp));
+
+	ret = sxe2_drv_cmd_exec(cdev, &param);
+	if (ret)
+		PMD_DEV_LOG_ERR(adapter, DRV, "get dev fw info failed, ret=%d", ret);
+
+	return ret;
+}
+
+s32 sxe2_drv_vsi_add(struct sxe2_adapter *adapter, struct sxe2_vsi *vsi)
+{
+	s32 ret = SXE2_SUCCESS;
+	struct sxe2_common_device *cdev = adapter->cdev;
+	struct sxe2_drv_cmd_params param = {0};
+	struct sxe2_drv_vsi_create_req_resp vsi_req = {0};
+	struct sxe2_drv_vsi_create_req_resp vsi_resp = {0};
+
+	vsi_req.vsi_id = vsi->vsi_id;
+
+	vsi_req.used_queues.queues_cnt = RTE_MIN(vsi->txqs.q_cnt, vsi->rxqs.q_cnt);
+	vsi_req.used_queues.base_idx_in_pf = vsi->txqs.base_idx_in_func;
+	vsi_req.used_msix.msix_vectors_cnt = vsi->irqs.avail_cnt;
+	vsi_req.used_msix.base_idx_in_func = vsi->irqs.base_idx_in_pf;
+
+	sxe2_drv_cmd_params_fill(adapter, &param, SXE2_DRV_CMD_VSI_CREATE,
+			&vsi_req,  sizeof(struct sxe2_drv_vsi_create_req_resp),
+			&vsi_resp, sizeof(struct sxe2_drv_vsi_create_req_resp));
+
+	ret = sxe2_drv_cmd_exec(cdev, &param);
+	if (ret) {
+		PMD_DEV_LOG_ERR(adapter, DRV, "dev add vsi failed, ret=%d", ret);
+		goto l_end;
+	}
+
+	vsi->vsi_id = vsi_resp.vsi_id;
+	vsi->vsi_type = vsi_resp.vsi_type;
+
+l_end:
+	return ret;
+}
+
+s32 sxe2_drv_vsi_del(struct sxe2_adapter *adapter, struct sxe2_vsi *vsi)
+{
+	s32 ret = SXE2_SUCCESS;
+	struct sxe2_common_device *cdev = adapter->cdev;
+	struct sxe2_drv_cmd_params param = {0};
+	struct sxe2_drv_vsi_free_req vsi_req = {0};
+
+	vsi_req.vsi_id = vsi->vsi_id;
+
+	sxe2_drv_cmd_params_fill(adapter, &param, SXE2_DRV_CMD_VSI_FREE,
+				&vsi_req, sizeof(struct sxe2_drv_vsi_free_req),
+				NULL, 0);
+
+	ret = sxe2_drv_cmd_exec(cdev, &param);
+	if (ret)
+		PMD_DEV_LOG_ERR(adapter, DRV, "dev del vsi failed, ret=%d", ret);
+
+	return ret;
+}
+
+#define SXE2_RXQ_CTXT_CFG_BUF_LEN_ALIGN  (1 << 7)
+#define SXE2_RX_HDR_SIZE 256
+
+static s32 sxe2_rxq_ctxt_cfg_fill(struct sxe2_rx_queue *rxq,
+		struct sxe2_drv_rxq_cfg_req *req, u16 rxq_cnt)
+{
+	struct sxe2_adapter *adapter = rxq->vsi->adapter;
+	struct sxe2_drv_rxq_ctxt *ctxt = req->cfg;
+	struct rte_eth_dev_data *dev_data = adapter->dev_info.dev_data;
+	s32 ret = SXE2_SUCCESS;
+
+	req->vsi_id = adapter->vsi_ctxt.main_vsi->vsi_id;
+	req->q_cnt = rxq_cnt;
+	req->max_frame_size = dev_data->mtu + SXE2_ETH_OVERHEAD;
+
+	ctxt->queue_id = rxq->queue_id;
+	ctxt->depth = rxq->ring_depth;
+	ctxt->buf_len = RTE_ALIGN(rxq->rx_buf_len, SXE2_RXQ_CTXT_CFG_BUF_LEN_ALIGN);
+	ctxt->dma_addr = rxq->base_addr;
+
+	if (rxq->offloads & RTE_ETH_RX_OFFLOAD_TCP_LRO) {
+		ctxt->lro_en = 1;
+		ctxt->max_lro_size = dev_data->dev_conf.rxmode.max_lro_pkt_size;
+	} else {
+		ctxt->lro_en = 0;
+	}
+
+	if (rxq->offloads & RTE_ETH_RX_OFFLOAD_KEEP_CRC)
+		ctxt->keep_crc_en = 1;
+	else
+		ctxt->keep_crc_en = 0;
+
+	ctxt->desc_size = sizeof(union sxe2_rx_desc);
+	return ret;
+}
+
+s32 sxe2_drv_rxq_ctxt_cfg(struct sxe2_adapter *adapter, struct sxe2_rx_queue *rxq, u16 rxq_cnt)
+{
+	s32 ret = SXE2_SUCCESS;
+	struct sxe2_common_device *cdev = adapter->cdev;
+	struct sxe2_drv_cmd_params param = {0};
+	struct sxe2_drv_rxq_cfg_req *req = NULL;
+	u16 len = 0;
+
+	len = sizeof(*req) + rxq_cnt * sizeof(struct sxe2_drv_rxq_ctxt);
+	req = rte_zmalloc("sxe2_rxq_cfg", len, 0);
+	if (req == NULL) {
+		PMD_LOG_ERR(RX, "rxq cfg mem alloc failed");
+		ret = SXE2_ERR_NO_MEMORY;
+		goto l_end;
+	}
+
+	ret = sxe2_rxq_ctxt_cfg_fill(rxq, req, rxq_cnt);
+	if (ret) {
+		PMD_DEV_LOG_ERR(adapter, DRV, "rxq cfg failed, ret=%d", ret);
+		ret = SXE2_ERR_INVAL;
+		goto l_end;
+	}
+
+	sxe2_drv_cmd_params_fill(adapter, &param, SXE2_DRV_CMD_RXQ_CFG_ENABLE,
+			req, len, NULL, 0);
+
+	ret = sxe2_drv_cmd_exec(cdev, &param);
+	if (ret)
+		PMD_DEV_LOG_ERR(adapter, DRV, "rxq cfg failed, ret=%d", ret);
+
+l_end:
+	if (req)
+		rte_free(req);
+	return ret;
+}
+
+static void sxe2_txq_ctxt_cfg_fill(struct sxe2_tx_queue *txq,
+		struct sxe2_drv_txq_cfg_req *req, u16 txq_cnt)
+{
+	struct sxe2_drv_txq_ctxt *ctxt = req->cfg;
+	u16 q_idx = 0;
+
+	req->vsi_id = txq->vsi->vsi_id;
+	req->q_cnt = txq_cnt;
+
+	for (q_idx = 0; q_idx < txq_cnt; q_idx++) {
+		ctxt = &req->cfg[q_idx];
+		ctxt->depth = txq[q_idx].ring_depth;
+		ctxt->dma_addr = txq[q_idx].base_addr;
+		ctxt->queue_id = txq[q_idx].queue_id;
+	}
+}
+
+s32 sxe2_drv_txq_ctxt_cfg(struct sxe2_adapter *adapter, struct sxe2_tx_queue *txq, u16 txq_cnt)
+{
+	s32 ret = SXE2_SUCCESS;
+	struct sxe2_common_device *cdev = adapter->cdev;
+	struct sxe2_drv_cmd_params param = {0};
+	struct sxe2_drv_txq_cfg_req *req;
+	u16 len = 0;
+
+	len = sizeof(*req) + txq_cnt * sizeof(struct sxe2_drv_txq_ctxt);
+	req = rte_zmalloc("sxe2_txq_cfg", len, 0);
+	if (req == NULL) {
+		PMD_LOG_ERR(TX, "txq cfg mem alloc failed");
+		ret = SXE2_ERR_NO_MEMORY;
+		goto l_end;
+	}
+
+	sxe2_txq_ctxt_cfg_fill(txq, req, txq_cnt);
+
+	sxe2_drv_cmd_params_fill(adapter, &param, SXE2_DRV_CMD_TXQ_CFG_ENABLE,
+			req, len, NULL, 0);
+
+	ret = sxe2_drv_cmd_exec(cdev, &param);
+	if (ret)
+		PMD_DEV_LOG_ERR(adapter, DRV, "txq cfg failed, ret=%d", ret);
+
+l_end:
+	if (req)
+		rte_free(req);
+	return ret;
+}
+
+s32 sxe2_drv_rxq_switch(struct sxe2_adapter *adapter, struct sxe2_rx_queue *rxq, bool enable)
+{
+	s32 ret = SXE2_SUCCESS;
+	struct sxe2_common_device *cdev = adapter->cdev;
+	struct sxe2_drv_cmd_params param = {0};
+	struct sxe2_drv_q_switch_req req;
+
+	req.vsi_id = rte_cpu_to_le_16(rxq->vsi->vsi_id);
+	req.q_idx = rxq->queue_id;
+
+	req.is_enable  = (u8)enable;
+	sxe2_drv_cmd_params_fill(adapter, &param, SXE2_DRV_CMD_RXQ_DISABLE,
+			&req, sizeof(req), NULL, 0);
+
+	ret = sxe2_drv_cmd_exec(cdev, &param);
+	if (ret)
+		PMD_DEV_LOG_ERR(adapter, DRV, "rxq switch failed, enable: %d, ret:%d",
+			enable, ret);
+
+	return ret;
+}
+
+s32 sxe2_drv_txq_switch(struct sxe2_adapter *adapter, struct sxe2_tx_queue *txq, bool enable)
+{
+	s32 ret = SXE2_SUCCESS;
+	struct sxe2_common_device *cdev = adapter->cdev;
+	struct sxe2_drv_cmd_params param = {0};
+	struct sxe2_drv_q_switch_req req;
+
+	req.vsi_id = rte_cpu_to_le_16(txq->vsi->vsi_id);
+	req.q_idx = txq->queue_id;
+
+	req.is_enable  = (u8)enable;
+	sxe2_drv_cmd_params_fill(adapter, &param, SXE2_DRV_CMD_TXQ_DISABLE,
+			&req, sizeof(req), NULL, 0);
+
+	ret = sxe2_drv_cmd_exec(cdev, &param);
+	if (ret) {
+		PMD_DEV_LOG_ERR(adapter, DRV, "txq switch failed, enable: %d, ret:%d",
+				enable, ret);
+	}
+
+	return ret;
+}
diff --git a/drivers/net/sxe2/sxe2_cmd_chnl.h b/drivers/net/sxe2/sxe2_cmd_chnl.h
new file mode 100644
index 0000000000..200fe0be00
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_cmd_chnl.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#ifndef __SXE2_CMD_CHNL_H__
+#define __SXE2_CMD_CHNL_H__
+
+#include "sxe2_ethdev.h"
+#include "sxe2_drv_cmd.h"
+#include "sxe2_ioctl_chnl_func.h"
+
+s32 sxe2_drv_dev_caps_get(struct sxe2_adapter *adapter,
+		struct sxe2_drv_dev_caps_resp *dev_caps);
+
+s32 sxe2_drv_dev_info_get(struct sxe2_adapter *adapter,
+		struct sxe2_drv_dev_info_resp *dev_info_resp);
+
+s32 sxe2_drv_dev_fw_info_get(struct sxe2_adapter *adapter,
+		struct sxe2_drv_dev_fw_info_resp *dev_fw_info_resp);
+
+s32 sxe2_drv_vsi_add(struct sxe2_adapter *adapter, struct sxe2_vsi *vsi);
+
+s32 sxe2_drv_vsi_del(struct sxe2_adapter *adapter, struct sxe2_vsi *vsi);
+
+s32 sxe2_drv_rxq_switch(struct sxe2_adapter *adapter, struct sxe2_rx_queue *rxq, bool enable);
+
+s32 sxe2_drv_txq_switch(struct sxe2_adapter *adapter, struct sxe2_tx_queue *txq, bool enable);
+
+s32 sxe2_drv_rxq_ctxt_cfg(struct sxe2_adapter *adapter, struct sxe2_rx_queue *rxq, u16 rxq_cnt);
+
+s32 sxe2_drv_txq_ctxt_cfg(struct sxe2_adapter *adapter, struct sxe2_tx_queue *txq, u16 txq_cnt);
+
+#endif
diff --git a/drivers/net/sxe2/sxe2_drv_cmd.h b/drivers/net/sxe2/sxe2_drv_cmd.h
new file mode 100644
index 0000000000..4094442077
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_drv_cmd.h
@@ -0,0 +1,398 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#ifndef __SXE2_DRV_CMD_H__
+#define __SXE2_DRV_CMD_H__
+
+#ifdef SXE2_DPDK_DRIVER
+#include "sxe2_type.h"
+#define SXE2_DPDK_RESOURCE_INSUFFICIENT
+#endif
+
+#ifdef SXE2_LINUX_DRIVER
+#ifdef __KERNEL__
+#include <linux/types.h>
+#include <linux/if_ether.h>
+#endif
+#endif
+
+#define SXE2_DRV_CMD_MODULE_S        (16)
+#define SXE2_MK_DRV_CMD(module, cmd) (((module) << SXE2_DRV_CMD_MODULE_S) | ((cmd) & 0xFFFF))
+
+#define SXE2_DEV_CAPS_OFFLOAD_L2    BIT(0)
+#define SXE2_DEV_CAPS_OFFLOAD_VLAN  BIT(1)
+#define SXE2_DEV_CAPS_OFFLOAD_RSS   BIT(2)
+#define SXE2_DEV_CAPS_OFFLOAD_IPSEC BIT(3)
+#define SXE2_DEV_CAPS_OFFLOAD_FNAV  BIT(4)
+#define SXE2_DEV_CAPS_OFFLOAD_TM    BIT(5)
+#define SXE2_DEV_CAPS_OFFLOAD_PTP   BIT(6)
+#define SXE2_DEV_CAPS_OFFLOAD_Q_MAP BIT(7)
+#define SXE2_DEV_CAPS_OFFLOAD_FC_STATE BIT(8)
+
+#define SXE2_TXQ_STATS_MAP_MAX_NUM 16
+#define SXE2_RXQ_STATS_MAP_MAX_NUM 4
+#define SXE2_RXQ_MAP_Q_MAX_NUM 256
+
+#define SXE2_STAT_MAP_INVALID_QID 0xFFFF
+
+#define SXE2_SCHED_MODE_DEFAULT				0
+#define SXE2_SCHED_MODE_TM					1
+#define SXE2_SCHED_MODE_HIGH_PERFORMANCE	2
+#define SXE2_SCHED_MODE_INVALID				3
+
+#define SXE2_SRCVSI_PRUNE_MAX_NUM			2
+
+#define SXE2_PTYPE_UNKNOWN                   BIT(0)
+#define SXE2_PTYPE_L2_ETHER                  BIT(1)
+#define SXE2_PTYPE_L3_IPV4                   BIT(2)
+#define SXE2_PTYPE_L3_IPV6                   BIT(4)
+#define SXE2_PTYPE_L4_TCP                    BIT(6)
+#define SXE2_PTYPE_L4_UDP                    BIT(7)
+#define SXE2_PTYPE_L4_SCTP                   BIT(8)
+#define SXE2_PTYPE_INNER_L2_ETHER            BIT(9)
+#define SXE2_PTYPE_INNER_L3_IPV4             BIT(10)
+#define SXE2_PTYPE_INNER_L3_IPV6             BIT(12)
+#define SXE2_PTYPE_INNER_L4_TCP              BIT(14)
+#define SXE2_PTYPE_INNER_L4_UDP              BIT(15)
+#define SXE2_PTYPE_INNER_L4_SCTP             BIT(16)
+#define SXE2_PTYPE_TUNNEL_GRENAT             BIT(17)
+
+#define SXE2_PTYPE_L2_MASK       (SXE2_PTYPE_L2_ETHER)
+#define SXE2_PTYPE_L3_MASK       (SXE2_PTYPE_L3_IPV4 | SXE2_PTYPE_L3_IPV6)
+#define SXE2_PTYPE_L4_MASK       (SXE2_PTYPE_L4_TCP | SXE2_PTYPE_L4_UDP | \
+		SXE2_PTYPE_L4_SCTP)
+#define SXE2_PTYPE_INNER_L2_MASK (SXE2_PTYPE_INNER_L2_ETHER)
+#define SXE2_PTYPE_INNER_L3_MASK (SXE2_PTYPE_INNER_L3_IPV4 | \
+		SXE2_PTYPE_INNER_L3_IPV6)
+#define SXE2_PTYPE_INNER_L4_MASK (SXE2_PTYPE_INNER_L4_TCP | \
+		SXE2_PTYPE_INNER_L4_UDP | \
+		SXE2_PTYPE_INNER_L4_SCTP)
+#define SXE2_PTYPE_TUNNEL_MASK   (SXE2_PTYPE_TUNNEL_GRENAT)
+
+enum sxe2_dev_type {
+	SXE2_DEV_T_PF = 0,
+	SXE2_DEV_T_VF,
+	SXE2_DEV_T_PF_BOND,
+	SXE2_DEV_T_MAX,
+};
+
+struct sxe2_drv_queue_caps {
+	__le16 queues_cnt;
+	__le16 base_idx_in_pf;
+};
+
+struct sxe2_drv_msix_caps {
+	__le16 msix_vectors_cnt;
+	__le16 base_idx_in_func;
+};
+
+struct sxe2_drv_rss_hash_caps {
+	__le16 hash_key_size;
+	__le16 lut_key_size;
+};
+
+enum sxe2_vf_vsi_valid {
+	SXE2_VF_VSI_BOTH = 0,
+	SXE2_VF_VSI_ONLY_DPDK,
+	SXE2_VF_VSI_ONLY_KERNEL,
+	SXE2_VF_VSI_MAX,
+};
+
+struct sxe2_drv_vsi_caps {
+	__le16 func_id;
+	__le16 dpdk_vsi_id;
+	__le16 kernel_vsi_id;
+	__le16 vsi_type;
+};
+
+struct sxe2_drv_representor_caps {
+	__le16 cnt_repr_vf;
+	u8 rsv[2];
+	struct sxe2_drv_vsi_caps repr_vf_id[256];
+};
+
+enum sxe2_phys_port_name_type {
+	SXE2_PHYS_PORT_NAME_TYPE_NOTSET = 0,
+	SXE2_PHYS_PORT_NAME_TYPE_LEGACY,
+	SXE2_PHYS_PORT_NAME_TYPE_UPLINK,
+	SXE2_PHYS_PORT_NAME_TYPE_PFVF,
+
+	SXE2_PHYS_PORT_NAME_TYPE_UNKNOWN,
+};
+
+struct sxe2_switchdev_mode_info {
+	u8 pf_id;
+	u8 is_switchdev;
+	u8 rsv[2];
+};
+
+struct sxe2_switchdev_cpvsi_info {
+	__le16 cp_vsi_id;
+	u8 rsv[2];
+};
+
+struct sxe2_txsch_caps {
+	u8 layer_cap;
+	u8 tm_mid_node_num;
+	u8 prio_num;
+	u8 rev;
+};
+
+struct sxe2_drv_dev_caps_resp {
+	struct sxe2_drv_queue_caps queue_caps;
+	struct sxe2_drv_msix_caps msix_caps;
+	struct sxe2_drv_rss_hash_caps rss_hash_caps;
+	struct sxe2_drv_vsi_caps vsi_caps;
+	struct sxe2_txsch_caps   txsch_caps;
+	struct sxe2_drv_representor_caps repr_caps;
+	u8 port_idx;
+	u8 pf_idx;
+	u8 dev_type;
+	u8 rev;
+	__le32 cap_flags;
+};
+
+struct sxe2_drv_dev_info_resp {
+	__le64 dsn;
+	__le16 vsi_id;
+	u8 rsv[2];
+	u8 mac_addr[ETH_ALEN];
+	u8 rsv2[2];
+};
+
+struct sxe2_drv_dev_fw_info_resp {
+	u8 main_version_id;
+	u8 sub_version_id;
+	u8 fix_version_id;
+	u8 build_id;
+};
+
+struct sxe2_drv_rxq_ctxt {
+	__le64 dma_addr;
+	__le32 max_lro_size;
+	__le32 split_type_mask;
+	__le16 hdr_len;
+	__le16 buf_len;
+	__le16 depth;
+	__le16 queue_id;
+	u8 lro_en;
+	u8 keep_crc_en;
+	u8 split_en;
+	u8 desc_size;
+};
+
+struct sxe2_drv_rxq_cfg_req {
+	__le16 q_cnt;
+	__le16 vsi_id;
+	__le16 max_frame_size;
+	u8 rsv[2];
+	struct sxe2_drv_rxq_ctxt cfg[];
+};
+
+struct sxe2_drv_txq_ctxt {
+	__le64 dma_addr;
+	__le32 sched_mode;
+	__le16 queue_id;
+	__le16 depth;
+	__le16 vsi_id;
+	u8 rsv[2];
+};
+
+struct sxe2_drv_txq_cfg_req {
+	__le16 q_cnt;
+	__le16 vsi_id;
+	struct sxe2_drv_txq_ctxt cfg[];
+};
+
+struct sxe2_drv_q_switch_req {
+	__le16 q_idx;
+	__le16 vsi_id;
+	u8 is_enable;
+	u8 sched_mode;
+	u8 rsv[2];
+};
+
+struct sxe2_drv_vsi_create_req_resp {
+	__le16 vsi_id;
+	__le16 vsi_type;
+	struct sxe2_drv_queue_caps used_queues;
+	struct sxe2_drv_msix_caps used_msix;
+};
+
+struct sxe2_drv_vsi_free_req {
+	__le16 vsi_id;
+	u8 rsv[2];
+};
+
+struct sxe2_drv_vsi_info_get_req {
+	__le16 vsi_id;
+	u8 rsv[2];
+};
+
+struct sxe2_drv_vsi_info_get_resp {
+	__le16 vsi_id;
+	__le16 vsi_type;
+	struct sxe2_drv_queue_caps used_queues;
+	struct sxe2_drv_msix_caps used_msix;
+};
+
+enum sxe2_drv_cmd_module {
+	SXE2_DRV_CMD_MODULE_HANDSHAKE = 0,
+	SXE2_DRV_CMD_MODULE_DEV = 1,
+	SXE2_DRV_CMD_MODULE_VSI = 2,
+	SXE2_DRV_CMD_MODULE_QUEUE = 3,
+	SXE2_DRV_CMD_MODULE_STATS = 4,
+	SXE2_DRV_CMD_MODULE_SUBSCRIBE = 5,
+	SXE2_DRV_CMD_MODULE_RSS = 6,
+	SXE2_DRV_CMD_MODULE_FLOW = 7,
+	SXE2_DRV_CMD_MODULE_TM = 8,
+	SXE2_DRV_CMD_MODULE_IPSEC = 9,
+	SXE2_DRV_CMD_MODULE_PTP = 10,
+
+	SXE2_DRV_CMD_MODULE_VLAN = 11,
+	SXE2_DRV_CMD_MODULE_RDMA = 12,
+	SXE2_DRV_CMD_MODULE_LINK = 13,
+	SXE2_DRV_CMD_MODULE_MACADDR = 14,
+	SXE2_DRV_CMD_MODULE_PROMISC = 15,
+
+	SXE2_DRV_CMD_MODULE_LED = 16,
+	SXE2_DEV_CMD_MODULE_OPT = 17,
+	SXE2_DEV_CMD_MODULE_SWITCH = 18,
+	SXE2_DRV_CMD_MODULE_ACL = 19,
+	SXE2_DRV_CMD_MODULE_UDPTUNEEL = 20,
+	SXE2_DRV_CMD_MODULE_QUEUE_MAP = 21,
+
+	SXE2_DRV_CMD_MODULE_SCHED = 22,
+
+	SXE2_DRV_CMD_MODULE_IRQ = 23,
+
+	SXE2_DRV_CMD_MODULE_OPT = 24,
+};
+
+enum sxe2_drv_cmd_code {
+	SXE2_DRV_CMD_HANDSHAKE_ENABLE =
+		SXE2_MK_DRV_CMD(SXE2_DRV_CMD_MODULE_HANDSHAKE, 1),
+	SXE2_DRV_CMD_HANDSHAKE_DISABLE,
+
+	SXE2_DRV_CMD_DEV_GET_CAPS =
+		SXE2_MK_DRV_CMD(SXE2_DRV_CMD_MODULE_DEV, 1),
+	SXE2_DRV_CMD_DEV_GET_INFO,
+	SXE2_DRV_CMD_DEV_GET_FW_INFO,
+	SXE2_DRV_CMD_DEV_RESET,
+	SXE2_DRV_CMD_DEV_GET_SWITCHDEV_INFO,
+
+	SXE2_DRV_CMD_VSI_CREATE =
+		SXE2_MK_DRV_CMD(SXE2_DRV_CMD_MODULE_VSI, 1),
+	SXE2_DRV_CMD_VSI_FREE,
+	SXE2_DRV_CMD_VSI_INFO_GET,
+	SXE2_DRV_CMD_VSI_SRCVSI_PRUNE,
+	SXE2_DRV_CMD_VSI_FC_GET,
+
+	SXE2_DRV_CMD_RX_MAP_SET =
+		SXE2_MK_DRV_CMD(SXE2_DRV_CMD_MODULE_QUEUE_MAP, 1),
+	SXE2_DRV_CMD_TX_MAP_SET,
+	SXE2_DRV_CMD_TX_RX_MAP_GET,
+	SXE2_DRV_CMD_TX_RX_MAP_RESET,
+	SXE2_DRV_CMD_TX_RX_MAP_INFO_CLEAR,
+
+	SXE2_DRV_CMD_SCHED_ROOT_TREE_ALLOC =
+		SXE2_MK_DRV_CMD(SXE2_DRV_CMD_MODULE_SCHED, 1),
+	SXE2_DRV_CMD_SCHED_ROOT_TREE_RELEASE,
+	SXE2_DRV_CMD_SCHED_ROOT_CHILDREN_DELETE,
+	SXE2_DRV_CMD_SCHED_TM_ADD_MID_NODE,
+	SXE2_DRV_CMD_SCHED_TM_ADD_QUEUE_NODE,
+
+	SXE2_DRV_CMD_RXQ_CFG_ENABLE =
+		SXE2_MK_DRV_CMD(SXE2_DRV_CMD_MODULE_QUEUE, 1),
+	SXE2_DRV_CMD_TXQ_CFG_ENABLE,
+	SXE2_DRV_CMD_RXQ_DISABLE,
+	SXE2_DRV_CMD_TXQ_DISABLE,
+
+	SXE2_DRV_CMD_VSI_STATS_GET =
+		SXE2_MK_DRV_CMD(SXE2_DRV_CMD_MODULE_STATS, 1),
+	SXE2_DRV_CMD_VSI_STATS_CLEAR,
+	SXE2_DRV_CMD_MAC_STATS_GET,
+	SXE2_DRV_CMD_MAC_STATS_CLEAR,
+
+	SXE2_DRV_CMD_RSS_KEY_SET =
+		SXE2_MK_DRV_CMD(SXE2_DRV_CMD_MODULE_RSS, 1),
+	SXE2_DRV_CMD_RSS_LUT_SET,
+	SXE2_DRV_CMD_RSS_FUNC_SET,
+	SXE2_DRV_CMD_RSS_HF_ADD,
+	SXE2_DRV_CMD_RSS_HF_DEL,
+	SXE2_DRV_CMD_RSS_HF_CLEAR,
+
+	SXE2_DRV_CMD_FLOW_FILTER_ADD =
+		SXE2_MK_DRV_CMD(SXE2_DRV_CMD_MODULE_FLOW, 1),
+	SXE2_DRV_CMD_FLOW_FILTER_DEL,
+	SXE2_DRV_CMD_FLOW_FILTER_CLEAR,
+	SXE2_DRV_CMD_FLOW_FNAV_STAT_ALLOC,
+	SXE2_DRV_CMD_FLOW_FNAV_STAT_FREE,
+	SXE2_DRV_CMD_FLOW_FNAV_STAT_QUERY,
+
+	SXE2_DRV_CMD_DEL_TM_ROOT =
+		SXE2_MK_DRV_CMD(SXE2_DRV_CMD_MODULE_TM, 1),
+	SXE2_DRV_CMD_ADD_TM_ROOT,
+	SXE2_DRV_CMD_ADD_TM_NODE,
+	SXE2_DRV_CMD_ADD_TM_QUEUE,
+
+	SXE2_DRV_CMD_GET_PTP_CLOCK =
+		SXE2_MK_DRV_CMD(SXE2_DRV_CMD_MODULE_PTP, 1),
+
+	SXE2_DRV_CMD_VLAN_FILTER_ADD_DEL =
+		SXE2_MK_DRV_CMD(SXE2_DRV_CMD_MODULE_VLAN, 1),
+	SXE2_DRV_CMD_VLAN_FILTER_SWITCH,
+	SXE2_DRV_CMD_VLAN_OFFLOAD_CFG,
+	SXE2_DRV_CMD_VLAN_PORTVLAN_CFG,
+	SXE2_DRV_CMD_VLAN_CFG_QUERY,
+
+	SXE2_DRV_CMD_RDMA_DUMP_PCAP =
+		SXE2_MK_DRV_CMD(SXE2_DRV_CMD_MODULE_RDMA, 1),
+
+	SXE2_DRV_CMD_LINK_STATUS_GET =
+		SXE2_MK_DRV_CMD(SXE2_DRV_CMD_MODULE_LINK, 1),
+
+	SXE2_DRV_CMD_MAC_ADDR_UC =
+		SXE2_MK_DRV_CMD(SXE2_DRV_CMD_MODULE_MACADDR, 1),
+	SXE2_DRV_CMD_MAC_ADDR_MC,
+
+	SXE2_DRV_CMD_PROMISC_CFG =
+		SXE2_MK_DRV_CMD(SXE2_DRV_CMD_MODULE_PROMISC, 1),
+	SXE2_DRV_CMD_ALLMULTI_CFG,
+
+	SXE2_DRV_CMD_LED_CTRL =
+		SXE2_MK_DRV_CMD(SXE2_DRV_CMD_MODULE_LED, 1),
+
+	SXE2_DRV_CMD_OPT_EEP =
+		SXE2_MK_DRV_CMD(SXE2_DEV_CMD_MODULE_OPT, 1),
+
+	SXE2_DRV_CMD_SWITCH =
+		SXE2_MK_DRV_CMD(SXE2_DEV_CMD_MODULE_SWITCH, 1),
+	SXE2_DRV_CMD_SWITCH_UPLINK,
+	SXE2_DRV_CMD_SWITCH_REPR,
+	SXE2_DRV_CMD_SWITCH_MODE,
+	SXE2_DRV_CMD_SWITCH_CPVSI,
+
+	SXE2_DRV_CMD_UDPTUNNEL_ADD =
+		SXE2_MK_DRV_CMD(SXE2_DRV_CMD_MODULE_UDPTUNEEL, 1),
+	SXE2_DRV_CMD_UDPTUNNEL_DEL,
+	SXE2_DRV_CMD_UDPTUNNEL_GET,
+
+	SXE2_DRV_CMD_IPSEC_CAP_GET =
+		SXE2_MK_DRV_CMD(SXE2_DRV_CMD_MODULE_IPSEC, 1),
+	SXE2_DRV_CMD_IPSEC_TXSA_ADD,
+	SXE2_DRV_CMD_IPSEC_RXSA_ADD,
+	SXE2_DRV_CMD_IPSEC_TXSA_DEL,
+	SXE2_DRV_CMD_IPSEC_RXSA_DEL,
+	SXE2_DRV_CMD_IPSEC_RESOURCE_CLEAR,
+
+	SXE2_DRV_CMD_EVT_IRQ_BAND_RXQ =
+		SXE2_MK_DRV_CMD(SXE2_DRV_CMD_MODULE_IRQ, 1),
+
+	SXE2_DRV_CMD_OPT_EEP_GET =
+		SXE2_MK_DRV_CMD(SXE2_DRV_CMD_MODULE_OPT, 1),
+
+};
+
+#endif
diff --git a/drivers/net/sxe2/sxe2_ethdev.c b/drivers/net/sxe2/sxe2_ethdev.c
new file mode 100644
index 0000000000..f2de249279
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_ethdev.c
@@ -0,0 +1,633 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#include <rte_string_fns.h>
+#include <ethdev_pci.h>
+#include <ctype.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <unistd.h>
+#include <rte_tailq.h>
+#include <rte_version.h>
+#include <bus_pci_driver.h>
+#include <dev_driver.h>
+#include <ethdev_driver.h>
+#include <rte_ethdev.h>
+#include <rte_alarm.h>
+#include <rte_dev_info.h>
+#include <rte_pci.h>
+#include <rte_mbuf_dyn.h>
+#include <rte_cycles.h>
+#include <rte_eal_paging.h>
+
+#include "sxe2_ethdev.h"
+#include "sxe2_drv_cmd.h"
+#include "sxe2_cmd_chnl.h"
+#include "sxe2_common.h"
+#include "sxe2_common_log.h"
+#include "sxe2_host_regs.h"
+#include "sxe2_ioctl_chnl_func.h"
+
+#define SXE2_PCI_VENDOR_ID_1    0x1ff2
+#define SXE2_PCI_DEVICE_ID_PF_1 0x10b1
+#define SXE2_PCI_DEVICE_ID_VF_1 0x10b2
+
+#define SXE2_PCI_VENDOR_ID_2    0x1d94
+#define SXE2_PCI_DEVICE_ID_PF_2 0x1260
+#define SXE2_PCI_DEVICE_ID_VF_2 0x126f
+
+#define SXE2_PCI_DEVICE_ID_PF_3 0x10b3
+#define SXE2_PCI_DEVICE_ID_VF_3 0x10b4
+
+#define SXE2_PCI_VENDOR_ID_206F 0x206f
+
+static const struct rte_pci_id pci_id_sxe2_tbl[] = {
+	{ RTE_PCI_DEVICE(SXE2_PCI_VENDOR_ID_1, SXE2_PCI_DEVICE_ID_PF_1)},
+	{ RTE_PCI_DEVICE(SXE2_PCI_VENDOR_ID_1, SXE2_PCI_DEVICE_ID_VF_1)},
+	{ RTE_PCI_DEVICE(SXE2_PCI_VENDOR_ID_2, SXE2_PCI_DEVICE_ID_PF_2)},
+	{ RTE_PCI_DEVICE(SXE2_PCI_VENDOR_ID_2, SXE2_PCI_DEVICE_ID_VF_2)},
+	{ RTE_PCI_DEVICE(SXE2_PCI_VENDOR_ID_1, SXE2_PCI_DEVICE_ID_PF_3)},
+	{ RTE_PCI_DEVICE(SXE2_PCI_VENDOR_ID_1, SXE2_PCI_DEVICE_ID_VF_3)},
+	{ RTE_PCI_DEVICE(SXE2_PCI_VENDOR_ID_206F, SXE2_PCI_DEVICE_ID_PF_1)},
+	{ RTE_PCI_DEVICE(SXE2_PCI_VENDOR_ID_206F, SXE2_PCI_DEVICE_ID_VF_1)},
+	{ .vendor_id = 0, },
+};
+
+static s32 sxe2_dev_configure(struct rte_eth_dev *dev)
+{
+	s32 ret = SXE2_SUCCESS;
+	PMD_INIT_FUNC_TRACE();
+
+	if (dev->data->dev_conf.rxmode.mq_mode  & RTE_ETH_MQ_RX_RSS_FLAG)
+		dev->data->dev_conf.rxmode.offloads |= RTE_ETH_RX_OFFLOAD_RSS_HASH;
+
+	return ret;
+}
+
+static void __rte_cold sxe2_txqs_all_stop(struct rte_eth_dev *dev __rte_unused)
+{
+}
+
+static void __rte_cold sxe2_rxqs_all_stop(struct rte_eth_dev *dev __rte_unused)
+{
+}
+
+static s32 sxe2_dev_stop(struct rte_eth_dev *dev)
+{
+	s32 ret = SXE2_SUCCESS;
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	PMD_INIT_FUNC_TRACE();
+
+	if (adapter->started == 0)
+		goto l_end;
+
+	sxe2_txqs_all_stop(dev);
+	sxe2_rxqs_all_stop(dev);
+
+	dev->data->dev_started = 0;
+	adapter->started = 0;
+l_end:
+	return ret;
+}
+
+static s32 __rte_cold sxe2_txqs_all_start(struct rte_eth_dev *dev __rte_unused)
+{
+	return 0;
+}
+
+static s32 __rte_cold sxe2_rxqs_all_start(struct rte_eth_dev *dev __rte_unused)
+{
+	return 0;
+}
+
+static s32 sxe2_queues_start(struct rte_eth_dev *dev)
+{
+	s32 ret = SXE2_SUCCESS;
+	ret = sxe2_txqs_all_start(dev);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "Failed to start tx queue.");
+		goto l_end;
+	}
+
+	ret = sxe2_rxqs_all_start(dev);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "Failed to start rx queue.");
+		sxe2_txqs_all_stop(dev);
+	}
+
+l_end:
+	return ret;
+}
+
+static s32 sxe2_dev_start(struct rte_eth_dev *dev)
+{
+	s32 ret = SXE2_SUCCESS;
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	PMD_INIT_FUNC_TRACE();
+
+	ret = sxe2_queues_init(dev);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "Failed to init queues.");
+		goto l_end;
+	}
+
+	ret = sxe2_queues_start(dev);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "enable queues failed");
+		goto l_end;
+	}
+
+	dev->data->dev_started = 1;
+	adapter->started = 1;
+	goto l_end;
+
+l_end:
+	return ret;
+}
+
+static s32 sxe2_dev_close(struct rte_eth_dev *dev)
+{
+	(void)sxe2_dev_stop(dev);
+
+	sxe2_vsi_uninit(dev);
+
+	return SXE2_SUCCESS;
+}
+
+static s32 sxe2_dev_infos_get(struct rte_eth_dev *dev,
+			struct rte_eth_dev_info *dev_info)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct sxe2_vsi *vsi = adapter->vsi_ctxt.main_vsi;
+
+	dev_info->max_rx_queues = vsi->rxqs.q_cnt;
+	dev_info->max_tx_queues = vsi->txqs.q_cnt;
+	dev_info->min_rx_bufsize = SXE2_MIN_BUF_SIZE;
+	dev_info->max_rx_pktlen = SXE2_FRAME_SIZE_MAX;
+	dev_info->max_lro_pkt_size = SXE2_FRAME_SIZE_MAX * SXE2_RX_LRO_DESC_MAX_NUM;
+	dev_info->max_mtu = dev_info->max_rx_pktlen - SXE2_ETH_OVERHEAD;
+	dev_info->min_mtu = RTE_ETHER_MIN_MTU;
+
+	dev_info->rx_offload_capa =
+		RTE_ETH_RX_OFFLOAD_VLAN_STRIP |
+		RTE_ETH_RX_OFFLOAD_KEEP_CRC |
+		RTE_ETH_RX_OFFLOAD_SCATTER |
+		RTE_ETH_RX_OFFLOAD_VLAN_FILTER |
+		RTE_ETH_RX_OFFLOAD_IPV4_CKSUM |
+		RTE_ETH_RX_OFFLOAD_UDP_CKSUM |
+		RTE_ETH_RX_OFFLOAD_TCP_CKSUM |
+		RTE_ETH_RX_OFFLOAD_SCTP_CKSUM |
+		RTE_ETH_RX_OFFLOAD_OUTER_IPV4_CKSUM |
+		RTE_ETH_RX_OFFLOAD_BUFFER_SPLIT |
+#ifndef RTE_LIBRTE_SXE2_16BYTE_RX_DESC
+		RTE_ETH_RX_OFFLOAD_QINQ_STRIP |
+#endif
+		RTE_ETH_RX_OFFLOAD_VLAN_EXTEND |
+		RTE_ETH_RX_OFFLOAD_TCP_LRO |
+		RTE_ETH_RX_OFFLOAD_RSS_HASH;
+
+	dev_info->tx_offload_capa =
+		RTE_ETH_TX_OFFLOAD_VLAN_INSERT |
+		RTE_ETH_TX_OFFLOAD_QINQ_INSERT |
+		RTE_ETH_TX_OFFLOAD_MULTI_SEGS |
+		RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE |
+		RTE_ETH_TX_OFFLOAD_IPV4_CKSUM |
+		RTE_ETH_TX_OFFLOAD_UDP_CKSUM |
+		RTE_ETH_TX_OFFLOAD_TCP_CKSUM |
+		RTE_ETH_TX_OFFLOAD_SCTP_CKSUM |
+		RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM |
+		RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM |
+		RTE_ETH_TX_OFFLOAD_TCP_TSO |
+		RTE_ETH_TX_OFFLOAD_UDP_TSO |
+		RTE_ETH_TX_OFFLOAD_VXLAN_TNL_TSO |
+		RTE_ETH_TX_OFFLOAD_GRE_TNL_TSO |
+		RTE_ETH_TX_OFFLOAD_IPIP_TNL_TSO |
+		RTE_ETH_TX_OFFLOAD_GENEVE_TNL_TSO;
+
+	dev_info->rx_queue_offload_capa =
+		RTE_ETH_RX_OFFLOAD_BUFFER_SPLIT |
+		RTE_ETH_RX_OFFLOAD_KEEP_CRC |
+		RTE_ETH_RX_OFFLOAD_SCATTER |
+		RTE_ETH_RX_OFFLOAD_IPV4_CKSUM |
+		RTE_ETH_RX_OFFLOAD_UDP_CKSUM |
+		RTE_ETH_RX_OFFLOAD_TCP_CKSUM |
+		RTE_ETH_RX_OFFLOAD_SCTP_CKSUM |
+		RTE_ETH_RX_OFFLOAD_OUTER_IPV4_CKSUM |
+		RTE_ETH_RX_OFFLOAD_TCP_LRO;
+	dev_info->tx_queue_offload_capa =
+		RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE |
+		RTE_ETH_TX_OFFLOAD_TCP_TSO |
+		RTE_ETH_TX_OFFLOAD_UDP_TSO |
+		RTE_ETH_TX_OFFLOAD_MULTI_SEGS |
+		RTE_ETH_TX_OFFLOAD_IPV4_CKSUM |
+		RTE_ETH_TX_OFFLOAD_UDP_CKSUM |
+		RTE_ETH_TX_OFFLOAD_TCP_CKSUM |
+		RTE_ETH_TX_OFFLOAD_SCTP_CKSUM |
+		RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM |
+		RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM |
+		RTE_ETH_TX_OFFLOAD_VXLAN_TNL_TSO |
+		RTE_ETH_TX_OFFLOAD_GRE_TNL_TSO |
+		RTE_ETH_TX_OFFLOAD_IPIP_TNL_TSO |
+		RTE_ETH_TX_OFFLOAD_GENEVE_TNL_TSO;
+
+	if (adapter->cap_flags & SXE2_DEV_CAPS_OFFLOAD_PTP)
+		dev_info->rx_offload_capa |= RTE_ETH_RX_OFFLOAD_TIMESTAMP;
+
+	dev_info->tx_queue_offload_capa = RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE;
+
+	dev_info->default_rxconf = (struct rte_eth_rxconf) {
+		.rx_thresh = {
+			.pthresh = SXE2_DEFAULT_RX_PTHRESH,
+			.hthresh = SXE2_DEFAULT_RX_HTHRESH,
+			.wthresh = SXE2_DEFAULT_RX_WTHRESH,
+		},
+		.rx_free_thresh = SXE2_DEFAULT_RX_FREE_THRESH,
+		.rx_drop_en = 0,
+		.offloads = 0,
+	};
+
+	dev_info->default_txconf = (struct rte_eth_txconf) {
+		.tx_thresh = {
+			.pthresh = SXE2_DEFAULT_TX_PTHRESH,
+			.hthresh = SXE2_DEFAULT_TX_HTHRESH,
+			.wthresh = SXE2_DEFAULT_TX_WTHRESH,
+		},
+		.tx_free_thresh = SXE2_DEFAULT_TX_FREE_THRESH,
+		.tx_rs_thresh = SXE2_DEFAULT_TX_RSBIT_THRESH,
+		.offloads = 0,
+	};
+
+	dev_info->rx_desc_lim = (struct rte_eth_desc_lim) {
+		.nb_max = SXE2_MAX_RING_DESC,
+		.nb_min = SXE2_MIN_RING_DESC,
+		.nb_align = SXE2_ALIGN,
+	};
+
+	dev_info->tx_desc_lim = (struct rte_eth_desc_lim) {
+		.nb_max = SXE2_MAX_RING_DESC,
+		.nb_min = SXE2_MIN_RING_DESC,
+		.nb_align = SXE2_ALIGN,
+		.nb_mtu_seg_max = SXE2_TX_MTU_SEG_MAX,
+		.nb_seg_max = SXE2_MAX_RING_DESC,
+	};
+
+	dev_info->speed_capa = RTE_ETH_LINK_SPEED_10G | RTE_ETH_LINK_SPEED_25G |
+				RTE_ETH_LINK_SPEED_50G | RTE_ETH_LINK_SPEED_100G;
+
+	dev_info->nb_rx_queues = dev->data->nb_rx_queues;
+	dev_info->nb_tx_queues = dev->data->nb_tx_queues;
+
+	dev_info->default_rxportconf.burst_size = SXE2_RX_MAX_BURST;
+	dev_info->default_txportconf.burst_size = SXE2_TX_MAX_BURST;
+	dev_info->default_rxportconf.nb_queues = 1;
+	dev_info->default_txportconf.nb_queues = 1;
+	dev_info->default_rxportconf.ring_size = SXE2_RING_SIZE_MIN;
+	dev_info->default_txportconf.ring_size = SXE2_RING_SIZE_MIN;
+
+	dev_info->rx_seg_capa.max_nseg = SXE2_RX_MAX_NSEG;
+
+	dev_info->rx_seg_capa.multi_pools = true;
+
+	dev_info->rx_seg_capa.offset_allowed = false;
+
+	dev_info->rx_seg_capa.offset_align_log2 = false;
+
+	return SXE2_SUCCESS;
+}
+
+static const struct eth_dev_ops sxe2_eth_dev_ops = {
+	.dev_configure              = sxe2_dev_configure,
+	.dev_start                  = sxe2_dev_start,
+	.dev_stop                   = sxe2_dev_stop,
+	.dev_close                  = sxe2_dev_close,
+	.dev_infos_get              = sxe2_dev_infos_get,
+};
+
+static void sxe2_drv_dev_caps_set(struct sxe2_adapter *adapter,
+			struct sxe2_drv_dev_caps_resp *dev_caps)
+{
+	adapter->port_idx = dev_caps->port_idx;
+
+	adapter->cap_flags = 0;
+
+	if (dev_caps->cap_flags & SXE2_DEV_CAPS_OFFLOAD_L2)
+		adapter->cap_flags |= SXE2_DEV_CAPS_OFFLOAD_L2;
+
+	if (dev_caps->cap_flags & SXE2_DEV_CAPS_OFFLOAD_VLAN)
+		adapter->cap_flags |= SXE2_DEV_CAPS_OFFLOAD_VLAN;
+
+	if (dev_caps->cap_flags & SXE2_DEV_CAPS_OFFLOAD_RSS)
+		adapter->cap_flags |= SXE2_DEV_CAPS_OFFLOAD_RSS;
+
+	if (dev_caps->cap_flags & SXE2_DEV_CAPS_OFFLOAD_IPSEC)
+		adapter->cap_flags |= SXE2_DEV_CAPS_OFFLOAD_IPSEC;
+
+	if (dev_caps->cap_flags & SXE2_DEV_CAPS_OFFLOAD_FNAV)
+		adapter->cap_flags |= SXE2_DEV_CAPS_OFFLOAD_FNAV;
+
+	if (dev_caps->cap_flags & SXE2_DEV_CAPS_OFFLOAD_TM)
+		adapter->cap_flags |= SXE2_DEV_CAPS_OFFLOAD_TM;
+
+	if (dev_caps->cap_flags & SXE2_DEV_CAPS_OFFLOAD_PTP)
+		adapter->cap_flags |= SXE2_DEV_CAPS_OFFLOAD_PTP;
+
+	if (dev_caps->cap_flags & SXE2_DEV_CAPS_OFFLOAD_Q_MAP)
+		adapter->cap_flags |= SXE2_DEV_CAPS_OFFLOAD_Q_MAP;
+
+	if (dev_caps->cap_flags & SXE2_DEV_CAPS_OFFLOAD_FC_STATE)
+		adapter->cap_flags |= SXE2_DEV_CAPS_OFFLOAD_FC_STATE;
+}
+
+static s32 sxe2_func_caps_get(struct sxe2_adapter *adapter)
+{
+	s32 ret = SXE2_ERROR;
+	struct sxe2_drv_dev_caps_resp dev_caps = {0};
+
+	ret = sxe2_drv_dev_caps_get(adapter, &dev_caps);
+	if (ret)
+		goto l_end;
+
+	adapter->dev_type = dev_caps.dev_type;
+
+	sxe2_drv_dev_caps_set(adapter,  &dev_caps);
+
+	sxe2_sw_queue_ctx_hw_cap_set(adapter, &dev_caps.queue_caps);
+
+	sxe2_sw_vsi_ctx_hw_cap_set(adapter, &dev_caps.vsi_caps);
+
+l_end:
+	return ret;
+}
+
+static s32 sxe2_dev_caps_get(struct sxe2_adapter *adapter)
+{
+	s32 ret = SXE2_ERROR;
+
+	ret = sxe2_func_caps_get(adapter);
+	if (ret)
+		PMD_LOG_ERR(INIT, "get function caps failed, ret=%d", ret);
+
+	return ret;
+}
+
+static s32 sxe2_hw_init(struct rte_eth_dev *dev)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	s32 ret = SXE2_ERROR;
+
+	PMD_INIT_FUNC_TRACE();
+
+	ret = sxe2_dev_caps_get(adapter);
+	if (ret)
+		PMD_LOG_ERR(INIT, "Failed to get device caps, ret=[%d]", ret);
+
+	return ret;
+}
+
+static s32 sxe2_dev_info_init(struct rte_eth_dev *dev)
+{
+	struct sxe2_adapter *adapter =
+		SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct rte_pci_device *pci_dev = RTE_DEV_TO_PCI(dev->device);
+	struct sxe2_dev_info *dev_info = &adapter->dev_info;
+	struct sxe2_drv_dev_info_resp dev_info_resp = {0};
+	struct sxe2_drv_dev_fw_info_resp dev_fw_info_resp = {0};
+	s32 ret = SXE2_SUCCESS;
+
+	dev_info->pci.bus_devid = pci_dev->addr.devid;
+	dev_info->pci.bus_function = pci_dev->addr.function;
+
+	ret = sxe2_drv_dev_info_get(adapter, &dev_info_resp);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "Failed to get device info, ret=[%d]", ret);
+		goto l_end;
+	}
+	dev_info->pci.serial_number = dev_info_resp.dsn;
+
+	ret = sxe2_drv_dev_fw_info_get(adapter, &dev_fw_info_resp);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "Failed to get device fw info, ret=[%d]", ret);
+		goto l_end;
+	}
+	dev_info->fw.build_id = dev_fw_info_resp.build_id;
+	dev_info->fw.fix_version_id = dev_fw_info_resp.fix_version_id;
+	dev_info->fw.sub_version_id = dev_fw_info_resp.sub_version_id;
+	dev_info->fw.main_version_id = dev_fw_info_resp.main_version_id;
+
+	if (rte_is_valid_assigned_ether_addr((struct rte_ether_addr *)dev_info_resp.mac_addr))
+		rte_ether_addr_copy((struct rte_ether_addr *)dev_info_resp.mac_addr,
+						(struct rte_ether_addr *)dev_info->mac.perm_addr);
+	else
+		rte_eth_random_addr(dev_info->mac.perm_addr);
+
+l_end:
+	return ret;
+}
+
+static s32 sxe2_dev_init(struct rte_eth_dev *dev, struct sxe2_dev_kvargs_info *kvargs __rte_unused)
+{
+	s32 ret = 0;
+
+	PMD_INIT_FUNC_TRACE();
+
+	dev->dev_ops = &sxe2_eth_dev_ops;
+
+	ret = sxe2_hw_init(dev);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "Failed to initialize hw, ret=[%d]", ret);
+		goto l_end;
+	}
+
+	ret = sxe2_vsi_init(dev);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "create main vsi failed, ret=%d", ret);
+		goto init_vsi_err;
+	}
+
+	ret = sxe2_dev_info_init(dev);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "Failed to get device info, ret=[%d]", ret);
+		goto init_dev_info_err;
+	}
+
+	goto l_end;
+
+init_dev_info_err:
+	sxe2_vsi_uninit(dev);
+init_vsi_err:
+l_end:
+	return ret;
+}
+
+static s32 sxe2_dev_uninit(struct rte_eth_dev *dev)
+{
+	s32 ret = 0;
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		goto l_end;
+
+	ret = sxe2_dev_close(dev);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "Sxe2 dev close failed, ret=%d", ret);
+		goto l_end;
+	}
+
+l_end:
+	return ret;
+}
+
+static s32 sxe2_eth_pmd_remove(struct sxe2_common_device *cdev)
+{
+	struct rte_eth_dev *eth_dev;
+	struct rte_pci_device *pci_dev = RTE_DEV_TO_PCI(cdev->dev);
+	s32 ret = SXE2_SUCCESS;
+
+	eth_dev = rte_eth_dev_allocated(pci_dev->device.name);
+	if (!eth_dev) {
+		PMD_LOG_INFO(INIT, "Sxe2 dev allocated failed");
+		goto l_end;
+	}
+
+	ret = sxe2_dev_uninit(eth_dev);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "Sxe2 dev uninit failed, ret=%d", ret);
+		goto l_end;
+	}
+	(void)rte_eth_dev_release_port(eth_dev);
+
+l_end:
+	return ret;
+}
+
+static s32 sxe2_eth_pmd_probe_pf(struct sxe2_common_device *cdev,
+		struct rte_eth_devargs *req_eth_da __rte_unused,
+		u16 owner_id __rte_unused,
+		struct sxe2_dev_kvargs_info *kvargs)
+{
+	struct rte_pci_device *pci_dev = RTE_DEV_TO_PCI(cdev->dev);
+	struct rte_eth_dev *eth_dev = NULL;
+	struct sxe2_adapter *adapter = NULL;
+	s32 ret = SXE2_SUCCESS;
+
+	if (!cdev) {
+		ret = SXE2_ERR_INVAL;
+		goto l_end;
+	}
+
+	eth_dev = rte_eth_dev_pci_allocate(pci_dev, sizeof(struct sxe2_adapter));
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
+		if (eth_dev == NULL) {
+			PMD_LOG_ERR(INIT, "Can not allocate ethdev");
+			ret = SXE2_ERR_NOMEM;
+			goto l_end;
+		}
+	} else {
+		if (!eth_dev) {
+			PMD_LOG_DEBUG(INIT, "Can not attach secondary ethdev");
+			ret = SXE2_ERR_INVAL;
+			goto l_end;
+		}
+	}
+
+	adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(eth_dev);
+	adapter->dev_port_id = eth_dev->data->port_id;
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY)
+		adapter->cdev = cdev;
+
+	ret = sxe2_dev_init(eth_dev, kvargs);
+	if (ret != SXE2_SUCCESS) {
+		PMD_DEV_LOG_ERR(adapter, INIT, "Sxe2 dev init failed, ret=%d", ret);
+		goto l_release_port;
+	}
+
+	rte_eth_dev_probing_finish(eth_dev);
+	PMD_DEV_LOG_DEBUG(adapter, INIT, "Sxe2 eth pmd probe successful!");
+	goto l_end;
+
+l_release_port:
+	(void)rte_eth_dev_release_port(eth_dev);
+l_end:
+	return ret;
+}
+
+static s32 sxe2_parse_eth_devargs(struct rte_device *dev,
+			  struct rte_eth_devargs *eth_da)
+{
+	int ret = 0;
+
+	if (dev->devargs == NULL)
+		return 0;
+
+	memset(eth_da, 0, sizeof(*eth_da));
+
+	if (dev->devargs->cls_str) {
+		ret = rte_eth_devargs_parse(dev->devargs->cls_str, eth_da, 1);
+		if (ret != 0) {
+			PMD_LOG_ERR(INIT, "Failed to parse device arguments: %s",
+				dev->devargs->cls_str);
+			return -rte_errno;
+		}
+	}
+
+	if (eth_da->type == RTE_ETH_REPRESENTOR_NONE && dev->devargs->args) {
+		ret = rte_eth_devargs_parse(dev->devargs->args, eth_da, 1);
+		if (ret) {
+			PMD_LOG_ERR(INIT, "Failed to parse device arguments: %s",
+				dev->devargs->args);
+			return -rte_errno;
+		}
+	}
+
+	return 0;
+}
+
+static s32 sxe2_eth_pmd_probe(struct sxe2_common_device *cdev, struct sxe2_dev_kvargs_info *kvargs)
+{
+	struct rte_eth_devargs eth_da = { .nb_ports = 0 };
+	s32 ret = SXE2_SUCCESS;
+
+	ret = sxe2_parse_eth_devargs(cdev->dev, &eth_da);
+	if (ret != 0) {
+		ret = SXE2_ERR_INVAL;
+		goto l_end;
+	}
+
+	ret = sxe2_eth_pmd_probe_pf(cdev, &eth_da, 0, kvargs);
+
+l_end:
+	return ret;
+}
+
+static struct sxe2_class_driver sxe2_eth_pmd = {
+	.drv_class = SXE2_CLASS_TYPE_ETH,
+	.name = "SXE2_ETH_PMD_DRIVER_NAME",
+	.probe = sxe2_eth_pmd_probe,
+	.remove = sxe2_eth_pmd_remove,
+	.id_table = pci_id_sxe2_tbl,
+	.intr_lsc = 1,
+	.intr_rmv = 1,
+};
+
+RTE_INIT(rte_sxe2_pmd_init)
+{
+	sxe2_common_init();
+	sxe2_class_driver_register(&sxe2_eth_pmd);
+}
+
+RTE_PMD_EXPORT_NAME(net_sxe2);
+RTE_PMD_REGISTER_PCI_TABLE(net_sxe2, pci_id_sxe2_tbl);
+RTE_PMD_REGISTER_KMOD_DEP(net_sxe2, "* sxe2");
+
+#ifdef SXE2_DPDK_DEBUG
+RTE_LOG_REGISTER_SUFFIX(sxe2_log_init, init, DEBUG);
+RTE_LOG_REGISTER_SUFFIX(sxe2_log_driver, driver, DEBUG);
+RTE_LOG_REGISTER_SUFFIX(sxe2_log_rx, rx, DEBUG);
+RTE_LOG_REGISTER_SUFFIX(sxe2_log_tx, rx, DEBUG);
+RTE_LOG_REGISTER_SUFFIX(sxe2_log_hw, hw, DEBUG);
+#else
+RTE_LOG_REGISTER_SUFFIX(sxe2_log_init, init, NOTICE);
+RTE_LOG_REGISTER_SUFFIX(sxe2_log_driver, driver, NOTICE);
+RTE_LOG_REGISTER_SUFFIX(sxe2_log_rx, rx, NOTICE);
+RTE_LOG_REGISTER_SUFFIX(sxe2_log_tx, rx, NOTICE);
+RTE_LOG_REGISTER_SUFFIX(sxe2_log_hw, hw, NOTICE);
+#endif
diff --git a/drivers/net/sxe2/sxe2_ethdev.h b/drivers/net/sxe2/sxe2_ethdev.h
new file mode 100644
index 0000000000..dc3a3175d1
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_ethdev.h
@@ -0,0 +1,295 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+#ifndef __SXE2_ETHDEV_H__
+#define __SXE2_ETHDEV_H__
+#include <rte_compat.h>
+#include <rte_kvargs.h>
+#include <rte_time.h>
+#include <ethdev_driver.h>
+#include <ethdev_pci.h>
+#include <rte_tm_driver.h>
+#include <rte_io.h>
+
+#include "sxe2_common.h"
+#include "sxe2_errno.h"
+#include "sxe2_type.h"
+#include "sxe2_vsi.h"
+#include "sxe2_queue.h"
+#include "sxe2_irq.h"
+#include "sxe2_osal.h"
+
+struct sxe2_link_msg {
+	__le32 speed;
+	u8 status;
+};
+
+enum sxe2_fnav_tunnel_flag_type {
+	SXE2_FNAV_TUN_FLAG_NO_TUNNEL,
+	SXE2_FNAV_TUN_FLAG_TUNNEL,
+	SXE2_FNAV_TUN_FLAG_ANY,
+};
+
+#define SXE2_VF_MAX_NUM        256
+#define SXE2_VSI_MAX_NUM       768
+#define SXE2_FRAME_SIZE_MAX    9832
+#define SXE2_VLAN_TAG_SIZE     4
+#define SXE2_ETH_OVERHEAD \
+	(RTE_ETHER_HDR_LEN + RTE_ETHER_CRC_LEN + SXE2_VLAN_TAG_SIZE * 2)
+#define SXE2_ETH_MAX_LEN (RTE_ETHER_MTU + SXE2_ETH_OVERHEAD)
+
+#ifdef SXE2_TEST
+#define SXE2_RESET_ACTIVE_WAIT_COUNT   (5)
+#else
+#define SXE2_RESET_ACTIVE_WAIT_COUNT   (10000)
+#endif
+#define SXE2_NO_ACTIVE_CNT           (10)
+
+#define SXE2_WOKER_DELAY_5MS         (5)
+#define SXE2_WOKER_DELAY_10MS        (10)
+#define SXE2_WOKER_DELAY_20MS        (20)
+#define SXE2_WOKER_DELAY_30MS        (30)
+
+#define SXE2_RESET_DETEC_WAIT_COUNT    (100)
+#define SXE2_RESET_DONE_WAIT_COUNT     (250)
+#define SXE2_RESET_WAIT_MS             (10)
+
+#define SXE2_RESET_WAIT_MIN   (10)
+#define SXE2_RESET_WAIT_MAX   (20)
+#define upper_32_bits(n) ((u32)(((n) >> 16) >> 16))
+#define lower_32_bits(n) ((u32)((n) & 0xffffffff))
+
+#define SXE2_I2C_EEPROM_DEV_ADDR	0xA0
+#define SXE2_I2C_EEPROM_DEV_ADDR2	0xA2
+#define SXE2_MODULE_TYPE_SFP		0x03
+#define SXE2_MODULE_TYPE_QSFP_PLUS	0x0D
+#define SXE2_MODULE_TYPE_QSFP28	0x11
+#define SXE2_MODULE_SFF_ADDR_MODE	0x04
+#define SXE2_MODULE_SFF_DIAG_CAPAB	0x40
+#define SXE2_MODULE_REVISION_ADDR	0x01
+#define SXE2_MODULE_SFF_8472_COMP	0x5E
+#define SXE2_MODULE_SFF_8472_SWAP	0x5C
+#define SXE2_MODULE_QSFP_MAX_LEN	640
+#define SXE2_MODULE_SFF_8472_UNSUP	0x0
+#define SXE2_MODULE_SFF_DDM_IMPLEMENTED	0x40
+#define SXE2_MODULE_SFF_SFP_TYPE   0x03
+#define SXE2_MODULE_TYPE_QSFP_PLUS	0x0D
+#define SXE2_MODULE_TYPE_QSFP28	0x11
+
+#define SXE2_MODULE_SFF_8079		0x1
+#define SXE2_MODULE_SFF_8079_LEN	256
+#define SXE2_MODULE_SFF_8472		0x2
+#define SXE2_MODULE_SFF_8472_LEN	512
+#define SXE2_MODULE_SFF_8636		0x3
+#define SXE2_MODULE_SFF_8636_LEN	256
+#define SXE2_MODULE_SFF_8636_MAX_LEN     640
+#define SXE2_MODULE_SFF_8436		0x4
+#define SXE2_MODULE_SFF_8436_LEN	256
+#define SXE2_MODULE_SFF_8436_MAX_LEN     640
+
+enum sxe2_wk_type {
+	SXE2_WK_MONITOR,
+	SXE2_WK_MONITOR_IM,
+	SXE2_WK_POST,
+	SXE2_WK_MBX,
+};
+
+enum {
+	SXE2_FLAG_LEGACY_RX_ENABLE   = 0,
+	SXE2_FLAG_LRO_ENABLE = 1,
+	SXE2_FLAG_RXQ_DISABLED = 2,
+	SXE2_FLAG_TXQ_DISABLED = 3,
+	SXE2_FLAG_DRV_REMOVING = 4,
+	SXE2_FLAG_RESET_DETECTED = 5,
+	SXE2_FLAG_CORE_RESET_DONE = 6,
+	SXE2_FLAG_RESET_ACTIVED = 7,
+	SXE2_FLAG_RESET_PENDING = 8,
+	SXE2_FLAG_RESET_REQUEST = 9,
+	SXE2_FLAGS_RESET_PROCESS_DONE = 10,
+	SXE2_FLAG_RESET_FAILED = 11,
+	SXE2_FLAG_DRV_PROBE_DONE = 12,
+	SXE2_FLAG_NETDEV_REGISTED = 13,
+	SXE2_FLAG_DRV_UP = 15,
+	SXE2_FLAG_DCB_ENABLE = 16,
+	SXE2_FLAG_FLTR_SYNC = 17,
+
+	SXE2_FLAG_EVENT_IRQ_DISABLED = 18,
+	SXE2_FLAG_SUSPEND = 19,
+	SXE2_FLAG_FNAV_ENABLE = 20,
+
+	SXE2_FLAGS_NBITS
+};
+
+struct sxe2_link_context {
+	rte_spinlock_t link_lock;
+	bool link_up;
+	u32  speed;
+};
+
+struct sxe2_devargs {
+	u8 flow_dup_pattern_mode;
+	u8 func_flow_direct_en;
+	u8 fnav_stat_type;
+	u8 high_performance_mode;
+	u8 sched_layer_mode;
+	u8 sw_stats_en;
+	u8 rx_low_latency;
+};
+
+#define SXE2_PCI_MAP_BAR_INVALID ((u8)0xff)
+#define SXE2_PCI_MAP_INVALID_VAL ((u32)0xffffffff)
+
+enum sxe2_pci_map_resource {
+	SXE2_PCI_MAP_RES_INVALID = 0,
+	SXE2_PCI_MAP_RES_DOORBELL_TX,
+	SXE2_PCI_MAP_RES_DOORBELL_RX_TAIL,
+	SXE2_PCI_MAP_RES_IRQ_DYN,
+	SXE2_PCI_MAP_RES_IRQ_ITR,
+	SXE2_PCI_MAP_RES_IRQ_MSIX,
+	SXE2_PCI_MAP_RES_PTP,
+	SXE2_PCI_MAP_RES_MAX_COUNT,
+};
+
+enum sxe2_udp_tunnel_protocol {
+	SXE2_UDP_TUNNEL_PROTOCOL_VXLAN = 0,
+	SXE2_UDP_TUNNEL_PROTOCOL_VXLAN_GPE,
+	SXE2_UDP_TUNNEL_PROTOCOL_GENEVE,
+	SXE2_UDP_TUNNEL_PROTOCOL_GTP_C = 4,
+	SXE2_UDP_TUNNEL_PROTOCOL_GTP_U,
+	SXE2_UDP_TUNNEL_PROTOCOL_PFCP,
+	SXE2_UDP_TUNNEL_PROTOCOL_ECPRI,
+	SXE2_UDP_TUNNEL_PROTOCOL_MPLS,
+	SXE2_UDP_TUNNEL_PROTOCOL_NVGRE = 10,
+	SXE2_UDP_TUNNEL_PROTOCOL_L2TP,
+	SXE2_UDP_TUNNEL_PROTOCOL_TEREDO,
+	SXE2_UDP_TUNNEL_MAX,
+};
+
+struct sxe2_pci_map_addr_info {
+	u64 addr_base;
+	u8 bar_idx;
+	u8 reg_width;
+};
+
+struct sxe2_pci_map_segment_info {
+	enum sxe2_pci_map_resource	type;
+	void __iomem				*addr;
+	resource_size_t				page_inner_offset;
+	resource_size_t				len;
+};
+
+struct sxe2_pci_map_bar_info {
+	u8    bar_idx;
+	u8    map_cnt;
+	struct sxe2_pci_map_segment_info    *seg_info;
+};
+
+struct sxe2_pci_map_context {
+	u8    bar_cnt;
+	struct sxe2_pci_map_bar_info *bar_info;
+	struct sxe2_pci_map_addr_info *addr_info;
+};
+
+struct sxe2_dev_mac_info {
+	u8 perm_addr[ETH_ALEN];
+};
+
+struct sxe2_pci_info {
+	u64                     serial_number;
+	u8                      bus_devid;
+	u8                      bus_function;
+	u16                     max_vfs;
+};
+
+struct sxe2_fw_info {
+	u8                      main_version_id;
+	u8                      sub_version_id;
+	u8                      fix_version_id;
+	u8                      build_id;
+};
+
+struct sxe2_dev_info {
+	struct rte_eth_dev_data        *dev_data;
+	struct sxe2_pci_info           pci;
+	struct sxe2_fw_info            fw;
+	struct sxe2_dev_mac_info       mac;
+};
+
+enum sxe2_udp_tunnel_status {
+	SXE2_UDP_TUNNEL_DISABLE = 0x0,
+	SXE2_UDP_TUNNEL_ENABLE,
+};
+
+struct sxe2_udp_tunnel_cfg {
+	u8			protocol;
+	u8			dev_status;
+	u16			dev_port;
+	u16			dev_ref_cnt;
+
+	u16			fw_port;
+	u8			fw_status;
+	u8			fw_dst_en;
+	u8			fw_src_en;
+	u8			fw_used;
+};
+
+struct sxe2_udp_tunnel_ctx {
+	struct sxe2_udp_tunnel_cfg   tunnel_conf[SXE2_UDP_TUNNEL_MAX];
+	rte_spinlock_t                lock;
+};
+
+struct sxe2_repr_context {
+	u16 nb_vf;
+	u16 nb_repr_vf;
+	struct rte_eth_dev **vf_rep_eth_dev;
+	struct sxe2_drv_vsi_caps repr_vf_id[SXE2_VF_MAX_NUM];
+};
+
+struct sxe2_repr_private_data {
+	struct rte_eth_dev *rep_eth_dev;
+	struct sxe2_adapter *parent_adapter;
+
+	struct sxe2_vsi *cp_vsi;
+	u16 repr_q_id;
+
+	u16 repr_id;
+	u16 repr_pf_id;
+	u16 repr_vf_id;
+	u16 repr_vf_vsi_id;
+	u16 repr_vf_k_vsi_id;
+	u16 repr_vf_u_vsi_id;
+};
+
+struct sxe2_sched_hw_cap {
+	u32 tm_layers;
+	u8 root_max_children;
+	u8 prio_max;
+	u8 adj_lvl;
+};
+
+struct sxe2_adapter {
+	struct sxe2_common_device      *cdev;
+	struct sxe2_dev_info            dev_info;
+	struct rte_pci_device            *pci_dev;
+	struct sxe2_repr_private_data  *repr_priv_data;
+	struct sxe2_pci_map_context   map_ctxt;
+	struct sxe2_irq_context       irq_ctxt;
+	struct sxe2_queue_context     q_ctxt;
+	struct sxe2_vsi_context       vsi_ctxt;
+	struct sxe2_devargs			  devargs;
+	u16                           dev_port_id;
+	u64                           cap_flags;
+	enum sxe2_dev_type            dev_type;
+	u32    ptype_tbl[SXE2_MAX_PTYPE_NUM];
+	struct rte_ether_addr           mac_addr;
+	u8                              port_idx;
+	u8                              pf_idx;
+	u32                             tx_mode_flags;
+	u32                             rx_mode_flags;
+	u8                              started;
+};
+
+#define SXE2_DEV_PRIVATE_TO_ADAPTER(dev) \
+	((struct sxe2_adapter *)(dev)->data->dev_private)
+
+#endif
diff --git a/drivers/net/sxe2/sxe2_irq.h b/drivers/net/sxe2/sxe2_irq.h
new file mode 100644
index 0000000000..7695a0206f
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_irq.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#ifndef __SXE2_IRQ_H__
+#define __SXE2_IRQ_H__
+
+#include <ethdev_driver.h>
+
+#include "sxe2_type.h"
+#include "sxe2_drv_cmd.h"
+
+#define SXE2_IRQ_MAX_CNT 2048
+
+#define SXE2_LAN_MSIX_MIN_CNT 1
+
+#define SXE2_EVENT_IRQ_IDX 0
+
+#define SXE2_MAX_INTR_QUEUE_NUM   256
+
+#define SXE2_IRQ_NAME_MAX_LEN     (IFNAMSIZ + 16)
+
+#define SXE2_ITR_1000K  1
+#define SXE2_ITR_500K   2
+#define SXE2_ITR_50K    20
+
+#define SXE2_ITR_INTERVAL_NORMAL  (SXE2_ITR_50K)
+#define SXE2_ITR_INTERVAL_LOW     (SXE2_ITR_1000K)
+
+struct sxe2_fwc_msix_caps;
+struct sxe2_adapter;
+
+struct sxe2_irq_context {
+	struct rte_intr_handle *reset_handle;
+	s32 reset_event_fd;
+	s32 other_event_fd;
+
+	u16 max_cnt_hw;
+	u16 base_idx_in_func;
+
+	u16 rxq_avail_cnt;
+	u16 rxq_base_idx_in_pf;
+
+	u16 rxq_irq_cnt;
+	u32 *rxq_msix_idx;
+	s32 *rxq_event_fd;
+};
+
+#endif
diff --git a/drivers/net/sxe2/sxe2_queue.c b/drivers/net/sxe2/sxe2_queue.c
new file mode 100644
index 0000000000..98343679f6
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_queue.c
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#include "sxe2_ethdev.h"
+#include "sxe2_queue.h"
+#include "sxe2_common_log.h"
+#include "sxe2_errno.h"
+
+void sxe2_sw_queue_ctx_hw_cap_set(struct sxe2_adapter *adapter,
+		struct sxe2_drv_queue_caps *q_caps)
+{
+	adapter->q_ctxt.qp_cnt_assign = q_caps->queues_cnt;
+	adapter->q_ctxt.base_idx_in_pf = q_caps->base_idx_in_pf;
+}
+
+s32 sxe2_queues_init(struct rte_eth_dev *dev)
+{
+	s32 ret = SXE2_SUCCESS;
+	u16 buf_size;
+	u16 frame_size;
+	struct sxe2_rx_queue *rxq;
+	u16 nb_rxq;
+
+	frame_size = dev->data->mtu + SXE2_ETH_OVERHEAD;
+	for (nb_rxq = 0; nb_rxq < dev->data->nb_rx_queues; nb_rxq++) {
+		rxq = dev->data->rx_queues[nb_rxq];
+		if (!rxq)
+			continue;
+
+		buf_size = rte_pktmbuf_data_room_size(rxq->mb_pool) - RTE_PKTMBUF_HEADROOM;
+		rxq->rx_buf_len = RTE_ALIGN_FLOOR(buf_size, (1 << SXE2_RXQ_CTX_DBUFF_SHIFT));
+		rxq->rx_buf_len = RTE_MIN(rxq->rx_buf_len, SXE2_RX_MAX_DATA_BUF_SIZE);
+		if (frame_size > rxq->rx_buf_len)
+			dev->data->scattered_rx = 1;
+	}
+
+	return ret;
+}
diff --git a/drivers/net/sxe2/sxe2_queue.h b/drivers/net/sxe2/sxe2_queue.h
new file mode 100644
index 0000000000..e4cbd55faf
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_queue.h
@@ -0,0 +1,227 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#ifndef __SXE2_QUEUE_H__
+#define __SXE2_QUEUE_H__
+#include <rte_ethdev.h>
+#include <rte_io.h>
+#include <rte_stdatomic.h>
+#include <ethdev_driver.h>
+
+#include "sxe2_drv_cmd.h"
+#include "sxe2_txrx_common.h"
+
+#define SXE2_PCI_REG_READ(reg)			\
+		rte_read32(reg)
+#define SXE2_PCI_REG_WRITE_WC(reg, value)			\
+		rte_write32_wc((rte_cpu_to_le_32(value)), reg)
+#define SXE2_PCI_REG_WRITE_WC_RELAXED(reg, value)		\
+		rte_write32_wc_relaxed((rte_cpu_to_le_32(value)), reg)
+
+struct sxe2_queue_context {
+	u16 qp_cnt_assign;
+	u16 base_idx_in_pf;
+
+	u32 tx_mode_flags;
+	u32 rx_mode_flags;
+};
+
+struct sxe2_tx_buffer {
+	struct rte_mbuf *mbuf;
+
+	u16 next_id;
+	u16 last_id;
+};
+
+struct sxe2_tx_buffer_vec {
+	struct rte_mbuf *mbuf;
+};
+
+struct sxe2_txq_stats {
+	u64 tx_restart;
+	u64 tx_busy;
+
+	u64 tx_linearize;
+	u64 tx_tso_linearize_chk;
+	u64 tx_vlan_insert;
+	u64 tx_tso_packets;
+	u64 tx_tso_bytes;
+	u64 tx_csum_none;
+	u64 tx_csum_partial;
+	u64 tx_csum_partial_inner;
+	u64 tx_queue_dropped;
+	u64 tx_xmit_more;
+	u64 tx_pkts_num;
+	u64 tx_desc_not_done;
+};
+
+struct sxe2_tx_queue;
+struct sxe2_txq_ops {
+	void (*queue_reset)(struct sxe2_tx_queue *txq);
+	void (*mbufs_release)(struct sxe2_tx_queue *txq);
+	void (*buffer_ring_free)(struct sxe2_tx_queue *txq);
+};
+struct sxe2_tx_queue {
+	volatile union sxe2_tx_data_desc *desc_ring;
+	struct sxe2_tx_buffer *buffer_ring;
+	volatile u32 *tdt_reg_addr;
+
+	u64 offloads;
+	u16 ring_depth;
+	u16 desc_free_num;
+
+	u16 free_thresh;
+
+	u16 rs_thresh;
+	u16 next_use;
+	u16 next_clean;
+
+	u16 desc_used_num;
+	u16 next_dd;
+	u16 next_rs;
+	u16 ipsec_pkt_md_offset;
+
+	u16 port_id;
+	u16 queue_id;
+	u16 idx_in_func;
+	bool tx_deferred_start;
+	u8 pthresh;
+	u8 hthresh;
+	u8 wthresh;
+	u16 reg_idx;
+	u64 base_addr;
+	struct sxe2_vsi *vsi;
+	const struct rte_memzone *mz;
+	struct sxe2_txq_ops ops;
+#ifdef SXE2_DPDK_DEBUG
+	struct sxe2_txq_stats tx_stats;
+	struct sxe2_txq_stats tx_stats_cur;
+	struct sxe2_txq_stats tx_stats_prev;
+#endif
+	u8  vlan_flag;
+	u8  use_ctx:1,
+		res:7;
+};
+struct sxe2_rx_queue;
+struct sxe2_rxq_ops {
+	void (*queue_reset)(struct sxe2_rx_queue *rxq);
+	void (*mbufs_release)(struct sxe2_rx_queue *txq);
+};
+struct sxe2_rxq_stats {
+	u64 rx_pkts_num;
+	u64 rx_rss_pkt_num;
+	u64 rx_fnav_pkt_num;
+	u64 rx_ptp_pkt_num;
+	u32 rx_vec_align_drop;
+
+	u32 rxdid_1588_err;
+	u32 ip_csum_err;
+	u32 l4_csum_err;
+	u32 outer_ip_csum_err;
+	u32 outer_l4_csum_err;
+	u32 macsec_err;
+	u32 ipsec_err;
+
+	u64 ptype_pkts[SXE2_MAX_PTYPE_NUM];
+};
+
+struct sxe2_rxq_sw_stats {
+	RTE_ATOMIC(uint64_t)pkts;
+	RTE_ATOMIC(uint64_t)bytes;
+	RTE_ATOMIC(uint64_t)drop_pkts;
+	RTE_ATOMIC(uint64_t)drop_bytes;
+	RTE_ATOMIC(uint64_t)unicast_pkts;
+	RTE_ATOMIC(uint64_t)multicast_pkts;
+	RTE_ATOMIC(uint64_t)broadcast_pkts;
+};
+
+struct sxe2_rx_queue {
+	volatile union sxe2_rx_desc *desc_ring;
+	volatile u32 *rdt_reg_addr;
+	struct rte_mempool *mb_pool;
+	struct rte_mbuf **buffer_ring;
+	struct sxe2_vsi *vsi;
+
+	u64 offloads;
+	u16 ring_depth;
+	u16 rx_free_thresh;
+	u16 processing_idx;
+	u16 hold_num;
+	u16 next_ret_pkt;
+	u16 batch_alloc_trigger;
+	u16 completed_pkts_num;
+	u64 update_time;
+	u32 desc_ts;
+	u64 ts_high;
+	u32 ts_low;
+	u32 ts_need_update;
+	u8  crc_len;
+	bool fnav_enable;
+
+	struct rte_eth_rxseg_split rx_seg[SXE2_RX_SEG_NUM];
+
+	struct rte_mbuf *completed_buf[SXE2_RX_PKTS_BURST_BATCH_NUM * 2];
+	struct rte_mbuf *pkt_first_seg;
+	struct rte_mbuf *pkt_last_seg;
+	u64 mbuf_init_value;
+	u16 realloc_num;
+	u16 realloc_start;
+	struct rte_mbuf fake_mbuf;
+
+	const struct rte_memzone *mz;
+	struct sxe2_rxq_ops ops;
+	rte_iova_t base_addr;
+	u16 reg_idx;
+	u32 low_desc_waterline : 16;
+	u32 ldw_event_pending : 1;
+#ifdef SXE2_DPDK_DEBUG
+	struct sxe2_rxq_stats rx_stats;
+	struct sxe2_rxq_stats rx_stats_cur;
+	struct sxe2_rxq_stats rx_stats_prev;
+#endif
+	struct sxe2_rxq_sw_stats sw_stats;
+	u16 port_id;
+	u16 queue_id;
+	u16 idx_in_func;
+	u16 rx_buf_len;
+	u16 rx_hdr_len;
+	u16 max_pkt_len;
+	bool rx_deferred_start;
+	u8 drop_en;
+};
+
+#ifdef SXE2_DPDK_DEBUG
+#define SXE2_RX_STATS_CNT(rxq, name, num) \
+	((((struct sxe2_rx_queue *)(rxq))->rx_stats.name) += (num))
+
+#define SXE2_TX_STATS_CNT(txq, name, num) \
+	((((struct sxe2_tx_queue *)(txq))->tx_stats.name) += (num))
+#else
+#define SXE2_RX_STATS_CNT(rxq, name, num)
+#define SXE2_TX_STATS_CNT(txq, name, num)
+#endif
+
+#ifdef SXE2_DPDK_DEBUG_RXTX_LOG
+#define PMD_LOG_RX_DEBUG(fmt, ...)PMD_LOG_DEBUG(RX, fmt, ##__VA_ARGS__)
+
+#define PMD_LOG_RX_INFO(fmt, ...) PMD_LOG_INFO(RX, fmt, ##__VA_ARGS__)
+
+#define PMD_LOG_TX_DEBUG(fmt, ...) PMD_LOG_DEBUG(TX, fmt, ##__VA_ARGS__)
+
+#define PMD_LOG_TX_INFO(fmt, ...) PMD_LOG_INFO(TX, fmt, ##__VA_ARGS__)
+#else
+#define PMD_LOG_RX_DEBUG(fmt, ...)
+#define PMD_LOG_RX_INFO(fmt, ...)
+#define PMD_LOG_TX_DEBUG(fmt, ...)
+#define PMD_LOG_TX_INFO(fmt, ...)
+#endif
+
+struct sxe2_adapter;
+
+void sxe2_sw_queue_ctx_hw_cap_set(struct sxe2_adapter *adapter,
+		struct sxe2_drv_queue_caps *q_caps);
+
+s32 sxe2_queues_init(struct rte_eth_dev *dev);
+
+#endif
diff --git a/drivers/net/sxe2/sxe2_txrx_common.h b/drivers/net/sxe2/sxe2_txrx_common.h
new file mode 100644
index 0000000000..7284cea4b6
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_txrx_common.h
@@ -0,0 +1,541 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#ifndef _SXE2_TXRX_COMMON_H_
+#define _SXE2_TXRX_COMMON_H_
+#include <stdbool.h>
+#include "sxe2_type.h"
+
+#define SXE2_ALIGN_RING_DESC      32
+#define SXE2_MIN_RING_DESC        64
+#define SXE2_MAX_RING_DESC        4096
+
+#define SXE2_VECTOR_PATH               0
+#define SXE2_VECTOR_OFFLOAD_PATH       1
+#define SXE2_VECTOR_CTX_OFFLOAD_PATH   2
+
+#define SXE2_MAX_PTYPE_NUM     1024
+#define SXE2_MIN_BUF_SIZE      1024
+
+#define SXE2_ALIGN                32
+#define SXE2_DESC_ADDR_ALIGN      128
+
+#define SXE2_MIN_TSO_MSS       88
+#define SXE2_MAX_TSO_MSS       9728
+
+#define SXE2_TX_MTU_SEG_MAX      15
+
+#define SXE2_TX_MIN_PKT_LEN    17
+#define SXE2_TX_MAX_BURST      32
+#define SXE2_TX_MAX_FREE_BUF   64
+#define SXE2_TX_TSO_PKTLEN_MAX        (256ULL * 1024)
+
+#define DEFAULT_TX_RS_THRESH   32
+#define DEFAULT_TX_FREE_THRESH 32
+
+#define SXE2_TX_FLAGS_VLAN_TAG_LOC_L2TAG1	BIT(0)
+#define SXE2_TX_FLAGS_VLAN_TAG_LOC_L2TAG2	BIT(1)
+
+#define SXE2_TX_PKTS_BURST_BATCH_NUM	32
+
+union sxe2_tx_offload_info {
+	u64 data;
+	struct {
+		u64 l2_len:7;
+		u64 l3_len:9;
+		u64 l4_len:8;
+		u64 tso_segsz:16;
+		u64 outer_l2_len:8;
+		u64 outer_l3_len:16;
+	};
+};
+
+#define SXE2_TX_OFFLOAD_CTXT_NEEDCK_MASK (RTE_MBUF_F_TX_TCP_SEG | \
+				RTE_MBUF_F_TX_UDP_SEG | \
+				RTE_MBUF_F_TX_QINQ | \
+				RTE_MBUF_F_TX_OUTER_IP_CKSUM | \
+				RTE_MBUF_F_TX_OUTER_UDP_CKSUM | \
+				RTE_MBUF_F_TX_SEC_OFFLOAD | \
+				RTE_MBUF_F_TX_IEEE1588_TMST)
+
+#define SXE2_TX_OFFLOAD_CKSUM_MASK (RTE_MBUF_F_TX_IP_CKSUM | \
+				RTE_MBUF_F_TX_L4_MASK | \
+				RTE_MBUF_F_TX_TCP_SEG | \
+				RTE_MBUF_F_TX_UDP_SEG | \
+				RTE_MBUF_F_TX_OUTER_UDP_CKSUM | \
+				RTE_MBUF_F_TX_OUTER_IP_CKSUM)
+
+struct sxe2_tx_context_desc {
+	__le32 tunneling_params;
+	__le16 l2tag2;
+	__le16 ipsec_offset;
+	__le64 type_cmd_tso_mss;
+};
+
+#define SXE2_TX_CTXT_DESC_EIPLEN_SHIFT	2
+#define SXE2_TX_CTXT_DESC_L4TUNT_SHIFT	9
+#define SXE2_TX_CTXT_DESC_NATLEN_SHIFT	12
+#define SXE2_TX_CTXT_DESC_L4T_CS_SHIFT	23
+
+#define SXE2_TX_CTXT_DESC_CMD_SHIFT			4
+#define SXE2_TX_CTXT_DESC_IPSEC_MODE_SHIFT	11
+#define SXE2_TX_CTXT_DESC_IPSEC_EN_SHIFT		12
+#define SXE2_TX_CTXT_DESC_IPSEC_ENGINE_SHIFT	13
+#define SXE2_TX_CTXT_DESC_IPSEC_SA_SHIFT		16
+#define SXE2_TX_CTXT_DESC_TSO_LEN_SHIFT		30
+#define SXE2_TX_CTXT_DESC_MSS_SHIFT			50
+#define SXE2_TX_CTXT_DESC_VSI_SHIFT	        50
+
+#define SXE2_TX_CTXT_DESC_L4T_CS_MASK  RTE_BIT64(SXE2_TX_CTXT_DESC_L4T_CS_SHIFT)
+
+#define SXE2_TX_CTXT_DESC_EIPLEN_VAL(val) \
+		(((val) >> 2) << SXE2_TX_CTXT_DESC_EIPLEN_SHIFT)
+#define SXE2_TX_CTXT_DESC_NATLEN_VAL(val) \
+		(((val) >> 1) << SXE2_TX_CTXT_DESC_NATLEN_SHIFT)
+
+enum sxe2_tx_ctxt_desc_eipt_bits {
+	SXE2_TX_CTXT_DESC_EIPT_NONE         = 0x0,
+	SXE2_TX_CTXT_DESC_EIPT_IPV6         = 0x1,
+	SXE2_TX_CTXT_DESC_EIPT_IPV4_NO_CSUM = 0x2,
+	SXE2_TX_CTXT_DESC_EIPT_IPV4         = 0x3,
+};
+
+enum sxe2_tx_ctxt_desc_l4tunt_bits {
+	SXE2_TX_CTXT_DESC_UDP_TUNNE = 0x1 << SXE2_TX_CTXT_DESC_L4TUNT_SHIFT,
+	SXE2_TX_CTXT_DESC_GRE_TUNNE = 0x2 << SXE2_TX_CTXT_DESC_L4TUNT_SHIFT,
+};
+
+enum sxe2_tx_ctxt_desc_cmd_bits {
+	SXE2_TX_CTXT_DESC_CMD_TSO          = 0x01,
+	SXE2_TX_CTXT_DESC_CMD_TSYN         = 0x02,
+	SXE2_TX_CTXT_DESC_CMD_IL2TAG2      = 0x04,
+	SXE2_TX_CTXT_DESC_CMD_IL2TAG2_IL2H = 0x08,
+	SXE2_TX_CTXT_DESC_CMD_SWTCH_NOTAG  = 0x00,
+	SXE2_TX_CTXT_DESC_CMD_SWTCH_UPLINK = 0x10,
+	SXE2_TX_CTXT_DESC_CMD_SWTCH_LOCAL  = 0x20,
+	SXE2_TX_CTXT_DESC_CMD_SWTCH_VSI    = 0x30,
+	SXE2_TX_CTXT_DESC_CMD_RESERVED     = 0x40
+};
+#define SXE2_TX_CTXT_DESC_IPSEC_MODE		RTE_BIT64(SXE2_TX_CTXT_DESC_IPSEC_MODE_SHIFT)
+#define SXE2_TX_CTXT_DESC_IPSEC_EN		RTE_BIT64(SXE2_TX_CTXT_DESC_IPSEC_EN_SHIFT)
+#define SXE2_TX_CTXT_DESC_IPSEC_ENGINE	RTE_BIT64(SXE2_TX_CTXT_DESC_IPSEC_ENGINE_SHIFT)
+#define SXE2_TX_CTXT_DESC_CMD_TSYN_MASK   \
+		(((u64)SXE2_TX_CTXT_DESC_CMD_TSYN) << SXE2_TX_CTXT_DESC_CMD_SHIFT)
+#define SXE2_TX_CTXT_DESC_CMD_IL2TAG2_MASK   \
+		(((u64)SXE2_TX_CTXT_DESC_CMD_IL2TAG2) << SXE2_TX_CTXT_DESC_CMD_SHIFT)
+
+union sxe2_tx_data_desc {
+	struct {
+		__le64 buf_addr;
+		__le64 type_cmd_off_bsz_l2t;
+	} read;
+	struct {
+		__le64 rsvd;
+		__le64 dd;
+	} wb;
+};
+
+#define SXE2_TX_DATA_DESC_CMD_SHIFT	4
+#define SXE2_TX_DATA_DESC_OFFSET_SHIFT	16
+#define SXE2_TX_DATA_DESC_BUF_SZ_SHIFT	34
+#define SXE2_TX_DATA_DESC_L2TAG1_SHIFT	48
+
+#define SXE2_TX_DATA_DESC_CMD_MASK	\
+		(0xFFFULL   << SXE2_TX_DATA_DESC_CMD_SHIFT)
+#define SXE2_TX_DATA_DESC_OFFSET_MASK	\
+		(0x3FFFFULL << SXE2_TX_DATA_DESC_OFFSET_SHIFT)
+#define SXE2_TX_DATA_DESC_BUF_SZ_MASK	\
+		(0x3FFFULL  << SXE2_TX_DATA_DESC_BUF_SZ_SHIFT)
+#define SXE2_TX_DATA_DESC_L2TAG1_MASK	\
+		(0xFFFFULL  << SXE2_TX_DATA_DESC_L2TAG1_SHIFT)
+
+#define SXE2_TX_DESC_LENGTH_MACLEN_SHIFT		 (0)
+#define SXE2_TX_DESC_LENGTH_IPLEN_SHIFT		 (7)
+#define SXE2_TX_DESC_LENGTH_L4_FC_LEN_SHIFT	 (14)
+
+#define SXE2_TX_DESC_DTYPE_MASK	0xF
+#define SXE2_TX_DATA_DESC_MACLEN_MASK \
+		(0x7FULL << SXE2_TX_DESC_LENGTH_MACLEN_SHIFT)
+#define SXE2_TX_DATA_DESC_IPLEN_MASK  \
+		(0x7FULL << SXE2_TX_DESC_LENGTH_IPLEN_SHIFT)
+#define SXE2_TX_DATA_DESC_L4LEN_MASK  \
+		(0xFULL  << SXE2_TX_DESC_LENGTH_L4_FC_LEN_SHIFT)
+
+#define SXE2_TX_DATA_DESC_MACLEN_VAL(val)	\
+	(((val) >> 1) << SXE2_TX_DESC_LENGTH_MACLEN_SHIFT)
+#define SXE2_TX_DATA_DESC_IPLEN_VAL(val)	\
+	(((val) >> 2) << SXE2_TX_DESC_LENGTH_IPLEN_SHIFT)
+#define SXE2_TX_DATA_DESC_L4LEN_VAL(val)	\
+	(((val) >> 2) << SXE2_TX_DESC_LENGTH_L4_FC_LEN_SHIFT)
+
+enum sxe2_tx_desc_type {
+	SXE2_TX_DESC_DTYPE_DATA      = 0x0,
+	SXE2_TX_DESC_DTYPE_CTXT      = 0x1,
+	SXE2_TX_DESC_DTYPE_FLTR_PROG = 0x8,
+	SXE2_TX_DESC_DTYPE_DESC_DONE = 0xF,
+};
+
+enum sxe2_tx_data_desc_cmd_bits {
+	SXE2_TX_DATA_DESC_CMD_EOP            = 0x0001,
+	SXE2_TX_DATA_DESC_CMD_RS             = 0x0002,
+	SXE2_TX_DATA_DESC_CMD_MACSEC         = 0x0004,
+	SXE2_TX_DATA_DESC_CMD_IL2TAG1        = 0x0008,
+	SXE2_TX_DATA_DESC_CMD_DUMMY          = 0x0010,
+	SXE2_TX_DATA_DESC_CMD_IIPT_IPV6      = 0x0020,
+	SXE2_TX_DATA_DESC_CMD_IIPT_IPV4      = 0x0040,
+	SXE2_TX_DATA_DESC_CMD_IIPT_IPV4_CSUM = 0x0060,
+	SXE2_TX_DATA_DESC_CMD_L4T_EOFT_TCP   = 0x0100,
+	SXE2_TX_DATA_DESC_CMD_L4T_EOFT_SCTP  = 0x0200,
+	SXE2_TX_DATA_DESC_CMD_L4T_EOFT_UDP   = 0x0300,
+	SXE2_TX_DATA_DESC_CMD_RE             = 0x0400
+};
+#define SXE2_TX_DATA_DESC_CMD_RS_MASK	\
+		(((u64)SXE2_TX_DATA_DESC_CMD_RS) << SXE2_TX_DATA_DESC_CMD_SHIFT)
+
+#define SXE2_TX_MAX_DATA_NUM_PER_DESC	0X3FFFUL
+
+#define SXE2_TX_DESC_RING_ALIGN	\
+	(SXE2_ALIGN_RING_DESC / sizeof(union sxe2_tx_data_desc))
+
+#define SXE2_TX_DESC_DTYPE_DESC_MASK 0xF
+
+#define SXE2_TX_FILL_PER_LOOP          4
+#define SXE2_TX_FILL_PER_LOOP_MASK     (SXE2_TX_FILL_PER_LOOP - 1)
+#define SXE2_TX_FREE_BUFFER_SIZE_MAX  (64)
+
+#define SXE2_RX_MAX_BURST              32
+#define SXE2_RING_SIZE_MIN             1024
+#define SXE2_RX_MAX_NSEG               2
+
+#define SXE2_RX_PKTS_BURST_BATCH_NUM	  SXE2_RX_MAX_BURST
+#define SXE2_VPMD_RX_MAX_BURST         SXE2_RX_MAX_BURST
+
+#define SXE2_RXQ_CTX_DBUFF_SHIFT       7
+
+#define SXE2_RX_NUM_PER_LOOP			8
+
+#define SXE2_RX_FLEX_DESC_PTYPE_S      (16)
+#define SXE2_RX_FLEX_DESC_PTYPE_M      (0x3FFULL)
+
+#define SXE2_RX_HBUF_LEN_UNIT          6
+#define SXE2_RX_LDW_LEN_UNIT           6
+#define SXE2_RX_DBUF_LEN_UNIT          7
+#define SXE2_RX_DBUF_LEN_MASK          (~0x7F)
+
+#define SXE2_RX_PKTS_TS_TIMEOUT_VAL	200
+
+#define SXE2_RX_VECTOR_OFFLOAD (			 \
+		RTE_ETH_RX_OFFLOAD_CHECKSUM   |		 \
+		RTE_ETH_RX_OFFLOAD_SCTP_CKSUM |		 \
+		RTE_ETH_RX_OFFLOAD_VLAN       |		 \
+		RTE_ETH_RX_OFFLOAD_RSS_HASH   |		 \
+		RTE_ETH_RX_OFFLOAD_TIMESTAMP)
+
+#define SXE2_DEFAULT_RX_FREE_THRESH  32
+#define SXE2_DEFAULT_RX_PTHRESH      8
+#define SXE2_DEFAULT_RX_HTHRESH      8
+#define SXE2_DEFAULT_RX_WTHRESH      0
+
+#define SXE2_DEFAULT_TX_FREE_THRESH  32
+#define SXE2_DEFAULT_TX_PTHRESH      32
+#define SXE2_DEFAULT_TX_HTHRESH      0
+#define SXE2_DEFAULT_TX_WTHRESH      0
+#define SXE2_DEFAULT_TX_RSBIT_THRESH 32
+
+#define SXE2_RX_SEG_NUM          2
+
+#ifdef RTE_LIBRTE_SXE2_16BYTE_RX_DESC
+#define sxe2_rx_desc sxe2_rx_16b_desc
+#else
+#define sxe2_rx_desc sxe2_rx_32b_desc
+#endif
+
+union sxe2_rx_16b_desc {
+	struct {
+		__le64 pkt_addr;
+		__le64 hdr_addr;
+	} read;
+	struct {
+		u8 rxdid_src;
+		u8 mirror;
+		__le16 l2tag1;
+		__le32 filter_status;
+
+		__le64 status_err_ptype_len;
+	} wb;
+};
+
+union sxe2_rx_32b_desc {
+	struct {
+		__le64 pkt_addr;
+		__le64 hdr_addr;
+		__le64 rsvd1;
+		__le64 rsvd2;
+	} read;
+	struct {
+		u8 rxdid_src;
+		u8 mirror;
+		__le16 l2tag1;
+		__le32 filter_status;
+
+		__le64 status_err_ptype_len;
+
+		__le32 status_lrocnt_fdpf_id;
+		__le16 l2tag2_1st;
+		__le16 l2tag2_2nd;
+
+		u8 acl_pf_id;
+		u8 sw_pf_id;
+		__le16 flow_id;
+
+		__le32 fd_filter_id;
+
+	} wb;
+	struct {
+		u8 rxdid_src_fd_eudpe;
+		u8 mirror;
+		__le16 l2_tag1;
+		__le32 filter_status;
+
+		__le64 status_err_ptype_len;
+
+		__le32 ext_status_ts_low;
+		__le16 l2tag2_1st;
+		__le16 l2tag2_2nd;
+
+		__le32 ts_h;
+		__le32 fd_filter_id;
+
+	} wb_ts;
+};
+
+enum sxe2_rx_lro_desc_max_num {
+	SXE2_RX_LRO_DESC_MAX_1   = 1,
+	SXE2_RX_LRO_DESC_MAX_4   = 4,
+	SXE2_RX_LRO_DESC_MAX_8   = 8,
+	SXE2_RX_LRO_DESC_MAX_16  = 16,
+	SXE2_RX_LRO_DESC_MAX_32  = 32,
+	SXE2_RX_LRO_DESC_MAX_48  = 48,
+	SXE2_RX_LRO_DESC_MAX_64  = 64,
+	SXE2_RX_LRO_DESC_MAX_NUM = SXE2_RX_LRO_DESC_MAX_64,
+};
+
+enum sxe2_rx_desc_rxdid {
+	SXE2_RX_DESC_RXDID_16B   = 0,
+	SXE2_RX_DESC_RXDID_32B,
+	SXE2_RX_DESC_RXDID_1588,
+	SXE2_RX_DESC_RXDID_FD,
+};
+
+#define SXE2_RX_DESC_RXDID_SHIFT     (0)
+#define SXE2_RX_DESC_RXDID_MASK      (0x7 << SXE2_RX_DESC_RXDID_SHIFT)
+#define SXE2_RX_DESC_RXDID_VAL_GET(rxdid_src) \
+		(((rxdid_src) & SXE2_RX_DESC_RXDID_MASK) >> SXE2_RX_DESC_RXDID_SHIFT)
+
+#define SXE2_RX_DESC_PKT_SRC_SHIFT     (3)
+#define SXE2_RX_DESC_PKT_SRC_MASK      (0x3 << SXE2_RX_DESC_PKT_SRC_SHIFT)
+#define SXE2_RX_DESC_PKT_SRC_VAL_GET(rxdid_src) \
+		(((rxdid_src) & SXE2_RX_DESC_PKT_SRC_MASK) >> SXE2_RX_DESC_PKT_SRC_SHIFT)
+
+#define SXE2_RX_DESC_FD_VLD_SHIFT     (5)
+#define SXE2_RX_DESC_FD_VLD_MASK      (0x1 << SXE2_RX_DESC_FD_VLD_SHIFT)
+#define SXE2_RX_DESC_FD_VLD_VAL_GET(rxdid_src) \
+		(((rxdid_src) & SXE2_RX_DESC_FD_VLD_MASK) >> SXE2_RX_DESC_FD_VLD_SHIFT)
+
+#define SXE2_RX_DESC_EUDPE_SHIFT     (6)
+#define SXE2_RX_DESC_EUDPE_MASK      (0x1 << SXE2_RX_DESC_EUDPE_SHIFT)
+#define SXE2_RX_DESC_EUDPE_VAL_GET(rxdid_src) \
+		(((rxdid_src) & SXE2_RX_DESC_EUDPE_MASK) >> SXE2_RX_DESC_EUDPE_SHIFT)
+
+#define SXE2_RX_DESC_UDP_NET_SHIFT     (7)
+#define SXE2_RX_DESC_UDP_NET_MASK      (0x1 << SXE2_RX_DESC_UDP_NET_SHIFT)
+#define SXE2_RX_DESC_UDP_NET_VAL_GET(rxdid_src) \
+		(((rxdid_src) & SXE2_RX_DESC_UDP_NET_MASK) >> SXE2_RX_DESC_UDP_NET_SHIFT)
+
+#define SXE2_RX_DESC_MIRR_ID_SHIFT   (0)
+#define SXE2_RX_DESC_MIRR_ID_MASK    (0x3F << SXE2_RX_DESC_MIRR_ID_SHIFT)
+#define SXE2_RX_DESC_MIRR_ID_VAL_GET(mirr) \
+		(((mirr) & SXE2_RX_DESC_MIRR_ID_MASK) >> SXE2_RX_DESC_MIRR_ID_SHIFT)
+
+#define SXE2_RX_DESC_MIRR_TYPE_SHIFT   (6)
+#define SXE2_RX_DESC_MIRR_TYPE_MASK    (0x3 << SXE2_RX_DESC_MIRR_TYPE_SHIFT)
+#define SXE2_RX_DESC_MIRR_TYPE_VAL_GET(mirr) \
+		(((mirr) & SXE2_RX_DESC_MIRR_TYPE_MASK) >> SXE2_RX_DESC_MIRR_TYPE_SHIFT)
+
+#define SXE2_RX_DESC_PKT_LEN_SHIFT   (32)
+#define SXE2_RX_DESC_PKT_LEN_MASK    (0x3FFFULL << SXE2_RX_DESC_PKT_LEN_SHIFT)
+#define SXE2_RX_DESC_PKT_LEN_VAL_GET(qw1) \
+		(((qw1) & SXE2_RX_DESC_PKT_LEN_MASK) >> SXE2_RX_DESC_PKT_LEN_SHIFT)
+
+#define SXE2_RX_DESC_HDR_LEN_SHIFT   (46)
+#define SXE2_RX_DESC_HDR_LEN_MASK    (0x7FFULL << SXE2_RX_DESC_HDR_LEN_SHIFT)
+#define SXE2_RX_DESC_HDR_LEN_VAL_GET(qw1) \
+		(((qw1) & SXE2_RX_DESC_HDR_LEN_MASK) >> SXE2_RX_DESC_HDR_LEN_SHIFT)
+
+#define SXE2_RX_DESC_SPH_SHIFT    (57)
+#define SXE2_RX_DESC_SPH_MASK     (0x1ULL << SXE2_RX_DESC_SPH_SHIFT)
+#define SXE2_RX_DESC_SPH_VAL_GET(qw1) \
+		(((qw1) & SXE2_RX_DESC_SPH_MASK) >> SXE2_RX_DESC_SPH_SHIFT)
+
+#define SXE2_RX_DESC_PTYPE_SHIFT    (16)
+#define SXE2_RX_DESC_PTYPE_MASK     (0x3FFULL << SXE2_RX_DESC_PTYPE_SHIFT)
+#define SXE2_RX_DESC_PTYPE_MASK_NO_SHIFT (0x3FFULL)
+#define SXE2_RX_DESC_PTYPE_VAL_GET(qw1) \
+		(((qw1) & SXE2_RX_DESC_PTYPE_MASK) >> SXE2_RX_DESC_PTYPE_SHIFT)
+
+#define SXE2_RX_DESC_FILTER_STATUS_SHIFT   (32)
+#define SXE2_RX_DESC_FILTER_STATUS_MASK    (0xFFFFUL)
+
+#define SXE2_RX_DESC_LROCNT_SHIFT   (0)
+#define SXE2_RX_DESC_LROCNT_MASK    (0xF)
+
+enum sxe2_rx_desc_status_shift {
+	SXE2_RX_DESC_STATUS_DD_SHIFT        = 0,
+	SXE2_RX_DESC_STATUS_EOP_SHIFT       = 1,
+	SXE2_RX_DESC_STATUS_L2TAG1_P_SHIFT  = 2,
+
+	SXE2_RX_DESC_STATUS_L3L4_P_SHIFT    = 3,
+	SXE2_RX_DESC_STATUS_CRCP_SHIFT      = 4,
+	SXE2_RX_DESC_STATUS_SECP_SHIFT      = 5,
+	SXE2_RX_DESC_STATUS_SECTAG_SHIFT    = 6,
+	SXE2_RX_DESC_STATUS_SECE_SHIFT      = 26,
+	SXE2_RX_DESC_STATUS_EXT_UDP_0_SHIFT = 27,
+	SXE2_RX_DESC_STATUS_UMBCAST_SHIFT   = 28,
+	SXE2_RX_DESC_STATUS_PHY_PORT_SHIFT  = 30,
+	SXE2_RX_DESC_STATUS_LPBK_SHIFT      = 59,
+	SXE2_RX_DESC_STATUS_IPV6_EXADD_SHIFT = 60,
+	SXE2_RX_DESC_STATUS_RSS_VLD_SHIFT   = 61,
+	SXE2_RX_DESC_STATUS_ACL_HIT_SHIFT   = 62,
+	SXE2_RX_DESC_STATUS_INT_UDP_0_SHIFT = 63,
+};
+
+#define SXE2_RX_DESC_STATUS_DD_MASK \
+		(0x1ULL << SXE2_RX_DESC_STATUS_DD_SHIFT)
+#define SXE2_RX_DESC_STATUS_EOP_MASK \
+		(0x1ULL << SXE2_RX_DESC_STATUS_EOP_SHIFT)
+#define SXE2_RX_DESC_STATUS_L2TAG1_P_MASK \
+		(0x1ULL << SXE2_RX_DESC_STATUS_L2TAG1_P_SHIFT)
+#define SXE2_RX_DESC_STATUS_L3L4_P_MASK \
+		(0x1ULL << SXE2_RX_DESC_STATUS_L3L4_P_SHIFT)
+#define SXE2_RX_DESC_STATUS_CRCP_MASK \
+		(0x1ULL << SXE2_RX_DESC_STATUS_CRCP_SHIFT)
+#define SXE2_RX_DESC_STATUS_SECP_MASK \
+		(0x1ULL << SXE2_RX_DESC_STATUS_SECP_SHIFT)
+#define SXE2_RX_DESC_STATUS_SECTAG_MASK \
+		(0x1ULL << SXE2_RX_DESC_STATUS_SECTAG_SHIFT)
+#define SXE2_RX_DESC_STATUS_SECE_MASK \
+		(0x1ULL << SXE2_RX_DESC_STATUS_SECE_SHIFT)
+#define SXE2_RX_DESC_STATUS_EXT_UDP_0_MASK \
+		(0x1ULL << SXE2_RX_DESC_STATUS_EXT_UDP_0_SHIFT)
+#define SXE2_RX_DESC_STATUS_UMBCAST_MASK \
+		(0x3ULL << SXE2_RX_DESC_STATUS_UMBCAST_SHIFT)
+#define SXE2_RX_DESC_STATUS_PHY_PORT_MASK \
+		(0x3ULL << SXE2_RX_DESC_STATUS_PHY_PORT_SHIFT)
+#define SXE2_RX_DESC_STATUS_LPBK_MASK \
+		(0x1ULL << SXE2_RX_DESC_STATUS_LPBK_SHIFT)
+#define SXE2_RX_DESC_STATUS_IPV6_EXADD_MASK \
+		(0x1ULL << SXE2_RX_DESC_STATUS_IPV6_EXADD_SHIFT)
+#define SXE2_RX_DESC_STATUS_RSS_VLD_MASK \
+		(0x1ULL << SXE2_RX_DESC_STATUS_RSS_VLD_SHIFT)
+#define SXE2_RX_DESC_STATUS_ACL_HIT_MASK \
+		(0x1ULL << SXE2_RX_DESC_STATUS_ACL_HIT_SHIFT)
+#define SXE2_RX_DESC_STATUS_INT_UDP_0_MASK \
+		(0x1ULL << SXE2_RX_DESC_STATUS_INT_UDP_0_SHIFT)
+
+enum sxe2_rx_desc_umbcast_val {
+	SXE2_RX_DESC_STATUS_UNICAST = 0,
+	SXE2_RX_DESC_STATUS_MUTICAST = 1,
+	SXE2_RX_DESC_STATUS_BOARDCAST = 2,
+};
+
+#define SXE2_RX_DESC_STATUS_UMBCAST_VAL_GET(qw1) \
+		(((qw1) & SXE2_RX_DESC_STATUS_UMBCAST_MASK) >> SXE2_RX_DESC_STATUS_UMBCAST_SHIFT)
+
+enum sxe2_rx_desc_error_shift {
+	SXE2_RX_DESC_ERROR_RXE_SHIFT        = 7,
+	SXE2_RX_DESC_ERROR_PKT_ECC_SHIFT    = 8,
+	SXE2_RX_DESC_ERROR_PKT_HBO_SHIFT    = 9,
+
+	SXE2_RX_DESC_ERROR_CSUM_IPE_SHIFT   = 10,
+
+	SXE2_RX_DESC_ERROR_CSUM_L4_SHIFT    = 11,
+
+	SXE2_RX_DESC_ERROR_CSUM_EIP_SHIFT   = 12,
+	SXE2_RX_DESC_ERROR_OVERSIZE_SHIFT   = 13,
+	SXE2_RX_DESC_ERROR_SEC_ERR_SHIFT    = 14,
+};
+
+#define SXE2_RX_DESC_ERROR_RXE_MASK \
+		(0x1ULL << SXE2_RX_DESC_ERROR_RXE_SHIFT)
+#define SXE2_RX_DESC_ERROR_PKT_ECC_MASK \
+		(0x1ULL << SXE2_RX_DESC_ERROR_PKT_ECC_SHIFT)
+#define SXE2_RX_DESC_ERROR_PKT_HBO_MASK \
+		(0x1ULL << SXE2_RX_DESC_ERROR_PKT_HBO_SHIFT)
+#define SXE2_RX_DESC_ERROR_CSUM_IPE_MASK \
+		(0x1ULL << SXE2_RX_DESC_ERROR_CSUM_IPE_SHIFT)
+#define SXE2_RX_DESC_ERROR_CSUM_L4_MASK \
+		(0x1ULL << SXE2_RX_DESC_ERROR_CSUM_L4_SHIFT)
+#define SXE2_RX_DESC_ERROR_CSUM_EIP_MASK \
+		(0x1ULL << SXE2_RX_DESC_ERROR_CSUM_EIP_SHIFT)
+#define SXE2_RX_DESC_ERROR_OVERSIZE_MASK \
+		(0x1ULL << SXE2_RX_DESC_ERROR_OVERSIZE_SHIFT)
+
+#define SXE2_RX_DESC_QW1_ERRORS_MASK \
+		(SXE2_RX_DESC_ERROR_CSUM_IPE_MASK | \
+			SXE2_RX_DESC_ERROR_CSUM_L4_MASK | \
+			SXE2_RX_DESC_ERROR_CSUM_EIP_MASK)
+
+enum sxe2_rx_desc_ext_status_shift {
+	SXE2_RX_DESC_EXT_STATUS_L2TAG2P_SHIFT	= 4,
+	SXE2_RX_DESC_EXT_STATUS_RSVD	= 5,
+	SXE2_RX_DESC_EXT_STATUS_PKT_REE_SHIFT	= 7,
+	SXE2_RX_DESC_EXT_STATUS_ROCE_SHIFT	= 13,
+};
+#define SXE2_RX_DESC_EXT_STATUS_L2TAG2P_MASK \
+			(0x1ULL << SXE2_RX_DESC_EXT_STATUS_L2TAG2P_SHIFT)
+#define SXE2_RX_DESC_EXT_STATUS_PKT_REE_MASK \
+			(0x3FULL << SXE2_RX_DESC_EXT_STATUS_PKT_REE_SHIFT)
+#define SXE2_RX_DESC_EXT_STATUS_ROCE_MASK \
+			(0x1ULL << SXE2_RX_DESC_EXT_STATUS_ROCE_SHIFT)
+
+enum sxe2_rx_desc_ipsec_shift {
+	SXE2_RX_DESC_IPSEC_PKT_S             = 21,
+	SXE2_RX_DESC_IPSEC_ENGINE_S          = 22,
+	SXE2_RX_DESC_IPSEC_MODE_S            = 23,
+	SXE2_RX_DESC_IPSEC_STATUS_S          = 24,
+
+	SXE2_RX_DESC_IPSEC_LAST
+};
+
+enum sxe2_rx_desc_ipsec_status {
+	SXE2_RX_DESC_IPSEC_STATUS_SUCCESS           = 0x0,
+	SXE2_RX_DESC_IPSEC_STATUS_PKG_OVER_2K       = 0x1,
+	SXE2_RX_DESC_IPSEC_STATUS_SPI_IP_INVALID    = 0x2,
+	SXE2_RX_DESC_IPSEC_STATUS_SA_INVALID        = 0x3,
+	SXE2_RX_DESC_IPSEC_STATUS_NOT_ALIGN         = 0x4,
+	SXE2_RX_DESC_IPSEC_STATUS_ICV_ERROR         = 0x5,
+	SXE2_RX_DESC_IPSEC_STATUS_BY_PASSH          = 0x6,
+	SXE2_RX_DESC_IPSEC_STATUS_MAC_BY_PASSH      = 0x7,
+};
+
+#define SXE2_RX_DESC_IPSEC_PKT_MASK \
+		(0x1ULL << SXE2_RX_DESC_IPSEC_PKT_S)
+#define SXE2_RX_DESC_IPSEC_STATUS_MASK		(0x7)
+#define SXE2_RX_DESC_IPSEC_STATUS_VAL_GET(qw2) \
+		(((qw2) >> SXE2_RX_DESC_IPSEC_STATUS_S) & \
+		SXE2_RX_DESC_IPSEC_STATUS_MASK)
+
+#define SXE2_RX_ERR_BITS 0x3f
+
+#define SXE2_RX_QUEUE_CHECK_INTERVAL_NUM 4
+
+#define SXE2_RX_DESC_RING_ALIGN	\
+	(SXE2_ALIGN / sizeof(union sxe2_rx_desc))
+
+#define SXE2_RX_RING_SIZE \
+	((SXE2_MAX_RING_DESC + SXE2_RX_PKTS_BURST_BATCH_NUM) * sizeof(union sxe2_rx_desc))
+
+#define SXE2_RX_MAX_DATA_BUF_SIZE	(16 * 1024 - 128)
+
+#endif
diff --git a/drivers/net/sxe2/sxe2_txrx_poll.h b/drivers/net/sxe2/sxe2_txrx_poll.h
new file mode 100644
index 0000000000..4924b0f41f
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_txrx_poll.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#ifndef SXE2_TXRX_POLL_H
+#define SXE2_TXRX_POLL_H
+
+#include "sxe2_queue.h"
+
+u16 sxe2_tx_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, u16 nb_pkts);
+
+u16 sxe2_rx_pkts_scattered(void *rx_queue, struct rte_mbuf **rx_pkts, u16 nb_pkts);
+
+u16 sxe2_rx_pkts_scattered_split(void *rx_queue, struct rte_mbuf **rx_pkts, u16 nb_pkts);
+
+#endif
diff --git a/drivers/net/sxe2/sxe2_vsi.c b/drivers/net/sxe2/sxe2_vsi.c
new file mode 100644
index 0000000000..1c8dccae0b
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_vsi.c
@@ -0,0 +1,211 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#include <rte_os.h>
+#include <rte_tailq.h>
+#include <rte_malloc.h>
+#include "sxe2_ethdev.h"
+#include "sxe2_vsi.h"
+#include "sxe2_common_log.h"
+#include "sxe2_cmd_chnl.h"
+
+void sxe2_sw_vsi_ctx_hw_cap_set(struct sxe2_adapter *adapter,
+		struct sxe2_drv_vsi_caps *vsi_caps)
+{
+	adapter->vsi_ctxt.dpdk_vsi_id = vsi_caps->dpdk_vsi_id;
+	adapter->vsi_ctxt.kernel_vsi_id = vsi_caps->kernel_vsi_id;
+	adapter->vsi_ctxt.vsi_type = vsi_caps->vsi_type;
+}
+
+static struct sxe2_vsi *
+sxe2_vsi_node_alloc(struct sxe2_adapter *adapter, u16 vsi_id, u16 vsi_type)
+{
+	struct sxe2_vsi *vsi = NULL;
+	vsi = rte_zmalloc("sxe2_vsi", sizeof(*vsi), 0);
+	if (vsi == NULL) {
+		PMD_LOG_ERR(DRV, "Failed to malloc vf vsi struct.");
+		goto l_end;
+	}
+	vsi->adapter = adapter;
+
+	vsi->vsi_id = vsi_id;
+	vsi->vsi_type = vsi_type;
+
+l_end:
+	return vsi;
+}
+
+static void sxe2_vsi_queues_num_set(struct sxe2_vsi *vsi, u16 num_queues, u16 base_idx)
+{
+	vsi->txqs.q_cnt = num_queues;
+	vsi->rxqs.q_cnt = num_queues;
+	vsi->txqs.base_idx_in_func = base_idx;
+	vsi->rxqs.base_idx_in_func = base_idx;
+}
+
+static void sxe2_vsi_queues_cfg(struct sxe2_vsi *vsi)
+{
+	vsi->txqs.depth = vsi->txqs.depth ? : SXE2_DFLT_NUM_TX_DESC;
+	vsi->rxqs.depth = vsi->rxqs.depth ? : SXE2_DFLT_NUM_RX_DESC;
+
+	PMD_LOG_INFO(DRV, "vsi:%u queue_cnt:%u txq_depth:%u rxq_depth:%u.",
+			vsi->vsi_id, vsi->txqs.q_cnt,
+			vsi->txqs.depth, vsi->rxqs.depth);
+}
+
+static void sxe2_vsi_irqs_cfg(struct sxe2_vsi *vsi, u16 num_irqs, u16 base_idx)
+{
+	vsi->irqs.avail_cnt = num_irqs;
+	vsi->irqs.base_idx_in_pf = base_idx;
+}
+
+static struct sxe2_vsi *sxe2_vsi_node_create(struct sxe2_adapter *adapter, u16 vsi_id, u16 vsi_type)
+{
+	struct sxe2_vsi *vsi = NULL;
+	u16 num_queues = 0;
+	u16 queue_base_idx = 0;
+	u16 num_irqs = 0;
+	u16 irq_base_idx = 0;
+
+	vsi = sxe2_vsi_node_alloc(adapter, vsi_id, vsi_type);
+	if (vsi == NULL)
+		goto l_end;
+
+	if (vsi_type == SXE2_VSI_T_DPDK_PF ||
+			vsi_type == SXE2_VSI_T_DPDK_VF) {
+		num_queues = adapter->q_ctxt.qp_cnt_assign;
+		queue_base_idx = adapter->q_ctxt.base_idx_in_pf;
+
+		num_irqs = adapter->irq_ctxt.max_cnt_hw;
+		irq_base_idx = adapter->irq_ctxt.base_idx_in_func;
+	} else if (vsi_type == SXE2_VSI_T_DPDK_ESW) {
+		num_queues = 1;
+		num_irqs = 1;
+	}
+
+	sxe2_vsi_queues_num_set(vsi, num_queues, queue_base_idx);
+
+	sxe2_vsi_queues_cfg(vsi);
+
+	sxe2_vsi_irqs_cfg(vsi, num_irqs, irq_base_idx);
+
+l_end:
+	return vsi;
+}
+
+static void sxe2_vsi_node_free(struct sxe2_vsi *vsi)
+{
+	if (!vsi)
+		return;
+
+	rte_free(vsi);
+	vsi = NULL;
+}
+
+static s32 sxe2_vsi_destroy(struct sxe2_adapter *adapter, struct sxe2_vsi *vsi)
+{
+	s32 ret = SXE2_SUCCESS;
+
+	if (vsi == NULL) {
+		PMD_LOG_INFO(DRV, "vsi is not created, no need to destroy.");
+		goto l_end;
+	}
+
+	if (vsi->vsi_type != SXE2_VSI_T_DPDK_ESW) {
+		ret = sxe2_drv_vsi_del(adapter, vsi);
+		if (ret) {
+			PMD_LOG_ERR(DRV, "Failed to del vsi from fw, ret=%d", ret);
+			if (ret == SXE2_ERR_PERM)
+				goto l_free;
+			goto l_end;
+		}
+	}
+
+l_free:
+	rte_free(vsi);
+	vsi = NULL;
+
+	PMD_LOG_DEBUG(DRV, "vsi destroyed.");
+l_end:
+	return ret;
+}
+
+static s32 sxe2_main_vsi_create(struct sxe2_adapter *adapter)
+{
+	s32 ret = SXE2_SUCCESS;
+	u16 vsi_id = adapter->vsi_ctxt.dpdk_vsi_id;
+	u16 vsi_type = adapter->vsi_ctxt.vsi_type;
+	bool is_reused = (vsi_id != SXE2_INVALID_VSI_ID);
+
+	PMD_INIT_FUNC_TRACE();
+
+	if (!is_reused)
+		vsi_type = SXE2_VSI_T_DPDK_PF;
+	else
+		PMD_LOG_INFO(DRV, "Reusing existing HW vsi_id:%u", vsi_id);
+
+	adapter->vsi_ctxt.main_vsi = sxe2_vsi_node_create(adapter, vsi_id, vsi_type);
+	if (adapter->vsi_ctxt.main_vsi == NULL) {
+		PMD_LOG_ERR(DRV, "Failed to create vsi struct, ret=%d", ret);
+		ret = -SXE2_ERR_INIT_VSI_CRITICAL;
+		goto l_end;
+	}
+
+	if (!is_reused) {
+		ret = sxe2_drv_vsi_add(adapter, adapter->vsi_ctxt.main_vsi);
+		if (ret) {
+			PMD_LOG_ERR(DRV, "Failed to config vsi to fw, ret=%d", ret);
+			goto l_free_vsi;
+		}
+
+		adapter->vsi_ctxt.dpdk_vsi_id = adapter->vsi_ctxt.main_vsi->vsi_id;
+		PMD_LOG_DEBUG(DRV, "Successfully created and synced new VSI");
+	}
+
+	goto l_end;
+
+l_free_vsi:
+	sxe2_vsi_node_free(adapter->vsi_ctxt.main_vsi);
+l_end:
+	return ret;
+}
+
+s32 sxe2_vsi_init(struct rte_eth_dev *dev)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	s32 ret = 0;
+
+	PMD_INIT_FUNC_TRACE();
+
+	ret = sxe2_main_vsi_create(adapter);
+	if (ret) {
+		PMD_LOG_ERR(DRV, "Failed to create main VSI, ret=%d", ret);
+		goto l_end;
+	}
+
+l_end:
+	return ret;
+}
+
+void sxe2_vsi_uninit(struct rte_eth_dev *dev)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	s32 ret;
+
+	if (adapter->vsi_ctxt.main_vsi == NULL) {
+		PMD_LOG_INFO(DRV, "vsi is not created, no need to destroy.");
+		goto l_end;
+	}
+
+	ret = sxe2_vsi_destroy(adapter, adapter->vsi_ctxt.main_vsi);
+	if (ret) {
+		PMD_LOG_ERR(DRV, "Failed to del vsi from fw, ret=%d", ret);
+		goto l_end;
+	}
+
+	PMD_LOG_DEBUG(DRV, "vsi destroyed.");
+
+l_end:
+	return;
+}
diff --git a/drivers/net/sxe2/sxe2_vsi.h b/drivers/net/sxe2/sxe2_vsi.h
new file mode 100644
index 0000000000..8870cbe22d
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_vsi.h
@@ -0,0 +1,205 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#ifndef __sxe2_VSI_H__
+#define __sxe2_VSI_H__
+#include <rte_os.h>
+#include "sxe2_type.h"
+#include "sxe2_drv_cmd.h"
+
+#define SXE2_MAX_BOND_MEMBER_CNT   4
+
+enum sxe2_drv_type {
+	SXE2_MAX_DRV_TYPE_DPDK = 0,
+	SXE2_MAX_DRV_TYPE_KERNEL,
+	SXE2_MAX_DRV_TYPE_CNT,
+};
+
+#define SXE2_MAX_USER_PRIORITY        (8)
+
+#define SXE2_DFLT_NUM_RX_DESC 512
+#define SXE2_DFLT_NUM_TX_DESC 512
+
+#define SXE2_DFLT_Q_NUM_OTHER_VSI 1
+#define SXE2_INVALID_VSI_ID    0xFFFF
+
+struct sxe2_adapter;
+struct sxe2_drv_vsi_caps;
+struct rte_eth_dev;
+
+enum sxe2_vsi_type {
+	SXE2_VSI_T_PF = 0,
+	SXE2_VSI_T_VF,
+	SXE2_VSI_T_CTRL,
+	SXE2_VSI_T_LB,
+	SXE2_VSI_T_MACVLAN,
+	SXE2_VSI_T_ESW,
+	SXE2_VSI_T_RDMA,
+	SXE2_VSI_T_DPDK_PF,
+	SXE2_VSI_T_DPDK_VF,
+	SXE2_VSI_T_DPDK_ESW,
+	SXE2_VSI_T_NR,
+};
+
+struct sxe2_queue_info {
+	u16 base_idx_in_nic;
+	u16 base_idx_in_func;
+	u16 q_cnt;
+	u16 depth;
+	u16 rx_buf_len;
+	u16 max_frame_len;
+	struct sxe2_queue **queues;
+};
+
+struct sxe2_vsi_irqs {
+	u16 avail_cnt;
+	u16 used_cnt;
+	u16 base_idx_in_pf;
+};
+
+enum {
+	sxe2_VSI_DOWN = 0,
+	sxe2_VSI_CLOSE,
+	sxe2_VSI_DISABLE,
+	sxe2_VSI_MAX,
+};
+
+struct sxe2_stats {
+	u64 ipackets;
+
+	u64 opackets;
+
+	u64 ibytes;
+
+	u64 obytes;
+
+	u64 ierrors;
+
+	u64 imissed;
+
+	u64 rx_out_of_buffer;
+	u64 rx_qblock_drop;
+
+	u64 tx_frame_good;
+	u64 rx_frame_good;
+	u64 rx_crc_errors;
+	u64 tx_bytes_good;
+	u64 rx_bytes_good;
+	u64 tx_multicast_good;
+	u64 tx_broadcast_good;
+	u64 rx_multicast_good;
+	u64 rx_broadcast_good;
+	u64 rx_len_errors;
+	u64 rx_out_of_range_errors;
+	u64 rx_oversize_pkts_phy;
+	u64 rx_symbol_err;
+	u64 rx_pause_frame;
+	u64 tx_pause_frame;
+
+	u64 rx_discards_phy;
+	u64 rx_discards_ips_phy;
+
+	u64 tx_dropped_link_down;
+	u64 rx_undersize_good;
+	u64 rx_runt_error;
+	u64 tx_bytes_good_bad;
+	u64 tx_frame_good_bad;
+	u64 rx_jabbers;
+	u64 rx_size_64;
+	u64 rx_size_65_127;
+	u64 rx_size_128_255;
+	u64 rx_size_256_511;
+	u64 rx_size_512_1023;
+	u64 rx_size_1024_1522;
+	u64 rx_size_1523_max;
+	u64 rx_pcs_symbol_err_phy;
+	u64 rx_corrected_bits_phy;
+	u64 rx_err_lane_0_phy;
+	u64 rx_err_lane_1_phy;
+	u64 rx_err_lane_2_phy;
+	u64 rx_err_lane_3_phy;
+
+	u64 rx_prio_buf_discard[SXE2_MAX_USER_PRIORITY];
+	u64 rx_illegal_bytes;
+	u64 rx_oversize_good;
+	u64 tx_unicast;
+	u64 tx_broadcast;
+	u64 tx_multicast;
+	u64 tx_vlan_packet_good;
+	u64 tx_size_64;
+	u64 tx_size_65_127;
+	u64 tx_size_128_255;
+	u64 tx_size_256_511;
+	u64 tx_size_512_1023;
+	u64 tx_size_1024_1522;
+	u64 tx_size_1523_max;
+	u64 tx_underflow_error;
+	u64 rx_byte_good_bad;
+	u64 rx_frame_good_bad;
+	u64 rx_unicast_good;
+	u64 rx_vlan_packets;
+
+	u64 prio_xoff_rx[SXE2_MAX_USER_PRIORITY];
+	u64 prio_xon_rx[SXE2_MAX_USER_PRIORITY];
+	u64 prio_xon_tx[SXE2_MAX_USER_PRIORITY];
+	u64 prio_xoff_tx[SXE2_MAX_USER_PRIORITY];
+	u64 prio_xon_2_xoff[SXE2_MAX_USER_PRIORITY];
+
+	u64 rx_vsi_unicast_packets;
+	u64 rx_vsi_bytes;
+	u64 tx_vsi_unicast_packets;
+	u64 tx_vsi_bytes;
+	u64 rx_vsi_multicast_packets;
+	u64 tx_vsi_multicast_packets;
+	u64 rx_vsi_broadcast_packets;
+	u64 tx_vsi_broadcast_packets;
+
+	u64 rx_sw_unicast_packets;
+	u64 rx_sw_broadcast_packets;
+	u64 rx_sw_multicast_packets;
+	u64 rx_sw_drop_packets;
+	u64 rx_sw_drop_bytes;
+};
+
+struct sxe2_vsi_stats {
+	struct sxe2_stats        vsi_sw_stats;
+	struct sxe2_stats        vsi_sw_stats_prev;
+	struct sxe2_stats        vsi_hw_stats;
+	struct sxe2_stats        stats;
+};
+
+struct sxe2_vsi {
+	TAILQ_ENTRY(sxe2_vsi) next;
+	struct sxe2_adapter *adapter;
+	u16 vsi_id;
+	u16 vsi_type;
+	struct sxe2_vsi_irqs irqs;
+	struct sxe2_queue_info txqs;
+	struct sxe2_queue_info rxqs;
+	u16 budget;
+	struct sxe2_vsi_stats vsi_stats;
+};
+
+TAILQ_HEAD(sxe2_vsi_list_head, sxe2_vsi);
+
+struct sxe2_vsi_context {
+	u16 func_id;
+	u16 dpdk_vsi_id;
+	u16 kernel_vsi_id;
+	u16 vsi_type;
+
+	u16 bond_member_kernel_vsi_id[SXE2_MAX_BOND_MEMBER_CNT];
+	u16 bond_member_dpdk_vsi_id[SXE2_MAX_BOND_MEMBER_CNT];
+
+	struct sxe2_vsi *main_vsi;
+};
+
+void sxe2_sw_vsi_ctx_hw_cap_set(struct sxe2_adapter *adapter,
+		struct sxe2_drv_vsi_caps *vsi_caps);
+
+s32 sxe2_vsi_init(struct rte_eth_dev *dev);
+
+void sxe2_vsi_uninit(struct rte_eth_dev *dev);
+
+#endif
-- 
2.47.3

