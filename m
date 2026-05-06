Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E88FCD342C
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 May 2026 06:14:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 92FFA40685;
	Wed,  6 May 2026 08:13:30 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 7B2B64026D
 for <dev@dpdk.org>; Wed,  6 May 2026 08:13:24 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowADn7sX_2_ppDUE1EA--.16873S8;
 Wed, 06 May 2026 14:13:21 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v8 06/10] drivers: support PCI BAR mapping
Date: Wed,  6 May 2026 14:12:55 +0800
Message-ID: <20260506061301.817613-7-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260506061301.817613-1-liujie5@linkdatatechnology.com>
References: <20260506033123.726997-10-liujie5@linkdatatechnology.com>
 <20260506061301.817613-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowADn7sX_2_ppDUE1EA--.16873S8
X-Coremail-Antispam: 1UD129KBjvAXoW3Kw4kurWfGr48Kr48Kw15Jwb_yoW8Gw13Jo
 WxW3y3Xw1fW34293y8Jr1kAFy7Zw40g398Janavryq9wsxK3WYyF9rtr13Xan8WF48KFyq
 9w1Iv397WrW3JF47n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UjIYCTnIWjp_UUUYN7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
 j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s0DM28Irc
 Ia0xkI8VCY1x0267AKxVW8JVW5JwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l
 84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F
 4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWx
 Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2I
 x0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8
 JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lw4CEc2x0rVAKj4xxMx
 AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_
 Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwI
 xGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWx
 JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcV
 C2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUUNeOJUUUUU==
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

Implement PCI BAR (Base Address Register) mapping and unmapping
logic to enable MMIO (Memory Mapped I/O) access to hardware
registers.

The driver retrieves the BAR0 virtual address from the PCI resource
during the probing phase. This mapping is used for subsequent
register-level operations. Proper cleanup is implemented in the
device close path.

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/common/sxe2/sxe2_ioctl_chnl.c |  34 +++
 drivers/net/sxe2/sxe2_ethdev.c        | 307 ++++++++++++++++++++++++++
 drivers/net/sxe2/sxe2_ethdev.h        |  18 ++
 3 files changed, 359 insertions(+)

diff --git a/drivers/common/sxe2/sxe2_ioctl_chnl.c b/drivers/common/sxe2/sxe2_ioctl_chnl.c
index e22731065d..2bd7c2b2eb 100644
--- a/drivers/common/sxe2/sxe2_ioctl_chnl.c
+++ b/drivers/common/sxe2/sxe2_ioctl_chnl.c
@@ -160,6 +160,40 @@ sxe2_drv_dev_handshark(struct sxe2_common_device *cdev)
 	return ret;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(sxe2_drv_dev_mmap)
+void
+*sxe2_drv_dev_mmap(struct sxe2_common_device *cdev, u8 bar_idx, u64 len, u64 offset)
+{
+	s32 cmd_fd = 0;
+	void *virt = NULL;
+
+	if (cdev->config.kernel_reset) {
+		PMD_LOG_WARN(COM, "kernel reseted, need restart app.");
+		goto l_err;
+	}
+
+	cmd_fd = SXE2_CDEV_TO_CMD_FD(cdev);
+	if (cmd_fd < 0) {
+		PMD_LOG_ERR(COM, "Failed to exec cmd, fd=%d", cmd_fd);
+		goto l_err;
+	}
+
+	PMD_LOG_DEBUG(COM, "fd=%d, bar idx=%d, len=0x%zx, src=0x%"PRIx64", offset=0x%"PRIx64"",
+		bar_idx, cmd_fd, len, offset, SXE2_COM_PCI_OFFSET_GEN(bar_idx, offset));
+
+	virt = mmap(NULL, len, PROT_READ | PROT_WRITE,
+		MAP_SHARED, cmd_fd, SXE2_COM_PCI_OFFSET_GEN(bar_idx, offset));
+	if (virt == MAP_FAILED) {
+		PMD_LOG_ERR(COM, "Failed mmap, cmd_fd=%d, len=0x%zx, offset=0x%"PRIx64", err:%s",
+			cmd_fd, len, offset, strerror(errno));
+		goto l_err;
+	}
+
+	return virt;
+l_err:
+	return NULL;
+}
+
 RTE_EXPORT_INTERNAL_SYMBOL(sxe2_drv_dev_munmap)
 s32
 sxe2_drv_dev_munmap(struct sxe2_common_device *cdev, void *virt, u64 len)
