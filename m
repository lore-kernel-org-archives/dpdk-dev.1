Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9E5CD4F25
	for <dpdk-dev@archiver.kernel.org>; Sat, 16 May 2026 07:47:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D593740662;
	Sat, 16 May 2026 09:46:35 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id ED47140281
 for <dev@dpdk.org>; Sat, 16 May 2026 09:46:29 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowAB3XOPSIAhqhIMqEQ--.2759S7;
 Sat, 16 May 2026 15:46:27 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v15 05/11] drivers: add base driver probe skeleton
Date: Sat, 16 May 2026 15:46:12 +0800
Message-ID: <20260516074618.2343883-6-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260516074618.2343883-1-liujie5@linkdatatechnology.com>
References: <20260516025540.2092621-12-liujie5@linkdatatechnology.com>
 <20260516074618.2343883-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAB3XOPSIAhqhIMqEQ--.2759S7
X-Coremail-Antispam: 1UD129KBjvAXoWkXw48ury8Ww4DuFyxAr47Arb_yoWftFyfAo
 W7WrnxXw1rAwn7A3yDGw1xXFWjvw4rur4UC3y8ury5u3ZxGw15GFyfJFnrZF13WFZ5tr1q
 gFn2v3yktrW3AFWkn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UjIYCTnIWjp_UUUYK7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
 j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s0DM28Irc
 Ia0xkI8VCY1x0267AKxVW8JVW5JwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l
 84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F
 4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4U
 JwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
 IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
 M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0F24l42
 xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWU
 GwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI4
 8JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4U
 MIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I
 8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU1PfHUUUUU
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
 drivers/common/sxe2/sxe2_common.c          |   2 +-
 drivers/common/sxe2/sxe2_ioctl_chnl.c      |  33 +-
 drivers/common/sxe2/sxe2_ioctl_chnl_func.h |  11 +-
 drivers/common/sxe2/sxe2_osal.h            |  28 +-
 drivers/net/meson.build                    |   1 +
 drivers/net/sxe2/meson.build               |  23 +
 drivers/net/sxe2/sxe2_cmd_chnl.c           | 323 +++++++++++
 drivers/net/sxe2/sxe2_cmd_chnl.h           |  37 ++
 drivers/net/sxe2/sxe2_drv_cmd.h            | 388 +++++++++++++
 drivers/net/sxe2/sxe2_ethdev.c             | 613 +++++++++++++++++++++
 drivers/net/sxe2/sxe2_ethdev.h             | 293 ++++++++++
 drivers/net/sxe2/sxe2_irq.h                |  48 ++
 drivers/net/sxe2/sxe2_queue.c              |  38 ++
 drivers/net/sxe2/sxe2_queue.h              | 191 +++++++
 drivers/net/sxe2/sxe2_txrx_common.h        | 540 ++++++++++++++++++
 drivers/net/sxe2/sxe2_txrx_poll.h          |  16 +
 drivers/net/sxe2/sxe2_vsi.c                | 214 +++++++
 drivers/net/sxe2/sxe2_vsi.h                | 204 +++++++
 18 files changed, 2976 insertions(+), 27 deletions(-)
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

diff --git a/drivers/common/sxe2/sxe2_common.c b/drivers/common/sxe2/sxe2_common.c
index 27c33b1186..5cf43dd3b7 100644
--- a/drivers/common/sxe2/sxe2_common.c
+++ b/drivers/common/sxe2/sxe2_common.c
@@ -183,7 +183,7 @@ static int32_t sxe2_common_device_setup(struct sxe2_common_device *cdev)
 		goto l_end;
 	}
 
-	ret = sxe2_drv_dev_handshark(cdev);
+	ret = sxe2_drv_dev_handshke(cdev);
 	if (ret != 0) {
 		PMD_LOG_ERR(COM, "Handshark failed, ret=%d", ret);
 		goto l_close_dev;
diff --git a/drivers/common/sxe2/sxe2_ioctl_chnl.c b/drivers/common/sxe2/sxe2_ioctl_chnl.c
index 4c2bc452ff..11e24d04d9 100644
--- a/drivers/common/sxe2/sxe2_ioctl_chnl.c
+++ b/drivers/common/sxe2/sxe2_ioctl_chnl.c
@@ -112,9 +112,9 @@ sxe2_drv_dev_close(struct sxe2_common_device *cdev)
 	SXE2_CDEV_TO_CMD_FD(cdev) = -1;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(sxe2_drv_dev_handshark)
+RTE_EXPORT_INTERNAL_SYMBOL(sxe2_drv_dev_handshke)
 int32_t
-sxe2_drv_dev_handshark(struct sxe2_common_device *cdev)
+sxe2_drv_dev_handshke(struct sxe2_common_device *cdev)
 {
 	int32_t ret = 0;
 	int32_t cmd_fd = 0;
@@ -144,7 +144,7 @@ sxe2_drv_dev_handshark(struct sxe2_common_device *cdev)
 	if (ret < 0) {
 		PMD_LOG_ERR(COM, "Failed to handshark, fd=%d, ret=%d, err:%s",
 				cmd_fd, ret, strerror(errno));
-		ret = -EIO;
+		ret = -errno;
 		(void)pthread_mutex_unlock(&cdev->config.lock);
 		goto l_end;
 	}
@@ -158,3 +158,30 @@ sxe2_drv_dev_handshark(struct sxe2_common_device *cdev)
 l_end:
 	return ret;
 }
+
+RTE_EXPORT_INTERNAL_SYMBOL(sxe2_drv_dev_munmap)
+int32_t
+sxe2_drv_dev_munmap(struct sxe2_common_device *cdev, void *virt, uint64_t len)
+{
+	int32_t ret = 0;
+
+	if (cdev->config.kernel_reset) {
+		ret = -EPERM;
+		PMD_LOG_WARN(COM, "kernel reset, need restart app.");
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
+		ret = -errno;
+		goto l_end;
+	}
+
+l_end:
+	return ret;
+}
diff --git a/drivers/common/sxe2/sxe2_ioctl_chnl_func.h b/drivers/common/sxe2/sxe2_ioctl_chnl_func.h
index 055229b0c3..710ca1a8d0 100644
--- a/drivers/common/sxe2/sxe2_ioctl_chnl_func.h
+++ b/drivers/common/sxe2/sxe2_ioctl_chnl_func.h
@@ -35,7 +35,16 @@ sxe2_drv_dev_close(struct sxe2_common_device *cdev);
 
 __rte_internal
 int32_t
-sxe2_drv_dev_handshark(struct sxe2_common_device *cdev);
+sxe2_drv_dev_handshke(struct sxe2_common_device *cdev);
+
+__rte_internal
+void
+*sxe2_drv_dev_mmap(struct sxe2_common_device *cdev, uint8_t bar_idx,
+		uint64_t len, uint64_t offset);
+
+__rte_internal
+int32_t
+sxe2_drv_dev_munmap(struct sxe2_common_device *cdev, void *virt, uint64_t len);
 
 #ifdef __cplusplus
 }
