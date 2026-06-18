Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 475A5CD98ED
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 08:29:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ABE8040296;
	Thu, 18 Jun 2026 10:28:13 +0200 (CEST)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by mails.dpdk.org (Postfix) with ESMTP id C37EA40661
 for <dev@dpdk.org>; Thu, 18 Jun 2026 10:27:41 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-05 (Coremail) with SMTP id zQCowAAnlunwqzNqY8cLFA--.46372S21;
 Thu, 18 Jun 2026 16:27:35 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v3 19/20] drivers: add parameters parsed using rte_kvargs
Date: Thu, 18 Jun 2026 16:27:22 +0800
Message-ID: <20260618082723.571054-20-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260618082723.571054-1-liujie5@linkdatatechnology.com>
References: <20260614092328.201826-21-liujie5@linkdatatechnology.com>
 <20260618082723.571054-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowAAnlunwqzNqY8cLFA--.46372S21
X-Coremail-Antispam: 1UD129KBjvAXoWfZr48Xw17Cw15Gw1fZFWDurg_yoW5XrW8Co
 WxKrW3Xa4fZw1Ig3ykArn7CFy2vw48Ww15Ja1S9F4DuwsxGw15KF9Fqw13XF1DWFsYqF17
 u3Z2v3s7tr4kGr18n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UjIYCTnIWjp_UUUYE7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
 j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s0DM28Irc
 Ia0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l
 84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r
 4UJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j
 6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7V
 C0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j
 6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0F2
 4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWU
 JVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7V
 AKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j
 6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIx
 AIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbfcTJUUUUU=
 =
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

The parameters are parsed using the standard 'rte_kvargs' library during
the PCI/vdev probing phase. Documentation for these parameters is also
updated.

During memory hotplug events, the SXE2 driver needs to track memory
segment layout changes to maintain internal DMA mappings. However,
existing memseg walk functions (rte_memseg_walk) acquire memory locks
and cannot be called from within memory event callbacks, leading to
potential deadlocks.

This commit introduces sxe2_memseg_walk_cb() as a helper that walks
memory segments using the thread-unsafe variant
rte_memseg_walk_thread_unsafe(), which is safe to call from
memory-related callbacks [citation:1][citation:3][citation:5].

The implementation follows the standard rte_memseg_walk_t prototype,
processing each memseg to update driver-specific data structures.

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/common/sxe2/sxe2_common.c     | 110 +++++++++++
 drivers/common/sxe2/sxe2_common.h     |   2 +
 drivers/common/sxe2/sxe2_ioctl_chnl.c |   2 +-
 drivers/net/sxe2/meson.build          |   3 +-
 drivers/net/sxe2/sxe2_cmd_chnl.c      |  21 ++
 drivers/net/sxe2/sxe2_cmd_chnl.h      |   3 +
 drivers/net/sxe2/sxe2_drv_cmd.h       |  17 ++
 drivers/net/sxe2/sxe2_dump.c          |  15 ++
 drivers/net/sxe2/sxe2_ethdev.c        | 274 ++++++++++++++++++++++++--
 drivers/net/sxe2/sxe2_ethdev.h        |   6 +
 drivers/net/sxe2/sxe2_flow.c          |   9 +-
 drivers/net/sxe2/sxe2_irq.c           |  30 +++
 drivers/net/sxe2/sxe2_rx.c            |  12 ++
 drivers/net/sxe2/sxe2_tm.c            |  18 ++
 drivers/net/sxe2/sxe2_tm.h            |   2 +
 15 files changed, 505 insertions(+), 19 deletions(-)