diff --git a/drivers/net/sxe2/sxe2_ethdev.c b/drivers/net/sxe2/sxe2_ethdev.c
index f2de249279..fa6304ebbc 100644
--- a/drivers/net/sxe2/sxe2_ethdev.c
+++ b/drivers/net/sxe2/sxe2_ethdev.c
@@ -54,6 +54,21 @@ static const struct rte_pci_id pci_id_sxe2_tbl[] = {
 	{ .vendor_id = 0, },
 };
 
+static struct sxe2_pci_map_addr_info sxe2_net_map_addr_info_pf[SXE2_PCI_MAP_RES_MAX_COUNT] = {
+	/* SXE2_PCI_MAP_RES_INVALID */
+	{0, 0, 0},
+	/* SXE2_PCI_MAP_RES_DOORBELL_TX */
+	{ SXE2_TXQ_LEGACY_DBLL(0), 0, 4},
+	/* SXE2_PCI_MAP_RES_DOORBELL_RX_TAIL */
+	{ SXE2_RXQ_TAIL(0), 0, 4},
+	/* SXE2_PCI_MAP_RES_IRQ_DYN */
+	{ SXE2_VF_DYN_CTL(0), 0, 4},
+	/* SXE2_PCI_MAP_RES_IRQ_ITR(默认使用ITR0) */
+	{ SXE2_VF_INT_ITR(0, 0), 0, 4},
+	/* SXE2_PCI_MAP_RES_IRQ_MSIX */
+	{ SXE2_BAR4_MSIX_CTL(0), 4, 0x10},
+};
+
 static s32 sxe2_dev_configure(struct rte_eth_dev *dev)
 {
 	s32 ret = SXE2_SUCCESS;
@@ -151,6 +166,7 @@ static s32 sxe2_dev_close(struct rte_eth_dev *dev)
 	(void)sxe2_dev_stop(dev);
 
 	sxe2_vsi_uninit(dev);
+	sxe2_dev_pci_map_uinit(dev);
 
 	return SXE2_SUCCESS;
 }
@@ -304,6 +320,31 @@ static const struct eth_dev_ops sxe2_eth_dev_ops = {
 	.dev_infos_get              = sxe2_dev_infos_get,
 };
 
+struct sxe2_pci_map_bar_info *sxe2_dev_get_bar_info(struct sxe2_adapter *adapter,
+		enum sxe2_pci_map_resource res_type)
+{
+	struct sxe2_pci_map_context *map_ctxt = &adapter->map_ctxt;
+	struct sxe2_pci_map_bar_info *bar_info = NULL;
+	u8 bar_idx = SXE2_PCI_MAP_BAR_INVALID;
+	u8 i;
+
+	bar_idx = map_ctxt->addr_info[res_type].bar_idx;
+	if (bar_idx == SXE2_PCI_MAP_BAR_INVALID) {
+		PMD_DEV_LOG_ERR(adapter, INIT, "Invalid bar index with resource type %d", res_type);
+		goto l_end;
+	}
+
+	for (i = 0; i < map_ctxt->bar_cnt; i++) {
+		if (bar_idx == map_ctxt->bar_info[i].bar_idx) {
+			bar_info = &map_ctxt->bar_info[i];
+			break;
+		}
+	}
+
+l_end:
+	return bar_info;
+}
+
 static void sxe2_drv_dev_caps_set(struct sxe2_adapter *adapter,
 			struct sxe2_drv_dev_caps_resp *dev_caps)
 {
@@ -371,6 +412,67 @@ static s32 sxe2_dev_caps_get(struct sxe2_adapter *adapter)
 	return ret;
 }
 
