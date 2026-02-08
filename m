Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CF0EF06E3
	for <dpdk-dev@archiver.kernel.org>; Sun,  8 Feb 2026 09:32:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B04E44065E;
	Sun,  8 Feb 2026 10:32:04 +0100 (CET)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by mails.dpdk.org (Postfix) with ESMTP id 40E23402E4
 for <dev@dpdk.org>; Sun,  8 Feb 2026 10:31:28 +0100 (CET)
Received: from mail.cstnet.cn (unknown [221.238.36.162])
 by APP-05 (Coremail) with SMTP id zQCowAD3hQntV4hp7xbIBw--.48983S14;
 Sun, 08 Feb 2026 17:31:26 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v15 13/13] net/sxe: add virtual function
Date: Sun,  8 Feb 2026 17:31:22 +0800
Message-Id: <20260208093122.10329-13-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20260208093122.10329-1-liujie5@linkdatatechnology.com>
References: <20251225092224.227202-13-liujie5@linkdatatechnology.com>
 <20260208093122.10329-1-liujie5@linkdatatechnology.com>
X-CM-TRANSID: zQCowAD3hQntV4hp7xbIBw--.48983S14
X-Coremail-Antispam: 1UD129KBjvAXoWkJry3CF4UCw1kWw43GFy5CFg_yoWDAF45Ko
 WfXFnxJF1ruryxCFZ5Jw1xGa47Zr47K345Zws09r4kuasxA34IgryfGr13AFnxWF1rtryD
 JwnFv39rJr4UWF4rn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UjIYCTnIWjp_UUUY27AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
 j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s0DM28Irc
 Ia0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l
 84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r
 4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JVW8
 Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2I
 x0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8
 JwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r4fMxC20s026xCaFVCjc4AY6r
 1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
 b7AF67AKxVWUXVWUAwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x
 0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
 6r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0J
 U9TmhUUUUU=
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

Add virtual function.

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe/base/sxe_common.c          |    2 +-
 drivers/net/sxe/base/sxe_compat_platform.h |    2 -
 drivers/net/sxe/base/sxe_hw.c              |   11 +-
 drivers/net/sxe/base/sxe_queue_common.c    |    4 +
 drivers/net/sxe/base/sxevf_hw.c            |  950 ++++++++++++++++
 drivers/net/sxe/base/sxevf_hw.h            |  349 ++++++
 drivers/net/sxe/base/sxevf_regs.h          |  119 ++
 drivers/net/sxe/include/sxe/sxe_msg.h      |    4 +-
 drivers/net/sxe/pf/rte_pmd_sxe.h           |    1 +
 drivers/net/sxe/pf/sxe_filter.c            |  177 +++
 drivers/net/sxe/pf/sxe_filter.h            |   15 +
 drivers/net/sxe/pf/sxe_phy.h               |    1 +
 drivers/net/sxe/pf/sxe_tx.c                |    2 +-
 drivers/net/sxe/pf/sxe_vf.c                | 1199 ++++++++++++++++++++
 drivers/net/sxe/pf/sxe_vf.h                |  200 ++++
 drivers/net/sxe/sxe_testpmd.c              |  130 +++
 drivers/net/sxe/vf/sxevf.h                 |   42 +
 drivers/net/sxe/vf/sxevf_ethdev.c          |  752 ++++++++++++
 drivers/net/sxe/vf/sxevf_ethdev.h          |   16 +
 drivers/net/sxe/vf/sxevf_filter.c          |  493 ++++++++
 drivers/net/sxe/vf/sxevf_filter.h          |   70 ++
 drivers/net/sxe/vf/sxevf_irq.c             |  432 +++++++
 drivers/net/sxe/vf/sxevf_irq.h             |   34 +
 drivers/net/sxe/vf/sxevf_main.c            |   82 ++
 drivers/net/sxe/vf/sxevf_msg.c             |  624 ++++++++++
 drivers/net/sxe/vf/sxevf_msg.h             |  201 ++++
 drivers/net/sxe/vf/sxevf_offload.c         |   30 +
 drivers/net/sxe/vf/sxevf_offload.h         |   16 +
 drivers/net/sxe/vf/sxevf_queue.c           |  208 ++++
 drivers/net/sxe/vf/sxevf_queue.h           |   69 ++
 drivers/net/sxe/vf/sxevf_rx.c              |  162 +++
 drivers/net/sxe/vf/sxevf_rx.h              |   18 +
 drivers/net/sxe/vf/sxevf_stats.c           |  162 +++
 drivers/net/sxe/vf/sxevf_stats.h           |   31 +
 drivers/net/sxe/vf/sxevf_tx.c              |   46 +
 drivers/net/sxe/vf/sxevf_tx.h              |   14 +
 36 files changed, 6660 insertions(+), 8 deletions(-)
 create mode 100644 drivers/net/sxe/base/sxevf_hw.c
 create mode 100644 drivers/net/sxe/base/sxevf_hw.h
 create mode 100644 drivers/net/sxe/base/sxevf_regs.h
 create mode 100644 drivers/net/sxe/pf/sxe_vf.c
 create mode 100644 drivers/net/sxe/pf/sxe_vf.h
 create mode 100644 drivers/net/sxe/vf/sxevf.h
 create mode 100644 drivers/net/sxe/vf/sxevf_ethdev.c
 create mode 100644 drivers/net/sxe/vf/sxevf_ethdev.h
 create mode 100644 drivers/net/sxe/vf/sxevf_filter.c
 create mode 100644 drivers/net/sxe/vf/sxevf_filter.h
 create mode 100644 drivers/net/sxe/vf/sxevf_irq.c
 create mode 100644 drivers/net/sxe/vf/sxevf_irq.h
 create mode 100644 drivers/net/sxe/vf/sxevf_main.c
 create mode 100644 drivers/net/sxe/vf/sxevf_msg.c
 create mode 100644 drivers/net/sxe/vf/sxevf_msg.h
 create mode 100644 drivers/net/sxe/vf/sxevf_offload.c
 create mode 100644 drivers/net/sxe/vf/sxevf_offload.h
 create mode 100644 drivers/net/sxe/vf/sxevf_queue.c
 create mode 100644 drivers/net/sxe/vf/sxevf_queue.h
 create mode 100644 drivers/net/sxe/vf/sxevf_rx.c
 create mode 100644 drivers/net/sxe/vf/sxevf_rx.h
 create mode 100644 drivers/net/sxe/vf/sxevf_stats.c
 create mode 100644 drivers/net/sxe/vf/sxevf_stats.h
 create mode 100644 drivers/net/sxe/vf/sxevf_tx.c
 create mode 100644 drivers/net/sxe/vf/sxevf_tx.h

