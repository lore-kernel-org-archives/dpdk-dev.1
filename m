Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F029CAC5A7
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 07:53:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 36C5D40689;
	Wed, 24 Sep 2025 09:53:41 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.2])
 by mails.dpdk.org (Postfix) with ESMTP id 3F75B4027C
 for <dev@dpdk.org>; Wed, 24 Sep 2025 09:53:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=zoRPe2iYOoiU15OmdHjW178BRyN3NM1pTdgTIK8KLhU=;
 b=oAiil37WO8MP8si/z4qVYIJMWxqMPATs/00DDwP2q+j1JFCcPi/4PB+7cgA4iO
 ts78SFG4L1YuKemS44ot4eBrl2YqC3Xr8EQP4ZDQxAqciO7LSUKvBwlxwxmCoPUU
 aR9kgn9YiquE9C5a9uLxcayyHZJYbk9076dpZQ/CPJn7k=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp2 (Coremail) with SMTP id As8vCgDnT+VCo9No80coBA--.31336S6;
 Wed, 24 Sep 2025 15:53:35 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Cc: gongfan1@huawei.com, Xin Wang <wangxin679@h-partners.com>,
 Yi Chen <chenyi221@huawei.com>, Feifei Wang <wangfeifei40@huawei.com>
Subject: [V13 02/18] net/hinic3: add basic header files
Date: Wed, 24 Sep 2025 15:51:49 +0800
Message-ID: <20250924075216.18750-3-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20250924075216.18750-1-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250924075216.18750-1-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgDnT+VCo9No80coBA--.31336S6
X-Coremail-Antispam: 1Uf129KBjvAXoWfJw4DAry5Wry7Xr1UCF1UGFg_yoW8GF1xGo
 WUuF4ftw4fXryIka1q9397tFWrZrs5Zr15t3yrCa92vFsrKry8G3y3Jw17XrWFq3yDGry5
 Cry5AF4Du3yYyr1Dn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUxID7UUUUU
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiAxfSCmjTmwEhdwAAs7
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
 MAINTAINERS                             |   1 +
 drivers/net/hinic3/base/hinic3_cmd.h    | 135 ++++++++++++++++++++++++
 drivers/net/hinic3/base/hinic3_compat.h | 133 +++++++++++++++++++++++
 drivers/net/hinic3/base/hinic3_csr.h    | 104 ++++++++++++++++++
 4 files changed, 373 insertions(+)
 create mode 100644 drivers/net/hinic3/base/hinic3_cmd.h
 create mode 100644 drivers/net/hinic3/base/hinic3_compat.h
 create mode 100644 drivers/net/hinic3/base/hinic3_csr.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 25530b9cf1..e24fbcccbb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -784,6 +784,7 @@ F: doc/guides/nics/features/hinic.ini
 
 Huawei hinic3
 M: Feifei Wang <wangfeifei40@huawei.com>
+F: drivers/net/hinic3/
 F: doc/guides/nics/hinic3.rst
 
 Intel Network Common Code
