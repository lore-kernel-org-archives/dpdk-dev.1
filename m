Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F17CEEF06E4
	for <dpdk-dev@archiver.kernel.org>; Sun,  8 Feb 2026 09:32:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 567A240665;
	Sun,  8 Feb 2026 10:32:06 +0100 (CET)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by mails.dpdk.org (Postfix) with ESMTP id 45D3F4025D
 for <dev@dpdk.org>; Sun,  8 Feb 2026 10:31:30 +0100 (CET)
Received: from mail.cstnet.cn (unknown [221.238.36.162])
 by APP-05 (Coremail) with SMTP id zQCowAD3hQntV4hp7xbIBw--.48983S5;
 Sun, 08 Feb 2026 17:31:26 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v15 04/13] net/sxe: add link, flow ctrl, mac ops,
 mtu ops function
Date: Sun,  8 Feb 2026 17:31:13 +0800
Message-Id: <20260208093122.10329-4-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20260208093122.10329-1-liujie5@linkdatatechnology.com>
References: <20251225092224.227202-13-liujie5@linkdatatechnology.com>
 <20260208093122.10329-1-liujie5@linkdatatechnology.com>
X-CM-TRANSID: zQCowAD3hQntV4hp7xbIBw--.48983S5
X-Coremail-Antispam: 1UD129KBjvAXoWDAw1rtrWrGr18JFWxCrW5trb_yoW3GF1rto
 WftrZxJw15Ary2kayxXrn7JrW7ZrWxWay5tw43uFs3uanrC3WY9ry3Kw13Arn3W3WrtF1k
 urn2kr92qa1UKa18n29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UjIYCTnIWjp_UUUO17AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20EY4v20xva
 j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r1rM28IrcIa0x
 kI8VCY1x0267AKxVWUCVW8JwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84AC
 jcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM2
 8EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4UJwAS
 0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
 IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
 Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0F24lc2xSY4
 AK67AK6r4fMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
 0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjmi
 iDUUUUU==
X-Originating-IP: [221.238.36.162]
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

Add link, flow ctrl, mac ops, mtu ops function.

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe/meson.build        |   5 +-
 drivers/net/sxe/pf/rte_pmd_sxe.h   |  14 +
 drivers/net/sxe/pf/sxe.h           |  36 +-
 drivers/net/sxe/pf/sxe_ethdev.c    | 614 ++++++++++++++++++-
 drivers/net/sxe/pf/sxe_filter.c    | 278 +++++++++
 drivers/net/sxe/pf/sxe_filter.h    |  52 ++
 drivers/net/sxe/pf/sxe_flow_ctrl.c |  98 +++
 drivers/net/sxe/pf/sxe_flow_ctrl.h |  16 +
 drivers/net/sxe/pf/sxe_irq.c       | 143 ++++-
 drivers/net/sxe/pf/sxe_main.c      |   2 +
 drivers/net/sxe/pf/sxe_phy.c       | 932 +++++++++++++++++++++++++++++
 drivers/net/sxe/pf/sxe_phy.h       |  77 +++
 12 files changed, 2262 insertions(+), 5 deletions(-)
 create mode 100644 drivers/net/sxe/pf/rte_pmd_sxe.h
 create mode 100644 drivers/net/sxe/pf/sxe_filter.c
 create mode 100644 drivers/net/sxe/pf/sxe_filter.h
 create mode 100644 drivers/net/sxe/pf/sxe_flow_ctrl.c
 create mode 100644 drivers/net/sxe/pf/sxe_flow_ctrl.h
 create mode 100644 drivers/net/sxe/pf/sxe_phy.c

diff --git a/drivers/net/sxe/meson.build b/drivers/net/sxe/meson.build
index 23d9f206e4..eab222d7c4 100644
--- a/drivers/net/sxe/meson.build
+++ b/drivers/net/sxe/meson.build
@@ -4,7 +4,7 @@ if not is_linux or not (dpdk_conf.has('RTE_ARCH_X86_64') or dpdk_conf.has('RTE_A
     build = false
     reason = 'only supported on x86_64 or arm64 Linux'
     subdir_done()
-+endif
+endif
 cflags += ['-DSXE_DPDK']
 cflags += ['-DSXE_HOST_DRIVER']
 
@@ -14,6 +14,8 @@ cflags += ['-DSXE_HOST_DRIVER']
 deps += ['hash']
 sources = files(
         'pf/sxe_main.c',
+        'pf/sxe_filter.c',
+        'pf/sxe_flow_ctrl.c',
         'pf/sxe_irq.c',
         'pf/sxe_ethdev.c',
         'pf/sxe_offload.c',
@@ -21,6 +23,7 @@ sources = files(
         'pf/sxe_rx.c',
         'pf/sxe_tx.c',
         'pf/sxe_pmd_hdc.c',
+        'pf/sxe_phy.c',
         'base/sxe_queue_common.c',
         'base/sxe_rx_common.c',
         'base/sxe_tx_common.c',
diff --git a/drivers/net/sxe/pf/rte_pmd_sxe.h b/drivers/net/sxe/pf/rte_pmd_sxe.h
new file mode 100644
index 0000000000..64c1140490
--- /dev/null
+++ b/drivers/net/sxe/pf/rte_pmd_sxe.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+
+#ifndef __PMD_SXE_H__
+#define __PMD_SXE_H__
+
+typedef uint8_t		u8;
+typedef uint16_t	u16;
+typedef uint32_t	u32;
+typedef int32_t		s32;
+
+s32 rte_pmd_sxe_tx_loopback_set(u16 port, u8 on);
+#endif
diff --git a/drivers/net/sxe/pf/sxe.h b/drivers/net/sxe/pf/sxe.h
index 187c7341e1..8fecce13fd 100644
--- a/drivers/net/sxe/pf/sxe.h
+++ b/drivers/net/sxe/pf/sxe.h
@@ -6,16 +6,18 @@
 
 #include <rte_pci.h>
 #include <rte_time.h>
-
 #include <stdbool.h>
 #include "sxe_types.h"
 #include "sxe_filter.h"
 #include "sxe_irq.h"
 #include "sxe_stats.h"
 #include "sxe_phy.h"
+#include "sxe_vf.h"
+#include "sxe_dcb.h"
 #include "sxe_hw.h"
 
 struct sxe_hw;
+struct sxe_vlan_context;
 
 #define SXE_LPBK_DISABLED   0x0
 #define SXE_LPBK_ENABLED	0x1
@@ -41,13 +43,45 @@ struct sxe_hw;
 #define rte_sxe_prefetch(p)   do {} while (0)
 #endif
 
+struct sxe_ptp_context {
+	struct rte_timecounter	  systime_tc;
+	struct rte_timecounter	  rx_tstamp_tc;
+	struct rte_timecounter	  tx_tstamp_tc;
+	u32 tx_hwtstamp_sec;
+	u32 tx_hwtstamp_nsec;
+};
+
 struct sxe_adapter {
 	struct sxe_hw hw;
 
 	struct sxe_irq_context irq_ctxt;
 
+	struct sxe_vlan_context vlan_ctxt;
+	struct sxe_mac_filter_context mac_filter_ctxt;
+#ifdef RTE_ADAPTER_HAVE_FNAV_CONF
+	struct rte_eth_fdir_conf fnav_conf;
+#endif
+	struct sxe_ptp_context ptp_ctxt;
+	struct sxe_phy_context phy_ctxt;
+	struct sxe_virtual_context vt_ctxt;
+
+	struct sxe_stats_info stats_info;
+	struct sxe_dcb_context dcb_ctxt;
+
 	bool rx_batch_alloc_allowed;
+#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SIMD
+	bool rx_vec_allowed;
+#endif
 	s8 name[PCI_PRI_STR_SIZE + 1];
+
+	u32 mtu;
+
+	bool rss_reta_updated;
+
+	RTE_ATOMIC(bool) link_thread_running;
+	RTE_ATOMIC(bool) is_stopping;
+	rte_thread_t link_thread_tid;
+	bool is_stopped;
 };
 
 s32 sxe_hw_reset(struct sxe_hw *hw);
diff --git a/drivers/net/sxe/pf/sxe_ethdev.c b/drivers/net/sxe/pf/sxe_ethdev.c
index b611922cf8..74b87507cf 100644
--- a/drivers/net/sxe/pf/sxe_ethdev.c
+++ b/drivers/net/sxe/pf/sxe_ethdev.c
@@ -7,6 +7,7 @@
 #include <ethdev_pci.h>
 #include <rte_ethdev.h>
 #include <rte_alarm.h>
+#include <rte_pmd_sxe.h>
 #include <eal_export.h>
 #include "sxe_types.h"
 #include "sxe_logs.h"
@@ -14,14 +15,27 @@
 #include "sxe_errno.h"
 #include "sxe.h"
 #include "sxe_hw.h"
+#include "sxe_offload.h"
 #include "sxe_ethdev.h"
+#include "sxe_filter.h"
+#include "sxe_rx.h"
+#include "sxe_tx.h"
+#include "sxe_queue.h"
 #include "sxe_irq.h"
+#include "sxe_stats.h"
+#include "sxe_phy.h"
 #include "sxe_pmd_hdc.h"
+#include "sxe_flow_ctrl.h"
+#include "sxe_ptp.h"
+#include "sxe_cli.h"
 #include "drv_msg.h"
+#include "sxe_vf.h"
+#include "sxe_dcb.h"
 #include "sxe_version.h"
 #include "sxe_compat_version.h"
 #include <rte_string_fns.h>
 
+
 #define SXE_DEFAULT_MTU			 1500
 #define SXE_ETH_HLEN				14
 #define SXE_ETH_FCS_LEN			 4
@@ -29,6 +43,20 @@
 
 #define SXE_ETH_MAX_LEN  (RTE_ETHER_MTU + SXE_ETH_OVERHEAD)
 
+static const struct rte_eth_desc_lim sxe_rx_desc_lim = {
+	.nb_max = SXE_MAX_RING_DESC,
+	.nb_min = SXE_MIN_RING_DESC,
+	.nb_align = SXE_RX_DESC_RING_ALIGN,
+};
+
+static const struct rte_eth_desc_lim sxe_tx_desc_lim = {
+	.nb_max = SXE_MAX_RING_DESC,
+	.nb_min = SXE_MIN_RING_DESC,
+	.nb_align = SXE_TX_DESC_RING_ALIGN,
+	.nb_seg_max = SXE_TX_MAX_SEG,
+	.nb_mtu_seg_max = SXE_TX_MAX_SEG,
+};
+
 static s32 sxe_dev_reset(struct rte_eth_dev *eth_dev);
 
 static s32 sxe_dev_configure(struct rte_eth_dev *dev)
@@ -39,10 +67,139 @@ static s32 sxe_dev_configure(struct rte_eth_dev *dev)
 
 	PMD_INIT_FUNC_TRACE();
 
+	/* Rx mode check */
+	if (dev->data->dev_conf.rxmode.mq_mode & RTE_ETH_MQ_RX_RSS_FLAG) {
+		PMD_LOG_DEBUG(INIT, "rx offload rss hash");
+		dev->data->dev_conf.rxmode.offloads |= RTE_ETH_RX_OFFLOAD_RSS_HASH;
+	}
+
+	/* Multi queue mode check */
+	ret  = sxe_mq_mode_check(dev);
+	if (ret != 0) {
+		PMD_LOG_ERR(INIT, "sxe mq mode check fails with %d.",
+				ret);
+		goto l_end;
+	}
+
+	irq->action |= SXE_IRQ_LINK_UPDATE;
+
+	/* Default use batch alloc  */
+	adapter->rx_batch_alloc_allowed = true;
+
+#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SIMD
+	adapter->rx_vec_allowed = true;
+#endif
+
+l_end:
+	return ret;
+}
+
+static void sxe_txrx_start(struct rte_eth_dev *dev)
+{
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_hw	 *hw = &adapter->hw;
+
+	sxe_hw_rx_cap_switch_on(hw);
+
+	sxe_hw_mac_txrx_enable(hw);
+}
+
+static s32 sxe_link_configure(struct rte_eth_dev *dev)
+{
+	s32 ret = 0;
+	bool link_up = false;
+	u32 conf_speeds;
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+
+	/* Disable loopback */
+	sxe_hw_loopback_switch(hw, false);
+
+	sxe_sfp_tx_laser_enable(adapter);
+
+	dev->data->dev_link.link_status = link_up;
+
+	/* Rate of obtaining user configuration */
+	ret = sxe_conf_speed_get(dev, &conf_speeds);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "invalid link setting");
+		goto l_end;
+	}
+
+	if (adapter->phy_ctxt.sfp_info.multispeed_fiber)
+		ret = sxe_multispeed_sfp_link_configure(dev, conf_speeds, false);
+	else
+		ret = sxe_sfp_link_configure(dev);
+
+	if (ret) {
+		PMD_LOG_ERR(INIT, "link config failed, speed=%x",
+						conf_speeds);
+		ret = -EIO;
+		goto l_end;
+	}
+
 l_end:
 	return ret;
 }
 
+static s32 sxe_loopback_pcs_init(struct sxe_adapter *adapter,
+				sxe_pcs_mode_e mode, u32 max_frame)
+{
+	s32 ret;
+	sxe_pcs_cfg_s pcs_cfg;
+	struct sxe_hw *hw = &adapter->hw;
+	struct sxe_irq_context *irq = &adapter->irq_ctxt;
+
+	pcs_cfg.mode = mode;
+	pcs_cfg.mtu  = max_frame;
+	ret = sxe_driver_cmd_trans(hw, SXE_CMD_PCS_SDS_INIT,
+				(void *)&pcs_cfg, sizeof(pcs_cfg),
+				NULL, 0);
+	irq->to_pcs_init = false;
+	if (ret) {
+		LOG_ERROR_BDF("hdc trans failed ret=%d, cmd:pcs init", ret);
+		goto l_end;
+	}
+
+	/* Set flow control mac address */
+	sxe_fc_mac_addr_set(adapter);
+
+	LOG_INFO_BDF("mode:%u max_frame:0x%x loopback pcs init done.",
+			 mode, max_frame);
+l_end:
+	return ret;
+}
+
+static s32 sxe_loopback_configure(struct sxe_adapter *adapter)
+{
+	s32 ret;
+	u32 max_frame = SXE_DEFAULT_MTU + SXE_ETH_DEAD_LOAD;
+
+	(void)sxe_sfp_tx_laser_disable(adapter);
+
+	/* Initialize sds and pcs modules */
+	ret = sxe_loopback_pcs_init(adapter, SXE_PCS_MODE_10GBASE_KR_WO, max_frame);
+	if (ret) {
+		LOG_ERROR_BDF("pcs sds init failed, mode=%d, ret=%d",
+					SXE_PCS_MODE_10GBASE_KR_WO, ret);
+		goto l_out;
+	}
+
+	ret = sxe_loopback_pcs_init(adapter, SXE_PCS_MODE_LPBK_PHY_TX2RX, max_frame);
+	if (ret) {
+		LOG_ERROR_BDF("pcs sds init failed, mode=%d, ret=%d",
+					SXE_PCS_MODE_LPBK_PHY_TX2RX, ret);
+		goto l_out;
+	}
+
+	usleep_range(10000, 20000);
+
+	LOG_DEBUG_BDF("loolback configure success max_frame:0x%x.", max_frame);
+
+l_out:
+	return ret;
+}
+
 static s32 sxe_dev_start(struct rte_eth_dev *dev)
 {
 	s32 ret;
@@ -54,8 +211,21 @@ static s32 sxe_dev_start(struct rte_eth_dev *dev)
 
 	ret = sxe_fw_time_sync(hw);
 
+	sxe_wait_setup_link_complete(dev, 0);
+
 	rte_intr_disable(handle);
 
+	adapter->is_stopped = false;
+	rte_atomic_store_explicit(&adapter->is_stopping, 0, rte_memory_order_seq_cst);
+	ret = sxe_phy_init(adapter);
+	if (ret == -SXE_ERR_SFF_NOT_SUPPORTED) {
+		PMD_LOG_ERR(INIT, "sfp is not sfp+, not supported, ret=%d", ret);
+		ret = -EPERM;
+		goto l_end;
+	} else if (ret) {
+		PMD_LOG_ERR(INIT, "phy init failed, ret=%d", ret);
+	}
+
 	ret = sxe_hw_reset(hw);
 	if (ret < 0) {
 		PMD_LOG_ERR(INIT, "hw init failed, ret=%d", ret);
@@ -64,18 +234,63 @@ static s32 sxe_dev_start(struct rte_eth_dev *dev)
 
 	sxe_hw_start(hw);
 
+	sxe_mac_addr_set(dev, &dev->data->mac_addrs[0]);
+
+#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SRIOV
+	sxe_hw_pf_rst_done_set(hw);
+
+	/* Configure virtualization */
+	sxe_vt_configure(dev);
+#endif
+	sxe_tx_configure(dev);
+
+	ret = sxe_rx_configure(dev);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "unable to initialize RX hardware");
+		goto l_error;
+	}
+
 	ret = sxe_irq_configure(dev);
 	if (ret) {
 		PMD_LOG_ERR(INIT, "irq config fail.");
 		goto l_error;
 	}
 
+	sxe_vlan_filter_configure(dev);
+
+	sxe_queue_stats_map_restore(dev);
+
+	sxe_txrx_start(dev);
+
+	irq->to_pcs_init = true;
+
+	if (dev->data->dev_conf.lpbk_mode == SXE_LPBK_DISABLED) {
+		sxe_link_configure(dev);
+	} else if (dev->data->dev_conf.lpbk_mode == SXE_LPBK_ENABLED) {
+		sxe_loopback_configure(adapter);
+	} else {
+		ret = -ENOTSUP;
+		PMD_LOG_ERR(INIT, "unsupported loopback mode:%u.",
+				dev->data->dev_conf.lpbk_mode);
+		goto l_end;
+	}
+
+	sxe_link_update(dev, false);
+
+	ret = sxe_flow_ctrl_enable(dev);
+	if (ret < 0) {
+		PMD_LOG_ERR(INIT, "enable flow ctrl err");
+		goto l_error;
+	}
+
+	sxe_dcb_configure(dev);
 l_end:
 	return ret;
 
 l_error:
 	PMD_LOG_ERR(INIT, "dev start err, ret=%d", ret);
 	sxe_irq_vec_free(handle);
+	sxe_txrx_queues_clear(dev, adapter->rx_batch_alloc_allowed);
 	ret = -EIO;
 	goto l_end;
 }
