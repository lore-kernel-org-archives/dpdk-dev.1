Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F14CD4F52
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 May 2026 09:14:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8050640652;
	Mon, 18 May 2026 11:14:17 +0200 (CEST)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by mails.dpdk.org (Postfix) with ESMTP id 21EB440612
 for <dev@dpdk.org>; Mon, 18 May 2026 11:14:13 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-05 (Coremail) with SMTP id zQCowADHVAhi2ApqIPmbEA--.3979S5;
 Mon, 18 May 2026 17:14:11 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v16 03/11] common/sxe2: add sxe2 basic structures
Date: Mon, 18 May 2026 17:13:57 +0800
Message-ID: <20260518091405.3295896-4-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260518091405.3295896-1-liujie5@linkdatatechnology.com>
References: <20260516074618.2343883-12-liujie5@linkdatatechnology.com>
 <20260518091405.3295896-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowADHVAhi2ApqIPmbEA--.3979S5
X-Coremail-Antispam: 1UD129KBjvAXoWDWw1xArWrKF47WryktF1xuFg_yoWrWr1fJo
 WUJFnxXw1UArn7Aw4DG3W7Xw1jvry09r15tFW0kryIy3ZrJr1DGryUJFWkX3WYqF92gF13
 XF9I934qy3s0vFykn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UjIYCTnIWjp_UUUYK7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20EY4v20xva
 j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r1rM28IrcIa0x
 kI8VCY1x0267AKxVWUCVW8JwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84AC
 jcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM2
 8EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4U
 JwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
 IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
 M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0F24l42
 xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWU
 GwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI4
 8JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4U
 MIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I
 8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUePfHUUUUU
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

This patch adds the base infrastructure for the sxe2 common
library. It includes the mandatory OS abstraction layer (OSAL),
common structure definitions, error codes, and the logging
system implementation.

Specifically, this commit:
 - Implements the logging stream management using RTE_LOG_LINE.
 - Defines device-specific error codes and status registers.
 - Adds the initial meson build configuration for the common library.

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/common/sxe2/sxe2_common_log.h   |  81 +++
 drivers/common/sxe2/sxe2_host_regs.h    | 707 ++++++++++++++++++++++++
 drivers/common/sxe2/sxe2_internal_ver.h |  33 ++
 drivers/common/sxe2/sxe2_osal.h         | 152 +++++
 4 files changed, 973 insertions(+)
 create mode 100644 drivers/common/sxe2/sxe2_common_log.h
 create mode 100644 drivers/common/sxe2/sxe2_host_regs.h
 create mode 100644 drivers/common/sxe2/sxe2_internal_ver.h
 create mode 100644 drivers/common/sxe2/sxe2_osal.h