diff --git a/drivers/common/sxe2/sxe2_common.c b/drivers/common/sxe2/sxe2_common.c
index c000a55cd0..5c5db85f29 100644
--- a/drivers/common/sxe2/sxe2_common.c
+++ b/drivers/common/sxe2/sxe2_common.c
@@ -196,6 +196,102 @@ static int32_t sxe2_parse_representor(const char *key, const char *value, void *
 
 	PMD_LOG_INFO(COM, "representor arg %s: \"%s\".", key, value);
 
+l_end:
+	return ret;
+}
+static int32_t sxe2_dma_mem_map(struct sxe2_common_device *cdev,
+				const void *addr, size_t len, bool do_map)
+{
+	struct rte_memseg_list *msl;
+	struct rte_memseg *ms;
+	size_t cur_len = 0;
+	int32_t ret = 0;
+
+	msl = rte_mem_virt2memseg_list(addr);
+	if (msl == NULL) {
+		ret = -EINVAL;
+		PMD_LOG_ERR(COM, "Invalid virt addr=%p.", addr);
+		goto l_end;
+	}
+
+	if ((uintptr_t)addr != RTE_ALIGN((uintptr_t)addr, msl->page_sz) ||
+		(len != RTE_ALIGN(len, msl->page_sz))) {
+		ret = -EINVAL;
+		PMD_LOG_ERR(COM, "Addr=%p and len=%zu not align page size=%" PRIu64 ".",
+			    addr, len, msl->page_sz);
+		goto l_end;
+	}
+
+	/* memsegs are contiguous in memory */
+	ms = rte_mem_virt2memseg(addr, msl);
+	while (cur_len < len) {
+		/* some memory segments may have invalid IOVA */
+		if (ms->iova == RTE_BAD_IOVA) {
+			PMD_LOG_WARN(COM, "Memory segment at %p has bad IOVA, skipping.",
+					ms->addr);
+			goto next;
+		}
+		if (do_map)
+			sxe2_drv_dev_dma_map(cdev, ms->addr_64,
+					ms->iova, ms->len);
+		else
+			sxe2_drv_dev_dma_unmap(cdev, ms->iova);
+
+next:
+		cur_len += ms->len;
+		++ms;
+	}
+
+l_end:
+	return ret;
+}
+
+RTE_EXPORT_INTERNAL_SYMBOL(sxe2_common_mem_event_cb)
+void
+sxe2_common_mem_event_cb(enum rte_mem_event type,
+		const void *addr, size_t size, void *arg __rte_unused)
+{
+	struct sxe2_common_device *cdev = NULL;
+
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		goto l_end;
+
+	pthread_mutex_lock(&sxe2_common_devices_list_lock);
+	switch (type) {
+	case RTE_MEM_EVENT_FREE:
+		TAILQ_FOREACH(cdev, &sxe2_common_devices_list, next)
+			(void)sxe2_dma_mem_map(cdev, addr, size, 0);
+		break;
+	case RTE_MEM_EVENT_ALLOC:
+		TAILQ_FOREACH(cdev, &sxe2_common_devices_list, next)
+			(void)sxe2_dma_mem_map(cdev, addr, size, 1);
+		break;
+	default:
+		break;
+	}
+	pthread_mutex_unlock(&sxe2_common_devices_list_lock);
+l_end:
+	return;
+}
+
+static int32_t sxe2_memseg_walk_cb(const struct rte_memseg_list *msl,
+				   const struct rte_memseg *ms, void *arg)
+{
+	struct sxe2_common_device *cdev = arg;
+	int32_t ret = 0;
+
+	if (msl->external && !msl->heap)
+		goto l_end;
+
+	if (ms->iova == RTE_BAD_IOVA)
+		goto l_end;
+
+	ret = sxe2_drv_dev_dma_map(cdev, ms->addr_64, ms->iova, ms->len);
+	if (ret != 0) {
+		PMD_LOG_ERR(COM, "Fail to memseg dma map.");
+		goto l_end;
+	}
+
 l_end:
 	return ret;
 }
@@ -220,6 +316,18 @@ static int32_t sxe2_common_device_setup(struct sxe2_common_device *cdev)
 		goto l_close_dev;
 	}
 
+	rte_mcfg_mem_read_lock();
+	ret = rte_memseg_walk_thread_unsafe(sxe2_memseg_walk_cb, cdev);
+	if (ret) {
+		PMD_LOG_ERR(COM, "Fail to walk memseg, ret=%d", ret);
+		rte_mcfg_mem_read_unlock();
+		goto l_close_dev;
+	}
+	rte_mcfg_mem_read_unlock();
+
+	(void)rte_mem_event_callback_register("SXE2_MEM_EVENT_CB",
+			sxe2_common_mem_event_cb, NULL);
+
 	goto l_end;
 
 l_close_dev:
@@ -251,6 +359,7 @@ static struct sxe2_common_device *sxe2_common_device_alloc(
 	}
 	cdev->dev = rte_dev;
 	cdev->class_type = class_type;
+	cdev->config.cmd_fd = SXE2_CMD_FD_INVALID;
 	cdev->config.kernel_reset = false;
 	pthread_mutex_init(&cdev->config.lock, NULL);
 
@@ -631,6 +740,7 @@ static int32_t sxe2_common_pci_id_table_update(const struct rte_pci_id *id_table
 
 	updated_table = calloc(num_ids, sizeof(*updated_table));
 	if (!updated_table) {
+		ret = -ENOMEM;
 		PMD_LOG_ERR(COM, "Failed to allocate memory for PCI ID table");
 		goto l_end;
 	}
diff --git a/drivers/common/sxe2/sxe2_common.h b/drivers/common/sxe2/sxe2_common.h
index b02b6317da..efc8d3585a 100644
--- a/drivers/common/sxe2/sxe2_common.h
+++ b/drivers/common/sxe2/sxe2_common.h
@@ -14,6 +14,8 @@
 
 #define SXE2_COMMON_PCI_DRIVER_NAME "sxe2_pci"
 
+#define SXE2_CMD_FD_INVALID (-1)
+
 #define SXE2_CDEV_TO_CMD_FD(cdev) \
 	((cdev)->config.cmd_fd)
 
diff --git a/drivers/common/sxe2/sxe2_ioctl_chnl.c b/drivers/common/sxe2/sxe2_ioctl_chnl.c
index 173d8d57ae..a233a78136 100644
--- a/drivers/common/sxe2/sxe2_ioctl_chnl.c
+++ b/drivers/common/sxe2/sxe2_ioctl_chnl.c
@@ -110,7 +110,7 @@ sxe2_drv_dev_close(struct sxe2_common_device *cdev)
 	if (fd >= 0)
 		close(fd);
 	PMD_LOG_INFO(COM, "closed device fd=%d", fd);
-	SXE2_CDEV_TO_CMD_FD(cdev) = -1;
+	SXE2_CDEV_TO_CMD_FD(cdev) = SXE2_CMD_FD_INVALID;
 }
 
 RTE_EXPORT_INTERNAL_SYMBOL(sxe2_drv_dev_handshake)
