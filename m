Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D986ACD4F54
	for <dpdk-dev@archiver.kernel.org>; Sun, 24 May 2026 09:34:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9DC41406B8;
	Sun, 24 May 2026 11:33:23 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id B5653402CC
 for <dev@dpdk.org>; Sun, 24 May 2026 11:33:10 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowABXd97QxRJq+04kEg--.9115S17;
 Sun, 24 May 2026 17:33:08 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v1 15/23] common/sxe2: add shared SFP module definitions
Date: Sun, 24 May 2026 17:32:51 +0800
Message-ID: <20260524093259.397506-16-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260524093259.397506-1-liujie5@linkdatatechnology.com>
References: <20260524093259.397506-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowABXd97QxRJq+04kEg--.9115S17
X-Coremail-Antispam: 1UD129KBjvJXoWxWry7Xr1fAry8Gr4UCw47CFg_yoWrWF1fpr
 1DJ3s8XFZ2qr1ag343tF1aqrnxCFsYy3WUCrs3W3yFkF1kJw1UCF18Cw4aga1kKrs7XFs3
 uayaqry3K348XrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUBv14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
 kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
 z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr
 1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1U
 M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
 v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
 F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4kE6xkIj40Ew7xC0wCF04
 k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
 MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr4
 1lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l
 IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4
 A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUB89_UUUUU=
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

This patch adds a new shared header file 'sxe2_msg.h' which
contains definitions for SFP/SFP+ modules. This file is shared across
Firmware, Kernel driver, and DPDK PMD to ensure consistent protocol
handling.

The header includes:
- SFP EEPROM memory map offsets.
- Module type encoding definitions.

By using this shared header, the PMD can correctly identify module
capabilities and report diagnostic information in a way that is
consistent with the underlying firmware logic.

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/common/sxe2/sxe2_msg.h | 118 +++++++++++++++++++++++++++++++++
 1 file changed, 118 insertions(+)
 create mode 100644 drivers/common/sxe2/sxe2_msg.h