diff --git a/drivers/net/hinic3/base/hinic3_cmd.h b/drivers/net/hinic3/base/hinic3_cmd.h
new file mode 100644
index 0000000000..6042ca51bd
--- /dev/null
+++ b/drivers/net/hinic3/base/hinic3_cmd.h
@@ -0,0 +1,135 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd
+ */
+
+#ifndef _HINIC3_CMD_H_
+#define _HINIC3_CMD_H_
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
+	(((uint32_t)(val) & 0x1) << HINIC3_RSS_TYPE_##member##_SHIFT)
+
+#define HINIC3_RSS_TYPE_GET(val, member)	\
+	(((uint32_t)(val) >> HINIC3_RSS_TYPE_##member##_SHIFT) & 0x1)
+
+/* NIC CMDQ MODE. */
+enum hinic3_ucode_cmd {
+	HINIC3_UCODE_CMD_MODIFY_QUEUE_CTX	= 0,
+	HINIC3_UCODE_CMD_CLEAN_QUEUE_CONTEXT	= 1,
+	HINIC3_UCODE_CMD_SET_RSS_INDIR_TABLE	= 4,
+	HINIC3_UCODE_CMD_SET_RSS_CONTEXT_TABLE	= 5,
+	HINIC3_UCODE_CMD_GET_RSS_INDIR_TABLE	= 6,
+	HINIC3_UCODE_CMD_SET_RQ_FLUSH		= 10,
+};
+
+/* Commands between NIC to MPU. */
+enum hinic3_nic_cmd {
+	/* Only for PFD and VFD. */
+	HINIC3_NIC_CMD_VF_REGISTER			= 0,
+
+	/* FUNC CFG */
+	HINIC3_NIC_CMD_SET_FUNC_TBL			= 5,
+	HINIC3_NIC_CMD_SET_VPORT_ENABLE			= 6,
+	HINIC3_NIC_CMD_SET_RX_MODE			= 7,
+	HINIC3_NIC_CMD_SQ_CI_ATTR_SET			= 8,
+	HINIC3_NIC_CMD_GET_VPORT_STAT			= 9,
+	HINIC3_NIC_CMD_CLEAN_VPORT_STAT			= 10,
+	HINIC3_NIC_CMD_CLEAR_QP_RESOURCE		= 11,
+	HINIC3_NIC_CMD_CFG_FLEX_QUEUE			= 12,
+	/* LRO CFG */
+	HINIC3_NIC_CMD_CFG_RX_LRO			= 13,
+	HINIC3_NIC_CMD_CFG_LRO_TIMER			= 14,
+	HINIC3_NIC_CMD_FEATURE_NEGO			= 15,
+	/* MAC & VLAN CFG */
+	HINIC3_NIC_CMD_GET_MAC				= 20,
+	HINIC3_NIC_CMD_SET_MAC				= 21,
+	HINIC3_NIC_CMD_DEL_MAC				= 22,
+	HINIC3_NIC_CMD_UPDATE_MAC			= 23,
+	HINIC3_NIC_CMD_CFG_FUNC_VLAN			= 25,
+	HINIC3_NIC_CMD_SET_VLAN_FILTER_EN		= 26,
+	HINIC3_NIC_CMD_SET_RX_VLAN_OFFLOAD		= 27,
+	/* RSS CFG */
+	HINIC3_NIC_CMD_RSS_CFG				= 60,
+	HINIC3_NIC_CMD_RSS_TEMP_MGR			= 61,
+	HINIC3_NIC_CMD_GET_RSS_CTX_TBL			= 62,
+	HINIC3_NIC_CMD_CFG_RSS_HASH_KEY			= 63,
+	HINIC3_NIC_CMD_CFG_RSS_HASH_ENGINE		= 64,
+	HINIC3_NIC_CMD_SET_RSS_CTX_TBL_INTO_FUNC	= 65,
+	/* FDIR */
+	HINIC3_NIC_CMD_ADD_TC_FLOW			= 80,
+	HINIC3_NIC_CMD_DEL_TC_FLOW			= 81,
+	HINIC3_NIC_CMD_FLUSH_TCAM			= 83,
+	HINIC3_NIC_CMD_CFG_TCAM_BLOCK			= 84,
+	HINIC3_NIC_CMD_ENABLE_TCAM			= 85,
+
+	HINIC3_NIC_CMD_SET_FDIR_STATUS			= 91,
+	/* PORT CFG */
+	HINIC3_NIC_CMD_CFG_PAUSE_INFO			= 101,
+	HINIC3_NIC_CMD_VF_COS				= 104,
+};
+
+/* COMM commands between driver to MPU. */
+enum hinic3_mgmt_cmd {
+	HINIC3_MGMT_CMD_FUNC_RESET			= 0,
+	HINIC3_MGMT_CMD_FEATURE_NEGO			= 1,
+	HINIC3_MGMT_CMD_SET_FUNC_SVC_USED_STATE		= 7,
+	HINIC3_MGMT_CMD_SET_CMDQ_CTXT			= 20,
+	HINIC3_MGMT_CMD_SET_VAT				= 21,
+	HINIC3_MGMT_CMD_CFG_PAGESIZE			= 22,
+	HINIC3_MGMT_CMD_CFG_MSIX_CTRL_REG		= 23,
+	HINIC3_MGMT_CMD_SET_DMA_ATTR			= 25,
+	HINIC3_MGMT_CMD_GET_MQM_FIX_INFO		= 40,
+	HINIC3_MGMT_CMD_GET_FW_VERSION			= 60,
+	HINIC3_MGMT_CMD_GET_BOARD_INFO			= 61,
+	HINIC3_MGMT_CMD_FAULT_REPORT			= 100,
+	HINIC3_MGMT_CMD_FFM_SET				= 103,
+};
+
+enum mag_cmd {
+	SERDES_CMD_PROCESS	  = 0,
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
+	MAG_CMD_GET_XSFP_INFO     = 60,
+	MAG_CMD_SET_XSFP_ENABLE   = 61,
+	MAG_CMD_GET_XSFP_PRESENT  = 62,
+	/* sfp/qsfp single byte read/write, for equipment test. */
+	MAG_CMD_SET_XSFP_RW       = 63,
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
index 0000000000..5fb71e1b0c
--- /dev/null
+++ b/drivers/net/hinic3/base/hinic3_compat.h
@@ -0,0 +1,133 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd
+ */
+
+#ifndef _HINIC3_COMPAT_H_
+#define _HINIC3_COMPAT_H_
+
+#include <rte_ethdev.h>
+#include <rte_io.h>
+#include <rte_log.h>
+
+#define upper_32_bits(n) ((uint32_t)((n) >> 32))
+#define lower_32_bits(n) ((uint32_t)(n))
+
+#define HINIC3_MEM_ALLOC_ALIGN_MIN 1
+
+extern int hinic3_logtype;
+#define RTE_LOGTYPE_HINIC3_DRIVER hinic3_logtype
+
+#define PMD_DRV_LOG(level, ...) \
+	RTE_LOG_LINE_PREFIX(level, HINIC3_DRIVER, "%s(): ", __func__, __VA_ARGS__)
+
+#ifdef HW_CONVERT_ENDIAN
+/* If csrs to enable endianness converting are configured, hw will do the
+ * endianness converting for stateless SQ ci, the fields less than 4B for
+ * doorbell, the fields less than 4B in the CQE data.
+ */
+#define hinic3_hw_be32(val)  (val)
+#define hinic3_hw_cpu32(val) (val)
+#define hinic3_hw_cpu16(val) (val)
+#else
+#define hinic3_hw_be32(val)  rte_cpu_to_be_32(val)
+#define hinic3_hw_cpu32(val) rte_be_to_cpu_32(val)
+#define hinic3_hw_cpu16(val) rte_be_to_cpu_16(val)
+#endif
+
+static inline void
+hinic3_cpu_to_hw(void *data, uint32_t len)
+{
+	uint32_t i, seg = len / sizeof(uint32_t);
+	uint32_t *mem = data;
+
+	for (i = 0; i < seg; i++) {
+		*mem = hinic3_hw_be32(*mem);
+		mem++;
+	}
+}
+
+static inline int
+hinic3_get_bit(uint32_t nr, volatile RTE_ATOMIC(uint64_t) *addr)
+{
+	return rte_atomic_fetch_or_explicit(addr, RTE_BIT64(nr),
+				     rte_memory_order_relaxed);
+}
+
+static inline void
+hinic3_set_bit(uint32_t nr, volatile RTE_ATOMIC(uint64_t) *addr)
+{
+	rte_atomic_fetch_or_explicit(addr, RTE_BIT64(nr),
+				     rte_memory_order_seq_cst);
+}
+
+static inline void
+hinic3_clear_bit(uint32_t nr, volatile RTE_ATOMIC(uint64_t) *addr)
+{
+	rte_atomic_fetch_and_explicit(addr, ~RTE_BIT64(nr),
+				      rte_memory_order_seq_cst);
+}
+
+static inline int
+hinic3_test_and_clear_bit(uint32_t nr, volatile RTE_ATOMIC(uint64_t) *addr)
+{
+	unsigned long mask = RTE_BIT64(nr);
+
+	return rte_atomic_fetch_and_explicit(addr, ~mask,
+				      rte_memory_order_seq_cst) & mask;
+}
+
+static inline int
+hinic3_test_and_set_bit(uint32_t nr, volatile RTE_ATOMIC(uint64_t) *addr)
+{
+	unsigned long mask = RTE_BIT64(nr);
+
+	return rte_atomic_fetch_or_explicit(addr, mask,
+				      rte_memory_order_seq_cst) & mask;
+}
+
+#define HINIC3_S_TO_MS_UNIT  1000
+
+#define cycles		      rte_get_timer_cycles()
+#define msecs_to_cycles(ms)  ((ms) * rte_get_timer_hz() / HINIC3_S_TO_MS_UNIT)
+#define time_before(now, end) ((int64_t)((now) - (end)) < 0)
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
+hinic3_cpu_to_be32(void *data, uint32_t len)
+{
+	uint32_t i, seg = len / sizeof(uint32_t);
+	uint32_t *mem = data;
+
+	for (i = 0; i < seg; i++) {
+		*mem = rte_cpu_to_be_32(*mem);
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
+hinic3_be32_to_cpu(void *data, uint32_t len)
+{
+	uint32_t i, seg = len / sizeof(uint32_t);
+	uint32_t *mem = data;
+
+	for (i = 0; i < seg; i++) {
+		*mem = rte_be_to_cpu_32(*mem);
+		mem++;
+	}
+}
+#endif /* _HINIC3_COMPAT_H_ */
diff --git a/drivers/net/hinic3/base/hinic3_csr.h b/drivers/net/hinic3/base/hinic3_csr.h
new file mode 100644
index 0000000000..94b10601c4
--- /dev/null
+++ b/drivers/net/hinic3/base/hinic3_csr.h
@@ -0,0 +1,104 @@
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
+#define HINIC3_CFG_REGS_FLAG  0x40000000
+
+#define HINIC3_MGMT_REGS_FLAG 0xC0000000
+
+#define HINIC3_REGS_FLAG_MASK 0x3FFFFFFF
+
+#define HINIC3_VF_CFG_REG_OFFSET 0x2000
+
+#define HINIC3_HOST_CSR_BASE_ADDR   (HINIC3_MGMT_REGS_FLAG + 0x6000)
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