@@ -90,14 +305,47 @@ static s32 sxe_dev_stop(struct rte_eth_dev *dev)
 
 	PMD_INIT_FUNC_TRACE();
 
+	if (adapter->is_stopped) {
+		LOG_ERROR("adapter[%p] is stopped", adapter);
+		goto l_end;
+	}
+
 	sxe_hw_all_irq_disable(hw);
 
+	sxe_sfp_tx_laser_disable(adapter);
+
+	(void)rte_atomic_exchange_explicit(&adapter->is_stopping, 1, rte_memory_order_seq_cst);
+
+	sxe_wait_setup_link_complete(dev, 0);
 	ret = sxe_hw_reset(hw);
 	if (ret < 0) {
 		PMD_LOG_ERR(INIT, "hw init failed, ret=%d", ret);
 		goto l_end;
 	}
 
+	sxe_mac_addr_set(dev, &dev->data->mac_addrs[0]);
+
+	sxe_irq_disable(dev);
+
+	sxe_txrx_queues_clear(dev, adapter->rx_batch_alloc_allowed);
+
+	dev->data->scattered_rx = 0;
+	dev->data->lro = 0;
+
+	memset(&link, 0, sizeof(link));
+	rte_eth_linkstatus_set(dev, &link);
+
+	adapter->rss_reta_updated = false;
+
+	dev->data->dev_started = 0;
+	adapter->is_stopped = true;
+
+	num = rte_eal_alarm_cancel(sxe_event_irq_delayed_handler, dev);
+	if (num > 0)
+		sxe_eth_dev_callback_process(dev, RTE_ETH_EVENT_INTR_LSC, NULL);
+
+	LOG_DEBUG_BDF("dev stop success.");
+
 l_end:
 	return ret;
 }
@@ -122,12 +370,15 @@ static s32 sxe_dev_close(struct rte_eth_dev *dev)
 		PMD_LOG_ERR(INIT, "hw init failed, ret=%d", ret);
 		goto l_end;
 	}
-
 	ret = sxe_dev_stop(dev);
 	if (ret)
 		PMD_LOG_ERR(INIT, "dev stop fail.(err:%d)", ret);
-
+	sxe_queues_free(dev);
+	sxe_mac_addr_set(dev, &adapter->mac_filter_ctxt.def_mac_addr);
 	sxe_irq_uninit(dev);
+#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SRIOV
+	sxe_vt_uninit(dev);
+#endif
 
 l_end:
 	return ret;
@@ -139,9 +390,106 @@ static s32 sxe_dev_infos_get(struct rte_eth_dev *dev,
 	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
 	struct rte_eth_conf *dev_conf = &dev->data->dev_conf;
 
+	dev_info->max_rx_queues = SXE_HW_TXRX_RING_NUM_MAX;
+	dev_info->max_tx_queues = SXE_HW_TXRX_RING_NUM_MAX;
+	if (RTE_ETH_DEV_SRIOV(dev).active == 0) {
+		if (dev_conf->txmode.mq_mode == RTE_ETH_MQ_TX_NONE)
+			dev_info->max_tx_queues = SXE_HW_TX_NONE_MODE_Q_NUM;
+	}
+
+	dev_info->min_rx_bufsize = 1024;
+	dev_info->max_rx_pktlen = 15872;
+	dev_info->max_mac_addrs = SXE_UC_ENTRY_NUM_MAX;
+	dev_info->max_hash_mac_addrs = SXE_HASH_UC_NUM_MAX;
+	dev_info->max_vfs = pci_dev->max_vfs;
+	dev_info->max_mtu =  dev_info->max_rx_pktlen - SXE_ETH_OVERHEAD;
+	dev_info->min_mtu = RTE_ETHER_MIN_MTU;
+	dev_info->max_vmdq_pools = RTE_ETH_64_POOLS;
+	dev_info->vmdq_queue_num = dev_info->max_rx_queues;
+
+	dev_info->rx_queue_offload_capa = sxe_rx_queue_offload_capa_get(dev);
+	dev_info->rx_offload_capa = (sxe_rx_port_offload_capa_get(dev) |
+					 dev_info->rx_queue_offload_capa);
+	dev_info->tx_queue_offload_capa = sxe_tx_queue_offload_capa_get(dev);
+	dev_info->tx_offload_capa = sxe_tx_port_offload_capa_get(dev);
+
+	dev_info->default_rxconf = (struct rte_eth_rxconf) {
+		.rx_thresh = {
+			.pthresh = SXE_DEFAULT_RX_PTHRESH,
+			.hthresh = SXE_DEFAULT_RX_HTHRESH,
+			.wthresh = SXE_DEFAULT_RX_WTHRESH,
+		},
+		.rx_free_thresh = SXE_DEFAULT_RX_FREE_THRESH,
+		.rx_drop_en = 0,
+		.offloads = 0,
+	};
+
+	dev_info->default_txconf = (struct rte_eth_txconf) {
+		.tx_thresh = {
+			.pthresh = SXE_DEFAULT_TX_PTHRESH,
+			.hthresh = SXE_DEFAULT_TX_HTHRESH,
+			.wthresh = SXE_DEFAULT_TX_WTHRESH,
+		},
+		.tx_free_thresh = SXE_DEFAULT_TX_FREE_THRESH,
+		.tx_rs_thresh = SXE_DEFAULT_TX_RSBIT_THRESH,
+		.offloads = 0,
+	};
+
+	dev_info->rx_desc_lim = sxe_rx_desc_lim;
+	dev_info->tx_desc_lim = sxe_tx_desc_lim;
+
+	dev_info->hash_key_size = SXE_HKEY_MAX_INDEX * sizeof(u32);
+	dev_info->reta_size = RTE_ETH_RSS_RETA_SIZE_128;
+	dev_info->flow_type_rss_offloads = SXE_RSS_OFFLOAD_ALL;
+
+	dev_info->speed_capa = RTE_ETH_LINK_SPEED_1G | RTE_ETH_LINK_SPEED_10G;
+
+	dev_info->default_rxportconf.burst_size = 32;
+	dev_info->default_txportconf.burst_size = 32;
+	dev_info->default_rxportconf.nb_queues = 1;
+	dev_info->default_txportconf.nb_queues = 1;
+	dev_info->default_rxportconf.ring_size = 256;
+	dev_info->default_txportconf.ring_size = 256;
+
 	return 0;
 }
 
