Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F634E7AD42
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Dec 2025 09:24:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C709F40B9A;
	Thu, 25 Dec 2025 10:22:48 +0100 (CET)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by mails.dpdk.org (Postfix) with ESMTP id 6CBC740647
 for <dev@dpdk.org>; Thu, 25 Dec 2025 10:22:37 +0100 (CET)
Received: from mail.cstnet.cn (unknown [221.238.36.162])
 by APP-01 (Coremail) with SMTP id qwCowABXAW1WAk1p0VvIAQ--.29619S3;
 Thu, 25 Dec 2025 17:22:32 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v14 02/13] net/sxe: add ethdev probe and remove MIME-Version:
 1.0 Content-Type: text/plain; charset=UTF-8 Content-Transfer-Encoding: 8bit
Date: Thu, 25 Dec 2025 17:22:13 +0800
Message-Id: <20251225092224.227202-2-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20251225092224.227202-1-liujie5@linkdatatechnology.com>
References: <20251225081201.177111-13-liujie5@linkdatatechnology.com>
 <20251225092224.227202-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowABXAW1WAk1p0VvIAQ--.29619S3
X-Coremail-Antispam: 1UD129KBjvAXoWkJr4kur4fuw4kuFWUuw1UGFg_yoWDWFyxto
 WfJF15G3WrZry2kr4UGw4xGFyIyrsFkFW5twsYyrWkuas8Z3y8Kr17Ka13Arn8Wr15Kryk
 AasruF9xJr42gas5n29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UjIYCTnIWjp_UUUYl7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20EY4v20xva
 j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r18M28IrcIa0x
 kI8VCY1x0267AKxVWUXVWUCwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84AC
 jcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j6r4UM2
 8EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
 M2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4
 xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCa
 FVCjc4AY6r1j6r4UM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUtVW8Zw
 CY02Avz4vE14v_GFWl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWU
 GwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIF0xvE2Ix0cI
 8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAv
 wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14
 v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU0fHUDUUUU
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

Add basic modules: logs、 hardware communication、common components
and support basic PCIe ethdev probe and remove.

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe/base/sxe_common.c          |   66 +
 drivers/net/sxe/base/sxe_common.h          |   15 +
 drivers/net/sxe/base/sxe_compat_platform.h |  126 +
 drivers/net/sxe/base/sxe_compat_version.h  |   34 +
 drivers/net/sxe/base/sxe_errno.h           |   61 +
 drivers/net/sxe/base/sxe_hw.c              | 6259 ++++++++++++++++++++
 drivers/net/sxe/base/sxe_hw.h              | 1537 +++++
 drivers/net/sxe/base/sxe_logs.h            |  105 +
 drivers/net/sxe/base/sxe_types.h           |   40 +
 drivers/net/sxe/include/drv_msg.h          |   18 +
 drivers/net/sxe/include/sxe/sxe_hdc.h      |   42 +
 drivers/net/sxe/include/sxe/sxe_msg.h      |  135 +
 drivers/net/sxe/include/sxe/sxe_regs.h     | 1270 ++++
 drivers/net/sxe/include/sxe_version.h      |   29 +
 drivers/net/sxe/meson.build                |   20 +-
 drivers/net/sxe/pf/sxe.h                   |   56 +
 drivers/net/sxe/pf/sxe_ethdev.c            |  321 +-
 drivers/net/sxe/pf/sxe_ethdev.h            |   27 +-
 drivers/net/sxe/pf/sxe_irq.c               |  125 +
 drivers/net/sxe/pf/sxe_irq.h               |   39 +
 drivers/net/sxe/pf/sxe_main.c              |  181 +
 drivers/net/sxe/pf/sxe_phy.h               |   38 +
 drivers/net/sxe/pf/sxe_pmd_hdc.c           |  682 +++
 drivers/net/sxe/pf/sxe_pmd_hdc.h           |   44 +
 drivers/net/sxe/sxe_drv_type.h             |   15 +
 25 files changed, 11282 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/sxe/base/sxe_common.c
 create mode 100644 drivers/net/sxe/base/sxe_common.h
 create mode 100644 drivers/net/sxe/base/sxe_compat_platform.h
 create mode 100644 drivers/net/sxe/base/sxe_compat_version.h
 create mode 100644 drivers/net/sxe/base/sxe_errno.h
 create mode 100644 drivers/net/sxe/base/sxe_hw.c
 create mode 100644 drivers/net/sxe/base/sxe_hw.h
 create mode 100644 drivers/net/sxe/base/sxe_logs.h
 create mode 100644 drivers/net/sxe/base/sxe_types.h
 create mode 100644 drivers/net/sxe/include/drv_msg.h
 create mode 100644 drivers/net/sxe/include/sxe/sxe_hdc.h
 create mode 100644 drivers/net/sxe/include/sxe/sxe_msg.h
 create mode 100644 drivers/net/sxe/include/sxe/sxe_regs.h
 create mode 100644 drivers/net/sxe/include/sxe_version.h
 create mode 100644 drivers/net/sxe/pf/sxe.h
 create mode 100644 drivers/net/sxe/pf/sxe_irq.c
 create mode 100644 drivers/net/sxe/pf/sxe_irq.h
 create mode 100644 drivers/net/sxe/pf/sxe_main.c
 create mode 100644 drivers/net/sxe/pf/sxe_phy.h
 create mode 100644 drivers/net/sxe/pf/sxe_pmd_hdc.c
 create mode 100644 drivers/net/sxe/pf/sxe_pmd_hdc.h
 create mode 100644 drivers/net/sxe/sxe_drv_type.h

diff --git a/drivers/net/sxe/base/sxe_common.c b/drivers/net/sxe/base/sxe_common.c
new file mode 100644
index 0000000000..8b3fb13e73
--- /dev/null
+++ b/drivers/net/sxe/base/sxe_common.c
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+
+#include <pthread.h>
+#include <sys/time.h>
+#include <sys/types.h>
+#include <unistd.h>
+#include <rte_common.h>
+#include <rte_cycles.h>
+#include <time.h>
+#include "sxe_types.h"
+#include "sxe_common.h"
+
+#define SXE_TRACE_ID_COUNT_MASK  0x00000000000000FFLLU
+#define SXE_TRACE_ID_TID_MASK	0x0000000000FFFF00LLU
+#define SXE_TRACE_ID_TIME_MASK   0x00FFFFFFFF000000LLU
+#define SXE_TRACE_ID_FLAG		0xFF00000000000000LLU
+
+#define SXE_TRACE_ID_COUNT_SHIFT 0
+#define SXE_TRACE_ID_TID_SHIFT   8
+#define SXE_TRACE_ID_TIME_SHIFT  24
+
+#define SXE_SEC_TO_MS(sec) ((sec) * 1000ULL)
+#define SXE_SEC_TO_NS(sec) ((sec) * 1000000000ULL)
+
+#define SXE_USEC_PER_MS		  1000000
+
+u64 sxe_trace_id;
+
+u64 sxe_time_get_real_ms(void)
+{
+	u64 ms = 0;
+	struct timespec ts;
+	s32 ret = clock_gettime(CLOCK_MONOTONIC, &ts);
+	if (ret < 0)
+		goto l_end;
+
+	ms = SXE_SEC_TO_MS(ts.tv_sec) + ts.tv_nsec / SXE_USEC_PER_MS;
+
+l_end:
+	return ms;
+}
+
+u64 sxe_trace_id_gen(void)
+{
+	u64 tid	   = getpid() + (pthread_self() << 20);
+	u64 index	 = 0;
+	u64 timestamp = sxe_time_get_real_ms();
+
+	sxe_trace_id = (SXE_TRACE_ID_FLAG)
+		| ((timestamp << SXE_TRACE_ID_TIME_SHIFT) & SXE_TRACE_ID_TIME_MASK)
+		| ((tid << SXE_TRACE_ID_TID_SHIFT) & SXE_TRACE_ID_TID_MASK)
+		| ((index << SXE_TRACE_ID_COUNT_SHIFT) & SXE_TRACE_ID_COUNT_MASK);
+	return sxe_trace_id;
+}
+
+void sxe_trace_id_clean(void)
+{
+	sxe_trace_id = 0;
+}
+
+u64 sxe_trace_id_get(void)
+{
+	return sxe_trace_id++;
+}
diff --git a/drivers/net/sxe/base/sxe_common.h b/drivers/net/sxe/base/sxe_common.h
new file mode 100644
index 0000000000..43c062b937
--- /dev/null
+++ b/drivers/net/sxe/base/sxe_common.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+#ifndef __SXE_DPDK_COMMON_H__
+#define __SXE_DPDK_COMMON_H__
+
+u64 sxe_trace_id_gen(void);
+
+void sxe_trace_id_clean(void);
+
+u64 sxe_trace_id_get(void);
+
+u64 sxe_time_get_real_ms(void);
+
+#endif
diff --git a/drivers/net/sxe/base/sxe_compat_platform.h b/drivers/net/sxe/base/sxe_compat_platform.h
new file mode 100644
index 0000000000..80d7d3f288
--- /dev/null
+++ b/drivers/net/sxe/base/sxe_compat_platform.h
@@ -0,0 +1,126 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+
+#ifndef __SXE_COMPAT_PLATFORM_H__
+#define __SXE_COMPAT_PLATFORM_H__
+
+#include <rte_cycles.h>
+#include <rte_branch_prediction.h>
+#include <rte_byteorder.h>
+#include <rte_io.h>
+#include <rte_common.h>
+
+#include "sxe_types.h"
+
+#define  false 0
+#define  true  1
+
+#define STATIC static
+
+#ifndef DIV_ROUND_UP
+#define DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
+#endif
+
+#define __iomem
+#define __force
+
+#define min(a, b)	RTE_MIN(a, b)
+
+#ifndef fallthrough
+# define fallthrough do {} while (0)
+#endif
+
+#define cpu_to_be16(o) rte_cpu_to_be_16(o)
+#define cpu_to_be32(o) rte_cpu_to_be_32(o)
+#define cpu_to_be64(o) rte_cpu_to_be_64(o)
+#define cpu_to_le32(o) rte_cpu_to_le_32(o)
+#define be16_to_cpu(o) rte_be_to_cpu_16(o)
+#define be32_to_cpu(o) rte_be_to_cpu_32(o)
+#define be64_to_cpu(o) rte_be_to_cpu_64(o)
+#define le32_to_cpu(o) rte_le_to_cpu_32(o)
+
+#ifndef ntohs
+#define ntohs(o) be16_to_cpu(o)
+#endif
+
+#ifndef ntohl
+#define ntohl(o) be32_to_cpu(o)
+#endif
+
+#ifndef htons
+#define htons(o) cpu_to_be16(o)
+#endif
+
+#ifndef htonl
+#define htonl(o) cpu_to_be32(o)
+#endif
+#define mdelay rte_delay_ms
+#define sxe_udelay rte_delay_us
+#define usleep_range(min, max) rte_delay_us(min)
+#define msleep(x)			 rte_delay_us((x) * 1000)
+
+#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
+#define BIT(x)	(1UL << (x))
+#define DMA_BIT_MASK(n)	(((n) == 64) ? ~0ULL : ((1ULL << (n)) - 1))
+
+#define NSEC_PER_SEC	1000000000L
+
+#define ETH_P_1588	0x88F7
+
+#define VLAN_PRIO_SHIFT		13
+
+static inline void
+set_bit(unsigned long nr, void *addr)
+{
+	int *m = ((int *)addr) + (nr >> 5);
+	*m |= 1 << (nr & 31);
+}
+
+static inline int
+test_bit(int nr, const void *addr)
+{
+	return (1UL & (((const int *)addr)[nr >> 5] >> (nr & 31))) != 0UL;
+}
+
+static inline void
+clear_bit(unsigned long nr, void *addr)
+{
+	int *m = ((int *)addr) + (nr >> 5);
+	*m &= ~(1 << (nr & 31));
+}
+
+static inline int
+test_and_clear_bit(unsigned long nr, void *addr)
+{
+	unsigned long mask = 1 << (nr & 0x1f);
+	int *m = ((int *)addr) + (nr >> 5);
+	int old = *m;
+
+	*m = old & ~mask;
+	return (old & mask) != 0;
+}
+
+static __rte_always_inline uint64_t
+readq(volatile void *addr)
+{
+	return rte_le_to_cpu_64(rte_read64(addr));
+}
+
+static __rte_always_inline void
+writeq(uint64_t value, volatile void *addr)
+{
+	rte_write64(rte_cpu_to_le_64(value), addr);
+}
+
+static inline u32 sxe_read_addr(const volatile void *addr)
+{
+	return rte_le_to_cpu_32(rte_read32(addr));
+}
+
+static inline void  sxe_write_addr(u32 value, volatile void *addr)
+{
+	rte_write32((rte_cpu_to_le_32(value)), addr);
+}
+
+#endif
diff --git a/drivers/net/sxe/base/sxe_compat_version.h b/drivers/net/sxe/base/sxe_compat_version.h
new file mode 100644
index 0000000000..7eb9f37da6
--- /dev/null
+++ b/drivers/net/sxe/base/sxe_compat_version.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+
+#ifndef __SXE_COMPAT_VERSION_H__
+#define __SXE_COMPAT_VERSION_H__
+
+#include <stdbool.h>
+
+struct rte_eth_dev;
+enum rte_eth_event_type;
+
+int sxe_eth_dev_callback_process(struct rte_eth_dev *dev,
+	enum rte_eth_event_type event, void *ret_param);
+
+#define PCI_REG_WC_WRITE
+
+#ifndef PCI_REG_WC_WRITE
+#define rte_write32_wc rte_write32
+#define rte_write32_wc_relaxed rte_write32_relaxed
+#endif
+
+#define SXE_PCI_INTR_HANDLE(pci_dev) \
+	((pci_dev)->intr_handle)
+#define SXE_DEV_FNAV_CONF(dev) \
+	(&((struct sxe_adapter *)(dev)->data->dev_private)->fnav_conf)
+#define RTE_ADAPTER_HAVE_FNAV_CONF
+#define SXE_GET_FRAME_SIZE(dev) \
+	((dev)->data->mtu + SXE_ETH_OVERHEAD)
+
+#define DEV_RX_OFFLOAD_CHECKSUM RTE_ETH_RX_OFFLOAD_CHECKSUM
+#define ETH_DCB_NUM_USER_PRIORITIES RTE_ETH_DCB_NUM_USER_PRIORITIES
+
+#endif
diff --git a/drivers/net/sxe/base/sxe_errno.h b/drivers/net/sxe/base/sxe_errno.h
new file mode 100644
index 0000000000..85f70ed176
--- /dev/null
+++ b/drivers/net/sxe/base/sxe_errno.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+
+#ifndef __SXE_ERRNO_H__
+#define __SXE_ERRNO_H__
+
+#define SXE_ERR_MODULE_STANDARD			0
+#define SXE_ERR_MODULE_PF				1
+#define SXE_ERR_MODULE_VF				2
+#define SXE_ERR_MODULE_HDC				3
+
+#define SXE_ERR_MODULE_OFFSET	16
+#define SXE_ERR_MODULE(module, errcode)		\
+	(((module) << SXE_ERR_MODULE_OFFSET) | (errcode))
+#define SXE_ERR_PF(errcode)		SXE_ERR_MODULE(SXE_ERR_MODULE_PF, errcode)
+#define SXE_ERR_VF(errcode)		SXE_ERR_MODULE(SXE_ERR_MODULE_VF, errcode)
+#define SXE_ERR_HDC(errcode)	SXE_ERR_MODULE(SXE_ERR_MODULE_HDC, errcode)
+
+#define SXE_ERR_CONFIG						EINVAL
+#define SXE_ERR_PARAM						 EINVAL
+#define SXE_ERR_RESET_FAILED				  EPERM
+#define SXE_ERR_NO_SPACE					  ENOSPC
+#define SXE_ERR_FNAV_CMD_INCOMPLETE		   EBUSY
+#define SXE_ERR_MBX_LOCK_FAIL				 EBUSY
+#define SXE_ERR_OPRATION_NOT_PERM			 EPERM
+#define SXE_ERR_LINK_STATUS_INVALID		   EINVAL
+#define SXE_ERR_LINK_SPEED_INVALID			EINVAL
+#define SXE_ERR_DEVICE_NOT_SUPPORTED		  EOPNOTSUPP
+#define SXE_ERR_HDC_LOCK_BUSY				 EBUSY
+#define SXE_ERR_HDC_FW_OV_TIMEOUT			 ETIMEDOUT
+#define SXE_ERR_MDIO_CMD_TIMEOUT			  ETIMEDOUT
+#define SXE_ERR_INVALID_LINK_SETTINGS		 EINVAL
+#define SXE_ERR_FNAV_REINIT_FAILED			EIO
+#define SXE_ERR_CLI_FAILED					EIO
+#define SXE_ERR_MASTER_REQUESTS_PENDING	   SXE_ERR_PF(1)
+#define SXE_ERR_SFP_NO_INIT_SEQ_PRESENT	   SXE_ERR_PF(2)
+#define SXE_ERR_ENABLE_SRIOV_FAIL			 SXE_ERR_PF(3)
+#define SXE_ERR_IPSEC_SA_STATE_NOT_EXSIT	  SXE_ERR_PF(4)
+#define SXE_ERR_SFP_NOT_PERSENT			   SXE_ERR_PF(5)
+#define SXE_ERR_PHY_NOT_PERSENT			   SXE_ERR_PF(6)
+#define SXE_ERR_PHY_RESET_FAIL				SXE_ERR_PF(7)
+#define SXE_ERR_FC_NOT_NEGOTIATED			 SXE_ERR_PF(8)
+#define SXE_ERR_SFF_NOT_SUPPORTED			 SXE_ERR_PF(9)
+
+#define SXEVF_ERR_MAC_ADDR_INVALID			  EINVAL
+#define SXEVF_ERR_RESET_FAILED				  EIO
+#define SXEVF_ERR_ARGUMENT_INVALID			  EINVAL
+#define SXEVF_ERR_NOT_READY					 EBUSY
+#define SXEVF_ERR_POLL_ACK_FAIL				 EIO
+#define SXEVF_ERR_POLL_MSG_FAIL				 EIO
+#define SXEVF_ERR_MBX_LOCK_FAIL				 EBUSY
+#define SXEVF_ERR_REPLY_INVALID				 EINVAL
+#define SXEVF_ERR_IRQ_NUM_INVALID			   EINVAL
+#define SXEVF_ERR_PARAM						 EINVAL
+#define SXEVF_ERR_MAILBOX_FAIL				  SXE_ERR_VF(1)
+#define SXEVF_ERR_MSG_HANDLE_ERR				SXE_ERR_VF(2)
+#define SXEVF_ERR_DEVICE_NOT_SUPPORTED		  SXE_ERR_VF(3)
+#define SXEVF_ERR_IPSEC_SA_STATE_NOT_EXSIT	  SXE_ERR_VF(4)
+
+#endif
diff --git a/drivers/net/sxe/base/sxe_hw.c b/drivers/net/sxe/base/sxe_hw.c
new file mode 100644
index 0000000000..c1c3f828ae
--- /dev/null
+++ b/drivers/net/sxe/base/sxe_hw.c
@@ -0,0 +1,6259 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+#ifdef SXE_PHY_CONFIGURE
+#include <linux/mdio.h>
+#endif
+#include <rte_byteorder.h>
+#if defined(__KERNEL__) || defined(SXE_KERNEL_TEST)
+#include "sxe_pci.h"
+#include "sxe_log.h"
+#include "sxe_debug.h"
+#include "sxe_host_hdc.h"
+#include "sxe_sriov.h"
+#include "sxe_compat.h"
+#else
+#include "sxe_errno.h"
+#include "sxe_logs.h"
+#include "sxe.h"
+#include "sxe_hw.h"
+#endif
+
+
+#define SXE_PFMSG_MASK  (0xFF00)
+
+#define SXE_MSGID_MASK  (0xFFFFFFFF)
+
+#define SXE_CTRL_MSG_MASK		  (0x700)
+
+#define SXE_RING_WAIT_LOOP		10
+#define SXE_REG_NAME_LEN		  16
+#define SXE_DUMP_REG_STRING_LEN   73
+#define SXE_DUMP_REGS_NUM		 64
+#define SXE_MAX_RX_DESC_POLL	  10
+#define SXE_LPBK_EN			   0x00000001
+#define SXE_MACADDR_LOW_4_BYTE	4
+#define SXE_MACADDR_HIGH_2_BYTE   2
+#define SXE_RSS_FIELD_MASK		0xffff0000
+#define SXE_MRQE_MASK			 0x0000000f
+
+#define SXE_HDC_DATA_LEN_MAX		 256
+
+#define SXE_8_TC_MSB				(0x11111111)
+
+static u32 sxe_read_reg(struct sxe_hw *hw, u32 reg);
+static void sxe_write_reg(struct sxe_hw *hw, u32 reg, u32 value);
+static void sxe_write_reg64(struct sxe_hw *hw, u32 reg, u64 value);
+
+#define SXE_WRITE_REG_ARRAY_32(a, reg, offset, value) \
+	sxe_write_reg(a, (reg) + ((offset) << 2), value)
+#define SXE_READ_REG_ARRAY_32(a, reg, offset) \
+	sxe_read_reg(a, (reg) + ((offset) << 2))
+
+#define SXE_REG_READ(hw, addr)		sxe_read_reg(hw, addr)
+#define SXE_REG_WRITE(hw, reg, value) sxe_write_reg(hw, reg, value)
+#define SXE_WRITE_FLUSH(a) sxe_read_reg(a, SXE_STATUS)
+#define SXE_REG_WRITE_ARRAY(hw, reg, offset, value) \
+	sxe_write_reg(hw, (reg) + ((offset) << 2), (value))
+
+#define SXE_SWAP_32(_value) rte_bswap32((_value))
+
+#define SXE_REG_WRITE_BE32(a, reg, value) \
+	SXE_REG_WRITE((a), (reg), SXE_SWAP_32(ntohl(value)))
+
+#define SXE_SWAP_16(_value) rte_bswap16((_value))
+
+#define SXE_REG64_WRITE(a, reg, value) sxe_write_reg64((a), (reg), (value))
+
+enum sxe_ipsec_table {
+	SXE_IPSEC_IP_TABLE = 0,
+	SXE_IPSEC_SPI_TABLE,
+	SXE_IPSEC_KEY_TABLE,
+};
+
+u32 sxe_mac_regs[] = {
+	SXE_COMCTRL,
+	SXE_PCCTRL,
+	SXE_LPBKCTRL,
+	SXE_MAXFS,
+	SXE_VLANCTRL,
+	SXE_VLANID,
+	SXE_LINKS,
+	SXE_HLREG0,
+	SXE_MFLCN,
+	SXE_MACC,
+};
+
+u16 sxe_mac_reg_num_get(void)
+{
+	return ARRAY_SIZE(sxe_mac_regs);
+}
+
+
+#ifndef SXE_DPDK
+
+void sxe_hw_fault_handle(struct sxe_hw *hw)
+{
+	struct sxe_adapter *adapter = hw->adapter;
+
+	if (test_bit(SXE_HW_FAULT, &hw->state))
+		return;
+
+	set_bit(SXE_HW_FAULT, &hw->state);
+
+	LOG_DEV_ERR("sxe nic hw fault");
+
+	if (hw->fault_handle != NULL && hw->priv != NULL)
+		hw->fault_handle(hw->priv);
+}
+
+static u32 sxe_hw_fault_check(struct sxe_hw *hw, u32 reg)
+{
+	u32 i, value;
+	u8  __iomem *base_addr = hw->reg_base_addr;
+	struct sxe_adapter *adapter = hw->adapter;
+
+	if (sxe_is_hw_fault(hw))
+		goto l_out;
+
+	for (i = 0; i < SXE_REG_READ_RETRY; i++) {
+		value = hw->reg_read(base_addr + SXE_STATUS);
+		if (value != SXE_REG_READ_FAIL)
+			break;
+
+		mdelay(3);
+	}
+
+	if (value == SXE_REG_READ_FAIL) {
+		LOG_ERROR_BDF("read registers multiple times failed, ret=%#x", value);
+		sxe_hw_fault_handle(hw);
+	} else {
+		value = hw->reg_read(base_addr + reg);
+	}
+
+	return value;
+l_out:
+	return SXE_REG_READ_FAIL;
+}
+
+static u32 sxe_read_reg(struct sxe_hw *hw, u32 reg)
+{
+	u32 value;
+	u8  __iomem *base_addr = hw->reg_base_addr;
+	struct sxe_adapter *adapter = hw->adapter;
+
+	if (sxe_is_hw_fault(hw)) {
+		value = SXE_REG_READ_FAIL;
+		goto l_ret;
+	}
+
+	value = hw->reg_read(base_addr + reg);
+	if (unlikely(value == SXE_REG_READ_FAIL)) {
+		LOG_ERROR_BDF("reg[0x%x] read failed, ret=%#x", reg, value);
+		value = sxe_hw_fault_check(hw, reg);
+	}
+
+l_ret:
+	return value;
+}
+
+static void sxe_write_reg(struct sxe_hw *hw, u32 reg, u32 value)
+{
+	u8 __iomem *base_addr = hw->reg_base_addr;
+
+	if (sxe_is_hw_fault(hw))
+		return;
+
+	hw->reg_write(value, base_addr + reg);
+}
+
+#else
+
+static u32 sxe_read_reg(struct sxe_hw *hw, u32 reg)
+{
+	u32 i, value;
+	u8  __iomem *base_addr = hw->reg_base_addr;
+
+	value = rte_le_to_cpu_32(rte_read32(base_addr + reg));
+	if (unlikely(value == SXE_REG_READ_FAIL)) {
+		value = rte_le_to_cpu_32(rte_read32(base_addr + SXE_STATUS));
+		if (unlikely(value != SXE_REG_READ_FAIL)) {
+			value = rte_le_to_cpu_32(rte_read32(base_addr + reg));
+		} else {
+			LOG_ERROR("reg[0x%x] and reg[0x%x] read failed, ret=%#x",
+							reg, SXE_STATUS, value);
+			for (i = 0; i < SXE_REG_READ_RETRY; i++) {
+				value = rte_le_to_cpu_32(rte_read32(base_addr + SXE_STATUS));
+				if (unlikely(value != SXE_REG_READ_FAIL)) {
+					value = rte_le_to_cpu_32(rte_read32(base_addr + reg));
+					LOG_INFO("reg[0x%x] read ok, value=%#x",
+									reg, value);
+					break;
+				}
+				LOG_ERROR("reg[0x%x] and reg[0x%x] read failed, ret=%#x",
+						reg, SXE_STATUS, value);
+
+				mdelay(3);
+			}
+		}
+	}
+
+	return value;
+}
+
+static void sxe_write_reg(struct sxe_hw *hw, u32 reg, u32 value)
+{
+	u8 __iomem *base_addr = hw->reg_base_addr;
+
+	rte_write32((rte_cpu_to_le_32(value)), (base_addr + reg));
+}
+#endif
+
+static void sxe_write_reg64(struct sxe_hw *hw, u32 reg, u64 value)
+{
+	u8 __iomem *reg_addr = hw->reg_base_addr;
+
+	if (sxe_is_hw_fault(hw))
+		return;
+
+	writeq(value, reg_addr + reg);
+}
+
+
+void sxe_hw_no_snoop_disable(struct sxe_hw *hw)
+{
+	u32 ctrl_ext;
+
+	ctrl_ext = SXE_REG_READ(hw, SXE_CTRL_EXT);
+	ctrl_ext |= SXE_CTRL_EXT_NS_DIS;
+	SXE_REG_WRITE(hw, SXE_CTRL_EXT, ctrl_ext);
+	SXE_WRITE_FLUSH(hw);
+}
+
+static void sxe_hw_uc_addr_pool_add(struct sxe_hw *hw, u32 rar_idx, u32 pool_idx)
+{
+	u32 value;
+
+	if (sxe_is_hw_fault(hw))
+		goto l_end;
+
+	if (pool_idx < 32) {
+		value = SXE_REG_READ(hw, SXE_MPSAR_LOW(rar_idx));
+		value |= BIT(pool_idx);
+		SXE_REG_WRITE(hw, SXE_MPSAR_LOW(rar_idx), value);
+	} else {
+		value = SXE_REG_READ(hw, SXE_MPSAR_HIGH(rar_idx));
+		value |= BIT(pool_idx - 32);
+		SXE_REG_WRITE(hw, SXE_MPSAR_HIGH(rar_idx), value);
+	}
+
+l_end:
+	return;
+}
+
+void sxe_hw_uc_addr_pool_del(struct sxe_hw *hw, u32 rar_idx, u32 pool_idx)
+{
+	u32 value;
+
+	if (sxe_is_hw_fault(hw))
+		goto l_end;
+
+	if (pool_idx < 32) {
+		value = SXE_REG_READ(hw, SXE_MPSAR_LOW(rar_idx));
+		value &= ~BIT(pool_idx);
+		SXE_REG_WRITE(hw, SXE_MPSAR_LOW(rar_idx), value);
+	} else {
+		value = SXE_REG_READ(hw, SXE_MPSAR_HIGH(rar_idx));
+		value &= ~BIT(pool_idx - 32);
+		SXE_REG_WRITE(hw, SXE_MPSAR_HIGH(rar_idx), value);
+	}
+
+l_end:
+	return;
+}
+
+s32 sxe_hw_uc_addr_pool_enable(struct sxe_hw *hw,
+						u8 rar_idx, u8 pool_idx)
+{
+	s32 ret = 0;
+	u32 value;
+	struct sxe_adapter *adapter = hw->adapter;
+
+	if (rar_idx > SXE_UC_ENTRY_NUM_MAX) {
+		ret = -SXE_ERR_PARAM;
+		LOG_DEV_ERR("pool_idx:%d rar_idx:%d invalid.",
+			  pool_idx, rar_idx);
+		goto l_end;
+	}
+
+	if (pool_idx < 32) {
+		value = SXE_REG_READ(hw, SXE_MPSAR_LOW(rar_idx));
+		value |= BIT(pool_idx);
+		SXE_REG_WRITE(hw, SXE_MPSAR_LOW(rar_idx), value);
+	} else {
+		value = SXE_REG_READ(hw, SXE_MPSAR_HIGH(rar_idx));
+		value |= BIT(pool_idx - 32);
+		SXE_REG_WRITE(hw, SXE_MPSAR_HIGH(rar_idx), value);
+	}
+
+l_end:
+	return ret;
+}
+
+static s32 sxe_hw_uc_addr_pool_disable(struct sxe_hw *hw, u8 rar_idx)
+{
+	u32 hi;
+	u32 low;
+	struct sxe_adapter *adapter = hw->adapter;
+
+	hi = SXE_REG_READ(hw, SXE_MPSAR_HIGH(rar_idx));
+	low = SXE_REG_READ(hw, SXE_MPSAR_LOW(rar_idx));
+
+	if (sxe_is_hw_fault(hw))
+		goto l_end;
+
+	if (!hi & !low) {
+		LOG_DEBUG_BDF("no need clear rar-pool relation register.");
+		goto l_end;
+	}
+
+	if (low)
+		SXE_REG_WRITE(hw, SXE_MPSAR_LOW(rar_idx), 0);
+
+	if (hi)
+		SXE_REG_WRITE(hw, SXE_MPSAR_HIGH(rar_idx), 0);
+
+
+l_end:
+	return 0;
+}
+
+s32 sxe_hw_nic_reset(struct sxe_hw *hw)
+{
+	s32 ret = 0;
+	u32 ctrl, i;
+	struct sxe_adapter *adapter = hw->adapter;
+
+	ctrl = SXE_CTRL_RST;
+	ctrl |= SXE_REG_READ(hw, SXE_CTRL);
+	ctrl &= ~SXE_CTRL_GIO_DIS;
+	SXE_REG_WRITE(hw, SXE_CTRL, ctrl);
+
+	SXE_WRITE_FLUSH(hw);
+	usleep_range(1000, 1200);
+
+	for (i = 0; i < 10; i++) {
+		ctrl = SXE_REG_READ(hw, SXE_CTRL);
+		if (!(ctrl & SXE_CTRL_RST_MASK))
+			break;
+
+		sxe_udelay(1);
+	}
+
+	if (ctrl & SXE_CTRL_RST_MASK) {
+		ret = -SXE_ERR_RESET_FAILED;
+		LOG_DEV_ERR("reset polling failed to complete");
+	}
+
+	return ret;
+}
+
+void sxe_hw_pf_rst_done_set(struct sxe_hw *hw)
+{
+	u32 value;
+
+	value = SXE_REG_READ(hw, SXE_CTRL_EXT);
+	value |= SXE_CTRL_EXT_PFRSTD;
+	SXE_REG_WRITE(hw, SXE_CTRL_EXT, value);
+}
+
+static void sxe_hw_regs_flush(struct sxe_hw *hw)
+{
+	SXE_WRITE_FLUSH(hw);
+}
+
+static const struct sxe_reg_info sxe_reg_info_tbl[] = {
+	{SXE_CTRL, 1, 1, "CTRL"},
+	{SXE_STATUS, 1, 1, "STATUS"},
+	{SXE_CTRL_EXT, 1, 1, "CTRL_EXT"},
+
+	{SXE_EICR, 1, 1, "EICR"},
+
+	{SXE_SRRCTL(0), 16, 0x4, "SRRCTL"},
+	{SXE_RDH(0), 64, 0x40, "RDH"},
+	{SXE_RDT(0), 64, 0x40, "RDT"},
+	{SXE_RXDCTL(0), 64, 0x40, "RXDCTL"},
+	{SXE_RDBAL(0), 64, 0x40, "RDBAL"},
+	{SXE_RDBAH(0), 64, 0x40, "RDBAH"},
+
+	{SXE_TDBAL(0), 32, 0x40, "TDBAL"},
+	{SXE_TDBAH(0), 32, 0x40, "TDBAH"},
+	{SXE_TDLEN(0), 32, 0x40, "TDLEN"},
+	{SXE_TDH(0), 32, 0x40, "TDH"},
+	{SXE_TDT(0), 32, 0x40, "TDT"},
+	{SXE_TXDCTL(0), 32, 0x40, "TXDCTL"},
+
+	{ .name = NULL }
+};
+
+static void sxe_hw_reg_print(struct sxe_hw *hw,
+				const struct sxe_reg_info *reginfo)
+{
+	u32 i, j;
+	s8 *value;
+	u32 first_reg_idx = 0;
+	u32 regs[SXE_DUMP_REGS_NUM];
+	s8 reg_name[SXE_REG_NAME_LEN];
+	s8 buf[SXE_DUMP_REG_STRING_LEN];
+	struct sxe_adapter *adapter = hw->adapter;
+
+	switch (reginfo->addr) {
+	case SXE_SRRCTL(0):
+		for (i = 0; i < SXE_DUMP_REGS_NUM; i++)
+			regs[i] = SXE_REG_READ(hw, SXE_SRRCTL(i));
+
+		break;
+	case SXE_RDLEN(0):
+		for (i = 0; i < SXE_DUMP_REGS_NUM; i++)
+			regs[i] = SXE_REG_READ(hw, SXE_RDLEN(i));
+
+		break;
+	case SXE_RDH(0):
+		for (i = 0; i < SXE_DUMP_REGS_NUM; i++)
+			regs[i] = SXE_REG_READ(hw, SXE_RDH(i));
+
+		break;
+	case SXE_RDT(0):
+		for (i = 0; i < SXE_DUMP_REGS_NUM; i++)
+			regs[i] = SXE_REG_READ(hw, SXE_RDT(i));
+
+		break;
+	case SXE_RXDCTL(0):
+		for (i = 0; i < SXE_DUMP_REGS_NUM; i++)
+			regs[i] = SXE_REG_READ(hw, SXE_RXDCTL(i));
+
+		break;
+	case SXE_RDBAL(0):
+		for (i = 0; i < SXE_DUMP_REGS_NUM; i++)
+			regs[i] = SXE_REG_READ(hw, SXE_RDBAL(i));
+
+		break;
+	case SXE_RDBAH(0):
+		for (i = 0; i < SXE_DUMP_REGS_NUM; i++)
+			regs[i] = SXE_REG_READ(hw, SXE_RDBAH(i));
+
+		break;
+	case SXE_TDBAL(0):
+		for (i = 0; i < SXE_DUMP_REGS_NUM; i++)
+			regs[i] = SXE_REG_READ(hw, SXE_TDBAL(i));
+
+		break;
+	case SXE_TDBAH(0):
+		for (i = 0; i < SXE_DUMP_REGS_NUM; i++)
+			regs[i] = SXE_REG_READ(hw, SXE_TDBAH(i));
+
+		break;
+	case SXE_TDLEN(0):
+		for (i = 0; i < SXE_DUMP_REGS_NUM; i++)
+			regs[i] = SXE_REG_READ(hw, SXE_TDLEN(i));
+
+		break;
+	case SXE_TDH(0):
+		for (i = 0; i < SXE_DUMP_REGS_NUM; i++)
+			regs[i] = SXE_REG_READ(hw, SXE_TDH(i));
+
+		break;
+	case SXE_TDT(0):
+		for (i = 0; i < SXE_DUMP_REGS_NUM; i++)
+			regs[i] = SXE_REG_READ(hw, SXE_TDT(i));
+
+		break;
+	case SXE_TXDCTL(0):
+		for (i = 0; i < SXE_DUMP_REGS_NUM; i++)
+			regs[i] = SXE_REG_READ(hw, SXE_TXDCTL(i));
+
+		break;
+	default:
+		LOG_DEV_INFO("%-15s %08x",
+			reginfo->name, SXE_REG_READ(hw, reginfo->addr));
+		return;
+	}
+
+	while (first_reg_idx < SXE_DUMP_REGS_NUM) {
+		value = buf;
+		snprintf(reg_name, SXE_REG_NAME_LEN,
+			"%s[%d-%d]", reginfo->name,
+			first_reg_idx, (first_reg_idx + 7));
+
+		for (j = 0; j < 8; j++)
+			value += sprintf(value, " %08x", regs[first_reg_idx++]);
+
+		LOG_DEV_ERR("%-15s%s", reg_name, buf);
+	}
+}
+
+static void sxe_hw_reg_dump(struct sxe_hw *hw)
+{
+	const struct sxe_reg_info *reginfo;
+
+	for (reginfo = (const struct sxe_reg_info *)sxe_reg_info_tbl;
+		 reginfo->name; reginfo++) {
+		sxe_hw_reg_print(hw, reginfo);
+	}
+}
+
+static s32 sxe_hw_status_reg_test(struct sxe_hw *hw)
+{
+	s32 ret = 0;
+	u32 value, before, after;
+	u32 toggle = 0x7FFFF30F;
+	struct sxe_adapter *adapter = hw->adapter;
+
+	before = SXE_REG_READ(hw, SXE_STATUS);
+	value = (SXE_REG_READ(hw, SXE_STATUS) & toggle);
+	SXE_REG_WRITE(hw, SXE_STATUS, toggle);
+	after = SXE_REG_READ(hw, SXE_STATUS) & toggle;
+	if (value != after) {
+		LOG_MSG_ERR(drv, "failed status register test got: 0x%08X expected: 0x%08X",
+			    after, value);
+		ret = -SXE_DIAG_TEST_BLOCKED;
+		goto l_end;
+	}
+
+	SXE_REG_WRITE(hw, SXE_STATUS, before);
+
+l_end:
+	return ret;
+}
+
+#define PATTERN_TEST	1
+#define SET_READ_TEST	2
+#define WRITE_NO_TEST	3
+#define TABLE32_TEST	4
+#define TABLE64_TEST_LO	5
+#define TABLE64_TEST_HI	6
+
+struct sxe_self_test_reg {
+	u32 reg;
+	u8  array_len;
+	u8  test_type;
+	u32 mask;
+	u32 write;
+};
+
+static const struct sxe_self_test_reg self_test_reg[] = {
+	{ SXE_FCRTL(0),  1,   PATTERN_TEST, 0x8007FFE0, 0x8007FFF0 },
+	{ SXE_FCRTH(0),  1,   PATTERN_TEST, 0x8007FFE0, 0x8007FFF0 },
+	{ SXE_PFCTOP,	1,   PATTERN_TEST, 0xFFFFFFFF, 0xFFFFFFFF },
+	{ SXE_FCTTV(0),  1,   PATTERN_TEST, 0xFFFFFFFF, 0xFFFFFFFF },
+	{ SXE_VLNCTRL,   1,   PATTERN_TEST, 0x00000000, 0x00000000 },
+	{ SXE_RDBAL(0),  4,   PATTERN_TEST, 0xFFFFFF80, 0xFFFFFF80 },
+	{ SXE_RDBAH(0),  4,   PATTERN_TEST, 0xFFFFFFFF, 0xFFFFFFFF },
+	{ SXE_RDLEN(0),  4,   PATTERN_TEST, 0x000FFFFF, 0x000FFFFF },
+	{ SXE_RXDCTL(0), 4,   WRITE_NO_TEST, 0, SXE_RXDCTL_ENABLE },
+	{ SXE_RDT(0),	4,   PATTERN_TEST, 0x0000FFFF, 0x0000FFFF },
+	{ SXE_RXDCTL(0), 4,   WRITE_NO_TEST, 0, 0 },
+	{ SXE_TDBAL(0),  4,   PATTERN_TEST, 0xFFFFFF80, 0xFFFFFFFF },
+	{ SXE_TDBAH(0),  4,   PATTERN_TEST, 0xFFFFFFFF, 0xFFFFFFFF },
+	{ SXE_TDLEN(0),  4,   PATTERN_TEST, 0x000FFF80, 0x000FFF80 },
+	{ SXE_RXCTRL,	1,   SET_READ_TEST, 0x00000001, 0x00000001 },
+	{ SXE_RAL(0),	16,  TABLE64_TEST_LO, 0xFFFFFFFF, 0xFFFFFFFF },
+	{ SXE_RAL(0),	16,  TABLE64_TEST_HI, 0x8001FFFF, 0x800CFFFF },
+	{ SXE_MTA(0),	128, TABLE32_TEST, 0xFFFFFFFF, 0xFFFFFFFF },
+	{ .reg = 0 }
+};
+
+static s32 sxe_hw_reg_pattern_test(struct sxe_hw *hw, u32 reg,
+				u32 mask, u32 write)
+{
+	s32 ret = 0;
+	u32 pat, val, before;
+	struct sxe_adapter *adapter = hw->adapter;
+	static const u32 test_pattern[] = {
+		0x5A5A5A5A, 0xA5A5A5A5, 0x00000000, 0xFFFFFFFE};
+
+	if (sxe_is_hw_fault(hw)) {
+		LOG_ERROR_BDF("hw fault");
+		ret = -SXE_DIAG_TEST_BLOCKED;
+		goto l_end;
+	}
+
+	for (pat = 0; pat < ARRAY_SIZE(test_pattern); pat++) {
+		before = SXE_REG_READ(hw, reg);
+
+		SXE_REG_WRITE(hw, reg, test_pattern[pat] & write);
+		val = SXE_REG_READ(hw, reg);
+		if (val != (test_pattern[pat] & write & mask)) {
+			LOG_MSG_ERR(drv, "pattern test reg %04X failed: "
+					"got 0x%08X expected 0x%08X",
+				reg, val, (test_pattern[pat] & write & mask));
+			SXE_REG_WRITE(hw, reg, before);
+			ret = -SXE_DIAG_REG_PATTERN_TEST_ERR;
+			goto l_end;
+		}
+
+		SXE_REG_WRITE(hw, reg, before);
+	}
+
+l_end:
+	return ret;
+}
+
+static s32 sxe_hw_reg_set_and_check(struct sxe_hw *hw, int reg,
+				u32 mask, u32 write)
+{
+	s32 ret = 0;
+	u32 val, before;
+	struct sxe_adapter *adapter = hw->adapter;
+
+	if (sxe_is_hw_fault(hw)) {
+		LOG_ERROR_BDF("hw fault");
+		ret = -SXE_DIAG_TEST_BLOCKED;
+		goto l_end;
+	}
+
+	before = SXE_REG_READ(hw, reg);
+	SXE_REG_WRITE(hw, reg, write & mask);
+	val = SXE_REG_READ(hw, reg);
+	if ((write & mask) != (val & mask)) {
+		LOG_MSG_ERR(drv, "set/check reg %04X test failed: "
+				"got 0x%08X expected 0x%08X",
+			reg, (val & mask), (write & mask));
+		SXE_REG_WRITE(hw, reg, before);
+		ret = -SXE_DIAG_CHECK_REG_TEST_ERR;
+		goto l_end;
+	}
+
+	SXE_REG_WRITE(hw, reg, before);
+
+l_end:
+	return ret;
+}
+
+static s32 sxe_hw_regs_test(struct sxe_hw *hw)
+{
+	u32 i;
+	s32 ret = 0;
+	const struct sxe_self_test_reg *test = self_test_reg;
+	struct sxe_adapter *adapter = hw->adapter;
+
+	ret = sxe_hw_status_reg_test(hw);
+	if (ret) {
+		LOG_MSG_ERR(drv, "status register test failed");
+		goto l_end;
+	}
+
+	while (test->reg) {
+		for (i = 0; i < test->array_len; i++) {
+			switch (test->test_type) {
+			case PATTERN_TEST:
+				ret = sxe_hw_reg_pattern_test(hw,
+					test->reg + (i * 0x40),
+					test->mask, test->write);
+				break;
+			case TABLE32_TEST:
+				ret = sxe_hw_reg_pattern_test(hw,
+					test->reg + (i * 4),
+					test->mask, test->write);
+				break;
+			case TABLE64_TEST_LO:
+				ret = sxe_hw_reg_pattern_test(hw,
+					test->reg + (i * 8),
+					test->mask, test->write);
+				break;
+			case TABLE64_TEST_HI:
+				ret = sxe_hw_reg_pattern_test(hw,
+					(test->reg + 4) + (i * 8),
+					test->mask, test->write);
+				break;
+			case SET_READ_TEST:
+				ret = sxe_hw_reg_set_and_check(hw,
+					test->reg + (i * 0x40),
+					test->mask, test->write);
+				break;
+			case WRITE_NO_TEST:
+				SXE_REG_WRITE(hw, test->reg + (i * 0x40),
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
+static const struct sxe_setup_operations sxe_setup_ops = {
+	.regs_dump		= sxe_hw_reg_dump,
+	.reg_read		= sxe_read_reg,
+	.reg_write		= sxe_write_reg,
+	.regs_test		= sxe_hw_regs_test,
+	.reset			= sxe_hw_nic_reset,
+	.regs_flush		= sxe_hw_regs_flush,
+	.pf_rst_done_set	= sxe_hw_pf_rst_done_set,
+	.no_snoop_disable	= sxe_hw_no_snoop_disable,
+};
+
+
+static void sxe_hw_ring_irq_enable(struct sxe_hw *hw, u64 qmask)
+{
+	u32 mask0, mask1;
+
+	mask0 = qmask & 0xFFFFFFFF;
+	mask1 = qmask >> 32;
+
+	if (mask0 && mask1) {
+		SXE_REG_WRITE(hw, SXE_EIMS_EX(0), mask0);
+		SXE_REG_WRITE(hw, SXE_EIMS_EX(1), mask1);
+	} else if (mask0) {
+		SXE_REG_WRITE(hw, SXE_EIMS_EX(0), mask0);
+	} else if (mask1) {
+		SXE_REG_WRITE(hw, SXE_EIMS_EX(1), mask1);
+	}
+}
+
+u32 sxe_hw_pending_irq_read_clear(struct sxe_hw *hw)
+{
+	return SXE_REG_READ(hw, SXE_EICR);
+}
+
+void sxe_hw_pending_irq_write_clear(struct sxe_hw *hw, u32 value)
+{
+	SXE_REG_WRITE(hw, SXE_EICR, value);
+}
+
+u32 sxe_hw_irq_cause_get(struct sxe_hw *hw)
+{
+	return SXE_REG_READ(hw, SXE_EICS);
+}
+
+static void sxe_hw_event_irq_trigger(struct sxe_hw *hw)
+{
+	SXE_REG_WRITE(hw, SXE_EICS, (SXE_EICS_TCP_TIMER | SXE_EICS_OTHER));
+}
+
+static void sxe_hw_ring_irq_trigger(struct sxe_hw *hw, u64 eics)
+{
+	u32 mask;
+
+	mask = (eics & 0xFFFFFFFF);
+	SXE_REG_WRITE(hw, SXE_EICS_EX(0), mask);
+	mask = (eics >> 32);
+	SXE_REG_WRITE(hw, SXE_EICS_EX(1), mask);
+}
+
+void sxe_hw_ring_irq_auto_disable(struct sxe_hw *hw,
+					bool is_msix)
+{
+	if (is_msix) {
+		SXE_REG_WRITE(hw, SXE_EIAM_EX(0), 0xFFFFFFFF);
+		SXE_REG_WRITE(hw, SXE_EIAM_EX(1), 0xFFFFFFFF);
+	} else {
+		SXE_REG_WRITE(hw, SXE_EIAM, SXE_EICS_RTX_QUEUE);
+	}
+}
+
+void sxe_hw_irq_general_reg_set(struct sxe_hw *hw, u32 value)
+{
+	SXE_REG_WRITE(hw, SXE_GPIE, value);
+}
+
+u32 sxe_hw_irq_general_reg_get(struct sxe_hw *hw)
+{
+	return SXE_REG_READ(hw, SXE_GPIE);
+}
+
+static void sxe_hw_set_eitrsel(struct sxe_hw *hw, u32 value)
+{
+	SXE_REG_WRITE(hw, SXE_EITRSEL, value);
+}
+
+void sxe_hw_event_irq_map(struct sxe_hw *hw, u8 offset, u16 irq_idx)
+{
+	u8  allocation;
+	u32 ivar, position;
+
+	allocation = irq_idx | SXE_IVAR_ALLOC_VALID;
+
+	position = (offset & 1) * 8;
+
+	ivar = SXE_REG_READ(hw, SXE_IVAR_MISC);
+	ivar &= ~(0xFF << position);
+	ivar |= (allocation << position);
+
+	SXE_REG_WRITE(hw, SXE_IVAR_MISC, ivar);
+}
+
+void sxe_hw_ring_irq_map(struct sxe_hw *hw, bool is_tx,
+						u16 reg_idx, u16 irq_idx)
+{
+	u8  allocation;
+	u32 ivar, position;
+
+	allocation = irq_idx | SXE_IVAR_ALLOC_VALID;
+
+	position = ((reg_idx & 1) * 16) + (8 * is_tx);
+
+	ivar = SXE_REG_READ(hw, SXE_IVAR(reg_idx >> 1));
+	ivar &= ~(0xFF << position);
+	ivar |= (allocation << position);
+
+	SXE_REG_WRITE(hw, SXE_IVAR(reg_idx >> 1), ivar);
+}
+
+void sxe_hw_ring_irq_interval_set(struct sxe_hw *hw,
+						u16 irq_idx, u32 interval)
+{
+	u32 eitr = interval & SXE_EITR_ITR_MASK;
+
+	eitr |= SXE_EITR_CNT_WDIS;
+
+	SXE_REG_WRITE(hw, SXE_EITR(irq_idx), eitr);
+}
+
+static void sxe_hw_event_irq_interval_set(struct sxe_hw *hw,
+						u16 irq_idx, u32 value)
+{
+	SXE_REG_WRITE(hw, SXE_EITR(irq_idx), value);
+}
+
+void sxe_hw_event_irq_auto_clear_set(struct sxe_hw *hw, u32 value)
+{
+	SXE_REG_WRITE(hw, SXE_EIAC, value);
+}
+
+void sxe_hw_specific_irq_disable(struct sxe_hw *hw, u32 value)
+{
+	SXE_REG_WRITE(hw, SXE_EIMC, value);
+}
+
+void sxe_hw_specific_irq_enable(struct sxe_hw *hw, u32 value)
+{
+	SXE_REG_WRITE(hw, SXE_EIMS, value);
+}
+
+static u32 sxe_hw_spp_state_get(struct sxe_hw *hw)
+{
+	return SXE_REG_READ(hw, SXE_SPP_STATE);
+}
+
+static void sxe_hw_rx_los_disable(struct sxe_hw *hw)
+{
+	u32 value;
+
+	value = SXE_REG_READ(hw, SXE_EIMS);
+	value &= ~SXE_EIMS_GPI_SPP1;
+	SXE_REG_WRITE(hw, SXE_EIMS, value);
+}
+
+static void sxe_hw_rx_los_enable(struct sxe_hw *hw)
+{
+	u32 value;
+
+	value = SXE_REG_READ(hw, SXE_EIMS);
+	value |= SXE_EIMS_GPI_SPP1;
+	SXE_REG_WRITE(hw, SXE_EIMS, value);
+}
+
+void sxe_hw_all_irq_disable(struct sxe_hw *hw)
+{
+	SXE_REG_WRITE(hw, SXE_EIMC, 0xFFFF0000);
+
+	SXE_REG_WRITE(hw, SXE_EIMC_EX(0), ~0);
+	SXE_REG_WRITE(hw, SXE_EIMC_EX(1), ~0);
+
+	SXE_WRITE_FLUSH(hw);
+}
+
+static void sxe_hw_spp_configure(struct sxe_hw *hw, u32 hw_spp_proc_delay_us)
+{
+	u32 reg = SXE_REG_READ(hw, SXE_SPP_PROC);
+
+	reg &= ~SXE_SPP_PROC_DELAY_US_MASK;
+	reg |= hw_spp_proc_delay_us;
+	reg &= SXE_SPP_PROC_SPP2_TRIGGER_MASK;
+	reg |= SXE_SPP_PROC_SPP2_TRIGGER;
+
+	SXE_REG_WRITE(hw, SXE_SPP_PROC, reg);
+}
+
+static s32 sxe_hw_irq_test(struct sxe_hw *hw, u32 *icr, bool shared)
+{
+	s32 ret = 0;
+	u32 i, mask;
+	struct sxe_adapter *adapter = hw->adapter;
+
+	sxe_hw_specific_irq_disable(hw, 0xFFFFFFFF);
+	sxe_hw_regs_flush(hw);
+	usleep_range(10000, 20000);
+
+	for (i = 0; i < 10; i++) {
+		mask = BIT(i);
+		if (!shared) {
+			LOG_INFO_BDF("test irq: irq test start");
+			*icr = 0;
+			SXE_REG_WRITE(hw, SXE_EIMC, ~mask & 0x00007FFF);
+			SXE_REG_WRITE(hw, SXE_EICS, ~mask & 0x00007FFF);
+			sxe_hw_regs_flush(hw);
+			usleep_range(10000, 20000);
+
+			if (*icr & mask) {
+				LOG_ERROR_BDF("test irq: failed, eicr = %x", *icr);
+				ret = -SXE_DIAG_DISABLE_IRQ_TEST_ERR;
+				break;
+			}
+			LOG_INFO_BDF("test irq: irq test end");
+		}
+
+		LOG_INFO_BDF("test irq: mask irq test start");
+		*icr = 0;
+		SXE_REG_WRITE(hw, SXE_EIMS, mask);
+		SXE_REG_WRITE(hw, SXE_EICS, mask);
+		sxe_hw_regs_flush(hw);
+		usleep_range(10000, 20000);
+
+		if (!(*icr & mask)) {
+			LOG_ERROR_BDF("test irq: mask failed, eicr = %x", *icr);
+			ret = -SXE_DIAG_ENABLE_IRQ_TEST_ERR;
+			break;
+		}
+		LOG_INFO_BDF("test irq: mask irq test end");
+
+		sxe_hw_specific_irq_disable(hw, mask);
+		sxe_hw_regs_flush(hw);
+		usleep_range(10000, 20000);
+
+		if (!shared) {
+			LOG_INFO_BDF("test irq: other irq test start");
+			*icr = 0;
+			SXE_REG_WRITE(hw, SXE_EIMC, ~mask & 0x00007FFF);
+			SXE_REG_WRITE(hw, SXE_EICS, ~mask & 0x00007FFF);
+			sxe_hw_regs_flush(hw);
+			usleep_range(10000, 20000);
+
+			if (*icr) {
+				LOG_ERROR_BDF("test irq: other irq failed, eicr = %x", *icr);
+				ret = -SXE_DIAG_DISABLE_OTHER_IRQ_TEST_ERR;
+				break;
+			}
+			LOG_INFO_BDF("test irq: other irq test end");
+		}
+	}
+
+	sxe_hw_specific_irq_disable(hw, 0xFFFFFFFF);
+	sxe_hw_regs_flush(hw);
+	usleep_range(10000, 20000);
+
+	return ret;
+}
+
+static const struct sxe_irq_operations sxe_irq_ops = {
+	.event_irq_auto_clear_set	= sxe_hw_event_irq_auto_clear_set,
+	.ring_irq_interval_set		= sxe_hw_ring_irq_interval_set,
+	.event_irq_interval_set		= sxe_hw_event_irq_interval_set,
+	.set_eitrsel			= sxe_hw_set_eitrsel,
+	.ring_irq_map			= sxe_hw_ring_irq_map,
+	.event_irq_map			= sxe_hw_event_irq_map,
+	.irq_general_reg_set		= sxe_hw_irq_general_reg_set,
+	.irq_general_reg_get		= sxe_hw_irq_general_reg_get,
+	.ring_irq_auto_disable		= sxe_hw_ring_irq_auto_disable,
+	.pending_irq_read_clear		= sxe_hw_pending_irq_read_clear,
+	.pending_irq_write_clear	= sxe_hw_pending_irq_write_clear,
+	.ring_irq_enable		= sxe_hw_ring_irq_enable,
+	.irq_cause_get			= sxe_hw_irq_cause_get,
+	.event_irq_trigger		= sxe_hw_event_irq_trigger,
+	.ring_irq_trigger		= sxe_hw_ring_irq_trigger,
+	.specific_irq_disable		= sxe_hw_specific_irq_disable,
+	.specific_irq_enable		= sxe_hw_specific_irq_enable,
+	.spp_state_get			= sxe_hw_spp_state_get,
+	.rx_los_disable			= sxe_hw_rx_los_disable,
+	.rx_los_enable			= sxe_hw_rx_los_enable,
+	.all_irq_disable		= sxe_hw_all_irq_disable,
+	.spp_configure			= sxe_hw_spp_configure,
+	.irq_test			= sxe_hw_irq_test,
+};
+
+
+u32 sxe_hw_link_speed_get(struct sxe_hw *hw)
+{
+	u32 speed, value;
+	struct sxe_adapter *adapter = hw->adapter;
+	value = SXE_REG_READ(hw, SXE_COMCTRL);
+
+	if ((value & SXE_COMCTRL_SPEED_10G) == SXE_COMCTRL_SPEED_10G)
+		speed = SXE_LINK_SPEED_10GB_FULL;
+	else if ((value & SXE_COMCTRL_SPEED_1G) == SXE_COMCTRL_SPEED_1G)
+		speed = SXE_LINK_SPEED_1GB_FULL;
+	else
+		speed = SXE_LINK_SPEED_UNKNOWN;
+
+	LOG_DEBUG_BDF("hw link speed=%x, (0x80=10G, 0x20=1G), reg=%x",
+			speed, value);
+
+	return speed;
+}
+
+void sxe_hw_link_speed_set(struct sxe_hw *hw, u32 speed)
+{
+	u32 ctrl;
+
+	ctrl = SXE_REG_READ(hw, SXE_COMCTRL);
+
+	if (speed == SXE_LINK_SPEED_1GB_FULL)
+		ctrl |= SXE_COMCTRL_SPEED_1G;
+	else if (speed == SXE_LINK_SPEED_10GB_FULL)
+		ctrl |= SXE_COMCTRL_SPEED_10G;
+
+	SXE_REG_WRITE(hw, SXE_COMCTRL, ctrl);
+}
+
+static bool sxe_hw_1g_link_up_check(struct sxe_hw *hw)
+{
+	return (SXE_REG_READ(hw, SXE_LINKS) & SXE_LINKS_UP) ? true : false;
+}
+
+bool sxe_hw_is_link_state_up(struct sxe_hw *hw)
+{
+	bool ret = false;
+	u32 links_reg, link_speed;
+	struct sxe_adapter *adapter = hw->adapter;
+
+	links_reg  = SXE_REG_READ(hw, SXE_LINKS);
+
+	LOG_DEBUG_BDF("nic link reg: 0x%x", links_reg);
+
+	if (links_reg & SXE_LINKS_UP) {
+		ret = true;
+
+		link_speed = sxe_hw_link_speed_get(hw);
+		if (link_speed == SXE_LINK_SPEED_10GB_FULL &&
+			links_reg & SXE_10G_LINKS_DOWN)
+			ret = false;
+	}
+
+	return ret;
+}
+
+void sxe_hw_mac_pad_enable(struct sxe_hw *hw)
+{
+	u32 ctl;
+
+	ctl = SXE_REG_READ(hw, SXE_MACCFG);
+	ctl |= SXE_MACCFG_PAD_EN;
+	SXE_REG_WRITE(hw, SXE_MACCFG, ctl);
+}
+
+s32 sxe_hw_fc_enable(struct sxe_hw *hw)
+{
+	s32 ret = 0;
+	u8  i;
+	u32 reg;
+	u32 flctrl_val;
+	u32 fcrtl, fcrth;
+	struct sxe_adapter *adapter = hw->adapter;
+
+	flctrl_val = SXE_REG_READ(hw, SXE_FLCTRL);
+	flctrl_val &= ~(SXE_FCTRL_TFCE_MASK | SXE_FCTRL_RFCE_MASK |
+			   SXE_FCTRL_TFCE_FCEN_MASK | SXE_FCTRL_TFCE_XONE_MASK);
+
+	switch (hw->fc.current_mode) {
+	case SXE_FC_NONE:
+		break;
+	case SXE_FC_RX_PAUSE:
+		flctrl_val |= SXE_FCTRL_RFCE_LFC_EN;
+		break;
+	case SXE_FC_TX_PAUSE:
+		flctrl_val |= SXE_FCTRL_TFCE_LFC_EN;
+		break;
+	case SXE_FC_FULL:
+		flctrl_val |= SXE_FCTRL_RFCE_LFC_EN;
+		flctrl_val |= SXE_FCTRL_TFCE_LFC_EN;
+		break;
+	default:
+		LOG_DEV_DEBUG("flow control param set incorrectly");
+		ret = -SXE_ERR_CONFIG;
+		goto l_ret;
+	}
+
+	for (i = 0; i < MAX_TRAFFIC_CLASS; i++) {
+		if ((hw->fc.current_mode & SXE_FC_TX_PAUSE) &&
+			hw->fc.high_water[i]) {
+			fcrtl = (hw->fc.low_water[i] << 9) | SXE_FCRTL_XONE;
+			SXE_REG_WRITE(hw, SXE_FCRTL(i), fcrtl);
+			fcrth = (hw->fc.high_water[i] << 9) | SXE_FCRTH_FCEN;
+		} else {
+			SXE_REG_WRITE(hw, SXE_FCRTL(i), 0);
+			fcrth = (SXE_REG_READ(hw, SXE_RXPBSIZE(i)) - 24576) >> 1;
+		}
+
+		SXE_REG_WRITE(hw, SXE_FCRTH(i), fcrth);
+	}
+
+	flctrl_val |= SXE_FCTRL_TFCE_DPF_EN;
+
+	if ((hw->fc.current_mode & SXE_FC_TX_PAUSE))
+		flctrl_val |= (SXE_FCTRL_TFCE_FCEN_MASK | SXE_FCTRL_TFCE_XONE_MASK);
+
+	SXE_REG_WRITE(hw, SXE_FLCTRL, flctrl_val);
+
+	reg = SXE_REG_READ(hw, SXE_PFCTOP);
+	reg &= ~SXE_PFCTOP_FCOP_MASK;
+	reg |= SXE_PFCTOP_FCT;
+	reg |= SXE_PFCTOP_FCOP_LFC;
+	SXE_REG_WRITE(hw, SXE_PFCTOP, reg);
+
+	reg = hw->fc.pause_time * 0x00010001U;
+	for (i = 0; i < (MAX_TRAFFIC_CLASS / 2); i++)
+		SXE_REG_WRITE(hw, SXE_FCTTV(i), reg);
+
+	SXE_REG_WRITE(hw, SXE_FCRTV, hw->fc.pause_time / 2);
+
+l_ret:
+	return ret;
+}
+
+void sxe_fc_autoneg_localcap_set(struct sxe_hw *hw)
+{
+	u32 reg = 0;
+
+	if (hw->fc.requested_mode == SXE_FC_DEFAULT)
+		hw->fc.requested_mode = SXE_FC_FULL;
+
+	reg = SXE_REG_READ(hw, SXE_PCS1GANA);
+
+	switch (hw->fc.requested_mode) {
+	case SXE_FC_NONE:
+		reg &= ~(SXE_PCS1GANA_SYM_PAUSE | SXE_PCS1GANA_ASM_PAUSE);
+		break;
+	case SXE_FC_TX_PAUSE:
+		reg |= SXE_PCS1GANA_ASM_PAUSE;
+		reg &= ~SXE_PCS1GANA_SYM_PAUSE;
+		break;
+	case SXE_FC_RX_PAUSE:
+	case SXE_FC_FULL:
+		reg |= SXE_PCS1GANA_SYM_PAUSE | SXE_PCS1GANA_ASM_PAUSE;
+		break;
+	default:
+		LOG_ERROR("Flow control param set incorrectly.");
+		break;
+	}
+
+	SXE_REG_WRITE(hw, SXE_PCS1GANA, reg);
+}
+
+s32 sxe_hw_pfc_enable(struct sxe_hw *hw, u8 tc_idx)
+{
+	s32 ret = 0;
+	u8  i;
+	u32 reg;
+	u32 flctrl_val;
+	u32 fcrtl, fcrth;
+	struct sxe_adapter *adapter = hw->adapter;
+	u8 rx_en_num;
+
+	flctrl_val = SXE_REG_READ(hw, SXE_FLCTRL);
+	flctrl_val &= ~(SXE_FCTRL_TFCE_MASK | SXE_FCTRL_RFCE_MASK |
+			   SXE_FCTRL_TFCE_FCEN_MASK | SXE_FCTRL_TFCE_XONE_MASK);
+
+	switch (hw->fc.current_mode) {
+	case SXE_FC_NONE:
+		rx_en_num = 0;
+		for (i = 0; i < MAX_TRAFFIC_CLASS; i++) {
+			reg = SXE_REG_READ(hw, SXE_FCRTH(i));
+			if (reg & SXE_FCRTH_FCEN)
+				rx_en_num++;
+		}
+		if (rx_en_num > 1)
+			flctrl_val |= SXE_FCTRL_TFCE_PFC_EN;
+
+		break;
+
+	case SXE_FC_RX_PAUSE:
+		flctrl_val |= SXE_FCTRL_RFCE_PFC_EN;
+
+		rx_en_num = 0;
+		for (i = 0; i < MAX_TRAFFIC_CLASS; i++) {
+			reg = SXE_REG_READ(hw, SXE_FCRTH(i));
+			if (reg & SXE_FCRTH_FCEN)
+				rx_en_num++;
+		}
+
+		if (rx_en_num > 1)
+			flctrl_val |= SXE_FCTRL_TFCE_PFC_EN;
+
+		break;
+	case SXE_FC_TX_PAUSE:
+		flctrl_val |= SXE_FCTRL_TFCE_PFC_EN;
+		break;
+	case SXE_FC_FULL:
+		flctrl_val |= SXE_FCTRL_RFCE_PFC_EN;
+		flctrl_val |= SXE_FCTRL_TFCE_PFC_EN;
+		break;
+	default:
+		LOG_DEV_DEBUG("flow control param set incorrectly");
+		ret = -SXE_ERR_CONFIG;
+		goto l_ret;
+	}
+
+	if ((hw->fc.current_mode & SXE_FC_TX_PAUSE) &&
+		hw->fc.high_water[tc_idx]) {
+		fcrtl = (hw->fc.low_water[tc_idx] << 9) | SXE_FCRTL_XONE;
+		SXE_REG_WRITE(hw, SXE_FCRTL(tc_idx), fcrtl);
+		fcrth = (hw->fc.high_water[tc_idx] << 9) | SXE_FCRTH_FCEN;
+	} else {
+		SXE_REG_WRITE(hw, SXE_FCRTL(tc_idx), 0);
+		fcrth = (SXE_REG_READ(hw, SXE_RXPBSIZE(tc_idx)) - 24576) >> 1;
+	}
+
+	SXE_REG_WRITE(hw, SXE_FCRTH(tc_idx), fcrth);
+
+	flctrl_val |= SXE_FCTRL_TFCE_DPF_EN;
+
+	if ((hw->fc.current_mode & SXE_FC_TX_PAUSE)) {
+		flctrl_val |= (BIT(tc_idx) << 16) & SXE_FCTRL_TFCE_FCEN_MASK;
+		flctrl_val |= (BIT(tc_idx) << 24) & SXE_FCTRL_TFCE_XONE_MASK;
+	}
+
+	SXE_REG_WRITE(hw, SXE_FLCTRL, flctrl_val);
+
+	reg = SXE_REG_READ(hw, SXE_PFCTOP);
+	reg &= ~SXE_PFCTOP_FCOP_MASK;
+	reg |= SXE_PFCTOP_FCT;
+	reg |= SXE_PFCTOP_FCOP_PFC;
+	SXE_REG_WRITE(hw, SXE_PFCTOP, reg);
+
+	reg = hw->fc.pause_time * 0x00010001U;
+	for (i = 0; i < (MAX_TRAFFIC_CLASS / 2); i++)
+		SXE_REG_WRITE(hw, SXE_FCTTV(i), reg);
+
+	SXE_REG_WRITE(hw, SXE_FCRTV, hw->fc.pause_time / 2);
+
+l_ret:
+	return ret;
+}
+
+void sxe_hw_crc_configure(struct sxe_hw *hw)
+{
+	u32 ctrl = SXE_REG_READ(hw, SXE_PCCTRL);
+
+	ctrl |=  SXE_PCCTRL_TXCE | SXE_PCCTRL_RXCE | SXE_PCCTRL_PCSC_ALL;
+	SXE_REG_WRITE(hw, SXE_PCCTRL, ctrl);
+}
+
+void sxe_hw_loopback_switch(struct sxe_hw *hw, bool is_enable)
+{
+	u32 value;
+
+	value = is_enable ? SXE_LPBK_EN : 0;
+
+	SXE_REG_WRITE(hw, SXE_LPBKCTRL, value);
+}
+
+void sxe_hw_mac_txrx_enable(struct sxe_hw *hw)
+{
+	u32 ctl;
+
+	ctl = SXE_REG_READ(hw, SXE_COMCTRL);
+	ctl |= SXE_COMCTRL_TXEN | SXE_COMCTRL_RXEN | SXE_COMCTRL_EDSEL;
+	SXE_REG_WRITE(hw, SXE_COMCTRL, ctl);
+}
+
+void sxe_hw_mac_max_frame_set(struct sxe_hw *hw, u32 max_frame)
+{
+	u32 maxfs = SXE_REG_READ(hw, SXE_MAXFS);
+
+	if (max_frame != (maxfs >> SXE_MAXFS_MFS_SHIFT)) {
+		maxfs &= ~SXE_MAXFS_MFS_MASK;
+		maxfs |= max_frame << SXE_MAXFS_MFS_SHIFT;
+	}
+
+	maxfs |=  SXE_MAXFS_RFSEL | SXE_MAXFS_TFSEL;
+	SXE_REG_WRITE(hw, SXE_MAXFS, maxfs);
+}
+
+u32 sxe_hw_mac_max_frame_get(struct sxe_hw *hw)
+{
+	u32 maxfs = SXE_REG_READ(hw, SXE_MAXFS);
+
+	maxfs &= SXE_MAXFS_MFS_MASK;
+	maxfs >>= SXE_MAXFS_MFS_SHIFT;
+
+	return maxfs;
+}
+
+bool sxe_device_supports_autoneg_fc(struct sxe_hw *hw)
+{
+	bool supported = true;
+	bool link_up = sxe_hw_is_link_state_up(hw);
+	u32  link_speed = sxe_hw_link_speed_get(hw);
+
+	if (link_up) {
+		supported = (link_speed == SXE_LINK_SPEED_1GB_FULL) ?
+				true : false;
+	}
+
+	return supported;
+}
+
+static void sxe_hw_fc_param_init(struct sxe_hw *hw)
+{
+	hw->fc.requested_mode = SXE_FC_FULL;
+	hw->fc.current_mode = SXE_FC_FULL;
+	hw->fc.pause_time = SXE_DEFAULT_FCPAUSE;
+
+	hw->fc.disable_fc_autoneg = true;
+}
+
+void sxe_hw_fc_tc_high_water_mark_set(struct sxe_hw *hw,
+							u8 tc_idx, u32 mark)
+{
+	hw->fc.high_water[tc_idx] = mark;
+}
+
+void sxe_hw_fc_tc_low_water_mark_set(struct sxe_hw *hw,
+							u8 tc_idx, u32 mark)
+{
+	hw->fc.low_water[tc_idx] = mark;
+}
+
+bool sxe_hw_is_fc_autoneg_disabled(struct sxe_hw *hw)
+{
+	return hw->fc.disable_fc_autoneg;
+}
+
+void sxe_hw_fc_autoneg_disable_set(struct sxe_hw *hw,
+							bool is_disabled)
+{
+	hw->fc.disable_fc_autoneg = is_disabled;
+}
+
+static enum sxe_fc_mode sxe_hw_fc_current_mode_get(struct sxe_hw *hw)
+{
+	return hw->fc.current_mode;
+}
+
+static enum sxe_fc_mode sxe_hw_fc_requested_mode_get(struct sxe_hw *hw)
+{
+	return hw->fc.requested_mode;
+}
+
+void sxe_hw_fc_requested_mode_set(struct sxe_hw *hw,
+						enum sxe_fc_mode mode)
+{
+	hw->fc.requested_mode = mode;
+}
+
+static const struct sxe_mac_operations sxe_mac_ops = {
+	.link_up_1g_check			= sxe_hw_1g_link_up_check,
+	.link_state_is_up		= sxe_hw_is_link_state_up,
+	.link_speed_get			= sxe_hw_link_speed_get,
+	.link_speed_set			= sxe_hw_link_speed_set,
+	.pad_enable			= sxe_hw_mac_pad_enable,
+	.crc_configure			= sxe_hw_crc_configure,
+	.loopback_switch		= sxe_hw_loopback_switch,
+	.txrx_enable			= sxe_hw_mac_txrx_enable,
+	.max_frame_set			= sxe_hw_mac_max_frame_set,
+	.max_frame_get			= sxe_hw_mac_max_frame_get,
+	.fc_enable			= sxe_hw_fc_enable,
+	.fc_autoneg_localcap_set	= sxe_fc_autoneg_localcap_set,
+	.fc_tc_high_water_mark_set	= sxe_hw_fc_tc_high_water_mark_set,
+	.fc_tc_low_water_mark_set	= sxe_hw_fc_tc_low_water_mark_set,
+	.fc_param_init			= sxe_hw_fc_param_init,
+	.fc_current_mode_get		= sxe_hw_fc_current_mode_get,
+	.fc_requested_mode_get		= sxe_hw_fc_requested_mode_get,
+	.fc_requested_mode_set		= sxe_hw_fc_requested_mode_set,
+	.is_fc_autoneg_disabled		= sxe_hw_is_fc_autoneg_disabled,
+	.fc_autoneg_disable_set		= sxe_hw_fc_autoneg_disable_set,
+};
+
+u32 sxe_hw_rx_mode_get(struct sxe_hw *hw)
+{
+	return SXE_REG_READ(hw, SXE_FCTRL);
+}
+
+u32 sxe_hw_pool_rx_mode_get(struct sxe_hw *hw, u16 pool_idx)
+{
+	return SXE_REG_READ(hw, SXE_VMOLR(pool_idx));
+}
+
+void sxe_hw_rx_mode_set(struct sxe_hw *hw, u32 filter_ctrl)
+{
+	SXE_REG_WRITE(hw, SXE_FCTRL, filter_ctrl);
+}
+
+void sxe_hw_pool_rx_mode_set(struct sxe_hw *hw,
+						u32 vmolr, u16 pool_idx)
+{
+	SXE_REG_WRITE(hw, SXE_VMOLR(pool_idx), vmolr);
+}
+
+void sxe_hw_rx_lro_enable(struct sxe_hw *hw, bool is_enable)
+{
+	u32 rfctl = SXE_REG_READ(hw, SXE_RFCTL);
+	rfctl &= ~SXE_RFCTL_LRO_DIS;
+
+	if (!is_enable)
+		rfctl |= SXE_RFCTL_LRO_DIS;
+
+	SXE_REG_WRITE(hw, SXE_RFCTL, rfctl);
+}
+
+void sxe_hw_rx_nfs_filter_disable(struct sxe_hw *hw)
+{
+	u32 rfctl = 0;
+
+	rfctl |= (SXE_RFCTL_NFSW_DIS | SXE_RFCTL_NFSR_DIS);
+	SXE_REG_WRITE(hw, SXE_RFCTL, rfctl);
+}
+
+void sxe_hw_rx_udp_frag_checksum_disable(struct sxe_hw *hw)
+{
+	u32 rxcsum;
+
+	rxcsum = SXE_REG_READ(hw, SXE_RXCSUM);
+	rxcsum |= SXE_RXCSUM_PCSD;
+	SXE_REG_WRITE(hw, SXE_RXCSUM, rxcsum);
+}
+
+void sxe_hw_fc_mac_addr_set(struct sxe_hw *hw, u8 *mac_addr)
+{
+	u32 mac_addr_h, mac_addr_l;
+
+	mac_addr_l = ((u32)mac_addr[5] |
+			((u32)mac_addr[4] << 8) |
+			((u32)mac_addr[3] << 16) |
+			((u32)mac_addr[2] << 24));
+	mac_addr_h = (((u32)mac_addr[1] << 16) |
+			((u32)mac_addr[0] << 24));
+
+	SXE_REG_WRITE(hw, SXE_SACONH, mac_addr_h);
+	SXE_REG_WRITE(hw, SXE_SACONL, mac_addr_l);
+}
+
+s32 sxe_hw_uc_addr_add(struct sxe_hw *hw, u32 rar_idx,
+					u8 *addr, u32 pool_idx)
+{
+	s32 ret = 0;
+	u32 rar_low, rar_high;
+	struct sxe_adapter *adapter = hw->adapter;
+
+	if (rar_idx >= SXE_UC_ENTRY_NUM_MAX) {
+		LOG_DEV_DEBUG("RAR rar_idx %d is out of range:%u.",
+			rar_idx, SXE_UC_ENTRY_NUM_MAX);
+		ret = -SXE_ERR_PARAM;
+		goto l_end;
+	}
+
+	sxe_hw_uc_addr_pool_enable(hw, rar_idx, pool_idx);
+
+	rar_low = ((u32)addr[0] |
+		   ((u32)addr[1] << 8) |
+		   ((u32)addr[2] << 16) |
+		   ((u32)addr[3] << 24));
+
+	rar_high = SXE_REG_READ(hw, SXE_RAH(rar_idx));
+	rar_high &= ~(0x0000FFFF | SXE_RAH_AV);
+	rar_high |= ((u32)addr[4] | ((u32)addr[5] << 8));
+
+	rar_high |= SXE_RAH_AV;
+
+	SXE_REG_WRITE(hw, SXE_RAL(rar_idx), rar_low);
+	SXE_WRITE_FLUSH(hw);
+	SXE_REG_WRITE(hw, SXE_RAH(rar_idx), rar_high);
+
+	LOG_DEBUG_BDF("rar_idx:%d pool_idx:%u addr:%pM add to rar done",
+		rar_idx, pool_idx, addr);
+
+l_end:
+	return ret;
+}
+
+s32 sxe_hw_uc_addr_del(struct sxe_hw *hw, u32 index)
+{
+	s32 ret = 0;
+	u32 rar_high;
+	struct sxe_adapter *adapter = hw->adapter;
+
+	if (index >= SXE_UC_ENTRY_NUM_MAX) {
+		ret = -SXE_ERR_PARAM;
+		LOG_ERROR_BDF("uc_entry_num:%d index:%u invalid.(err:%d)",
+			  SXE_UC_ENTRY_NUM_MAX, index, ret);
+		goto l_end;
+	}
+
+	rar_high = SXE_REG_READ(hw, SXE_RAH(index));
+	rar_high &= ~(0x0000FFFF | SXE_RAH_AV);
+
+	SXE_REG_WRITE(hw, SXE_RAH(index), rar_high);
+	SXE_WRITE_FLUSH(hw);
+	SXE_REG_WRITE(hw, SXE_RAL(index), 0);
+
+	sxe_hw_uc_addr_pool_disable(hw, index);
+
+l_end:
+	return ret;
+}
+
+void sxe_hw_mta_hash_table_set(struct sxe_hw *hw,
+						u8 index, u32 value)
+{
+	SXE_REG_WRITE(hw, SXE_MTA(index), value);
+}
+
+void sxe_hw_mta_hash_table_update(struct sxe_hw *hw,
+						u8 reg_idx, u8 bit_idx)
+{
+	u32 value = SXE_REG_READ(hw, SXE_MTA(reg_idx));
+
+	value |= BIT(bit_idx);
+
+	LOG_INFO("mta update value:0x%x.", value);
+	SXE_REG_WRITE(hw, SXE_MTA(reg_idx), value);
+}
+
+u32 sxe_hw_mc_filter_get(struct sxe_hw *hw)
+{
+	return SXE_REG_READ(hw, SXE_MCSTCTRL);
+}
+
+void sxe_hw_mc_filter_enable(struct sxe_hw *hw)
+{
+	u32 value = SXE_MC_FILTER_TYPE0 | SXE_MCSTCTRL_MFE;
+
+	SXE_REG_WRITE(hw, SXE_MCSTCTRL, value);
+}
+
+static void sxe_hw_mc_filter_disable(struct sxe_hw *hw)
+{
+	u32 value = SXE_REG_READ(hw, SXE_MCSTCTRL);
+
+	value &= ~SXE_MCSTCTRL_MFE;
+
+	SXE_REG_WRITE(hw, SXE_MCSTCTRL, value);
+}
+
+static void sxe_hw_uta_all_set(struct sxe_hw *hw, u32 value)
+{
+	u32 i;
+	for (i = 0; i < SXE_UTA_ENTRY_NUM_MAX; i++)
+		SXE_REG_WRITE(hw, SXE_UTA(i), value);
+}
+
+void sxe_hw_uc_addr_clear(struct sxe_hw *hw)
+{
+	u32 i;
+	struct sxe_adapter *adapter = hw->adapter;
+
+	sxe_hw_uc_addr_pool_disable(hw, 0);
+
+	LOG_DEV_DEBUG("clear uc filter addr register:0-%d",
+		   SXE_UC_ENTRY_NUM_MAX - 1);
+	for (i = 0; i < SXE_UC_ENTRY_NUM_MAX; i++) {
+		SXE_REG_WRITE(hw, SXE_RAL(i), 0);
+		SXE_REG_WRITE(hw, SXE_RAH(i), 0);
+	}
+
+	LOG_DEV_DEBUG("clear %u uta filter addr register",
+			SXE_UTA_ENTRY_NUM_MAX);
+	for (i = 0; i < SXE_UTA_ENTRY_NUM_MAX; i++)
+		SXE_REG_WRITE(hw, SXE_UTA(i), 0);
+
+	SXE_REG_WRITE(hw, SXE_MCSTCTRL, SXE_MC_FILTER_TYPE0);
+
+	LOG_DEV_DEBUG("clear %u mta filter addr register",
+			SXE_MTA_ENTRY_NUM_MAX);
+	for (i = 0; i < SXE_MTA_ENTRY_NUM_MAX; i++)
+		SXE_REG_WRITE(hw, SXE_MTA(i), 0);
+}
+
+static void sxe_hw_ethertype_filter_set(struct sxe_hw *hw,
+						u8 filter_type, u32 value)
+{
+	SXE_REG_WRITE(hw, SXE_ETQF(filter_type), value);
+}
+
+void sxe_hw_vt_ctrl_cfg(struct sxe_hw *hw, u8 default_pool)
+{
+	u32 ctrl;
+
+	ctrl = SXE_REG_READ(hw, SXE_VT_CTL);
+
+	ctrl |= SXE_VT_CTL_VT_ENABLE;
+	ctrl &= ~SXE_VT_CTL_POOL_MASK;
+	ctrl |= default_pool << SXE_VT_CTL_POOL_SHIFT;
+	ctrl |= SXE_VT_CTL_REPLEN;
+
+	SXE_REG_WRITE(hw, SXE_VT_CTL, ctrl);
+}
+
+void sxe_hw_vt_disable(struct sxe_hw *hw)
+{
+	u32 vmdctl;
+
+	vmdctl = SXE_REG_READ(hw, SXE_VT_CTL);
+	vmdctl &= ~SXE_VMD_CTL_POOL_EN;
+	SXE_REG_WRITE(hw, SXE_VT_CTL, vmdctl);
+}
+
+#ifdef SXE_WOL_CONFIGURE
+
+static void sxe_hw_wol_status_set(struct sxe_hw *hw)
+{
+	SXE_REG_WRITE(hw, SXE_WUS, ~0);
+}
+
+static void sxe_hw_wol_mode_set(struct sxe_hw *hw, u32 wol_status)
+{
+	u32 fctrl;
+
+	SXE_REG_WRITE(hw, SXE_WUC, SXE_WUC_PME_EN);
+
+	fctrl = SXE_REG_READ(hw, SXE_FCTRL);
+	fctrl |= SXE_FCTRL_BAM;
+	if (wol_status & SXE_WUFC_MC)
+		fctrl |= SXE_FCTRL_MPE;
+
+	SXE_REG_WRITE(hw, SXE_FCTRL, fctrl);
+
+	SXE_REG_WRITE(hw, SXE_WUFC, wol_status);
+	sxe_hw_wol_status_set(hw);
+}
+
+static void sxe_hw_wol_mode_clean(struct sxe_hw *hw)
+{
+	SXE_REG_WRITE(hw, SXE_WUC, 0);
+	SXE_REG_WRITE(hw, SXE_WUFC, 0);
+}
+#endif
+
+static const struct sxe_filter_mac_operations sxe_filter_mac_ops = {
+	.rx_mode_get			= sxe_hw_rx_mode_get,
+	.rx_mode_set			= sxe_hw_rx_mode_set,
+	.pool_rx_mode_get		= sxe_hw_pool_rx_mode_get,
+	.pool_rx_mode_set		= sxe_hw_pool_rx_mode_set,
+	.rx_lro_enable			= sxe_hw_rx_lro_enable,
+	.uc_addr_pool_add		= sxe_hw_uc_addr_pool_add,
+	.uc_addr_pool_del		= sxe_hw_uc_addr_pool_del,
+	.uc_addr_add			= sxe_hw_uc_addr_add,
+	.uc_addr_del			= sxe_hw_uc_addr_del,
+	.uc_addr_clear			= sxe_hw_uc_addr_clear,
+	.uta_all_set			= sxe_hw_uta_all_set,
+	.fc_mac_addr_set		= sxe_hw_fc_mac_addr_set,
+	.mta_hash_table_set		= sxe_hw_mta_hash_table_set,
+	.mta_hash_table_update		= sxe_hw_mta_hash_table_update,
+
+	.mc_filter_enable		= sxe_hw_mc_filter_enable,
+	.mc_filter_disable		= sxe_hw_mc_filter_disable,
+	.rx_nfs_filter_disable		= sxe_hw_rx_nfs_filter_disable,
+	.ethertype_filter_set		= sxe_hw_ethertype_filter_set,
+	.vt_ctrl_configure		= sxe_hw_vt_ctrl_cfg,
+	.uc_addr_pool_enable		= sxe_hw_uc_addr_pool_enable,
+	.uc_addr_pool_disable		= sxe_hw_uc_addr_pool_disable,
+	.rx_udp_frag_checksum_disable	= sxe_hw_rx_udp_frag_checksum_disable,
+
+#ifdef SXE_WOL_CONFIGURE
+	.wol_mode_set			= sxe_hw_wol_mode_set,
+	.wol_mode_clean			= sxe_hw_wol_mode_clean,
+	.wol_status_set			= sxe_hw_wol_status_set,
+#endif
+
+	.vt_disable					 = sxe_hw_vt_disable,
+};
+
+u32 sxe_hw_vlan_pool_filter_read(struct sxe_hw *hw, u16 reg_index)
+{
+	return SXE_REG_READ(hw, SXE_VLVF(reg_index));
+}
+
+static void sxe_hw_vlan_pool_filter_write(struct sxe_hw *hw,
+						u16 reg_index, u32 value)
+{
+	SXE_REG_WRITE(hw, SXE_VLVF(reg_index), value);
+}
+
+static u32 sxe_hw_vlan_pool_filter_bitmap_read(struct sxe_hw *hw,
+							u16 reg_index)
+{
+	return SXE_REG_READ(hw, SXE_VLVFB(reg_index));
+}
+
+static void sxe_hw_vlan_pool_filter_bitmap_write(struct sxe_hw *hw,
+						u16 reg_index, u32 value)
+{
+	SXE_REG_WRITE(hw, SXE_VLVFB(reg_index), value);
+}
+
+void sxe_hw_vlan_filter_array_write(struct sxe_hw *hw,
+					u16 reg_index, u32 value)
+{
+	SXE_REG_WRITE(hw, SXE_VFTA(reg_index), value);
+}
+
+u32 sxe_hw_vlan_filter_array_read(struct sxe_hw *hw, u16 reg_index)
+{
+	return SXE_REG_READ(hw, SXE_VFTA(reg_index));
+}
+
+void sxe_hw_vlan_filter_switch(struct sxe_hw *hw, bool is_enable)
+{
+	u32 vlnctrl;
+
+	vlnctrl = SXE_REG_READ(hw, SXE_VLNCTRL);
+	if (is_enable)
+		vlnctrl |= SXE_VLNCTRL_VFE;
+	else
+		vlnctrl &= ~SXE_VLNCTRL_VFE;
+
+	SXE_REG_WRITE(hw, SXE_VLNCTRL, vlnctrl);
+}
+
+static void sxe_hw_vlan_untagged_pkts_rcv_switch(struct sxe_hw *hw,
+							u32 vf, bool accept)
+{
+	u32 vmolr = SXE_REG_READ(hw, SXE_VMOLR(vf));
+	vmolr |= SXE_VMOLR_BAM;
+	if (accept)
+		vmolr |= SXE_VMOLR_AUPE;
+	else
+		vmolr &= ~SXE_VMOLR_AUPE;
+
+	LOG_WARN("vf:%u value:0x%x.", vf, vmolr);
+	SXE_REG_WRITE(hw, SXE_VMOLR(vf), vmolr);
+}
+
+s32 sxe_hw_vlvf_slot_find(struct sxe_hw *hw, u32 vlan, bool vlvf_bypass)
+{
+	s32 ret, regindex, first_empty_slot;
+	u32 bits;
+	struct sxe_adapter *adapter = hw->adapter;
+
+	if (vlan == 0) {
+		ret = 0;
+		goto l_end;
+	}
+
+	first_empty_slot = vlvf_bypass ? -SXE_ERR_NO_SPACE : 0;
+
+	vlan |= SXE_VLVF_VIEN;
+
+	for (regindex = SXE_VLVF_ENTRIES; --regindex;) {
+		bits = SXE_REG_READ(hw, SXE_VLVF(regindex));
+		if (bits == vlan) {
+			ret = regindex;
+			goto l_end;
+		}
+
+		if (!first_empty_slot && !bits)
+			first_empty_slot = regindex;
+	}
+
+	if (!first_empty_slot)
+		LOG_DEV_WARN("no space in VLVF.");
+
+	ret = first_empty_slot ? : -SXE_ERR_NO_SPACE;
+l_end:
+	return ret;
+}
+
+s32 sxe_hw_vlan_filter_configure(struct sxe_hw *hw,
+					u32 vid, u32 pool,
+					bool vlan_on, bool vlvf_bypass)
+{
+	s32 ret = 0;
+	u32 regidx, vfta_delta, vfta, bits;
+	s32 vlvf_index;
+
+	LOG_DEBUG("vid: %u, pool: %u, vlan_on: %d, vlvf_bypass: %d",
+		vid, pool, vlan_on, vlvf_bypass);
+
+	if (vid > 4095 || pool > 63) {
+		ret = -SXE_ERR_PARAM;
+		goto l_end;
+	}
+
+
+	regidx = vid / 32;
+	vfta_delta = BIT(vid % 32);
+	vfta = SXE_REG_READ(hw, SXE_VFTA(regidx));
+
+	vfta_delta &= vlan_on ? ~vfta : vfta;
+	vfta ^= vfta_delta;
+
+	if (!(SXE_REG_READ(hw, SXE_VT_CTL) & SXE_VT_CTL_VT_ENABLE))
+		goto vfta_update;
+
+	vlvf_index = sxe_hw_vlvf_slot_find(hw, vid, vlvf_bypass);
+	if (vlvf_index < 0) {
+		if (vlvf_bypass)
+			goto vfta_update;
+
+		ret = vlvf_index;
+		goto l_end;
+	}
+
+	bits = SXE_REG_READ(hw, SXE_VLVFB(vlvf_index * 2 + pool / 32));
+
+	bits |= BIT(pool % 32);
+	if (vlan_on)
+		goto vlvf_update;
+
+	bits ^= BIT(pool % 32);
+
+	if (!bits &&
+		!SXE_REG_READ(hw, SXE_VLVFB(vlvf_index * 2 + 1 - pool / 32))) {
+		if (vfta_delta)
+			SXE_REG_WRITE(hw, SXE_VFTA(regidx), vfta);
+
+		SXE_REG_WRITE(hw, SXE_VLVF(vlvf_index), 0);
+		SXE_REG_WRITE(hw, SXE_VLVFB(vlvf_index * 2 + pool / 32), 0);
+
+		goto l_end;
+	}
+
+	vfta_delta = 0;
+
+vlvf_update:
+	SXE_REG_WRITE(hw, SXE_VLVFB(vlvf_index * 2 + pool / 32), bits);
+	SXE_REG_WRITE(hw, SXE_VLVF(vlvf_index), SXE_VLVF_VIEN | vid);
+
+vfta_update:
+	if (vfta_delta)
+		SXE_REG_WRITE(hw, SXE_VFTA(regidx), vfta);
+
+l_end:
+	return ret;
+}
+
+void sxe_hw_vlan_filter_array_clear(struct sxe_hw *hw)
+{
+	u32 offset;
+
+	for (offset = 0; offset < SXE_VFT_TBL_SIZE; offset++)
+		SXE_REG_WRITE(hw, SXE_VFTA(offset), 0);
+
+	for (offset = 0; offset < SXE_VLVF_ENTRIES; offset++) {
+		SXE_REG_WRITE(hw, SXE_VLVF(offset), 0);
+		SXE_REG_WRITE(hw, SXE_VLVFB(offset * 2), 0);
+		SXE_REG_WRITE(hw, SXE_VLVFB(offset * 2 + 1), 0);
+	}
+}
+
+static const struct sxe_filter_vlan_operations sxe_filter_vlan_ops = {
+	.pool_filter_read		= sxe_hw_vlan_pool_filter_read,
+	.pool_filter_write		= sxe_hw_vlan_pool_filter_write,
+	.pool_filter_bitmap_read	= sxe_hw_vlan_pool_filter_bitmap_read,
+	.pool_filter_bitmap_write	= sxe_hw_vlan_pool_filter_bitmap_write,
+	.filter_array_write		= sxe_hw_vlan_filter_array_write,
+	.filter_array_read		= sxe_hw_vlan_filter_array_read,
+	.filter_array_clear		= sxe_hw_vlan_filter_array_clear,
+	.filter_switch			= sxe_hw_vlan_filter_switch,
+	.untagged_pkts_rcv_switch	= sxe_hw_vlan_untagged_pkts_rcv_switch,
+	.filter_configure		= sxe_hw_vlan_filter_configure,
+};
+
+
+static void sxe_hw_rx_pkt_buf_switch(struct sxe_hw *hw, bool is_on)
+{
+	u32 dbucfg = SXE_REG_READ(hw, SXE_DRXCFG);
+
+	if (is_on)
+		dbucfg |= SXE_DRXCFG_DBURX_START;
+	else
+		dbucfg &= ~SXE_DRXCFG_DBURX_START;
+
+	SXE_REG_WRITE(hw, SXE_DRXCFG, dbucfg);
+}
+
+static void sxe_hw_rx_pkt_buf_size_configure(struct sxe_hw *hw,
+				 u8 num_pb,
+				 u32 headroom,
+				 u16 strategy)
+{
+	u16 total_buf_size = (SXE_RX_PKT_BUF_SIZE - headroom);
+	u32 rx_buf_size;
+	u16 i = 0;
+
+	if (!num_pb)
+		num_pb = 1;
+
+	switch (strategy) {
+	case (PBA_STRATEGY_WEIGHTED):
+		rx_buf_size = ((total_buf_size * 5 * 2) / (num_pb * 8));
+		total_buf_size -= rx_buf_size * (num_pb / 2);
+		rx_buf_size <<= SXE_RX_PKT_BUF_SIZE_SHIFT;
+		for (i = 0; i < (num_pb / 2); i++)
+			SXE_REG_WRITE(hw, SXE_RXPBSIZE(i), rx_buf_size);
+
+		fallthrough;
+	case (PBA_STRATEGY_EQUAL):
+		rx_buf_size = (total_buf_size / (num_pb - i))
+				<< SXE_RX_PKT_BUF_SIZE_SHIFT;
+		for (; i < num_pb; i++)
+			SXE_REG_WRITE(hw, SXE_RXPBSIZE(i), rx_buf_size);
+
+		break;
+
+	default:
+		break;
+	}
+
+	for (; i < SXE_PKG_BUF_NUM_MAX; i++)
+		SXE_REG_WRITE(hw, SXE_RXPBSIZE(i), 0);
+}
+
+u32 sxe_hw_rx_pkt_buf_size_get(struct sxe_hw *hw, u8 pb)
+{
+	return SXE_REG_READ(hw, SXE_RXPBSIZE(pb));
+}
+
+void sxe_hw_rx_multi_ring_configure(struct sxe_hw *hw,
+						u8 tcs, bool is_4q_per_pool,
+						bool sriov_enable)
+{
+	u32 mrqc = SXE_REG_READ(hw, SXE_MRQC);
+
+	mrqc &= ~SXE_MRQE_MASK;
+
+	if (sriov_enable) {
+		if (tcs > 4)
+			mrqc |= SXE_MRQC_VMDQRT8TCEN;
+		else if (tcs > 1)
+			mrqc |= SXE_MRQC_VMDQRT4TCEN;
+		else if (is_4q_per_pool)
+			mrqc |= SXE_MRQC_VMDQRSS32EN;
+		else
+			mrqc |= SXE_MRQC_VMDQRSS64EN;
+
+	} else {
+		if (tcs > 4)
+			mrqc |= SXE_MRQC_RTRSS8TCEN;
+		else if (tcs > 1)
+			mrqc |= SXE_MRQC_RTRSS4TCEN;
+		else
+			mrqc |= SXE_MRQC_RSSEN;
+	}
+
+	SXE_REG_WRITE(hw, SXE_MRQC, mrqc);
+}
+
+static void sxe_hw_rss_hash_pkt_type_set(struct sxe_hw *hw, u32 version)
+{
+	u32 mrqc = 0;
+	u32 rss_field = 0;
+
+	rss_field |= SXE_MRQC_RSS_FIELD_IPV4 |
+			 SXE_MRQC_RSS_FIELD_IPV4_TCP |
+			 SXE_MRQC_RSS_FIELD_IPV6 |
+			 SXE_MRQC_RSS_FIELD_IPV6_TCP;
+
+	if (version == SXE_RSS_IP_VER_4)
+		rss_field |= SXE_MRQC_RSS_FIELD_IPV4_UDP;
+
+	if (version == SXE_RSS_IP_VER_6)
+		rss_field |= SXE_MRQC_RSS_FIELD_IPV6_UDP;
+
+	mrqc |= rss_field;
+	SXE_REG_WRITE(hw, SXE_MRQC, mrqc);
+}
+
+static void sxe_hw_rss_hash_pkt_type_update(struct sxe_hw *hw,
+							u32 version)
+{
+	u32 mrqc;
+
+	mrqc = SXE_REG_READ(hw, SXE_MRQC);
+
+	mrqc |= SXE_MRQC_RSS_FIELD_IPV4
+		  | SXE_MRQC_RSS_FIELD_IPV4_TCP
+		  | SXE_MRQC_RSS_FIELD_IPV6
+		  | SXE_MRQC_RSS_FIELD_IPV6_TCP;
+
+	mrqc &= ~(SXE_MRQC_RSS_FIELD_IPV4_UDP |
+		  SXE_MRQC_RSS_FIELD_IPV6_UDP);
+
+	if (version == SXE_RSS_IP_VER_4)
+		mrqc |= SXE_MRQC_RSS_FIELD_IPV4_UDP;
+
+	if (version == SXE_RSS_IP_VER_6)
+		mrqc |= SXE_MRQC_RSS_FIELD_IPV6_UDP;
+
+	SXE_REG_WRITE(hw, SXE_MRQC, mrqc);
+}
+
+static void sxe_hw_rss_rings_used_set(struct sxe_hw *hw, u32 rss_num,
+						u16 pool, u16 pf_offset)
+{
+	u32 psrtype = 0;
+
+	if (rss_num > 3)
+		psrtype |= 2u << 29;
+	else if (rss_num > 1)
+		psrtype |= 1u << 29;
+
+	while (pool--)
+		SXE_REG_WRITE(hw, SXE_PSRTYPE(pf_offset + pool), psrtype);
+}
+
+void sxe_hw_rss_key_set_all(struct sxe_hw *hw, u32 *rss_key)
+{
+	u32 i;
+
+	for (i = 0; i < SXE_MAX_RSS_KEY_ENTRIES; i++)
+		SXE_REG_WRITE(hw, SXE_RSSRK(i), rss_key[i]);
+}
+
+void sxe_hw_rss_redir_tbl_reg_write(struct sxe_hw *hw,
+						u16 reg_idx, u32 value)
+{
+	SXE_REG_WRITE(hw, SXE_RETA(reg_idx >> 2), value);
+}
+
+void sxe_hw_rss_redir_tbl_set_all(struct sxe_hw *hw, u8 *redir_tbl)
+{
+	u32 i;
+	u32 tbl = 0;
+	u32 indices_multi = 0x1;
+
+
+	for (i = 0; i < SXE_MAX_RETA_ENTRIES; i++) {
+		tbl |= indices_multi * redir_tbl[i] << (i & 0x3) * 8;
+		if ((i & 3) == 3) {
+			sxe_hw_rss_redir_tbl_reg_write(hw, i, tbl);
+			tbl = 0;
+		}
+	}
+}
+
+void sxe_hw_rx_cap_switch_on(struct sxe_hw *hw)
+{
+	u32 rxctrl;
+
+	if (hw->mac.set_lben) {
+		u32 pfdtxgswc = SXE_REG_READ(hw, SXE_PFDTXGSWC);
+		pfdtxgswc |= SXE_PFDTXGSWC_VT_LBEN;
+		SXE_REG_WRITE(hw, SXE_PFDTXGSWC, pfdtxgswc);
+		hw->mac.set_lben = false;
+	}
+
+	rxctrl = SXE_REG_READ(hw, SXE_RXCTRL);
+	rxctrl |= SXE_RXCTRL_RXEN;
+	SXE_REG_WRITE(hw, SXE_RXCTRL, rxctrl);
+}
+
+void sxe_hw_rx_cap_switch_off(struct sxe_hw *hw)
+{
+	u32 rxctrl;
+
+	rxctrl = SXE_REG_READ(hw, SXE_RXCTRL);
+	if (rxctrl & SXE_RXCTRL_RXEN) {
+		u32 pfdtxgswc = SXE_REG_READ(hw, SXE_PFDTXGSWC);
+		if (pfdtxgswc & SXE_PFDTXGSWC_VT_LBEN) {
+			pfdtxgswc &= ~SXE_PFDTXGSWC_VT_LBEN;
+			SXE_REG_WRITE(hw, SXE_PFDTXGSWC, pfdtxgswc);
+			hw->mac.set_lben = true;
+		} else {
+			hw->mac.set_lben = false;
+		}
+		rxctrl &= ~SXE_RXCTRL_RXEN;
+		SXE_REG_WRITE(hw, SXE_RXCTRL, rxctrl);
+	}
+}
+
+static void sxe_hw_rx_func_switch_on(struct sxe_hw *hw)
+{
+	u32 rxctrl;
+
+	rxctrl = SXE_REG_READ(hw, SXE_COMCTRL);
+	rxctrl |= SXE_COMCTRL_RXEN | SXE_COMCTRL_EDSEL;
+	SXE_REG_WRITE(hw, SXE_COMCTRL, rxctrl);
+}
+
+void sxe_hw_tx_pkt_buf_switch(struct sxe_hw *hw, bool is_on)
+{
+	u32 dbucfg;
+
+	dbucfg = SXE_REG_READ(hw, SXE_DTXCFG);
+
+	if (is_on) {
+		dbucfg |= SXE_DTXCFG_DBUTX_START;
+		dbucfg |= SXE_DTXCFG_DBUTX_BUF_ALFUL_CFG;
+		SXE_REG_WRITE(hw, SXE_DTXCFG, dbucfg);
+	} else {
+		dbucfg &= ~SXE_DTXCFG_DBUTX_START;
+		SXE_REG_WRITE(hw, SXE_DTXCFG, dbucfg);
+	}
+}
+
+void sxe_hw_tx_pkt_buf_size_configure(struct sxe_hw *hw, u8 num_pb)
+{
+	u32 i, tx_pkt_size;
+
+	if (!num_pb)
+		num_pb = 1;
+
+	tx_pkt_size = SXE_TX_PBSIZE_MAX / num_pb;
+	for (i = 0; i < num_pb; i++)
+		SXE_REG_WRITE(hw, SXE_TXPBSIZE(i), tx_pkt_size);
+
+	for (; i < SXE_PKG_BUF_NUM_MAX; i++)
+		SXE_REG_WRITE(hw, SXE_TXPBSIZE(i), 0);
+}
+
+void sxe_hw_rx_lro_ack_switch(struct sxe_hw *hw, bool is_on)
+{
+	u32 lro_dbu = SXE_REG_READ(hw, SXE_LRODBU);
+
+	if (is_on)
+		lro_dbu &= ~SXE_LRODBU_LROACKDIS;
+	else
+		lro_dbu |= SXE_LRODBU_LROACKDIS;
+
+	SXE_REG_WRITE(hw, SXE_LRODBU, lro_dbu);
+}
+
+static void sxe_hw_vf_rx_switch(struct sxe_hw *hw,
+				u32 reg_offset, u32 vf_index, bool is_off)
+{
+	u32 vfre = SXE_REG_READ(hw, SXE_VFRE(reg_offset));
+	if (is_off)
+		vfre &= ~BIT(vf_index);
+	else
+		vfre |= BIT(vf_index);
+
+	SXE_REG_WRITE(hw, SXE_VFRE(reg_offset), vfre);
+}
+
+static s32 sxe_hw_fnav_wait_init_done(struct sxe_hw *hw)
+{
+	u32 i;
+	s32 ret = 0;
+	struct sxe_adapter *adapter = hw->adapter;
+	for (i = 0; i < SXE_FNAV_INIT_DONE_POLL; i++) {
+		if (SXE_REG_READ(hw, SXE_FNAVCTRL) &
+				   SXE_FNAVCTRL_INIT_DONE) {
+			break;
+		}
+
+		usleep_range(1000, 2000);
+	}
+
+	if (i >= SXE_FNAV_INIT_DONE_POLL) {
+		LOG_DEV_DEBUG("flow navigator poll time exceeded!");
+		ret = -SXE_ERR_FNAV_REINIT_FAILED;
+	}
+
+	return ret;
+}
+
+void sxe_hw_fnav_enable(struct sxe_hw *hw, u32 fnavctrl)
+{
+	u32 fnavctrl_ori;
+	bool is_clear_stat = false;
+
+	SXE_REG_WRITE(hw, SXE_FNAVHKEY, SXE_FNAV_BUCKET_HASH_KEY);
+	SXE_REG_WRITE(hw, SXE_FNAVSKEY, SXE_FNAV_SAMPLE_HASH_KEY);
+
+	fnavctrl_ori = SXE_REG_READ(hw, SXE_FNAVCTRL);
+	if ((fnavctrl_ori & 0x13) != (fnavctrl & 0x13))
+		is_clear_stat = true;
+
+	SXE_REG_WRITE(hw, SXE_FNAVCTRL, fnavctrl);
+	SXE_WRITE_FLUSH(hw);
+
+	sxe_hw_fnav_wait_init_done(hw);
+
+	if (is_clear_stat) {
+		SXE_REG_READ(hw, SXE_FNAVUSTAT);
+		SXE_REG_READ(hw, SXE_FNAVFSTAT);
+		SXE_REG_READ(hw, SXE_FNAVMATCH);
+		SXE_REG_READ(hw, SXE_FNAVMISS);
+		SXE_REG_READ(hw, SXE_FNAVLEN);
+	}
+}
+
+static s32 sxe_hw_fnav_mode_init(struct sxe_hw *hw,
+					u32 fnavctrl, u32 sxe_fnav_mode)
+{
+	struct sxe_adapter *adapter = hw->adapter;
+
+	LOG_DEBUG_BDF("fnavctrl=0x%x, sxe_fnav_mode=%u", fnavctrl, sxe_fnav_mode);
+
+	if (sxe_fnav_mode != SXE_FNAV_SAMPLE_MODE &&
+		sxe_fnav_mode != SXE_FNAV_SPECIFIC_MODE) {
+		LOG_ERROR_BDF("mode[%u] a error fnav mode, fnav do not work. please"
+			" use SXE_FNAV_SAMPLE_MODE or SXE_FNAV_SPECIFIC_MODE",
+			sxe_fnav_mode);
+		goto l_end;
+	}
+
+	if (sxe_fnav_mode == SXE_FNAV_SPECIFIC_MODE) {
+		fnavctrl |= SXE_FNAVCTRL_SPECIFIC_MATCH |
+			 (SXE_FNAV_DROP_QUEUE << SXE_FNAVCTRL_DROP_Q_SHIFT);
+	}
+
+	fnavctrl |= (0x6 << SXE_FNAVCTRL_FLEX_SHIFT) |
+			(0xA << SXE_FNAVCTRL_MAX_LENGTH_SHIFT) |
+			(4 << SXE_FNAVCTRL_FULL_THRESH_SHIFT);
+
+	sxe_hw_fnav_enable(hw, fnavctrl);
+
+l_end:
+	return 0;
+}
+
+u32 sxe_hw_fnav_port_mask_get(__be16 src_port_mask, __be16 dst_port_mask)
+{
+	u32 mask = ntohs(dst_port_mask);
+
+	mask <<= SXE_FNAVTCPM_DPORTM_SHIFT;
+	mask |= ntohs(src_port_mask);
+	mask = ((mask & 0x55555555) << 1) | ((mask & 0xAAAAAAAA) >> 1);
+	mask = ((mask & 0x33333333) << 2) | ((mask & 0xCCCCCCCC) >> 2);
+	mask = ((mask & 0x0F0F0F0F) << 4) | ((mask & 0xF0F0F0F0) >> 4);
+	return ((mask & 0x00FF00FF) << 8) | ((mask & 0xFF00FF00) >> 8);
+}
+
+static s32 sxe_hw_fnav_vm_pool_mask_get(struct sxe_hw *hw,
+					u8 vm_pool, u32 *fnavm)
+{
+	s32 ret = 0;
+	struct sxe_adapter *adapter = hw->adapter;
+
+	switch (vm_pool & SXE_SAMPLE_VM_POOL_MASK) {
+	case 0x0:
+		*fnavm |= SXE_FNAVM_POOL;
+		/* fallthrough */;
+	case 0x7F:
+		break;
+	default:
+		LOG_DEV_ERR("error on vm pool mask");
+		ret = -SXE_ERR_CONFIG;
+	}
+
+	return ret;
+}
+
+static s32 sxe_hw_fnav_flow_type_mask_get(struct sxe_hw *hw,
+					union sxe_fnav_rule_info *input_mask,
+					u32 *fnavm)
+{
+	s32 ret = 0;
+	struct sxe_adapter *adapter = hw->adapter;
+
+	switch (input_mask->ntuple.flow_type & SXE_SAMPLE_L4TYPE_MASK) {
+	case 0x0:
+		*fnavm |= SXE_FNAVM_L4P;
+		if (input_mask->ntuple.dst_port ||
+			input_mask->ntuple.src_port) {
+			LOG_DEV_ERR("error on src/dst port mask");
+			ret = -SXE_ERR_CONFIG;
+			goto l_ret;
+		}
+		break;
+	case SXE_SAMPLE_L4TYPE_MASK:
+		break;
+	default:
+		LOG_DEV_ERR("error on flow type mask");
+		ret = -SXE_ERR_CONFIG;
+	}
+
+l_ret:
+	return ret;
+}
+
+static s32 sxe_hw_fnav_vlan_mask_get(struct sxe_hw *hw,
+					__be16 vlan_id, u32 *fnavm)
+{
+	s32 ret = 0;
+	struct sxe_adapter *adapter = hw->adapter;
+
+	switch (ntohs(vlan_id) & SXE_SAMPLE_VLAN_MASK) {
+	case 0x0000:
+		*fnavm |= SXE_FNAVM_VLANID;
+		fallthrough;
+	case 0x0FFF:
+		*fnavm |= SXE_FNAVM_VLANP;
+		break;
+	case 0xE000:
+		*fnavm |= SXE_FNAVM_VLANID;
+		fallthrough;
+	case 0xEFFF:
+		break;
+	default:
+		LOG_DEV_ERR("error on VLAN mask");
+		ret = -SXE_ERR_CONFIG;
+	}
+
+	return ret;
+}
+
+static s32 sxe_hw_fnav_flex_bytes_mask_get(struct sxe_hw *hw,
+					__be16 flex_bytes, u32 *fnavm)
+{
+	s32 ret = 0;
+	struct sxe_adapter *adapter = hw->adapter;
+
+	switch ((__force u16)flex_bytes & SXE_SAMPLE_FLEX_BYTES_MASK) {
+	case 0x0000:
+		*fnavm |= SXE_FNAVM_FLEX;
+		fallthrough;
+	case 0xFFFF:
+		break;
+	default:
+		LOG_DEV_ERR("error on flexible byte mask");
+		ret = -SXE_ERR_CONFIG;
+	}
+
+	return ret;
+}
+
+s32 sxe_hw_fnav_specific_rule_mask_set(struct sxe_hw *hw,
+					union sxe_fnav_rule_info *input_mask)
+{
+	s32 ret;
+	u32 fnavm = SXE_FNAVM_DIPV6;
+	u32 fnavtcpm;
+	struct sxe_adapter *adapter = hw->adapter;
+
+
+	if (input_mask->ntuple.bkt_hash)
+		LOG_DEV_ERR("bucket hash should always be 0 in mask");
+
+	ret = sxe_hw_fnav_vm_pool_mask_get(hw, input_mask->ntuple.vm_pool, &fnavm);
+	if (ret)
+		goto l_err_config;
+
+	ret = sxe_hw_fnav_flow_type_mask_get(hw, input_mask,  &fnavm);
+	if (ret)
+		goto l_err_config;
+
+	ret = sxe_hw_fnav_vlan_mask_get(hw, input_mask->ntuple.vlan_id, &fnavm);
+	if (ret)
+		goto l_err_config;
+
+	ret = sxe_hw_fnav_flex_bytes_mask_get(hw, input_mask->ntuple.flex_bytes, &fnavm);
+	if (ret)
+		goto l_err_config;
+
+	LOG_DEBUG_BDF("fnavm = 0x%x", fnavm);
+	SXE_REG_WRITE(hw, SXE_FNAVM, fnavm);
+
+	fnavtcpm = sxe_hw_fnav_port_mask_get(input_mask->ntuple.src_port,
+						 input_mask->ntuple.dst_port);
+
+	LOG_DEBUG_BDF("fnavtcpm = 0x%x", fnavtcpm);
+	SXE_REG_WRITE(hw, SXE_FNAVTCPM, ~fnavtcpm);
+	SXE_REG_WRITE(hw, SXE_FNAVUDPM, ~fnavtcpm);
+
+	SXE_REG_WRITE_BE32(hw, SXE_FNAVSIP4M,
+				 ~input_mask->ntuple.src_ip[0]);
+	SXE_REG_WRITE_BE32(hw, SXE_FNAVDIP4M,
+				 ~input_mask->ntuple.dst_ip[0]);
+
+	return 0;
+
+l_err_config:
+	return -SXE_ERR_CONFIG;
+}
+
+static s32 sxe_hw_fnav_cmd_complete_check(struct sxe_hw *hw,
+							u32 *fnavcmd)
+{
+	u32 i;
+
+	for (i = 0; i < SXE_FNAVCMD_CMD_POLL * 10; i++) {
+		*fnavcmd = SXE_REG_READ(hw, SXE_FNAVCMD);
+		if (!(*fnavcmd & SXE_FNAVCMD_CMD_MASK))
+			return 0;
+
+		sxe_udelay(10);
+	}
+
+	return -SXE_ERR_FNAV_CMD_INCOMPLETE;
+}
+
+static void sxe_hw_fnav_filter_ip_set(struct sxe_hw *hw,
+					union sxe_fnav_rule_info *input)
+{
+	SXE_REG_WRITE_BE32(hw, SXE_FNAVSIPV6(0),
+				 input->ntuple.src_ip[0]);
+	SXE_REG_WRITE_BE32(hw, SXE_FNAVSIPV6(1),
+				 input->ntuple.src_ip[1]);
+	SXE_REG_WRITE_BE32(hw, SXE_FNAVSIPV6(2),
+				 input->ntuple.src_ip[2]);
+
+	SXE_REG_WRITE_BE32(hw, SXE_FNAVIPSA, input->ntuple.src_ip[0]);
+
+	SXE_REG_WRITE_BE32(hw, SXE_FNAVIPDA, input->ntuple.dst_ip[0]);
+}
+
+static void sxe_hw_fnav_filter_port_set(struct sxe_hw *hw,
+					union sxe_fnav_rule_info *input)
+{
+	u32 fnavport;
+
+	fnavport = be16_to_cpu(input->ntuple.dst_port);
+	fnavport <<= SXE_FNAVPORT_DESTINATION_SHIFT;
+	fnavport |= be16_to_cpu(input->ntuple.src_port);
+	SXE_REG_WRITE(hw, SXE_FNAVPORT, fnavport);
+}
+
+static void sxe_hw_fnav_filter_vlan_set(struct sxe_hw *hw,
+					union sxe_fnav_rule_info *input)
+{
+	u32 fnavvlan;
+
+	fnavvlan = ntohs(SXE_SWAP_16(input->ntuple.flex_bytes));
+	fnavvlan <<= SXE_FNAVVLAN_FLEX_SHIFT;
+	fnavvlan |= ntohs(input->ntuple.vlan_id);
+	SXE_REG_WRITE(hw, SXE_FNAVVLAN, fnavvlan);
+}
+
+static void sxe_hw_fnav_filter_bkt_hash_set(struct sxe_hw *hw,
+					union sxe_fnav_rule_info *input,
+					u16 soft_id)
+{
+	u32 fnavhash;
+
+	fnavhash = (__force u32)input->ntuple.bkt_hash;
+	fnavhash |= soft_id << SXE_FNAVHASH_SIG_SW_INDEX_SHIFT;
+	SXE_REG_WRITE(hw, SXE_FNAVHASH, fnavhash);
+}
+
+static s32 sxe_hw_fnav_filter_cmd_set(struct sxe_hw *hw,
+					union sxe_fnav_rule_info *input,
+					u8 queue)
+{
+	u32 fnavcmd;
+	s32 ret;
+	struct sxe_adapter *adapter = hw->adapter;
+
+	fnavcmd = SXE_FNAVCMD_CMD_ADD_FLOW | SXE_FNAVCMD_FILTER_UPDATE |
+		  SXE_FNAVCMD_LAST | SXE_FNAVCMD_QUEUE_EN;
+
+#ifndef SXE_DPDK
+	if (queue == SXE_FNAV_DROP_QUEUE)
+		fnavcmd |= SXE_FNAVCMD_DROP;
+#endif
+
+	fnavcmd |= input->ntuple.flow_type << SXE_FNAVCMD_FLOW_TYPE_SHIFT;
+	fnavcmd |= (u32)queue << SXE_FNAVCMD_RX_QUEUE_SHIFT;
+	fnavcmd |= (u32)input->ntuple.vm_pool << SXE_FNAVCMD_VT_POOL_SHIFT;
+
+	SXE_REG_WRITE(hw, SXE_FNAVCMD, fnavcmd);
+	ret = sxe_hw_fnav_cmd_complete_check(hw, &fnavcmd);
+	if (ret)
+		LOG_DEV_ERR("flow navigator command did not complete!");
+
+	return ret;
+}
+
+s32 sxe_hw_fnav_specific_rule_add(struct sxe_hw *hw,
+					  union sxe_fnav_rule_info *input,
+					  u16 soft_id, u8 queue)
+{
+	s32 ret;
+	struct sxe_adapter *adapter = hw->adapter;
+
+	sxe_hw_fnav_filter_ip_set(hw, input);
+
+	sxe_hw_fnav_filter_port_set(hw, input);
+
+	sxe_hw_fnav_filter_vlan_set(hw, input);
+
+	sxe_hw_fnav_filter_bkt_hash_set(hw, input, soft_id);
+
+	SXE_WRITE_FLUSH(hw);
+
+	ret = sxe_hw_fnav_filter_cmd_set(hw, input, queue);
+	if (ret)
+		LOG_ERROR_BDF("set fnav filter cmd error. ret=%d", ret);
+
+	return ret;
+}
+
+s32 sxe_hw_fnav_specific_rule_del(struct sxe_hw *hw,
+					  union sxe_fnav_rule_info *input,
+					  u16 soft_id)
+{
+	u32 fnavhash;
+	u32 fnavcmd;
+	s32 ret;
+	struct sxe_adapter *adapter = hw->adapter;
+
+
+	fnavhash = (__force u32)input->ntuple.bkt_hash;
+	fnavhash |= soft_id << SXE_FNAVHASH_SIG_SW_INDEX_SHIFT;
+	SXE_REG_WRITE(hw, SXE_FNAVHASH, fnavhash);
+
+	SXE_WRITE_FLUSH(hw);
+
+	SXE_REG_WRITE(hw, SXE_FNAVCMD, SXE_FNAVCMD_CMD_QUERY_REM_FILT);
+
+	ret = sxe_hw_fnav_cmd_complete_check(hw, &fnavcmd);
+	if (ret) {
+		LOG_DEV_ERR("flow navigator command did not complete!");
+		return ret;
+	}
+
+	if (fnavcmd & SXE_FNAVCMD_FILTER_VALID) {
+		SXE_REG_WRITE(hw, SXE_FNAVHASH, fnavhash);
+		SXE_WRITE_FLUSH(hw);
+		SXE_REG_WRITE(hw, SXE_FNAVCMD,
+				SXE_FNAVCMD_CMD_REMOVE_FLOW);
+	}
+
+	return 0;
+}
+
+void sxe_hw_fnav_sample_rule_configure(struct sxe_hw *hw,
+					  u8 flow_type, u32 hash_value, u8 queue)
+{
+	u32 fnavcmd;
+	u64 fnavhashcmd;
+	struct sxe_adapter *adapter = hw->adapter;
+
+	fnavcmd = SXE_FNAVCMD_CMD_ADD_FLOW | SXE_FNAVCMD_FILTER_UPDATE |
+		  SXE_FNAVCMD_LAST | SXE_FNAVCMD_QUEUE_EN;
+	fnavcmd |= (u32)flow_type << SXE_FNAVCMD_FLOW_TYPE_SHIFT;
+	fnavcmd |= (u32)queue << SXE_FNAVCMD_RX_QUEUE_SHIFT;
+
+	fnavhashcmd = (u64)fnavcmd << 32;
+	fnavhashcmd |= hash_value;
+	SXE_REG64_WRITE(hw, SXE_FNAVHASH, fnavhashcmd);
+
+	LOG_DEV_DEBUG("tx queue=%x hash=%x", queue, (u32)fnavhashcmd);
+}
+
+static u64 sxe_hw_fnav_sample_rule_hash_get(struct sxe_hw *hw,
+					  u8 flow_type, u32 hash_value, u8 queue)
+{
+	u32 fnavcmd;
+	u64 fnavhashcmd;
+	struct sxe_adapter *adapter = hw->adapter;
+
+	fnavcmd = SXE_FNAVCMD_CMD_ADD_FLOW | SXE_FNAVCMD_FILTER_UPDATE |
+		  SXE_FNAVCMD_LAST | SXE_FNAVCMD_QUEUE_EN;
+	fnavcmd |= (u32)flow_type << SXE_FNAVCMD_FLOW_TYPE_SHIFT;
+	fnavcmd |= (u32)queue << SXE_FNAVCMD_RX_QUEUE_SHIFT;
+
+	fnavhashcmd = (u64)fnavcmd << 32;
+	fnavhashcmd |= hash_value;
+
+	LOG_DEV_DEBUG("tx queue=%x hash=%x", queue, (u32)fnavhashcmd);
+
+	return fnavhashcmd;
+}
+
+static s32 sxe_hw_fnav_sample_hash_cmd_get(struct sxe_hw *hw,
+					  u8  flow_type,
+					  u32 hash_value,
+					  u8  queue, u64 *hash_cmd)
+{
+	s32 ret = 0;
+	u8 pkg_type;
+	struct sxe_adapter *adapter = hw->adapter;
+
+	pkg_type = flow_type & SXE_SAMPLE_FLOW_TYPE_MASK;
+	switch (pkg_type) {
+	case SXE_SAMPLE_FLOW_TYPE_TCPV4:
+	case SXE_SAMPLE_FLOW_TYPE_UDPV4:
+	case SXE_SAMPLE_FLOW_TYPE_SCTPV4:
+	case SXE_SAMPLE_FLOW_TYPE_TCPV6:
+	case SXE_SAMPLE_FLOW_TYPE_UDPV6:
+	case SXE_SAMPLE_FLOW_TYPE_SCTPV6:
+		break;
+	default:
+		LOG_DEV_ERR("error on flow type input");
+		ret = -SXE_ERR_CONFIG;
+		goto l_end;
+	}
+
+	*hash_cmd = sxe_hw_fnav_sample_rule_hash_get(hw, pkg_type, hash_value, queue);
+
+l_end:
+	return ret;
+}
+
+static s32 sxe_hw_fnav_single_sample_rule_del(struct sxe_hw *hw,
+						u32 hash)
+{
+	u32 fdircmd;
+	s32 ret;
+	struct sxe_adapter *adapter = hw->adapter;
+
+	SXE_REG_WRITE(hw, SXE_FNAVHASH, hash);
+	SXE_WRITE_FLUSH(hw);
+
+	SXE_REG_WRITE(hw, SXE_FNAVCMD, SXE_FNAVCMD_CMD_REMOVE_FLOW);
+	ret = sxe_hw_fnav_cmd_complete_check(hw, &fdircmd);
+	if (ret) {
+		LOG_DEV_ERR("flow navigator previous command did not complete,"
+			"aborting table re-initialization.");
+	}
+
+	return ret;
+}
+
+s32 sxe_hw_fnav_sample_rules_table_reinit(struct sxe_hw *hw)
+{
+	u32 fnavctrl = SXE_REG_READ(hw, SXE_FNAVCTRL);
+	u32 fnavcmd;
+	s32 ret;
+	struct sxe_adapter *adapter = hw->adapter;
+
+	fnavctrl &= ~SXE_FNAVCTRL_INIT_DONE;
+
+	ret = sxe_hw_fnav_cmd_complete_check(hw, &fnavcmd);
+	if (ret) {
+		LOG_DEV_ERR("flow navigator previous command did not complete,"
+			"aborting table re-initialization.");
+		goto l_ret;
+	}
+
+	SXE_REG_WRITE(hw, SXE_FNAVFREE, 0);
+	SXE_WRITE_FLUSH(hw);
+
+	SXE_REG_WRITE(hw, SXE_FNAVCMD,
+			(SXE_REG_READ(hw, SXE_FNAVCMD) |
+			 SXE_FNAVCMD_CLEARHT));
+	SXE_WRITE_FLUSH(hw);
+	SXE_REG_WRITE(hw, SXE_FNAVCMD,
+			(SXE_REG_READ(hw, SXE_FNAVCMD) &
+			 ~SXE_FNAVCMD_CLEARHT));
+	SXE_WRITE_FLUSH(hw);
+
+	SXE_REG_WRITE(hw, SXE_FNAVHASH, 0x00);
+	SXE_WRITE_FLUSH(hw);
+
+	SXE_REG_WRITE(hw, SXE_FNAVCTRL, fnavctrl);
+	SXE_WRITE_FLUSH(hw);
+
+	ret = sxe_hw_fnav_wait_init_done(hw);
+	if (ret) {
+		LOG_ERROR_BDF("flow navigator simple poll time exceeded!");
+		goto l_ret;
+	}
+
+	SXE_REG_READ(hw, SXE_FNAVUSTAT);
+	SXE_REG_READ(hw, SXE_FNAVFSTAT);
+	SXE_REG_READ(hw, SXE_FNAVMATCH);
+	SXE_REG_READ(hw, SXE_FNAVMISS);
+	SXE_REG_READ(hw, SXE_FNAVLEN);
+
+l_ret:
+	return ret;
+}
+
+static void sxe_hw_fnav_sample_stats_reinit(struct sxe_hw *hw)
+{
+	SXE_REG_READ(hw, SXE_FNAVUSTAT);
+	SXE_REG_READ(hw, SXE_FNAVFSTAT);
+	SXE_REG_READ(hw, SXE_FNAVMATCH);
+	SXE_REG_READ(hw, SXE_FNAVMISS);
+	SXE_REG_READ(hw, SXE_FNAVLEN);
+}
+
+static void sxe_hw_ptp_freq_adjust(struct sxe_hw *hw, u32 adj_freq)
+{
+	SXE_REG_WRITE(hw, SXE_TIMADJL, 0);
+	SXE_REG_WRITE(hw, SXE_TIMADJH, adj_freq);
+	SXE_WRITE_FLUSH(hw);
+}
+
+u64 sxe_hw_ptp_systime_get(struct sxe_hw *hw)
+{
+	struct sxe_adapter *adapter = hw->adapter;
+	u32 systiml;
+	u32 systimm;
+	u64 ns;
+
+	systiml = SXE_REG_READ(hw, SXE_SYSTIML);
+	systimm = SXE_REG_READ(hw, SXE_SYSTIMM);
+	ns = SXE_TIME_TO_NS(systiml, systimm);
+
+	LOG_DEBUG_BDF("get ptp hw systime systiml=%u, systimm=%u, ns=%" SXE_PRIU64,
+			systiml, systimm, ns);
+	return ns;
+}
+
+void sxe_hw_ptp_systime_init(struct sxe_hw *hw)
+{
+	SXE_REG_WRITE(hw, SXE_SYSTIML, 0);
+	SXE_REG_WRITE(hw, SXE_SYSTIMM, 0);
+	SXE_REG_WRITE(hw, SXE_SYSTIMH, 0);
+
+	SXE_WRITE_FLUSH(hw);
+}
+
+void sxe_hw_ptp_init(struct sxe_hw *hw)
+{
+	u32 regval;
+	u32 tsctl = SXE_TSCTRL_TSEN |
+	SXE_TSCTRL_VER_2 |
+	SXE_TSCTRL_PTYP_ALL |
+	SXE_TSCTRL_L4_UNICAST;
+
+	regval = SXE_REG_READ(hw, SXE_TSCTRL);
+	regval &= ~SXE_TSCTRL_ONESTEP;
+	regval &= ~SXE_TSCTRL_CSEN;
+	regval |= tsctl;
+	SXE_REG_WRITE(hw, SXE_TSCTRL, regval);
+
+	SXE_REG_WRITE(hw, SXE_TIMINC,
+			SXE_TIMINC_SET(SXE_INCPD, SXE_IV_NS, SXE_IV_SNS));
+}
+
+void sxe_hw_ptp_rx_timestamp_clear(struct sxe_hw *hw)
+{
+	SXE_REG_READ(hw, SXE_RXSTMPH);
+}
+
+void sxe_hw_ptp_tx_timestamp_get(struct sxe_hw *hw,
+						u32 *ts_sec, u32 *ts_ns)
+{
+	u32 reg_sec;
+	u32 reg_ns;
+	u32 sec_8bit;
+	u32 sec_24bit;
+	u32 systimm;
+	u32 systimm_8bit;
+	u32 systimm_24bit;
+
+	SXE_REG64_WRITE(hw, SXE_TXSTMP_SEL, SXE_TXTS_MAGIC0);
+	reg_ns = SXE_REG_READ(hw, SXE_TXSTMP_VAL);
+	SXE_REG64_WRITE(hw, SXE_TXSTMP_SEL, SXE_TXTS_MAGIC1);
+	reg_sec = SXE_REG_READ(hw, SXE_TXSTMP_VAL);
+	systimm = SXE_REG_READ(hw, SXE_SYSTIMM);
+
+
+	sec_8bit  = reg_sec & 0x000000FF;
+	sec_24bit = (reg_sec >> 8) & 0x00FFFFFF;
+
+	systimm_24bit = systimm & 0x00FFFFFF;
+	systimm_8bit  = systimm & 0xFF000000;
+
+	*ts_ns  = (sec_8bit << 24) | ((reg_ns & 0xFFFFFF00) >> 8);
+
+	if (unlikely((sec_24bit - systimm_24bit) >= 0x00FFFFF0)) {
+		if (systimm_8bit >= 1)
+			systimm_8bit -= 1;
+	}
+
+	*ts_sec = systimm_8bit | sec_24bit;
+}
+
+u64 sxe_hw_ptp_rx_timestamp_get(struct sxe_hw *hw)
+{
+	struct sxe_adapter *adapter = hw->adapter;
+	u32 rxtsl;
+	u32 rxtsh;
+	u64 ns;
+
+	rxtsl = SXE_REG_READ(hw, SXE_RXSTMPL);
+	rxtsh = SXE_REG_READ(hw, SXE_RXSTMPH);
+	ns = SXE_TIME_TO_NS(rxtsl, rxtsh);
+
+	LOG_DEBUG_BDF("ptp get rx ptp timestamp low=%u, high=%u, ns=%" SXE_PRIU64,
+			rxtsl, rxtsh, ns);
+	return ns;
+}
+
+bool sxe_hw_ptp_is_rx_timestamp_valid(struct sxe_hw *hw)
+{
+	bool rx_tmstamp_valid = false;
+	u32 tsyncrxctl;
+
+	tsyncrxctl = SXE_REG_READ(hw, SXE_TSYNCRXCTL);
+	if (tsyncrxctl & SXE_TSYNCRXCTL_RXTT)
+		rx_tmstamp_valid = true;
+
+	return rx_tmstamp_valid;
+}
+
+void sxe_hw_ptp_timestamp_mode_set(struct sxe_hw *hw,
+					bool is_l2, u32 tsctl, u32 tses)
+{
+	u32 regval;
+
+	if (is_l2) {
+		SXE_REG_WRITE(hw, SXE_ETQF(SXE_ETQF_FILTER_1588),
+			(SXE_ETQF_FILTER_EN |
+			 SXE_ETQF_1588 |
+			 ETH_P_1588));
+	} else {
+		SXE_REG_WRITE(hw, SXE_ETQF(SXE_ETQF_FILTER_1588), 0);
+	}
+
+	if (tsctl) {
+		regval = SXE_REG_READ(hw, SXE_TSCTRL);
+		regval |= tsctl;
+		SXE_REG_WRITE(hw, SXE_TSCTRL, regval);
+	}
+
+	SXE_REG_WRITE(hw, SXE_TSES, tses);
+
+	SXE_WRITE_FLUSH(hw);
+}
+
+void sxe_hw_ptp_timestamp_enable(struct sxe_hw *hw)
+{
+	SXE_REG_WRITE(hw, SXE_TSYNCTXCTL,
+			(SXE_REG_READ(hw, SXE_TSYNCTXCTL) |
+			SXE_TSYNCTXCTL_TEN));
+
+	SXE_REG_WRITE(hw, SXE_TSYNCRXCTL,
+			(SXE_REG_READ(hw, SXE_TSYNCRXCTL) |
+			SXE_TSYNCRXCTL_REN));
+	SXE_WRITE_FLUSH(hw);
+}
+
+static void sxe_hw_dcb_tc_rss_configure(struct sxe_hw *hw, u16 rss)
+{
+	u32 msb = 0;
+
+	while (rss) {
+		msb++;
+		rss >>= 1;
+	}
+
+	SXE_REG_WRITE(hw, SXE_RQTC, msb * SXE_8_TC_MSB);
+}
+
+static void sxe_hw_tx_ring_disable(struct sxe_hw *hw, u8 reg_idx,
+				 unsigned long timeout)
+{
+	unsigned long wait_delay, delay_interval;
+	int wait_loop;
+	u32 txdctl;
+	struct sxe_adapter *adapter = hw->adapter;
+
+	txdctl = SXE_REG_READ(hw, SXE_TXDCTL(reg_idx));
+	txdctl &= ~SXE_TXDCTL_ENABLE;
+	SXE_REG_WRITE(hw, SXE_TXDCTL(reg_idx), txdctl);
+
+	delay_interval = timeout / 100;
+
+	wait_loop = SXE_MAX_RX_DESC_POLL;
+	wait_delay = delay_interval;
+
+	while (wait_loop--) {
+		usleep_range(wait_delay, wait_delay + 10);
+		wait_delay += delay_interval * 2;
+		txdctl = SXE_REG_READ(hw, SXE_TXDCTL(reg_idx));
+
+		if (!(txdctl & SXE_TXDCTL_ENABLE))
+			return;
+	}
+
+	LOG_MSG_ERR(drv, "register TXDCTL.ENABLE not cleared within the polling period");
+}
+
+static void sxe_hw_rx_ring_disable(struct sxe_hw *hw, u8 reg_idx,
+				 unsigned long timeout)
+{
+	unsigned long wait_delay, delay_interval;
+	int wait_loop;
+	u32 rxdctl;
+	struct sxe_adapter *adapter = hw->adapter;
+
+	rxdctl = SXE_REG_READ(hw, SXE_RXDCTL(reg_idx));
+	rxdctl &= ~SXE_RXDCTL_ENABLE;
+
+	SXE_REG_WRITE(hw, SXE_RXDCTL(reg_idx), rxdctl);
+
+	delay_interval = timeout / 100;
+
+	wait_loop = SXE_MAX_RX_DESC_POLL;
+	wait_delay = delay_interval;
+
+	while (wait_loop--) {
+		usleep_range(wait_delay, wait_delay + 10);
+		wait_delay += delay_interval * 2;
+		rxdctl = SXE_REG_READ(hw, SXE_RXDCTL(reg_idx));
+
+		if (!(rxdctl & SXE_RXDCTL_ENABLE))
+			return;
+	}
+
+	LOG_MSG_ERR(drv, "register RXDCTL.ENABLE not cleared within the polling period");
+}
+
+static u32 sxe_hw_tx_dbu_fc_status_get(struct sxe_hw *hw)
+{
+	return SXE_REG_READ(hw, SXE_TXPBFCS);
+}
+
+static void sxe_hw_fnav_sample_hash_set(struct sxe_hw *hw, u64 hash)
+{
+	SXE_REG64_WRITE(hw, SXE_FNAVHASH, hash);
+}
+
+static const struct sxe_dbu_operations sxe_dbu_ops = {
+	.rx_pkt_buf_size_configure	= sxe_hw_rx_pkt_buf_size_configure,
+	.rx_pkt_buf_switch		= sxe_hw_rx_pkt_buf_switch,
+	.rx_multi_ring_configure	= sxe_hw_rx_multi_ring_configure,
+	.rss_key_set_all		= sxe_hw_rss_key_set_all,
+	.rss_redir_tbl_set_all		= sxe_hw_rss_redir_tbl_set_all,
+	.rx_cap_switch_on		= sxe_hw_rx_cap_switch_on,
+	.rx_cap_switch_off		= sxe_hw_rx_cap_switch_off,
+	.rss_hash_pkt_type_set		= sxe_hw_rss_hash_pkt_type_set,
+	.rss_hash_pkt_type_update	= sxe_hw_rss_hash_pkt_type_update,
+	.rss_rings_used_set		= sxe_hw_rss_rings_used_set,
+	.lro_ack_switch			= sxe_hw_rx_lro_ack_switch,
+
+	.fnav_mode_init			= sxe_hw_fnav_mode_init,
+	.fnav_specific_rule_mask_set	= sxe_hw_fnav_specific_rule_mask_set,
+	.fnav_specific_rule_add		= sxe_hw_fnav_specific_rule_add,
+	.fnav_specific_rule_del		= sxe_hw_fnav_specific_rule_del,
+	.fnav_sample_hash_cmd_get	= sxe_hw_fnav_sample_hash_cmd_get,
+	.fnav_sample_stats_reinit	= sxe_hw_fnav_sample_stats_reinit,
+	.fnav_sample_hash_set		= sxe_hw_fnav_sample_hash_set,
+	.fnav_single_sample_rule_del	= sxe_hw_fnav_single_sample_rule_del,
+
+	.tx_pkt_buf_switch		= sxe_hw_tx_pkt_buf_switch,
+	.tx_pkt_buf_size_configure	= sxe_hw_tx_pkt_buf_size_configure,
+
+	.ptp_init			= sxe_hw_ptp_init,
+	.ptp_freq_adjust		= sxe_hw_ptp_freq_adjust,
+	.ptp_systime_init		= sxe_hw_ptp_systime_init,
+	.ptp_systime_get		= sxe_hw_ptp_systime_get,
+	.ptp_tx_timestamp_get		= sxe_hw_ptp_tx_timestamp_get,
+	.ptp_timestamp_mode_set		= sxe_hw_ptp_timestamp_mode_set,
+	.ptp_timestamp_enable		= sxe_hw_ptp_timestamp_enable,
+	.ptp_rx_timestamp_clear		= sxe_hw_ptp_rx_timestamp_clear,
+	.ptp_rx_timestamp_get		= sxe_hw_ptp_rx_timestamp_get,
+	.ptp_is_rx_timestamp_valid	= sxe_hw_ptp_is_rx_timestamp_valid,
+
+	.dcb_tc_rss_configure		= sxe_hw_dcb_tc_rss_configure,
+	.vf_rx_switch			= sxe_hw_vf_rx_switch,
+	.rx_pkt_buf_size_get		= sxe_hw_rx_pkt_buf_size_get,
+	.rx_func_switch_on		= sxe_hw_rx_func_switch_on,
+
+	.tx_ring_disable		= sxe_hw_tx_ring_disable,
+	.rx_ring_disable		= sxe_hw_rx_ring_disable,
+
+	.tx_dbu_fc_status_get		= sxe_hw_tx_dbu_fc_status_get,
+};
+
+
+void sxe_hw_rx_dma_ctrl_init(struct sxe_hw *hw)
+{
+	u32 rx_dma_ctrl = SXE_REG_READ(hw, SXE_RDRXCTL);
+
+	rx_dma_ctrl &= ~SXE_RDRXCTL_LROFRSTSIZE;
+	SXE_REG_WRITE(hw, SXE_RDRXCTL, rx_dma_ctrl);
+}
+
+void sxe_hw_rx_dma_lro_ctrl_set(struct sxe_hw *hw)
+{
+	u32 rx_dma_ctrl = SXE_REG_READ(hw, SXE_RDRXCTL);
+
+	rx_dma_ctrl |= SXE_RDRXCTL_LROACKC;
+	SXE_REG_WRITE(hw, SXE_RDRXCTL, rx_dma_ctrl);
+}
+
+void sxe_hw_rx_desc_thresh_set(struct sxe_hw *hw, u8 reg_idx)
+{
+	u32 rxdctl;
+	rxdctl = SXE_REG_READ(hw, SXE_RXDCTL(reg_idx));
+	rxdctl |= 0x40 << SXE_RXDCTL_PREFETCH_NUM_CFG_SHIFT;
+	rxdctl |= 0x2 << SXE_RXDCTL_DESC_FIFO_AE_TH_SHIFT;
+	rxdctl |= 0x10;
+	SXE_REG_WRITE(hw, SXE_RXDCTL(reg_idx), rxdctl);
+}
+
+void sxe_hw_rx_ring_switch(struct sxe_hw *hw, u8 reg_idx, bool is_on)
+{
+	u32 rxdctl;
+	u32 wait_loop = SXE_RING_WAIT_LOOP;
+	struct sxe_adapter *adapter = hw->adapter;
+
+	rxdctl = SXE_REG_READ(hw, SXE_RXDCTL(reg_idx));
+	if (is_on) {
+		rxdctl |= SXE_RXDCTL_ENABLE;
+		SXE_REG_WRITE(hw, SXE_RXDCTL(reg_idx), rxdctl);
+
+		do {
+			usleep_range(1000, 2000);
+			rxdctl = SXE_REG_READ(hw, SXE_RXDCTL(reg_idx));
+		} while (--wait_loop && !(rxdctl & SXE_RXDCTL_ENABLE));
+	} else {
+		rxdctl &= ~SXE_RXDCTL_ENABLE;
+		SXE_REG_WRITE(hw, SXE_RXDCTL(reg_idx), rxdctl);
+
+		do {
+			usleep_range(1000, 2000);
+			rxdctl = SXE_REG_READ(hw, SXE_RXDCTL(reg_idx));
+		} while (--wait_loop && (rxdctl & SXE_RXDCTL_ENABLE));
+	}
+
+	SXE_WRITE_FLUSH(hw);
+
+	if (!wait_loop) {
+		LOG_MSG_ERR(drv, "rx ring %u switch %u failed within "
+			  "the polling period", reg_idx, is_on);
+	}
+}
+
+void sxe_hw_rx_ring_switch_not_polling(struct sxe_hw *hw, u8 reg_idx, bool is_on)
+{
+	u32 rxdctl = SXE_REG_READ(hw, SXE_RXDCTL(reg_idx));
+	if (is_on) {
+		rxdctl |= SXE_RXDCTL_ENABLE;
+		SXE_REG_WRITE(hw, SXE_RXDCTL(reg_idx), rxdctl);
+	} else {
+		rxdctl &= ~SXE_RXDCTL_ENABLE;
+		SXE_REG_WRITE(hw, SXE_RXDCTL(reg_idx), rxdctl);
+	}
+
+	SXE_WRITE_FLUSH(hw);
+}
+
+void sxe_hw_rx_queue_desc_reg_configure(struct sxe_hw *hw,
+					u8 reg_idx, u32 rdh_value,
+					u32 rdt_value)
+{
+	SXE_REG_WRITE(hw, SXE_RDH(reg_idx), rdh_value);
+	SXE_REG_WRITE(hw, SXE_RDT(reg_idx), rdt_value);
+}
+
+static void sxe_hw_rx_ring_head_init(struct sxe_hw *hw, u8 reg_idx)
+{
+	SXE_REG_WRITE(hw, SXE_RDH(reg_idx), 0);
+}
+
+static void sxe_hw_rx_ring_tail_init(struct sxe_hw *hw, u8 reg_idx)
+{
+	SXE_REG_WRITE(hw, SXE_RDT(reg_idx), 0);
+}
+
+void sxe_hw_rx_ring_desc_configure(struct sxe_hw *hw,
+					u32 desc_mem_len, u64 desc_dma_addr,
+					u8 reg_idx)
+{
+	SXE_REG_WRITE(hw, SXE_RDBAL(reg_idx),
+			(desc_dma_addr & DMA_BIT_MASK(32)));
+	SXE_REG_WRITE(hw, SXE_RDBAH(reg_idx), (desc_dma_addr >> 32));
+	SXE_REG_WRITE(hw, SXE_RDLEN(reg_idx), desc_mem_len);
+
+	SXE_WRITE_FLUSH(hw);
+
+	sxe_hw_rx_ring_head_init(hw, reg_idx);
+	sxe_hw_rx_ring_tail_init(hw, reg_idx);
+}
+
+void sxe_hw_rx_rcv_ctl_configure(struct sxe_hw *hw, u8 reg_idx,
+				   u32 header_buf_len, u32 pkg_buf_len)
+{
+	u32 srrctl;
+
+	srrctl = ((header_buf_len << SXE_SRRCTL_BSIZEHDRSIZE_SHIFT) &
+			SXE_SRRCTL_BSIZEHDR_MASK);
+	srrctl |= ((pkg_buf_len >> SXE_SRRCTL_BSIZEPKT_SHIFT) &
+			SXE_SRRCTL_BSIZEPKT_MASK);
+
+	SXE_REG_WRITE(hw, SXE_SRRCTL(reg_idx), srrctl);
+}
+
+void sxe_hw_rx_lro_ctl_configure(struct sxe_hw *hw,
+						u8 reg_idx, u32 max_desc)
+{
+	u32 lroctrl;
+	lroctrl = SXE_REG_READ(hw, SXE_LROCTL(reg_idx));
+	lroctrl |= SXE_LROCTL_LROEN;
+	lroctrl |= max_desc;
+	SXE_REG_WRITE(hw, SXE_LROCTL(reg_idx), lroctrl);
+}
+
+static u32 sxe_hw_rx_desc_ctrl_get(struct sxe_hw *hw, u8 reg_idx)
+{
+	return SXE_REG_READ(hw, SXE_RXDCTL(reg_idx));
+}
+
+static void sxe_hw_dcb_arbiter_set(struct sxe_hw *hw, bool is_enable)
+{
+	u32 rttdcs;
+
+	rttdcs = SXE_REG_READ(hw, SXE_RTTDCS);
+
+	if (is_enable) {
+		rttdcs &= ~SXE_RTTDCS_ARBDIS;
+		rttdcs &= ~SXE_RTTDCS_BPBFSM;
+
+		SXE_REG_WRITE(hw, SXE_RTTDCS, rttdcs);
+	} else {
+		rttdcs |= SXE_RTTDCS_ARBDIS;
+		SXE_REG_WRITE(hw, SXE_RTTDCS, rttdcs);
+	}
+}
+
+
+static void sxe_hw_tx_multi_ring_configure(struct sxe_hw *hw, u8 tcs,
+				u16 pool_mask, bool sriov_enable, u16 max_txq)
+{
+	u32 mtqc;
+
+	sxe_hw_dcb_arbiter_set(hw, false);
+
+	if (sriov_enable) {
+		mtqc = SXE_MTQC_VT_ENA;
+		if (tcs > SXE_DCB_4_TC)
+			mtqc |= SXE_MTQC_RT_ENA | SXE_MTQC_8TC_8TQ;
+		else if (tcs > SXE_DCB_1_TC)
+			mtqc |= SXE_MTQC_RT_ENA | SXE_MTQC_4TC_4TQ;
+		else if (pool_mask == SXE_4Q_PER_POOL_MASK)
+			mtqc |= SXE_MTQC_32VF;
+		else
+			mtqc |= SXE_MTQC_64VF;
+	} else {
+		if (tcs > SXE_DCB_4_TC) {
+			mtqc = SXE_MTQC_RT_ENA | SXE_MTQC_8TC_8TQ;
+		} else if (tcs > SXE_DCB_1_TC) {
+			mtqc = SXE_MTQC_RT_ENA | SXE_MTQC_4TC_4TQ;
+		} else {
+			if (max_txq > 63)
+				mtqc = SXE_MTQC_RT_ENA | SXE_MTQC_4TC_4TQ;
+			else
+				mtqc = SXE_MTQC_64Q_1PB;
+		}
+	}
+
+	SXE_REG_WRITE(hw, SXE_MTQC, mtqc);
+
+	sxe_hw_dcb_arbiter_set(hw, true);
+}
+
+void sxe_hw_tx_ring_head_init(struct sxe_hw *hw, u8 reg_idx)
+{
+	SXE_REG_WRITE(hw, SXE_TDH(reg_idx), 0);
+}
+
+void sxe_hw_tx_ring_tail_init(struct sxe_hw *hw, u8 reg_idx)
+{
+	SXE_REG_WRITE(hw, SXE_TDT(reg_idx), 0);
+}
+
+void sxe_hw_tx_ring_desc_configure(struct sxe_hw *hw,
+					u32 desc_mem_len,
+					u64 desc_dma_addr, u8 reg_idx)
+{
+	SXE_REG_WRITE(hw, SXE_TXDCTL(reg_idx), 0);
+
+	SXE_WRITE_FLUSH(hw);
+
+	SXE_REG_WRITE(hw, SXE_TDBAL(reg_idx), (desc_dma_addr & DMA_BIT_MASK(32)));
+	SXE_REG_WRITE(hw, SXE_TDBAH(reg_idx), (desc_dma_addr >> 32));
+	SXE_REG_WRITE(hw, SXE_TDLEN(reg_idx), desc_mem_len);
+	sxe_hw_tx_ring_head_init(hw, reg_idx);
+	sxe_hw_tx_ring_tail_init(hw, reg_idx);
+}
+
+void sxe_hw_tx_desc_thresh_set(struct sxe_hw *hw,
+				u8 reg_idx,
+				u32 wb_thresh,
+				u32 host_thresh,
+				u32 prefech_thresh)
+{
+	u32 txdctl = 0;
+
+	txdctl |= (wb_thresh << SXE_TXDCTL_WTHRESH_SHIFT);
+	txdctl |= (host_thresh << SXE_TXDCTL_HTHRESH_SHIFT) | prefech_thresh;
+
+	SXE_REG_WRITE(hw, SXE_TXDCTL(reg_idx), txdctl);
+}
+
+void sxe_hw_all_ring_disable(struct sxe_hw *hw, u32 ring_max)
+{
+	u32 i, value;
+
+	for (i = 0; i < ring_max; i++) {
+		value = SXE_REG_READ(hw, SXE_TXDCTL(i));
+		value &= ~SXE_TXDCTL_ENABLE;
+		SXE_REG_WRITE(hw, SXE_TXDCTL(i), value);
+
+		value = SXE_REG_READ(hw, SXE_RXDCTL(i));
+		value &= ~SXE_RXDCTL_ENABLE;
+		SXE_REG_WRITE(hw, SXE_RXDCTL(i), value);
+	}
+
+	SXE_WRITE_FLUSH(hw);
+	usleep_range(1000, 2000);
+}
+
+void sxe_hw_tx_ring_switch(struct sxe_hw *hw, u8 reg_idx, bool is_on)
+{
+	u32 wait_loop = SXE_RING_WAIT_LOOP;
+	struct sxe_adapter *adapter = hw->adapter;
+
+	u32 txdctl = SXE_REG_READ(hw, SXE_TXDCTL(reg_idx));
+	if (is_on) {
+		txdctl |= SXE_TXDCTL_ENABLE;
+		SXE_REG_WRITE(hw, SXE_TXDCTL(reg_idx), txdctl);
+
+		do {
+			usleep_range(1000, 2000);
+			txdctl = SXE_REG_READ(hw, SXE_TXDCTL(reg_idx));
+		} while (--wait_loop && !(txdctl & SXE_TXDCTL_ENABLE));
+	} else {
+		txdctl &= ~SXE_TXDCTL_ENABLE;
+		SXE_REG_WRITE(hw, SXE_TXDCTL(reg_idx), txdctl);
+
+		do {
+			usleep_range(1000, 2000);
+			txdctl = SXE_REG_READ(hw, SXE_TXDCTL(reg_idx));
+		} while (--wait_loop && (txdctl & SXE_TXDCTL_ENABLE));
+	}
+
+	if (!wait_loop) {
+		LOG_DEV_ERR("tx ring %u switch %u failed within "
+			  "the polling period", reg_idx, is_on);
+	}
+}
+
+void sxe_hw_tx_ring_switch_not_polling(struct sxe_hw *hw, u8 reg_idx, bool is_on)
+{
+	u32 txdctl = SXE_REG_READ(hw, SXE_TXDCTL(reg_idx));
+	if (is_on) {
+		txdctl |= SXE_TXDCTL_ENABLE;
+		SXE_REG_WRITE(hw, SXE_TXDCTL(reg_idx), txdctl);
+	} else {
+		txdctl &= ~SXE_TXDCTL_ENABLE;
+		SXE_REG_WRITE(hw, SXE_TXDCTL(reg_idx), txdctl);
+	}
+}
+
+void sxe_hw_tx_pkt_buf_thresh_configure(struct sxe_hw *hw,
+					u8 num_pb, bool dcb_enable)
+{
+	u32 i, tx_pkt_size, tx_pb_thresh;
+
+	if (!num_pb)
+		num_pb = 1;
+
+	tx_pkt_size = SXE_TX_PBSIZE_MAX / num_pb;
+	if (dcb_enable)
+		tx_pb_thresh = (tx_pkt_size / 1024) - SXE_TX_PKT_SIZE_MAX;
+	else
+		tx_pb_thresh = (tx_pkt_size / 1024) - SXE_NODCB_TX_PKT_SIZE_MAX;
+
+	for (i = 0; i < num_pb; i++)
+		SXE_REG_WRITE(hw, SXE_TXPBTHRESH(i), tx_pb_thresh);
+
+	for (; i < SXE_PKG_BUF_NUM_MAX; i++)
+		SXE_REG_WRITE(hw, SXE_TXPBTHRESH(i), 0);
+}
+
+void sxe_hw_tx_enable(struct sxe_hw *hw)
+{
+	u32 ctl;
+
+	ctl = SXE_REG_READ(hw, SXE_DMATXCTL);
+	ctl |= SXE_DMATXCTL_TE;
+	SXE_REG_WRITE(hw, SXE_DMATXCTL, ctl);
+}
+
+static u32 sxe_hw_tx_desc_ctrl_get(struct sxe_hw *hw, u8 reg_idx)
+{
+	return SXE_REG_READ(hw, SXE_TXDCTL(reg_idx));
+}
+
+static void sxe_hw_tx_desc_wb_thresh_clear(struct sxe_hw *hw, u8 reg_idx)
+{
+	u32 reg_data;
+
+	reg_data = SXE_REG_READ(hw, SXE_TXDCTL(reg_idx));
+	reg_data &= ~SXE_TXDCTL_ENABLE;
+	SXE_REG_WRITE(hw, SXE_TXDCTL(reg_idx), reg_data);
+	SXE_WRITE_FLUSH(hw);
+	reg_data &= ~(0x7f << 16);
+	reg_data |= SXE_TXDCTL_ENABLE;
+	SXE_REG_WRITE(hw, SXE_TXDCTL(reg_idx), reg_data);
+}
+
+void sxe_hw_vlan_tag_strip_switch(struct sxe_hw *hw,
+					u16 reg_index, bool is_enable)
+{
+	u32 rxdctl;
+
+	rxdctl = SXE_REG_READ(hw, SXE_RXDCTL(reg_index));
+
+	if (is_enable)
+		rxdctl |= SXE_RXDCTL_VME;
+	else
+		rxdctl &= ~SXE_RXDCTL_VME;
+
+	SXE_REG_WRITE(hw, SXE_RXDCTL(reg_index), rxdctl);
+}
+
+static void sxe_hw_tx_vlan_tag_set(struct sxe_hw *hw,
+				   u16 vid, u16 qos, u32 vf)
+{
+	u32 vmvir = vid | (qos << VLAN_PRIO_SHIFT) | SXE_VMVIR_VLANA_DEFAULT;
+
+	SXE_REG_WRITE(hw, SXE_VMVIR(vf), vmvir);
+}
+
+void sxe_hw_tx_vlan_tag_clear(struct sxe_hw *hw, u32 vf)
+{
+	SXE_REG_WRITE(hw, SXE_VMVIR(vf), 0);
+}
+
+u32 sxe_hw_tx_vlan_insert_get(struct sxe_hw *hw, u32 vf)
+{
+	return SXE_REG_READ(hw, SXE_VMVIR(vf));
+}
+
+void sxe_hw_tx_ring_info_get(struct sxe_hw *hw,
+				u8 idx, u32 *head, u32 *tail)
+{
+	*head = SXE_REG_READ(hw, SXE_TDH(idx));
+	*tail = SXE_REG_READ(hw, SXE_TDT(idx));
+}
+
+void sxe_hw_dcb_rx_bw_alloc_configure(struct sxe_hw *hw,
+					  u16 *refill,
+					  u16 *max,
+					  u8 *bwg_id,
+					  u8 *prio_type,
+					  u8 *prio_tc,
+					  u8 max_priority)
+{
+	u32	reg;
+	u32	credit_refill;
+	u32	credit_max;
+	u8	 i;
+
+	reg = SXE_RTRPCS_RRM | SXE_RTRPCS_RAC | SXE_RTRPCS_ARBDIS;
+	SXE_REG_WRITE(hw, SXE_RTRPCS, reg);
+
+	reg = 0;
+	for (i = 0; i < max_priority; i++)
+		reg |= (prio_tc[i] << (i * SXE_RTRUP2TC_UP_SHIFT));
+
+	SXE_REG_WRITE(hw, SXE_RTRUP2TC, reg);
+
+	for (i = 0; i < MAX_TRAFFIC_CLASS; i++) {
+		credit_refill = refill[i];
+		credit_max	= max[i];
+		reg = credit_refill | (credit_max << SXE_RTRPT4C_MCL_SHIFT);
+
+		reg |= (u32)(bwg_id[i]) << SXE_RTRPT4C_BWG_SHIFT;
+
+		if (prio_type[i] == PRIO_LINK)
+			reg |= SXE_RTRPT4C_LSP;
+
+		SXE_REG_WRITE(hw, SXE_RTRPT4C(i), reg);
+	}
+
+	reg = SXE_RTRPCS_RRM | SXE_RTRPCS_RAC;
+	SXE_REG_WRITE(hw, SXE_RTRPCS, reg);
+}
+
+void sxe_hw_dcb_tx_desc_bw_alloc_configure(struct sxe_hw *hw,
+					   u16 *refill,
+					   u16 *max,
+					   u8 *bwg_id,
+					   u8 *prio_type)
+{
+	u32	reg, max_credits;
+	u8	 i;
+
+	for (i = 0; i < 128; i++) {
+		SXE_REG_WRITE(hw, SXE_RTTDQSEL, i);
+		SXE_REG_WRITE(hw, SXE_RTTDT1C, 0);
+	}
+
+	for (i = 0; i < MAX_TRAFFIC_CLASS; i++) {
+		max_credits = max[i];
+		reg = max_credits << SXE_RTTDT2C_MCL_SHIFT;
+		reg |= refill[i];
+		reg |= (u32)(bwg_id[i]) << SXE_RTTDT2C_BWG_SHIFT;
+
+		if (prio_type[i] == PRIO_GROUP)
+			reg |= SXE_RTTDT2C_GSP;
+
+		if (prio_type[i] == PRIO_LINK)
+			reg |= SXE_RTTDT2C_LSP;
+
+		SXE_REG_WRITE(hw, SXE_RTTDT2C(i), reg);
+	}
+
+	reg = SXE_RTTDCS_TDPAC | SXE_RTTDCS_TDRM;
+	SXE_REG_WRITE(hw, SXE_RTTDCS, reg);
+}
+
+void sxe_hw_dcb_tx_data_bw_alloc_configure(struct sxe_hw *hw,
+					   u16 *refill,
+					   u16 *max,
+					   u8 *bwg_id,
+					   u8 *prio_type,
+					   u8 *prio_tc,
+					   u8 max_priority)
+{
+	u32 reg;
+	u8 i;
+
+	reg = SXE_RTTPCS_TPPAC | SXE_RTTPCS_TPRM |
+		  (SXE_RTTPCS_ARBD_DCB << SXE_RTTPCS_ARBD_SHIFT) |
+		  SXE_RTTPCS_ARBDIS;
+	SXE_REG_WRITE(hw, SXE_RTTPCS, reg);
+
+	reg = 0;
+	for (i = 0; i < max_priority; i++)
+		reg |= (prio_tc[i] << (i * SXE_RTTUP2TC_UP_SHIFT));
+
+	SXE_REG_WRITE(hw, SXE_RTTUP2TC, reg);
+
+	for (i = 0; i < MAX_TRAFFIC_CLASS; i++) {
+		reg = refill[i];
+		reg |= (u32)(max[i]) << SXE_RTTPT2C_MCL_SHIFT;
+		reg |= (u32)(bwg_id[i]) << SXE_RTTPT2C_BWG_SHIFT;
+
+		if (prio_type[i] == PRIO_GROUP)
+			reg |= SXE_RTTPT2C_GSP;
+
+		if (prio_type[i] == PRIO_LINK)
+			reg |= SXE_RTTPT2C_LSP;
+
+		SXE_REG_WRITE(hw, SXE_RTTPT2C(i), reg);
+	}
+
+	reg = SXE_RTTPCS_TPPAC | SXE_RTTPCS_TPRM |
+		  (SXE_RTTPCS_ARBD_DCB << SXE_RTTPCS_ARBD_SHIFT);
+	SXE_REG_WRITE(hw, SXE_RTTPCS, reg);
+}
+
+void sxe_hw_dcb_pfc_configure(struct sxe_hw *hw,
+						u8 pfc_en, u8 *prio_tc,
+						u8 max_priority)
+{
+	u32 i, j, fcrtl, reg;
+	u8 max_tc = 0;
+	u32 reg_val;
+
+	reg_val = SXE_REG_READ(hw, SXE_FLCTRL);
+
+	reg_val &= ~SXE_FCTRL_TFCE_MASK;
+	reg_val |= SXE_FCTRL_TFCE_PFC_EN;
+
+	reg_val |= SXE_FCTRL_TFCE_DPF_EN;
+
+	reg_val &= ~(SXE_FCTRL_TFCE_FCEN_MASK | SXE_FCTRL_TFCE_XONE_MASK);
+	reg_val |= (pfc_en << 16) & SXE_FCTRL_TFCE_FCEN_MASK;
+	reg_val |= (pfc_en << 24) & SXE_FCTRL_TFCE_XONE_MASK;
+
+	reg_val &= ~SXE_FCTRL_RFCE_MASK;
+	reg_val |= SXE_FCTRL_RFCE_PFC_EN;
+	SXE_REG_WRITE(hw, SXE_FLCTRL, reg_val);
+
+	reg_val = SXE_REG_READ(hw, SXE_PFCTOP);
+	reg_val &= ~SXE_PFCTOP_FCOP_MASK;
+	reg_val |= SXE_PFCTOP_FCT;
+	reg_val |= SXE_PFCTOP_FCOP_PFC;
+	SXE_REG_WRITE(hw, SXE_PFCTOP, reg_val);
+
+	for (i = 0; i < max_priority; i++) {
+		if (prio_tc[i] > max_tc)
+			max_tc = prio_tc[i];
+	}
+
+	for (i = 0; i <= max_tc; i++) {
+		int enabled = 0;
+
+		for (j = 0; j < max_priority; j++) {
+			if (prio_tc[j] == i && (pfc_en & BIT(j))) {
+				enabled = 1;
+				break;
+			}
+		}
+
+		if (enabled) {
+			reg = (hw->fc.high_water[i] << 9) | SXE_FCRTH_FCEN;
+			fcrtl = (hw->fc.low_water[i] << 9) | SXE_FCRTL_XONE;
+			SXE_REG_WRITE(hw, SXE_FCRTL(i), fcrtl);
+		} else {
+			reg = (SXE_REG_READ(hw, SXE_RXPBSIZE(i)) - 24576) >> 1;
+			SXE_REG_WRITE(hw, SXE_FCRTL(i), 0);
+		}
+
+		SXE_REG_WRITE(hw, SXE_FCRTH(i), reg);
+	}
+
+	for (; i < MAX_TRAFFIC_CLASS; i++) {
+		SXE_REG_WRITE(hw, SXE_FCRTL(i), 0);
+		SXE_REG_WRITE(hw, SXE_FCRTH(i), 0);
+	}
+
+	reg = hw->fc.pause_time * 0x00010001;
+	for (i = 0; i < (MAX_TRAFFIC_CLASS / 2); i++)
+		SXE_REG_WRITE(hw, SXE_FCTTV(i), reg);
+
+	SXE_REG_WRITE(hw, SXE_FCRTV, hw->fc.pause_time / 2);
+}
+
+static void sxe_hw_dcb_8tc_vmdq_off_stats_configure(struct sxe_hw *hw)
+{
+	u32 reg;
+	u8  i;
+
+	for (i = 0; i < 32; i++) {
+		reg = 0x01010101 * (i / 4);
+		SXE_REG_WRITE(hw, SXE_RQSMR(i), reg);
+	}
+
+	for (i = 0; i < 32; i++) {
+		if (i < 8)
+			reg = 0x00000000;
+		else if (i < 16)
+			reg = 0x01010101;
+		else if (i < 20)
+			reg = 0x02020202;
+		else if (i < 24)
+			reg = 0x03030303;
+		else if (i < 26)
+			reg = 0x04040404;
+		else if (i < 28)
+			reg = 0x05050505;
+		else if (i < 30)
+			reg = 0x06060606;
+		else
+			reg = 0x07070707;
+
+		SXE_REG_WRITE(hw, SXE_TQSM(i), reg);
+	}
+}
+
+static void sxe_hw_dcb_rx_up_tc_map_set(struct sxe_hw *hw, u8 tc)
+{
+	u8 i;
+	u32 reg, rsave;
+
+	reg = SXE_REG_READ(hw, SXE_RTRUP2TC);
+	rsave = reg;
+
+	for (i = 0; i < MAX_TRAFFIC_CLASS; i++) {
+		u8 up2tc = reg >> (i * SXE_RTRUP2TC_UP_SHIFT);
+
+		if (up2tc > tc)
+			reg &= ~(0x7 << SXE_RTRUP2TC_UP_MASK);
+	}
+
+	if (reg != rsave)
+		SXE_REG_WRITE(hw, SXE_RTRUP2TC, reg);
+}
+
+void sxe_hw_vt_pool_loopback_switch(struct sxe_hw *hw,
+							bool is_enable)
+{
+	if (is_enable)
+		SXE_REG_WRITE(hw, SXE_PFDTXGSWC, SXE_PFDTXGSWC_VT_LBEN);
+	else
+		SXE_REG_WRITE(hw, SXE_PFDTXGSWC, 0);
+}
+
+void sxe_hw_pool_rx_ring_drop_enable(struct sxe_hw *hw, u8 vf_idx,
+					u16 pf_vlan, u8 ring_per_pool)
+{
+	u32 qde = SXE_QDE_ENABLE;
+	u8 i;
+
+	if (pf_vlan)
+		qde |= SXE_QDE_HIDE_VLAN;
+
+	for (i = (vf_idx * ring_per_pool); i < ((vf_idx + 1) * ring_per_pool); i++) {
+		u32 value;
+
+		SXE_WRITE_FLUSH(hw);
+
+		value = i << SXE_QDE_IDX_SHIFT;
+		value |= qde | SXE_QDE_WRITE;
+
+		SXE_REG_WRITE(hw, SXE_QDE, value);
+	}
+}
+
+u32 sxe_hw_rx_pool_bitmap_get(struct sxe_hw *hw, u8 reg_idx)
+{
+	return SXE_REG_READ(hw, SXE_VFRE(reg_idx));
+}
+
+void sxe_hw_rx_pool_bitmap_set(struct sxe_hw *hw,
+						u8 reg_idx, u32 bitmap)
+{
+	SXE_REG_WRITE(hw, SXE_VFRE(reg_idx), bitmap);
+}
+
+u32 sxe_hw_tx_pool_bitmap_get(struct sxe_hw *hw, u8 reg_idx)
+{
+	return SXE_REG_READ(hw, SXE_VFTE(reg_idx));
+}
+
+void sxe_hw_tx_pool_bitmap_set(struct sxe_hw *hw,
+						u8 reg_idx, u32 bitmap)
+{
+	SXE_REG_WRITE(hw, SXE_VFTE(reg_idx), bitmap);
+}
+
+void sxe_hw_dcb_max_mem_window_set(struct sxe_hw *hw, u32 value)
+{
+	SXE_REG_WRITE(hw, SXE_RTTBCNRM, value);
+}
+
+void sxe_hw_dcb_tx_ring_rate_factor_set(struct sxe_hw *hw,
+							u32 ring_idx, u32 rate)
+{
+	SXE_REG_WRITE(hw, SXE_RTTDQSEL, ring_idx);
+	SXE_REG_WRITE(hw, SXE_RTTBCNRC, rate);
+}
+
+void sxe_hw_spoof_count_enable(struct sxe_hw *hw,
+						u8 reg_idx, u8 bit_index)
+{
+	u32 value = SXE_REG_READ(hw, SXE_VMECM(reg_idx));
+
+	value |= BIT(bit_index);
+
+	SXE_REG_WRITE(hw, SXE_VMECM(reg_idx), value);
+}
+
+void sxe_hw_pool_mac_anti_spoof_set(struct sxe_hw *hw,
+							u8 vf_idx, bool status)
+{
+	u8 reg_index = vf_idx >> 3;
+	u8 bit_index = vf_idx % 8;
+	u32 value;
+
+	value = SXE_REG_READ(hw, SXE_SPOOF(reg_index));
+
+	if (status)
+		value |= BIT(bit_index);
+	else
+		value &= ~BIT(bit_index);
+
+	SXE_REG_WRITE(hw, SXE_SPOOF(reg_index), value);
+}
+
+static void sxe_hw_dcb_rx_up_tc_map_get(struct sxe_hw *hw, u8 *map)
+{
+	u32 reg, i;
+
+	reg = SXE_REG_READ(hw, SXE_RTRUP2TC);
+	for (i = 0; i < MAX_TRAFFIC_CLASS; i++) {
+		map[i] = SXE_RTRUP2TC_UP_MASK &
+			(reg >> (i * SXE_RTRUP2TC_UP_SHIFT));
+	}
+}
+
+void sxe_hw_rx_drop_switch(struct sxe_hw *hw, u8 idx, bool is_enable)
+{
+	u32 srrctl = SXE_REG_READ(hw, SXE_SRRCTL(idx));
+
+	if (is_enable)
+		srrctl |= SXE_SRRCTL_DROP_EN;
+	else
+		srrctl &= ~SXE_SRRCTL_DROP_EN;
+
+	SXE_REG_WRITE(hw, SXE_SRRCTL(idx), srrctl);
+}
+
+static void sxe_hw_pool_vlan_anti_spoof_set(struct sxe_hw *hw,
+							u8 vf_idx, bool status)
+{
+	u8 reg_index = vf_idx >> 3;
+	u8 bit_index = (vf_idx % 8) + SXE_SPOOF_VLAN_SHIFT;
+	u32 value;
+
+	value = SXE_REG_READ(hw, SXE_SPOOF(reg_index));
+
+	if (status)
+		value |= BIT(bit_index);
+	else
+		value &= ~BIT(bit_index);
+
+	SXE_REG_WRITE(hw, SXE_SPOOF(reg_index), value);
+}
+
+static void sxe_hw_vf_tx_desc_addr_clear(struct sxe_hw *hw,
+						u8 vf_idx, u8 ring_per_pool)
+{
+	u8 i;
+
+	for (i = 0; i < ring_per_pool; i++) {
+		SXE_REG_WRITE(hw, SXE_PVFTDWBAL_N(ring_per_pool, vf_idx, i), 0);
+		SXE_REG_WRITE(hw, SXE_PVFTDWBAH_N(ring_per_pool, vf_idx, i), 0);
+	}
+}
+
+static void sxe_hw_vf_tx_ring_disable(struct sxe_hw *hw,
+						u8 ring_per_pool, u8 vf_idx)
+{
+	u32 ring_idx;
+	u32 reg;
+
+	for (ring_idx = 0; ring_idx < ring_per_pool; ring_idx++) {
+		u32 reg_idx = vf_idx * ring_per_pool + ring_idx;
+		reg = SXE_REG_READ(hw, SXE_TXDCTL(reg_idx));
+		if (reg) {
+			reg |= SXE_TXDCTL_ENABLE;
+			SXE_REG_WRITE(hw, SXE_TXDCTL(reg_idx), reg);
+			reg &= ~SXE_TXDCTL_ENABLE;
+			SXE_REG_WRITE(hw, SXE_TXDCTL(reg_idx), reg);
+		}
+	}
+
+	SXE_WRITE_FLUSH(hw);
+}
+
+void sxe_hw_dcb_rate_limiter_clear(struct sxe_hw *hw, u8 ring_max)
+{
+	u32 i;
+
+	for (i = 0; i < ring_max; i++) {
+		SXE_REG_WRITE(hw, SXE_RTTDQSEL, i);
+		SXE_REG_WRITE(hw, SXE_RTTBCNRC, 0);
+	}
+	SXE_WRITE_FLUSH(hw);
+}
+
+static void sxe_hw_tx_tph_update(struct sxe_hw *hw, u8 ring_idx, u8 cpu)
+{
+	u32 value = cpu;
+
+	value <<= SXE_TPH_TXCTRL_CPUID_SHIFT;
+
+	value |= (SXE_TPH_TXCTRL_DESC_RRO_EN |
+		 SXE_TPH_TXCTRL_DATA_RRO_EN |
+		 SXE_TPH_TXCTRL_DESC_TPH_EN);
+
+	SXE_REG_WRITE(hw, SXE_TPH_TXCTRL(ring_idx), value);
+}
+
+static void sxe_hw_rx_tph_update(struct sxe_hw *hw, u8 ring_idx, u8 cpu)
+{
+	u32 value = cpu;
+
+	value <<= SXE_TPH_RXCTRL_CPUID_SHIFT;
+
+	value |= (SXE_TPH_RXCTRL_DESC_RRO_EN |
+		 SXE_TPH_RXCTRL_DATA_TPH_EN |
+		 SXE_TPH_RXCTRL_DESC_TPH_EN);
+
+	SXE_REG_WRITE(hw, SXE_TPH_RXCTRL(ring_idx), value);
+}
+
+static void sxe_hw_tph_switch(struct sxe_hw *hw, bool is_enable)
+{
+	if (is_enable)
+		SXE_REG_WRITE(hw, SXE_TPH_CTRL, SXE_TPH_CTRL_MODE_CB2);
+	else
+		SXE_REG_WRITE(hw, SXE_TPH_CTRL, SXE_TPH_CTRL_DISABLE);
+}
+
+static const struct sxe_dma_operations sxe_dma_ops = {
+	.rx_dma_ctrl_init	   = sxe_hw_rx_dma_ctrl_init,
+	.rx_ring_switch		 = sxe_hw_rx_ring_switch,
+	.rx_ring_switch_not_polling = sxe_hw_rx_ring_switch_not_polling,
+	.rx_ring_desc_configure		= sxe_hw_rx_ring_desc_configure,
+	.rx_desc_thresh_set		= sxe_hw_rx_desc_thresh_set,
+	.rx_rcv_ctl_configure		= sxe_hw_rx_rcv_ctl_configure,
+	.rx_lro_ctl_configure		= sxe_hw_rx_lro_ctl_configure,
+	.rx_desc_ctrl_get		= sxe_hw_rx_desc_ctrl_get,
+	.rx_dma_lro_ctl_set		= sxe_hw_rx_dma_lro_ctrl_set,
+	.rx_drop_switch			= sxe_hw_rx_drop_switch,
+	.pool_rx_ring_drop_enable	= sxe_hw_pool_rx_ring_drop_enable,
+	.rx_tph_update			= sxe_hw_rx_tph_update,
+
+	.tx_enable			= sxe_hw_tx_enable,
+	.tx_multi_ring_configure	= sxe_hw_tx_multi_ring_configure,
+	.tx_ring_desc_configure		= sxe_hw_tx_ring_desc_configure,
+	.tx_desc_thresh_set		= sxe_hw_tx_desc_thresh_set,
+	.tx_desc_wb_thresh_clear	= sxe_hw_tx_desc_wb_thresh_clear,
+	.tx_ring_switch			= sxe_hw_tx_ring_switch,
+	.tx_ring_switch_not_polling	 = sxe_hw_tx_ring_switch_not_polling,
+	.tx_pkt_buf_thresh_configure	= sxe_hw_tx_pkt_buf_thresh_configure,
+	.tx_desc_ctrl_get		= sxe_hw_tx_desc_ctrl_get,
+	.tx_ring_info_get		= sxe_hw_tx_ring_info_get,
+	.tx_tph_update			= sxe_hw_tx_tph_update,
+
+	.tph_switch			= sxe_hw_tph_switch,
+
+	.vlan_tag_strip_switch		= sxe_hw_vlan_tag_strip_switch,
+	.tx_vlan_tag_set		= sxe_hw_tx_vlan_tag_set,
+	.tx_vlan_tag_clear		= sxe_hw_tx_vlan_tag_clear,
+
+	.dcb_rx_bw_alloc_configure	= sxe_hw_dcb_rx_bw_alloc_configure,
+	.dcb_tx_desc_bw_alloc_configure	= sxe_hw_dcb_tx_desc_bw_alloc_configure,
+	.dcb_tx_data_bw_alloc_configure	= sxe_hw_dcb_tx_data_bw_alloc_configure,
+	.dcb_pfc_configure		= sxe_hw_dcb_pfc_configure,
+	.dcb_tc_stats_configure		= sxe_hw_dcb_8tc_vmdq_off_stats_configure,
+	.dcb_rx_up_tc_map_set		= sxe_hw_dcb_rx_up_tc_map_set,
+	.dcb_rx_up_tc_map_get		= sxe_hw_dcb_rx_up_tc_map_get,
+	.dcb_rate_limiter_clear		= sxe_hw_dcb_rate_limiter_clear,
+	.dcb_tx_ring_rate_factor_set	= sxe_hw_dcb_tx_ring_rate_factor_set,
+
+	.vt_pool_loopback_switch	= sxe_hw_vt_pool_loopback_switch,
+	.rx_pool_get			= sxe_hw_rx_pool_bitmap_get,
+	.rx_pool_set			= sxe_hw_rx_pool_bitmap_set,
+	.tx_pool_get			= sxe_hw_tx_pool_bitmap_get,
+	.tx_pool_set			= sxe_hw_tx_pool_bitmap_set,
+
+	.vf_tx_desc_addr_clear		= sxe_hw_vf_tx_desc_addr_clear,
+	.pool_mac_anti_spoof_set	= sxe_hw_pool_mac_anti_spoof_set,
+	.pool_vlan_anti_spoof_set	= sxe_hw_pool_vlan_anti_spoof_set,
+
+	.max_dcb_memory_window_set	= sxe_hw_dcb_max_mem_window_set,
+	.spoof_count_enable		= sxe_hw_spoof_count_enable,
+
+	.vf_tx_ring_disable		 = sxe_hw_vf_tx_ring_disable,
+	.all_ring_disable		   = sxe_hw_all_ring_disable,
+	.tx_ring_tail_init		  = sxe_hw_tx_ring_tail_init,
+};
+
+
+#ifdef SXE_IPSEC_CONFIGURE
+
+static void sxe_hw_ipsec_rx_sa_load(struct sxe_hw *hw, u16 idx,
+					u8 type)
+{
+	u32 reg = SXE_REG_READ(hw, SXE_IPSRXIDX);
+
+	reg &= SXE_RXTXIDX_IPS_EN;
+	reg |= type << SXE_RXIDX_TBL_SHIFT |
+		   idx << SXE_RXTXIDX_IDX_SHIFT |
+		   SXE_RXTXIDX_WRITE;
+	SXE_REG_WRITE(hw, SXE_IPSRXIDX, reg);
+	SXE_WRITE_FLUSH(hw);
+}
+
+static void sxe_hw_ipsec_rx_ip_store(struct sxe_hw *hw,
+						 __be32 *ip_addr, u8 ip_len, u8 ip_idx)
+{
+	u8 i;
+
+	for (i = 0; i < ip_len; i++) {
+		SXE_REG_WRITE(hw, SXE_IPSRXIPADDR(i),
+				(__force u32)cpu_to_le32((__force u32)ip_addr[i]));
+	}
+	SXE_WRITE_FLUSH(hw);
+	sxe_hw_ipsec_rx_sa_load(hw, ip_idx, SXE_IPSEC_IP_TABLE);
+}
+
+static void sxe_hw_ipsec_rx_spi_store(struct sxe_hw *hw,
+						 __be32 spi, u8 ip_idx, u16 sa_idx)
+{
+	SXE_REG_WRITE(hw, SXE_IPSRXSPI, (__force u32)cpu_to_le32((__force u32)spi));
+
+	SXE_REG_WRITE(hw, SXE_IPSRXIPIDX, ip_idx);
+
+	SXE_WRITE_FLUSH(hw);
+
+	sxe_hw_ipsec_rx_sa_load(hw, sa_idx, SXE_IPSEC_SPI_TABLE);
+}
+
+static void sxe_hw_ipsec_rx_key_store(struct sxe_hw *hw,
+			u32 *key,  u8 key_len, u32 salt, u32 mode, u16 sa_idx)
+{
+	u8 i;
+
+	for (i = 0; i < key_len; i++) {
+		SXE_REG_WRITE(hw, SXE_IPSRXKEY(i),
+				(__force u32)cpu_to_be32(key[(key_len - 1) - i]));
+	}
+
+	SXE_REG_WRITE(hw, SXE_IPSRXSALT, (__force u32)cpu_to_be32(salt));
+	SXE_REG_WRITE(hw, SXE_IPSRXMOD, mode);
+	SXE_WRITE_FLUSH(hw);
+
+	sxe_hw_ipsec_rx_sa_load(hw, sa_idx, SXE_IPSEC_KEY_TABLE);
+}
+
+static void sxe_hw_ipsec_tx_sa_load(struct sxe_hw *hw, u16 idx)
+{
+	u32 reg = SXE_REG_READ(hw, SXE_IPSTXIDX);
+
+	reg &= SXE_RXTXIDX_IPS_EN;
+	reg |= idx << SXE_RXTXIDX_IDX_SHIFT | SXE_RXTXIDX_WRITE;
+	SXE_REG_WRITE(hw, SXE_IPSTXIDX, reg);
+	SXE_WRITE_FLUSH(hw);
+}
+
+static void sxe_hw_ipsec_tx_key_store(struct sxe_hw *hw, u32 *key,
+						u8 key_len, u32 salt, u16 sa_idx)
+{
+	u8 i;
+
+	for (i = 0; i < key_len; i++) {
+		SXE_REG_WRITE(hw, SXE_IPSTXKEY(i),
+			(__force u32)cpu_to_be32(key[(key_len - 1) - i]));
+	}
+	SXE_REG_WRITE(hw, SXE_IPSTXSALT, (__force u32)cpu_to_be32(salt));
+	SXE_WRITE_FLUSH(hw);
+
+	sxe_hw_ipsec_tx_sa_load(hw, sa_idx);
+}
+
+static void sxe_hw_ipsec_sec_data_stop(struct sxe_hw *hw, bool is_linkup)
+{
+	u32 tx_empty, rx_empty;
+	u32 limit;
+	u32 reg;
+
+	reg = SXE_REG_READ(hw, SXE_SECTXCTRL);
+	reg |= SXE_SECTXCTRL_TX_DIS;
+	SXE_REG_WRITE(hw, SXE_SECTXCTRL, reg);
+
+	reg = SXE_REG_READ(hw, SXE_SECRXCTRL);
+	reg |= SXE_SECRXCTRL_RX_DIS;
+	SXE_REG_WRITE(hw, SXE_SECRXCTRL, reg);
+
+	tx_empty = SXE_REG_READ(hw, SXE_SECTXSTAT) & SXE_SECTXSTAT_SECTX_RDY;
+	rx_empty = SXE_REG_READ(hw, SXE_SECRXSTAT) & SXE_SECRXSTAT_SECRX_RDY;
+	if (tx_empty && rx_empty)
+		return;
+
+	if (!is_linkup) {
+		SXE_REG_WRITE(hw, SXE_LPBKCTRL, SXE_LPBKCTRL_EN);
+
+		SXE_WRITE_FLUSH(hw);
+		mdelay(3);
+	}
+
+	limit = 20;
+	do {
+		mdelay(10);
+		tx_empty = SXE_REG_READ(hw, SXE_SECTXSTAT) &
+			SXE_SECTXSTAT_SECTX_RDY;
+	   rx_empty = SXE_REG_READ(hw, SXE_SECRXSTAT) &
+			SXE_SECRXSTAT_SECRX_RDY;
+	} while (!(tx_empty && rx_empty) && limit--);
+
+	if (!is_linkup) {
+		SXE_REG_WRITE(hw, SXE_LPBKCTRL, 0);
+
+		SXE_WRITE_FLUSH(hw);
+	}
+}
+
+static void sxe_hw_ipsec_engine_start(struct sxe_hw *hw, bool is_linkup)
+{
+	u32 reg;
+
+	sxe_hw_ipsec_sec_data_stop(hw, is_linkup);
+
+	reg = SXE_REG_READ(hw, SXE_SECTXMINIFG);
+	reg = (reg & 0xfffffff0) | 0x3;
+	SXE_REG_WRITE(hw, SXE_SECTXMINIFG, reg);
+
+	reg = SXE_REG_READ(hw, SXE_SECTXBUFFAF);
+	reg = (reg & 0xfffffc00) | 0x15;
+	SXE_REG_WRITE(hw, SXE_SECTXBUFFAF, reg);
+
+	SXE_REG_WRITE(hw, SXE_SECRXCTRL, 0);
+	SXE_REG_WRITE(hw, SXE_SECTXCTRL, SXE_SECTXCTRL_STORE_FORWARD);
+
+	SXE_REG_WRITE(hw, SXE_IPSTXIDX, SXE_RXTXIDX_IPS_EN);
+	SXE_REG_WRITE(hw, SXE_IPSRXIDX, SXE_RXTXIDX_IPS_EN);
+
+	SXE_WRITE_FLUSH(hw);
+}
+
+static void sxe_hw_ipsec_engine_stop(struct sxe_hw *hw, bool is_linkup)
+{
+	u32 reg;
+
+	sxe_hw_ipsec_sec_data_stop(hw, is_linkup);
+
+	SXE_REG_WRITE(hw, SXE_IPSTXIDX, 0);
+	SXE_REG_WRITE(hw, SXE_IPSRXIDX, 0);
+
+	reg = SXE_REG_READ(hw, SXE_SECTXCTRL);
+	reg |= SXE_SECTXCTRL_SECTX_DIS;
+	reg &= ~SXE_SECTXCTRL_STORE_FORWARD;
+	SXE_REG_WRITE(hw, SXE_SECTXCTRL, reg);
+
+	reg = SXE_REG_READ(hw, SXE_SECRXCTRL);
+	reg |= SXE_SECRXCTRL_SECRX_DIS;
+	SXE_REG_WRITE(hw, SXE_SECRXCTRL, reg);
+
+	SXE_REG_WRITE(hw, SXE_SECTXBUFFAF, 0x250);
+
+	reg = SXE_REG_READ(hw, SXE_SECTXMINIFG);
+	reg = (reg & 0xfffffff0) | 0x1;
+	SXE_REG_WRITE(hw, SXE_SECTXMINIFG, reg);
+
+	SXE_REG_WRITE(hw, SXE_SECTXCTRL, SXE_SECTXCTRL_SECTX_DIS);
+	SXE_REG_WRITE(hw, SXE_SECRXCTRL, SXE_SECRXCTRL_SECRX_DIS);
+
+	SXE_WRITE_FLUSH(hw);
+}
+
+bool sxe_hw_ipsec_offload_is_disable(struct sxe_hw *hw)
+{
+	u32 tx_dis = SXE_REG_READ(hw, SXE_SECTXSTAT);
+	u32 rx_dis = SXE_REG_READ(hw, SXE_SECRXSTAT);
+	bool ret = false;
+
+	if ((tx_dis & SXE_SECTXSTAT_SECTX_OFF_DIS) ||
+		(rx_dis & SXE_SECRXSTAT_SECRX_OFF_DIS)) {
+		ret = true;
+	}
+
+	return ret;
+}
+
+void sxe_hw_ipsec_sa_disable(struct sxe_hw *hw)
+{
+	SXE_REG_WRITE(hw, SXE_IPSRXIDX, 0);
+	SXE_REG_WRITE(hw, SXE_IPSTXIDX, 0);
+}
+
+static const struct sxe_sec_operations sxe_sec_ops = {
+	.ipsec_rx_ip_store		= sxe_hw_ipsec_rx_ip_store,
+	.ipsec_rx_spi_store		= sxe_hw_ipsec_rx_spi_store,
+	.ipsec_rx_key_store		= sxe_hw_ipsec_rx_key_store,
+	.ipsec_tx_key_store		= sxe_hw_ipsec_tx_key_store,
+	.ipsec_sec_data_stop		= sxe_hw_ipsec_sec_data_stop,
+	.ipsec_engine_start		= sxe_hw_ipsec_engine_start,
+	.ipsec_engine_stop		= sxe_hw_ipsec_engine_stop,
+	.ipsec_sa_disable		= sxe_hw_ipsec_sa_disable,
+	.ipsec_offload_is_disable	= sxe_hw_ipsec_offload_is_disable,
+};
+#endif
+
+static const struct sxe_sec_operations sxe_sec_ops = { 0 };
+
+
+void sxe_hw_stats_regs_clean(struct sxe_hw *hw)
+{
+	u16 i;
+	for (i = 0; i < 16; i++) {
+		SXE_REG_READ(hw, SXE_QPTC(i));
+		SXE_REG_READ(hw, SXE_QPRC(i));
+		SXE_REG_READ(hw, SXE_QBTC_H(i));
+		SXE_REG_READ(hw, SXE_QBTC_L(i));
+		SXE_REG_READ(hw, SXE_QBRC_H(i));
+		SXE_REG_READ(hw, SXE_QBRC_L(i));
+		SXE_REG_READ(hw, SXE_QPRDC(i));
+	}
+
+	SXE_REG_READ(hw, SXE_RXDGBCH);
+	SXE_REG_READ(hw, SXE_RXDGBCL);
+	SXE_REG_READ(hw, SXE_RXDGPC);
+	SXE_REG_READ(hw, SXE_TXDGPC);
+	SXE_REG_READ(hw, SXE_TXDGBCH);
+	SXE_REG_READ(hw, SXE_TXDGBCL);
+	SXE_REG_READ(hw, SXE_RXDDGPC);
+	SXE_REG_READ(hw, SXE_RXDDGBCH);
+	SXE_REG_READ(hw, SXE_RXDDGBCL);
+	SXE_REG_READ(hw, SXE_RXLPBKGPC);
+	SXE_REG_READ(hw, SXE_RXLPBKGBCH);
+	SXE_REG_READ(hw, SXE_RXLPBKGBCL);
+	SXE_REG_READ(hw, SXE_RXDLPBKGPC);
+	SXE_REG_READ(hw, SXE_RXDLPBKGBCH);
+	SXE_REG_READ(hw, SXE_RXDLPBKGBCL);
+	SXE_REG_READ(hw, SXE_RXTPCIN);
+	SXE_REG_READ(hw, SXE_RXTPCOUT);
+	SXE_REG_READ(hw, SXE_RXPRDDC);
+	SXE_REG_READ(hw, SXE_TXSWERR);
+	SXE_REG_READ(hw, SXE_TXSWITCH);
+	SXE_REG_READ(hw, SXE_TXREPEAT);
+	SXE_REG_READ(hw, SXE_TXDESCERR);
+
+	SXE_REG_READ(hw, SXE_CRCERRS);
+	SXE_REG_READ(hw, SXE_ERRBC);
+	SXE_REG_READ(hw, SXE_RLEC);
+	SXE_REG_READ(hw, SXE_PRC64);
+	SXE_REG_READ(hw, SXE_PRC127);
+	SXE_REG_READ(hw, SXE_PRC255);
+	SXE_REG_READ(hw, SXE_PRC511);
+	SXE_REG_READ(hw, SXE_PRC1023);
+	SXE_REG_READ(hw, SXE_PRC1522);
+	SXE_REG_READ(hw, SXE_GPRC);
+	SXE_REG_READ(hw, SXE_BPRC);
+	SXE_REG_READ(hw, SXE_MPRC);
+	SXE_REG_READ(hw, SXE_GPTC);
+	SXE_REG_READ(hw, SXE_GORCL);
+	SXE_REG_READ(hw, SXE_GORCH);
+	SXE_REG_READ(hw, SXE_GOTCL);
+	SXE_REG_READ(hw, SXE_GOTCH);
+	SXE_REG_READ(hw, SXE_RUC);
+	SXE_REG_READ(hw, SXE_RFC);
+	SXE_REG_READ(hw, SXE_ROC);
+	SXE_REG_READ(hw, SXE_RJC);
+	for (i = 0; i < 8; i++)
+		SXE_REG_READ(hw, SXE_PRCPF(i));
+
+	SXE_REG_READ(hw, SXE_TORL);
+	SXE_REG_READ(hw, SXE_TORH);
+	SXE_REG_READ(hw, SXE_TPR);
+	SXE_REG_READ(hw, SXE_TPT);
+	SXE_REG_READ(hw, SXE_PTC64);
+	SXE_REG_READ(hw, SXE_PTC127);
+	SXE_REG_READ(hw, SXE_PTC255);
+	SXE_REG_READ(hw, SXE_PTC511);
+	SXE_REG_READ(hw, SXE_PTC1023);
+	SXE_REG_READ(hw, SXE_PTC1522);
+	SXE_REG_READ(hw, SXE_MPTC);
+	SXE_REG_READ(hw, SXE_BPTC);
+	for (i = 0; i < 8; i++)
+		SXE_REG_READ(hw, SXE_PFCT(i));
+}
+
+static void sxe_hw_stats_seq_get(struct sxe_hw *hw, struct sxe_mac_stats *stats)
+{
+	u8 i;
+	u64 tx_pfc_num = 0;
+#ifdef SXE_DPDK
+	u64 gotch = 0;
+	u32 rycle_cnt = 10;
+#endif
+
+	for (i = 0; i < 8; i++) {
+		stats->prcpf[i] += SXE_REG_READ(hw, SXE_PRCPF(i));
+		tx_pfc_num = SXE_REG_READ(hw, SXE_PFCT(i));
+		stats->pfct[i] += tx_pfc_num;
+		stats->total_tx_pause += tx_pfc_num;
+	}
+
+	stats->total_gptc += SXE_REG_READ(hw, SXE_GPTC);
+	stats->total_gotc += (SXE_REG_READ(hw, SXE_GOTCL) |
+			((u64)SXE_REG_READ(hw, SXE_GOTCH) << 32));
+#ifdef SXE_DPDK
+	do {
+		gotch = SXE_REG_READ(hw, SXE_GOTCH);
+		rycle_cnt--;
+	} while (gotch != 0 && rycle_cnt != 0);
+	if (gotch != 0)
+		LOG_INFO("GOTCH is not clear!");
+#endif
+}
+
+void sxe_hw_stats_seq_clean(struct sxe_hw *hw, struct sxe_mac_stats *stats)
+{
+	u8 i;
+	u64 tx_pfc_num = 0;
+	u64 gotch = 0;
+	u32 rycle_cnt = 10;
+
+	stats->total_gotc += (SXE_REG_READ(hw, SXE_GOTCL) |
+			((u64)SXE_REG_READ(hw, SXE_GOTCH) << 32));
+	stats->total_gptc += SXE_REG_READ(hw, SXE_GPTC);
+	do {
+		gotch = SXE_REG_READ(hw, SXE_GOTCH);
+		rycle_cnt--;
+	} while (gotch != 0 && rycle_cnt != 0);
+	if (gotch != 0)
+		LOG_INFO("GOTCH is not clear!");
+
+	for (i = 0; i < 8; i++) {
+		stats->prcpf[i] += SXE_REG_READ(hw, SXE_PRCPF(i));
+		tx_pfc_num = SXE_REG_READ(hw, SXE_PFCT(i));
+		stats->pfct[i] += tx_pfc_num;
+		stats->total_tx_pause += tx_pfc_num;
+	}
+}
+
+void sxe_hw_stats_get(struct sxe_hw *hw, struct sxe_mac_stats *stats)
+{
+	u64 rjc;
+	u32 i, rx_dbu_drop, ring_drop = 0;
+	u64 tpr = 0;
+#ifdef SXE_DPDK
+	u32 rycle_cnt = 10;
+	u64 gorch, torh = 0;
+#endif
+
+	for (i = 0; i < 16; i++) {
+		stats->qptc[i] += SXE_REG_READ(hw, SXE_QPTC(i));
+		stats->qprc[i] += SXE_REG_READ(hw, SXE_QPRC(i));
+		ring_drop = SXE_REG_READ(hw, SXE_QPRDC(i));
+		stats->qprdc[i] += ring_drop;
+		stats->hw_rx_no_dma_resources += ring_drop;
+
+		stats->qbtc[i] += ((u64)SXE_REG_READ(hw, SXE_QBTC_H(i)) << 32);
+		SXE_RMB();
+		stats->qbtc[i] += SXE_REG_READ(hw, SXE_QBTC_L(i));
+
+		stats->qbrc[i] += ((u64)SXE_REG_READ(hw, SXE_QBRC_H(i)) << 32);
+		SXE_RMB();
+		stats->qbrc[i] += SXE_REG_READ(hw, SXE_QBRC_L(i));
+	}
+	stats->rxdgbc += ((u64)SXE_REG_READ(hw, SXE_RXDGBCH) << 32) +
+				(SXE_REG_READ(hw, SXE_RXDGBCL));
+
+	stats->rxdgpc += SXE_REG_READ(hw, SXE_RXDGPC);
+	stats->txdgpc += SXE_REG_READ(hw, SXE_TXDGPC);
+	stats->txdgbc += (((u64)SXE_REG_READ(hw, SXE_TXDGBCH) << 32) +
+				SXE_REG_READ(hw, SXE_TXDGBCL));
+
+	stats->rxddpc += SXE_REG_READ(hw, SXE_RXDDGPC);
+	stats->rxddbc += ((u64)SXE_REG_READ(hw, SXE_RXDDGBCH) << 32) +
+				(SXE_REG_READ(hw, SXE_RXDDGBCL));
+
+	stats->rxlpbkpc += SXE_REG_READ(hw, SXE_RXLPBKGPC);
+	stats->rxlpbkbc += ((u64)SXE_REG_READ(hw, SXE_RXLPBKGBCH) << 32) +
+			(SXE_REG_READ(hw, SXE_RXLPBKGBCL));
+
+	stats->rxdlpbkpc += SXE_REG_READ(hw, SXE_RXDLPBKGPC);
+	stats->rxdlpbkbc += ((u64)SXE_REG_READ(hw, SXE_RXDLPBKGBCH) << 32) +
+				(SXE_REG_READ(hw, SXE_RXDLPBKGBCL));
+	stats->rxtpcing += SXE_REG_READ(hw, SXE_RXTPCIN);
+	stats->rxtpceng += SXE_REG_READ(hw, SXE_RXTPCOUT);
+	stats->prddc += SXE_REG_READ(hw, SXE_RXPRDDC);
+	stats->txswerr += SXE_REG_READ(hw, SXE_TXSWERR);
+	stats->txswitch += SXE_REG_READ(hw, SXE_TXSWITCH);
+	stats->txrepeat += SXE_REG_READ(hw, SXE_TXREPEAT);
+	stats->txdescerr += SXE_REG_READ(hw, SXE_TXDESCERR);
+
+	for (i = 0; i < 8; i++) {
+		stats->dburxtcin[i] += SXE_REG_READ(hw, SXE_DBUDRTCICNT(i));
+		stats->dburxtcout[i] += SXE_REG_READ(hw, SXE_DBUDRTCOCNT(i));
+		stats->dburxgdreecnt[i] += SXE_REG_READ(hw, SXE_DBUDREECNT(i));
+		rx_dbu_drop = SXE_REG_READ(hw, SXE_DBUDROFPCNT(i));
+		stats->dburxdrofpcnt[i] += rx_dbu_drop;
+		stats->dbutxtcin[i] += SXE_REG_READ(hw, SXE_DBUDTTCICNT(i));
+		stats->dbutxtcout[i] += SXE_REG_READ(hw, SXE_DBUDTTCOCNT(i));
+	}
+
+	stats->fnavadd += (SXE_REG_READ(hw, SXE_FNAVUSTAT) & 0xFFFF);
+	stats->fnavrmv += ((SXE_REG_READ(hw, SXE_FNAVUSTAT) >> 16) & 0xFFFF);
+	stats->fnavadderr += (SXE_REG_READ(hw, SXE_FNAVFSTAT) & 0xFFFF);
+	stats->fnavrmverr += ((SXE_REG_READ(hw, SXE_FNAVFSTAT) >> 16) & 0xFFFF);
+	stats->fnavmatch += SXE_REG_READ(hw, SXE_FNAVMATCH);
+	stats->fnavmiss += SXE_REG_READ(hw, SXE_FNAVMISS);
+
+	sxe_hw_stats_seq_get(hw, stats);
+
+	stats->crcerrs += SXE_REG_READ(hw, SXE_CRCERRS);
+	stats->errbc   += SXE_REG_READ(hw, SXE_ERRBC);
+	stats->bprc += SXE_REG_READ(hw, SXE_BPRC);
+	stats->mprc += SXE_REG_READ(hw, SXE_MPRC);
+	stats->roc += SXE_REG_READ(hw, SXE_ROC);
+	stats->prc64 += SXE_REG_READ(hw, SXE_PRC64);
+	stats->prc127 += SXE_REG_READ(hw, SXE_PRC127);
+	stats->prc255 += SXE_REG_READ(hw, SXE_PRC255);
+	stats->prc511 += SXE_REG_READ(hw, SXE_PRC511);
+	stats->prc1023 += SXE_REG_READ(hw, SXE_PRC1023);
+	stats->prc1522 += SXE_REG_READ(hw, SXE_PRC1522);
+	stats->rlec += SXE_REG_READ(hw, SXE_RLEC);
+	stats->mptc += SXE_REG_READ(hw, SXE_MPTC);
+	stats->ruc += SXE_REG_READ(hw, SXE_RUC);
+	stats->rfc += SXE_REG_READ(hw, SXE_RFC);
+
+	rjc = SXE_REG_READ(hw, SXE_RJC);
+	stats->rjc += rjc;
+	stats->roc += rjc;
+
+	tpr = SXE_REG_READ(hw, SXE_TPR);
+	stats->tpr += tpr;
+	stats->tpt += SXE_REG_READ(hw, SXE_TPT);
+	stats->ptc64 += SXE_REG_READ(hw, SXE_PTC64);
+	stats->ptc127 += SXE_REG_READ(hw, SXE_PTC127);
+	stats->ptc255 += SXE_REG_READ(hw, SXE_PTC255);
+	stats->ptc511 += SXE_REG_READ(hw, SXE_PTC511);
+	stats->ptc1023 += SXE_REG_READ(hw, SXE_PTC1023);
+	stats->ptc1522 += SXE_REG_READ(hw, SXE_PTC1522);
+	stats->bptc += SXE_REG_READ(hw, SXE_BPTC);
+
+	stats->gprc += SXE_REG_READ(hw, SXE_GPRC);
+	stats->gorc += (SXE_REG_READ(hw, SXE_GORCL) |
+			((u64)SXE_REG_READ(hw, SXE_GORCH) << 32));
+#ifdef SXE_DPDK
+	do {
+		gorch = SXE_REG_READ(hw, SXE_GORCH);
+		rycle_cnt--;
+	} while (gorch != 0 && rycle_cnt != 0);
+	if (gorch != 0)
+		LOG_INFO("GORCH is not clear!");
+#endif
+
+	stats->tor += (SXE_REG_READ(hw, SXE_TORL) |
+			((u64)SXE_REG_READ(hw, SXE_TORH) << 32));
+#ifdef SXE_DPDK
+	rycle_cnt = 10;
+	do {
+		torh = SXE_REG_READ(hw, SXE_TORH);
+		rycle_cnt--;
+	} while (torh != 0 && rycle_cnt != 0);
+	if (torh != 0)
+		LOG_INFO("TORH is not clear!");
+#endif
+
+#ifdef SXE_DPDK
+	stats->tor -= tpr * RTE_ETHER_CRC_LEN;
+	stats->gptc = stats->total_gptc - stats->total_tx_pause;
+	stats->gotc = stats->total_gotc - stats->total_tx_pause * RTE_ETHER_MIN_LEN
+			- stats->gptc * RTE_ETHER_CRC_LEN;
+#else
+	stats->gptc = stats->total_gptc;
+	stats->gotc = stats->total_gotc;
+#endif
+}
+
+static u32 sxe_hw_tx_packets_num_get(struct sxe_hw *hw)
+{
+	return SXE_REG_READ(hw, SXE_TXDGPC);
+}
+
+static u32 sxe_hw_unsec_packets_num_get(struct sxe_hw *hw)
+{
+	return SXE_REG_READ(hw, SXE_SSVPC);
+}
+
+static u32 sxe_hw_mac_stats_dump(struct sxe_hw *hw, u32 *regs_buff, u32 buf_size)
+{
+	u32 i;
+	u32 regs_num = buf_size / sizeof(u32);
+
+	for (i = 0; i < regs_num; i++)
+		regs_buff[i] = SXE_REG_READ(hw, sxe_mac_regs[i]);
+
+	return i;
+}
+
+static u32 sxe_hw_tx_dbu_to_mac_stats(struct sxe_hw *hw)
+{
+	return SXE_REG_READ(hw, SXE_DTMPCNT);
+}
+
+static const struct sxe_stat_operations sxe_stat_ops = {
+	.stats_get			= sxe_hw_stats_get,
+	.stats_clear			= sxe_hw_stats_regs_clean,
+	.mac_stats_dump			= sxe_hw_mac_stats_dump,
+	.tx_packets_num_get		= sxe_hw_tx_packets_num_get,
+	.unsecurity_packets_num_get	= sxe_hw_unsec_packets_num_get,
+	.tx_dbu_to_mac_stats		= sxe_hw_tx_dbu_to_mac_stats,
+};
+
+void sxe_hw_mbx_init(struct sxe_hw *hw)
+{
+	hw->mbx.msg_len = SXE_MBX_MSG_NUM;
+	hw->mbx.interval = SXE_MBX_RETRY_INTERVAL;
+	hw->mbx.retry = SXE_MBX_RETRY_COUNT;
+
+	hw->mbx.stats.rcv_msgs   = 0;
+	hw->mbx.stats.send_msgs  = 0;
+	hw->mbx.stats.acks	   = 0;
+	hw->mbx.stats.reqs	   = 0;
+	hw->mbx.stats.rsts	   = 0;
+}
+
+static bool sxe_hw_vf_irq_check(struct sxe_hw *hw, u32 mask, u32 index)
+{
+	u32 value = SXE_REG_READ(hw, SXE_PFMBICR(index));
+
+	if (value & mask) {
+		SXE_REG_WRITE(hw, SXE_PFMBICR(index), mask);
+		return true;
+	}
+
+	return false;
+}
+
+bool sxe_hw_vf_rst_check(struct sxe_hw *hw, u8 vf_idx)
+{
+	u32 index = vf_idx >> 5;
+	u32 bit = vf_idx % 32;
+	u32 value;
+
+	value = SXE_REG_READ(hw, SXE_VFLRE(index));
+	if (value & BIT(bit)) {
+		SXE_REG_WRITE(hw, SXE_VFLREC(index), BIT(bit));
+		hw->mbx.stats.rsts++;
+		return true;
+	}
+
+	return false;
+}
+
+bool sxe_hw_vf_req_check(struct sxe_hw *hw, u8 vf_idx)
+{
+	u8 index = vf_idx >> 4;
+	u8 bit = vf_idx % 16;
+
+	if (sxe_hw_vf_irq_check(hw, SXE_PFMBICR_VFREQ << bit, index)) {
+		hw->mbx.stats.reqs++;
+		return true;
+	}
+
+	return false;
+}
+
+bool sxe_hw_vf_ack_check(struct sxe_hw *hw, u8 vf_idx)
+{
+	u8 index = vf_idx >> 4;
+	u8 bit = vf_idx % 16;
+
+	if (sxe_hw_vf_irq_check(hw, SXE_PFMBICR_VFACK << bit, index)) {
+		hw->mbx.stats.acks++;
+		return true;
+	}
+
+	return false;
+}
+
+static bool sxe_hw_mbx_lock(struct sxe_hw *hw, u8 vf_idx)
+{
+	u32 value;
+	bool ret = false;
+	u32 retry = hw->mbx.retry;
+
+	while (retry--) {
+		SXE_REG_WRITE(hw, SXE_PFMAILBOX(vf_idx), SXE_PFMAILBOX_PFU);
+
+		value = SXE_REG_READ(hw, SXE_PFMAILBOX(vf_idx));
+		if (value & SXE_PFMAILBOX_PFU) {
+			ret = true;
+			break;
+		}
+
+		sxe_udelay(hw->mbx.interval);
+	}
+
+	return ret;
+}
+
+s32 sxe_hw_rcv_msg_from_vf(struct sxe_hw *hw, u32 *msg,
+				u16 msg_len, u16 index)
+{
+	struct sxe_mbx_info *mbx = &hw->mbx;
+	u8 i;
+	s32 ret = 0;
+	u16 msg_entry;
+	struct sxe_adapter *adapter = hw->adapter;
+
+	msg_entry = (msg_len > mbx->msg_len) ? mbx->msg_len : msg_len;
+
+	if (!sxe_hw_mbx_lock(hw, index)) {
+		ret = -SXE_ERR_MBX_LOCK_FAIL;
+		LOG_ERROR_BDF("vf idx:%d msg_len:%d rcv lock mailbox fail.(err:%d)",
+			   index, msg_len, ret);
+		goto l_out;
+	}
+
+	for (i = 0; i < msg_entry; i++) {
+		msg[i] = SXE_REG_READ(hw, (SXE_PFMBMEM(index) + (i << 2)));
+		LOG_DEBUG_BDF("vf_idx:%u read mbx mem[%u]:0x%x.",
+				  index, i, msg[i]);
+	}
+
+	SXE_REG_WRITE(hw, SXE_PFMAILBOX(index), SXE_PFMAILBOX_ACK);
+	mbx->stats.rcv_msgs++;
+
+l_out:
+	return ret;
+}
+
+s32 sxe_hw_send_msg_to_vf(struct sxe_hw *hw, u32 *msg,
+				u16 msg_len, u16 index)
+{
+	struct sxe_mbx_info *mbx = &hw->mbx;
+	u8 i;
+	s32 ret = 0;
+	u32 old;
+	struct sxe_adapter *adapter = hw->adapter;
+
+	if (msg_len > mbx->msg_len) {
+		ret = -EINVAL;
+		LOG_ERROR_BDF("pf reply msg num:%d exceed limit:%d reply fail.(err:%d)",
+			  msg_len, mbx->msg_len, ret);
+		goto l_out;
+	}
+
+	if (!sxe_hw_mbx_lock(hw, index)) {
+		ret = -SXE_ERR_MBX_LOCK_FAIL;
+		LOG_ERROR_BDF("send msg len:%u to vf idx:%u msg[0]:0x%x "
+			   "lock mailbox fail.(err:%d)",
+			   msg_len, index, msg[0], ret);
+		goto l_out;
+	}
+
+	old = SXE_REG_READ(hw, (SXE_PFMBMEM(index)));
+	LOG_DEBUG_BDF("original send msg:0x%x. mbx mem[0]:0x%x", *msg, old);
+	if (msg[0] & SXE_CTRL_MSG_MASK)
+		msg[0] |= (old & SXE_MSGID_MASK);
+	else
+		msg[0] |= (old & SXE_PFMSG_MASK);
+
+	for (i = 0; i < msg_len; i++) {
+		SXE_REG_WRITE(hw, (SXE_PFMBMEM(index) + (i << 2)), msg[i]);
+		LOG_DEBUG_BDF("vf_idx:%u write mbx mem[%u]:0x%x.",
+				  index, i, msg[i]);
+	}
+
+	SXE_REG_WRITE(hw, SXE_PFMAILBOX(index), SXE_PFMAILBOX_STS);
+	mbx->stats.send_msgs++;
+
+l_out:
+	return ret;
+}
+
+void sxe_hw_mbx_mem_clear(struct sxe_hw *hw, u8 vf_idx)
+{
+	u8 msg_idx;
+	struct sxe_adapter *adapter = hw->adapter;
+	for (msg_idx = 0; msg_idx < hw->mbx.msg_len; msg_idx++)
+		SXE_REG_WRITE_ARRAY(hw, SXE_PFMBMEM(vf_idx), msg_idx, 0);
+
+	SXE_WRITE_FLUSH(hw);
+
+	LOG_INFO_BDF("vf_idx:%u clear mbx mem.", vf_idx);
+}
+
+static const struct sxe_mbx_operations sxe_mbx_ops = {
+	.init		= sxe_hw_mbx_init,
+
+	.req_check	= sxe_hw_vf_req_check,
+	.ack_check	= sxe_hw_vf_ack_check,
+	.rst_check	= sxe_hw_vf_rst_check,
+
+	.msg_send	= sxe_hw_send_msg_to_vf,
+	.msg_rcv	= sxe_hw_rcv_msg_from_vf,
+
+	.mbx_mem_clear	= sxe_hw_mbx_mem_clear,
+};
+
+void sxe_hw_pcie_vt_mode_set(struct sxe_hw *hw, u32 value)
+{
+	SXE_REG_WRITE(hw, SXE_GCR_EXT, value);
+}
+
+static const struct sxe_pcie_operations sxe_pcie_ops = {
+	.vt_mode_set	= sxe_hw_pcie_vt_mode_set,
+};
+
+s32 sxe_hw_hdc_lock_get(struct sxe_hw *hw, u32 trylock)
+{
+	u32 val;
+	u16 i;
+	s32 ret = 0;
+	struct sxe_adapter *adapter = hw->adapter;
+
+	SXE_REG_WRITE(hw, SXE_HDC_SW_LK, SXE_HDC_RELEASE_SW_LK);
+	SXE_WRITE_FLUSH(hw);
+
+	for (i = 0; i < trylock; i++) {
+		val = SXE_REG_READ(hw, SXE_HDC_SW_LK) & SXE_HDC_SW_LK_BIT;
+		if (!val)
+			break;
+
+		sxe_udelay(10);
+	}
+
+	if (i >= trylock) {
+		LOG_ERROR_BDF("hdc is busy, reg: 0x%x", val);
+		ret = -SXE_ERR_HDC_LOCK_BUSY;
+		goto l_out;
+	}
+
+	val = SXE_REG_READ(hw, SXE_HDC_PF_LK) & SXE_HDC_PF_LK_BIT;
+	if (!val) {
+		SXE_REG_WRITE(hw, SXE_HDC_SW_LK, SXE_HDC_RELEASE_SW_LK);
+		LOG_ERROR_BDF("get hdc lock fail, reg: 0x%x", val);
+		ret = -SXE_ERR_HDC_LOCK_BUSY;
+		goto l_out;
+	}
+
+	hw->hdc.pf_lock_val = val;
+	LOG_DEBUG_BDF("hw[%p]'s port[%u] got pf lock", hw, val);
+
+l_out:
+	return ret;
+}
+
+void sxe_hw_hdc_lock_release(struct sxe_hw *hw, u32 retry_cnt)
+{
+	struct sxe_adapter *adapter = hw->adapter;
+
+	do {
+		SXE_REG_WRITE(hw, SXE_HDC_SW_LK, SXE_HDC_RELEASE_SW_LK);
+		sxe_udelay(1);
+		if (!(SXE_REG_READ(hw, SXE_HDC_PF_LK) & hw->hdc.pf_lock_val)) {
+			LOG_DEBUG_BDF("hw[%p]'s port[%u] release pf lock", hw,
+				hw->hdc.pf_lock_val);
+			hw->hdc.pf_lock_val = 0;
+			break;
+		}
+	} while ((retry_cnt--) > 0);
+}
+
+void sxe_hw_hdc_fw_ov_clear(struct sxe_hw *hw)
+{
+	SXE_REG_WRITE(hw, SXE_HDC_FW_OV, 0);
+}
+
+bool sxe_hw_hdc_is_fw_over_set(struct sxe_hw *hw)
+{
+	bool fw_ov = false;
+
+	if (SXE_REG_READ(hw, SXE_HDC_FW_OV) & SXE_HDC_FW_OV_BIT)
+		fw_ov = true;
+
+	return fw_ov;
+}
+
+void sxe_hw_hdc_packet_send_done(struct sxe_hw *hw)
+{
+	SXE_REG_WRITE(hw, SXE_HDC_SW_OV, SXE_HDC_SW_OV_BIT);
+	SXE_WRITE_FLUSH(hw);
+}
+
+void sxe_hw_hdc_packet_header_send(struct sxe_hw *hw, u32 value)
+{
+	SXE_REG_WRITE(hw, SXE_HDC_PACKET_HEAD0, value);
+}
+
+void sxe_hw_hdc_packet_data_dword_send(struct sxe_hw *hw,
+						u16 dword_index, u32 value)
+{
+	SXE_WRITE_REG_ARRAY_32(hw, SXE_HDC_PACKET_DATA0, dword_index, value);
+}
+
+u32 sxe_hw_hdc_fw_ack_header_get(struct sxe_hw *hw)
+{
+	return SXE_REG_READ(hw, SXE_HDC_PACKET_HEAD0);
+}
+
+u32 sxe_hw_hdc_packet_data_dword_rcv(struct sxe_hw *hw,
+						u16 dword_index)
+{
+	return SXE_READ_REG_ARRAY_32(hw, SXE_HDC_PACKET_DATA0, dword_index);
+}
+
+u32 sxe_hw_hdc_fw_status_get(struct sxe_hw *hw)
+{
+	struct sxe_adapter *adapter = hw->adapter;
+	u32 status = SXE_REG_READ(hw, SXE_FW_STATUS_REG);
+
+	LOG_DEBUG_BDF("fw status[0x%x]", status);
+
+	return status;
+}
+
+void sxe_hw_hdc_drv_status_set(struct sxe_hw *hw, u32 value)
+{
+	SXE_REG_WRITE(hw, SXE_DRV_STATUS_REG, value);
+}
+
+u32 sxe_hw_hdc_channel_state_get(struct sxe_hw *hw)
+{
+	struct sxe_adapter *adapter = hw->adapter;
+
+	u32 state = SXE_REG_READ(hw, SXE_FW_HDC_STATE_REG);
+
+	LOG_DEBUG_BDF("hdc channel state[0x%x]", state);
+
+	return state;
+}
+
+static u32 sxe_hw_hdc_irq_event_get(struct sxe_hw *hw)
+{
+	u32 status = SXE_REG_READ(hw, SXE_HDC_MSI_STATUS_REG);
+	struct sxe_adapter *adapter = hw->adapter;
+
+	LOG_DEBUG_BDF("msi status[0x%x]", status);
+
+	return status;
+}
+
+static void sxe_hw_hdc_irq_event_clear(struct sxe_hw *hw, u32 event)
+{
+	u32 status = SXE_REG_READ(hw, SXE_HDC_MSI_STATUS_REG);
+	struct sxe_adapter *adapter = hw->adapter;
+
+	LOG_DEBUG_BDF("msi status[0x%x] and clear bit=[0x%x]", status, event);
+
+	status &= ~event;
+	SXE_REG_WRITE(hw, SXE_HDC_MSI_STATUS_REG, status);
+}
+
+static void sxe_hw_hdc_resource_clean(struct sxe_hw *hw)
+{
+	u16 i;
+
+	SXE_REG_WRITE(hw, SXE_HDC_SW_LK, 0x0);
+	SXE_REG_WRITE(hw, SXE_HDC_PACKET_HEAD0, 0x0);
+	for (i = 0; i < SXE_HDC_DATA_LEN_MAX; i++)
+		SXE_WRITE_REG_ARRAY_32(hw, SXE_HDC_PACKET_DATA0, i, 0x0);
+}
+
+static const struct sxe_hdc_operations sxe_hdc_ops = {
+	.pf_lock_get			= sxe_hw_hdc_lock_get,
+	.pf_lock_release		= sxe_hw_hdc_lock_release,
+	.is_fw_over_set		 = sxe_hw_hdc_is_fw_over_set,
+	.fw_ack_header_rcv	  = sxe_hw_hdc_fw_ack_header_get,
+	.packet_send_done	   = sxe_hw_hdc_packet_send_done,
+	.packet_header_send	 = sxe_hw_hdc_packet_header_send,
+	.packet_data_dword_send = sxe_hw_hdc_packet_data_dword_send,
+	.packet_data_dword_rcv  = sxe_hw_hdc_packet_data_dword_rcv,
+	.fw_status_get		  = sxe_hw_hdc_fw_status_get,
+	.drv_status_set		 = sxe_hw_hdc_drv_status_set,
+	.irq_event_get		  = sxe_hw_hdc_irq_event_get,
+	.irq_event_clear		= sxe_hw_hdc_irq_event_clear,
+	.fw_ov_clear			= sxe_hw_hdc_fw_ov_clear,
+	.channel_state_get	  = sxe_hw_hdc_channel_state_get,
+	.resource_clean		 = sxe_hw_hdc_resource_clean,
+};
+
+#ifdef SXE_PHY_CONFIGURE
+#define SXE_MDIO_COMMAND_TIMEOUT 100
+
+static s32 sxe_hw_phy_reg_write(struct sxe_hw *hw, s32 prtad, u32 reg_addr,
+				u32 device_type, u16 phy_data)
+{
+	s32 ret;
+	u32 i, command;
+	struct sxe_adapter *adapter = hw->adapter;
+
+	SXE_REG_WRITE(hw, SXE_MSCD, (u32)phy_data);
+
+	command = ((reg_addr << SXE_MSCA_NP_ADDR_SHIFT)  |
+		   (device_type << SXE_MSCA_DEV_TYPE_SHIFT) |
+		   (prtad << SXE_MSCA_PHY_ADDR_SHIFT) |
+		   (SXE_MSCA_ADDR_CYCLE | SXE_MSCA_MDI_CMD_ON_PROG));
+
+	SXE_REG_WRITE(hw, SXE_MSCA, command);
+
+	for (i = 0; i < SXE_MDIO_COMMAND_TIMEOUT; i++) {
+		sxe_udelay(10);
+
+		command = SXE_REG_READ(hw, SXE_MSCA);
+		if ((command & SXE_MSCA_MDI_CMD_ON_PROG) == 0)
+			break;
+	}
+
+	if ((command & SXE_MSCA_MDI_CMD_ON_PROG) != 0) {
+		LOG_DEV_ERR("phy write cmd didn't complete, "
+			"reg_addr=%u, device_type=%u", reg_addr, device_type);
+		ret = -SXE_ERR_MDIO_CMD_TIMEOUT;
+		goto l_end;
+	}
+
+	command = ((reg_addr << SXE_MSCA_NP_ADDR_SHIFT)  |
+		   (device_type << SXE_MSCA_DEV_TYPE_SHIFT) |
+		   (prtad << SXE_MSCA_PHY_ADDR_SHIFT) |
+		   (SXE_MSCA_WRITE | SXE_MSCA_MDI_CMD_ON_PROG));
+
+	SXE_REG_WRITE(hw, SXE_MSCA, command);
+
+	for (i = 0; i < SXE_MDIO_COMMAND_TIMEOUT; i++) {
+		sxe_udelay(10);
+
+		command = SXE_REG_READ(hw, SXE_MSCA);
+		if ((command & SXE_MSCA_MDI_CMD_ON_PROG) == 0)
+			break;
+	}
+
+	if ((command & SXE_MSCA_MDI_CMD_ON_PROG) != 0) {
+		LOG_DEV_ERR("phy write cmd didn't complete, "
+			"reg_addr=%u, device_type=%u", reg_addr, device_type);
+		ret = -SXE_ERR_MDIO_CMD_TIMEOUT;
+	}
+
+l_end:
+	return ret;
+}
+
+static s32 sxe_hw_phy_reg_read(struct sxe_hw *hw, s32 prtad, u32 reg_addr,
+				u32 device_type, u16 *phy_data)
+{
+	s32 ret = 0;
+	u32 i, data, command;
+	struct sxe_adapter *adapter = hw->adapter;
+
+	command = ((reg_addr << SXE_MSCA_NP_ADDR_SHIFT)  |
+		   (device_type << SXE_MSCA_DEV_TYPE_SHIFT) |
+		   (prtad << SXE_MSCA_PHY_ADDR_SHIFT) |
+		   (SXE_MSCA_ADDR_CYCLE | SXE_MSCA_MDI_CMD_ON_PROG));
+
+	SXE_REG_WRITE(hw, SXE_MSCA, command);
+
+	for (i = 0; i < SXE_MDIO_COMMAND_TIMEOUT; i++) {
+		sxe_udelay(10);
+
+		command = SXE_REG_READ(hw, SXE_MSCA);
+		if ((command & SXE_MSCA_MDI_CMD_ON_PROG) == 0)
+			break;
+	}
+
+	if ((command & SXE_MSCA_MDI_CMD_ON_PROG) != 0) {
+		LOG_DEV_ERR("phy read cmd didn't complete, "
+			"reg_addr=%u, device_type=%u", reg_addr, device_type);
+		ret = -SXE_ERR_MDIO_CMD_TIMEOUT;
+		goto l_end;
+	}
+
+	command = ((reg_addr << SXE_MSCA_NP_ADDR_SHIFT)  |
+		   (device_type << SXE_MSCA_DEV_TYPE_SHIFT) |
+		   (prtad << SXE_MSCA_PHY_ADDR_SHIFT) |
+		   (SXE_MSCA_READ | SXE_MSCA_MDI_CMD_ON_PROG));
+
+	SXE_REG_WRITE(hw, SXE_MSCA, command);
+
+	for (i = 0; i < SXE_MDIO_COMMAND_TIMEOUT; i++) {
+		sxe_udelay(10);
+
+		command = SXE_REG_READ(hw, SXE_MSCA);
+		if ((command & SXE_MSCA_MDI_CMD_ON_PROG) == 0)
+			break;
+	}
+
+	if ((command & SXE_MSCA_MDI_CMD_ON_PROG) != 0) {
+		LOG_DEV_ERR("phy write cmd didn't complete, "
+			"reg_addr=%u, device_type=%u", reg_addr, device_type);
+		ret = -SXE_ERR_MDIO_CMD_TIMEOUT;
+		goto l_end;
+	}
+
+	data = SXE_REG_READ(hw, SXE_MSCD);
+	data >>= MDIO_MSCD_RDATA_SHIFT;
+	*phy_data = (u16)(data);
+
+l_end:
+	return ret;
+}
+
+#define SXE_PHY_REVISION_MASK		0x000F
+#define SXE_PHY_ID_HIGH_5_BIT_MASK	0xFC00
+#define SXE_PHY_ID_HIGH_SHIFT		10
+
+static s32 sxe_hw_phy_id_get(struct sxe_hw *hw, u32 prtad, u32 *id)
+{
+	s32 ret;
+	u16 phy_id_high = 0;
+	u16 phy_id_low = 0;
+
+
+	ret = sxe_hw_phy_reg_read(hw, prtad, MDIO_DEVID1, MDIO_MMD_PMAPMD,
+					  &phy_id_low);
+
+	if (ret) {
+		LOG_ERROR("get phy id upper 16 bits failed, prtad=%d", prtad);
+		goto l_end;
+	}
+
+	ret = sxe_hw_phy_reg_read(hw, prtad, MDIO_DEVID2, MDIO_MMD_PMAPMD,
+					&phy_id_high);
+	if (ret) {
+		LOG_ERROR("get phy id lower 4 bits failed, prtad=%d", prtad);
+		goto l_end;
+	}
+
+	*id = (u32)((phy_id_high >> SXE_PHY_ID_HIGH_SHIFT) << 16);
+	*id |= (u32)phy_id_low;
+
+l_end:
+	return ret;
+}
+
+s32 sxe_hw_phy_link_cap_get(struct sxe_hw *hw, u32 prtad, u32 *speed)
+{
+	s32 ret;
+	u16 speed_ability;
+
+	ret = hw->phy.ops->reg_read(hw, prtad, MDIO_SPEED, MDIO_MMD_PMAPMD,
+					  &speed_ability);
+	if (ret) {
+		*speed = 0;
+		LOG_ERROR("get phy link cap failed, ret=%d, prtad=%d",
+							ret, prtad);
+		goto l_end;
+	}
+
+	if (speed_ability & MDIO_SPEED_10G)
+		*speed |= SXE_LINK_SPEED_10GB_FULL;
+
+	if (speed_ability & MDIO_PMA_SPEED_1000)
+		*speed |= SXE_LINK_SPEED_1GB_FULL;
+
+	if (speed_ability & MDIO_PMA_SPEED_100)
+		*speed |= SXE_LINK_SPEED_100_FULL;
+
+l_end:
+	return ret;
+}
+
+static s32 sxe_hw_phy_ctrl_reset(struct sxe_hw *hw, u32 prtad)
+{
+	u32 i;
+	s32 ret;
+	u16 ctrl;
+
+	ret = sxe_hw_phy_reg_write(hw, prtad, MDIO_CTRL1,
+			 MDIO_MMD_PHYXS, MDIO_CTRL1_RESET);
+	if (ret) {
+		LOG_ERROR("phy reset failed, ret=%d", ret);
+		goto l_end;
+	}
+
+	for (i = 0; i < 30; i++) {
+		msleep(100);
+		ret = sxe_hw_phy_reg_read(hw, prtad, MDIO_CTRL1,
+					MDIO_MMD_PHYXS, &ctrl);
+		if (ret)
+			goto l_end;
+
+		if (!(ctrl & MDIO_CTRL1_RESET)) {
+			sxe_udelay(2);
+			break;
+		}
+	}
+
+	if (ctrl & MDIO_CTRL1_RESET) {
+		LOG_DEV_ERR("phy reset polling failed to complete");
+		return -SXE_ERR_PHY_RESET_FAIL;
+	}
+
+l_end:
+	return ret;
+}
+
+static const struct sxe_phy_operations sxe_phy_hw_ops = {
+	.reg_write	= sxe_hw_phy_reg_write,
+	.reg_read	= sxe_hw_phy_reg_read,
+	.identifier_get	= sxe_hw_phy_id_get,
+	.link_cap_get	= sxe_hw_phy_link_cap_get,
+	.reset		= sxe_hw_phy_ctrl_reset,
+};
+#endif
+
+void sxe_hw_ops_init(struct sxe_hw *hw)
+{
+	hw->setup.ops	= &sxe_setup_ops;
+	hw->irq.ops	= &sxe_irq_ops;
+	hw->mac.ops	= &sxe_mac_ops;
+	hw->dbu.ops	= &sxe_dbu_ops;
+	hw->dma.ops	= &sxe_dma_ops;
+	hw->sec.ops	= &sxe_sec_ops;
+	hw->stat.ops	= &sxe_stat_ops;
+	hw->mbx.ops	= &sxe_mbx_ops;
+	hw->pcie.ops	= &sxe_pcie_ops;
+	hw->hdc.ops	= &sxe_hdc_ops;
+#ifdef SXE_PHY_CONFIGURE
+	hw->phy.ops	 = &sxe_phy_hw_ops;
+#endif
+
+	hw->filter.mac.ops	= &sxe_filter_mac_ops;
+	hw->filter.vlan.ops	= &sxe_filter_vlan_ops;
+}
+
+u32 sxe_hw_rss_key_get_by_idx(struct sxe_hw *hw, u8 reg_idx)
+{
+	u32 rss_key;
+
+	if (reg_idx >= SXE_MAX_RSS_KEY_ENTRIES)
+		rss_key = 0;
+	else
+		rss_key = SXE_REG_READ(hw, SXE_RSSRK(reg_idx));
+
+	return rss_key;
+}
+
+bool sxe_hw_is_rss_enabled(struct sxe_hw *hw)
+{
+	bool rss_enable = false;
+	u32 mrqc = SXE_REG_READ(hw, SXE_MRQC);
+	if (mrqc & SXE_MRQC_RSSEN)
+		rss_enable = true;
+
+	return rss_enable;
+}
+
+static u32 sxe_hw_mrqc_reg_get(struct sxe_hw *hw)
+{
+	return SXE_REG_READ(hw, SXE_MRQC);
+}
+
+u32 sxe_hw_rss_field_get(struct sxe_hw *hw)
+{
+	u32 mrqc = sxe_hw_mrqc_reg_get(hw);
+	return (mrqc & SXE_RSS_FIELD_MASK);
+}
+
+#ifdef SXE_DPDK
+
+#define SXE_TRAFFIC_CLASS_MAX  8
+
+#define SXE_MR_VLAN_MSB_REG_OFFSET		 4
+#define SXE_MR_VIRTUAL_POOL_MSB_REG_OFFSET 4
+
+#define SXE_MR_TYPE_MASK				   0x0F
+#define SXE_MR_DST_POOL_OFFSET			 8
+
+void sxe_hw_crc_strip_config(struct sxe_hw *hw, bool keep_crc)
+{
+	u32 crcflag = SXE_REG_READ(hw, SXE_CRC_STRIP_REG);
+
+	if (keep_crc)
+		crcflag |= SXE_KEEP_CRC_EN;
+	else
+		crcflag &= ~SXE_KEEP_CRC_EN;
+
+	SXE_REG_WRITE(hw, SXE_CRC_STRIP_REG, crcflag);
+}
+
+void sxe_hw_rx_pkt_buf_size_set(struct sxe_hw *hw, u8 tc_idx, u16 pbsize)
+{
+	u32 rxpbsize = pbsize << SXE_RX_PKT_BUF_SIZE_SHIFT;
+
+	sxe_hw_rx_pkt_buf_switch(hw, false);
+	SXE_REG_WRITE(hw, SXE_RXPBSIZE(tc_idx), rxpbsize);
+	sxe_hw_rx_pkt_buf_switch(hw, true);
+}
+
+void sxe_hw_dcb_vmdq_mq_configure(struct sxe_hw *hw, u8 num_pools)
+{
+	u16 pbsize;
+	u8 i, nb_tcs;
+	u32 mrqc;
+
+	nb_tcs = SXE_VMDQ_DCB_NUM_QUEUES / num_pools;
+
+	pbsize = (u8)(SXE_RX_PKT_BUF_SIZE / nb_tcs);
+
+	for (i = 0; i < nb_tcs; i++)
+		sxe_hw_rx_pkt_buf_size_set(hw, i, pbsize);
+
+	for (i = nb_tcs; i < ETH_DCB_NUM_USER_PRIORITIES; i++)
+		sxe_hw_rx_pkt_buf_size_set(hw, i, 0);
+
+	mrqc = (num_pools == RTE_ETH_16_POOLS) ?
+		SXE_MRQC_VMDQRT8TCEN : SXE_MRQC_VMDQRT4TCEN;
+	SXE_REG_WRITE(hw, SXE_MRQC, mrqc);
+
+	SXE_REG_WRITE(hw, SXE_RTRPCS, SXE_RTRPCS_RRM);
+}
+
+static const struct sxe_reg_info sxe_regs_general_group[] = {
+	{SXE_CTRL, 1, 1, "SXE_CTRL"},
+	{SXE_STATUS, 1, 1, "SXE_STATUS"},
+	{SXE_CTRL_EXT, 1, 1, "SXE_CTRL_EXT"},
+	{0, 0, 0, ""}
+};
+
+static const struct sxe_reg_info sxe_regs_interrupt_group[] = {
+	{SXE_EICS, 1, 1, "SXE_EICS"},
+	{SXE_EIMS, 1, 1, "SXE_EIMS"},
+	{SXE_EIMC, 1, 1, "SXE_EIMC"},
+	{SXE_EIAC, 1, 1, "SXE_EIAC"},
+	{SXE_EIAM, 1, 1, "SXE_EIAM"},
+	{SXE_EITR(0), 24, 4, "SXE_EITR"},
+	{SXE_IVAR(0), 24, 4, "SXE_IVAR"},
+	{SXE_GPIE, 1, 1, "SXE_GPIE"},
+	{0, 0, 0, ""}
+};
+
+static const struct sxe_reg_info sxe_regs_fctl_group[] = {
+	{SXE_PFCTOP, 1, 1, "SXE_PFCTOP"},
+	{SXE_FCRTV, 1, 1, "SXE_FCRTV"},
+	{SXE_TFCS, 1, 1, "SXE_TFCS"},
+	{0, 0, 0, ""}
+};
+
+static const struct sxe_reg_info sxe_regs_rxdma_group[] = {
+	{SXE_RDBAL(0), 64, 0x40, "SXE_RDBAL"},
+	{SXE_RDBAH(0), 64, 0x40, "SXE_RDBAH"},
+	{SXE_RDLEN(0), 64, 0x40, "SXE_RDLEN"},
+	{SXE_RDH(0), 64, 0x40, "SXE_RDH"},
+	{SXE_RDT(0), 64, 0x40, "SXE_RDT"},
+	{SXE_RXDCTL(0), 64, 0x40, "SXE_RXDCTL"},
+	{SXE_SRRCTL(0), 16, 0x4, "SXE_SRRCTL"},
+	{SXE_TPH_RXCTRL(0), 16, 4, "SXE_TPH_RXCTRL"},
+	{SXE_RDRXCTL, 1, 1, "SXE_RDRXCTL"},
+	{SXE_RXPBSIZE(0), 8, 4, "SXE_RXPBSIZE"},
+	{SXE_RXCTRL, 1, 1, "SXE_RXCTRL"},
+	{0, 0, 0, ""}
+};
+
+static const struct sxe_reg_info sxe_regs_rx_group[] = {
+	{SXE_RXCSUM, 1, 1, "SXE_RXCSUM"},
+	{SXE_RFCTL, 1, 1, "SXE_RFCTL"},
+	{SXE_RAL(0), 16, 8, "SXE_RAL"},
+	{SXE_RAH(0), 16, 8, "SXE_RAH"},
+	{SXE_PSRTYPE(0), 1, 4, "SXE_PSRTYPE"},
+	{SXE_FCTRL, 1, 1, "SXE_FCTRL"},
+	{SXE_VLNCTRL, 1, 1, "SXE_VLNCTRL"},
+	{SXE_MCSTCTRL, 1, 1, "SXE_MCSTCTRL"},
+	{SXE_MRQC, 1, 1, "SXE_MRQC"},
+	{SXE_VMD_CTL, 1, 1, "SXE_VMD_CTL"},
+
+	{0, 0, 0, ""}
+};
+
+static struct sxe_reg_info sxe_regs_tx_group[] = {
+	{SXE_TDBAL(0), 32, 0x40, "SXE_TDBAL"},
+	{SXE_TDBAH(0), 32, 0x40, "SXE_TDBAH"},
+	{SXE_TDLEN(0), 32, 0x40, "SXE_TDLEN"},
+	{SXE_TDH(0), 32, 0x40, "SXE_TDH"},
+	{SXE_TDT(0), 32, 0x40, "SXE_TDT"},
+	{SXE_TXDCTL(0), 32, 0x40, "SXE_TXDCTL"},
+	{SXE_TPH_TXCTRL(0), 16, 4, "SXE_TPH_TXCTRL"},
+	{SXE_TXPBSIZE(0), 8, 4, "SXE_TXPBSIZE"},
+	{0, 0, 0, ""}
+};
+
+static const struct sxe_reg_info sxe_regs_wakeup_group[] = {
+	{SXE_WUC, 1, 1, "SXE_WUC"},
+	{SXE_WUFC, 1, 1, "SXE_WUFC"},
+	{SXE_WUS, 1, 1, "SXE_WUS"},
+	{0, 0, 0, ""}
+};
+
+static const struct sxe_reg_info sxe_regs_dcb_group[] = {
+	{0, 0, 0, ""}
+};
+
+static const struct sxe_reg_info sxe_regs_diagnostic_group[] = {
+	{SXE_MFLCN, 1, 1, "SXE_MFLCN"},
+	{0, 0, 0, ""},
+};
+
+static const struct sxe_reg_info *sxe_regs_group[] = {
+				sxe_regs_general_group,
+				sxe_regs_interrupt_group,
+				sxe_regs_fctl_group,
+				sxe_regs_rxdma_group,
+				sxe_regs_rx_group,
+				sxe_regs_tx_group,
+				sxe_regs_wakeup_group,
+				sxe_regs_dcb_group,
+				sxe_regs_diagnostic_group,
+				NULL};
+
+static u32 sxe_regs_group_count(const struct sxe_reg_info *regs)
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
+static u32 sxe_hw_regs_group_read(struct sxe_hw *hw,
+				const struct sxe_reg_info *regs,
+				u32 *reg_buf)
+{
+	u32 j, i = 0;
+	int count = 0;
+
+	while (regs[i].count) {
+		for (j = 0; j < regs[i].count; j++) {
+			reg_buf[count + j] = SXE_REG_READ(hw,
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
+u32 sxe_hw_all_regs_group_num_get(void)
+{
+	u32 i = 0;
+	u32 count = 0;
+	const struct sxe_reg_info *reg_group;
+	const struct sxe_reg_info **reg_set = sxe_regs_group;
+
+	while ((reg_group = reg_set[i++]))
+		count += sxe_regs_group_count(reg_group);
+
+	return count;
+}
+
+void sxe_hw_all_regs_group_read(struct sxe_hw *hw, u32 *data)
+{
+	u32 count = 0, i = 0;
+	const struct sxe_reg_info *reg_group;
+	const struct sxe_reg_info **reg_set = sxe_regs_group;
+
+	while ((reg_group = reg_set[i++]))
+		count += sxe_hw_regs_group_read(hw, reg_group, &data[count]);
+
+	LOG_INFO("read regs cnt=%u, regs num=%u",
+				count, sxe_hw_all_regs_group_num_get());
+}
+
+static void sxe_hw_default_pool_configure(struct sxe_hw *hw,
+						u8 default_pool_enabled,
+						u8 default_pool_idx)
+{
+	u32 vt_ctl;
+
+	vt_ctl = SXE_VT_CTL_VT_ENABLE | SXE_VT_CTL_REPLEN;
+	if (default_pool_enabled)
+		vt_ctl |= (default_pool_idx << SXE_VT_CTL_POOL_SHIFT);
+	else
+		vt_ctl |= SXE_VT_CTL_DIS_DEFPL;
+
+	SXE_REG_WRITE(hw, SXE_VT_CTL, vt_ctl);
+}
+
+void sxe_hw_dcb_vmdq_default_pool_configure(struct sxe_hw *hw,
+						u8 default_pool_enabled,
+						u8 default_pool_idx)
+{
+	sxe_hw_default_pool_configure(hw, default_pool_enabled, default_pool_idx);
+}
+
+u32 sxe_hw_ring_irq_switch_get(struct sxe_hw *hw, u8 idx)
+{
+	u32 mask;
+
+	if (idx == 0)
+		mask = SXE_REG_READ(hw, SXE_EIMS_EX(0));
+	else
+		mask = SXE_REG_READ(hw, SXE_EIMS_EX(1));
+
+	return mask;
+}
+
+void sxe_hw_ring_irq_switch_set(struct sxe_hw *hw, u8 idx, u32 value)
+{
+	if (idx == 0)
+		SXE_REG_WRITE(hw, SXE_EIMS_EX(0), value);
+	else
+		SXE_REG_WRITE(hw, SXE_EIMS_EX(1), value);
+}
+
+void sxe_hw_dcb_vmdq_up_2_tc_configure(struct sxe_hw *hw,
+						u8 *tc_arr)
+{
+	u32 up2tc;
+	u8 i;
+
+	up2tc = 0;
+	for (i = 0; i < 8; i++)
+		up2tc |= ((tc_arr[i] & 0x07) << (i * 3));
+
+	SXE_REG_WRITE(hw, SXE_RTRUP2TC, up2tc);
+}
+
+u32 sxe_hw_uta_hash_table_get(struct sxe_hw *hw, u8 reg_idx)
+{
+	return SXE_REG_READ(hw, SXE_UTA(reg_idx));
+}
+
+void sxe_hw_uta_hash_table_set(struct sxe_hw *hw,
+				u8 reg_idx, u32 value)
+{
+	SXE_REG_WRITE(hw, SXE_UTA(reg_idx), value);
+}
+
+u32 sxe_hw_vlan_type_get(struct sxe_hw *hw)
+{
+	return SXE_REG_READ(hw, SXE_VLNCTRL);
+}
+
+void sxe_hw_vlan_type_set(struct sxe_hw *hw, u32 value)
+{
+	SXE_REG_WRITE(hw, SXE_VLNCTRL, value);
+}
+
+void sxe_hw_dcb_vmdq_vlan_configure(struct sxe_hw *hw,
+						u8 num_pools)
+{
+	u32 vlanctrl;
+	u8 i;
+
+	vlanctrl = SXE_REG_READ(hw, SXE_VLNCTRL);
+	vlanctrl |= SXE_VLNCTRL_VFE;
+	SXE_REG_WRITE(hw, SXE_VLNCTRL, vlanctrl);
+
+	for (i = 0; i < SXE_VFT_TBL_SIZE; i++)
+		SXE_REG_WRITE(hw, SXE_VFTA(i), 0xFFFFFFFF);
+
+	SXE_REG_WRITE(hw, SXE_VFRE(0),
+			num_pools == RTE_ETH_16_POOLS ? 0xFFFF : 0xFFFFFFFF);
+
+	SXE_REG_WRITE(hw, SXE_MPSAR_LOW(0), 0xFFFFFFFF);
+	SXE_REG_WRITE(hw, SXE_MPSAR_HIGH(0), 0xFFFFFFFF);
+}
+
+void sxe_hw_vlan_ext_type_set(struct sxe_hw *hw, u32 value)
+{
+	SXE_REG_WRITE(hw, SXE_EXVET, value);
+}
+
+u32 sxe_hw_txctl_vlan_type_get(struct sxe_hw *hw)
+{
+	return SXE_REG_READ(hw, SXE_DMATXCTL);
+}
+
+void sxe_hw_txctl_vlan_type_set(struct sxe_hw *hw, u32 value)
+{
+	SXE_REG_WRITE(hw, SXE_DMATXCTL, value);
+}
+
+u32 sxe_hw_ext_vlan_get(struct sxe_hw *hw)
+{
+	return SXE_REG_READ(hw, SXE_CTRL_EXT);
+}
+
+void sxe_hw_ext_vlan_set(struct sxe_hw *hw, u32 value)
+{
+	SXE_REG_WRITE(hw, SXE_CTRL_EXT, value);
+}
+
+void sxe_hw_rxq_stat_map_set(struct sxe_hw *hw, u8 idx, u32 value)
+{
+	SXE_REG_WRITE(hw, SXE_RQSMR(idx), value);
+}
+
+void sxe_hw_dcb_vmdq_pool_configure(struct sxe_hw *hw,
+						u8 pool_idx, u16 vlan_id,
+						u64 pools_map)
+{
+	SXE_REG_WRITE(hw, SXE_VLVF(pool_idx), (SXE_VLVF_VIEN |
+			(vlan_id & 0xFFF)));
+
+	SXE_REG_WRITE(hw, SXE_VLVFB(pool_idx * 2), pools_map);
+}
+
+void sxe_hw_txq_stat_map_set(struct sxe_hw *hw, u8 idx, u32 value)
+{
+	SXE_REG_WRITE(hw, SXE_TQSM(idx), value);
+}
+
+void sxe_hw_dcb_rx_configure(struct sxe_hw *hw, bool is_vt_on,
+					u8 sriov_active, u8 tc_num)
+{
+	u32 reg;
+	u32 vlanctrl;
+	u8 i;
+	u32 q;
+
+	reg = SXE_RTRPCS_RRM | SXE_RTRPCS_RAC | SXE_RTRPCS_ARBDIS;
+	SXE_REG_WRITE(hw, SXE_RTRPCS, reg);
+
+	reg = SXE_REG_READ(hw, SXE_MRQC);
+	if (tc_num == 4) {
+		if (is_vt_on) {
+			reg = (reg & ~SXE_MRQC_MRQE_MASK) |
+				SXE_MRQC_VMDQRT4TCEN;
+		} else {
+			SXE_REG_WRITE(hw, SXE_VT_CTL, 0);
+			reg = (reg & ~SXE_MRQC_MRQE_MASK) |
+				SXE_MRQC_RTRSS4TCEN;
+		}
+	}
+
+	if (tc_num == 8) {
+		if (is_vt_on) {
+			reg = (reg & ~SXE_MRQC_MRQE_MASK) |
+				SXE_MRQC_VMDQRT8TCEN;
+		} else {
+			SXE_REG_WRITE(hw, SXE_VT_CTL, 0);
+			reg = (reg & ~SXE_MRQC_MRQE_MASK) |
+				SXE_MRQC_RTRSS8TCEN;
+		}
+	}
+
+	SXE_REG_WRITE(hw, SXE_MRQC, reg);
+
+	if (sriov_active == 0) {
+		for (q = 0; q < SXE_HW_TXRX_RING_NUM_MAX; q++) {
+			SXE_REG_WRITE(hw, SXE_QDE,
+				(SXE_QDE_WRITE |
+				 (q << SXE_QDE_IDX_SHIFT)));
+		}
+	} else {
+		for (q = 0; q < SXE_HW_TXRX_RING_NUM_MAX; q++) {
+			SXE_REG_WRITE(hw, SXE_QDE,
+				(SXE_QDE_WRITE |
+				 (q << SXE_QDE_IDX_SHIFT) |
+				 SXE_QDE_ENABLE));
+		}
+	}
+
+	vlanctrl = SXE_REG_READ(hw, SXE_VLNCTRL);
+	vlanctrl |= SXE_VLNCTRL_VFE;
+	SXE_REG_WRITE(hw, SXE_VLNCTRL, vlanctrl);
+
+	for (i = 0; i < SXE_VFT_TBL_SIZE; i++)
+		SXE_REG_WRITE(hw, SXE_VFTA(i), 0xFFFFFFFF);
+
+	reg = SXE_RTRPCS_RRM | SXE_RTRPCS_RAC;
+	SXE_REG_WRITE(hw, SXE_RTRPCS, reg);
+}
+
+void sxe_hw_fc_status_get(struct sxe_hw *hw,
+					bool *rx_pause_on, bool *tx_pause_on)
+{
+	u32 flctrl;
+
+	flctrl = SXE_REG_READ(hw, SXE_FLCTRL);
+	if (flctrl & (SXE_FCTRL_RFCE_PFC_EN | SXE_FCTRL_RFCE_LFC_EN))
+		*rx_pause_on = true;
+	else
+		*rx_pause_on = false;
+
+	if (flctrl & (SXE_FCTRL_TFCE_PFC_EN | SXE_FCTRL_TFCE_LFC_EN))
+		*tx_pause_on = true;
+	else
+		*tx_pause_on = false;
+}
+
+void sxe_hw_fc_base_init(struct sxe_hw *hw)
+{
+	u8 i;
+
+	hw->fc.requested_mode = SXE_FC_NONE;
+	hw->fc.current_mode = SXE_FC_NONE;
+	hw->fc.pause_time = SXE_DEFAULT_FCPAUSE;
+	hw->fc.disable_fc_autoneg = false;
+
+	for (i = 0; i < MAX_TRAFFIC_CLASS; i++) {
+		hw->fc.low_water[i]  = SXE_FC_DEFAULT_LOW_WATER_MARK;
+		hw->fc.high_water[i] = SXE_FC_DEFAULT_HIGH_WATER_MARK;
+	}
+
+	hw->fc.send_xon = 1;
+}
+
+u32 sxe_hw_fc_tc_high_water_mark_get(struct sxe_hw *hw, u8 tc_idx)
+{
+	return hw->fc.high_water[tc_idx];
+}
+
+u32 sxe_hw_fc_tc_low_water_mark_get(struct sxe_hw *hw, u8 tc_idx)
+{
+	return hw->fc.low_water[tc_idx];
+}
+
+u16 sxe_hw_fc_send_xon_get(struct sxe_hw *hw)
+{
+	return hw->fc.send_xon;
+}
+
+void sxe_hw_fc_send_xon_set(struct sxe_hw *hw, u16 send_xon)
+{
+	hw->fc.send_xon = send_xon;
+}
+
+u16 sxe_hw_fc_pause_time_get(struct sxe_hw *hw)
+{
+	return hw->fc.pause_time;
+}
+
+void sxe_hw_fc_pause_time_set(struct sxe_hw *hw, u16 pause_time)
+{
+	hw->fc.pause_time = pause_time;
+}
+
+void sxe_hw_dcb_tx_configure(struct sxe_hw *hw, bool is_vt_on, u8 tc_num)
+{
+	u32 reg;
+
+	reg = SXE_REG_READ(hw, SXE_RTTDCS);
+	reg |= SXE_RTTDCS_ARBDIS;
+	SXE_REG_WRITE(hw, SXE_RTTDCS, reg);
+
+	if (tc_num == 8)
+		reg = SXE_MTQC_RT_ENA | SXE_MTQC_8TC_8TQ;
+	else
+		reg = SXE_MTQC_RT_ENA | SXE_MTQC_4TC_4TQ;
+
+	if (is_vt_on)
+		reg |= SXE_MTQC_VT_ENA;
+
+	SXE_REG_WRITE(hw, SXE_MTQC, reg);
+
+	reg = SXE_REG_READ(hw, SXE_RTTDCS);
+	reg &= ~SXE_RTTDCS_ARBDIS;
+	SXE_REG_WRITE(hw, SXE_RTTDCS, reg);
+}
+
+void sxe_hw_rx_ip_checksum_offload_switch(struct sxe_hw *hw,
+							bool is_on)
+{
+	u32 rxcsum;
+
+	rxcsum = SXE_REG_READ(hw, SXE_RXCSUM);
+	if (is_on)
+		rxcsum |= SXE_RXCSUM_IPPCSE;
+	else
+		rxcsum &= ~SXE_RXCSUM_IPPCSE;
+
+	SXE_REG_WRITE(hw, SXE_RXCSUM, rxcsum);
+}
+
+void sxe_hw_rss_cap_switch(struct sxe_hw *hw, bool is_on)
+{
+	u32 mrqc = SXE_REG_READ(hw, SXE_MRQC);
+	u32 mrqe_val;
+
+	mrqe_val = mrqc & SXE_MRQC_MRQE_MASK;
+	if (is_on) {
+		mrqe_val = SXE_MRQC_RSSEN;
+	} else {
+		switch (mrqe_val) {
+		case SXE_MRQC_RSSEN:
+			mrqe_val = 0;
+			break;
+		case SXE_MRQC_RTRSS8TCEN:
+			mrqe_val = SXE_MRQC_RT8TCEN;
+			break;
+		case SXE_MRQC_RTRSS4TCEN:
+			mrqe_val = SXE_MRQC_RT4TCEN;
+			break;
+		case SXE_MRQC_VMDQRSS64EN:
+			mrqe_val = SXE_MRQC_VMDQEN;
+			break;
+		case SXE_MRQC_VMDQRSS32EN:
+			PMD_LOG_WARN(DRV, "Three is no regression for virtualizatic"
+				" and RSS with 32 polls among the MRQE configuration"
+				" after disable RSS and left it unchanged.");
+			break;
+		default:
+			break;
+		}
+	}
+	mrqc = (mrqc & ~SXE_MRQC_MRQE_MASK) | mrqe_val;
+
+	SXE_REG_WRITE(hw, SXE_MRQC, mrqc);
+}
+
+void sxe_hw_pool_xmit_enable(struct sxe_hw *hw, u16 reg_idx, u8 pool_num)
+{
+	SXE_REG_WRITE(hw, SXE_VFTE(reg_idx),
+		pool_num == RTE_ETH_16_POOLS ? 0xFFFF : 0xFFFFFFFF);
+}
+
+void sxe_hw_rss_field_set(struct sxe_hw *hw, u32 rss_field)
+{
+	u32 mrqc = SXE_REG_READ(hw, SXE_MRQC);
+
+	mrqc &= ~SXE_RSS_FIELD_MASK;
+	mrqc |= rss_field;
+	SXE_REG_WRITE(hw, SXE_MRQC, mrqc);
+}
+
+static void sxe_hw_dcb_4tc_vmdq_off_stats_configure(struct sxe_hw *hw)
+{
+	u32 reg;
+	u8  i;
+
+	for (i = 0; i < 32; i++) {
+		if (i % 8 > 3)
+			continue;
+
+		reg = 0x01010101 * (i / 8);
+		SXE_REG_WRITE(hw, SXE_RQSMR(i), reg);
+	}
+	for (i = 0; i < 32; i++) {
+		if (i < 16)
+			reg = 0x00000000;
+		else if (i < 24)
+			reg = 0x01010101;
+		else if (i < 28)
+			reg = 0x02020202;
+		else
+			reg = 0x03030303;
+
+		SXE_REG_WRITE(hw, SXE_TQSM(i), reg);
+	}
+}
+
+static void sxe_hw_dcb_4tc_vmdq_on_stats_configure(struct sxe_hw *hw)
+{
+	u8  i;
+
+	for (i = 0; i < 32; i++)
+		SXE_REG_WRITE(hw, SXE_RQSMR(i), 0x03020100);
+
+
+	for (i = 0; i < 32; i++)
+		SXE_REG_WRITE(hw, SXE_TQSM(i), 0x03020100);
+}
+
+void sxe_hw_rss_redir_tbl_set_by_idx(struct sxe_hw *hw,
+						u16 reg_idx, u32 value)
+{
+	return sxe_hw_rss_redir_tbl_reg_write(hw, reg_idx, value);
+}
+
+static u32 sxe_hw_rss_redir_tbl_reg_read(struct sxe_hw *hw, u16 reg_idx)
+{
+	return SXE_REG_READ(hw, SXE_RETA(reg_idx >> 2));
+}
+
+u32 sxe_hw_rss_redir_tbl_get_by_idx(struct sxe_hw *hw, u16 reg_idx)
+{
+	return sxe_hw_rss_redir_tbl_reg_read(hw, reg_idx);
+}
+
+void sxe_hw_ptp_time_inc_stop(struct sxe_hw *hw)
+{
+	SXE_REG_WRITE(hw, SXE_TIMINC, 0);
+}
+
+void sxe_hw_dcb_tc_stats_configure(struct sxe_hw *hw,
+					u8 tc_num, bool vmdq_active)
+{
+	if (tc_num == 8 && !vmdq_active)
+		sxe_hw_dcb_8tc_vmdq_off_stats_configure(hw);
+	else if (tc_num == 4 && !vmdq_active)
+		sxe_hw_dcb_4tc_vmdq_off_stats_configure(hw);
+	else if (tc_num == 4 && vmdq_active)
+		sxe_hw_dcb_4tc_vmdq_on_stats_configure(hw);
+}
+
+void sxe_hw_ptp_timestamp_disable(struct sxe_hw *hw)
+{
+	SXE_REG_WRITE(hw, SXE_TSYNCTXCTL,
+			(SXE_REG_READ(hw, SXE_TSYNCTXCTL) &
+			~SXE_TSYNCTXCTL_TEN));
+
+	SXE_REG_WRITE(hw, SXE_TSYNCRXCTL,
+			(SXE_REG_READ(hw, SXE_TSYNCRXCTL) &
+			~SXE_TSYNCRXCTL_REN));
+	SXE_WRITE_FLUSH(hw);
+}
+
+void sxe_hw_mac_pool_clear(struct sxe_hw *hw, u8 rar_idx)
+{
+	struct sxe_adapter *adapter = hw->adapter;
+
+	if (rar_idx > SXE_UC_ENTRY_NUM_MAX) {
+		LOG_ERROR_BDF("rar_idx:%d invalid.(err:%d)",
+			  rar_idx, SXE_ERR_PARAM);
+		return;
+	}
+
+	SXE_REG_WRITE(hw, SXE_MPSAR_LOW(rar_idx), 0);
+	SXE_REG_WRITE(hw, SXE_MPSAR_HIGH(rar_idx), 0);
+}
+
+void sxe_hw_vmdq_mq_configure(struct sxe_hw *hw)
+{
+	u32 mrqc;
+
+	mrqc = SXE_MRQC_VMDQEN;
+	SXE_REG_WRITE(hw, SXE_MRQC, mrqc);
+}
+
+void sxe_hw_vmdq_default_pool_configure(struct sxe_hw *hw,
+						u8 default_pool_enabled,
+						u8 default_pool_idx)
+{
+	sxe_hw_default_pool_configure(hw, default_pool_enabled, default_pool_idx);
+}
+
+void sxe_hw_vmdq_vlan_configure(struct sxe_hw *hw,
+						u8 num_pools, u32 rx_mode)
+{
+	u32 vlanctrl;
+	u8 i;
+
+	vlanctrl = SXE_REG_READ(hw, SXE_VLNCTRL);
+	vlanctrl |= SXE_VLNCTRL_VFE;
+	SXE_REG_WRITE(hw, SXE_VLNCTRL, vlanctrl);
+
+	for (i = 0; i < SXE_VFT_TBL_SIZE; i++)
+		SXE_REG_WRITE(hw, SXE_VFTA(i), 0xFFFFFFFF);
+
+	SXE_REG_WRITE(hw, SXE_VFRE(0), 0xFFFFFFFF);
+	if (num_pools == RTE_ETH_64_POOLS)
+		SXE_REG_WRITE(hw, SXE_VFRE(1), 0xFFFFFFFF);
+
+	for (i = 0; i < num_pools; i++)
+		SXE_REG_WRITE(hw, SXE_VMOLR(i), rx_mode);
+
+	SXE_REG_WRITE(hw, SXE_MPSAR_LOW(0), 0xFFFFFFFF);
+	SXE_REG_WRITE(hw, SXE_MPSAR_HIGH(0), 0xFFFFFFFF);
+
+	SXE_WRITE_FLUSH(hw);
+}
+
+u32 sxe_hw_pcie_vt_mode_get(struct sxe_hw *hw)
+{
+	return SXE_REG_READ(hw, SXE_GCR_EXT);
+}
+
+void sxe_rx_fc_threshold_set(struct sxe_hw *hw)
+{
+	u8 i;
+	u32 high;
+
+	for (i = 0; i < SXE_TRAFFIC_CLASS_MAX; i++) {
+		SXE_REG_WRITE(hw, SXE_FCRTL(i), 0);
+		high = SXE_REG_READ(hw, SXE_RXPBSIZE(i)) - 32;
+		SXE_REG_WRITE(hw, SXE_FCRTH(i), high);
+	}
+}
+
+void sxe_hw_vmdq_pool_configure(struct sxe_hw *hw,
+						u8 pool_idx, u16 vlan_id,
+						u64 pools_map)
+{
+	SXE_REG_WRITE(hw, SXE_VLVF(pool_idx), (SXE_VLVF_VIEN |
+			(vlan_id & SXE_RXD_VLAN_ID_MASK)));
+
+	if (((pools_map >> 32) & 0xFFFFFFFF) == 0) {
+		SXE_REG_WRITE(hw, SXE_VLVFB(pool_idx * 2),
+			(pools_map & 0xFFFFFFFF));
+	} else {
+		SXE_REG_WRITE(hw, SXE_VLVFB((pool_idx * 2 + 1)),
+			((pools_map >> 32) & 0xFFFFFFFF));
+	}
+
+	SXE_WRITE_FLUSH(hw);
+}
+
+void sxe_hw_vmdq_loopback_configure(struct sxe_hw *hw)
+{
+	u8 i;
+	SXE_REG_WRITE(hw, SXE_PFDTXGSWC, SXE_PFDTXGSWC_VT_LBEN);
+	for (i = 0; i < SXE_VMTXSW_REGISTER_COUNT; i++)
+		SXE_REG_WRITE(hw, SXE_VMTXSW(i), 0xFFFFFFFF);
+
+	SXE_WRITE_FLUSH(hw);
+}
+
+void sxe_hw_tx_multi_queue_configure(struct sxe_hw *hw,
+				bool vmdq_enable, bool sriov_enable, u16 pools_num)
+{
+	u32 mtqc;
+
+	sxe_hw_dcb_arbiter_set(hw, false);
+
+	if (sriov_enable) {
+		switch (pools_num) {
+		case RTE_ETH_64_POOLS:
+			mtqc = SXE_MTQC_VT_ENA | SXE_MTQC_64VF;
+			break;
+		case RTE_ETH_32_POOLS:
+			mtqc = SXE_MTQC_VT_ENA | SXE_MTQC_32VF;
+			break;
+		case RTE_ETH_16_POOLS:
+			mtqc = SXE_MTQC_VT_ENA | SXE_MTQC_RT_ENA |
+				SXE_MTQC_8TC_8TQ;
+			break;
+		default:
+			mtqc = SXE_MTQC_64Q_1PB;
+		}
+	} else {
+		if (vmdq_enable) {
+			u8 queue_idx;
+			SXE_REG_WRITE(hw, SXE_VFTE(0), UINT32_MAX);
+			SXE_REG_WRITE(hw, SXE_VFTE(1), UINT32_MAX);
+
+			for (queue_idx = 0; queue_idx < SXE_HW_TXRX_RING_NUM_MAX;
+				queue_idx++) {
+				SXE_REG_WRITE(hw, SXE_QDE,
+					(SXE_QDE_WRITE |
+					(queue_idx << SXE_QDE_IDX_SHIFT)));
+			}
+
+			mtqc = SXE_MTQC_VT_ENA | SXE_MTQC_64VF;
+		} else {
+			mtqc = SXE_MTQC_64Q_1PB;
+		}
+	}
+
+	SXE_REG_WRITE(hw, SXE_MTQC, mtqc);
+
+	sxe_hw_dcb_arbiter_set(hw, true);
+}
+
+void sxe_hw_vf_queue_drop_enable(struct sxe_hw *hw, u8 vf_idx,
+					u8 ring_per_pool)
+{
+	u32 value;
+	u8 i;
+
+	for (i = (vf_idx * ring_per_pool); i < ((vf_idx + 1) * ring_per_pool); i++) {
+		value = SXE_QDE_ENABLE | SXE_QDE_WRITE;
+		SXE_WRITE_FLUSH(hw);
+
+		value |= i << SXE_QDE_IDX_SHIFT;
+
+		SXE_REG_WRITE(hw, SXE_QDE, value);
+	}
+}
+
+bool sxe_hw_vt_status(struct sxe_hw *hw)
+{
+	bool ret;
+	u32 vt_ctl = SXE_REG_READ(hw, SXE_VT_CTL);
+
+	if (vt_ctl & SXE_VMD_CTL_POOL_EN)
+		ret = true;
+	else
+		ret = false;
+
+	return ret;
+}
+
+void sxe_hw_mirror_ctl_set(struct sxe_hw *hw, u8 rule_id,
+					u8 mirror_type, u8 dst_pool, bool on)
+{
+	u32 mr_ctl;
+
+	mr_ctl = SXE_REG_READ(hw, SXE_MRCTL(rule_id));
+
+	if (on) {
+		mr_ctl |= mirror_type;
+		mr_ctl &= SXE_MR_TYPE_MASK;
+		mr_ctl |= dst_pool << SXE_MR_DST_POOL_OFFSET;
+	} else {
+		mr_ctl &= ~(mirror_type & SXE_MR_TYPE_MASK);
+	}
+
+	SXE_REG_WRITE(hw, SXE_MRCTL(rule_id), mr_ctl);
+}
+
+void sxe_hw_mirror_virtual_pool_set(struct sxe_hw *hw, u8 rule_id, u32 lsb, u32 msb)
+{
+	SXE_REG_WRITE(hw, SXE_VMRVM(rule_id), lsb);
+	SXE_REG_WRITE(hw, SXE_VMRVM(rule_id  + SXE_MR_VIRTUAL_POOL_MSB_REG_OFFSET), msb);
+}
+
+void sxe_hw_mirror_vlan_set(struct sxe_hw *hw, u8 rule_id, u32 lsb, u32 msb)
+{
+	SXE_REG_WRITE(hw, SXE_VMRVLAN(rule_id), lsb);
+	SXE_REG_WRITE(hw, SXE_VMRVLAN(rule_id  + SXE_MR_VLAN_MSB_REG_OFFSET), msb);
+}
+
+void sxe_hw_mirror_rule_clear(struct sxe_hw *hw, u8 rule_id)
+{
+	SXE_REG_WRITE(hw, SXE_MRCTL(rule_id), 0);
+
+	SXE_REG_WRITE(hw, SXE_VMRVLAN(rule_id), 0);
+	SXE_REG_WRITE(hw, SXE_VMRVLAN(rule_id  + SXE_MR_VLAN_MSB_REG_OFFSET), 0);
+
+	SXE_REG_WRITE(hw, SXE_VMRVM(rule_id), 0);
+	SXE_REG_WRITE(hw, SXE_VMRVM(rule_id  + SXE_MR_VIRTUAL_POOL_MSB_REG_OFFSET), 0);
+}
+
+void sxe_hw_mac_reuse_add(struct rte_eth_dev *dev,
+				u8 *mac_addr, u8 rar_idx)
+{
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_uc_addr_table *uc_table = adapter->mac_filter_ctxt.uc_addr_table;
+	struct sxe_hw *hw = &adapter->hw;
+	s32 i;
+	u32 value_low = SXE_REG_READ(hw, SXE_MPSAR_LOW(rar_idx));
+	u32 value_high = SXE_REG_READ(hw, SXE_MPSAR_HIGH(rar_idx));
+
+	for (i = 0; i < SXE_UC_ENTRY_NUM_MAX; i++) {
+		if (memcmp(uc_table[i].addr, mac_addr, SXE_MAC_ADDR_LEN) == 0 &&
+				uc_table[i].used && i != rar_idx) {
+			value_low |= SXE_REG_READ(hw, SXE_MPSAR_LOW(i));
+			value_high |= SXE_REG_READ(hw, SXE_MPSAR_HIGH(i));
+
+			SXE_REG_WRITE(hw, SXE_MPSAR_LOW(i), value_low);
+			SXE_REG_WRITE(hw, SXE_MPSAR_HIGH(i), value_high);
+		}
+	}
+
+	SXE_REG_WRITE(hw, SXE_MPSAR_LOW(rar_idx), value_low);
+	SXE_REG_WRITE(hw, SXE_MPSAR_HIGH(rar_idx), value_high);
+}
+
+void sxe_hw_mac_reuse_del(struct rte_eth_dev *dev,
+				u8 *mac_addr, u8 pool_idx, u8 rar_idx)
+{
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_uc_addr_table *uc_table = adapter->mac_filter_ctxt.uc_addr_table;
+	struct sxe_hw *hw = &adapter->hw;
+	u32 value;
+	s32 i;
+
+	for (i = 0; i < SXE_UC_ENTRY_NUM_MAX; i++) {
+		if (memcmp(uc_table[i].addr, mac_addr, SXE_MAC_ADDR_LEN) == 0 &&
+				uc_table[i].used && i != rar_idx) {
+			if (pool_idx < 32) {
+				value = SXE_REG_READ(hw, SXE_MPSAR_LOW(i));
+				value &= ~(BIT(pool_idx));
+				SXE_REG_WRITE(hw, SXE_MPSAR_LOW(i), value);
+			} else {
+				value = SXE_REG_READ(hw, SXE_MPSAR_HIGH(i));
+				value &= ~(BIT(pool_idx - 32));
+				SXE_REG_WRITE(hw, SXE_MPSAR_HIGH(i), value);
+			}
+		}
+	}
+}
+
+#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_FILTER_CTRL
+void sxe_hw_fivetuple_filter_add(struct rte_eth_dev *dev,
+					struct sxe_fivetuple_node_info *filter)
+{
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+	u16 i;
+	u32 ftqf, sdpqf;
+	u32 l34timir = 0;
+	u8 mask = 0xff;
+
+	i = filter->index;
+
+	sdpqf = (u32)(filter->filter_info.dst_port << SXE_SDPQF_DSTPORT_SHIFT);
+	sdpqf = sdpqf | (filter->filter_info.src_port & SXE_SDPQF_SRCPORT);
+
+	ftqf = (u32)(filter->filter_info.protocol & SXE_FTQF_PROTOCOL_MASK);
+	ftqf |= (u32)((filter->filter_info.priority &
+			SXE_FTQF_PRIORITY_MASK) << SXE_FTQF_PRIORITY_SHIFT);
+
+	if (filter->filter_info.src_ip_mask == 0)
+		mask &= SXE_FTQF_SOURCE_ADDR_MASK;
+
+	if (filter->filter_info.dst_ip_mask == 0)
+		mask &= SXE_FTQF_DEST_ADDR_MASK;
+
+	if (filter->filter_info.src_port_mask == 0)
+		mask &= SXE_FTQF_SOURCE_PORT_MASK;
+
+	if (filter->filter_info.dst_port_mask == 0)
+		mask &= SXE_FTQF_DEST_PORT_MASK;
+
+	if (filter->filter_info.proto_mask == 0)
+		mask &= SXE_FTQF_PROTOCOL_COMP_MASK;
+
+	ftqf |= mask << SXE_FTQF_5TUPLE_MASK_SHIFT;
+	ftqf |= SXE_FTQF_POOL_MASK_EN;
+	ftqf |= SXE_FTQF_QUEUE_ENABLE;
+
+	LOG_DEBUG("add fivetuple filter, index[%u], src_ip[0x%x], dst_ip[0x%x]"
+		"src_port[%u], dst_port[%u], ftqf[0x%x], queue[%u]", i,
+		filter->filter_info.src_ip, filter->filter_info.dst_ip,
+		filter->filter_info.src_port, filter->filter_info.dst_port,
+		ftqf, filter->queue);
+
+	SXE_REG_WRITE(hw, SXE_DAQF(i), filter->filter_info.dst_ip);
+	SXE_REG_WRITE(hw, SXE_SAQF(i), filter->filter_info.src_ip);
+	SXE_REG_WRITE(hw, SXE_SDPQF(i), sdpqf);
+	SXE_REG_WRITE(hw, SXE_FTQF(i), ftqf);
+
+	l34timir |= SXE_L34T_IMIR_RESERVE;
+	l34timir |= (u32)(filter->queue << SXE_L34T_IMIR_QUEUE_SHIFT);
+	SXE_REG_WRITE(hw, SXE_L34T_IMIR(i), l34timir);
+}
+
+void sxe_hw_fivetuple_filter_del(struct sxe_hw *hw, u16 reg_index)
+{
+	SXE_REG_WRITE(hw, SXE_DAQF(reg_index), 0);
+	SXE_REG_WRITE(hw, SXE_SAQF(reg_index), 0);
+	SXE_REG_WRITE(hw, SXE_SDPQF(reg_index), 0);
+	SXE_REG_WRITE(hw, SXE_FTQF(reg_index), 0);
+	SXE_REG_WRITE(hw, SXE_L34T_IMIR(reg_index), 0);
+}
+
+void sxe_hw_ethertype_filter_add(struct sxe_hw *hw,
+					u8 reg_index, u16 ethertype, u16 queue)
+{
+	u32 etqf = 0;
+	u32 etqs = 0;
+
+	etqf = SXE_ETQF_FILTER_EN;
+	etqf |= (u32)ethertype;
+	etqs |= (u32)((queue << SXE_ETQS_RX_QUEUE_SHIFT) &
+			SXE_ETQS_RX_QUEUE);
+	etqs |= SXE_ETQS_QUEUE_EN;
+
+	SXE_REG_WRITE(hw, SXE_ETQF(reg_index), etqf);
+	SXE_REG_WRITE(hw, SXE_ETQS(reg_index), etqs);
+	SXE_WRITE_FLUSH(hw);
+}
+
+void sxe_hw_ethertype_filter_del(struct sxe_hw *hw, u8 filter_type)
+{
+	SXE_REG_WRITE(hw, SXE_ETQF(filter_type), 0);
+	SXE_REG_WRITE(hw, SXE_ETQS(filter_type), 0);
+	SXE_WRITE_FLUSH(hw);
+}
+
+void sxe_hw_syn_filter_add(struct sxe_hw *hw, u16 queue, u8 priority)
+{
+	u32 synqf;
+
+	synqf = (u32)(((queue << SXE_SYN_FILTER_QUEUE_SHIFT) &
+			SXE_SYN_FILTER_QUEUE) | SXE_SYN_FILTER_ENABLE);
+
+	if (priority)
+		synqf |= SXE_SYN_FILTER_SYNQFP;
+	else
+		synqf &= ~SXE_SYN_FILTER_SYNQFP;
+
+	SXE_REG_WRITE(hw, SXE_SYNQF, synqf);
+	SXE_WRITE_FLUSH(hw);
+}
+
+void sxe_hw_syn_filter_del(struct sxe_hw *hw)
+{
+	u32 synqf;
+
+	synqf = SXE_REG_READ(hw, SXE_SYNQF);
+
+	synqf &= ~(SXE_SYN_FILTER_QUEUE | SXE_SYN_FILTER_ENABLE);
+	SXE_REG_WRITE(hw, SXE_SYNQF, synqf);
+	SXE_WRITE_FLUSH(hw);
+}
+
+void sxe_hw_fnav_rx_pkt_buf_size_reset(struct sxe_hw *hw, u32 pbsize)
+{
+	S32 i;
+
+	SXE_REG_WRITE(hw, SXE_RXPBSIZE(0), (SXE_REG_READ(hw, SXE_RXPBSIZE(0)) - pbsize));
+	for (i = 1; i < 8; i++)
+		SXE_REG_WRITE(hw, SXE_RXPBSIZE(i), 0);
+}
+
+void sxe_hw_fnav_flex_mask_set(struct sxe_hw *hw, u16 flex_mask)
+{
+	u32 fnavm;
+
+	fnavm = SXE_REG_READ(hw, SXE_FNAVM);
+	if (flex_mask == UINT16_MAX)
+		fnavm &= ~SXE_FNAVM_FLEX;
+
+	SXE_REG_WRITE(hw, SXE_FNAVM, fnavm);
+}
+
+void sxe_hw_fnav_ipv6_mask_set(struct sxe_hw *hw, u16 src_mask, u16 dst_mask)
+{
+	u32 fnavipv6m;
+
+	fnavipv6m = (dst_mask << 16) | src_mask;
+	SXE_REG_WRITE(hw, SXE_FNAVIP6M, ~fnavipv6m);
+}
+
+s32 sxe_hw_fnav_flex_offset_set(struct sxe_hw *hw, u16 offset)
+{
+	u32 fnavctrl;
+	s32 ret;
+
+	fnavctrl = SXE_REG_READ(hw, SXE_FNAVCTRL);
+	fnavctrl &= ~SXE_FNAVCTRL_FLEX_MASK;
+	fnavctrl |= ((offset >> 1)
+		<< SXE_FNAVCTRL_FLEX_SHIFT);
+
+	SXE_REG_WRITE(hw, SXE_FNAVCTRL, fnavctrl);
+	SXE_WRITE_FLUSH(hw);
+
+	ret = sxe_hw_fnav_wait_init_done(hw);
+	if (ret)
+		LOG_ERROR("flow director signature poll time exceeded!");
+	return ret;
+}
+#endif
+
+#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_MACSEC
+static void sxe_macsec_stop_data(struct sxe_hw *hw, bool link)
+{
+	u32 t_rdy, r_rdy;
+	u32 limit;
+	u32 reg;
+
+	reg = SXE_REG_READ(hw, SXE_SECTXCTRL);
+	reg |= SXE_SECTXCTRL_TX_DIS;
+	SXE_REG_WRITE(hw, SXE_SECTXCTRL, reg);
+
+	reg = SXE_REG_READ(hw, SXE_SECRXCTRL);
+	reg |= SXE_SECRXCTRL_RX_DIS;
+	SXE_REG_WRITE(hw, SXE_SECRXCTRL, reg);
+	SXE_WRITE_FLUSH(hw);
+
+	t_rdy = SXE_REG_READ(hw, SXE_SECTXSTAT) &
+		SXE_SECTXSTAT_SECTX_RDY;
+	r_rdy = SXE_REG_READ(hw, SXE_SECRXSTAT) &
+		SXE_SECRXSTAT_SECRX_RDY;
+	if (t_rdy && r_rdy)
+		return;
+
+	if (!link) {
+		SXE_REG_WRITE(hw, SXE_LPBKCTRL, 0x1);
+
+		SXE_WRITE_FLUSH(hw);
+		mdelay(3);
+	}
+
+	limit = 20;
+	do {
+		mdelay(10);
+		t_rdy = SXE_REG_READ(hw, SXE_SECTXSTAT) &
+			SXE_SECTXSTAT_SECTX_RDY;
+		r_rdy = SXE_REG_READ(hw, SXE_SECRXSTAT) &
+			SXE_SECRXSTAT_SECRX_RDY;
+	} while (!(t_rdy && r_rdy) && limit--);
+
+	if (!link) {
+		SXE_REG_WRITE(hw, SXE_LPBKCTRL, 0x0);
+		SXE_WRITE_FLUSH(hw);
+	}
+}
+void sxe_hw_rx_queue_mode_set(struct sxe_hw *hw, u32 mrqc)
+{
+	SXE_REG_WRITE(hw, SXE_MRQC, mrqc);
+}
+
+void sxe_hw_macsec_enable(struct sxe_hw *hw, bool is_up, u32 tx_mode,
+				u32 rx_mode, u32 pn_trh)
+{
+	u32 reg;
+
+	sxe_macsec_stop_data(hw, is_up);
+
+	reg = SXE_REG_READ(hw, SXE_SECTXCTRL);
+	reg &= ~SXE_SECTXCTRL_SECTX_DIS;
+	reg &= ~SXE_SECTXCTRL_STORE_FORWARD;
+	SXE_REG_WRITE(hw, SXE_SECTXCTRL, reg);
+
+	SXE_REG_WRITE(hw, SXE_SECTXBUFFAF, 0x250);
+
+	reg = SXE_REG_READ(hw, SXE_SECTXMINIFG);
+	reg = (reg & 0xfffffff0) | 0x3;
+	SXE_REG_WRITE(hw, SXE_SECTXMINIFG, reg);
+
+	reg = SXE_REG_READ(hw, SXE_SECRXCTRL);
+	reg &= ~SXE_SECRXCTRL_SECRX_DIS;
+	reg |= SXE_SECRXCTRL_RP;
+	SXE_REG_WRITE(hw, SXE_SECRXCTRL, reg);
+
+	reg = tx_mode & SXE_LSECTXCTRL_EN_MASK;
+	reg |= SXE_LSECTXCTRL_AISCI;
+	reg &= ~SXE_LSECTXCTRL_PNTHRSH_MASK;
+	reg |= (pn_trh << SXE_LSECTXCTRL_PNTHRSH_SHIFT);
+	SXE_REG_WRITE(hw, SXE_LSECTXCTRL, reg);
+
+	reg = (rx_mode << SXE_LSECRXCTRL_EN_SHIFT) & SXE_LSECRXCTRL_EN_MASK;
+	reg |= SXE_LSECRXCTRL_RP;
+	reg |= SXE_LSECRXCTRL_DROP_EN;
+	SXE_REG_WRITE(hw, SXE_LSECRXCTRL, reg);
+
+	reg = SXE_REG_READ(hw, SXE_SECTXCTRL);
+	reg &= ~SXE_SECTXCTRL_TX_DIS;
+	SXE_REG_WRITE(hw, SXE_SECTXCTRL, reg);
+
+	reg = SXE_REG_READ(hw, SXE_SECRXCTRL);
+	reg &= ~SXE_SECRXCTRL_RX_DIS;
+	SXE_REG_WRITE(hw, SXE_SECRXCTRL, reg);
+
+	SXE_WRITE_FLUSH(hw);
+}
+
+void sxe_hw_macsec_disable(struct sxe_hw *hw, bool is_up)
+{
+	u32 reg;
+
+	sxe_macsec_stop_data(hw, is_up);
+
+	reg = SXE_REG_READ(hw, SXE_SECTXCTRL);
+	reg |= SXE_SECTXCTRL_SECTX_DIS;
+	reg &= ~SXE_SECTXCTRL_STORE_FORWARD;
+	SXE_REG_WRITE(hw, SXE_SECTXCTRL, reg);
+
+	reg = SXE_REG_READ(hw, SXE_SECRXCTRL);
+	reg |= SXE_SECRXCTRL_SECRX_DIS;
+	SXE_REG_WRITE(hw, SXE_SECRXCTRL, reg);
+
+	SXE_REG_WRITE(hw, SXE_SECTXBUFFAF, 0x250);
+
+	reg = SXE_REG_READ(hw, SXE_SECTXMINIFG);
+	reg = (reg & 0xfffffff0) | 0x1;
+	SXE_REG_WRITE(hw, SXE_SECTXMINIFG, reg);
+
+	SXE_REG_WRITE(hw, SXE_SECTXCTRL, SXE_SECTXCTRL_SECTX_DIS);
+	SXE_REG_WRITE(hw, SXE_SECRXCTRL, SXE_SECRXCTRL_SECRX_DIS);
+
+	SXE_WRITE_FLUSH(hw);
+}
+
+void sxe_hw_macsec_txsc_set(struct sxe_hw *hw, u32 scl, u32 sch)
+{
+	SXE_REG_WRITE(hw, SXE_LSECTXSCL, scl);
+	SXE_REG_WRITE(hw, SXE_LSECTXSCH, sch);
+
+	SXE_WRITE_FLUSH(hw);
+}
+
+void sxe_hw_macsec_rxsc_set(struct sxe_hw *hw, u32 scl, u32 sch, u16 pi)
+{
+	u32 reg = sch;
+
+	SXE_REG_WRITE(hw, SXE_LSECRXSCL, scl);
+
+	reg |= (pi << SXE_LSECRXSCH_PI_SHIFT) & SXE_LSECRXSCH_PI_MASK;
+	SXE_REG_WRITE(hw, SXE_LSECRXSCH, reg);
+
+	SXE_WRITE_FLUSH(hw);
+}
+
+void sxe_hw_macsec_tx_sa_configure(struct sxe_hw *hw, u8 sa_idx,
+				u8 an, u32 pn, u32 *keys)
+{
+	u32 reg;
+	u8 i;
+
+	reg = SXE_REG_READ(hw, SXE_LSECTXSA);
+	reg &= ~SXE_LSECTXSA_SELSA;
+	reg |= (sa_idx << SXE_LSECTXSA_SELSA_SHIFT) & SXE_LSECTXSA_SELSA;
+	SXE_REG_WRITE(hw, SXE_LSECTXSA, reg);
+	SXE_WRITE_FLUSH(hw);
+
+	SXE_REG_WRITE(hw, SXE_LSECTXPN(sa_idx), pn);
+	for (i = 0; i < 4; i++)
+		SXE_REG_WRITE(hw, SXE_LSECTXKEY(sa_idx, i), keys[i]);
+
+	SXE_WRITE_FLUSH(hw);
+
+	reg = SXE_REG_READ(hw, SXE_LSECTXSA);
+	if (sa_idx == 0) {
+		reg &= ~SXE_LSECTXSA_AN0_MASK;
+		reg |= (an << SXE_LSECTXSA_AN0_SHIFT) & SXE_LSECTXSA_AN0_MASK;
+		reg &= ~SXE_LSECTXSA_SELSA;
+		SXE_REG_WRITE(hw, SXE_LSECTXSA, reg);
+	} else if (sa_idx == 1) {
+		reg &= ~SXE_LSECTXSA_AN1_MASK;
+		reg |= (an << SXE_LSECTXSA_AN1_SHIFT) & SXE_LSECTXSA_AN1_MASK;
+		reg |= SXE_LSECTXSA_SELSA;
+		SXE_REG_WRITE(hw, SXE_LSECTXSA, reg);
+	}
+
+	SXE_WRITE_FLUSH(hw);
+}
+
+void sxe_hw_macsec_rx_sa_configure(struct sxe_hw *hw, u8 sa_idx,
+				u8 an, u32 pn, u32 *keys)
+{
+	u32 reg;
+	u8 i;
+
+	reg = SXE_REG_READ(hw, SXE_LSECRXSA(sa_idx));
+	reg &= ~SXE_LSECRXSA_SAV;
+	reg |= (0 << SXE_LSECRXSA_SAV_SHIFT) & SXE_LSECRXSA_SAV;
+
+	SXE_REG_WRITE(hw, SXE_LSECRXSA(sa_idx), reg);
+
+	SXE_WRITE_FLUSH(hw);
+
+	SXE_REG_WRITE(hw, SXE_LSECRXPN(sa_idx), pn);
+
+	for (i = 0; i < 4; i++)
+		SXE_REG_WRITE(hw, SXE_LSECRXKEY(sa_idx, i), keys[i]);
+
+	SXE_WRITE_FLUSH(hw);
+
+	reg = ((an << SXE_LSECRXSA_AN_SHIFT) & SXE_LSECRXSA_AN_MASK) | SXE_LSECRXSA_SAV;
+	SXE_REG_WRITE(hw, SXE_LSECRXSA(sa_idx), reg);
+	SXE_WRITE_FLUSH(hw);
+}
+
+#endif
+#endif
diff --git a/drivers/net/sxe/base/sxe_hw.h b/drivers/net/sxe/base/sxe_hw.h
new file mode 100644
index 0000000000..42c1615fa7
--- /dev/null
+++ b/drivers/net/sxe/base/sxe_hw.h
@@ -0,0 +1,1537 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+
+#ifndef __SXE_HW_H__
+#define __SXE_HW_H__
+
+#if defined(__KERNEL__) || defined(SXE_KERNEL_TEST)
+#include <linux/types.h>
+#include <linux/kernel.h>
+#else
+#include "sxe_types.h"
+#include "sxe_compat_platform.h"
+#include "sxe_compat_version.h"
+#ifdef SXE_HOST_DRIVER
+#include "sxe_drv_type.h"
+#endif
+#include <inttypes.h>
+#endif
+
+#include "sxe_regs.h"
+
+#if defined(__KERNEL__) || defined(SXE_KERNEL_TEST)
+#define SXE_PRIU64  "llu"
+#define SXE_PRIX64  "llx"
+#define SXE_PRID64  "lld"
+#define SXE_RMB()	 rmb() /* verify reading before check ****/
+
+#else
+#define SXE_PRIU64  PRIu64
+#define SXE_PRIX64  PRIx64
+#define SXE_PRID64  PRId64
+#define SXE_RMB()	 rte_rmb()
+#endif
+
+struct sxe_hw;
+struct sxe_filter_mac;
+struct sxe_fc_info;
+
+#define SXE_MAC_ADDR_LEN 6
+#define SXE_QUEUE_STATS_MAP_REG_NUM 32
+
+#define SXE_FC_DEFAULT_HIGH_WATER_MARK	0x80
+#define SXE_FC_DEFAULT_LOW_WATER_MARK	 0x40
+
+#define  SXE_MC_ADDR_EXTRACT_MASK  (0xFFF)
+#define  SXE_MC_ADDR_SHIFT		 (5)
+#define  SXE_MC_ADDR_REG_MASK	  (0x7F)
+#define  SXE_MC_ADDR_BIT_MASK	  (0x1F)
+
+#define SXE_TXTS_POLL_CHECK		3
+#define SXE_TXTS_POLL			5
+#define SXE_TIME_TO_NS(ns, sec)	(((u64)(ns)) + (u64)(((u64)(sec)) * NSEC_PER_SEC))
+
+enum sxe_strict_prio_type {
+	PRIO_NONE = 0,
+	PRIO_GROUP,
+	PRIO_LINK
+};
+
+enum sxe_mc_filter_type {
+	SXE_MC_FILTER_TYPE0 = 0,
+	SXE_MC_FILTER_TYPE1,
+	SXE_MC_FILTER_TYPE2,
+	SXE_MC_FILTER_TYPE3
+};
+
+#define SXE_POOLS_NUM_MAX 64
+#define SXE_16_POOL 16
+#define SXE_32_POOL 32
+#define SXE_1_RING_PER_POOL 1
+#define SXE_2_RING_PER_POOL 2
+#define SXE_3_RING_PER_POOL 3
+#define SXE_4_RING_PER_POOL 4
+
+#define SXE_DCB_1_TC 1
+#define SXE_DCB_4_TC 4
+#define SXE_DCB_8_TC 8
+
+#define SXE_8Q_PER_POOL_MASK   0x78
+#define SXE_4Q_PER_POOL_MASK   0x7C
+#define SXE_2Q_PER_POOL_MASK   0x7E
+
+#define SXE_VF_NUM_16		16
+#define SXE_VF_NUM_32		32
+
+#define SXE_TX_DESC_EOP_MASK  0x01000000
+#define SXE_TX_DESC_RS_MASK   0x08000000
+#define SXE_TX_DESC_STAT_DD   0x00000001
+#define SXE_TX_DESC_CMD	   (SXE_TX_DESC_EOP_MASK | SXE_TX_DESC_RS_MASK)
+#define SXE_TX_DESC_TYPE_DATA 0x00300000
+#define SXE_TX_DESC_DEXT	  0x20000000
+#define SXE_TX_DESC_IFCS	  0x02000000
+#define SXE_TX_DESC_VLE	   0x40000000
+#define SXE_TX_DESC_TSTAMP	0x00080000
+#define SXE_TX_DESC_FLAGS	 (SXE_TX_DESC_TYPE_DATA | \
+				SXE_TX_DESC_IFCS | \
+				SXE_TX_DESC_DEXT | \
+				SXE_TX_DESC_EOP_MASK)
+#define SXE_TXD_DTYP_CTXT	 0x00200000
+#define SXE_TXD_DCMD_TSE	  0x80000000
+#define SXE_TXD_MAC_LINKSEC   0x00040000
+#define SXE_TXD_MAC_1588	  0x00080000
+#define SXE_TX_DESC_PAYLEN_SHIFT	 14
+#define SXE_TX_OUTERIPCS_SHIFT	17
+
+#define SXE_TX_POPTS_IXSM   0x01
+#define SXE_TX_POPTS_TXSM   0x02
+#define SXE_TXD_POPTS_SHIFT 8
+#define SXE_TXD_POPTS_IXSM  (SXE_TX_POPTS_IXSM << SXE_TXD_POPTS_SHIFT)
+#define SXE_TXD_POPTS_TXSM  (SXE_TX_POPTS_TXSM << SXE_TXD_POPTS_SHIFT)
+#define SXE_TXD_POPTS_IPSEC (0x00000400)
+
+#define SXE_TX_CTXTD_DTYP_CTXT	  0x00200000
+#define SXE_TX_CTXTD_TUCMD_IPV6	 0x00000000
+#define SXE_TX_CTXTD_TUCMD_IPV4	 0x00000400
+#define SXE_TX_CTXTD_TUCMD_L4T_UDP  0x00000000
+#define SXE_TX_CTXTD_TUCMD_L4T_TCP  0x00000800
+#define SXE_TX_CTXTD_TUCMD_L4T_SCTP 0x00001000
+#define SXE_TX_CTXTD_TUCMD_L4T_RSV  0x00001800
+#define SXE_TX_CTXTD_TUCMD_IPSEC_TYPE_ESP   0x00002000
+#define SXE_TX_CTXTD_TUCMD_IPSEC_ENCRYPT_EN 0x00004000
+
+#define SXE_TX_CTXTD_L4LEN_SHIFT		  8
+#define SXE_TX_CTXTD_MSS_SHIFT			16
+#define SXE_TX_CTXTD_MACLEN_SHIFT		 9
+#define SXE_TX_CTXTD_VLAN_SHIFT		   16
+#define SXE_TX_CTXTD_VLAN_MASK			0xffff0000
+#define SXE_TX_CTXTD_MACLEN_MASK		  0x0000fE00
+#define SXE_TX_CTXTD_OUTER_IPLEN_SHIFT	16
+#define SXE_TX_CTXTD_TUNNEL_LEN_SHIFT	 24
+
+#define SXE_VLAN_TAG_SIZE	 4
+
+#define SXE_RSS_KEY_SIZE				(40)
+#define SXE_MAX_RSS_KEY_ENTRIES		(10)
+#define SXE_MAX_RETA_ENTRIES			(128)
+
+#define SXE_TIMINC_IV_NS_SHIFT  8
+#define SXE_TIMINC_INCPD_SHIFT  24
+#define SXE_TIMINC_SET(incpd, iv_ns, iv_sns)   \
+	(((incpd) << SXE_TIMINC_INCPD_SHIFT) | \
+	((iv_ns) << SXE_TIMINC_IV_NS_SHIFT) | (iv_sns))
+
+#define PBA_STRATEGY_EQUAL	   (0)
+#define PBA_STRATEGY_WEIGHTED	(1)
+#define SXE_PKG_BUF_NUM_MAX			   (8)
+#define SXE_HW_TXRX_RING_NUM_MAX 128
+#define SXE_VMDQ_DCB_NUM_QUEUES  SXE_HW_TXRX_RING_NUM_MAX
+#define SXE_RX_PKT_BUF_SIZE				(512)
+
+#define SXE_UC_ENTRY_NUM_MAX   128
+#define SXE_HW_TX_NONE_MODE_Q_NUM 64
+
+#define SXE_MBX_MSG_NUM	16
+#define SXE_MBX_RETRY_INTERVAL   500
+#define SXE_MBX_RETRY_COUNT	  2000
+
+#define SXE_VF_UC_ENTRY_NUM_MAX 10
+#define SXE_VF_MC_ENTRY_NUM_MAX 30
+
+#define SXE_UTA_ENTRY_NUM_MAX   128
+#define SXE_MTA_ENTRY_NUM_MAX   128
+#define SXE_HASH_UC_NUM_MAX   4096
+
+#define  SXE_MAC_ADDR_EXTRACT_MASK  (0xFFF)
+#define  SXE_MAC_ADDR_SHIFT		 (5)
+#define  SXE_MAC_ADDR_REG_MASK	  (0x7F)
+#define  SXE_MAC_ADDR_BIT_MASK	  (0x1F)
+
+#define  SXE_VFT_TBL_SIZE		  (128)
+#define  SXE_VLAN_ID_SHIFT		 (5)
+#define  SXE_VLAN_ID_REG_MASK	  (0x7F)
+#define  SXE_VLAN_ID_BIT_MASK	  (0x1F)
+
+#define SXE_TX_PBSIZE_MAX	0x00028000
+#define SXE_TX_PKT_SIZE_MAX  0xA
+#define SXE_NODCB_TX_PKT_SIZE_MAX 0x14
+#define SXE_RING_ENABLE_WAIT_LOOP 10
+
+#define VFTA_BLOCK_SIZE		 8
+#define VF_BLOCK_BITS		   (32)
+#define SXE_MAX_MAC_HDR_LEN		127
+#define SXE_MAX_NETWORK_HDR_LEN		511
+#define SXE_MAC_ADDR_LEN		6
+
+#define SXE_FNAV_BUCKET_HASH_KEY	0x3DAD14E2
+#define SXE_FNAV_SAMPLE_HASH_KEY 0x174D3614
+#define SXE_SAMPLE_COMMON_HASH_KEY \
+		(SXE_FNAV_BUCKET_HASH_KEY & SXE_FNAV_SAMPLE_HASH_KEY)
+
+#define SXE_SAMPLE_HASH_MASK		0x7fff
+#define SXE_SAMPLE_L4TYPE_MASK		0x3
+#define SXE_SAMPLE_L4TYPE_UDP		0x1
+#define SXE_SAMPLE_L4TYPE_TCP		0x2
+#define SXE_SAMPLE_L4TYPE_SCTP		0x3
+#define SXE_SAMPLE_L4TYPE_IPV6_MASK	0x4
+#define SXE_SAMPLE_L4TYPE_TUNNEL_MASK	0x10
+#define SXE_SAMPLE_FLOW_TYPE_MASK	0xF
+
+#define SXE_SAMPLE_VM_POOL_MASK		0x7F
+#define SXE_SAMPLE_VLAN_MASK		0xEFFF
+#define SXE_SAMPLE_FLEX_BYTES_MASK	0xFFFF
+
+#define SXE_FNAV_INIT_DONE_POLL			   10
+#define SXE_FNAV_DROP_QUEUE				   127
+
+#define MAX_TRAFFIC_CLASS		8
+#define DEF_TRAFFIC_CLASS		1
+
+#define SXE_LINK_SPEED_UNKNOWN   0
+#define SXE_LINK_SPEED_10_FULL   0x0002
+#define SXE_LINK_SPEED_100_FULL  0x0008
+#define SXE_LINK_SPEED_1GB_FULL  0x0020
+#define SXE_LINK_SPEED_10GB_FULL 0x0080
+
+typedef u32 sxe_link_speed;
+#define SXE_LINK_MBPS_SPEED_DEFAULT 10000
+
+#define SXE_LINK_MBPS_SPEED_MIN   (10)
+
+enum sxe_rss_ip_version {
+	SXE_RSS_IP_VER_4 = 4,
+	SXE_RSS_IP_VER_6 = 6,
+};
+
+enum sxe_fnav_mode {
+	SXE_FNAV_SAMPLE_MODE = 1,
+	SXE_FNAV_SPECIFIC_MODE	= 2,
+};
+
+enum sxe_sample_type {
+	SXE_SAMPLE_FLOW_TYPE_IPV4   = 0x0,
+	SXE_SAMPLE_FLOW_TYPE_UDPV4  = 0x1,
+	SXE_SAMPLE_FLOW_TYPE_TCPV4  = 0x2,
+	SXE_SAMPLE_FLOW_TYPE_SCTPV4 = 0x3,
+	SXE_SAMPLE_FLOW_TYPE_IPV6   = 0x4,
+	SXE_SAMPLE_FLOW_TYPE_UDPV6  = 0x5,
+	SXE_SAMPLE_FLOW_TYPE_TCPV6  = 0x6,
+	SXE_SAMPLE_FLOW_TYPE_SCTPV6 = 0x7,
+};
+
+enum {
+	SXE_DIAG_TEST_PASSED				= 0,
+	SXE_DIAG_TEST_BLOCKED			   = 1,
+	SXE_DIAG_STATS_REG_TEST_ERR		 = 2,
+	SXE_DIAG_REG_PATTERN_TEST_ERR	   = 3,
+	SXE_DIAG_CHECK_REG_TEST_ERR		 = 4,
+	SXE_DIAG_DISABLE_IRQ_TEST_ERR	   = 5,
+	SXE_DIAG_ENABLE_IRQ_TEST_ERR		= 6,
+	SXE_DIAG_DISABLE_OTHER_IRQ_TEST_ERR = 7,
+	SXE_DIAG_TX_RING_CONFIGURE_ERR	  = 8,
+	SXE_DIAG_RX_RING_CONFIGURE_ERR	  = 9,
+	SXE_DIAG_ALLOC_SKB_ERR			  = 10,
+	SXE_DIAG_LOOPBACK_SEND_TEST_ERR	 = 11,
+	SXE_DIAG_LOOPBACK_RECV_TEST_ERR	 = 12,
+};
+
+#define SXE_RXD_STAT_DD	   0x01
+#define SXE_RXD_STAT_EOP	  0x02
+#define SXE_RXD_STAT_FLM	  0x04
+#define SXE_RXD_STAT_VP	   0x08
+#define SXE_RXDADV_NEXTP_MASK   0x000FFFF0
+#define SXE_RXDADV_NEXTP_SHIFT  0x00000004
+#define SXE_RXD_STAT_UDPCS	0x10
+#define SXE_RXD_STAT_L4CS	 0x20
+#define SXE_RXD_STAT_IPCS	 0x40
+#define SXE_RXD_STAT_PIF	  0x80
+#define SXE_RXD_STAT_CRCV	 0x100
+#define SXE_RXD_STAT_OUTERIPCS  0x100
+#define SXE_RXD_STAT_VEXT	 0x200
+#define SXE_RXD_STAT_UDPV	 0x400
+#define SXE_RXD_STAT_DYNINT   0x800
+#define SXE_RXD_STAT_LLINT	0x800
+#define SXE_RXD_STAT_TSIP	 0x08000
+#define SXE_RXD_STAT_TS	   0x10000
+#define SXE_RXD_STAT_SECP	 0x20000
+#define SXE_RXD_STAT_LB	   0x40000
+#define SXE_RXD_STAT_ACK	  0x8000
+#define SXE_RXD_ERR_CE		0x01
+#define SXE_RXD_ERR_LE		0x02
+#define SXE_RXD_ERR_PE		0x08
+#define SXE_RXD_ERR_OSE	   0x10
+#define SXE_RXD_ERR_USE	   0x20
+#define SXE_RXD_ERR_TCPE	  0x40
+#define SXE_RXD_ERR_IPE	   0x80
+#define SXE_RXDADV_ERR_MASK		   0xfff00000
+#define SXE_RXDADV_ERR_SHIFT		  20
+#define SXE_RXDADV_ERR_OUTERIPER	0x04000000
+#define SXE_RXDADV_ERR_FCEOFE		 0x80000000
+#define SXE_RXDADV_ERR_FCERR		  0x00700000
+#define SXE_RXDADV_ERR_FNAV_LEN	   0x00100000
+#define SXE_RXDADV_ERR_FNAV_DROP	  0x00200000
+#define SXE_RXDADV_ERR_FNAV_COLL	  0x00400000
+#define SXE_RXDADV_ERR_HBO	0x00800000
+#define SXE_RXDADV_ERR_CE	 0x01000000
+#define SXE_RXDADV_ERR_LE	 0x02000000
+#define SXE_RXDADV_ERR_PE	 0x08000000
+#define SXE_RXDADV_ERR_OSE	0x10000000
+#define SXE_RXDADV_ERR_IPSEC_INV_PROTOCOL  0x08000000
+#define SXE_RXDADV_ERR_IPSEC_INV_LENGTH	0x10000000
+#define SXE_RXDADV_ERR_IPSEC_AUTH_FAILED   0x18000000
+#define SXE_RXDADV_ERR_USE	0x20000000
+#define SXE_RXDADV_ERR_L4E	0x40000000
+#define SXE_RXDADV_ERR_IPE	0x80000000
+#define SXE_RXD_VLAN_ID_MASK  0x0FFF
+#define SXE_RXD_PRI_MASK	  0xE000
+#define SXE_RXD_PRI_SHIFT	 13
+#define SXE_RXD_CFI_MASK	  0x1000
+#define SXE_RXD_CFI_SHIFT	 12
+#define SXE_RXDADV_LROCNT_MASK		0x001E0000
+#define SXE_RXDADV_LROCNT_SHIFT	   17
+
+#define SXE_RXDADV_STAT_DD			SXE_RXD_STAT_DD
+#define SXE_RXDADV_STAT_EOP		   SXE_RXD_STAT_EOP
+#define SXE_RXDADV_STAT_FLM		   SXE_RXD_STAT_FLM
+#define SXE_RXDADV_STAT_VP			SXE_RXD_STAT_VP
+#define SXE_RXDADV_STAT_MASK		  0x000fffff
+#define SXE_RXDADV_STAT_TS		0x00010000
+#define SXE_RXDADV_STAT_SECP		0x00020000
+
+#define SXE_RXDADV_PKTTYPE_NONE	   0x00000000
+#define SXE_RXDADV_PKTTYPE_IPV4	   0x00000010
+#define SXE_RXDADV_PKTTYPE_IPV4_EX	0x00000020
+#define SXE_RXDADV_PKTTYPE_IPV6	   0x00000040
+#define SXE_RXDADV_PKTTYPE_IPV6_EX	0x00000080
+#define SXE_RXDADV_PKTTYPE_TCP		0x00000100
+#define SXE_RXDADV_PKTTYPE_UDP		0x00000200
+#define SXE_RXDADV_PKTTYPE_SCTP	   0x00000400
+#define SXE_RXDADV_PKTTYPE_NFS		0x00000800
+#define SXE_RXDADV_PKTTYPE_VXLAN	  0x00000800
+#define SXE_RXDADV_PKTTYPE_TUNNEL	 0x00010000
+#define SXE_RXDADV_PKTTYPE_IPSEC_ESP  0x00001000
+#define SXE_RXDADV_PKTTYPE_IPSEC_AH   0x00002000
+#define SXE_RXDADV_PKTTYPE_LINKSEC	0x00004000
+#define SXE_RXDADV_PKTTYPE_ETQF	   0x00008000
+#define SXE_RXDADV_PKTTYPE_ETQF_MASK  0x00000070
+#define SXE_RXDADV_PKTTYPE_ETQF_SHIFT 4
+
+struct sxe_mac_stats {
+	u64 crcerrs;
+	u64 errbc;
+	u64 rlec;
+	u64 prc64;
+	u64 prc127;
+	u64 prc255;
+	u64 prc511;
+	u64 prc1023;
+	u64 prc1522;
+	u64 gprc;
+	u64 bprc;
+	u64 mprc;
+	u64 gptc;
+	u64 gorc;
+	u64 gotc;
+	u64 ruc;
+	u64 rfc;
+	u64 roc;
+	u64 rjc;
+	u64 tor;
+	u64 tpr;
+	u64 tpt;
+	u64 ptc64;
+	u64 ptc127;
+	u64 ptc255;
+	u64 ptc511;
+	u64 ptc1023;
+	u64 ptc1522;
+	u64 mptc;
+	u64 bptc;
+	u64 qprc[16];
+	u64 qptc[16];
+	u64 qbrc[16];
+	u64 qbtc[16];
+	u64 qprdc[16];
+	u64 dburxtcin[8];
+	u64 dburxtcout[8];
+	u64 dburxgdreecnt[8];
+	u64 dburxdrofpcnt[8];
+	u64 dbutxtcin[8];
+	u64 dbutxtcout[8];
+	u64 rxdgpc;
+	u64 rxdgbc;
+	u64 rxddpc;
+	u64 rxddbc;
+	u64 rxtpcing;
+	u64 rxtpceng;
+	u64 rxlpbkpc;
+	u64 rxlpbkbc;
+	u64 rxdlpbkpc;
+	u64 rxdlpbkbc;
+	u64 prddc;
+	u64 txdgpc;
+	u64 txdgbc;
+	u64 txswerr;
+	u64 txswitch;
+	u64 txrepeat;
+	u64 txdescerr;
+
+	u64 fnavadd;
+	u64 fnavrmv;
+	u64 fnavadderr;
+	u64 fnavrmverr;
+	u64 fnavmatch;
+	u64 fnavmiss;
+	u64 hw_rx_no_dma_resources;
+	u64 prcpf[8];
+	u64 pfct[8];
+	u64 mpc[8];
+
+	u64 total_tx_pause;
+	u64 total_gptc;
+	u64 total_gotc;
+};
+
+#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_FILTER_CTRL
+enum sxe_fivetuple_protocol {
+	SXE_FILTER_PROTOCOL_TCP = 0,
+	SXE_FILTER_PROTOCOL_UDP,
+	SXE_FILTER_PROTOCOL_SCTP,
+	SXE_FILTER_PROTOCOL_NONE,
+};
+
+struct sxe_fivetuple_filter_info {
+	u32 src_ip;
+	u32 dst_ip;
+	u16 src_port;
+	u16 dst_port;
+	enum sxe_fivetuple_protocol protocol;
+	u8 priority;
+	u8 src_ip_mask:1,
+	   dst_ip_mask:1,
+	   src_port_mask:1,
+	   dst_port_mask:1,
+	   proto_mask:1;
+};
+
+struct sxe_fivetuple_node_info {
+	u16 index;
+	u16 queue;
+	struct sxe_fivetuple_filter_info filter_info;
+};
+#endif
+
+union sxe_fnav_rule_info {
+	struct {
+		u8	 vm_pool;
+		u8	 flow_type;
+		__be16 vlan_id;
+		__be32 dst_ip[4];
+		__be32 src_ip[4];
+		__be16 src_port;
+		__be16 dst_port;
+		__be16 flex_bytes;
+		__be16 bkt_hash;
+	} ntuple;
+	__be32 fast_access[11];
+};
+
+union sxe_sample_hash_dword {
+	struct {
+		u8 vm_pool;
+		u8 flow_type;
+		__be16 vlan_id;
+	} formatted;
+	__be32 ip;
+	struct {
+		__be16 src;
+		__be16 dst;
+	} port;
+	__be16 flex_bytes;
+	__be32 dword;
+};
+
+void sxe_hw_ops_init(struct sxe_hw *hw);
+
+
+struct sxe_reg_info {
+	u32 addr;
+	u32 count;
+	u32 stride;
+	const s8 *name;
+};
+
+struct sxe_setup_operations {
+	s32  (*reset)(struct sxe_hw *hw);
+	void (*pf_rst_done_set)(struct sxe_hw *hw);
+	void (*no_snoop_disable)(struct sxe_hw *hw);
+	u32  (*reg_read)(struct sxe_hw *hw, u32 reg);
+	void (*reg_write)(struct sxe_hw *hw, u32 reg, u32 val);
+	void (*regs_dump)(struct sxe_hw *hw);
+	void (*regs_flush)(struct sxe_hw *hw);
+	s32  (*regs_test)(struct sxe_hw *hw);
+};
+
+struct sxe_hw_setup {
+	const struct sxe_setup_operations *ops;
+};
+
+struct sxe_irq_operations {
+	u32  (*pending_irq_read_clear)(struct sxe_hw *hw);
+	void (*pending_irq_write_clear)(struct sxe_hw *hw, u32 value);
+	void (*irq_general_reg_set)(struct sxe_hw *hw, u32 value);
+	u32  (*irq_general_reg_get)(struct sxe_hw *hw);
+	void (*ring_irq_auto_disable)(struct sxe_hw *hw, bool is_misx);
+	void (*set_eitrsel)(struct sxe_hw *hw, u32 value);
+	void (*ring_irq_interval_set)(struct sxe_hw *hw, u16 irq_idx,
+			u32 interval);
+	void (*event_irq_interval_set)(struct sxe_hw *hw, u16 irq_idx,
+			u32 value);
+	void (*event_irq_auto_clear_set)(struct sxe_hw *hw, u32 value);
+	void (*ring_irq_map)(struct sxe_hw *hw, bool is_tx,
+							u16 reg_idx, u16 irq_idx);
+	void (*event_irq_map)(struct sxe_hw *hw, u8 offset, u16 irq_idx);
+	void (*ring_irq_enable)(struct sxe_hw *hw, u64 qmask);
+	u32  (*irq_cause_get)(struct sxe_hw *hw);
+	void (*event_irq_trigger)(struct sxe_hw *hw);
+	void (*ring_irq_trigger)(struct sxe_hw *hw, u64 eics);
+	void (*specific_irq_disable)(struct sxe_hw *hw, u32 value);
+	void (*specific_irq_enable)(struct sxe_hw *hw, u32 value);
+	u32  (*spp_state_get)(struct sxe_hw *hw);
+	void (*rx_los_disable)(struct sxe_hw *hw);
+	void (*rx_los_enable)(struct sxe_hw *hw);
+	void (*all_irq_disable)(struct sxe_hw *hw);
+	void (*spp_configure)(struct sxe_hw *hw, u32 value);
+	s32  (*irq_test)(struct sxe_hw *hw, u32 *icr, bool shared);
+};
+
+struct sxe_irq_info {
+	const struct sxe_irq_operations *ops;
+};
+
+struct sxe_mac_operations {
+	bool (*link_up_1g_check)(struct sxe_hw *hw);
+	bool (*link_state_is_up)(struct sxe_hw *hw);
+	u32  (*link_speed_get)(struct sxe_hw *hw);
+	void (*link_speed_set)(struct sxe_hw *hw, u32 speed);
+	void (*pad_enable)(struct sxe_hw *hw);
+	s32  (*fc_enable)(struct sxe_hw *hw);
+	void (*crc_configure)(struct sxe_hw *hw);
+	void (*loopback_switch)(struct sxe_hw *hw, bool val);
+	void (*txrx_enable)(struct sxe_hw *hw);
+	void (*max_frame_set)(struct sxe_hw *hw, u32 val);
+	u32  (*max_frame_get)(struct sxe_hw *hw);
+	void (*fc_autoneg_localcap_set)(struct sxe_hw *hw);
+	void (*fc_tc_high_water_mark_set)(struct sxe_hw *hw, u8 tc_idx, u32 val);
+	void (*fc_tc_low_water_mark_set)(struct sxe_hw *hw, u8 tc_idx, u32 val);
+	void (*fc_param_init)(struct sxe_hw *hw);
+	enum sxe_fc_mode (*fc_current_mode_get)(struct sxe_hw *hw);
+	enum sxe_fc_mode (*fc_requested_mode_get)(struct sxe_hw *hw);
+	void (*fc_requested_mode_set)(struct sxe_hw *hw, enum sxe_fc_mode e);
+	bool (*is_fc_autoneg_disabled)(struct sxe_hw *hw);
+	void (*fc_autoneg_disable_set)(struct sxe_hw *hw, bool val);
+};
+
+#define SXE_FLAGS_DOUBLE_RESET_REQUIRED	0x01
+
+struct sxe_mac_info {
+	const struct sxe_mac_operations	*ops;
+	u8   flags;
+	bool set_lben;
+	bool auto_restart;
+};
+
+struct sxe_filter_mac_operations {
+	u32 (*rx_mode_get)(struct sxe_hw *hw);
+	void (*rx_mode_set)(struct sxe_hw *hw, u32 filter_ctrl);
+	u32 (*pool_rx_mode_get)(struct sxe_hw *hw, u16 idx);
+	void (*pool_rx_mode_set)(struct sxe_hw *hw, u32 vmolr, u16 idx);
+	void (*rx_lro_enable)(struct sxe_hw *hw, bool is_enable);
+	void (*rx_udp_frag_checksum_disable)(struct sxe_hw *hw);
+	void (*uc_addr_pool_add)(struct sxe_hw *hw, u32 rar_idx, u32 pool_idx);
+	void (*uc_addr_pool_del)(struct sxe_hw *hw, u32 rar_idx, u32 pool_idx);
+	s32  (*uc_addr_add)(struct sxe_hw *hw, u32 rar_idx, u8 *addr, u32 pool_idx);
+	s32  (*uc_addr_del)(struct sxe_hw *hw, u32 index);
+	void (*uc_addr_clear)(struct sxe_hw *hw);
+	void (*uta_all_set)(struct sxe_hw *hw, u32 value);
+	void (*mta_hash_table_set)(struct sxe_hw *hw, u8 index, u32 value);
+	void (*mta_hash_table_update)(struct sxe_hw *hw, u8 reg_idx, u8 bit_idx);
+	void (*fc_mac_addr_set)(struct sxe_hw *hw, u8 *mac_addr);
+
+	void (*mc_filter_enable)(struct sxe_hw *hw);
+
+	void (*mc_filter_disable)(struct sxe_hw *hw);
+
+	void (*rx_nfs_filter_disable)(struct sxe_hw *hw);
+	void (*ethertype_filter_set)(struct sxe_hw *hw, u8 filter_type, u32 val);
+
+	void (*vt_ctrl_configure)(struct sxe_hw *hw, u8 num_vfs);
+
+#ifdef SXE_WOL_CONFIGURE
+	void (*wol_mode_set)(struct sxe_hw *hw, u32 wol_status);
+	void (*wol_mode_clean)(struct sxe_hw *hw);
+	void (*wol_status_set)(struct sxe_hw *hw);
+#endif
+
+	void (*vt_disable)(struct sxe_hw *hw);
+
+	s32 (*uc_addr_pool_enable)(struct sxe_hw *hw, u8 rar_idx, u8 pool_idx);
+	s32 (*uc_addr_pool_disable)(struct sxe_hw *hw, u8 rar_idx);
+};
+
+struct sxe_filter_mac {
+	const struct sxe_filter_mac_operations *ops;
+};
+
+struct sxe_filter_vlan_operations {
+	u32 (*pool_filter_read)(struct sxe_hw *hw, u16 reg_idx);
+	void (*pool_filter_write)(struct sxe_hw *hw, u16 reg_idx, u32 val);
+	u32 (*pool_filter_bitmap_read)(struct sxe_hw *hw, u16 reg_idx);
+	void (*pool_filter_bitmap_write)(struct sxe_hw *hw, u16 reg_idx, u32 val);
+	void (*filter_array_write)(struct sxe_hw *hw, u16 reg_idx, u32 val);
+	u32  (*filter_array_read)(struct sxe_hw *hw, u16 reg_idx);
+	void (*filter_array_clear)(struct sxe_hw *hw);
+	void (*filter_switch)(struct sxe_hw *hw, bool enable);
+	void (*untagged_pkts_rcv_switch)(struct sxe_hw *hw, u32 vf, bool accept);
+	s32  (*filter_configure)(struct sxe_hw *hw, u32 vid, u32 pool,
+								bool vlan_on, bool vlvf_bypass);
+};
+
+struct sxe_filter_vlan {
+	const struct sxe_filter_vlan_operations *ops;
+};
+
+struct sxe_filter_info {
+	struct sxe_filter_mac  mac;
+	struct sxe_filter_vlan vlan;
+};
+
+struct sxe_dbu_operations {
+	void (*rx_pkt_buf_size_configure)(struct sxe_hw *hw, u8 num_pb,
+			u32 headroom, u16 strategy);
+	void (*rx_pkt_buf_switch)(struct sxe_hw *hw, bool is_on);
+	void (*rx_multi_ring_configure)(struct sxe_hw *hw, u8 tcs,
+			bool is_4q, bool sriov_enable);
+	void (*rss_key_set_all)(struct sxe_hw *hw, u32 *rss_key);
+	void (*rss_redir_tbl_set_all)(struct sxe_hw *hw, u8 *redir_tbl);
+	void (*rx_cap_switch_on)(struct sxe_hw *hw);
+	void (*rss_hash_pkt_type_set)(struct sxe_hw *hw, u32 version);
+	void (*rss_hash_pkt_type_update)(struct sxe_hw *hw, u32 version);
+	void (*rss_rings_used_set)(struct sxe_hw *hw, u32 rss_num,
+			u16 pool, u16 pf_offset);
+	void (*lro_ack_switch)(struct sxe_hw *hw, bool is_on);
+	void (*vf_rx_switch)(struct sxe_hw *hw, u32 reg_offset,
+			u32 vf_index, bool is_off);
+
+	s32  (*fnav_mode_init)(struct sxe_hw *hw, u32 fnavctrl, u32 fnav_mode);
+	s32  (*fnav_specific_rule_mask_set)(struct sxe_hw *hw,
+						union sxe_fnav_rule_info *mask);
+	s32  (*fnav_specific_rule_add)(struct sxe_hw *hw,
+						union sxe_fnav_rule_info *input,
+						u16 soft_id, u8 queue);
+	s32  (*fnav_specific_rule_del)(struct sxe_hw *hw,
+					  union sxe_fnav_rule_info *input, u16 soft_id);
+	s32  (*fnav_sample_hash_cmd_get)(struct sxe_hw *hw,
+						u8 flow_type, u32 hash_value,
+						u8 queue, u64 *hash_cmd);
+	void (*fnav_sample_stats_reinit)(struct sxe_hw *hw);
+	void (*fnav_sample_hash_set)(struct sxe_hw *hw, u64 hash);
+	s32  (*fnav_single_sample_rule_del)(struct sxe_hw *hw, u32 hash);
+
+	void (*ptp_init)(struct sxe_hw *hw);
+	void (*ptp_freq_adjust)(struct sxe_hw *hw, u32 adj_freq);
+	void (*ptp_systime_init)(struct sxe_hw *hw);
+	u64  (*ptp_systime_get)(struct sxe_hw *hw);
+	void (*ptp_tx_timestamp_get)(struct sxe_hw *hw, u32 *ts_sec, u32 *ts_ns);
+	void (*ptp_timestamp_mode_set)(struct sxe_hw *hw, bool is_l2,
+			u32 tsctl, u32 tses);
+	void (*ptp_rx_timestamp_clear)(struct sxe_hw *hw);
+	u64  (*ptp_rx_timestamp_get)(struct sxe_hw *hw);
+	bool (*ptp_is_rx_timestamp_valid)(struct sxe_hw *hw);
+	void (*ptp_timestamp_enable)(struct sxe_hw *hw);
+
+	void (*tx_pkt_buf_switch)(struct sxe_hw *hw, bool is_on);
+
+	void (*dcb_tc_rss_configure)(struct sxe_hw *hw, u16 rss_i);
+
+	void (*tx_pkt_buf_size_configure)(struct sxe_hw *hw, u8 num_pb);
+
+	void (*rx_cap_switch_off)(struct sxe_hw *hw);
+	u32  (*rx_pkt_buf_size_get)(struct sxe_hw *hw, u8 pb);
+	void (*rx_func_switch_on)(struct sxe_hw *hw);
+
+	void (*tx_ring_disable)(struct sxe_hw *hw, u8 reg_idx,
+			unsigned long timeout);
+	void (*rx_ring_disable)(struct sxe_hw *hw, u8 reg_idx,
+			unsigned long timeout);
+
+	u32  (*tx_dbu_fc_status_get)(struct sxe_hw *hw);
+};
+
+struct sxe_dbu_info {
+	const struct sxe_dbu_operations	*ops;
+};
+
+
+struct sxe_dma_operations {
+	void (*rx_dma_ctrl_init)(struct sxe_hw *hw);
+	void (*rx_ring_disable)(struct sxe_hw *hw, u8 ring_idx);
+	void (*rx_ring_switch)(struct sxe_hw *hw, u8 reg_idx, bool is_on);
+	void (*rx_ring_switch_not_polling)(struct sxe_hw *hw, u8 reg_idx,
+										bool is_on);
+	void (*rx_ring_desc_configure)(struct sxe_hw *hw, u32 desc_mem_len,
+			u64 desc_dma_addr, u8 reg_idx);
+	void (*rx_desc_thresh_set)(struct sxe_hw *hw, u8 reg_idx);
+	void (*rx_rcv_ctl_configure)(struct sxe_hw *hw, u8 reg_idx,
+			u32 header_buf_len, u32 pkg_buf_len);
+	void (*rx_lro_ctl_configure)(struct sxe_hw *hw, u8 reg_idx, u32 max_desc);
+	u32  (*rx_desc_ctrl_get)(struct sxe_hw *hw, u8 reg_idx);
+	void (*rx_dma_lro_ctl_set)(struct sxe_hw *hw);
+	void (*rx_drop_switch)(struct sxe_hw *hw, u8 idx, bool is_enable);
+	void (*rx_tph_update)(struct sxe_hw *hw, u8 ring_idx, u8 cpu);
+
+	void (*tx_enable)(struct sxe_hw *hw);
+	void (*tx_multi_ring_configure)(struct sxe_hw *hw, u8 tcs, u16 pool_mask,
+			bool sriov_enable, u16 max_txq);
+	void (*tx_ring_desc_configure)(struct sxe_hw *hw, u32 desc_mem_len,
+			u64 desc_dma_addr, u8 reg_idx);
+	void (*tx_desc_thresh_set)(struct sxe_hw *hw, u8 reg_idx, u32 wb_thresh,
+			u32 host_thresh, u32 prefech_thresh);
+	void (*tx_ring_switch)(struct sxe_hw *hw, u8 reg_idx, bool is_on);
+	void (*tx_ring_switch_not_polling)(struct sxe_hw *hw, u8 reg_idx, bool is_on);
+	void (*tx_pkt_buf_thresh_configure)(struct sxe_hw *hw, u8 num_pb, bool dcb_enable);
+	u32  (*tx_desc_ctrl_get)(struct sxe_hw *hw, u8 reg_idx);
+	void (*tx_ring_info_get)(struct sxe_hw *hw, u8 idx, u32 *head, u32 *tail);
+	void (*tx_desc_wb_thresh_clear)(struct sxe_hw *hw, u8 reg_idx);
+
+	void (*vlan_tag_strip_switch)(struct sxe_hw *hw, u16 reg_index, bool is_enable);
+	void (*tx_vlan_tag_set)(struct sxe_hw *hw, u16 vid, u16 qos, u32 vf);
+	void (*tx_vlan_tag_clear)(struct sxe_hw *hw, u32 vf);
+	void (*tx_tph_update)(struct sxe_hw *hw, u8 ring_idx, u8 cpu);
+
+	void (*tph_switch)(struct sxe_hw *hw, bool is_enable);
+
+	void  (*dcb_rx_bw_alloc_configure)(struct sxe_hw *hw,
+					  u16 *refill,
+					  u16 *max,
+					  u8 *bwg_id,
+					  u8 *prio_type,
+					  u8 *prio_tc,
+					  u8 max_priority);
+	void  (*dcb_tx_desc_bw_alloc_configure)(struct sxe_hw *hw,
+					   u16 *refill,
+					   u16 *max,
+					   u8 *bwg_id,
+					   u8 *prio_type);
+	void  (*dcb_tx_data_bw_alloc_configure)(struct sxe_hw *hw,
+					   u16 *refill,
+					   u16 *max,
+					   u8 *bwg_id,
+					   u8 *prio_type,
+					   u8 *prio_tc,
+					   u8 max_priority);
+	void  (*dcb_pfc_configure)(struct sxe_hw *hw, u8 pfc_en, u8 *prio_tc,
+				  u8 max_priority);
+	void  (*dcb_tc_stats_configure)(struct sxe_hw *hw);
+	void (*dcb_rx_up_tc_map_set)(struct sxe_hw *hw, u8 tc);
+	void (*dcb_rx_up_tc_map_get)(struct sxe_hw *hw, u8 *map);
+	void (*dcb_rate_limiter_clear)(struct sxe_hw *hw, u8 ring_max);
+
+	void (*vt_pool_loopback_switch)(struct sxe_hw *hw, bool is_enable);
+	u32 (*rx_pool_get)(struct sxe_hw *hw, u8 reg_idx);
+	u32 (*tx_pool_get)(struct sxe_hw *hw, u8 reg_idx);
+	void (*tx_pool_set)(struct sxe_hw *hw, u8 reg_idx, u32 bitmap);
+	void (*rx_pool_set)(struct sxe_hw *hw, u8 reg_idx, u32 bitmap);
+
+	void (*vf_tx_desc_addr_clear)(struct sxe_hw *hw, u8 vf_idx, u8 ring_per_pool);
+	void (*pool_mac_anti_spoof_set)(struct sxe_hw *hw, u8 vf_idx, bool status);
+	void (*pool_vlan_anti_spoof_set)(struct sxe_hw *hw, u8 vf_idx, bool status);
+	void (*spoof_count_enable)(struct sxe_hw *hw, u8 reg_idx, u8 bit_index);
+	void (*pool_rx_ring_drop_enable)(struct sxe_hw *hw, u8 vf_idx,
+					u16 pf_vlan, u8 ring_per_pool);
+
+	void (*max_dcb_memory_window_set)(struct sxe_hw *hw, u32 value);
+	void (*dcb_tx_ring_rate_factor_set)(struct sxe_hw *hw, u32 ring_idx, u32 rate);
+
+	void (*vf_tx_ring_disable)(struct sxe_hw *hw, u8 ring_per_pool, u8 vf_idx);
+	void (*all_ring_disable)(struct sxe_hw *hw, u32 ring_max);
+	void (*tx_ring_tail_init)(struct sxe_hw *hw, u8 reg_idx);
+};
+
+struct sxe_dma_info {
+	const struct sxe_dma_operations	*ops;
+};
+
+struct sxe_sec_operations {
+	void (*ipsec_rx_ip_store)(struct sxe_hw *hw, __be32 *ip_addr, u8 ip_len, u8 ip_idx);
+	void (*ipsec_rx_spi_store)(struct sxe_hw *hw, __be32 spi, u8 ip_idx, u16 idx);
+	void (*ipsec_rx_key_store)(struct sxe_hw *hw, u32 *key,  u8 key_len,
+			u32 salt, u32 mode, u16 idx);
+	void (*ipsec_tx_key_store)(struct sxe_hw *hw, u32 *key,  u8 key_len, u32 salt, u16 idx);
+	void (*ipsec_sec_data_stop)(struct sxe_hw *hw, bool is_linkup);
+	void (*ipsec_engine_start)(struct sxe_hw *hw, bool is_linkup);
+	void (*ipsec_engine_stop)(struct sxe_hw *hw, bool is_linkup);
+	bool (*ipsec_offload_is_disable)(struct sxe_hw *hw);
+	void (*ipsec_sa_disable)(struct sxe_hw *hw);
+};
+
+struct sxe_sec_info {
+	const struct sxe_sec_operations *ops;
+};
+
+struct sxe_stat_operations {
+	void (*stats_clear)(struct sxe_hw *hw);
+	void (*stats_get)(struct sxe_hw *hw, struct sxe_mac_stats *st);
+
+	u32 (*tx_packets_num_get)(struct sxe_hw *hw);
+	u32 (*unsecurity_packets_num_get)(struct sxe_hw *hw);
+	u32  (*mac_stats_dump)(struct sxe_hw *hw, u32 *regs_buff, u32 buf_size);
+	u32  (*tx_dbu_to_mac_stats)(struct sxe_hw *hw);
+};
+
+struct sxe_stat_info {
+	const struct sxe_stat_operations	*ops;
+};
+
+struct sxe_mbx_operations {
+	void (*init)(struct sxe_hw *hw);
+
+	s32 (*msg_send)(struct sxe_hw *hw, u32 *msg, u16 len, u16 index);
+	s32 (*msg_rcv)(struct sxe_hw *hw, u32 *msg, u16 len, u16 index);
+
+	bool (*req_check)(struct sxe_hw *hw, u8 vf_idx);
+	bool (*ack_check)(struct sxe_hw *hw, u8 vf_idx);
+	bool (*rst_check)(struct sxe_hw *hw, u8 vf_idx);
+
+	void (*mbx_mem_clear)(struct sxe_hw *hw, u8 vf_idx);
+};
+
+struct sxe_mbx_stats {
+	u32 send_msgs;
+	u32 rcv_msgs;
+
+	u32 reqs;
+	u32 acks;
+	u32 rsts;
+};
+
+struct sxe_mbx_info {
+	const struct sxe_mbx_operations *ops;
+	struct sxe_mbx_stats stats;
+	u32 retry;
+	u32 interval;
+	u32 msg_len;
+};
+
+struct sxe_pcie_operations {
+	void (*vt_mode_set)(struct sxe_hw *hw, u32 value);
+};
+
+struct sxe_pcie_info {
+	const struct sxe_pcie_operations *ops;
+};
+
+enum sxe_hw_state {
+	SXE_HW_STOP,
+	SXE_HW_FAULT,
+};
+
+enum sxe_fc_mode {
+	SXE_FC_NONE = 0,
+	SXE_FC_RX_PAUSE,
+	SXE_FC_TX_PAUSE,
+	SXE_FC_FULL,
+	SXE_FC_DEFAULT,
+};
+
+struct sxe_fc_info {
+	u32 high_water[MAX_TRAFFIC_CLASS];
+	u32 low_water[MAX_TRAFFIC_CLASS];
+	u16 pause_time;
+	bool strict_ieee;
+	bool disable_fc_autoneg;
+	u16 send_xon;
+	enum sxe_fc_mode current_mode;
+	enum sxe_fc_mode requested_mode;
+};
+
+struct sxe_fc_nego_mode {
+	u32 adv_sym;
+	u32 adv_asm;
+	u32 lp_sym;
+	u32 lp_asm;
+
+};
+
+struct sxe_hdc_operations {
+	s32 (*pf_lock_get)(struct sxe_hw *hw, u32 trylock);
+	void (*pf_lock_release)(struct sxe_hw *hw, u32 retry_cnt);
+	bool (*is_fw_over_set)(struct sxe_hw *hw);
+	u32 (*fw_ack_header_rcv)(struct sxe_hw *hw);
+	void (*packet_send_done)(struct sxe_hw *hw);
+	void (*packet_header_send)(struct sxe_hw *hw, u32 value);
+	void (*packet_data_dword_send)(struct sxe_hw *hw,
+									u16 dword_index, u32 value);
+	u32  (*packet_data_dword_rcv)(struct sxe_hw *hw, u16 dword_index);
+	u32 (*fw_status_get)(struct sxe_hw *hw);
+	void (*drv_status_set)(struct sxe_hw *hw, u32 value);
+	u32 (*irq_event_get)(struct sxe_hw *hw);
+	void (*irq_event_clear)(struct sxe_hw *hw, u32 event);
+	void (*fw_ov_clear)(struct sxe_hw *hw);
+	u32 (*channel_state_get)(struct sxe_hw *hw);
+	void (*resource_clean)(struct sxe_hw *hw);
+};
+
+struct sxe_hdc_info {
+	u32 pf_lock_val;
+	const struct sxe_hdc_operations	*ops;
+};
+
+struct sxe_phy_operations {
+	s32 (*reg_write)(struct sxe_hw *hw, s32 prtad, u32 reg_addr,
+				u32 device_type, u16 phy_data);
+	s32 (*reg_read)(struct sxe_hw *hw, s32 prtad, u32 reg_addr,
+				u32 device_type, u16 *phy_data);
+	s32 (*identifier_get)(struct sxe_hw *hw, u32 prtad, u32 *id);
+	s32 (*link_cap_get)(struct sxe_hw *hw, u32 prtad, u32 *speed);
+	s32 (*reset)(struct sxe_hw *hw, u32 prtad);
+};
+
+struct sxe_phy_reg_info {
+	const struct sxe_phy_operations	*ops;
+};
+
+struct sxe_hw {
+	u8 __iomem *reg_base_addr;
+
+	void *adapter;
+	void *priv;
+	unsigned long state;
+	void (*fault_handle)(void *priv);
+	u32 (*reg_read)(const volatile void *reg);
+	void (*reg_write)(u32 value, volatile void *reg);
+
+	struct sxe_hw_setup  setup;
+	struct sxe_irq_info  irq;
+	struct sxe_mac_info  mac;
+	struct sxe_filter_info filter;
+	struct sxe_dbu_info  dbu;
+	struct sxe_dma_info  dma;
+	struct sxe_sec_info  sec;
+	struct sxe_stat_info stat;
+	struct sxe_fc_info   fc;
+
+	struct sxe_mbx_info mbx;
+	struct sxe_pcie_info pcie;
+	struct sxe_hdc_info  hdc;
+	struct sxe_phy_reg_info phy;
+};
+
+u16 sxe_mac_reg_num_get(void);
+
+void sxe_hw_fault_handle(struct sxe_hw *hw);
+
+bool sxe_device_supports_autoneg_fc(struct sxe_hw *hw);
+
+void sxe_hw_ops_init(struct sxe_hw *hw);
+
+u32 sxe_hw_rss_key_get_by_idx(struct sxe_hw *hw, u8 reg_idx);
+
+bool sxe_hw_is_rss_enabled(struct sxe_hw *hw);
+
+u32 sxe_hw_rss_field_get(struct sxe_hw *hw);
+
+static inline bool sxe_is_hw_fault(struct sxe_hw *hw)
+{
+	return test_bit(SXE_HW_FAULT, &hw->state);
+}
+
+static inline void sxe_hw_fault_handle_init(struct sxe_hw *hw,
+			void (*handle)(void *), void *priv)
+{
+	hw->priv = priv;
+	hw->fault_handle = handle;
+}
+
+static inline void sxe_hw_reg_handle_init(struct sxe_hw *hw,
+		u32 (*read)(const volatile void *),
+		void (*write)(u32, volatile void *))
+{
+	hw->reg_read  = read;
+	hw->reg_write = write;
+}
+
+#ifdef SXE_DPDK
+
+void sxe_hw_crc_strip_config(struct sxe_hw *hw, bool keep_crc);
+
+void sxe_hw_stats_seq_clean(struct sxe_hw *hw, struct sxe_mac_stats *stats);
+
+void sxe_hw_hdc_drv_status_set(struct sxe_hw *hw, u32 value);
+
+s32 sxe_hw_nic_reset(struct sxe_hw *hw);
+
+u16 sxe_hw_fc_pause_time_get(struct sxe_hw *hw);
+
+void sxe_hw_fc_pause_time_set(struct sxe_hw *hw, u16 pause_time);
+
+void sxe_fc_autoneg_localcap_set(struct sxe_hw *hw);
+
+u32 sxe_hw_fc_tc_high_water_mark_get(struct sxe_hw *hw, u8 tc_idx);
+
+u32 sxe_hw_fc_tc_low_water_mark_get(struct sxe_hw *hw, u8 tc_idx);
+
+u16 sxe_hw_fc_send_xon_get(struct sxe_hw *hw);
+
+void sxe_hw_fc_send_xon_set(struct sxe_hw *hw, u16 send_xon);
+
+u32 sxe_hw_rx_mode_get(struct sxe_hw *hw);
+
+void sxe_hw_rx_mode_set(struct sxe_hw *hw, u32 filter_ctrl);
+
+void sxe_hw_specific_irq_enable(struct sxe_hw *hw, u32 value);
+
+void sxe_hw_specific_irq_disable(struct sxe_hw *hw, u32 value);
+
+void sxe_hw_irq_general_reg_set(struct sxe_hw *hw, u32 value);
+
+u32 sxe_hw_irq_general_reg_get(struct sxe_hw *hw);
+
+void sxe_hw_event_irq_map(struct sxe_hw *hw, u8 offset, u16 irq_idx);
+
+void sxe_hw_ring_irq_map(struct sxe_hw *hw, bool is_tx,
+						u16 reg_idx, u16 irq_idx);
+
+void sxe_hw_ring_irq_interval_set(struct sxe_hw *hw,
+						u16 irq_idx, u32 interval);
+
+void sxe_hw_event_irq_auto_clear_set(struct sxe_hw *hw, u32 value);
+
+void sxe_hw_all_irq_disable(struct sxe_hw *hw);
+
+void sxe_hw_ring_irq_auto_disable(struct sxe_hw *hw,
+					bool is_msix);
+
+u32 sxe_hw_irq_cause_get(struct sxe_hw *hw);
+
+void sxe_hw_pending_irq_write_clear(struct sxe_hw *hw, u32 value);
+
+u32 sxe_hw_ring_irq_switch_get(struct sxe_hw *hw, u8 idx);
+
+void sxe_hw_ring_irq_switch_set(struct sxe_hw *hw, u8 idx, u32 value);
+
+s32 sxe_hw_uc_addr_add(struct sxe_hw *hw, u32 rar_idx,
+					u8 *addr, u32 pool_idx);
+
+s32 sxe_hw_uc_addr_del(struct sxe_hw *hw, u32 index);
+
+void sxe_hw_uc_addr_pool_del(struct sxe_hw *hw, u32 rar_idx, u32 pool_idx);
+
+u32 sxe_hw_uta_hash_table_get(struct sxe_hw *hw, u8 reg_idx);
+
+void sxe_hw_uta_hash_table_set(struct sxe_hw *hw,
+				u8 reg_idx, u32 value);
+
+u32 sxe_hw_mc_filter_get(struct sxe_hw *hw);
+
+void sxe_hw_mta_hash_table_set(struct sxe_hw *hw,
+						u8 index, u32 value);
+
+void sxe_hw_mc_filter_enable(struct sxe_hw *hw);
+
+void sxe_hw_vlan_filter_array_write(struct sxe_hw *hw,
+					u16 reg_index, u32 value);
+
+u32 sxe_hw_vlan_filter_array_read(struct sxe_hw *hw, u16 reg_index);
+
+void sxe_hw_vlan_filter_switch(struct sxe_hw *hw, bool is_enable);
+
+u32 sxe_hw_vlan_type_get(struct sxe_hw *hw);
+
+void sxe_hw_vlan_type_set(struct sxe_hw *hw, u32 value);
+
+void sxe_hw_vlan_ext_vet_write(struct sxe_hw *hw, u32 value);
+
+void sxe_hw_vlan_tag_strip_switch(struct sxe_hw *hw,
+					u16 reg_index, bool is_enable);
+
+void sxe_hw_txctl_vlan_type_set(struct sxe_hw *hw, u32 value);
+
+u32 sxe_hw_txctl_vlan_type_get(struct sxe_hw *hw);
+
+u32 sxe_hw_ext_vlan_get(struct sxe_hw *hw);
+
+void sxe_hw_ext_vlan_set(struct sxe_hw *hw, u32 value);
+
+void sxe_hw_pf_rst_done_set(struct sxe_hw *hw);
+
+u32 sxe_hw_all_regs_group_num_get(void);
+
+void sxe_hw_all_regs_group_read(struct sxe_hw *hw, u32 *data);
+
+s32 sxe_hw_fc_enable(struct sxe_hw *hw);
+
+bool sxe_hw_is_fc_autoneg_disabled(struct sxe_hw *hw);
+
+void sxe_hw_fc_status_get(struct sxe_hw *hw,
+					bool *rx_pause_on, bool *tx_pause_on);
+
+void sxe_hw_fc_requested_mode_set(struct sxe_hw *hw,
+						enum sxe_fc_mode mode);
+
+void sxe_hw_fc_tc_high_water_mark_set(struct sxe_hw *hw,
+							u8 tc_idx, u32 mark);
+
+void sxe_hw_fc_tc_low_water_mark_set(struct sxe_hw *hw,
+							u8 tc_idx, u32 mark);
+
+void sxe_hw_fc_autoneg_disable_set(struct sxe_hw *hw,
+							bool is_disabled);
+
+u32 sxe_hw_rx_pkt_buf_size_get(struct sxe_hw *hw, u8 pb);
+
+void sxe_hw_ptp_init(struct sxe_hw *hw);
+
+void sxe_hw_ptp_timestamp_mode_set(struct sxe_hw *hw,
+					bool is_l2, u32 tsctl, u32 tses);
+
+void sxe_hw_ptp_timestamp_enable(struct sxe_hw *hw);
+
+void sxe_hw_ptp_time_inc_stop(struct sxe_hw *hw);
+
+void sxe_hw_ptp_rx_timestamp_clear(struct sxe_hw *hw);
+
+void sxe_hw_ptp_timestamp_disable(struct sxe_hw *hw);
+
+bool sxe_hw_ptp_is_rx_timestamp_valid(struct sxe_hw *hw);
+
+u64 sxe_hw_ptp_rx_timestamp_get(struct sxe_hw *hw);
+
+void sxe_hw_ptp_tx_timestamp_get(struct sxe_hw *hw,
+						u32 *ts_sec, u32 *ts_ns);
+
+u64 sxe_hw_ptp_systime_get(struct sxe_hw *hw);
+
+void sxe_hw_rss_cap_switch(struct sxe_hw *hw, bool is_on);
+
+void sxe_hw_rss_key_set_all(struct sxe_hw *hw, u32 *rss_key);
+
+void sxe_hw_rss_field_set(struct sxe_hw *hw, u32 rss_field);
+
+void sxe_hw_rss_redir_tbl_set_all(struct sxe_hw *hw, u8 *redir_tbl);
+
+u32 sxe_hw_rss_redir_tbl_get_by_idx(struct sxe_hw *hw, u16 reg_idx);
+
+void sxe_hw_rss_redir_tbl_set_by_idx(struct sxe_hw *hw,
+						u16 reg_idx, u32 value);
+
+void sxe_hw_rx_dma_ctrl_init(struct sxe_hw *hw);
+
+void sxe_hw_mac_max_frame_set(struct sxe_hw *hw, u32 max_frame);
+
+void sxe_hw_rx_udp_frag_checksum_disable(struct sxe_hw *hw);
+
+void sxe_hw_rx_ip_checksum_offload_switch(struct sxe_hw *hw,
+							bool is_on);
+
+void sxe_hw_rx_ring_switch(struct sxe_hw *hw, u8 reg_idx, bool is_on);
+
+void sxe_hw_rx_ring_switch_not_polling(struct sxe_hw *hw, u8 reg_idx, bool is_on);
+
+void sxe_hw_rx_ring_desc_configure(struct sxe_hw *hw,
+					u32 desc_mem_len, u64 desc_dma_addr,
+					u8 reg_idx);
+
+void sxe_hw_rx_rcv_ctl_configure(struct sxe_hw *hw, u8 reg_idx,
+				   u32 header_buf_len, u32 pkg_buf_len
+				   );
+
+void sxe_hw_rx_drop_switch(struct sxe_hw *hw, u8 idx, bool is_enable);
+
+void sxe_hw_rx_desc_thresh_set(struct sxe_hw *hw, u8 reg_idx);
+
+void sxe_hw_rx_lro_ack_switch(struct sxe_hw *hw, bool is_on);
+
+void sxe_hw_rx_dma_lro_ctrl_set(struct sxe_hw *hw);
+
+void sxe_hw_rx_nfs_filter_disable(struct sxe_hw *hw);
+
+void sxe_hw_rx_lro_enable(struct sxe_hw *hw, bool is_enable);
+
+void sxe_hw_rx_lro_ctl_configure(struct sxe_hw *hw,
+						u8 reg_idx, u32 max_desc);
+void sxe_hw_loopback_switch(struct sxe_hw *hw, bool is_enable);
+
+void sxe_hw_rx_cap_switch_off(struct sxe_hw *hw);
+
+void sxe_hw_tx_ring_info_get(struct sxe_hw *hw,
+				u8 idx, u32 *head, u32 *tail);
+
+void sxe_hw_tx_ring_switch(struct sxe_hw *hw, u8 reg_idx, bool is_on);
+
+void sxe_hw_tx_ring_switch_not_polling(struct sxe_hw *hw, u8 reg_idx, bool is_on);
+
+void sxe_hw_rx_queue_desc_reg_configure(struct sxe_hw *hw,
+					u8 reg_idx, u32 rdh_value,
+					u32 rdt_value);
+
+u32 sxe_hw_hdc_fw_status_get(struct sxe_hw *hw);
+
+s32 sxe_hw_hdc_lock_get(struct sxe_hw *hw, u32 trylock);
+
+void sxe_hw_hdc_lock_release(struct sxe_hw *hw, u32 retry_cnt);
+
+bool sxe_hw_hdc_is_fw_over_set(struct sxe_hw *hw);
+
+void sxe_hw_hdc_fw_ov_clear(struct sxe_hw *hw);
+
+u32 sxe_hw_hdc_fw_ack_header_get(struct sxe_hw *hw);
+
+void sxe_hw_hdc_packet_send_done(struct sxe_hw *hw);
+
+void sxe_hw_hdc_packet_header_send(struct sxe_hw *hw, u32 value);
+
+void sxe_hw_hdc_packet_data_dword_send(struct sxe_hw *hw,
+						u16 dword_index, u32 value);
+
+u32 sxe_hw_hdc_packet_data_dword_rcv(struct sxe_hw *hw,
+						u16 dword_index);
+
+u32 sxe_hw_hdc_channel_state_get(struct sxe_hw *hw);
+
+u32 sxe_hw_pending_irq_read_clear(struct sxe_hw *hw);
+
+void sxe_hw_all_ring_disable(struct sxe_hw *hw, u32 ring_max);
+
+void sxe_hw_tx_ring_head_init(struct sxe_hw *hw, u8 reg_idx);
+
+void sxe_hw_tx_ring_tail_init(struct sxe_hw *hw, u8 reg_idx);
+
+void sxe_hw_tx_enable(struct sxe_hw *hw);
+
+void sxe_hw_tx_desc_thresh_set(struct sxe_hw *hw,
+				u8 reg_idx,
+				u32 wb_thresh,
+				u32 host_thresh,
+				u32 prefech_thresh);
+
+void sxe_hw_tx_pkt_buf_switch(struct sxe_hw *hw, bool is_on);
+
+void sxe_hw_tx_pkt_buf_size_configure(struct sxe_hw *hw, u8 num_pb);
+
+void sxe_hw_tx_pkt_buf_thresh_configure(struct sxe_hw *hw,
+					u8 num_pb, bool dcb_enable);
+
+void sxe_hw_tx_ring_desc_configure(struct sxe_hw *hw,
+					u32 desc_mem_len,
+					u64 desc_dma_addr, u8 reg_idx);
+
+void sxe_hw_mac_txrx_enable(struct sxe_hw *hw);
+
+void sxe_hw_rx_cap_switch_on(struct sxe_hw *hw);
+
+void sxe_hw_mac_pad_enable(struct sxe_hw *hw);
+
+bool sxe_hw_is_link_state_up(struct sxe_hw *hw);
+
+u32 sxe_hw_link_speed_get(struct sxe_hw *hw);
+
+void sxe_hw_fc_base_init(struct sxe_hw *hw);
+
+void sxe_hw_stats_get(struct sxe_hw *hw, struct sxe_mac_stats *stats);
+
+void sxe_hw_rxq_stat_map_set(struct sxe_hw *hw, u8 idx, u32 value);
+
+void sxe_hw_txq_stat_map_set(struct sxe_hw *hw, u8 idx, u32 value);
+
+void sxe_hw_uc_addr_clear(struct sxe_hw *hw);
+
+void sxe_hw_vt_disable(struct sxe_hw *hw);
+
+void sxe_hw_stats_regs_clean(struct sxe_hw *hw);
+
+void sxe_hw_vlan_ext_type_set(struct sxe_hw *hw, u32 value);
+
+void sxe_hw_link_speed_set(struct sxe_hw *hw, u32 speed);
+
+void sxe_hw_crc_configure(struct sxe_hw *hw);
+
+void sxe_hw_vlan_filter_array_clear(struct sxe_hw *hw);
+
+void sxe_hw_no_snoop_disable(struct sxe_hw *hw);
+
+void sxe_hw_dcb_rate_limiter_clear(struct sxe_hw *hw, u8 ring_max);
+
+s32 sxe_hw_pfc_enable(struct sxe_hw *hw, u8 tc_idx);
+
+void sxe_hw_dcb_vmdq_mq_configure(struct sxe_hw *hw, u8 num_pools);
+
+void sxe_hw_dcb_vmdq_default_pool_configure(struct sxe_hw *hw,
+						u8 default_pool_enabled,
+						u8 default_pool_idx);
+
+void sxe_hw_dcb_vmdq_up_2_tc_configure(struct sxe_hw *hw,
+						u8 *tc_arr);
+
+void sxe_hw_dcb_vmdq_vlan_configure(struct sxe_hw *hw,
+						u8 num_pools);
+
+void sxe_hw_dcb_vmdq_pool_configure(struct sxe_hw *hw,
+						u8 pool_idx, u16 vlan_id,
+						u64 pools_map);
+
+void sxe_hw_dcb_rx_configure(struct sxe_hw *hw, bool is_vt_on,
+					u8 sriov_active, u8 pg_tcs);
+
+void sxe_hw_dcb_tx_configure(struct sxe_hw *hw, bool is_vt_on, u8 pg_tcs);
+
+void sxe_hw_pool_xmit_enable(struct sxe_hw *hw, u16 reg_idx, u8 pool_num);
+
+void sxe_hw_rx_pkt_buf_size_set(struct sxe_hw *hw, u8 tc_idx, u16 pbsize);
+
+void sxe_hw_dcb_tc_stats_configure(struct sxe_hw *hw,
+					u8 tc_count, bool vmdq_active);
+
+void sxe_hw_dcb_rx_bw_alloc_configure(struct sxe_hw *hw,
+					  u16 *refill,
+					  u16 *max,
+					  u8 *bwg_id,
+					  u8 *prio_type,
+					  u8 *prio_tc,
+					  u8 max_priority);
+
+void sxe_hw_dcb_tx_desc_bw_alloc_configure(struct sxe_hw *hw,
+					   u16 *refill,
+					   u16 *max,
+					   u8 *bwg_id,
+					   u8 *prio_type);
+
+void sxe_hw_dcb_tx_data_bw_alloc_configure(struct sxe_hw *hw,
+					   u16 *refill,
+					   u16 *max,
+					   u8 *bwg_id,
+					   u8 *prio_type,
+					   u8 *prio_tc,
+					   u8 max_priority);
+
+void sxe_hw_dcb_pfc_configure(struct sxe_hw *hw,
+						u8 pfc_en, u8 *prio_tc,
+						u8 max_priority);
+
+void sxe_hw_vmdq_mq_configure(struct sxe_hw *hw);
+
+void sxe_hw_vmdq_default_pool_configure(struct sxe_hw *hw,
+						u8 default_pool_enabled,
+						u8 default_pool_idx);
+
+void sxe_hw_vmdq_vlan_configure(struct sxe_hw *hw,
+						u8 num_pools, u32 rx_mode);
+
+void sxe_hw_vmdq_pool_configure(struct sxe_hw *hw,
+						u8 pool_idx, u16 vlan_id,
+						u64 pools_map);
+
+void sxe_hw_vmdq_loopback_configure(struct sxe_hw *hw);
+
+void sxe_hw_tx_multi_queue_configure(struct sxe_hw *hw,
+				bool vmdq_enable, bool sriov_enable, u16 pools_num);
+
+void sxe_hw_dcb_max_mem_window_set(struct sxe_hw *hw, u32 value);
+
+void sxe_hw_dcb_tx_ring_rate_factor_set(struct sxe_hw *hw,
+							u32 ring_idx, u32 rate);
+
+void sxe_hw_mbx_init(struct sxe_hw *hw);
+
+void sxe_hw_vt_ctrl_cfg(struct sxe_hw *hw, u8 num_vfs);
+
+void sxe_hw_tx_pool_bitmap_set(struct sxe_hw *hw,
+						u8 reg_idx, u32 bitmap);
+
+void sxe_hw_rx_pool_bitmap_set(struct sxe_hw *hw,
+						u8 reg_idx, u32 bitmap);
+
+void sxe_hw_vt_pool_loopback_switch(struct sxe_hw *hw,
+						bool is_enable);
+
+void sxe_hw_mac_pool_clear(struct sxe_hw *hw, u8 rar_idx);
+
+s32 sxe_hw_uc_addr_pool_enable(struct sxe_hw *hw,
+						u8 rar_idx, u8 pool_idx);
+
+s32 sxe_hw_uc_addr_single_pool_disable(struct sxe_hw *hw,
+				u8 rar_idx, u8 pool_idx);
+
+void sxe_hw_pcie_vt_mode_set(struct sxe_hw *hw, u32 value);
+
+u32 sxe_hw_pcie_vt_mode_get(struct sxe_hw *hw);
+
+void sxe_hw_pool_mac_anti_spoof_set(struct sxe_hw *hw,
+							u8 vf_idx, bool status);
+
+void sxe_rx_fc_threshold_set(struct sxe_hw *hw);
+
+void sxe_hw_rx_multi_ring_configure(struct sxe_hw *hw,
+						u8 tcs, bool is_4Q,
+						bool sriov_enable);
+
+void sxe_hw_rx_queue_mode_set(struct sxe_hw *hw, u32 mrqc);
+
+bool sxe_hw_vf_rst_check(struct sxe_hw *hw, u8 vf_idx);
+
+bool sxe_hw_vf_req_check(struct sxe_hw *hw, u8 vf_idx);
+
+bool sxe_hw_vf_ack_check(struct sxe_hw *hw, u8 vf_idx);
+
+s32 sxe_hw_rcv_msg_from_vf(struct sxe_hw *hw, u32 *msg,
+				u16 msg_len, u16 index);
+
+s32 sxe_hw_send_msg_to_vf(struct sxe_hw *hw, u32 *msg,
+				u16 msg_len, u16 index);
+
+void sxe_hw_mbx_mem_clear(struct sxe_hw *hw, u8 vf_idx);
+
+u32 sxe_hw_pool_rx_mode_get(struct sxe_hw *hw, u16 pool_idx);
+
+void sxe_hw_pool_rx_mode_set(struct sxe_hw *hw,
+						u32 vmolr, u16 pool_idx);
+
+void sxe_hw_tx_vlan_tag_clear(struct sxe_hw *hw, u32 vf);
+
+u32 sxe_hw_rx_pool_bitmap_get(struct sxe_hw *hw, u8 reg_idx);
+
+u32 sxe_hw_tx_pool_bitmap_get(struct sxe_hw *hw, u8 reg_idx);
+
+void sxe_hw_pool_rx_ring_drop_enable(struct sxe_hw *hw, u8 vf_idx,
+					u16 pf_vlan, u8 ring_per_pool);
+
+void sxe_hw_spoof_count_enable(struct sxe_hw *hw,
+						u8 reg_idx, u8 bit_index);
+
+u32 sxe_hw_tx_vlan_insert_get(struct sxe_hw *hw, u32 vf);
+
+bool sxe_hw_vt_status(struct sxe_hw *hw);
+
+s32 sxe_hw_vlvf_slot_find(struct sxe_hw *hw, u32 vlan, bool vlvf_bypass);
+
+u32 sxe_hw_vlan_pool_filter_read(struct sxe_hw *hw, u16 reg_index);
+
+void sxe_hw_mirror_vlan_set(struct sxe_hw *hw, u8 idx, u32 lsb, u32 msb);
+
+void sxe_hw_mirror_virtual_pool_set(struct sxe_hw *hw, u8 idx, u32 lsb, u32 msb);
+
+void sxe_hw_mirror_ctl_set(struct sxe_hw *hw, u8 rule_id,
+					u8 mirror_type, u8 dst_pool, bool on);
+
+void sxe_hw_mirror_rule_clear(struct sxe_hw *hw, u8 rule_id);
+
+void sxe_hw_mac_reuse_add(struct rte_eth_dev *dev,
+				 u8 *mac_addr, u8 rar_idx);
+
+void sxe_hw_mac_reuse_del(struct rte_eth_dev *dev,
+				 u8 *mac_addr, u8 pool_idx, u8 rar_idx);
+
+u32 sxe_hw_mac_max_frame_get(struct sxe_hw *hw);
+
+void sxe_hw_mta_hash_table_update(struct sxe_hw *hw,
+						u8 reg_idx, u8 bit_idx);
+
+void sxe_hw_vf_queue_drop_enable(struct sxe_hw *hw, u8 vf_idx,
+					u8 ring_per_pool);
+void sxe_hw_fc_mac_addr_set(struct sxe_hw *hw, u8 *mac_addr);
+
+void sxe_hw_macsec_enable(struct sxe_hw *hw, bool is_up, u32 tx_mode,
+				u32 rx_mode, u32 pn_trh);
+
+void sxe_hw_macsec_disable(struct sxe_hw *hw, bool is_up);
+
+void sxe_hw_macsec_txsc_set(struct sxe_hw *hw, u32 scl, u32 sch);
+
+void sxe_hw_macsec_rxsc_set(struct sxe_hw *hw, u32 scl, u32 sch, u16 pi);
+
+void sxe_hw_macsec_tx_sa_configure(struct sxe_hw *hw, u8 sa_idx,
+				u8 an, u32 pn, u32 *keys);
+
+void sxe_hw_macsec_rx_sa_configure(struct sxe_hw *hw, u8 sa_idx,
+				u8 an, u32 pn, u32 *keys);
+void sxe_hw_vt_pool_loopback_switch(struct sxe_hw *hw,
+							bool is_enable);
+
+#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_FILTER_CTRL
+void sxe_hw_fnav_rx_pkt_buf_size_reset(struct sxe_hw *hw, u32 pbsize);
+
+void sxe_hw_fnav_flex_mask_set(struct sxe_hw *hw, u16 flex_mask);
+
+void sxe_hw_fnav_ipv6_mask_set(struct sxe_hw *hw, u16 src_mask, u16 dst_mask);
+
+s32 sxe_hw_fnav_flex_offset_set(struct sxe_hw *hw, u16 offset);
+
+void sxe_hw_fivetuple_filter_add(struct rte_eth_dev *dev,
+				struct sxe_fivetuple_node_info *filter);
+
+void sxe_hw_fivetuple_filter_del(struct sxe_hw *hw, u16 reg_index);
+
+void sxe_hw_ethertype_filter_add(struct sxe_hw *hw,
+					u8 reg_index, u16 ethertype, u16 queue);
+
+void sxe_hw_ethertype_filter_del(struct sxe_hw *hw, u8 filter_type);
+
+void sxe_hw_syn_filter_add(struct sxe_hw *hw, u16 queue, u8 priority);
+
+void sxe_hw_syn_filter_del(struct sxe_hw *hw);
+
+void sxe_hw_rss_key_set_all(struct sxe_hw *hw, u32 *rss_key);
+#endif
+
+void sxe_hw_fnav_enable(struct sxe_hw *hw, u32 fnavctrl);
+
+s32 sxe_hw_fnav_sample_rules_table_reinit(struct sxe_hw *hw);
+
+s32 sxe_hw_fnav_specific_rule_add(struct sxe_hw *hw,
+					  union sxe_fnav_rule_info *input,
+					  u16 soft_id, u8 queue);
+
+s32 sxe_hw_fnav_specific_rule_del(struct sxe_hw *hw,
+					  union sxe_fnav_rule_info *input,
+					  u16 soft_id);
+
+void sxe_hw_fnav_sample_rule_configure(struct sxe_hw *hw,
+					  u8 flow_type, u32 hash_value, u8 queue);
+
+void sxe_hw_rss_redir_tbl_reg_write(struct sxe_hw *hw,
+						u16 reg_idx, u32 value);
+
+u32 sxe_hw_fnav_port_mask_get(__be16 src_port_mask, __be16 dst_port_mask);
+
+s32 sxe_hw_fnav_specific_rule_mask_set(struct sxe_hw *hw,
+					union sxe_fnav_rule_info *input_mask);
+
+s32 sxe_hw_vlan_filter_configure(struct sxe_hw *hw,
+					u32 vid, u32 pool,
+					bool vlan_on, bool vlvf_bypass);
+
+void sxe_hw_ptp_systime_init(struct sxe_hw *hw);
+
+#endif
+#endif
diff --git a/drivers/net/sxe/base/sxe_logs.h b/drivers/net/sxe/base/sxe_logs.h
new file mode 100644
index 0000000000..2776b8f6a6
--- /dev/null
+++ b/drivers/net/sxe/base/sxe_logs.h
@@ -0,0 +1,105 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+
+#ifndef _SXE_LOGS_H_
+#define _SXE_LOGS_H_
+
+#include <stdio.h>
+#include <sys/time.h>
+#include <pthread.h>
+
+#include "sxe_types.h"
+
+#define LOG_FILE_NAME_LEN	 256
+#define LOG_FILE_PATH		 "/var/log/"
+#define LOG_FILE_PREFIX	   "sxepmd.log"
+
+extern s32 sxe_log_init;
+extern s32 sxe_log_rx;
+extern s32 sxe_log_tx;
+extern s32 sxe_log_drv;
+extern s32 sxe_log_hw;
+
+#define RTE_LOGTYPE_sxe_log_init sxe_log_init
+#define RTE_LOGTYPE_sxe_log_rx sxe_log_rx
+#define RTE_LOGTYPE_sxe_log_tx sxe_log_tx
+#define RTE_LOGTYPE_sxe_log_drv sxe_log_drv
+#define RTE_LOGTYPE_sxe_log_hw sxe_log_hw
+
+#define INIT sxe_log_init
+#define RX   sxe_log_rx
+#define TX   sxe_log_tx
+#define HW   sxe_log_hw
+#define DRV  sxe_log_drv
+
+#define UNUSED(x)	((void)(x))
+
+#define  TIME(log_time) \
+	do { \
+		struct timeval	tv; \
+		struct tm *td; \
+		gettimeofday(&tv, NULL); \
+		td = localtime(&tv.tv_sec); \
+		strftime(log_time, sizeof(log_time), "%Y-%m-%d-%H:%M:%S", td); \
+	} while (0)
+
+#define filename_printf(x) (strrchr((x), '/') ? strrchr((x), '/') + 1 : (x))
+
+#define PMD_LOG_DEBUG(logtype, ...) \
+		RTE_LOG_LINE_PREFIX(DEBUG, logtype, "%s(): ",\
+			__func__, __VA_ARGS__)
+
+#define PMD_LOG_INFO(logtype, ...) \
+		RTE_LOG_LINE_PREFIX(INFO, logtype, "%s(): ",\
+			__func__, __VA_ARGS__)
+
+#define PMD_LOG_NOTICE(logtype, ...) \
+		RTE_LOG_LINE_PREFIX(NOTICE, logtype, "%s(): ",\
+			__func__, __VA_ARGS__)
+
+#define PMD_LOG_WARN(logtype, ...) \
+		RTE_LOG_LINE_PREFIX(WARNING, logtype, "%s(): ",\
+			__func__, __VA_ARGS__)
+
+#define PMD_LOG_ERR(logtype, ...) \
+		RTE_LOG_LINE_PREFIX(ERR, logtype, "%s(): ",\
+			__func__, __VA_ARGS__)
+
+#define PMD_LOG_CRIT(logtype, ...) \
+		RTE_LOG_LINE_PREFIX(CRIT, logtype, "%s(): ",\
+			__func__, __VA_ARGS__)
+
+#define PMD_LOG_ALERT(logtype, ...) \
+		RTE_LOG_LINE_PREFIX(ALERT, logtype, "%s(): ",\
+			__func__, __VA_ARGS__)
+
+#define PMD_LOG_EMERG(logtype, ...) \
+		RTE_LOG_LINE_PREFIX(EMERG, logtype, "%s(): ",\
+			__func__, __VA_ARGS__)
+
+
+#define PMD_INIT_FUNC_TRACE() PMD_LOG_DEBUG(INIT, " >>")
+
+#define LOG_DEBUG(fmt, ...) UNUSED(fmt)
+#define LOG_INFO(fmt, ...) UNUSED(fmt)
+#define LOG_WARN(fmt, ...) UNUSED(fmt)
+#define LOG_ERROR(fmt, ...) UNUSED(fmt)
+#define LOG_DEBUG_BDF(fmt, ...) UNUSED(adapter)
+#define LOG_INFO_BDF(fmt, ...) UNUSED(adapter)
+#define LOG_WARN_BDF(fmt, ...) UNUSED(adapter)
+#define LOG_ERROR_BDF(fmt, ...) UNUSED(adapter)
+
+#define LOG_DEV_DEBUG(fmt, ...) UNUSED(adapter)
+#define LOG_DEV_INFO(fmt, ...) UNUSED(adapter)
+#define LOG_DEV_WARN(fmt, ...) UNUSED(adapter)
+#define LOG_DEV_ERR(fmt, ...) UNUSED(adapter)
+#define LOG_MSG_DEBUG(msglvl, fmt, ...) UNUSED(adapter)
+#define LOG_MSG_INFO(msglvl, fmt, ...) UNUSED(adapter)
+#define LOG_MSG_WARN(msglvl, fmt, ...) UNUSED(adapter)
+#define LOG_MSG_ERR(msglvl, fmt, ...) UNUSED(adapter)
+
+
+void sxe_log_stream_init(void);
+
+#endif
diff --git a/drivers/net/sxe/base/sxe_types.h b/drivers/net/sxe/base/sxe_types.h
new file mode 100644
index 0000000000..a36a3cfbf6
--- /dev/null
+++ b/drivers/net/sxe/base/sxe_types.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+#ifndef __SXE_DPDK_TYPES_H__
+#define __SXE_DPDK_TYPES_H__
+
+#include <sys/time.h>
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <errno.h>
+#include <stdarg.h>
+#include <unistd.h>
+#include <string.h>
+
+#include <rte_common.h>
+
+typedef uint8_t		u8;
+typedef uint16_t	u16;
+typedef uint32_t	u32;
+typedef uint64_t	u64;
+
+typedef char		s8;
+typedef int16_t		s16;
+typedef int32_t		s32;
+typedef int64_t		s64;
+
+typedef s8		S8;
+typedef s16		S16;
+typedef s32		S32;
+
+#define __le16  u16
+#define __le32  u32
+#define __le64  u64
+
+#define __be16  u16
+#define __be32  u32
+#define __be64  u64
+
+#endif
diff --git a/drivers/net/sxe/include/drv_msg.h b/drivers/net/sxe/include/drv_msg.h
new file mode 100644
index 0000000000..87c505569d
--- /dev/null
+++ b/drivers/net/sxe/include/drv_msg.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+
+#ifndef __DRV_MSG_H__
+#define __DRV_MSG_H__
+
+#ifdef SXE_HOST_DRIVER
+#include "sxe_drv_type.h"
+#endif
+
+#define SXE_VERSION_LEN 32
+
+typedef struct sxe_version_resp {
+	u8 fw_version[SXE_VERSION_LEN];
+} sxe_version_resp_s;
+
+#endif
diff --git a/drivers/net/sxe/include/sxe/sxe_hdc.h b/drivers/net/sxe/include/sxe/sxe_hdc.h
new file mode 100644
index 0000000000..accff9e9e6
--- /dev/null
+++ b/drivers/net/sxe/include/sxe/sxe_hdc.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+
+#ifndef __SXE_HDC_H__
+#define __SXE_HDC_H__
+
+#ifdef SXE_HOST_DRIVER
+#include "sxe_drv_type.h"
+#endif
+
+#define HDC_CACHE_TOTAL_LEN	 (16 * 1024)
+#define ONE_PACKET_LEN_MAX	  (1024)
+#define DWORD_NUM			   (256)
+#define HDC_TRANS_RETRY_COUNT   (3)
+
+
+typedef enum sxe_hdc_errno_code {
+	PKG_OK			= 0,
+	PKG_ERR_REQ_LEN,
+	PKG_ERR_RESP_LEN,
+	PKG_ERR_PKG_SKIP,
+	PKG_ERR_NODATA,
+	PKG_ERR_PF_LK,
+	PKG_ERR_OTHER,
+} sxe_hdc_errno_code_e;
+
+typedef union hdc_header {
+	struct {
+		u8 pid:4;
+		u8 err_code:4;
+		u8 len;
+		u16 start_pkg:1;
+		u16 end_pkg:1;
+		u16 is_rd:1;
+		u16 msi:1;
+		u16 total_len:12;
+	} head;
+	u32 dw0;
+} hdc_header_u;
+
+#endif
diff --git a/drivers/net/sxe/include/sxe/sxe_msg.h b/drivers/net/sxe/include/sxe/sxe_msg.h
new file mode 100644
index 0000000000..460258c907
--- /dev/null
+++ b/drivers/net/sxe/include/sxe/sxe_msg.h
@@ -0,0 +1,135 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+
+#ifndef __SXE_MSG_H__
+#define __SXE_MSG_H__
+
+#ifdef SXE_HOST_DRIVER
+#include "sxe_drv_type.h"
+#endif
+
+#define SXE_MAC_ADDR_LEN 6
+
+#define SXE_HDC_CMD_HDR_SIZE  sizeof(struct sxe_hdc_cmd_hdr)
+#define SXE_HDC_MSG_HDR_SIZE  sizeof(struct sxe_hdc_drv_cmd_msg)
+
+enum sxe_cmd_type {
+	SXE_CMD_TYPE_CLI,
+	SXE_CMD_TYPE_DRV,
+	SXE_CMD_TYPE_UNKNOWN,
+};
+
+typedef struct sxe_hdc_cmd_hdr {
+	U8 cmd_type;
+	U8 cmd_sub_type;
+	U8 reserve[6];
+} sxe_hdc_cmd_hdr_s;
+
+typedef enum sxe_fw_state {
+	SXE_FW_START_STATE_UNDEFINED	= 0x00,
+	SXE_FW_START_STATE_INIT_BASE	= 0x10,
+	SXE_FW_START_STATE_SCAN_DEVICE  = 0x20,
+	SXE_FW_START_STATE_FINISHED	 = 0x30,
+	SXE_FW_START_STATE_UPGRADE	  = 0x31,
+	SXE_FW_RUNNING_STATE_ABNOMAL	= 0x40,
+	SXE_FW_START_STATE_MASK		 = 0xF0,
+} sxe_fw_state_e;
+
+typedef struct sxe_fw_state_info {
+	U8 soc_status;
+	char stat_buff[32];
+} sxe_fw_state_info_s;
+
+
+typedef enum msi_evt {
+	MSI_EVT_SOC_STATUS		  = 0x1,
+	MSI_EVT_HDC_FWOV			= 0x2,
+	MSI_EVT_HDC_TIME_SYNC	   = 0x4,
+
+	MSI_EVT_MAX				 = 0x80000000,
+} msi_evt_u;
+
+
+typedef enum sxe_fw_hd_state {
+	SXE_FW_HDC_TRANSACTION_IDLE = 0x01,
+	SXE_FW_HDC_TRANSACTION_BUSY,
+
+	SXE_FW_HDC_TRANSACTION_ERR,
+} sxe_fw_hd_state_e;
+
+enum sxe_hdc_cmd_opcode {
+	SXE_CMD_SET_WOL		 = 1,
+	SXE_CMD_LED_CTRL,
+	SXE_CMD_SFP_READ,
+	SXE_CMD_SFP_WRITE,
+	SXE_CMD_TX_DIS_CTRL	 = 5,
+	SXE_CMD_TINE_SYNC,
+	SXE_CMD_RATE_SELECT,
+	SXE_CMD_R0_MAC_GET,
+	SXE_CMD_LOG_EXPORT,
+	SXE_CMD_FW_VER_GET  = 10,
+	SXE_CMD_PCS_SDS_INIT,
+	SXE_CMD_AN_SPEED_GET,
+	SXE_CMD_AN_CAP_GET,
+	SXE_CMD_GET_SOC_INFO,
+	SXE_CMD_MNG_RST = 15,
+
+	SXE_CMD_MAX,
+};
+
+enum sxe_hdc_cmd_errcode {
+	SXE_ERR_INVALID_PARAM = 1,
+};
+
+typedef struct sxe_hdc_drv_cmd_msg {
+	U16 opcode;
+	U16 errcode;
+	union data_length {
+		U16 req_len;
+		U16 ack_len;
+	} length;
+	U8 reserve[8];
+	U64 traceid;
+	U8 body[0];
+} sxe_hdc_drv_cmd_msg_s;
+
+
+typedef struct sxe_sfp_rw_req {
+	U16 offset;
+	U16 len;
+	U8  write_data[0];
+} sxe_sfp_rw_req_s;
+
+
+typedef struct sxe_sfp_read_resp {
+	U16 len;
+	U8  resp[0];
+} sxe_sfp_read_resp_s;
+
+typedef enum sxe_sfp_rate {
+	SXE_SFP_RATE_1G	 = 0,
+	SXE_SFP_RATE_10G	= 1,
+} sxe_sfp_rate_e;
+
+
+typedef struct sxe_sfp_rate_able {
+	sxe_sfp_rate_e rate;
+} sxe_sfp_rate_able_s;
+
+
+typedef struct sxe_spp_tx_able {
+	BOOL is_disable;
+} sxe_spp_tx_able_s;
+
+
+typedef struct sxe_default_mac_addr_resp {
+	U8  addr[SXE_MAC_ADDR_LEN];
+} sxe_default_mac_addr_resp_s;
+
+
+typedef struct sxe_mng_rst {
+	BOOL enable;
+} sxe_mng_rst_s;
+
+#endif
diff --git a/drivers/net/sxe/include/sxe/sxe_regs.h b/drivers/net/sxe/include/sxe/sxe_regs.h
new file mode 100644
index 0000000000..4fa1198d76
--- /dev/null
+++ b/drivers/net/sxe/include/sxe/sxe_regs.h
@@ -0,0 +1,1270 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+
+#ifndef __SXE_REGS_H__
+#define __SXE_REGS_H__
+
+#define SXE_LINKSEC_MAX_SC_COUNT 1
+#define SXE_LINKSEC_MAX_SA_COUNT 2
+
+#define SXE_FLAGS_DOUBLE_RESET_REQUIRED	0x01
+
+
+#define SXE_REG_READ_FAIL	0xffffffffU
+#define SXE_REG_READ_RETRY	5
+#define SXE_PCI_MASTER_DISABLE_TIMEOUT	(800)
+
+#define SXE_CTRL	0x00000
+#define SXE_STATUS	0x00008
+#define SXE_CTRL_EXT	0x00018
+
+
+#define SXE_CTRL_LNK_RST	0x00000008
+#define SXE_CTRL_RST		0x04000000
+
+#define SXE_CTRL_RST_MASK	(SXE_CTRL_LNK_RST | SXE_CTRL_RST)
+#define SXE_CTRL_GIO_DIS	0x00000004
+
+
+#define SXE_STATUS_GIO		0x00080000
+
+
+#define SXE_CTRL_EXT_PFRSTD	0x00004000
+#define SXE_CTRL_EXT_NS_DIS	0x00010000
+#define SXE_CTRL_EXT_DRV_LOAD	0x10000000
+
+
+#define SXE_FCRTL(_i)	(0x03220 + ((_i) * 4))
+#define SXE_FCRTH(_i)	(0x03260 + ((_i) * 4))
+#define SXE_FCCFG	0x03D00
+
+
+#define SXE_FCRTL_XONE		0x80000000
+#define SXE_FCRTH_FCEN		0x80000000
+
+#define SXE_FCCFG_TFCE_802_3X	0x00000008
+#define SXE_FCCFG_TFCE_PRIORITY	0x00000010
+
+
+#define SXE_GCR_EXT		   0x11050
+
+
+#define SXE_GCR_CMPL_TMOUT_MASK		0x0000F000
+#define SXE_GCR_CMPL_TMOUT_10ms		0x00001000
+#define SXE_GCR_CMPL_TMOUT_RESEND	0x00010000
+#define SXE_GCR_CAP_VER2		0x00040000
+#define SXE_GCR_EXT_MSIX_EN		0x80000000
+#define SXE_GCR_EXT_BUFFERS_CLEAR	0x40000000
+#define SXE_GCR_EXT_VT_MODE_16		0x00000001
+#define SXE_GCR_EXT_VT_MODE_32		0x00000002
+#define SXE_GCR_EXT_VT_MODE_64		0x00000003
+#define SXE_GCR_EXT_VT_MODE_MASK	0x00000003
+#define SXE_GCR_EXT_SRIOV		(SXE_GCR_EXT_MSIX_EN | \
+					SXE_GCR_EXT_VT_MODE_64)
+
+#define SXE_PCI_DEVICE_STATUS		0x7A
+#define SXE_PCI_DEVICE_STATUS_TRANSACTION_PENDING   0x0020
+#define SXE_PCI_LINK_STATUS		0x82
+#define SXE_PCI_DEVICE_CONTROL2		0x98
+#define SXE_PCI_LINK_WIDTH		0x3F0
+#define SXE_PCI_LINK_WIDTH_1		0x10
+#define SXE_PCI_LINK_WIDTH_2		0x20
+#define SXE_PCI_LINK_WIDTH_4		0x40
+#define SXE_PCI_LINK_WIDTH_8		0x80
+#define SXE_PCI_LINK_SPEED		0xF
+#define SXE_PCI_LINK_SPEED_2500		0x1
+#define SXE_PCI_LINK_SPEED_5000		0x2
+#define SXE_PCI_LINK_SPEED_8000		0x3
+#define SXE_PCI_HEADER_TYPE_REGISTER	0x0E
+#define SXE_PCI_HEADER_TYPE_MULTIFUNC	0x80
+#define SXE_PCI_DEVICE_CONTROL2_16ms	0x0005
+
+#define SXE_PCIDEVCTRL2_TIMEO_MASK	0xf
+#define SXE_PCIDEVCTRL2_16_32ms_def	0x0
+#define SXE_PCIDEVCTRL2_50_100us	0x1
+#define SXE_PCIDEVCTRL2_1_2ms		0x2
+#define SXE_PCIDEVCTRL2_16_32ms		0x5
+#define SXE_PCIDEVCTRL2_65_130ms	0x6
+#define SXE_PCIDEVCTRL2_260_520ms	0x9
+#define SXE_PCIDEVCTRL2_1_2s		0xa
+#define SXE_PCIDEVCTRL2_4_8s		0xd
+#define SXE_PCIDEVCTRL2_17_34s		0xe
+
+
+#define SXE_EICR	0x00800
+#define SXE_EICS	0x00808
+#define SXE_EIMS	0x00880
+#define SXE_EIMC	0x00888
+#define SXE_EIAC	0x00810
+#define SXE_EIAM	0x00890
+#define SXE_EITRSEL	0x00894
+#define SXE_GPIE	0x00898
+#define SXE_IVAR(i)	(0x00900 + (i) * 4)
+#define SXE_IVAR_MISC	0x00A00
+#define SXE_EICS_EX(i)	(0x00A90 + (i) * 4)
+#define SXE_EIMS_EX(i)	(0x00AA0 + (i) * 4)
+#define SXE_EIMC_EX(i)	(0x00AB0 + (i) * 4)
+#define SXE_EIAM_EX(i)	(0x00AD0 + (i) * 4)
+#define SXE_EITR(i)	(((i) <= 23) ? (0x00820 + ((i) * 4)) : \
+							(0x012300 + (((i) - 24) * 4)))
+
+#define SXE_SPP_PROC	0x00AD8
+#define SXE_SPP_STATE	0x00AF4
+
+
+
+#define SXE_EICR_RTX_QUEUE	0x0000FFFF
+#define SXE_EICR_FLOW_NAV	0x00010000
+#define SXE_EICR_MAILBOX	0x00080000
+#define SXE_EICR_LSC		0x00100000
+#define SXE_EICR_LINKSEC	0x00200000
+#define SXE_EICR_ECC		0x10000000
+#define SXE_EICR_HDC		0x20000000
+#define SXE_EICR_TCP_TIMER	0x40000000
+#define SXE_EICR_OTHER		0x80000000
+
+
+#define SXE_EICS_RTX_QUEUE	SXE_EICR_RTX_QUEUE
+#define SXE_EICS_FLOW_NAV	SXE_EICR_FLOW_NAV
+#define SXE_EICS_MAILBOX	SXE_EICR_MAILBOX
+#define SXE_EICS_LSC		SXE_EICR_LSC
+#define SXE_EICS_ECC		SXE_EICR_ECC
+#define SXE_EICS_HDC		SXE_EICR_HDC
+#define SXE_EICS_TCP_TIMER	SXE_EICR_TCP_TIMER
+#define SXE_EICS_OTHER		SXE_EICR_OTHER
+
+
+#define SXE_EIMS_RTX_QUEUE	SXE_EICR_RTX_QUEUE
+#define SXE_EIMS_FLOW_NAV	SXE_EICR_FLOW_NAV
+#define SXE_EIMS_MAILBOX	SXE_EICR_MAILBOX
+#define SXE_EIMS_LSC		SXE_EICR_LSC
+#define SXE_EIMS_ECC		SXE_EICR_ECC
+#define SXE_EIMS_HDC		SXE_EICR_HDC
+#define SXE_EIMS_TCP_TIMER	SXE_EICR_TCP_TIMER
+#define SXE_EIMS_OTHER		SXE_EICR_OTHER
+#define SXE_EIMS_ENABLE_MASK	(SXE_EIMS_RTX_QUEUE | SXE_EIMS_LSC | \
+					SXE_EIMS_TCP_TIMER | SXE_EIMS_OTHER)
+
+#define SXE_EIMC_FLOW_NAV	SXE_EICR_FLOW_NAV
+#define SXE_EIMC_LSC		SXE_EICR_LSC
+#define SXE_EIMC_HDC		SXE_EICR_HDC
+
+
+#define SXE_GPIE_SPP0_EN	0x00000001
+#define SXE_GPIE_SPP1_EN	0x00000002
+#define SXE_GPIE_SPP2_EN	0x00000004
+#define SXE_GPIE_MSIX_MODE	0x00000010
+#define SXE_GPIE_OCD		0x00000020
+#define SXE_GPIE_EIMEN		0x00000040
+#define SXE_GPIE_EIAME		0x40000000
+#define SXE_GPIE_PBA_SUPPORT	0x80000000
+#define SXE_GPIE_VTMODE_MASK	0x0000C000
+#define SXE_GPIE_VTMODE_16	0x00004000
+#define SXE_GPIE_VTMODE_32	0x00008000
+#define SXE_GPIE_VTMODE_64	0x0000C000
+
+
+#define SXE_IVAR_ALLOC_VALID	0x80
+
+
+#define SXE_EITR_CNT_WDIS	0x80000000
+#define SXE_EITR_ITR_MASK	0x00000FF8
+#define SXE_EITR_ITR_SHIFT	2
+#define SXE_EITR_ITR_MAX	(SXE_EITR_ITR_MASK >> SXE_EITR_ITR_SHIFT)
+
+
+#define SXE_EICR_GPI_SPP0	0x01000000
+#define SXE_EICR_GPI_SPP1	0x02000000
+#define SXE_EICR_GPI_SPP2	0x04000000
+#define SXE_EIMS_GPI_SPP0	SXE_EICR_GPI_SPP0
+#define SXE_EIMS_GPI_SPP1	SXE_EICR_GPI_SPP1
+#define SXE_EIMS_GPI_SPP2	SXE_EICR_GPI_SPP2
+
+
+#define SXE_SPP_PROC_SPP2_TRIGGER	0x00300000
+#define SXE_SPP_PROC_SPP2_TRIGGER_MASK	0xFFCFFFFF
+#define SXE_SPP_PROC_DELAY_US_MASK	0x0000FFFF
+#define SXE_SPP_PROC_DELAY_US		0x00000007
+#define SXE_SPP_PROC_DELAY_MS		0x00003A98
+
+
+#define SXE_SPP2_STATE		0x00000004
+
+
+#define SXE_IRQ_CLEAR_MASK	0xFFFFFFFF
+
+
+#define SXE_RXCSUM		0x05000
+#define SXE_RFCTL		0x05008
+#define SXE_FCTRL		0x05080
+#define SXE_EXVET			   0x05078
+#define SXE_VLNCTRL		0x05088
+#define SXE_MCSTCTRL		0x05090
+#define SXE_ETQF(_i)		(0x05128 + ((_i) * 4))
+#define SXE_ETQS(_i)		(0x0EC00 + ((_i) * 4))
+#define SXE_SYNQF		0x0EC30
+#define SXE_MTA(_i)		(0x05200 + ((_i) * 4))
+#define SXE_UTA(_i)		(0x0F400 + ((_i) * 4))
+#define SXE_VFTA(_i)		(0x0A000 + ((_i) * 4))
+#define SXE_RAL(_i)		(0x0A200 + ((_i) * 8))
+#define SXE_RAH(_i)		(0x0A204 + ((_i) * 8))
+#define SXE_MPSAR_LOW(_i)	(0x0A600 + ((_i) * 8))
+#define SXE_MPSAR_HIGH(_i)	(0x0A604 + ((_i) * 8))
+#define SXE_PSRTYPE(_i)		(0x0EA00 + ((_i) * 4))
+#define SXE_RETA(_i)		(0x0EB00 + ((_i) * 4))
+#define SXE_RSSRK(_i)		(0x0EB80 + ((_i) * 4))
+#define SXE_RQTC		0x0EC70
+#define SXE_MRQC		0x0EC80
+#define SXE_IEOI		0x0F654
+#define SXE_PL			0x0F658
+#define SXE_LPL			0x0F65C
+
+
+#define SXE_ETQF_CNT			8
+#define SXE_MTA_CNT				128
+#define SXE_UTA_CNT				128
+#define SXE_VFTA_CNT			128
+#define SXE_RAR_CNT				128
+#define SXE_MPSAR_CNT			128
+
+
+#define SXE_EXVET_DEFAULT		0x81000000
+#define SXE_VLNCTRL_DEFAULT		0x8100
+#define SXE_IEOI_DEFAULT		0x060005DC
+#define SXE_PL_DEFAULT			0x3e000016
+#define SXE_LPL_DEFAULT			0x26000000
+
+
+#define SXE_RXCSUM_IPPCSE	0x00001000
+#define SXE_RXCSUM_PCSD		0x00002000
+
+
+#define SXE_RFCTL_LRO_DIS	0x00000020
+#define SXE_RFCTL_NFSW_DIS	0x00000040
+#define SXE_RFCTL_NFSR_DIS	0x00000080
+
+
+#define SXE_FCTRL_SBP		0x00000002
+#define SXE_FCTRL_MPE		0x00000100
+#define SXE_FCTRL_UPE		0x00000200
+#define SXE_FCTRL_BAM		0x00000400
+#define SXE_FCTRL_PMCF		0x00001000
+#define SXE_FCTRL_DPF		0x00002000
+
+
+#define SXE_VLNCTRL_VET		0x0000FFFF
+#define SXE_VLNCTRL_CFI		0x10000000
+#define SXE_VLNCTRL_CFIEN	0x20000000
+#define SXE_VLNCTRL_VFE		0x40000000
+#define SXE_VLNCTRL_VME		0x80000000
+
+#define SXE_EXVET_VET_EXT_SHIFT			  16
+#define SXE_EXTENDED_VLAN				 (1 << 26)
+
+
+#define SXE_MCSTCTRL_MFE	4
+
+#define SXE_ETQF_FILTER_EAPOL	0
+#define SXE_ETQF_FILTER_1588	3
+#define SXE_ETQF_FILTER_FIP	4
+#define SXE_ETQF_FILTER_LLDP	5
+#define SXE_ETQF_FILTER_LACP	6
+#define SXE_ETQF_FILTER_FC	7
+#define SXE_MAX_ETQF_FILTERS	8
+#define SXE_ETQF_1588		0x40000000
+#define SXE_ETQF_FILTER_EN	0x80000000
+#define SXE_ETQF_POOL_ENABLE	BIT(26)
+#define SXE_ETQF_POOL_SHIFT	20
+
+
+#define SXE_ETQS_RX_QUEUE	0x007F0000
+#define SXE_ETQS_RX_QUEUE_SHIFT	16
+#define SXE_ETQS_LLI		0x20000000
+#define SXE_ETQS_QUEUE_EN	0x80000000
+
+
+#define SXE_SYN_FILTER_ENABLE		 0x00000001
+#define SXE_SYN_FILTER_QUEUE		  0x000000FE
+#define SXE_SYN_FILTER_QUEUE_SHIFT	1
+#define SXE_SYN_FILTER_SYNQFP		 0x80000000
+
+
+#define SXE_RAH_VIND_MASK	0x003C0000
+#define SXE_RAH_VIND_SHIFT	18
+#define SXE_RAH_AV		0x80000000
+#define SXE_CLEAR_VMDQ_ALL	0xFFFFFFFF
+
+
+#define SXE_PSRTYPE_TCPHDR	0x00000010
+#define SXE_PSRTYPE_UDPHDR	0x00000020
+#define SXE_PSRTYPE_IPV4HDR	0x00000100
+#define SXE_PSRTYPE_IPV6HDR	0x00000200
+#define SXE_PSRTYPE_L2HDR	0x00001000
+
+
+#define SXE_MRQC_RSSEN				 0x00000001
+#define SXE_MRQC_MRQE_MASK					0xF
+#define SXE_MRQC_RT8TCEN			   0x00000002
+#define SXE_MRQC_RT4TCEN			   0x00000003
+#define SXE_MRQC_RTRSS8TCEN			0x00000004
+#define SXE_MRQC_RTRSS4TCEN			0x00000005
+#define SXE_MRQC_VMDQEN				0x00000008
+#define SXE_MRQC_VMDQRSS32EN		   0x0000000A
+#define SXE_MRQC_VMDQRSS64EN		   0x0000000B
+#define SXE_MRQC_VMDQRT8TCEN		   0x0000000C
+#define SXE_MRQC_VMDQRT4TCEN		   0x0000000D
+#define SXE_MRQC_RSS_FIELD_MASK		0xFFFF0000
+#define SXE_MRQC_RSS_FIELD_IPV4_TCP	0x00010000
+#define SXE_MRQC_RSS_FIELD_IPV4		0x00020000
+#define SXE_MRQC_RSS_FIELD_IPV6_EX_TCP 0x00040000
+#define SXE_MRQC_RSS_FIELD_IPV6_EX	 0x00080000
+#define SXE_MRQC_RSS_FIELD_IPV6		0x00100000
+#define SXE_MRQC_RSS_FIELD_IPV6_TCP	0x00200000
+#define SXE_MRQC_RSS_FIELD_IPV4_UDP	0x00400000
+#define SXE_MRQC_RSS_FIELD_IPV6_UDP	0x00800000
+#define SXE_MRQC_RSS_FIELD_IPV6_EX_UDP 0x01000000
+
+
+#define SXE_RDBAL(_i)		(((_i) < 64) ? (0x01000 + ((_i) * 0x40)) : \
+					(0x0D000 + (((_i) - 64) * 0x40)))
+#define SXE_RDBAH(_i)		(((_i) < 64) ? (0x01004 + ((_i) * 0x40)) : \
+					(0x0D004 + (((_i) - 64) * 0x40)))
+#define SXE_RDLEN(_i)		(((_i) < 64) ? (0x01008 + ((_i) * 0x40)) : \
+					(0x0D008 + (((_i) - 64) * 0x40)))
+#define SXE_RDH(_i)		(((_i) < 64) ? (0x01010 + ((_i) * 0x40)) : \
+					(0x0D010 + (((_i) - 64) * 0x40)))
+#define SXE_SRRCTL(_i)		(((_i) < 64) ? (0x01014 + ((_i) * 0x40)) : \
+					(0x0D014 + (((_i) - 64) * 0x40)))
+#define SXE_RDT(_i)		(((_i) < 64) ? (0x01018 + ((_i) * 0x40)) : \
+					(0x0D018 + (((_i) - 64) * 0x40)))
+#define SXE_RXDCTL(_i)		(((_i) < 64) ? (0x01028 + ((_i) * 0x40)) : \
+					(0x0D028 + (((_i) - 64) * 0x40)))
+#define SXE_LROCTL(_i)		(((_i) < 64) ? (0x0102C + ((_i) * 0x40)) : \
+					(0x0D02C + (((_i) - 64) * 0x40)))
+#define SXE_RDRXCTL		0x02F00
+#define SXE_RXCTRL		0x03000
+#define SXE_LRODBU		0x03028
+#define SXE_RXPBSIZE(_i)	(0x03C00 + ((_i) * 4))
+
+#define SXE_DRXCFG		(0x03C20)
+
+
+#define SXE_RXDCTL_CNT			128
+
+
+#define SXE_RXDCTL_DEFAULT		0x40210
+
+
+#define SXE_SRRCTL_DROP_EN		0x10000000
+#define SXE_SRRCTL_BSIZEPKT_SHIFT	(10)
+#define SXE_SRRCTL_BSIZEHDRSIZE_SHIFT	(2)
+#define SXE_SRRCTL_DESCTYPE_DATA_ONEBUF	0x02000000
+#define SXE_SRRCTL_BSIZEPKT_MASK	0x0000007F
+#define SXE_SRRCTL_BSIZEHDR_MASK	0x00003F00
+
+
+#define SXE_RXDCTL_ENABLE	0x02000000
+#define SXE_RXDCTL_SWFLSH	0x04000000
+#define SXE_RXDCTL_VME		0x40000000
+#define SXE_RXDCTL_DESC_FIFO_AE_TH_SHIFT	8
+#define SXE_RXDCTL_PREFETCH_NUM_CFG_SHIFT	16
+
+
+#define SXE_LROCTL_LROEN	0x01
+#define SXE_LROCTL_MAXDESC_1	0x00
+#define SXE_LROCTL_MAXDESC_4	0x04
+#define SXE_LROCTL_MAXDESC_8	0x08
+#define SXE_LROCTL_MAXDESC_16	0x0C
+
+
+#define SXE_RDRXCTL_RDMTS_1_2	0x00000000
+#define SXE_RDRXCTL_RDMTS_EN	0x00200000
+#define SXE_RDRXCTL_CRCSTRIP	0x00000002
+#define SXE_RDRXCTL_PSP		0x00000004
+#define SXE_RDRXCTL_MVMEN	0x00000020
+#define SXE_RDRXCTL_DMAIDONE	0x00000008
+#define SXE_RDRXCTL_AGGDIS	0x00010000
+#define SXE_RDRXCTL_LROFRSTSIZE	0x003E0000
+#define SXE_RDRXCTL_LROLLIDIS	0x00800000
+#define SXE_RDRXCTL_LROACKC	0x02000000
+#define SXE_RDRXCTL_FCOE_WRFIX	0x04000000
+#define SXE_RDRXCTL_MBINTEN	0x10000000
+#define SXE_RDRXCTL_MDP_EN	0x20000000
+#define SXE_RDRXCTL_MPBEN	0x00000010
+
+#define SXE_RDRXCTL_MCEN	0x00000040
+
+
+
+#define SXE_RXCTRL_RXEN		0x00000001
+
+
+#define SXE_LRODBU_LROACKDIS	0x00000080
+
+
+#define SXE_DRXCFG_GSP_ZERO	0x00000002
+#define SXE_DRXCFG_DBURX_START 0x00000001
+
+
+#define SXE_DMATXCTL		0x04A80
+#define SXE_TDBAL(_i)		(0x06000 + ((_i) * 0x40))
+#define SXE_TDBAH(_i)		(0x06004 + ((_i) * 0x40))
+#define SXE_TDLEN(_i)		(0x06008 + ((_i) * 0x40))
+#define SXE_TDH(_i)		(0x06010 + ((_i) * 0x40))
+#define SXE_TDT(_i)		(0x06018 + ((_i) * 0x40))
+#define SXE_TXDCTL(_i)		(0x06028 + ((_i) * 0x40))
+#define SXE_PVFTDWBAL(p)	(0x06038 + (0x40 * (p)))
+#define SXE_PVFTDWBAH(p)	(0x0603C + (0x40 * (p)))
+#define SXE_TXPBSIZE(_i)	(0x0CC00 + ((_i) * 4))
+#define SXE_TXPBTHRESH(_i)	(0x04950 + ((_i) * 4))
+#define SXE_MTQC		0x08120
+#define SXE_TXPBFCS		0x0CE00
+#define SXE_DTXCFG		0x0CE08
+#define SXE_DTMPCNT		0x0CE98
+
+
+#define SXE_DMATXCTL_DEFAULT		0x81000000
+
+
+#define SXE_DMATXCTL_TE		0x1
+#define SXE_DMATXCTL_GDV	0x8
+#define SXE_DMATXCTL_VT_SHIFT	16
+#define SXE_DMATXCTL_VT_MASK	0xFFFF0000
+
+
+#define SXE_TXDCTL_HTHRESH_SHIFT 8
+#define SXE_TXDCTL_WTHRESH_SHIFT 16
+#define SXE_TXDCTL_ENABLE	 0x02000000
+#define SXE_TXDCTL_SWFLSH	 0x04000000
+
+#define SXE_PVFTDWBAL_N(ring_per_pool, vf_idx, vf_ring_idx) \
+		SXE_PVFTDWBAL((ring_per_pool) * (vf_idx) + (vf_ring_idx))
+#define SXE_PVFTDWBAH_N(ring_per_pool, vf_idx, vf_ring_idx) \
+		SXE_PVFTDWBAH((ring_per_pool) * (vf_idx) + (vf_ring_idx))
+
+
+#define SXE_MTQC_RT_ENA		0x1
+#define SXE_MTQC_VT_ENA		0x2
+#define SXE_MTQC_64Q_1PB	0x0
+#define SXE_MTQC_32VF		0x8
+#define SXE_MTQC_64VF		0x4
+#define SXE_MTQC_8TC_8TQ	0xC
+#define SXE_MTQC_4TC_4TQ	0x8
+
+
+#define SXE_TFCS_PB0_MASK	0x1
+#define SXE_TFCS_PB1_MASK	0x2
+#define SXE_TFCS_PB2_MASK	0x4
+#define SXE_TFCS_PB3_MASK	0x8
+#define SXE_TFCS_PB4_MASK	0x10
+#define SXE_TFCS_PB5_MASK	0x20
+#define SXE_TFCS_PB6_MASK	0x40
+#define SXE_TFCS_PB7_MASK	0x80
+#define SXE_TFCS_PB_MASK	0xff
+
+
+#define SXE_DTXCFG_DBUTX_START	0x00000001
+#define SXE_DTXCFG_DBUTX_BUF_ALFUL_CFG	0x20
+
+
+#define SXE_RTRPCS		0x02430
+#define SXE_RTRPT4C(_i)		(0x02140 + ((_i) * 4))
+#define SXE_RTRUP2TC		0x03020
+#define SXE_RTTDCS		0x04900
+#define SXE_RTTDQSEL		0x04904
+#define SXE_RTTDT1C		0x04908
+#define SXE_RTTDT2C(_i)		(0x04910 + ((_i) * 4))
+#define SXE_RTTBCNRM		0x04980
+#define SXE_RTTBCNRC		0x04984
+#define SXE_RTTUP2TC		0x0C800
+#define SXE_RTTPCS		0x0CD00
+#define SXE_RTTPT2C(_i)		(0x0CD20 + ((_i) * 4))
+
+
+#define SXE_RTRPCS_RRM		0x00000002
+#define SXE_RTRPCS_RAC		0x00000004
+#define SXE_RTRPCS_ARBDIS	0x00000040
+
+
+#define SXE_RTRPT4C_MCL_SHIFT	12
+#define SXE_RTRPT4C_BWG_SHIFT	9
+#define SXE_RTRPT4C_GSP		0x40000000
+#define SXE_RTRPT4C_LSP		0x80000000
+
+
+#define SXE_RTRUP2TC_UP_SHIFT 3
+#define SXE_RTRUP2TC_UP_MASK	7
+
+
+#define SXE_RTTDCS_ARBDIS	0x00000040
+#define SXE_RTTDCS_TDPAC	0x00000001
+
+#define SXE_RTTDCS_VMPAC	0x00000002
+
+#define SXE_RTTDCS_TDRM		0x00000010
+#define SXE_RTTDCS_ARBDIS	0x00000040
+#define SXE_RTTDCS_BDPM		0x00400000
+#define SXE_RTTDCS_BPBFSM	0x00800000
+
+#define SXE_RTTDCS_SPEED_CHG	0x80000000
+
+
+#define SXE_RTTDT2C_MCL_SHIFT	12
+#define SXE_RTTDT2C_BWG_SHIFT	9
+#define SXE_RTTDT2C_GSP		0x40000000
+#define SXE_RTTDT2C_LSP		0x80000000
+
+
+#define SXE_RTTBCNRC_RS_ENA		0x80000000
+#define SXE_RTTBCNRC_RF_DEC_MASK	0x00003FFF
+#define SXE_RTTBCNRC_RF_INT_SHIFT	14
+#define SXE_RTTBCNRC_RF_INT_MASK	\
+			(SXE_RTTBCNRC_RF_DEC_MASK << SXE_RTTBCNRC_RF_INT_SHIFT)
+
+
+#define SXE_RTTUP2TC_UP_SHIFT	3
+
+
+#define SXE_RTTPCS_TPPAC	0x00000020
+
+#define SXE_RTTPCS_ARBDIS	0x00000040
+#define SXE_RTTPCS_TPRM		0x00000100
+#define SXE_RTTPCS_ARBD_SHIFT	22
+#define SXE_RTTPCS_ARBD_DCB	0x4
+
+
+#define SXE_RTTPT2C_MCL_SHIFT 12
+#define SXE_RTTPT2C_BWG_SHIFT 9
+#define SXE_RTTPT2C_GSP	   0x40000000
+#define SXE_RTTPT2C_LSP	   0x80000000
+
+
+#define SXE_TPH_CTRL		0x11074
+#define SXE_TPH_TXCTRL(_i)	  (0x0600C + ((_i) * 0x40))
+#define SXE_TPH_RXCTRL(_i)	(((_i) < 64) ? (0x0100C + ((_i) * 0x40)) : \
+				 (0x0D00C + (((_i) - 64) * 0x40)))
+
+
+#define SXE_TPH_CTRL_ENABLE		0x00000000
+#define SXE_TPH_CTRL_DISABLE		0x00000001
+#define SXE_TPH_CTRL_MODE_CB1		0x00
+#define SXE_TPH_CTRL_MODE_CB2		0x02
+
+
+#define SXE_TPH_RXCTRL_DESC_TPH_EN	BIT(5)
+#define SXE_TPH_RXCTRL_HEAD_TPH_EN	BIT(6)
+#define SXE_TPH_RXCTRL_DATA_TPH_EN	BIT(7)
+#define SXE_TPH_RXCTRL_DESC_RRO_EN	BIT(9)
+#define SXE_TPH_RXCTRL_DATA_WRO_EN	BIT(13)
+#define SXE_TPH_RXCTRL_HEAD_WRO_EN	BIT(15)
+#define SXE_TPH_RXCTRL_CPUID_SHIFT	24
+
+#define SXE_TPH_TXCTRL_DESC_TPH_EN	BIT(5)
+#define SXE_TPH_TXCTRL_DESC_RRO_EN	BIT(9)
+#define SXE_TPH_TXCTRL_DESC_WRO_EN	BIT(11)
+#define SXE_TPH_TXCTRL_DATA_RRO_EN	BIT(13)
+#define SXE_TPH_TXCTRL_CPUID_SHIFT	24
+
+
+#define SXE_SECTXCTRL		0x08800
+#define SXE_SECTXSTAT		0x08804
+#define SXE_SECTXBUFFAF		0x08808
+#define SXE_SECTXMINIFG		0x08810
+#define SXE_SECRXCTRL		0x08D00
+#define SXE_SECRXSTAT		0x08D04
+#define SXE_LSECTXCTRL			0x08A04
+#define SXE_LSECTXSCL			 0x08A08
+#define SXE_LSECTXSCH			 0x08A0C
+#define SXE_LSECTXSA			  0x08A10
+#define SXE_LSECTXPN(_n)		  (0x08A14 + (4 * (_n)))
+#define SXE_LSECTXKEY(_n, _m)	 (0x08A1C + ((0x10 * (_n)) + (4 * (_m))))
+#define SXE_LSECRXCTRL			0x08B04
+#define SXE_LSECRXSCL			 0x08B08
+#define SXE_LSECRXSCH			 0x08B0C
+#define SXE_LSECRXSA(_i)		  (0x08B10 + (4 * (_i)))
+#define SXE_LSECRXPN(_i)		  (0x08B18 + (4 * (_i)))
+#define SXE_LSECRXKEY(_n, _m)	 (0x08B20 + ((0x10 * (_n)) + (4 * (_m))))
+
+
+#define SXE_SECTXCTRL_SECTX_DIS		0x00000001
+#define SXE_SECTXCTRL_TX_DIS		0x00000002
+#define SXE_SECTXCTRL_STORE_FORWARD	0x00000004
+
+
+#define SXE_SECTXSTAT_SECTX_RDY		0x00000001
+#define SXE_SECTXSTAT_SECTX_OFF_DIS	0x00000002
+#define SXE_SECTXSTAT_ECC_TXERR		0x00000004
+
+
+#define SXE_SECRXCTRL_SECRX_DIS		0x00000001
+#define SXE_SECRXCTRL_RX_DIS		0x00000002
+#define SXE_SECRXCTRL_RP			  0x00000080
+
+
+#define SXE_SECRXSTAT_SECRX_RDY		0x00000001
+#define SXE_SECRXSTAT_SECRX_OFF_DIS	0x00000002
+#define SXE_SECRXSTAT_ECC_RXERR		0x00000004
+
+#define SXE_SECTX_DCB_ENABLE_MASK	0x00001F00
+
+#define SXE_LSECTXCTRL_EN_MASK		0x00000003
+#define SXE_LSECTXCTRL_EN_SHIFT	   0
+#define SXE_LSECTXCTRL_ES			 0x00000010
+#define SXE_LSECTXCTRL_AISCI		  0x00000020
+#define SXE_LSECTXCTRL_PNTHRSH_MASK   0xFFFFFF00
+#define SXE_LSECTXCTRL_PNTHRSH_SHIFT  8
+#define SXE_LSECTXCTRL_RSV_MASK	   0x000000D8
+
+#define SXE_LSECRXCTRL_EN_MASK		0x0000000C
+#define SXE_LSECRXCTRL_EN_SHIFT	   2
+#define SXE_LSECRXCTRL_DROP_EN		0x00000010
+#define SXE_LSECRXCTRL_DROP_EN_SHIFT  4
+#define SXE_LSECRXCTRL_PLSH		   0x00000040
+#define SXE_LSECRXCTRL_PLSH_SHIFT	 6
+#define SXE_LSECRXCTRL_RP			 0x00000080
+#define SXE_LSECRXCTRL_RP_SHIFT	   7
+#define SXE_LSECRXCTRL_RSV_MASK	   0xFFFFFF33
+
+#define SXE_LSECTXSA_AN0_MASK		 0x00000003
+#define SXE_LSECTXSA_AN0_SHIFT		0
+#define SXE_LSECTXSA_AN1_MASK		 0x0000000C
+#define SXE_LSECTXSA_AN1_SHIFT		2
+#define SXE_LSECTXSA_SELSA			0x00000010
+#define SXE_LSECTXSA_SELSA_SHIFT	  4
+#define SXE_LSECTXSA_ACTSA			0x00000020
+
+#define SXE_LSECRXSA_AN_MASK		  0x00000003
+#define SXE_LSECRXSA_AN_SHIFT		 0
+#define SXE_LSECRXSA_SAV			  0x00000004
+#define SXE_LSECRXSA_SAV_SHIFT		2
+#define SXE_LSECRXSA_RETIRED		  0x00000010
+#define SXE_LSECRXSA_RETIRED_SHIFT	4
+
+#define SXE_LSECRXSCH_PI_MASK		 0xFFFF0000
+#define SXE_LSECRXSCH_PI_SHIFT		16
+
+#define SXE_LSECTXCTRL_DISABLE	0x0
+#define SXE_LSECTXCTRL_AUTH		0x1
+#define SXE_LSECTXCTRL_AUTH_ENCRYPT	0x2
+
+#define SXE_LSECRXCTRL_DISABLE	0x0
+#define SXE_LSECRXCTRL_CHECK		0x1
+#define SXE_LSECRXCTRL_STRICT		0x2
+#define SXE_LSECRXCTRL_DROP		0x3
+#define SXE_SECTXCTRL_STORE_FORWARD_ENABLE	0x4
+
+
+
+#define SXE_IPSTXIDX		0x08900
+#define SXE_IPSTXSALT		0x08904
+#define SXE_IPSTXKEY(_i)	(0x08908 + (4 * (_i)))
+#define SXE_IPSRXIDX		0x08E00
+#define SXE_IPSRXIPADDR(_i)	(0x08E04 + (4 * (_i)))
+#define SXE_IPSRXSPI		0x08E14
+#define SXE_IPSRXIPIDX		0x08E18
+#define SXE_IPSRXKEY(_i)	(0x08E1C + (4 * (_i)))
+#define SXE_IPSRXSALT		0x08E2C
+#define SXE_IPSRXMOD		0x08E30
+
+
+
+#define SXE_FNAVCTRL		0x0EE00
+#define SXE_FNAVHKEY		0x0EE68
+#define SXE_FNAVSKEY		0x0EE6C
+#define SXE_FNAVDIP4M		0x0EE3C
+#define SXE_FNAVSIP4M		0x0EE40
+#define SXE_FNAVTCPM		0x0EE44
+#define SXE_FNAVUDPM		0x0EE48
+#define SXE_FNAVIP6M		0x0EE74
+#define SXE_FNAVM		0x0EE70
+
+#define SXE_FNAVFREE		0x0EE38
+#define SXE_FNAVLEN		0x0EE4C
+#define SXE_FNAVUSTAT		0x0EE50
+#define SXE_FNAVFSTAT		0x0EE54
+#define SXE_FNAVMATCH		0x0EE58
+#define SXE_FNAVMISS		0x0EE5C
+
+#define SXE_FNAVSIPV6(_i)	(0x0EE0C + ((_i) * 4))
+#define SXE_FNAVIPSA		0x0EE18
+#define SXE_FNAVIPDA		0x0EE1C
+#define SXE_FNAVPORT		0x0EE20
+#define SXE_FNAVVLAN		0x0EE24
+#define SXE_FNAVHASH		0x0EE28
+#define SXE_FNAVCMD		0x0EE2C
+
+
+#define SXE_FNAVCTRL_FLEX_SHIFT			16
+#define SXE_FNAVCTRL_MAX_LENGTH_SHIFT		24
+#define SXE_FNAVCTRL_FULL_THRESH_SHIFT		28
+#define SXE_FNAVCTRL_DROP_Q_SHIFT		8
+#define SXE_FNAVCTRL_PBALLOC_64K		0x00000001
+#define SXE_FNAVCTRL_PBALLOC_128K		0x00000002
+#define SXE_FNAVCTRL_PBALLOC_256K		0x00000003
+#define SXE_FNAVCTRL_INIT_DONE			0x00000008
+#define SXE_FNAVCTRL_SPECIFIC_MATCH		0x00000010
+#define SXE_FNAVCTRL_REPORT_STATUS		0x00000020
+#define SXE_FNAVCTRL_REPORT_STATUS_ALWAYS	0x00000080
+
+#define SXE_FNAVCTRL_FLEX_MASK			(0x1F << SXE_FNAVCTRL_FLEX_SHIFT)
+
+#define SXE_FNAVTCPM_DPORTM_SHIFT		16
+
+#define SXE_FNAVM_VLANID			0x00000001
+#define SXE_FNAVM_VLANP				0x00000002
+#define SXE_FNAVM_POOL				0x00000004
+#define SXE_FNAVM_L4P				0x00000008
+#define SXE_FNAVM_FLEX				0x00000010
+#define SXE_FNAVM_DIPV6				0x00000020
+
+#define SXE_FNAVPORT_DESTINATION_SHIFT		16
+#define SXE_FNAVVLAN_FLEX_SHIFT			16
+#define SXE_FNAVHASH_SIG_SW_INDEX_SHIFT		16
+
+#define SXE_FNAVCMD_CMD_MASK			0x00000003
+#define SXE_FNAVCMD_CMD_ADD_FLOW		0x00000001
+#define SXE_FNAVCMD_CMD_REMOVE_FLOW		0x00000002
+#define SXE_FNAVCMD_CMD_QUERY_REM_FILT		0x00000003
+#define SXE_FNAVCMD_FILTER_VALID		0x00000004
+#define SXE_FNAVCMD_FILTER_UPDATE		0x00000008
+#define SXE_FNAVCMD_IPV6DMATCH			0x00000010
+#define SXE_FNAVCMD_L4TYPE_UDP			0x00000020
+#define SXE_FNAVCMD_L4TYPE_TCP			0x00000040
+#define SXE_FNAVCMD_L4TYPE_SCTP			0x00000060
+#define SXE_FNAVCMD_IPV6			0x00000080
+#define SXE_FNAVCMD_CLEARHT			0x00000100
+#define SXE_FNAVCMD_DROP			0x00000200
+#define SXE_FNAVCMD_INT				0x00000400
+#define SXE_FNAVCMD_LAST			0x00000800
+#define SXE_FNAVCMD_COLLISION			0x00001000
+#define SXE_FNAVCMD_QUEUE_EN			0x00008000
+#define SXE_FNAVCMD_FLOW_TYPE_SHIFT		5
+#define SXE_FNAVCMD_RX_QUEUE_SHIFT		16
+#define SXE_FNAVCMD_RX_TUNNEL_FILTER_SHIFT	23
+#define SXE_FNAVCMD_VT_POOL_SHIFT		24
+#define SXE_FNAVCMD_CMD_POLL			10
+#define SXE_FNAVCMD_TUNNEL_FILTER		0x00800000
+
+
+#define SXE_LXOFFRXCNT		0x041A8
+#define SXE_PXOFFRXCNT(_i)	(0x04160 + ((_i) * 4))
+
+#define SXE_EPC_GPRC		0x050E0
+#define SXE_RXDGPC			  0x02F50
+#define SXE_RXDGBCL			 0x02F54
+#define SXE_RXDGBCH			 0x02F58
+#define SXE_RXDDGPC			 0x02F5C
+#define SXE_RXDDGBCL			0x02F60
+#define SXE_RXDDGBCH			0x02F64
+#define SXE_RXLPBKGPC		   0x02F68
+#define SXE_RXLPBKGBCL		  0x02F6C
+#define SXE_RXLPBKGBCH		  0x02F70
+#define SXE_RXDLPBKGPC		  0x02F74
+#define SXE_RXDLPBKGBCL		 0x02F78
+#define SXE_RXDLPBKGBCH		 0x02F7C
+
+#define SXE_RXTPCIN			 0x02F88
+#define SXE_RXTPCOUT			0x02F8C
+#define SXE_RXPRDDC			 0x02F9C
+
+#define SXE_TXDGPC		0x087A0
+#define SXE_TXDGBCL			 0x087A4
+#define SXE_TXDGBCH			 0x087A8
+#define SXE_TXSWERR			 0x087B0
+#define SXE_TXSWITCH			0x087B4
+#define SXE_TXREPEAT			0x087B8
+#define SXE_TXDESCERR		   0x087BC
+#define SXE_MNGPRC		0x040B4
+#define SXE_MNGPDC		0x040B8
+#define SXE_RQSMR(_i)		(0x02300 + ((_i) * 4))
+#define SXE_TQSM(_i)		(0x08600 + ((_i) * 4))
+#define SXE_QPRC(_i)		(0x01030 + ((_i) * 0x40))
+#define SXE_QBRC_L(_i)		(0x01034 + ((_i) * 0x40))
+#define SXE_QBRC_H(_i)		(0x01038 + ((_i) * 0x40))
+
+
+#define SXE_QPRDC(_i)		(0x01430 + ((_i) * 0x40))
+#define SXE_QPTC(_i)		(0x08680 + ((_i) * 0x4))
+#define SXE_QBTC_L(_i)		(0x08700 + ((_i) * 0x8))
+#define SXE_QBTC_H(_i)		(0x08704 + ((_i) * 0x8))
+#define SXE_SSVPC		0x08780
+#define SXE_MNGPTC		0x0CF90
+#define SXE_MPC(_i)		(0x03FA0 + ((_i) * 4))
+
+#define SXE_DBUDRTCICNT(_i)	(0x03C6C + ((_i) * 4))
+#define SXE_DBUDRTCOCNT(_i)	(0x03C8C + ((_i) * 4))
+#define SXE_DBUDRBDPCNT(_i)	(0x03D20 + ((_i) * 4))
+#define SXE_DBUDREECNT(_i)	(0x03D40 + ((_i) * 4))
+#define SXE_DBUDROFPCNT(_i)	(0x03D60 + ((_i) * 4))
+#define SXE_DBUDTTCICNT(_i)	(0x0CE54 + ((_i) * 4))
+#define SXE_DBUDTTCOCNT(_i)	(0x0CE74 + ((_i) * 4))
+
+
+
+#define SXE_WUC					   0x05800
+#define SXE_WUFC					  0x05808
+#define SXE_WUS					   0x05810
+#define SXE_IP6AT(_i)				 (0x05880 + ((_i) * 4))
+
+
+#define SXE_IP6AT_CNT				 4
+
+
+#define SXE_WUC_PME_EN				0x00000002
+#define SXE_WUC_PME_STATUS			0x00000004
+#define SXE_WUC_WKEN				  0x00000010
+#define SXE_WUC_APME				  0x00000020
+
+
+#define SXE_WUFC_LNKC				 0x00000001
+#define SXE_WUFC_MAG				  0x00000002
+#define SXE_WUFC_EX				   0x00000004
+#define SXE_WUFC_MC				   0x00000008
+#define SXE_WUFC_BC				   0x00000010
+#define SXE_WUFC_ARP				  0x00000020
+#define SXE_WUFC_IPV4				 0x00000040
+#define SXE_WUFC_IPV6				 0x00000080
+#define SXE_WUFC_MNG				  0x00000100
+
+
+
+
+#define SXE_TSCTRL			  0x14800
+#define SXE_TSES				0x14804
+#define SXE_TSYNCTXCTL		  0x14810
+#define SXE_TSYNCRXCTL		  0x14820
+#define SXE_RXSTMPL			 0x14824
+#define SXE_RXSTMPH			 0x14828
+#define SXE_SYSTIML			 0x14840
+#define SXE_SYSTIMM			 0x14844
+#define SXE_SYSTIMH			 0x14848
+#define SXE_TIMADJL			 0x14850
+#define SXE_TIMADJH			 0x14854
+#define SXE_TIMINC			  0x14860
+
+
+#define SXE_TSYNCTXCTL_TXTT	 0x0001
+#define SXE_TSYNCTXCTL_TEN	  0x0010
+
+
+#define SXE_TSYNCRXCTL_RXTT	 0x0001
+#define SXE_TSYNCRXCTL_REN	  0x0010
+
+
+#define SXE_TSCTRL_TSSEL		0x00001
+#define SXE_TSCTRL_TSEN		 0x00002
+#define SXE_TSCTRL_VER_2		0x00010
+#define SXE_TSCTRL_ONESTEP	  0x00100
+#define SXE_TSCTRL_CSEN		 0x01000
+#define SXE_TSCTRL_PTYP_ALL	 0x00C00
+#define SXE_TSCTRL_L4_UNICAST   0x08000
+
+
+#define SXE_TSES_TXES				   0x00200
+#define SXE_TSES_RXES				   0x00800
+#define SXE_TSES_TXES_V1_SYNC		   0x00000
+#define SXE_TSES_TXES_V1_DELAY_REQ	  0x00100
+#define SXE_TSES_TXES_V1_ALL			0x00200
+#define SXE_TSES_RXES_V1_SYNC		   0x00000
+#define SXE_TSES_RXES_V1_DELAY_REQ	  0x00400
+#define SXE_TSES_RXES_V1_ALL			0x00800
+#define SXE_TSES_TXES_V2_ALL			0x00200
+#define SXE_TSES_RXES_V2_ALL			0x00800
+
+#define SXE_IV_SNS			  0
+#define SXE_IV_NS			   8
+#define SXE_INCPD			   0
+#define SXE_BASE_INCVAL		 8
+
+
+#define SXE_VT_CTL		0x051B0
+#define SXE_PFMAILBOX(_i)	(0x04B00 + (4 * (_i)))
+
+#define SXE_PFMBICR(_i)		(0x00710 + (4 * (_i)))
+#define SXE_VFLRE(i)		(((i) & 1) ? 0x001C0 : 0x00600)
+#define SXE_VFLREC(i)		(0x00700 + ((i) * 4))
+#define SXE_VFRE(_i)		(0x051E0 + ((_i) * 4))
+#define SXE_VFTE(_i)		(0x08110 + ((_i) * 4))
+#define SXE_QDE			(0x02F04)
+#define SXE_SPOOF(_i)		(0x08200 + (_i) * 4)
+#define SXE_PFDTXGSWC		0x08220
+#define SXE_VMVIR(_i)		(0x08000 + ((_i) * 4))
+#define SXE_VMOLR(_i)		(0x0F000 + ((_i) * 4))
+#define SXE_VLVF(_i)		(0x0F100 + ((_i) * 4))
+#define SXE_VLVFB(_i)		(0x0F200 + ((_i) * 4))
+#define SXE_MRCTL(_i)		(0x0F600 + ((_i) * 4))
+#define SXE_VMRVLAN(_i)			(0x0F610 + ((_i) * 4))
+#define SXE_VMRVM(_i)		(0x0F630 + ((_i) * 4))
+#define SXE_VMECM(_i)		(0x08790 + ((_i) * 4))
+#define SXE_PFMBMEM(_i)		(0x13000 + (64 * (_i)))
+
+
+#define SXE_VMOLR_CNT			64
+#define SXE_VLVF_CNT			64
+#define SXE_VLVFB_CNT			128
+#define SXE_MRCTL_CNT			4
+#define SXE_VMRVLAN_CNT			8
+#define SXE_VMRVM_CNT			8
+#define SXE_SPOOF_CNT			8
+#define SXE_VMVIR_CNT			64
+#define SXE_VFRE_CNT			2
+
+
+#define SXE_VMVIR_VLANA_MASK	0xC0000000
+#define SXE_VMVIR_VLAN_VID_MASK	0x00000FFF
+#define SXE_VMVIR_VLAN_UP_MASK	0x0000E000
+
+
+#define SXE_MRCTL_VPME  0x01
+
+#define SXE_MRCTL_UPME  0x02
+
+#define SXE_MRCTL_DPME  0x04
+
+#define SXE_MRCTL_VLME  0x08
+
+
+#define SXE_VT_CTL_DIS_DEFPL  0x20000000
+#define SXE_VT_CTL_REPLEN	 0x40000000
+#define SXE_VT_CTL_VT_ENABLE  0x00000001
+#define SXE_VT_CTL_POOL_SHIFT 7
+#define SXE_VT_CTL_POOL_MASK  (0x3F << SXE_VT_CTL_POOL_SHIFT)
+
+
+#define SXE_PFMAILBOX_STS		 0x00000001
+#define SXE_PFMAILBOX_ACK		 0x00000002
+#define SXE_PFMAILBOX_VFU		 0x00000004
+#define SXE_PFMAILBOX_PFU		 0x00000008
+#define SXE_PFMAILBOX_RVFU		0x00000010
+
+
+#define SXE_PFMBICR_VFREQ		 0x00000001
+#define SXE_PFMBICR_VFACK		 0x00010000
+#define SXE_PFMBICR_VFREQ_MASK	0x0000FFFF
+#define SXE_PFMBICR_VFACK_MASK	0xFFFF0000
+
+
+#define SXE_QDE_ENABLE		(0x00000001)
+#define SXE_QDE_HIDE_VLAN	(0x00000002)
+#define SXE_QDE_IDX_MASK	(0x00007F00)
+#define SXE_QDE_IDX_SHIFT	(8)
+#define SXE_QDE_WRITE		(0x00010000)
+
+
+
+#define SXE_SPOOF_VLAN_SHIFT  (8)
+
+
+#define SXE_PFDTXGSWC_VT_LBEN	0x1
+
+
+#define SXE_VMVIR_VLANA_DEFAULT 0x40000000
+#define SXE_VMVIR_VLANA_NEVER   0x80000000
+
+
+#define SXE_VMOLR_UPE		0x00400000
+#define SXE_VMOLR_VPE		0x00800000
+#define SXE_VMOLR_AUPE		0x01000000
+#define SXE_VMOLR_ROMPE		0x02000000
+#define SXE_VMOLR_ROPE		0x04000000
+#define SXE_VMOLR_BAM		0x08000000
+#define SXE_VMOLR_MPE		0x10000000
+
+
+#define SXE_VLVF_VIEN		 0x80000000
+#define SXE_VLVF_ENTRIES	  64
+#define SXE_VLVF_VLANID_MASK  0x00000FFF
+
+
+#define SXE_HDC_HOST_BASE	   0x16000
+#define SXE_HDC_SW_LK		   (SXE_HDC_HOST_BASE + 0x00)
+#define SXE_HDC_PF_LK		   (SXE_HDC_HOST_BASE + 0x04)
+#define SXE_HDC_SW_OV		   (SXE_HDC_HOST_BASE + 0x08)
+#define SXE_HDC_FW_OV		   (SXE_HDC_HOST_BASE + 0x0C)
+#define SXE_HDC_PACKET_HEAD0	(SXE_HDC_HOST_BASE + 0x10)
+
+#define SXE_HDC_PACKET_DATA0	(SXE_HDC_HOST_BASE + 0x20)
+
+
+#define SXE_HDC_MSI_STATUS_REG  0x17000
+#define SXE_FW_STATUS_REG	   0x17004
+#define SXE_DRV_STATUS_REG	  0x17008
+#define SXE_FW_HDC_STATE_REG	0x1700C
+#define SXE_R0_MAC_ADDR_RAL	 0x17010
+#define SXE_R0_MAC_ADDR_RAH	 0x17014
+#define SXE_CRC_STRIP_REG		0x17018
+
+
+#define SXE_HDC_SW_LK_BIT	   0x0001
+#define SXE_HDC_PF_LK_BIT	   0x0003
+#define SXE_HDC_SW_OV_BIT	   0x0001
+#define SXE_HDC_FW_OV_BIT	   0x0001
+#define SXE_HDC_RELEASE_SW_LK   0x0000
+
+#define SXE_HDC_LEN_TO_REG(n)		((n) - 1)
+#define SXE_HDC_LEN_FROM_REG(n)	  ((n) + 1)
+
+
+#define SXE_RX_PKT_BUF_SIZE_SHIFT	10
+#define SXE_TX_PKT_BUF_SIZE_SHIFT	10
+
+#define SXE_RXIDX_TBL_SHIFT		   1
+#define SXE_RXTXIDX_IPS_EN			0x00000001
+#define SXE_RXTXIDX_IDX_SHIFT		 3
+#define SXE_RXTXIDX_READ			  0x40000000
+#define SXE_RXTXIDX_WRITE			 0x80000000
+
+
+#define SXE_KEEP_CRC_EN			  0x00000001
+
+
+#define SXE_VMD_CTL			0x0581C
+
+
+#define SXE_VMD_CTL_POOL_EN		0x00000001
+#define SXE_VMD_CTL_POOL_FILTER		0x00000002
+
+
+#define SXE_FLCTRL					0x14300
+#define SXE_PFCTOP					0x14304
+#define SXE_FCTTV0					0x14310
+#define SXE_FCTTV(_i)				(SXE_FCTTV0 + ((_i) * 4))
+#define SXE_FCRTV					 0x14320
+#define SXE_TFCS					  0x14324
+
+
+#define SXE_FCTRL_TFCE_MASK		   0x0018
+#define SXE_FCTRL_TFCE_LFC_EN		 0x0008
+#define SXE_FCTRL_TFCE_PFC_EN		 0x0010
+#define SXE_FCTRL_TFCE_DPF_EN		 0x0020
+#define SXE_FCTRL_RFCE_MASK		   0x0300
+#define SXE_FCTRL_RFCE_LFC_EN		 0x0100
+#define SXE_FCTRL_RFCE_PFC_EN		 0x0200
+
+#define SXE_FCTRL_TFCE_FCEN_MASK	  0x00FF0000
+#define SXE_FCTRL_TFCE_XONE_MASK	  0xFF000000
+
+
+#define SXE_PFCTOP_FCT			   0x8808
+#define SXE_PFCTOP_FCOP_MASK		 0xFFFF0000
+#define SXE_PFCTOP_FCOP_PFC		  0x01010000
+#define SXE_PFCTOP_FCOP_LFC		  0x00010000
+
+
+#define SXE_COMCTRL				   0x14400
+#define SXE_PCCTRL					0x14404
+#define SXE_LPBKCTRL				  0x1440C
+#define SXE_MAXFS					 0x14410
+#define SXE_SACONH					0x14420
+#define SXE_SACONL					0x14424
+#define SXE_VLANCTRL				  0x14430
+#define SXE_VLANID					0x14434
+#define SXE_LINKS					 0x14454
+#define SXE_FPGA_SDS_STS		  0x14704
+#define SXE_MSCA					  0x14500
+#define SXE_MSCD					  0x14504
+
+#define SXE_HLREG0					0x04240
+#define SXE_MFLCN					 0x04294
+#define SXE_MACC					  0x04330
+
+#define SXE_PCS1GLSTA				 0x0420C
+#define SXE_MFLCN					 0x04294
+#define SXE_PCS1GANA				  0x04850
+#define SXE_PCS1GANLP				 0x04854
+
+
+#define SXE_LPBKCTRL_EN			   0x00000001
+
+
+#define SXE_MAC_ADDR_SACONH_SHIFT	 32
+#define SXE_MAC_ADDR_SACONL_MASK	  0xFFFFFFFF
+
+
+#define SXE_PCS1GLSTA_AN_COMPLETE	 0x10000
+#define SXE_PCS1GLSTA_AN_PAGE_RX	  0x20000
+#define SXE_PCS1GLSTA_AN_TIMED_OUT	0x40000
+#define SXE_PCS1GLSTA_AN_REMOTE_FAULT 0x80000
+#define SXE_PCS1GLSTA_AN_ERROR_RWS	0x100000
+
+#define SXE_PCS1GANA_SYM_PAUSE		0x100
+#define SXE_PCS1GANA_ASM_PAUSE		0x80
+
+
+#define SXE_LKSTS_PCS_LKSTS_UP		0x00000001
+#define SXE_LINK_UP_TIME			  90
+#define SXE_AUTO_NEG_TIME			 45
+
+
+#define SXE_MSCA_NP_ADDR_MASK	  0x0000FFFF
+#define SXE_MSCA_NP_ADDR_SHIFT	 0
+#define SXE_MSCA_DEV_TYPE_MASK	 0x001F0000
+#define SXE_MSCA_DEV_TYPE_SHIFT	16
+#define SXE_MSCA_PHY_ADDR_MASK	 0x03E00000
+#define SXE_MSCA_PHY_ADDR_SHIFT	21
+#define SXE_MSCA_OP_CODE_MASK	  0x0C000000
+#define SXE_MSCA_OP_CODE_SHIFT	 26
+#define SXE_MSCA_ADDR_CYCLE		0x00000000
+#define SXE_MSCA_WRITE			 0x04000000
+#define SXE_MSCA_READ			  0x0C000000
+#define SXE_MSCA_READ_AUTOINC	  0x08000000
+#define SXE_MSCA_ST_CODE_MASK	  0x30000000
+#define SXE_MSCA_ST_CODE_SHIFT	 28
+#define SXE_MSCA_NEW_PROTOCOL	  0x00000000
+#define SXE_MSCA_OLD_PROTOCOL	  0x10000000
+#define SXE_MSCA_BYPASSRA_C45	  0x40000000
+#define SXE_MSCA_MDI_CMD_ON_PROG   0x80000000
+
+
+#define MDIO_MSCD_RDATA_LEN		16
+#define MDIO_MSCD_RDATA_SHIFT	  16
+
+
+#define SXE_CRCERRS				   0x14A04
+#define SXE_ERRBC					 0x14A10
+#define SXE_RLEC					  0x14A14
+#define SXE_PRC64					 0x14A18
+#define SXE_PRC127					0x14A1C
+#define SXE_PRC255					0x14A20
+#define SXE_PRC511					0x14A24
+#define SXE_PRC1023				   0x14A28
+#define SXE_PRC1522				   0x14A2C
+#define SXE_BPRC					  0x14A30
+#define SXE_MPRC					  0x14A34
+#define SXE_GPRC					  0x14A38
+#define SXE_GORCL					 0x14A3C
+#define SXE_GORCH					 0x14A40
+#define SXE_RUC					   0x14A44
+#define SXE_RFC					   0x14A48
+#define SXE_ROC					   0x14A4C
+#define SXE_RJC					   0x14A50
+#define SXE_TORL					  0x14A54
+#define SXE_TORH					  0x14A58
+#define SXE_TPR					   0x14A5C
+#define SXE_PRCPF(_i)				 (0x14A60 + ((_i) * 4))
+#define SXE_GPTC					  0x14B00
+#define SXE_GOTCL					 0x14B04
+#define SXE_GOTCH					 0x14B08
+#define SXE_TPT					   0x14B0C
+#define SXE_PTC64					 0x14B10
+#define SXE_PTC127					0x14B14
+#define SXE_PTC255					0x14B18
+#define SXE_PTC511					0x14B1C
+#define SXE_PTC1023				   0x14B20
+#define SXE_PTC1522				   0x14B24
+#define SXE_MPTC					  0x14B28
+#define SXE_BPTC					  0x14B2C
+#define SXE_PFCT(_i)				  (0x14B30 + ((_i) * 4))
+
+#define SXE_MACCFG					0x0CE04
+#define SXE_MACCFG_PAD_EN			 0x00000001
+
+
+#define SXE_COMCTRL_TXEN		  0x0001
+#define SXE_COMCTRL_RXEN		  0x0002
+#define SXE_COMCTRL_EDSEL		  0x0004
+#define SXE_COMCTRL_SPEED_1G		  0x0200
+#define SXE_COMCTRL_SPEED_10G		  0x0300
+
+
+#define SXE_PCCTRL_TXCE			  0x0001
+#define SXE_PCCTRL_RXCE			  0x0002
+#define SXE_PCCTRL_PEN			  0x0100
+#define SXE_PCCTRL_PCSC_ALL		  0x30000
+
+
+#define SXE_MAXFS_TFSEL			  0x0001
+#define SXE_MAXFS_RFSEL			  0x0002
+#define SXE_MAXFS_MFS_MASK		  0xFFFF0000
+#define SXE_MAXFS_MFS			  0x40000000
+#define SXE_MAXFS_MFS_SHIFT		  16
+
+
+#define SXE_LINKS_UP			0x00000001
+
+#define SXE_10G_LINKS_DOWN		0x00000006
+
+
+#define SXE_LINK_SPEED_UNKNOWN		0
+#define SXE_LINK_SPEED_10_FULL		0x0002
+#define SXE_LINK_SPEED_100_FULL	   0x0008
+#define SXE_LINK_SPEED_1GB_FULL	   0x0020
+#define SXE_LINK_SPEED_10GB_FULL	  0x0080
+
+
+#define SXE_HLREG0_TXCRCEN			0x00000001
+#define SXE_HLREG0_RXCRCSTRP		  0x00000002
+#define SXE_HLREG0_JUMBOEN			0x00000004
+#define SXE_HLREG0_TXPADEN			0x00000400
+#define SXE_HLREG0_TXPAUSEEN		  0x00001000
+#define SXE_HLREG0_RXPAUSEEN		  0x00004000
+#define SXE_HLREG0_LPBK			   0x00008000
+#define SXE_HLREG0_MDCSPD			 0x00010000
+#define SXE_HLREG0_CONTMDC			0x00020000
+#define SXE_HLREG0_CTRLFLTR		   0x00040000
+#define SXE_HLREG0_PREPEND			0x00F00000
+#define SXE_HLREG0_PRIPAUSEEN		 0x01000000
+#define SXE_HLREG0_RXPAUSERECDA	   0x06000000
+#define SXE_HLREG0_RXLNGTHERREN	   0x08000000
+#define SXE_HLREG0_RXPADSTRIPEN	   0x10000000
+
+#define SXE_MFLCN_PMCF				0x00000001
+#define SXE_MFLCN_DPF				 0x00000002
+#define SXE_MFLCN_RPFCE			   0x00000004
+#define SXE_MFLCN_RFCE				0x00000008
+#define SXE_MFLCN_RPFCE_MASK		  0x00000FF4
+#define SXE_MFLCN_RPFCE_SHIFT		 4
+
+#define SXE_MACC_FLU				  0x00000001
+#define SXE_MACC_FSV_10G			  0x00030000
+#define SXE_MACC_FS				   0x00040000
+
+#define SXE_DEFAULT_FCPAUSE		   0xFFFF
+
+
+#define SXE_SAQF(_i)		(0x0E000 + ((_i) * 4))
+#define SXE_DAQF(_i)		(0x0E200 + ((_i) * 4))
+#define SXE_SDPQF(_i)		(0x0E400 + ((_i) * 4))
+#define SXE_FTQF(_i)		(0x0E600 + ((_i) * 4))
+#define SXE_L34T_IMIR(_i)	(0x0E800 + ((_i) * 4))
+
+#define SXE_MAX_FTQF_FILTERS		128
+#define SXE_FTQF_PROTOCOL_MASK		0x00000003
+#define SXE_FTQF_PROTOCOL_TCP		0x00000000
+#define SXE_FTQF_PROTOCOL_UDP		0x00000001
+#define SXE_FTQF_PROTOCOL_SCTP		2
+#define SXE_FTQF_PRIORITY_MASK		0x00000007
+#define SXE_FTQF_PRIORITY_SHIFT		2
+#define SXE_FTQF_POOL_MASK		0x0000003F
+#define SXE_FTQF_POOL_SHIFT		8
+#define SXE_FTQF_5TUPLE_MASK_MASK	0x0000001F
+#define SXE_FTQF_5TUPLE_MASK_SHIFT	25
+#define SXE_FTQF_SOURCE_ADDR_MASK	0x1E
+#define SXE_FTQF_DEST_ADDR_MASK		0x1D
+#define SXE_FTQF_SOURCE_PORT_MASK	0x1B
+#define SXE_FTQF_DEST_PORT_MASK		0x17
+#define SXE_FTQF_PROTOCOL_COMP_MASK	0x0F
+#define SXE_FTQF_POOL_MASK_EN		0x40000000
+#define SXE_FTQF_QUEUE_ENABLE		0x80000000
+
+#define SXE_SDPQF_DSTPORT		0xFFFF0000
+#define SXE_SDPQF_DSTPORT_SHIFT		16
+#define SXE_SDPQF_SRCPORT		0x0000FFFF
+
+#define SXE_L34T_IMIR_SIZE_BP		0x00001000
+#define SXE_L34T_IMIR_RESERVE		0x00080000
+#define SXE_L34T_IMIR_LLI			0x00100000
+#define SXE_L34T_IMIR_QUEUE			0x0FE00000
+#define SXE_L34T_IMIR_QUEUE_SHIFT	21
+
+#define SXE_VMTXSW(_i)				(0x05180 + ((_i) * 4))
+#define SXE_VMTXSW_REGISTER_COUNT	 2
+
+#define SXE_TXSTMP_SEL		0x14510
+#define SXE_TXSTMP_VAL		0x1451c
+
+#define SXE_TXTS_MAGIC0		0x005a005900580057
+#define SXE_TXTS_MAGIC1		0x005e005d005c005b
+
+#endif
diff --git a/drivers/net/sxe/include/sxe_version.h b/drivers/net/sxe/include/sxe_version.h
new file mode 100644
index 0000000000..fb58e73399
--- /dev/null
+++ b/drivers/net/sxe/include/sxe_version.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+#ifndef __SXE_VER_H__
+#define __SXE_VER_H__
+
+#define SXE_VERSION				"0.0.0.0"
+#define SXE_COMMIT_ID			  "852946d"
+#define SXE_BRANCH				 "feature/sagitta-1.3.0-P3-dpdk_patch"
+#define SXE_BUILD_TIME			 "2025-04-03 17:15:31"
+
+#define SXE_DRV_NAME				   "sxe"
+#define SXEVF_DRV_NAME				 "sxevf"
+#define SXE_DRV_LICENSE				"GPL v2"
+#define SXE_DRV_AUTHOR				 "sxe"
+#define SXEVF_DRV_AUTHOR			   "sxevf"
+#define SXE_DRV_DESCRIPTION			"sxe driver"
+#define SXEVF_DRV_DESCRIPTION		  "sxevf driver"
+
+#define SXE_FW_NAME					 "soc"
+#define SXE_FW_ARCH					 "arm32"
+
+#ifndef PS3_CFG_RELEASE
+#define PS3_SXE_FW_BUILD_MODE			 "debug"
+#else
+#define PS3_SXE_FW_BUILD_MODE			 "release"
+#endif
+
+#endif
diff --git a/drivers/net/sxe/meson.build b/drivers/net/sxe/meson.build
index dad9ee44a0..598fce480d 100644
--- a/drivers/net/sxe/meson.build
+++ b/drivers/net/sxe/meson.build
@@ -1,9 +1,27 @@
 # SPDX-License-Identifier: BSD-3-Clause
-# Copyright (C), 2020, Wuxi Stars Micro System Technologies Co., Ltd.
+# Copyright (C), 2022, Linkdata Technology Co., Ltd.
+if not is_linux or not (dpdk_conf.has('RTE_ARCH_X86_64') or dpdk_conf.has('RTE_ARCH_ARM64'))
+    build = false
+    reason = 'only supported on x86_64 or arm64 Linux'
+    subdir_done()
++endif
+cflags += ['-DSXE_DPDK']
+cflags += ['-DSXE_HOST_DRIVER']
+
+#subdir('base')
+#objs = [base_objs]
 
 deps += ['hash']
 sources = files(
+        'pf/sxe_main.c',
+        'pf/sxe_irq.c',
         'pf/sxe_ethdev.c',
+        'pf/sxe_pmd_hdc.c',
+        'base/sxe_common.c',
+        'base/sxe_hw.c',
 )
 
+includes += include_directories('base')
 includes += include_directories('pf')
+includes += include_directories('include/sxe/')
+includes += include_directories('include/')
diff --git a/drivers/net/sxe/pf/sxe.h b/drivers/net/sxe/pf/sxe.h
new file mode 100644
index 0000000000..009d2db173
--- /dev/null
+++ b/drivers/net/sxe/pf/sxe.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+#ifndef __SXE_H__
+#define __SXE_H__
+
+#include <rte_pci.h>
+#include <rte_time.h>
+
+#include <stdbool.h>
+#include "sxe_types.h"
+#include "sxe_irq.h"
+#include "sxe_phy.h"
+#include "sxe_hw.h"
+
+struct sxe_hw;
+
+#define SXE_LPBK_DISABLED   0x0
+#define SXE_LPBK_ENABLED	0x1
+
+#define PCI_VENDOR_ID_STARS	  0x1FF2
+#define SXE_DEV_ID_ASIC		  0x10a1
+
+#define MAC_FMT "%02x:%02x:%02x:%02x:%02x:%02x"
+
+#ifdef RTE_PMD_PACKET_PREFETCH
+#define rte_packet_prefetch(p)  rte_prefetch1(p)
+#else
+#define rte_packet_prefetch(p) \
+	do { \
+	} while (0)
+#endif
+
+#define RTE_PMD_USE_PREFETCH
+
+#ifdef RTE_PMD_USE_PREFETCH
+#define rte_sxe_prefetch(p)   rte_prefetch0(p)
+#else
+#define rte_sxe_prefetch(p)   do {} while (0)
+#endif
+
+struct sxe_adapter {
+	struct sxe_hw hw;
+
+	struct sxe_irq_context irq_ctxt;
+
+	s8 name[PCI_PRI_STR_SIZE + 1];
+};
+
+s32 sxe_hw_reset(struct sxe_hw *hw);
+
+void sxe_hw_start(struct sxe_hw *hw);
+
+bool sxe_is_supported(struct rte_eth_dev *dev);
+
+#endif
diff --git a/drivers/net/sxe/pf/sxe_ethdev.c b/drivers/net/sxe/pf/sxe_ethdev.c
index e31a23deeb..eef032eca0 100644
--- a/drivers/net/sxe/pf/sxe_ethdev.c
+++ b/drivers/net/sxe/pf/sxe_ethdev.c
@@ -1,3 +1,322 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2015-2024
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
  */
+
+#include <bus_pci_driver.h>
+#include <ethdev_driver.h>
+#include <dev_driver.h>
+#include <ethdev_pci.h>
+#include <rte_ethdev.h>
+#include <rte_alarm.h>
+#include "sxe_types.h"
+#include "sxe_logs.h"
+#include "sxe_compat_platform.h"
+#include "sxe_errno.h"
+#include "sxe.h"
+#include "sxe_hw.h"
+#include "sxe_ethdev.h"
+#include "sxe_irq.h"
+#include "sxe_pmd_hdc.h"
+#include "drv_msg.h"
+#include "sxe_version.h"
+#include "sxe_compat_version.h"
+#include <rte_string_fns.h>
+
+#define SXE_DEFAULT_MTU			 1500
+#define SXE_ETH_HLEN				14
+#define SXE_ETH_FCS_LEN			 4
+#define SXE_ETH_FRAME_LEN		   1514
+
+#define SXE_ETH_MAX_LEN  (RTE_ETHER_MTU + SXE_ETH_OVERHEAD)
+
+static s32 sxe_dev_reset(struct rte_eth_dev *eth_dev);
+
+static s32 sxe_dev_configure(struct rte_eth_dev *dev)
+{
+	s32 ret;
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_irq_context *irq = &adapter->irq_ctxt;
+
+	PMD_INIT_FUNC_TRACE();
+
+l_end:
+	return ret;
+}
+
+static s32 sxe_dev_start(struct rte_eth_dev *dev)
+{
+	s32 ret;
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_intr_handle *handle = SXE_PCI_INTR_HANDLE(pci_dev);
+	struct sxe_irq_context *irq = &adapter->irq_ctxt;
+
+	ret = sxe_fw_time_sync(hw);
+
+	rte_intr_disable(handle);
+
+	ret = sxe_hw_reset(hw);
+	if (ret < 0) {
+		PMD_LOG_ERR(INIT, "hw init failed, ret=%d", ret);
+		goto l_end;
+	}
+
+	sxe_hw_start(hw);
+
+	ret = sxe_irq_configure(dev);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "irq config fail.");
+		goto l_error;
+	}
+
+l_end:
+	return ret;
+
+l_error:
+	PMD_LOG_ERR(INIT, "dev start err, ret=%d", ret);
+	sxe_irq_vec_free(handle);
+	ret = -EIO;
+	goto l_end;
+}
+
+static s32 sxe_dev_stop(struct rte_eth_dev *dev)
+{
+	s32 ret = 0;
+	s32 num;
+	struct rte_eth_link link;
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+
+	PMD_INIT_FUNC_TRACE();
+
+	sxe_hw_all_irq_disable(hw);
+
+	ret = sxe_hw_reset(hw);
+	if (ret < 0) {
+		PMD_LOG_ERR(INIT, "hw init failed, ret=%d", ret);
+		goto l_end;
+	}
+
+l_end:
+	return ret;
+}
+
+static s32 sxe_dev_close(struct rte_eth_dev *dev)
+{
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+	s32 ret = 0;
+
+	PMD_INIT_FUNC_TRACE();
+
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY) {
+		PMD_LOG_INFO(INIT, "not primary, do nothing");
+		goto l_end;
+	}
+
+	sxe_hw_hdc_drv_status_set(hw, (u32)false);
+
+	ret = sxe_hw_reset(hw);
+	if (ret < 0) {
+		PMD_LOG_ERR(INIT, "hw init failed, ret=%d", ret);
+		goto l_end;
+	}
+
+	ret = sxe_dev_stop(dev);
+	if (ret)
+		PMD_LOG_ERR(INIT, "dev stop fail.(err:%d)", ret);
+
+	sxe_irq_uninit(dev);
+
+l_end:
+	return ret;
+}
+
+static s32 sxe_dev_infos_get(struct rte_eth_dev *dev,
+					struct rte_eth_dev_info *dev_info)
+{
+	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_eth_conf *dev_conf = &dev->data->dev_conf;
+
+	return 0;
+}
+
+static int sxe_get_regs(struct rte_eth_dev *dev,
+		  struct rte_dev_reg_info *regs)
+{
+	s32 ret = 0;
+	u32 *data = regs->data;
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+	u32 length = sxe_hw_all_regs_group_num_get();
+
+	if (data == NULL) {
+		regs->length = length;
+		regs->width = sizeof(uint32_t);
+		goto l_end;
+	}
+
+	if (regs->length == 0 || regs->length == length) {
+		sxe_hw_all_regs_group_read(hw, data);
+
+		goto l_end;
+	}
+
+	ret = -ENOTSUP;
+	LOG_ERROR("get regs: inval param: regs_len=%u, regs->data=%p, "
+			"regs_offset=%u,  regs_width=%u, regs_version=%u",
+			regs->length, regs->data,
+			regs->offset, regs->width,
+			regs->version);
+
+l_end:
+	return ret;
+}
+
+static int sxe_fw_version_get(struct rte_eth_dev *dev, char *fw_version,
+						size_t fw_size)
+{
+	int ret;
+	sxe_version_resp_s resp;
+	struct sxe_adapter *adapter = (struct sxe_adapter *)(dev->data->dev_private);
+	struct sxe_hw *hw = &adapter->hw;
+
+	ret = sxe_driver_cmd_trans(hw, SXE_CMD_FW_VER_GET,
+				NULL, 0,
+				(void *)&resp, sizeof(resp));
+	if (ret) {
+		LOG_ERROR_BDF("get version failed, ret=%d", ret);
+		ret = -EIO;
+		goto l_end;
+	}
+
+	ret = snprintf(fw_version, fw_size, "%s", resp.fw_version);
+	if (ret < 0) {
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	ret += 1;
+
+	if (fw_size >= (size_t)ret)
+		ret = 0;
+
+l_end:
+	return ret;
+}
+
+static const struct eth_dev_ops sxe_eth_dev_ops = {
+	.dev_configure		= sxe_dev_configure,
+	.dev_start		= sxe_dev_start,
+	.dev_stop		= sxe_dev_stop,
+	.dev_close		= sxe_dev_close,
+	.dev_reset		= sxe_dev_reset,
+
+	.get_reg		= sxe_get_regs,
+};
+
+static s32 sxe_hw_base_init(struct rte_eth_dev *eth_dev)
+{
+	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct sxe_adapter *adapter = eth_dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+	s32 ret;
+
+	hw->reg_base_addr = (void *)pci_dev->mem_resource[0].addr;
+	PMD_LOG_INFO(INIT, "eth_dev[%u] got reg_base_addr=%p",
+			eth_dev->data->port_id, hw->reg_base_addr);
+	hw->adapter = adapter;
+
+	strlcpy(adapter->name, pci_dev->device.name, sizeof(adapter->name) - 1);
+
+	sxe_hw_hdc_drv_status_set(hw, (u32)true);
+
+	ret = sxe_hw_reset(hw);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "hw init failed, ret=%d", ret);
+		goto l_out;
+	} else {
+		sxe_hw_start(hw);
+	}
+
+l_out:
+	if (ret)
+		sxe_hw_hdc_drv_status_set(hw, (u32)false);
+
+	return ret;
+}
+
+void sxe_secondary_proc_init(struct rte_eth_dev *eth_dev,
+	bool rx_batch_alloc_allowed, bool *rx_vec_allowed)
+{
+	__sxe_secondary_proc_init(eth_dev, rx_batch_alloc_allowed, rx_vec_allowed);
+}
+
+s32 sxe_ethdev_init(struct rte_eth_dev *eth_dev, void *param __rte_unused)
+{
+	s32 ret = 0;
+	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct sxe_adapter *adapter = eth_dev->data->dev_private;
+#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_FILTER_CTRL
+	struct sxe_filter_context *filter_info = &adapter->filter_ctxt;
+#endif
+
+	eth_dev->dev_ops = &sxe_eth_dev_ops;
+
+	rte_eth_copy_pci_info(eth_dev, pci_dev);
+
+	ret = sxe_hw_base_init(eth_dev);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "hw base init fail.(err:%d)", ret);
+		goto l_out;
+	}
+
+	sxe_irq_init(eth_dev);
+
+	PMD_LOG_INFO(INIT, "sxe eth dev init done.");
+
+l_out:
+	return ret;
+}
+
+s32 sxe_ethdev_uninit(struct rte_eth_dev *eth_dev)
+{
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY) {
+		PMD_LOG_INFO(INIT, "not primary process ,do nothing");
+		goto l_end;
+	}
+
+	sxe_dev_close(eth_dev);
+
+l_end:
+	return 0;
+}
+
+static s32 sxe_dev_reset(struct rte_eth_dev *eth_dev)
+{
+	s32 ret;
+
+	if (eth_dev->data->sriov.active) {
+		ret = -ENOTSUP;
+		PMD_LOG_ERR(INIT, "sriov activated, not support reset pf port[%u]",
+			eth_dev->data->port_id);
+		goto l_end;
+	}
+
+	ret = sxe_ethdev_uninit(eth_dev);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "port[%u] dev uninit failed",
+			eth_dev->data->port_id);
+		goto l_end;
+	}
+
+	ret = sxe_ethdev_init(eth_dev, NULL);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "port[%u] dev init failed",
+			eth_dev->data->port_id);
+	}
+
+l_end:
+	return ret;
+}
diff --git a/drivers/net/sxe/pf/sxe_ethdev.h b/drivers/net/sxe/pf/sxe_ethdev.h
index e31a23deeb..66034343ea 100644
--- a/drivers/net/sxe/pf/sxe_ethdev.h
+++ b/drivers/net/sxe/pf/sxe_ethdev.h
@@ -1,3 +1,28 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2015-2024
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
  */
+
+#ifndef __SXE_ETHDEV_H__
+#define __SXE_ETHDEV_H__
+
+#include "sxe.h"
+
+#define SXE_MMW_SIZE_DEFAULT		0x4
+#define SXE_MMW_SIZE_JUMBO_FRAME	0x14
+#define SXE_MAX_JUMBO_FRAME_SIZE	0x2600
+
+#define SXE_ETH_MAX_LEN  (RTE_ETHER_MTU + SXE_ETH_OVERHEAD)
+
+#define SXE_HKEY_MAX_INDEX 10
+#define SXE_ETH_OVERHEAD (RTE_ETHER_HDR_LEN + RTE_ETHER_CRC_LEN)
+#define SXE_ETH_DEAD_LOAD (SXE_ETH_OVERHEAD + 2 * SXE_VLAN_TAG_SIZE)
+
+struct sxe_adapter;
+s32 sxe_ethdev_init(struct rte_eth_dev *eth_dev, void *param __rte_unused);
+
+s32 sxe_ethdev_uninit(struct rte_eth_dev *eth_dev);
+
+void sxe_secondary_proc_init(struct rte_eth_dev *eth_dev,
+	bool rx_batch_alloc_allowed, bool *rx_vec_allowed);
+
+#endif
diff --git a/drivers/net/sxe/pf/sxe_irq.c b/drivers/net/sxe/pf/sxe_irq.c
new file mode 100644
index 0000000000..b00e9888e2
--- /dev/null
+++ b/drivers/net/sxe/pf/sxe_irq.c
@@ -0,0 +1,125 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+#include <rte_ethdev.h>
+#include <rte_pci.h>
+#include <rte_alarm.h>
+
+#include <rte_pci.h>
+#include <bus_pci_driver.h>
+#include <eal_interrupts.h>
+
+#include <rte_malloc.h>
+
+#include "sxe_irq.h"
+#include "sxe_logs.h"
+#include "sxe_regs.h"
+#include "sxe_hw.h"
+#include "sxe.h"
+#include "sxe_phy.h"
+#include "sxe_errno.h"
+#include "sxe_compat_version.h"
+
+#define SXE_LINK_DOWN_TIMEOUT 4000
+#define SXE_LINK_UP_TIMEOUT   1000
+
+#define SXE_IRQ_MAILBOX		  ((u32)(1 << 1))
+#define SXE_IRQ_MACSEC		   ((u32)(1 << 2))
+
+#define SXE_LINK_UP_TIME		 90
+
+#define SXE_MISC_VEC_ID		  RTE_INTR_VEC_ZERO_OFFSET
+
+#define SXE_RX_VEC_BASE		  RTE_INTR_VEC_RXTX_OFFSET
+
+static s32 sxe_event_irq_action(struct rte_eth_dev *eth_dev)
+{
+	struct sxe_adapter *adapter = eth_dev->data->dev_private;
+	struct sxe_irq_context *irq = &adapter->irq_ctxt;
+
+	PMD_LOG_DEBUG(DRV, "event irq action type %d", irq->action);
+
+	/* lsc irq handler */
+	if (irq->action & SXE_IRQ_LINK_UPDATE)
+		PMD_LOG_INFO(DRV, "link change irq");
+
+	return 0;
+}
+
+static void sxe_event_irq_handler(void *data)
+{
+	struct rte_eth_dev *eth_dev = (struct rte_eth_dev *)data;
+	struct sxe_adapter *adapter = eth_dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+	struct sxe_irq_context *irq = &adapter->irq_ctxt;
+	u32 eicr;
+
+	rte_spinlock_lock(&adapter->irq_ctxt.event_irq_lock);
+
+	sxe_hw_all_irq_disable(hw);
+
+	eicr = sxe_hw_irq_cause_get(hw);
+	PMD_LOG_DEBUG(DRV, "event irq triggered eicr:0x%x", eicr);
+
+	eicr &= 0xFFFF0000;
+
+	sxe_hw_pending_irq_write_clear(hw, eicr);
+
+	rte_spinlock_unlock(&adapter->irq_ctxt.event_irq_lock);
+
+	if (eicr & SXE_EICR_LSC)
+		irq->action |= SXE_IRQ_LINK_UPDATE;
+
+	if (eicr & SXE_EICR_MAILBOX)
+		irq->action |= SXE_IRQ_MAILBOX;
+
+	if (eicr & SXE_EICR_LINKSEC)
+		irq->action |= SXE_IRQ_MACSEC;
+
+	sxe_event_irq_action(eth_dev);
+
+	rte_spinlock_lock(&adapter->irq_ctxt.event_irq_lock);
+	sxe_hw_specific_irq_enable(hw, irq->enable_mask);
+	rte_spinlock_unlock(&adapter->irq_ctxt.event_irq_lock);
+}
+
+void sxe_irq_init(struct rte_eth_dev *eth_dev)
+{
+	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct rte_intr_handle *irq_handle = SXE_PCI_INTR_HANDLE(pci_dev);
+	struct sxe_adapter *adapter = eth_dev->data->dev_private;
+
+	rte_intr_callback_register(irq_handle,
+				   sxe_event_irq_handler, eth_dev);
+
+	rte_spinlock_init(&adapter->irq_ctxt.event_irq_lock);
+}
+
+void sxe_irq_vec_free(struct rte_intr_handle *handle)
+{
+	if (handle->intr_vec != NULL) {
+		rte_free(handle->intr_vec);
+		handle->intr_vec = NULL;
+	}
+}
+void sxe_irq_uninit(struct rte_eth_dev *eth_dev)
+{
+	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct rte_intr_handle *handle = SXE_PCI_INTR_HANDLE(pci_dev);
+	u8 retry = 0;
+	s32 ret;
+
+	rte_intr_disable(handle);
+
+	do {
+		ret = rte_intr_callback_unregister(handle,
+				sxe_event_irq_handler, eth_dev);
+		if (ret >= 0 || ret == -ENOENT) {
+			break;
+		} else if (ret != -EAGAIN) {
+			PMD_LOG_ERR(DRV,
+					"irq handler unregister fail, next to retry");
+		}
+		rte_delay_ms(100);
+	} while (retry++ < (10 + SXE_LINK_UP_TIME));
+}
diff --git a/drivers/net/sxe/pf/sxe_irq.h b/drivers/net/sxe/pf/sxe_irq.h
new file mode 100644
index 0000000000..e3a7da6ae8
--- /dev/null
+++ b/drivers/net/sxe/pf/sxe_irq.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+
+#ifndef __SXE_IRQ_H__
+#define __SXE_IRQ_H__
+
+#include <ethdev_driver.h>
+#include "sxe_compat_platform.h"
+#include "sxe_compat_version.h"
+
+#define SXE_QUEUE_IRQ_NUM_MAX	15
+
+#define SXE_QUEUE_ITR_INTERVAL_DEFAULT   500
+#define SXE_QUEUE_ITR_INTERVAL   3
+
+#define SXE_EITR_INTERVAL_UNIT_NS	2048
+#define SXE_EITR_ITR_INT_SHIFT		  3
+#define SXE_IRQ_ITR_MASK				(0x00000FF8)
+#define SXE_EITR_INTERVAL_US(us) \
+	(((us) * 1000 / SXE_EITR_INTERVAL_UNIT_NS << SXE_EITR_ITR_INT_SHIFT) & \
+		SXE_IRQ_ITR_MASK)
+
+struct sxe_irq_context {
+	u32 action;
+	u32 enable_mask;
+	u32 enable_mask_original;
+	rte_spinlock_t event_irq_lock;
+	bool to_pcs_init;
+};
+
+void sxe_event_irq_delayed_handler(void *param);
+
+void sxe_irq_init(struct rte_eth_dev *eth_dev);
+
+void sxe_irq_uninit(struct rte_eth_dev *eth_dev);
+
+
+#endif
diff --git a/drivers/net/sxe/pf/sxe_main.c b/drivers/net/sxe/pf/sxe_main.c
new file mode 100644
index 0000000000..652c432268
--- /dev/null
+++ b/drivers/net/sxe/pf/sxe_main.c
@@ -0,0 +1,181 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+#include <string.h>
+#include <sys/time.h>
+
+#include <rte_log.h>
+#include <rte_pci.h>
+
+#include "sxe_version.h"
+#include <bus_pci_driver.h>
+#include <ethdev_driver.h>
+#include <ethdev_pci.h>
+#include <dev_driver.h>
+
+#include "sxe_logs.h"
+#include "sxe_types.h"
+#include "sxe_hw.h"
+#include "sxe_ethdev.h"
+#include "sxe.h"
+#include "drv_msg.h"
+#include "sxe_errno.h"
+#include "sxe_compat_platform.h"
+#include "sxe_pmd_hdc.h"
+
+static const struct rte_pci_id sxe_pci_tbl[] = {
+	{ RTE_PCI_DEVICE(PCI_VENDOR_ID_STARS, SXE_DEV_ID_ASIC) },
+	{.vendor_id = 0,}
+};
+
+static s32 sxe_probe(struct rte_pci_driver *pci_drv __rte_unused,
+					struct rte_pci_device *pci_dev)
+{
+	s32 ret;
+
+	PMD_LOG_INFO(INIT, "sxe_version[%s], sxe_commit_id[%s], sxe_branch[%s], sxe_build_time[%s]",
+		SXE_VERSION, SXE_COMMIT_ID, SXE_BRANCH, SXE_BUILD_TIME);
+
+
+	/* HDC */
+	sxe_hdc_channel_init();
+
+	ret = rte_eth_dev_create(&pci_dev->device, pci_dev->device.name,
+				sizeof(struct sxe_adapter),
+				eth_dev_pci_specific_init,
+				pci_dev,
+				sxe_ethdev_init, NULL);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "sxe pmd eth dev create fail.(err:%d)", ret);
+		goto l_out;
+	}
+
+	PMD_LOG_DEBUG(INIT, "%s sxe pmd probe done.", pci_dev->device.name);
+
+l_out:
+	return ret;
+}
+
+static s32 sxe_remove(struct rte_pci_device *pci_dev)
+{
+	struct rte_eth_dev *eth_dev;
+	s32 ret;
+
+	eth_dev = rte_eth_dev_allocated(pci_dev->device.name);
+	if (!eth_dev) {
+		ret = 0;
+		PMD_LOG_ERR(INIT, "sxe pmd dev has removed.");
+		goto l_out;
+	}
+
+	ret = rte_eth_dev_pci_generic_remove(pci_dev,
+					sxe_ethdev_uninit);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "sxe eth dev remove fail.(err:%d)", ret);
+		goto l_out;
+	}
+
+	sxe_hdc_channel_uninit();
+
+	PMD_LOG_DEBUG(INIT, "sxe pmd remove done.");
+
+l_out:
+	return ret;
+}
+
+static struct rte_pci_driver rte_sxe_pmd = {
+	.id_table  = sxe_pci_tbl,
+	.drv_flags = RTE_PCI_DRV_NEED_MAPPING | RTE_PCI_DRV_INTR_LSC,
+	.probe	 = sxe_probe,
+	.remove	= sxe_remove,
+};
+
+static s32 sxe_mng_reset(struct sxe_hw *hw, bool enable)
+{
+	s32 ret;
+	sxe_mng_rst_s mng_rst;
+
+	mng_rst.enable = enable;
+	PMD_LOG_INFO(INIT, "mng reset, enable=%x", enable);
+
+	/* Send reset command */
+	ret = sxe_driver_cmd_trans(hw, SXE_CMD_MNG_RST,
+				(void *)&mng_rst, sizeof(mng_rst),
+				NULL, 0);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "mng reset failed, ret=%d", ret);
+		goto l_end;
+	}
+
+	PMD_LOG_INFO(INIT, "mng reset success, enable=%x", enable);
+
+l_end:
+	return ret;
+}
+
+s32 sxe_hw_reset(struct sxe_hw *hw)
+{
+	s32 ret;
+
+	sxe_hw_all_irq_disable(hw);
+
+	sxe_hw_pending_irq_read_clear(hw);
+
+	ret = sxe_mng_reset(hw, false);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "mng reset disable failed, ret=%d", ret);
+		goto l_end;
+	}
+
+	ret = sxe_hw_nic_reset(hw);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "nic reset failed, ret=%d", ret);
+		goto l_end;
+	}
+
+	msleep(50);
+
+	ret = sxe_mng_reset(hw, true);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "mng reset enable failed, ret=%d", ret);
+		goto l_end;
+	}
+
+l_end:
+	return ret;
+}
+
+void sxe_hw_start(struct sxe_hw *hw)
+{
+	hw->mac.auto_restart = true;
+	PMD_LOG_INFO(INIT, "auto_restart:%u.", hw->mac.auto_restart);
+}
+
+static bool is_device_supported(struct rte_eth_dev *dev,
+					struct rte_pci_driver *drv)
+{
+	bool ret = true;
+
+	if (strcmp(dev->device->driver->name, drv->driver.name))
+		ret = false;
+
+	return ret;
+}
+
+bool sxe_is_supported(struct rte_eth_dev *dev)
+{
+	return is_device_supported(dev, &rte_sxe_pmd);
+}
+
+RTE_PMD_REGISTER_PCI(net_sxe, rte_sxe_pmd);
+RTE_PMD_REGISTER_PCI_TABLE(net_sxe, sxe_pci_tbl);
+RTE_PMD_REGISTER_KMOD_DEP(net_sxe, "* igb_uio | uio_pci_generic | vfio-pci");
+
+RTE_LOG_REGISTER_SUFFIX(sxe_log_init, pmd.net.sxe.init, NOTICE);
+RTE_LOG_REGISTER_SUFFIX(sxe_log_drv, pmd.net.sxe.drv, NOTICE);
+
+int sxe_eth_dev_callback_process(struct rte_eth_dev *dev,
+	enum rte_eth_event_type event, void *ret_param)
+{
+	return rte_eth_dev_callback_process(dev, event, ret_param);
+}
diff --git a/drivers/net/sxe/pf/sxe_phy.h b/drivers/net/sxe/pf/sxe_phy.h
new file mode 100644
index 0000000000..2947d88812
--- /dev/null
+++ b/drivers/net/sxe/pf/sxe_phy.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+#ifndef __SXE_PHY_H__
+#define __SXE_PHY_H__
+
+#include <rte_ethdev.h>
+#include "drv_msg.h"
+#include "sxe_msg.h"
+
+#define SXE_SFF_BASE_ADDR			0x0
+#define SXE_SFF_IDENTIFIER			0x0
+#define SXE_SFF_10GBE_COMP_CODES		0x3
+#define SXE_SFF_1GBE_COMP_CODES			0x6
+#define SXE_SFF_CABLE_TECHNOLOGY		0x8
+#define SXE_SFF_8472_DIAG_MONITOR_TYPE		0x5C
+#define SXE_SFF_8472_COMPLIANCE			0x5E
+
+#define SXE_SFF_IDENTIFIER_SFP			0x3
+#define SXE_SFF_ADDRESSING_MODE			0x4
+#define SXE_SFF_8472_UNSUP			0x0
+#define SXE_SFF_DDM_IMPLEMENTED			0x40
+#define SXE_SFF_DA_PASSIVE_CABLE		0x4
+#define SXE_SFF_DA_ACTIVE_CABLE			0x8
+#define SXE_SFF_DA_SPEC_ACTIVE_LIMITING		0x4
+#define SXE_SFF_1GBASESX_CAPABLE		0x1
+#define SXE_SFF_1GBASELX_CAPABLE		0x2
+#define SXE_SFF_1GBASET_CAPABLE			0x8
+#define SXE_SFF_10GBASESR_CAPABLE		0x10
+#define SXE_SFF_10GBASELR_CAPABLE		0x20
+
+#define SXE_SFP_COMP_CODE_SIZE			10
+#define SXE_SFP_EEPROM_SIZE_MAX			512
+
+#define SXE_IRQ_LINK_UPDATE	  ((u32)(1 << 0))
+#define SXE_IRQ_LINK_CONFIG	  ((u32)(1 << 3))
+
+#endif
diff --git a/drivers/net/sxe/pf/sxe_pmd_hdc.c b/drivers/net/sxe/pf/sxe_pmd_hdc.c
new file mode 100644
index 0000000000..61dcb6a6c1
--- /dev/null
+++ b/drivers/net/sxe/pf/sxe_pmd_hdc.c
@@ -0,0 +1,682 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+
+#include <rte_malloc.h>
+#include <ethdev_driver.h>
+#include "sxe_compat_version.h"
+#include <semaphore.h>
+#include <pthread.h>
+#include <signal.h>
+#include "sxe_pmd_hdc.h"
+#include "sxe_logs.h"
+#include "sxe_hw.h"
+#include "sxe.h"
+#include "sxe_msg.h"
+#include "drv_msg.h"
+#include "sxe_errno.h"
+#include "sxe_common.h"
+
+static sem_t g_hdc_sem;
+
+#define SXE_SUCCESS			(0)
+
+#define SXE_HDC_TRYLOCK_MAX		200
+
+#define SXE_HDC_RELEASELOCK_MAX		20
+#define SXE_HDC_WAIT_TIME		1000
+#define SXE_HDC_BIT_1			0x1
+#define ONE_DWORD_LEN			(4)
+
+static sem_t *sxe_hdc_sema_get(void)
+{
+	return &g_hdc_sem;
+}
+
+void sxe_hdc_channel_init(void)
+{
+	s32 ret;
+	ret = sem_init(sxe_hdc_sema_get(), 0, 1);
+	if (ret)
+		PMD_LOG_ERR(INIT, "hdc sem init failed, ret=%d", ret);
+
+	sxe_trace_id_gen();
+}
+
+void sxe_hdc_channel_uninit(void)
+{
+	sem_destroy(sxe_hdc_sema_get());
+	sxe_trace_id_clean();
+}
+
+static s32 sxe_fw_time_sync_process(struct sxe_hw *hw)
+{
+	s32 ret;
+	u64 timestamp = sxe_time_get_real_ms();
+	struct sxe_adapter *adapter = hw->adapter;
+
+	LOG_DEBUG_BDF("sync time= %" SXE_PRIU64 "ms", timestamp);
+	ret = sxe_driver_cmd_trans(hw, SXE_CMD_TINE_SYNC,
+				(void *)&timestamp, sizeof(timestamp),
+				NULL, 0);
+	if (ret)
+		LOG_ERROR_BDF("hdc trans failed ret=%d, cmd:time sync", ret);
+
+	return ret;
+}
+
+s32 sxe_fw_time_sync(struct sxe_hw *hw)
+{
+	s32 ret = 0;
+	s32 ret_v;
+	u32 status;
+	struct sxe_adapter *adapter = hw->adapter;
+
+	status = sxe_hw_hdc_fw_status_get(hw);
+	if (status != SXE_FW_START_STATE_FINISHED) {
+		LOG_ERROR_BDF("fw[%p] status[0x%x] is not good", hw, status);
+		ret = -SXE_FW_STATUS_ERR;
+		goto l_ret;
+	}
+
+	ret_v = sxe_fw_time_sync_process(hw);
+	if (ret_v) {
+		LOG_WARN_BDF("fw time sync failed, ret_v=%d", ret_v);
+		goto l_ret;
+	}
+
+l_ret:
+	return ret;
+}
+
+static inline s32 sxe_hdc_lock_get(struct sxe_hw *hw)
+{
+	return sxe_hw_hdc_lock_get(hw, SXE_HDC_TRYLOCK_MAX);
+}
+
+static inline void sxe_hdc_lock_release(struct sxe_hw *hw)
+{
+	sxe_hw_hdc_lock_release(hw, SXE_HDC_RELEASELOCK_MAX);
+}
+
+static inline s32 sxe_poll_fw_ack(struct sxe_hw *hw, u32 timeout)
+{
+	s32 ret = 0;
+	u32 i;
+	bool fw_ov = false;
+	struct sxe_adapter *adapter = hw->adapter;
+
+	for (i = 0; i < timeout; i++) {
+		fw_ov = sxe_hw_hdc_is_fw_over_set(hw);
+		if (fw_ov)
+			break;
+
+		mdelay(10);
+	}
+
+	if (i >= timeout) {
+		LOG_ERROR_BDF("poll fw_ov timeout...");
+		ret = -SXE_ERR_HDC_FW_OV_TIMEOUT;
+		goto l_ret;
+	}
+
+	sxe_hw_hdc_fw_ov_clear(hw);
+l_ret:
+	return ret;
+}
+
+static inline void hdc_channel_clear(struct sxe_hw *hw)
+{
+	sxe_hw_hdc_fw_ov_clear(hw);
+}
+
+static s32 hdc_packet_ack_get(struct sxe_hw *hw, u64 trace_id,
+				hdc_header_u *pkt_header)
+{
+	s32 ret	 = 0;
+	u32 timeout = SXE_HDC_WAIT_TIME;
+	struct sxe_adapter *adapter = hw->adapter;
+	UNUSED(trace_id);
+
+	pkt_header->dw0 = 0;
+	pkt_header->head.err_code = PKG_ERR_OTHER;
+
+	LOG_DEBUG_BDF("trace_id=0x%" SXE_PRIX64 " hdc cmd ack get start", trace_id);
+	ret = sxe_poll_fw_ack(hw, timeout);
+	if (ret) {
+		LOG_ERROR_BDF("get fw ack failed, ret=%d", ret);
+		goto l_out;
+	}
+
+	pkt_header->dw0 = sxe_hw_hdc_fw_ack_header_get(hw);
+	if (pkt_header->head.err_code == PKG_ERR_PKG_SKIP) {
+		ret = -SXE_HDC_PKG_SKIP_ERR;
+		goto l_out;
+	} else if (pkt_header->head.err_code != PKG_OK) {
+		ret = -SXE_HDC_PKG_OTHER_ERR;
+		goto l_out;
+	}
+
+l_out:
+	LOG_DEBUG_BDF("trace_id=0x%" SXE_PRIX64 " hdc cmd ack get end ret=%d", trace_id, ret);
+	return ret;
+}
+
+static void hdc_packet_header_fill(hdc_header_u *pkt_header,
+			u8 pkt_index, u16 total_len,
+			u16 pkt_num, u8 is_read)
+{
+	u16 pkt_len = 0;
+
+	pkt_header->dw0 = 0;
+
+	pkt_header->head.pid = (is_read == 0) ? pkt_index : (pkt_index - 1);
+
+	pkt_header->head.total_len = SXE_HDC_LEN_TO_REG(total_len);
+
+	if (pkt_index == 0 && is_read == 0)
+		pkt_header->head.start_pkg = SXE_HDC_BIT_1;
+
+	if (pkt_index == (pkt_num - 1)) {
+		pkt_header->head.end_pkg = SXE_HDC_BIT_1;
+		pkt_len = total_len - (DWORD_NUM * (pkt_num - 1));
+	} else {
+		pkt_len = DWORD_NUM;
+	}
+
+	pkt_header->head.len  = SXE_HDC_LEN_TO_REG(pkt_len);
+	pkt_header->head.is_rd = is_read;
+	pkt_header->head.msi = 0;
+}
+
+static inline void hdc_packet_send_done(struct sxe_hw *hw)
+{
+	sxe_hw_hdc_packet_send_done(hw);
+}
+
+static inline void hdc_packet_header_send(struct sxe_hw *hw,
+							u32 header)
+{
+	sxe_hw_hdc_packet_header_send(hw, header);
+}
+
+static inline void hdc_packet_data_dword_send(struct sxe_hw *hw,
+						u16 dword_index, u32 value)
+{
+	sxe_hw_hdc_packet_data_dword_send(hw, dword_index, value);
+}
+
+static void hdc_packet_send(struct sxe_hw *hw, u64 trace_id,
+			hdc_header_u *pkt_header, u8 *data,
+			u16 data_len)
+{
+	u16		  dw_idx   = 0;
+	u16		  pkt_len	   = 0;
+	u16		  offset		= 0;
+	u32		  pkg_data	  = 0;
+	struct sxe_adapter *adapter = hw->adapter;
+	UNUSED(trace_id);
+
+	LOG_DEBUG_BDF("hw_addr[%p] trace_id=0x%" SXE_PRIX64 " send pkt pkg_header[0x%x], "
+		"data_addr[%p], data_len[%u]",
+		hw, trace_id, pkt_header->dw0, data, data_len);
+
+	hdc_packet_header_send(hw, pkt_header->dw0);
+
+	if (data == NULL || data_len == 0)
+		goto l_send_done;
+
+	pkt_len = SXE_HDC_LEN_FROM_REG(pkt_header->head.len);
+	for (dw_idx = 0; dw_idx < pkt_len; dw_idx++) {
+		pkg_data = 0;
+
+		offset = dw_idx * 4;
+
+		if (pkt_header->head.end_pkg == SXE_HDC_BIT_1 &&
+			(dw_idx == (pkt_len - 1)) &&
+			(data_len % 4 != 0)) {
+			memcpy((u8 *)&pkg_data, data + offset,
+					data_len % ONE_DWORD_LEN);
+		} else {
+			pkg_data = *(u32 *)(data + offset);
+		}
+
+		LOG_DEBUG_BDF("trace_id=0x%" SXE_PRIX64 " send data to reg[%u] dword[0x%x]",
+				trace_id, dw_idx, pkg_data);
+		hdc_packet_data_dword_send(hw, dw_idx, pkg_data);
+	}
+
+l_send_done:
+	hdc_channel_clear(hw);
+
+	hdc_packet_send_done(hw);
+}
+
+static inline u32 hdc_packet_data_dword_rcv(struct sxe_hw *hw,
+						u16 dword_index)
+{
+	return sxe_hw_hdc_packet_data_dword_rcv(hw, dword_index);
+}
+
+static void hdc_resp_data_rcv(struct sxe_hw *hw, u64 trace_id,
+				hdc_header_u *pkt_header, u8 *out_data,
+				u16 out_len)
+{
+	u16		  dw_idx	  = 0;
+	u16		  dw_num	  = 0;
+	u16		  offset = 0;
+	u32		  pkt_data;
+	struct sxe_adapter *adapter = hw->adapter;
+	UNUSED(trace_id);
+
+	dw_num = SXE_HDC_LEN_FROM_REG(pkt_header->head.len);
+	for (dw_idx = 0; dw_idx < dw_num; dw_idx++) {
+		pkt_data = hdc_packet_data_dword_rcv(hw, dw_idx);
+		offset = dw_idx * ONE_DWORD_LEN;
+		LOG_DEBUG_BDF("trace_id=0x%" SXE_PRIX64 " get data from reg[%u] dword=0x%x",
+				trace_id, dw_idx, pkt_data);
+
+		if (pkt_header->head.end_pkg == SXE_HDC_BIT_1 &&
+			(dw_idx == (dw_num - 1)) && (out_len % 4 != 0)) {
+			memcpy(out_data + offset, (u8 *)&pkt_data,
+					out_len % ONE_DWORD_LEN);
+		} else {
+			*(u32 *)(out_data + offset) = pkt_data;
+		}
+	}
+}
+
+static s32 hdc_req_process(struct sxe_hw *hw, u64 trace_id,
+			u8 *in_data, u16 in_len)
+{
+	s32 ret = 0;
+	u32 total_len	= 0;
+	u16 pkt_num	 = 0;
+	u16 index	   = 0;
+	u16 offset	  = 0;
+	hdc_header_u	 pkt_header;
+	bool is_retry   = false;
+	struct sxe_adapter *adapter = hw->adapter;
+
+	total_len  = (in_len + ONE_DWORD_LEN - 1) / ONE_DWORD_LEN;
+
+	pkt_num = (in_len + ONE_PACKET_LEN_MAX - 1) / ONE_PACKET_LEN_MAX;
+	LOG_DEBUG_BDF("hw[%p] trace_id=0x%" SXE_PRIX64 " req in_data[%p] in_len=%u, "
+			"total_len=%uDWORD, pkt_num = %u",
+			hw, trace_id, in_data, in_len, total_len,
+			pkt_num);
+
+	for (index = 0; index < pkt_num; index++) {
+		LOG_DEBUG_BDF("trace_id=0x%" SXE_PRIX64 " fill pkg header[%p], pkg_index[%u], "
+			"total_Len[%u], pkg_num[%u], is_read[no]",
+			trace_id, &pkt_header, index, total_len, pkt_num);
+		hdc_packet_header_fill(&pkt_header, index, total_len,
+						pkt_num, 0);
+
+		offset = index * DWORD_NUM * 4;
+		hdc_packet_send(hw, trace_id, &pkt_header,
+				in_data + offset, in_len);
+
+		if (index == pkt_num - 1)
+			break;
+
+		ret = hdc_packet_ack_get(hw, trace_id, &pkt_header);
+		if (ret == -EINTR) {
+			LOG_ERROR_BDF("hdc cmd trace_id=0x%" SXE_PRIX64 " interrupted", trace_id);
+			goto l_out;
+		} else if (ret == -SXE_HDC_PKG_SKIP_ERR) {
+			LOG_ERROR_BDF("hdc cmd trace_id=0x%" SXE_PRIX64 " req ack "
+					"failed, retry", trace_id);
+			if (is_retry) {
+				ret = -SXE_HDC_RETRY_ERR;
+				goto l_out;
+			}
+
+			index--;
+			is_retry = true;
+			continue;
+		} else if (ret != SXE_HDC_SUCCESS) {
+			LOG_ERROR_BDF("hdc cmd trace_id=0x%" SXE_PRIX64 " req ack "
+					"failed, ret=%d", trace_id, ret);
+			ret = -SXE_HDC_RETRY_ERR;
+			goto l_out;
+		}
+
+		LOG_DEBUG_BDF("hdc cmd trace_id=0x%" SXE_PRIX64 " get req packet_index[%u]"
+			" ack succeed header[0x%x]",
+			trace_id, index, pkt_header.dw0);
+		is_retry = false;
+	}
+
+l_out:
+	return ret;
+}
+
+static s32 hdc_resp_process(struct sxe_hw *hw, u64 trace_id,
+			u8 *out_data, u16 out_len)
+{
+	s32		  ret;
+	u32		  req_dwords;
+	u32		  resp_len;
+	u32		  resp_dwords;
+	u16		  pkt_num;
+	u16		  index;
+	u16		  offset;
+	hdc_header_u  pkt_header;
+	bool	 retry		  = false;
+	struct sxe_adapter *adapter = hw->adapter;
+
+	LOG_DEBUG_BDF("hdc trace_id=0x%" SXE_PRIX64 " req's last cmd ack get", trace_id);
+	ret = hdc_packet_ack_get(hw, trace_id, &pkt_header);
+	if (ret == -EINTR) {
+		LOG_ERROR_BDF("hdc cmd trace_id=0x%" SXE_PRIX64 " interrupted", trace_id);
+		goto l_out;
+	} else if (ret) {
+		LOG_ERROR_BDF("hdc trace_id=0x%" SXE_PRIX64 " ack get failed, ret=%d",
+				trace_id, ret);
+		ret = -SXE_HDC_RETRY_ERR;
+		goto l_out;
+	}
+
+	LOG_DEBUG_BDF("hdc trace_id=0x%" SXE_PRIX64 " req's last cmd ack get "
+		"succeed header[0x%x]", trace_id, pkt_header.dw0);
+
+	if (!pkt_header.head.start_pkg) {
+		ret = -SXE_HDC_RETRY_ERR;
+		LOG_ERROR_BDF("trace_id=0x%" SXE_PRIX64 " ack header has error："
+				"not set start bit", trace_id);
+		goto l_out;
+	}
+
+	req_dwords = (out_len + ONE_DWORD_LEN - 1) / ONE_DWORD_LEN;
+	resp_dwords  = SXE_HDC_LEN_FROM_REG(pkt_header.head.total_len);
+	if (resp_dwords > req_dwords) {
+		ret = -SXE_HDC_RETRY_ERR;
+		LOG_ERROR_BDF("trace_id=0x%" SXE_PRIX64 " rsv len check failed:"
+				"resp_dwords=%u, req_dwords=%u", trace_id,
+				resp_dwords, req_dwords);
+		goto l_out;
+	}
+
+	resp_len = resp_dwords << 2;
+	LOG_DEBUG_BDF("outlen = %u bytes, resp_len = %u bytes", out_len, resp_len);
+	if (resp_len > out_len)
+		resp_len = out_len;
+
+	hdc_resp_data_rcv(hw, trace_id, &pkt_header, out_data, resp_len);
+
+	pkt_num = (resp_len + ONE_PACKET_LEN_MAX - 1) / ONE_PACKET_LEN_MAX;
+	for (index = 1; index < pkt_num; index++) {
+		LOG_DEBUG_BDF("trace_id=0x%" SXE_PRIX64 " fill pkg header[%p], pkg_index[%u], "
+			"total_Len[%u], pkg_num[%u], is_read[yes]",
+			trace_id, &pkt_header, index, resp_dwords,
+			pkt_num);
+		hdc_packet_header_fill(&pkt_header, index, resp_dwords,
+					pkt_num, 1);
+
+		hdc_packet_send(hw, trace_id, &pkt_header, NULL, 0);
+
+		ret = hdc_packet_ack_get(hw, trace_id, &pkt_header);
+		if (ret == -EINTR) {
+			LOG_ERROR_BDF("hdc cmd trace_id=0x%" SXE_PRIX64 " interrupted", trace_id);
+			goto l_out;
+		} else if (ret == -SXE_HDC_PKG_SKIP_ERR) {
+			LOG_ERROR_BDF("trace_id=0x%" SXE_PRIX64 " hdc resp ack polling "
+					"failed, ret=%d", trace_id, ret);
+			if (retry) {
+				ret = -SXE_HDC_RETRY_ERR;
+				goto l_out;
+			}
+
+			index--;
+			retry = true;
+			continue;
+		} else if (ret != SXE_HDC_SUCCESS) {
+			LOG_ERROR_BDF("trace_id=0x%" SXE_PRIX64 " hdc resp ack polling "
+					"failed, ret=%d", trace_id, ret);
+			ret = -SXE_HDC_RETRY_ERR;
+			goto l_out;
+		}
+
+		LOG_DEBUG_BDF("hdc trace_id=0x%" SXE_PRIX64 " resp pkt[%u] get "
+			"succeed header[0x%x]",
+			trace_id, index, pkt_header.dw0);
+
+		retry = false;
+
+		offset = index * DWORD_NUM * 4;
+		hdc_resp_data_rcv(hw, trace_id, &pkt_header,
+					out_data + offset, resp_len);
+	}
+
+l_out:
+	return ret;
+}
+
+static s32 sxe_hdc_packet_trans(struct sxe_hw *hw, u64 trace_id,
+					struct sxe_hdc_trans_info *trans_info)
+{
+	s32 ret = SXE_SUCCESS;
+	u32 status;
+	struct sxe_adapter *adapter = hw->adapter;
+	u32 channel_state;
+
+	status = sxe_hw_hdc_fw_status_get(hw);
+	if (status != SXE_FW_START_STATE_FINISHED) {
+		LOG_ERROR_BDF("fw[%p] status[0x%x] is not good", hw, status);
+		ret = -SXE_FW_STATUS_ERR;
+		goto l_ret;
+	}
+
+	channel_state = sxe_hw_hdc_channel_state_get(hw);
+	if (channel_state != SXE_FW_HDC_TRANSACTION_IDLE) {
+		LOG_ERROR_BDF("hdc channel state is busy");
+		ret = -SXE_HDC_RETRY_ERR;
+		goto l_ret;
+	}
+
+	ret = sxe_hdc_lock_get(hw);
+	if (ret) {
+		LOG_ERROR_BDF("hw[%p] cmd trace_id=0x%" SXE_PRIX64 " get hdc lock fail, ret=%d",
+				hw, trace_id, ret);
+		ret = -SXE_HDC_RETRY_ERR;
+		goto l_ret;
+	}
+
+	ret = hdc_req_process(hw, trace_id, trans_info->in.data,
+				trans_info->in.len);
+	if (ret) {
+		LOG_ERROR_BDF("hdc cmd trace_id=0x%" SXE_PRIX64 " req process "
+				"failed, ret=%d", trace_id, ret);
+		goto l_hdc_lock_release;
+	}
+
+	ret = hdc_resp_process(hw, trace_id, trans_info->out.data,
+				trans_info->out.len);
+	if (ret) {
+		LOG_ERROR_BDF("hdc cmd trace_id=0x%" SXE_PRIX64 " resp process "
+				"failed, ret=%d", trace_id, ret);
+	}
+
+l_hdc_lock_release:
+	sxe_hdc_lock_release(hw);
+l_ret:
+	return ret;
+}
+
+static s32 sxe_hdc_cmd_process(struct sxe_hw *hw, u64 trace_id,
+				struct sxe_hdc_trans_info *trans_info)
+{
+	s32 ret;
+	u8 retry_idx;
+	struct sxe_adapter *adapter = hw->adapter;
+	sigset_t old_mask, new_mask;
+	sigemptyset(&new_mask);
+	sigaddset(&new_mask, SIGINT);
+	sigaddset(&new_mask, SIGTERM);
+	ret = pthread_sigmask(SIG_BLOCK, &new_mask, &old_mask);
+	if (ret) {
+		LOG_ERROR_BDF("hdc set signal mask failed, ret=%d", ret);
+		goto l_ret;
+	}
+
+	LOG_DEBUG_BDF("hw[%p] cmd trace=0x%" SXE_PRIX64 "", hw, trace_id);
+
+	ret = sem_wait(sxe_hdc_sema_get());
+	if (ret) {
+		LOG_WARN_BDF("hw[%p] hdc concurrency full", hw);
+		goto l_ret;
+	}
+
+	for (retry_idx = 0; retry_idx < 250; retry_idx++) {
+		ret = sxe_hdc_packet_trans(hw, trace_id, trans_info);
+		if (ret == SXE_SUCCESS) {
+			goto l_up;
+		} else if (ret == -SXE_HDC_RETRY_ERR) {
+			rte_delay_ms(10);
+			continue;
+		} else {
+			LOG_ERROR_BDF("sxe hdc packet trace_id=0x%" SXE_PRIX64
+					" trans error, ret=%d", trace_id, ret);
+			ret = -EFAULT;
+			goto l_up;
+		}
+	}
+
+l_up:
+	LOG_DEBUG_BDF("hw[%p] cmd trace=0x%" SXE_PRIX64 "", hw, trace_id);
+	sem_post(sxe_hdc_sema_get());
+l_ret:
+	ret = pthread_sigmask(SIG_SETMASK, &old_mask, NULL);
+	if (ret)
+		LOG_ERROR_BDF("hdc restore old signal mask failed, ret=%d", ret);
+
+	if (ret == -SXE_HDC_RETRY_ERR)
+		ret = -EFAULT;
+
+	return ret;
+}
+
+static void sxe_cmd_hdr_init(struct sxe_hdc_cmd_hdr *cmd_hdr,
+					u8 cmd_type)
+{
+	cmd_hdr->cmd_type = cmd_type;
+	cmd_hdr->cmd_sub_type = 0;
+}
+
+static void sxe_driver_cmd_msg_init(struct sxe_hdc_drv_cmd_msg *msg,
+						u16 opcode, u64 trace_id,
+						void *req_data, u16 req_len)
+{
+	LOG_DEBUG("cmd[opcode=0x%x], trace=0x%" SXE_PRIX64 ", req_data_len=%u start init",
+			opcode, trace_id, req_len);
+	msg->opcode = opcode;
+	msg->length.req_len = SXE_HDC_MSG_HDR_SIZE + req_len;
+	msg->traceid = trace_id;
+
+	if (req_data && req_len != 0)
+		memcpy(msg->body, (u8 *)req_data, req_len);
+}
+
+static void sxe_hdc_trans_info_init(struct sxe_hdc_trans_info *trans_info,
+					u8 *in_data_buf, u16 in_len,
+					u8 *out_data_buf, u16 out_len)
+{
+	trans_info->in.data  = in_data_buf;
+	trans_info->in.len   = in_len;
+	trans_info->out.data = out_data_buf;
+	trans_info->out.len  = out_len;
+}
+
+s32 sxe_driver_cmd_trans(struct sxe_hw *hw, u16 opcode,
+					void *req_data, u16 req_len,
+					void *resp_data, u16 resp_len)
+{
+	s32 ret = SXE_SUCCESS;
+	struct sxe_hdc_cmd_hdr *cmd_hdr;
+	struct sxe_hdc_drv_cmd_msg *msg;
+	struct sxe_hdc_drv_cmd_msg *ack;
+	struct sxe_hdc_trans_info trans_info;
+	struct sxe_adapter *adapter = hw->adapter;
+
+	u8 *in_data_buf;
+	u8 *out_data_buf;
+	u16 in_len;
+	u16 out_len;
+	u64 trace_id = 0;
+	u16 ack_data_len;
+
+	in_len = SXE_HDC_CMD_HDR_SIZE + SXE_HDC_MSG_HDR_SIZE + req_len;
+	out_len = SXE_HDC_CMD_HDR_SIZE + SXE_HDC_MSG_HDR_SIZE + resp_len;
+
+	trace_id = sxe_trace_id_get();
+
+	in_data_buf = rte_zmalloc("pmd hdc in buffer", in_len, RTE_CACHE_LINE_SIZE);
+	if (in_data_buf == NULL) {
+		LOG_ERROR_BDF("cmd trace_id=0x%" SXE_PRIX64 " kzalloc indata "
+				"mem len[%u] failed", trace_id, in_len);
+		ret = -ENOMEM;
+		goto l_ret;
+	}
+
+	out_data_buf = rte_zmalloc("pmd hdc out buffer", out_len, RTE_CACHE_LINE_SIZE);
+	if (out_data_buf == NULL) {
+		LOG_ERROR_BDF("cmd trace_id=0x%" SXE_PRIX64 " kzalloc out_data "
+				"mem len[%u] failed", trace_id, out_len);
+		ret = -ENOMEM;
+		goto l_in_buf_free;
+	}
+
+	cmd_hdr = (struct sxe_hdc_cmd_hdr *)in_data_buf;
+	sxe_cmd_hdr_init(cmd_hdr, SXE_CMD_TYPE_DRV);
+
+	msg = (struct sxe_hdc_drv_cmd_msg *)((u8 *)in_data_buf + SXE_HDC_CMD_HDR_SIZE);
+	sxe_driver_cmd_msg_init(msg, opcode, trace_id, req_data, req_len);
+
+	LOG_DEBUG_BDF("trans drv cmd:trace_id=0x%" SXE_PRIX64 ", opcode[0x%x], "
+			"inlen=%u, out_len=%u",
+			trace_id, opcode, in_len, out_len);
+
+	sxe_hdc_trans_info_init(&trans_info,
+				in_data_buf, in_len,
+				out_data_buf, out_len);
+
+	ret = sxe_hdc_cmd_process(hw, trace_id, &trans_info);
+	if (ret) {
+		LOG_ERROR_BDF("hdc cmd trace_id=0x%" SXE_PRIX64 " hdc cmd process"
+				" failed, ret=%d", trace_id, ret);
+		goto l_out_buf_free;
+	}
+
+	ack = (struct sxe_hdc_drv_cmd_msg *)((u8 *)out_data_buf + SXE_HDC_CMD_HDR_SIZE);
+
+	if (ack->errcode) {
+		LOG_ERROR_BDF("driver get hdc ack failed trace_id=0x%" SXE_PRIX64 ", err=%d",
+				trace_id, ack->errcode);
+		ret = -EFAULT;
+		goto l_out_buf_free;
+	}
+
+	ack_data_len = ack->length.ack_len - SXE_HDC_MSG_HDR_SIZE;
+	if (resp_len != ack_data_len) {
+		LOG_ERROR("ack trace_id=0x%" SXE_PRIX64 " data len[%u]"
+			" and resp_len[%u] dont match",
+			trace_id, ack_data_len, resp_len);
+		ret = -EFAULT;
+		goto l_out_buf_free;
+	}
+
+	if (resp_len != 0)
+		memcpy(resp_data, ack->body, resp_len);
+
+	LOG_DEBUG_BDF("driver get hdc ack trace_id=0x%" SXE_PRIX64 ","
+			" ack_len=%u, ack_data_len=%u",
+			trace_id, ack->length.ack_len, ack_data_len);
+
+l_out_buf_free:
+	rte_free(out_data_buf);
+l_in_buf_free:
+	rte_free(in_data_buf);
+l_ret:
+	return ret;
+}
diff --git a/drivers/net/sxe/pf/sxe_pmd_hdc.h b/drivers/net/sxe/pf/sxe_pmd_hdc.h
new file mode 100644
index 0000000000..98e6599b9d
--- /dev/null
+++ b/drivers/net/sxe/pf/sxe_pmd_hdc.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+#ifndef __SXE_HOST_HDC_H__
+#define __SXE_HOST_HDC_H__
+
+#include "sxe_hdc.h"
+#include "sxe_hw.h"
+#include "sxe_errno.h"
+
+#define SXE_HDC_SUCCESS			  0
+#define SXE_HDC_FALSE				SXE_ERR_HDC(1)
+#define SXE_HDC_INVAL_PARAM		  SXE_ERR_HDC(2)
+#define SXE_HDC_BUSY				 SXE_ERR_HDC(3)
+#define SXE_HDC_FW_OPS_FAILED		SXE_ERR_HDC(4)
+#define SXE_HDC_FW_OV_TIMEOUT		SXE_ERR_HDC(5)
+#define SXE_HDC_REQ_ACK_HEAD_ERR	 SXE_ERR_HDC(6)
+#define SXE_HDC_REQ_ACK_TLEN_ERR	 SXE_ERR_HDC(7)
+#define SXE_HDC_PKG_SKIP_ERR		 SXE_ERR_HDC(8)
+#define SXE_HDC_PKG_OTHER_ERR		SXE_ERR_HDC(9)
+#define SXE_HDC_RETRY_ERR			SXE_ERR_HDC(10)
+#define SXE_FW_STATUS_ERR			SXE_ERR_HDC(11)
+
+struct sxe_hdc_data_info {
+	u8 *data;
+	u16 len;
+};
+
+struct sxe_hdc_trans_info {
+	struct sxe_hdc_data_info in;
+	struct sxe_hdc_data_info out;
+};
+
+s32 sxe_driver_cmd_trans(struct sxe_hw *hw, u16 opcode,
+					void *req_data, u16 req_len,
+					void *resp_data, u16 resp_len);
+
+void sxe_hdc_channel_init(void);
+
+void sxe_hdc_channel_uninit(void);
+
+s32 sxe_fw_time_sync(struct sxe_hw *hw);
+
+#endif
diff --git a/drivers/net/sxe/sxe_drv_type.h b/drivers/net/sxe/sxe_drv_type.h
new file mode 100644
index 0000000000..027c0571a4
--- /dev/null
+++ b/drivers/net/sxe/sxe_drv_type.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+
+#ifndef __SXE_DRV_TYPEDEF_H__
+#define __SXE_DRV_TYPEDEF_H__
+
+#include "sxe_types.h"
+
+typedef u8 U8;
+typedef u16 U16;
+typedef u32 U32;
+typedef u64 U64;
+
+#endif
-- 
2.18.2

