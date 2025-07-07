Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47076C83F07
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Jul 2025 12:00:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 37A1840A6D;
	Mon,  7 Jul 2025 13:58:56 +0200 (CEST)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by mails.dpdk.org (Postfix) with ESMTP id EF29C40A67
 for <dev@dpdk.org>; Mon,  7 Jul 2025 13:58:53 +0200 (CEST)
Received: from mail.cstnet.cn (unknown [60.29.3.194])
 by APP-01 (Coremail) with SMTP id qwCowAAXBqpetmtosYbMAQ--.21604S10;
 Mon, 07 Jul 2025 19:58:48 +0800 (CST)
From: Jie Liu <liujie5@linkdatatechnology.com>
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v3 09/14] net/sxe: support ptp
Date: Mon,  7 Jul 2025 07:58:14 -0400
Message-ID: <20250707115819.12826-9-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250707115819.12826-1-liujie5@linkdatatechnology.com>
References: <20250704025401.301617-1-liujie5@linkdatatechnology.com>
 <20250707115819.12826-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAAXBqpetmtosYbMAQ--.21604S10
X-Coremail-Antispam: 1UD129KBjvJXoW3XF45tr17GrykGw4kAw4DXFb_yoWftFyxpF
 Z5C34ayrWxJF4qgayfCF4Dury5KFsYqryqgF9aywsxZryxCrW8uryvvr1Utr1rG34kJr13
 A3ZYqanxWr1rXF7anT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUQK14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
 kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
 z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr
 1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_
 Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzV
 Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S
 6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxw
 CY1x0262kKe7AKxVWUAVWUtwCY02Avz4vE14v_Gw4l42xK82IYc2Ij64vIr41l4I8I3I0E
 4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGw
 C20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48J
 MIIF0xvE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMI
 IF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAIcVC2
 z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUUfHUPUUUUU==
X-Originating-IP: [60.29.3.194]
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

Add ptp module.

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe/Makefile     |   1 +
 drivers/net/sxe/meson.build  |   1 +
 drivers/net/sxe/pf/sxe.h     |   9 ++
 drivers/net/sxe/pf/sxe_ptp.c | 209 +++++++++++++++++++++++++++++++++++
 drivers/net/sxe/pf/sxe_ptp.h |  26 +++++
 5 files changed, 246 insertions(+)
 create mode 100644 drivers/net/sxe/pf/sxe_ptp.c
 create mode 100644 drivers/net/sxe/pf/sxe_ptp.h

diff --git a/drivers/net/sxe/Makefile b/drivers/net/sxe/Makefile
index eea6556963..5099de8438 100644
--- a/drivers/net/sxe/Makefile
+++ b/drivers/net/sxe/Makefile
@@ -71,6 +71,7 @@ SRCS-$(CONFIG_RTE_LIBRTE_SXE_PMD) += sxe_main.c
 SRCS-$(CONFIG_RTE_LIBRTE_SXE_PMD) += sxe_offload.c
 SRCS-$(CONFIG_RTE_LIBRTE_SXE_PMD) += sxe_phy.c
 SRCS-$(CONFIG_RTE_LIBRTE_SXE_PMD) += sxe_pmd_hdc.c
+SRCS-$(CONFIG_RTE_LIBRTE_SXE_PMD) += sxe_ptp.c
 SRCS-$(CONFIG_RTE_LIBRTE_SXE_PMD) += sxe_queue.c
 SRCS-$(CONFIG_RTE_LIBRTE_SXE_PMD) += sxe_rx.c
 SRCS-$(CONFIG_RTE_LIBRTE_SXE_PMD) += sxe_tx.c