+static s32 sxe_mtu_set(struct rte_eth_dev *dev, u16 mtu)
+{
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct rte_eth_dev_info dev_info;
+	u32 frame_size = mtu + SXE_ETH_OVERHEAD;
+	struct rte_eth_dev_data *dev_data = dev->data;
+	s32 ret;
+
+	ret = sxe_dev_infos_get(dev, &dev_info);
+	if (ret != 0) {
+		PMD_LOG_ERR(INIT, "get dev info fails with ret=%d", ret);
+		goto l_end;
+	}
+
+	if (mtu < RTE_ETHER_MTU || frame_size > dev_info.max_rx_pktlen) {
+		PMD_LOG_ERR(INIT, "mtu=%u < %u or frame_size=%u > max_rx_pktlen=%u",
+			mtu, RTE_ETHER_MTU, frame_size, dev_info.max_rx_pktlen);
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	if (dev_data->dev_started && !dev_data->scattered_rx &&
+		(frame_size + 2 * SXE_VLAN_TAG_SIZE >
+		dev->data->min_rx_buf_size - RTE_PKTMBUF_HEADROOM)) {
+		PMD_LOG_ERR(INIT, "stop port first.");
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	adapter->mtu = mtu;
+	PMD_LOG_NOTICE(DRV, "mtu set success, take effect after port-restart.");
+
+l_end:
+	return ret;
+}
+
 static int sxe_get_regs(struct rte_eth_dev *dev,
 		  struct rte_dev_reg_info *regs)
 {
@@ -174,6 +522,73 @@ static int sxe_get_regs(struct rte_eth_dev *dev,
 	return ret;
 }
 
+static s32 sxe_led_reset(struct rte_eth_dev *dev)
+{
+	s32 ret;
+	s32 resp;
+	struct sxe_led_ctrl ctrl;
+	struct sxe_adapter *adapter = (struct sxe_adapter *)(dev->data->dev_private);
+	struct sxe_hw *hw = &adapter->hw;
+
+	ctrl.mode = SXE_IDENTIFY_LED_RESET;
+	ctrl.duration = 0;
+
+	ret = sxe_driver_cmd_trans(hw, SXE_CMD_LED_CTRL,
+				(void *)&ctrl, sizeof(ctrl),
+				(void *)&resp, sizeof(resp));
+	if (ret) {
+		LOG_ERROR_BDF("hdc trans failed ret=%d, cmd:led reset", ret);
+		ret = -EIO;
+	} else {
+		LOG_DEBUG_BDF("led reset success");
+	}
+
+	return ret;
+}
+
+static s32 sxe_led_ctrl(struct sxe_adapter *adapter, bool is_on)
+{
+	s32 ret;
+	s32 resp;
+	struct sxe_led_ctrl ctrl;
+	struct sxe_hw *hw = &adapter->hw;
+
+	ctrl.mode = is_on ? SXE_IDENTIFY_LED_ON : SXE_IDENTIFY_LED_OFF;
+	ctrl.duration = 0;
+
+	ret = sxe_driver_cmd_trans(hw, SXE_CMD_LED_CTRL,
+				(void *)&ctrl, sizeof(ctrl),
+				(void *)&resp, sizeof(resp));
+	if (ret) {
+		LOG_ERROR_BDF("hdc trans failed ret=%d, cmd:led ctrl", ret);
+		ret = -EIO;
+	}
+
+	return ret;
+}
+
+static int sxe_led_on(struct rte_eth_dev *dev)
+{
+	int ret;
+
+	struct sxe_adapter *adapter = dev->data->dev_private;
+
+	ret = sxe_led_ctrl(adapter, true);
+
+	return ret;
+}
+
+static int sxe_led_off(struct rte_eth_dev *dev)
+{
+	int ret;
+
+	struct sxe_adapter *adapter = dev->data->dev_private;
+
+	ret = sxe_led_ctrl(adapter, false);
+
+	return ret;
+}
+
 static int sxe_fw_version_get(struct rte_eth_dev *dev, char *fw_version,
 						size_t fw_size)
 {
@@ -213,7 +628,87 @@ static const struct eth_dev_ops sxe_eth_dev_ops = {
 	.dev_close		= sxe_dev_close,
 	.dev_reset		= sxe_dev_reset,
 
+	.rx_queue_start		= sxe_rx_queue_start,
+	.rx_queue_stop		= sxe_rx_queue_stop,
+	.rx_queue_setup		= sxe_rx_queue_setup,
+	.rx_queue_release	= sxe_rx_queue_release,
+	.rxq_info_get		= sxe_rx_queue_info_get,
+	.dev_infos_get		= sxe_dev_infos_get,
+
+	.tx_queue_start		= sxe_tx_queue_start,
+	.tx_queue_stop		= sxe_tx_queue_stop,
+	.tx_queue_setup		= sxe_tx_queue_setup,
+	.tx_queue_release	= sxe_tx_queue_release,
+	.tx_done_cleanup	= sxe_tx_done_cleanup,
+	.txq_info_get		= sxe_tx_queue_info_get,
+
+	.recycle_rxq_info_get	= sxe_recycle_rxq_info_get,
+
+
+	.promiscuous_enable	= sxe_promiscuous_enable,
+	.promiscuous_disable	= sxe_promiscuous_disable,
+	.allmulticast_enable	= sxe_allmulticast_enable,
+	.allmulticast_disable	= sxe_allmulticast_disable,
+
+	.rx_queue_intr_enable	= sxe_rx_queue_intr_enable,
+	.rx_queue_intr_disable	= sxe_rx_queue_intr_disable,
+
+	.mtu_set		= sxe_mtu_set,
+	.reta_update		= sxe_rss_reta_update,
+	.reta_query		= sxe_rss_reta_query,
+	.rss_hash_update	= sxe_rss_hash_update,
+	.rss_hash_conf_get	= sxe_rss_hash_conf_get,
+
+	.mac_addr_add		= sxe_mac_addr_add,
+	.mac_addr_remove	= sxe_mac_addr_remove,
+	.mac_addr_set		= sxe_mac_addr_set,
+
+	.set_mc_addr_list	= sxe_set_mc_addr_list,
+
+	.stats_get		= sxe_eth_stats_get,
+	.stats_reset		= sxe_stats_reset,
+
+	.xstats_get		= sxe_xstats_get,
+	.xstats_reset		= sxe_xstats_reset,
+	.xstats_get_by_id	= sxe_xstats_get_by_id,
+	.xstats_get_names	= sxe_xstats_names_get,
+	.xstats_get_names_by_id	= sxe_xstats_names_get_by_id,
+	.queue_stats_mapping_set = sxe_queue_stats_mapping_set,
+
+	.get_module_info	= sxe_get_module_info,
+	.get_module_eeprom	= sxe_get_module_eeprom,
+
+	.flow_ctrl_get		= sxe_flow_ctrl_get,
+	.flow_ctrl_set		= sxe_flow_ctrl_set,
+	.priority_flow_ctrl_set = sxe_priority_flow_ctrl_set,
+
+	.timesync_enable	= sxe_timesync_enable,
+	.timesync_disable	= sxe_timesync_disable,
+	.timesync_read_rx_timestamp = sxe_timesync_read_rx_timestamp,
+	.timesync_read_tx_timestamp = sxe_timesync_read_tx_timestamp,
+	.timesync_adjust_time	= sxe_timesync_adjust_time,
+	.timesync_read_time	= sxe_timesync_read_time,
+	.timesync_write_time	= sxe_timesync_write_time,
+
+	.vlan_filter_set	= sxe_vlan_filter_set,
+	.vlan_tpid_set		= sxe_vlan_tpid_set,
+	.vlan_offload_set	= sxe_vlan_offload_set,
+	.vlan_strip_queue_set   = sxe_vlan_strip_queue_set,
+
 	.get_reg		= sxe_get_regs,
+
+	.dev_set_link_up	= sxe_dev_set_link_up,
+	.dev_set_link_down	= sxe_dev_set_link_down,
+	.dev_led_on		= sxe_led_on,
+	.dev_led_off		= sxe_led_off,
+	.link_update		= sxe_link_update,
+
+	.dev_supported_ptypes_get = sxe_dev_supported_ptypes_get,
+
+	.get_dcb_info		= sxe_get_dcb_info,
+
+	.set_queue_rate_limit	= sxe_queue_rate_limit_set,
+	.fw_version_get		= sxe_fw_version_get,
 };
 
 static s32 sxe_hw_base_init(struct rte_eth_dev *eth_dev)
@@ -232,6 +727,15 @@ static s32 sxe_hw_base_init(struct rte_eth_dev *eth_dev)
 
 	sxe_hw_hdc_drv_status_set(hw, (u32)true);
 
+	ret = sxe_phy_init(adapter);
+	if (ret == -SXE_ERR_SFF_NOT_SUPPORTED) {
+		PMD_LOG_ERR(INIT, "sfp is not sfp+, not supported, ret=%d", ret);
+		ret = -EPERM;
+		goto l_out;
+	} else if (ret) {
+		PMD_LOG_ERR(INIT, "phy init failed, ret=%d", ret);
+	}
+
 	ret = sxe_hw_reset(hw);
 	if (ret) {
 		PMD_LOG_ERR(INIT, "hw init failed, ret=%d", ret);
@@ -240,6 +744,18 @@ static s32 sxe_hw_base_init(struct rte_eth_dev *eth_dev)
 		sxe_hw_start(hw);
 	}
 
+	ret = sxe_mac_addr_init(eth_dev);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "mac addr init fail, ret=%d", ret);
+		goto l_out;
+	}
+
+	sxe_hw_fc_base_init(hw);
+
+#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SRIOV
+	sxe_hw_pf_rst_done_set(hw);
+#endif
+
 l_out:
 	if (ret)
 		sxe_hw_hdc_drv_status_set(hw, (u32)false);
@@ -253,6 +769,26 @@ void sxe_secondary_proc_init(struct rte_eth_dev *eth_dev,
 	__sxe_secondary_proc_init(eth_dev, rx_batch_alloc_allowed, rx_vec_allowed);
 }
 
+static void sxe_ethdev_mac_mem_free(struct rte_eth_dev *eth_dev)
+{
+	struct sxe_adapter *adapter = eth_dev->data->dev_private;
+
+	if (eth_dev->data->mac_addrs) {
+		rte_free(eth_dev->data->mac_addrs);
+		eth_dev->data->mac_addrs = NULL;
+	}
+
+	if (eth_dev->data->hash_mac_addrs) {
+		rte_free(eth_dev->data->hash_mac_addrs);
+		eth_dev->data->hash_mac_addrs = NULL;
+	}
+
+	if (adapter->mac_filter_ctxt.uc_addr_table) {
+		rte_free(adapter->mac_filter_ctxt.uc_addr_table);
+		adapter->mac_filter_ctxt.uc_addr_table = NULL;
+	}
+}
+
 s32 sxe_ethdev_init(struct rte_eth_dev *eth_dev, void *param __rte_unused)
 {
 	s32 ret = 0;
@@ -264,14 +800,53 @@ s32 sxe_ethdev_init(struct rte_eth_dev *eth_dev, void *param __rte_unused)
 
 	eth_dev->dev_ops = &sxe_eth_dev_ops;
 
+	eth_dev->rx_queue_count	   = sxe_rx_queue_count;
+	eth_dev->rx_descriptor_status = sxe_rx_descriptor_status;
+	eth_dev->tx_descriptor_status = sxe_tx_descriptor_status;
+
+	eth_dev->rx_pkt_burst		  = &sxe_pkts_recv;
+	eth_dev->tx_pkt_burst = &sxe_pkts_xmit_with_offload;
+	eth_dev->tx_pkt_prepare = &sxe_prep_pkts;
+
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY) {
+#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SIMD
+		sxe_secondary_proc_init(eth_dev, adapter->rx_batch_alloc_allowed,
+				&adapter->rx_vec_allowed);
+#else
+		bool rx_vec_allowed = 0;
+		sxe_secondary_proc_init(eth_dev, adapter->rx_batch_alloc_allowed,
+			&rx_vec_allowed);
+#endif
+		goto l_out;
+	}
+
+	rte_atomic_store_explicit(&adapter->link_thread_running, 0, rte_memory_order_seq_cst);
+
 	rte_eth_copy_pci_info(eth_dev, pci_dev);
 
+
 	ret = sxe_hw_base_init(eth_dev);
 	if (ret) {
 		PMD_LOG_ERR(INIT, "hw base init fail.(err:%d)", ret);
 		goto l_out;
 	}
 
+	sxe_led_reset(eth_dev);
+
+	sxe_dcb_init(eth_dev);
+
+	/* Reset stats info */
+	sxe_stats_reset(eth_dev);
+
+	sxe_queue_stats_map_reset(eth_dev);
+
+	eth_dev->data->dev_flags |= RTE_ETH_DEV_AUTOFILL_QUEUE_XSTATS;
+
+#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SRIOV
+	sxe_vt_init(eth_dev);
+#endif
+	adapter->mtu = RTE_ETHER_MTU;
+
 	sxe_irq_init(eth_dev);
 
 	PMD_LOG_INFO(INIT, "sxe eth dev init done.");
@@ -289,6 +864,8 @@ s32 sxe_ethdev_uninit(struct rte_eth_dev *eth_dev)
 
 	sxe_dev_close(eth_dev);
 
+	sxe_ethdev_mac_mem_free(eth_dev);
+
 l_end:
 	return 0;
 }
@@ -320,3 +897,36 @@ static s32 sxe_dev_reset(struct rte_eth_dev *eth_dev)
 l_end:
 	return ret;
 }
