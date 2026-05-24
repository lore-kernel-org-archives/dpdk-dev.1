Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B04FCD5BAB
	for <dpdk-dev@archiver.kernel.org>; Sun, 24 May 2026 09:34:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AD5A040A89;
	Sun, 24 May 2026 11:33:27 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id BCBED402A3
 for <dev@dpdk.org>; Sun, 24 May 2026 11:33:11 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowABXd97QxRJq+04kEg--.9115S22;
 Sun, 24 May 2026 17:33:09 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v1 20/23] net/sxe2: add private devargs parsing
Date: Sun, 24 May 2026 17:32:56 +0800
Message-ID: <20260524093259.397506-21-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260524093259.397506-1-liujie5@linkdatatechnology.com>
References: <20260524093259.397506-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowABXd97QxRJq+04kEg--.9115S22
X-Coremail-Antispam: 1UD129KBjvJXoWxuw4UKrW8KrW5Wr4xJFy3twb_yoW3ZF4fpr
 4DWryYyFWftFsYgF48tr4UXrnagr4rKry2gFs3uw1fKFyIyr1kAw1vgw15Awn5C39xAF1I
 yFs0qa1DGa12qrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUBl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
 kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
 z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr
 1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4U
 JwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
 IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
 M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0F24l42
 xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWU
 GwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI4
 8JMIIF0xvE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4U
 JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcV
 C2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbfcTJUUUUU==
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

Introduce runtime private device arguments (devargs) support for the
sxe2 PMD. This allows users to customize driver behavior at startup
without recompiling the source code.

The following private parameters are added:
- high-performance-mode': Enable high-performance burst mode (0: disable,
  1: enable, default 0).

The parameters are parsed using the standard 'rte_kvargs' library during
the PCI/vdev probing phase. Documentation for these parameters is also
updated.

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/sxe2_ethdev.c | 216 ++++++++++++++++++++++++++++++++-
 1 file changed, 215 insertions(+), 1 deletion(-)

diff --git a/drivers/net/sxe2/sxe2_ethdev.c b/drivers/net/sxe2/sxe2_ethdev.c
index 0b19e17c2e..4b9258edd8 100644
--- a/drivers/net/sxe2/sxe2_ethdev.c
+++ b/drivers/net/sxe2/sxe2_ethdev.c
@@ -2,6 +2,7 @@
  * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
  */
 
+#include <asm-generic/errno-base.h>
 #include <rte_string_fns.h>
 #include <ethdev_pci.h>
 #include <ctype.h>
@@ -68,7 +69,14 @@ static const struct rte_pci_id pci_id_sxe2_tbl[] = {
 	{ RTE_PCI_DEVICE(SXE2_PCI_VENDOR_ID_206F, SXE2_PCI_DEVICE_ID_VF_1)},
 	{ .vendor_id = 0, },
 };