diff --git a/drivers/common/sxe2/sxe2_osal.h b/drivers/common/sxe2/sxe2_osal.h
index 58a8dbc522..e16ee8c7f8 100644
--- a/drivers/common/sxe2/sxe2_osal.h
+++ b/drivers/common/sxe2/sxe2_osal.h
@@ -23,14 +23,6 @@
 #define BIT_WORD(nr)      ((nr) / __BITS_PER_LONG)
 #define BIT_MASK(nr)      (1UL << ((nr) % __BITS_PER_LONG))
 
-#define BITS_PER_BYTE 8
-
-#define IS_UNICAST_ETHER_ADDR(addr)			\
-	((bool)((((uint8_t *)(addr))[0] % ((uint8_t)0x2)) == 0))
-
-#define STRUCT_SIZE(ptr, field, num) \
-	(sizeof(*(ptr)) + sizeof(*(ptr)->field) * (num))
-
 #ifndef TAILQ_FOREACH_SAFE
 #define TAILQ_FOREACH_SAFE(var, head, field, tvar) \
 	for ((var) = TAILQ_FIRST((head)); \
@@ -38,16 +30,11 @@
 		(var) = (tvar))
 #endif
 
-#define SXE2_QUEUE_WAIT_RETRY_CNT    (50)
-
 #define upper_32_bits(n) ((uint32_t)(((n) >> 16) >> 16))
 #define lower_32_bits(n) ((uint32_t)((n) & 0xffffffff))
 
-#define FIELD_SIZEOF(t, f) RTE_SIZEOF_FIELD(t, f)
-#define ARRAY_SIZE(arr) RTE_DIM(arr)
-
-#ifndef DIV_ROUND_UP
-#define DIV_ROUND_UP(n, d) \
+#ifndef SXE2_DIV_ROUND_UP
+#define SXE2_DIV_ROUND_UP(n, d) \
 			(((n) + (typeof(n))(d) - (typeof(n))1) / (typeof(n))(d))
 #endif
 
@@ -58,12 +45,9 @@ enum sxe2_itr_idx {
 	SXE2_ITR_IDX_NONE,
 };
 
-#define  ETH_P_8021Q  0x8100
-#define  ETH_P_8021AD 0x88a8
-#define  ETH_P_QINQ1  0x9100
-
-#define BITS_TO_LONGS(nr) DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(unsigned long))
-#define BITS_TO_uint32_t(nr) DIV_ROUND_UP(nr, 32)
+#define SXE2_ETH_ALEN 6
+#define BITS_TO_LONGS(nr) SXE2_DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(unsigned long))
+#define BITS_TO_uint32_t(nr) SXE2_DIV_ROUND_UP(nr, 32)
 
 #define BITMAP_LAST_WORD_MASK(nbits) (~0UL >> (-(nbits) & (__BITS_PER_LONG - 1)))
 
@@ -81,7 +65,7 @@ static inline void sxe2_clear_bit(uint32_t nr, unsigned long *addr)
 	addr[nr / __BITS_PER_LONG] &= ~(1UL << (nr % __BITS_PER_LONG));
 }
 
