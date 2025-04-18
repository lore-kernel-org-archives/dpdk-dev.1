Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EACC3ABB6
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 May 2025 12:52:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 54F3F40E36;
	Mon,  5 May 2025 14:51:22 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.3])
 by mails.dpdk.org (Postfix) with ESMTP id E99C1400D6
 for <dev@dpdk.org>; Fri, 18 Apr 2025 10:09:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:Subject:Date:Message-ID:
 MIME-Version; bh=62XEtH36pqsDlA4yBLNbSfDYkIBHjhGkC6oXhZ4z0eE=;
 b=RPXOwpueAf8UM4pT2IbISqvCChNfrQaf/syEkEkMxBmuMnG0PVaNXpYQxBi5PC
 rM8n9fCAzpmwxtBCVCSErNfSUn5ZEuns6fKk6zH/tKCp34lLutMSrUYsKbElsALl
 kuMHCo6HCohzrEddBNGgY3NgQGr1d8Mwrqqhe8QHP/bZo=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp2 (Coremail) with SMTP id As8vCgAXqpe1CAJoAsjFAg--.56413S6;
 Fri, 18 Apr 2025 16:09:31 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Cc: Xin Wang <wangxin679@h-partners.com>, Yi Chen <chenyi221@huawei.com>,
 Feifei Wang <wangfeifei40@huawei.com>
Subject: [RFC 02/18] net/hinic3: add basic header files
Date: Fri, 18 Apr 2025 16:08:34 +0800
Message-ID: <20250418080908.9447-3-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20250418080908.9447-1-wff_light@vip.163.com>
References: <20250418080908.9447-1-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgAXqpe1CAJoAsjFAg--.56413S6
X-Coremail-Antispam: 1Uf129KBjvAXoWfJw4DAryrZr43Ww18ZrW5Jrb_yoW8CFy5Xo
 W5uF43tr4rXryjka1q9397tFW8Zrs5Zr15t3y5CayIvFsrKry8J3y3Jw47XrWfXw4DXry3
 Cry5tF4Du3yFyrn7n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUVveQDUUUU
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiAw4zCmgB4rykOgAAsd
X-Mailman-Approved-At: Mon, 05 May 2025 14:51:05 +0200
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

From: Xin Wang <wangxin679@h-partners.com>

Add HW registers definition header file for SP series NIC.
Add some headers that define commands and basic defines for
use in the code.

Signed-off-by: Xin Wang <wangxin679@h-partners.com>
Reviewed-by: Yi Chen <chenyi221@huawei.com>
Reviewed-by: Feifei Wang <wangfeifei40@huawei.com>
---
 drivers/net/hinic3/base/hinic3_cmd.h    | 231 ++++++++++++++++++++
 drivers/net/hinic3/base/hinic3_compat.h | 266 ++++++++++++++++++++++++
 drivers/net/hinic3/base/hinic3_csr.h    | 108 ++++++++++
 3 files changed, 605 insertions(+)
 create mode 100644 drivers/net/hinic3/base/hinic3_cmd.h
 create mode 100644 drivers/net/hinic3/base/hinic3_compat.h
 create mode 100644 drivers/net/hinic3/base/hinic3_csr.h