diff --git a/drivers/net/sxe2/meson.build b/drivers/net/sxe2/meson.build
index 4fb2333926..0d17a6c2c7 100644
--- a/drivers/net/sxe2/meson.build
+++ b/drivers/net/sxe2/meson.build
@@ -9,7 +9,7 @@ endif
 
 cflags += ['-g']
 
-deps += ['common_sxe2', 'hash','cryptodev','security']
+deps += ['common_sxe2', 'hash', 'cryptodev', 'security']
 
 includes += include_directories('../../common/sxe2')
 
@@ -79,5 +79,4 @@ sources += files(
         'sxe2_flow_parse_engine.c',
         'sxe2_dump.c',
         'sxe2_txrx_check_mbuf.c',
-
 )
diff --git a/drivers/net/sxe2/sxe2_cmd_chnl.c b/drivers/net/sxe2/sxe2_cmd_chnl.c
index 43e8c59487..b09989fe50 100644
--- a/drivers/net/sxe2/sxe2_cmd_chnl.c
+++ b/drivers/net/sxe2/sxe2_cmd_chnl.c
@@ -99,6 +99,27 @@ int32_t sxe2_drv_dev_info_get(struct sxe2_adapter *adapter,
 	return ret;
 }
 
+int32_t sxe2_drv_fc_state_get(struct sxe2_adapter *adapter,
+			      struct sxe2_drv_vsi_fc_get_resp *dev_fc_state_resp)
+{
+	int32_t ret = 0;
+	struct sxe2_common_device *cdev = adapter->cdev;
+	struct sxe2_drv_cmd_params param = {0};
+	struct sxe2_drv_vsi_fc_get_req req = {0};
+
+	req.vsi_id = adapter->vsi_ctxt.main_vsi->vsi_id;
+	sxe2_drv_cmd_params_fill(adapter, &param, SXE2_DRV_CMD_VSI_FC_GET,
+				&req, sizeof(req),
+				dev_fc_state_resp,
+				sizeof(*dev_fc_state_resp));
+	ret = sxe2_drv_cmd_exec(cdev, &param);
+	if (ret) {
+		PMD_DEV_LOG_ERR(adapter, DRV, "get fc state failed, ret=%d", ret);
+		ret = -EIO;
+	}
+	return ret;
+}
+
 int32_t sxe2_drv_dev_fw_info_get(struct sxe2_adapter *adapter,
 				struct sxe2_drv_dev_fw_info_resp *dev_fw_info_resp)
 {
diff --git a/drivers/net/sxe2/sxe2_cmd_chnl.h b/drivers/net/sxe2/sxe2_cmd_chnl.h
index 988d4b458b..d63caad526 100644
--- a/drivers/net/sxe2/sxe2_cmd_chnl.h
+++ b/drivers/net/sxe2/sxe2_cmd_chnl.h
@@ -99,6 +99,9 @@ int32_t sxe2_drv_vsi_stats_reset(struct sxe2_adapter *adapter);
 int32_t sxe2_drv_queue_info_get_update(struct sxe2_adapter *adapter,
 				       struct eth_queue_stats *qstats);
 
+int32_t sxe2_drv_fc_state_get(struct sxe2_adapter *adapter,
+			      struct sxe2_drv_vsi_fc_get_resp *dev_fc_state_resp);
+
 int32_t sxe2_drv_rxq_mapping_set(struct rte_eth_dev *eth_dev, uint16_t queue_id, uint8_t pool_idx);
 
 int32_t sxe2_drv_txq_mapping_set(struct rte_eth_dev *eth_dev, uint16_t queue_id, uint8_t pool_idx);
diff --git a/drivers/net/sxe2/sxe2_drv_cmd.h b/drivers/net/sxe2/sxe2_drv_cmd.h
index 3fabf351af..03ef3b315d 100644
--- a/drivers/net/sxe2/sxe2_drv_cmd.h
+++ b/drivers/net/sxe2/sxe2_drv_cmd.h
@@ -651,6 +651,23 @@ struct __rte_aligned(4) __rte_packed_begin sxe2_drv_sfp_resp {
 	uint8_t data[];
 } __rte_packed_end;
 
+enum sxe2_fc_type {
+	SXE2_FC_T_DIS = 0,
+	SXE2_FC_T_LFC,
+	SXE2_FC_T_PFC,
+	SXE2_FC_T_UNKNOWN = 255,
+};
+
+struct __rte_aligned(4) __rte_packed_begin sxe2_drv_vsi_fc_get_req {
+	uint16_t vsi_id;
+	uint8_t rsv[2];
+} __rte_packed_end;
+
+struct __rte_aligned(4) __rte_packed_begin sxe2_drv_vsi_fc_get_resp {
+	uint8_t fc_enable;
+	uint8_t rsv[3];
+} __rte_packed_end;
+
 enum sxe2_drv_cmd_module {
 	SXE2_DRV_CMD_MODULE_HANDSHAKE = 0,
 	SXE2_DRV_CMD_MODULE_DEV = 1,
diff --git a/drivers/net/sxe2/sxe2_dump.c b/drivers/net/sxe2/sxe2_dump.c
index d43473e083..c7cdde5f4f 100644
--- a/drivers/net/sxe2/sxe2_dump.c
+++ b/drivers/net/sxe2/sxe2_dump.c
@@ -186,6 +186,20 @@ static void sxe2_dump_filter_info(FILE *file, struct rte_eth_dev *dev)
 	return;
 }
 
+static void sxe2_dump_fc_state(FILE *file, struct rte_eth_dev *dev)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+
+	if (!(adapter->cap_flags & SXE2_DEV_CAPS_OFFLOAD_FC_STATE))
+		goto l_end;
+
+	fprintf(file, " -- fc state:\n"
+		"\t  -- curr_state: %u\n",
+		adapter->fc_state_ctx.curr_state);
+l_end:
+	return;
+}
+
 static const char *sxe2_vsi_id_str(uint16_t vsi_id, char *buf, size_t len)
 {
 	if (vsi_id == SXE2_INVALID_VSI_ID)
@@ -272,6 +286,7 @@ int32_t sxe2_eth_dev_priv_dump(struct rte_eth_dev *dev, FILE *file)
 	sxe2_dump_dev_args_info(str, dev);
 	sxe2_dump_filter_info(str, dev);
 	sxe2_dump_switchdev_info(str, dev);
+	sxe2_dump_fc_state(str, dev);
 
 	(void)fflush(str);
 
diff --git a/drivers/net/sxe2/sxe2_ethdev.c b/drivers/net/sxe2/sxe2_ethdev.c
index 6b60b6d75f..2620f2ef4d 100644
--- a/drivers/net/sxe2/sxe2_ethdev.c
+++ b/drivers/net/sxe2/sxe2_ethdev.c
@@ -69,6 +69,16 @@ static const struct rte_pci_id pci_id_sxe2_tbl[] = {
 	{ RTE_PCI_DEVICE(SXE2_PCI_VENDOR_ID_206F, SXE2_PCI_DEVICE_ID_VF_1)},
 	{ .vendor_id = 0, },
 };
+#define SXE2_TXSCH_NODE_ADJ_LVL_MAX  3
+#define SXE2_DEVARG_FLOW_DULP_PATTERN_MODE "flow-duplicate-pattern"
+#define SXE2_DEVARG_FUNC_FLOW_DIRCT "function-flow-direct"
+#define SXE2_DEVARG_FNAV_STAT_TYPE "fnav-stat-type"
+#define SXE2_DEVARG_SW_STATS "drv-sw-stats"
+#define SXE2_DEVARG_NO_SCHED_MODE "no-sched-mode"
+#define SXE2_DEVARG_SCHED_LAYER_MODE "sched-layer-mode"
+#define SXE2_DEVARG_RX_LOW_LATENCY "rx-low-latency"
+
+#define SXE2_FLOW_DUP_PATTERN_DEFAULT  1
 
 static struct sxe2_pci_map_addr_info sxe2_net_map_addr_info_pf[SXE2_PCI_MAP_RES_MAX_COUNT] = {
 	[SXE2_PCI_MAP_RES_INVALID] = {.addr_base = 0,
@@ -965,6 +975,149 @@ sxe2_buffer_split_supported_hdr_ptypes_get(struct rte_eth_dev *dev __rte_unused,
 	return ptypes;
 }
 
+static int32_t sxe2_parse_fnav_stat_type(const char *key, const char *value, void *args)
+{
+	int32_t ret = -EINVAL;
+	uint8_t *num = (uint8_t *)args;
+	unsigned long fnav_stat_type;
+	char *endptr = NULL;
+
+	if (value == NULL || args == NULL) {
+		ret = 0;
+		goto l_end;
+	}
+	errno = 0;
+	fnav_stat_type = strtoul(value, &endptr, 10);
+	if (errno != 0 || endptr == value || *endptr != '\0') {
+		PMD_LOG_WARN(INIT, "%s: \"%s\" is not a valid int value.",
+			key, value);
+		goto l_end;
+	}
+	if (fnav_stat_type > SXE2_FNAV_STAT_ENA_ALL ||
+		fnav_stat_type == SXE2_FNAV_STAT_ENA_NONE) {
+		PMD_LOG_ERR(INIT, "%s: \"%s\" out of range [1-3].",
+			key, value);
+		goto l_end;
+	}
+	*num = (uint8_t)fnav_stat_type;
+	ret = 0;
+l_end:
+	return ret;
+}
+static int32_t sxe2_parse_sched_layer_mode(const char *key, const char *value, void *args)
+{
+	int32_t ret = -EINVAL;
+	uint8_t *num = (uint8_t *)args;
+	unsigned long sched_layer_mode;
+	char *endptr = NULL;
+
+	if (value == NULL || args == NULL) {
+		ret = 0;
+		goto l_end;
+	}
+	errno = 0;
+	sched_layer_mode = strtoul(value, &endptr, 10);
+	if (errno != 0 || endptr == value || *endptr != '\0') {
+		PMD_LOG_WARN(INIT, "%s: \"%s\" is not a valid int value.",
+			key, value);
+		goto l_end;
+	}
+	if (sched_layer_mode > SXE2_TXSCH_NODE_ADJ_LVL_MAX) {
+		PMD_LOG_ERR(INIT, "%s: \"%s\" > 3.",
+			key, value);
+		goto l_end;
+	}
+	*num = (uint8_t)sched_layer_mode;
+	ret = 0;
+l_end:
+	return ret;
+}
+static int32_t sxe2_parse_no_sched_mode(const char *key, const char *value, void *args)
+{
+	int32_t ret = -EINVAL;
+	uint8_t *num = (uint8_t *)args;
+	unsigned long high_performance_mode;
+	char *endptr = NULL;
+
+	if (value == NULL || args == NULL) {
+		ret = 0;
+		goto l_end;
+	}
+	errno = 0;
+	high_performance_mode = strtoul(value, &endptr, 10);
+	if (errno != 0 || endptr == value || *endptr != '\0') {
+		PMD_LOG_WARN(INIT, "%s: \"%s\" is not a valid int value.",
+			key, value);
+		goto l_end;
+	}
+	if (high_performance_mode != 1) {
+		PMD_LOG_ERR(INIT, "%s: \"%s\" != 1.",
+			key, value);
+		goto l_end;
+	}
+	*num = (uint8_t)high_performance_mode;
+	ret = 0;
+l_end:
+	return ret;
+}
+static int32_t sxe2_parse_u8(const char *key, const char *value, void *args)
+{
+	uint8_t *num = (uint8_t *)args;
+	char *end;
+	unsigned long val;
+	int32_t ret = -EINVAL;
+
+	if (value == NULL || args == NULL) {
+		ret = 0;
+		goto l_end;
+	}
+	errno = 0;
+	val = strtoul(value, &end, 10);
+	if (errno != 0 || end == value || *end != '\0') {
+		PMD_LOG_ERR(INIT, "Invalid 8-bit integer value for key %s: %s", key, value);
+		return -EINVAL;
+	}
+
+	if (val > UINT8_MAX) {
+		PMD_LOG_ERR(INIT, "%s: \"%s\" out of range [0-255].",
+			key, value);
+		return -ERANGE;
+	}
+
+	*num = (uint8_t)val;
+	ret = 0;
+l_end:
+	return ret;
+}
+static int32_t sxe2_parse_bool(const char *key, const char *value, void *args)
+{
+	int32_t ret = -EINVAL;
+	uint8_t *num = (uint8_t *)args;
+	unsigned long bool_val;
+	char *endptr = NULL;
+
+	if (value == NULL || args == NULL) {
+		ret = 0;
+		goto l_end;
+	}
+	errno = 0;
+	bool_val = strtoul(value, &endptr, 10);
+	if (errno != 0 || endptr == value || *endptr != '\0') {
+		PMD_LOG_WARN(INIT, "%s: \"%s\" is not a valid int value.",
+			key, value);
+		goto l_end;
+	}
+	if (bool_val != 0 && bool_val != 1) {
+		PMD_LOG_ERR(INIT, "%s: \"%s\" out of range [0|1].",
+			key, value);
+		goto l_end;
+	}
+	*num = (uint8_t)bool_val;
+	ret = 0;
+l_end:
+	return ret;
+}
+
 struct sxe2_pci_map_bar_info *sxe2_dev_get_bar_info(struct sxe2_adapter *adapter,
 						    enum sxe2_pci_map_resource res_type)
 {
@@ -1032,6 +1185,65 @@ void *sxe2_pci_map_addr_get(struct sxe2_adapter *adapter,
 	return addr;
 }
 
+static int32_t sxe2_args_parse(struct rte_eth_dev *dev, struct sxe2_dev_kvargs_info *kvargs)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	int32_t ret = 0;
+	PMD_INIT_FUNC_TRACE();
+
+	adapter->devargs.flow_dup_pattern_mode = SXE2_FLOW_DUP_PATTERN_DEFAULT;
+
+	if (kvargs == NULL)
+		goto l_end;
+	ret = sxe2_kvargs_process(kvargs, SXE2_DEVARG_FNAV_STAT_TYPE,
+				 &sxe2_parse_fnav_stat_type,
+				 &adapter->devargs.fnav_stat_type);
+	if (ret) {
+		PMD_DEV_LOG_ERR(adapter, INIT, "Failed to parse fnav stat type, ret:%d", ret);
+		goto l_end;
+	}
+
+	ret = sxe2_kvargs_process(kvargs, SXE2_DEVARG_NO_SCHED_MODE,
+				 &sxe2_parse_no_sched_mode,
+				 &adapter->devargs.no_sched_mode);
+	if (ret) {
+		PMD_DEV_LOG_ERR(adapter, INIT, "Failed to parse no sched mode, ret:%d", ret);
+		goto l_end;
+	}
+	ret = sxe2_kvargs_process(kvargs, SXE2_DEVARG_SCHED_LAYER_MODE,
+				 &sxe2_parse_sched_layer_mode,
+				 &adapter->devargs.sched_layer_mode);
+	if (ret) {
+		PMD_DEV_LOG_ERR(adapter, INIT, "Failed to parse sched layer mode, ret:%d", ret);
+		goto l_end;
+	}
+	ret = sxe2_kvargs_process(kvargs, SXE2_DEVARG_FLOW_DULP_PATTERN_MODE,
+				 &sxe2_parse_u8,
+				 &adapter->devargs.flow_dup_pattern_mode);
+	if (ret) {
+		PMD_DEV_LOG_ERR(adapter, INIT, "Failed to parse switch dulpliate flow pattern mode,"
+				"ret:%d", ret);
+		goto l_end;
+	}
+	ret = sxe2_kvargs_process(kvargs, SXE2_DEVARG_FUNC_FLOW_DIRCT,
+				 &sxe2_parse_bool,
+				 &adapter->devargs.func_flow_direct_en);
+	if (ret) {
+		PMD_DEV_LOG_ERR(adapter, INIT, "Failed to parse function flow rule enable,"
+				"ret:%d", ret);
+		goto l_end;
+	}
+	ret = sxe2_kvargs_process(kvargs, SXE2_DEVARG_RX_LOW_LATENCY,
+				 &sxe2_parse_bool,
+				 &adapter->devargs.rx_low_latency);
+	if (ret) {
+		PMD_DEV_LOG_ERR(adapter, INIT, "Failed to parse rx low latency, ret:%d", ret);
+		goto l_end;
+	}
+l_end:
+	return ret;
+}
+
 static int32_t sxe2_eth_init(struct rte_eth_dev *dev)
 {
 	int32_t ret = 0;
@@ -1584,6 +1796,37 @@ void sxe2_dev_pci_map_uinit(struct rte_eth_dev *dev)
 	adapter->dev_info.dev_data = NULL;
 }
 
+static int32_t sxe2_fc_state_init(struct rte_eth_dev *dev)
+{
+	struct sxe2_adapter *adapter =
+		SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct sxe2_drv_vsi_fc_get_resp fc_resp = {0};
+	int32_t ret;
+
+	if (!(adapter->cap_flags & SXE2_DEV_CAPS_OFFLOAD_FC_STATE)) {
+		adapter->fc_state_ctx.cfg_state = 0;
+		adapter->fc_state_ctx.curr_state = 0;
+		ret = 0;
+		goto l_end;
+	}
+	ret = sxe2_drv_fc_state_get(adapter, &fc_resp);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "Failed to get fc state, ret=[%d]", ret);
+		goto l_end;
+	}
+	adapter->fc_state_ctx.cfg_state = fc_resp.fc_enable;
+	adapter->fc_state_ctx.curr_state = 0;
+l_end:
+	return ret;
+}
+static void sxe2_fc_state_uinit(struct rte_eth_dev *dev)
+{
+	struct sxe2_adapter *adapter =
+		SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	adapter->fc_state_ctx.cfg_state = 0;
+	adapter->fc_state_ctx.curr_state = 0;
+}
+
 uint32_t sxe2_sched_mode_get(struct sxe2_adapter *adapter)
 {
 	uint32_t ret_mode = SXE2_SCHED_MODE_INVALID;
@@ -1646,18 +1889,6 @@ static int32_t sxe2_sched_uinit(struct rte_eth_dev *dev)
 	return ret;
 }
 
-static int32_t sxe2_args_parse(struct rte_eth_dev *dev,
-			       __rte_unused struct sxe2_dev_kvargs_info *kvargs)
-{
-	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
-	int32_t ret = 0;
-	PMD_INIT_FUNC_TRACE();
-
-	adapter->devargs.flow_dup_pattern_mode = SXE2_FLOW_DUP_PATTERN_DEFAULT;
-
-	return ret;
-}
-
 static int32_t sxe2_dev_init(struct rte_eth_dev *dev,
 			     struct sxe2_dev_kvargs_info *kvargs)
 {
@@ -1682,7 +1913,7 @@ static int32_t sxe2_dev_init(struct rte_eth_dev *dev,
 
 	ret = sxe2_args_parse(dev, kvargs);
 	if (ret) {
-		PMD_LOG_ERR(INIT, "Failed to parse args, ret=[%d]", ret);
+		PMD_LOG_ERR(INIT, "Failed to parse devargs, ret=%d", ret);
 		goto l_end;
 	}
 
@@ -1752,6 +1983,12 @@ static int32_t sxe2_dev_init(struct rte_eth_dev *dev,
 		goto init_flow_err;
 	}
 
+	ret = sxe2_fc_state_init(dev);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "Failed to init fc state, ret=%d", ret);
+		goto init_fc_state_err;
+	}
+
 	ret = sxe2_sched_init(dev);
 	if (ret) {
 		PMD_LOG_ERR(INIT, "Failed to init sched, ret=%d", ret);
@@ -1775,6 +2012,8 @@ static int32_t sxe2_dev_init(struct rte_eth_dev *dev,
 init_xstats_err:
 	(void)sxe2_sched_uinit(dev);
 init_sched_err:
+	sxe2_fc_state_uinit(dev);
+init_fc_state_err:
 	(void)sxe2_flow_uninit(dev);
 init_flow_err:
 init_rss_err:
@@ -1820,6 +2059,7 @@ static int32_t sxe2_dev_close(struct rte_eth_dev *dev)
 	sxe2_eth_uinit(dev);
 	sxe2_dev_pci_map_uinit(dev);
 	sxe2_free_repr_info(dev);
+	sxe2_fc_state_uinit(dev);
 
 l_end:
 	return 0;
@@ -2125,6 +2365,14 @@ RTE_INIT(rte_sxe2_pmd_init)
 RTE_PMD_EXPORT_NAME(net_sxe2);
 RTE_PMD_REGISTER_PCI_TABLE(net_sxe2, pci_id_sxe2_tbl);
 RTE_PMD_REGISTER_KMOD_DEP(net_sxe2, "* sxe2");
+RTE_PMD_REGISTER_PARAM_STRING(net_sxe2,
+	"flow-duplicate-pattern=<0|1> "
+	"function-flow-direct=<0|1> "
+	"fnav-stat-type=<1|2|3> "
+	"drv-sw-stats=<0|1> "
+	"no-sched-mode=<0|1> "
+	"sched-layer-mode=<0-3> "
+	"rx-low-latency=<0|1>");
 
 RTE_LOG_REGISTER_SUFFIX(sxe2_log_init, init, NOTICE);
 RTE_LOG_REGISTER_SUFFIX(sxe2_log_driver, driver, NOTICE);
diff --git a/drivers/net/sxe2/sxe2_ethdev.h b/drivers/net/sxe2/sxe2_ethdev.h
index 3cd3dc9ced..87326dcdd5 100644
--- a/drivers/net/sxe2/sxe2_ethdev.h
+++ b/drivers/net/sxe2/sxe2_ethdev.h
@@ -310,6 +310,11 @@ struct sxe2_filter_context {
 	bool cur_l2_config;
 };
 
+struct sxe2_fc_state_ctxt {
+	uint8_t curr_state;
+	uint8_t cfg_state;
+};
+
 struct sxe2_adapter {
 	struct sxe2_common_device      *cdev;
 	struct sxe2_dev_info            dev_info;
@@ -331,6 +336,7 @@ struct sxe2_adapter {
 	struct sxe2_security_ctx      security_ctx;
 	struct sxe2_repr_context      repr_ctxt;
 	struct sxe2_switchdev_info    switchdev_info;
+	struct sxe2_fc_state_ctxt     fc_state_ctx;
 	bool                          rule_started;
 	bool                          flow_isolated;
 	bool                          flow_isolate_cfg;
diff --git a/drivers/net/sxe2/sxe2_flow.c b/drivers/net/sxe2/sxe2_flow.c
index 63cfc36968..1aa5813ee4 100644
--- a/drivers/net/sxe2/sxe2_flow.c
+++ b/drivers/net/sxe2/sxe2_flow.c
@@ -762,6 +762,7 @@ static int32_t sxe2_flow_validate_with_flow(struct rte_eth_dev *dev,
 					const struct rte_flow_action actions[],
 					struct rte_flow_error *error)
 {
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
 	int32_t ret = 0;
 	struct sxe2_flow *flow = NULL;
 
@@ -804,9 +805,11 @@ static int32_t sxe2_flow_validate_with_flow(struct rte_eth_dev *dev,
 
 	ret = sxe2_flow_check_flow_list_duplicate(dev, flow_list);
 	if (ret != 0) {
-		rte_flow_error_set(error, EEXIST, RTE_FLOW_ERROR_TYPE_ITEM,
-				NULL, "Duplicate flow.");
-		PMD_LOG_ERR(DRV, "Duplicate flow.");
+		rte_flow_error_set(error, EEXIST, RTE_FLOW_ERROR_TYPE_ITEM, NULL,
+				   adapter->devargs.flow_dup_pattern_mode ?
+				   "Duplicate flow pattern." :
+				   "Duplicate flow pattern is not allowed.");
+		PMD_LOG_ERR(DRV, "Duplicate flow pattern.");
 		goto l_end;
 	}
 l_end:
diff --git a/drivers/net/sxe2/sxe2_irq.c b/drivers/net/sxe2/sxe2_irq.c
index d8e0b19463..3306504761 100644
--- a/drivers/net/sxe2/sxe2_irq.c
+++ b/drivers/net/sxe2/sxe2_irq.c
@@ -10,6 +10,7 @@
 #include <rte_alarm.h>
 #include <fcntl.h>
 #include <rte_stdatomic.h>
+#include <rte_common.h>
 
 #include "sxe2_ethdev.h"
 #include "sxe2_irq.h"
@@ -47,6 +48,31 @@ static struct sxe2_event_handler event_handler = {
 
 static RTE_ATOMIC(uint32_t)event_thread_run;
 
+static int32_t sxe2_fc_state_callback(struct rte_eth_dev *dev)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct sxe2_drv_vsi_fc_get_resp fc_resp = {0};
+	int32_t ret;
+
+	if (!(adapter->cap_flags & SXE2_DEV_CAPS_OFFLOAD_FC_STATE)) {
+		ret = 0;
+		goto l_end;
+	}
+	ret = sxe2_drv_fc_state_get(adapter, &fc_resp);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "Failed to get fc state, ret=[%d]", ret);
+		goto l_end;
+	}
+	adapter->fc_state_ctx.cfg_state = fc_resp.fc_enable;
+	if (dev->data->dev_started) {
+		PMD_LOG_NOTICE(DRV, "Interrupt event: FC status changed."
+			       "cfg_state:%u curr_state:%u",
+				adapter->fc_state_ctx.cfg_state,
+				adapter->fc_state_ctx.curr_state);
+	}
+l_end:
+	return ret;
+}
 
 static void sxe2_event_irq_common_handler(struct sxe2_adapter *adapter, uint64_t oicr)
 {
@@ -68,6 +94,10 @@ static void sxe2_event_irq_common_handler(struct sxe2_adapter *adapter, uint64_t
 		PMD_DEV_LOG_INFO(adapter, DRV, "event notify legacy");
 		(void)sxe2_switchdev_notify_callback(adapter, false);
 	}
+	if (oicr & RTE_BIT32(SXE2_COM_FC_ST_CHANGE)) {
+		PMD_DEV_LOG_INFO(adapter, DRV, "fc event notify legacy");
+		(void)sxe2_fc_state_callback(dev);
+	}
 }
 
 static uint32_t sxe2_event_intr_handle(void *param __rte_unused)
diff --git a/drivers/net/sxe2/sxe2_rx.c b/drivers/net/sxe2/sxe2_rx.c
index 820d4f0620..d700c60083 100644
--- a/drivers/net/sxe2/sxe2_rx.c
+++ b/drivers/net/sxe2/sxe2_rx.c
@@ -467,12 +467,24 @@ int32_t __rte_cold sxe2_rx_queue_start(struct rte_eth_dev *dev, uint16_t rx_queu
 int32_t __rte_cold sxe2_rxqs_all_start(struct rte_eth_dev *dev)
 {
 	struct rte_eth_dev_data *data = dev->data;
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct sxe2_drv_vsi_fc_get_resp fc_resp = {0};
 	struct sxe2_rx_queue *rxq;
 	uint16_t nb_rxq;
 	uint16_t nb_started_rxq;
 	int32_t ret;
 	PMD_INIT_FUNC_TRACE();
 
+	if (adapter->cap_flags & SXE2_DEV_CAPS_OFFLOAD_FC_STATE) {
+		ret = sxe2_drv_fc_state_get(adapter, &fc_resp);
+		if (ret) {
+			PMD_LOG_ERR(RX, "Failed to get fc state, ret=[%d]", ret);
+			goto l_end;
+		}
+		adapter->fc_state_ctx.cfg_state = fc_resp.fc_enable;
+		adapter->fc_state_ctx.curr_state = adapter->fc_state_ctx.cfg_state;
+	}
+
 	for (nb_rxq = 0; nb_rxq < data->nb_rx_queues; nb_rxq++) {
 		rxq = dev->data->rx_queues[nb_rxq];
 		if (!rxq || rxq->rx_deferred_start)
diff --git a/drivers/net/sxe2/sxe2_tm.c b/drivers/net/sxe2/sxe2_tm.c
index 4c4f793cd5..5de9b5d3b7 100644
--- a/drivers/net/sxe2/sxe2_tm.c
+++ b/drivers/net/sxe2/sxe2_tm.c
@@ -982,6 +982,24 @@ int32_t sxe2_tm_init(struct rte_eth_dev *dev)
 	return ret;
 }
 
+int32_t sxe2_tm_conf_reset(struct rte_eth_dev *dev)
+{
+	int32_t ret;
+
+	ret = sxe2_tm_uninit(dev);
+	if (ret)
+		goto l_end;
+
+	ret = sxe2_tm_init(dev);
+	if (ret)
+		goto l_end;
+
+	PMD_LOG_DEBUG(DRV, "Tm config reset succeed.");
+
+l_end:
+	return ret;
+}
+
 static int32_t sxe2_tm_chk_all_leaf(struct rte_eth_dev *dev)
 {
 	int32_t ret = 0;
diff --git a/drivers/net/sxe2/sxe2_tm.h b/drivers/net/sxe2/sxe2_tm.h
index c4f8da6a8e..b0bfc2091d 100644
--- a/drivers/net/sxe2/sxe2_tm.h
+++ b/drivers/net/sxe2/sxe2_tm.h
@@ -73,4 +73,6 @@ int32_t sxe2_tm_init(struct rte_eth_dev *dev);
 
 int32_t sxe2_tm_uninit(struct rte_eth_dev *dev);
 
+int32_t sxe2_tm_conf_reset(struct rte_eth_dev *dev);
+
 #endif /* __SXE2_TM_H__ */
-- 
2.31.1