+
+s32 rte_pmd_sxe_tx_loopback_set(u16 port, u8 on)
+{
+	struct rte_eth_dev *dev;
+	struct sxe_adapter *adapter;
+	s32 ret = 0;
+
+	RTE_ETH_VALID_PORTID_OR_ERR_RET(port, -ENODEV);
+
+	dev = &rte_eth_devices[port];
+
+	if (!sxe_is_supported(dev)) {
+		ret = -ENOTSUP;
+		PMD_LOG_ERR(DRV, "port:%u not support tx loopback set.", port);
+		goto l_out;
+	}
+
+	if (on > 1) {
+		ret = -EINVAL;
+		PMD_LOG_ERR(DRV, "port:%u invalid user configure value:%u.",
+					port, on);
+		goto l_out;
+	}
+
+	adapter = dev->data->dev_private;
+
+	sxe_hw_vt_pool_loopback_switch(&adapter->hw, on);
+
+	PMD_LOG_ERR(DRV, "port:%u set tx loopback:%u success.", port, on);
+
+l_out:
+	return ret;
+}
diff --git a/drivers/net/sxe/pf/sxe_filter.c b/drivers/net/sxe/pf/sxe_filter.c
new file mode 100644
index 0000000000..3cd5ddad03
--- /dev/null
+++ b/drivers/net/sxe/pf/sxe_filter.c
@@ -0,0 +1,278 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+#include <ethdev_driver.h>
+#include <bus_pci_driver.h>
+#include <rte_malloc.h>
+#include <rte_ethdev.h>
+#include "sxe_filter.h"
+#include "sxe_logs.h"
+#include "sxe.h"
+#include "sxe_queue.h"
+#include "sxe_pmd_hdc.h"
+#include "sxe_compat_version.h"
+
+#define PF_POOL_INDEX(p)		(p)
+
+#define SXE_STRIP_BITMAP_SET(h, q) \
+	do { \
+		const typeof(h) _sxe_h = (h); \
+		const typeof(q) _sxe_q = (q); \
+		u32 idx = (_sxe_q) / (sizeof((_sxe_h)->strip_bitmap[0]) * BYTE_BIT_NUM); \
+		u32 bit = (_sxe_q) % (sizeof((_sxe_h)->strip_bitmap[0]) * BYTE_BIT_NUM); \
+		(_sxe_h)->strip_bitmap[idx] |= 1 << bit;\
+	} while (0)
+
+#define SXE_STRIP_BITMAP_CLEAR(h, q) \
+	do {\
+		const typeof(h) _sxe_h = (h); \
+		const typeof(q) _sxe_q = (q); \
+		u32 idx = (_sxe_q) / (sizeof((_sxe_h)->strip_bitmap[0]) * BYTE_BIT_NUM); \
+		u32 bit = (_sxe_q) % (sizeof((_sxe_h)->strip_bitmap[0]) * BYTE_BIT_NUM); \
+		(_sxe_h)->strip_bitmap[idx] &= ~(1 << bit);\
+	} while (0)
+
+#define SXE_STRIP_BITMAP_GET(h, q, r) \
+	do {\
+		const typeof(h) _sxe_h = (h); \
+		const typeof(q) _sxe_q = (q); \
+		u32 idx = (_sxe_q) / (sizeof((_sxe_h)->strip_bitmap[0]) * BYTE_BIT_NUM); \
+		u32 bit = (_sxe_q) % (sizeof((_sxe_h)->strip_bitmap[0]) * BYTE_BIT_NUM); \
+		(r) = (_sxe_h)->strip_bitmap[idx] >> bit & 1;\
+	} while (0)
+
+static s32 sxe_get_mac_addr_from_fw(struct sxe_adapter *adapter,
+						u8 *mac_addr)
+{
+	s32 ret;
+	struct sxe_default_mac_addr_resp mac;
+	struct sxe_hw *hw = &adapter->hw;
+
+	/* Get default mac address from firmware */
+	ret = sxe_driver_cmd_trans(hw, SXE_CMD_R0_MAC_GET, NULL, 0,
+				(void *)&mac, sizeof(mac));
+	if (ret) {
+		LOG_ERROR_BDF("hdc trans failed ret=%d, cmd:mac addr get", ret);
+		ret = -EIO;
+	} else {
+		memcpy(mac_addr, mac.addr, SXE_MAC_ADDR_LEN);
+	}
+
+	return ret;
+}
+
+static void sxe_default_mac_addr_get(struct sxe_adapter *adapter)
+{
+	s32 ret;
+	struct rte_ether_addr mac_addr = { {0} };
+	u8 *addr;
+
+	UNUSED(addr);
+	ret = sxe_get_mac_addr_from_fw(adapter, mac_addr.addr_bytes);
+	addr = mac_addr.addr_bytes;
+	if (ret || !rte_is_valid_assigned_ether_addr(&mac_addr)) {
+		LOG_DEBUG("invalid default mac addr:" RTE_ETHER_ADDR_PRT_FMT " result:%d",
+					addr[0], addr[1], addr[2], addr[3], addr[4], addr[5], ret);
+		return;
+	}
+
+	LOG_DEBUG("default mac addr = " RTE_ETHER_ADDR_PRT_FMT "", addr[0], addr[1], addr[2],
+				addr[3], addr[4], addr[5]);
+	rte_ether_addr_copy(&mac_addr, &adapter->mac_filter_ctxt.def_mac_addr);
+	rte_ether_addr_copy(&mac_addr, &adapter->mac_filter_ctxt.fc_mac_addr);
+}
+
+s32 sxe_mac_addr_init(struct rte_eth_dev *eth_dev)
+{
+	struct sxe_adapter *adapter = eth_dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+	s32 ret = 0;
+	u8 rar_idx;
+
+	eth_dev->data->mac_addrs = rte_zmalloc("sxe",
+				RTE_ETHER_ADDR_LEN * SXE_UC_ENTRY_NUM_MAX, 0);
+	if (eth_dev->data->mac_addrs == NULL) {
+		LOG_ERROR("mac addr allocate %u B fail.",
+			RTE_ETHER_ADDR_LEN * SXE_UC_ENTRY_NUM_MAX);
+		ret = -ENOMEM;
+		goto l_out;
+	}
+
+	eth_dev->data->hash_mac_addrs = rte_zmalloc("sxe",
+				RTE_ETHER_ADDR_LEN * SXE_UTA_ENTRY_NUM_MAX, 0);
+	if (eth_dev->data->hash_mac_addrs == NULL) {
+		LOG_ERROR("uta table allocate %u B fail.",
+			RTE_ETHER_ADDR_LEN * SXE_UTA_ENTRY_NUM_MAX);
+		ret = -ENOMEM;
+		goto l_free_mac_addr;
+	}
+
+	adapter->mac_filter_ctxt.uc_addr_table = rte_zmalloc("sxe",
+		sizeof(struct sxe_uc_addr_table) * SXE_UC_ENTRY_NUM_MAX, 0);
+	if (adapter->mac_filter_ctxt.uc_addr_table == NULL) {
+		LOG_ERROR("uc table allocate %u B fail.",
+			sizeof(struct sxe_uc_addr_table) * SXE_UC_ENTRY_NUM_MAX);
+		ret = -ENOMEM;
+		goto l_free_hash_mac;
+	}
+
+	sxe_default_mac_addr_get(adapter);
+
+	rte_ether_addr_copy(&adapter->mac_filter_ctxt.def_mac_addr,
+				eth_dev->data->mac_addrs);
+
+	rte_ether_addr_copy(&adapter->mac_filter_ctxt.def_mac_addr,
+				&adapter->mac_filter_ctxt.cur_mac_addr);
+
+	rar_idx = sxe_sw_uc_entry_add(eth_dev, 0, adapter->mac_filter_ctxt.def_mac_addr.addr_bytes);
+
+#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SRIOV
+	sxe_hw_uc_addr_add(hw, rar_idx,
+			adapter->mac_filter_ctxt.def_mac_addr.addr_bytes,
+			sxe_vf_num_get(eth_dev));
+#else
+	sxe_hw_uc_addr_add(hw, rar_idx,
+		adapter->mac_filter_ctxt.def_mac_addr.addr_bytes,
+		0);
+#endif
+
+l_out:
+	return ret;
+
+l_free_hash_mac:
+	rte_free(eth_dev->data->hash_mac_addrs);
+	eth_dev->data->hash_mac_addrs = NULL;
+
+l_free_mac_addr:
+	rte_free(eth_dev->data->mac_addrs);
+	eth_dev->data->mac_addrs = NULL;
+	goto l_out;
+}
+
+s32 sxe_mac_addr_add(struct rte_eth_dev *dev,
+				 struct rte_ether_addr *mac_addr,
+				 u32 index, u32 pool)
+{
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+	s32 ret;
+	u8 *addr;
+	u8 rar_idx = sxe_sw_uc_entry_add(dev, index, mac_addr->addr_bytes);
+
+	UNUSED(pool);
+	ret = sxe_hw_uc_addr_add(hw, rar_idx,
+					mac_addr->addr_bytes, sxe_vf_num_get(dev));
+
+	addr = mac_addr->addr_bytes;
+	if (ret) {
+		LOG_ERROR("rar_idx:%u pool:%u mac_addr:" RTE_ETHER_ADDR_PRT_FMT "add fail.(err:%d)",
+				rar_idx, pool,
+				addr[0], addr[1], addr[2], addr[3],
+				addr[4], addr[5], ret);
+		goto l_out;
+	}
+
+	sxe_hw_mac_reuse_add(dev, mac_addr->addr_bytes, rar_idx);
+
+	sxe_vf_promisc_mac_update(dev, rar_idx);
+
+	PMD_LOG_INFO(DRV, "rar_idx:%u pool:%u mac_addr:" RTE_ETHER_ADDR_PRT_FMT " add done",
+			rar_idx, sxe_vf_num_get(dev),
+			addr[0], addr[1], addr[2],
+			addr[3], addr[4], addr[5]);
+
+l_out:
+	return ret;
+}
+
+void sxe_mac_addr_remove(struct rte_eth_dev *dev, u32 index)
+{
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+	s32 ret;
+	u8 rar_idx = sxe_sw_uc_entry_del(adapter, index);
+	u8 *mac_addr;
+	u8 pool_idx;
+
+#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SRIOV
+	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+
+	pool_idx = pci_dev->max_vfs;
+#else
+	pool_idx = 0;
+#endif
+
+	ret = sxe_hw_uc_addr_del(hw, rar_idx);
+	if (ret) {
+		PMD_LOG_ERR(DRV, "rar_idx:%u remove fail.(err:%d)",
+				rar_idx, ret);
+		return;
+	}
+
+	mac_addr = dev->data->mac_addrs[rar_idx].addr_bytes;
+	sxe_hw_mac_reuse_del(dev, dev->data->mac_addrs[rar_idx].addr_bytes,
+			pool_idx, rar_idx);
+
+	sxe_vf_promisc_mac_update_all(dev);
+
+	PMD_LOG_INFO(DRV, "rar_idx:%u mac_addr:" RTE_ETHER_ADDR_PRT_FMT " remove done",
+			rar_idx,
+			mac_addr[0], mac_addr[1], mac_addr[2],
+			mac_addr[3], mac_addr[4], mac_addr[5]);
+}
+
+void sxe_fc_mac_addr_set(struct sxe_adapter *adapter)
+{
+	struct sxe_hw *hw = &adapter->hw;
+
+	sxe_hw_fc_mac_addr_set(hw,
+			adapter->mac_filter_ctxt.fc_mac_addr.addr_bytes);
+}
+
+s32 sxe_mac_addr_set(struct rte_eth_dev *dev,
+				 struct rte_ether_addr *mac_addr)
+{
+	u8 pool_idx;
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	u8 *addr = mac_addr->addr_bytes;
+
+	sxe_mac_addr_remove(dev, 0);
+
+#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SRIOV
+	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+
+	pool_idx = pci_dev->max_vfs;
+#else
+	pool_idx = 0;
+#endif
+
+	sxe_mac_addr_add(dev, mac_addr, 0, pool_idx);
+	rte_ether_addr_copy(mac_addr, &adapter->mac_filter_ctxt.fc_mac_addr);
+
+	sxe_fc_mac_addr_set(adapter);
+
+	PMD_LOG_INFO(DRV, "pool:%u mac_addr:" RTE_ETHER_ADDR_PRT_FMT " set to be cur mac addr done",
+			pool_idx, addr[0], addr[1], addr[2],
+			addr[3], addr[4], addr[5]);
+
+	return 0;
+}
+
+static void sxe_hash_mac_addr_parse(u8 *mac_addr, u16 *reg_idx,
+						u16 *bit_idx)
+{
+	u16 extracted;
+
+	extracted = ((mac_addr[4] >> 4) |
+			(((u16)mac_addr[5]) << 4));
+
+	extracted &= SXE_MAC_ADDR_EXTRACT_MASK;
+
+	*reg_idx = (extracted >> SXE_MAC_ADDR_SHIFT) & SXE_MAC_ADDR_REG_MASK;
+
+	*bit_idx = extracted & SXE_MAC_ADDR_BIT_MASK;
+
+	PMD_LOG_DEBUG(DRV, "mac_addr:" RTE_ETHER_ADDR_PRT_FMT " hash reg_idx:%u bit_idx:%u",
+			 mac_addr[0], mac_addr[1], mac_addr[2], mac_addr[3],
+			 mac_addr[4], mac_addr[5], *reg_idx, *bit_idx);
+}
diff --git a/drivers/net/sxe/pf/sxe_filter.h b/drivers/net/sxe/pf/sxe_filter.h
new file mode 100644
index 0000000000..1f103f978d
--- /dev/null
+++ b/drivers/net/sxe/pf/sxe_filter.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+
+#ifndef __SXE_FILTER_H__
+#define __SXE_FILTER_H__
+
+#include <rte_ether.h>
+#include <ethdev_driver.h>
+#include "sxe_types.h"
+#include "sxe_hw.h"
+
+struct sxe_adapter;
+
+#define BYTE_BIT_NUM   8
+
+#define SXE_VLAN_STRIP_BITMAP_SIZE	\
+		RTE_ALIGN((SXE_HW_TXRX_RING_NUM_MAX / (sizeof(u32) * BYTE_BIT_NUM)), \
+		sizeof(u32))
+
+struct sxe_mac_filter_context {
+	struct rte_ether_addr def_mac_addr;
+	struct rte_ether_addr cur_mac_addr;
+
+	struct rte_ether_addr fc_mac_addr;
+
+	bool promiscuous_mode;
+	u32 uta_used_count;
+	u32 uta_hash_table[SXE_UTA_ENTRY_NUM_MAX];
+
+	u32 mta_hash_table[SXE_MTA_ENTRY_NUM_MAX];
+	struct sxe_uc_addr_table *uc_addr_table;
+};
+
+s32 sxe_mac_addr_init(struct rte_eth_dev *eth_dev);
+
+s32 sxe_mac_addr_add(struct rte_eth_dev *dev,
+				 struct rte_ether_addr *mac_addr,
+				 u32 rar_idx, u32 pool);
+
+void sxe_mac_addr_remove(struct rte_eth_dev *dev, u32 rar_idx);
+
+s32 sxe_mac_addr_set(struct rte_eth_dev *dev,
+				 struct rte_ether_addr *mac_addr);
+
+s32 sxe_set_mc_addr_list(struct rte_eth_dev *dev,
+			  struct rte_ether_addr *mc_addr_list,
+			  u32 nb_mc_addr);
+
+void sxe_fc_mac_addr_set(struct sxe_adapter *adapter);
+
+#endif
diff --git a/drivers/net/sxe/pf/sxe_flow_ctrl.c b/drivers/net/sxe/pf/sxe_flow_ctrl.c
new file mode 100644
index 0000000000..80f97ce15d
--- /dev/null
+++ b/drivers/net/sxe/pf/sxe_flow_ctrl.c
@@ -0,0 +1,98 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+
+#include "sxe.h"
+#include "sxe_logs.h"
+#include "sxe_hw.h"
+#include "sxe_flow_ctrl.h"
+#include "sxe_phy.h"
+#include "sxe_compat_version.h"
+
+s32 sxe_flow_ctrl_enable(struct rte_eth_dev *dev)
+{
+	s32 ret = 0;
+	struct sxe_adapter *adapter = dev->data->dev_private;
+
+	ret = sxe_fc_enable(adapter);
+	PMD_LOG_DEBUG(INIT, "fc enable");
+
+	return ret;
+}
+
+s32 sxe_flow_ctrl_get(struct rte_eth_dev *dev,
+					struct rte_eth_fc_conf *fc_conf)
+{
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+	bool rx_pause_on;
+	bool tx_pause_on;
+
+	fc_conf->pause_time = sxe_hw_fc_pause_time_get(hw);
+	fc_conf->high_water = sxe_hw_fc_tc_high_water_mark_get(hw, 0);
+	fc_conf->low_water = sxe_hw_fc_tc_low_water_mark_get(hw, 0);
+	fc_conf->send_xon = sxe_hw_fc_send_xon_get(hw);
+	fc_conf->autoneg = !sxe_hw_is_fc_autoneg_disabled(hw);
+
+	fc_conf->mac_ctrl_frame_fwd = 1;
+
+	sxe_hw_fc_status_get(hw, &rx_pause_on, &tx_pause_on);
+
+	if (rx_pause_on && tx_pause_on)
+		fc_conf->mode = RTE_ETH_FC_FULL;
+	else if (rx_pause_on)
+		fc_conf->mode = RTE_ETH_FC_RX_PAUSE;
+	else if (tx_pause_on)
+		fc_conf->mode = RTE_ETH_FC_TX_PAUSE;
+	else
+		fc_conf->mode = RTE_ETH_FC_NONE;
+
+	return 0;
+}
+
+s32 sxe_flow_ctrl_set(struct rte_eth_dev *dev,
+					struct rte_eth_fc_conf *fc_conf)
+{
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+	s32 ret;
+	u32 rx_buf_size;
+	u32 max_high_water;
+	enum sxe_fc_mode rte_2_sxe_fcmode[] = {
+		SXE_FC_NONE,
+		SXE_FC_RX_PAUSE,
+		SXE_FC_TX_PAUSE,
+		SXE_FC_FULL,
+	};
+
+	PMD_INIT_FUNC_TRACE();
+
+	rx_buf_size = sxe_hw_rx_pkt_buf_size_get(hw, 0);
+	PMD_LOG_DEBUG(INIT, "Rx packet buffer size = 0x%x", rx_buf_size);
+
+	max_high_water = (rx_buf_size -
+			RTE_ETHER_MAX_LEN) >> SXE_RX_PKT_BUF_SIZE_SHIFT;
+	if (fc_conf->high_water > max_high_water ||
+		fc_conf->high_water < fc_conf->low_water) {
+		PMD_LOG_ERR(INIT, "Invalid high/low water setup value in KB");
+		PMD_LOG_ERR(INIT, "High_water must <= 0x%x", max_high_water);
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	sxe_hw_fc_requested_mode_set(hw, rte_2_sxe_fcmode[fc_conf->mode]);
+	sxe_hw_fc_pause_time_set(hw, fc_conf->pause_time);
+	sxe_hw_fc_tc_high_water_mark_set(hw, 0, fc_conf->high_water);
+	sxe_hw_fc_tc_low_water_mark_set(hw, 0, fc_conf->low_water);
+	sxe_hw_fc_send_xon_set(hw, fc_conf->send_xon);
+	sxe_hw_fc_autoneg_disable_set(hw, !fc_conf->autoneg);
+
+	ret = sxe_flow_ctrl_enable(dev);
+	if (ret < 0) {
+		PMD_LOG_ERR(INIT, "sxe_flow_ctrl_enable = 0x%x", ret);
+		ret = -EIO;
+	}
+
+l_end:
+	return ret;
+}
diff --git a/drivers/net/sxe/pf/sxe_flow_ctrl.h b/drivers/net/sxe/pf/sxe_flow_ctrl.h
new file mode 100644
index 0000000000..fb124b11bd
--- /dev/null
+++ b/drivers/net/sxe/pf/sxe_flow_ctrl.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+
+#ifndef __SXE_FLOW_CTRL_H__
+#define __SXE_FLOW_CTRL_H__
+
+s32 sxe_flow_ctrl_enable(struct rte_eth_dev *dev);
+
+s32 sxe_flow_ctrl_get(struct rte_eth_dev *dev,
+					struct rte_eth_fc_conf *fc_conf);
+
+s32 sxe_flow_ctrl_set(struct rte_eth_dev *dev,
+					struct rte_eth_fc_conf *fc_conf);
+
+#endif
diff --git a/drivers/net/sxe/pf/sxe_irq.c b/drivers/net/sxe/pf/sxe_irq.c
index de7fc210f6..217048b8a8 100644
--- a/drivers/net/sxe/pf/sxe_irq.c
+++ b/drivers/net/sxe/pf/sxe_irq.c
@@ -20,6 +20,7 @@
 #include "sxe_queue.h"
 #include "sxe_errno.h"
 #include "sxe_compat_version.h"
+#include "sxe_vf.h"
 
 #define SXE_LINK_DOWN_TIMEOUT 4000
 #define SXE_LINK_UP_TIMEOUT   1000
@@ -33,6 +34,119 @@
 
 #define SXE_RX_VEC_BASE		  RTE_INTR_VEC_RXTX_OFFSET
 
+static void sxe_link_info_output(struct rte_eth_dev *dev)
+{
+	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_eth_link link;
+
+	rte_eth_linkstatus_get(dev, &link);
+
+	PMD_LOG_DEBUG(DRV, "port:%d link status:%s speed %u Mbps %s",
+				(u16)(dev->data->port_id),
+				link.link_status ? "up" : "down",
+				link.link_speed,
+				(link.link_duplex == RTE_ETH_LINK_FULL_DUPLEX) ?
+				"full-duplex" : "half-duplex");
+
+	PMD_LOG_DEBUG(DRV, "pci dev: " PCI_PRI_FMT,
+				pci_dev->addr.domain,
+				pci_dev->addr.bus,
+				pci_dev->addr.devid,
+				pci_dev->addr.function);
+}
+
+void sxe_event_irq_delayed_handler(void *param)
+{
+	struct rte_eth_dev *eth_dev = (struct rte_eth_dev *)param;
+	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct rte_intr_handle *intr_handle = SXE_PCI_INTR_HANDLE(pci_dev);
+	struct sxe_adapter *adapter = eth_dev->data->dev_private;
+	struct sxe_irq_context *irq = &adapter->irq_ctxt;
+	struct sxe_hw *hw = &adapter->hw;
+	u32 eicr;
+
+	rte_spinlock_lock(&adapter->irq_ctxt.event_irq_lock);
+
+	sxe_hw_all_irq_disable(hw);
+
+	eicr = sxe_hw_irq_cause_get(hw);
+	PMD_LOG_DEBUG(DRV, "delay handler eicr:0x%x action:0x%x",
+			   eicr, irq->action);
+
+	eicr &= 0xFFFF0000;
+	if (rte_atomic_load_explicit(&adapter->link_thread_running, rte_memory_order_seq_cst) &&
+		(eicr & SXE_EICR_LSC)) {
+		eicr &= ~SXE_EICR_LSC;
+		PMD_LOG_DEBUG(DRV, "delay handler keep lsc irq");
+	}
+	sxe_hw_pending_irq_write_clear(hw, eicr);
+
+	rte_spinlock_unlock(&adapter->irq_ctxt.event_irq_lock);
+
+#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SRIOV
+	if (eicr & SXE_EICR_MAILBOX)
+		sxe_mbx_irq_handler(eth_dev);
+#endif
+
+	if (irq->action & SXE_IRQ_LINK_UPDATE) {
+		sxe_link_update(eth_dev, 0);
+		sxe_link_info_output(eth_dev);
+		sxe_eth_dev_callback_process(eth_dev, RTE_ETH_EVENT_INTR_LSC, NULL);
+
+		irq->action &= ~SXE_IRQ_LINK_UPDATE;
+	}
+
+	irq->enable_mask |= SXE_EIMS_LSC;
+	PMD_LOG_DEBUG(DRV, "irq enable mask:0x%x", irq->enable_mask);
+
+	rte_spinlock_lock(&adapter->irq_ctxt.event_irq_lock);
+	sxe_hw_specific_irq_enable(hw, irq->enable_mask);
+	rte_spinlock_unlock(&adapter->irq_ctxt.event_irq_lock);
+
+	rte_intr_ack(intr_handle);
+}
+
+static void sxe_lsc_irq_handler(struct rte_eth_dev *eth_dev)
+{
+	struct rte_eth_link link;
+	struct sxe_adapter *adapter = eth_dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+	struct sxe_irq_context *irq = &adapter->irq_ctxt;
+	u64 timeout;
+	bool link_up;
+
+	rte_eth_linkstatus_get(eth_dev, &link);
+
+	link_up = sxe_hw_is_link_state_up(hw);
+
+	if (!link.link_status && !link_up) {
+		PMD_LOG_DEBUG(DRV, "link change irq, down->down, do nothing.");
+		return;
+	}
+
+	if (irq->to_pcs_init) {
+		PMD_LOG_DEBUG(DRV, "to set pcs init, do nothing.");
+		return;
+	}
+
+	PMD_LOG_INFO(DRV, "link change irq handler start");
+	sxe_link_update(eth_dev, 0);
+	sxe_link_info_output(eth_dev);
+
+	timeout = link.link_status ? SXE_LINK_DOWN_TIMEOUT :
+					SXE_LINK_UP_TIMEOUT;
+
+	if (rte_eal_alarm_set(timeout * 1000,
+				  sxe_event_irq_delayed_handler,
+				  (void *)eth_dev) < 0) {
+		PMD_LOG_ERR(DRV, "submit event irq delay handle fail.");
+	} else {
+		irq->enable_mask &= ~SXE_EIMS_LSC;
+	}
+
+	PMD_LOG_INFO(DRV, "link change irq handler end");
+}
+
 static s32 sxe_event_irq_action(struct rte_eth_dev *eth_dev)
 {
 	struct sxe_adapter *adapter = eth_dev->data->dev_private;
@@ -40,9 +154,19 @@ static s32 sxe_event_irq_action(struct rte_eth_dev *eth_dev)
 
 	PMD_LOG_DEBUG(DRV, "event irq action type %d", irq->action);
 
+#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SRIOV
+	/* mailbox irq handler */
+	if (irq->action & SXE_IRQ_MAILBOX) {
+		sxe_mbx_irq_handler(eth_dev);
+		irq->action &= ~SXE_IRQ_MAILBOX;
+	}
+#endif
+
 	/* lsc irq handler */
-	if (irq->action & SXE_IRQ_LINK_UPDATE)
+	if (irq->action & SXE_IRQ_LINK_UPDATE) {
+		sxe_lsc_irq_handler(eth_dev);
 		PMD_LOG_INFO(DRV, "link change irq");
+	}
 
 	return 0;
 }
@@ -94,6 +218,23 @@ void sxe_irq_init(struct rte_eth_dev *eth_dev)
 				   sxe_event_irq_handler, eth_dev);
 
 	rte_spinlock_init(&adapter->irq_ctxt.event_irq_lock);