-
+#define SXE2_TXSCH_NODE_ADJ_LVL_MAX  3
+#define SXE2_DEVARG_FLOW_DULP_PATTERN_MODE "flow-duplicate-pattern"
+#define SXE2_DEVARG_FUNC_FLOW_DIRCT "function-flow-direct"
+#define SXE2_DEVARG_FNAV_STAT_TYPE "fnav-stat-type"
+#define SXE2_DEVARG_SW_STATS "drv-sw-stats"
+#define SXE2_DEVARG_HIGH_PERFORMANCE_MODE "high-performance-mode"
+#define SXE2_DEVARG_SCHED_LAYER_MODE "sched-layer-mode"
+#define SXE2_DEVARG_RX_LOW_LATENCY "rx-low-latency"
 static struct sxe2_pci_map_addr_info sxe2_net_map_addr_info_pf[SXE2_PCI_MAP_RES_MAX_COUNT] = {
 	[SXE2_PCI_MAP_RES_INVALID] = {.addr_base = 0,
 				      .bar_idx = 0,
@@ -980,6 +988,143 @@ static inline void sxe2_init_ptype_tbl(struct rte_eth_dev *dev)
 	sxe2_init_ptype_list(ptype);
 }
 
+static int32_t sxe2_parse_fnav_stat_type(const char *key, const char *value, void *args)
+{
+	int32_t ret = -EINVAL;
+	uint8_t *num = (uint8_t *)args;
+	uint8_t fnav_stat_type = 0;
+	char *endptr = NULL;
+
+	if (value == NULL || args == NULL) {
+		ret = 0;
+		goto l_end;
+	}
+	errno = 0;
+	fnav_stat_type = (uint8_t)strtoul(value, &endptr, 10);
+	if (errno != 0 || *endptr != '\0') {
+		PMD_LOG_WARN(INIT, "%s: \"%s\" is not a valid int value.",
+			key, value);
+		goto l_end;
+	}
+	if (fnav_stat_type > SXE2_FNAV_STAT_ENA_ALL ||
+		fnav_stat_type == SXE2_FNAV_STAT_ENA_NONE) {
+		PMD_LOG_ERR(INIT, "%s: \"%s\" out of range [1-3].",
+			key, value);
+		goto l_end;
+	}
+	*num = fnav_stat_type;
+	ret = 0;
+l_end:
+	return ret;
+}
+static int32_t sxe2_parse_sched_layer_mode(const char *key, const char *value, void *args)
+{
+	int32_t ret = -EINVAL;
+	uint8_t *num = (uint8_t *)args;
+	uint8_t sched_layer_mode;
+	char *endptr = NULL;
+
+	if (value == NULL || args == NULL) {
+		ret = 0;
+		goto l_end;
+	}
+	errno = 0;
+	sched_layer_mode = (uint8_t)strtoul(value, &endptr, 10);
+	if (errno != 0 || *endptr != '\0') {
+		PMD_LOG_WARN(INIT, "%s: \"%s\" is not a valid int value.",
+			key, value);
+		goto l_end;
+	}
+	if (sched_layer_mode > SXE2_TXSCH_NODE_ADJ_LVL_MAX) {
+		PMD_LOG_ERR(INIT, "%s: \"%s\" > 3.",
+			key, value);
+		goto l_end;
+	}
+	*num = sched_layer_mode;
+	ret = 0;
+l_end:
+	return ret;
+}
+static int32_t sxe2_parse_high_performance_mode(const char *key, const char *value, void *args)
+{
+	int32_t ret = -EINVAL;
+	uint8_t *num = (uint8_t *)args;
+	uint8_t high_performance_mode;
+	char *endptr = NULL;
+
+	if (value == NULL || args == NULL) {
+		ret = 0;
+		goto l_end;
+	}
+	errno = 0;
+	high_performance_mode = (uint8_t)strtoul(value, &endptr, 10);
+	if (errno != 0 || *endptr != '\0') {
+		PMD_LOG_WARN(INIT, "%s: \"%s\" is not a valid int value.",
+			key, value);
+		goto l_end;
+	}
+	if (high_performance_mode != 1) {
+		PMD_LOG_ERR(INIT, "%s: \"%s\" != 1.",
+			key, value);
+		goto l_end;
+	}
+	*num = high_performance_mode;
+	ret = 0;
+l_end:
+	return ret;
+}
+static int32_t sxe2_parse_u8(const char *key, const char *value, void *args)
+{
+	uint8_t *num = (uint8_t *)args;
+	char *end;
+	uint8_t u8_val;
+	int32_t ret = -EINVAL;
+
+	if (value == NULL || args == NULL) {
+		ret = 0;
+		goto l_end;
+	}
+	errno = 0;
+	u8_val = strtoul(value, &end, 10);
+	if (errno) {
+		PMD_LOG_WARN(INIT, "%s: \"%s\" is not a valid uint8_t",
+			key, value);
+		goto l_end;
+	}
+	*num = u8_val;
+	ret = 0;
+l_end:
+	return ret;
+}
+static int32_t sxe2_parse_bool(const char *key, const char *value, void *args)
+{
+	int32_t ret = -EINVAL;
+	uint8_t *num = (uint8_t *)args;
+	uint8_t bool_val = 0;
+	char *endptr = NULL;
+
+	if (value == NULL || args == NULL) {
+		ret = 0;
+		goto l_end;
+	}
+	errno = 0;
+	bool_val = (uint8_t)strtoul(value, &endptr, 10);
+	if (errno != 0 || *endptr != '\0') {
+		PMD_LOG_WARN(INIT, "%s: \"%s\" is not a valid int value.",
+			key, value);
+		goto l_end;
+	}
+	if (bool_val != 0 && bool_val != 1) {
+		PMD_LOG_ERR(INIT, "%s: \"%s\" out of range [0|1].",
+			key, value);
+		goto l_end;
+	}
+	*num = bool_val;
+	ret = 0;
+l_end:
+	return ret;
+}
+
 struct sxe2_pci_map_bar_info *sxe2_dev_get_bar_info(struct sxe2_adapter *adapter,
 						    enum sxe2_pci_map_resource res_type)
 {
@@ -1047,6 +1192,69 @@ void *sxe2_pci_map_addr_get(struct sxe2_adapter *adapter,
 	return addr;
 }
 
+static int32_t sxe2_args_parse(struct rte_eth_dev *dev, struct sxe2_dev_kvargs_info *kvargs)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	int32_t ret = 0;
+	PMD_INIT_FUNC_TRACE();
+
+	if (kvargs == NULL)
+		goto l_end;
+	ret = sxe2_kvargs_process(kvargs, SXE2_DEVARG_FNAV_STAT_TYPE,
+				 &sxe2_parse_fnav_stat_type,
+				 &adapter->devargs.fnav_stat_type);
+	if (ret) {
+		PMD_DEV_LOG_ERR(adapter, INIT, "Failed to parse fnav stat type, ret:%d", ret);
+		goto l_end;
+	}
+	ret = sxe2_kvargs_process(kvargs, SXE2_DEVARG_SW_STATS,
+				 &sxe2_parse_bool,
+				 &adapter->devargs.sw_stats_en);
+	if (ret) {
+		PMD_DEV_LOG_ERR(adapter, INIT, "Failed to parse sw stats enable, ret:%d", ret);
+		goto l_end;
+	}
+	ret = sxe2_kvargs_process(kvargs, SXE2_DEVARG_HIGH_PERFORMANCE_MODE,
+				 &sxe2_parse_high_performance_mode,
+				 &adapter->devargs.high_performance_mode);
+	if (ret) {
+		PMD_DEV_LOG_ERR(adapter, INIT, "Failed to parse high performance, ret:%d", ret);
+		goto l_end;
+	}
+	ret = sxe2_kvargs_process(kvargs, SXE2_DEVARG_SCHED_LAYER_MODE,
+				 &sxe2_parse_sched_layer_mode,
+				 &adapter->devargs.sched_layer_mode);
+	if (ret) {
+		PMD_DEV_LOG_ERR(adapter, INIT, "Failed to parse sched layer mode, ret:%d", ret);
+		goto l_end;
+	}
+	ret = sxe2_kvargs_process(kvargs, SXE2_DEVARG_FLOW_DULP_PATTERN_MODE,
+				 &sxe2_parse_u8,
+				 &adapter->devargs.flow_dup_pattern_mode);
+	if (ret) {
+		PMD_DEV_LOG_ERR(adapter, INIT, "Failed to parse switch dulpliate flow pattern mode,"
+				"ret:%d", ret);
+		goto l_end;
+	}
+	ret = sxe2_kvargs_process(kvargs, SXE2_DEVARG_FUNC_FLOW_DIRCT,
+				 &sxe2_parse_bool,
+				 &adapter->devargs.func_flow_direct_en);
+	if (ret) {
+		PMD_DEV_LOG_ERR(adapter, INIT, "Failed to parse function flow rule enable,"
+				"ret:%d", ret);
+		goto l_end;
+	}
+	ret = sxe2_kvargs_process(kvargs, SXE2_DEVARG_RX_LOW_LATENCY,
+				 &sxe2_parse_bool,
+				 &adapter->devargs.rx_low_latency);
+	if (ret) {
+		PMD_DEV_LOG_ERR(adapter, INIT, "Failed to parse rx low latency, ret:%d", ret);
+		goto l_end;
+	}
+l_end:
+	return ret;
+}
+
 static int32_t sxe2_eth_init(struct rte_eth_dev *dev)
 {
 	int32_t ret = 0;
@@ -1709,6 +1917,12 @@ static int32_t sxe2_dev_init(struct rte_eth_dev *dev,
 
 	sxe2_init_ptype_tbl(dev);
 
+	ret = sxe2_args_parse(dev, kvargs);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "Failed to parse devargs, ret=%d", ret);
+		goto l_end;
+	}
+
 	ret = sxe2_hw_init(dev);
 	if (ret) {
 		PMD_LOG_ERR(INIT, "Failed to initialize hw, ret=[%d]", ret);
-- 
2.47.3