diff --git a/drivers/net/hinic3/base/hinic3_cmd.h b/drivers/net/hinic3/base/hinic3_cmd.h
new file mode 100644
index 0000000000..f0e200a944
--- /dev/null
+++ b/drivers/net/hinic3/base/hinic3_cmd.h
@@ -0,0 +1,231 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd
+ */
+
+#ifndef _HINIC3_CMD_H_
+#define _HINIC3_CMD_H_
+
+#define NIC_RSS_TEMP_ID_TO_CTX_LT_IDX(tmp_id)	tmp_id
+/* Begin of one temp tbl. */
+#define NIC_RSS_TEMP_ID_TO_INDIR_LT_IDX(tmp_id)	((tmp_id) << 4)
+/* 4 ctx in one entry. */
+#define NIC_RSS_CTX_TBL_ENTRY_SIZE		0x10
+/* Entry size = 16B, 16 entry/template. */
+#define NIC_RSS_INDIR_TBL_ENTRY_SIZE		0x10
+/* Entry size = 16B, so entry_num = 256B/16B. */
+#define NIC_RSS_INDIR_TBL_ENTRY_NUM		0x10
+
+#define NIC_UP_RSS_INVALID_TEMP_ID		0xFF
+#define NIC_UP_RSS_INVALID_FUNC_ID		0xFFFF
+#define NIC_UP_RSS_INVALID			0x00
+#define NIC_UP_RSS_EN				0x01
+#define NIC_UP_RSS_INVALID_GROUP_ID		0x7F
+
+#define NIC_RSS_CMD_TEMP_ALLOC			0x01
+#define NIC_RSS_CMD_TEMP_FREE			0x02
+
+#define HINIC3_RSS_TYPE_VALID_SHIFT		23
+#define HINIC3_RSS_TYPE_TCP_IPV6_EXT_SHIFT	24
+#define HINIC3_RSS_TYPE_IPV6_EXT_SHIFT		25
+#define HINIC3_RSS_TYPE_TCP_IPV6_SHIFT		26
+#define HINIC3_RSS_TYPE_IPV6_SHIFT		27
+#define HINIC3_RSS_TYPE_TCP_IPV4_SHIFT		28
+#define HINIC3_RSS_TYPE_IPV4_SHIFT		29
+#define HINIC3_RSS_TYPE_UDP_IPV6_SHIFT		30
+#define HINIC3_RSS_TYPE_UDP_IPV4_SHIFT		31
+#define HINIC3_RSS_TYPE_SET(val, member)	\
+	(((u32)(val) & 0x1) << HINIC3_RSS_TYPE_##member##_SHIFT)
+
+#define HINIC3_RSS_TYPE_GET(val, member)	\
+	(((u32)(val) >> HINIC3_RSS_TYPE_##member##_SHIFT) & 0x1)
+
+/* NIC CMDQ MODE. */
+typedef enum hinic3_ucode_cmd {
+	HINIC3_UCODE_CMD_MODIFY_QUEUE_CTX = 0,
+	HINIC3_UCODE_CMD_CLEAN_QUEUE_CONTEXT,
+	HINIC3_UCODE_CMD_ARM_SQ,
+	HINIC3_UCODE_CMD_ARM_RQ,
+	HINIC3_UCODE_CMD_SET_RSS_INDIR_TABLE,
+	HINIC3_UCODE_CMD_SET_RSS_CONTEXT_TABLE,
+	HINIC3_UCODE_CMD_GET_RSS_INDIR_TABLE,
+	HINIC3_UCODE_CMD_GET_RSS_CONTEXT_TABLE,
+	HINIC3_UCODE_CMD_SET_IQ_ENABLE,
+	HINIC3_UCODE_CMD_SET_RQ_FLUSH = 10,
+	HINIC3_UCODE_CMD_MODIFY_VLAN_CTX,
+} cmdq_nic_subtype_e;
+
+/* Commands between NIC to MPU. */
+enum hinic3_nic_cmd {
+	/* Only for PFD and VFD. */
+	HINIC3_NIC_CMD_VF_REGISTER = 0,
+
+	/* FUNC CFG */
+	HINIC3_NIC_CMD_SET_FUNC_TBL = 5,
+	HINIC3_NIC_CMD_SET_VPORT_ENABLE,
+	HINIC3_NIC_CMD_SET_RX_MODE,
+	HINIC3_NIC_CMD_SQ_CI_ATTR_SET,
+	HINIC3_NIC_CMD_GET_VPORT_STAT,
+	HINIC3_NIC_CMD_CLEAN_VPORT_STAT,
+	HINIC3_NIC_CMD_CLEAR_QP_RESOURCE,
+	HINIC3_NIC_CMD_CFG_FLEX_QUEUE,
+	/* LRO CFG */
+	HINIC3_NIC_CMD_CFG_RX_LRO,
+	HINIC3_NIC_CMD_CFG_LRO_TIMER,
+	HINIC3_NIC_CMD_FEATURE_NEGO,
+
+	/* MAC & VLAN CFG */
+	HINIC3_NIC_CMD_GET_MAC = 20,
+	HINIC3_NIC_CMD_SET_MAC,
+	HINIC3_NIC_CMD_DEL_MAC,
+	HINIC3_NIC_CMD_UPDATE_MAC,
+	HINIC3_NIC_CMD_GET_ALL_DEFAULT_MAC,
+
+	HINIC3_NIC_CMD_CFG_FUNC_VLAN,
+	HINIC3_NIC_CMD_SET_VLAN_FILTER_EN,
+	HINIC3_NIC_CMD_SET_RX_VLAN_OFFLOAD,
+
+	/* SR-IOV */
+	HINIC3_NIC_CMD_CFG_VF_VLAN = 40,
+	HINIC3_NIC_CMD_SET_SPOOPCHK_STATE,
+	/* RATE LIMIT */
+	HINIC3_NIC_CMD_SET_MAX_MIN_RATE,
+
+	/* RSS CFG */
+	HINIC3_NIC_CMD_RSS_CFG = 60,
+	HINIC3_NIC_CMD_RSS_TEMP_MGR,
+	HINIC3_NIC_CMD_GET_RSS_CTX_TBL,
+	HINIC3_NIC_CMD_CFG_RSS_HASH_KEY,
+	HINIC3_NIC_CMD_CFG_RSS_HASH_ENGINE,
+	HINIC3_NIC_CMD_SET_RSS_CTX_TBL_INTO_FUNC,
+
+	/* FDIR */
+	HINIC3_NIC_CMD_ADD_TC_FLOW = 80,
+	HINIC3_NIC_CMD_DEL_TC_FLOW,
+	HINIC3_NIC_CMD_GET_TC_FLOW,
+	HINIC3_NIC_CMD_FLUSH_TCAM,
+	HINIC3_NIC_CMD_CFG_TCAM_BLOCK,
+	HINIC3_NIC_CMD_ENABLE_TCAM,
+	HINIC3_NIC_CMD_GET_TCAM_BLOCK,
+
+	HINIC3_NIC_CMD_SET_FDIR_STATUS = 91,
+
+	/* PORT CFG */
+	HINIC3_NIC_CMD_SET_PORT_ENABLE = 100,
+	HINIC3_NIC_CMD_CFG_PAUSE_INFO,
+
+	HINIC3_NIC_CMD_SET_PORT_CAR,
+	HINIC3_NIC_CMD_SET_ER_DROP_PKT,
+
+	HINIC3_NIC_CMD_VF_COS,
+	HINIC3_NIC_CMD_SETUP_COS_MAPPING,
+	HINIC3_NIC_CMD_SET_ETS,
+	HINIC3_NIC_CMD_SET_PFC,
+
+	/* MISC */
+	HINIC3_NIC_CMD_BIOS_CFG = 120,
+	HINIC3_NIC_CMD_SET_FIRMWARE_CUSTOM_PACKETS_MSG,
+
+	/* DFX */
+	HINIC3_NIC_CMD_GET_SM_TABLE = 140,
+	HINIC3_NIC_CMD_RD_LINE_TBL,
+
+	HINIC3_NIC_CMD_SET_VHD_CFG = 161,
+
+	HINIC3_NIC_CMD_GET_PORT_STAT = 200,
+	HINIC3_NIC_CMD_CLEAN_PORT_STAT,
+
+	HINIC3_NIC_CMD_MAX = 256
+};
+
+/* COMM commands between driver to MPU. */
+enum hinic3_mgmt_cmd {
+	HINIC3_MGMT_CMD_FUNC_RESET = 0,
+	HINIC3_MGMT_CMD_FEATURE_NEGO,
+	HINIC3_MGMT_CMD_FLUSH_DOORBELL,
+	HINIC3_MGMT_CMD_START_FLUSH,
+	HINIC3_MGMT_CMD_SET_FUNC_FLR,
+	HINIC3_MGMT_CMD_SET_FUNC_SVC_USED_STATE = 7,
+
+	HINIC3_MGMT_CMD_CFG_MSIX_NUM = 10,
+
+	HINIC3_MGMT_CMD_SET_CMDQ_CTXT = 20,
+	HINIC3_MGMT_CMD_SET_VAT,
+	HINIC3_MGMT_CMD_CFG_PAGESIZE,
+	HINIC3_MGMT_CMD_CFG_MSIX_CTRL_REG,
+	HINIC3_MGMT_CMD_SET_CEQ_CTRL_REG,
+	HINIC3_MGMT_CMD_SET_DMA_ATTR,
+
+	HINIC3_MGMT_CMD_GET_MQM_FIX_INFO = 40,
+	HINIC3_MGMT_CMD_SET_MQM_CFG_INFO,
+	HINIC3_MGMT_CMD_SET_MQM_SRCH_GPA,
+	HINIC3_MGMT_CMD_SET_PPF_TMR,
+	HINIC3_MGMT_CMD_SET_PPF_HT_GPA,
+	HINIC3_MGMT_CMD_SET_FUNC_TMR_BITMAT,
+
+	HINIC3_MGMT_CMD_GET_FW_VERSION = 60,
+	HINIC3_MGMT_CMD_GET_BOARD_INFO,
+	HINIC3_MGMT_CMD_SYNC_TIME,
+	HINIC3_MGMT_CMD_GET_HW_PF_INFOS,
+	HINIC3_MGMT_CMD_SEND_BDF_INFO,
+
+	HINIC3_MGMT_CMD_UPDATE_FW = 80,
+	HINIC3_MGMT_CMD_ACTIVE_FW,
+	HINIC3_MGMT_CMD_HOT_ACTIVE_FW,
+	HINIC3_MGMT_CMD_HOT_ACTIVE_DONE_NOTICE,
+	HINIC3_MGMT_CMD_SWITCH_CFG,
+	HINIC3_MGMT_CMD_CHECK_FLASH,
+	HINIC3_MGMT_CMD_CHECK_FLASH_RW,
+	HINIC3_MGMT_CMD_RESOURCE_CFG,
+	HINIC3_MGMT_CMD_UPDATE_BIOS,
+
+	HINIC3_MGMT_CMD_FAULT_REPORT = 100,
+	HINIC3_MGMT_CMD_WATCHDOG_INFO,
+	HINIC3_MGMT_CMD_MGMT_RESET,
+	HINIC3_MGMT_CMD_FFM_SET,
+
+	HINIC3_MGMT_CMD_GET_LOG = 120,
+	HINIC3_MGMT_CMD_TEMP_OP,
+	HINIC3_MGMT_CMD_EN_AUTO_RST_CHIP,
+	HINIC3_MGMT_CMD_CFG_REG,
+	HINIC3_MGMT_CMD_GET_CHIP_ID,
+	HINIC3_MGMT_CMD_SYSINFO_DFX,
+	HINIC3_MGMT_CMD_PCIE_DFX_NTC,
+};
+
+enum mag_cmd {
+	SERDES_CMD_PROCESS = 0,
+
+	MAG_CMD_SET_PORT_CFG      = 1,
+	MAG_CMD_SET_PORT_ADAPT    = 2,
+	MAG_CMD_CFG_LOOPBACK_MODE = 3,
+
+	MAG_CMD_GET_PORT_ENABLE   = 5,
+	MAG_CMD_SET_PORT_ENABLE   = 6,
+	MAG_CMD_GET_LINK_STATUS   = 7,
+	MAG_CMD_SET_LINK_FOLLOW   = 8,
+	MAG_CMD_SET_PMA_ENABLE    = 9,
+	MAG_CMD_CFG_FEC_MODE      = 10,
+
+	/* PHY */
+	MAG_CMD_GET_XSFP_INFO        = 60,
+	MAG_CMD_SET_XSFP_ENABLE      = 61,
+	MAG_CMD_GET_XSFP_PRESENT     = 62,
+	/* sfp/qsfp single byte read/write, for equipment test. */
+	MAG_CMD_SET_XSFP_RW          = 63,
+	MAG_CMD_CFG_XSFP_TEMPERATURE = 64,
+
+	MAG_CMD_WIRE_EVENT        = 100,
+	MAG_CMD_LINK_ERR_EVENT    = 101,
+
+	MAG_CMD_EVENT_PORT_INFO   = 150,
+	MAG_CMD_GET_PORT_STAT     = 151,
+	MAG_CMD_CLR_PORT_STAT     = 152,
+	MAG_CMD_GET_PORT_INFO     = 153,
+	MAG_CMD_GET_PCS_ERR_CNT   = 154,
+	MAG_CMD_GET_MAG_CNT       = 155,
+	MAG_CMD_DUMP_ANTRAIN_INFO = 156,
+
+	MAG_CMD_MAX = 0xFF
+};
+
+#endif /* _HINIC3_CMD_H_ */
diff --git a/drivers/net/hinic3/base/hinic3_compat.h b/drivers/net/hinic3/base/hinic3_compat.h
new file mode 100644
index 0000000000..ae2899d15c
--- /dev/null
+++ b/drivers/net/hinic3/base/hinic3_compat.h
@@ -0,0 +1,266 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd
+ */
+
+#ifndef _HINIC3_COMPAT_H_
+#define _HINIC3_COMPAT_H_
+
+#include <stdint.h>
+#include <stdbool.h>
+#include <sys/time.h>
+#include <unistd.h>
+#include <sys/syscall.h>
+#include <pthread.h>
+#include <ethdev_pci.h>
+#include <eal_interrupts.h>
+#include <rte_io.h>
+#include <rte_atomic.h>
+#include <rte_byteorder.h>
+#include <rte_common.h>
+#include <rte_config.h>
+#include <rte_cycles.h>
+#include <rte_log.h>
+#include <rte_malloc.h>
+#include <rte_memcpy.h>
+#include <rte_memzone.h>
+#include <rte_spinlock.h>
+
+typedef uint8_t  u8;
+typedef int8_t   s8;
+typedef uint16_t u16;
+typedef uint32_t u32;
+typedef int32_t  s32;
+typedef uint64_t u64;
+
+#ifndef BIT
+#define BIT(n) (1U << (n))
+#endif
+
+#define upper_32_bits(n) ((u32)(((n) >> 16) >> 16))
+#define lower_32_bits(n) ((u32)(n))
+
+#define HINIC3_MEM_ALLOC_ALIGN_MIN 1
+
+extern int hinic3_logtype;
+#define RTE_LOGTYPE_NET_HINIC3 hinic3_logtype
+
+#define PMD_DRV_LOG(level, ...) RTE_LOG_LINE(level, NET_HINIC3, __VA_ARGS__)
+
+/* Bit order interface. */
+#define cpu_to_be16(o) rte_cpu_to_be_16(o)
+#define cpu_to_be32(o) rte_cpu_to_be_32(o)
+#define cpu_to_be64(o) rte_cpu_to_be_64(o)
+#define cpu_to_le32(o) rte_cpu_to_le_32(o)
+#define be16_to_cpu(o) rte_be_to_cpu_16(o)
+#define be32_to_cpu(o) rte_be_to_cpu_32(o)
+#define be64_to_cpu(o) rte_be_to_cpu_64(o)
+#define le32_to_cpu(o) rte_le_to_cpu_32(o)
+
+#ifdef HW_CONVERT_ENDIAN
+/* If csrs to enable endianness coverting are configed, hw will do the
+ * endianness coverting for stateless SQ ci, the fields less than 4B for
+ * doorbell, the fields less than 4B in the CQE data.
+ */
+#define hinic3_hw_be32(val)  (val)
+#define hinic3_hw_cpu32(val) (val)
+#define hinic3_hw_cpu16(val) (val)
+#else
+#define hinic3_hw_be32(val)  cpu_to_be32(val)
+#define hinic3_hw_cpu32(val) be32_to_cpu(val)
+#define hinic3_hw_cpu16(val) be16_to_cpu(val)
+#endif
+
+#define ARRAY_LEN(arr) ((int)(sizeof(arr) / sizeof((arr)[0])))
+
+static inline void
+hinic3_hw_be32_len(void *data, int len)
+{
+	int i, chunk_sz = sizeof(u32);
+	u32 *mem = data;
+
+	if (!data)
+		return;
+
+	len = len / chunk_sz;
+
+	for (i = 0; i < len; i++) {
+		*mem = hinic3_hw_be32(*mem);
+		mem++;
+	}
+}
+
+static inline int
+hinic3_get_bit(int nr, volatile unsigned long *addr)
+{
+	RTE_ASSERT(nr < 0x20);
+
+	uint32_t mask = UINT32_C(1) << nr;
+	return (*addr) & mask;
+}
+
+static inline void
+hinic3_set_bit(unsigned int nr, volatile unsigned long *addr)
+{
+	rte_atomic_fetch_or_explicit(addr, (1UL << nr),
+				     rte_memory_order_seq_cst);
+}
+
+static inline void
+hinic3_clear_bit(int nr, volatile unsigned long *addr)
+{
+	rte_atomic_fetch_and_explicit(addr, ~(1UL << nr),
+				      rte_memory_order_seq_cst);
+}
+
+static inline int
+hinic3_test_and_clear_bit(int nr, volatile unsigned long *addr)
+{
+	unsigned long mask = (1UL << nr);
+
+	return (int)(rte_atomic_fetch_and_explicit(addr, ~mask,
+						   rte_memory_order_seq_cst) &
+		     mask);
+}
+
+static inline int
+hinic3_test_and_set_bit(int nr, volatile unsigned long *addr)
+{
+	unsigned long mask = (1UL << nr);
+
+	return (int)(rte_atomic_fetch_or_explicit(addr, mask,
+						  rte_memory_order_seq_cst) &
+		     mask);
+}
+
+#ifdef CLOCK_MONOTONIC_RAW /**< Defined in glibc bits/time.h . */
+#define CLOCK_TYPE CLOCK_MONOTONIC_RAW
+#else
+#define CLOCK_TYPE CLOCK_MONOTONIC
+#endif
+
+#define HINIC3_MUTEX_TIMEOUT 10
+#define HINIC3_S_TO_MS_UNIT  1000
+#define HINIC3_S_TO_NS_UNIT  1000000
+
+static inline unsigned long
+clock_gettime_ms(void)
+{
+	struct timespec tv;
+
+	(void)clock_gettime(CLOCK_TYPE, &tv);
+
+	return (unsigned long)tv.tv_sec * HINIC3_S_TO_MS_UNIT +
+	       (unsigned long)tv.tv_nsec / HINIC3_S_TO_NS_UNIT;
+}
+
+#define jiffies		      clock_gettime_ms()
+#define msecs_to_jiffies(ms)  (ms)
+#define time_before(now, end) ((now) < (end))
+
+/**
+ * Convert data to big endian 32 bit format.
+ *
+ * @param data
+ * The data to convert.
+ * @param len
+ * Length of data to convert, must be Multiple of 4B.
+ */
+static inline void
+hinic3_cpu_to_be32(void *data, int len)
+{
+	int i, chunk_sz = sizeof(u32);
+	u32 *mem = data;
+
+	if (!data)
+		return;
+
+	len = len / chunk_sz;
+
+	for (i = 0; i < len; i++) {
+		*mem = cpu_to_be32(*mem);
+		mem++;
+	}
+}
+
+/**
+ * Convert data from big endian 32 bit format.
+ *
+ * @param data
+ * The data to convert.
+ * @param len
+ * Length of data to convert, must be Multiple of 4B.
+ */
+static inline void
+hinic3_be32_to_cpu(void *data, int len)
+{
+	int i, chunk_sz = sizeof(u32);
+	u32 *mem = data;
+
+	if (!data)
+		return;
+
+	len = len / chunk_sz;
+
+	for (i = 0; i < len; i++) {
+		*mem = be32_to_cpu(*mem);
+		mem++;
+	}
+}
+
+static inline u16
+ilog2(u32 n)
+{
+	u16 res = 0;
+
+	while (n > 1) {
+		n >>= 1;
+		res++;
+	}
+
+	return res;
+}
+
+static inline int
+hinic3_mutex_init(pthread_mutex_t *pthreadmutex,
+		  const pthread_mutexattr_t *mattr)
+{
+	int err;
+
+	err = pthread_mutex_init(pthreadmutex, mattr);
+	if (unlikely(err))
+		PMD_DRV_LOG(ERR, "Initialize mutex failed, error: %d", err);
+
+	return err;
+}
+
+static inline int
+hinic3_mutex_destroy(pthread_mutex_t *pthreadmutex)
+{
+	int err;
+
+	err = pthread_mutex_destroy(pthreadmutex);
+	if (unlikely(err))
+		PMD_DRV_LOG(ERR, "Destroy mutex failed, error: %d", err);
+
+	return err;
+}
+
+static inline int
+hinic3_mutex_lock(pthread_mutex_t *pthreadmutex)
+{
+	int err;
+
+	err = pthread_mutex_lock(pthreadmutex);
+	if (err)
+		PMD_DRV_LOG(ERR, "Mutex lock failed, err: %d", err);
+
+	return err;
+}
+
+static inline int
+hinic3_mutex_unlock(pthread_mutex_t *pthreadmutex)
+{
+	return pthread_mutex_unlock(pthreadmutex);
+}
+
+#endif /* _HINIC3_COMPAT_H_ */
diff --git a/drivers/net/hinic3/base/hinic3_csr.h b/drivers/net/hinic3/base/hinic3_csr.h
new file mode 100644
index 0000000000..8579794c8d
--- /dev/null
+++ b/drivers/net/hinic3/base/hinic3_csr.h
@@ -0,0 +1,108 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd
+ */
+
+#ifndef _HINIC3_CSR_H_
+#define _HINIC3_CSR_H_
+
+#ifdef CONFIG_SP_VID_DID
+#define PCI_VENDOR_ID_SPNIC    0x1F3F
+#define HINIC3_DEV_ID_STANDARD 0x9020
+#define HINIC3_DEV_ID_VF       0x9001
+#else
+#define PCI_VENDOR_ID_HUAWEI   0x19e5
+#define HINIC3_DEV_ID_STANDARD 0x0222
+#define HINIC3_DEV_ID_VF       0x375F
+#endif
+
+/*
+ * Bit30/bit31 for bar index flag.
+ * 00: bar0
+ * 01: bar1
+ * 10: bar2
+ * 11: bar3
+ */
+#define HINIC3_CFG_REGS_FLAG 0x40000000
+
+#define HINIC3_MGMT_REGS_FLAG 0xC0000000
+
+#define HINIC3_REGS_FLAG_MAKS 0x3FFFFFFF
+
+#define HINIC3_VF_CFG_REG_OFFSET 0x2000
+
+#define HINIC3_HOST_CSR_BASE_ADDR   (HINIC3_MGMT_REGS_FLAG + 0x6000)
+#define HINIC3_CSR_GLOBAL_BASE_ADDR (HINIC3_MGMT_REGS_FLAG + 0x6400)
+
+/* HW interface registers. */
+#define HINIC3_CSR_FUNC_ATTR0_ADDR (HINIC3_CFG_REGS_FLAG + 0x0)
+#define HINIC3_CSR_FUNC_ATTR1_ADDR (HINIC3_CFG_REGS_FLAG + 0x4)
+#define HINIC3_CSR_FUNC_ATTR2_ADDR (HINIC3_CFG_REGS_FLAG + 0x8)
+#define HINIC3_CSR_FUNC_ATTR3_ADDR (HINIC3_CFG_REGS_FLAG + 0xC)
+#define HINIC3_CSR_FUNC_ATTR4_ADDR (HINIC3_CFG_REGS_FLAG + 0x10)
+#define HINIC3_CSR_FUNC_ATTR5_ADDR (HINIC3_CFG_REGS_FLAG + 0x14)
+#define HINIC3_CSR_FUNC_ATTR6_ADDR (HINIC3_CFG_REGS_FLAG + 0x18)
+
+#define HINIC3_FUNC_CSR_MAILBOX_DATA_OFF       0x80
+#define HINIC3_FUNC_CSR_MAILBOX_CONTROL_OFF    (HINIC3_CFG_REGS_FLAG + 0x0100)
+#define HINIC3_FUNC_CSR_MAILBOX_INT_OFFSET_OFF (HINIC3_CFG_REGS_FLAG + 0x0104)
+#define HINIC3_FUNC_CSR_MAILBOX_RESULT_H_OFF   (HINIC3_CFG_REGS_FLAG + 0x0108)
+#define HINIC3_FUNC_CSR_MAILBOX_RESULT_L_OFF   (HINIC3_CFG_REGS_FLAG + 0x010C)
+
+#define HINIC3_PPF_ELECTION_OFFSET 0x0
+#define HINIC3_MPF_ELECTION_OFFSET 0x20
+
+#define HINIC3_CSR_PPF_ELECTION_ADDR \
+	(HINIC3_HOST_CSR_BASE_ADDR + HINIC3_PPF_ELECTION_OFFSET)
+
+#define HINIC3_CSR_GLOBAL_MPF_ELECTION_ADDR \
+	(HINIC3_HOST_CSR_BASE_ADDR + HINIC3_MPF_ELECTION_OFFSET)
+
+#define HINIC3_CSR_DMA_ATTR_TBL_ADDR	   (HINIC3_CFG_REGS_FLAG + 0x380)
+#define HINIC3_CSR_DMA_ATTR_INDIR_IDX_ADDR (HINIC3_CFG_REGS_FLAG + 0x390)
+
+/* MSI-X registers. */
+#define HINIC3_CSR_MSIX_INDIR_IDX_ADDR	(HINIC3_CFG_REGS_FLAG + 0x310)
+#define HINIC3_CSR_MSIX_CTRL_ADDR	(HINIC3_CFG_REGS_FLAG + 0x300)
+#define HINIC3_CSR_MSIX_CNT_ADDR	(HINIC3_CFG_REGS_FLAG + 0x304)
+#define HINIC3_CSR_FUNC_MSI_CLR_WR_ADDR (HINIC3_CFG_REGS_FLAG + 0x58)
+
+#define HINIC3_MSI_CLR_INDIR_RESEND_TIMER_CLR_SHIFT 0
+#define HINIC3_MSI_CLR_INDIR_INT_MSK_SET_SHIFT	    1
+#define HINIC3_MSI_CLR_INDIR_INT_MSK_CLR_SHIFT	    2
+#define HINIC3_MSI_CLR_INDIR_AUTO_MSK_SET_SHIFT	    3
+#define HINIC3_MSI_CLR_INDIR_AUTO_MSK_CLR_SHIFT	    4
+#define HINIC3_MSI_CLR_INDIR_SIMPLE_INDIR_IDX_SHIFT 22
+
+#define HINIC3_MSI_CLR_INDIR_RESEND_TIMER_CLR_MASK 0x1U
+#define HINIC3_MSI_CLR_INDIR_INT_MSK_SET_MASK	   0x1U
+#define HINIC3_MSI_CLR_INDIR_INT_MSK_CLR_MASK	   0x1U
+#define HINIC3_MSI_CLR_INDIR_AUTO_MSK_SET_MASK	   0x1U
+#define HINIC3_MSI_CLR_INDIR_AUTO_MSK_CLR_MASK	   0x1U
+#define HINIC3_MSI_CLR_INDIR_SIMPLE_INDIR_IDX_MASK 0x3FFU
+
+#define HINIC3_MSI_CLR_INDIR_SET(val, member)           \
+	(((val) & HINIC3_MSI_CLR_INDIR_##member##_MASK) \
+	 << HINIC3_MSI_CLR_INDIR_##member##_SHIFT)
+
+/* EQ registers. */
+#define HINIC3_AEQ_INDIR_IDX_ADDR (HINIC3_CFG_REGS_FLAG + 0x210)
+
+#define HINIC3_AEQ_MTT_OFF_BASE_ADDR (HINIC3_CFG_REGS_FLAG + 0x240)
+
+#define HINIC3_CSR_EQ_PAGE_OFF_STRIDE 8
+
+#define HINIC3_AEQ_HI_PHYS_ADDR_REG(pg_num) \
+	(HINIC3_AEQ_MTT_OFF_BASE_ADDR +     \
+	 (pg_num) * HINIC3_CSR_EQ_PAGE_OFF_STRIDE)
+
+#define HINIC3_AEQ_LO_PHYS_ADDR_REG(pg_num) \
+	(HINIC3_AEQ_MTT_OFF_BASE_ADDR +     \
+	 (pg_num) * HINIC3_CSR_EQ_PAGE_OFF_STRIDE + 4)
+
+#define HINIC3_CSR_AEQ_CTRL_0_ADDR	    (HINIC3_CFG_REGS_FLAG + 0x200)
+#define HINIC3_CSR_AEQ_CTRL_1_ADDR	    (HINIC3_CFG_REGS_FLAG + 0x204)
+#define HINIC3_CSR_AEQ_CONS_IDX_ADDR	    (HINIC3_CFG_REGS_FLAG + 0x208)
+#define HINIC3_CSR_AEQ_PROD_IDX_ADDR	    (HINIC3_CFG_REGS_FLAG + 0x20C)
+#define HINIC3_CSR_AEQ_CI_SIMPLE_INDIR_ADDR (HINIC3_CFG_REGS_FLAG + 0x50)
+
+#endif /* _HINIC3_CSR_H_ */
-- 
2.47.0.windows.2

