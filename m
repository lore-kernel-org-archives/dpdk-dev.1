Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 031FBEF06E2
	for <dpdk-dev@archiver.kernel.org>; Sun,  8 Feb 2026 11:57:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C971D40693;
	Sun,  8 Feb 2026 12:55:48 +0100 (CET)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by mails.dpdk.org (Postfix) with ESMTP id 6C451402ED
 for <dev@dpdk.org>; Sun,  8 Feb 2026 12:55:35 +0100 (CET)
Received: from mail.cstnet.cn (unknown [221.238.36.162])
 by APP-05 (Coremail) with SMTP id zQCowAD3iAyveYhp1svKBw--.57133S9;
 Sun, 08 Feb 2026 19:55:28 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v15 08/13] net/sxe: add dcb function
Date: Sun,  8 Feb 2026 19:55:21 +0800
Message-Id: <20260208115526.146104-8-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20260208115526.146104-1-liujie5@linkdatatechnology.com>
References: <20260208093122.10329-13-liujie5@linkdatatechnology.com>
 <20260208115526.146104-1-liujie5@linkdatatechnology.com>
X-CM-TRANSID: zQCowAD3iAyveYhp1svKBw--.57133S9
X-Coremail-Antispam: 1UD129KBjvAXoWfWFy7ZF1kCF1rCrW3AF4DXFb_yoW5KF1fAo
 WfWrnxJ3W8Ary2grWxW3Z5CFWjvr1j9ay7Jws8ZFsxXw47AF1rZFyUKr47A3Z7Wr10yF15
 Aw1F93y3Aw47WF1kn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UjIYCTnIWjp_UUUOn7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
 j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s0DM28Irc
 Ia0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l
 84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F
 4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4U
 JwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
 IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
 M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0F24lc2
 xSY4AK67AK6r4kMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
 5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXV
 WUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY
 1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
 0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7V
 UjGjg3UUUUU==
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

Add dcb function.

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe/meson.build      |  28 +
 drivers/net/sxe/pf/rte_pmd_sxe.h |   4 +
 drivers/net/sxe/pf/sxe_dcb.c     | 945 +++++++++++++++++++++++++++++++
 drivers/net/sxe/pf/sxe_dcb.h     |  99 ++++
 drivers/net/sxe/pf/sxe_main.c    |   1 +
 drivers/net/sxe/pf/sxe_phy.c     |  34 ++
 drivers/net/sxe/pf/sxe_phy.h     |   2 +
 7 files changed, 1113 insertions(+)
 create mode 100644 drivers/net/sxe/pf/sxe_dcb.c
 create mode 100644 drivers/net/sxe/pf/sxe_dcb.h