+
+#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SRIOV
+	struct sxe_irq_context *irq = &adapter->irq_ctxt;
+	struct sxe_hw *hw = &adapter->hw;
+	u32 gpie = 0;
+
+	if (irq_handle->type == RTE_INTR_HANDLE_UIO ||
+		irq_handle->type == RTE_INTR_HANDLE_VFIO_MSIX) {
+		gpie = sxe_hw_irq_general_reg_get(hw);
+
+		gpie |= SXE_GPIE_MSIX_MODE | SXE_GPIE_OCD;
+		sxe_hw_irq_general_reg_set(hw, gpie);
+	}
+	rte_intr_enable(irq_handle);
+
+	sxe_hw_specific_irq_enable(hw, irq->enable_mask);
+#endif
 }
 
 static s32 sxe_irq_general_config(struct rte_eth_dev *dev)
diff --git a/drivers/net/sxe/pf/sxe_main.c b/drivers/net/sxe/pf/sxe_main.c
index 2df467b9cd..1abd0303f3 100644
--- a/drivers/net/sxe/pf/sxe_main.c
+++ b/drivers/net/sxe/pf/sxe_main.c
@@ -154,6 +154,8 @@ s32 sxe_hw_reset(struct sxe_hw *hw)
 
 void sxe_hw_start(struct sxe_hw *hw)
 {
+	sxe_fc_autoneg_localcap_set(hw);
+
 	hw->mac.auto_restart = true;
 	PMD_LOG_INFO(INIT, "auto_restart:%u.", hw->mac.auto_restart);
 }