diff --git a/drivers/common/sxe2/sxe2_common_log.h b/drivers/common/sxe2/sxe2_common_log.h
new file mode 100644
index 0000000000..e7a9a5f8d0
--- /dev/null
+++ b/drivers/common/sxe2/sxe2_common_log.h
@@ -0,0 +1,81 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#ifndef __SXE2_COMMON_LOG_H__
+#define __SXE2_COMMON_LOG_H__
+
+extern int32_t sxe2_common_log;
+extern int32_t sxe2_log_init;
+extern int32_t sxe2_log_driver;
+extern int32_t sxe2_log_rx;
+extern int32_t sxe2_log_tx;
+extern int32_t sxe2_log_hw;
+
+#define RTE_LOGTYPE_SXE2_COM  sxe2_common_log
+#define RTE_LOGTYPE_SXE2_INIT sxe2_log_init
+#define RTE_LOGTYPE_SXE2_DRV  sxe2_log_driver
+#define RTE_LOGTYPE_SXE2_RX   sxe2_log_rx
+#define RTE_LOGTYPE_SXE2_TX   sxe2_log_tx
+#define RTE_LOGTYPE_SXE2_HW   sxe2_log_hw
+
+#define SXE2_PMD_LOG(level, log_type, ...) \
+	RTE_LOG_LINE_PREFIX(level, log_type, "%s(): ", \
+		__func__, __VA_ARGS__)
+
+#define SXE2_PMD_DRV_LOG(level, log_type, adapter, ...) \
+	RTE_LOG_LINE_PREFIX(level, log_type, "%s(): port:%u ", \
+		__func__ RTE_LOG_COMMA \
+		adapter->dev_port_id, __VA_ARGS__)
+
+#define PMD_LOG_DEBUG(logtype, fmt, ...) \
+	SXE2_PMD_LOG(DEBUG, SXE2_##logtype, fmt, ##__VA_ARGS__)
+
+#define PMD_LOG_INFO(logtype, fmt, ...) \
+	SXE2_PMD_LOG(INFO, SXE2_##logtype, fmt, ##__VA_ARGS__)
+
+#define PMD_LOG_NOTICE(logtype, fmt, ...) \
+	SXE2_PMD_LOG(NOTICE, SXE2_##logtype, fmt, ##__VA_ARGS__)
+
+#define PMD_LOG_WARN(logtype, fmt, ...) \
+	SXE2_PMD_LOG(WARNING, SXE2_##logtype, fmt, ##__VA_ARGS__)
+
+#define PMD_LOG_ERR(logtype, fmt, ...) \
+	SXE2_PMD_LOG(ERR, SXE2_##logtype, fmt, ##__VA_ARGS__)
+
+#define PMD_LOG_CRIT(logtype, fmt, ...) \
+	SXE2_PMD_LOG(CRIT, SXE2_##logtype, fmt, ##__VA_ARGS__)
+
+#define PMD_LOG_ALERT(logtype, fmt, ...) \
+	SXE2_PMD_LOG(ALERT, SXE2_##logtype, fmt, ##__VA_ARGS__)
+
+#define PMD_LOG_EMERG(logtype, fmt, ...) \
+	SXE2_PMD_LOG(EMERG, SXE2_##logtype, fmt, ##__VA_ARGS__)
+
+#define PMD_DEV_LOG_DEBUG(adapter, logtype, fmt, ...) \
+	SXE2_PMD_DRV_LOG(DEBUG, SXE2_##logtype, adapter, fmt, ##__VA_ARGS__)
+
+#define PMD_DEV_LOG_INFO(adapter, logtype, fmt, ...) \
+	SXE2_PMD_DRV_LOG(INFO, SXE2_##logtype, adapter, fmt, ##__VA_ARGS__)
+
+#define PMD_DEV_LOG_NOTICE(adapter, logtype, fmt, ...) \
+	SXE2_PMD_DRV_LOG(NOTICE, SXE2_##logtype, adapter, fmt, ##__VA_ARGS__)
+
+#define PMD_DEV_LOG_WARN(adapter, logtype, fmt, ...) \
+	SXE2_PMD_DRV_LOG(WARNING, SXE2_##logtype, adapter, fmt, ##__VA_ARGS__)
+
+#define PMD_DEV_LOG_ERR(adapter, logtype, fmt, ...) \
+	SXE2_PMD_DRV_LOG(ERR, SXE2_##logtype, adapter, fmt, ##__VA_ARGS__)
+
+#define PMD_DEV_LOG_CRIT(adapter, logtype, fmt, ...) \
+	SXE2_PMD_DRV_LOG(CRIT, SXE2_##logtype, adapter, fmt, ##__VA_ARGS__)
+
+#define PMD_DEV_LOG_ALERT(adapter, logtype, fmt, ...) \
+	SXE2_PMD_DRV_LOG(ALERT, SXE2_##logtype, adapter, fmt, ##__VA_ARGS__)
+
+#define PMD_DEV_LOG_EMERG(adapter, logtype, fmt, ...) \
+	SXE2_PMD_DRV_LOG(EMERG, SXE2_##logtype, adapter, fmt, ##__VA_ARGS__)
+
+#define PMD_INIT_FUNC_TRACE() PMD_LOG_DEBUG(INIT, " >>")
+
+#endif /* __SXE2_COMMON_LOG_H__ */
diff --git a/drivers/common/sxe2/sxe2_host_regs.h b/drivers/common/sxe2/sxe2_host_regs.h
new file mode 100644
index 0000000000..984ea6214c
--- /dev/null
+++ b/drivers/common/sxe2/sxe2_host_regs.h
@@ -0,0 +1,707 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#ifndef __SXE2_HOST_REGS_H__
+#define __SXE2_HOST_REGS_H__
+
+#define SXE2_BITS_MASK(m, s)		((m ## UL) << (s))
+
+#define SXE2_RXQ_CTXT(_i, _QRX)             (0x0050000 + ((_i) * 4 + (_QRX) * 0x20))
+#define SXE2_RXQ_HEAD(_QRX)                 (0x0060000 + ((_QRX) * 4))
+#define SXE2_RXQ_TAIL(_QRX)                 (0x0070000 + ((_QRX) * 4))
+#define SXE2_RXQ_CTRL(_QRX)                 (0x006d000 + ((_QRX) * 4))
+#define SXE2_RXQ_WB(_QRX)                   (0x006B000 + ((_QRX) * 4))
+
+#define SXE2_RXQ_CTRL_STATUS_ACTIVE       0x00000004
+#define SXE2_RXQ_CTRL_ENABLED             0x00000001
+#define SXE2_RXQ_CTRL_CDE_ENABLE		BIT(3)
+
+#define SXE2_PCIEPROC_BASE         0x002d6000
+
+#define SXE2_PF_INT_BASE         0x00260000
+#define SXE2_PF_INT_ALLOC        (SXE2_PF_INT_BASE + 0x0000)
+#define SXE2_PF_INT_ALLOC_FIRST  0x7FF
+#define SXE2_PF_INT_ALLOC_LAST_S 12
+#define SXE2_PF_INT_ALLOC_LAST \
+	(0x7FF << SXE2_PF_INT_ALLOC_LAST_S)
+#define SXE2_PF_INT_ALLOC_VALID BIT(31)
+
+#define SXE2_PF_INT_OICR                  (SXE2_PF_INT_BASE + 0x0040)
+#define SXE2_PF_INT_OICR_PCIE_TIMEOUT     BIT(0)
+#define SXE2_PF_INT_OICR_UR               BIT(1)
+#define SXE2_PF_INT_OICR_CA               BIT(2)
+#define SXE2_PF_INT_OICR_VFLR             BIT(3)
+#define SXE2_PF_INT_OICR_VFR_DONE         BIT(4)
+#define SXE2_PF_INT_OICR_LAN_TX_ERR       BIT(5)
+#define SXE2_PF_INT_OICR_BFDE             BIT(6)
+#define SXE2_PF_INT_OICR_LAN_RX_ERR       BIT(7)
+#define SXE2_PF_INT_OICR_ECC_ERR          BIT(8)
+#define SXE2_PF_INT_OICR_GPIO             BIT(9)
+#define SXE2_PF_INT_OICR_TSYN_TX          BIT(11)
+#define SXE2_PF_INT_OICR_TSYN_EVENT       BIT(12)
+#define SXE2_PF_INT_OICR_TSYN_TGT         BIT(13)
+#define SXE2_PF_INT_OICR_EXHAUST          BIT(14)
+#define SXE2_PF_INT_OICR_FW               BIT(15)
+#define SXE2_PF_INT_OICR_SWINT            BIT(16)
+#define SXE2_PF_INT_OICR_LINKSEC_CHG      BIT(17)
+#define SXE2_PF_INT_OICR_INT_CFG_ADDR_ERR BIT(18)
+#define SXE2_PF_INT_OICR_INT_CFG_DATA_ERR BIT(19)
+#define SXE2_PF_INT_OICR_INT_CFG_ADR_UNRANGE BIT(20)
+#define SXE2_PF_INT_OICR_INT_RAM_CONFLICT BIT(21)
+#define SXE2_PF_INT_OICR_GRST             BIT(22)
+#define SXE2_PF_INT_OICR_FWQ_INT          BIT(29)
+#define SXE2_PF_INT_OICR_FWQ_TOOL_INT     BIT(30)
+#define SXE2_PF_INT_OICR_MBXQ_INT         BIT(31)
+
+#define SXE2_PF_INT_OICR_ENABLE (SXE2_PF_INT_BASE + 0x0020)
+
+#define SXE2_PF_INT_FW_EVENT (SXE2_PF_INT_BASE + 0x0100)
+#define SXE2_PF_INT_FW_ABNORMAL BIT(0)
+#define SXE2_PF_INT_RDMA_AEQ_OVERFLOW BIT(1)
+#define SXE2_PF_INT_CGMAC_LINK_CHG BIT(18)
+#define SXE2_PF_INT_VFLR_DONE         BIT(2)
+
+#define SXE2_PF_INT_OICR_CTL           (SXE2_PF_INT_BASE + 0x0060)
+#define SXE2_PF_INT_OICR_CTL_MSIX_IDX  0x7FF
+#define SXE2_PF_INT_OICR_CTL_ITR_IDX_S 11
+#define SXE2_PF_INT_OICR_CTL_ITR_IDX \
+	(0x3 << SXE2_PF_INT_OICR_CTL_ITR_IDX_S)
+#define SXE2_PF_INT_OICR_CTL_CAUSE_ENABLE BIT(30)
+
+#define SXE2_PF_INT_FWQ_CTL           (SXE2_PF_INT_BASE + 0x00C0)
+#define SXE2_PF_INT_FWQ_CTL_MSIX_IDX  0x7FFF
+#define SXE2_PF_INT_FWQ_CTL_ITR_IDX_S 11
+#define SXE2_PF_INT_FWQ_CTL_ITR_IDX \
+	(0x3 << SXE2_PF_INT_FWQ_CTL_ITR_IDX_S)
+#define SXE2_PF_INT_FWQ_CTL_CAUSE_ENABLE BIT(30)
+
+#define SXE2_PF_INT_MBX_CTL           (SXE2_PF_INT_BASE + 0x00A0)
+#define SXE2_PF_INT_MBX_CTL_MSIX_IDX  0x7FF
+#define SXE2_PF_INT_MBX_CTL_ITR_IDX_S 11
+#define SXE2_PF_INT_MBX_CTL_ITR_IDX   (0x3 << SXE2_PF_INT_MBX_CTL_ITR_IDX_S)
+#define SXE2_PF_INT_MBX_CTL_CAUSE_ENABLE BIT(30)
+
+#define SXE2_PF_INT_GPIO_ENA      (SXE2_PF_INT_BASE + 0x0100)
+#define SXE2_PF_INT_GPIO_X_ENA(x) BIT(x)
+
+#define SXE2_PFG_INT_CTL               (SXE2_PF_INT_BASE + 0x0120)
+#define SXE2_PFG_INT_CTL_ITR_GRAN      0x7
+#define SXE2_PFG_INT_CTL_ITR_GRAN_0    (2)
+#define SXE2_PFG_INT_CTL_CREDIT_GRAN   BIT(4)
+#define SXE2_PFG_INT_CTL_CREDIT_GRAN_0 (4)
+#define SXE2_PFG_INT_CTL_CREDIT_GRAN_1 (8)
+
+#define SXE2_VFG_RAM_INIT_DONE \
+	(SXE2_PF_INT_BASE + 0x0128)
+#define SXE2_VFG_RAM_INIT_DONE_0 BIT(0)
+#define SXE2_VFG_RAM_INIT_DONE_1 BIT(1)
+#define SXE2_VFG_RAM_INIT_DONE_2 BIT(2)
+
+#define SXE2_LINK_REG_GET_10G_VALUE   4
+#define SXE2_LINK_REG_GET_25G_VALUE   1
+#define SXE2_LINK_REG_GET_50G_VALUE   2
+#define SXE2_LINK_REG_GET_100G_VALUE  3
+
+#define SXE2_PORT0_CNT 0
+#define SXE2_PORT1_CNT 1
+#define SXE2_PORT2_CNT 2
+#define SXE2_PORT3_CNT 3
+
+#define SXE2_LINK_STATUS_BASE		(0x002ac200)
+#define SXE2_LINK_STATUS_PORT0_POS		3
+#define SXE2_LINK_STATUS_PORT1_POS		11
+#define SXE2_LINK_STATUS_PORT2_POS		19
+#define SXE2_LINK_STATUS_PORT3_POS		27
+#define SXE2_LINK_STATUS_MASK			1
+
+#define SXE2_LINK_SPEED_BASE		(0x002ac200)
+#define SXE2_LINK_SPEED_PORT0_POS		0
+#define SXE2_LINK_SPEED_PORT1_POS		8
+#define SXE2_LINK_SPEED_PORT2_POS		16
+#define SXE2_LINK_SPEED_PORT3_POS		24
+#define SXE2_LINK_SPEED_MASK			7
+
+#define SXE2_PFVP_INT_ALLOC(vf_idx)        (SXE2_PF_INT_BASE + 0x012C + ((vf_idx) * 4))
+#define SXE2_PFVP_INT_ALLOC_FIRST_S  0
+
+#define SXE2_PFVP_INT_ALLOC_FIRST_M  (0x7FF << SXE2_PFVP_INT_ALLOC_FIRST_S)
+#define SXE2_PFVP_INT_ALLOC_LAST_S 12
+#define SXE2_PFVP_INT_ALLOC_LAST_M \
+	(0x7FF << SXE2_PFVP_INT_ALLOC_LAST_S)
+#define SXE2_PFVP_INT_ALLOC_VALID BIT(31)
+
+#define SXE2_PCI_PFVP_INT_ALLOC(vf_idx)  (SXE2_PCIEPROC_BASE + 0x5800 + ((vf_idx) * 4))
+#define SXE2_PCI_PFVP_INT_ALLOC_FIRST_S  0
+
+#define SXE2_PCI_PFVP_INT_ALLOC_FIRST_M  (0x7FF << SXE2_PCI_PFVP_INT_ALLOC_FIRST_S)
+#define SXE2_PCI_PFVP_INT_ALLOC_LAST_S 12
+
+#define SXE2_PCI_PFVP_INT_ALLOC_LAST_M \
+		(0x7FF << SXE2_PCI_PFVP_INT_ALLOC_LAST_S)
+#define SXE2_PCI_PFVP_INT_ALLOC_VALID BIT(31)
+
+#define SXE2_PCIEPROC_INT2FUNC(_INT)		   (SXE2_PCIEPROC_BASE + 0xe000 + ((_INT) * 4))
+#define SXE2_PCIEPROC_INT2FUNC_VF_NUM_S		0
+#define SXE2_PCIEPROC_INT2FUNC_VF_NUM_M		(0xFF << SXE2_PCIEPROC_INT2FUNC_VF_NUM_S)
+#define SXE2_PCIEPROC_INT2FUNC_PF_NUM_S		12
+#define SXE2_PCIEPROC_INT2FUNC_PF_NUM_M		(0x7 << SXE2_PCIEPROC_INT2FUNC_PF_NUM_S)
+#define SXE2_PCIEPROC_INT2FUNC_IS_PF_S       16
+#define SXE2_PCIEPROC_INT2FUNC_IS_PF_M       BIT(16)
+
+#define SXE2_VSI_PF(vf_idx)                (SXE2_PF_INT_BASE + 0x14000 + ((vf_idx) * 4))
+#define SXE2_VSI_PF_ID_S		   0
+#define SXE2_VSI_PF_ID_M		  (0x7 << SXE2_VSI_PF_ID_S)
+#define SXE2_VSI_PF_EN_M		  BIT(3)
+
+#define SXE2_MBX_CTL(_VSI)			(0x0026692C + ((_VSI) * 4))
+#define SXE2_MBX_CTL_MSIX_INDX_S		0
+#define SXE2_MBX_CTL_MSIX_INDX_M		(0x7FF << SXE2_MBX_CTL_MSIX_INDX_S)
+#define SXE2_MBX_CTL_CAUSE_ENA_M		BIT(30)
+
+#define SXE2_PF_INT_TQCTL(q_idx)    (SXE2_PF_INT_BASE + 0x092C + 4 * (q_idx))
+#define SXE2_PF_INT_TQCTL_MSIX_IDX  0x7FF
+#define SXE2_PF_INT_TQCTL_ITR_IDX_S 11
+#define SXE2_PF_INT_TQCTL_ITR_IDX \
+	(0x3 << SXE2_PF_INT_TQCTL_ITR_IDX_S)
+#define SXE2_PF_INT_TQCTL_CAUSE_ENABLE BIT(30)
+
+#define SXE2_PF_INT_RQCTL(q_idx)    (SXE2_PF_INT_BASE + 0x292C + 4 * (q_idx))
+#define SXE2_PF_INT_RQCTL_MSIX_IDX  0x7FF
+#define SXE2_PF_INT_RQCTL_ITR_IDX_S 11
+#define SXE2_PF_INT_RQCTL_ITR_IDX \
+	(0x3 << SXE2_PF_INT_RQCTL_ITR_IDX_S)
+#define SXE2_PF_INT_RQCTL_CAUSE_ENABLE BIT(30)
+
+#define SXE2_PF_INT_RATE(irq_idx)        (SXE2_PF_INT_BASE + 0x7530 + 4 * (irq_idx))
+#define SXE2_PF_INT_RATE_CREDIT_INTERVAL (0x3F)
+#define SXE2_PF_INT_RATE_CREDIT_INTERVAL_MAX \
+	(0x3F)
+#define SXE2_PF_INT_RATE_INTRL_ENABLE           (BIT(6))
+#define SXE2_PF_INT_RATE_CREDIT_MAX_VALUE_SHIFT (7)
+#define SXE2_PF_INT_RATE_CREDIT_MAX_VALUE \
+	(0x3F << SXE2_PF_INT_RATE_CREDIT_MAX_VALUE_SHIFT)
+
+#define SXE2_VF_INT_ITR(itr_idx, irq_idx) \
+	(SXE2_PF_INT_BASE + 0xB530 + 0x2000 * (itr_idx) + 4 * (irq_idx))
+#define SXE2_VF_INT_ITR_INTERVAL 0xFFF
+
+#define SXE2_VF_DYN_CTL(irq_idx)   (SXE2_PF_INT_BASE + 0x9530 + 4 * (irq_idx))
+#define SXE2_VF_DYN_CTL_INTENABLE     BIT(0)
+#define SXE2_VF_DYN_CTL_CLEARPBA   BIT(1)
+#define SXE2_VF_DYN_CTL_SWINT_TRIG BIT(2)
+#define SXE2_VF_DYN_CTL_ITR_IDX_S \
+	3
+#define SXE2_VF_DYN_CTL_ITR_IDX_M      0x3
+#define SXE2_VF_DYN_CTL_INTERVAL_S     5
+#define SXE2_VF_DYN_CTL_INTERVAL_M     0xFFF
+#define SXE2_VF_DYN_CTL_SW_ITR_IDX_ENABLE BIT(24)
+#define SXE2_VF_DYN_CTL_SW_ITR_IDX_S   25
+#define SXE2_VF_DYN_CTL_SW_ITR_IDX_M   0x3
+
+#define SXE2_VF_DYN_CTL_INTENABLE_MSK \
+	BIT(31)
+
+#define SXE2_BAR4_MSIX_BASE 0
+#define SXE2_BAR4_MSIX_CTL(_idx) (SXE2_BAR4_MSIX_BASE + 0xC + ((_idx) * 0x10))
+#define SXE2_BAR4_MSIX_ENABLE 0
+#define SXE2_BAR4_MSIX_DISABLE 1
+
+#define SXE2_TXQ_LEGACY_DBLL(_DBQM)	(0x1000 + ((_DBQM) * 4))
+
+#define SXE2_TXQ_CONTEXT0(_pfIdx)	(0x10040 + ((_pfIdx) * 0x100))
+#define SXE2_TXQ_CONTEXT1(_pfIdx)	(0x10044 + ((_pfIdx) * 0x100))
+#define SXE2_TXQ_CONTEXT2(_pfIdx)	(0x10048 + ((_pfIdx) * 0x100))
+#define SXE2_TXQ_CONTEXT3(_pfIdx)	(0x1004C + ((_pfIdx) * 0x100))
+#define SXE2_TXQ_CONTEXT4(_pfIdx)	(0x10050 + ((_pfIdx) * 0x100))
+#define SXE2_TXQ_CONTEXT7(_pfIdx)	(0x1005C + ((_pfIdx) * 0x100))
+#define SXE2_TXQ_CONTEXT7_HEAD_S      0
+#define SXE2_TXQ_CONTEXT7_HEAD_M      SXE2_BITS_MASK(0xFFF, SXE2_TXQ_CONTEXT7_HEAD_S)
+#define SXE2_TXQ_CONTEXT7_READ_HEAD_S 16
+#define SXE2_TXQ_CONTEXT7_READ_HEAD_M SXE2_BITS_MASK(0xFFF, SXE2_TXQ_CONTEXT7_READ_HEAD_S)
+
+#define SXE2_TXQ_CTRL(_pfIdx)          (0x10064 + ((_pfIdx) * 0x100))
+#define SXE2_TXQ_CTXT_CTRL(_pfIdx)     (0x100C8 + ((_pfIdx) * 0x100))
+#define SXE2_TXQ_DIS_CNT(_pfIdx)       (0x100D0 + ((_pfIdx) * 0x100))
+
+#define SXE2_TXQ_CTXT_CTRL_USED_MASK   0x00000800
+#define SXE2_TXQ_CTRL_SW_EN_M		BIT(0)
+#define SXE2_TXQ_CTRL_HW_EN_M		BIT(1)
+
+#define	SXE2_TXQ_CTXT2_PROT_IDX_S	0
+#define	SXE2_TXQ_CTXT2_PROT_IDX_M	SXE2_BITS_MASK(0x7, 0)
+#define	SXE2_TXQ_CTXT2_CGD_IDX_S	4
+#define	SXE2_TXQ_CTXT2_CGD_IDX_M	SXE2_BITS_MASK(0x1F, 4)
+#define	SXE2_TXQ_CTXT2_PF_IDX_S	9
+#define	SXE2_TXQ_CTXT2_PF_IDX_M	SXE2_BITS_MASK(0x7, 9)
+#define	SXE2_TXQ_CTXT2_VMVF_IDX_S	12
+#define	SXE2_TXQ_CTXT2_VMVF_IDX_M	SXE2_BITS_MASK(0x3FF, 12)
+#define	SXE2_TXQ_CTXT2_VMVF_TYPE_S	23
+#define	SXE2_TXQ_CTXT2_VMVF_TYPE_M	SXE2_BITS_MASK(0x3, 23)
+#define	SXE2_TXQ_CTXT2_TSYN_ENA_S	25
+#define	SXE2_TXQ_CTXT2_TSYN_ENA_M	BIT(25)
+#define	SXE2_TXQ_CTXT2_ALT_VLAN_S	26
+#define	SXE2_TXQ_CTXT2_ALT_VLAN_M	BIT(26)
+#define	SXE2_TXQ_CTXT2_WB_MODE_S	27
+#define	SXE2_TXQ_CTXT2_WB_MODE_M	BIT(27)
+#define	SXE2_TXQ_CTXT2_ITR_WB_S	28
+#define	SXE2_TXQ_CTXT2_ITR_WB_M	BIT(28)
+#define	SXE2_TXQ_CTXT2_LEGACY_EN_S	29
+#define	SXE2_TXQ_CTXT2_LEGACY_EN_M	BIT(29)
+#define	SXE2_TXQ_CTXT2_SSO_EN_S	30
+#define	SXE2_TXQ_CTXT2_SSO_EN_M	BIT(30)
+
+#define	SXE2_TXQ_CTXT3_SRC_VSI_S	0
+#define	SXE2_TXQ_CTXT3_SRC_VSI_M	SXE2_BITS_MASK(0x3FF, 0)
+#define	SXE2_TXQ_CTXT3_CPU_ID_S	12
+#define	SXE2_TXQ_CTXT3_CPU_ID_M	SXE2_BITS_MASK(0xFF, 12)
+#define	SXE2_TXQ_CTXT3_TPH_RDDESC_S	20
+#define	SXE2_TXQ_CTXT3_TPH_RDDESC_M	BIT(20)
+#define	SXE2_TXQ_CTXT3_TPH_RDDATA_S	21
+#define	SXE2_TXQ_CTXT3_TPH_RDDATA_M	BIT(21)
+#define	SXE2_TXQ_CTXT3_TPH_WRDESC_S	22
+#define	SXE2_TXQ_CTXT3_TPH_WRDESC_M	BIT(22)
+
+#define	SXE2_TXQ_CTXT3_QID_IN_FUNC_S	0
+#define	SXE2_TXQ_CTXT3_QID_IN_FUNC_M	SXE2_BITS_MASK(0x7FF, 0)
+#define	SXE2_TXQ_CTXT3_RDDESC_RO_S	13
+#define	SXE2_TXQ_CTXT3_RDDESC_RO_M	BIT(13)
+#define	SXE2_TXQ_CTXT3_WRDESC_RO_S	14
+#define	SXE2_TXQ_CTXT3_WRDESC_RO_M	BIT(14)
+#define	SXE2_TXQ_CTXT3_RDDATA_RO_S	15
+#define	SXE2_TXQ_CTXT3_RDDATA_RO_M	BIT(15)
+#define	SXE2_TXQ_CTXT3_QLEN_S		16
+#define	SXE2_TXQ_CTXT3_QLEN_M		SXE2_BITS_MASK(0x1FFF, 16)
+
+#define SXE2_RX_BUF_CHAINED_MAX        10
+#define SXE2_RX_DESC_BASE_ADDR_UNIT    7
+#define SXE2_RX_HBUF_LEN_UNIT          6
+#define SXE2_RX_DBUF_LEN_UNIT          7
+#define SXE2_RX_DBUF_LEN_MASK          (~0x7F)
+#define SXE2_RX_HWTAIL_VALUE_MASK      (~0x7)
+
+enum {
+	SXE2_RX_CTXT0 = 0,
+	SXE2_RX_CTXT1,
+	SXE2_RX_CTXT2,
+	SXE2_RX_CTXT3,
+	SXE2_RX_CTXT4,
+	SXE2_RX_CTXT_CNT,
+};
+
+#define SXE2_RX_CTXT_BASE_L_S                 0
+#define SXE2_RX_CTXT_BASE_L_W                 32
+
+#define SXE2_RX_CTXT_BASE_H_S                 0
+#define SXE2_RX_CTXT_BASE_H_W                 25
+#define SXE2_RX_CTXT_DEPTH_L_S                25
+#define SXE2_RX_CTXT_DEPTH_L_W		       7
+
+#define SXE2_RX_CTXT_DEPTH_H_S                0
+#define SXE2_RX_CTXT_DEPTH_H_W		       6
+
+#define SXE2_RX_CTXT_DBUFF_S                  6
+#define SXE2_RX_CTXT_DBUFF_W                  7
+
+#define SXE2_RX_CTXT_HBUFF_S                  13
+#define SXE2_RX_CTXT_HBUFF_W                  5
+
+#define SXE2_RX_CTXT_HSPLT_TYPE_S             18
+#define SXE2_RX_CTXT_HSPLT_TYPE_W             2
+
+#define SXE2_RX_CTXT_DESC_TYPE_S              20
+#define SXE2_RX_CTXT_DESC_TYPE_W              1
+
+#define SXE2_RX_CTXT_CRC_S                    21
+#define SXE2_RX_CTXT_CRC_W                    1
+
+#define SXE2_RX_CTXT_L2TAG_FLAG_S             23
+#define SXE2_RX_CTXT_L2TAG_FLAG_W             1
+
+#define SXE2_RX_CTXT_HSPLT_0_S                24
+#define SXE2_RX_CTXT_HSPLT_0_W                4
+
+#define SXE2_RX_CTXT_HSPLT_1_S                28
+#define SXE2_RX_CTXT_HSPLT_1_W                2
+
+#define SXE2_RX_CTXT_INVALN_STP_S             31
+#define SXE2_RX_CTXT_INVALN_STP_W             1
+
+#define SXE2_RX_CTXT_LRO_ENABLE_S             0
+#define SXE2_RX_CTXT_LRO_ENABLE_W             1
+
+#define SXE2_RX_CTXT_CPUID_S                  3
+#define SXE2_RX_CTXT_CPUID_W                  8
+
+#define SXE2_RX_CTXT_MAX_FRAME_SIZE_S         11
+#define SXE2_RX_CTXT_MAX_FRAME_SIZE_W         14
+
+#define SXE2_RX_CTXT_LRO_DESC_MAX_S           25
+#define SXE2_RX_CTXT_LRO_DESC_MAX_W           4
+
+#define SXE2_RX_CTXT_RELAX_DATA_S             29
+#define SXE2_RX_CTXT_RELAX_DATA_W             1
+
+#define SXE2_RX_CTXT_RELAX_WB_S               30
+#define SXE2_RX_CTXT_RELAX_WB_W               1
+
+#define SXE2_RX_CTXT_RELAX_RD_S               31
+#define SXE2_RX_CTXT_RELAX_RD_W               1
+
+#define SXE2_RX_CTXT_THPRDESC_ENABLE_S        1
+#define SXE2_RX_CTXT_THPRDESC_ENABLE_W        1
+
+#define SXE2_RX_CTXT_THPWDESC_ENABLE_S        2
+#define SXE2_RX_CTXT_THPWDESC_ENABLE_W        1
+
+#define SXE2_RX_CTXT_THPRDATA_ENABLE_S        3
+#define SXE2_RX_CTXT_THPRDATA_ENABLE_W        1
+
+#define SXE2_RX_CTXT_THPHEAD_ENABLE_S         4
+#define SXE2_RX_CTXT_THPHEAD_ENABLE_W         1
+
+#define SXE2_RX_CTXT_LOW_DESC_LINE_S          6
+#define SXE2_RX_CTXT_LOW_DESC_LINE_W          3
+
+#define SXE2_RX_CTXT_VF_ID_S                  9
+#define SXE2_RX_CTXT_VF_ID_W                  8
+
+#define SXE2_RX_CTXT_PF_ID_S                  17
+#define SXE2_RX_CTXT_PF_ID_W                  3
+
+#define SXE2_RX_CTXT_VF_ENABLE_S              20
+#define SXE2_RX_CTXT_VF_ENABLE_W              1
+
+#define SXE2_RX_CTXT_VSI_ID_S                 21
+#define SXE2_RX_CTXT_VSI_ID_W                 10
+
+#define SXE2_PF_CTRLQ_FW_BASE      0x00312000
+#define SXE2_PF_CTRLQ_FW_ATQBAL (SXE2_PF_CTRLQ_FW_BASE + 0x0000)
+#define SXE2_PF_CTRLQ_FW_ARQBAL (SXE2_PF_CTRLQ_FW_BASE + 0x0080)
+#define SXE2_PF_CTRLQ_FW_ATQBAH (SXE2_PF_CTRLQ_FW_BASE + 0x0100)
+#define SXE2_PF_CTRLQ_FW_ARQBAH (SXE2_PF_CTRLQ_FW_BASE + 0x0180)
+#define SXE2_PF_CTRLQ_FW_ATQLEN (SXE2_PF_CTRLQ_FW_BASE + 0x0200)
+#define SXE2_PF_CTRLQ_FW_ARQLEN (SXE2_PF_CTRLQ_FW_BASE + 0x0280)
+#define SXE2_PF_CTRLQ_FW_ATQH   (SXE2_PF_CTRLQ_FW_BASE + 0x0300)
+#define SXE2_PF_CTRLQ_FW_ARQH   (SXE2_PF_CTRLQ_FW_BASE + 0x0380)
+#define SXE2_PF_CTRLQ_FW_ATQT   (SXE2_PF_CTRLQ_FW_BASE + 0x0400)
+#define SXE2_PF_CTRLQ_FW_ARQT   (SXE2_PF_CTRLQ_FW_BASE + 0x0480)
+
+#define SXE2_PF_CTRLQ_MBX_BASE      0x00316000
+#define SXE2_PF_CTRLQ_MBX_ATQBAL (SXE2_PF_CTRLQ_MBX_BASE + 0xE100)
+#define SXE2_PF_CTRLQ_MBX_ATQBAH (SXE2_PF_CTRLQ_MBX_BASE + 0xE180)
+#define SXE2_PF_CTRLQ_MBX_ATQLEN (SXE2_PF_CTRLQ_MBX_BASE + 0xE200)
+#define SXE2_PF_CTRLQ_MBX_ATQH   (SXE2_PF_CTRLQ_MBX_BASE + 0xE280)
+#define SXE2_PF_CTRLQ_MBX_ATQT   (SXE2_PF_CTRLQ_MBX_BASE + 0xE300)
+#define SXE2_PF_CTRLQ_MBX_ARQBAL (SXE2_PF_CTRLQ_MBX_BASE + 0xE380)
+#define SXE2_PF_CTRLQ_MBX_ARQBAH (SXE2_PF_CTRLQ_MBX_BASE + 0xE400)
+#define SXE2_PF_CTRLQ_MBX_ARQLEN (SXE2_PF_CTRLQ_MBX_BASE + 0xE480)
+#define SXE2_PF_CTRLQ_MBX_ARQH   (SXE2_PF_CTRLQ_MBX_BASE + 0xE500)
+#define SXE2_PF_CTRLQ_MBX_ARQT   (SXE2_PF_CTRLQ_MBX_BASE + 0xE580)
+
+#define SXE2_CMD_REG_LEN_M      0x3FF
+#define SXE2_CMD_REG_LEN_VFE_M  BIT(28)
+#define SXE2_CMD_REG_LEN_OVFL_M BIT(29)
+#define SXE2_CMD_REG_LEN_CRIT_M BIT(30)
+#define SXE2_CMD_REG_LEN_ENABLE_M  BIT(31)
+
+#define SXE2_CMD_REG_HEAD_M     0x3FF
+
+#define SXE2_PF_CTRLQ_FW_HW_STS (SXE2_PF_CTRLQ_FW_BASE + 0x0500)
+#define SXE2_PF_CTRLQ_FW_ATQ_IDLE_MASK BIT(0)
+#define SXE2_PF_CTRLQ_FW_ARQ_IDLE_MASK BIT(1)
+
+#define SXE2_TOP_CFG_BASE      0x00292000
+#define SXE2_HW_VER (SXE2_TOP_CFG_BASE + 0x48c)
+#define	SXE2_HW_FPGA_VER_M	SXE2_BITS_MASK(0xFFF, 0)
+
+#define SXE2_FW_VER (SXE2_TOP_CFG_BASE + 0x214)
+#define	SXE2_FW_VER_BUILD_M	SXE2_BITS_MASK(0xFF, 0)
+#define	SXE2_FW_VER_FIX_M	SXE2_BITS_MASK(0xFF, 8)
+#define	SXE2_FW_VER_SUB_M	SXE2_BITS_MASK(0xFF, 16)
+#define	SXE2_FW_VER_MAIN_M	SXE2_BITS_MASK(0xFF, 24)
+#define	SXE2_FW_VER_FIX_SHIFT	(8)
+#define	SXE2_FW_VER_SUB_SHIFT	(16)
+#define	SXE2_FW_VER_MAIN_SHIFT	(24)
+
+#define SXE2_FW_COMP_VER_ADDR (SXE2_TOP_CFG_BASE + 0x20c)
+
+#define SXE2_STATUS SXE2_FW_VER
+
+#define SXE2_FW_STATE     (SXE2_TOP_CFG_BASE + 0x210)
+
+#define SXE2_FW_HEARTBEAT (SXE2_TOP_CFG_BASE + 0x218)
+
+#define SXE2_FW_MISC (SXE2_TOP_CFG_BASE + 0x21c)
+#define	SXE2_FW_MISC_MODE_M	SXE2_BITS_MASK(0xF, 0)
+#define	SXE2_FW_MISC_POP_M	SXE2_BITS_MASK(0x80000000, 0)
+
+#define SXE2_TX_OE_BASE		0x00030000
+#define SXE2_RX_OE_BASE		0x00050000
+
+#define SXE2_PFP_L2TAGSEN(_i)	(SXE2_TX_OE_BASE + 0x00300 + ((_i) * 4))
+#define SXE2_VSI_L2TAGSTXVALID(_i)	\
+	(SXE2_TX_OE_BASE + 0x01000 + ((_i) * 4))
+#define SXE2_VSI_TIR0(_i)		(SXE2_TX_OE_BASE + 0x01C00 + ((_i) * 4))
+#define SXE2_VSI_TIR1(_i)		(SXE2_TX_OE_BASE + 0x02800 + ((_i) * 4))
+#define SXE2_VSI_TAR(_i)		(SXE2_TX_OE_BASE + 0x04C00 + ((_i) * 4))
+#define SXE2_VSI_TSR(_i)		(SXE2_RX_OE_BASE + 0x18000 + ((_i) * 4))
+
+#define SXE2_STATS_TX_LAN_CONFIG(_i)			(SXE2_TX_OE_BASE + 0x08300 + ((_i) * 4))
+#define SXE2_STATS_TX_LAN_PKT_CNT_GET(_i)		(SXE2_TX_OE_BASE + 0x08340 + ((_i) * 4))
+#define SXE2_STATS_TX_LAN_BYTE_CNT_GET(_i)		(SXE2_TX_OE_BASE + 0x08380 + ((_i) * 4))
+
+#define SXE2_STATS_RX_CONFIG(_i)	(SXE2_RX_OE_BASE + 0x230B0 + ((_i) * 4))
+#define SXE2_STATS_RX_LAN_PKT_CNT_GET(_i)	(SXE2_RX_OE_BASE + 0x230C0 + ((_i) * 8))
+#define SXE2_STATS_RX_LAN_BYTE_CNT_GET(_i)	(SXE2_RX_OE_BASE + 0x23120 + ((_i) * 8))
+#define SXE2_STATS_RX_FD_PKT_CNT_GET(_i)	(SXE2_RX_OE_BASE + 0x230E0 + ((_i) * 8))
+#define SXE2_STATS_RX_MNG_IN_PKT_CNT_GET(_i)	(SXE2_RX_OE_BASE + 0x23100 + ((_i) * 8))
+#define SXE2_STATS_RX_MNG_IN_BYTE_CNT_GET(_i)	(SXE2_RX_OE_BASE + 0x23140 + ((_i) * 8))
+#define SXE2_STATS_RX_MNG_OUT_PKT_CNT_GET(_i)	(SXE2_RX_OE_BASE + 0x23160 + ((_i) * 8))
+
+#define SXE2_L2TAG_ID_STAG		0
+#define SXE2_L2TAG_ID_OUT_VLAN1	1
+#define SXE2_L2TAG_ID_OUT_VLAN2	2
+#define SXE2_L2TAG_ID_VLAN		3
+
+#define SXE2_PFP_L2TAGSEN_ALL_TAG	0xFF
+#define SXE2_PFP_L2TAGSEN_DVM		BIT(10)
+
+#define SXE2_VSI_TSR_STRIP_TAG_S	0
+#define SXE2_VSI_TSR_SHOW_TAG_S	4
+
+#define SXE2_VSI_TSR_ID_STAG		BIT(0)
+#define SXE2_VSI_TSR_ID_OUT_VLAN1	BIT(1)
+#define SXE2_VSI_TSR_ID_OUT_VLAN2	BIT(2)
+#define SXE2_VSI_TSR_ID_VLAN		BIT(3)
+
+#define SXE2_VSI_L2TAGSTXVALID_L2TAG1_ID_S	0
+#define SXE2_VSI_L2TAGSTXVALID_L2TAG1_ID_M	0x7
+#define SXE2_VSI_L2TAGSTXVALID_L2TAG1_VALID	BIT(3)
+#define SXE2_VSI_L2TAGSTXVALID_L2TAG2_ID_S	4
+#define SXE2_VSI_L2TAGSTXVALID_L2TAG2_ID_M	0x7
+#define SXE2_VSI_L2TAGSTXVALID_L2TAG2_VALID	BIT(7)
+#define SXE2_VSI_L2TAGSTXVALID_TIR0_ID_S	16
+#define SXE2_VSI_L2TAGSTXVALID_TIR0_VALID	BIT(19)
+#define SXE2_VSI_L2TAGSTXVALID_TIR1_ID_S	20
+#define SXE2_VSI_L2TAGSTXVALID_TIR1_VALID	BIT(23)
+
+#define SXE2_VSI_L2TAGSTXVALID_ID_STAG		0
+#define SXE2_VSI_L2TAGSTXVALID_ID_OUT_VLAN1	2
+#define SXE2_VSI_L2TAGSTXVALID_ID_OUT_VLAN2	3
+#define SXE2_VSI_L2TAGSTXVALID_ID_VLAN		4
+
+#define SXE2_SWITCH_OG_BASE		0x00140000
+#define SXE2_SWITCH_SWE_BASE		0x00150000
+#define SXE2_SWITCH_RG_BASE		0x00160000
+
+#define SXE2_VSI_RX_SWITCH_CTRL(_i)	(SXE2_SWITCH_RG_BASE + 0x01074 + ((_i) * 4))
+#define SXE2_VSI_TX_SWITCH_CTRL(_i)	(SXE2_SWITCH_RG_BASE + 0x01C74 + ((_i) * 4))
+
+#define SXE2_VSI_RX_SW_CTRL_VLAN_PRUNE	BIT(9)
+
+#define SXE2_VSI_TX_SW_CTRL_LOOPBACK_EN	BIT(1)
+#define SXE2_VSI_TX_SW_CTRL_LAN_EN		BIT(2)
+#define SXE2_VSI_TX_SW_CTRL_MACAS_EN		BIT(3)
+#define SXE2_VSI_TX_SW_CTRL_VLAN_PRUNE		BIT(9)
+
+#define SXE2_VSI_TAR_UNTAGGED_SHIFT		(16)
+
+#define SXE2_PCIE_SYS_READY                    0x38c
+#define SXE2_PCIE_SYS_READY_CORER_ASSERT       BIT(0)
+#define SXE2_PCIE_SYS_READY_STOP_DROP_DONE     BIT(2)
+#define SXE2_PCIE_SYS_READY_R5                 BIT(3)
+#define SXE2_PCIE_SYS_READY_STOP_DROP          BIT(16)
+
+#define SXE2_PCIE_DEV_CTRL_DEV_STATUS               0x78
+#define SXE2_PCIE_DEV_CTRL_DEV_STATUS_TRANS_PENDING BIT(21)
+
+#define SXE2_TOP_CFG_CORE            (SXE2_TOP_CFG_BASE + 0x0630)
+#define SXE2_TOP_CFG_CORE_RST_CODE   0x09FBD586
+
+#define SXE2_PFGEN_CTRL       (0x00336000)
+#define SXE2_PFGEN_CTRL_PFSWR BIT(0)
+
+#define SXE2_VFGEN_CTRL(_vf)       (0x00337000 + ((_vf) * 4))
+#define SXE2_VFGEN_CTRL_VFSWR      BIT(0)
+
+#define SXE2_VF_VRC_VFGEN_RSTAT(_vf)        (0x00338000 + (_vf)*4)
+#define SXE2_VF_VRC_VFGEN_VFRSTAT           (0x3)
+#define SXE2_VF_VRC_VFGEN_VFRSTAT_VFR       (0)
+#define SXE2_VF_VRC_VFGEN_VFRSTAT_COMPLETE  (BIT(0))
+#define SXE2_VF_VRC_VFGEN_VFRSTAT_VF_ACTIVE (BIT(1))
+#define SXE2_VF_VRC_VFGEN_VFRSTAT_MASK (BIT(2))
+#define SXE2_VF_VRC_VFGEN_VFRSTAT_FORVF (0x300)
+#define SXE2_VF_VRC_VFGEN_VFRSTAT_FORVF_NO_VFR (0)
+#define SXE2_VF_VRC_VFGEN_VFRSTAT_FORVF_VFR (1)
+#define SXE2_VF_VRC_VFGEN_VFRSTAT_FORVF_MASK (BIT(10))
+
+#define SXE2_GLGEN_VFLRSTAT(_reg) (0x0033A000 + ((_reg)*4))
+
+#define SXE2_ACCEPT_RULE_TAGGED_S      0
+#define SXE2_ACCEPT_RULE_UNTAGGED_S    16
+
+#define SXE2_VF_RXQ_BASE(_VF)			(0x000b0800 + ((_VF) * 4))
+#define SXE2_VF_RXQ_BASE_FIRST_Q_S		0
+#define SXE2_VF_RXQ_BASE_FIRST_Q_M		(0x7FF << SXE2_VF_RXQ_BASE_FIRST_Q_S)
+#define SXE2_VF_RXQ_BASE_Q_NUM_S		16
+#define SXE2_VF_RXQ_BASE_Q_NUM_M		(0x7FF << SXE2_VF_RXQ_BASE_Q_NUM_S)
+
+#define SXE2_VF_RXQ_MAPENA(_VF)		(0x000b0400 + ((_VF) * 4))
+#define SXE2_VF_RXQ_MAPENA_M		        BIT(0)
+
+#define SXE2_VF_TXQ_BASE(_VF)			(0x00040400 + ((_VF) * 4))
+#define SXE2_VF_TXQ_BASE_FIRST_Q_S		0
+#define SXE2_VF_TXQ_BASE_FIRST_Q_M		(0x3FFF << SXE2_VF_TXQ_BASE_FIRST_Q_S)
+#define SXE2_VF_TXQ_BASE_Q_NUM_S		16
+#define SXE2_VF_TXQ_BASE_Q_NUM_M		(0xFF << SXE2_VF_TXQ_BASE_Q_NUM_S)
+
+#define SXE2_VF_TXQ_MAPENA(_VF)		(0x00045000 + ((_VF) * 4))
+#define SXE2_VF_TXQ_MAPENA_M		        BIT(0)
+
+#define PRI_PTP_BASEADDR 0x2a8000
+
+#define GLTSYN (PRI_PTP_BASEADDR + 0x0)
+#define GLTSYN_ENA_M BIT(0)
+
+#define GLTSYN_CMD (PRI_PTP_BASEADDR + 0x4)
+#define GLTSYN_CMD_INIT_TIME 0x01
+#define GLTSYN_CMD_INIT_INCVAL 0x02
+#define GLTSYN_CMD_ADJ_TIME 0x04
+#define GLTSYN_CMD_ADJ_TIME_AT_TIME 0x0C
+#define GLTSYN_CMD_LATCHING_SHTIME 0x80
+
+#define GLTSYN_SYNC (PRI_PTP_BASEADDR + 0x8)
+#define GLTSYN_SYNC_PLUS_1NS 0x1
+#define GLTSYN_SYNC_MINUS_1NS 0x2
+#define GLTSYN_SYNC_EXEC 0x3
+#define GLTSYN_SYNC_GEN_PULSE 0x4
+
+#define GLTSYN_SEM (PRI_PTP_BASEADDR + 0xC)
+#define GLTSYN_SEM_BUSY_M BIT(0)
+
+#define GLTSYN_STAT (PRI_PTP_BASEADDR + 0x10)
+#define GLTSYN_STAT_EVENT0_M			BIT(0)
+#define GLTSYN_STAT_EVENT1_M			BIT(1)
+#define GLTSYN_STAT_EVENT2_M			BIT(2)
+
+#define GLTSYN_TIME_SUBNS (PRI_PTP_BASEADDR + 0x20)
+#define GLTSYN_TIME_NS (PRI_PTP_BASEADDR + 0x24)
+#define GLTSYN_TIME_S_H (PRI_PTP_BASEADDR + 0x28)
+#define GLTSYN_TIME_S_L (PRI_PTP_BASEADDR + 0x2C)
+
+#define GLTSYN_SHTIME_SUBNS (PRI_PTP_BASEADDR + 0x30)
+#define GLTSYN_SHTIME_NS (PRI_PTP_BASEADDR + 0x34)
+#define GLTSYN_SHTIME_S_H (PRI_PTP_BASEADDR + 0x38)
+#define GLTSYN_SHTIME_S_L (PRI_PTP_BASEADDR + 0x3C)
+
+#define GLTSYN_SHADJ_SUBNS (PRI_PTP_BASEADDR + 0x40)
+#define GLTSYN_SHADJ_NS (PRI_PTP_BASEADDR + 0x44)
+
+#define GLTSYN_INCVAL_NS (PRI_PTP_BASEADDR + 0x50)
+#define GLTSYN_INCVAL_SUBNS (PRI_PTP_BASEADDR + 0x54)
+
+#define GLTSYN_TGT_NS(_i) \
+	(PRI_PTP_BASEADDR + 0x60 + ((_i) * 16))
+#define GLTSYN_TGT_S_H(_i) (PRI_PTP_BASEADDR + 0x64 + ((_i) * 16))
+#define GLTSYN_TGT_S_L(_i) (PRI_PTP_BASEADDR + 0x68 + ((_i) * 16))
+
+#define GLTSYN_EVENT_NS(_i) \
+	(PRI_PTP_BASEADDR + 0xA0 + ((_i) * 16))
+
+#define GLTSYN_EVENT_S_H(_i) (PRI_PTP_BASEADDR + 0xA4 + ((_i) * 16))
+#define GLTSYN_EVENT_S_H_MASK (0xFFFF)
+
+#define GLTSYN_EVENT_S_L(_i) (PRI_PTP_BASEADDR + 0xA8 + ((_i) * 16))
+
+#define GLTSYN_AUXOUT(_i) \
+	(PRI_PTP_BASEADDR + 0xD0 + ((_i) * 4))
+#define GLTSYN_AUXOUT_OUT_ENA BIT(0)
+#define GLTSYN_AUXOUT_OUT_MOD (0x03 << 1)
+#define GLTSYN_AUXOUT_OUTLVL BIT(3)
+#define GLTSYN_AUXOUT_INT_ENA BIT(4)
+#define GLTSYN_AUXOUT_PULSEW (0x1fff << 3)
+
+#define GLTSYN_CLKO(_i) \
+	(PRI_PTP_BASEADDR + 0xE0 + ((_i) * 4))
+
+#define GLTSYN_AUXIN(_i) (PRI_PTP_BASEADDR + 0xF4 + ((_i) * 4))
+#define GLTSYN_AUXIN_RISING_EDGE BIT(0)
+#define GLTSYN_AUXIN_FALLING_EDGE BIT(1)
+#define GLTSYN_AUXIN_ENABLE BIT(4)
+
+#define CGMAC_CSR_BASE 0x2B4000
+
+#define CGMAC_PORT_OFFSET         0x00004000
+
+#define PFP_CGM_TX_TSMEM(_port, _i)        \
+	(CGMAC_CSR_BASE + 0x100 + \
+	 + CGMAC_PORT_OFFSET * _port + ((_i) * 4))
+
+#define PFP_CGM_TX_TXHI(_port, _i) (CGMAC_CSR_BASE + CGMAC_PORT_OFFSET * _port + 0x108 + ((_i) * 8))
+#define PFP_CGM_TX_TXLO(_port, _i) (CGMAC_CSR_BASE + CGMAC_PORT_OFFSET * _port + 0x10C + ((_i) * 8))
+
+#define CGMAC_CSR_MAC0_OFFSET 0x2B4000
+#define CGMAC_CSR_MAC_OFFSET(_i) (CGMAC_CSR_MAC0_OFFSET + ((_i) * 0x4000))
+
+#define PFP_CGM_MAC_TX_TSMEM(_phy, _i)        \
+	(CGMAC_CSR_MAC_OFFSET(_phy) + 0x100 + \
+	 ((_i) * 4))
+
+#define PFP_CGM_MAC_TX_TXHI(_phy, _i) (CGMAC_CSR_MAC_OFFSET(_phy) + 0x108 + ((_i) * 8))
+#define PFP_CGM_MAC_TX_TXLO(_phy, _i) (CGMAC_CSR_MAC_OFFSET(_phy) + 0x10C + ((_i) * 8))
+
+#define SXE2_VF_GLINT_CEQCTL_MSIX_INDX_M	SXE2_BITS_MASK(0x7FF, 0)
+#define SXE2_VF_GLINT_CEQCTL_ITR_INDX_S	11
+#define SXE2_VF_GLINT_CEQCTL_ITR_INDX_M	SXE2_BITS_MASK(0x3, 11)
+#define SXE2_VF_GLINT_CEQCTL_CAUSE_ENA_M	BIT(30)
+#define SXE2_VF_GLINT_CEQCTL(_INT)			(0x0026492C + ((_INT) * 4))
+
+#define SXE2_VF_PFINT_AEQCTL_MSIX_INDX_M	SXE2_BITS_MASK(0x7FF, 0)
+#define SXE2_VF_VPINT_AEQCTL_ITR_INDX_S	11
+#define SXE2_VF_VPINT_AEQCTL_ITR_INDX_M	SXE2_BITS_MASK(0x3, 11)
+#define SXE2_VF_VPINT_AEQCTL_CAUSE_ENA_M	BIT(30)
+#define SXE2_VF_VPINT_AEQCTL(_VF)			(0x0026052c + ((_VF) * 4))
+
+#define SXE2_IPSEC_TX_BASE (0x2A0000)
+#define SXE2_IPSEC_RX_BASE (0x2A2000)
+
+#define SXE2_IPSEC_RX_IPSIDX_ADDR (SXE2_IPSEC_RX_BASE + 0x0084)
+#define SXE2_IPSEC_RX_IPSIDX_RST (0x00040000)
+#define SXE2_IPSEC_RX_IPSIDX_VBI_SHIFT (18)
+#define SXE2_IPSEC_RX_IPSIDX_VBI_MASK (0x00040000)
+#define SXE2_IPSEC_RX_IPSIDX_SWRITE_SHIFT (17)
+#define SXE2_IPSEC_RX_IPSIDX_SWRITE_MASK (0x00020000)
+#define SXE2_IPSEC_RX_IPSIDX_SA_IDX_SHIFT (4)
+#define SXE2_IPSEC_RX_IPSIDX_SA_IDX_MASK (0x0000fff0)
+#define SXE2_IPSEC_RX_IPSIDX_TABLE_SHIFT (2)
+#define SXE2_IPSEC_RX_IPSIDX_TABLE_MASK (0x0000000c)
+
+#define SXE2_IPSEC_RX_IPSIPID_ADDR (SXE2_IPSEC_RX_BASE + 0x0088)
+#define SXE2_IPSEC_RX_IPSIPID_IP_ID_X_SHIFT (0)
+#define SXE2_IPSEC_RX_IPSIPID_IP_ID_X_MASK (0x000000ff)
+
+#define SXE2_IPSEC_RX_IPSSPI0_ADDR (SXE2_IPSEC_RX_BASE + 0x008c)
+#define SXE2_IPSEC_RX_IPSSPI0_SPI_X_SHIFT (0)
+#define SXE2_IPSEC_RX_IPSSPI0_SPI_X_MASK (0xffffffff)
+
+#define SXE2_IPSEC_RX_IPSSPI1_ADDR (SXE2_IPSEC_RX_BASE + 0x0090)
+#define SXE2_IPSEC_RX_IPSSPI1_SPI_Y_MASK (0xffffffff)
+
+#define SXE2_PAUSE_STATS_BASE(port)		(0x002b2000 + port * 0x4000)
+#define SXE2_TXPAUSEXONFRAMES_LO(port)	(SXE2_PAUSE_STATS_BASE(port) + 0x0894)
+#define SXE2_TXPAUSEXOFFFRAMES_LO(port)	(SXE2_PAUSE_STATS_BASE(port) + 0x0a18)
+#define SXE2_TXPFCXONFRAMES_LO(port, pri)	(SXE2_PAUSE_STATS_BASE(port) + \
+						(0x0a20 + 8 * (pri)))
+#define SXE2_TXPFCXOFFFRAMES_LO(port, pri)	(SXE2_PAUSE_STATS_BASE(port) + \
+						(0x0a60 + 8 * (pri)))
+#define SXE2_TXPFCXONTOXOFFFRAMES_LO(port, pri)	(SXE2_PAUSE_STATS_BASE(port) + \
+							(0x0aa0 + 8 * (pri)))
+#define SXE2_RXPAUSEXONFRAMES_LO(port)	(SXE2_PAUSE_STATS_BASE(port) + 0x0988)
+#define SXE2_RXPAUSEXOFFFRAMES_LO(port)	(SXE2_PAUSE_STATS_BASE(port) + 0x0b28)
+#define SXE2_RXPFCXONFRAMES_LO(port, pri)	(SXE2_PAUSE_STATS_BASE(port) + \
+						(0x0b30 + 8 * (pri)))
+#define SXE2_RXPFCXOFFFRAMES_LO(port, pri)	(SXE2_PAUSE_STATS_BASE(port) + \
+						(0x0b70 + 8 * (pri)))
+
+#endif
diff --git a/drivers/common/sxe2/sxe2_internal_ver.h b/drivers/common/sxe2/sxe2_internal_ver.h
new file mode 100644
index 0000000000..92f49e7a20
--- /dev/null
+++ b/drivers/common/sxe2/sxe2_internal_ver.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#ifndef __SXE2_INTERNAL_VER_H__
+#define __SXE2_INTERNAL_VER_H__
+
+#define SXE2_VER_MAJOR_OFFSET (16)
+#define SXE2_MK_VER(major, minor) \
+	(major << SXE2_VER_MAJOR_OFFSET | minor)
+#define SXE2_MK_VER_MAJOR(ver) (((ver) >> SXE2_VER_MAJOR_OFFSET) & 0xff)
+#define SXE2_MK_VER_MINOR(ver) ((ver) & 0xff)
+
+#define SXE2_ITR_VER_MAJOR_V100    1
+#define SXE2_ITR_VER_MAJOR_V200    2
+
+#define SXE2_ITR_VER_MAJOR      1
+#define SXE2_ITR_VER_MINOR      1
+#define SXE2_ITR_VER SXE2_MK_VER(SXE2_ITR_VER_MAJOR, SXE2_ITR_VER_MINOR)
+
+#define SXE2_CTRL_VER_IS_V100(ver)  (SXE2_MK_VER_MAJOR(ver) == SXE2_ITR_VER_MAJOR_V100)
+#define SXE2_CTRL_VER_IS_V200(ver)  (SXE2_MK_VER_MAJOR(ver) == SXE2_ITR_VER_MAJOR_V200)
+
+#define SXE2LIB_ITR_VER_MAJOR      1
+#define SXE2LIB_ITR_VER_MINOR      1
+#define SXE2LIB_ITR_VER     SXE2_MK_VER(SXE2LIB_ITR_VER_MAJOR, SXE2LIB_ITR_VER_MINOR)
+
+#define SXE2_DRV_CLI_VER_MAJOR      1
+#define SXE2_DRV_CLI_VER_MINOR      1
+#define SXE2_DRV_CLI_VER \
+	SXE2_MK_VER(SXE2_DRV_CLI_VER_MAJOR, SXE2_DRV_CLI_VER_MINOR)
+
+#endif /* __SXE2_INTERNAL_VER_H__ */
diff --git a/drivers/common/sxe2/sxe2_osal.h b/drivers/common/sxe2/sxe2_osal.h
new file mode 100644
index 0000000000..930498f3c2
--- /dev/null
+++ b/drivers/common/sxe2/sxe2_osal.h
@@ -0,0 +1,152 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#ifndef __SXE2_OSAL_H__
+#define __SXE2_OSAL_H__
+#include <string.h>
+#include <stdint.h>
+#include <stdarg.h>
+#include <inttypes.h>
+#include <stdbool.h>
+
+#include <rte_common.h>
+#include <rte_cycles.h>
+#include <rte_malloc.h>
+#include <rte_ether.h>
+#include <rte_version.h>
+#include <rte_bitops.h>
+
+#ifndef __BITS_PER_LONG
+#define __BITS_PER_LONG   (__SIZEOF_LONG__ * 8)
+#endif
+#define BIT_WORD(nr)      ((nr) / __BITS_PER_LONG)
+#define BIT_MASK(nr)      (1UL << ((nr) % __BITS_PER_LONG))
+
+#ifndef TAILQ_FOREACH_SAFE
+#define TAILQ_FOREACH_SAFE(var, head, field, tvar) \
+	for ((var) = TAILQ_FIRST((head)); \
+		(var) && ((tvar) = TAILQ_NEXT((var), field), 1); \
+		(var) = (tvar))
+#endif
+
+#define upper_32_bits(n) ((uint32_t)(((n) >> 16) >> 16))
+#define lower_32_bits(n) ((uint32_t)((n) & 0xffffffff))
+
+#ifndef SXE2_DIV_ROUND_UP
+#define SXE2_DIV_ROUND_UP(n, d) \
+			(((n) + (typeof(n))(d) - (typeof(n))1) / (typeof(n))(d))
+#endif
+
+enum sxe2_itr_idx {
+	SXE2_ITR_IDX_0 = 0,
+	SXE2_ITR_IDX_1,
+	SXE2_ITR_IDX_2,
+	SXE2_ITR_IDX_NONE,
+};
+
+#define SXE2_ETH_ALEN 6
+#define SXE2_BITS_PER_BYTE 8
+#define BITS_TO_LONGS(nr) SXE2_DIV_ROUND_UP(nr, SXE2_BITS_PER_BYTE * sizeof(unsigned long))
+#define BITS_TO_U32(nr) SXE2_DIV_ROUND_UP(nr, 32)
+
+#define BITMAP_LAST_WORD_MASK(nbits) (~0UL >> (-(nbits) & (__BITS_PER_LONG - 1)))
+
+#define DECLARE_BITMAP(name, bits) \
+				unsigned long name[BITS_TO_LONGS(bits)]
+#define BITMAP_TYPE unsigned long
+
+static inline void sxe2_set_bit(uint32_t nr, unsigned long *addr)
+{
+	addr[nr / __BITS_PER_LONG] |= 1UL << (nr % __BITS_PER_LONG);
+}
+
+static inline void sxe2_clear_bit(uint32_t nr, unsigned long *addr)
+{
+	addr[nr / __BITS_PER_LONG] &= ~(1UL << (nr % __BITS_PER_LONG));
+}
+
+static inline uint32_t sxe2_test_bit(uint32_t nr, const unsigned long *addr)
+{
+	return 1UL & (addr[BIT_WORD(nr)] >> (nr & (__BITS_PER_LONG-1)));
+}
+
+static inline uint32_t sxe2_bitmap_weight(const unsigned long *src, uint32_t nbits)
+{
+	uint32_t cnt = 0;
+	uint16_t i;
+
+	for (i = 0; i < nbits; i++) {
+		if (sxe2_test_bit(i, src))
+			cnt++;
+	}
+	return cnt;
+}
+
+static inline bool sxe2_bitmap_empty(const unsigned long *src, uint32_t nbits)
+{
+	uint16_t i;
+
+	for (i = 0; i < nbits; i++) {
+		if (sxe2_test_bit(i, src))
+			return false;
+	}
+	return true;
+}
+
+static inline void sxe2_bitmap_zero(unsigned long *dst, uint32_t nbits)
+{
+	uint32_t len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
+	memset(dst, 0, len);
+}
+
+static inline void sxe2_bitmap_copy(unsigned long *dst, const unsigned long *src,
+			uint32_t nbits)
+{
+	uint32_t len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
+	memcpy(dst, src, len);
+}
+
+#define sxe2_small_const_nbits(nbits) \
+	((nbits) && (nbits) <= __BITS_PER_LONG && (nbits) > 0)
+
+#define SXE2_BITMAP_LAST_WORD_MASK(nbits) \
+	(((nbits) % __BITS_PER_LONG) ? \
+	 ((1UL << ((nbits) % __BITS_PER_LONG)) - 1UL) : ~0UL)
+
+static inline bool
+__sxe2_bitmap_equal_generic(const unsigned long *src1,
+			    const unsigned long *src2, uint32_t nbits)
+{
+	uint32_t i;
+	uint32_t words = nbits / __BITS_PER_LONG;
+	uint32_t trailing = nbits % __BITS_PER_LONG;
+
+	for (i = 0; i < words; i++) {
+		if (src1[i] != src2[i])
+			return false;
+	}
+
+	if (trailing) {
+		unsigned long mask = (1UL << trailing) - 1UL;
+		if ((src1[words] & mask) != (src2[words] & mask))
+			return false;
+	}
+
+	return true;
+}
+
+static inline bool
+sxe2_bitmap_equal(const unsigned long *src1,
+		  const unsigned long *src2, uint32_t nbits)
+{
+	if (sxe2_small_const_nbits(nbits))
+		return !((*src1 ^ *src2) & SXE2_BITMAP_LAST_WORD_MASK(nbits));
+
+	if (__rte_constant(nbits & 7) && (nbits % 8 == 0))
+		return !memcmp(src1, src2, nbits / 8);
+
+	return __sxe2_bitmap_equal_generic(src1, src2, nbits);
+}
+
+#endif /* __SXE2_OSAL_H__ */
-- 
2.47.3