+s32 sxe2_dev_pci_seg_map(struct sxe2_adapter *adapter,
+		enum sxe2_pci_map_resource res_type, u64 org_len, u64 org_offset)
+{
+	struct sxe2_pci_map_bar_info *bar_info = NULL;
+	struct sxe2_pci_map_segment_info *seg_info = NULL;
+	void *map_addr = NULL;
+	s32 ret = SXE2_SUCCESS;
+	size_t page_size = 0;
+	size_t aligned_len = 0;
+	size_t page_inner_offset = 0;
+	off_t aligned_offset = 0;
+	u8 i = 0;
+
+	if (org_len == 0) {
+		PMD_DEV_LOG_ERR(adapter, INIT, "Invalid length, ori_len = 0");
+		ret = SXE2_ERR_FAULT;
+		goto l_end;
+	}
+
+	bar_info = sxe2_dev_get_bar_info(adapter, res_type);
+	if (!bar_info) {
+		PMD_LOG_ERR(INIT, "Failed to get bar info, res_type=[%d]", res_type);
+		ret = SXE2_ERR_FAULT;
+		goto l_end;
+	}
+	seg_info = bar_info->seg_info;
+
+	page_size = rte_mem_page_size();
+
+	aligned_offset = RTE_ALIGN_FLOOR(org_offset, page_size);
+	page_inner_offset = org_offset - aligned_offset;
+	aligned_len = RTE_ALIGN(page_inner_offset + org_len, page_size);
+
+	map_addr = sxe2_drv_dev_mmap(adapter->cdev, bar_info->bar_idx, aligned_len, aligned_offset);
+	if (!map_addr) {
+		PMD_LOG_ERR(INIT, "Failed to mmap BAR space, type=%d, len=%zu, page_size=%zu",
+					res_type, org_len, page_size);
+		ret = SXE2_ERR_FAULT;
+		goto l_end;
+	}
+
+	for (i = 0; i < bar_info->map_cnt; i++) {
+		if (seg_info[i].type != SXE2_PCI_MAP_RES_INVALID)
+			continue;
+		seg_info[i].type = res_type;
+		seg_info[i].addr = map_addr;
+		seg_info[i].page_inner_offset = page_inner_offset;
+		seg_info[i].len = aligned_len;
+		break;
+	}
+	if (i == bar_info->map_cnt) {
+		PMD_LOG_ERR(INIT, "No memory to save resource, res_type=%d", res_type);
+		ret = SXE2_ERR_NOMEM;
+		sxe2_drv_dev_munmap(adapter->cdev, map_addr, aligned_len);
+		goto l_end;
+	}
+
+l_end:
+	return ret;
+}
+
 static s32 sxe2_hw_init(struct rte_eth_dev *dev)
 {
 	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
@@ -385,6 +487,54 @@ static s32 sxe2_hw_init(struct rte_eth_dev *dev)
 	return ret;
 }
 