diff --git a/drivers/net/sxe/pf/sxe_phy.c b/drivers/net/sxe/pf/sxe_phy.c
new file mode 100644
index 0000000000..7b10eec7f5
--- /dev/null
+++ b/drivers/net/sxe/pf/sxe_phy.c
@@ -0,0 +1,932 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+#include <ethdev_driver.h>
+#include <dev_driver.h>
+#include <rte_cycles.h>
+#include <rte_net.h>
+
+#include "sxe.h"
+#include "sxe_hw.h"
+#include "sxe_phy.h"
+#include "drv_msg.h"
+#include "sxe_phy.h"
+#include "sxe_logs.h"
+#include "sxe_errno.h"
+#include "sxe_ethdev.h"
+#include "sxe_filter.h"
+#include "sxe_pmd_hdc.h"
+#include "sxe_filter.h"
+#include "sxe_compat_version.h"
+
+#define SXE_WAIT_LINK_UP_FAILED	1
+#define SXE_WARNING_TIMEOUT	9000
+#define SXE_CHG_SFP_RATE_MS	 40
+#define SXE_1G_WAIT_PCS_MS	  100
+#define SXE_10G_WAIT_PCS_MS	 100
+#define SXE_HZ_TRANSTO_MS	   1000
+#define SXE_AN_COMPLETE_TIME	5
+#define SXE_10G_WAIT_13_TIME	13
+#define SXE_10G_WAIT_5_TIME	 5
+
+static uint32_t sxe_setup_link_thread_handler(void *param)
+{
+	s32 ret;
+	struct rte_eth_dev *dev = (struct rte_eth_dev *)param;
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_irq_context *irq = &adapter->irq_ctxt;
+	u32 allowed_speeds = 0;
+	u32 conf_speeds = 0;
+	u32 speed = 0;
+	bool autoneg = false;
+
+	rte_thread_detach(rte_thread_self());
+
+	sxe_sfp_link_capabilities_get(adapter, &allowed_speeds, &autoneg);
+
+	sxe_conf_speed_get(dev, &conf_speeds);
+
+	speed = (conf_speeds & allowed_speeds) ? (conf_speeds & allowed_speeds) :
+		allowed_speeds;
+
+	if (adapter->phy_ctxt.sfp_info.multispeed_fiber)
+		ret = sxe_multispeed_sfp_link_configure(dev, speed, true);
+	else
+		ret = sxe_sfp_link_configure(dev);
+	if (ret)
+		PMD_LOG_ERR(INIT, "link setup failed, ret=%d", ret);
+
+	irq->action &= ~SXE_IRQ_LINK_CONFIG;
+	rte_atomic_store_explicit(&adapter->link_thread_running, 0, rte_memory_order_seq_cst);
+
+	return 0;
+}
+
+void sxe_wait_setup_link_complete(struct rte_eth_dev *dev,
+						uint32_t timeout_ms)
+{
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	uint32_t timeout = timeout_ms ? timeout_ms : SXE_WARNING_TIMEOUT;
+
+	while (rte_atomic_load_explicit(&adapter->link_thread_running,
+		rte_memory_order_seq_cst)) {
+		rte_delay_us_sleep(1000);
+		timeout--;
+
+		if (timeout_ms) {
+			if (!timeout)
+				return;
+
+		} else if (!timeout) {
+			timeout = SXE_WARNING_TIMEOUT;
+			PMD_LOG_ERR(INIT, "link thread not complete too long time!");
+		}
+	}
+}
+
+static s32 sxe_an_cap_get(struct sxe_adapter *adapter, sxe_an_cap_s *an_cap)
+{
+	s32 ret;
+	struct sxe_hw *hw = &adapter->hw;
+
+	ret = sxe_driver_cmd_trans(hw, SXE_CMD_AN_CAP_GET,
+				NULL, 0,
+				(void *)an_cap, sizeof(*an_cap));
+	if (ret)
+		PMD_LOG_ERR(INIT, "hdc trans failed ret=%d, cmd:negotiaton cap get", ret);
+
+	return ret;
+}
+
+s32 sxe_link_update(struct rte_eth_dev *dev, int wait_to_complete)
+{
+	u32 i;
+	bool link_up, orig_link_up;
+	struct rte_eth_link link;
+	sxe_an_cap_s an_cap;
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_irq_context *irq = &adapter->irq_ctxt;
+	sxe_link_speed link_speed = SXE_LINK_SPEED_UNKNOWN;
+
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -1;
+
+	PMD_LOG_INFO(INIT, "link update start...");
+
+	memset(&link, 0, sizeof(link));
+	link.link_status = RTE_ETH_LINK_DOWN;
+	link.link_speed  = RTE_ETH_SPEED_NUM_NONE;
+	link.link_duplex = RTE_ETH_LINK_HALF_DUPLEX;
+	link.link_autoneg = !(dev->data->dev_conf.link_speeds &
+						RTE_ETH_LINK_SPEED_FIXED);
+
+	if (irq->action & SXE_IRQ_LINK_CONFIG) {
+		PMD_LOG_INFO(INIT, "other link config thread exist");
+		goto l_end;
+	}
+
+	if (dev->data->dev_conf.intr_conf.lsc)
+		wait_to_complete = 0;
+
+	sxe_link_info_get(adapter, &link_speed, &orig_link_up);
+	sxe_link_info_get(adapter, &link_speed, &link_up);
+
+	if (orig_link_up != link_up) {
+		PMD_LOG_INFO(INIT, "link status %s to %s",
+			(orig_link_up ? "up" : "down"),
+			(link_up ? "up" : "down"));
+	}
+
+	if (wait_to_complete) {
+		for (i = 0; i < SXE_LINK_UP_TIME; i++) {
+			if (link_up)
+				break;
+
+			rte_delay_us_sleep(100000);
+
+			sxe_link_info_get(adapter, &link_speed, &link_up);
+		}
+	}
+
+	if (!link_up) {
+		sxe_wait_setup_link_complete(dev, 0);
+		if (!rte_atomic_exchange_explicit(&adapter->link_thread_running, 1,
+				rte_memory_order_seq_cst)) {
+			if (rte_atomic_load_explicit(&adapter->is_stopping,
+				rte_memory_order_seq_cst) ||
+				adapter->phy_ctxt.sfp_tx_laser_disabled) {
+				PMD_LOG_INFO(INIT, "not create sxe_setup_link_thread_handler thread, "
+						"tx_laser_disabled %d.",
+						adapter->phy_ctxt.sfp_tx_laser_disabled);
+				rte_atomic_store_explicit(&adapter->link_thread_running, 0,
+					rte_memory_order_seq_cst);
+			} else {
+				irq->action |= SXE_IRQ_LINK_CONFIG;
+				irq->to_pcs_init = true;
+				if (rte_thread_create_internal_control(&adapter->link_thread_tid,
+					"sxe-link-handler",
+					sxe_setup_link_thread_handler, dev) < 0) {
+					PMD_LOG_ERR(INIT,
+						"Create link thread failed!");
+					rte_atomic_store_explicit(&adapter->link_thread_running, 0,
+						rte_memory_order_seq_cst);
+				}
+			}
+		} else {
+			PMD_LOG_ERR(INIT, "other link thread is running now!");
+		}
+		goto l_end;
+	}
+
+	link.link_status = RTE_ETH_LINK_UP;
+	link.link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
+	switch (link_speed) {
+	case SXE_LINK_SPEED_1GB_FULL:
+		link.link_speed = RTE_ETH_SPEED_NUM_1G;
+		if (adapter->phy_ctxt.sfp_tx_laser_disabled) {
+			PMD_LOG_INFO(INIT, "tx laser disabled, link state is down.");
+			link.link_status = RTE_ETH_LINK_DOWN;
+			link.link_speed = RTE_ETH_SPEED_NUM_NONE;
+		} else {
+			for (i = 0; i < SXE_AN_COMPLETE_TIME; i++) {
+				sxe_an_cap_get(adapter, &an_cap);
+				if (an_cap.peer.remote_fault != SXE_REMOTE_UNKNOWN)
+					break;
+				rte_delay_us_sleep(100000);
+			}
+		}
+		break;
+
+	case SXE_LINK_SPEED_10GB_FULL:
+		link.link_speed = RTE_ETH_SPEED_NUM_10G;
+		break;
+	default:
+		link.link_speed = RTE_ETH_SPEED_NUM_UNKNOWN;
+	}
+
+l_end:
+	PMD_LOG_INFO(INIT, "link update end, up=%x, speed=%x",
+						link.link_status, link_speed);
+	return rte_eth_linkstatus_set(dev, &link);
+}
+
+s32 sxe_link_status_update(struct rte_eth_dev *dev)
+{
+	u32 i;
+	bool link_up;
+	struct rte_eth_link link;
+	sxe_an_cap_s an_cap;
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	sxe_link_speed link_speed = SXE_LINK_SPEED_UNKNOWN;
+
+	PMD_LOG_INFO(INIT, "link status update start...");
+
+	memset(&link, 0, sizeof(link));
+	link.link_status = RTE_ETH_LINK_DOWN;
+	link.link_speed  = RTE_ETH_SPEED_NUM_NONE;
+	link.link_duplex = RTE_ETH_LINK_HALF_DUPLEX;
+	link.link_autoneg = !(dev->data->dev_conf.link_speeds &
+						RTE_ETH_LINK_SPEED_FIXED);
+
+	sxe_link_info_get(adapter, &link_speed, &link_up);
+	if (!link_up) {
+		PMD_LOG_INFO(INIT, "link status is down.");
+		goto l_end;
+	}
+
+	link.link_status = RTE_ETH_LINK_UP;
+	link.link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
+	switch (link_speed) {
+	case SXE_LINK_SPEED_1GB_FULL:
+		link.link_speed = RTE_ETH_SPEED_NUM_1G;
+		for (i = 0; i < SXE_AN_COMPLETE_TIME; i++) {
+			sxe_an_cap_get(adapter, &an_cap);
+			if (an_cap.peer.remote_fault != SXE_REMOTE_UNKNOWN)
+				break;
+
+			rte_delay_us_sleep(100000);
+		}
+		break;
+
+	case SXE_LINK_SPEED_10GB_FULL:
+		link.link_speed = RTE_ETH_SPEED_NUM_10G;
+		break;
+	default:
+		link.link_speed = RTE_ETH_SPEED_NUM_UNKNOWN;
+	}
+
+l_end:
+	PMD_LOG_INFO(INIT, "link status update end, up=%x, speed=%x",
+						link.link_status, link_speed);
+	return rte_eth_linkstatus_set(dev, &link);
+}
+
+int sxe_dev_set_link_up(struct rte_eth_dev *dev)
+{
+	struct sxe_adapter *adapter = (struct sxe_adapter *)dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+
+	sxe_sfp_tx_laser_enable(adapter);
+
+	rte_spinlock_lock(&adapter->irq_ctxt.event_irq_lock);
+	sxe_hw_specific_irq_enable(hw, SXE_EIMS_LSC);
+	rte_spinlock_unlock(&adapter->irq_ctxt.event_irq_lock);
+
+	sxe_link_update(dev, 0);
+
+	return 0;
+}
+
+int sxe_dev_set_link_down(struct rte_eth_dev *dev)
+{
+	struct sxe_adapter *adapter = (struct sxe_adapter *)dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+
+	sxe_sfp_tx_laser_disable(adapter);
+
+	rte_spinlock_lock(&adapter->irq_ctxt.event_irq_lock);
+	sxe_hw_specific_irq_disable(hw, SXE_EIMS_LSC);
+	rte_spinlock_unlock(&adapter->irq_ctxt.event_irq_lock);
+
+	sxe_link_update(dev, 0);
+
+	return 0;
+}
+
+
+static s32 sxe_sfp_eeprom_read(struct sxe_adapter *adapter, u16 offset,
+					u16 len, u8 *data)
+{
+	s32 ret;
+	struct sxe_sfp_rw_req req;
+	struct sxe_sfp_read_resp *resp;
+	u16 resp_len = sizeof(struct sxe_sfp_read_resp) + len;
+	struct sxe_hw *hw = &adapter->hw;
+
+	if (!data) {
+		ret = -EINVAL;
+		PMD_LOG_ERR(INIT, "sfp read buff == NULL");
+		goto l_end;
+	}
+
+	if (len > SXE_SFP_EEPROM_SIZE_MAX) {
+		ret = -EINVAL;
+		PMD_LOG_ERR(INIT, "sfp read size[%u] > eeprom max size[%d], ret=%d",
+					len, SXE_SFP_EEPROM_SIZE_MAX, ret);
+		goto l_end;
+	}
+
+	PMD_LOG_INFO(INIT, "sfp read, offset=%u, len=%u", offset, len);
+
+	req.len = len;
+	req.offset = offset;
+
+	resp = malloc(resp_len);
+	if (!resp) {
+		ret = -ENOMEM;
+		PMD_LOG_ERR(INIT, "sfp read, alloc resp mem failed");
+		goto l_end;
+	}
+
+	ret = sxe_driver_cmd_trans(hw, SXE_CMD_SFP_READ,
+				(void *)&req, sizeof(struct sxe_sfp_rw_req),
+				(void *)resp, resp_len);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "sfp read, hdc failed, offset=%u, len=%u, ret=%d",
+					offset, len, ret);
+		ret = -EIO;
+		goto l_free;
+	}
+
+	if (resp->len != len) {
+		ret = -EIO;
+		PMD_LOG_ERR(INIT, "sfp read failed, offset=%u, len=%u", offset, len);
+		goto l_free;
+	}
+
+	memcpy(data, resp->resp, len);
+
+l_free:
+	free(resp);
+
+l_end:
+	return ret;
+}
+
+static s32 sxe_sfp_tx_laser_ctrl(struct sxe_adapter *adapter, bool is_disable)
+{
+	s32 ret;
+	sxe_spp_tx_able_s laser_disable;
+	struct sxe_hw *hw = &adapter->hw;
+
+	laser_disable.is_disable = is_disable;
+	adapter->phy_ctxt.sfp_tx_laser_disabled = is_disable;
+	PMD_LOG_INFO(INIT, "sfp tx laser ctrl start, is_disable=%x", is_disable);
+	ret = sxe_driver_cmd_trans(hw, SXE_CMD_TX_DIS_CTRL,
+				&laser_disable, sizeof(laser_disable),
+				NULL, 0);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "sfp tx laser ctrl failed, ret=%d", ret);
+		goto l_end;
+	}
+
+	PMD_LOG_INFO(INIT, "sfp tx laser ctrl success, is_disable=%x", is_disable);
+
+l_end:
+	return ret;
+}
+
+void sxe_sfp_tx_laser_enable(struct sxe_adapter *adapter)
+{
+	sxe_sfp_tx_laser_ctrl(adapter, false);
+}
+
+void sxe_sfp_tx_laser_disable(struct sxe_adapter *adapter)
+{
+	sxe_sfp_tx_laser_ctrl(adapter, true);
+}
+
+s32 sxe_sfp_reset(struct sxe_adapter *adapter)
+{
+	PMD_LOG_INFO(INIT, "auto_restart:%u.", adapter->hw.mac.auto_restart);
+
+	if (adapter->hw.mac.auto_restart) {
+		sxe_sfp_tx_laser_disable(adapter);
+		sxe_sfp_tx_laser_enable(adapter);
+		adapter->hw.mac.auto_restart = false;
+	}
+
+	return 0;
+}
+
+void sxe_sfp_link_capabilities_get(struct sxe_adapter *adapter, u32 *speed,
+							bool *autoneg)
+{
+	struct sxe_sfp_info *sfp = &adapter->phy_ctxt.sfp_info;
+
+	*speed = 0;
+
+	if (sfp->type == SXE_SFP_TYPE_1G_CU ||
+		sfp->type == SXE_SFP_TYPE_1G_SXLX) {
+		*speed = SXE_LINK_SPEED_1GB_FULL;
+		*autoneg = true;
+		goto l_end;
+	}
+
+	*speed = SXE_LINK_SPEED_10GB_FULL;
+	*autoneg = false;
+
+	if (sfp->multispeed_fiber) {
+		*speed |= SXE_LINK_SPEED_10GB_FULL | SXE_LINK_SPEED_1GB_FULL;
+		*autoneg = true;
+	}
+
+l_end:
+	PMD_LOG_INFO(INIT, "sfp link speed cap=%d", *speed);
+}
+
+s32 sxe_sfp_rate_select(struct sxe_adapter *adapter, sxe_sfp_rate_e rate)
+{
+	s32 ret;
+	sxe_sfp_rate_able_s rate_able;
+	struct sxe_hw *hw = &adapter->hw;
+
+	rate_able.rate = rate;
+	PMD_LOG_INFO(INIT, "sfp tx rate select start, rate=%d", rate);
+	ret = sxe_driver_cmd_trans(hw, SXE_CMD_RATE_SELECT,
+				&rate_able, sizeof(rate_able),
+				NULL, 0);
+	if (ret)
+		PMD_LOG_ERR(INIT, "sfp rate select failed, ret=%d", ret);
+
+	PMD_LOG_INFO(INIT, "sfp tx rate select end, rate=%d", rate);
+
+	return ret;
+}
+
+s32 sxe_pcs_sds_init(struct rte_eth_dev *dev,
+				sxe_pcs_mode_e mode, u32 max_frame)
+{
+	s32 ret;
+	bool keep_crc = false;
+	sxe_pcs_cfg_s pcs_cfg;
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+	struct sxe_irq_context *irq = &adapter->irq_ctxt;
+	struct rte_eth_rxmode *rx_conf = &dev->data->dev_conf.rxmode;
+
+	if (rx_conf->offloads & RTE_ETH_RX_OFFLOAD_KEEP_CRC)
+		keep_crc = true;
+	sxe_hw_crc_strip_config(hw, keep_crc);
+
+	pcs_cfg.mode = mode;
+	pcs_cfg.mtu  = max_frame;
+	sxe_sfp_tx_laser_disable(adapter);
+	ret = sxe_driver_cmd_trans(hw, SXE_CMD_PCS_SDS_INIT,
+				(void *)&pcs_cfg, sizeof(pcs_cfg),
+				NULL, 0);
+	irq->to_pcs_init = false;
+	sxe_sfp_tx_laser_enable(adapter);
+	if (ret) {
+		LOG_ERROR_BDF("hdc trans failed ret=%d, cmd:pcs init", ret);
+		goto l_end;
+	}
+
+	sxe_fc_mac_addr_set(adapter);
+
+	LOG_INFO_BDF("mode:%u max_frame:0x%x pcs sds init done.",
+			 mode, max_frame);
+l_end:
+	return ret;
+}
+
+s32 sxe_conf_speed_get(struct rte_eth_dev *dev, u32 *conf_speeds)
+{
+	s32 ret = 0;
+	u32 *link_speeds;
+	u32 allowed_speeds;
+
+	link_speeds = &dev->data->dev_conf.link_speeds;
+	allowed_speeds = RTE_ETH_LINK_SPEED_1G |
+			RTE_ETH_LINK_SPEED_10G;
+
+	if (((*link_speeds) >> 1) & ~(allowed_speeds >> 1)) {
+		PMD_LOG_ERR(INIT, "invalid link setting, link_speed=%x",
+						*link_speeds);
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	*conf_speeds = SXE_LINK_SPEED_UNKNOWN;
+	if (*link_speeds == RTE_ETH_LINK_SPEED_AUTONEG) {
+		*conf_speeds = SXE_LINK_SPEED_1GB_FULL |
+				 SXE_LINK_SPEED_10GB_FULL;
+	} else {
+		if (*link_speeds & RTE_ETH_LINK_SPEED_10G)
+			*conf_speeds |= SXE_LINK_SPEED_10GB_FULL;
+
+		if (*link_speeds & RTE_ETH_LINK_SPEED_1G)
+			*conf_speeds |= SXE_LINK_SPEED_1GB_FULL;
+	}
+
+l_end:
+	return ret;
+}
+
+s32 sxe_multispeed_sfp_link_configure(struct rte_eth_dev *dev, u32 speed, bool is_in_thread)
+{
+	s32 ret;
+	bool autoneg, link_up;
+	u32 i, speed_cap, link_speed, speedcnt = 0;
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+	struct sxe_irq_context *irq = &adapter->irq_ctxt;
+	u32 highest_link_speed = SXE_LINK_SPEED_UNKNOWN;
+	u32 frame_size = adapter->mtu + SXE_ETH_DEAD_LOAD;
+	u8 wait_time = is_in_thread ? SXE_10G_WAIT_13_TIME : SXE_10G_WAIT_5_TIME;
+
+	sxe_sfp_link_capabilities_get(adapter, &speed_cap, &autoneg);
+
+	speed &= speed_cap;
+
+	if (speed & SXE_LINK_SPEED_10GB_FULL) {
+		PMD_LOG_DEBUG(INIT, "10G link cfg start");
+		irq->to_pcs_init = true;
+
+		speedcnt++;
+		highest_link_speed = SXE_LINK_SPEED_10GB_FULL;
+
+		ret = sxe_sfp_rate_select(adapter, SXE_SFP_RATE_10G);
+		if (ret) {
+			PMD_LOG_ERR(INIT, "set sfp rate failed, ret=%d", ret);
+			goto l_end;
+		}
+
+		rte_delay_us_sleep((SXE_CHG_SFP_RATE_MS * SXE_HZ_TRANSTO_MS));
+
+		ret = sxe_pcs_sds_init(dev, SXE_PCS_MODE_10GBASE_KR_WO,
+						frame_size);
+		if (ret)
+			goto l_end;
+
+
+		for (i = 0; i < wait_time; i++) {
+			rte_delay_us_sleep((SXE_10G_WAIT_PCS_MS * SXE_HZ_TRANSTO_MS));
+
+			sxe_link_info_get(adapter, &link_speed, &link_up);
+			if (link_up) {
+				PMD_LOG_INFO(INIT, "link cfg end, link up, speed is 10G");
+				goto l_out;
+			}
+		}
+
+		PMD_LOG_WARN(INIT, "10G link cfg failed, retry...");
+	}
+
+	if (speed & SXE_LINK_SPEED_1GB_FULL) {
+		PMD_LOG_DEBUG(INIT, "1G link cfg start");
+		irq->to_pcs_init = true;
+
+		speedcnt++;
+		if (highest_link_speed == SXE_LINK_SPEED_UNKNOWN)
+			highest_link_speed = SXE_LINK_SPEED_1GB_FULL;
+
+		ret = sxe_sfp_rate_select(adapter, SXE_SFP_RATE_1G);
+		if (ret) {
+			PMD_LOG_ERR(INIT, "set sfp rate failed, ret=%d", ret);
+			goto l_end;
+		}
+
+		rte_delay_us_sleep((SXE_CHG_SFP_RATE_MS * SXE_HZ_TRANSTO_MS));
+
+		ret = sxe_pcs_sds_init(dev, SXE_PCS_MODE_1000BASE_KX_W,
+						frame_size);
+		if (ret)
+			goto l_end;
+
+
+		rte_delay_us_sleep(SXE_1G_WAIT_PCS_MS * SXE_HZ_TRANSTO_MS);
+
+		sxe_link_status_update(dev);
+
+		link_up = sxe_hw_is_link_state_up(hw);
+		if (link_up) {
+			PMD_LOG_INFO(INIT, "link cfg end, link up, speed is 1G");
+			goto l_out;
+		}
+
+		PMD_LOG_WARN(INIT, "1G link cfg failed, retry...");
+	}
+
+	if (speedcnt > 1)
+		ret = sxe_multispeed_sfp_link_configure(dev, highest_link_speed, is_in_thread);
+
+l_out:
+
+	adapter->phy_ctxt.autoneg_advertised = 0;
+
+	if (speed & SXE_LINK_SPEED_10GB_FULL)
+		adapter->phy_ctxt.autoneg_advertised |= SXE_LINK_SPEED_10GB_FULL;
+
+	if (speed & SXE_LINK_SPEED_1GB_FULL)
+		adapter->phy_ctxt.autoneg_advertised |= SXE_LINK_SPEED_1GB_FULL;
+
+l_end:
+	return ret;
+}
+
+void sxe_link_info_get(struct sxe_adapter *adapter, u32 *link_speed, bool *link_up)
+{
+	struct sxe_hw *hw = &adapter->hw;
+
+	*link_up = sxe_hw_is_link_state_up(hw);
+	if (false == *link_up) {
+		PMD_LOG_INFO(INIT, "link state =%d, (1=link_up, 0=link_down)",
+								*link_up);
+		*link_speed = SXE_LINK_SPEED_UNKNOWN;
+	} else {
+		*link_speed = sxe_hw_link_speed_get(hw);
+	}
+}
+
+static s32 sxe_sfp_fc_autoneg(struct sxe_adapter *adapter)
+{
+	s32 ret;
+	sxe_an_cap_s an_cap;
+	struct sxe_hw *hw = &adapter->hw;
+
+	ret = sxe_an_cap_get(adapter, &an_cap);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "get auto negotiate capacity failed, ret=%d", ret);
+		goto l_end;
+	}
+
+	if ((an_cap.local.pause_cap & SXE_PAUSE_CAP_SYMMETRIC_PAUSE) &&
+		(an_cap.peer.pause_cap & SXE_PAUSE_CAP_SYMMETRIC_PAUSE)) {
+		if (hw->fc.requested_mode == SXE_FC_FULL) {
+			hw->fc.current_mode = SXE_FC_FULL;
+			PMD_LOG_DEBUG(INIT, "Flow Control = FULL.");
+		} else {
+			hw->fc.current_mode = SXE_FC_RX_PAUSE;
+			PMD_LOG_DEBUG(INIT, "Flow Control=RX PAUSE frames only");
+		}
+	} else if ((an_cap.local.pause_cap == SXE_PAUSE_CAP_ASYMMETRIC_PAUSE) &&
+		(an_cap.peer.pause_cap == SXE_PAUSE_CAP_BOTH_PAUSE)) {
+		hw->fc.current_mode = SXE_FC_TX_PAUSE;
+		PMD_LOG_DEBUG(INIT, "Flow Control = TX PAUSE frames only.");
+	} else if ((an_cap.local.pause_cap == SXE_PAUSE_CAP_BOTH_PAUSE) &&
+		(an_cap.peer.pause_cap == SXE_PAUSE_CAP_ASYMMETRIC_PAUSE)) {
+		hw->fc.current_mode = SXE_FC_RX_PAUSE;
+		PMD_LOG_DEBUG(INIT, "Flow Control = RX PAUSE frames only.");
+	} else {
+		hw->fc.current_mode = SXE_FC_NONE;
+		PMD_LOG_DEBUG(INIT, "Flow Control = NONE.");
+	}
+
+l_end:
+	return ret;
+}
+
+static void sxe_fc_autoneg(struct sxe_adapter *adapter)
+{
+	struct sxe_hw *hw = &adapter->hw;
+
+	s32 ret = -SXE_ERR_FC_NOT_NEGOTIATED;
+	bool link_up;
+	u32 link_speed;
+	if (hw->fc.disable_fc_autoneg) {
+		PMD_LOG_INFO(INIT, "disable fc autoneg");
+		goto l_end;
+	}
+
+	sxe_link_info_get(adapter, &link_speed, &link_up);
+	if (!link_up) {
+		PMD_LOG_INFO(INIT, "link down, don't fc autoneg");
+		goto l_end;
+	}
+
+	if (link_speed != SXE_LINK_SPEED_1GB_FULL) {
+		PMD_LOG_INFO(INIT, "link speed=%x, (0x80=10G, 0x20=1G), "
+			"don't fc autoneg", link_speed);
+		goto l_end;
+	}
+
+	ret = sxe_sfp_fc_autoneg(adapter);
+l_end:
+	if (ret)
+		hw->fc.current_mode = hw->fc.requested_mode;
+}
+
+s32 sxe_fc_enable(struct sxe_adapter *adapter)
+{
+	s32 ret = 0;
+	u32 i;
+	struct sxe_hw *hw = &adapter->hw;
+
+	if (!hw->fc.pause_time) {
+		PMD_LOG_ERR(INIT, "link fc disabled since pause time is 0");
+		ret = -SXE_ERR_INVALID_LINK_SETTINGS;
+		goto l_end;
+	}
+
+	for (i = 0; i < MAX_TRAFFIC_CLASS; i++) {
+		if ((hw->fc.current_mode & SXE_FC_TX_PAUSE) &&
+			hw->fc.high_water[i]) {
+			if (!hw->fc.low_water[i] ||
+				hw->fc.low_water[i] >= hw->fc.high_water[i]) {
+				PMD_LOG_DEBUG(INIT, "invalid water mark configuration, "
+					"tc[%u] low_water=%u, high_water=%u",
+					i, hw->fc.low_water[i],
+					hw->fc.high_water[i]);
+				ret = -SXE_ERR_INVALID_LINK_SETTINGS;
+				goto l_end;
+			}
+		}
+	}
+
+	/* auto negotiation flow control local capability configuration */
+	sxe_fc_autoneg_localcap_set(hw);
+
+	sxe_fc_autoneg(adapter);
+
+	ret = sxe_hw_fc_enable(hw);
+	if (ret)
+		PMD_LOG_ERR(INIT, "link fc enable failed, ret=%d", ret);
+
+l_end:
+	return ret;
+}
+
+s32 sxe_sfp_identify(struct sxe_adapter *adapter)
+{
+	s32 ret;
+	enum sxe_sfp_type sfp_type;
+	u8 sfp_comp_code[SXE_SFP_COMP_CODE_SIZE];
+	struct sxe_sfp_info *sfp = &adapter->phy_ctxt.sfp_info;
+
+	PMD_LOG_INFO(INIT, "sfp identify start");
+
+	ret = sxe_sfp_eeprom_read(adapter, SXE_SFF_BASE_ADDR,
+				SXE_SFP_COMP_CODE_SIZE, sfp_comp_code);
+	if (ret) {
+		sfp_type = SXE_SFP_TYPE_UNKNOWN;
+		PMD_LOG_ERR(INIT, "get sfp identifier failed, ret=%d", ret);
+		goto l_end;
+	}
+
+	PMD_LOG_INFO(INIT, "sfp identifier=%x, cable_technology=%x, "
+			"10GB_code=%x, 1GB_code=%x",
+		sfp_comp_code[SXE_SFF_IDENTIFIER],
+		sfp_comp_code[SXE_SFF_CABLE_TECHNOLOGY],
+		sfp_comp_code[SXE_SFF_10GBE_COMP_CODES],
+		sfp_comp_code[SXE_SFF_1GBE_COMP_CODES]);
+
+	if (sfp_comp_code[SXE_SFF_IDENTIFIER] != SXE_SFF_IDENTIFIER_SFP) {
+		LOG_WARN("sfp type get failed, offset=%d, type=%x",
+			SXE_SFF_IDENTIFIER, sfp_comp_code[SXE_SFF_IDENTIFIER]);
+		sfp_type = SXE_SFP_TYPE_UNKNOWN;
+		ret = -SXE_ERR_SFF_NOT_SUPPORTED;
+		goto l_end;
+	}
+
+	if (sfp_comp_code[SXE_SFF_CABLE_TECHNOLOGY] & SXE_SFF_DA_PASSIVE_CABLE) {
+		sfp_type = SXE_SFP_TYPE_DA_CU;
+	}  else if (sfp_comp_code[SXE_SFF_10GBE_COMP_CODES] &
+		(SXE_SFF_10GBASESR_CAPABLE | SXE_SFF_10GBASELR_CAPABLE)) {
+		sfp_type = SXE_SFP_TYPE_SRLR;
+	} else if (sfp_comp_code[SXE_SFF_1GBE_COMP_CODES] &
+		SXE_SFF_1GBASET_CAPABLE) {
+		sfp_type = SXE_SFP_TYPE_1G_CU;
+	} else if ((sfp_comp_code[SXE_SFF_1GBE_COMP_CODES] &
+		SXE_SFF_1GBASESX_CAPABLE) ||
+		(sfp_comp_code[SXE_SFF_1GBE_COMP_CODES] &
+		SXE_SFF_1GBASELX_CAPABLE)) {
+		sfp_type = SXE_SFP_TYPE_1G_SXLX;
+	} else {
+		sfp_type = SXE_SFP_TYPE_UNKNOWN;
+	}
+
+	sfp->multispeed_fiber = false;
+	if (((sfp_comp_code[SXE_SFF_1GBE_COMP_CODES] &
+			SXE_SFF_1GBASESX_CAPABLE) &&
+		(sfp_comp_code[SXE_SFF_10GBE_COMP_CODES] &
+			SXE_SFF_10GBASESR_CAPABLE)) ||
+		((sfp_comp_code[SXE_SFF_1GBE_COMP_CODES] &
+			SXE_SFF_1GBASELX_CAPABLE) &&
+		(sfp_comp_code[SXE_SFF_10GBE_COMP_CODES] &
+			SXE_SFF_10GBASELR_CAPABLE))) {
+		sfp->multispeed_fiber = true;
+	}
+
+	PMD_LOG_INFO(INIT, "identify sfp, sfp_type=%d, is_multispeed=%x",
+			sfp_type, sfp->multispeed_fiber);
+
+l_end:
+	adapter->phy_ctxt.sfp_info.type = sfp_type;
+	return ret;
+}
+
+s32 sxe_sfp_link_configure(struct rte_eth_dev *dev)
+{
+	s32 ret = 0;
+	bool an;
+	u32 pcs_mode = SXE_PCS_MODE_BUTT;
+	u32 speed;
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	u32 frame_size = adapter->mtu + SXE_ETH_DEAD_LOAD;
+
+	sxe_sfp_link_capabilities_get(adapter, &speed, &an);
+
+	if (speed == SXE_LINK_SPEED_1GB_FULL) {
+		pcs_mode = SXE_PCS_MODE_1000BASE_KX_W;
+		adapter->phy_ctxt.autoneg_advertised = SXE_LINK_SPEED_1GB_FULL;
+	} else if (speed == SXE_LINK_SPEED_10GB_FULL) {
+		pcs_mode = SXE_PCS_MODE_10GBASE_KR_WO;
+		adapter->phy_ctxt.autoneg_advertised = SXE_LINK_SPEED_10GB_FULL;
+	}
+
+	ret = sxe_pcs_sds_init(dev, pcs_mode, frame_size);
+	if (ret)
+		PMD_LOG_ERR(INIT, "pcs sds init failed, ret=%d", ret);
+
+	if (speed == SXE_LINK_SPEED_1GB_FULL)
+		sxe_link_status_update(dev);
+
+	PMD_LOG_INFO(INIT, "link :cfg speed=%x, pcs_mode=%x, atuoreg=%d",
+					speed, pcs_mode, an);
+
+	return ret;
+}
+
+int sxe_get_module_info(struct rte_eth_dev *dev,
+			struct rte_eth_dev_module_info *info)
+{
+	s32 ret;
+	bool page_swap = false;
+	u8 sff8472_rev, addr_mode;
+	struct sxe_adapter *adapter = dev->data->dev_private;
+
+	ret = sxe_sfp_eeprom_read(adapter, SXE_SFF_8472_COMPLIANCE,
+					sizeof(sff8472_rev), &sff8472_rev);
+	if (ret) {
+		ret = -EIO;
+		goto l_end;
+	}
+
+	ret = sxe_sfp_eeprom_read(adapter, SXE_SFF_8472_DIAG_MONITOR_TYPE,
+					sizeof(addr_mode), &addr_mode);
+	if (ret) {
+		ret = -EIO;
+		goto l_end;
+	}
+
+	if (addr_mode & SXE_SFF_ADDRESSING_MODE) {
+		PMD_LOG_ERR(DRV, "address change required to access page 0xA2, "
+			"but not supported. Please report the module "
+			"type to the driver maintainers.");
+		page_swap = true;
+	}
+
+	if (sff8472_rev == SXE_SFF_8472_UNSUP || page_swap ||
+			!(addr_mode & SXE_SFF_DDM_IMPLEMENTED)) {
+		info->type = RTE_ETH_MODULE_SFF_8079;
+		info->eeprom_len = RTE_ETH_MODULE_SFF_8079_LEN;
+	} else {
+		info->type = RTE_ETH_MODULE_SFF_8472;
+		info->eeprom_len = RTE_ETH_MODULE_SFF_8472_LEN;
+	}
+
+	LOG_INFO("sfp support management is %x, eeprom addr mode=%x "
+			"eeprom type=%x, eeprom len=%d",
+		sff8472_rev, addr_mode, info->type, info->eeprom_len);
+
+l_end:
+	return ret;
+}
+
+int sxe_get_module_eeprom(struct rte_eth_dev *dev,
+				struct rte_dev_eeprom_info *info)
+{
+	s32 ret;
+	u8 *data = info->data;
+	struct sxe_adapter *adapter = dev->data->dev_private;
+
+	if (info->length == 0) {
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	ret = sxe_sfp_eeprom_read(adapter, info->offset, info->length, data);
+	if (ret)
+		LOG_ERROR("read sfp failed");
+
+l_end:
+	return ret;
+}
+
+
+static enum sxe_media_type sxe_media_type_get(struct sxe_adapter *adapter)
+{
+	enum sxe_media_type type;
+
+	type = SXE_MEDIA_TYPE_FIBER;
+	adapter->phy_ctxt.is_sfp = true;
+
+	return type;
+}
+
+s32 sxe_phy_init(struct sxe_adapter *adapter)
+{
+	s32 ret = 0;
+	enum sxe_media_type media_type = sxe_media_type_get(adapter);
+
+	if (media_type == SXE_MEDIA_TYPE_FIBER) {
+		ret = sxe_sfp_identify(adapter);
+		if (ret)
+			PMD_LOG_ERR(INIT, "phy identify failed, ret=%d", ret);
+	} else {
+		PMD_LOG_ERR(INIT, "phy init failed, only support SFP.");
+	}
+
+	return ret;
+}
diff --git a/drivers/net/sxe/pf/sxe_phy.h b/drivers/net/sxe/pf/sxe_phy.h
index 2947d88812..a3d7dbf85b 100644
--- a/drivers/net/sxe/pf/sxe_phy.h
+++ b/drivers/net/sxe/pf/sxe_phy.h
@@ -34,5 +34,82 @@
 
 #define SXE_IRQ_LINK_UPDATE	  ((u32)(1 << 0))
 #define SXE_IRQ_LINK_CONFIG	  ((u32)(1 << 3))
+struct sxe_adapter;
+
+enum sxe_media_type {
+	SXE_MEDIA_TYPE_UNKWON = 0,
+	SXE_MEDIA_TYPE_FIBER  = 1,
+};
+
+enum sxe_phy_idx {
+	SXE_SFP_IDX = 0,
+	SXE_PHY_MAX,
+};
+
+enum sxe_sfp_type {
+	SXE_SFP_TYPE_DA_CU	   = 0,
+	SXE_SFP_TYPE_SRLR		= 1,
+	SXE_SFP_TYPE_1G_CU	   = 2,
+	SXE_SFP_TYPE_1G_SXLX	 = 4,
+	SXE_SFP_TYPE_UNKNOWN	 = 0xFFFF,
+};
+
+struct sxe_sfp_info {
+	enum sxe_sfp_type	type;
+	bool			multispeed_fiber;
+};
+
+struct sxe_phy_context {
+	bool is_sfp;
+	bool sfp_tx_laser_disabled;
+	u32  speed;
+	u32  autoneg_advertised;
+	struct sxe_sfp_info sfp_info;
+};
+
+s32 sxe_phy_init(struct sxe_adapter *adapter);
+
+s32 sxe_link_update(struct rte_eth_dev *dev, int wait_to_complete);
+
+s32 sxe_link_status_update(struct rte_eth_dev *dev);
+
+void sxe_sfp_tx_laser_enable(struct sxe_adapter *adapter);
+
+void sxe_sfp_tx_laser_disable(struct sxe_adapter *adapter);
+
+int sxe_dev_set_link_up(struct rte_eth_dev *dev);
+
+int sxe_dev_set_link_down(struct rte_eth_dev *dev);
+
+void sxe_wait_setup_link_complete(struct rte_eth_dev *dev,
+						uint32_t timeout_ms);
+
+int sxe_get_module_info(struct rte_eth_dev *dev,
+			struct rte_eth_dev_module_info *info);
+
+int sxe_get_module_eeprom(struct rte_eth_dev *dev,
+				struct rte_dev_eeprom_info *info);
+s32 sxe_sfp_identify(struct sxe_adapter *adapter);
+s32 sxe_sfp_reset(struct sxe_adapter *adapter);
+
+s32 sxe_pcs_sds_init(struct rte_eth_dev *dev,
+				sxe_pcs_mode_e mode, u32 max_frame);
+
+s32 sxe_sfp_rate_select(struct sxe_adapter *adapter, sxe_sfp_rate_e rate);
+
+s32 sxe_multispeed_sfp_link_configure(struct rte_eth_dev *dev, u32 speed, bool is_in_thread);
+
+s32 sxe_conf_speed_get(struct rte_eth_dev *dev, u32 *conf_speeds);
+
+s32 sxe_fc_enable(struct sxe_adapter *adapter);
+
+void sxe_link_info_get(struct sxe_adapter *adapter, u32 *link_speed, bool *link_up);
+
+void sxe_sfp_link_capabilities_get(struct sxe_adapter *adapter, u32 *speed,
+							bool *autoneg);
+
+s32 sxe_sfp_link_configure(struct rte_eth_dev *dev);
+
+void sxe_mac_configure(struct sxe_adapter *adapter);
 
 #endif
-- 
2.18.2