diff --git a/drivers/common/sxe2/sxe2_msg.h b/drivers/common/sxe2/sxe2_msg.h
new file mode 100644
index 0000000000..a5270b2c13
--- /dev/null
+++ b/drivers/common/sxe2/sxe2_msg.h
@@ -0,0 +1,118 @@
+
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#ifndef __SXE2_MSG_H__
+#define __SXE2_MSG_H__
+
+enum sfp_type_identifier {
+	SXE2_SFP_TYPE_UNKNOW       = 0x00,
+	SXE2_SFP_TYPE_SFP          = 0x03,
+
+	SXE2_SFP_TYPE_QSFP_PLUS    = 0x0D,
+	SXE2_SFP_TYPE_QSFP28       = 0x11,
+
+	SXE2_SFP_TYPE_MAX          = 0xFF,
+};
+
+#ifndef SFP_DEFINE
+#define SFP_DEFINE
+
+#define SXE2_SFP_EEP_WR            0x1
+#define SXE2_SFP_EEP_QSFP          0x1
+
+enum sfp_bus_addr {
+	SXE2_SFP_EEP_I2C_ADDR0 = 0xA0,
+	SXE2_SFP_EEP_I2C_ADDR1 = 0xA2,
+	SXE2_SFP_EEP_I2C_ADDR_NR = 0xFFFF,
+};
+
+struct sxe2_sfp_req {
+	u8 is_wr;
+	u8 is_qsfp;
+	uint16_t bus_addr;
+	uint16_t page_cnt;
+	uint16_t offset;
+	uint16_t data_len;
+	uint16_t rvd;
+	u8 data[];
+};
+
+struct sxe2_sfp_resp {
+	u8 is_wr;
+	u8 is_qsfp;
+	uint16_t data_len;
+	u8 data[];
+};
+
+enum sfp_page_cnt {
+	SXE2_SFP_EEP_PAGE_CNT0     = 0,
+	SXE2_SFP_EEP_PAGE_CNT1,
+	SXE2_SFP_EEP_PAGE_CNT2,
+	SXE2_SFP_EEP_PAGE_CNT3,
+	SXE2_SFP_EEP_PAGE_CNT20    = 20,
+	SXE2_SFP_EEP_PAGE_CNT21    = 21,
+
+	SXE2_SFP_EEP_PAGE_CNT_NR   = 0xFFFF,
+};
+
+#define SXE2_SFP_E2P_I2C_7BIT_ADDR0             (SXE2_SFP_EEP_I2C_ADDR0 >> 1)
+#define SXE2_SFP_E2P_I2C_7BIT_ADDR1             (SXE2_SFP_EEP_I2C_ADDR1 >> 1)
+
+#define SXE2_QSFP_PAGE_OFST_START  128
+#define SXE2_SFP_EEP_OFST_MAX      255
+#define SXE2_SFP_EEP_LEN_MAX       256
+#endif
+
+#ifndef FW_STATE_DEFINE
+#define FW_STATE_DEFINE
+
+#define SXE2_FW_STATUS_MAIN_SHIF       (16)
+#define SXE2_FW_STATUS_MAIN_MASK       (0xFF0000)
+#define SXE2_FW_STATUS_SUB_MASK        (0xFFFF)
+
+enum Sxe2FwStateMain {
+	SXE2_FW_STATE_MAIN_UNDEFINED       = 0x00,
+	SXE2_FW_STATE_MAIN_INIT            = 0x10000,
+	SXE2_FW_STATE_MAIN_RUN             = 0x20000,
+	SXE2_FW_STATE_MAIN_ABNOMAL         = 0x30000,
+};
+
+enum Sxe2FwState {
+	SXE2_FW_START_STATE_UNDEFINED = SXE2_FW_STATE_MAIN_UNDEFINED,
+	SXE2_FW_START_STATE_INIT_BASE = (SXE2_FW_STATE_MAIN_INIT + 0x1),
+	SXE2_FW_START_STATE_SCAN_DEVICE = (SXE2_FW_STATE_MAIN_INIT + 0x20),
+	SXE2_FW_START_STATE_FINISHED = (SXE2_FW_STATE_MAIN_RUN + 0x0),
+	SXE2_FW_START_STATE_UPGRADE = (SXE2_FW_STATE_MAIN_RUN + 0x1),
+	SXE2_FW_START_STATE_SYNC = (SXE2_FW_STATE_MAIN_RUN + 0x2),
+	SXE2_FW_RUNNING_STATE_ABNOMAL = (SXE2_FW_STATE_MAIN_ABNOMAL + 0x1),
+	SXE2_FW_RUNNING_STATE_ABNOMAL_CORE1 = (SXE2_FW_STATE_MAIN_ABNOMAL + 0x2),
+	SXE2_FW_RUNNING_STATE_ABNOMAL_HEART = (SXE2_FW_STATE_MAIN_ABNOMAL + 0x3),
+	SXE2_FW_START_STATE_MASK = (SXE2_FW_STATUS_MAIN_MASK | SXE2_FW_STATUS_SUB_MASK),
+};
+#endif
+
+#ifndef LED_DEFINE
+#define LED_DEFINE
+
+enum sxe2_led_mode {
+	SXE2_IDENTIFY_LED_BLINK_ON   = 0,
+	SXE2_IDENTIFY_LED_BLINK_OFF,
+	SXE2_IDENTIFY_LED_ON,
+	SXE2_IDENTIFY_LED_OFF,
+	SXE2_IDENTIFY_LED_RESET,
+};
+
+
+typedef struct sxe2_led_ctrl {
+	u32 mode;
+	u32 duration;
+} sxe2_led_ctrl_s;
+
+typedef struct sxe2_led_ctrl_resp {
+	u32 ack;
+} sxe2_led_ctrl_resp_s;
+#endif
+
+#endif /* __SXE2_MSG_H__ */
-- 
2.47.3