+s32 sxe2_dev_pci_res_seg_map(struct sxe2_adapter *adapter, u32 res_type,
+							 u32 item_cnt, u32 item_base)
+{
+	struct sxe2_pci_map_addr_info *addr_info = NULL;
+	s32 ret = SXE2_SUCCESS;
+
+	addr_info = &adapter->map_ctxt.addr_info[res_type];
+	if (!addr_info || addr_info->bar_idx == SXE2_PCI_MAP_BAR_INVALID) {
+		PMD_DEV_LOG_ERR(adapter, INIT, "Invalid bar index with resource type %d", res_type);
+		ret = SXE2_ERR_FAULT;
+		goto l_end;
+	}
+
+	ret = sxe2_dev_pci_seg_map(adapter, res_type, item_cnt * addr_info->reg_width,
+			addr_info->addr_base + item_base * addr_info->reg_width);
+	if (ret != SXE2_SUCCESS) {
+		PMD_DEV_LOG_ERR(adapter, INIT, "Failed to map resource, res_type=%d", res_type);
+		goto l_end;
+	}
+l_end:
+	return ret;
+}
+
+void sxe2_dev_pci_seg_unmap(struct sxe2_adapter *adapter, u32 res_type)
+{
+	struct sxe2_pci_map_bar_info *bar_info = NULL;
+	struct sxe2_pci_map_segment_info *seg_info = NULL;
+	u32 i = 0;
+
+	bar_info = sxe2_dev_get_bar_info(adapter, res_type);
+	if (bar_info == NULL) {
+		PMD_DEV_LOG_WARN(adapter, INIT, "Failed to get bar info, res_type=[%d]", res_type);
+		goto l_end;
+	}
+	seg_info = bar_info->seg_info;
+
+	for (i = 0; i < bar_info->map_cnt; i++) {
+		if (res_type == seg_info[i].type) {
+			(void)sxe2_drv_dev_munmap(adapter->cdev, seg_info[i].addr, seg_info[i].len);
+			memset(&seg_info[i], 0, sizeof(struct sxe2_pci_map_segment_info));
+			break;
+		}
+	}
+
+l_end:
+	return;
+}
+
 static s32 sxe2_dev_info_init(struct rte_eth_dev *dev)
 {
 	struct sxe2_adapter *adapter =
@@ -425,6 +575,157 @@ static s32 sxe2_dev_info_init(struct rte_eth_dev *dev)
 	return ret;
 }
 
