Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA500EC0461
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Mar 2026 09:11:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E957040E1B;
	Tue,  3 Mar 2026 10:11:05 +0100 (CET)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by mails.dpdk.org (Postfix) with ESMTP id 9393C40B9C
 for <dev@dpdk.org>; Tue,  3 Mar 2026 10:11:01 +0100 (CET)
Received: from mail.cstnet.cn (unknown [221.238.36.162])
 by APP-01 (Coremail) with SMTP id qwCowAC3Ym6ipaZpYi4sCQ--.16406S11;
 Tue, 03 Mar 2026 17:10:59 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v18 09/13] net/sxe: support ptp
Date: Tue,  3 Mar 2026 17:10:53 +0800
Message-Id: <20260303091057.2952214-10-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20260303091057.2952214-1-liujie5@linkdatatechnology.com>
References: <20260209012458.506200-13-liujie5@linkdatatechnology.com>
 <20260303091057.2952214-1-liujie5@linkdatatechnology.com>
X-CM-TRANSID: qwCowAC3Ym6ipaZpYi4sCQ--.16406S11
X-Coremail-Antispam: 1UD129KBjvJXoWxtr4fGrWrGFy7Cr45tF4xJFb_yoW3WF1rpF
 Z8Ca4YyrWxtFsFgFWfCF4Dury5KFsYqr92gF9ayw43Z34xCrW8Wry09r1UtFn5G34kJw13
 A3ZYqanxWr1rXF7anT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUQa14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
 kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
 z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr
 1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4U
 JwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I
 8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCF
 s4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lw4
 CEc2x0rVAKj4xxMxkF7I0En4kS14v26r126r1DMxkIecxEwVAFwVW8uwCF04k20xvY0x0E
 wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
 80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0
 I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
 k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7Cj
 xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUIZXrUUUUU=
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

Add ptp module.

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe/pf/sxe_ptp.c | 209 +++++++++++++++++++++++++++++++++++
 drivers/net/sxe/pf/sxe_ptp.h |  26 +++++
 2 files changed, 235 insertions(+)
 create mode 100644 drivers/net/sxe/pf/sxe_ptp.c
 create mode 100644 drivers/net/sxe/pf/sxe_ptp.h

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
2.18.2