diff --git a/drivers/net/sxe/base/sxe_common.c b/drivers/net/sxe/base/sxe_common.c
index 8b3fb13e73..cf6b656680 100644
--- a/drivers/net/sxe/base/sxe_common.c
+++ b/drivers/net/sxe/base/sxe_common.c
@@ -44,7 +44,7 @@ u64 sxe_time_get_real_ms(void)
 
 u64 sxe_trace_id_gen(void)
 {
-	u64 tid	   = getpid() + (pthread_self() << 20);
+	u64 tid	   = (u64)getpid() + ((u64)pthread_self() << 20);
 	u64 index	 = 0;
 	u64 timestamp = sxe_time_get_real_ms();
 
diff --git a/drivers/net/sxe/base/sxe_compat_platform.h b/drivers/net/sxe/base/sxe_compat_platform.h
index 80d7d3f288..8c254d52c5 100644
--- a/drivers/net/sxe/base/sxe_compat_platform.h
+++ b/drivers/net/sxe/base/sxe_compat_platform.h
@@ -25,8 +25,6 @@
 #define __iomem
 #define __force
 
-#define min(a, b)	RTE_MIN(a, b)
-
 #ifndef fallthrough
 # define fallthrough do {} while (0)
 #endif
diff --git a/drivers/net/sxe/base/sxe_hw.c b/drivers/net/sxe/base/sxe_hw.c
index 95ac9c804d..ba1c099627 100644
--- a/drivers/net/sxe/base/sxe_hw.c
+++ b/drivers/net/sxe/base/sxe_hw.c
@@ -3,6 +3,7 @@
  */
 #ifdef SXE_PHY_CONFIGURE
 #include <linux/mdio.h>
+#include <rte_compat.h>
 #endif
 #include <rte_byteorder.h>
 #if defined(__KERNEL__) || defined(SXE_KERNEL_TEST)
@@ -4962,7 +4963,14 @@ bool sxe_hw_is_rss_enabled(struct sxe_hw *hw)
 {
 	bool rss_enable = false;
 	u32 mrqc = SXE_REG_READ(hw, SXE_MRQC);
-	if (mrqc & SXE_MRQC_RSSEN)
+
+
+	u32 mrqe_val = mrqc & SXE_MRQC_MRQE_MASK;
+	if (mrqe_val == SXE_MRQC_RSSEN ||
+		mrqe_val == SXE_MRQC_RTRSS8TCEN ||
+		mrqe_val == SXE_MRQC_RTRSS4TCEN ||
+		mrqe_val == SXE_MRQC_VMDQRSS32EN ||
+		mrqe_val == SXE_MRQC_VMDQRSS64EN)
 		rss_enable = true;
 
 	return rss_enable;
@@ -5496,7 +5504,6 @@ void sxe_hw_rss_cap_switch(struct sxe_hw *hw, bool is_on)
 {
 	u32 mrqc = SXE_REG_READ(hw, SXE_MRQC);
 	u32 mrqe_val;
-
 	mrqe_val = mrqc & SXE_MRQC_MRQE_MASK;
 	if (is_on) {
 		mrqe_val = SXE_MRQC_RSSEN;
diff --git a/drivers/net/sxe/base/sxe_queue_common.c b/drivers/net/sxe/base/sxe_queue_common.c
index 991b374667..15e086b45e 100644
--- a/drivers/net/sxe/base/sxe_queue_common.c
+++ b/drivers/net/sxe/base/sxe_queue_common.c
@@ -12,11 +12,15 @@
 #include "sxe_tx.h"
 #include "sxe_logs.h"
 #include "sxe_regs.h"
+#include "sxevf_regs.h"
 #include "sxe.h"
 #if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SIMD
 #include "sxe_vec_common.h"
 #include <rte_vect.h>
 #endif
+#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SRIOV
+#include "sxevf.h"
+#endif
 #include "sxe_queue_common.h"
 #include "sxe_queue.h"
 
diff --git a/drivers/net/sxe/base/sxevf_hw.c b/drivers/net/sxe/base/sxevf_hw.c
new file mode 100644
index 0000000000..ae016f85fc
--- /dev/null
+++ b/drivers/net/sxe/base/sxevf_hw.c
@@ -0,0 +1,950 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+#if defined(__KERNEL__) || defined(SXE_KERNEL_TEST)
+#include <linux/etherdevice.h>
+
+#include "sxevf_hw.h"
+#include "sxevf_regs.h"
+#include "sxe_log.h"
+#include "sxevf_irq.h"
+#include "sxevf_msg.h"
+#include "sxevf_ring.h"
+#include "sxevf.h"
+#include "sxevf_rx_proc.h"
+#else
+#include "sxe_errno.h"
+#include "sxe_logs.h"
+#include "sxe_compat_version.h"
+#include "sxevf.h"
+#include "sxevf_hw.h"
+#endif
+
+#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SRIOV
+struct sxevf_adapter;
+#endif
+
+#define DMA_BIT_MASK(n)	(((n) == 64) ? ~0ULL : ((1ULL << (n)) - 1))
+#define DMA_MASK_NONE	0x0ULL
+
+#define SXEVF_REG_READ_CNT	5
+
+#define SXE_REG_READ_FAIL	0xffffffffU
+
+#define SXEVF_RING_WAIT_LOOP	(100)
+#define SXEVF_MAX_RX_DESC_POLL	(10)
+
+
+#define SXEVF_REG_READ(hw, addr)	sxevf_reg_read(hw, addr)
+#define SXEVF_REG_WRITE(hw, reg, value)	sxevf_reg_write(hw, reg, value)
+#define SXEVF_WRITE_FLUSH(a)		sxevf_reg_read(a, SXE_VFSTATUS)
+
+#ifndef SXE_DPDK
+void sxevf_hw_fault_handle(struct sxevf_hw *hw)
+{
+	struct sxevf_adapter *adapter = hw->adapter;
+
+	if (test_bit(SXEVF_HW_FAULT, &hw->state))
+		return;
+
+	set_bit(SXEVF_HW_FAULT, &hw->state);
+
+	LOG_DEV_ERR("sxe nic hw fault");
+
+	if (hw->fault_handle != NULL && hw->priv != NULL)
+		hw->fault_handle(hw->priv);
+}
+
+static void sxevf_hw_fault_check(struct sxevf_hw *hw, u32 reg)
+{
+	u32 value;
+	u8  __iomem *base_addr = hw->reg_base_addr;
+	struct sxevf_adapter *adapter = hw->adapter;
+	u8 i;
+
+	if (reg == SXE_VFSTATUS)
+		sxevf_hw_fault_handle(hw);
+
+
+	for (i = 0; i < SXEVF_REG_READ_CNT; i++) {
+		value = hw->reg_read(base_addr + SXE_VFSTATUS);
+
+		if (value != SXEVF_REG_READ_FAIL)
+			break;
+
+		mdelay(20);
+	}
+
+	LOG_INFO_BDF("retry done i:%d value:0x%x", i, value);
+
+	if (value == SXEVF_REG_READ_FAIL)
+		sxevf_hw_fault_handle(hw);
+}
+
+static u32 sxevf_reg_read(struct sxevf_hw *hw, u32 reg)
+{
+	u32 value;
+	u8  __iomem *base_addr = hw->reg_base_addr;
+	struct sxevf_adapter *adapter = hw->adapter;
+
+	if (sxevf_is_hw_fault(hw)) {
+		value = SXEVF_REG_READ_FAIL;
+		goto l_ret;
+	}
+
+	value = hw->reg_read(base_addr + reg);
+	if (unlikely(value == SXEVF_REG_READ_FAIL)) {
+		LOG_ERROR_BDF("reg[0x%x] read failed, value=%#x", reg, value);
+		sxevf_hw_fault_check(hw, reg);
+	}
+
+l_ret:
+	return value;
+}
+
+static void sxevf_reg_write(struct sxevf_hw *hw, u32 reg, u32 value)
+{
+	u8 __iomem *base_addr = hw->reg_base_addr;
+
+	if (sxevf_is_hw_fault(hw))
+		return;
+
+	hw->reg_write(value, base_addr + reg);
+}
+
+#else
+
+static u32 sxevf_reg_read(struct sxevf_hw *hw, u32 reg)
+{
+	u32 i, value;
+	u8  __iomem *base_addr = hw->reg_base_addr;
+
+	value = rte_le_to_cpu_32(rte_read32(base_addr + reg));
+	if (unlikely(value == SXEVF_REG_READ_FAIL)) {
+		for (i = 0; i < SXEVF_REG_READ_CNT; i++) {
+			LOG_ERROR("reg[0x%x] read failed, value=%#x",
+							reg, value);
+			value = rte_le_to_cpu_32(rte_read32(base_addr + reg));
+			if (value != SXEVF_REG_READ_FAIL) {
+				LOG_INFO("reg[0x%x] read ok, value=%#x",
+								reg, value);
+				break;
+			}
+
+			mdelay(3);
+		}
+	}
+
+	return value;
+}
+
+static void sxevf_reg_write(struct sxevf_hw *hw, u32 reg, u32 value)
+{
+	u8 __iomem *base_addr = hw->reg_base_addr;
+
+	rte_write32((rte_cpu_to_le_32(value)), (base_addr + reg));
+}
+#endif
+
+void sxevf_hw_stop(struct sxevf_hw *hw)
+{
+	u8 i;
+	u32 value;
+
+	for (i = 0; i < SXEVF_TXRX_RING_NUM_MAX; i++) {
+		value = SXEVF_REG_READ(hw, SXE_VFRXDCTL(i));
+		if (value & SXE_VFRXDCTL_ENABLE) {
+			value &= ~SXE_VFRXDCTL_ENABLE;
+			SXEVF_REG_WRITE(hw, SXE_VFRXDCTL(i), value);
+		}
+	}
+
+	SXEVF_WRITE_FLUSH(hw);
+
+	SXEVF_REG_WRITE(hw, SXE_VFEIMC, SXEVF_VFEIMC_IRQ_MASK);
+	SXEVF_REG_READ(hw, SXE_VFEICR);
+
+	for (i = 0; i < SXEVF_TXRX_RING_NUM_MAX; i++) {
+		value = SXEVF_REG_READ(hw, SXE_VFTXDCTL(i));
+		if (value & SXE_VFTXDCTL_ENABLE) {
+			value &= ~SXE_VFTXDCTL_ENABLE;
+			SXEVF_REG_WRITE(hw, SXE_VFTXDCTL(i), value);
+		}
+	}
+}
+
+void sxevf_msg_write(struct sxevf_hw *hw, u8 index, u32 msg)
+{
+	struct sxevf_adapter *adapter = hw->adapter;
+
+	SXEVF_REG_WRITE(hw, SXE_VFMBMEM + (index << 2), msg);
+
+	LOG_DEBUG_BDF("index:%u write mbx mem:0x%x.", index, msg);
+}
+
+u32 sxevf_msg_read(struct sxevf_hw *hw, u8 index)
+{
+	u32 value = SXEVF_REG_READ(hw, SXE_VFMBMEM + (index << 2));
+	struct sxevf_adapter *adapter = hw->adapter;
+
+	LOG_DEBUG_BDF("index:%u read mbx mem:0x%x.", index, value);
+
+	return value;
+}
+
+u32 sxevf_mailbox_read(struct sxevf_hw *hw)
+{
+	return SXEVF_REG_READ(hw, SXE_VFMAILBOX);
+}
+
+void sxevf_mailbox_write(struct sxevf_hw *hw, u32 value)
+{
+	SXEVF_REG_WRITE(hw, SXE_VFMAILBOX, value);
+}
+
+void sxevf_pf_req_irq_trigger(struct sxevf_hw *hw)
+{
+	SXEVF_REG_WRITE(hw, SXE_VFMAILBOX, SXE_VFMAILBOX_REQ);
+}
+
+void sxevf_pf_ack_irq_trigger(struct sxevf_hw *hw)
+{
+	SXEVF_REG_WRITE(hw, SXE_VFMAILBOX, SXE_VFMAILBOX_ACK);
+}
+
+void sxevf_event_irq_map(struct sxevf_hw *hw, u16 vector)
+{
+	u8  allocation;
+	u32 ivar;
+
+	allocation = vector | SXEVF_IVAR_ALLOC_VALID;
+
+	ivar = SXEVF_REG_READ(hw, SXE_VFIVAR_MISC);
+	ivar &= ~0xFF;
+	ivar |= allocation;
+
+	SXEVF_REG_WRITE(hw, SXE_VFIVAR_MISC, ivar);
+}
+
+void sxevf_specific_irq_enable(struct sxevf_hw *hw, u32 value)
+{
+	SXEVF_REG_WRITE(hw, SXE_VFEIMS, value);
+}
+
+void sxevf_irq_enable(struct sxevf_hw *hw, u32 mask)
+{
+	SXEVF_REG_WRITE(hw, SXE_VFEIAM, mask);
+	SXEVF_REG_WRITE(hw, SXE_VFEIMS, mask);
+}
+
+void sxevf_irq_disable(struct sxevf_hw *hw)
+{
+	SXEVF_REG_WRITE(hw, SXE_VFEIAM, 0);
+	SXEVF_REG_WRITE(hw, SXE_VFEIMC, ~0);
+
+	SXEVF_WRITE_FLUSH(hw);
+}
+
+void sxevf_hw_ring_irq_map(struct sxevf_hw *hw, bool is_tx, u16 hw_ring_idx, u16 vector)
+{
+	u8  allocation;
+	u32 ivar, position;
+
+	allocation = vector | SXEVF_IVAR_ALLOC_VALID;
+
+	position = ((hw_ring_idx & 1) * 16) + (8 * is_tx);
+
+	ivar = SXEVF_REG_READ(hw, SXE_VFIVAR(hw_ring_idx >> 1));
+	ivar &= ~(0xFF << position);
+	ivar |= (allocation << position);
+
+	SXEVF_REG_WRITE(hw, SXE_VFIVAR(hw_ring_idx >> 1), ivar);
+}
+
+void sxevf_ring_irq_interval_set(struct sxevf_hw *hw, u16 irq_idx, u32 interval)
+{
+	u32 eitr = interval & SXEVF_EITR_ITR_MASK;
+
+	eitr |= SXEVF_EITR_CNT_WDIS;
+
+	SXEVF_REG_WRITE(hw, SXE_VFEITR(irq_idx), eitr);
+}
+
+static void sxevf_event_irq_interval_set(struct sxevf_hw *hw, u16 irq_idx, u32 value)
+{
+	SXEVF_REG_WRITE(hw, SXE_VFEITR(irq_idx), value);
+}
+
+static void sxevf_pending_irq_clear(struct sxevf_hw *hw)
+{
+	SXEVF_REG_READ(hw, SXE_VFEICR);
+}
+
+static void sxevf_ring_irq_trigger(struct sxevf_hw *hw, u64 eics)
+{
+	SXEVF_REG_WRITE(hw, SXE_VFEICS, eics);
+}
+
+static const struct sxevf_irq_operations sxevf_irq_ops = {
+	.ring_irq_interval_set	= sxevf_ring_irq_interval_set,
+	.event_irq_interval_set	= sxevf_event_irq_interval_set,
+	.ring_irq_map		= sxevf_hw_ring_irq_map,
+	.event_irq_map		= sxevf_event_irq_map,
+	.pending_irq_clear	= sxevf_pending_irq_clear,
+	.ring_irq_trigger	= sxevf_ring_irq_trigger,
+	.specific_irq_enable	= sxevf_specific_irq_enable,
+	.irq_enable		= sxevf_irq_enable,
+	.irq_disable		= sxevf_irq_disable,
+};
+
+void sxevf_hw_reset(struct sxevf_hw *hw)
+{
+	SXEVF_REG_WRITE(hw, SXE_VFCTRL, SXE_VFCTRL_RST);
+	SXEVF_WRITE_FLUSH(hw);
+}
+
+static bool sxevf_hw_rst_done(struct sxevf_hw *hw)
+{
+	return !(SXEVF_REG_READ(hw, SXE_VFCTRL) & SXE_VFCTRL_RST);
+}
+
+u32 sxevf_link_state_get(struct sxevf_hw *hw)
+{
+	return SXEVF_REG_READ(hw, SXE_VFLINKS);
+}
+
+u32 sxe_dump_regs[] = {
+	SXE_VFCTRL,
+};
+
+u16 sxevf_reg_dump_num_get(void)
+{
+	return ARRAY_SIZE(sxe_dump_regs);
+}
+
+static u32 sxevf_reg_dump(struct sxevf_hw *hw, u32 *regs_buff, u32 buf_size)
+{
+	u32 i;
+	u32 regs_num = buf_size / sizeof(u32);
+
+	for (i = 0; i < regs_num; i++)
+		regs_buff[i] = SXEVF_REG_READ(hw, sxe_dump_regs[i]);
+
+	return i;
+}
+
+#define PATTERN_TEST	1
+#define SET_READ_TEST	2
+#define WRITE_NO_TEST	3
+#define TABLE32_TEST	4
+#define TABLE64_TEST_LO	5
+#define TABLE64_TEST_HI	6
+
+struct sxevf_self_test_reg {
+	u32 reg;
+	u8  array_len;
+	u8  test_type;
+	u32 mask;
+	u32 write;
+};
+
+static const struct sxevf_self_test_reg self_test_reg[] = {
+	{ SXE_VFRDBAL(0), 2, PATTERN_TEST, 0xFFFFFF80, 0xFFFFFF80 },
+	{ SXE_VFRDBAH(0), 2, PATTERN_TEST, 0xFFFFFFFF, 0xFFFFFFFF },
+	{ SXE_VFRDLEN(0), 2, PATTERN_TEST, 0x000FFFFF, 0x000FFFFF },
+	{ SXE_VFRXDCTL(0), 2, WRITE_NO_TEST, 0, SXEVF_RXDCTL_ENABLE },
+	{ SXE_VFRDT(0), 2, PATTERN_TEST, 0x0000FFFF, 0x0000FFFF },
+	{ SXE_VFRXDCTL(0), 2, WRITE_NO_TEST, 0, 0 },
+	{ SXE_VFTDBAL(0), 2, PATTERN_TEST, 0xFFFFFF80, 0xFFFFFFFF },
+	{ SXE_VFTDBAH(0), 2, PATTERN_TEST, 0xFFFFFFFF, 0xFFFFFFFF },
+	{ SXE_VFTDLEN(0), 2, PATTERN_TEST, 0x000FFF80, 0x000FFF80 },
+	{ .reg = 0 }
+};
+
+static s32 sxevf_reg_pattern_test(struct sxevf_hw *hw, u32 reg,
+				u32 mask, u32 write)
+{
+	s32 ret = 0;
+	u32 pat, val, before;
+	static const u32 test_pattern[] = {
+		0x5A5A5A5A, 0xA5A5A5A5, 0x00000000, 0xFFFFFFFE};
+	struct sxevf_adapter *adapter = hw->adapter;
+
+	if (sxevf_is_hw_fault(hw)) {
+		LOG_ERROR_BDF("hw fault");
+		ret = -SXEVF_DIAG_TEST_BLOCKED;
+		goto l_end;
+	}
+
+	for (pat = 0; pat < ARRAY_SIZE(test_pattern); pat++) {
+		before = SXEVF_REG_READ(hw, reg);
+
+		SXEVF_REG_WRITE(hw, reg, test_pattern[pat] & write);
+		val = SXEVF_REG_READ(hw, reg);
+		if (val != (test_pattern[pat] & write & mask)) {
+			LOG_MSG_ERR(drv, "pattern test reg %04X failed: "
+					"got 0x%08X expected 0x%08X",
+				reg, val, (test_pattern[pat] & write & mask));
+			SXEVF_REG_WRITE(hw, reg, before);
+			ret = -SXEVF_DIAG_REG_PATTERN_TEST_ERR;
+			goto l_end;
+		}
+
+		SXEVF_REG_WRITE(hw, reg, before);
+	}
+
+l_end:
+	return ret;
+}
+
+static s32 sxevf_reg_set_and_check(struct sxevf_hw *hw, int reg,
+				u32 mask, u32 write)
+{
+	s32 ret = 0;
+	u32 val, before;
+	struct sxevf_adapter *adapter = hw->adapter;
+
+	if (sxevf_is_hw_fault(hw)) {
+		LOG_ERROR_BDF("hw fault");
+		ret = -SXEVF_DIAG_TEST_BLOCKED;
+		goto l_end;
+	}
+
+	before = SXEVF_REG_READ(hw, reg);
+	SXEVF_REG_WRITE(hw, reg, write & mask);
+	val = SXEVF_REG_READ(hw, reg);
+	if ((write & mask) != (val & mask)) {
+		LOG_DEV_ERR("set/check reg %04X test failed: "
+				"got 0x%08X expected 0x%08X",
+			reg, (val & mask), (write & mask));
+		SXEVF_REG_WRITE(hw, reg, before);
+		ret = -SXEVF_DIAG_CHECK_REG_TEST_ERR;
+		goto l_end;
+	}
+
+	SXEVF_REG_WRITE(hw, reg, before);
+
+l_end:
+	return ret;
+}
+
+static s32 sxevf_regs_test(struct sxevf_hw *hw)
+{
+	u32 i;
+	s32 ret = 0;
+	const struct sxevf_self_test_reg *test = self_test_reg;
+	struct sxevf_adapter *adapter = hw->adapter;
+
+	while (test->reg) {
+		for (i = 0; i < test->array_len; i++) {
+			switch (test->test_type) {
+			case PATTERN_TEST:
+				ret = sxevf_reg_pattern_test(hw,
+					test->reg + (i * 0x40),
+					test->mask, test->write);
+				break;
+			case TABLE32_TEST:
+				ret = sxevf_reg_pattern_test(hw,
+					test->reg + (i * 4),
+					test->mask, test->write);
+				break;
+			case TABLE64_TEST_LO:
+				ret = sxevf_reg_pattern_test(hw,
+					test->reg + (i * 8),
+					test->mask, test->write);
+				break;
+			case TABLE64_TEST_HI:
+				ret = sxevf_reg_pattern_test(hw,
+					(test->reg + 4) + (i * 8),
+					test->mask, test->write);
+				break;
+			case SET_READ_TEST:
+				ret = sxevf_reg_set_and_check(hw,
+					test->reg + (i * 0x40),
+					test->mask, test->write);
+				break;
+			case WRITE_NO_TEST:
+				SXEVF_REG_WRITE(hw, test->reg + (i * 0x40),
+						test->write);
+				break;
+			default:
+				LOG_ERROR_BDF("reg test mod err, type=%d",
+						test->test_type);
+				break;
+			}
+
+			if (ret)
+				goto l_end;
+		}
+		test++;
+	}
+
+l_end:
+	return ret;
+}
+
+static const struct sxevf_setup_operations sxevf_setup_ops = {
+	.reset		= sxevf_hw_reset,
+	.hw_stop	= sxevf_hw_stop,
+	.regs_test	= sxevf_regs_test,
+	.regs_dump	= sxevf_reg_dump,
+	.link_state_get	= sxevf_link_state_get,
+	.reset_done = sxevf_hw_rst_done,
+};
+
+static void sxevf_tx_ring_desc_configure(struct sxevf_hw *hw, u32 desc_mem_len,
+				u64 desc_dma_addr, u8 reg_idx)
+{
+	SXEVF_REG_WRITE(hw, SXEVF_TDBAL(reg_idx), (desc_dma_addr &
+						DMA_BIT_MASK(32)));
+	SXEVF_REG_WRITE(hw, SXEVF_TDBAH(reg_idx), (desc_dma_addr >> 32));
+	SXEVF_REG_WRITE(hw, SXEVF_TDLEN(reg_idx), desc_mem_len);
+	SXEVF_REG_WRITE(hw, SXEVF_TDH(reg_idx), 0);
+	SXEVF_REG_WRITE(hw, SXEVF_TDT(reg_idx), 0);
+}
+
+static void sxevf_tx_writeback_off(struct sxevf_hw *hw, u8 reg_idx)
+{
+	SXEVF_REG_WRITE(hw, SXEVF_TDWBAH(reg_idx), 0);
+	SXEVF_REG_WRITE(hw, SXEVF_TDWBAL(reg_idx), 0);
+}
+
+static void sxevf_tx_desc_thresh_set(struct sxevf_hw *hw,
+				u8 reg_idx,
+				u32 wb_thresh,
+				u32 host_thresh,
+				u32 prefech_thresh)
+{
+	u32 txdctl = 0;
+
+	txdctl |= (wb_thresh << SXEVF_TXDCTL_WTHRESH_SHIFT);
+	txdctl |= (host_thresh << SXEVF_TXDCTL_HTHRESH_SHIFT) |
+			prefech_thresh;
+
+	SXEVF_REG_WRITE(hw, SXEVF_TXDCTL(reg_idx), txdctl);
+}
+
+void sxevf_tx_ring_switch(struct sxevf_hw *hw, u8 reg_idx, bool is_on)
+{
+	u32 wait_loop = SXEVF_MAX_TXRX_DESC_POLL;
+	struct sxevf_adapter *adapter = hw->adapter;
+
+	u32 txdctl = SXEVF_REG_READ(hw, SXEVF_TXDCTL(reg_idx));
+	if (is_on) {
+		txdctl |= SXEVF_TXDCTL_ENABLE;
+		SXEVF_REG_WRITE(hw, SXEVF_TXDCTL(reg_idx), txdctl);
+
+		do {
+			usleep_range(1000, 2000);
+			txdctl = SXEVF_REG_READ(hw, SXEVF_TXDCTL(reg_idx));
+		} while (--wait_loop && !(txdctl & SXEVF_TXDCTL_ENABLE));
+	} else {
+		txdctl &= ~SXEVF_TXDCTL_ENABLE;
+		SXEVF_REG_WRITE(hw, SXEVF_TXDCTL(reg_idx), txdctl);
+
+		do {
+			usleep_range(1000, 2000);
+			txdctl = SXEVF_REG_READ(hw, SXEVF_TXDCTL(reg_idx));
+		} while (--wait_loop && (txdctl & SXEVF_TXDCTL_ENABLE));
+	}
+
+	if (!wait_loop) {
+		LOG_DEV_ERR("tx ring %u switch %u failed within "
+			  "the polling period", reg_idx, is_on);
+	}
+}
+
+static void sxevf_rx_disable(struct sxevf_hw *hw, u8 reg_idx)
+{
+	u32 rxdctl;
+	u32 wait_loop = SXEVF_RX_RING_POLL_MAX;
+	struct sxevf_adapter *adapter = hw->adapter;
+
+	if (!hw->reg_base_addr)
+		return;
+
+	rxdctl = SXEVF_REG_READ(hw, SXE_VFRXDCTL(reg_idx));
+	rxdctl &= ~SXE_VFRXDCTL_ENABLE;
+	SXEVF_REG_WRITE(hw, SXE_VFRXDCTL(reg_idx), rxdctl);
+
+	do {
+		sxe_udelay(10);
+		rxdctl = SXEVF_REG_READ(hw, SXE_VFRXDCTL(reg_idx));
+	} while (--wait_loop && (rxdctl & SXE_VFRXDCTL_ENABLE));
+
+	if (!wait_loop) {
+		LOG_ERROR_BDF("RXDCTL.ENABLE queue %d not cleared while polling",
+				reg_idx);
+	}
+}
+
+void sxevf_rx_ring_switch(struct sxevf_hw *hw, u8 reg_idx, bool is_on)
+{
+	u32 rxdctl;
+	u32 wait_loop = SXEVF_RING_WAIT_LOOP;
+	struct sxevf_adapter *adapter = hw->adapter;
+
+	rxdctl = SXEVF_REG_READ(hw, SXE_VFRXDCTL(reg_idx));
+	if (is_on) {
+		rxdctl |= SXEVF_RXDCTL_ENABLE | SXEVF_RXDCTL_VME;
+		SXEVF_REG_WRITE(hw, SXE_VFRXDCTL(reg_idx), rxdctl);
+
+		do {
+			usleep_range(1000, 2000);
+			rxdctl = SXEVF_REG_READ(hw, SXE_VFRXDCTL(reg_idx));
+		} while (--wait_loop && !(rxdctl & SXEVF_RXDCTL_ENABLE));
+	} else {
+		rxdctl &= ~SXEVF_RXDCTL_ENABLE;
+		SXEVF_REG_WRITE(hw, SXE_VFRXDCTL(reg_idx), rxdctl);
+
+		do {
+			usleep_range(1000, 2000);
+			rxdctl = SXEVF_REG_READ(hw, SXE_VFRXDCTL(reg_idx));
+		} while (--wait_loop && (rxdctl & SXEVF_RXDCTL_ENABLE));
+	}
+
+	SXEVF_WRITE_FLUSH(hw);
+
+	if (!wait_loop) {
+		LOG_DEV_ERR("rx ring %u switch %u failed within "
+			  "the polling period", reg_idx, is_on);
+	}
+}
+
+void sxevf_rx_ring_desc_configure(struct sxevf_hw *hw, u32 desc_mem_len,
+					u64 desc_dma_addr, u8 reg_idx)
+{
+	SXEVF_REG_WRITE(hw, SXE_VFRDBAL(reg_idx),
+			(desc_dma_addr & DMA_BIT_MASK(32)));
+	SXEVF_REG_WRITE(hw, SXE_VFRDBAH(reg_idx), (desc_dma_addr >> 32));
+	SXEVF_REG_WRITE(hw, SXE_VFRDLEN(reg_idx), desc_mem_len);
+
+	SXEVF_WRITE_FLUSH(hw);
+
+	SXEVF_REG_WRITE(hw, SXE_VFRDH(reg_idx), 0);
+	SXEVF_REG_WRITE(hw, SXE_VFRDT(reg_idx), 0);
+}
+
+void sxevf_rx_rcv_ctl_configure(struct sxevf_hw *hw, u8 reg_idx,
+				   u32 header_buf_len, u32 pkg_buf_len, bool drop_en)
+{
+	u32 srrctl = 0;
+
+	if (drop_en)
+		srrctl = SXEVF_SRRCTL_DROP_EN;
+
+	srrctl |= ((header_buf_len << SXEVF_SRRCTL_BSIZEHDRSIZE_SHIFT) &
+			SXEVF_SRRCTL_BSIZEHDR_MASK);
+	srrctl |= ((pkg_buf_len >> SXEVF_SRRCTL_BSIZEPKT_SHIFT) &
+			SXEVF_SRRCTL_BSIZEPKT_MASK);
+
+	SXEVF_REG_WRITE(hw, SXE_VFSRRCTL(reg_idx), srrctl);
+}
+
+static void sxevf_tx_ring_info_get(struct sxevf_hw *hw,
+				u8 idx, u32 *head, u32 *tail)
+{
+	*head = SXEVF_REG_READ(hw, SXE_VFTDH(idx));
+	*tail = SXEVF_REG_READ(hw, SXE_VFTDT(idx));
+}
+
+static const struct sxevf_dma_operations sxevf_dma_ops = {
+	.tx_ring_desc_configure	= sxevf_tx_ring_desc_configure,
+	.tx_writeback_off	= sxevf_tx_writeback_off,
+	.tx_desc_thresh_set	= sxevf_tx_desc_thresh_set,
+	.tx_ring_switch		= sxevf_tx_ring_switch,
+	.tx_ring_info_get	= sxevf_tx_ring_info_get,
+
+	.rx_disable		= sxevf_rx_disable,
+	.rx_ring_switch		= sxevf_rx_ring_switch,
+	.rx_ring_desc_configure	= sxevf_rx_ring_desc_configure,
+	.rx_rcv_ctl_configure	= sxevf_rx_rcv_ctl_configure,
+};
+
+#ifdef SXE_DPDK
+#define SXEVF_32BIT_COUNTER_UPDATE(reg, last, cur) \
+	{ \
+		u32 latest = SXEVF_REG_READ(hw, reg); \
+		(cur) += (latest - (last)) & UINT_MAX; \
+		last = latest; \
+	}
+
+#define SXEVF_36BIT_COUNTER_UPDATE(lsb, msb, last, cur) \
+	{ \
+		u64 new_lsb = SXEVF_REG_READ(hw, lsb); \
+		u64 new_msb = SXEVF_REG_READ(hw, msb); \
+		u64 latest = ((new_msb << 32) | new_lsb); \
+		(cur) += (0x1000000000LL + latest - (last)) & 0xFFFFFFFFFLL; \
+		last = latest; \
+	}
+
+#else
+#define SXEVF_32BIT_COUNTER_UPDATE(reg, last_counter, counter)	\
+	{ \
+		u32 current_counter = SXEVF_REG_READ(hw, reg); \
+		if (current_counter < (last_counter)) \
+			(counter) += 0x100000000LL; \
+		last_counter = current_counter; \
+		(counter) &= 0xFFFFFFFF00000000LL; \
+		(counter) |= current_counter; \
+	}
+
+#define SXEVF_36BIT_COUNTER_UPDATE(reg_lsb, reg_msb, last_counter, counter) \
+	{								 \
+		u64 current_counter_lsb = SXEVF_REG_READ(hw, reg_lsb);	 \
+		u64 current_counter_msb = SXEVF_REG_READ(hw, reg_msb);	 \
+		u64 current_counter = (current_counter_msb << 32) |	 \
+			current_counter_lsb;				 \
+		if (current_counter < (last_counter))			 \
+			(counter) += 0x1000000000LL;			 \
+		last_counter = current_counter;				 \
+		(counter) &= 0xFFFFFFF000000000LL;			 \
+		(counter) |= current_counter;				 \
+	}
+#endif
+
+void sxevf_packet_stats_get(struct sxevf_hw *hw,
+				struct sxevf_hw_stats *stats)
+{
+	SXEVF_32BIT_COUNTER_UPDATE(SXEVF_VFGPRC, stats->last_vfgprc,
+				stats->vfgprc);
+	SXEVF_32BIT_COUNTER_UPDATE(SXEVF_VFGPTC, stats->last_vfgptc,
+				stats->vfgptc);
+	SXEVF_36BIT_COUNTER_UPDATE(SXEVF_VFGORC_LSB, SXEVF_VFGORC_MSB,
+				stats->last_vfgorc,
+				stats->vfgorc);
+	SXEVF_36BIT_COUNTER_UPDATE(SXEVF_VFGOTC_LSB, SXEVF_VFGOTC_MSB,
+				stats->last_vfgotc,
+				stats->vfgotc);
+	SXEVF_32BIT_COUNTER_UPDATE(SXEVF_VFMPRC, stats->last_vfmprc,
+				stats->vfmprc);
+}
+
+void sxevf_stats_init_value_get(struct sxevf_hw *hw,
+				struct sxevf_hw_stats *stats)
+{
+	stats->last_vfgprc = SXEVF_REG_READ(hw, SXE_VFGPRC);
+	stats->last_vfgorc = SXEVF_REG_READ(hw, SXE_VFGORC_LSB);
+	stats->last_vfgorc |= (((u64)(SXEVF_REG_READ(hw, SXE_VFGORC_MSB))) << 32);
+	stats->last_vfgptc = SXEVF_REG_READ(hw, SXE_VFGPTC);
+	stats->last_vfgotc = SXEVF_REG_READ(hw, SXE_VFGOTC_LSB);
+	stats->last_vfgotc |= (((u64)(SXEVF_REG_READ(hw, SXE_VFGOTC_MSB))) << 32);
+	stats->last_vfmprc = SXEVF_REG_READ(hw, SXE_VFMPRC);
+}
+static const struct sxevf_stat_operations sxevf_stat_ops = {
+	.packet_stats_get	= sxevf_packet_stats_get,
+	.stats_init_value_get	= sxevf_stats_init_value_get,
+};
+
+static void sxevf_rx_max_used_ring_set(struct sxevf_hw *hw, u16 max_rx_ring)
+{
+	u32 rqpl = 0;
+
+	if (max_rx_ring > 1)
+		rqpl |= BIT(29);
+
+	SXEVF_REG_WRITE(hw, SXE_VFPSRTYPE, rqpl);
+}
+
+static const struct sxevf_dbu_operations sxevf_dbu_ops = {
+	.rx_max_used_ring_set = sxevf_rx_max_used_ring_set,
+};
+
+static const struct sxevf_mbx_operations sxevf_mbx_ops = {
+	.mailbox_read		= sxevf_mailbox_read,
+	.mailbox_write		= sxevf_mailbox_write,
+
+	.msg_write		= sxevf_msg_write,
+	.msg_read		= sxevf_msg_read,
+
+	.pf_req_irq_trigger	= sxevf_pf_req_irq_trigger,
+	.pf_ack_irq_trigger	= sxevf_pf_ack_irq_trigger,
+};
+
+void sxevf_hw_ops_init(struct sxevf_hw *hw)
+{
+	hw->setup.ops	= &sxevf_setup_ops;
+	hw->irq.ops	= &sxevf_irq_ops;
+	hw->mbx.ops	= &sxevf_mbx_ops;
+	hw->dma.ops	= &sxevf_dma_ops;
+	hw->stat.ops	= &sxevf_stat_ops;
+	hw->dbu.ops	= &sxevf_dbu_ops;
+}
+
+#ifdef SXE_DPDK
+
+#define SXEVF_RSS_FIELD_MASK		0xffff0000
+#define SXEVF_MRQC_RSSEN			0x00000001
+
+#define SXEVF_RSS_KEY_SIZE				(40)
+#define SXEVF_MAX_RSS_KEY_ENTRIES	  (10)
+#define SXEVF_MAX_RETA_ENTRIES			(128)
+
+void sxevf_rxtx_reg_init(struct sxevf_hw *hw)
+{
+	int i;
+	u32 vfsrrctl;
+
+	vfsrrctl = 0x100 << SXEVF_SRRCTL_BSIZEHDRSIZE_SHIFT;
+	vfsrrctl |= 0x800 >> SXEVF_SRRCTL_BSIZEPKT_SHIFT;
+
+	SXEVF_REG_WRITE(hw, SXE_VFPSRTYPE, 0);
+
+	for (i = 0; i < 7; i++) {
+		SXEVF_REG_WRITE(hw, SXE_VFRDH(i), 0);
+		SXEVF_REG_WRITE(hw, SXE_VFRDT(i), 0);
+		SXEVF_REG_WRITE(hw, SXE_VFRXDCTL(i), 0);
+		SXEVF_REG_WRITE(hw, SXE_VFSRRCTL(i), vfsrrctl);
+		SXEVF_REG_WRITE(hw, SXE_VFTDH(i), 0);
+		SXEVF_REG_WRITE(hw, SXE_VFTDT(i), 0);
+		SXEVF_REG_WRITE(hw, SXE_VFTXDCTL(i), 0);
+		SXEVF_REG_WRITE(hw, SXE_VFTDWBAH(i), 0);
+		SXEVF_REG_WRITE(hw, SXE_VFTDWBAL(i), 0);
+	}
+
+	SXEVF_WRITE_FLUSH(hw);
+}
+
+u32 sxevf_irq_cause_get(struct sxevf_hw *hw)
+{
+	return SXEVF_REG_READ(hw, SXE_VFEICR);
+}
+
+void sxevf_tx_desc_configure(struct sxevf_hw *hw, u32 desc_mem_len,
+				u64 desc_dma_addr, u8 reg_idx)
+{
+	SXEVF_REG_WRITE(hw, SXEVF_TDBAL(reg_idx), (desc_dma_addr &
+						DMA_BIT_MASK(32)));
+	SXEVF_REG_WRITE(hw, SXEVF_TDBAH(reg_idx), (desc_dma_addr >> 32));
+	SXEVF_REG_WRITE(hw, SXEVF_TDLEN(reg_idx), desc_mem_len);
+	SXEVF_REG_WRITE(hw, SXEVF_TDH(reg_idx), 0);
+	SXEVF_REG_WRITE(hw, SXEVF_TDT(reg_idx), 0);
+}
+
+void sxevf_rss_bit_num_set(struct sxevf_hw *hw, u32 value)
+{
+	SXEVF_REG_WRITE(hw, SXE_VFPSRTYPE, value);
+}
+
+void sxevf_hw_vlan_tag_strip_switch(struct sxevf_hw *hw,
+					u16 reg_index, bool is_enable)
+{
+	u32 vlnctrl;
+
+	vlnctrl = SXEVF_REG_READ(hw, SXE_VFRXDCTL(reg_index));
+
+	if (is_enable)
+		vlnctrl |= SXEVF_RXDCTL_VME;
+	else
+		vlnctrl &= ~SXEVF_RXDCTL_VME;
+
+	SXEVF_REG_WRITE(hw, SXE_VFRXDCTL(reg_index), vlnctrl);
+}
+
+void sxevf_tx_queue_thresh_set(struct sxevf_hw *hw, u8 reg_idx,
+				u32 prefech_thresh, u32 host_thresh, u32 wb_thresh)
+{
+	u32 txdctl = SXEVF_REG_READ(hw, SXEVF_TXDCTL(reg_idx));
+
+	txdctl |= (prefech_thresh & SXEVF_TXDCTL_THRESH_MASK);
+	txdctl |= ((host_thresh & SXEVF_TXDCTL_THRESH_MASK) << SXEVF_TXDCTL_HTHRESH_SHIFT);
+	txdctl |= ((wb_thresh & SXEVF_TXDCTL_THRESH_MASK) << SXEVF_TXDCTL_WTHRESH_SHIFT);
+
+	SXEVF_REG_WRITE(hw, SXEVF_TXDCTL(reg_idx), txdctl);
+}
+
+void sxevf_rx_desc_tail_set(struct sxevf_hw *hw, u8 reg_idx, u32 value)
+{
+	SXEVF_REG_WRITE(hw, SXE_VFRDT(reg_idx), value);
+}
+
+u32 sxevf_hw_rss_redir_tbl_get(struct sxevf_hw *hw, u16 reg_idx)
+{
+	return SXEVF_REG_READ(hw, SXE_VFRETA(reg_idx >> 2));
+}
+
+void sxevf_hw_rss_redir_tbl_set(struct sxevf_hw *hw,
+						u16 reg_idx, u32 value)
+{
+	SXEVF_REG_WRITE(hw, SXE_VFRETA(reg_idx >> 2), value);
+}
+
+u32 sxevf_hw_rss_key_get(struct sxevf_hw *hw, u8 reg_idx)
+{
+	u32 rss_key;
+
+	if (reg_idx >= SXEVF_MAX_RSS_KEY_ENTRIES)
+		rss_key = 0;
+	else
+		rss_key = SXEVF_REG_READ(hw, SXE_VFRSSRK(reg_idx));
+
+	return rss_key;
+}
+
+u32 sxevf_hw_rss_field_get(struct sxevf_hw *hw)
+{
+	u32 mrqc = SXEVF_REG_READ(hw, SXE_VFMRQC);
+	return (mrqc & SXEVF_RSS_FIELD_MASK);
+}
+
+bool sxevf_hw_is_rss_enabled(struct sxevf_hw *hw)
+{
+	bool rss_enable = false;
+	u32 mrqc = SXEVF_REG_READ(hw, SXE_VFMRQC);
+	if (mrqc & SXEVF_MRQC_RSSEN)
+		rss_enable = true;
+
+	return rss_enable;
+}
+
+void sxevf_hw_rss_key_set_all(struct sxevf_hw *hw, u32 *rss_key)
+{
+	u32 i;
+
+	for (i = 0; i < SXEVF_MAX_RSS_KEY_ENTRIES; i++)
+		SXEVF_REG_WRITE(hw, SXE_VFRSSRK(i), rss_key[i]);
+}
+
+void sxevf_hw_rss_cap_switch(struct sxevf_hw *hw, bool is_on)
+{
+	u32 mrqc = SXEVF_REG_READ(hw, SXE_VFMRQC);
+	if (is_on)
+		mrqc |= SXEVF_MRQC_RSSEN;
+	else
+		mrqc &= ~SXEVF_MRQC_RSSEN;
+
+	SXEVF_REG_WRITE(hw, SXE_VFMRQC, mrqc);
+}
+
+void sxevf_hw_rss_field_set(struct sxevf_hw *hw, u32 rss_field)
+{
+	u32 mrqc = SXEVF_REG_READ(hw, SXE_VFMRQC);
+
+	mrqc &= ~SXEVF_RSS_FIELD_MASK;
+	mrqc |= rss_field;
+	SXEVF_REG_WRITE(hw, SXE_VFMRQC, mrqc);
+}
+
+u32 sxevf_hw_regs_group_read(struct sxevf_hw *hw,
+				const struct sxevf_reg_info *regs,
+				u32 *reg_buf)
+{
+	u32 j, i = 0;
+	int count = 0;
+
+	while (regs[i].count) {
+		for (j = 0; j < regs[i].count; j++) {
+			reg_buf[count + j] = SXEVF_REG_READ(hw,
+					regs[i].addr + j * regs[i].stride);
+			LOG_INFO("regs= %s, regs_addr=%x, regs_value=%04x",
+				regs[i].name, regs[i].addr, reg_buf[count + j]);
+		}
+
+		i++;
+		count += j;
+	}
+
+	return count;
+};
+
+#endif
diff --git a/drivers/net/sxe/base/sxevf_hw.h b/drivers/net/sxe/base/sxevf_hw.h
new file mode 100644
index 0000000000..ede6238c0c
--- /dev/null
+++ b/drivers/net/sxe/base/sxevf_hw.h
@@ -0,0 +1,349 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+
+#ifndef __SXEVF_HW_H__
+#define __SXEVF_HW_H__
+
+#if defined(__KERNEL__) || defined(SXE_KERNEL_TEST)
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/if_ether.h>
+#else
+#include "sxe_compat_platform.h"
+#ifdef SXE_HOST_DRIVER
+#include "sxe_drv_type.h"
+#endif
+#endif
+
+#include "sxevf_regs.h"
+
+#if defined(__KERNEL__) || defined(SXE_KERNEL_TEST)
+#define SXE_PRIU64  "llu"
+#define SXE_PRIX64  "llx"
+#define SXE_PRID64  "lld"
+#else
+#define SXE_PRIU64  PRIu64
+#define SXE_PRIX64  PRIx64
+#define SXE_PRID64  PRId64
+#endif
+
+#define SXEVF_TXRX_RING_NUM_MAX		   8
+#define SXEVF_MAX_TXRX_DESC_POLL		  (10)
+#define SXEVF_TX_DESC_PREFETCH_THRESH_32  (32)
+#define SXEVF_TX_DESC_HOST_THRESH_1	   (1)
+#define SXEVF_TX_DESC_WRITEBACK_THRESH_8  (8)
+#define SXEVF_TXDCTL_HTHRESH_SHIFT		(8)
+#define SXEVF_TXDCTL_WTHRESH_SHIFT		(16)
+
+#define SXEVF_TXDCTL_THRESH_MASK		  (0x7F)
+
+#define SXEVF_RX_RING_POLL_MAX		   (10)
+
+#define SXEVF_MAC_HDR_LEN_MAX		   (127)
+#define SXEVF_NETWORK_HDR_LEN_MAX	   (511)
+
+#define SXEVF_LINK_SPEED_UNKNOWN		0
+#define SXEVF_LINK_SPEED_1GB_FULL	0x0020
+#define SXEVF_LINK_SPEED_10GB_FULL	0x0080
+#define SXEVF_LINK_SPEED_100_FULL	0x0008
+
+#define SXEVF_VFT_TBL_SIZE		   (128)
+#define SXEVF_HW_TXRX_RING_NUM_MAX   (128)
+
+#define SXEVF_VLAN_TAG_SIZE		  (4)
+
+#define SXEVF_HW_UC_ENTRY_NUM_MAX   128
+
+enum {
+	SXEVF_LINK_TO_PHY   = 0,
+	SXEVF_LINK_TO_DOWN,
+	SXEVF_LINK_TO_REINIT,
+};
+
+enum {
+	SXEVF_DIAG_TEST_PASSED			= 0,
+	SXEVF_DIAG_TEST_BLOCKED			= 1,
+	SXEVF_DIAG_REG_PATTERN_TEST_ERR		= 2,
+	SXEVF_DIAG_CHECK_REG_TEST_ERR		   = 3,
+};
+
+struct sxevf_hw;
+
+struct sxevf_hw_stats {
+	u64 base_vfgprc;
+	u64 base_vfgptc;
+	u64 base_vfgorc;
+	u64 base_vfgotc;
+	u64 base_vfmprc;
+
+	u64 last_vfgprc;
+	u64 last_vfgptc;
+	u64 last_vfgorc;
+	u64 last_vfgotc;
+	u64 last_vfmprc;
+
+	u64 vfgprc;
+	u64 vfgptc;
+	u64 vfgorc;
+	u64 vfgotc;
+	u64 vfmprc;
+
+	u64 saved_reset_vfgprc;
+	u64 saved_reset_vfgptc;
+	u64 saved_reset_vfgorc;
+	u64 saved_reset_vfgotc;
+	u64 saved_reset_vfmprc;
+};
+
+void sxevf_hw_ops_init(struct sxevf_hw *hw);
+
+
+struct sxevf_setup_operations {
+	void (*reset)(struct sxevf_hw *hw);
+	void (*hw_stop)(struct sxevf_hw *hw);
+	s32  (*regs_test)(struct sxevf_hw *hw);
+	u32  (*link_state_get)(struct sxevf_hw *hw);
+	u32  (*regs_dump)(struct sxevf_hw *hw, u32 *regs_buff, u32 buf_size);
+	bool (*reset_done)(struct sxevf_hw *hw);
+};
+
+struct sxevf_hw_setup {
+	const struct sxevf_setup_operations *ops;
+};
+
+struct sxevf_irq_operations {
+	void (*pending_irq_clear)(struct sxevf_hw *hw);
+	void (*ring_irq_interval_set)(struct sxevf_hw *hw, u16 irq_idx, u32 interval);
+	void (*event_irq_interval_set)(struct sxevf_hw *hw, u16 irq_idx, u32 value);
+	void (*ring_irq_map)(struct sxevf_hw *hw, bool is_tx, u16 hw_ring_idx, u16 irq_idx);
+	void (*event_irq_map)(struct sxevf_hw *hw, u16 irq_idx);
+	void (*ring_irq_trigger)(struct sxevf_hw *hw, u64 eics);
+	void (*irq_enable)(struct sxevf_hw *hw, u32 mask);
+	void (*specific_irq_enable)(struct sxevf_hw *hw, u32 value);
+	void (*irq_disable)(struct sxevf_hw *hw);
+	void (*irq_off)(struct sxevf_hw *hw);
+};
+
+struct sxevf_irq_info {
+	const struct sxevf_irq_operations *ops;
+};
+
+struct sxevf_mbx_operations {
+	u32 (*mailbox_read)(struct sxevf_hw *hw);
+	void (*mailbox_write)(struct sxevf_hw *hw, u32 value);
+
+	void (*msg_write)(struct sxevf_hw *hw, u8 index, u32 msg);
+	u32 (*msg_read)(struct sxevf_hw *hw, u8 index);
+
+	void (*pf_req_irq_trigger)(struct sxevf_hw *hw);
+	void (*pf_ack_irq_trigger)(struct sxevf_hw *hw);
+};
+
+struct sxevf_mbx_stats {
+	u32 send_msgs;
+	u32 rcv_msgs;
+
+	u32 reqs;
+	u32 acks;
+	u32 rsts;
+};
+
+struct sxevf_mbx_info {
+	const struct sxevf_mbx_operations *ops;
+
+	struct sxevf_mbx_stats stats;
+	u32 msg_len;
+	u32 retry;
+	u32 interval;
+	u32 reg_value;
+	u32 api_version;
+};
+
+struct sxevf_dma_operations {
+	void (*tx_ring_desc_configure)(struct sxevf_hw *hw, u32 desc_mem_len,
+				u64 desc_dma_addr, u8 reg_idx);
+	void (*tx_writeback_off)(struct sxevf_hw *hw, u8 reg_idx);
+	void (*tx_desc_thresh_set)(struct sxevf_hw *hw, u8 reg_idx,
+				u32 wb_thresh, u32 host_thresh, u32 prefech_thresh);
+	void (*tx_ring_switch)(struct sxevf_hw *hw, u8 reg_idx, bool is_on);
+	void (*tx_desc_wb_flush)(struct sxevf_hw *hw, u8 val);
+	void (*tx_ring_info_get)(struct sxevf_hw *hw, u8 reg_idx,
+					u32 *head, u32 *tail);
+	void (*rx_disable)(struct sxevf_hw *hw, u8 reg_idx);
+	void (*rx_ring_switch)(struct sxevf_hw *hw, u8 reg_idx, bool is_on);
+	void (*rx_ring_desc_configure)(struct sxevf_hw *hw, u32 desc_mem_len,
+				u64 desc_dma_addr, u8 reg_idx);
+	void (*rx_rcv_ctl_configure)(struct sxevf_hw *hw, u8 reg_idx,
+				   u32 header_buf_len, u32 pkg_buf_len, bool drop_en);
+};
+
+struct sxevf_dma_info {
+	const struct sxevf_dma_operations *ops;
+};
+
+struct sxevf_stat_operations {
+	void (*packet_stats_get)(struct sxevf_hw *hw,
+			struct sxevf_hw_stats *stats);
+	void (*stats_init_value_get)(struct sxevf_hw *hw,
+				struct sxevf_hw_stats *stats);
+};
+
+struct sxevf_stat_info {
+	const struct sxevf_stat_operations *ops;
+};
+
+struct sxevf_dbu_operations {
+	void (*rx_max_used_ring_set)(struct sxevf_hw *hw, u16 max_rx_ring);
+
+};
+
+struct sxevf_dbu_info {
+	const struct sxevf_dbu_operations	*ops;
+};
+
+enum sxevf_hw_state {
+	SXEVF_HW_STOP,
+	SXEVF_HW_FAULT,
+};
+
+struct sxevf_hw {
+	u8 __iomem *reg_base_addr;
+	void *adapter;
+
+	void *priv;
+	unsigned long state;
+	void (*fault_handle)(void *priv);
+	u32 (*reg_read)(const volatile void *reg);
+	void (*reg_write)(u32 value, volatile void *reg);
+	s32	board_type;
+
+	struct sxevf_hw_setup   setup;
+	struct sxevf_irq_info   irq;
+	struct sxevf_mbx_info   mbx;
+
+	struct sxevf_dma_info	dma;
+	struct sxevf_stat_info   stat;
+	struct sxevf_dbu_info	dbu;
+};
+
+struct sxevf_reg_info {
+	u32 addr;
+	u32 count;
+	u32 stride;
+	const s8 *name;
+};
+
+u16 sxevf_reg_dump_num_get(void);
+
+void sxevf_hw_fault_handle(struct sxevf_hw *hw);
+
+static inline bool sxevf_is_hw_fault(struct sxevf_hw *hw)
+{
+	return test_bit(SXEVF_HW_FAULT, &hw->state);
+}
+
+static inline void sxevf_hw_fault_handle_init(struct sxevf_hw *hw,
+			void (*handle)(void *), void *priv)
+{
+	hw->priv = priv;
+	hw->fault_handle = handle;
+}
+
+static inline void sxevf_hw_reg_handle_init(struct sxevf_hw *hw,
+		u32 (*read)(const volatile void *),
+		void (*write)(u32, volatile void *))
+{
+	hw->reg_read  = read;
+	hw->reg_write = write;
+}
+
+#ifdef SXE_DPDK
+
+void sxevf_irq_disable(struct sxevf_hw *hw);
+
+void sxevf_hw_stop(struct sxevf_hw *hw);
+
+void sxevf_hw_reset(struct sxevf_hw *hw);
+
+void sxevf_msg_write(struct sxevf_hw *hw, u8 index, u32 msg);
+
+u32 sxevf_msg_read(struct sxevf_hw *hw, u8 index);
+
+u32 sxevf_mailbox_read(struct sxevf_hw *hw);
+
+void sxevf_mailbox_write(struct sxevf_hw *hw, u32 value);
+
+void sxevf_pf_req_irq_trigger(struct sxevf_hw *hw);
+
+void sxevf_pf_ack_irq_trigger(struct sxevf_hw *hw);
+
+void sxevf_rxtx_reg_init(struct sxevf_hw *hw);
+
+void sxevf_irq_enable(struct sxevf_hw *hw, u32 mask);
+
+u32 sxevf_irq_cause_get(struct sxevf_hw *hw);
+
+void sxevf_event_irq_map(struct sxevf_hw *hw, u16 vector);
+
+void sxevf_hw_ring_irq_map(struct sxevf_hw *hw, bool is_tx, u16 hw_ring_idx, u16 vector);
+
+void sxevf_ring_irq_interval_set(struct sxevf_hw *hw, u16 irq_idx, u32 interval);
+
+void sxevf_tx_desc_configure(struct sxevf_hw *hw, u32 desc_mem_len,
+				u64 desc_dma_addr, u8 reg_idx);
+
+void sxevf_rx_ring_desc_configure(struct sxevf_hw *hw, u32 desc_mem_len,
+					u64 desc_dma_addr, u8 reg_idx);
+
+void sxevf_rx_rcv_ctl_configure(struct sxevf_hw *hw, u8 reg_idx,
+				   u32 header_buf_len, u32 pkg_buf_len,
+				   bool drop_en);
+
+void sxevf_rss_bit_num_set(struct sxevf_hw *hw, u32 value);
+
+void sxevf_hw_vlan_tag_strip_switch(struct sxevf_hw *hw,
+					u16 reg_index, bool is_enable);
+
+void sxevf_tx_queue_thresh_set(struct sxevf_hw *hw, u8 reg_idx,
+				u32 prefech_thresh, u32 host_thresh, u32 wb_thresh);
+
+void sxevf_tx_ring_switch(struct sxevf_hw *hw, u8 reg_idx, bool is_on);
+
+void sxevf_rx_ring_switch(struct sxevf_hw *hw, u8 reg_idx, bool is_on);
+
+void sxevf_rx_desc_tail_set(struct sxevf_hw *hw, u8 reg_idx, u32 value);
+
+void sxevf_specific_irq_enable(struct sxevf_hw *hw, u32 value);
+
+void sxevf_packet_stats_get(struct sxevf_hw *hw,
+				struct sxevf_hw_stats *stats);
+
+void sxevf_stats_init_value_get(struct sxevf_hw *hw,
+				struct sxevf_hw_stats *stats);
+
+u32 sxevf_hw_rss_redir_tbl_get(struct sxevf_hw *hw, u16 reg_idx);
+
+void sxevf_hw_rss_redir_tbl_set(struct sxevf_hw *hw,
+						u16 reg_idx, u32 value);
+
+u32 sxevf_hw_rss_key_get(struct sxevf_hw *hw, u8 reg_idx);
+
+u32 sxevf_hw_rss_field_get(struct sxevf_hw *hw);
+
+void sxevf_hw_rss_field_set(struct sxevf_hw *hw, u32 rss_field);
+
+void sxevf_hw_rss_cap_switch(struct sxevf_hw *hw, bool is_on);
+
+void sxevf_hw_rss_key_set_all(struct sxevf_hw *hw, u32 *rss_key);
+
+bool sxevf_hw_is_rss_enabled(struct sxevf_hw *hw);
+
+u32 sxevf_link_state_get(struct sxevf_hw *hw);
+
+u32 sxevf_hw_regs_group_read(struct sxevf_hw *hw,
+				const struct sxevf_reg_info *regs,
+				u32 *reg_buf);
+
+#endif
+#endif
diff --git a/drivers/net/sxe/base/sxevf_regs.h b/drivers/net/sxe/base/sxevf_regs.h
new file mode 100644
index 0000000000..50a22f559c
--- /dev/null
+++ b/drivers/net/sxe/base/sxevf_regs.h
@@ -0,0 +1,119 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+
+#ifndef __SXEVF_REGS_H__
+#define __SXEVF_REGS_H__
+
+#define SXEVF_REG_READ_FAIL  0xffffffffU
+#define SXEVF_REG_READ_RETRY 5
+
+#define SXE_VFLINKS_UP		0x00000008
+#define SXE_VFLINKS_SPEED	0x00000006
+#define SXE_VFLINKS_SPEED_10G	0x00000006
+#define SXE_VFLINKS_SPEED_1G	0x00000004
+#define SXE_VFLINKS_SPEED_100	0x00000002
+
+#define SXE_VFCTRL		0x00000
+#define SXE_VFSTATUS	  0x00008
+#define SXE_VFLINKS	   0x00018
+#define SXE_VFFRTIMER	 0x00048
+#define SXE_VFRXMEMWRAP   0x03190
+#define SXE_VFEICR		0x00100
+#define SXE_VFEICS		0x00104
+#define SXE_VFEIMS		0x00108
+#define SXE_VFEIMC		0x0010C
+#define SXE_VFEIAM		0x00114
+#define SXE_VFEITR(x)	 (0x00820 + (4 * (x)))
+#define SXE_VFIVAR(x)	 (0x00120 + (4 * (x)))
+#define SXE_VFIVAR_MISC	0x00140
+#define SXE_VFRDBAL(x)	(0x01000 + (0x40 * (x)))
+#define SXE_VFRDBAH(x)	(0x01004 + (0x40 * (x)))
+#define SXE_VFRDLEN(x)	(0x01008 + (0x40 * (x)))
+#define SXE_VFRDH(x)	  (0x01010 + (0x40 * (x)))
+#define SXE_VFRDT(x)	  (0x01018 + (0x40 * (x)))
+#define SXE_VFRXDCTL(x)   (0x01028 + (0x40 * (x)))
+#define SXE_VFSRRCTL(x)   (0x01014 + (0x40 * (x)))
+#define SXE_VFLROCTL(x)   (0x0102C + (0x40 * (x)))
+#define SXE_VFPSRTYPE	 0x00300
+#define SXE_VFTDBAL(x)	(0x02000 + (0x40 * (x)))
+#define SXE_VFTDBAH(x)	(0x02004 + (0x40 * (x)))
+#define SXE_VFTDLEN(x)	(0x02008 + (0x40 * (x)))
+#define SXE_VFTDH(x)	  (0x02010 + (0x40 * (x)))
+#define SXE_VFTDT(x)	  (0x02018 + (0x40 * (x)))
+#define SXE_VFTXDCTL(x)   (0x02028 + (0x40 * (x)))
+#define SXE_VFTDWBAL(x)   (0x02038 + (0x40 * (x)))
+#define SXE_VFTDWBAH(x)   (0x0203C + (0x40 * (x)))
+#define SXE_VFDCA_RXCTRL(x)	(0x0100C + (0x40 * (x)))
+#define SXE_VFDCA_TXCTRL(x)	(0x0200c + (0x40 * (x)))
+#define SXE_VFGPRC		0x0101C
+#define SXE_VFGPTC		0x0201C
+#define SXE_VFGORC_LSB	0x01020
+#define SXE_VFGORC_MSB	0x01024
+#define SXE_VFGOTC_LSB	0x02020
+#define SXE_VFGOTC_MSB	0x02024
+#define SXE_VFMPRC		0x01034
+#define SXE_VFMRQC		0x3000
+#define SXE_VFRSSRK(x)	(0x3100 + ((x) * 4))
+#define SXE_VFRETA(x)	 (0x3200 + ((x) * 4))
+
+#define SXEVF_VFEIMC_IRQ_MASK			(7)
+#define SXEVF_IVAR_ALLOC_VALID	(0x80)
+
+#define SXEVF_EITR_CNT_WDIS	   (0x80000000)
+#define SXEVF_EITR_ITR_MASK	   (0x00000FF8)
+#define SXEVF_EITR_ITR_SHIFT	  (2)
+#define SXEVF_EITR_ITR_MAX		(SXEVF_EITR_ITR_MASK >> SXEVF_EITR_ITR_SHIFT)
+
+#define SXE_VFRXDCTL_ENABLE  0x02000000
+#define SXE_VFTXDCTL_ENABLE  0x02000000
+#define SXE_VFCTRL_RST	   0x04000000
+
+#define SXEVF_RXDCTL_ENABLE	 0x02000000
+#define SXEVF_RXDCTL_VME	0x40000000
+
+#define SXEVF_PSRTYPE_RQPL_SHIFT			   29
+
+#define SXEVF_SRRCTL_DROP_EN				   0x10000000
+#define SXEVF_SRRCTL_DESCTYPE_DATA_ONEBUF	  0x02000000
+#define SXEVF_SRRCTL_BSIZEPKT_SHIFT			(10)
+#define SXEVF_SRRCTL_BSIZEHDRSIZE_SHIFT		(2)
+#define SXEVF_SRRCTL_BSIZEPKT_MASK		   0x0000007F
+#define SXEVF_SRRCTL_BSIZEHDR_MASK		   0x00003F00
+
+#define SXE_VFMAILBOX	   0x002FC
+#define SXE_VFMBMEM		 0x00200
+
+#define SXE_VFMAILBOX_REQ	 0x00000001
+#define SXE_VFMAILBOX_ACK	 0x00000002
+#define SXE_VFMAILBOX_VFU	 0x00000004
+#define SXE_VFMAILBOX_PFU	 0x00000008
+#define SXE_VFMAILBOX_PFSTS   0x00000010
+#define SXE_VFMAILBOX_PFACK   0x00000020
+#define SXE_VFMAILBOX_RSTI	0x00000040
+#define SXE_VFMAILBOX_RSTD	0x00000080
+#define SXE_VFMAILBOX_RC_BIT  0x000000B0
+
+#define SXEVF_TDBAL(_i)	  (0x02000 + ((_i) * 0x40))
+#define SXEVF_TDBAH(_i)	  (0x02004 + ((_i) * 0x40))
+#define SXEVF_TDLEN(_i)	  (0x02008 + ((_i) * 0x40))
+#define SXEVF_TDH(_i)		(0x02010 + ((_i) * 0x40))
+#define SXEVF_TDT(_i)		(0x02018 + ((_i) * 0x40))
+#define SXEVF_TXDCTL(_i)	 (0x02028 + ((_i) * 0x40))
+#define SXEVF_TDWBAL(_i)	 (0x02038 + ((_i) * 0x40))
+#define SXEVF_TDWBAH(_i)	 (0x0203C + ((_i) * 0x40))
+
+#define SXEVF_TXDCTL_SWFLSH  (0x02000000)
+#define SXEVF_TXDCTL_ENABLE  (0x02000000)
+
+#define SXEVF_VFGPRC		  0x0101C
+#define SXEVF_VFGPTC		  0x0201C
+#define SXEVF_VFGORC_LSB	  0x01020
+#define SXEVF_VFGORC_MSB	  0x01024
+#define SXEVF_VFGOTC_LSB	  0x02020
+#define SXEVF_VFGOTC_MSB	  0x02024
+#define SXEVF_VFMPRC		  0x01034
+
+#define SXEVF_EICR_MASK	   0x07
+
+#endif
diff --git a/drivers/net/sxe/include/sxe/sxe_msg.h b/drivers/net/sxe/include/sxe/sxe_msg.h
index 460258c907..19d03d25b2 100644
--- a/drivers/net/sxe/include/sxe/sxe_msg.h
+++ b/drivers/net/sxe/include/sxe/sxe_msg.h
@@ -119,7 +119,7 @@ typedef struct sxe_sfp_rate_able {
 
 
 typedef struct sxe_spp_tx_able {
-	BOOL is_disable;
+	bool is_disable;
 } sxe_spp_tx_able_s;
 
 
@@ -129,7 +129,7 @@ typedef struct sxe_default_mac_addr_resp {
 
 
 typedef struct sxe_mng_rst {
-	BOOL enable;
+	bool enable;
 } sxe_mng_rst_s;
 
 #endif
diff --git a/drivers/net/sxe/pf/rte_pmd_sxe.h b/drivers/net/sxe/pf/rte_pmd_sxe.h
index ce4e121016..4691a7a2d7 100644
--- a/drivers/net/sxe/pf/rte_pmd_sxe.h
+++ b/drivers/net/sxe/pf/rte_pmd_sxe.h
@@ -12,4 +12,5 @@ typedef int32_t		s32;
 
 s32 rte_pmd_sxe_tx_loopback_set(u16 port, u8 on);
 s32 rte_pmd_sxe_tc_bw_set(u8 port, u8 tc_num, u8 *bw_weight);
+int rte_pmd_sxe_set_vf_rxmode(u16 port, u16 vf, u16 rx_mask, u8 on);
 #endif
diff --git a/drivers/net/sxe/pf/sxe_filter.c b/drivers/net/sxe/pf/sxe_filter.c
index df583c960a..8d09d8596f 100644
--- a/drivers/net/sxe/pf/sxe_filter.c
+++ b/drivers/net/sxe/pf/sxe_filter.c
@@ -9,7 +9,9 @@
 #include "sxe_logs.h"
 #include "sxe.h"
 #include "sxe_queue.h"
+#include "drv_msg.h"
 #include "sxe_pmd_hdc.h"
+#include "sxe_cli.h"
 #include "sxe_compat_version.h"
 
 #define PF_POOL_INDEX(p)		(p)
@@ -123,6 +125,45 @@ static u8 sxe_sw_uc_entry_del(struct sxe_adapter *adapter, u8 index)
 	return i;
 }
 
+u8 sxe_sw_uc_entry_vf_add(struct sxe_adapter *adapter,
+				u8 vf_idx, u8 *mac_addr, bool macvlan)
+{
+	u8 i;
+	struct sxe_uc_addr_table *uc_table = adapter->mac_filter_ctxt.uc_addr_table;
+
+	for (i = 0; i < SXE_UC_ENTRY_NUM_MAX; i++) {
+		if (!uc_table[i].used) {
+			uc_table[i].used = true;
+			uc_table[i].rar_idx = i;
+			uc_table[i].pool_idx = vf_idx;
+			uc_table[i].type = macvlan ? SXE_VF_MACVLAN : SXE_VF;
+			rte_memcpy(uc_table[i].addr, mac_addr, SXE_MAC_ADDR_LEN);
+			break;
+		}
+	}
+
+	return i;
+}
+
+void sxe_sw_uc_entry_vf_del(struct sxe_adapter *adapter, u8 vf_idx,
+					bool macvlan)
+{
+	u8 i;
+	struct sxe_uc_addr_table *uc_table = adapter->mac_filter_ctxt.uc_addr_table;
+
+	for (i = 0; i < SXE_UC_ENTRY_NUM_MAX; i++) {
+		if (!uc_table[i].used || uc_table[i].type == SXE_PF)
+			continue;
+
+		if (uc_table[i].pool_idx == vf_idx) {
+			uc_table[i].used = false;
+			sxe_hw_uc_addr_del(&adapter->hw, i);
+			if (!macvlan)
+				break;
+		}
+	}
+}
+
 s32 sxe_mac_addr_init(struct rte_eth_dev *eth_dev)
 {
 	struct sxe_adapter *adapter = eth_dev->data->dev_private;
@@ -340,6 +381,40 @@ s32 sxe_allmulticast_disable(struct rte_eth_dev *dev)
 	return 0;
 }
 
+static void sxe_vf_promisc_mac_update_all(struct rte_eth_dev *dev)
+{
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_vf_info *vf_info = adapter->vt_ctxt.vf_info;
+	struct sxe_uc_addr_table *uc_table = adapter->mac_filter_ctxt.uc_addr_table;
+	u16 vf_num = sxe_vf_num_get(dev);
+	u8 vf_idx = 0;
+	s32 i;
+
+	for (vf_idx = 0; vf_idx < vf_num; vf_idx++) {
+		if (vf_info[vf_idx].cast_mode == SXE_CAST_MODE_PROMISC) {
+			for (i = 0; i < SXE_UC_ENTRY_NUM_MAX; i++) {
+				if (uc_table[i].used) {
+					sxe_hw_uc_addr_pool_enable(&adapter->hw,
+						uc_table[i].rar_idx, vf_idx);
+				}
+			}
+		}
+	}
+}
+
+static void sxe_vf_promisc_mac_update(struct rte_eth_dev *dev, u32 rar_idx)
+{
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_vf_info *vf_info = adapter->vt_ctxt.vf_info;
+	u16 vf_num = sxe_vf_num_get(dev);
+	u8 vf_idx;
+
+	for (vf_idx = 0; vf_idx < vf_num; vf_idx++) {
+		if (vf_info[vf_idx].cast_mode == SXE_CAST_MODE_PROMISC)
+			sxe_hw_uc_addr_pool_enable(&adapter->hw, rar_idx, vf_idx);
+	}
+}
+
 s32 sxe_mac_addr_add(struct rte_eth_dev *dev,
 				 struct rte_ether_addr *mac_addr,
 				 u32 index, u32 pool)
@@ -468,6 +543,108 @@ static void sxe_hash_mac_addr_parse(u8 *mac_addr, u16 *reg_idx,
 			 mac_addr[4], mac_addr[5], *reg_idx, *bit_idx);
 }
 
+s32 sxe_uc_hash_table_set(struct rte_eth_dev *dev,
+			struct rte_ether_addr *mac_addr, u8 on)
+{
+	u16 bit_idx;
+	u16 reg_idx;
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+	struct sxe_mac_filter_context *mac_filter = &adapter->mac_filter_ctxt;
+	u32 value;
+	s32 ret = 0;
+	u8 *addr;
+
+	sxe_hash_mac_addr_parse(mac_addr->addr_bytes, &reg_idx, &bit_idx);
+
+	value = (mac_filter->uta_hash_table[reg_idx] >> bit_idx) & 0x1;
+	if (value == on)
+		goto l_out;
+
+	value = sxe_hw_uta_hash_table_get(hw, reg_idx);
+	if (on) {
+		mac_filter->uta_used_count++;
+		value |= (0x1 << bit_idx);
+		mac_filter->uta_hash_table[reg_idx] |= (0x1 << bit_idx);
+	} else {
+		mac_filter->uta_used_count--;
+		value &= ~(0x1 << bit_idx);
+		mac_filter->uta_hash_table[reg_idx] &= ~(0x1 << bit_idx);
+	}
+
+	sxe_hw_uta_hash_table_set(hw, reg_idx, value);
+
+	addr = mac_addr->addr_bytes;
+	PMD_LOG_INFO(DRV, "mac_addr:" RTE_ETHER_ADDR_PRT_FMT " uta reg_idx:%u bit_idx:%u"
+			  " %s done, uta_used_count:%u",
+			 addr[0], addr[1], addr[2],
+			 addr[3], addr[4], addr[5],
+			 reg_idx, bit_idx,
+			 on ? "set" : "clear",
+			 mac_filter->uta_used_count);
+
+l_out:
+	return ret;
+}
+
+s32 sxe_uc_all_hash_table_set(struct rte_eth_dev *dev, u8 on)
+{
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+	struct sxe_mac_filter_context *mac_filter = &adapter->mac_filter_ctxt;
+	u32 value;
+	u8 i;
+
+	value = on ? (~0) : 0;
+
+	for (i = 0; i < SXE_UTA_ENTRY_NUM_MAX; i++) {
+		mac_filter->uta_hash_table[i] = value;
+		sxe_hw_uta_hash_table_set(hw, i, value);
+	}
+
+	PMD_LOG_INFO(DRV, "uta table all entry %s done.",
+			  on ? "set" : "clear");
+
+	return 0;
+}
+
+s32 sxe_set_mc_addr_list(struct rte_eth_dev *dev,
+			  struct rte_ether_addr *mc_addr_list,
+			  u32 nb_mc_addr)
+{
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+	struct sxe_mac_filter_context *mac_filter = &adapter->mac_filter_ctxt;
+	u16 vf_num = sxe_vf_num_get(dev);
+	u32 vm_l2_ctrl = sxe_hw_pool_rx_mode_get(hw, vf_num);
+	u32 i;
+	u16 bit_idx;
+	u16 reg_idx;
+
+	memset(&mac_filter->mta_hash_table, 0, sizeof(mac_filter->mta_hash_table));
+	for (i = 0; i < nb_mc_addr; i++) {
+		sxe_hash_mac_addr_parse(mc_addr_list->addr_bytes, &reg_idx, &bit_idx);
+		mc_addr_list++;
+		mac_filter->mta_hash_table[reg_idx] |= (0x1 << bit_idx);
+	}
+
+	for (i = 0; i < SXE_MTA_ENTRY_NUM_MAX; i++)
+		sxe_hw_mta_hash_table_set(hw, i, mac_filter->mta_hash_table[i]);
+
+	if (nb_mc_addr) {
+		sxe_hw_mc_filter_enable(hw);
+
+		if (vf_num > 0) {
+			vm_l2_ctrl |= SXE_VMOLR_ROMPE;
+			sxe_hw_pool_rx_mode_set(hw, vm_l2_ctrl, vf_num);
+		}
+	}
+
+	PMD_LOG_INFO(DRV, "mc addr list cnt:%u set to mta done.", nb_mc_addr);
+
+	return 0;
+}
+
 s32 sxe_vlan_filter_set(struct rte_eth_dev *eth_dev, u16 vlan_id, s32 on)
 {
 	struct sxe_adapter *adapter = eth_dev->data->dev_private;
diff --git a/drivers/net/sxe/pf/sxe_filter.h b/drivers/net/sxe/pf/sxe_filter.h
index 2b7c91a9bd..7b9026fcfb 100644
--- a/drivers/net/sxe/pf/sxe_filter.h
+++ b/drivers/net/sxe/pf/sxe_filter.h
@@ -72,6 +72,15 @@ void sxe_mac_addr_remove(struct rte_eth_dev *dev, u32 rar_idx);
 s32 sxe_mac_addr_set(struct rte_eth_dev *dev,
 				 struct rte_ether_addr *mac_addr);
 
+s32 sxe_uc_hash_table_set(struct rte_eth_dev *dev,
+			struct rte_ether_addr *mac_addr, u8 on);
+
+s32 sxe_uc_all_hash_table_set(struct rte_eth_dev *dev, u8 on);
+
+s32 sxe_set_mc_addr_list(struct rte_eth_dev *dev,
+			  struct rte_ether_addr *mc_addr_list,
+			  u32 nb_mc_addr);
+
 s32 sxe_vlan_filter_set(struct rte_eth_dev *eth_dev, u16 vlan_id, s32 on);
 
 s32 sxe_vlan_tpid_set(struct rte_eth_dev *eth_dev,
@@ -91,4 +100,10 @@ void sxe_vlan_strip_switch_set(struct rte_eth_dev *dev);
 
 void sxe_fc_mac_addr_set(struct sxe_adapter *adapter);
 
+u8 sxe_sw_uc_entry_vf_add(struct sxe_adapter *adapter,
+				u8 vf_idx, u8 *mac_addr, bool macvlan);
+
+void sxe_sw_uc_entry_vf_del(struct sxe_adapter *adapter, u8 vf_idx,
+					bool macvlan);
+
 #endif
diff --git a/drivers/net/sxe/pf/sxe_phy.h b/drivers/net/sxe/pf/sxe_phy.h
index 9fd2746ec8..d907b3c8f8 100644
--- a/drivers/net/sxe/pf/sxe_phy.h
+++ b/drivers/net/sxe/pf/sxe_phy.h
@@ -6,6 +6,7 @@
 
 #include <rte_ethdev.h>
 #include "drv_msg.h"
+#include "sxe_cli.h"
 #include "sxe_msg.h"
 
 #define SXE_SFF_BASE_ADDR			0x0
diff --git a/drivers/net/sxe/pf/sxe_tx.c b/drivers/net/sxe/pf/sxe_tx.c
index 33d4468ebc..bbf802cd2f 100644
--- a/drivers/net/sxe/pf/sxe_tx.c
+++ b/drivers/net/sxe/pf/sxe_tx.c
@@ -55,7 +55,7 @@ void __rte_cold sxe_tx_function_set(struct rte_eth_dev *dev,
 
 		PMD_LOG_INFO(INIT, "using full-featured tx code path");
 		PMD_LOG_INFO(INIT, " - offloads = 0x%" SXE_PRIX64,
-					(unsigned long)txq->offloads);
+							txq->offloads);
 		PMD_LOG_INFO(INIT, " - tx_rs_thresh = %d "
 				   "[RTE_PMD_SXE_MAX_TX_BURST=%d]",
 				txq->rs_thresh,
diff --git a/drivers/net/sxe/pf/sxe_vf.c b/drivers/net/sxe/pf/sxe_vf.c
new file mode 100644
index 0000000000..a13c70e946
--- /dev/null
+++ b/drivers/net/sxe/pf/sxe_vf.c
@@ -0,0 +1,1199 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SRIOV
+
+#include <rte_ethdev.h>
+#include <rte_ether.h>
+#include <rte_memcpy.h>
+#include <ethdev_driver.h>
+#include <ethdev_pci.h>
+#include <bus_pci_driver.h>
+#include "sxe_logs.h"
+#include "sxe_vf.h"
+#include "sxe_hw.h"
+#include "sxe.h"
+#include "sxe_errno.h"
+#include "sxe_filter.h"
+#include "sxe_offload.h"
+#include "sxe_ethdev.h"
+#include "sxe_rx.h"
+#include "rte_pmd_sxe.h"
+
+#define SXE_MR_VLAN_MASK  0xFFFFFFFF
+#define SXE_MR_VLAN_MSB_BIT_OFFSET 32
+
+#define SXE_MR_VIRTUAL_POOL_MASK		 0xFFFFFFFF
+#define SXE_MR_VIRTUAL_POOL_MSB_BIT_MASK 32
+
+#define SXE_UC_MAC_UNSET 0
+#define SXE_UC_MAC_SET 1
+
+static inline s32 sxe_vf_mac_addr_generate(struct rte_eth_dev *eth_dev, u16 vf_num)
+{
+	u8 vf_mac_addr[RTE_ETHER_ADDR_LEN];
+	struct sxe_adapter *adapter = eth_dev->data->dev_private;
+	struct sxe_vf_info *vf_info = adapter->vt_ctxt.vf_info;
+	u16 idx;
+
+	for (idx = 0; idx < vf_num; idx++) {
+		rte_eth_random_addr(vf_mac_addr);
+		memcpy(vf_info[idx].mac_addr, vf_mac_addr, RTE_ETHER_ADDR_LEN);
+	}
+
+	return 0;
+}
+
+static void sxe_vt_mode_configure(struct rte_eth_dev *eth_dev)
+{
+	struct sxe_adapter *adapter = eth_dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+	u32 gpie;
+	u32 pcie_ext;
+
+	pcie_ext = sxe_hw_pcie_vt_mode_get(hw);
+	pcie_ext &= ~SXE_GCR_EXT_VT_MODE_MASK;
+
+	gpie = sxe_hw_irq_general_reg_get(hw);
+	gpie &= ~SXE_GPIE_VTMODE_MASK;
+	gpie |= SXE_GPIE_MSIX_MODE;
+
+	switch (RTE_ETH_DEV_SRIOV(eth_dev).active) {
+	case RTE_ETH_64_POOLS:
+		pcie_ext |= SXE_GCR_EXT_VT_MODE_64;
+		gpie |= SXE_GPIE_VTMODE_64;
+		break;
+	case RTE_ETH_32_POOLS:
+		pcie_ext |= SXE_GCR_EXT_VT_MODE_32;
+		gpie |= SXE_GPIE_VTMODE_32;
+		break;
+	case RTE_ETH_16_POOLS:
+		pcie_ext |= SXE_GCR_EXT_VT_MODE_16;
+		gpie |= SXE_GPIE_VTMODE_16;
+		break;
+	}
+
+	sxe_hw_pcie_vt_mode_set(hw, pcie_ext);
+	sxe_hw_irq_general_reg_set(hw, gpie);
+}
+
+s32 sxe_vt_init(struct rte_eth_dev *eth_dev)
+{
+	struct sxe_adapter *adapter = eth_dev->data->dev_private;
+	struct sxe_vf_info **vf_info = &adapter->vt_ctxt.vf_info;
+	struct sxe_hw *hw = &adapter->hw;
+	struct sxe_irq_context *irq = &adapter->irq_ctxt;
+	u16 vf_num;
+	s32 ret = 0;
+	u8 nb_queue;
+
+	PMD_INIT_FUNC_TRACE();
+
+	RTE_ETH_DEV_SRIOV(eth_dev).active = 0;
+	/* get vf num from max_vfs or sriov_numvfs */
+	vf_num = sxe_vf_num_get(eth_dev);
+	if (vf_num == 0) {
+		LOG_WARN_BDF("no vf, no need init vt");
+		goto l_out;
+	}
+
+	*vf_info = rte_zmalloc("vf_info", sizeof(struct sxe_vf_info) * vf_num, 0);
+	if (*vf_info == NULL) {
+		LOG_WARN_BDF("vf_info allocate memory fail.");
+		ret = -ENOMEM;
+		goto l_out;
+	}
+
+	ret = rte_eth_switch_domain_alloc(&(*vf_info)->domain_id);
+	if (ret) {
+		LOG_ERROR_BDF("failed to allocate switch domain for device %d", ret);
+		goto l_free_vf_info;
+	}
+
+	if (vf_num >= RTE_ETH_32_POOLS) {
+		nb_queue = 2;
+		RTE_ETH_DEV_SRIOV(eth_dev).active = RTE_ETH_64_POOLS;
+	} else if (vf_num >= RTE_ETH_16_POOLS) {
+		nb_queue = 4;
+		RTE_ETH_DEV_SRIOV(eth_dev).active = RTE_ETH_32_POOLS;
+	} else {
+		nb_queue = 8;
+		RTE_ETH_DEV_SRIOV(eth_dev).active = RTE_ETH_16_POOLS;
+	}
+
+	RTE_ETH_DEV_SRIOV(eth_dev).nb_q_per_pool = nb_queue;
+	RTE_ETH_DEV_SRIOV(eth_dev).def_vmdq_idx = vf_num;
+	RTE_ETH_DEV_SRIOV(eth_dev).def_pool_q_idx = (u16)(vf_num * nb_queue);
+
+	sxe_vf_mac_addr_generate(eth_dev, vf_num);
+
+	sxe_hw_mbx_init(hw);
+
+	irq->enable_mask |= SXE_EIMS_MAILBOX;
+
+	adapter->vt_ctxt.promisc_cnt = 0;
+
+	sxe_vt_mode_configure(eth_dev);
+
+	LOG_INFO_BDF("vf_num:%d domain id:%u init done.",
+			  vf_num, (*vf_info)->domain_id);
+
+l_out:
+	return ret;
+
+l_free_vf_info:
+	rte_free(*vf_info);
+	*vf_info = NULL;
+	return ret;
+}
+
+static void sxe_pf_pool_enable(struct rte_eth_dev *eth_dev, u16 vf_num)
+{
+	struct sxe_adapter *adapter = eth_dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+	u32 enable_mask = ~0;
+	u8 vf_reg_idx = ((vf_num >> 5) > 0) ? 1 : 0;
+	u8 vf_bit_index = vf_num & ((1 << 5) - 1);
+
+	sxe_hw_rx_pool_bitmap_set(hw, vf_reg_idx, enable_mask << vf_bit_index);
+	sxe_hw_rx_pool_bitmap_set(hw, (vf_reg_idx ^ 1), (vf_reg_idx - 1));
+
+	sxe_hw_tx_pool_bitmap_set(hw, vf_reg_idx, enable_mask << vf_bit_index);
+	sxe_hw_tx_pool_bitmap_set(hw, (vf_reg_idx ^ 1), (vf_reg_idx - 1));
+}
+
+static void sxe_vf_vlan_filter_enable(struct rte_eth_dev *eth_dev)
+{
+	struct sxe_adapter *adapter = eth_dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+	u32 enable_mask = ~0;
+	u32 vlan_ctl;
+	u8 i;
+
+	vlan_ctl = sxe_hw_vlan_type_get(hw);
+	vlan_ctl |= SXE_VLNCTRL_VFE;
+	sxe_hw_vlan_type_set(hw, vlan_ctl);
+
+	for (i = 0; i < SXE_VFT_TBL_SIZE; i++)
+		sxe_hw_vlan_filter_array_write(hw, i, enable_mask);
+}
+
+static void sxe_uc_mac_table_init(struct rte_eth_dev *eth_dev)
+{
+	struct sxe_adapter *adapter = eth_dev->data->dev_private;
+	struct sxe_vf_info *vf_info = adapter->vt_ctxt.vf_info;
+	u8 vf_num = sxe_vf_num_get(eth_dev);
+	u8 i;
+
+	for (i = 0; i < vf_num; i++)
+		memset(vf_info[i].uc_mac_table, SXE_UC_MAC_UNSET, SXE_UC_ENTRY_NUM_MAX);
+}
+
+void sxe_vt_configure(struct rte_eth_dev *eth_dev)
+{
+	struct sxe_adapter *adapter = eth_dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+	u16 vf_num;
+	u16 pf_pool_idx = RTE_ETH_DEV_SRIOV(eth_dev).def_vmdq_idx;
+
+	vf_num = sxe_vf_num_get(eth_dev);
+	if (vf_num == 0) {
+		LOG_WARN_BDF("no vf, no need configure vt");
+		return;
+	}
+
+	sxe_hw_vt_ctrl_cfg(hw, pf_pool_idx);
+
+	sxe_pf_pool_enable(eth_dev, vf_num);
+
+	sxe_hw_vt_pool_loopback_switch(hw, true);
+
+	sxe_hw_mac_pool_clear(hw, 0);
+	sxe_hw_mac_pool_clear(hw, SXE_UC_ENTRY_NUM_MAX - 1);
+
+	sxe_hw_uc_addr_pool_enable(hw, 0, pf_pool_idx);
+
+	sxe_vt_mode_configure(eth_dev);
+
+	sxe_vf_vlan_filter_enable(eth_dev);
+
+	sxe_hw_pool_mac_anti_spoof_set(hw, vf_num, 0);
+
+	sxe_uc_mac_table_init(eth_dev);
+
+	sxe_rx_fc_threshold_set(hw);
+}
+
+void sxe_vt_uninit(struct rte_eth_dev *eth_dev)
+{
+	struct sxe_adapter *adapter = eth_dev->data->dev_private;
+	struct sxe_vf_info **vf_info = &adapter->vt_ctxt.vf_info;
+	u16 vf_num;
+	int ret;
+
+	PMD_INIT_FUNC_TRACE();
+
+	RTE_ETH_DEV_SRIOV(eth_dev).active = 0;
+	RTE_ETH_DEV_SRIOV(eth_dev).nb_q_per_pool = 0;
+	RTE_ETH_DEV_SRIOV(eth_dev).def_vmdq_idx = 0;
+	RTE_ETH_DEV_SRIOV(eth_dev).def_pool_q_idx = 0;
+
+	vf_num = sxe_vf_num_get(eth_dev);
+	if (vf_num == 0 || (*vf_info) == NULL) {
+		LOG_INFO_BDF("vf_num:%u vf_info:%p, no need free vf_info.",
+				 vf_num, *vf_info);
+		return;
+	}
+
+	ret = rte_eth_switch_domain_free((*vf_info)->domain_id);
+	if (ret)
+		LOG_ERROR_BDF("failed to free switch domain: %d", ret);
+
+	rte_free(*vf_info);
+	*vf_info = NULL;
+}
+
+s32 sxe_vf_rss_configure(struct rte_eth_dev *dev)
+{
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+	bool is_4q_per_pool;
+	s32 ret = 0;
+
+	sxe_rss_configure(dev);
+
+	switch (RTE_ETH_DEV_SRIOV(dev).active) {
+	case RTE_ETH_64_POOLS:
+		is_4q_per_pool = false;
+		break;
+
+	case RTE_ETH_32_POOLS:
+		is_4q_per_pool = true;
+		break;
+
+	default:
+		ret = -EINVAL;
+		LOG_ERROR_BDF("invalid pool number:%u in iov mode with rss.(err:%d)",
+				  RTE_ETH_DEV_SRIOV(dev).active, ret);
+		goto l_out;
+	}
+
+	sxe_hw_rx_multi_ring_configure(hw, 0, is_4q_per_pool, true);
+
+	LOG_INFO_BDF("pool num:%u is_4q_per_pool:%u configure done.",
+			RTE_ETH_DEV_SRIOV(dev).active, is_4q_per_pool);
+
+l_out:
+	return ret;
+}
+
+s32 sxe_vf_default_mode_configure(struct rte_eth_dev *dev)
+{
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+	s32 ret = 0;
+	u8 tcs = 0;
+	bool is_4q_per_pool = false;
+
+	switch (RTE_ETH_DEV_SRIOV(dev).active) {
+	case RTE_ETH_64_POOLS:
+		is_4q_per_pool = false;
+		break;
+
+	case RTE_ETH_32_POOLS:
+		is_4q_per_pool = true;
+		break;
+
+	case RTE_ETH_16_POOLS:
+		tcs = 8;
+		break;
+	default:
+		ret = -SXE_ERR_CONFIG;
+		LOG_ERROR_BDF("invalid pool number:%u (err:%d)",
+				  RTE_ETH_DEV_SRIOV(dev).active, ret);
+		goto l_out;
+	}
+
+	sxe_hw_rx_multi_ring_configure(hw, tcs, is_4q_per_pool, true);
+
+l_out:
+	return ret;
+}
+
+static void sxe_filter_mode_configure(struct rte_eth_dev *dev)
+{
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+	u16 vf_num = sxe_vf_num_get(dev);
+	u32 filter_ctrl = sxe_hw_rx_mode_get(hw);
+	u32 vm_l2_ctrl = SXE_VMOLR_AUPE | SXE_VMOLR_BAM;
+
+	filter_ctrl &= ~(SXE_FCTRL_SBP | SXE_FCTRL_UPE | SXE_FCTRL_MPE);
+
+	filter_ctrl |= SXE_FCTRL_BAM;
+
+	if (dev->data->promiscuous) {
+		filter_ctrl |= (SXE_FCTRL_UPE | SXE_FCTRL_MPE);
+		vm_l2_ctrl |= (SXE_VMOLR_ROPE | SXE_VMOLR_MPE);
+	} else {
+		if (dev->data->all_multicast) {
+			filter_ctrl |= SXE_FCTRL_MPE;
+			vm_l2_ctrl |= SXE_VMOLR_MPE;
+		} else {
+			vm_l2_ctrl |= SXE_VMOLR_ROMPE;
+		}
+	}
+
+	vm_l2_ctrl |= sxe_hw_pool_rx_mode_get(hw, vf_num) &
+			~(SXE_VMOLR_MPE | SXE_VMOLR_ROMPE | SXE_VMOLR_ROPE);
+
+	sxe_hw_pool_rx_mode_set(hw, vm_l2_ctrl, vf_num);
+
+	sxe_hw_rx_mode_set(hw, filter_ctrl);
+
+	sxe_vlan_strip_switch_set(dev);
+}
+
+static inline void sxe_vf_flr_handle(struct rte_eth_dev *dev, u16 vf)
+{
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+	struct sxe_vf_info *vf_info = adapter->vt_ctxt.vf_info;
+	u32 vm_l2_ctrl = sxe_hw_pool_rx_mode_get(hw, vf);
+
+	sxe_sw_uc_entry_vf_del(adapter, vf, false);
+
+	vm_l2_ctrl |= (SXE_VMOLR_AUPE | SXE_VMOLR_ROPE | SXE_VMOLR_BAM);
+
+	sxe_hw_pool_rx_mode_set(hw, vm_l2_ctrl, vf);
+
+	sxe_hw_tx_vlan_tag_clear(hw, vf);
+
+	vf_info[vf].mc_hash_used = 0;
+
+	sxe_filter_mode_configure(dev);
+}
+
+static void sxe_vf_promisc_mac_update(struct rte_eth_dev *dev, u32 vf,
+		u32 rar_idx)
+{
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_vf_info *vf_info = adapter->vt_ctxt.vf_info;
+	u16 vf_num = sxe_vf_num_get(dev);
+	u8 vf_idx;
+
+	for (vf_idx = 0; vf_idx < vf_num; vf_idx++) {
+		if (vf_info[vf_idx].cast_mode == SXE_CAST_MODE_PROMISC &&
+				vf_idx != vf)
+			sxe_hw_uc_addr_pool_enable(&adapter->hw, rar_idx, vf_idx);
+	}
+}
+
+static void sxe_vf_promisc_mac_update_all(struct rte_eth_dev *dev)
+{
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_vf_info *vf_info = adapter->vt_ctxt.vf_info;
+	struct sxe_uc_addr_table *uc_table = adapter->mac_filter_ctxt.uc_addr_table;
+	s32 i;
+	u16 vf_num = sxe_vf_num_get(dev);
+	u8 vf_idx;
+
+	for (vf_idx = 0; vf_idx < vf_num; vf_idx++) {
+		if (vf_info[vf_idx].cast_mode == SXE_CAST_MODE_PROMISC) {
+			for (i = 0; i < SXE_UC_ENTRY_NUM_MAX; i++) {
+				if (uc_table[i].used) {
+					sxe_hw_uc_addr_pool_enable(&adapter->hw,
+						uc_table[i].rar_idx, vf_idx);
+				}
+			}
+		}
+	}
+}
+
+static void sxe_vf_uc_clean(struct rte_eth_dev *dev, u32 vf)
+{
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_uc_addr_table *uc_table = adapter->mac_filter_ctxt.uc_addr_table;
+	struct sxe_vf_info *vf_info = &adapter->vt_ctxt.vf_info[vf];
+	u8 i;
+
+	sxe_sw_uc_entry_vf_del(adapter, vf, true);
+	for (i = 0; i < SXE_UC_ENTRY_NUM_MAX; i++) {
+		if (vf_info->uc_mac_table[i] == SXE_UC_MAC_SET)
+			sxe_hw_mac_reuse_del(dev, uc_table[i].addr, vf,
+					uc_table[i].rar_idx);
+	}
+	vf_info->uc_mac_cnt = 0;
+	memset(vf_info->uc_mac_table, SXE_UC_MAC_UNSET, SXE_UC_ENTRY_NUM_MAX);
+	sxe_vf_promisc_mac_update_all(dev);
+}
+
+static s32 sxe_vf_dev_mac_addr_set_handler(struct rte_eth_dev *dev, u32 *msgbuf, u32 vf)
+{
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_uc_addr_msg mac_msg = *(struct sxe_uc_addr_msg *)msgbuf;
+	struct sxe_vf_info *vf_info = adapter->vt_ctxt.vf_info;
+	u32 rar_idx = sxe_sw_uc_entry_vf_add(adapter, vf, mac_msg.uc_addr, false);
+	s32 ret = -SXE_ERR_PARAM;
+	u8 *mac_addr = mac_msg.uc_addr;
+
+	UNUSED(mac_addr);
+	if (rte_is_valid_assigned_ether_addr((struct rte_ether_addr *)mac_msg.uc_addr)) {
+		rte_memcpy(vf_info[vf].mac_addr, mac_msg.uc_addr, RTE_ETHER_ADDR_LEN);
+		ret = sxe_hw_uc_addr_add(&adapter->hw, rar_idx, mac_msg.uc_addr, vf);
+		if (ret) {
+			LOG_ERROR_BDF("vf:%u mac addr:" RTE_ETHER_ADDR_PRT_FMT " set fail.(err:%d)",
+					  vf, mac_addr[0], mac_addr[1], mac_addr[2],
+					  mac_addr[3], mac_addr[4], mac_addr[5], ret);
+		}
+		sxe_vf_promisc_mac_update(dev, vf, rar_idx);
+	}
+
+	return ret;
+}
+
+static s32 sxe_mbx_api_set_handler(struct rte_eth_dev *dev,
+							u32 *msg, u32 vf_idx)
+{
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_mbx_api_msg *api_msg = (struct sxe_mbx_api_msg *)msg;
+	struct sxe_vf_info *vf_info = &adapter->vt_ctxt.vf_info[vf_idx];
+	s32 ret = 0;
+
+	switch (api_msg->api_version) {
+	case SXE_MBX_API_10:
+	case SXE_MBX_API_11:
+	case SXE_MBX_API_12:
+	case SXE_MBX_API_13:
+		vf_info->mbx_version = api_msg->api_version;
+		break;
+	default:
+		ret = -SXE_ERR_PARAM;
+		LOG_ERROR_BDF("invalid mailbox api version:%u.",
+			  api_msg->api_version);
+		break;
+	}
+
+	LOG_INFO_BDF("mailbox api version:0x%x.(err:%d)",
+					vf_info->mbx_version, ret);
+
+	return ret;
+}
+
+static s32 sxe_pf_ring_info_get(struct rte_eth_dev *dev, u32 *msgbuf, u32 vf)
+{
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+	struct sxe_vf_info *vf_info = &adapter->vt_ctxt.vf_info[vf];
+	struct sxe_ring_info_msg *ring_msg = (struct sxe_ring_info_msg *)msgbuf;
+	u32 default_q = vf * RTE_ETH_DEV_SRIOV(dev).nb_q_per_pool;
+	struct rte_eth_vmdq_dcb_tx_conf *vmdq_dcb_tx_conf;
+	u8 num_tcs;
+	u32 vmvir;
+	u32 vlan_action;
+	u32 vlan_id;
+	u32 user_priority;
+	s32 ret = 0;
+
+	switch (vf_info->mbx_version) {
+	case SXE_MBX_API_11:
+	case SXE_MBX_API_12:
+	case SXE_MBX_API_13:
+		break;
+	default:
+		ret = -SXE_ERR_CONFIG;
+		LOG_ERROR_BDF("mailbod version:0x%x not support get ring"
+				  " info.(err:%d)",
+				  vf_info->mbx_version, ret);
+		goto l_out;
+	}
+
+	ring_msg->max_rx_num = RTE_ETH_DEV_SRIOV(dev).nb_q_per_pool;
+	ring_msg->max_tx_num  = RTE_ETH_DEV_SRIOV(dev).nb_q_per_pool;
+
+	ring_msg->default_tc = default_q;
+
+	switch (dev->data->dev_conf.txmode.mq_mode) {
+	case RTE_ETH_MQ_TX_NONE:
+	case RTE_ETH_MQ_TX_DCB:
+		ret = -SXE_ERR_CONFIG;
+		LOG_ERROR_BDF("vf_idx:%u sriov eanble, not support tx queue mode:0x%x.",
+			vf,
+			dev->data->dev_conf.txmode.mq_mode);
+		goto l_out;
+
+	case RTE_ETH_MQ_TX_VMDQ_DCB:
+		vmdq_dcb_tx_conf = &dev->data->dev_conf.tx_adv_conf.vmdq_dcb_tx_conf;
+		switch (vmdq_dcb_tx_conf->nb_queue_pools) {
+		case RTE_ETH_16_POOLS:
+			num_tcs = RTE_ETH_8_TCS;
+			break;
+		case RTE_ETH_32_POOLS:
+			num_tcs = RTE_ETH_4_TCS;
+			break;
+		default:
+			ret = -SXE_ERR_CONFIG;
+			LOG_ERROR_BDF("vf:%u sriov enable, tx queue mode:0x%x "
+					  "invalid pool num:%u.(err:%d)",
+					vf,
+					dev->data->dev_conf.txmode.mq_mode,
+					vmdq_dcb_tx_conf->nb_queue_pools,
+					ret);
+			goto l_out;
+		}
+		break;
+
+	case RTE_ETH_MQ_TX_VMDQ_ONLY:
+		vmvir = sxe_hw_tx_vlan_insert_get(hw, vf);
+		vlan_action = vmvir & SXE_VMVIR_VLANA_MASK;
+		vlan_id = vmvir & SXE_VMVIR_VLAN_VID_MASK;
+		user_priority = (vmvir & SXE_VMVIR_VLAN_UP_MASK) >> VLAN_PRIO_SHIFT;
+		if (vlan_action == SXE_VMVIR_VLANA_DEFAULT &&
+			(vlan_id !=  0 || user_priority != 0)) {
+			num_tcs = 1;
+		} else {
+			num_tcs = 0;
+		}
+		break;
+
+	default:
+		ret = -SXE_ERR_CONFIG;
+		LOG_ERROR_BDF("vf_idx:%u sriov eanble, invalid tx queue mode:0x%x.",
+			vf,
+			dev->data->dev_conf.txmode.mq_mode);
+		goto l_out;
+	}
+
+	ring_msg->tc_num = num_tcs;
+
+	LOG_INFO_BDF("max_rx_num:%u max_tx_num:%u default queue:%u tc_num:%u.",
+			ring_msg->max_rx_num, ring_msg->max_tx_num,
+			ring_msg->default_tc, ring_msg->tc_num);
+
+l_out:
+	return ret;
+}
+
+static s32 sxe_vf_rss_hash_conf_get(struct rte_eth_dev *dev, u32 *msgbuf, u32 vf)
+{
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct rte_eth_rss_conf rss_conf;
+	struct sxe_rss_hash_msg *rss_msg = (struct sxe_rss_hash_msg *)msgbuf;
+
+	UNUSED(vf);
+	rss_conf.rss_key = malloc(SXE_RSS_KEY_SIZE);
+	sxe_rss_hash_conf_get(dev, &rss_conf);
+
+	memcpy(rss_msg->hash_key, rss_conf.rss_key, SXE_RSS_KEY_SIZE);
+	rss_msg->rss_hf = rss_conf.rss_hf;
+
+	free(rss_conf.rss_key);
+
+	LOG_INFO_BDF("vf[%u] rss hash conf get, rss_key:%s, rss_hf:%" SXE_PRID64 "",
+			vf, rss_msg->hash_key, rss_msg->rss_hf);
+
+	return 0;
+}
+
+static s32 sxe_vf_vlan_id_set_handler(struct rte_eth_dev *dev,
+						u32 *msgbuf, u32 vf)
+{
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+	struct sxe_vf_info *vf_info = adapter->vt_ctxt.vf_info;
+	struct sxe_vlan_msg *vlan_msg = (struct sxe_vlan_msg *)msgbuf;
+	u32 vlan_id = (vlan_msg->vlan_id & SXE_VLVF_VLANID_MASK);
+	s32 ret;
+
+	ret = sxe_hw_vlan_filter_configure(hw, vlan_id, vf, vlan_msg->add, false);
+	if (ret == 0) {
+		if (vlan_msg->add)
+			vf_info[vf].vlan_cnt++;
+		else if (vf_info[vf].vlan_cnt)
+			vf_info[vf].vlan_cnt--;
+	}
+
+	LOG_INFO_BDF("vf[%u] %s vid[%u] done vlan_cnt:%u ret = %d",
+			vf, vlan_msg->add ? "add" : "delete",
+			vlan_id,
+			vf_info[vf].vlan_cnt, ret);
+
+	return ret;
+}
+
+static s32 sxe_vf_max_frame_set_handler(struct rte_eth_dev *dev,
+						u32 *msgbuf, u32 vf)
+
+{
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+	struct sxe_vf_info *vf_info = &adapter->vt_ctxt.vf_info[vf];
+	struct sxe_max_frame_msg *msg = (struct sxe_max_frame_msg *)msgbuf;
+	u32 vf_max_frame = msg->max_frame + SXE_ETH_OVERHEAD;
+	s32 ret = 0;
+	u32 cur_max_frs;
+	u32 frame_size = SXE_GET_FRAME_SIZE(dev);
+
+	switch (vf_info->mbx_version) {
+	case SXE_MBX_API_11:
+	case SXE_MBX_API_12:
+	case SXE_MBX_API_13:
+		if (frame_size > SXE_ETH_MAX_LEN) {
+			LOG_WARN_BDF("pf jumbo frame enabled.");
+			break;
+		}
+		// fall through
+	default:
+		if (vf_max_frame > SXE_ETH_MAX_LEN ||
+			frame_size > SXE_ETH_MAX_LEN) {
+			ret = -SXE_ERR_PARAM;
+			LOG_ERROR_BDF("mbx version:0x%x pf max pkt len:0x%x vf:%u"
+					  " max_frames:0x%x max_len:0x%x.(err:%d)",
+					  vf_info->mbx_version,
+					  frame_size,
+					  vf, vf_max_frame,
+					  SXE_ETH_MAX_LEN, ret);
+			goto l_out;
+		}
+		break;
+	}
+
+	if (vf_max_frame < RTE_ETHER_MIN_LEN ||
+		vf_max_frame > RTE_ETHER_MAX_JUMBO_FRAME_LEN) {
+		ret = -SXE_ERR_PARAM;
+		LOG_ERROR_BDF("mbx version:0x%x vf:%u invalid max_frame:%u (err:%d)",
+				  vf_info->mbx_version,
+				  vf,
+				  vf_max_frame,
+				  ret);
+		goto l_out;
+	}
+
+	cur_max_frs = sxe_hw_mac_max_frame_get(hw);
+	if (vf_max_frame > cur_max_frs) {
+		ret = -SXE_ERR_PARAM;
+		LOG_ERROR_BDF("mbx version:0x%x vf:%u invalid max_frame:%u >= cur_max_frs:%u",
+				  vf_info->mbx_version,
+				  vf,
+				  vf_max_frame,
+				  cur_max_frs);
+		goto l_out;
+	}
+
+l_out:
+	return ret;
+}
+
+static void sxe_vf_mc_promisc_disable(struct rte_eth_dev *dev, u32 vf)
+{
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+	u32 vm_l2_ctrl = sxe_hw_pool_rx_mode_get(hw, vf);
+
+	vm_l2_ctrl &= ~SXE_VMOLR_MPE;
+
+	sxe_hw_pool_rx_mode_set(hw, vm_l2_ctrl, vf);
+}
+
+static void sxe_vf_promisc_disable(struct rte_eth_dev *dev, u32 vf)
+{
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+	struct sxe_vf_info *vf_info = &adapter->vt_ctxt.vf_info[vf];
+	u32 disable;
+	u32 vm_l2_filter;
+
+	if (vf_info->cast_mode != SXE_CAST_MODE_PROMISC)
+		goto out;
+
+	disable = SXE_VMOLR_BAM | SXE_VMOLR_ROMPE |
+				SXE_VMOLR_MPE | SXE_VMOLR_ROPE;
+
+	vf_info->cast_mode = SXE_CAST_MODE_NONE;
+
+	vm_l2_filter = sxe_hw_pool_rx_mode_get(hw, vf);
+	vm_l2_filter &= ~disable;
+	sxe_hw_pool_rx_mode_set(hw, vm_l2_filter, vf);
+
+	adapter->vt_ctxt.promisc_cnt--;
+	if (adapter->vt_ctxt.promisc_cnt == 0)
+		sxe_uc_all_hash_table_set(dev, false);
+
+out:
+	return;
+}
+
+static s32 sxe_vf_mc_addr_sync(struct rte_eth_dev *dev,
+					u32 *msgbuf, u32 vf)
+{
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+	struct sxe_vf_info *vf_info = &adapter->vt_ctxt.vf_info[vf];
+	struct sxe_mc_sync_msg *mc_msg = (struct sxe_mc_sync_msg *)msgbuf;
+	u8 mc_cnt = RTE_MIN(mc_msg->mc_cnt, SXE_VF_MC_ENTRY_NUM_MAX);
+	u32 mta_idx;
+	u32 mta_shift;
+	u32 vm_l2_filter = sxe_hw_pool_rx_mode_get(hw, vf);
+	int i;
+
+	sxe_vf_mc_promisc_disable(dev, vf);
+
+	vf_info->mc_hash_used = mc_cnt;
+	for (i = 0; i < mc_cnt; i++) {
+		vf_info->mc_hash[i] = mc_msg->mc_addr_extract[i];
+		LOG_INFO_BDF("vf_idx:%u mc_cnt:%u mc_hash[%d]:0x%x",
+				 vf, mc_cnt, i, vf_info->mc_hash[i]);
+	}
+
+	if (mc_cnt == 0) {
+		vm_l2_filter &= ~SXE_VMOLR_ROMPE;
+		sxe_hw_pool_rx_mode_set(hw, vm_l2_filter, vf);
+		LOG_WARN_BDF("vf:%u request disable mta filter.", vf);
+	} else {
+		for (i = 0; i < mc_cnt; i++) {
+			mta_idx = (vf_info->mc_hash[i] >> SXE_MC_ADDR_SHIFT) &
+				  SXE_MC_ADDR_REG_MASK;
+			mta_shift = vf_info->mc_hash[i] & SXE_MC_ADDR_BIT_MASK;
+			sxe_hw_mta_hash_table_update(hw, mta_idx, mta_shift);
+
+			LOG_INFO_BDF("vf_idx:%u mc_cnt:%u mc_hash[%d]:0x%x "
+				"reg_idx=%u, bit_idx=%u.",
+				vf, mc_cnt, i, vf_info->mc_hash[i],
+				mta_idx, mta_shift);
+		}
+
+		vm_l2_filter |= SXE_VMOLR_ROMPE;
+		sxe_hw_pool_rx_mode_set(hw, vm_l2_filter, vf);
+		sxe_hw_mc_filter_enable(hw);
+	}
+
+	return 0;
+}
+
+static void sxe_vf_mac_reuse_rebuild(struct sxe_adapter *adapter,
+					u8 rar_idx, u32 vf)
+{
+	struct sxe_hw *hw = &adapter->hw;
+	struct sxe_vf_info *vf_info = &adapter->vt_ctxt.vf_info[vf];
+	struct sxe_uc_addr_table *uc_table = adapter->mac_filter_ctxt.uc_addr_table;
+	u8 i;
+
+	for (i = 0; i < SXE_UC_ENTRY_NUM_MAX; i++) {
+		if (vf_info->uc_mac_table[i] == SXE_UC_MAC_SET &&
+				memcmp(uc_table[rar_idx].addr, uc_table[rar_idx].addr,
+					SXE_MAC_ADDR_LEN) == 0) {
+			sxe_hw_uc_addr_pool_enable(hw, rar_idx, vf);
+			break;
+		}
+	}
+}
+
+static s32 sxe_vf_cast_mode_handler(struct rte_eth_dev *dev,
+					u32 *msgbuf, u32 vf)
+
+{
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+	struct sxe_vf_info *vf_info = &adapter->vt_ctxt.vf_info[vf];
+	struct sxe_cast_mode_msg *cast_msg = (struct sxe_cast_mode_msg *)msgbuf;
+	struct sxe_uc_addr_table *uc_table = adapter->mac_filter_ctxt.uc_addr_table;
+	u32 enable;
+	u32 disable;
+	u32 flt_ctrl = 0;
+	u32 vm_l2_filter;
+	s32 ret = 0;
+	u8 i;
+	bool allmulti = false;
+
+	switch (vf_info->mbx_version) {
+	case SXE_MBX_API_12:
+	case SXE_MBX_API_13:
+		break;
+	default:
+		ret = -SXE_ERR_PARAM;
+		LOG_ERROR_BDF("vf:%u invalid mbx api version:0x%x.",
+				 vf, vf_info->mbx_version);
+		goto l_out;
+	}
+
+	if (vf_info->cast_mode == cast_msg->cast_mode) {
+		LOG_INFO_BDF("vf:%d currut mode equal set mode:0x%x, skip set.",
+				 vf, cast_msg->cast_mode);
+		goto l_out;
+	}
+
+	switch (cast_msg->cast_mode) {
+	case SXE_CAST_MODE_NONE:
+		disable = SXE_VMOLR_BAM | SXE_VMOLR_ROMPE |
+				SXE_VMOLR_MPE | SXE_VMOLR_ROPE;
+		enable = 0;
+		break;
+
+	case SXE_CAST_MODE_MULTI:
+		disable = SXE_VMOLR_MPE | SXE_VMOLR_ROPE;
+		enable = SXE_VMOLR_BAM | SXE_VMOLR_ROMPE;
+		break;
+
+	case SXE_CAST_MODE_ALLMULTI:
+		disable = SXE_VMOLR_ROPE;
+		enable = SXE_VMOLR_BAM | SXE_VMOLR_ROMPE |
+					SXE_VMOLR_MPE;
+		allmulti = true;
+		break;
+
+	case SXE_CAST_MODE_PROMISC:
+		disable = 0;
+		enable = SXE_VMOLR_MPE | SXE_VMOLR_ROPE |
+					SXE_VMOLR_BAM | SXE_VMOLR_ROMPE;
+		allmulti = true;
+		break;
+
+	default:
+		ret = -SXE_ERR_PARAM;
+		LOG_ERROR_BDF("vf:%u invalid cast mode:0x%x.",
+				vf, cast_msg->cast_mode);
+		goto l_out;
+	}
+
+	vm_l2_filter = sxe_hw_pool_rx_mode_get(hw, vf);
+	vm_l2_filter &= ~disable;
+	vm_l2_filter |= enable;
+	sxe_hw_pool_rx_mode_set(hw, vm_l2_filter, vf);
+
+	if (allmulti) {
+		flt_ctrl = sxe_hw_rx_mode_get(hw) | SXE_FCTRL_MPE;
+		sxe_hw_rx_mode_set(hw, flt_ctrl);
+	}
+
+	if (cast_msg->cast_mode == SXE_CAST_MODE_PROMISC) {
+		sxe_uc_all_hash_table_set(dev, true);
+		adapter->vt_ctxt.promisc_cnt++;
+		for (i = 0; i < SXE_UC_ENTRY_NUM_MAX; i++) {
+			if (uc_table[i].used)
+				sxe_hw_uc_addr_pool_enable(hw, i, vf);
+		}
+	} else if (vf_info->cast_mode == SXE_CAST_MODE_PROMISC) {
+		adapter->vt_ctxt.promisc_cnt--;
+		if (adapter->vt_ctxt.promisc_cnt == 0)
+			sxe_uc_all_hash_table_set(dev, false);
+
+		for (i = 0; i < SXE_UC_ENTRY_NUM_MAX; i++) {
+			if (uc_table[i].used && uc_table[i].pool_idx != vf) {
+				sxe_hw_uc_addr_pool_del(hw, i, vf);
+				sxe_vf_mac_reuse_rebuild(adapter, i, vf);
+			}
+		}
+	}
+
+	vf_info->cast_mode = cast_msg->cast_mode;
+	LOG_INFO_BDF("vf:%d filter reg:0x%x mode:%d promisc vfs:%d.",
+			 vf, vm_l2_filter, cast_msg->cast_mode, adapter->vt_ctxt.promisc_cnt);
+
+l_out:
+	return ret;
+}
+
+static s32 sxe_vf_uc_addr_sync_handler(struct rte_eth_dev *dev,
+					u32 *msgbuf, u32 vf)
+{
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+	struct sxe_vf_info *vf_info = &adapter->vt_ctxt.vf_info[vf];
+	struct sxe_uc_sync_msg *uc_msg = (struct sxe_uc_sync_msg *)msgbuf;
+	s32 ret = 0;
+	u8 rar_idx;
+	u8 *mac_addr = (u8 *)uc_msg->addr;
+
+	UNUSED(mac_addr);
+	if (uc_msg->index) {
+		if (!rte_is_valid_assigned_ether_addr((struct rte_ether_addr *)uc_msg->addr)) {
+			ret = -SXE_ERR_PARAM;
+			LOG_ERROR_BDF("vf:%u mac addr:" RTE_ETHER_ADDR_PRT_FMT " invalid.(err:%d).",
+					  vf, mac_addr[0], mac_addr[1], mac_addr[2],
+					  mac_addr[3], mac_addr[4], mac_addr[5], ret);
+			goto l_out;
+		}
+
+		vf_info->uc_mac_cnt++;
+		rar_idx = sxe_sw_uc_entry_vf_add(adapter, vf, (u8 *)uc_msg->addr, true);
+		if (rar_idx < SXE_UC_ENTRY_NUM_MAX) {
+			vf_info->uc_mac_table[rar_idx] = SXE_UC_MAC_SET;
+			sxe_hw_uc_addr_add(hw, rar_idx, (u8 *)uc_msg->addr, vf);
+			sxe_hw_mac_reuse_add(dev, (u8 *)uc_msg->addr, rar_idx);
+			sxe_vf_promisc_mac_update(dev, vf, rar_idx);
+		}
+	} else {
+		if (vf_info->uc_mac_cnt)
+			sxe_vf_uc_clean(dev, vf);
+	}
+
+	LOG_INFO_BDF("vf:%u mac addr:" RTE_ETHER_ADDR_PRT_FMT " opt:%d.",
+					vf, mac_addr[0], mac_addr[1], mac_addr[2],
+					mac_addr[3], mac_addr[4], mac_addr[5], uc_msg->index);
+
+l_out:
+	return ret;
+}
+
+static struct sxe_msg_table msg_table[] = {
+	[SXE_VFREQ_MAC_ADDR_SET] = {SXE_VFREQ_MAC_ADDR_SET, sxe_vf_dev_mac_addr_set_handler},
+	[SXE_VFREQ_MC_ADDR_SYNC] = {SXE_VFREQ_MC_ADDR_SYNC, sxe_vf_mc_addr_sync},
+	[SXE_VFREQ_VLAN_SET] = {SXE_VFREQ_VLAN_SET, sxe_vf_vlan_id_set_handler},
+	[SXE_VFREQ_LPE_SET] = {SXE_VFREQ_LPE_SET, sxe_vf_max_frame_set_handler},
+	[SXE_VFREQ_UC_ADDR_SYNC] = {SXE_VFREQ_UC_ADDR_SYNC, sxe_vf_uc_addr_sync_handler},
+	[SXE_VFREQ_API_NEGOTIATE] = {SXE_VFREQ_API_NEGOTIATE, sxe_mbx_api_set_handler},
+	[SXE_VFREQ_RING_INFO_GET] = {SXE_VFREQ_RING_INFO_GET, sxe_pf_ring_info_get},
+	[SXE_VFREQ_CAST_MODE_SET] = {SXE_VFREQ_CAST_MODE_SET, sxe_vf_cast_mode_handler},
+	[SXE_VFREQ_RSS_CONF_GET] = {SXE_VFREQ_RSS_CONF_GET, sxe_vf_rss_hash_conf_get},
+};
+
+static void sxe_vf_pool_enable(struct rte_eth_dev *dev, u8 vf_idx)
+{
+	u32 enable_pool;
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	u8 reg_idx = vf_idx / 32;
+	u8 bit_idx = vf_idx % 32;
+	struct sxe_hw *hw = &adapter->hw;
+	struct sxe_vf_info *vf_info = &adapter->vt_ctxt.vf_info[vf_idx];
+
+	enable_pool = sxe_hw_tx_pool_bitmap_get(hw, reg_idx);
+	enable_pool |= BIT(bit_idx);
+	sxe_hw_tx_pool_bitmap_set(hw, reg_idx, enable_pool);
+
+	sxe_hw_vf_queue_drop_enable(hw, vf_idx,
+				RTE_ETH_DEV_SRIOV(dev).nb_q_per_pool);
+
+	enable_pool = sxe_hw_rx_pool_bitmap_get(hw, reg_idx);
+	enable_pool |= BIT(bit_idx);
+	sxe_hw_rx_pool_bitmap_set(hw, reg_idx, enable_pool);
+
+	vf_info->is_ready = true;
+
+	sxe_hw_spoof_count_enable(hw, reg_idx, bit_idx);
+}
+
+static void sxe_vf_reset_msg_handle(struct rte_eth_dev *dev, u8 vf_idx)
+{
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+	struct sxe_rst_reply reply = {};
+	u8 *mac_addr = adapter->vt_ctxt.vf_info[vf_idx].mac_addr;
+	u8 *addr_bytes = (u8 *)(((struct rte_ether_addr *)mac_addr)->addr_bytes);
+	u32 rar_idx = sxe_sw_uc_entry_vf_add(adapter, vf_idx, addr_bytes, false);
+
+	LOG_INFO_BDF("receive vf_idx:%d reset msg.", vf_idx);
+
+	sxe_vf_pool_enable(dev, vf_idx);
+
+	sxe_vf_flr_handle(dev, vf_idx);
+
+	sxe_hw_uc_addr_add(&adapter->hw, rar_idx, addr_bytes, vf_idx);
+
+	sxe_vf_mc_promisc_disable(dev, vf_idx);
+
+	sxe_vf_promisc_disable(dev, vf_idx);
+
+	reply.msg_type = SXE_VFREQ_RESET | SXE_MSGTYPE_ACK;
+	reply.mc_filter_type = SXE_MC_FILTER_TYPE0;
+	rte_memcpy(reply.mac_addr, mac_addr, RTE_ETHER_ADDR_LEN);
+
+	sxe_hw_send_msg_to_vf(hw, (u32 *)&reply,
+				SXE_MSG_NUM(sizeof(reply)), vf_idx);
+
+	adapter->vt_ctxt.vf_info->is_ready = true;
+
+	LOG_INFO_BDF("vf_idx:%d reset msg:0x%x handle done.send mac addr:" RTE_ETHER_ADDR_PRT_FMT
+			" mc type:%d to vf.",
+			vf_idx, reply.msg_type,
+			mac_addr[0], mac_addr[1], mac_addr[2],
+			mac_addr[3], mac_addr[4], mac_addr[5],
+			SXE_MC_FILTER_TYPE0);
+}
+
+static s32 sxe_req_msg_handle(struct rte_eth_dev *dev, u32 *msg,
+					u8 vf_idx)
+{
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+	s32 ret = 0;
+	u16 cmd_id = msg[0] & SXE_VFREQ_MASK;
+	struct rte_pmd_sxe_mb_event_param user_param;
+
+	if (cmd_id > SXE_VFREQ_CAST_MODE_SET &&
+		cmd_id <= SXE_VFREQ_IPSEC_DEL) {
+		ret = -SXE_ERR_PARAM;
+		LOG_ERROR_BDF("vf_idx:%u msg:0x%x invalid cmd_id:0x%x.",
+			   vf_idx, msg[0], cmd_id);
+		goto l_out;
+	}
+
+	user_param.ret = RTE_PMD_SXE_MB_EVENT_PROCEED;
+	user_param.vf_idx = vf_idx;
+	user_param.msg_type = msg[0] & 0xFFFF;
+	user_param.msg = (void *)msg;
+
+	if (cmd_id == SXE_VFREQ_RESET) {
+		ret = 0;
+		sxe_vf_reset_msg_handle(dev, vf_idx);
+
+		sxe_eth_dev_callback_process(dev, RTE_ETH_EVENT_VF_MBOX,
+						  &user_param);
+		goto l_out;
+	}
+
+	sxe_eth_dev_callback_process(dev, RTE_ETH_EVENT_VF_MBOX,
+						  &user_param);
+
+	LOG_INFO_BDF("vf_idx:%u cmd_id:0x%x user configure:0x%x.",
+			vf_idx, cmd_id, user_param.ret);
+
+	if (!adapter->vt_ctxt.vf_info[vf_idx].is_ready) {
+		msg[0] |= SXE_MSGTYPE_NACK;
+		ret = sxe_hw_send_msg_to_vf(hw, msg,
+					SXE_MSG_NUM(sizeof(msg[0])), vf_idx);
+		LOG_WARN_BDF("vf_idx:%d not ready now, send nack to vf.ret:%d.",
+			  vf_idx, ret);
+		goto l_out;
+	}
+
+	if (msg_table[cmd_id].msg_func) {
+		if (user_param.ret == RTE_PMD_SXE_MB_EVENT_PROCEED ||
+			cmd_id == SXE_VFREQ_API_NEGOTIATE ||
+			cmd_id == SXE_VFREQ_RING_INFO_GET) {
+			ret = msg_table[cmd_id].msg_func(dev, msg, vf_idx);
+		}
+		LOG_INFO_BDF("msg:0x%x cmd_id:0x%x handle done.ret:%d",
+			 msg[0], cmd_id, ret);
+	} else {
+		ret = -SXE_ERR_PARAM;
+	}
+
+	if (!ret) {
+		msg[0] |= SXE_MSGTYPE_ACK;
+	} else {
+		msg[0] |= SXE_MSGTYPE_NACK;
+		LOG_ERROR_BDF("vf_idx:%u msg_type:0x%x cmdId:0x%x invalid.(err:%d)",
+				  vf_idx, msg[0], cmd_id, ret);
+	}
+
+	ret = sxe_hw_send_msg_to_vf(hw, msg, SXE_MBX_MSG_NUM, vf_idx);
+	if (ret) {
+		LOG_ERROR_BDF("vf:%d msg:0x%x reply fail.(err:%d).",
+			   vf_idx, msg[0], ret);
+	}
+
+	LOG_INFO_BDF("pf reply vf:%d msg:0x%x done.ret:%d", vf_idx, msg[0], ret);
+
+l_out:
+	return ret;
+}
+
+static s32 sxe_vf_req_msg_handle(struct rte_eth_dev *dev, u8 vf_idx)
+{
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+	u32 msg[SXE_MBX_MSG_NUM] = {0};
+	s32 ret;
+
+	ret = sxe_hw_rcv_msg_from_vf(hw, msg, SXE_MBX_MSG_NUM, vf_idx);
+	if (ret) {
+		LOG_ERROR_BDF("rcv vf:0x%x req msg:0x%x fail.(err:%d)",
+			   vf_idx, msg[0], ret);
+		goto l_out;
+	}
+
+	LOG_INFO_BDF("rcv vf_idx:%d req msg:0x%x.", vf_idx, msg[0]);
+
+	if (msg[0] & (SXE_MSGTYPE_ACK | SXE_MSGTYPE_NACK)) {
+		LOG_WARN_BDF("msg:0x%x has handled, no need dup handle.",
+			  msg[0]);
+		goto l_out;
+	}
+
+	ret = sxe_req_msg_handle(dev, msg, vf_idx);
+	if (ret) {
+		LOG_ERROR_BDF("vf:%d request msg handle fail.(err:%d)",
+			  vf_idx, ret);
+	}
+
+l_out:
+	return ret;
+}
+
+static void sxe_vf_ack_msg_handle(struct rte_eth_dev *eth_dev, u8 vf_idx)
+{
+	struct sxe_adapter *adapter = eth_dev->data->dev_private;
+	u32 msg = SXE_MSGTYPE_NACK;
+
+	if (!adapter->vt_ctxt.vf_info[vf_idx].is_ready) {
+		sxe_hw_send_msg_to_vf(&adapter->hw, &msg,
+					SXE_MSG_NUM(sizeof(msg)), vf_idx);
+	}
+}
+
+void sxe_mbx_irq_handler(struct rte_eth_dev *eth_dev)
+{
+	struct sxe_adapter *adapter = eth_dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+	u16 vf_num = sxe_vf_num_get(eth_dev);
+	u8 vf_idx;
+
+	LOG_DEBUG_BDF("mailbox irq triggered vf_num:%u.", vf_num);
+
+	for (vf_idx = 0; vf_idx < vf_num; vf_idx++) {
+		if (sxe_hw_vf_rst_check(hw, vf_idx)) {
+			LOG_WARN_BDF("vf_idx:%d flr triggered.", vf_idx);
+			sxe_vf_flr_handle(eth_dev, vf_idx);
+		}
+
+		if (sxe_hw_vf_req_check(hw, vf_idx))
+			sxe_vf_req_msg_handle(eth_dev, vf_idx);
+
+		if (sxe_hw_vf_ack_check(hw, vf_idx))
+			sxe_vf_ack_msg_handle(eth_dev, vf_idx);
+	}
+}
+
+int rte_pmd_sxe_set_vf_rxmode(u16 port, u16 vf,
+				u16 rx_mask, u8 on)
+{
+	u32 val = 0;
+	struct rte_eth_dev *dev;
+	struct rte_pci_device *pci_dev;
+	struct sxe_adapter *adapter;
+	struct sxe_hw *hw;
+	u32 vmolr;
+
+	RTE_ETH_VALID_PORTID_OR_ERR_RET(port, -ENODEV);
+
+	dev = &rte_eth_devices[port];
+	pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+
+	if (!sxe_is_supported(dev))
+		return -ENOTSUP;
+
+	if (vf >= pci_dev->max_vfs)
+		return -EINVAL;
+
+	if (on > 1)
+		return -EINVAL;
+
+	adapter = dev->data->dev_private;
+	hw = &adapter->hw;
+	vmolr = sxe_hw_pool_rx_mode_get(hw, vf);
+
+	if (sxe_hw_vt_status(hw) == false)
+		return -ENOTSUP;
+
+	sxe_vmdq_rx_mode_get((u32)rx_mask, &val);
+
+	if (on)
+		vmolr |= val;
+	else
+		vmolr &= ~val;
+
+	sxe_hw_pool_rx_mode_set(hw, vmolr, vf);
+
+	return 0;
+}
+#endif
diff --git a/drivers/net/sxe/pf/sxe_vf.h b/drivers/net/sxe/pf/sxe_vf.h
new file mode 100644
index 0000000000..6f07c20751
--- /dev/null
+++ b/drivers/net/sxe/pf/sxe_vf.h
@@ -0,0 +1,200 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+
+#ifndef __SXE_VF_H__
+#define __SXE_VF_H__
+
+#include <rte_ethdev.h>
+#include <bus_pci_driver.h>
+
+#include "sxe_hw.h"
+
+#define SXE_MIRROR_RULES_MAX   4
+
+#define SXE_MSG_NUM(size)		 DIV_ROUND_UP(size, 4)
+
+#define SXE_MSGTYPE_ACK	0x80000000
+#define SXE_MSGTYPE_NACK   0x40000000
+
+#define SXE_VFREQ_RESET			   0x01
+#define SXE_VFREQ_MAC_ADDR_SET		0x02
+#define SXE_VFREQ_MC_ADDR_SYNC		0x03
+#define SXE_VFREQ_VLAN_SET			0x04
+#define SXE_VFREQ_LPE_SET			 0x05
+
+#define SXE_VFREQ_UC_ADDR_SYNC		0x06
+
+#define SXE_VFREQ_API_NEGOTIATE	   0x08
+
+#define SXE_VFREQ_RING_INFO_GET	   0x09
+#define SXE_VFREQ_REDIR_TBL_GET	   0x0a
+#define SXE_VFREQ_RSS_KEY_GET		 0x0b
+#define SXE_VFREQ_CAST_MODE_SET	   0x0c
+#define SXE_VFREQ_LINK_ENABLE_GET	 0X0d
+#define SXE_VFREQ_IPSEC_ADD		   0x0e
+#define SXE_VFREQ_IPSEC_DEL		   0x0f
+#define SXE_VFREQ_RSS_CONF_GET		0x10
+
+#define SXE_VFREQ_MASK				0xFF
+
+#define SXE_MIRROR_TYPE_INVALID(mirror_type) \
+	((mirror_type) & ~(u8)(ETH_MIRROR_VIRTUAL_POOL_UP | \
+	ETH_MIRROR_UPLINK_PORT | ETH_MIRROR_DOWNLINK_PORT | ETH_MIRROR_VLAN))
+
+#define SXE_ETH_MIRROR_TYPE_MASK \
+			(ETH_MIRROR_VIRTUAL_POOL_UP | ETH_MIRROR_UPLINK_PORT \
+			| ETH_MIRROR_DOWNLINK_PORT | ETH_MIRROR_VLAN)
+
+static inline u16 sxe_vf_num_get(struct rte_eth_dev *eth_dev)
+{
+	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+
+	return pci_dev->max_vfs;
+}
+
+enum sxe_mbx_api_version {
+	SXE_MBX_API_10 = 0,
+	SXE_MBX_API_11,
+	SXE_MBX_API_12,
+	SXE_MBX_API_13,
+	SXE_MBX_API_14,
+
+	SXE_MBX_API_NR,
+};
+
+enum sxe_cast_mode {
+	SXE_CAST_MODE_NONE = 0,
+	SXE_CAST_MODE_MULTI,
+	SXE_CAST_MODE_ALLMULTI,
+	SXE_CAST_MODE_PROMISC,
+};
+
+struct sxe_vf_info {
+	u8 mac_addr[RTE_ETHER_ADDR_LEN];
+	u16 mc_hash[SXE_VF_MC_ENTRY_NUM_MAX];
+	u8  mc_hash_used;
+	u8 cast_mode;
+	u8  trusted :1;
+	u8  is_ready :1;
+	u8  spoof_chk_enabled :1;
+	u8  rss_query_enabled :1;
+	u8  mac_from_pf :1;
+	u8  reserved :3;
+	u16 domain_id;
+	u16 tx_rate;
+	u32 mbx_version;
+	u32 vlan_cnt;
+	u32 uc_mac_cnt;
+	u8 uc_mac_table[SXE_UC_ENTRY_NUM_MAX];
+};
+
+struct sxe_virtual_context {
+	u8  pflink_fullchk;
+	u8  promisc_cnt;
+	u32 mbx_version;
+	struct sxe_vf_info *vf_info;
+};
+
+struct sxe_msg_table {
+	u32 msg_type;
+	s32 (*msg_func)(struct rte_eth_dev *dev, u32 *msg, u32 vf_idx);
+};
+
+enum RTE_PMD_SXE_MB_event_rsp {
+	RTE_PMD_SXE_MB_EVENT_NOOP_ACK,
+	RTE_PMD_SXE_MB_EVENT_NOOP_NACK,
+	RTE_PMD_SXE_MB_EVENT_PROCEED,
+	RTE_PMD_SXE_MB_EVENT_MAX
+};
+
+struct rte_pmd_sxe_mb_event_param {
+	u16 vf_idx;
+	u16 msg_type;
+	u16 ret;
+	void *msg;
+};
+
+struct sxe_mbx_api_msg {
+	u32 msg_type;
+	u32 api_version;
+};
+
+struct sxe_uc_addr_msg {
+	u32 msg_type;
+	u8 uc_addr[RTE_ETHER_ADDR_LEN];
+	u16 pad;
+};
+
+struct sxe_rst_rcv {
+	u32 msg_type;
+};
+
+struct sxe_rst_reply {
+	u32 msg_type;
+	u32 mac_addr[2];
+	u32 mc_filter_type;
+};
+
+struct sxe_rst_msg {
+	union {
+		struct sxe_rst_rcv rcv;
+		struct sxe_rst_reply reply;
+	};
+};
+
+struct sxe_ring_info_msg {
+	u32 msg_type;
+	u8  max_rx_num;
+	u8  max_tx_num;
+	u8  tc_num;
+	u8  default_tc;
+};
+
+struct sxe_rss_hash_msg {
+	u32 msg_type;
+	u8  hash_key[SXE_RSS_KEY_SIZE];
+	u64 rss_hf;
+};
+
+struct sxe_vlan_msg {
+	u16 msg_type;
+	u16 add;
+	u32 vlan_id;
+};
+
+struct sxe_mc_sync_msg {
+	u16 msg_type;
+	u16 mc_cnt;
+	u16 mc_addr_extract[SXE_VF_MC_ENTRY_NUM_MAX];
+};
+
+struct sxe_cast_mode_msg {
+	u32 msg_type;
+	u32 cast_mode;
+};
+
+struct sxe_uc_sync_msg {
+	u16 msg_type;
+	u16 index;
+	u32 addr[2];
+};
+
+struct sxe_max_frame_msg {
+	u32 msg_type;
+	u32 max_frame;
+};
+
+s32 sxe_vt_init(struct rte_eth_dev *eth_dev);
+
+void sxe_vt_configure(struct rte_eth_dev *eth_dev);
+
+void sxe_vt_uninit(struct rte_eth_dev *eth_dev);
+
+s32 sxe_vf_rss_configure(struct rte_eth_dev *dev);
+
+s32 sxe_vf_default_mode_configure(struct rte_eth_dev *dev);
+
+void sxe_mbx_irq_handler(struct rte_eth_dev *eth_dev);
+
+#endif
diff --git a/drivers/net/sxe/sxe_testpmd.c b/drivers/net/sxe/sxe_testpmd.c
index 6974bfe002..a0205e593e 100644
--- a/drivers/net/sxe/sxe_testpmd.c
+++ b/drivers/net/sxe/sxe_testpmd.c
@@ -12,6 +12,131 @@
 
 #include "testpmd.h"
 
+static int
+vf_tc_min_bw_parse_bw_list(uint8_t *bw_list, uint8_t *tc_num, char *str)
+{
+	uint32_t size;
+	const char *p, *p0 = str;
+	char s[256];
+	char *end;
+	char *str_fld[16];
+	uint16_t i;
+	int ret;
+
+	p = strchr(p0, '(');
+	if (p == NULL) {
+		RTE_LOG_LINE(ERR, EAL, "The bandwidth-list should be '(bw1, bw2, ...)'");
+		return -1;
+	}
+	p++;
+	p0 = strchr(p, ')');
+	if (p0 == NULL) {
+		RTE_LOG_LINE(ERR, EAL, "The bandwidth-list should be '(bw1, bw2, ...)'");
+		return -1;
+	}
+	size = p0 - p;
+	if (size >= sizeof(s)) {
+		RTE_LOG_LINE(ERR, EAL, "The string size exceeds the internal buffer size");
+		return -1;
+	}
+	snprintf(s, sizeof(s), "%.*s", size, p);
+	ret = rte_strsplit(s, sizeof(s), str_fld, 16, ',');
+	if (ret <= 0) {
+		RTE_LOG_LINE(ERR, EAL, "Failed to get the bandwidth list.");
+		return -1;
+	}
+	*tc_num = ret;
+	for (i = 0; i < ret; i++)
+		bw_list[i] = (uint8_t)strtoul(str_fld[i], &end, 0);
+
+	return 0;
+}
+
+struct cmd_vf_tc_bw_result {
+	cmdline_fixed_string_t set;
+	cmdline_fixed_string_t tc;
+	cmdline_fixed_string_t tx;
+	cmdline_fixed_string_t min_bw;
+	portid_t port_id;
+	cmdline_fixed_string_t bw_list;
+};
+
+static cmdline_parse_token_string_t cmd_vf_tc_bw_set =
+	TOKEN_STRING_INITIALIZER(struct cmd_vf_tc_bw_result,
+		set, "set");
+static cmdline_parse_token_string_t cmd_vf_tc_bw_tc =
+	TOKEN_STRING_INITIALIZER(struct cmd_vf_tc_bw_result,
+		tc, "tc");
+static cmdline_parse_token_string_t cmd_vf_tc_bw_tx =
+	TOKEN_STRING_INITIALIZER(struct cmd_vf_tc_bw_result,
+		tx, "tx");
+static cmdline_parse_token_string_t cmd_vf_tc_bw_min_bw =
+	TOKEN_STRING_INITIALIZER(struct cmd_vf_tc_bw_result,
+		min_bw, "min-bandwidth");
+static cmdline_parse_token_num_t cmd_vf_tc_bw_port_id =
+	TOKEN_NUM_INITIALIZER(struct cmd_vf_tc_bw_result,
+		port_id, RTE_UINT16);
+static cmdline_parse_token_string_t cmd_vf_tc_bw_bw_list =
+	TOKEN_STRING_INITIALIZER(struct cmd_vf_tc_bw_result,
+		bw_list, NULL);
+
+static void
+cmd_tc_min_bw_parsed(void *parsed_result,
+	__rte_unused struct cmdline *cl, __rte_unused void *data)
+{
+	struct cmd_vf_tc_bw_result *res = parsed_result;
+	struct rte_port *port;
+	uint8_t tc_num;
+	uint8_t bw[16];
+	int ret = -ENOTSUP;
+
+	if (port_id_is_invalid(res->port_id, ENABLED_WARN))
+		return;
+
+	port = &ports[res->port_id];
+	if (port->port_status != RTE_PORT_STOPPED) {
+		RTE_LOG_LINE(ERR, EAL, "Please stop port %d first", res->port_id);
+		return;
+	}
+
+	ret = vf_tc_min_bw_parse_bw_list(bw, &tc_num, res->bw_list);
+	if (ret)
+		return;
+
+	ret = rte_pmd_sxe_tc_bw_set(res->port_id, tc_num, bw);
+
+	switch (ret) {
+	case 0:
+		break;
+	case -EINVAL:
+		RTE_LOG_LINE(ERR, EAL, "invalid bandwidth");
+		break;
+	case -ENODEV:
+		RTE_LOG_LINE(ERR, EAL, "invalid port_id %d", res->port_id);
+		break;
+	case -ENOTSUP:
+		RTE_LOG_LINE(ERR, EAL, "function not implemented");
+		break;
+	default:
+		RTE_LOG_LINE(ERR, EAL, "programming error: (%s)", strerror(-ret));
+	}
+}
+
+static cmdline_parse_inst_t cmd_tc_min_bw = {
+	.f = cmd_tc_min_bw_parsed,
+	.data = NULL,
+	.help_str = "set tc tx min-bandwidth <port_id> <bw1, bw2, ...>",
+	.tokens = {
+		(void *)&cmd_vf_tc_bw_set,
+		(void *)&cmd_vf_tc_bw_tc,
+		(void *)&cmd_vf_tc_bw_tx,
+		(void *)&cmd_vf_tc_bw_min_bw,
+		(void *)&cmd_vf_tc_bw_port_id,
+		(void *)&cmd_vf_tc_bw_bw_list,
+		NULL,
+	},
+};
+
 struct led_ctrl_result {
 	cmdline_fixed_string_t port;
 	uint16_t port_id;
@@ -55,6 +180,11 @@ cmdline_parse_inst_t  cmd_led_ctrl = {
 
 static struct testpmd_driver_commands sxe_cmds = {
 	.commands = {
+		{
+			&cmd_tc_min_bw,
+			"set tc tx min-bandwidth (port_id) (bw1, bw2, ...)\n"
+			"	Set all TCs' min bandwidth(%%) for all PF and VFs.\n",
+		},
 		{
 			&cmd_led_ctrl,
 			"port <port_id> led on|off\n"
diff --git a/drivers/net/sxe/vf/sxevf.h b/drivers/net/sxe/vf/sxevf.h
new file mode 100644
index 0000000000..60c4a6342f
--- /dev/null
+++ b/drivers/net/sxe/vf/sxevf.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+#ifndef __SXEVF_H__
+#define __SXEVF_H__
+
+#include <rte_pci.h>
+
+#include "sxevf_irq.h"
+#include "sxevf_hw.h"
+#include "sxevf_filter.h"
+#include "sxevf_stats.h"
+
+#define SXEVF_DEVARG_LINK_CHECK		   "link_check"
+
+struct sxevf_adapter {
+	s8 name[PCI_PRI_STR_SIZE + 1];
+	u8 max_rx_queue;
+	u8 max_tx_queue;
+
+	struct sxevf_hw hw;
+	struct sxevf_irq_context irq_ctxt;
+	struct sxevf_vlan_context vlan_ctxt;
+	struct sxevf_mac_filter_context mac_filter_ctxt;
+	struct sxevf_stats_info stats_info;
+
+	pthread_t link_thread_tid;
+	u8 link_check;
+	bool stop;
+	bool rx_batch_alloc_allowed;
+#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SIMD
+	bool rx_vec_allowed;
+#endif
+	u8 rss_reta_updated;
+};
+
+struct sxevf_thread_param {
+	struct rte_eth_dev *dev;
+	pthread_barrier_t barrier;
+};
+
+#endif
diff --git a/drivers/net/sxe/vf/sxevf_ethdev.c b/drivers/net/sxe/vf/sxevf_ethdev.c
new file mode 100644
index 0000000000..117c9d6dba
--- /dev/null
+++ b/drivers/net/sxe/vf/sxevf_ethdev.c
@@ -0,0 +1,752 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+
+#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SRIOV
+
+#include <stdio.h>
+#include <errno.h>
+#include <stdint.h>
+#include <string.h>
+#include <unistd.h>
+#include <stdarg.h>
+#include <inttypes.h>
+
+#include <ethdev_driver.h>
+#include <ethdev_pci.h>
+#include <bus_pci_driver.h>
+
+#include <rte_ethdev.h>
+#include <rte_kvargs.h>
+#include <rte_common.h>
+#include <rte_string_fns.h>
+
+#include "sxevf.h"
+#include "sxe_rx.h"
+#include "sxe_logs.h"
+#include "sxevf_msg.h"
+#include "sxe_errno.h"
+#include "sxevf_tx.h"
+#include "sxevf_rx.h"
+#include "sxevf_ethdev.h"
+#include "sxevf_queue.h"
+#include "sxevf_offload.h"
+#include "sxe_compat_version.h"
+
+#define SXEVF_ETH_OVERHEAD	 (RTE_ETHER_HDR_LEN + RTE_ETHER_CRC_LEN)
+#define SXEVF_HKEY_MAX_INDEX   (10)
+#define SXEVF_RSS_OFFLOAD_ALL ( \
+	RTE_ETH_RSS_IPV4 | \
+	RTE_ETH_RSS_NONFRAG_IPV4_TCP | \
+	RTE_ETH_RSS_NONFRAG_IPV4_UDP | \
+	RTE_ETH_RSS_IPV6 | \
+	RTE_ETH_RSS_NONFRAG_IPV6_TCP | \
+	RTE_ETH_RSS_NONFRAG_IPV6_UDP | \
+	RTE_ETH_RSS_IPV6_EX | \
+	RTE_ETH_RSS_IPV6_TCP_EX | \
+	RTE_ETH_RSS_IPV6_UDP_EX)
+
+#define SXEVF_DEFAULT_RX_FREE_THRESH  32
+#define SXEVF_DEFAULT_RX_PTHRESH	  8
+#define SXEVF_DEFAULT_RX_HTHRESH	  8
+#define SXEVF_DEFAULT_RX_WTHRESH	  0
+
+#define SXEVF_DEFAULT_TX_FREE_THRESH  32
+#define SXEVF_DEFAULT_TX_PTHRESH	  32
+#define SXEVF_DEFAULT_TX_HTHRESH	  0
+#define SXEVF_DEFAULT_TX_WTHRESH	  0
+#define SXEVF_DEFAULT_TX_RSBIT_THRESH 32
+
+#define	SXEVF_MIN_RING_DESC	 32
+#define	SXEVF_MAX_RING_DESC	 4096
+
+#define	SXEVF_ALIGN			 128
+#define SXEVF_RXD_ALIGN		(SXEVF_ALIGN / sizeof(sxevf_rx_data_desc_u))
+#define SXEVF_TXD_ALIGN		(SXEVF_ALIGN / sizeof(sxevf_tx_data_desc_u))
+
+#define SXEVF_TX_MAX_SEG			40
+#define SXEVF_DEFAULT_TX_QUEUE_NUM  1
+#define SXEVF_DEFAULT_RX_QUEUE_NUM  1
+#define SXEVF_RX_BUF_MIN	  1024
+#define SXEVF_RX_BUF_LEN_MAX  9728
+
+static const struct rte_eth_desc_lim rx_desc_lim = {
+	.nb_max = SXEVF_MAX_RING_DESC,
+	.nb_min = SXEVF_MIN_RING_DESC,
+	.nb_align = SXEVF_RXD_ALIGN,
+};
+
+static const struct rte_eth_desc_lim tx_desc_lim = {
+	.nb_max = SXEVF_MAX_RING_DESC,
+	.nb_min = SXEVF_MIN_RING_DESC,
+	.nb_align = SXEVF_TXD_ALIGN,
+	.nb_seg_max = SXEVF_TX_MAX_SEG,
+	.nb_mtu_seg_max = SXEVF_TX_MAX_SEG,
+};
+
+static const char * const sxevf_valid_arguments[] = {
+	SXEVF_DEVARG_LINK_CHECK,
+	NULL
+};
+
+static s32 sxevf_devargs_handle(__rte_unused const char *key, const char *value,
+		  void *extra_args)
+{
+	u16 *n = extra_args;
+	s32 ret;
+
+	if (value == NULL || extra_args == NULL) {
+		ret = -EINVAL;
+		LOG_ERROR("invalid args.(err:%d)", ret);
+		goto l_out;
+	}
+
+	*n = (u16)strtoul(value, NULL, 0);
+	if (*n == USHRT_MAX && errno == ERANGE) {
+		ret = -ERANGE;
+		LOG_ERROR("invalid args.(err:%d)", ret);
+		goto l_out;
+	}
+
+	ret = 0;
+
+l_out:
+	return ret;
+}
+
+static void sxevf_devargs_parse(struct sxevf_adapter *adapter,
+			  struct rte_devargs *devargs)
+{
+	struct rte_kvargs *kvlist;
+	u16 check;
+
+	if (devargs == NULL) {
+		LOG_INFO_BDF("no dev args.");
+		return;
+	}
+
+	kvlist = rte_kvargs_parse(devargs->args, sxevf_valid_arguments);
+	if (kvlist == NULL)
+		return;
+
+	if (rte_kvargs_count(kvlist, SXEVF_DEVARG_LINK_CHECK) == 1 &&
+		rte_kvargs_process(kvlist, SXEVF_DEVARG_LINK_CHECK,
+				   sxevf_devargs_handle, &check) == 0 &&
+		check == 1) {
+		adapter->link_check = 1;
+	}
+
+	LOG_INFO_BDF("dev args link_check:%u", adapter->link_check);
+
+	rte_kvargs_free(kvlist);
+}
+
+static s32 sxevf_hw_dev_reset(struct sxevf_hw *hw)
+{
+	u32 retry = SXEVF_RST_CHECK_NUM;
+	s32 ret;
+	struct sxevf_rst_msg msg = {};
+	struct sxevf_adapter *adapter = hw->adapter;
+	u8 *mac_addr = adapter->mac_filter_ctxt.def_mac_addr.addr_bytes;
+
+	UNUSED(mac_addr);
+	adapter->stop = true;
+
+	sxevf_hw_stop(hw);
+
+	/* Mail box init */
+	sxevf_mbx_init(hw);
+
+
+	sxevf_hw_reset(hw);
+
+	while (!sxevf_pf_rst_check(hw) && retry) {
+		retry--;
+		sxe_udelay(5);
+	}
+
+	if (!retry) {
+		ret = -SXEVF_ERR_RESET_FAILED;
+		LOG_ERROR_BDF("retry: %u use up, pf has not reset done.(err:%d)",
+						SXEVF_RST_CHECK_NUM, ret);
+		goto l_out;
+	}
+
+	LOG_INFO_BDF("pf reset done.");
+
+	hw->mbx.retry = SXEVF_MBX_RETRY_COUNT;
+
+	sxevf_rxtx_reg_init(hw);
+
+	/* Send reset message to pf */
+	msg.msg_type = SXEVF_RESET;
+	ret = sxevf_send_and_rcv_msg(hw, (u32 *)&msg,
+					SXEVF_MSG_NUM(sizeof(msg)));
+	if (ret) {
+		LOG_ERROR_BDF("vf reset msg:%d len:%zu mailbox fail.(err:%d)",
+			  msg.msg_type, SXEVF_MSG_NUM(sizeof(msg)), ret);
+		goto l_out;
+	}
+
+	if (msg.msg_type == (SXEVF_RESET | SXEVF_MSGTYPE_ACK)) {
+		memcpy(&adapter->mac_filter_ctxt.def_mac_addr,
+			(u8 *)(msg.mac_addr), SXEVF_MAC_ADDR_LEN);
+	}
+
+	adapter->mac_filter_ctxt.mc_filter_type = msg.mc_fiter_type;
+
+	LOG_INFO_BDF("vf get mc filter type:%d default mac addr:" RTE_ETHER_ADDR_PRT_FMT " from pf.",
+		  adapter->mac_filter_ctxt.mc_filter_type,
+		  mac_addr[0], mac_addr[1], mac_addr[2],
+		  mac_addr[3], mac_addr[4], mac_addr[5]);
+
+l_out:
+	return ret;
+}
+
+static s32 sxevf_hw_base_init(struct rte_eth_dev *eth_dev)
+{
+	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct sxevf_adapter *adapter = eth_dev->data->dev_private;
+	struct sxevf_hw *hw = &adapter->hw;
+	s32 ret;
+
+	hw->reg_base_addr = (void *)pci_dev->mem_resource[0].addr;
+	PMD_LOG_INFO(INIT, "eth_dev[%u] got reg_base_addr=%p",
+			eth_dev->data->port_id, hw->reg_base_addr);
+	hw->adapter = adapter;
+
+	strlcpy(adapter->name, pci_dev->device.name, sizeof(adapter->name) - 1);
+	adapter->stop = true;
+
+	adapter->max_rx_queue = SXEVF_DEFAULT_RX_QUEUE_NUM;
+	adapter->max_tx_queue = SXEVF_DEFAULT_TX_QUEUE_NUM;
+
+	ret = sxevf_hw_dev_reset(hw);
+	if (ret < 0) {
+		PMD_LOG_ERR(INIT, "hw dev reset failed, ret=%d", ret);
+		goto l_out;
+	} else {
+		adapter->stop = false;
+	}
+
+	ret = sxevf_mac_addr_init(eth_dev);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "mac addr init fail, ret=%d", ret);
+		goto l_out;
+	}
+
+l_out:
+	return ret;
+}
+
+static void sxevf_txrx_start(struct rte_eth_dev *eth_dev)
+{
+	struct sxevf_adapter *adapter = eth_dev->data->dev_private;
+	struct sxevf_hw *hw = &adapter->hw;
+	sxevf_tx_queue_s *txq;
+	sxevf_rx_queue_s *rxq;
+	u16 i;
+
+	for (i = 0; i < eth_dev->data->nb_tx_queues; i++) {
+		txq = eth_dev->data->tx_queues[i];
+		sxevf_tx_ring_switch(hw, txq->reg_idx, true);
+		eth_dev->data->tx_queue_state[i] = RTE_ETH_QUEUE_STATE_STARTED;
+
+	}
+
+	for (i = 0; i < eth_dev->data->nb_rx_queues; i++) {
+		rxq = eth_dev->data->rx_queues[i];
+		sxevf_rx_ring_switch(hw, rxq->reg_idx, true);
+		eth_dev->data->rx_queue_state[i] = RTE_ETH_QUEUE_STATE_STARTED;
+		rte_wmb();
+
+		sxevf_rx_desc_tail_set(hw, rxq->reg_idx, rxq->ring_depth - 1);
+	}
+}
+
+static s32 sxevf_dev_start(struct rte_eth_dev *dev)
+{
+	s32 ret;
+	struct sxevf_adapter *adapter = dev->data->dev_private;
+	struct sxevf_stats_info *stats_info = &adapter->stats_info;
+	struct sxevf_hw *hw = &adapter->hw;
+
+	PMD_INIT_FUNC_TRACE();
+
+	ret = sxevf_hw_dev_reset(hw);
+	if (ret) {
+		LOG_ERROR_BDF("dev reset fail.");
+		goto l_out;
+	}
+
+	sxevf_mbx_api_version_init(adapter);
+
+	sxevf_tx_configure(dev);
+
+	ret = sxevf_rx_configure(dev);
+	if (ret) {
+		LOG_ERROR_BDF("rx configure fail.(err:%d)", ret);
+		goto l_clear_queue;
+	}
+
+	sxevf_vlan_filter_configure(dev);
+
+	sxevf_txrx_start(dev);
+
+	sxevf_irq_configure(dev);
+
+	sxevf_stats_init_value_get(hw, &stats_info->hw_stats);
+
+	adapter->stop = false;
+
+l_out:
+	return ret;
+
+l_clear_queue:
+	sxevf_txrx_queues_clear(dev, adapter->rx_batch_alloc_allowed);
+	return ret;
+}
+
+static s32 sxevf_dev_stop(struct rte_eth_dev *dev)
+{
+	struct sxevf_adapter *adapter = dev->data->dev_private;
+	struct sxevf_hw *hw = &adapter->hw;
+
+	PMD_INIT_FUNC_TRACE();
+
+	if (adapter->stop) {
+		LOG_INFO_BDF("eth dev has been stopped.");
+		goto l_out;
+	}
+
+	adapter->stop = false;
+	dev->data->dev_started = false;
+	dev->data->scattered_rx = false;
+
+	sxevf_hw_stop(hw);
+
+	sxevf_vfta_sync(dev, false);
+
+	sxevf_txrx_queues_clear(dev, adapter->rx_batch_alloc_allowed);
+
+	sxevf_irq_free(dev);
+
+l_out:
+	return 0;
+}
+
+static s32 sxevf_dev_close(struct rte_eth_dev *dev)
+{
+	s32 ret = 0;
+	struct sxevf_adapter *adapter = dev->data->dev_private;
+	struct sxevf_stats_info *stats_info = &adapter->stats_info;
+	struct sxevf_hw *hw = &adapter->hw;
+
+	PMD_INIT_FUNC_TRACE();
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY) {
+		LOG_INFO_BDF("secondery procee can't close dev.");
+		goto l_out;
+	}
+
+	ret = sxevf_hw_dev_reset(hw);
+	if (ret)
+		LOG_ERROR_BDF("dev reset fail.");
+
+	sxevf_dev_stop(dev);
+
+	sxevf_stats_init_value_get(hw, &stats_info->hw_stats);
+
+	sxevf_queues_free(dev);
+
+	sxevf_irq_unregister(dev);
+
+l_out:
+	return ret;
+}
+
+static s32 sxevf_dev_reset(struct rte_eth_dev *dev)
+{
+	s32 ret;
+
+	ret = sxevf_ethdev_uninit(dev);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "dev uninit fail.");
+		goto l_out;
+	}
+
+	ret = sxevf_ethdev_init(dev);
+	if (ret)
+		PMD_LOG_ERR(INIT, "dev init fail.");
+
+l_out:
+	return ret;
+}
+
+static s32 sxevf_dev_info_get(struct rte_eth_dev *dev,
+			 struct rte_eth_dev_info *dev_info)
+{
+	struct sxevf_adapter *adapter = dev->data->dev_private;
+	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+
+	dev_info->max_rx_queues = adapter->max_rx_queue;
+	dev_info->max_tx_queues = adapter->max_tx_queue;
+	dev_info->min_rx_bufsize = SXEVF_RX_BUF_MIN;
+	dev_info->max_rx_pktlen = SXEVF_RX_BUF_LEN_MAX;
+	dev_info->max_mtu = dev_info->max_rx_pktlen - SXEVF_ETH_OVERHEAD;
+	dev_info->max_mac_addrs = adapter->mac_filter_ctxt.uc_table_size;
+	dev_info->max_hash_mac_addrs = SXEVF_UTA_HASH_BIT_MAX;
+	dev_info->max_vfs = pci_dev->max_vfs;
+	dev_info->max_vmdq_pools = RTE_ETH_64_POOLS;
+
+	dev_info->rx_queue_offload_capa = sxevf_rx_queue_offloads_get(dev);
+	dev_info->rx_offload_capa = (sxevf_rx_port_offloads_get(dev) |
+					 dev_info->rx_queue_offload_capa);
+	dev_info->tx_queue_offload_capa = sxevf_tx_queue_offloads_get(dev);
+	dev_info->tx_offload_capa = sxevf_tx_port_offloads_get(dev);
+
+	dev_info->hash_key_size = SXEVF_HKEY_MAX_INDEX * sizeof(u32);
+	dev_info->reta_size = 0;
+	dev_info->flow_type_rss_offloads = SXEVF_RSS_OFFLOAD_ALL;
+
+	dev_info->default_rxconf = (struct rte_eth_rxconf) {
+		.rx_thresh = {
+			.pthresh = SXEVF_DEFAULT_RX_PTHRESH,
+			.hthresh = SXEVF_DEFAULT_RX_HTHRESH,
+			.wthresh = SXEVF_DEFAULT_RX_WTHRESH,
+		},
+		.rx_free_thresh = SXEVF_DEFAULT_RX_FREE_THRESH,
+		.rx_drop_en = 0,
+		.offloads = 0,
+	};
+
+	dev_info->default_txconf = (struct rte_eth_txconf) {
+		.tx_thresh = {
+			.pthresh = SXEVF_DEFAULT_TX_PTHRESH,
+			.hthresh = SXEVF_DEFAULT_TX_HTHRESH,
+			.wthresh = SXEVF_DEFAULT_TX_WTHRESH,
+		},
+		.tx_free_thresh = SXEVF_DEFAULT_TX_FREE_THRESH,
+		.tx_rs_thresh = SXEVF_DEFAULT_TX_RSBIT_THRESH,
+		.offloads = 0,
+	};
+
+	dev_info->rx_desc_lim = rx_desc_lim;
+	dev_info->tx_desc_lim = tx_desc_lim;
+
+	dev_info->err_handle_mode = RTE_ETH_ERROR_HANDLE_MODE_PASSIVE;
+
+	return 0;
+}
+
+static s32 sxevf_mtu_set(struct rte_eth_dev *dev, u16 mtu)
+{
+	struct sxevf_adapter *adapter = dev->data->dev_private;
+	struct sxevf_hw *hw = &adapter->hw;
+	u32 max_frame = mtu + SXEVF_ETH_OVERHEAD;
+	s32 ret;
+
+	if (mtu < RTE_ETHER_MIN_MTU ||
+			max_frame > RTE_ETHER_MAX_JUMBO_FRAME_LEN) {
+		ret = -EINVAL;
+		LOG_ERROR_BDF("invalid mtu:%u.", mtu);
+		goto l_out;
+	}
+
+	if (dev->data->dev_started && !dev->data->scattered_rx &&
+		((max_frame + 2 * SXEVF_VLAN_TAG_SIZE) >
+		 (dev->data->min_rx_buf_size - RTE_PKTMBUF_HEADROOM))) {
+		ret = -EINVAL;
+		LOG_ERROR_BDF("max_frame:%u stop port first.(err:%d)",
+				  max_frame, ret);
+		goto l_out;
+	}
+
+	ret = sxevf_rx_max_frame_set(hw, mtu);
+	if (ret) {
+		LOG_ERROR_BDF("max_frame:%u set fail.(err:%d)", max_frame, ret);
+		ret = -EINVAL;
+		goto l_out;
+	}
+
+	LOG_INFO_BDF("change max frame size to %u success.", max_frame);
+
+l_out:
+	return ret;
+}
+
+static s32 sxevf_dev_configure(struct rte_eth_dev *dev)
+{
+	struct rte_eth_conf *conf = &dev->data->dev_conf;
+	struct sxevf_adapter *adapter = dev->data->dev_private;
+
+	LOG_INFO_BDF("Configured Virtual Function port id: %d",
+			 dev->data->port_id);
+
+	if (dev->data->dev_conf.rxmode.mq_mode & RTE_ETH_MQ_RX_RSS_FLAG)
+		dev->data->dev_conf.rxmode.offloads |= RTE_ETH_RX_OFFLOAD_RSS_HASH;
+
+#ifndef RTE_LIBRTE_SXEVF_PF_DISABLE_STRIP_CRC
+	if (conf->rxmode.offloads & RTE_ETH_RX_OFFLOAD_KEEP_CRC) {
+		LOG_INFO_BDF("VF can't disable HW CRC Strip");
+		conf->rxmode.offloads &= ~RTE_ETH_RX_OFFLOAD_KEEP_CRC;
+	}
+#else
+	if (!(conf->rxmode.offloads & RTE_ETH_RX_OFFLOAD_KEEP_CRC)) {
+		LOG_INFO_BDF("VF can't enable HW CRC Strip");
+		conf->rxmode.offloads |= RTE_ETH_RX_OFFLOAD_KEEP_CRC;
+	}
+#endif
+
+	adapter->rx_batch_alloc_allowed = true;
+
+#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SIMD
+	adapter->rx_vec_allowed = true;
+#endif
+
+	return 0;
+}
+
+static const struct sxevf_reg_info sxevf_regs_general[] = {
+	{SXE_VFCTRL, 1, 1, "SXE_VFCTRL"},
+	{SXE_VFSTATUS, 1, 1, "SXE_VFSTATUS"},
+	{SXE_VFLINKS, 1, 1, "SXE_VFLINKS"},
+	{SXE_VFFRTIMER, 1, 1, "SXE_VFFRTIMER"},
+	{SXE_VFMAILBOX, 1, 1, "SXE_VFMAILBOX"},
+	{SXE_VFMBMEM, 16, 4, "SXE_VFMBMEM"},
+	{SXE_VFRXMEMWRAP, 1, 1, "SXE_VFRXMEMWRAP"},
+	{0, 0, 0, ""}
+};
+
+static const struct sxevf_reg_info sxevf_regs_interrupt[] = {
+	{SXE_VFEICR, 1, 1, "SXE_VFEICR"},
+	{SXE_VFEICS, 1, 1, "SXE_VFEICS"},
+	{SXE_VFEIMS, 1, 1, "SXE_VFEIMS"},
+	{SXE_VFEIMC, 1, 1, "SXE_VFEIMC"},
+	{SXE_VFEIAM, 1, 1, "SXE_VFEIAM"},
+	{SXE_VFEITR(0), 2, 4, "SXE_VFEITR"},
+	{SXE_VFIVAR(0), 4, 4, "SXE_VFIVAR"},
+	{SXE_VFIVAR_MISC, 1, 1, "SXE_VFIVAR_MISC"},
+	{0, 0, 0, ""}
+};
+
+static const struct sxevf_reg_info sxevf_regs_rxdma[] = {
+	{SXE_VFRDBAL(0), 8, 0x40, "SXE_VFRDBAL"},
+	{SXE_VFRDBAH(0), 8, 0x40, "SXE_VFRDBAH"},
+	{SXE_VFRDLEN(0), 8, 0x40, "SXE_VFRDLEN"},
+	{SXE_VFRDH(0), 8, 0x40, "SXE_VFRDH"},
+	{SXE_VFRDT(0), 8, 0x40, "SXE_VFRDT"},
+	{SXE_VFRXDCTL(0), 8, 0x40, "SXE_VFRXDCTL"},
+	{SXE_VFSRRCTL(0), 8, 0x40, "SXE_VFSRRCTL"},
+	{SXE_VFPSRTYPE, 1, 1,	"SXE_VFPSRTYPE"},
+	{SXE_VFLROCTL(0), 8, 0x40, "SXE_VFRSCCTL"},
+	{SXE_VFDCA_RXCTRL(0), 8, 0x40, "SXE_VFDCA_RXCTRL"},
+	{SXE_VFDCA_TXCTRL(0), 8, 0x40, "SXE_VFDCA_TXCTRL"},
+	{0, 0, 0, ""}
+};
+
+static const struct sxevf_reg_info sxevf_regs_tx[] = {
+	{SXE_VFTDBAL(0), 4, 0x40, "SXE_VFTDBAL"},
+	{SXE_VFTDBAH(0), 4, 0x40, "SXE_VFTDBAH"},
+	{SXE_VFTDLEN(0), 4, 0x40, "SXE_VFTDLEN"},
+	{SXE_VFTDH(0), 4, 0x40, "SXE_VFTDH"},
+	{SXE_VFTDT(0), 4, 0x40, "SXE_VFTDT"},
+	{SXE_VFTXDCTL(0), 4, 0x40, "SXE_VFTXDCTL"},
+	{SXE_VFTDWBAL(0), 4, 0x40, "SXE_VFTDWBAL"},
+	{SXE_VFTDWBAH(0), 4, 0x40, "SXE_VFTDWBAH"},
+	{0, 0, 0, ""}
+};
+
+static const struct sxevf_reg_info *sxevf_regs_group[] = {
+				sxevf_regs_general,
+				sxevf_regs_interrupt,
+				sxevf_regs_rxdma,
+				sxevf_regs_tx,
+				NULL};
+
+static u32 sxevf_regs_group_count(const struct sxevf_reg_info *regs)
+{
+	int i = 0;
+	int count = 0;
+
+	while (regs[i].count)
+		count += regs[i++].count;
+
+	return count;
+};
+
+u32 sxevf_regs_group_num_get(void)
+{
+	u32 i = 0;
+	u32 count = 0;
+	const struct sxevf_reg_info *reg_group;
+	const struct sxevf_reg_info **reg_set = sxevf_regs_group;
+
+	while ((reg_group = reg_set[i++]))
+		count += sxevf_regs_group_count(reg_group);
+
+	PMD_LOG_INFO(INIT, "read regs cnt=%u", count);
+
+	return count;
+}
+
+void sxevf_regs_group_read(struct sxevf_hw *hw, u32 *data)
+{
+	u32 cnt = 0, i = 0;
+	const struct sxevf_reg_info *reg_group;
+	const struct sxevf_reg_info **reg_set = sxevf_regs_group;
+
+	while ((reg_group = reg_set[i++]))
+		cnt += sxevf_hw_regs_group_read(hw, reg_group, &data[cnt]);
+
+	PMD_LOG_INFO(INIT, "read regs cnt=%u, regs num=%u",
+				 cnt, sxevf_regs_group_num_get());
+}
+
+static int sxevf_get_regs(struct rte_eth_dev *dev,
+		  struct rte_dev_reg_info *regs)
+{
+	s32 ret = 0;
+	u32 *data = regs->data;
+	struct sxevf_adapter *adapter = dev->data->dev_private;
+	struct sxevf_hw *hw = &adapter->hw;
+	u32 length = sxevf_regs_group_num_get();
+
+	if (data == NULL) {
+		regs->length = length;
+		regs->width = sizeof(u32);
+		goto l_end;
+	}
+
+	if (regs->length == 0 || regs->length == length) {
+		sxevf_regs_group_read(hw, data);
+
+		goto l_end;
+	}
+
+	ret = -ENOTSUP;
+	PMD_LOG_ERR(INIT, "get regs: inval param: regs_len=%u, regs->data=%p, "
+			  "regs_offset=%u,  regs_width=%u, regs_version=%u",
+			  regs->length, regs->data,
+			  regs->offset, regs->width,
+			  regs->version);
+
+l_end:
+	return ret;
+}
+
+static const struct eth_dev_ops sxevf_eth_dev_ops = {
+	.dev_configure		= sxevf_dev_configure,
+	.dev_start		= sxevf_dev_start,
+	.dev_stop		= sxevf_dev_stop,
+	.link_update		= sxevf_link_update,
+	.stats_get		= sxevf_eth_stats_get,
+	.xstats_get		= sxevf_xstats_get,
+	.stats_reset		= sxevf_dev_stats_reset,
+	.xstats_reset		= sxevf_dev_stats_reset,
+	.xstats_get_names	= sxevf_xstats_names_get,
+	.dev_close		= sxevf_dev_close,
+	.dev_reset		= sxevf_dev_reset,
+	.promiscuous_enable	= sxevf_promiscuous_enable,
+	.promiscuous_disable	= sxevf_promiscuous_disable,
+	.allmulticast_enable	= sxevf_allmulticast_enable,
+	.allmulticast_disable	= sxevf_allmulticast_disable,
+	.dev_infos_get		= sxevf_dev_info_get,
+	.dev_supported_ptypes_get = sxevf_dev_supported_ptypes_get,
+	.mtu_set		= sxevf_mtu_set,
+	.vlan_filter_set	= sxevf_vlan_filter_set,
+	.vlan_strip_queue_set	= sxevf_vlan_strip_queue_set,
+	.vlan_offload_set	= sxevf_vlan_offload_set,
+	.rx_queue_setup		= sxevf_rx_queue_setup,
+	.rx_queue_release	= sxevf_rx_queue_release,
+	.tx_queue_setup		= sxevf_tx_queue_setup,
+	.tx_queue_release	= sxevf_tx_queue_release,
+	.rx_queue_intr_enable	= sxevf_rx_queue_intr_enable,
+	.rx_queue_intr_disable	= sxevf_rx_queue_intr_disable,
+	.mac_addr_add		= sxevf_mac_addr_add,
+	.mac_addr_remove	= sxevf_mac_addr_remove,
+	.set_mc_addr_list	= sxevf_set_mc_addr_list,
+	.rxq_info_get		= sxevf_rx_queue_info_get,
+	.txq_info_get		= sxevf_tx_queue_info_get,
+	.mac_addr_set		= sxevf_default_mac_addr_set,
+	.get_reg		= sxevf_get_regs,
+	.reta_update		= sxevf_rss_reta_update,
+	.reta_query		= sxevf_rss_reta_query,
+	.rss_hash_update	= sxevf_rss_hash_update,
+	.rss_hash_conf_get	= sxevf_rss_hash_conf_get,
+	.tx_done_cleanup	= sxevf_tx_done_cleanup,
+	.get_monitor_addr	= sxe_monitor_addr_get,
+};
+
+s32 sxevf_ethdev_init(struct rte_eth_dev *eth_dev)
+{
+	s32 ret = 0;
+	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct sxevf_adapter *adapter = eth_dev->data->dev_private;
+	struct sxevf_stats_info *stats_info = &adapter->stats_info;
+	struct sxevf_hw *hw = &adapter->hw;
+	u8 default_tc;
+	u8 tc_num;
+
+	PMD_INIT_FUNC_TRACE();
+
+	eth_dev->dev_ops = &sxevf_eth_dev_ops;
+
+	eth_dev->rx_descriptor_status = sxevf_rx_descriptor_status;
+	eth_dev->tx_descriptor_status = sxevf_tx_descriptor_status;
+
+	eth_dev->rx_pkt_burst = &sxevf_pkts_recv;
+	eth_dev->tx_pkt_burst = &sxevf_pkts_xmit_with_offload;
+
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY) {
+		sxevf_secondary_proc_init(eth_dev);
+		goto l_out;
+	}
+
+	sxevf_devargs_parse(eth_dev->data->dev_private,
+				  pci_dev->device.devargs);
+
+	rte_eth_copy_pci_info(eth_dev, pci_dev);
+
+	eth_dev->data->dev_flags |= RTE_ETH_DEV_AUTOFILL_QUEUE_XSTATS;
+
+	ret = sxevf_hw_base_init(eth_dev);
+	if (ret) {
+		ret = -EIO;
+		LOG_ERROR_BDF("hw base init fail.(err:%d)", ret);
+		goto l_out;
+	}
+
+	sxevf_dev_stats_reset(eth_dev);
+
+	sxevf_stats_init_value_get(hw, &stats_info->hw_stats);
+
+	sxevf_mbx_api_version_init(adapter);
+
+	sxevf_ring_info_get(adapter, &default_tc, &tc_num);
+
+	sxevf_irq_init(eth_dev);
+
+	LOG_INFO_BDF("sxevf eth dev init done.");
+
+l_out:
+	return ret;
+}
+
+s32 sxevf_ethdev_uninit(struct rte_eth_dev *eth_dev)
+{
+	s32 ret = 0;
+
+	PMD_INIT_FUNC_TRACE();
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY) {
+		PMD_LOG_WARN(INIT, "secondery procee can't unint.");
+		goto l_out;
+	}
+
+	sxevf_dev_close(eth_dev);
+
+l_out:
+	return ret;
+}
+
+#endif
diff --git a/drivers/net/sxe/vf/sxevf_ethdev.h b/drivers/net/sxe/vf/sxevf_ethdev.h
new file mode 100644
index 0000000000..57dfeea2e6
--- /dev/null
+++ b/drivers/net/sxe/vf/sxevf_ethdev.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+
+#ifndef __SXEVF_ETHDEV_H__
+#define __SXEVF_ETHDEV_H__
+
+s32 sxevf_ethdev_init(struct rte_eth_dev *eth_dev);
+
+s32 sxevf_ethdev_uninit(struct rte_eth_dev *eth_dev);
+
+u32 sxevf_regs_group_num_get(void);
+
+void sxevf_regs_group_read(struct sxevf_hw *hw, u32 *data);
+
+#endif
diff --git a/drivers/net/sxe/vf/sxevf_filter.c b/drivers/net/sxe/vf/sxevf_filter.c
new file mode 100644
index 0000000000..c4875f82bc
--- /dev/null
+++ b/drivers/net/sxe/vf/sxevf_filter.c
@@ -0,0 +1,493 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+
+#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SRIOV
+
+#include <string.h>
+#include <rte_ether.h>
+#include <rte_ethdev.h>
+#include <rte_malloc.h>
+
+#include "sxevf.h"
+#include "sxe_logs.h"
+#include "sxevf_msg.h"
+#include "sxe_errno.h"
+#include "sxevf_filter.h"
+#include "sxevf_rx.h"
+#include "sxevf_queue.h"
+#include "sxe_compat_version.h"
+
+#define  SXEVF_MAC_ADDR_EXTRACT_MASK  (0xFFF)
+#define  SXEVF_MAC_ADDR_SHIFT		 (5)
+#define  SXEVF_MAC_ADDR_REG_MASK	  (0x7F)
+#define  SXEVF_MAC_ADDR_BIT_MASK	  (0x1F)
+
+#define SXEVF_STRIP_BITMAP_SET(h, q) \
+	do { \
+		u32 idx = (q) / (sizeof((h)->strip_bitmap[0]) * BYTE_BIT_NUM); \
+		u32 bit = (q) % (sizeof((h)->strip_bitmap[0]) * BYTE_BIT_NUM); \
+		(h)->strip_bitmap[idx] |= 1 << bit;\
+	} while (0)
+
+#define SXEVF_STRIP_BITMAP_CLEAR(h, q) \
+	do {\
+		u32 idx = (q) / (sizeof((h)->strip_bitmap[0]) * BYTE_BIT_NUM); \
+		u32 bit = (q) % (sizeof((h)->strip_bitmap[0]) * BYTE_BIT_NUM); \
+		(h)->strip_bitmap[idx] &= ~(1 << bit);\
+	} while (0)
+
+#define SXEVF_STRIP_BITMAP_GET(h, q, r) \
+	do {\
+		u32 idx = (q) / (sizeof((h)->strip_bitmap[0]) * BYTE_BIT_NUM); \
+		u32 bit = (q) % (sizeof((h)->strip_bitmap[0]) * BYTE_BIT_NUM); \
+		(r) = (h)->strip_bitmap[idx] >> bit & 1;\
+	} while (0)
+
+static void sxevf_random_mac_addr_generate(struct rte_ether_addr *mac_addr)
+{
+	u64 random;
+
+	mac_addr->addr_bytes[0] = 0xe4;
+	mac_addr->addr_bytes[1] = 0xb6;
+	mac_addr->addr_bytes[2] = 0x33;
+
+	mac_addr->addr_bytes[0] |= RTE_ETHER_LOCAL_ADMIN_ADDR;
+
+	random = rte_rand();
+	memcpy(&mac_addr->addr_bytes[3], &random, 3);
+}
+
+s32 sxevf_mac_addr_init(struct rte_eth_dev *eth_dev)
+{
+	struct sxevf_adapter *adapter = eth_dev->data->dev_private;
+	struct sxevf_hw *hw = &adapter->hw;
+	struct sxevf_mac_filter_context *mac_filter = &adapter->mac_filter_ctxt;
+	s32 ret = 0;
+	u8 *mac_addr;
+
+	UNUSED(mac_addr);
+	eth_dev->data->mac_addrs = rte_zmalloc("sxe",
+				RTE_ETHER_ADDR_LEN * SXEVF_HW_UC_ENTRY_NUM_MAX, 0);
+	if (eth_dev->data->mac_addrs == NULL) {
+		LOG_ERROR_BDF("mac addr allocate %u B fail.",
+				 RTE_ETHER_ADDR_LEN * SXEVF_HW_UC_ENTRY_NUM_MAX);
+		ret = -ENOMEM;
+		goto l_out;
+	}
+
+	if (rte_is_zero_ether_addr(&mac_filter->def_mac_addr)) {
+		sxevf_random_mac_addr_generate(&mac_filter->def_mac_addr);
+		ret = sxevf_mac_addr_set(hw, mac_filter->def_mac_addr.addr_bytes);
+		if (ret) {
+			LOG_ERROR_BDF("vf uc mac addr set fail.(err:%d)", ret);
+			goto l_free;
+		}
+		mac_addr = mac_filter->def_mac_addr.addr_bytes;
+		LOG_INFO_BDF("generate random mac_addr:" RTE_ETHER_ADDR_PRT_FMT,
+			mac_addr[0], mac_addr[1], mac_addr[2], mac_addr[3],
+			mac_addr[4], mac_addr[5]);
+	}
+
+	rte_ether_addr_copy(&mac_filter->def_mac_addr, &eth_dev->data->mac_addrs[0]);
+
+	mac_filter->uc_table_size = SXEVF_HW_UC_ENTRY_NUM_MAX;
+
+l_out:
+	return ret;
+
+l_free:
+	rte_free(eth_dev->data->mac_addrs);
+	eth_dev->data->mac_addrs = NULL;
+	return ret;
+}
+
+void sxevf_vfta_sync(struct rte_eth_dev *eth_dev, bool on)
+{
+	struct sxevf_adapter *adapter = eth_dev->data->dev_private;
+	struct sxevf_hw *hw = &adapter->hw;
+	struct sxevf_vlan_context *vlan_ctxt = &adapter->vlan_ctxt;
+	u32 reg_idx;
+	u32 bit_idx;
+	u32 vfta;
+	u32 mask;
+	u32 vlan_id;
+
+	for (reg_idx = 0; reg_idx < SXEVF_VFT_TBL_SIZE; reg_idx++) {
+		vfta = vlan_ctxt->vlan_table[reg_idx];
+		if (vfta) {
+			mask = 1;
+			for (bit_idx = 0; bit_idx < 32; bit_idx++) {
+				vlan_id = (reg_idx << 5) + bit_idx;
+				if (vfta & mask)
+					sxevf_vlan_id_set(hw, vlan_id, on);
+				mask <<= 1;
+			}
+		}
+	}
+}
+
+static void sxevf_vlan_strip_bitmap_set(struct rte_eth_dev *dev, u16 queue_idx, bool on)
+{
+	struct sxevf_adapter *adapter = dev->data->dev_private;
+	struct sxevf_vlan_context *vlan_ctxt = &adapter->vlan_ctxt;
+	sxevf_rx_queue_s *rxq;
+
+	if (queue_idx >= adapter->max_rx_queue) {
+		LOG_ERROR_BDF("invalid queue idx:%u exceed max"
+			   " queue  number:%u.",
+			   queue_idx, adapter->max_rx_queue);
+		return;
+	}
+
+	if (on)
+		SXEVF_STRIP_BITMAP_SET(vlan_ctxt, queue_idx);
+	else
+		SXEVF_STRIP_BITMAP_CLEAR(vlan_ctxt, queue_idx);
+
+	if (queue_idx >= dev->data->nb_rx_queues) {
+		LOG_ERROR_BDF("invalid queue_idx id:%u exceed rx "
+			   " queue number:%u.",
+			   queue_idx, dev->data->nb_rx_queues);
+		return;
+	}
+
+	rxq = dev->data->rx_queues[queue_idx];
+
+	if (on) {
+		rxq->vlan_flags = RTE_MBUF_F_RX_VLAN | RTE_MBUF_F_RX_VLAN_STRIPPED;
+		rxq->offloads |= RTE_ETH_RX_OFFLOAD_VLAN_STRIP;
+	} else {
+		rxq->vlan_flags = RTE_MBUF_F_RX_VLAN;
+		rxq->offloads &= ~RTE_ETH_RX_OFFLOAD_VLAN_STRIP;
+	}
+
+	LOG_INFO_BDF("queue idx:%u vlan strip on:%d set bitmap and offload done.",
+			 queue_idx, on);
+}
+
+static void sxevf_vlan_strip_switch_set(struct rte_eth_dev *dev)
+{
+	struct sxevf_adapter *adapter = dev->data->dev_private;
+	struct sxevf_hw *hw = &adapter->hw;
+	u16 i;
+	sxevf_rx_queue_s *rxq;
+	bool on;
+
+	PMD_INIT_FUNC_TRACE();
+
+	for (i = 0; i < dev->data->nb_rx_queues; i++) {
+		rxq = dev->data->rx_queues[i];
+
+		if (rxq->offloads & RTE_ETH_RX_OFFLOAD_VLAN_STRIP)
+			on = true;
+		else
+			on = false;
+
+		sxevf_hw_vlan_tag_strip_switch(hw, i, on);
+
+		sxevf_vlan_strip_bitmap_set(dev, i, on);
+	}
+}
+
+static void sxevf_vlan_offload_configure(struct rte_eth_dev *dev, s32 mask)
+{
+	if (mask & RTE_ETH_VLAN_STRIP_MASK)
+		sxevf_vlan_strip_switch_set(dev);
+}
+
+void sxevf_vlan_filter_configure(struct rte_eth_dev *eth_dev)
+{
+	u32 vlan_mask;
+
+	sxevf_vfta_sync(eth_dev, true);
+
+	vlan_mask = RTE_ETH_VLAN_STRIP_MASK | RTE_ETH_VLAN_FILTER_MASK |
+			RTE_ETH_VLAN_EXTEND_MASK;
+
+	sxevf_vlan_offload_configure(eth_dev, vlan_mask);
+}
+
+s32 sxevf_promiscuous_enable(struct rte_eth_dev *eth_dev)
+{
+	struct sxevf_adapter *adapter = eth_dev->data->dev_private;
+	struct sxevf_hw *hw = &adapter->hw;
+	s32 ret;
+
+	ret = sxevf_cast_mode_set(hw, SXEVF_CAST_MODE_PROMISC);
+	if (ret) {
+		LOG_ERROR_BDF("cast mode:0x%x set fail.(err:%d)",
+				  SXEVF_CAST_MODE_PROMISC, ret);
+	}
+
+	return ret;
+}
+
+s32 sxevf_promiscuous_disable(struct rte_eth_dev *eth_dev)
+{
+	struct sxevf_adapter *adapter = eth_dev->data->dev_private;
+	struct sxevf_hw *hw = &adapter->hw;
+	s32 mode = SXEVF_CAST_MODE_NONE;
+	s32 ret;
+
+	if (eth_dev->data->all_multicast)
+		mode = SXEVF_CAST_MODE_ALLMULTI;
+	ret = sxevf_cast_mode_set(hw, mode);
+	if (ret)
+		LOG_ERROR_BDF("disable mc promiscuous fail.(err:%d)", ret);
+
+	return ret;
+}
+
+s32 sxevf_allmulticast_enable(struct rte_eth_dev *eth_dev)
+{
+	struct sxevf_adapter *adapter = eth_dev->data->dev_private;
+	struct sxevf_hw *hw = &adapter->hw;
+	s32 ret = 0;
+
+	if (eth_dev->data->promiscuous)
+		goto l_out;
+
+	ret = sxevf_cast_mode_set(hw, SXEVF_CAST_MODE_ALLMULTI);
+	if (ret)
+		LOG_ERROR_BDF("cast mode:0x%x set fail.(err:%d)",
+				  SXEVF_CAST_MODE_ALLMULTI, ret);
+
+l_out:
+	return ret;
+}
+
+s32 sxevf_allmulticast_disable(struct rte_eth_dev *eth_dev)
+{
+	struct sxevf_adapter *adapter = eth_dev->data->dev_private;
+	struct sxevf_hw *hw = &adapter->hw;
+	s32 ret = 0;
+
+	if (eth_dev->data->promiscuous)
+		goto l_out;
+
+	ret = sxevf_cast_mode_set(hw, SXEVF_CAST_MODE_MULTI);
+	if (ret)
+		LOG_ERROR_BDF("disable mc promiscuous fail.(err:%d)", ret);
+
+l_out:
+	return ret;
+}
+
+s32 sxevf_vlan_filter_set(struct rte_eth_dev *eth_dev,  u16 vlan_id, s32 on)
+{
+	struct sxevf_adapter *adapter = eth_dev->data->dev_private;
+	struct sxevf_hw *hw = &adapter->hw;
+	struct sxevf_vlan_context *vlan_ctxt = &adapter->vlan_ctxt;
+	s32 ret;
+	u8 reg_idx;
+	u8 bit_idx;
+
+	ret = sxevf_vlan_id_set(hw, vlan_id, on);
+	if (ret) {
+		LOG_ERROR_BDF("vlan_id:0x%x status:%u set fail.(err:%d)",
+				  vlan_id, on, ret);
+		goto l_out;
+	}
+
+	reg_idx = (vlan_id >> SXEVF_VLAN_ID_SHIFT) & SXEVF_VLAN_ID_REG_MASK;
+	bit_idx = (vlan_id & SXEVF_VLAN_ID_BIT_MASK);
+
+	if (on)
+		vlan_ctxt->vlan_table[reg_idx] |= (1 << bit_idx);
+	else
+		vlan_ctxt->vlan_table[reg_idx] &= ~(1 << bit_idx);
+
+	LOG_INFO_BDF("vlan_id:0x%x status:%u set success.", vlan_id, on);
+
+l_out:
+	return ret;
+}
+
+void sxevf_vlan_strip_queue_set(struct rte_eth_dev *dev, u16 queue, s32 on)
+{
+	struct sxevf_adapter *adapter = dev->data->dev_private;
+	struct sxevf_hw *hw = &adapter->hw;
+
+	if (queue > adapter->max_rx_queue) {
+		LOG_ERROR_BDF("queue id:%u invalid exceed max rx queue num:%u",
+				  queue, adapter->max_rx_queue);
+		return;
+	}
+
+	sxevf_hw_vlan_tag_strip_switch(hw, queue, on);
+
+	sxevf_vlan_strip_bitmap_set(dev, queue, on);
+
+	LOG_INFO_BDF("queue:%u vlan tag strip on:%u done", queue, on);
+}
+
+static void sxevf_vlan_strip_offload_configure(struct rte_eth_dev *dev, s32 mask)
+{
+	u16 i;
+	struct rte_eth_rxmode *rxmode = &dev->data->dev_conf.rxmode;
+	sxevf_rx_queue_s *rxq;
+
+	if (mask & RTE_ETH_VLAN_STRIP_MASK) {
+		if (rxmode->offloads & RTE_ETH_RX_OFFLOAD_VLAN_STRIP) {
+			for (i = 0; i < dev->data->nb_rx_queues; i++) {
+				rxq = dev->data->rx_queues[i];
+				rxq->offloads |= RTE_ETH_RX_OFFLOAD_VLAN_STRIP;
+			}
+		} else {
+			for (i = 0; i < dev->data->nb_rx_queues; i++) {
+				rxq = dev->data->rx_queues[i];
+				rxq->offloads &= ~RTE_ETH_RX_OFFLOAD_VLAN_STRIP;
+			}
+		}
+	}
+
+	PMD_LOG_INFO(DRV, "mask:0x%x rx mode offload:0x%" SXE_PRIX64
+			 " all queue vlan strip offload flag configure done",
+			 mask, rxmode->offloads);
+}
+
+s32 sxevf_vlan_offload_set(struct rte_eth_dev *dev, s32 mask)
+{
+	sxevf_vlan_strip_offload_configure(dev, mask);
+
+	sxevf_vlan_offload_configure(dev, mask);
+
+	PMD_LOG_INFO(DRV, "vlan offload mask:0x%x set done.", mask);
+
+	return 0;
+}
+
+s32 sxevf_default_mac_addr_set(struct rte_eth_dev *dev,
+				 struct rte_ether_addr *mac_addr)
+{
+	s32 ret;
+	struct sxevf_adapter *adapter = dev->data->dev_private;
+	struct sxevf_hw *hw = &adapter->hw;
+	u8 *addr = mac_addr->addr_bytes;
+
+	UNUSED(addr);
+	ret = sxevf_mac_addr_set(hw, mac_addr->addr_bytes);
+	if (ret) {
+		LOG_ERROR_BDF("modify default mac addr to " RTE_ETHER_ADDR_PRT_FMT " fail.(err:%d)",
+				  addr[0], addr[1], addr[2], addr[3], addr[4], addr[5], ret);
+	}
+
+	LOG_INFO_BDF("modify default mac addr to " RTE_ETHER_ADDR_PRT_FMT " success.",
+			  addr[0], addr[1], addr[2], addr[3], addr[4], addr[5]);
+
+	return ret;
+}
+
+s32 sxevf_mac_addr_add(struct rte_eth_dev *dev,
+				 struct rte_ether_addr *mac_addr,
+				 __rte_unused u32 rar_idx, __rte_unused u32 pool)
+{
+	s32 ret;
+	struct sxevf_adapter *adapter = dev->data->dev_private;
+	struct sxevf_hw *hw = &adapter->hw;
+	struct sxevf_mac_filter_context *mac_ctxt = &adapter->mac_filter_ctxt;
+	u8 *addr = mac_addr->addr_bytes;
+
+	UNUSED(addr);
+	if (memcmp(mac_ctxt->def_mac_addr.addr_bytes, mac_addr->addr_bytes,
+			sizeof(*mac_addr)) == 0) {
+		ret = -EINVAL;
+		LOG_ERROR_BDF("mac_addr:" RTE_ETHER_ADDR_PRT_FMT " eaqual to defalut mac addr"
+				 " skip mac addr add.(err:%d)",
+				 addr[0], addr[1], addr[2], addr[3], addr[4], addr[5], ret);
+		goto l_out;
+	}
+
+	ret = sxevf_uc_addr_add(hw, 2, mac_addr->addr_bytes);
+	if (ret) {
+		LOG_ERROR_BDF("mac_addr:" RTE_ETHER_ADDR_PRT_FMT " add fail.(err:%d)",
+				  addr[0], addr[1], addr[2], addr[3], addr[4], addr[5], ret);
+		goto l_out;
+	}
+
+	LOG_INFO_BDF("mac_addr:" RTE_ETHER_ADDR_PRT_FMT " add success.",
+				addr[0], addr[1], addr[2], addr[3], addr[4], addr[5]);
+
+l_out:
+	return ret;
+}
+
+void sxevf_mac_addr_remove(struct rte_eth_dev *dev, u32 index)
+{
+	struct sxevf_adapter *adapter = dev->data->dev_private;
+	struct sxevf_hw *hw = &adapter->hw;
+	struct sxevf_mac_filter_context *mac_ctxt = &adapter->mac_filter_ctxt;
+	struct rte_ether_addr *mac_addr;
+	u8 *addr;
+	u8 i;
+
+	sxevf_uc_addr_add(hw, 0, NULL);
+
+	for (i = 0, mac_addr = dev->data->mac_addrs; i < mac_ctxt->uc_table_size;
+		 i++, mac_addr++) {
+		if (i == index || rte_is_zero_ether_addr(mac_addr) ||
+		(memcmp(mac_ctxt->def_mac_addr.addr_bytes, mac_addr->addr_bytes,
+				sizeof(*mac_addr)) == 0)) {
+			continue;
+		}
+		sxevf_uc_addr_add(hw, 2, mac_addr->addr_bytes);
+	}
+	addr = dev->data->mac_addrs[index].addr_bytes;
+	UNUSED(addr);
+	LOG_INFO_BDF("index:%u mac addr" RTE_ETHER_ADDR_PRT_FMT " remove success.",
+			  index, addr[0], addr[1], addr[2], addr[3], addr[4], addr[5]);
+}
+
+static u16 sxevf_hash_mac_addr_parse(u8 *mac_addr)
+{
+	u16 extracted = ((mac_addr[4] >> 4) |
+			(((u16)mac_addr[5]) << 4));
+
+	extracted &= SXEVF_MAC_ADDR_EXTRACT_MASK;
+
+	PMD_LOG_DEBUG(DRV, "mac_addr:" RTE_ETHER_ADDR_PRT_FMT " parse result:0x%x",
+			 mac_addr[0], mac_addr[1], mac_addr[2], mac_addr[3],
+			 mac_addr[4], mac_addr[5], extracted);
+
+	return extracted;
+}
+
+s32 sxevf_set_mc_addr_list(struct rte_eth_dev *dev,
+			  struct rte_ether_addr *mc_addr_list,
+			  u32 nb_mc_addr)
+{
+	s32 ret;
+	u32 result;
+	struct sxevf_mc_sync_msg msg;
+	struct sxevf_adapter *adapter = dev->data->dev_private;
+	struct sxevf_hw *hw = &adapter->hw;
+	u32 i;
+
+	msg.msg_type = SXEVF_MC_ADDR_SYNC;
+	msg.mc_cnt = RTE_MIN(nb_mc_addr, (u32)SXEVF_MC_ENTRY_NUM_MAX);
+
+	for (i = 0; i < msg.mc_cnt; i++) {
+		msg.mc_addr_extract[i] = sxevf_hash_mac_addr_parse(mc_addr_list->addr_bytes);
+		mc_addr_list++;
+	}
+
+	ret = sxevf_send_and_rcv_msg(hw, (u32 *)&msg, SXEVF_MSG_NUM(sizeof(msg)));
+	result = (msg.mc_cnt << 16) | msg.msg_type;
+
+	if (ret || ((result & SXEVF_MC_ADDR_SYNC) &&
+			(result & SXEVF_MSGTYPE_NACK))) {
+		ret = ret ? ret : -SXEVF_ERR_MSG_HANDLE_ERR;
+		goto l_out;
+	}
+
+	PMD_LOG_DEBUG(DRV, "msg_type:0x%x len:%zu mc_cnt:%d msg "
+		  "result:0x%x.(ret:%d)",
+		  msg.msg_type, SXEVF_MSG_NUM(sizeof(msg)),
+		  msg.mc_cnt, result, ret);
+
+l_out:
+	return ret;
+}
+
+#endif
diff --git a/drivers/net/sxe/vf/sxevf_filter.h b/drivers/net/sxe/vf/sxevf_filter.h
new file mode 100644
index 0000000000..6fa51e3af1
--- /dev/null
+++ b/drivers/net/sxe/vf/sxevf_filter.h
@@ -0,0 +1,70 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+
+#ifndef __SXEVF_FILTER_H__
+#define __SXEVF_FILTER_H__
+
+#include <rte_ether.h>
+#include <ethdev_driver.h>
+
+#define SXEVF_MTA_ENTRY_NUM_MAX		128
+#define SXEVF_UTA_HASH_BIT_MAX		 4096
+#define VLAN_N_VID	 4096
+#define BYTE_BIT_NUM   8
+
+#define  SXEVF_VLAN_ID_SHIFT		 (5)
+#define  SXEVF_VLAN_ID_REG_MASK	  (0x7F)
+#define  SXEVF_VLAN_ID_BIT_MASK	  (0x1F)
+
+#define SXEVF_VLAN_STRIP_BITMAP_SIZE \
+		(SXEVF_HW_TXRX_RING_NUM_MAX / (sizeof(u32) * BYTE_BIT_NUM))
+
+struct sxevf_vlan_context {
+	u32 vlan_table[SXEVF_VFT_TBL_SIZE];
+	u32 strip_bitmap[SXEVF_VLAN_STRIP_BITMAP_SIZE];
+	u32 vlan_table_size;
+};
+
+struct sxevf_mac_filter_context {
+	struct rte_ether_addr def_mac_addr;
+	u8  mc_filter_type;
+	u32 uc_table_size;
+};
+
+void sxevf_vlan_filter_init(struct rte_eth_dev *eth_dev);
+
+s32 sxevf_mac_addr_init(struct rte_eth_dev *eth_dev);
+
+void sxevf_vlan_filter_configure(struct rte_eth_dev *eth_dev);
+
+void sxevf_vfta_sync(struct rte_eth_dev *eth_dev, bool on);
+
+s32 sxevf_promiscuous_disable(struct rte_eth_dev *eth_dev);
+
+s32 sxevf_promiscuous_enable(struct rte_eth_dev *eth_dev);
+
+s32 sxevf_allmulticast_disable(struct rte_eth_dev *eth_dev);
+
+s32 sxevf_allmulticast_enable(struct rte_eth_dev *eth_dev);
+
+s32 sxevf_vlan_filter_set(struct rte_eth_dev *eth_dev,  u16 vlan_id, s32 on);
+
+void sxevf_vlan_strip_queue_set(struct rte_eth_dev *dev, u16 queue, s32 on);
+
+s32 sxevf_vlan_offload_set(struct rte_eth_dev *dev, s32 mask);
+
+s32 sxevf_default_mac_addr_set(struct rte_eth_dev *dev,
+				 struct rte_ether_addr *mac_addr);
+
+void sxevf_mac_addr_remove(struct rte_eth_dev *dev, u32 index);
+
+s32 sxevf_mac_addr_add(struct rte_eth_dev *dev,
+				 struct rte_ether_addr *mac_addr,
+				 __rte_unused u32 rar_idx, __rte_unused u32 pool);
+
+s32 sxevf_set_mc_addr_list(struct rte_eth_dev *dev,
+			  struct rte_ether_addr *mc_addr_list,
+			  u32 nb_mc_addr);
+
+#endif
diff --git a/drivers/net/sxe/vf/sxevf_irq.c b/drivers/net/sxe/vf/sxevf_irq.c
new file mode 100644
index 0000000000..3263f56313
--- /dev/null
+++ b/drivers/net/sxe/vf/sxevf_irq.c
@@ -0,0 +1,432 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+
+#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SRIOV
+
+#include <rte_ethdev.h>
+#include <rte_pci.h>
+#include <rte_alarm.h>
+#include <rte_interrupts.h>
+#include <rte_malloc.h>
+#include <bus_pci_driver.h>
+#include <eal_interrupts.h>
+#include "sxevf.h"
+#include "sxe_logs.h"
+#include "sxe_errno.h"
+#include "sxevf_rx.h"
+#include "sxevf_irq.h"
+#include "sxevf_msg.h"
+#include "sxevf_queue.h"
+#include "sxe_compat_version.h"
+
+#define SXEVF_IRQ_LINK_CONFIG	  (u32)(1 << 3)
+
+#define SXEVF_RX_OTHER_IRQ_MASK	 (3)
+
+#define SXEVF_MISC_VEC_ID		RTE_INTR_VEC_ZERO_OFFSET
+
+#define SXEVF_RX_VEC_BASE		  RTE_INTR_VEC_RXTX_OFFSET
+
+#define SXEVF_EITR_INTERVAL_UNIT_NS	2048
+#define SXEVF_EITR_ITR_INT_SHIFT		3
+#define SXEVF_IRQ_ITR_MASK			  (0x00000FF8)
+#define SXEVF_EITR_INTERVAL_US(us) \
+	(((us) * 1000 / SXEVF_EITR_INTERVAL_UNIT_NS << SXEVF_EITR_ITR_INT_SHIFT) & \
+		SXEVF_IRQ_ITR_MASK)
+
+#define SXEVF_QUEUE_ITR_INTERVAL_DEFAULT   500
+#define SXEVF_QUEUE_ITR_INTERVAL   3
+
+void sxevf_intr_disable(struct rte_eth_dev *eth_dev)
+{
+	struct sxevf_adapter *adapter = eth_dev->data->dev_private;
+	struct sxevf_hw *hw = &adapter->hw;
+	struct sxevf_irq_context *irq_ctxt = &adapter->irq_ctxt;
+
+	PMD_INIT_FUNC_TRACE();
+
+	sxevf_irq_disable(hw);
+
+	irq_ctxt->enable_mask = 0;
+}
+
+void sxevf_intr_enable(struct rte_eth_dev *eth_dev)
+{
+	struct sxevf_adapter *adapter = eth_dev->data->dev_private;
+	struct sxevf_hw *hw = &adapter->hw;
+	struct sxevf_irq_context *irq_ctxt = &adapter->irq_ctxt;
+
+	PMD_INIT_FUNC_TRACE();
+
+	sxevf_irq_enable(hw, SXEVF_RX_OTHER_IRQ_MASK);
+
+	irq_ctxt->enable_mask = SXEVF_RX_OTHER_IRQ_MASK;
+}
+
+static s32 sxevf_ctrl_msg_check(struct rte_eth_dev *eth_dev)
+{
+	struct sxevf_adapter *adapter = eth_dev->data->dev_private;
+	struct sxevf_hw *hw = &adapter->hw;
+	u32 ctrl_msg;
+	s32 ret;
+
+	ret = sxevf_ctrl_msg_rcv_and_clear(hw, (u32 *)&ctrl_msg,
+				SXEVF_MSG_NUM(sizeof(ctrl_msg)));
+	if (ret) {
+		PMD_LOG_INFO(DRV, "ctrl msg rcv fail due to lock fail.(err:%d)", ret);
+		goto l_end;
+	}
+
+	if (ctrl_msg & SXEVF_PF_CTRL_MSG_REINIT) {
+		sxe_eth_dev_callback_process(eth_dev, RTE_ETH_EVENT_INTR_RESET,
+						 NULL);
+		PMD_LOG_INFO(DRV, "rcv reinit msg.");
+	}
+
+l_end:
+	return ret;
+}
+
+static s32 sxevf_link_msg_check(struct rte_eth_dev *eth_dev, bool *link_up)
+{
+	struct sxevf_adapter *adapter = eth_dev->data->dev_private;
+	struct sxevf_hw *hw = &adapter->hw;
+	u32 ctrl_msg;
+	s32 ret;
+
+	ret = sxevf_ctrl_msg_rcv_and_clear(hw, (u32 *)&ctrl_msg,
+				SXEVF_MSG_NUM(sizeof(ctrl_msg)));
+	if (ret) {
+		PMD_LOG_INFO(DRV, "ctrl msg rcv fail due to lock fail.(err:%d)", ret);
+		goto l_end;
+	}
+
+	if (ctrl_msg & SXEVF_PF_CTRL_MSG_NETDEV_DOWN) {
+		*link_up = false;
+		PMD_LOG_INFO(DRV, "rcv ctrl msg:0x%x need link down.", ctrl_msg);
+	} else if (ctrl_msg & SXEVF_PF_CTRL_MSG_LINK_UPDATE) {
+		*link_up = true;
+		PMD_LOG_INFO(DRV, "rcv ctrl msg:0x%x physical link up.", ctrl_msg);
+	}
+
+l_end:
+	return ret;
+}
+
+static void sxevf_mbx_irq_handler(void *data)
+{
+	struct rte_eth_dev *eth_dev = (struct rte_eth_dev *)data;
+
+	sxevf_intr_disable(eth_dev);
+
+	sxevf_ctrl_msg_check(eth_dev);
+
+	sxevf_intr_enable(eth_dev);
+}
+
+void sxevf_irq_init(struct rte_eth_dev *eth_dev)
+{
+	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct rte_intr_handle *irq_handle = SXE_PCI_INTR_HANDLE(pci_dev);
+
+	sxevf_intr_disable(eth_dev);
+
+	rte_intr_callback_register(irq_handle,
+				   sxevf_mbx_irq_handler, eth_dev);
+
+	rte_intr_enable(irq_handle);
+	sxevf_intr_enable(eth_dev);
+}
+
+static s32 sxevf_msix_configure(struct rte_eth_dev *dev)
+{
+	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_intr_handle *handle = SXE_PCI_INTR_HANDLE(pci_dev);
+	struct sxevf_adapter *adapter = dev->data->dev_private;
+	struct sxevf_hw *hw = &adapter->hw;
+	sxevf_rx_queue_s *rx_queue;
+	u16 queue_id;
+	u16 vector = SXEVF_MISC_VEC_ID;
+	u16 base = SXEVF_MISC_VEC_ID;
+	u32 irq_interval;
+	s32 ret = 0;
+
+	sxevf_event_irq_map(hw, vector);
+
+	if (!rte_intr_dp_is_en(handle)) {
+		ret = -SXE_ERR_PARAM;
+		PMD_LOG_ERR(DRV, "intr type:%u nb_efd:%u irq unsupported.(err:%d)",
+				  handle->type, handle->nb_efd, ret);
+		goto l_out;
+	}
+
+	if (rte_intr_allow_others(handle)) {
+		vector = SXEVF_RX_VEC_BASE;
+		base = SXEVF_RX_VEC_BASE;
+	}
+
+	irq_interval = SXEVF_EITR_INTERVAL_US(SXEVF_QUEUE_ITR_INTERVAL_DEFAULT);
+	if (rte_intr_dp_is_en(handle))
+		irq_interval = SXEVF_EITR_INTERVAL_US(SXEVF_QUEUE_ITR_INTERVAL);
+
+	for (queue_id = 0; queue_id < dev->data->nb_rx_queues;
+		queue_id++) {
+		rx_queue = dev->data->rx_queues[queue_id];
+		if (rte_intr_dp_is_en(handle))
+			sxevf_ring_irq_interval_set(hw, vector, irq_interval);
+
+		sxevf_hw_ring_irq_map(hw, false,
+					rx_queue->reg_idx,
+					vector);
+		handle->intr_vec[queue_id] = vector;
+		PMD_LOG_INFO(DRV,
+				"queue id:%u reg_idx:%u vector:%u ",
+				queue_id,
+				rx_queue->reg_idx,
+				vector);
+		if (vector < base + handle->nb_efd - 1)
+			vector++;
+	}
+
+	sxevf_ring_irq_interval_set(hw, 0, irq_interval);
+
+l_out:
+	return ret;
+}
+
+s32 sxevf_irq_configure(struct rte_eth_dev *eth_dev)
+{
+	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct rte_intr_handle *handle = SXE_PCI_INTR_HANDLE(pci_dev);
+	u16 irq_num;
+	s32 ret = 0;
+
+	if (rte_intr_cap_multiple(handle) &&
+		 eth_dev->data->dev_conf.intr_conf.rxq != 0) {
+		irq_num = 1;
+		if (rte_intr_efd_enable(handle, irq_num)) {
+			ret = -SXE_ERR_CONFIG;
+			PMD_LOG_ERR(DRV,
+					  "intr_handle type:%d irq num:%d invalid",
+					  handle->type, irq_num);
+			goto l_out;
+		}
+	}
+
+	if (rte_intr_dp_is_en(handle) && !handle->intr_vec) {
+		handle->intr_vec = rte_zmalloc("intr_vec",
+					eth_dev->data->nb_rx_queues * sizeof(u32), 0);
+		if (handle->intr_vec == NULL) {
+			PMD_LOG_ERR(DRV, "rx queue irq vector "
+					 "allocate %zuB memory fail.",
+					 eth_dev->data->nb_rx_queues * sizeof(u32));
+			ret = -ENOMEM;
+			goto l_out;
+		}
+	}
+
+	ret = sxevf_msix_configure(eth_dev);
+	if (ret) {
+		PMD_LOG_ERR(DRV, "intr type:%u nb_efd:%u irq unsupported.(err:%d)",
+				  handle->type, handle->nb_efd, ret);
+		goto l_out;
+	}
+
+	rte_intr_disable(handle);
+
+	rte_intr_enable(handle);
+
+	sxevf_intr_enable(eth_dev);
+
+	PMD_LOG_INFO(DRV,
+			  "intr_handle type:%d rx queue num:%d "
+			  "queue irq num:%u total irq num:%u "
+			  "config done",
+			  handle->type,
+			  eth_dev->data->nb_rx_queues,
+			  handle->nb_efd,
+			  handle->max_intr);
+
+l_out:
+	return ret;
+}
+
+void sxevf_irq_free(struct rte_eth_dev *eth_dev)
+{
+	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct rte_intr_handle *handle = SXE_PCI_INTR_HANDLE(pci_dev);
+
+	rte_intr_disable(handle);
+
+	if (handle->intr_vec) {
+		rte_free(handle->intr_vec);
+		handle->intr_vec = NULL;
+	}
+}
+
+void sxevf_irq_unregister(struct rte_eth_dev *eth_dev)
+{
+	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct rte_intr_handle *handle = SXE_PCI_INTR_HANDLE(pci_dev);
+
+	rte_intr_callback_unregister(handle, sxevf_mbx_irq_handler, eth_dev);
+}
+
+s32 sxevf_rx_queue_intr_enable(struct rte_eth_dev *dev, u16 queue_id)
+{
+	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_intr_handle *intr_handle = SXE_PCI_INTR_HANDLE(pci_dev);
+	struct sxevf_adapter *adapter = dev->data->dev_private;
+	struct sxevf_hw *hw = &adapter->hw;
+	struct sxevf_irq_context *irq_ctxt = &adapter->irq_ctxt;
+	u32 vector = SXEVF_MISC_VEC_ID;
+
+	RTE_SET_USED(queue_id);
+
+	if (rte_intr_allow_others(intr_handle))
+		vector = SXEVF_RX_VEC_BASE;
+
+	irq_ctxt->enable_mask |= (1 << vector);
+
+	sxevf_specific_irq_enable(hw, irq_ctxt->enable_mask);
+
+	rte_intr_ack(intr_handle);
+
+	return 0;
+}
+
+s32 sxevf_rx_queue_intr_disable(struct rte_eth_dev *dev, u16 queue_id)
+{
+	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_intr_handle *intr_handle = SXE_PCI_INTR_HANDLE(pci_dev);
+	struct sxevf_adapter *adapter = dev->data->dev_private;
+	struct sxevf_hw *hw = &adapter->hw;
+	struct sxevf_irq_context *irq_ctxt = &adapter->irq_ctxt;
+	u32 vector = SXEVF_MISC_VEC_ID;
+
+	RTE_SET_USED(queue_id);
+
+	if (rte_intr_allow_others(intr_handle))
+		vector = SXEVF_RX_VEC_BASE;
+
+	irq_ctxt->enable_mask &= ~(1 << vector);
+
+	sxevf_specific_irq_enable(hw, irq_ctxt->enable_mask);
+
+	return 0;
+}
+
+static void sxevf_physical_link_check(struct rte_eth_dev *dev,  u32 *link_speed, bool *link_up)
+{
+	u32 link_reg, i;
+	struct sxevf_adapter *adapter = dev->data->dev_private;
+	struct sxevf_hw *hw = &adapter->hw;
+
+	link_reg = sxevf_link_state_get(hw);
+	if (!(link_reg & SXE_VFLINKS_UP)) {
+		*link_up = false;
+		goto l_end;
+	}
+
+	for (i = 0; i < 5; i++) {
+		sxe_udelay(100);
+		link_reg = sxevf_link_state_get(hw);
+		if (!(link_reg & SXE_VFLINKS_UP)) {
+			*link_up = false;
+			goto l_end;
+		}
+	}
+
+	switch (link_reg & SXE_VFLINKS_SPEED) {
+	case SXE_VFLINKS_SPEED_10G:
+		*link_speed = SXEVF_LINK_SPEED_10GB_FULL;
+		break;
+	case SXE_VFLINKS_SPEED_1G:
+		*link_speed = SXEVF_LINK_SPEED_1GB_FULL;
+		break;
+	case SXE_VFLINKS_SPEED_100:
+		*link_speed = SXEVF_LINK_SPEED_100_FULL;
+		break;
+	default:
+		*link_speed = SXEVF_LINK_SPEED_UNKNOWN;
+	}
+
+	*link_up = true;
+
+l_end:
+	PMD_LOG_INFO(DRV, "link up status:%d.", *link_up);
+}
+
+static void sxevf_link_info_get(struct rte_eth_dev *dev, int wait_to_complete,
+				   u32 *link_speed, bool *link_up)
+{
+	s32 ret;
+	struct sxevf_adapter *adapter = dev->data->dev_private;
+
+	sxevf_physical_link_check(dev, link_speed, link_up);
+
+	if (wait_to_complete == 0 && adapter->link_check == 0) {
+		if (*link_speed == SXEVF_LINK_SPEED_UNKNOWN)
+			*link_up = false;
+		else
+			*link_up = true;
+		return;
+	}
+
+	if (*link_up) {
+		ret = sxevf_link_msg_check(dev, link_up);
+		if (ret) {
+			PMD_LOG_ERR(DRV, "ctrl msg rcv fail, try to next workqueue.");
+			return;
+		}
+	}
+}
+
+s32 sxevf_link_update(struct rte_eth_dev *dev, int wait_to_complete)
+{
+	bool link_up;
+	struct rte_eth_link link;
+	u32 link_speed = SXEVF_LINK_SPEED_UNKNOWN;
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
+	if (wait_to_complete == 0 || dev->data->dev_conf.intr_conf.lsc)
+		wait_to_complete = 0;
+
+	sxevf_link_info_get(dev, wait_to_complete, &link_speed, &link_up);
+
+	if (!link_up) {
+		PMD_LOG_ERR(DRV, "other link thread is running now!");
+
+		goto l_end;
+	}
+
+	link.link_status = RTE_ETH_LINK_UP;
+	link.link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
+	switch (link_speed) {
+	case SXEVF_LINK_SPEED_1GB_FULL:
+		link.link_speed = RTE_ETH_SPEED_NUM_1G;
+		break;
+
+	case SXEVF_LINK_SPEED_10GB_FULL:
+		link.link_speed = RTE_ETH_SPEED_NUM_10G;
+		break;
+	default:
+		link.link_speed = RTE_ETH_SPEED_NUM_UNKNOWN;
+	}
+
+l_end:
+	PMD_LOG_INFO(DRV, "link update end, up=%x, speed=%x",
+			  link_up, link_speed);
+	return rte_eth_linkstatus_set(dev, &link);
+}
+
+#endif
diff --git a/drivers/net/sxe/vf/sxevf_irq.h b/drivers/net/sxe/vf/sxevf_irq.h
new file mode 100644
index 0000000000..2f9860ba15
--- /dev/null
+++ b/drivers/net/sxe/vf/sxevf_irq.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+
+#ifndef __SXEVF_IRQ_H__
+#define __SXEVF_IRQ_H__
+
+#include <ethdev_driver.h>
+#include "sxe_compat_platform.h"
+
+struct sxevf_irq_context {
+	u32 enable_mask;
+	u32 enable_mask_original;
+};
+
+void sxevf_intr_disable(struct rte_eth_dev *eth_dev);
+
+void sxevf_intr_enable(struct rte_eth_dev *eth_dev);
+
+void sxevf_irq_init(struct rte_eth_dev *eth_dev);
+
+s32 sxevf_irq_configure(struct rte_eth_dev *eth_dev);
+
+void sxevf_irq_free(struct rte_eth_dev *eth_dev);
+
+void sxevf_irq_unregister(struct rte_eth_dev *eth_dev);
+
+s32 sxevf_rx_queue_intr_disable(struct rte_eth_dev *dev, u16 queue_id);
+
+s32 sxevf_rx_queue_intr_enable(struct rte_eth_dev *dev, u16 queue_id);
+
+s32 sxevf_link_update(struct rte_eth_dev *dev, int wait_to_complete);
+
+#endif
diff --git a/drivers/net/sxe/vf/sxevf_main.c b/drivers/net/sxe/vf/sxevf_main.c
new file mode 100644
index 0000000000..b1924c1475
--- /dev/null
+++ b/drivers/net/sxe/vf/sxevf_main.c
@@ -0,0 +1,82 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+
+#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SRIOV
+
+#include <string.h>
+#include <sys/time.h>
+
+#include <rte_log.h>
+#include <rte_pci.h>
+#include <rte_dev.h>
+
+#include "sxe_version.h"
+#include <ethdev_driver.h>
+#include <ethdev_pci.h>
+#include <bus_pci_driver.h>
+
+#include "sxevf.h"
+#include "sxe_logs.h"
+#include "sxevf_ethdev.h"
+#include "sxe_queue_common.h"
+
+#define PCI_VENDOR_ID_STARS	  0x1FF2
+#define SXEVF_DEV_ID_ASIC		0x10A2
+
+static s32 sxevf_probe(struct rte_pci_driver *pci_drv __rte_unused,
+					struct rte_pci_device *pci_dev)
+{
+	s32 ret;
+
+	PMD_LOG_INFO(INIT, "sxe_version[%s], sxe_commit_id[%s], sxe_branch[%s], sxe_build_time[%s]",
+		SXE_VERSION, SXE_COMMIT_ID, SXE_BRANCH, SXE_BUILD_TIME);
+
+#ifdef SXE_DPDK_DEBUG
+	sxe_log_stream_init();
+#endif
+
+	ret = rte_eth_dev_pci_generic_probe(pci_dev,
+		sizeof(struct sxevf_adapter), sxevf_ethdev_init);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "sxe pmd eth dev create fail.(err:%d)", ret);
+		goto l_out;
+	}
+
+	PMD_LOG_DEBUG(INIT, "%s sxevf pmd probe done.", pci_dev->device.name);
+
+l_out:
+	return ret;
+}
+
+static s32 sxevf_remove(struct rte_pci_device *pci_dev)
+{
+	s32 ret;
+
+	ret = rte_eth_dev_pci_generic_remove(pci_dev,
+			sxevf_ethdev_uninit);
+	if (ret)
+		LOG_ERROR("vf remove fail.(err:%d)", ret);
+
+	return ret;
+}
+
+static const struct rte_pci_id sxevf_pci_tbl[] = {
+	{ RTE_PCI_DEVICE(PCI_VENDOR_ID_STARS, SXEVF_DEV_ID_ASIC) },
+	{.vendor_id = 0,}
+};
+
+static struct rte_pci_driver rte_sxevf_pmd = {
+	.id_table  = sxevf_pci_tbl,
+	.drv_flags = RTE_PCI_DRV_NEED_MAPPING,
+	.probe	 = sxevf_probe,
+	.remove	= sxevf_remove,
+};
+
+RTE_PMD_REGISTER_PCI(net_sxevf, rte_sxevf_pmd);
+RTE_PMD_REGISTER_PCI_TABLE(net_sxevf, sxevf_pci_tbl);
+RTE_PMD_REGISTER_KMOD_DEP(net_sxevf, "* igb_uio | vfio-pci");
+RTE_PMD_REGISTER_PARAM_STRING(net_sxevf,
+				  SXEVF_DEVARG_LINK_CHECK "=<0|1>");
+
+#endif
diff --git a/drivers/net/sxe/vf/sxevf_msg.c b/drivers/net/sxe/vf/sxevf_msg.c
new file mode 100644
index 0000000000..37d3f2c5dc
--- /dev/null
+++ b/drivers/net/sxe/vf/sxevf_msg.c
@@ -0,0 +1,624 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+
+#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SRIOV
+
+#include "sxevf.h"
+#include "sxevf_msg.h"
+#include "sxevf_hw.h"
+#include "sxe_errno.h"
+#include "sxe_logs.h"
+
+#define SXEVF_PFMSG_MASK	0xFF00
+#define SXEVF_DEFAULT_TC_NUM		1
+
+void sxevf_mbx_init(struct sxevf_hw *hw)
+{
+	hw->mbx.msg_len = SXEVF_MBX_MSG_NUM;
+
+	hw->mbx.stats.rcv_msgs = 0;
+	hw->mbx.stats.send_msgs = 0;
+	hw->mbx.stats.acks = 0;
+	hw->mbx.stats.reqs = 0;
+	hw->mbx.stats.rsts = 0;
+
+	hw->mbx.retry = 0;
+	hw->mbx.interval = SXEVF_MBX_RETRY_INTERVAL;
+
+	hw->mbx.api_version = SXEVF_MBX_API_10;
+}
+
+static u32 sxevf_mbx_reg_read(struct sxevf_hw *hw)
+{
+	u32 value = sxevf_mailbox_read(hw);
+
+	value |= hw->mbx.reg_value;
+
+	hw->mbx.reg_value |= value & SXE_VFMAILBOX_RC_BIT;
+
+	return value;
+}
+
+static bool sxevf_mbx_bit_check(struct sxevf_hw *hw, u32 mask)
+{
+	bool ret = false;
+	u32 value = sxevf_mbx_reg_read(hw);
+
+	if (value & mask)
+		ret = true;
+
+	hw->mbx.reg_value &= ~mask;
+
+	return ret;
+}
+
+static bool sxevf_pf_msg_check(struct sxevf_hw *hw)
+{
+	bool ret = false;
+
+	if (sxevf_mbx_bit_check(hw, SXE_VFMAILBOX_PFSTS)) {
+		hw->mbx.stats.reqs++;
+		ret = true;
+	}
+
+	return ret;
+}
+
+static bool sxevf_pf_ack_check(struct sxevf_hw *hw)
+{
+	bool ret = false;
+
+	if (sxevf_mbx_bit_check(hw, SXE_VFMAILBOX_PFACK)) {
+		hw->mbx.stats.acks++;
+		ret = true;
+	}
+
+	return ret;
+}
+
+bool sxevf_pf_rst_check(struct sxevf_hw *hw)
+{
+	bool ret = false;
+
+	if (!sxevf_mbx_bit_check(hw, (SXE_VFMAILBOX_RSTI |
+					  SXE_VFMAILBOX_RSTD))) {
+		hw->mbx.stats.rsts++;
+		ret = true;
+	}
+
+	return ret;
+}
+
+static s32 sxevf_mailbox_lock(struct sxevf_hw *hw)
+{
+	u32 mailbox;
+	u32 retry = SXEVF_MBX_RETRY_COUNT;
+	s32 ret = -SXEVF_ERR_MBX_LOCK_FAIL;
+
+	while (retry--) {
+		mailbox = sxevf_mbx_reg_read(hw);
+		mailbox |= SXE_VFMAILBOX_VFU;
+		sxevf_mailbox_write(hw, mailbox);
+
+		if (sxevf_mbx_reg_read(hw) & SXE_VFMAILBOX_VFU) {
+			ret = 0;
+			break;
+		}
+
+		sxe_udelay(hw->mbx.interval);
+	}
+
+	return ret;
+}
+
+static void sxevf_mailbox_unlock(struct sxevf_hw *hw)
+{
+	u32 mailbox;
+
+	mailbox = sxevf_mbx_reg_read(hw);
+	mailbox &= ~SXE_VFMAILBOX_VFU;
+	sxevf_mailbox_write(hw, mailbox);
+}
+
+static bool sxevf_msg_poll(struct sxevf_hw *hw)
+{
+	struct sxevf_mbx_info *mbx = &hw->mbx;
+	u32 retry = mbx->retry;
+	bool ret = true;
+	struct sxevf_adapter *adapter = hw->adapter;
+
+	while (!sxevf_pf_msg_check(hw) && retry) {
+		retry--;
+		sxe_udelay(mbx->interval);
+	}
+
+	if (!retry) {
+		LOG_ERROR_BDF("retry:%d send msg to pf done, but don't check pf reply.",
+			  mbx->retry);
+		mbx->retry = 0;
+		ret = false;
+	}
+
+	return ret;
+}
+
+static bool sxevf_ack_poll(struct sxevf_hw *hw)
+{
+	struct sxevf_mbx_info *mbx = &hw->mbx;
+	u32 retry = mbx->retry;
+	bool ret = true;
+	struct sxevf_adapter *adapter = hw->adapter;
+
+	while (!sxevf_pf_ack_check(hw) && retry) {
+		retry--;
+		sxe_udelay(mbx->interval);
+	}
+
+	if (!retry) {
+		LOG_ERROR_BDF("send msg to pf, retry:%d but don't check pf ack, "
+			  "init mbx retry to 0.",
+			  mbx->retry);
+		mbx->retry = 0;
+		ret = false;
+	}
+
+	return ret;
+}
+
+static void sxevf_pf_msg_and_ack_clear(struct sxevf_hw *hw)
+{
+	struct sxevf_adapter *adapter = hw->adapter;
+
+	LOG_INFO_BDF("clear pending pf msg and ack.");
+
+	sxevf_pf_msg_check(hw);
+	sxevf_pf_ack_check(hw);
+}
+
+static s32 sxevf_send_msg_to_pf(struct sxevf_hw *hw, u32 *msg, u16 msg_len)
+{
+	struct sxevf_mbx_info *mbx = &hw->mbx;
+	s32 ret = 0;
+	u16 i;
+	u32 old;
+	struct sxevf_adapter *adapter = hw->adapter;
+
+	if (!mbx->retry) {
+		ret = -SXEVF_ERR_NOT_READY;
+		LOG_ERROR_BDF("msg:0x%x len:%d send fail due to timeout.(err:%d)",
+			  msg[0], msg_len, ret);
+		goto l_out;
+	}
+
+	if (msg_len > mbx->msg_len) {
+		ret = -EINVAL;
+		LOG_ERROR_BDF("vf msg:0x%x len:%d exceed limit:%d "
+			  "send fail.(err:%d)",
+			  msg[0], msg_len, mbx->msg_len, ret);
+		goto l_out;
+	}
+
+	ret = sxevf_mailbox_lock(hw);
+	if (ret) {
+		LOG_ERROR_BDF("msg:0x%x len:%d send lock mailbox fail.(err:%d)",
+			   msg[0], msg_len, ret);
+		goto l_out;
+	}
+
+	sxevf_pf_msg_and_ack_clear(hw);
+
+	old = sxevf_msg_read(hw, 0);
+	msg[0] |= (old & SXEVF_PFMSG_MASK);
+
+	for (i = 0; i < msg_len; i++)
+		sxevf_msg_write(hw, i, msg[i]);
+
+	sxevf_pf_req_irq_trigger(hw);
+
+	hw->mbx.stats.send_msgs++;
+
+	if (!sxevf_ack_poll(hw)) {
+		ret = -SXEVF_ERR_POLL_ACK_FAIL;
+		LOG_ERROR_BDF("msg:0x%x len:%d send done, but don't poll ack.",
+			   msg[0], msg_len);
+		goto l_out;
+	}
+
+	LOG_INFO_BDF("vf send msg:0x%x len:%d to pf and polled pf ack done."
+		 "stats send_msg:%d ack:%d.",
+		 msg[0], msg_len,
+		 mbx->stats.send_msgs, mbx->stats.acks);
+
+l_out:
+	return ret;
+}
+
+s32 sxevf_mbx_msg_rcv(struct sxevf_hw *hw, u32 *msg, u16 msg_len)
+{
+	u32 i;
+	u16 msg_entry;
+	s32 ret = 0;
+	struct sxevf_mbx_info *mbx = &hw->mbx;
+	struct sxevf_adapter *adapter = hw->adapter;
+
+	msg_entry = (msg_len > mbx->msg_len) ? mbx->msg_len : msg_len;
+
+	ret = sxevf_mailbox_lock(hw);
+	if (ret) {
+		LOG_ERROR_BDF("size:%d rcv lock mailbox fail.(err:%d)",
+			   msg_entry, ret);
+		goto l_end;
+	}
+
+	for (i = 0; i < msg_entry; i++)
+		msg[i] = sxevf_msg_read(hw, i);
+
+	msg[0] &= ~SXEVF_PFMSG_MASK;
+
+	sxevf_pf_ack_irq_trigger(hw);
+
+	mbx->stats.rcv_msgs++;
+l_end:
+	return ret;
+}
+
+s32 sxevf_ctrl_msg_rcv(struct sxevf_hw *hw, u32 *msg, u16 msg_len)
+{
+	u16 i;
+	u16 msg_entry;
+	s32 ret = 0;
+	struct sxevf_mbx_info *mbx = &hw->mbx;
+	struct sxevf_adapter *adapter = hw->adapter;
+
+	msg_entry = (msg_len > mbx->msg_len) ? mbx->msg_len : msg_len;
+
+	ret = sxevf_mailbox_lock(hw);
+	if (ret) {
+		LOG_ERROR_BDF("size:%d rcv lock mailbox fail.(err:%d)",
+			   msg_entry, ret);
+		goto l_end;
+	}
+
+	for (i = 0; i < msg_entry; i++)
+		msg[i] = sxevf_msg_read(hw, i);
+
+	sxevf_mailbox_unlock(hw);
+
+	LOG_INFO_BDF("rcv pf mailbox msg:0x%x.", *msg);
+
+	mbx->stats.rcv_msgs++;
+l_end:
+	return ret;
+}
+
+s32 sxevf_ctrl_msg_rcv_and_clear(struct sxevf_hw *hw, u32 *msg, u16 msg_len)
+{
+	u16 i;
+	u16 msg_entry;
+	s32 ret = 0;
+	u32 clear;
+	struct sxevf_mbx_info *mbx = &hw->mbx;
+	struct sxevf_adapter *adapter = hw->adapter;
+
+	msg_entry = (msg_len > mbx->msg_len) ? mbx->msg_len : msg_len;
+
+	ret = sxevf_mailbox_lock(hw);
+	if (ret) {
+		LOG_ERROR_BDF("size:%d rcv lock mailbox fail.(err:%d)",
+			   msg_entry, ret);
+		goto l_end;
+	}
+
+	for (i = 0; i < msg_entry; i++)
+		msg[i] = sxevf_msg_read(hw, i);
+
+	clear = msg[0] & (~SXEVF_PFMSG_MASK);
+	sxevf_msg_write(hw, 0, clear);
+
+	sxevf_mailbox_unlock(hw);
+
+	LOG_INFO_BDF("rcv pf mailbox msg:0x%x.", *msg);
+
+	mbx->stats.rcv_msgs++;
+l_end:
+	return ret;
+}
+
+static s32 sxevf_rcv_msg_from_pf(struct sxevf_hw *hw, u32 *msg, u16 msg_len)
+{
+	s32 ret;
+	struct sxevf_adapter *adapter = hw->adapter;
+
+	if (!sxevf_msg_poll(hw)) {
+		ret = -SXEVF_ERR_POLL_MSG_FAIL;
+		LOG_ERROR_BDF("retry:%d don't poll pf msg.", hw->mbx.retry);
+		goto l_out;
+	}
+
+	ret = sxevf_mbx_msg_rcv(hw, msg, msg_len);
+	if (ret < 0) {
+		LOG_ERROR_BDF("retry:%d read msg fail.", hw->mbx.retry);
+		goto l_out;
+	}
+
+	LOG_INFO_BDF("vf polled pf msg:0x%x and rcv pf msg done. "
+		"stats req:%d rcv_msg:%d",
+		 msg[0], hw->mbx.stats.reqs, hw->mbx.stats.rcv_msgs);
+
+l_out:
+	return ret;
+}
+
+s32 sxevf_send_and_rcv_msg(struct sxevf_hw *hw, u32 *msg, u8 msg_len)
+{
+	s32 ret;
+	u16 msg_type = msg[0] & 0xFF;
+	struct sxevf_adapter *adapter = hw->adapter;
+
+	ret = sxevf_send_msg_to_pf(hw, msg, msg_len);
+	if (ret) {
+		LOG_ERROR_BDF("msg:0x%x len:%u msg send fail.(err:%d).",
+			   msg[0], msg_len, ret);
+		goto l_out;
+	}
+
+	if (msg_type == SXEVF_RESET)
+		mdelay(10);
+
+	ret = sxevf_rcv_msg_from_pf(hw, msg, msg_len);
+	if (ret) {
+		LOG_ERROR_BDF("msg:0x%x len:%u rcv fail.(err:%d).",
+			   msg[0], msg_len, ret);
+		goto l_out;
+	}
+
+	LOG_INFO_BDF("send and rcv msg:0x%x len:%u success.", msg[0], msg_len);
+
+l_out:
+	return ret;
+}
+
+void sxevf_mbx_api_version_init(struct sxevf_adapter *adapter)
+{
+	s32 ret;
+	struct sxevf_hw *hw = &adapter->hw;
+	static const int api[] = {
+		SXEVF_MBX_API_13,
+		SXEVF_MBX_API_12,
+		SXEVF_MBX_API_11,
+		SXEVF_MBX_API_10,
+		SXEVF_MBX_API_NR
+	};
+	u32 idx = 0;
+	struct sxevf_mbx_api_msg msg;
+
+	while (api[idx] != SXEVF_MBX_API_NR) {
+		msg.msg_type = SXEVF_API_NEGOTIATE;
+		msg.api_version = api[idx];
+
+		ret = sxevf_send_and_rcv_msg(hw, (u32 *)&msg, SXEVF_MSG_NUM(sizeof(msg)));
+		if (!ret && (msg.msg_type == (SXEVF_API_NEGOTIATE | SXEVF_MSGTYPE_ACK))) {
+			hw->mbx.api_version = api[idx];
+			break;
+		}
+		idx++;
+	}
+
+	LOG_INFO_BDF("mailbox api version:%u", hw->mbx.api_version);
+}
+
+s32 sxevf_ring_info_get(struct sxevf_adapter *adapter,
+			u8 *tc_num, u8 *default_tc)
+{
+	struct sxevf_hw *hw = &adapter->hw;
+	struct sxevf_ring_info_msg req = {};
+	s32 ret;
+
+	req.msg_type = SXEVF_RING_INFO_GET;
+	ret = sxevf_send_and_rcv_msg(hw, (u32 *)&req,
+					 SXEVF_MSG_NUM(sizeof(req)));
+	if (ret) {
+		LOG_ERROR_BDF("msg:0x%x send or rcv reply failed.(err:%d)",
+			   req.msg_type, ret);
+		goto l_out;
+	}
+
+	if (req.msg_type != (SXEVF_MSGTYPE_ACK | SXEVF_RING_INFO_GET)) {
+		ret = -SXEVF_ERR_REPLY_INVALID;
+		LOG_WARN_BDF("msg:0x%x not expected.(err:%d)", req.msg_type, ret);
+		goto l_out;
+	}
+
+	LOG_DEBUG_BDF("original ring info from pf, max_tx_num:%u max_rx_num:%u "
+		 "tc_num:%u default_tc:%u.",
+		 req.max_tx_num, req.max_rx_num, req.tc_num, req.default_tc);
+
+	if (req.max_tx_num == 0 ||
+		req.max_tx_num > SXEVF_TXRX_RING_NUM_MAX) {
+		req.max_tx_num = SXEVF_TXRX_RING_NUM_MAX;
+	}
+
+	if (req.max_rx_num == 0 ||
+		req.max_rx_num > SXEVF_TXRX_RING_NUM_MAX) {
+		req.max_rx_num = SXEVF_TXRX_RING_NUM_MAX;
+	}
+
+	if (req.tc_num > req.max_rx_num)
+		req.tc_num = SXEVF_DEFAULT_TC_NUM;
+
+	*tc_num = req.tc_num;
+
+	if (req.default_tc > req.max_tx_num)
+		req.default_tc = 0;
+
+	*default_tc = req.default_tc;
+
+	adapter->max_rx_queue = req.max_rx_num;
+	adapter->max_tx_queue = req.max_tx_num;
+
+	LOG_INFO_BDF("ring info max_tx_num:%u max_rx_num:%u "
+		 "tc_num:%u default_tc:%u.",
+		 req.max_tx_num, req.max_rx_num, req.tc_num, req.default_tc);
+
+l_out:
+	return ret;
+}
+
+s32 sxevf_rss_hash_config_get(struct sxevf_adapter *adapter,
+			struct rte_eth_rss_conf *rss_conf)
+{
+	struct sxevf_hw *hw = &adapter->hw;
+	struct sxevf_rss_hash_msg msg = {};
+	s32 ret;
+
+	msg.msg_type = SXEVF_RSS_CONF_GET;
+	ret = sxevf_send_and_rcv_msg(hw, (u32 *)&msg,
+					 SXEVF_MSG_NUM(sizeof(msg)));
+	if (ret) {
+		LOG_ERROR_BDF("msg:0x%x send or rcv reply failed.(err:%d)",
+			   msg.msg_type, ret);
+		goto l_out;
+	}
+
+	if (msg.msg_type != (SXEVF_MSGTYPE_ACK | SXEVF_RSS_CONF_GET)) {
+		ret = -SXEVF_ERR_REPLY_INVALID;
+		LOG_WARN_BDF("msg:0x%x not expected.(err:%d)", msg.msg_type, ret);
+		goto l_out;
+	}
+
+	rss_conf->rss_key = msg.hash_key;
+	rss_conf->rss_hf = msg.rss_hf;
+
+	LOG_INFO_BDF("rss hash conf get success, msg:0x%x rss_key:%s rss_func:%" SXE_PRID64 ". ",
+		 msg.msg_type, msg.hash_key, msg.rss_hf);
+
+l_out:
+	return ret;
+}
+
+s32 sxevf_mac_addr_set(struct sxevf_hw *hw, u8 *uc_addr)
+{
+	s32 ret;
+	struct sxevf_uc_addr_msg msg = {};
+	struct sxevf_adapter *adapter = hw->adapter;
+
+	msg.msg_type = SXEVF_DEV_MAC_ADDR_SET;
+	memcpy(msg.uc_addr, uc_addr, SXEVF_MAC_ADDR_LEN);
+
+	ret = sxevf_send_and_rcv_msg(hw, (u32 *)&msg, SXEVF_MSG_NUM(sizeof(msg)));
+	if (!ret && (msg.msg_type ==
+		   (SXEVF_DEV_MAC_ADDR_SET | SXEVF_MSGTYPE_NACK))) {
+		ret = -EPERM;
+		LOG_ERROR_BDF("msg:0x%x uc addr:%pM replyed nack.",
+			   msg.msg_type, uc_addr);
+		goto l_out;
+	}
+
+	if (ret) {
+		LOG_ERROR_BDF("msg:0x%x uc addr:%pM set fail.(err:%d)",
+			   msg.msg_type, uc_addr, ret);
+		ret = -EPERM;
+		goto l_out;
+	}
+
+	LOG_INFO_BDF("msg:0x%x uc addr:%pM set success.", msg.msg_type, uc_addr);
+
+l_out:
+	return ret;
+}
+
+s32 sxevf_rx_max_frame_set(struct sxevf_hw *hw, u32 mtu)
+{
+	struct sxevf_max_frame_msg msg = {};
+	s32 ret;
+	struct sxevf_adapter *adapter = hw->adapter;
+
+	msg.msg_type = SXEVF_LPE_SET;
+	msg.max_frame = mtu;
+
+	ret = sxevf_send_and_rcv_msg(hw, (u32 *)&msg,
+						 SXEVF_MSG_NUM(sizeof(msg)));
+	if (ret || ((msg.msg_type & SXEVF_LPE_SET) &&
+			(msg.msg_type & SXEVF_MSGTYPE_NACK))) {
+		ret = ret ? ret : -SXEVF_ERR_MSG_HANDLE_ERR;
+	}
+
+	LOG_INFO_BDF("msg_type:0x%x max_frame:0x%x (ret:%d)",
+		   msg.msg_type, msg.max_frame, ret);
+
+	return ret;
+}
+
+s32 sxevf_vlan_id_set(struct sxevf_hw *hw, u32 vlan_id,
+						 bool vlan_on)
+{
+	struct sxevf_vlan_filter_msg msg = {};
+	s32 ret;
+	struct sxevf_adapter *adapter = hw->adapter;
+
+	msg.msg_type = SXEVF_VLAN_SET;
+	msg.vlan_id = vlan_id;
+	msg.msg_type |= vlan_on << SXEVF_MSGINFO_SHIFT;
+
+	LOG_INFO_BDF("update vlan[%u], vlan on = %s", vlan_id, vlan_on ? "yes" : "no");
+	ret = sxevf_send_and_rcv_msg(hw, (u32 *)&msg,
+						 SXEVF_MSG_NUM(sizeof(msg)));
+	LOG_INFO_BDF("update vlan[%u] ret = %d", vlan_id, ret);
+
+	msg.msg_type &= ~(0xFF << SXEVF_MSGINFO_SHIFT);
+
+	if (ret || (msg.msg_type != (SXEVF_VLAN_SET | SXEVF_MSGTYPE_ACK)))
+		ret = ret ? ret : -SXEVF_ERR_MSG_HANDLE_ERR;
+
+	return ret;
+}
+
+s32 sxevf_cast_mode_set(struct sxevf_hw *hw, enum sxevf_cast_mode mode)
+{
+	struct sxevf_cast_mode_msg msg = {};
+	s32 ret;
+	struct sxevf_adapter *adapter = hw->adapter;
+
+	msg.msg_type = SXEVF_CAST_MODE_SET;
+	msg.cast_mode = mode;
+
+	ret = sxevf_send_and_rcv_msg(hw, (u32 *)&msg, SXEVF_MSG_NUM(sizeof(msg)));
+	if (ret || (msg.msg_type != (SXEVF_CAST_MODE_SET | SXEVF_MSGTYPE_ACK)))
+		ret = ret ? ret : -SXEVF_ERR_MSG_HANDLE_ERR;
+
+	LOG_INFO_BDF("msg_type:0x%x mode:0x%x msg result:0x%x.(ret:%d)",
+		   msg.msg_type, mode, msg.msg_type, ret);
+
+	return ret;
+}
+
+s32 sxevf_uc_addr_add(struct sxevf_hw *hw, u32 index, u8 *mac_addr)
+{
+	s32 ret = 0;
+	struct sxevf_adapter *adapter = hw->adapter;
+	struct sxevf_uc_sync_msg msg = {};
+	u32 check;
+	u32 result;
+
+	msg.msg_type = SXEVF_UC_ADDR_SYNC;
+	msg.index = index;
+	check = *(u32 *)&msg;
+
+	if (mac_addr)
+		memcpy((u8 *)&msg.addr, mac_addr, SXEVF_MAC_ADDR_LEN);
+
+	ret = sxevf_send_and_rcv_msg(hw, (u32 *)&msg, SXEVF_MSG_NUM(sizeof(msg)));
+	result = *(u32 *)&msg;
+
+	if (ret || (result != (check | SXEVF_MSGTYPE_ACK)))
+		ret = ret ? ret : -SXEVF_ERR_MSG_HANDLE_ERR;
+
+	LOG_INFO_BDF("msg_type:0x%x index:%d addr:%pM sync done "
+		 " result:0x%x msg.(ret:%d)",
+		 msg.msg_type, index, mac_addr, result, ret);
+
+	return ret;
+}
+
+#endif
diff --git a/drivers/net/sxe/vf/sxevf_msg.h b/drivers/net/sxe/vf/sxevf_msg.h
new file mode 100644
index 0000000000..f017117dff
--- /dev/null
+++ b/drivers/net/sxe/vf/sxevf_msg.h
@@ -0,0 +1,201 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+#ifndef __SXEVF_MSG_H__
+#define __SXEVF_MSG_H__
+
+struct sxevf_adapter;
+
+#define SXEVF_MAC_ADDR_LEN 6
+
+#define SXEVF_UC_ENTRY_NUM_MAX 10
+#define SXEVF_MC_ENTRY_NUM_MAX 30
+
+#define SXEVF_MBX_MSG_NUM		16
+#define SXEVF_MBX_RETRY_INTERVAL 500
+#define SXEVF_MBX_RETRY_COUNT	2000
+
+#define SXEVF_RST_CHECK_NUM		  10000
+
+#define SXEVF_DEFAULT_ADDR_LEN	   4
+#define SXEVF_MC_FILTER_TYPE_WORD	3
+
+#define SXEVF_RESET			   0x01
+#define SXEVF_DEV_MAC_ADDR_SET	0x02
+#define SXEVF_MC_ADDR_SYNC		0x03
+#define SXEVF_VLAN_SET			0x04
+#define SXEVF_LPE_SET			 0x05
+
+#define SXEVF_UC_ADDR_SYNC		0x06
+
+#define SXEVF_API_NEGOTIATE	   0x08
+
+#define SXEVF_RING_INFO_GET	   0x09
+
+#define SXEVF_REDIR_TBL_GET		 0x0a
+#define SXEVF_RSS_KEY_GET		   0x0b
+#define SXEVF_CAST_MODE_SET		 0x0c
+#define SXEVF_LINK_ENABLE_GET	   0X0d
+#define SXEVF_IPSEC_ADD			 0x0e
+#define SXEVF_IPSEC_DEL			 0x0f
+#define SXEVF_RSS_CONF_GET		  0x10
+
+#define SXEVF_PF_CTRL_MSG_LINK_UPDATE  0x100
+#define SXEVF_PF_CTRL_MSG_NETDEV_DOWN   0x200
+
+#define SXEVF_PF_CTRL_MSG_REINIT		0x400
+
+#define SXEVF_PF_CTRL_MSG_MASK		  0x700
+#define SXEVF_PFREQ_MASK				0xFF00
+
+#define SXEVF_RSS_HASH_KEY_SIZE   (40)
+#define SXEVF_MAX_RETA_ENTRIES	(128)
+#define SXEVF_RETA_ENTRIES_DWORDS (SXEVF_MAX_RETA_ENTRIES / 16)
+
+#define SXEVF_TX_QUEUES	  1
+#define SXEVF_RX_QUEUES	  2
+#define SXEVF_TRANS_VLAN	 3
+#define SXEVF_DEF_QUEUE	  4
+
+#define SXEVF_MSGTYPE_ACK	0x80000000
+#define SXEVF_MSGTYPE_NACK   0x40000000
+
+#define SXEVF_MSGINFO_SHIFT  16
+#define SXEVF_MSGINFO_MASK   (0xFF << SXEVF_MSGINFO_SHIFT)
+
+#define SXEVF_MSG_NUM(size)   DIV_ROUND_UP(size, 4)
+
+enum sxevf_mbx_api_version {
+	SXEVF_MBX_API_10 = 0,
+	SXEVF_MBX_API_11,
+	SXEVF_MBX_API_12,
+	SXEVF_MBX_API_13,
+	SXEVF_MBX_API_14,
+
+	SXEVF_MBX_API_NR,
+};
+
+enum sxevf_cast_mode {
+	SXEVF_CAST_MODE_NONE = 0,
+	SXEVF_CAST_MODE_MULTI,
+	SXEVF_CAST_MODE_ALLMULTI,
+	SXEVF_CAST_MODE_PROMISC,
+};
+
+struct sxevf_rst_msg {
+	u32 msg_type;
+	u32 mac_addr[2];
+	u32 mc_fiter_type;
+};
+
+struct sxevf_mbx_api_msg {
+	u32 msg_type;
+	u32 api_version;
+};
+
+struct sxevf_ring_info_msg {
+	u32 msg_type;
+	u8  max_rx_num;
+	u8  max_tx_num;
+	u8  tc_num;
+	u8  default_tc;
+};
+
+struct sxevf_uc_addr_msg {
+	u32 msg_type;
+	u8 uc_addr[SXEVF_MAC_ADDR_LEN];
+	u16 pad;
+};
+
+struct sxevf_cast_mode_msg {
+	u32 msg_type;
+	u32 cast_mode;
+};
+
+struct sxevf_mc_sync_msg {
+	u16 msg_type;
+	u16 mc_cnt;
+	u16 mc_addr_extract[SXEVF_MC_ENTRY_NUM_MAX];
+};
+
+struct sxevf_uc_sync_msg {
+	u16 msg_type;
+	u16 index;
+	u32 addr[2];
+};
+
+struct sxevf_max_frame_msg {
+	u32 msg_type;
+	u32 max_frame;
+};
+
+struct sxevf_vlan_filter_msg {
+	u32 msg_type;
+	u32 vlan_id;
+};
+
+struct sxevf_redir_tbl_msg {
+	u32 type;
+	u32 entries[SXEVF_RETA_ENTRIES_DWORDS];
+};
+
+struct sxevf_rss_hsah_key_msg {
+	u32 type;
+	u8  hash_key[SXEVF_RSS_HASH_KEY_SIZE];
+};
+
+struct sxevf_rss_hash_msg {
+	u32 msg_type;
+	u8  hash_key[SXEVF_RSS_HASH_KEY_SIZE];
+	u64 rss_hf;
+};
+
+struct sxevf_ipsec_add_msg {
+	u32 msg_type;
+	u32 pf_sa_idx;
+	__be32 spi;
+	u8 flags;
+	u8 proto;
+	u16 family;
+	__be32 addr[4];
+	u32 key[5];
+};
+
+struct sxevf_ipsec_del_msg {
+	u32 msg_type;
+	u32 sa_idx;
+};
+
+void sxevf_mbx_init(struct sxevf_hw *hw);
+
+void sxevf_mbx_api_version_init(struct sxevf_adapter *adapter);
+
+bool sxevf_pf_rst_check(struct sxevf_hw *hw);
+
+s32 sxevf_mbx_msg_rcv(struct sxevf_hw *hw, u32 *msg, u16 msg_len);
+
+s32 sxevf_send_and_rcv_msg(struct sxevf_hw *hw, u32 *msg, u8 msg_len);
+
+s32 sxevf_mac_addr_set(struct sxevf_hw *hw, u8 *uc_addr);
+
+s32 sxevf_ring_info_get(struct sxevf_adapter *adapter,
+			u8 *tc_num, u8 *default_tc);
+
+s32 sxevf_rss_hash_config_get(struct sxevf_adapter *adapter,
+			struct rte_eth_rss_conf *rss_conf);
+
+void sxevf_mbx_api_version_init(struct sxevf_adapter *adapter);
+
+s32 sxevf_ctrl_msg_rcv(struct sxevf_hw *hw, u32 *msg, u16 msg_len);
+
+s32 sxevf_rx_max_frame_set(struct sxevf_hw *hw, u32 mtu);
+
+s32 sxevf_vlan_id_set(struct sxevf_hw *hw, u32 vlan,
+						 bool vlan_on);
+s32 sxevf_cast_mode_set(struct sxevf_hw *hw, enum sxevf_cast_mode mode);
+
+s32 sxevf_uc_addr_add(struct sxevf_hw *hw, u32 index, u8 *mac_addr);
+
+s32 sxevf_ctrl_msg_rcv_and_clear(struct sxevf_hw *hw, u32 *msg, u16 msg_len);
+
+#endif
diff --git a/drivers/net/sxe/vf/sxevf_offload.c b/drivers/net/sxe/vf/sxevf_offload.c
new file mode 100644
index 0000000000..b39245aa11
--- /dev/null
+++ b/drivers/net/sxe/vf/sxevf_offload.c
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+#include <ethdev_driver.h>
+
+#include "sxe_types.h"
+#include "sxe_offload_common.h"
+#include "sxevf_offload.h"
+
+u64 sxevf_rx_queue_offloads_get(struct rte_eth_dev *dev)
+{
+	return __sxe_rx_queue_offload_capa_get(dev);
+}
+
+u64 sxevf_rx_port_offloads_get(struct rte_eth_dev *dev)
+{
+	return __sxe_rx_port_offload_capa_get(dev);
+}
+
+u64 sxevf_tx_queue_offloads_get(struct rte_eth_dev *dev)
+{
+	RTE_SET_USED(dev);
+
+	return 0;
+}
+
+u64 sxevf_tx_port_offloads_get(struct rte_eth_dev *dev)
+{
+	return __sxe_tx_port_offload_capa_get(dev);
+}
diff --git a/drivers/net/sxe/vf/sxevf_offload.h b/drivers/net/sxe/vf/sxevf_offload.h
new file mode 100644
index 0000000000..ae4bf87f30
--- /dev/null
+++ b/drivers/net/sxe/vf/sxevf_offload.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+
+#ifndef __SXEVF_OFFLOAD_H__
+#define __SXEVF_OFFLOAD_H__
+
+u64 sxevf_rx_queue_offloads_get(struct rte_eth_dev *dev);
+
+u64 sxevf_rx_port_offloads_get(struct rte_eth_dev *dev);
+
+u64 sxevf_tx_queue_offloads_get(struct rte_eth_dev *dev);
+
+u64 sxevf_tx_port_offloads_get(struct rte_eth_dev *dev);
+
+#endif
diff --git a/drivers/net/sxe/vf/sxevf_queue.c b/drivers/net/sxe/vf/sxevf_queue.c
new file mode 100644
index 0000000000..69ef1f6676
--- /dev/null
+++ b/drivers/net/sxe/vf/sxevf_queue.c
@@ -0,0 +1,208 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+
+#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SRIOV
+
+#include <rte_byteorder.h>
+#include <rte_mbuf_core.h>
+#include <rte_ethdev.h>
+#include "sxevf_rx.h"
+#include "sxevf_tx.h"
+#include "sxe_logs.h"
+#include "sxevf.h"
+#include "sxe_queue_common.h"
+#include "sxevf_hw.h"
+#include "sxe_offload.h"
+#include "sxe_ethdev.h"
+#include "sxevf_queue.h"
+#include "sxevf_msg.h"
+
+s32 __rte_cold sxevf_rx_queue_mbufs_alloc(sxevf_rx_queue_s *rxq)
+{
+	s32 ret;
+
+	ret = __sxe_rx_queue_mbufs_alloc((sxevf_rx_queue_s *)rxq);
+
+	return ret;
+}
+
+s32 __rte_cold sxevf_rx_queue_setup(struct rte_eth_dev *dev,
+			 u16 queue_idx, u16 desc_num,
+			 unsigned int socket_id,
+			 const struct rte_eth_rxconf *rx_conf,
+			 struct rte_mempool *mp)
+{
+	struct sxevf_adapter *adapter = dev->data->dev_private;
+	struct sxevf_hw	 *hw = &adapter->hw;
+	struct rx_setup rx_setup = {};
+	s32 ret;
+
+	PMD_INIT_FUNC_TRACE();
+
+	rx_setup.desc_num = desc_num;
+	rx_setup.queue_idx = queue_idx;
+	rx_setup.socket_id = socket_id;
+	rx_setup.mp = mp;
+	rx_setup.dev = dev;
+	rx_setup.reg_base_addr = hw->reg_base_addr;
+	rx_setup.rx_conf = rx_conf;
+	rx_setup.rx_batch_alloc_allowed = &adapter->rx_batch_alloc_allowed;
+
+	ret = __sxe_rx_queue_setup(&rx_setup, true);
+	if (ret)
+		LOG_ERROR_BDF("rx queue setup fail.(err:%d)", ret);
+
+	return ret;
+}
+
+s32 __rte_cold sxevf_tx_queue_setup(struct rte_eth_dev *dev,
+				u16 tx_queue_id,
+				u16 ring_depth,
+				u32 socket_id,
+				const struct rte_eth_txconf *tx_conf)
+{
+	s32 ret;
+	struct sxevf_hw *hw = (&((struct sxevf_adapter *)(dev->data->dev_private))->hw);
+	struct tx_setup tx_setup;
+
+	tx_setup.dev = dev;
+	tx_setup.desc_num = ring_depth;
+	tx_setup.queue_idx = tx_queue_id;
+	tx_setup.socket_id = socket_id;
+	tx_setup.reg_base_addr = hw->reg_base_addr;
+	tx_setup.tx_conf = tx_conf;
+
+	ret = __sxe_tx_queue_setup(&tx_setup, true);
+	if (ret)
+		PMD_LOG_ERR(DRV, "rx queue setup fail.(err:%d)", ret);
+
+	return ret;
+}
+
+void __rte_cold
+sxevf_rx_queue_release(struct rte_eth_dev *dev, u16 queue_id)
+{
+	__sxe_rx_queue_free(dev->data->rx_queues[queue_id]);
+}
+
+void __rte_cold
+sxevf_tx_queue_release(struct rte_eth_dev *dev, u16 queue_id)
+{
+	__sxe_tx_queue_free(dev->data->tx_queues[queue_id]);
+}
+
+void sxevf_rx_queue_info_get(struct rte_eth_dev *dev, u16 queue_id,
+	struct rte_eth_rxq_info *qinfo)
+{
+	__sxe_rx_queue_info_get(dev, queue_id, qinfo);
+}
+
+void sxevf_tx_queue_info_get(struct rte_eth_dev *dev, u16 queue_id,
+		struct rte_eth_txq_info *q_info)
+{
+	__sxe_tx_queue_info_get(dev, queue_id, q_info);
+}
+
+s32 sxevf_tx_done_cleanup(void *tx_queue, u32 free_cnt)
+{
+	s32 ret;
+
+	/* Tx queue cleanup */
+	ret = __sxe_tx_done_cleanup(tx_queue, free_cnt);
+	if (ret)
+		PMD_LOG_ERR(DRV, "tx cleanup fail.(err:%d)", ret);
+
+	return ret;
+}
+
+s32 sxevf_rss_reta_update(struct rte_eth_dev *dev,
+			struct rte_eth_rss_reta_entry64 *reta_conf,
+			u16 reta_size)
+{
+	s32 ret = -ENOTSUP;
+
+	PMD_INIT_FUNC_TRACE();
+
+	RTE_SET_USED(reta_conf);
+	RTE_SET_USED(reta_size);
+
+	if (!dev->data->dev_started) {
+		PMD_LOG_ERR(DRV,
+			"port %d must be started before rss reta update",
+			 dev->data->port_id);
+		ret = -EIO;
+		goto l_out;
+	}
+
+	PMD_LOG_ERR(DRV, "rss reta update is not supported on vf.(err:%d)", ret);
+
+l_out:
+	return ret;
+}
+
+s32 sxevf_rss_reta_query(struct rte_eth_dev *dev,
+			 struct rte_eth_rss_reta_entry64 *reta_conf,
+			 u16 reta_size)
+{
+	s32 ret = 0;
+
+	RTE_SET_USED(dev);
+	RTE_SET_USED(reta_conf);
+
+	if (reta_size != 0) {
+		ret = -EINVAL;
+		PMD_LOG_ERR(DRV, "vf rss reta size:0, not support query.(err:%d)", ret);
+	}
+
+	return ret;
+}
+
+s32 sxevf_rss_hash_conf_get(struct rte_eth_dev *dev,
+				struct rte_eth_rss_conf *rss_conf)
+{
+	s32 ret = 0;
+	struct sxevf_adapter *adapter = dev->data->dev_private;
+
+	ret = sxevf_rss_hash_config_get(adapter, rss_conf);
+	if (ret) {
+		LOG_ERROR_BDF("rss hash config get failed.(err:%d)", ret);
+		goto l_out;
+	}
+
+l_out:
+	return ret;
+}
+
+s32 sxevf_rss_hash_update(struct rte_eth_dev *dev,
+			struct rte_eth_rss_conf *rss_conf)
+{
+	s32 ret = -ENOTSUP;
+
+	RTE_SET_USED(dev);
+	RTE_SET_USED(rss_conf);
+
+	PMD_LOG_ERR(DRV, "rss hash update is not supported on vf.(err:%d)", ret);
+
+	return ret;
+}
+
+void sxevf_secondary_proc_init(struct rte_eth_dev *eth_dev)
+{
+	struct sxevf_adapter *adapter = eth_dev->data->dev_private;
+	bool rx_vec_allowed = 0;
+
+	__sxe_secondary_proc_init(eth_dev, adapter->rx_batch_alloc_allowed, &rx_vec_allowed);
+}
+
+void __rte_cold sxevf_txrx_queues_clear(struct rte_eth_dev *dev, bool rx_batch_alloc_allowed)
+{
+	__sxe_txrx_queues_clear(dev, rx_batch_alloc_allowed);
+}
+
+void sxevf_queues_free(struct rte_eth_dev *dev)
+{
+	__sxe_queues_free(dev);
+}
+
+#endif
diff --git a/drivers/net/sxe/vf/sxevf_queue.h b/drivers/net/sxe/vf/sxevf_queue.h
new file mode 100644
index 0000000000..01e2ec216c
--- /dev/null
+++ b/drivers/net/sxe/vf/sxevf_queue.h
@@ -0,0 +1,69 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+
+#ifndef __SXEVF_QUEUEU_H__
+#define __SXEVF_QUEUEU_H__
+
+#include "sxe_types.h"
+#include "sxe_queue_common.h"
+
+typedef union sxe_tx_data_desc sxevf_tx_data_desc_u;
+typedef struct sxe_rx_buffer   sxevf_rx_buffer_s;
+typedef union sxe_rx_data_desc sxevf_rx_data_desc_u;
+typedef struct sxe_tx_queue	sxevf_tx_queue_s;
+typedef struct sxe_rx_queue	sxevf_rx_queue_s;
+
+s32 __rte_cold sxevf_rx_queue_mbufs_alloc(sxevf_rx_queue_s *rxq);
+
+s32 __rte_cold sxevf_rx_queue_setup(struct rte_eth_dev *dev,
+			 u16 queue_idx, u16 desc_num,
+			 unsigned int socket_id,
+			 const struct rte_eth_rxconf *rx_conf,
+			 struct rte_mempool *mp);
+
+s32 __rte_cold sxevf_tx_queue_setup(struct rte_eth_dev *dev,
+				u16 tx_queue_id,
+				u16 ring_depth,
+				u32 socket_id,
+				const struct rte_eth_txconf *tx_conf);
+void __rte_cold sxevf_tx_queue_release(struct rte_eth_dev *dev, u16 queue_id);
+
+void __rte_cold sxevf_rx_queue_release(struct rte_eth_dev *dev, u16 queue_id);
+
+void sxevf_rx_queue_info_get(struct rte_eth_dev *dev, u16 queue_id,
+	struct rte_eth_rxq_info *qinfo);
+
+void sxevf_tx_queue_info_get(struct rte_eth_dev *dev, u16 queue_id,
+		struct rte_eth_txq_info *q_info);
+
+s32 sxevf_tx_done_cleanup(void *tx_queue, u32 free_cnt);
+
+s32 sxevf_rss_reta_update(struct rte_eth_dev *dev,
+			struct rte_eth_rss_reta_entry64 *reta_conf,
+			u16 reta_size);
+
+s32 sxevf_rss_reta_query(struct rte_eth_dev *dev,
+			 struct rte_eth_rss_reta_entry64 *reta_conf,
+			 u16 reta_size);
+
+s32 sxevf_rss_hash_conf_get(struct rte_eth_dev *dev,
+				struct rte_eth_rss_conf *rss_conf);
+
+s32 sxevf_rss_hash_update(struct rte_eth_dev *dev,
+			struct rte_eth_rss_conf *rss_conf);
+
+void sxevf_secondary_proc_init(struct rte_eth_dev *eth_dev);
+
+s32 sxevf_rx_descriptor_status(void *rx_queue, u16 offset);
+
+u16 sxevf_pkts_recv(void *rx_queue, struct rte_mbuf **rx_pkts, u16 num_pkts);
+
+u16 sxevf_pkts_xmit_with_offload(void *tx_queue, struct rte_mbuf **tx_pkts, u16 pkts_num);
+s32 sxevf_tx_descriptor_status(void *tx_queue, u16 offset);
+
+void __rte_cold sxevf_txrx_queues_clear(struct rte_eth_dev *dev, bool rx_batch_alloc_allowed);
+
+void sxevf_queues_free(struct rte_eth_dev *dev);
+
+#endif
diff --git a/drivers/net/sxe/vf/sxevf_rx.c b/drivers/net/sxe/vf/sxevf_rx.c
new file mode 100644
index 0000000000..81aab3f315
--- /dev/null
+++ b/drivers/net/sxe/vf/sxevf_rx.c
@@ -0,0 +1,162 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+
+#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SRIOV
+
+#include <rte_common.h>
+#include <ethdev_driver.h>
+
+#include "sxe_logs.h"
+#include "sxe_errno.h"
+#include "sxevf.h"
+#include "sxevf_msg.h"
+#include "sxevf_rx.h"
+#include "sxe_rx_common.h"
+#include "sxevf_queue.h"
+#include "sxevf_rx.h"
+#include "sxe_ethdev.h"
+
+#define SXEVF_RX_HDR_SIZE  256
+
+static void sxevf_rss_bit_num_configure(struct sxevf_hw *hw, u16 rx_queues_num)
+{
+	u32 psrtype;
+
+	psrtype = (rx_queues_num >> 1) << SXEVF_PSRTYPE_RQPL_SHIFT;
+
+	sxevf_rss_bit_num_set(hw, psrtype);
+}
+
+static void sxevf_rxmode_offload_configure(struct rte_eth_dev *eth_dev,
+						u64 queue_offload, u32 buf_size)
+{
+	struct rte_eth_rxmode *rxmode = &eth_dev->data->dev_conf.rxmode;
+	u32 frame_size = SXE_GET_FRAME_SIZE(eth_dev);
+
+	if (rxmode->offloads & RTE_ETH_RX_OFFLOAD_SCATTER ||
+		((frame_size + 2 * SXEVF_VLAN_TAG_SIZE) > buf_size)) {
+		if (!eth_dev->data->scattered_rx) {
+			PMD_LOG_WARN(DRV, "rxmode offload:0x%" SXE_PRIX64 " max_rx_pkt_len:%u "
+					"buf_size:%u enable rx scatter",
+					rxmode->offloads,
+					frame_size,
+					buf_size);
+		}
+		eth_dev->data->scattered_rx = 1;
+	}
+
+	if (queue_offload & RTE_ETH_RX_OFFLOAD_VLAN_STRIP)
+		rxmode->offloads |= RTE_ETH_RX_OFFLOAD_VLAN_STRIP;
+}
+
+static s32 sxevf_rx_queue_configure(struct rte_eth_dev *eth_dev)
+{
+	struct sxevf_adapter *adapter = eth_dev->data->dev_private;
+	struct sxevf_hw *hw = &adapter->hw;
+	sxevf_rx_queue_s *rxq;
+	struct rte_eth_rxmode *rxmode = &eth_dev->data->dev_conf.rxmode;
+	s32 ret;
+	u16 i;
+	u32 len;
+	u32 buf_size;
+
+	rxmode->offloads &= ~RTE_ETH_RX_OFFLOAD_VLAN_STRIP;
+	for (i = 0; i < eth_dev->data->nb_rx_queues; i++) {
+		rxq = eth_dev->data->rx_queues[i];
+		len = rxq->ring_depth * sizeof(sxevf_rx_data_desc_u);
+
+		ret = sxevf_rx_queue_mbufs_alloc(rxq);
+		if (ret) {
+			LOG_ERROR_BDF("rx queue num:%u queue id:%u alloc "
+					  "rx buffer fail.(err:%d)",
+					  eth_dev->data->nb_rx_queues, i, ret);
+			goto l_out;
+		}
+
+		buf_size = (u16)(rte_pktmbuf_data_room_size(rxq->mb_pool) -
+			RTE_PKTMBUF_HEADROOM);
+
+		sxevf_rx_ring_desc_configure(hw, len, rxq->base_addr, rxq->reg_idx);
+
+		sxevf_rx_rcv_ctl_configure(hw, rxq->reg_idx, SXEVF_RX_HDR_SIZE,
+					   buf_size, rxq->drop_en);
+
+		sxevf_rxmode_offload_configure(eth_dev, rxq->offloads, buf_size);
+	}
+
+	sxevf_rss_bit_num_configure(hw, eth_dev->data->nb_rx_queues);
+
+	sxevf_rx_function_set(eth_dev);
+
+l_out:
+	return ret;
+}
+
+s32 sxevf_rx_configure(struct rte_eth_dev *eth_dev)
+{
+	struct sxevf_adapter *adapter = eth_dev->data->dev_private;
+	struct sxevf_hw *hw = &adapter->hw;
+	u32 frame_size = SXE_GET_FRAME_SIZE(eth_dev);
+	u32 mtu = frame_size - SXE_ETH_OVERHEAD;
+	s32 ret;
+
+	if (rte_is_power_of_2(eth_dev->data->nb_rx_queues) == 0) {
+		ret = -SXEVF_ERR_PARAM;
+		LOG_ERROR_BDF("invalid rx queue num:%u.",
+			 eth_dev->data->nb_rx_queues);
+		goto l_out;
+	}
+
+	if (eth_dev->data->nb_rx_queues > adapter->max_rx_queue) {
+		ret = -SXEVF_ERR_PARAM;
+		LOG_ERROR_BDF("invalid rx queue num:%u exceed max rx queue:%u ",
+			eth_dev->data->nb_rx_queues,
+			adapter->max_rx_queue);
+		goto l_out;
+	}
+
+	ret = sxevf_rx_max_frame_set(hw, mtu);
+	if (ret) {
+		LOG_ERROR_BDF("max frame size:%u set fail.(err:%d)",
+				  frame_size, ret);
+		goto l_out;
+	}
+
+	ret = sxevf_rx_queue_configure(eth_dev);
+	if (ret) {
+		LOG_ERROR_BDF("rx queue num:%u configure fail.(err:%u)",
+				  eth_dev->data->nb_rx_queues, ret);
+	}
+
+l_out:
+	return ret;
+}
+
+void __rte_cold sxevf_rx_function_set(struct rte_eth_dev *dev)
+{
+	struct sxevf_adapter *adapter = dev->data->dev_private;
+
+#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SIMD
+	__sxe_rx_function_set(dev, adapter->rx_batch_alloc_allowed, &adapter->rx_vec_allowed);
+#else
+	__sxe_rx_function_set(dev, adapter->rx_batch_alloc_allowed, NULL);
+#endif
+}
+
+s32 sxevf_rx_descriptor_status(void *rx_queue, u16 offset)
+{
+	return __sxe_rx_descriptor_status(rx_queue, offset);
+}
+
+u16 sxevf_pkts_recv(void *rx_queue, struct rte_mbuf **rx_pkts, u16 num_pkts)
+{
+	return __sxe_pkts_recv(rx_queue, rx_pkts, num_pkts);
+}
+
+const u32 *sxevf_dev_supported_ptypes_get(struct rte_eth_dev *dev, size_t *no_of_elements)
+{
+	return __sxe_dev_supported_ptypes_get(dev, no_of_elements);
+}
+
+#endif
diff --git a/drivers/net/sxe/vf/sxevf_rx.h b/drivers/net/sxe/vf/sxevf_rx.h
new file mode 100644
index 0000000000..55ca2705c1
--- /dev/null
+++ b/drivers/net/sxe/vf/sxevf_rx.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+
+#ifndef __SXEVF_RX_H__
+#define __SXEVF_RX_H__
+
+#include "sxe_queue_common.h"
+
+#define SXEVF_RX_DESC_RING_ALIGN	(SXE_ALIGN / sizeof(sxevf_rx_data_desc_t))
+
+s32 sxevf_rx_configure(struct rte_eth_dev *eth_dev);
+
+const u32 *sxevf_dev_supported_ptypes_get(struct rte_eth_dev *dev, size_t *no_of_elements);
+
+void __rte_cold sxevf_rx_function_set(struct rte_eth_dev *dev);
+
+#endif
diff --git a/drivers/net/sxe/vf/sxevf_stats.c b/drivers/net/sxe/vf/sxevf_stats.c
new file mode 100644
index 0000000000..5cf8603807
--- /dev/null
+++ b/drivers/net/sxe/vf/sxevf_stats.c
@@ -0,0 +1,162 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+
+#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SRIOV
+
+#include <rte_ethdev.h>
+#include <ethdev_driver.h>
+#include "sxevf_stats.h"
+#include "sxe_logs.h"
+#include "sxe_errno.h"
+#include "sxevf.h"
+
+#define SXE_HW_XSTATS_CNT (sizeof(sxevf_xstats_field) / \
+			  sizeof(sxevf_xstats_field[0]))
+
+static const struct sxevf_stats_field sxevf_xstats_field[] = {
+	{"rx_multicast_packets", offsetof(struct sxevf_hw_stats, vfmprc)},
+};
+
+#ifdef SXE_TEST
+static u32 sxevf_xstats_cnt_get(void)
+{
+	return SXE_HW_XSTATS_CNT;
+}
+#endif
+
+int sxevf_eth_stats_get(struct rte_eth_dev *eth_dev, struct rte_eth_stats *stats,
+			struct eth_queue_stats *qstats __rte_unused)
+{
+	struct sxevf_adapter *adapter = eth_dev->data->dev_private;
+	struct sxevf_stats_info *stats_info = &adapter->stats_info;
+	struct sxevf_hw *hw = &adapter->hw;
+	s32 ret = 0;
+
+	sxevf_packet_stats_get(hw, &stats_info->hw_stats);
+
+	if (stats == NULL) {
+		ret = -EINVAL;
+		PMD_LOG_ERR(DRV, "input param stats is null.");
+		goto l_out;
+	}
+
+	stats->ipackets = stats_info->hw_stats.vfgprc;
+	stats->ibytes   = stats_info->hw_stats.vfgorc;
+	stats->opackets = stats_info->hw_stats.vfgptc;
+	stats->obytes   = stats_info->hw_stats.vfgotc - stats->opackets * RTE_ETHER_CRC_LEN;
+
+l_out:
+	return ret;
+}
+
+s32 sxevf_dev_stats_reset(struct rte_eth_dev *eth_dev)
+{
+	struct sxevf_adapter *adapter = eth_dev->data->dev_private;
+	struct sxevf_stats_info *stats_info = &adapter->stats_info;
+
+	sxevf_eth_stats_get(eth_dev, NULL, NULL);
+
+	stats_info->hw_stats.vfgprc = 0;
+	stats_info->hw_stats.vfgorc = 0;
+	stats_info->hw_stats.vfgptc = 0;
+	stats_info->hw_stats.vfgotc = 0;
+	stats_info->hw_stats.vfmprc = 0;
+
+	return 0;
+}
+
+static s32 sxevf_hw_xstat_offset_get(u32 id, u32 *offset)
+{
+	s32 ret = 0;
+	u32 size = SXE_HW_XSTATS_CNT;
+
+	if (id < size) {
+		*offset = sxevf_xstats_field[id].offset;
+	} else {
+		ret = -SXE_ERR_PARAM;
+		PMD_LOG_ERR(DRV, "invalid id:%u exceed stats size cnt:%u.",
+				id, size);
+	}
+
+	return ret;
+}
+
+s32 sxevf_xstats_get(struct rte_eth_dev *eth_dev,
+				struct rte_eth_xstat *xstats,
+				u32 usr_cnt)
+{
+	struct sxevf_adapter *adapter = eth_dev->data->dev_private;
+	struct sxevf_stats_info *stats_info = &adapter->stats_info;
+	struct sxevf_hw *hw = &adapter->hw;
+	u32 i;
+	u32 cnt;
+	s32 ret;
+	u32 offset;
+
+	cnt = SXE_HW_XSTATS_CNT;
+	PMD_LOG_INFO(DRV, "xstat size:%u. hw xstat field cnt:%" SXE_PRIU64,
+			cnt,
+			(u64)SXE_HW_XSTATS_CNT);
+
+	if (usr_cnt < cnt) {
+		ret = cnt;
+		PMD_LOG_ERR(DRV, "user usr_cnt:%u less than stats cnt:%u.",
+				usr_cnt, cnt);
+		goto l_out;
+	}
+
+	sxevf_packet_stats_get(hw, &stats_info->hw_stats);
+
+	if (xstats == NULL) {
+		ret = 0;
+		PMD_LOG_ERR(DRV, "usr_cnt:%u, input param xstats is null.",
+					usr_cnt);
+		goto l_out;
+	}
+
+	cnt = 0;
+	for (i = 0; i < SXE_HW_XSTATS_CNT; i++) {
+		sxevf_hw_xstat_offset_get(i, &offset);
+		xstats[cnt].value = *(u_long *)(((s8 *)(&stats_info->hw_stats)) + offset);
+		xstats[cnt].id = cnt;
+		cnt++;
+	}
+
+	ret = SXE_HW_XSTATS_CNT;
+
+l_out:
+	return ret;
+}
+
+s32 sxevf_xstats_names_get(__rte_unused struct rte_eth_dev *dev,
+	struct rte_eth_xstat_name *xstats_names, __rte_unused unsigned int usr_cnt)
+{
+	u32 i = 0;
+	u32 cnt = 0;
+	s32 ret;
+
+	if (xstats_names == NULL) {
+		ret = SXE_HW_XSTATS_CNT;
+		PMD_LOG_INFO(DRV, "xstats field size:%u.", ret);
+		goto l_out;
+	} else if (usr_cnt < SXE_HW_XSTATS_CNT) {
+		ret = -ENOMEM;
+		PMD_LOG_ERR(DRV, "usr_cnt:%u invalid.(err:%d).", usr_cnt, ret);
+		goto l_out;
+	}
+
+	for (i = 0; i < SXE_HW_XSTATS_CNT; i++) {
+		strlcpy(xstats_names[cnt].name,
+			sxevf_xstats_field[i].name,
+			sizeof(xstats_names[cnt].name));
+		cnt++;
+	}
+
+	ret = cnt;
+
+l_out:
+	return ret;
+}
+
+#endif
diff --git a/drivers/net/sxe/vf/sxevf_stats.h b/drivers/net/sxe/vf/sxevf_stats.h
new file mode 100644
index 0000000000..cba450953f
--- /dev/null
+++ b/drivers/net/sxe/vf/sxevf_stats.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+
+#ifndef __SXEVF_STATS_H__
+#define __SXEVF_STATS_H__
+
+#include "sxevf_hw.h"
+
+struct sxevf_stats_field {
+	s8  name[RTE_ETH_XSTATS_NAME_SIZE];
+	u32 offset;
+};
+
+struct sxevf_stats_info {
+	struct sxevf_hw_stats hw_stats;
+};
+
+int sxevf_eth_stats_get(struct rte_eth_dev *eth_dev, struct rte_eth_stats *stats,
+			struct eth_queue_stats *qstats __rte_unused);
+
+s32 sxevf_dev_stats_reset(struct rte_eth_dev *eth_dev);
+
+s32 sxevf_xstats_get(struct rte_eth_dev *eth_dev,
+				struct rte_eth_xstat *xstats,
+				u32 usr_cnt);
+
+s32 sxevf_xstats_names_get(__rte_unused struct rte_eth_dev *dev,
+	struct rte_eth_xstat_name *xstats_names, __rte_unused unsigned int usr_cnt);
+
+#endif
diff --git a/drivers/net/sxe/vf/sxevf_tx.c b/drivers/net/sxe/vf/sxevf_tx.c
new file mode 100644
index 0000000000..099f737e9a
--- /dev/null
+++ b/drivers/net/sxe/vf/sxevf_tx.c
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+
+#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SRIOV
+
+#include <rte_ethdev.h>
+
+#include "sxe_logs.h"
+#include "sxevf.h"
+#include "sxevf_tx.h"
+#include "sxevf_queue.h"
+#include "sxe_tx_common.h"
+
+void sxevf_tx_configure(struct rte_eth_dev *eth_dev)
+{
+	struct sxevf_adapter *adapter = eth_dev->data->dev_private;
+	struct sxevf_hw *hw = &adapter->hw;
+	sxevf_tx_queue_s *txq;
+	u16 i;
+	u32 len;
+
+	for (i = 0; i < eth_dev->data->nb_tx_queues; i++) {
+		txq = eth_dev->data->tx_queues[i];
+		len = txq->ring_depth * sizeof(sxevf_tx_data_desc_u);
+		sxevf_tx_desc_configure(hw, len, txq->base_addr, txq->reg_idx);
+
+		sxevf_tx_queue_thresh_set(hw, txq->reg_idx,
+			txq->pthresh, txq->hthresh, txq->wthresh);
+	}
+
+	LOG_DEBUG_BDF("tx queue num:%u tx configure done.",
+			eth_dev->data->nb_tx_queues);
+}
+
+s32 sxevf_tx_descriptor_status(void *tx_queue, u16 offset)
+{
+	return __sxe_tx_descriptor_status(tx_queue, offset);
+}
+
+u16 sxevf_pkts_xmit_with_offload(void *tx_queue, struct rte_mbuf **tx_pkts, u16 pkts_num)
+{
+	return __sxe_pkts_xmit_with_offload(tx_queue, tx_pkts, pkts_num);
+}
+
+#endif
diff --git a/drivers/net/sxe/vf/sxevf_tx.h b/drivers/net/sxe/vf/sxevf_tx.h
new file mode 100644
index 0000000000..c8ad400bca
--- /dev/null
+++ b/drivers/net/sxe/vf/sxevf_tx.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+
+#ifndef __SXEVF_TX_H__
+#define __SXEVF_TX_H__
+
+#include "sxe_queue_common.h"
+
+#define SXEVF_TX_DESC_RING_ALIGN	(SXE_ALIGN / sizeof(sxevf_tx_data_desc_u))
+
+void sxevf_tx_configure(struct rte_eth_dev *eth_dev);
+
+#endif
-- 
2.18.2