diff --git a/drivers/net/sxe/meson.build b/drivers/net/sxe/meson.build
index ff44dd8e38..49a6eebf45 100644
--- a/drivers/net/sxe/meson.build
+++ b/drivers/net/sxe/meson.build
@@ -19,6 +19,7 @@ sources = files(
 	'pf/sxe_tx.c',
         'pf/sxe_pmd_hdc.c',
         'pf/sxe_phy.c',
+        'pf/sxe_ptp.c',
         'pf/sxe_dcb.c',
         'base/sxe_queue_common.c',
 	'base/sxe_rx_common.c',
diff --git a/drivers/net/sxe/pf/sxe.h b/drivers/net/sxe/pf/sxe.h
index 30efe4ee66..8699e1a82f 100644
--- a/drivers/net/sxe/pf/sxe.h
+++ b/drivers/net/sxe/pf/sxe.h
@@ -41,6 +41,14 @@ struct sxe_vlan_context;
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
 
@@ -51,6 +59,7 @@ struct sxe_adapter {
 #ifdef RTE_ADAPTER_HAVE_FNAV_CONF
 	struct rte_eth_fdir_conf fnav_conf;
 #endif
+	struct sxe_ptp_context ptp_ctxt;
 	struct sxe_phy_context phy_ctxt;
 	struct sxe_dcb_context dcb_ctxt;
 
diff --git a/drivers/net/sxe/pf/sxe_ptp.c b/drivers/net/sxe/pf/sxe_ptp.c
new file mode 100644
index 0000000000..4116dbb37e
--- /dev/null
+++ b/drivers/net/sxe/pf/sxe_ptp.c
@@ -0,0 +1,209 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+
+#include "sxe.h"
+#include "sxe_logs.h"
+#include "sxe_hw.h"
+#include "sxe_ptp.h"
+
+#define SXE_CYCLECOUNTER_MASK   0xffffffffffffffffULL
+
+static void sxe_timecounters_start(struct rte_eth_dev *dev)
+{
+	struct sxe_adapter *adapter = dev->data->dev_private;
+
+	u32 shift = 0;
+
+	memset(&adapter->ptp_ctxt.systime_tc, 0, sizeof(struct rte_timecounter));
+	memset(&adapter->ptp_ctxt.rx_tstamp_tc, 0, sizeof(struct rte_timecounter));
+	memset(&adapter->ptp_ctxt.tx_tstamp_tc, 0, sizeof(struct rte_timecounter));
+
+	adapter->ptp_ctxt.systime_tc.cc_mask = SXE_CYCLECOUNTER_MASK;
+	adapter->ptp_ctxt.systime_tc.cc_shift = shift;
+	adapter->ptp_ctxt.systime_tc.nsec_mask = (1ULL << shift) - 1;
+
+	adapter->ptp_ctxt.rx_tstamp_tc.cc_mask = SXE_CYCLECOUNTER_MASK;
+	adapter->ptp_ctxt.rx_tstamp_tc.cc_shift = shift;
+	adapter->ptp_ctxt.rx_tstamp_tc.nsec_mask = (1ULL << shift) - 1;
+
+	adapter->ptp_ctxt.tx_tstamp_tc.cc_mask = SXE_CYCLECOUNTER_MASK;
+	adapter->ptp_ctxt.tx_tstamp_tc.cc_shift = shift;
+	adapter->ptp_ctxt.tx_tstamp_tc.nsec_mask = (1ULL << shift) - 1;
+
+	adapter->ptp_ctxt.tx_hwtstamp_nsec = 0;
+	adapter->ptp_ctxt.tx_hwtstamp_sec = 0;
+}
+
+s32 sxe_timesync_enable(struct rte_eth_dev *dev)
+{
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+	u32 tses = SXE_TSES_TXES_V2_ALL | SXE_TSES_RXES_V2_ALL;
+
+	struct timespec ts;
+
+	memset(&ts, 0, sizeof(struct timespec));
+
+	clock_gettime(CLOCK_REALTIME, &ts);
+
+	sxe_hw_ptp_init(hw);
+
+
+	sxe_hw_ptp_timestamp_mode_set(hw, true, 0, tses);
+
+	sxe_hw_ptp_timestamp_enable(hw);
+
+	sxe_hw_ptp_rx_timestamp_clear(hw);
+
+	sxe_hw_ptp_systime_init(hw);
+
+	sxe_timecounters_start(dev);
+
+
+	sxe_timesync_write_time(dev, &ts);
+
+	return 0;
+}
+
+s32 sxe_timesync_disable(struct rte_eth_dev *dev)
+{
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+
+	sxe_hw_ptp_timestamp_disable(hw);
+
+	sxe_hw_ptp_timestamp_mode_set(hw, false, 0, 0);
+
+	sxe_hw_ptp_time_inc_stop(hw);
+
+	return 0;
+}
+
+s32 sxe_timesync_read_rx_timestamp(struct rte_eth_dev *dev,
+				 struct timespec *timestamp,
+				 u32 flags __rte_unused)
+{
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+	u64 ns;
+	s32 ret = 0;
+	bool is_valid;
+	u64 rx_tstamp_cycles;
+
+	is_valid = sxe_hw_ptp_is_rx_timestamp_valid(hw);
+	if (!is_valid) {
+		PMD_LOG_ERR(DRV, "no valid ptp timestamp in rx register");
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	rx_tstamp_cycles = sxe_hw_ptp_rx_timestamp_get(hw);
+	ns = rte_timecounter_update(&adapter->ptp_ctxt.rx_tstamp_tc, rx_tstamp_cycles);
+	PMD_LOG_DEBUG(DRV, "got rx_tstamp_cycles = %" SXE_PRIU64 "ns=%" SXE_PRIU64,
+			rx_tstamp_cycles, ns);
+	*timestamp = rte_ns_to_timespec(ns);
+
+l_end:
+	return ret;
+}
+
+static u64 sxe_timesync_tx_tstamp_cycles_get(struct sxe_adapter *adapter)
+{
+	return SXE_TIME_TO_NS(adapter->ptp_ctxt.tx_hwtstamp_nsec,
+				adapter->ptp_ctxt.tx_hwtstamp_sec);
+}
+
+s32 sxe_timesync_read_tx_timestamp(struct rte_eth_dev *dev,
+				 struct timespec *timestamp)
+{
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+	u64 ns;
+	s32 ret = 0;
+	u64 tx_tstamp_cycles;
+	u32 ts_sec;
+	u32 ts_ns;
+	u32 last_sec;
+	u32 last_ns;
+	bool tx_tstamp_valid = true;
+	u8 i;
+
+	sxe_hw_ptp_tx_timestamp_get(hw, &ts_sec, &ts_ns);
+	if (ts_ns  != adapter->ptp_ctxt.tx_hwtstamp_nsec ||
+		ts_sec != adapter->ptp_ctxt.tx_hwtstamp_sec) {
+		for (i = 0; i < SXE_TXTS_POLL_CHECK; i++)
+			sxe_hw_ptp_tx_timestamp_get(hw, &last_sec, &last_ns);
+
+		for (; i < SXE_TXTS_POLL; i++) {
+			sxe_hw_ptp_tx_timestamp_get(hw, &ts_sec, &ts_ns);
+			if (last_ns != ts_ns || last_sec != ts_sec) {
+				tx_tstamp_valid = false;
+				break;
+			}
+		}
+	}
+
+	if (!tx_tstamp_valid || (ts_ns == adapter->ptp_ctxt.tx_hwtstamp_nsec &&
+			ts_sec == adapter->ptp_ctxt.tx_hwtstamp_sec)) {
+		PMD_LOG_DEBUG(DRV, "no valid ptp timestamp in tx register");
+		ret = -EINVAL;
+		goto l_end;
+	} else {
+		adapter->ptp_ctxt.tx_hwtstamp_nsec = ts_ns;
+		adapter->ptp_ctxt.tx_hwtstamp_sec  = ts_sec;
+		tx_tstamp_cycles =
+			sxe_timesync_tx_tstamp_cycles_get(adapter);
+		ns = rte_timecounter_update(&adapter->ptp_ctxt.tx_tstamp_tc,
+						tx_tstamp_cycles);
+		PMD_LOG_DEBUG(DRV, "got tx_tstamp_cycles = %"
+			SXE_PRIU64 "ns=%" SXE_PRIU64, tx_tstamp_cycles, ns);
+		*timestamp = rte_ns_to_timespec(ns);
+	}
+
+l_end:
+	return ret;
+}
+
+s32 sxe_timesync_adjust_time(struct rte_eth_dev *dev, s64 delta)
+{
+	struct sxe_adapter *adapter = dev->data->dev_private;
+
+	PMD_LOG_DEBUG(DRV, "got delta = %" SXE_PRID64, delta);
+
+	adapter->ptp_ctxt.systime_tc.nsec += delta;
+	adapter->ptp_ctxt.rx_tstamp_tc.nsec += delta;
+	adapter->ptp_ctxt.tx_tstamp_tc.nsec += delta;
+
+	return 0;
+}
+
+s32 sxe_timesync_read_time(struct rte_eth_dev *dev, struct timespec *ts)
+{
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+	u64 ns, systime_cycles;
+
+	systime_cycles = sxe_hw_ptp_systime_get(hw);
+	ns = rte_timecounter_update(&adapter->ptp_ctxt.systime_tc, systime_cycles);
+	PMD_LOG_DEBUG(DRV, "got systime_cycles = %" SXE_PRIU64 "ns=%" SXE_PRIU64,
+			systime_cycles, ns);
+	*ts = rte_ns_to_timespec(ns);
+
+	return 0;
+}
+
+s32 sxe_timesync_write_time(struct rte_eth_dev *dev,
+					const struct timespec *ts)
+{
+	u64 ns;
+	struct sxe_adapter *adapter = dev->data->dev_private;
+
+	ns = rte_timespec_to_ns(ts);
+	PMD_LOG_DEBUG(DRV, "set systime ns = %" SXE_PRIU64, ns);
+	adapter->ptp_ctxt.systime_tc.nsec = ns;
+	adapter->ptp_ctxt.rx_tstamp_tc.nsec = ns;
+	adapter->ptp_ctxt.tx_tstamp_tc.nsec = ns;
+
+	return 0;
+}
diff --git a/drivers/net/sxe/pf/sxe_ptp.h b/drivers/net/sxe/pf/sxe_ptp.h
new file mode 100644
index 0000000000..14971b2d50
--- /dev/null
+++ b/drivers/net/sxe/pf/sxe_ptp.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+
+#ifndef __SXE_PTP_H__
+#define __SXE_PTP_H__
+
+s32 sxe_timesync_enable(struct rte_eth_dev *dev);
+
+s32 sxe_timesync_disable(struct rte_eth_dev *dev);
+
+s32 sxe_timesync_read_rx_timestamp(struct rte_eth_dev *dev,
+				 struct timespec *timestamp,
+				 u32 flags __rte_unused);
+
+s32 sxe_timesync_read_tx_timestamp(struct rte_eth_dev *dev,
+				 struct timespec *timestamp);
+
+s32 sxe_timesync_adjust_time(struct rte_eth_dev *dev, s64 delta);
+
+s32 sxe_timesync_read_time(struct rte_eth_dev *dev, struct timespec *ts);
+
+s32 sxe_timesync_write_time(struct rte_eth_dev *dev,
+					const struct timespec *ts);
+
+#endif
-- 
2.18.4

