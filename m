Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A08CDB47F
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 05:49:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 86B5140A75;
	Thu, 25 Jun 2026 07:49:44 +0200 (CEST)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by mails.dpdk.org (Postfix) with ESMTP id E7F454025F
 for <dev@dpdk.org>; Thu, 25 Jun 2026 07:49:42 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-05 (Coremail) with SMTP id zQCowAA3j9J0wTxqJ8wnFQ--.8319S2;
 Thu, 25 Jun 2026 13:49:40 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v7 21/23] net/sxe2: add private devargs parsing
Date: Thu, 25 Jun 2026 13:49:40 +0800
Message-ID: <20260625054940.62795-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260624020249.3687380-1-liujie5@linkdatatechnology.com>
References: <20260624020249.3687380-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowAA3j9J0wTxqJ8wnFQ--.8319S2
X-Coremail-Antispam: 1UD129KBjvAXoW3Aw45Gw1kAr1UKF18Xr45GFg_yoW8ArWfZo
 WIgrW3Xa4fZ34Ig3y8Ar1kC3y2vw48Gw15Ja1S9F4DuwsxGw15KFnIqr13XF1DWFsYqFnr
 C3Z2y3s7trs7J3W8n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UjIYCTnIWjp_UUUYo7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xva
 j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2
 x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWx
 JVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
 4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
 Yx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbV
 WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lw4CEc2x0rVAK
 j4xxMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
 0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y
 0x0EwIxGrwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
 WxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4U
 MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU4v38UUU
 UU=
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

The parameters are parsed using the standard 'rte_kvargs' library during
the PCI/vdev probing phase. Documentation for these parameters is also
updated.

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/sxe2_cmd_chnl.c |  21 +++
 drivers/net/sxe2/sxe2_cmd_chnl.h |   3 +
 drivers/net/sxe2/sxe2_drv_cmd.h  |  17 +++
 drivers/net/sxe2/sxe2_ethdev.c   | 240 +++++++++++++++++++++++++++++++
 drivers/net/sxe2/sxe2_ethdev.h   |   6 +
 drivers/net/sxe2/sxe2_flow.c     |   9 +-
 drivers/net/sxe2/sxe2_irq.c      |  30 ++++
 drivers/net/sxe2/sxe2_rx.c       |  12 ++
 8 files changed, 335 insertions(+), 3 deletions(-)

diff --git a/drivers/net/sxe2/sxe2_cmd_chnl.c b/drivers/net/sxe2/sxe2_cmd_chnl.c
index 43e8c59487..b09989fe50 100644
--- a/drivers/net/sxe2/sxe2_cmd_chnl.c
+++ b/drivers/net/sxe2/sxe2_cmd_chnl.c
@@ -99,6 +99,27 @@ int32_t sxe2_drv_dev_info_get(struct sxe2_adapter *adapter,
 	return ret;
 }
 