+s32 sxe2_dev_pci_map_init(struct rte_eth_dev *dev)
+{
+	struct sxe2_adapter *adapter  = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct rte_pci_device *pci_dev = RTE_DEV_TO_PCI(dev->device);
+	struct sxe2_pci_map_context *map_ctxt = &adapter->map_ctxt;
+	struct sxe2_pci_map_bar_info *bar_info = NULL;
+	struct sxe2_pci_map_segment_info *seg_info = NULL;
+	u16 txq_cnt = adapter->q_ctxt.qp_cnt_assign;
+	u16 txq_base = adapter->q_ctxt.base_idx_in_pf;
+	u16 rxq_cnt = adapter->q_ctxt.qp_cnt_assign;
+	u16 irq_cnt = adapter->irq_ctxt.max_cnt_hw;
+	u16 irq_base = adapter->irq_ctxt.base_idx_in_func;
+	u16 rxq_base = adapter->q_ctxt.base_idx_in_pf;
+	s32 ret = SXE2_SUCCESS;
+
+	PMD_INIT_FUNC_TRACE();
+
+	adapter->dev_info.dev_data = dev->data;
+
+	if (!pci_dev->mem_resource[0].phys_addr) {
+		PMD_LOG_ERR(INIT, "Physical address not scanned");
+		ret = SXE2_ERR_NXIO;
+		goto l_end;
+	}
+
+	map_ctxt->bar_cnt = 2;
+
+	bar_info = rte_zmalloc(NULL, sizeof(*bar_info) * map_ctxt->bar_cnt, 0);
+	if (!bar_info) {
+		PMD_LOG_ERR(INIT, "Failed to alloc bar_info");
+		ret = SXE2_ERR_NOMEM;
+		goto l_end;
+	}
+	bar_info[0].bar_idx = 0;
+	bar_info[0].map_cnt = SXE2_PCI_MAP_RES_MAX_COUNT;
+	seg_info = rte_zmalloc(NULL, sizeof(*seg_info) * bar_info[0].map_cnt, 0);
+	if (!seg_info) {
+		PMD_LOG_ERR(INIT, "Failed to alloc seg_info");
+		ret = SXE2_ERR_NOMEM;
+		goto l_free_bar;
+	}
+
+	bar_info[0].seg_info = seg_info;
+
+	bar_info[1].bar_idx = 4;
+	bar_info[1].map_cnt = SXE2_PCI_MAP_RES_MAX_COUNT;
+	seg_info = rte_zmalloc(NULL, sizeof(*seg_info) * bar_info[1].map_cnt, 0);
+	if (!seg_info) {
+		PMD_LOG_ERR(INIT, "Failed to alloc seg_info");
+		ret = SXE2_ERR_NOMEM;
+		goto l_free_seg0;
+	}
+
+	bar_info[1].seg_info = seg_info;
+	map_ctxt->bar_info = bar_info;
+
+	map_ctxt->addr_info = sxe2_net_map_addr_info_pf;
+
+	ret = sxe2_dev_pci_res_seg_map(adapter, SXE2_PCI_MAP_RES_DOORBELL_TX,
+			txq_cnt, txq_base);
+	if (!ret) {
+		PMD_LOG_ERR(INIT, "Failed to map txq doorbell addr, ret=%d", ret);
+		goto l_free_seg1;
+	}
+
+	ret = sxe2_dev_pci_res_seg_map(adapter, SXE2_PCI_MAP_RES_DOORBELL_RX_TAIL,
+			rxq_cnt, rxq_base);
+	if (!ret) {
+		PMD_LOG_ERR(INIT, "Failed to map rxq tail doorbell addr, ret=%d", ret);
+		goto l_free_txq;
+	}
+
+	ret = sxe2_dev_pci_res_seg_map(adapter, SXE2_PCI_MAP_RES_IRQ_DYN,
+			irq_cnt, irq_base);
+	if (!ret) {
+		PMD_LOG_ERR(INIT, "Failed to map irq dyn addr, ret=%d", ret);
+		goto l_free_rxq_tail;
+	}
+
+	ret = sxe2_dev_pci_res_seg_map(adapter, SXE2_PCI_MAP_RES_IRQ_ITR,
+			irq_cnt, irq_base);
+	if (!ret) {
+		PMD_LOG_ERR(INIT, "Failed to map irq itr addr, ret=%d", ret);
+		goto l_free_irq_dyn;
+	}
+
+	ret = sxe2_dev_pci_res_seg_map(adapter, SXE2_PCI_MAP_RES_IRQ_MSIX,
+			irq_cnt, irq_base);
+	if (!ret) {
+		PMD_LOG_ERR(INIT, "Failed to map irq msix addr, ret=%d", ret);
+		goto l_free_irq_itr;
+	}
+	goto l_end;
+
+l_free_irq_itr:
+	(void)sxe2_dev_pci_seg_unmap(adapter, SXE2_PCI_MAP_RES_IRQ_ITR);
+l_free_irq_dyn:
+	(void)sxe2_dev_pci_seg_unmap(adapter, SXE2_PCI_MAP_RES_IRQ_DYN);
+l_free_rxq_tail:
+	(void)sxe2_dev_pci_seg_unmap(adapter, SXE2_PCI_MAP_RES_DOORBELL_RX_TAIL);
+l_free_txq:
+	(void)sxe2_dev_pci_seg_unmap(adapter, SXE2_PCI_MAP_RES_DOORBELL_TX);
+l_free_seg1:
+	if (bar_info[1].seg_info) {
+		rte_free(bar_info[1].seg_info);
+		bar_info[1].seg_info = NULL;
+	}
+l_free_seg0:
+	if (bar_info[0].seg_info) {
+		rte_free(bar_info[0].seg_info);
+		bar_info[0].seg_info = NULL;
+	}
+l_free_bar:
+	if (bar_info) {
+		rte_free(bar_info);
+		bar_info = NULL;
+	}
+l_end:
+	return ret;
+}
+
+void sxe2_dev_pci_map_uinit(struct rte_eth_dev *dev)
+{
+	struct sxe2_adapter *adapter  = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct sxe2_pci_map_context *map_ctxt = &adapter->map_ctxt;
+	struct sxe2_pci_map_bar_info *bar_info = NULL;
+	u8 i = 0;
+
+	PMD_INIT_FUNC_TRACE();
+
+	(void)sxe2_dev_pci_seg_unmap(adapter, SXE2_PCI_MAP_RES_DOORBELL_RX_TAIL);
+	(void)sxe2_dev_pci_seg_unmap(adapter, SXE2_PCI_MAP_RES_DOORBELL_TX);
+	(void)sxe2_dev_pci_seg_unmap(adapter, SXE2_PCI_MAP_RES_IRQ_DYN);
+	(void)sxe2_dev_pci_seg_unmap(adapter, SXE2_PCI_MAP_RES_IRQ_ITR);
+	(void)sxe2_dev_pci_seg_unmap(adapter, SXE2_PCI_MAP_RES_IRQ_MSIX);
+
+	if (map_ctxt != NULL && map_ctxt->bar_info != NULL) {
+		for (i = 0; i < map_ctxt->bar_cnt; i++) {
+			bar_info = &map_ctxt->bar_info[i];
+			if (bar_info != NULL && bar_info->seg_info != NULL) {
+				rte_free(bar_info->seg_info);
+				bar_info->seg_info = NULL;
+			}
+		}
+		rte_free(map_ctxt->bar_info);
+		map_ctxt->bar_info = NULL;
+	}
+
+	adapter->dev_info.dev_data = NULL;
+}
+
 static s32 sxe2_dev_init(struct rte_eth_dev *dev, struct sxe2_dev_kvargs_info *kvargs __rte_unused)
 {
 	s32 ret = 0;
@@ -439,6 +740,12 @@ static s32 sxe2_dev_init(struct rte_eth_dev *dev, struct sxe2_dev_kvargs_info *k
 		goto l_end;
 	}
 
+	ret = sxe2_dev_pci_map_init(dev);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "Failed to pci addr map, ret=[%d]", ret);
+		goto l_end;
+	}
+
 	ret = sxe2_vsi_init(dev);
 	if (ret) {
 		PMD_LOG_ERR(INIT, "create main vsi failed, ret=%d", ret);
diff --git a/drivers/net/sxe2/sxe2_ethdev.h b/drivers/net/sxe2/sxe2_ethdev.h
index dc3a3175d1..fb7813ef80 100644
--- a/drivers/net/sxe2/sxe2_ethdev.h
+++ b/drivers/net/sxe2/sxe2_ethdev.h
@@ -292,4 +292,22 @@ struct sxe2_adapter {
 #define SXE2_DEV_PRIVATE_TO_ADAPTER(dev) \
 	((struct sxe2_adapter *)(dev)->data->dev_private)
 
+#define SXE2_DEV_TO_PCI(eth_dev) \
+		RTE_DEV_TO_PCI((eth_dev)->device)
+
+struct sxe2_pci_map_bar_info *sxe2_dev_get_bar_info(struct sxe2_adapter *adapter,
+		enum sxe2_pci_map_resource res_type);
+
+s32 sxe2_dev_pci_seg_map(struct sxe2_adapter *adapter,
+		enum sxe2_pci_map_resource res_type, u64 org_len, u64 org_offset);
+
+s32 sxe2_dev_pci_res_seg_map(struct sxe2_adapter *adapter, u32 res_type,
+		u32 item_cnt, u32 item_base);
+
+void sxe2_dev_pci_seg_unmap(struct sxe2_adapter *adapter, u32 res_type);
+
+s32 sxe2_dev_pci_map_init(struct rte_eth_dev *dev);
+
+void sxe2_dev_pci_map_uinit(struct rte_eth_dev *dev);
+
 #endif
-- 
2.47.3

