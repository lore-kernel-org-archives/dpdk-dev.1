Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55A4CD6E4A
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 02:24:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E8D140E1F;
	Wed,  3 Jun 2026 04:22:19 +0200 (CEST)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by mails.dpdk.org (Postfix) with ESMTP id F297340A6B
 for <dev@dpdk.org>; Wed,  3 Jun 2026 04:22:05 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-01 (Coremail) with SMTP id qwCowACHJ9C_jx9qM398AA--.10425S17;
 Wed, 03 Jun 2026 10:21:56 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v7 15/20] common/sxe2: add shared SFP module definitions
Date: Wed,  3 Jun 2026 10:21:45 +0800
Message-ID: <20260603022150.1140722-16-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260603022150.1140722-1-liujie5@linkdatatechnology.com>
References: <20260602155240.1002602-21-liujie5@linkdatatechnology.com>
 <20260603022150.1140722-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowACHJ9C_jx9qM398AA--.10425S17
X-Coremail-Antispam: 1UD129KBjvJXoWxWry7Xr1fArW8Cw43Aw45trb_yoWrWw4rpr
 1DJwn8Xa97Kr1ag343tF13trnxCFsYyw1UCrs3W3yFkF1kJw18CF18Cw42qa1kKrsrXFs3
 uayaqry3Ka48ZrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUBm14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
 kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
 z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr
 1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4U
 JwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
 IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
 M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0F24l42
 xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWU
 GwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI4
 8JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4U
 MIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I
 8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUYGYpUUUUU
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
index 0000000000..f08944f7c9
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
+	SXE2_SFP_TYPE_UNKNOWN       = 0x00,
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
+	uint8_t is_wr;
+	uint8_t is_qsfp;
+	uint16_t bus_addr;
+	uint16_t page_cnt;
+	uint16_t offset;
+	uint16_t data_len;
+	uint16_t rvd;
+	uint8_t data[];
+};
+
+struct sxe2_sfp_resp {
+	uint8_t is_wr;
+	uint8_t is_qsfp;
+	uint16_t data_len;
+	uint8_t data[];
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
+	uint32_t mode;
+	uint32_t duration;
+} sxe2_led_ctrl_s;
+
+typedef struct sxe2_led_ctrl_resp {
+	uint32_t ack;
+} sxe2_led_ctrl_resp_s;
+#endif
+
+#endif /* __SXE2_MSG_H__ */
-- 
2.52.0