+int32_t sxe2_drv_fc_state_get(struct sxe2_adapter *adapter,
+			      struct sxe2_drv_vsi_fc_get_resp *dev_fc_state_resp)
+{
+	int32_t ret = 0;
+	struct sxe2_common_device *cdev = adapter->cdev;
+	struct sxe2_drv_cmd_params param = {0};
+	struct sxe2_drv_vsi_fc_get_req req = {0};
+
+	req.vsi_id = adapter->vsi_ctxt.main_vsi->vsi_id;
+	sxe2_drv_cmd_params_fill(adapter, &param, SXE2_DRV_CMD_VSI_FC_GET,
+				&req, sizeof(req),
+				dev_fc_state_resp,
+				sizeof(*dev_fc_state_resp));
+	ret = sxe2_drv_cmd_exec(cdev, &param);
+	if (ret) {
+		PMD_DEV_LOG_ERR(adapter, DRV, "get fc state failed, ret=%d", ret);
+		ret = -EIO;
+	}
+	return ret;
+}
+
 int32_t sxe2_drv_dev_fw_info_get(struct sxe2_adapter *adapter,
 				struct sxe2_drv_dev_fw_info_resp *dev_fw_info_resp)
 {
diff --git a/drivers/net/sxe2/sxe2_cmd_chnl.h b/drivers/net/sxe2/sxe2_cmd_chnl.h
index 988d4b458b..d63caad526 100644
--- a/drivers/net/sxe2/sxe2_cmd_chnl.h
+++ b/drivers/net/sxe2/sxe2_cmd_chnl.h
@@ -99,6 +99,9 @@ int32_t sxe2_drv_vsi_stats_reset(struct sxe2_adapter *adapter);
 int32_t sxe2_drv_queue_info_get_update(struct sxe2_adapter *adapter,
 				       struct eth_queue_stats *qstats);
 
+int32_t sxe2_drv_fc_state_get(struct sxe2_adapter *adapter,
+			      struct sxe2_drv_vsi_fc_get_resp *dev_fc_state_resp);
+
 int32_t sxe2_drv_rxq_mapping_set(struct rte_eth_dev *eth_dev, uint16_t queue_id, uint8_t pool_idx);
 
 int32_t sxe2_drv_txq_mapping_set(struct rte_eth_dev *eth_dev, uint16_t queue_id, uint8_t pool_idx);
diff --git a/drivers/net/sxe2/sxe2_drv_cmd.h b/drivers/net/sxe2/sxe2_drv_cmd.h
index 3fabf351af..03ef3b315d 100644
--- a/drivers/net/sxe2/sxe2_drv_cmd.h
+++ b/drivers/net/sxe2/sxe2_drv_cmd.h
@@ -651,6 +651,23 @@ struct __rte_aligned(4) __rte_packed_begin sxe2_drv_sfp_resp {
 	uint8_t data[];
 } __rte_packed_end;
 
+enum sxe2_fc_type {
+	SXE2_FC_T_DIS = 0,
+	SXE2_FC_T_LFC,
+	SXE2_FC_T_PFC,
+	SXE2_FC_T_UNKNOWN = 255,
+};
+
+struct __rte_aligned(4) __rte_packed_begin sxe2_drv_vsi_fc_get_req {
+	uint16_t vsi_id;
+	uint8_t rsv[2];
+} __rte_packed_end;
+
+struct __rte_aligned(4) __rte_packed_begin sxe2_drv_vsi_fc_get_resp {
+	uint8_t fc_enable;
+	uint8_t rsv[3];
+} __rte_packed_end;
+
 enum sxe2_drv_cmd_module {
 	SXE2_DRV_CMD_MODULE_HANDSHAKE = 0,
 	SXE2_DRV_CMD_MODULE_DEV = 1,
diff --git a/drivers/net/sxe2/sxe2_ethdev.c b/drivers/net/sxe2/sxe2_ethdev.c
index e881cc2af6..0fb855fb33 100644
--- a/drivers/net/sxe2/sxe2_ethdev.c
+++ b/drivers/net/sxe2/sxe2_ethdev.c
@@ -67,6 +67,15 @@ static const struct rte_pci_id pci_id_sxe2_tbl[] = {
 	{ .vendor_id = 0, },
 };
 
+#define SXE2_TXSCH_NODE_ADJ_LVL_MAX 3
+
+#define SXE2_DEVARG_FLOW_DUP_PATTERN_MODE "flow-duplicate-pattern"
+#define SXE2_DEVARG_FUNC_FLOW_DIRCT "function-flow-direct"
+#define SXE2_DEVARG_FNAV_STAT_TYPE "fnav-stat-type"
+#define SXE2_DEVARG_NO_SCHED_MODE "no-sched-mode"
+#define SXE2_DEVARG_SCHED_LAYER_MODE "sched-layer-mode"
+#define SXE2_DEVARG_RX_LOW_LATENCY "rx-low-latency"
+
 static struct sxe2_pci_map_addr_info sxe2_net_map_addr_info_pf[SXE2_PCI_MAP_RES_MAX_COUNT] = {
 	[SXE2_PCI_MAP_RES_INVALID] = {.addr_base = 0,
 				      .bar_idx = 0,
@@ -960,6 +969,124 @@ sxe2_buffer_split_supported_hdr_ptypes_get(struct rte_eth_dev *dev __rte_unused,
 	return ptypes;
 }
 
+static int32_t sxe2_parse_fnav_stat_type(const char *key, const char *value, void *args)
+{
+	int32_t ret = -EINVAL;
+	uint8_t *num = (uint8_t *)args;
+	unsigned long fnav_stat_type;
+	char *endptr = NULL;
+
+	if (value == NULL || args == NULL) {
+		ret = 0;
+		goto l_end;
+	}
+	errno = 0;
+	fnav_stat_type = strtoul(value, &endptr, 10);
+	if (errno != 0 || endptr == value || *endptr != '\0') {
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
+	*num = (uint8_t)fnav_stat_type;
+	ret = 0;
+l_end:
+	return ret;
+}
+
+static int32_t sxe2_parse_sched_layer_mode(const char *key, const char *value, void *args)
+{
+	int32_t ret = -EINVAL;
+	uint8_t *num = (uint8_t *)args;
+	unsigned long sched_layer_mode;
+	char *endptr = NULL;
+
+	if (value == NULL || args == NULL) {
+		ret = 0;
+		goto l_end;
+	}
+	errno = 0;
+	sched_layer_mode = strtoul(value, &endptr, 10);
+	if (errno != 0 || endptr == value || *endptr != '\0') {
+		PMD_LOG_WARN(INIT, "%s: \"%s\" is not a valid int value.",
+			key, value);
+		goto l_end;
+	}
+	if (sched_layer_mode > SXE2_TXSCH_NODE_ADJ_LVL_MAX) {
+		PMD_LOG_ERR(INIT, "%s: \"%s\" > 3.",
+			key, value);
+		goto l_end;
+	}
+	*num = (uint8_t)sched_layer_mode;
+	ret = 0;
+l_end:
+	return ret;
+}
+
+static int32_t sxe2_parse_flow_dup_pattern_mode(const char *key, const char *value, void *args)
+{
+	uint8_t *num = (uint8_t *)args;
+	char *end;
+	unsigned long val;
+	int32_t ret = -EINVAL;
+
+	if (value == NULL || args == NULL) {
+		ret = 0;
+		goto l_end;
+	}
+	errno = 0;
+	val = strtoul(value, &end, 10);
+	if (errno != 0 || end == value || *end != '\0') {
+		PMD_LOG_ERR(INIT, "Invalid 8-bit integer value for key %s: %s", key, value);
+		goto l_end;
+	}
+
+	if (val >= SXE2_FLOW_SW_PATTERN_MAX) {
+		PMD_LOG_ERR(INIT, "%s: \"%s\" out of range [0-%u].",
+			key, value, SXE2_FLOW_SW_PATTERN_MAX - 1);
+		goto l_end;
+	}
+
+	*num = (uint8_t)val;
+	ret = 0;
+l_end:
+	return ret;
+}
+
+static int32_t sxe2_parse_bool(const char *key, const char *value, void *args)
+{
+	int32_t ret = -EINVAL;
+	uint8_t *num = (uint8_t *)args;
+	unsigned long bool_val;
+	char *endptr = NULL;
+
+	if (value == NULL || args == NULL) {
+		ret = 0;
+		goto l_end;
+	}
+	errno = 0;
+	bool_val = strtoul(value, &endptr, 10);
+	if (errno != 0 || endptr == value || *endptr != '\0') {
+		PMD_LOG_WARN(INIT, "%s: \"%s\" is not a valid int value.",
+			key, value);
+		goto l_end;
+	}
+	if (bool_val != 0 && bool_val != 1) {
+		PMD_LOG_ERR(INIT, "%s: \"%s\" out of range [0|1].",
+			key, value);
+		goto l_end;
+	}
+	*num = (uint8_t)bool_val;
+	ret = 0;
+l_end:
+	return ret;
+}
+
 struct sxe2_pci_map_bar_info *sxe2_dev_get_bar_info(struct sxe2_adapter *adapter,
 						    enum sxe2_pci_map_resource res_type)
 {
@@ -1027,6 +1154,66 @@ void *sxe2_pci_map_addr_get(struct sxe2_adapter *adapter,
 	return addr;
 }
 
+static int32_t sxe2_args_parse(struct rte_eth_dev *dev, struct sxe2_dev_kvargs_info *kvargs)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	int32_t ret = 0;
+	PMD_INIT_FUNC_TRACE();
+
+	adapter->devargs.flow_dup_pattern_mode = SXE2_FLOW_SW_PATTERN_LAST;
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
+
+	ret = sxe2_kvargs_process(kvargs, SXE2_DEVARG_NO_SCHED_MODE,
+				 &sxe2_parse_bool,
+				 &adapter->devargs.no_sched_mode);
+	if (ret) {
+		PMD_DEV_LOG_ERR(adapter, INIT, "Failed to parse no sched mode, ret:%d", ret);
+		goto l_end;
+	}
+	ret = sxe2_kvargs_process(kvargs, SXE2_DEVARG_SCHED_LAYER_MODE,
+				 &sxe2_parse_sched_layer_mode,
+				 &adapter->devargs.sched_layer_mode);
+	if (ret) {
+		PMD_DEV_LOG_ERR(adapter, INIT, "Failed to parse sched layer mode, ret:%d", ret);
+		goto l_end;
+	}
+
+	ret = sxe2_kvargs_process(kvargs, SXE2_DEVARG_FLOW_DUP_PATTERN_MODE,
+				 &sxe2_parse_flow_dup_pattern_mode,
+				 &adapter->devargs.flow_dup_pattern_mode);
+	if (ret) {
+		PMD_DEV_LOG_ERR(adapter, INIT, "Failed to parse flow duplicate pattern mode, ret:%d", ret);
+		goto l_end;
+	}
+
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
@@ -1579,6 +1766,37 @@ void sxe2_dev_pci_map_uinit(struct rte_eth_dev *dev)
 	adapter->dev_info.dev_data = NULL;
 }
 
+static int32_t sxe2_fc_state_init(struct rte_eth_dev *dev)
+{
+	struct sxe2_adapter *adapter =
+		SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct sxe2_drv_vsi_fc_get_resp fc_resp = {0};
+	int32_t ret;
+
+	if (!(adapter->cap_flags & SXE2_DEV_CAPS_OFFLOAD_FC_STATE)) {
+		adapter->fc_state_ctx.cfg_state = 0;
+		adapter->fc_state_ctx.curr_state = 0;
+		ret = 0;
+		goto l_end;
+	}
+	ret = sxe2_drv_fc_state_get(adapter, &fc_resp);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "Failed to get fc state, ret=[%d]", ret);
+		goto l_end;
+	}
+	adapter->fc_state_ctx.cfg_state = fc_resp.fc_enable;
+	adapter->fc_state_ctx.curr_state = 0;
+l_end:
+	return ret;
+}
+static void sxe2_fc_state_uinit(struct rte_eth_dev *dev)
+{
+	struct sxe2_adapter *adapter =
+		SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	adapter->fc_state_ctx.cfg_state = 0;
+	adapter->fc_state_ctx.curr_state = 0;
+}
+
 uint32_t sxe2_sched_mode_get(struct sxe2_adapter *adapter)
 {
 	uint32_t ret_mode = SXE2_SCHED_MODE_INVALID;
@@ -1661,6 +1879,12 @@ static int32_t sxe2_dev_init(struct rte_eth_dev *dev,
 		goto l_end;
 	}
 
+	ret = sxe2_args_parse(dev, kvargs);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "Failed to parse devargs, ret=%d", ret);
+		goto l_end;
+	}
+
 	ret = sxe2_hw_init(dev);
 	if (ret) {
 		PMD_LOG_ERR(INIT, "Failed to initialize hw, ret=[%d]", ret);
@@ -1727,6 +1951,12 @@ static int32_t sxe2_dev_init(struct rte_eth_dev *dev,
 		goto init_flow_err;
 	}
 
+	ret = sxe2_fc_state_init(dev);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "Failed to init fc state, ret=%d", ret);
+		goto init_fc_state_err;
+	}
+
 	ret = sxe2_sched_init(dev);
 	if (ret) {
 		PMD_LOG_ERR(INIT, "Failed to init sched, ret=%d", ret);
@@ -1750,6 +1980,8 @@ static int32_t sxe2_dev_init(struct rte_eth_dev *dev,
 init_xstats_err:
 	(void)sxe2_sched_uinit(dev);
 init_sched_err:
+	sxe2_fc_state_uinit(dev);
+init_fc_state_err:
 	(void)sxe2_flow_uninit(dev);
 init_flow_err:
 init_rss_err:
@@ -1795,6 +2027,7 @@ static int32_t sxe2_dev_close(struct rte_eth_dev *dev)
 	sxe2_eth_uinit(dev);
 	sxe2_dev_pci_map_uinit(dev);
 	sxe2_free_repr_info(dev);
+	sxe2_fc_state_uinit(dev);
 
 l_end:
 	return 0;
@@ -2100,6 +2333,13 @@ RTE_INIT(rte_sxe2_pmd_init)
 RTE_PMD_EXPORT_NAME(net_sxe2);
 RTE_PMD_REGISTER_PCI_TABLE(net_sxe2, pci_id_sxe2_tbl);
 RTE_PMD_REGISTER_KMOD_DEP(net_sxe2, "* sxe2");
+RTE_PMD_REGISTER_PARAM_STRING(net_sxe2,
+	"flow-duplicate-pattern=<0|1|2> "
+	"function-flow-direct=<0|1> "
+	"fnav-stat-type=<1|2|3> "
+	"no-sched-mode=<0|1> "
+	"sched-layer-mode=<0-3> "
+	"rx-low-latency=<0|1>");
 
 RTE_LOG_REGISTER_SUFFIX(sxe2_log_init, init, NOTICE);
 RTE_LOG_REGISTER_SUFFIX(sxe2_log_driver, driver, NOTICE);
diff --git a/drivers/net/sxe2/sxe2_ethdev.h b/drivers/net/sxe2/sxe2_ethdev.h
index a68b95c0d0..c54e8a435e 100644
--- a/drivers/net/sxe2/sxe2_ethdev.h
+++ b/drivers/net/sxe2/sxe2_ethdev.h
@@ -310,6 +310,11 @@ struct sxe2_filter_context {
 	bool cur_l2_config;
 };
 
+struct sxe2_fc_state_ctxt {
+	uint8_t curr_state;
+	uint8_t cfg_state;
+};
+
 struct sxe2_adapter {
 	struct sxe2_common_device      *cdev;
 	struct sxe2_dev_info            dev_info;
@@ -331,6 +336,7 @@ struct sxe2_adapter {
 	struct sxe2_security_ctx      security_ctx;
 	struct sxe2_repr_context      repr_ctxt;
 	struct sxe2_switchdev_info    switchdev_info;
+	struct sxe2_fc_state_ctxt     fc_state_ctx;
 	bool                          rule_started;
 	bool                          flow_isolated;
 	bool                          flow_isolate_cfg;
diff --git a/drivers/net/sxe2/sxe2_flow.c b/drivers/net/sxe2/sxe2_flow.c
index 63cfc36968..1aa5813ee4 100644
--- a/drivers/net/sxe2/sxe2_flow.c
+++ b/drivers/net/sxe2/sxe2_flow.c
@@ -762,6 +762,7 @@ static int32_t sxe2_flow_validate_with_flow(struct rte_eth_dev *dev,
 					const struct rte_flow_action actions[],
 					struct rte_flow_error *error)
 {
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
 	int32_t ret = 0;
 	struct sxe2_flow *flow = NULL;
 
@@ -804,9 +805,11 @@ static int32_t sxe2_flow_validate_with_flow(struct rte_eth_dev *dev,
 
 	ret = sxe2_flow_check_flow_list_duplicate(dev, flow_list);
 	if (ret != 0) {
-		rte_flow_error_set(error, EEXIST, RTE_FLOW_ERROR_TYPE_ITEM,
-				NULL, "Duplicate flow.");
-		PMD_LOG_ERR(DRV, "Duplicate flow.");
+		rte_flow_error_set(error, EEXIST, RTE_FLOW_ERROR_TYPE_ITEM, NULL,
+				   adapter->devargs.flow_dup_pattern_mode ?
+				   "Duplicate flow pattern." :
+				   "Duplicate flow pattern is not allowed.");
+		PMD_LOG_ERR(DRV, "Duplicate flow pattern.");
 		goto l_end;
 	}
 l_end:
diff --git a/drivers/net/sxe2/sxe2_irq.c b/drivers/net/sxe2/sxe2_irq.c
index d8e0b19463..3306504761 100644
--- a/drivers/net/sxe2/sxe2_irq.c
+++ b/drivers/net/sxe2/sxe2_irq.c
@@ -10,6 +10,7 @@
 #include <rte_alarm.h>
 #include <fcntl.h>
 #include <rte_stdatomic.h>
+#include <rte_common.h>
 
 #include "sxe2_ethdev.h"
 #include "sxe2_irq.h"
@@ -47,6 +48,31 @@ static struct sxe2_event_handler event_handler = {
 
 static RTE_ATOMIC(uint32_t)event_thread_run;
 
+static int32_t sxe2_fc_state_callback(struct rte_eth_dev *dev)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct sxe2_drv_vsi_fc_get_resp fc_resp = {0};
+	int32_t ret;
+
+	if (!(adapter->cap_flags & SXE2_DEV_CAPS_OFFLOAD_FC_STATE)) {
+		ret = 0;
+		goto l_end;
+	}
+	ret = sxe2_drv_fc_state_get(adapter, &fc_resp);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "Failed to get fc state, ret=[%d]", ret);
+		goto l_end;
+	}
+	adapter->fc_state_ctx.cfg_state = fc_resp.fc_enable;
+	if (dev->data->dev_started) {
+		PMD_LOG_NOTICE(DRV, "Interrupt event: FC status changed."
+			       "cfg_state:%u curr_state:%u",
+				adapter->fc_state_ctx.cfg_state,
+				adapter->fc_state_ctx.curr_state);
+	}
+l_end:
+	return ret;
+}
 
 static void sxe2_event_irq_common_handler(struct sxe2_adapter *adapter, uint64_t oicr)
 {
@@ -68,6 +94,10 @@ static void sxe2_event_irq_common_handler(struct sxe2_adapter *adapter, uint64_t
 		PMD_DEV_LOG_INFO(adapter, DRV, "event notify legacy");
 		(void)sxe2_switchdev_notify_callback(adapter, false);
 	}
+	if (oicr & RTE_BIT32(SXE2_COM_FC_ST_CHANGE)) {
+		PMD_DEV_LOG_INFO(adapter, DRV, "fc event notify legacy");
+		(void)sxe2_fc_state_callback(dev);
+	}
 }
 
 static uint32_t sxe2_event_intr_handle(void *param __rte_unused)
diff --git a/drivers/net/sxe2/sxe2_rx.c b/drivers/net/sxe2/sxe2_rx.c
index 820d4f0620..d700c60083 100644
--- a/drivers/net/sxe2/sxe2_rx.c
+++ b/drivers/net/sxe2/sxe2_rx.c
@@ -467,12 +467,24 @@ int32_t __rte_cold sxe2_rx_queue_start(struct rte_eth_dev *dev, uint16_t rx_queu
 int32_t __rte_cold sxe2_rxqs_all_start(struct rte_eth_dev *dev)
 {
 	struct rte_eth_dev_data *data = dev->data;
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct sxe2_drv_vsi_fc_get_resp fc_resp = {0};
 	struct sxe2_rx_queue *rxq;
 	uint16_t nb_rxq;
 	uint16_t nb_started_rxq;
 	int32_t ret;
 	PMD_INIT_FUNC_TRACE();
 
+	if (adapter->cap_flags & SXE2_DEV_CAPS_OFFLOAD_FC_STATE) {
+		ret = sxe2_drv_fc_state_get(adapter, &fc_resp);
+		if (ret) {
+			PMD_LOG_ERR(RX, "Failed to get fc state, ret=[%d]", ret);
+			goto l_end;
+		}
+		adapter->fc_state_ctx.cfg_state = fc_resp.fc_enable;
+		adapter->fc_state_ctx.curr_state = adapter->fc_state_ctx.cfg_state;
+	}
+
 	for (nb_rxq = 0; nb_rxq < data->nb_rx_queues; nb_rxq++) {
 		rxq = dev->data->rx_queues[nb_rxq];
 		if (!rxq || rxq->rx_deferred_start)
-- 
2.52.0