diff --git a/drivers/net/sxe/meson.build b/drivers/net/sxe/meson.build
index eab222d7c4..700f331ac5 100644
--- a/drivers/net/sxe/meson.build
+++ b/drivers/net/sxe/meson.build
@@ -5,8 +5,12 @@ if not is_linux or not (dpdk_conf.has('RTE_ARCH_X86_64') or dpdk_conf.has('RTE_A
     reason = 'only supported on x86_64 or arm64 Linux'
     subdir_done()
 endif
+
 cflags += ['-DSXE_DPDK']
 cflags += ['-DSXE_HOST_DRIVER']
+cflags += ['-DSXE_DPDK_L4_FEATURES']
+cflags += ['-DSXE_DPDK_SRIOV']
+cflags += ['-DSXE_DPDK_SIMD']
 
 #subdir('base')
 #objs = [base_objs]
@@ -22,17 +26,41 @@ sources = files(
         'pf/sxe_queue.c',
         'pf/sxe_rx.c',
         'pf/sxe_tx.c',
+        'pf/sxe_stats.c',
         'pf/sxe_pmd_hdc.c',
         'pf/sxe_phy.c',
+        'pf/sxe_ptp.c',
+        'pf/sxe_vf.c',
+        'pf/sxe_dcb.c',
+        'vf/sxevf_main.c',
+        'vf/sxevf_filter.c',
+        'vf/sxevf_irq.c',
+        'vf/sxevf_msg.c',
+        'vf/sxevf_ethdev.c',
+        'vf/sxevf_stats.c',
+        'vf/sxevf_rx.c',
+        'vf/sxevf_tx.c',
+        'vf/sxevf_queue.c',
+        'vf/sxevf_offload.c',
         'base/sxe_queue_common.c',
         'base/sxe_rx_common.c',
         'base/sxe_tx_common.c',
         'base/sxe_offload_common.c',
         'base/sxe_common.c',
         'base/sxe_hw.c',
+        'base/sxevf_hw.c',
 )
 
+testpmd_sources = files('sxe_testpmd.c')
+
+if arch_subdir == 'x86'
+    sources += files('pf/sxe_vec_sse.c')
+elif arch_subdir == 'arm'
+    sources += files('pf/sxe_vec_neon.c')
+endif
+
 includes += include_directories('base')
 includes += include_directories('pf')
+includes += include_directories('vf')
 includes += include_directories('include/sxe/')
 includes += include_directories('include/')
diff --git a/drivers/net/sxe/pf/rte_pmd_sxe.h b/drivers/net/sxe/pf/rte_pmd_sxe.h
index 64c1140490..25e768624f 100644
--- a/drivers/net/sxe/pf/rte_pmd_sxe.h
+++ b/drivers/net/sxe/pf/rte_pmd_sxe.h
@@ -5,10 +5,14 @@
 #ifndef __PMD_SXE_H__
 #define __PMD_SXE_H__
 
+#include <rte_compat.h>
+
 typedef uint8_t		u8;
 typedef uint16_t	u16;
 typedef uint32_t	u32;
 typedef int32_t		s32;
 
 s32 rte_pmd_sxe_tx_loopback_set(u16 port, u8 on);
+__rte_experimental
+s32 rte_pmd_sxe_tc_bw_set(u8 port, u8 tc_num, u8 *bw_weight);
 #endif
diff --git a/drivers/net/sxe/pf/sxe_dcb.c b/drivers/net/sxe/pf/sxe_dcb.c
new file mode 100644
index 0000000000..7e9dc1aea3
--- /dev/null
+++ b/drivers/net/sxe/pf/sxe_dcb.c
@@ -0,0 +1,945 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+
+#include "sxe.h"
+#include "sxe_logs.h"
+#include "sxe_hw.h"
+#include "sxe_phy.h"
+#include "sxe_errno.h"
+#include "sxe_offload.h"
+#include "sxe_ethdev.h"
+#include "sxe_compat_version.h"
+#include "rte_pmd_sxe.h"
+#include <eal_export.h>
+
+#define DCB_RX_CONFIG  1
+#define DCB_TX_CONFIG  1
+
+#define DCB_CREDIT_QUANTUM	64
+#define MAX_CREDIT_REFILL	   511
+#define MAX_CREDIT			  4095
+
+void sxe_dcb_init(struct rte_eth_dev *dev)
+{
+	u8 i;
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_dcb_config *cfg = &adapter->dcb_ctxt.config;
+	struct sxe_tc_config *tc;
+	u8 dcb_max_tc = SXE_DCB_MAX_TRAFFIC_CLASS;
+
+	memset(cfg, 0, sizeof(struct sxe_dcb_config));
+
+	cfg->num_tcs.pg_tcs = dcb_max_tc;
+	cfg->num_tcs.pfc_tcs = dcb_max_tc;
+	for (i = 0; i < dcb_max_tc; i++) {
+		tc = &cfg->tc_config[i];
+		tc->channel[DCB_PATH_TX].bwg_id = i;
+		tc->channel[DCB_PATH_TX].bwg_percent =
+				 (u8)(100 / dcb_max_tc + (i & 1));
+		tc->channel[DCB_PATH_RX].bwg_id = i;
+		tc->channel[DCB_PATH_RX].bwg_percent =
+				 (u8)(100 / dcb_max_tc + (i & 1));
+		tc->pfc_type = pfc_disabled;
+	}
+
+	tc = &cfg->tc_config[0];
+	tc->channel[DCB_PATH_TX].up_to_tc_bitmap = 0xFF;
+	tc->channel[DCB_PATH_RX].up_to_tc_bitmap = 0xFF;
+	for (i = 0; i < MAX_BW_GROUP; i++) {
+		cfg->bwg_link_percent[DCB_PATH_TX][i] = 100;
+		cfg->bwg_link_percent[DCB_PATH_RX][i] = 100;
+	}
+	cfg->rx_pba_config = SXE_DCB_PBA_EQUAL;
+	cfg->pfc_mode_enable = false;
+	cfg->vmdq_active = true;
+	cfg->round_robin_enable = false;
+}
+
+static u8 sxe_dcb_get_tc_from_up(struct sxe_dcb_config *cfg,
+					u8 direction, u8 up)
+{
+	struct sxe_tc_config *tc_config = &cfg->tc_config[0];
+	u8 prio_mask = BIT(up);
+	u8 tc = cfg->num_tcs.pg_tcs;
+
+	if (!tc)
+		goto l_ret;
+
+	for (tc--; tc; tc--) {
+		if (prio_mask & tc_config[tc].channel[direction].up_to_tc_bitmap)
+			break;
+	}
+
+l_ret:
+	LOG_DEBUG("up[%u] to tc[%u]", up, tc);
+	return tc;
+}
+
+static void sxe_dcb_up2tc_map_parse(struct sxe_dcb_config *cfg,
+						u8 direction, u8 *map)
+{
+	u8 up;
+
+	for (up = 0; up < MAX_USER_PRIORITY; up++) {
+		map[up] = sxe_dcb_get_tc_from_up(cfg, direction, up);
+		LOG_DEBUG("up[%u] --- up2tc_map[%u]", up, map[up]);
+	}
+}
+
+s32 sxe_priority_flow_ctrl_set(struct rte_eth_dev *dev,
+					struct rte_eth_pfc_conf *pfc_conf)
+{
+	s32 ret;
+	u32 rx_buf_size;
+	u32 max_high_water;
+	u8 tc_idx;
+	u8  up2tc_map[MAX_USER_PRIORITY] = { 0 };
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+
+	struct sxe_dcb_config *dcb_config = &adapter->dcb_ctxt.config;
+
+	static const enum sxe_fc_mode fcmode[] = {
+		SXE_FC_NONE,
+		SXE_FC_RX_PAUSE,
+		SXE_FC_TX_PAUSE,
+		SXE_FC_FULL,
+	};
+
+	PMD_INIT_FUNC_TRACE();
+
+	sxe_dcb_up2tc_map_parse(dcb_config, DCB_PATH_RX, up2tc_map);
+	tc_idx = up2tc_map[pfc_conf->priority];
+	rx_buf_size = sxe_hw_rx_pkt_buf_size_get(hw, tc_idx);
+	PMD_LOG_DEBUG(INIT, "Rx packet buffer size = 0x%x", rx_buf_size);
+
+	max_high_water = (rx_buf_size -
+			RTE_ETHER_MAX_LEN) >> SXE_RX_PKT_BUF_SIZE_SHIFT;
+	if (pfc_conf->fc.high_water > max_high_water ||
+		pfc_conf->fc.high_water <= pfc_conf->fc.low_water) {
+		PMD_LOG_ERR(INIT, "Invalid high/low water setup value in KB, "
+				"high water=0x%x, low water=0x%x",
+				pfc_conf->fc.high_water, pfc_conf->fc.low_water);
+		PMD_LOG_ERR(INIT, "High_water must <= 0x%x", max_high_water);
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	sxe_hw_fc_requested_mode_set(hw, fcmode[pfc_conf->fc.mode]);
+	sxe_hw_fc_pause_time_set(hw, pfc_conf->fc.pause_time);
+	sxe_hw_fc_send_xon_set(hw, pfc_conf->fc.send_xon);
+	sxe_hw_fc_tc_low_water_mark_set(hw, tc_idx, pfc_conf->fc.low_water);
+	sxe_hw_fc_tc_high_water_mark_set(hw, tc_idx, pfc_conf->fc.high_water);
+
+	ret = sxe_pfc_enable(adapter, tc_idx);
+
+	if (ret == 0 || ret == SXE_ERR_FC_NOT_NEGOTIATED) {
+		PMD_LOG_DEBUG(INIT, "pfc set end ret = %d", ret);
+		ret = 0;
+		goto l_end;
+	}
+
+	PMD_LOG_ERR(INIT, "sxe_dcb_pfc_enable = 0x%x", ret);
+	ret = -EIO;
+l_end:
+	return ret;
+}
+
+s32 sxe_get_dcb_info(struct rte_eth_dev *dev,
+			struct rte_eth_dcb_info *dcb_info)
+{
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_dcb_config *dcb_config = &adapter->dcb_ctxt.config;
+
+	struct sxe_tc_config *tc;
+	struct rte_eth_dcb_tc_queue_mapping *tc_queue;
+	u8 tcs_num;
+	u8 i, j;
+
+	if (dev->data->dev_conf.rxmode.mq_mode & RTE_ETH_MQ_RX_DCB_FLAG)
+		dcb_info->nb_tcs = dcb_config->num_tcs.pg_tcs;
+	else
+		dcb_info->nb_tcs = 1;
+
+	tc_queue = &dcb_info->tc_queue;
+	tcs_num = dcb_info->nb_tcs;
+
+	if (dcb_config->vmdq_active) {
+		struct rte_eth_vmdq_dcb_conf *vmdq_rx_conf =
+				&dev->data->dev_conf.rx_adv_conf.vmdq_dcb_conf;
+		for (i = 0; i < RTE_ETH_DCB_NUM_USER_PRIORITIES; i++)
+			dcb_info->prio_tc[i] = vmdq_rx_conf->dcb_tc[i];
+
+		if (RTE_ETH_DEV_SRIOV(dev).active > 0) {
+			for (j = 0; j < tcs_num; j++) {
+				tc_queue->tc_rxq[0][j].base = j;
+				tc_queue->tc_rxq[0][j].nb_queue = 1;
+				tc_queue->tc_txq[0][j].base = j;
+				tc_queue->tc_txq[0][j].nb_queue = 1;
+			}
+		} else {
+			for (i = 0; i < vmdq_rx_conf->nb_queue_pools; i++) {
+				for (j = 0; j < tcs_num; j++) {
+					tc_queue->tc_rxq[i][j].base =
+						i * tcs_num + j;
+					tc_queue->tc_rxq[i][j].nb_queue = 1;
+					tc_queue->tc_txq[i][j].base =
+						i * tcs_num + j;
+					tc_queue->tc_txq[i][j].nb_queue = 1;
+				}
+			}
+		}
+	} else {
+		struct rte_eth_dcb_rx_conf *rx_conf =
+				&dev->data->dev_conf.rx_adv_conf.dcb_rx_conf;
+		for (i = 0; i < RTE_ETH_DCB_NUM_USER_PRIORITIES; i++)
+			dcb_info->prio_tc[i] = rx_conf->dcb_tc[i];
+
+		if (dcb_info->nb_tcs == RTE_ETH_4_TCS) {
+			for (i = 0; i < dcb_info->nb_tcs; i++) {
+				dcb_info->tc_queue.tc_rxq[0][i].base = i * 32;
+				dcb_info->tc_queue.tc_rxq[0][i].nb_queue = 16;
+			}
+
+			dcb_info->tc_queue.tc_txq[0][0].base = 0;
+			dcb_info->tc_queue.tc_txq[0][1].base = 64;
+			dcb_info->tc_queue.tc_txq[0][2].base = 96;
+			dcb_info->tc_queue.tc_txq[0][3].base = 112;
+			dcb_info->tc_queue.tc_txq[0][0].nb_queue = 64;
+			dcb_info->tc_queue.tc_txq[0][1].nb_queue = 32;
+			dcb_info->tc_queue.tc_txq[0][2].nb_queue = 16;
+			dcb_info->tc_queue.tc_txq[0][3].nb_queue = 16;
+		} else if (dcb_info->nb_tcs == RTE_ETH_8_TCS) {
+			for (i = 0; i < dcb_info->nb_tcs; i++) {
+				dcb_info->tc_queue.tc_rxq[0][i].base = i * 16;
+				dcb_info->tc_queue.tc_rxq[0][i].nb_queue = 16;
+			}
+
+			dcb_info->tc_queue.tc_txq[0][0].base = 0;
+			dcb_info->tc_queue.tc_txq[0][1].base = 32;
+			dcb_info->tc_queue.tc_txq[0][2].base = 64;
+			dcb_info->tc_queue.tc_txq[0][3].base = 80;
+			dcb_info->tc_queue.tc_txq[0][4].base = 96;
+			dcb_info->tc_queue.tc_txq[0][5].base = 104;
+			dcb_info->tc_queue.tc_txq[0][6].base = 112;
+			dcb_info->tc_queue.tc_txq[0][7].base = 120;
+			dcb_info->tc_queue.tc_txq[0][0].nb_queue = 32;
+			dcb_info->tc_queue.tc_txq[0][1].nb_queue = 32;
+			dcb_info->tc_queue.tc_txq[0][2].nb_queue = 16;
+			dcb_info->tc_queue.tc_txq[0][3].nb_queue = 16;
+			dcb_info->tc_queue.tc_txq[0][4].nb_queue = 8;
+			dcb_info->tc_queue.tc_txq[0][5].nb_queue = 8;
+			dcb_info->tc_queue.tc_txq[0][6].nb_queue = 8;
+			dcb_info->tc_queue.tc_txq[0][7].nb_queue = 8;
+		}
+	}
+
+	for (i = 0; i < dcb_info->nb_tcs; i++) {
+		tc = &dcb_config->tc_config[i];
+		dcb_info->tc_bws[i] = tc->channel[DCB_PATH_TX].bwg_percent;
+	}
+
+	return 0;
+}
+
+static void sxe_dcb_vmdq_rx_param_get(struct rte_eth_dev *dev,
+			struct sxe_dcb_config *dcb_config)
+{
+	struct rte_eth_vmdq_dcb_conf *vmdq_rx_conf =
+			&dev->data->dev_conf.rx_adv_conf.vmdq_dcb_conf;
+	struct sxe_tc_config *tc;
+	u8 i, j;
+
+	if (vmdq_rx_conf->nb_queue_pools == RTE_ETH_16_POOLS) {
+		dcb_config->num_tcs.pg_tcs = RTE_ETH_8_TCS;
+		dcb_config->num_tcs.pfc_tcs = RTE_ETH_8_TCS;
+	} else {
+		dcb_config->num_tcs.pg_tcs = RTE_ETH_4_TCS;
+		dcb_config->num_tcs.pfc_tcs = RTE_ETH_4_TCS;
+	}
+
+	for (j = 0; j < MAX_TRAFFIC_CLASS; j++) {
+		tc = &dcb_config->tc_config[j];
+		tc->channel[DCB_PATH_RX].up_to_tc_bitmap = 0;
+	}
+
+	for (i = 0; i < RTE_ETH_DCB_NUM_USER_PRIORITIES; i++) {
+		j = vmdq_rx_conf->dcb_tc[i];
+		tc = &dcb_config->tc_config[j];
+		tc->channel[DCB_PATH_RX].up_to_tc_bitmap |=
+						(u8)(1 << i);
+	}
+}
+
+void sxe_dcb_vmdq_rx_hw_configure(struct rte_eth_dev *dev)
+{
+	struct rte_eth_vmdq_dcb_conf *cfg;
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+	enum rte_eth_nb_pools pools_num;
+	u16 i;
+
+	PMD_INIT_FUNC_TRACE();
+	cfg = &dev->data->dev_conf.rx_adv_conf.vmdq_dcb_conf;
+	pools_num = cfg->nb_queue_pools;
+
+	if (pools_num != RTE_ETH_16_POOLS && pools_num != RTE_ETH_32_POOLS) {
+		sxe_rss_disable(dev);
+		return;
+	}
+
+	sxe_hw_dcb_vmdq_mq_configure(hw, pools_num);
+
+	sxe_hw_dcb_vmdq_default_pool_configure(hw,
+						cfg->enable_default_pool,
+						cfg->default_pool);
+
+	sxe_hw_dcb_vmdq_up_2_tc_configure(hw, cfg->dcb_tc);
+
+	sxe_hw_dcb_vmdq_vlan_configure(hw, pools_num);
+
+	for (i = 0; i < cfg->nb_pool_maps; i++) {
+		sxe_hw_dcb_vmdq_pool_configure(hw,
+					i, cfg->pool_map[i].vlan_id,
+					cfg->pool_map[i].pools);
+	}
+}
+
+static void sxe_dcb_rx_param_get(struct rte_eth_dev *dev,
+		struct sxe_dcb_config *dcb_config)
+{
+	struct rte_eth_dcb_rx_conf *rx_conf =
+			&dev->data->dev_conf.rx_adv_conf.dcb_rx_conf;
+	struct sxe_tc_config *tc;
+	u8 i, j;
+
+	dcb_config->num_tcs.pg_tcs = (u8)rx_conf->nb_tcs;
+	dcb_config->num_tcs.pfc_tcs = (u8)rx_conf->nb_tcs;
+
+	for (j = 0; j < MAX_TRAFFIC_CLASS; j++) {
+		tc = &dcb_config->tc_config[j];
+		tc->channel[DCB_PATH_RX].up_to_tc_bitmap = 0;
+	}
+
+	for (i = 0; i < RTE_ETH_DCB_NUM_USER_PRIORITIES; i++) {
+		j = rx_conf->dcb_tc[i];
+		tc = &dcb_config->tc_config[j];
+		tc->channel[DCB_PATH_RX].up_to_tc_bitmap |=
+						(u8)(1 << i);
+	}
+}
+
+static void sxe_dcb_rx_hw_configure(struct rte_eth_dev *dev,
+			   struct sxe_dcb_config *dcb_config)
+{
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+
+	PMD_INIT_FUNC_TRACE();
+	sxe_hw_dcb_rx_configure(hw, dcb_config->vmdq_active,
+				RTE_ETH_DEV_SRIOV(dev).active,
+				dcb_config->num_tcs.pg_tcs);
+}
+
+static void sxe_dcb_vmdq_tx_param_get(struct rte_eth_dev *dev,
+			struct sxe_dcb_config *dcb_config)
+{
+	struct rte_eth_vmdq_dcb_tx_conf *vmdq_tx_conf =
+			&dev->data->dev_conf.tx_adv_conf.vmdq_dcb_tx_conf;
+	struct sxe_tc_config *tc;
+	u8 i, j;
+
+	if (vmdq_tx_conf->nb_queue_pools == RTE_ETH_16_POOLS) {
+		dcb_config->num_tcs.pg_tcs = RTE_ETH_8_TCS;
+		dcb_config->num_tcs.pfc_tcs = RTE_ETH_8_TCS;
+	} else {
+		dcb_config->num_tcs.pg_tcs = RTE_ETH_4_TCS;
+		dcb_config->num_tcs.pfc_tcs = RTE_ETH_4_TCS;
+	}
+
+	for (j = 0; j < MAX_TRAFFIC_CLASS; j++) {
+		tc = &dcb_config->tc_config[j];
+		tc->channel[DCB_PATH_TX].up_to_tc_bitmap = 0;
+	}
+
+	for (i = 0; i < RTE_ETH_DCB_NUM_USER_PRIORITIES; i++) {
+		j = vmdq_tx_conf->dcb_tc[i];
+		tc = &dcb_config->tc_config[j];
+		tc->channel[DCB_PATH_TX].up_to_tc_bitmap |=
+						(u8)(1 << i);
+	}
+}
+
+static void sxe_dcb_vmdq_tx_hw_configure(struct rte_eth_dev *dev,
+			struct sxe_dcb_config *dcb_config)
+{
+	struct rte_eth_vmdq_dcb_tx_conf *vmdq_tx_conf =
+			&dev->data->dev_conf.tx_adv_conf.vmdq_dcb_tx_conf;
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+
+	PMD_INIT_FUNC_TRACE();
+
+	sxe_hw_pool_xmit_enable(hw, 0, (u8)vmdq_tx_conf->nb_queue_pools);
+
+	sxe_hw_dcb_tx_configure(hw, dcb_config->vmdq_active,
+				dcb_config->num_tcs.pg_tcs);
+}
+
+static void sxe_dcb_tx_param_get(struct rte_eth_dev *dev,
+		struct sxe_dcb_config *dcb_config)
+{
+	struct rte_eth_dcb_tx_conf *tx_conf =
+			&dev->data->dev_conf.tx_adv_conf.dcb_tx_conf;
+	struct sxe_tc_config *tc;
+	u8 i, j;
+
+	dcb_config->num_tcs.pg_tcs = (u8)tx_conf->nb_tcs;
+	dcb_config->num_tcs.pfc_tcs = (u8)tx_conf->nb_tcs;
+
+	for (j = 0; j < MAX_TRAFFIC_CLASS; j++) {
+		tc = &dcb_config->tc_config[j];
+		tc->channel[DCB_PATH_TX].up_to_tc_bitmap = 0;
+	}
+
+	for (i = 0; i < RTE_ETH_DCB_NUM_USER_PRIORITIES; i++) {
+		j = tx_conf->dcb_tc[i];
+		tc = &dcb_config->tc_config[j];
+		tc->channel[DCB_PATH_TX].up_to_tc_bitmap |=
+						(u8)(1 << i);
+	}
+}
+
+static u32 sxe_dcb_min_credit_get(u32 max_frame)
+{
+	return ((max_frame / 2) + DCB_CREDIT_QUANTUM - 1) /
+				DCB_CREDIT_QUANTUM;
+}
+
+static u16 sxe_dcb_cee_tc_link_percent_get(struct sxe_dcb_config *cee_config,
+			u8 direction, u8 tc_index)
+{
+	u8  bw_percent;
+	u16 link_percentage;
+	struct sxe_tc_bw_alloc *tc_info;
+
+	tc_info = &cee_config->tc_config[tc_index].channel[direction];
+	link_percentage =
+		cee_config->bwg_link_percent[direction][tc_info->bwg_id];
+	bw_percent = tc_info->bwg_percent;
+
+	link_percentage = (link_percentage * bw_percent) / 100;
+
+	return link_percentage;
+}
+
+static u32 sxe_dcb_cee_min_link_percent_get(struct sxe_dcb_config *cee_config,
+		u8 direction)
+{
+	u8  tc_index;
+	u16 link_percentage;
+	u32 min_link_percent = 100;
+
+	for (tc_index = 0; tc_index < MAX_TRAFFIC_CLASS; tc_index++) {
+		link_percentage = sxe_dcb_cee_tc_link_percent_get(cee_config,
+					direction, tc_index);
+
+		if (link_percentage && link_percentage < min_link_percent)
+			min_link_percent = link_percentage;
+	}
+
+	return min_link_percent;
+}
+
+static s32 sxe_dcb_cee_tc_credits_calculate(struct sxe_hw *hw,
+				   struct sxe_dcb_config *cee_config,
+				   u32 max_frame, u8 direction)
+{
+	s32 ret = 0;
+	struct sxe_adapter *adapter = hw->adapter;
+	struct sxe_tc_bw_alloc *tc_info;
+	u32 min_credit;
+	u32 total_credit;
+	u32 min_link_percent;
+	u32 credit_refill;
+	u32 credit_max;
+	u16 link_percentage;
+	u8  tc_index;
+
+	LOG_DEBUG_BDF("cee_config[%p] input max_frame[%u] direction[%s]",
+			cee_config, max_frame, direction ? "RX" : "TX");
+
+	min_credit = sxe_dcb_min_credit_get(max_frame);
+	LOG_DEBUG_BDF("cee_config[%p] max_frame[%u] got min_credit[%u]",
+			cee_config, max_frame, min_credit);
+
+	min_link_percent = sxe_dcb_cee_min_link_percent_get(cee_config, direction);
+	LOG_DEBUG_BDF("cee_config[%p] direction[%s] got min_link_percent[%u]",
+			cee_config, direction ? "RX" : "TX", min_link_percent);
+
+	total_credit = (min_credit / min_link_percent) + 1;
+	LOG_DEBUG_BDF("cee_config[%p] total_credit=%u", cee_config, total_credit);
+
+	for (tc_index = 0; tc_index < MAX_TRAFFIC_CLASS; tc_index++) {
+		tc_info = &cee_config->tc_config[tc_index].channel[direction];
+
+		link_percentage = sxe_dcb_cee_tc_link_percent_get(cee_config,
+					direction, tc_index);
+		LOG_DEBUG_BDF("tc[%u] bwg_percent=%u, link_percentage=%u",
+			tc_index, tc_info->bwg_percent, link_percentage);
+
+		if (tc_info->bwg_percent > 0 && link_percentage == 0)
+			link_percentage = 1;
+
+		tc_info->link_percent = (u8)link_percentage;
+
+		credit_refill = RTE_MIN(link_percentage * total_credit,
+					(u32)MAX_CREDIT_REFILL);
+
+		if (credit_refill < min_credit)
+			credit_refill = min_credit;
+
+		tc_info->data_credits_refill = (u16)credit_refill;
+		LOG_DEBUG_BDF("tc[%u] credit_refill=%u",
+					tc_index, credit_refill);
+
+		credit_max = (link_percentage * MAX_CREDIT) / 100;
+
+		if (credit_max < min_credit)
+			credit_max = min_credit;
+		LOG_DEBUG_BDF("tc[%u] credit_max=%u",
+					tc_index, credit_max);
+
+		if (direction == DCB_PATH_TX)
+			cee_config->tc_config[tc_index].desc_credits_max =
+				(u16)credit_max;
+
+		tc_info->data_credits_max = (u16)credit_max;
+	}
+
+	return ret;
+}
+
+static void sxe_dcb_cee_refill_parse(struct sxe_dcb_config *cfg,
+					u8 direction, u16 *refill)
+{
+	u32 tc;
+	struct sxe_tc_config *tc_config = &cfg->tc_config[0];
+
+	for (tc = 0; tc < MAX_TRAFFIC_CLASS; tc++) {
+		refill[tc] = tc_config[tc].channel[direction].data_credits_refill;
+		LOG_DEBUG("tc[%u] --- refill[%u]", tc, refill[tc]);
+	}
+}
+
+static void sxe_dcb_cee_max_credits_parse(struct sxe_dcb_config *cfg,
+						u16 *max_credits)
+{
+	u32 tc;
+	struct sxe_tc_config *tc_config = &cfg->tc_config[0];
+
+	for (tc = 0; tc < MAX_TRAFFIC_CLASS; tc++) {
+		max_credits[tc] = tc_config[tc].desc_credits_max;
+		LOG_DEBUG("tc[%u] --- max_credits[%u]", tc, max_credits[tc]);
+	}
+}
+
+static void sxe_dcb_cee_bwgid_parse(struct sxe_dcb_config *cfg,
+					u8 direction, u8 *bwgid)
+{
+	u32 tc;
+	struct sxe_tc_config *tc_config = &cfg->tc_config[0];
+
+	for (tc = 0; tc < MAX_TRAFFIC_CLASS; tc++) {
+		bwgid[tc] = tc_config[tc].channel[direction].bwg_id;
+		LOG_DEBUG("tc[%u] --- bwgid[%u]", tc, bwgid[tc]);
+	}
+}
+
+static void sxe_dcb_cee_prio_parse(struct sxe_dcb_config *cfg,
+					u8 direction, u8 *ptype)
+{
+	u32 tc;
+	struct sxe_tc_config *tc_config = &cfg->tc_config[0];
+
+	for (tc = 0; tc < MAX_TRAFFIC_CLASS; tc++) {
+		ptype[tc] = tc_config[tc].channel[direction].prio_type;
+		LOG_DEBUG("tc[%u] --- ptype[%u]", tc, ptype[tc]);
+	}
+}
+
+static void sxe_dcb_cee_pfc_parse(struct sxe_dcb_config *cfg,
+						u8 *map, u8 *pfc_en)
+{
+	u32 up;
+	struct sxe_tc_config *tc_config = &cfg->tc_config[0];
+
+	for (*pfc_en = 0, up = 0; up < MAX_TRAFFIC_CLASS; up++) {
+		if (tc_config[map[up]].pfc_type != pfc_disabled)
+			*pfc_en |= BIT(up);
+	}
+	LOG_DEBUG("cfg[%p] pfc_en[0x%x]", cfg, *pfc_en);
+}
+
+static s32 sxe_dcb_tc_stats_configure(struct sxe_hw *hw,
+					struct sxe_dcb_config *dcb_config)
+{
+	s32 ret = 0;
+	u8 tc_count = 8;
+	bool vmdq_active = false;
+
+	if (dcb_config != NULL) {
+		tc_count = dcb_config->num_tcs.pg_tcs;
+		vmdq_active = dcb_config->vmdq_active;
+	}
+
+	if (!((tc_count == 8 && !vmdq_active) || tc_count == 4)) {
+		ret = -SXE_ERR_PARAM;
+		PMD_LOG_ERR(INIT, "dcb tc stats configure failed, "
+				"tc_num = %u, vmdq_active = %s",
+				tc_count, vmdq_active ? "on" : "off");
+		goto l_end;
+	}
+
+	sxe_hw_dcb_tc_stats_configure(hw, tc_count, vmdq_active);
+
+l_end:
+	return ret;
+}
+
+static void sxe_dcb_rx_mq_mode_configure(struct rte_eth_dev *dev,
+					struct sxe_dcb_config *dcb_config,
+					u8 *rx_configured)
+{
+	switch (dev->data->dev_conf.rxmode.mq_mode) {
+	case RTE_ETH_MQ_RX_VMDQ_DCB:
+		dcb_config->vmdq_active = true;
+		*rx_configured = DCB_RX_CONFIG;
+
+		sxe_dcb_vmdq_rx_param_get(dev, dcb_config);
+		sxe_dcb_vmdq_rx_hw_configure(dev);
+		break;
+	case RTE_ETH_MQ_RX_DCB:
+	case RTE_ETH_MQ_RX_DCB_RSS:
+		dcb_config->vmdq_active = false;
+		*rx_configured = DCB_RX_CONFIG;
+
+		sxe_dcb_rx_param_get(dev, dcb_config);
+		sxe_dcb_rx_hw_configure(dev, dcb_config);
+		break;
+	default:
+		PMD_LOG_ERR(INIT, "Incorrect DCB RX mode configuration");
+		break;
+	}
+}
+
+static void sxe_dcb_tx_mq_mode_configure(struct rte_eth_dev *dev,
+					struct sxe_dcb_config *dcb_config,
+					u8 *tx_configured)
+{
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+
+	switch (dev->data->dev_conf.txmode.mq_mode) {
+	case RTE_ETH_MQ_TX_VMDQ_DCB:
+		dcb_config->vmdq_active = true;
+		*tx_configured = DCB_TX_CONFIG;
+
+		sxe_dcb_vmdq_tx_param_get(dev, dcb_config);
+		sxe_dcb_vmdq_tx_hw_configure(dev, dcb_config);
+		break;
+
+	case RTE_ETH_MQ_TX_DCB:
+		dcb_config->vmdq_active = false;
+		*tx_configured = DCB_TX_CONFIG;
+
+		sxe_dcb_tx_param_get(dev, dcb_config);
+		sxe_hw_dcb_tx_configure(hw, dcb_config->vmdq_active,
+				dcb_config->num_tcs.pg_tcs);
+		break;
+	default:
+		PMD_LOG_ERR(INIT, "Incorrect DCB TX mode configuration");
+		break;
+	}
+}
+
+static void sxe_dcb_bwg_percentage_alloc(struct rte_eth_dev *dev,
+				struct sxe_dcb_config *dcb_config, u8 *map)
+{
+	u8 i;
+	struct sxe_tc_config *tc;
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_bw_config *bw_conf = &adapter->dcb_ctxt.bw_config;
+
+	u8 nb_tcs = dcb_config->num_tcs.pfc_tcs;
+
+	if (nb_tcs == RTE_ETH_4_TCS) {
+		for (i = 0; i < MAX_TRAFFIC_CLASS; i++) {
+			if (map[i] >= nb_tcs) {
+				PMD_LOG_INFO(DRV, "map[up-%u] to tc[%u] not exist, "
+								"change to tc 0", i, map[i]);
+				map[i] = 0;
+			}
+		}
+
+		for (i = 0; i < nb_tcs; i++) {
+			tc = &dcb_config->tc_config[i];
+			if (bw_conf->tc_num != nb_tcs) {
+				tc->channel[DCB_PATH_TX].bwg_percent =
+							(u8)(100 / nb_tcs);
+		}
+		tc->channel[DCB_PATH_RX].bwg_percent =
+					(u8)(100 / nb_tcs);
+		}
+		for (; i < MAX_TRAFFIC_CLASS; i++) {
+			tc = &dcb_config->tc_config[i];
+			tc->channel[DCB_PATH_TX].bwg_percent = 0;
+			tc->channel[DCB_PATH_RX].bwg_percent = 0;
+		}
+	} else {
+		for (i = 0; i < nb_tcs; i++) {
+			tc = &dcb_config->tc_config[i];
+			if (bw_conf->tc_num != nb_tcs) {
+				tc->channel[DCB_PATH_TX].bwg_percent =
+					(u8)(100 / nb_tcs + (i & 1));
+			}
+
+			tc->channel[DCB_PATH_RX].bwg_percent =
+				(u8)(100 / nb_tcs + (i & 1));
+		}
+	}
+}
+
+static void sxe_dcb_rx_pkt_buf_configure(struct sxe_hw *hw,
+						u16 rx_buffer_size, u8 tcs_num)
+{
+	u8 i;
+	u16 pbsize;
+
+	pbsize = (u16)(rx_buffer_size / tcs_num);
+
+	for (i = 0; i < tcs_num; i++)
+		sxe_hw_rx_pkt_buf_size_set(hw, i, pbsize);
+
+	for (; i < RTE_ETH_DCB_NUM_USER_PRIORITIES; i++)
+		sxe_hw_rx_pkt_buf_size_set(hw, i, 0);
+}
+
+static void sxe_dcb_tx_pkt_buf_configure(struct sxe_hw *hw, u8 tcs_num)
+{
+	sxe_hw_tx_pkt_buf_switch(hw, false);
+
+	sxe_hw_tx_pkt_buf_size_configure(hw, tcs_num);
+	sxe_hw_tx_pkt_buf_thresh_configure(hw, tcs_num, true);
+
+	sxe_hw_tx_pkt_buf_switch(hw, true);
+}
+
+static void sxe_dcb_rx_configure(struct rte_eth_dev *dev,
+			struct sxe_dcb_config *dcb_config, u8 *map)
+{
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+	u8 tsa[MAX_TRAFFIC_CLASS]	 = {0};
+	u8 bwgid[MAX_TRAFFIC_CLASS]   = {0};
+	u16 refill[MAX_TRAFFIC_CLASS] = {0};
+	u16 max[MAX_TRAFFIC_CLASS]	= {0};
+
+	sxe_dcb_rx_pkt_buf_configure(hw, SXE_RX_PKT_BUF_SIZE, dcb_config->num_tcs.pg_tcs);
+
+	sxe_dcb_cee_refill_parse(dcb_config, DCB_PATH_RX, refill);
+	sxe_dcb_cee_bwgid_parse(dcb_config, DCB_PATH_RX, bwgid);
+	sxe_dcb_cee_prio_parse(dcb_config, DCB_PATH_RX, tsa);
+	sxe_dcb_cee_max_credits_parse(dcb_config, max);
+
+	sxe_hw_dcb_rx_bw_alloc_configure(hw, refill, max,
+				bwgid, tsa, map, MAX_USER_PRIORITY);
+}
+
+static void sxe_dcb_tx_configure(struct rte_eth_dev *dev,
+			struct sxe_dcb_config *dcb_config, u8 *map)
+{
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+	u8 tsa[MAX_TRAFFIC_CLASS]	 = {0};
+	u8 bwgid[MAX_TRAFFIC_CLASS]   = {0};
+	u16 refill[MAX_TRAFFIC_CLASS] = {0};
+	u16 max[MAX_TRAFFIC_CLASS]	= {0};
+
+	sxe_dcb_tx_pkt_buf_configure(hw, dcb_config->num_tcs.pg_tcs);
+
+	sxe_dcb_cee_refill_parse(dcb_config, DCB_PATH_TX, refill);
+	sxe_dcb_cee_max_credits_parse(dcb_config, max);
+	sxe_dcb_cee_bwgid_parse(dcb_config, DCB_PATH_TX, bwgid);
+	sxe_dcb_cee_prio_parse(dcb_config, DCB_PATH_TX, tsa);
+
+	sxe_hw_dcb_tx_desc_bw_alloc_configure(hw, refill, max, bwgid, tsa);
+	sxe_hw_dcb_tx_data_bw_alloc_configure(hw, refill, max,
+				bwgid, tsa, map, MAX_USER_PRIORITY);
+}
+
+static void sxe_dcb_pfc_configure(struct sxe_hw *hw,
+					struct sxe_dcb_config *dcb_config,
+					u8 *map)
+{
+	u8 nb_tcs = dcb_config->num_tcs.pg_tcs;
+	u16 pbsize;
+	u8 i, pfc_en;
+	struct sxe_tc_config *tc;
+
+	pbsize = (u16)(SXE_RX_PKT_BUF_SIZE / nb_tcs);
+	for (i = 0; i < nb_tcs; i++) {
+		sxe_hw_fc_tc_high_water_mark_set(hw, i, (pbsize * 3) / 4);
+		sxe_hw_fc_tc_low_water_mark_set(hw, i, pbsize / 4);
+
+		tc = &dcb_config->tc_config[i];
+		tc->pfc_type = pfc_enabled_full;
+	}
+
+	sxe_dcb_cee_pfc_parse(dcb_config, map, &pfc_en);
+	if (dcb_config->num_tcs.pfc_tcs == RTE_ETH_4_TCS)
+		pfc_en &= 0x0F;
+
+	sxe_hw_dcb_pfc_configure(hw, pfc_en, map, MAX_USER_PRIORITY);
+}
+
+static void sxe_dcb_hw_configure(struct rte_eth_dev *dev,
+			struct sxe_dcb_config *dcb_config)
+{
+	u8 rx_configured = 0;
+	u8 tx_configured = 0;
+	u8 map[MAX_TRAFFIC_CLASS] = {0};
+	u32 max_frame = dev->data->mtu + SXE_ETH_DEAD_LOAD;
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+
+	sxe_dcb_rx_mq_mode_configure(dev, dcb_config, &rx_configured);
+	sxe_dcb_tx_mq_mode_configure(dev, dcb_config, &tx_configured);
+
+	sxe_dcb_up2tc_map_parse(dcb_config, DCB_PATH_RX, map);
+
+	sxe_dcb_bwg_percentage_alloc(dev, dcb_config, map);
+
+	sxe_dcb_cee_tc_credits_calculate(hw, dcb_config, max_frame, DCB_PATH_TX);
+	sxe_dcb_cee_tc_credits_calculate(hw, dcb_config, max_frame, DCB_PATH_RX);
+
+	if (rx_configured)
+		sxe_dcb_rx_configure(dev, dcb_config, map);
+
+	if (tx_configured)
+		sxe_dcb_tx_configure(dev, dcb_config, map);
+
+	sxe_dcb_tc_stats_configure(hw, dcb_config);
+
+	if (dev->data->dev_conf.dcb_capability_en & RTE_ETH_DCB_PFC_SUPPORT)
+		sxe_dcb_pfc_configure(hw, dcb_config, map);
+}
+
+void sxe_dcb_configure(struct rte_eth_dev *dev)
+{
+	struct sxe_adapter *adapter = dev->data->dev_private;
+
+	struct sxe_dcb_config *dcb_cfg = &adapter->dcb_ctxt.config;
+	struct rte_eth_conf *dev_conf = &dev->data->dev_conf;
+
+	PMD_INIT_FUNC_TRACE();
+
+	if (dev_conf->rxmode.mq_mode != RTE_ETH_MQ_RX_VMDQ_DCB &&
+		dev_conf->rxmode.mq_mode != RTE_ETH_MQ_RX_DCB &&
+		dev_conf->rxmode.mq_mode != RTE_ETH_MQ_RX_DCB_RSS) {
+		PMD_LOG_INFO(INIT, "dcb config failed, cause mq_mode=0x%x",
+				(u8)dev_conf->rxmode.mq_mode);
+		return;
+	}
+
+	if (dev->data->nb_rx_queues > RTE_ETH_DCB_NUM_QUEUES) {
+		PMD_LOG_INFO(INIT, "dcb config failed, cause nb_rx_queues=%u > %u",
+			dev->data->nb_rx_queues, RTE_ETH_DCB_NUM_QUEUES);
+		return;
+	}
+
+	sxe_dcb_hw_configure(dev, dcb_cfg);
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_sxe_tc_bw_set, 26.03)
+s32 rte_pmd_sxe_tc_bw_set(u8 port, u8 tc_num, u8 *bw_weight)
+{
+	struct sxe_adapter *adapter;
+	struct rte_eth_dev *dev;
+	struct sxe_dcb_config *dcb_config;
+	struct sxe_tc_config *tc;
+	struct rte_eth_conf *eth_conf;
+	struct sxe_bw_config *bw_conf;
+	u8 i;
+	u8 nb_tcs;
+	u16 sum;
+	s32 ret = 0;
+
+	RTE_ETH_VALID_PORTID_OR_ERR_RET(port, -ENODEV);
+
+	dev = &rte_eth_devices[port];
+	if (!sxe_is_supported(dev)) {
+		ret = -ENOTSUP;
+		goto l_end;
+	}
+
+	if (tc_num > MAX_TRAFFIC_CLASS) {
+		PMD_LOG_ERR(DRV, "TCs should be no more than %d.",
+				MAX_TRAFFIC_CLASS);
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	adapter = dev->data->dev_private;
+	dcb_config = &adapter->dcb_ctxt.config;
+	bw_conf = &adapter->dcb_ctxt.bw_config;
+	eth_conf = &dev->data->dev_conf;
+
+	if (eth_conf->txmode.mq_mode == RTE_ETH_MQ_TX_DCB) {
+		nb_tcs = eth_conf->tx_adv_conf.dcb_tx_conf.nb_tcs;
+	} else if (eth_conf->txmode.mq_mode == RTE_ETH_MQ_TX_VMDQ_DCB) {
+		if (eth_conf->tx_adv_conf.vmdq_dcb_tx_conf.nb_queue_pools ==
+			RTE_ETH_32_POOLS) {
+			nb_tcs = RTE_ETH_4_TCS;
+		} else {
+			nb_tcs = RTE_ETH_8_TCS;
+		}
+	} else {
+		nb_tcs = 1;
+	}
+
+	if (nb_tcs != tc_num) {
+		PMD_LOG_ERR(DRV,
+				"Weight should be set for all %d enabled TCs.",
+				nb_tcs);
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	sum = 0;
+	for (i = 0; i < nb_tcs; i++)
+		sum += bw_weight[i];
+
+	if (sum != 100) {
+		PMD_LOG_ERR(DRV,
+				"The summary of the TC weight should be 100.");
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	for (i = 0; i < nb_tcs; i++) {
+		tc = &dcb_config->tc_config[i];
+		tc->channel[DCB_PATH_TX].bwg_percent = bw_weight[i];
+	}
+
+	for (; i < MAX_TRAFFIC_CLASS; i++) {
+		tc = &dcb_config->tc_config[i];
+		tc->channel[DCB_PATH_TX].bwg_percent = 0;
+	}
+
+	bw_conf->tc_num = nb_tcs;
+
+l_end:
+	return ret;
+}
diff --git a/drivers/net/sxe/pf/sxe_dcb.h b/drivers/net/sxe/pf/sxe_dcb.h
new file mode 100644
index 0000000000..2330febb2e
--- /dev/null
+++ b/drivers/net/sxe/pf/sxe_dcb.h
@@ -0,0 +1,99 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+
+#ifndef __SXE_DCB_H__
+#define __SXE_DCB_H__
+#include <stdbool.h>
+
+#define PBA_STRATEGY_EQUAL	   (0)
+#define PBA_STRATEGY_WEIGHTED	(1)
+#define MAX_BW_GROUP			 8
+#define MAX_USER_PRIORITY		8
+#define SXE_DCB_MAX_TRAFFIC_CLASS		8
+
+enum sxe_dcb_strict_prio_type {
+	DCB_PRIO_NONE = 0,
+	DCB_PRIO_GROUP,
+	DCB_PRIO_LINK
+};
+enum {
+	DCB_PATH_TX   =  0,
+	DCB_PATH_RX   =  1,
+	DCB_PATH_NUM  =  DCB_PATH_RX + 1,
+};
+
+enum sxe_dcb_tsa {
+	sxe_dcb_tsa_ets = 0,
+	sxe_dcb_tsa_group_strict_cee,
+	sxe_dcb_tsa_strict
+};
+
+enum sxe_dcb_pba_config {
+	SXE_DCB_PBA_EQUAL = PBA_STRATEGY_EQUAL,
+	SXE_DCB_PBA_80_48 = PBA_STRATEGY_WEIGHTED
+};
+
+struct sxe_dcb_num_tcs {
+	u8 pg_tcs;
+	u8 pfc_tcs;
+};
+
+struct sxe_tc_bw_alloc {
+	u8 bwg_id;
+	u8 bwg_percent;
+	u8 link_percent;
+	u8 up_to_tc_bitmap;
+	u16 data_credits_refill;
+	u16 data_credits_max;
+	enum sxe_dcb_strict_prio_type prio_type;
+};
+
+enum sxe_dcb_pfc_type {
+	pfc_disabled = 0,
+	pfc_enabled_full,
+	pfc_enabled_tx,
+	pfc_enabled_rx
+};
+
+struct sxe_tc_config {
+	struct sxe_tc_bw_alloc channel[DCB_PATH_NUM];
+	enum sxe_dcb_pfc_type  pfc_type;
+
+	u16 desc_credits_max;
+	u8 tc;
+};
+
+struct sxe_dcb_config {
+	struct sxe_tc_config tc_config[SXE_DCB_MAX_TRAFFIC_CLASS];
+	struct sxe_dcb_num_tcs num_tcs;
+	u8 bwg_link_percent[DCB_PATH_NUM][MAX_BW_GROUP];
+	bool pfc_mode_enable;
+	bool round_robin_enable;
+
+	enum sxe_dcb_pba_config rx_pba_config;
+	bool vmdq_active;
+};
+
+struct sxe_bw_config {
+	u8 tc_num;
+};
+
+struct sxe_dcb_context {
+	struct sxe_dcb_config config;
+	struct sxe_bw_config bw_config;
+};
+
+void sxe_dcb_init(struct rte_eth_dev *dev);
+
+s32 sxe_priority_flow_ctrl_set(struct rte_eth_dev *dev,
+					struct rte_eth_pfc_conf *pfc_conf);
+
+s32 sxe_get_dcb_info(struct rte_eth_dev *dev,
+			struct rte_eth_dcb_info *dcb_info);
+
+void sxe_dcb_configure(struct rte_eth_dev *dev);
+
+void sxe_dcb_vmdq_rx_hw_configure(struct rte_eth_dev *dev);
+
+#endif
diff --git a/drivers/net/sxe/pf/sxe_main.c b/drivers/net/sxe/pf/sxe_main.c
index 4d32d193ff..eb165b35b4 100644
--- a/drivers/net/sxe/pf/sxe_main.c
+++ b/drivers/net/sxe/pf/sxe_main.c
@@ -156,6 +156,7 @@ s32 sxe_hw_reset(struct sxe_hw *hw)
 void sxe_hw_start(struct sxe_hw *hw)
 {
 	sxe_hw_vlan_filter_array_clear(hw);
+	sxe_hw_dcb_rate_limiter_clear(hw, SXE_TXRX_RING_NUM_MAX);
 
 	sxe_fc_autoneg_localcap_set(hw);
 
diff --git a/drivers/net/sxe/pf/sxe_phy.c b/drivers/net/sxe/pf/sxe_phy.c
index 7b10eec7f5..afc885545e 100644
--- a/drivers/net/sxe/pf/sxe_phy.c
+++ b/drivers/net/sxe/pf/sxe_phy.c
@@ -737,6 +737,40 @@ s32 sxe_fc_enable(struct sxe_adapter *adapter)
 	return ret;
 }
 
+s32 sxe_pfc_enable(struct sxe_adapter *adapter, u8 tc_idx)
+{
+	s32 ret;
+	struct sxe_hw *hw = &adapter->hw;
+
+	if (!hw->fc.pause_time) {
+		LOG_ERROR_BDF("link fc disabled since pause time is 0");
+		ret = -SXE_ERR_INVALID_LINK_SETTINGS;
+		goto l_ret;
+	}
+
+	if (hw->fc.current_mode & SXE_FC_TX_PAUSE) {
+		if (!hw->fc.high_water[tc_idx] || !hw->fc.low_water[tc_idx]) {
+			LOG_ERROR_BDF("Invalid water mark configuration");
+			ret = SXE_ERR_INVALID_LINK_SETTINGS;
+			goto l_ret;
+		}
+
+		if (hw->fc.low_water[tc_idx] >= hw->fc.high_water[tc_idx]) {
+			LOG_ERROR_BDF("Invalid water mark configuration");
+			ret = SXE_ERR_INVALID_LINK_SETTINGS;
+			goto l_ret;
+		}
+	}
+
+	sxe_fc_autoneg(adapter);
+
+	ret = sxe_hw_pfc_enable(hw, tc_idx);
+	if (ret)
+		PMD_LOG_ERR(INIT, "link fc enable failed, ret=%d", ret);
+
+l_ret:
+	return ret;
+}
 s32 sxe_sfp_identify(struct sxe_adapter *adapter)
 {
 	s32 ret;
diff --git a/drivers/net/sxe/pf/sxe_phy.h b/drivers/net/sxe/pf/sxe_phy.h
index a3d7dbf85b..9fd2746ec8 100644
--- a/drivers/net/sxe/pf/sxe_phy.h
+++ b/drivers/net/sxe/pf/sxe_phy.h
@@ -105,6 +105,8 @@ s32 sxe_fc_enable(struct sxe_adapter *adapter);
 
 void sxe_link_info_get(struct sxe_adapter *adapter, u32 *link_speed, bool *link_up);
 
+s32 sxe_pfc_enable(struct sxe_adapter *adapter, u8 tc_idx);
+
 void sxe_sfp_link_capabilities_get(struct sxe_adapter *adapter, u32 *speed,
 							bool *autoneg);
 
-- 
2.18.2