-static inline uint32_t sxe2_test_bit(uint32_t nr, const volatile unsigned long *addr)
+static inline uint32_t sxe2_test_bit(uint32_t nr, const unsigned long *addr)
 {
 	return 1UL & (addr[BIT_WORD(nr)] >> (nr & (__BITS_PER_LONG-1)));
 }
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
index 0000000000..00c38b147c
--- /dev/null
+++ b/drivers/net/sxe2/meson.build
@@ -0,0 +1,23 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+
+if is_windows
+        build = false
+        reason = 'only supported on Linux'
+        subdir_done()
+endif
+
+cflags += ['-g']
+
+deps += ['common_sxe2', 'hash','cryptodev','security']
+
+includes += include_directories('../../common/sxe2')
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
index 0000000000..d16b6528d0
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_cmd_chnl.c
@@ -0,0 +1,323 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#include "sxe2_ioctl_chnl_func.h"
+#include "sxe2_drv_cmd.h"
+#include "sxe2_cmd_chnl.h"
+#include "sxe2_ethdev.h"
+#include "sxe2_common_log.h"
+
+static union sxe2_drv_trace_info sxe2_drv_trace_id;
+
+static void sxe2_drv_trace_id_alloc(uint64_t *trace_id)
+{
+	union sxe2_drv_trace_info *trace = NULL;
+	uint64_t trace_id_count = 0;
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
+		struct sxe2_drv_cmd_params *cmd, uint32_t opc, const char *opc_str,
+		void *in_data, uint32_t in_len, void *out_data, uint32_t out_len)
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
+int32_t sxe2_drv_dev_caps_get(struct sxe2_adapter *adapter, struct sxe2_drv_dev_caps_resp *dev_caps)
+{
+	int32_t ret = 0;
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
+int32_t sxe2_drv_dev_info_get(struct sxe2_adapter *adapter,
+				struct sxe2_drv_dev_info_resp *dev_info_resp)
+{
+	int32_t ret = 0;
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
+int32_t sxe2_drv_dev_fw_info_get(struct sxe2_adapter *adapter,
+				struct sxe2_drv_dev_fw_info_resp *dev_fw_info_resp)
+{
+	int32_t ret = 0;
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
+int32_t sxe2_drv_vsi_add(struct sxe2_adapter *adapter, struct sxe2_vsi *vsi)
+{
+	int32_t ret = 0;
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
+int32_t sxe2_drv_vsi_del(struct sxe2_adapter *adapter, struct sxe2_vsi *vsi)
+{
+	int32_t ret = 0;
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
+static int32_t sxe2_rxq_ctxt_cfg_fill(struct sxe2_rx_queue *rxq,
+		struct sxe2_drv_rxq_cfg_req *req, uint16_t rxq_cnt)
+{
+	struct sxe2_adapter *adapter = rxq->vsi->adapter;
+	struct sxe2_drv_rxq_ctxt *ctxt = req->cfg;
+	struct rte_eth_dev_data *dev_data = adapter->dev_info.dev_data;
+	int32_t ret = 0;
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
+int32_t sxe2_drv_rxq_ctxt_cfg(struct sxe2_adapter *adapter,
+			      struct sxe2_rx_queue *rxq,
+			      uint16_t rxq_cnt)
+{
+	int32_t ret = 0;
+	struct sxe2_common_device *cdev = adapter->cdev;
+	struct sxe2_drv_cmd_params param = {0};
+	struct sxe2_drv_rxq_cfg_req *req = NULL;
+	uint16_t len = 0;
+
+	len = sizeof(*req) + rxq_cnt * sizeof(struct sxe2_drv_rxq_ctxt);
+	req = rte_zmalloc("sxe2_rxq_cfg", len, 0);
+	if (req == NULL) {
+		PMD_LOG_ERR(RX, "rxq cfg mem alloc failed");
+		ret = -ENOMEM;
+		goto l_end;
+	}
+
+	ret = sxe2_rxq_ctxt_cfg_fill(rxq, req, rxq_cnt);
+	if (ret) {
+		PMD_DEV_LOG_ERR(adapter, DRV, "rxq cfg failed, ret=%d", ret);
+		ret = -EINVAL;
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
+				   struct sxe2_drv_txq_cfg_req *req,
+				   uint16_t txq_cnt)
+{
+	struct sxe2_drv_txq_ctxt *ctxt = req->cfg;
+	uint16_t q_idx = 0;
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
+int32_t sxe2_drv_txq_ctxt_cfg(struct sxe2_adapter *adapter,
+			      struct sxe2_tx_queue *txq,
+			      uint16_t txq_cnt)
+{
+	int32_t ret = 0;
+	struct sxe2_common_device *cdev = adapter->cdev;
+	struct sxe2_drv_cmd_params param = {0};
+	struct sxe2_drv_txq_cfg_req *req;
+	uint16_t len = 0;
+
+	len = sizeof(*req) + txq_cnt * sizeof(struct sxe2_drv_txq_ctxt);
+	req = rte_zmalloc("sxe2_txq_cfg", len, 0);
+	if (req == NULL) {
+		PMD_LOG_ERR(TX, "txq cfg mem alloc failed");
+		ret = -ENOMEM;
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
+int32_t sxe2_drv_rxq_switch(struct sxe2_adapter *adapter, struct sxe2_rx_queue *rxq, bool enable)
+{
+	int32_t ret = 0;
+	struct sxe2_common_device *cdev = adapter->cdev;
+	struct sxe2_drv_cmd_params param = {0};
+	struct sxe2_drv_q_switch_req req;
+
+	req.vsi_id = rte_cpu_to_le_16(rxq->vsi->vsi_id);
+	req.q_idx = rxq->queue_id;
+
+	req.is_enable  = (uint8_t)enable;
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
+int32_t sxe2_drv_txq_switch(struct sxe2_adapter *adapter, struct sxe2_tx_queue *txq, bool enable)
+{
+	int32_t ret = 0;
+	struct sxe2_common_device *cdev = adapter->cdev;
+	struct sxe2_drv_cmd_params param = {0};
+	struct sxe2_drv_q_switch_req req;
+
+	req.vsi_id = rte_cpu_to_le_16(txq->vsi->vsi_id);
+	req.q_idx = txq->queue_id;
+
+	req.is_enable  = (uint8_t)enable;
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
index 0000000000..cd41cd9e8d
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_cmd_chnl.h
@@ -0,0 +1,37 @@
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
+int32_t sxe2_drv_dev_caps_get(struct sxe2_adapter *adapter,
+		struct sxe2_drv_dev_caps_resp *dev_caps);
+
+int32_t sxe2_drv_dev_info_get(struct sxe2_adapter *adapter,
+		struct sxe2_drv_dev_info_resp *dev_info_resp);
+
+int32_t sxe2_drv_dev_fw_info_get(struct sxe2_adapter *adapter,
+		struct sxe2_drv_dev_fw_info_resp *dev_fw_info_resp);
+
+int32_t sxe2_drv_vsi_add(struct sxe2_adapter *adapter, struct sxe2_vsi *vsi);
+
+int32_t sxe2_drv_vsi_del(struct sxe2_adapter *adapter, struct sxe2_vsi *vsi);
+
+int32_t sxe2_drv_rxq_switch(struct sxe2_adapter *adapter, struct sxe2_rx_queue *rxq, bool enable);
+
+int32_t sxe2_drv_txq_switch(struct sxe2_adapter *adapter, struct sxe2_tx_queue *txq, bool enable);
+
+int32_t sxe2_drv_rxq_ctxt_cfg(struct sxe2_adapter *adapter,
+			      struct sxe2_rx_queue *rxq,
+			      uint16_t rxq_cnt);
+
+int32_t sxe2_drv_txq_ctxt_cfg(struct sxe2_adapter *adapter,
+			      struct sxe2_tx_queue *txq,
+			      uint16_t txq_cnt);
+
+#endif /* __SXE2_CMD_CHNL_H__ */
diff --git a/drivers/net/sxe2/sxe2_drv_cmd.h b/drivers/net/sxe2/sxe2_drv_cmd.h
new file mode 100644
index 0000000000..a16087c6bf
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_drv_cmd.h
@@ -0,0 +1,388 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#ifndef __SXE2_DRV_CMD_H__
+#define __SXE2_DRV_CMD_H__
+
+#include "sxe2_osal.h"
+
+#define SXE2_DRV_CMD_MODULE_S        (16)
+#define SXE2_MK_DRV_CMD(module, cmd) (((module) << SXE2_DRV_CMD_MODULE_S) | ((cmd) & 0xFFFF))
+
+#define SXE2_DEV_CAPS_OFFLOAD_L2    RTE_BIT32(0)
+#define SXE2_DEV_CAPS_OFFLOAD_VLAN  RTE_BIT32(1)
+#define SXE2_DEV_CAPS_OFFLOAD_RSS   RTE_BIT32(2)
+#define SXE2_DEV_CAPS_OFFLOAD_IPSEC RTE_BIT32(3)
+#define SXE2_DEV_CAPS_OFFLOAD_FNAV  RTE_BIT32(4)
+#define SXE2_DEV_CAPS_OFFLOAD_TM    RTE_BIT32(5)
+#define SXE2_DEV_CAPS_OFFLOAD_PTP   RTE_BIT32(6)
+#define SXE2_DEV_CAPS_OFFLOAD_Q_MAP RTE_BIT32(7)
+#define SXE2_DEV_CAPS_OFFLOAD_FC_STATE RTE_BIT32(8)
+
+#define SXE2_TXQ_STATS_MAP_MAX_NUM 16
+#define SXE2_RXQ_STATS_MAP_MAX_NUM 4
+#define SXE2_RXQ_MAP_Q_MAX_NUM 256
+
+#define SXE2_STAT_MAP_INVALID_QID 0xFFFF
+
+#define SXE2_SCHED_MODE_DEFAULT			0
+#define SXE2_SCHED_MODE_TM			1
+#define SXE2_SCHED_MODE_HIGH_PERFORMANCE	2
+#define SXE2_SCHED_MODE_INVALID			3
+
+#define SXE2_SRCVSI_PRUNE_MAX_NUM		2
+
+#define SXE2_PTYPE_UNKNOWN                   RTE_BIT32(0)
+#define SXE2_PTYPE_L2_ETHER                  RTE_BIT32(1)
+#define SXE2_PTYPE_L3_IPV4                   RTE_BIT32(2)
+#define SXE2_PTYPE_L3_IPV6                   RTE_BIT32(4)
+#define SXE2_PTYPE_L4_TCP                    RTE_BIT32(6)
+#define SXE2_PTYPE_L4_UDP                    RTE_BIT32(7)
+#define SXE2_PTYPE_L4_SCTP                   RTE_BIT32(8)
+#define SXE2_PTYPE_INNER_L2_ETHER            RTE_BIT32(9)
+#define SXE2_PTYPE_INNER_L3_IPV4             RTE_BIT32(10)
+#define SXE2_PTYPE_INNER_L3_IPV6             RTE_BIT32(12)
+#define SXE2_PTYPE_INNER_L4_TCP              RTE_BIT32(14)
+#define SXE2_PTYPE_INNER_L4_UDP              RTE_BIT32(15)
+#define SXE2_PTYPE_INNER_L4_SCTP             RTE_BIT32(16)
+#define SXE2_PTYPE_TUNNEL_GRENAT             RTE_BIT32(17)
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
+	uint16_t queues_cnt;
+	uint16_t base_idx_in_pf;
+};
+
+struct sxe2_drv_msix_caps {
+	uint16_t msix_vectors_cnt;
+	uint16_t base_idx_in_func;
+};
+
+struct sxe2_drv_rss_hash_caps {
+	uint16_t hash_key_size;
+	uint16_t lut_key_size;
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
+	uint16_t func_id;
+	uint16_t dpdk_vsi_id;
+	uint16_t kernel_vsi_id;
+	uint16_t vsi_type;
+};
+
+struct sxe2_drv_representor_caps {
+	uint16_t cnt_repr_vf;
+	uint8_t rsv[2];
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
+	uint8_t pf_id;
+	uint8_t is_switchdev;
+	uint8_t rsv[2];
+};
+
+struct sxe2_switchdev_cpvsi_info {
+	uint16_t cp_vsi_id;
+	uint8_t rsv[2];
+};
+
+struct sxe2_txsch_caps {
+	uint8_t layer_cap;
+	uint8_t tm_mid_node_num;
+	uint8_t prio_num;
+	uint8_t rev;
+};
+
+struct sxe2_drv_dev_caps_resp {
+	struct sxe2_drv_queue_caps queue_caps;
+	struct sxe2_drv_msix_caps msix_caps;
+	struct sxe2_drv_rss_hash_caps rss_hash_caps;
+	struct sxe2_drv_vsi_caps vsi_caps;
+	struct sxe2_txsch_caps   txsch_caps;
+	struct sxe2_drv_representor_caps repr_caps;
+	uint8_t port_idx;
+	uint8_t pf_idx;
+	uint8_t dev_type;
+	uint8_t rev;
+	uint32_t cap_flags;
+};
+
+struct sxe2_drv_dev_info_resp {
+	uint64_t dsn;
+	uint16_t vsi_id;
+	uint8_t rsv[2];
+	uint8_t mac_addr[SXE2_ETH_ALEN];
+	uint8_t rsv2[2];
+};
+
+struct sxe2_drv_dev_fw_info_resp {
+	uint8_t main_version_id;
+	uint8_t sub_version_id;
+	uint8_t fix_version_id;
+	uint8_t build_id;
+};
+
+struct sxe2_drv_rxq_ctxt {
+	uint64_t dma_addr;
+	uint32_t max_lro_size;
+	uint32_t split_type_mask;
+	uint16_t hdr_len;
+	uint16_t buf_len;
+	uint16_t depth;
+	uint16_t queue_id;
+	uint8_t lro_en;
+	uint8_t keep_crc_en;
+	uint8_t split_en;
+	uint8_t desc_size;
+};
+
+struct sxe2_drv_rxq_cfg_req {
+	uint16_t q_cnt;
+	uint16_t vsi_id;
+	uint16_t max_frame_size;
+	uint8_t rsv[2];
+	struct sxe2_drv_rxq_ctxt cfg[];
+};
+
+struct sxe2_drv_txq_ctxt {
+	uint64_t dma_addr;
+	uint32_t sched_mode;
+	uint16_t queue_id;
+	uint16_t depth;
+	uint16_t vsi_id;
+	uint8_t rsv[2];
+};
+
+struct sxe2_drv_txq_cfg_req {
+	uint16_t q_cnt;
+	uint16_t vsi_id;
+	struct sxe2_drv_txq_ctxt cfg[];
+};
+
+struct sxe2_drv_q_switch_req {
+	uint16_t q_idx;
+	uint16_t vsi_id;
+	uint8_t is_enable;
+	uint8_t sched_mode;
+	uint8_t rsv[2];
+};
+
+struct sxe2_drv_vsi_create_req_resp {
+	uint16_t vsi_id;
+	uint16_t vsi_type;
+	struct sxe2_drv_queue_caps used_queues;
+	struct sxe2_drv_msix_caps used_msix;
+};
+
+struct sxe2_drv_vsi_free_req {
+	uint16_t vsi_id;
+	uint8_t rsv[2];
+};
+
+struct sxe2_drv_vsi_info_get_req {
+	uint16_t vsi_id;
+	uint8_t rsv[2];
+};
+
+struct sxe2_drv_vsi_info_get_resp {
+	uint16_t vsi_id;
+	uint16_t vsi_type;
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
+#endif /* __SXE2_DRV_CMD_H__ */
diff --git a/drivers/net/sxe2/sxe2_ethdev.c b/drivers/net/sxe2/sxe2_ethdev.c
new file mode 100644
index 0000000000..f0bdda38a7
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_ethdev.c
@@ -0,0 +1,613 @@
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
+static int32_t sxe2_dev_configure(struct rte_eth_dev *dev)
+{
+	int32_t ret = 0;
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
+static int32_t sxe2_dev_stop(struct rte_eth_dev *dev)
+{
+	int32_t ret = 0;
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
+static int32_t __rte_cold sxe2_txqs_all_start(struct rte_eth_dev *dev __rte_unused)
+{
+	return 0;
+}
+
+static int32_t __rte_cold sxe2_rxqs_all_start(struct rte_eth_dev *dev __rte_unused)
+{
+	return 0;
+}
+
+static int32_t sxe2_queues_start(struct rte_eth_dev *dev)
+{
+	int32_t ret = 0;
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
+static int32_t sxe2_dev_start(struct rte_eth_dev *dev)
+{
+	int32_t ret = 0;
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
+static int32_t sxe2_dev_close(struct rte_eth_dev *dev)
+{
+	(void)sxe2_dev_stop(dev);
+
+	sxe2_vsi_uninit(dev);
+
+	return 0;
+}
+
+static int32_t sxe2_dev_infos_get(struct rte_eth_dev *dev,
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
+		RTE_ETH_RX_OFFLOAD_KEEP_CRC |
+		RTE_ETH_RX_OFFLOAD_SCATTER |
+		RTE_ETH_RX_OFFLOAD_IPV4_CKSUM |
+		RTE_ETH_RX_OFFLOAD_UDP_CKSUM |
+		RTE_ETH_RX_OFFLOAD_TCP_CKSUM |
+		RTE_ETH_RX_OFFLOAD_SCTP_CKSUM |
+		RTE_ETH_RX_OFFLOAD_OUTER_IPV4_CKSUM |
+		RTE_ETH_RX_OFFLOAD_BUFFER_SPLIT |
+		RTE_ETH_RX_OFFLOAD_TCP_LRO;
+
+	dev_info->tx_offload_capa =
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
+	return 0;
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
+static int32_t sxe2_func_caps_get(struct sxe2_adapter *adapter)
+{
+	int32_t ret = -1;
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
+static int32_t sxe2_dev_caps_get(struct sxe2_adapter *adapter)
+{
+	int32_t ret = -1;
+
+	ret = sxe2_func_caps_get(adapter);
+	if (ret)
+		PMD_LOG_ERR(INIT, "get function caps failed, ret=%d", ret);
+
+	return ret;
+}
+
+static int32_t sxe2_hw_init(struct rte_eth_dev *dev)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	int32_t ret = -1;
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
+static int32_t sxe2_dev_info_init(struct rte_eth_dev *dev)
+{
+	struct sxe2_adapter *adapter =
+		SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct rte_pci_device *pci_dev = RTE_DEV_TO_PCI(dev->device);
+	struct sxe2_dev_info *dev_info = &adapter->dev_info;
+	struct sxe2_drv_dev_info_resp dev_info_resp = {0};
+	struct sxe2_drv_dev_fw_info_resp dev_fw_info_resp = {0};
+	int32_t ret = 0;
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
+static int32_t sxe2_dev_init(struct rte_eth_dev *dev,
+			     struct sxe2_dev_kvargs_info *kvargs __rte_unused)
+{
+	int32_t ret = 0;
+
+	PMD_INIT_FUNC_TRACE();
+
+	dev->dev_ops = &sxe2_eth_dev_ops;
+
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		goto l_end;
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
+static int32_t sxe2_dev_uninit(struct rte_eth_dev *dev)
+{
+	int32_t ret = 0;
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
+static int32_t sxe2_eth_pmd_remove(struct sxe2_common_device *cdev)
+{
+	struct rte_eth_dev *eth_dev;
+	struct rte_pci_device *pci_dev = RTE_DEV_TO_PCI(cdev->dev);
+	int32_t ret = 0;
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
+static int32_t sxe2_eth_pmd_probe_pf(struct sxe2_common_device *cdev,
+		struct rte_eth_devargs *req_eth_da __rte_unused,
+		uint16_t owner_id __rte_unused,
+		struct sxe2_dev_kvargs_info *kvargs)
+{
+	struct rte_pci_device *pci_dev = RTE_DEV_TO_PCI(cdev->dev);
+	struct rte_eth_dev *eth_dev = NULL;
+	struct sxe2_adapter *adapter = NULL;
+	int32_t ret = 0;
+
+	if (!cdev) {
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	eth_dev = rte_eth_dev_pci_allocate(pci_dev, sizeof(struct sxe2_adapter));
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
+		if (eth_dev == NULL) {
+			PMD_LOG_ERR(INIT, "Can not allocate ethdev");
+			ret = -ENOMEM;
+			goto l_end;
+		}
+	} else {
+		if (!eth_dev) {
+			PMD_LOG_DEBUG(INIT, "Can not attach secondary ethdev");
+			ret = -EINVAL;
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
+	if (ret != 0) {
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
+static int32_t sxe2_parse_eth_devargs(struct rte_device *dev,
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
+static int32_t sxe2_eth_pmd_probe(struct sxe2_common_device *cdev,
+				  struct sxe2_dev_kvargs_info *kvargs)
+{
+	struct rte_eth_devargs eth_da = { .nb_ports = 0 };
+	int32_t ret = 0;
+
+	ret = sxe2_parse_eth_devargs(cdev->dev, &eth_da);
+	if (ret != 0) {
+		ret = -EINVAL;
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
+RTE_LOG_REGISTER_SUFFIX(sxe2_log_init, init, NOTICE);
+RTE_LOG_REGISTER_SUFFIX(sxe2_log_driver, driver, NOTICE);
+RTE_LOG_REGISTER_SUFFIX(sxe2_log_rx, rx, NOTICE);
+RTE_LOG_REGISTER_SUFFIX(sxe2_log_tx, tx, NOTICE);
+RTE_LOG_REGISTER_SUFFIX(sxe2_log_hw, hw, NOTICE);
diff --git a/drivers/net/sxe2/sxe2_ethdev.h b/drivers/net/sxe2/sxe2_ethdev.h
new file mode 100644
index 0000000000..c4634685e6
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_ethdev.h
@@ -0,0 +1,293 @@
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
+#include "sxe2_vsi.h"
+#include "sxe2_queue.h"
+#include "sxe2_irq.h"
+#include "sxe2_osal.h"
+
+struct sxe2_link_msg {
+	uint32_t speed;
+	uint8_t status;
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
+	(RTE_ETHER_HDR_LEN + RTE_ETHER_CRC_LEN + SXE2_VLAN_TAG_SIZE)
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
+#define upper_32_bits(n) ((uint32_t)(((n) >> 16) >> 16))
+#define lower_32_bits(n) ((uint32_t)((n) & 0xffffffff))
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
+	uint32_t  speed;
+};
+
+struct sxe2_devargs {
+	uint8_t flow_dup_pattern_mode;
+	uint8_t func_flow_direct_en;
+	uint8_t fnav_stat_type;
+	uint8_t high_performance_mode;
+	uint8_t sched_layer_mode;
+	uint8_t sw_stats_en;
+	uint8_t rx_low_latency;
+};
+
+#define SXE2_PCI_MAP_BAR_INVALID ((uint8_t)0xff)
+#define SXE2_PCI_MAP_INVALID_VAL ((uint32_t)0xffffffff)
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
+	uint64_t addr_base;
+	uint8_t bar_idx;
+	uint8_t reg_width;
+};
+
+struct sxe2_pci_map_segment_info {
+	enum sxe2_pci_map_resource	type;
+	void				*addr;
+	uint64_t			page_inner_offset;
+	uint64_t			len;
+};
+
+struct sxe2_pci_map_bar_info {
+	uint8_t    bar_idx;
+	uint8_t    map_cnt;
+	struct sxe2_pci_map_segment_info    *seg_info;
+};
+
+struct sxe2_pci_map_context {
+	uint8_t    bar_cnt;
+	struct sxe2_pci_map_bar_info *bar_info;
+	struct sxe2_pci_map_addr_info *addr_info;
+};
+
+struct sxe2_dev_mac_info {
+	uint8_t perm_addr[SXE2_ETH_ALEN];
+};
+
+struct sxe2_pci_info {
+	uint64_t                     serial_number;
+	uint8_t                      bus_devid;
+	uint8_t                      bus_function;
+	uint16_t                     max_vfs;
+};
+
+struct sxe2_fw_info {
+	uint8_t                      main_version_id;
+	uint8_t                      sub_version_id;
+	uint8_t                      fix_version_id;
+	uint8_t                      build_id;
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
+	uint8_t			protocol;
+	uint8_t			dev_status;
+	uint16_t			dev_port;
+	uint16_t			dev_ref_cnt;
+
+	uint16_t			fw_port;
+	uint8_t			fw_status;
+	uint8_t			fw_dst_en;
+	uint8_t			fw_src_en;
+	uint8_t			fw_used;
+};
+
+struct sxe2_udp_tunnel_ctx {
+	struct sxe2_udp_tunnel_cfg   tunnel_conf[SXE2_UDP_TUNNEL_MAX];
+	rte_spinlock_t                lock;
+};
+
+struct sxe2_repr_context {
+	uint16_t nb_vf;
+	uint16_t nb_repr_vf;
+	struct rte_eth_dev **vf_rep_eth_dev;
+	struct sxe2_drv_vsi_caps repr_vf_id[SXE2_VF_MAX_NUM];
+};
+
+struct sxe2_repr_private_data {
+	struct rte_eth_dev *rep_eth_dev;
+	struct sxe2_adapter *parent_adapter;
+
+	struct sxe2_vsi *cp_vsi;
+	uint16_t repr_q_id;
+
+	uint16_t repr_id;
+	uint16_t repr_pf_id;
+	uint16_t repr_vf_id;
+	uint16_t repr_vf_vsi_id;
+	uint16_t repr_vf_k_vsi_id;
+	uint16_t repr_vf_u_vsi_id;
+};
+
+struct sxe2_sched_hw_cap {
+	uint32_t tm_layers;
+	uint8_t root_max_children;
+	uint8_t prio_max;
+	uint8_t adj_lvl;
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
+	uint16_t                           dev_port_id;
+	uint64_t                           cap_flags;
+	enum sxe2_dev_type            dev_type;
+	uint32_t    ptype_tbl[SXE2_MAX_PTYPE_NUM];
+	struct rte_ether_addr           mac_addr;
+	uint8_t                              port_idx;
+	uint8_t                              pf_idx;
+	uint32_t                             tx_mode_flags;
+	uint32_t                             rx_mode_flags;
+	uint8_t                              started;
+};
+
+#define SXE2_DEV_PRIVATE_TO_ADAPTER(dev) \
+	((struct sxe2_adapter *)(dev)->data->dev_private)
+
+#endif /* __SXE2_ETHDEV_H__ */
diff --git a/drivers/net/sxe2/sxe2_irq.h b/drivers/net/sxe2/sxe2_irq.h
new file mode 100644
index 0000000000..bb96c6d842
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_irq.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#ifndef __SXE2_IRQ_H__
+#define __SXE2_IRQ_H__
+
+#include <ethdev_driver.h>
+
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
+	int32_t reset_event_fd;
+	int32_t other_event_fd;
+
+	uint16_t max_cnt_hw;
+	uint16_t base_idx_in_func;
+
+	uint16_t rxq_avail_cnt;
+	uint16_t rxq_base_idx_in_pf;
+
+	uint16_t rxq_irq_cnt;
+	uint32_t *rxq_msix_idx;
+	int32_t *rxq_event_fd;
+};
+
+#endif /* __SXE2_IRQ_H__ */
diff --git a/drivers/net/sxe2/sxe2_queue.c b/drivers/net/sxe2/sxe2_queue.c
new file mode 100644
index 0000000000..93f8236381
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_queue.c
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#include "sxe2_ethdev.h"
+#include "sxe2_queue.h"
+#include "sxe2_common_log.h"
+
+void sxe2_sw_queue_ctx_hw_cap_set(struct sxe2_adapter *adapter,
+		struct sxe2_drv_queue_caps *q_caps)
+{
+	adapter->q_ctxt.qp_cnt_assign = q_caps->queues_cnt;
+	adapter->q_ctxt.base_idx_in_pf = q_caps->base_idx_in_pf;
+}
+
+int32_t sxe2_queues_init(struct rte_eth_dev *dev)
+{
+	int32_t ret = 0;
+	uint16_t buf_size;
+	uint16_t frame_size;
+	struct sxe2_rx_queue *rxq;
+	uint16_t nb_rxq;
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
index 0000000000..e587e582fa
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_queue.h
@@ -0,0 +1,191 @@
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
+	uint16_t qp_cnt_assign;
+	uint16_t base_idx_in_pf;
+
+	uint32_t tx_mode_flags;
+	uint32_t rx_mode_flags;
+};
+
+struct sxe2_tx_buffer {
+	struct rte_mbuf *mbuf;
+
+	uint16_t next_id;
+	uint16_t last_id;
+};
+
+struct sxe2_tx_buffer_vec {
+	struct rte_mbuf *mbuf;
+};
+
+struct sxe2_txq_stats {
+	uint64_t tx_restart;
+	uint64_t tx_busy;
+
+	uint64_t tx_linearize;
+	uint64_t tx_tso_linearize_chk;
+	uint64_t tx_vlan_insert;
+	uint64_t tx_tso_packets;
+	uint64_t tx_tso_bytes;
+	uint64_t tx_csum_none;
+	uint64_t tx_csum_partial;
+	uint64_t tx_csum_partial_inner;
+	uint64_t tx_queue_dropped;
+	uint64_t tx_xmit_more;
+	uint64_t tx_pkts_num;
+	uint64_t tx_desc_not_done;
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
+	volatile uint32_t *tdt_reg_addr;
+
+	uint64_t offloads;
+	uint16_t ring_depth;
+	uint16_t desc_free_num;
+
+	uint16_t free_thresh;
+
+	uint16_t rs_thresh;
+	uint16_t next_use;
+	uint16_t next_clean;
+
+	uint16_t desc_used_num;
+	uint16_t next_dd;
+	uint16_t next_rs;
+	uint16_t ipsec_pkt_md_offset;
+
+	uint16_t port_id;
+	uint16_t queue_id;
+	uint16_t idx_in_func;
+	bool tx_deferred_start;
+	uint8_t pthresh;
+	uint8_t hthresh;
+	uint8_t wthresh;
+	uint16_t reg_idx;
+	uint64_t base_addr;
+	struct sxe2_vsi *vsi;
+	const struct rte_memzone *mz;
+	struct sxe2_txq_ops ops;
+	uint8_t  vlan_flag;
+	uint8_t  use_ctx:1,
+		res:7;
+};
+struct sxe2_rx_queue;
+struct sxe2_rxq_ops {
+	void (*queue_reset)(struct sxe2_rx_queue *rxq);
+	void (*mbufs_release)(struct sxe2_rx_queue *txq);
+};
+struct sxe2_rxq_stats {
+	uint64_t rx_pkts_num;
+	uint64_t rx_rss_pkt_num;
+	uint64_t rx_fnav_pkt_num;
+	uint64_t rx_ptp_pkt_num;
+	uint32_t rx_vec_align_drop;
+
+	uint32_t rxdid_1588_err;
+	uint32_t ip_csum_err;
+	uint32_t l4_csum_err;
+	uint32_t outer_ip_csum_err;
+	uint32_t outer_l4_csum_err;
+	uint32_t macsec_err;
+	uint32_t ipsec_err;
+
+	uint64_t ptype_pkts[SXE2_MAX_PTYPE_NUM];
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
+	volatile uint32_t *rdt_reg_addr;
+	struct rte_mempool *mb_pool;
+	struct rte_mbuf **buffer_ring;
+	struct sxe2_vsi *vsi;
+
+	uint64_t offloads;
+	uint16_t ring_depth;
+	uint16_t rx_free_thresh;
+	uint16_t processing_idx;
+	uint16_t hold_num;
+	uint16_t next_ret_pkt;
+	uint16_t batch_alloc_trigger;
+	uint16_t completed_pkts_num;
+	uint64_t update_time;
+	uint32_t desc_ts;
+	uint64_t ts_high;
+	uint32_t ts_low;
+	uint32_t ts_need_update;
+	uint8_t  crc_len;
+	bool fnav_enable;
+
+	struct rte_eth_rxseg_split rx_seg[SXE2_RX_SEG_NUM];
+
+	struct rte_mbuf *completed_buf[SXE2_RX_PKTS_BURST_BATCH_NUM * 2];
+	struct rte_mbuf *pkt_first_seg;
+	struct rte_mbuf *pkt_last_seg;
+	uint64_t mbuf_init_value;
+	uint16_t realloc_num;
+	uint16_t realloc_start;
+	struct rte_mbuf fake_mbuf;
+
+	const struct rte_memzone *mz;
+	struct sxe2_rxq_ops ops;
+	rte_iova_t base_addr;
+	uint16_t reg_idx;
+	uint32_t low_desc_waterline : 16;
+	uint32_t ldw_event_pending : 1;
+	struct sxe2_rxq_sw_stats sw_stats;
+	uint16_t port_id;
+	uint16_t queue_id;
+	uint16_t idx_in_func;
+	uint16_t rx_buf_len;
+	uint16_t rx_hdr_len;
+	uint16_t max_pkt_len;
+	bool rx_deferred_start;
+	uint8_t drop_en;
+};
+
+struct sxe2_adapter;
+
+void sxe2_sw_queue_ctx_hw_cap_set(struct sxe2_adapter *adapter,
+		struct sxe2_drv_queue_caps *q_caps);
+
+int32_t sxe2_queues_init(struct rte_eth_dev *dev);
+
+#endif /* __SXE2_QUEUE_H__ */
diff --git a/drivers/net/sxe2/sxe2_txrx_common.h b/drivers/net/sxe2/sxe2_txrx_common.h
new file mode 100644
index 0000000000..63f56e4964
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_txrx_common.h
@@ -0,0 +1,540 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#ifndef _SXE2_TXRX_COMMON_H_
+#define _SXE2_TXRX_COMMON_H_
+#include <stdbool.h>
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
+#define SXE2_TX_FLAGS_VLAN_TAG_LOC_L2TAG1	RTE_BIT32(0)
+#define SXE2_TX_FLAGS_VLAN_TAG_LOC_L2TAG2	RTE_BIT32(1)
+
+#define SXE2_TX_PKTS_BURST_BATCH_NUM	32
+
+union sxe2_tx_offload_info {
+	uint64_t data;
+	struct {
+		uint64_t l2_len:7;
+		uint64_t l3_len:9;
+		uint64_t l4_len:8;
+		uint64_t tso_segsz:16;
+		uint64_t outer_l2_len:8;
+		uint64_t outer_l3_len:16;
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
+	uint32_t tunneling_params;
+	uint16_t l2tag2;
+	uint16_t ipsec_offset;
+	uint64_t type_cmd_tso_mss;
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
+		(((uint64_t)SXE2_TX_CTXT_DESC_CMD_TSYN) << SXE2_TX_CTXT_DESC_CMD_SHIFT)
+#define SXE2_TX_CTXT_DESC_CMD_IL2TAG2_MASK   \
+		(((uint64_t)SXE2_TX_CTXT_DESC_CMD_IL2TAG2) << SXE2_TX_CTXT_DESC_CMD_SHIFT)
+
+union sxe2_tx_data_desc {
+	struct {
+		uint64_t buf_addr;
+		uint64_t type_cmd_off_bsz_l2t;
+	} read;
+	struct {
+		uint64_t rsvd;
+		uint64_t dd;
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
+		(((uint64_t)SXE2_TX_DATA_DESC_CMD_RS) << SXE2_TX_DATA_DESC_CMD_SHIFT)
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
+		uint64_t pkt_addr;
+		uint64_t hdr_addr;
+	} read;
+	struct {
+		uint8_t rxdid_src;
+		uint8_t mirror;
+		uint16_t l2tag1;
+		uint32_t filter_status;
+
+		uint64_t status_err_ptype_len;
+	} wb;
+};
+
+union sxe2_rx_32b_desc {
+	struct {
+		uint64_t pkt_addr;
+		uint64_t hdr_addr;
+		uint64_t rsvd1;
+		uint64_t rsvd2;
+	} read;
+	struct {
+		uint8_t rxdid_src;
+		uint8_t mirror;
+		uint16_t l2tag1;
+		uint32_t filter_status;
+
+		uint64_t status_err_ptype_len;
+
+		uint32_t status_lrocnt_fdpf_id;
+		uint16_t l2tag2_1st;
+		uint16_t l2tag2_2nd;
+
+		uint8_t acl_pf_id;
+		uint8_t sw_pf_id;
+		uint16_t flow_id;
+
+		uint32_t fd_filter_id;
+
+	} wb;
+	struct {
+		uint8_t rxdid_src_fd_eudpe;
+		uint8_t mirror;
+		uint16_t l2_tag1;
+		uint32_t filter_status;
+
+		uint64_t status_err_ptype_len;
+
+		uint32_t ext_status_ts_low;
+		uint16_t l2tag2_1st;
+		uint16_t l2tag2_2nd;
+
+		uint32_t ts_h;
+		uint32_t fd_filter_id;
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
+#endif /* __SXE2_TXRX_COMMON_H__ */
diff --git a/drivers/net/sxe2/sxe2_txrx_poll.h b/drivers/net/sxe2/sxe2_txrx_poll.h
new file mode 100644
index 0000000000..f45e33f9b7
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
+uint16_t sxe2_tx_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts);
+
+uint16_t sxe2_rx_pkts_scattered(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts);
+
+uint16_t sxe2_rx_pkts_scattered_split(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts);
+
+#endif /* __SXE2_TXRX_POLL_H__ */
diff --git a/drivers/net/sxe2/sxe2_vsi.c b/drivers/net/sxe2/sxe2_vsi.c
new file mode 100644
index 0000000000..baaa20c02e
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_vsi.c
@@ -0,0 +1,214 @@
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
+sxe2_vsi_node_alloc(struct sxe2_adapter *adapter, uint16_t vsi_id, uint16_t vsi_type)
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
+static void sxe2_vsi_queues_num_set(struct sxe2_vsi *vsi, uint16_t num_queues, uint16_t base_idx)
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
+static void sxe2_vsi_irqs_cfg(struct sxe2_vsi *vsi, uint16_t num_irqs, uint16_t base_idx)
+{
+	vsi->irqs.avail_cnt = num_irqs;
+	vsi->irqs.base_idx_in_pf = base_idx;
+}
+
+static struct sxe2_vsi *sxe2_vsi_node_create(struct sxe2_adapter *adapter,
+					     uint16_t vsi_id,
+					     uint16_t vsi_type)
+{
+	struct sxe2_vsi *vsi = NULL;
+	uint16_t num_queues = 0;
+	uint16_t queue_base_idx = 0;
+	uint16_t num_irqs = 0;
+	uint16_t irq_base_idx = 0;
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
+static int32_t sxe2_vsi_destroy(struct sxe2_adapter *adapter, struct sxe2_vsi *vsi)
+{
+	int32_t ret = 0;
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
+			if (ret == -EPERM)
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
+static int32_t sxe2_main_vsi_create(struct sxe2_adapter *adapter)
+{
+	int32_t ret = 0;
+	uint16_t vsi_id = adapter->vsi_ctxt.dpdk_vsi_id;
+	uint16_t vsi_type = adapter->vsi_ctxt.vsi_type;
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
+		ret = -ENOMEM;
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
+	adapter->vsi_ctxt.main_vsi = NULL;
+l_end:
+	return ret;
+}
+
+int32_t sxe2_vsi_init(struct rte_eth_dev *dev)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	int32_t ret = 0;
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
+	int32_t ret;
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
index 0000000000..e712f738f1
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_vsi.h
@@ -0,0 +1,204 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#ifndef __sxe2_VSI_H__
+#define __sxe2_VSI_H__
+#include <rte_os.h>
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
+	uint16_t base_idx_in_nic;
+	uint16_t base_idx_in_func;
+	uint16_t q_cnt;
+	uint16_t depth;
+	uint16_t rx_buf_len;
+	uint16_t max_frame_len;
+	struct sxe2_queue **queues;
+};
+
+struct sxe2_vsi_irqs {
+	uint16_t avail_cnt;
+	uint16_t used_cnt;
+	uint16_t base_idx_in_pf;
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
+	uint64_t ipackets;
+
+	uint64_t opackets;
+
+	uint64_t ibytes;
+
+	uint64_t obytes;
+
+	uint64_t ierrors;
+
+	uint64_t imissed;
+
+	uint64_t rx_out_of_buffer;
+	uint64_t rx_qblock_drop;
+
+	uint64_t tx_frame_good;
+	uint64_t rx_frame_good;
+	uint64_t rx_crc_errors;
+	uint64_t tx_bytes_good;
+	uint64_t rx_bytes_good;
+	uint64_t tx_multicast_good;
+	uint64_t tx_broadcast_good;
+	uint64_t rx_multicast_good;
+	uint64_t rx_broadcast_good;
+	uint64_t rx_len_errors;
+	uint64_t rx_out_of_range_errors;
+	uint64_t rx_oversize_pkts_phy;
+	uint64_t rx_symbol_err;
+	uint64_t rx_pause_frame;
+	uint64_t tx_pause_frame;
+
+	uint64_t rx_discards_phy;
+	uint64_t rx_discards_ips_phy;
+
+	uint64_t tx_dropped_link_down;
+	uint64_t rx_undersize_good;
+	uint64_t rx_runt_error;
+	uint64_t tx_bytes_good_bad;
+	uint64_t tx_frame_good_bad;
+	uint64_t rx_jabbers;
+	uint64_t rx_size_64;
+	uint64_t rx_size_65_127;
+	uint64_t rx_size_128_255;
+	uint64_t rx_size_256_511;
+	uint64_t rx_size_512_1023;
+	uint64_t rx_size_1024_1522;
+	uint64_t rx_size_1523_max;
+	uint64_t rx_pcs_symbol_err_phy;
+	uint64_t rx_corrected_bits_phy;
+	uint64_t rx_err_lane_0_phy;
+	uint64_t rx_err_lane_1_phy;
+	uint64_t rx_err_lane_2_phy;
+	uint64_t rx_err_lane_3_phy;
+
+	uint64_t rx_prio_buf_discard[SXE2_MAX_USER_PRIORITY];
+	uint64_t rx_illegal_bytes;
+	uint64_t rx_oversize_good;
+	uint64_t tx_unicast;
+	uint64_t tx_broadcast;
+	uint64_t tx_multicast;
+	uint64_t tx_vlan_packet_good;
+	uint64_t tx_size_64;
+	uint64_t tx_size_65_127;
+	uint64_t tx_size_128_255;
+	uint64_t tx_size_256_511;
+	uint64_t tx_size_512_1023;
+	uint64_t tx_size_1024_1522;
+	uint64_t tx_size_1523_max;
+	uint64_t tx_underflow_error;
+	uint64_t rx_byte_good_bad;
+	uint64_t rx_frame_good_bad;
+	uint64_t rx_unicast_good;
+	uint64_t rx_vlan_packets;
+
+	uint64_t prio_xoff_rx[SXE2_MAX_USER_PRIORITY];
+	uint64_t prio_xon_rx[SXE2_MAX_USER_PRIORITY];
+	uint64_t prio_xon_tx[SXE2_MAX_USER_PRIORITY];
+	uint64_t prio_xoff_tx[SXE2_MAX_USER_PRIORITY];
+	uint64_t prio_xon_2_xoff[SXE2_MAX_USER_PRIORITY];
+
+	uint64_t rx_vsi_unicast_packets;
+	uint64_t rx_vsi_bytes;
+	uint64_t tx_vsi_unicast_packets;
+	uint64_t tx_vsi_bytes;
+	uint64_t rx_vsi_multicast_packets;
+	uint64_t tx_vsi_multicast_packets;
+	uint64_t rx_vsi_broadcast_packets;
+	uint64_t tx_vsi_broadcast_packets;
+
+	uint64_t rx_sw_unicast_packets;
+	uint64_t rx_sw_broadcast_packets;
+	uint64_t rx_sw_multicast_packets;
+	uint64_t rx_sw_drop_packets;
+	uint64_t rx_sw_drop_bytes;
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
+	uint16_t vsi_id;
+	uint16_t vsi_type;
+	struct sxe2_vsi_irqs irqs;
+	struct sxe2_queue_info txqs;
+	struct sxe2_queue_info rxqs;
+	uint16_t budget;
+	struct sxe2_vsi_stats vsi_stats;
+};
+
+TAILQ_HEAD(sxe2_vsi_list_head, sxe2_vsi);
+
+struct sxe2_vsi_context {
+	uint16_t func_id;
+	uint16_t dpdk_vsi_id;
+	uint16_t kernel_vsi_id;
+	uint16_t vsi_type;
+
+	uint16_t bond_member_kernel_vsi_id[SXE2_MAX_BOND_MEMBER_CNT];
+	uint16_t bond_member_dpdk_vsi_id[SXE2_MAX_BOND_MEMBER_CNT];
+
+	struct sxe2_vsi *main_vsi;
+};
+
+void sxe2_sw_vsi_ctx_hw_cap_set(struct sxe2_adapter *adapter,
+		struct sxe2_drv_vsi_caps *vsi_caps);
+
+int32_t sxe2_vsi_init(struct rte_eth_dev *dev);
+
+void sxe2_vsi_uninit(struct rte_eth_dev *dev);
+
+#endif /* __SXE2_VSI_H__ */
-- 
2.47.3

