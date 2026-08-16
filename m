Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D88C5DF67
	for <dpdk-dev@archiver.kernel.org>; Sun, 16 Aug 2026 02:53:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AADDD40658;
	Sun, 16 Aug 2026 04:52:48 +0200 (CEST)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by mails.dpdk.org (Postfix) with ESMTP id ED88440294
 for <dev@dpdk.org>; Sun, 16 Aug 2026 04:52:43 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-01 (Coremail) with SMTP id qwCowAAn+u32JYFqrYDQBQ--.14967S5;
 Sun, 16 Aug 2026 10:52:42 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v2 03/13] net/sxe2: add ACL engine event statistics support
Date: Sun, 16 Aug 2026 10:52:23 +0800
Message-ID: <20260816025233.2727226-4-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260816025233.2727226-1-liujie5@linkdatatechnology.com>
References: <20260816025233.2727226-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAAn+u32JYFqrYDQBQ--.14967S5
X-Coremail-Antispam: 1UD129KBjvAXoWfXryxAF1ktr15KFyfZF4kCrg_yoW5JFyxWo
 WxWrWUZFyxA34xtaykXr18CFyUAay8Gr15Ja1fWF4DuanrGa42vF4DXwsxX3WDWFs5KFn0
 9wn3AayUtFn7Kr95n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UjIYCTnIWjp_UUUYZ7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20EY4v20xva
 j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r1rM28IrcIa0x
 kI8VCY1x0267AKxVWUCVW8JwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84AC
 jcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM2
 8EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4UJwAS
 0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
 IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
 Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0F24l42xK82
 IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC2
 0s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMI
 IF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF
 0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87
 Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUePfHUUUUU
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

Add statistics support for ACL flow engine to track packet hits
and bytes. This enables flow aging and traffic monitoring for
ACL rules.

Implementation includes:
- Add acl-stat-type devarg to configure statistics type
- Implement sxe2_drv_flow_acl_get_stat_id for stat allocation
- Implement sxe2_drv_flow_acl_free_stat for stat cleanup
- Implement sxe2_drv_flow_acl_query_stat for stat query
- Integrate stat operations into flow create/destroy/query paths

Statistics are accumulated in manager context and reported through
rte_flow_query() interface with COUNT action.

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/sxe2_cmd_chnl.c          |  73 +++++++++++++-
 drivers/net/sxe2/sxe2_cmd_chnl.h          |   9 +-
 drivers/net/sxe2/sxe2_drv_cmd.h           |  17 ++++
 drivers/net/sxe2/sxe2_dump.c              |   2 +
 drivers/net/sxe2/sxe2_ethdev.c            |  25 +++--
 drivers/net/sxe2/sxe2_ethdev.h            |   1 +
 drivers/net/sxe2/sxe2_flow.c              | 111 ++++++++++++++++------
 drivers/net/sxe2/sxe2_flow.h              |   6 +-
 drivers/net/sxe2/sxe2_flow_define.h       |  13 +--
 drivers/net/sxe2/sxe2_flow_parse_action.c |  19 +++-
 drivers/net/sxe2/sxe2_queue.c             |   2 +
 11 files changed, 225 insertions(+), 53 deletions(-)

diff --git a/drivers/net/sxe2/sxe2_cmd_chnl.c b/drivers/net/sxe2/sxe2_cmd_chnl.c
index 9ed5559eff..b2dbd4457d 100644
--- a/drivers/net/sxe2/sxe2_cmd_chnl.c
+++ b/drivers/net/sxe2/sxe2_cmd_chnl.c
@@ -1914,7 +1914,7 @@ int32_t sxe2_drv_flow_fnav_free_stat(struct sxe2_adapter *adapter, uint32_t stat
 }
 
 int32_t sxe2_drv_flow_fnav_query_stat(struct sxe2_adapter *adapter,
-		struct sxe2_fnav_cid_mgr *mgr)
+		struct sxe2_flow_cid_mgr *mgr)
 {
 	struct sxe2_drv_flow_fnav_query_stat_req req = { 0 };
 	struct sxe2_drv_flow_fnav_query_stat_resp resp = { 0 };
@@ -1943,6 +1943,77 @@ int32_t sxe2_drv_flow_fnav_query_stat(struct sxe2_adapter *adapter,
 	return ret;
 }
 
+int32_t sxe2_drv_flow_acl_get_stat_id(struct sxe2_adapter *adapter, uint32_t *stat_id)
+{
+	struct sxe2_drv_flow_fnav_get_stat_id_req req = { 0 };
+	struct sxe2_drv_flow_fnav_get_stat_id_resp resp = { 0 };
+	struct sxe2_drv_cmd_params cmd             = { 0 };
+	struct sxe2_common_device *cdev = adapter->cdev;
+	int32_t ret                                 = -1;
+
+	sxe2_drv_cmd_params_fill(adapter, &cmd, SXE2_DRV_CMD_FLOW_ACL_STAT_ALLOC,
+				&req, sizeof(req),
+				&resp, sizeof(resp));
+	ret = sxe2_drv_cmd_exec(cdev, &cmd);
+	if (ret) {
+		PMD_DEV_LOG_ERR(adapter, DRV, "Failed to get acl stat id, ret: %d.", ret);
+		goto l_end;
+	}
+	*stat_id = resp.stat_id;
+
+l_end:
+	return ret;
+}
+
+int32_t sxe2_drv_flow_acl_free_stat(struct sxe2_adapter *adapter, uint32_t stat_id)
+{
+	struct sxe2_drv_flow_fnav_free_stat_id_req req = { 0 };
+	struct sxe2_drv_cmd_params cmd             = { 0 };
+	struct sxe2_common_device *cdev = adapter->cdev;
+	int32_t ret                                 = -1;
+
+	req.stat_id = stat_id;
+	sxe2_drv_cmd_params_fill(adapter, &cmd, SXE2_DRV_CMD_FLOW_ACL_STAT_FREE,
+				&req, sizeof(req),
+				NULL, 0);
+	ret = sxe2_drv_cmd_exec(cdev, &cmd);
+	if (ret) {
+		PMD_DEV_LOG_ERR(adapter, DRV, "Failed to free acl stat id, ret: %d.", ret);
+		goto l_end;
+	}
+
+l_end:
+	return ret;
+}
+
+int32_t sxe2_drv_flow_acl_query_stat(struct sxe2_adapter *adapter,
+				     struct sxe2_flow_cid_mgr *mgr)
+{
+	struct sxe2_drv_acl_query_stat_req req = { 0 };
+	struct sxe2_drv_acl_query_stat_resp resp = { 0 };
+	struct sxe2_drv_cmd_params cmd             = { 0 };
+	struct sxe2_common_device *cdev = adapter->cdev;
+	int32_t ret                                 = -1;
+
+	req.stat_id = mgr->stat_index;
+	req.stat_ctrl = mgr->count_type;
+	req.is_clear = 1;
+
+	sxe2_drv_cmd_params_fill(adapter, &cmd, SXE2_DRV_CMD_FLOW_ACL_STAT_QUERY,
+				 &req, sizeof(req), &resp, sizeof(resp));
+	ret = sxe2_drv_cmd_exec(cdev, &cmd);
+	if (ret) {
+		PMD_DEV_LOG_ERR(adapter, DRV, "Failed to query ACL stat, stat id: %u, ret: %d.",
+				req.stat_id, ret);
+		goto l_end;
+	}
+	mgr->hits += resp.stat_hits;
+	mgr->bytes += resp.stat_bytes;
+
+l_end:
+	return ret;
+}
+
 int32_t sxe2_drv_srcvsi_prune_config(struct sxe2_adapter *adapter,
 			uint16_t *vsi_list, uint16_t vsi_cnt, bool set)
 {
diff --git a/drivers/net/sxe2/sxe2_cmd_chnl.h b/drivers/net/sxe2/sxe2_cmd_chnl.h
index d63caad526..7d75a91061 100644
--- a/drivers/net/sxe2/sxe2_cmd_chnl.h
+++ b/drivers/net/sxe2/sxe2_cmd_chnl.h
@@ -165,7 +165,14 @@ int32_t sxe2_drv_flow_fnav_get_stat_id(struct sxe2_adapter *adapter, uint32_t *s
 int32_t sxe2_drv_flow_fnav_free_stat(struct sxe2_adapter *adapter, uint32_t stat_id);
 
 int32_t sxe2_drv_flow_fnav_query_stat(struct sxe2_adapter *adapter,
-		struct sxe2_fnav_cid_mgr *mgr);
+		struct sxe2_flow_cid_mgr *mgr);
+
+int32_t sxe2_drv_flow_acl_get_stat_id(struct sxe2_adapter *adapter, uint32_t *stat_id);
+
+int32_t sxe2_drv_flow_acl_free_stat(struct sxe2_adapter *adapter, uint32_t stat_id);
+
+int32_t sxe2_drv_flow_acl_query_stat(struct sxe2_adapter *adapter,
+			struct sxe2_flow_cid_mgr *mgr);
 
 int32_t sxe2_drv_srcvsi_prune_config(struct sxe2_adapter *adapter,
 		uint16_t *vsi_list, uint16_t vsi_cnt, bool set);
diff --git a/drivers/net/sxe2/sxe2_drv_cmd.h b/drivers/net/sxe2/sxe2_drv_cmd.h
index 03ef3b315d..d332d15980 100644
--- a/drivers/net/sxe2/sxe2_drv_cmd.h
+++ b/drivers/net/sxe2/sxe2_drv_cmd.h
@@ -668,6 +668,18 @@ struct __rte_aligned(4) __rte_packed_begin sxe2_drv_vsi_fc_get_resp {
 	uint8_t rsv[3];
 } __rte_packed_end;
 
+struct __rte_aligned(4) __rte_packed_begin sxe2_drv_acl_query_stat_req {
+	uint32_t stat_id;
+	uint32_t stat_ctrl;
+	uint32_t is_clear;
+} __rte_packed_end;
+
+struct __rte_aligned(4) __rte_packed_begin sxe2_drv_acl_query_stat_resp {
+	uint32_t stat_index;
+	uint64_t stat_hits;
+	uint64_t stat_bytes;
+} __rte_packed_end;
+
 enum sxe2_drv_cmd_module {
 	SXE2_DRV_CMD_MODULE_HANDSHAKE = 0,
 	SXE2_DRV_CMD_MODULE_DEV = 1,
@@ -824,6 +836,11 @@ enum sxe2_drv_cmd_code {
 	SXE2_DRV_CMD_OPT_EEP_GET =
 		SXE2_MK_DRV_CMD(SXE2_DRV_CMD_MODULE_OPT, 1),
 
+	SXE2_DRV_CMD_FLOW_ACL_STAT_QUERY =
+		SXE2_MK_DRV_CMD(SXE2_DRV_CMD_MODULE_ACL, 1),
+	SXE2_DRV_CMD_FLOW_ACL_STAT_ALLOC,
+	SXE2_DRV_CMD_FLOW_ACL_STAT_FREE,
+
 };
 
 #endif /* SXE2_DRV_CMD_H */
diff --git a/drivers/net/sxe2/sxe2_dump.c b/drivers/net/sxe2/sxe2_dump.c
index 590219f502..31f7d6ba61 100644
--- a/drivers/net/sxe2/sxe2_dump.c
+++ b/drivers/net/sxe2/sxe2_dump.c
@@ -80,12 +80,14 @@ sxe2_dump_dev_args_info(FILE *file, struct rte_eth_dev *dev)
 		"\t  -- no_sched_mode: %s\n"
 		"\t  -- flow-duplicate-pattern: %u\n"
 		"\t  -- fnav-stat-type: %u\n"
+		"\t  -- acl-stat-type: %u\n"
 		"\t  -- sched_layer_mode: %u\n"
 		"\t  -- rx_low_latency: %s\n"
 		"\t  -- function-flow-direct: %s\n",
 		adapter->devargs.no_sched_mode ? "On" : "Off",
 		adapter->devargs.flow_dup_pattern_mode,
 		adapter->devargs.fnav_stat_type,
+		adapter->devargs.acl_stat_type,
 		adapter->devargs.sched_layer_mode,
 		adapter->devargs.rx_low_latency ? "On" : "Off",
 		adapter->devargs.func_flow_direct_en ? "On" : "Off");
diff --git a/drivers/net/sxe2/sxe2_ethdev.c b/drivers/net/sxe2/sxe2_ethdev.c
index 8bbfdc3a15..3c3e78125d 100644
--- a/drivers/net/sxe2/sxe2_ethdev.c
+++ b/drivers/net/sxe2/sxe2_ethdev.c
@@ -44,7 +44,7 @@
 
 #define SXE2_PCI_VENDOR_ID_1    0x1ff2
 #define SXE2_PCI_DEVICE_ID_PF_1 0x10b1
-#define SXE2_PCI_DEVICE_ID_VF_1 0x10b
+#define SXE2_PCI_DEVICE_ID_VF_1 0x10b2
 
 #define SXE2_PCI_VENDOR_ID_2    0x1d94
 #define SXE2_PCI_DEVICE_ID_PF_2 0x1260
@@ -72,6 +72,7 @@ static const struct rte_pci_id pci_id_sxe2_tbl[] = {
 #define SXE2_DEVARG_FLOW_DUP_PATTERN_MODE "flow-duplicate-pattern"
 #define SXE2_DEVARG_FUNC_FLOW_DIRCT "function-flow-direct"
 #define SXE2_DEVARG_FNAV_STAT_TYPE "fnav-stat-type"
+#define SXE2_DEVARG_ACL_STAT_TYPE "acl-stat-type"
 #define SXE2_DEVARG_NO_SCHED_MODE "no-sched-mode"
 #define SXE2_DEVARG_SCHED_LAYER_MODE "sched-layer-mode"
 #define SXE2_DEVARG_RX_LOW_LATENCY "rx-low-latency"
@@ -971,11 +972,11 @@ sxe2_buffer_split_supported_hdr_ptypes_get(struct rte_eth_dev *dev __rte_unused,
 	return ptypes;
 }
 
-static int32_t sxe2_parse_fnav_stat_type(const char *key, const char *value, void *args)
+static int32_t sxe2_parse_stat_type(const char *key, const char *value, void *args)
 {
 	int32_t ret = -EINVAL;
 	uint8_t *num = (uint8_t *)args;
-	unsigned long fnav_stat_type;
+	unsigned long stat_type;
 	char *endptr = NULL;
 
 	if (value == NULL || args == NULL) {
@@ -983,19 +984,19 @@ static int32_t sxe2_parse_fnav_stat_type(const char *key, const char *value, voi
 		goto l_end;
 	}
 	errno = 0;
-	fnav_stat_type = strtoul(value, &endptr, 10);
+	stat_type = strtoul(value, &endptr, 10);
 	if (errno != 0 || endptr == value || *endptr != '\0') {
 		PMD_LOG_WARN(INIT, "%s: \"%s\" is not a valid int value.",
 			key, value);
 		goto l_end;
 	}
-	if (fnav_stat_type > SXE2_FNAV_STAT_ENA_ALL ||
-		fnav_stat_type == SXE2_FNAV_STAT_ENA_NONE) {
+	if (stat_type > SXE2_FNAV_STAT_ENA_ALL ||
+		stat_type == SXE2_FNAV_STAT_ENA_NONE) {
 		PMD_LOG_ERR(INIT, "%s: \"%s\" out of range [1-3].",
 			key, value);
 		goto l_end;
 	}
-	*num = (uint8_t)fnav_stat_type;
+	*num = (uint8_t)stat_type;
 	ret = 0;
 l_end:
 	return ret;
@@ -1177,13 +1178,20 @@ static int32_t sxe2_args_parse(struct rte_eth_dev *dev, struct sxe2_dev_kvargs_i
 	if (kvargs == NULL)
 		goto l_end;
 	ret = sxe2_kvargs_process(kvargs, SXE2_DEVARG_FNAV_STAT_TYPE,
-				 &sxe2_parse_fnav_stat_type,
+				 &sxe2_parse_stat_type,
 				 &adapter->devargs.fnav_stat_type);
 	if (ret) {
 		PMD_DEV_LOG_ERR(adapter, INIT, "Failed to parse fnav stat type, ret:%d", ret);
 		goto l_end;
 	}
 
+	ret = sxe2_kvargs_process(kvargs, SXE2_DEVARG_ACL_STAT_TYPE,
+				 &sxe2_parse_stat_type, &adapter->devargs.acl_stat_type);
+	if (ret) {
+		PMD_DEV_LOG_ERR(adapter, INIT, "Failed to parse acl stat type, ret:%d", ret);
+		goto l_end;
+	}
+
 	ret = sxe2_kvargs_process(kvargs, SXE2_DEVARG_NO_SCHED_MODE,
 				 &sxe2_parse_bool,
 				 &adapter->devargs.no_sched_mode);
@@ -2350,6 +2358,7 @@ RTE_PMD_REGISTER_PARAM_STRING(net_sxe2,
 	"flow-duplicate-pattern=<0|1|2> "
 	"function-flow-direct=<0|1> "
 	"fnav-stat-type=<1|2|3> "
+	"acl-stat-type=<1|2|3> "
 	"no-sched-mode=<0|1> "
 	"sched-layer-mode=<0-3> "
 	"rx-low-latency=<0|1>");
diff --git a/drivers/net/sxe2/sxe2_ethdev.h b/drivers/net/sxe2/sxe2_ethdev.h
index 158198d74b..7e495e5cb9 100644
--- a/drivers/net/sxe2/sxe2_ethdev.h
+++ b/drivers/net/sxe2/sxe2_ethdev.h
@@ -138,6 +138,7 @@ struct sxe2_devargs {
 	uint8_t flow_dup_pattern_mode;
 	uint8_t func_flow_direct_en;
 	uint8_t fnav_stat_type;
+	uint8_t acl_stat_type;
 	uint8_t no_sched_mode;
 	uint8_t sched_layer_mode;
 	uint8_t rx_low_latency;
diff --git a/drivers/net/sxe2/sxe2_flow.c b/drivers/net/sxe2/sxe2_flow.c
index cf54803301..3cf98dd294 100644
--- a/drivers/net/sxe2/sxe2_flow.c
+++ b/drivers/net/sxe2/sxe2_flow.c
@@ -857,7 +857,7 @@ static int32_t sxe2_flow_rte_list_free(struct sxe2_adapter *adapter,
 	struct rte_flow *flow_temp = NULL;
 	struct sxe2_flow *hw_flow = NULL;
 	struct sxe2_flow *hw_flow_temp = NULL;
-	struct sxe2_fnav_cid_mgr *mgr = NULL;
+	struct sxe2_flow_cid_mgr *mgr = NULL;
 	rte_spinlock_lock(&adapter->flow_ctxt.flow_list_lock);
 	TAILQ_FOREACH(flow_temp, &adapter->flow_ctxt.rte_flow_list, next) {
 		if (flow_temp == flow)
@@ -1028,7 +1028,7 @@ static struct rte_flow *sxe2_flow_create(struct rte_eth_dev *dev,
 		goto l_free_flow;
 
 	TAILQ_FOREACH(flow, &flow_list->sxe2_flow_list, next) {
-		ret = sxe2_fnav_get_filter_cid(adapter, flow);
+		ret = sxe2_flow_get_filter_cid(adapter, flow);
 		if (ret != 0) {
 			PMD_LOG_ERR(DRV, "fnav get stats id failed, ret:%d", ret);
 			rte_flow_error_set(error, EIO,
@@ -1088,16 +1088,26 @@ static int32_t sxe2_flow_flush(struct rte_eth_dev *dev, struct rte_flow_error *e
 	return ret;
 }
 
-int32_t sxe2_fnav_get_filter_cid(struct sxe2_adapter *adapter, struct sxe2_flow *flow)
+int32_t sxe2_flow_get_filter_cid(struct sxe2_adapter *adapter, struct sxe2_flow *flow)
 {
 	int32_t ret = 0;
-	struct sxe2_fnav_cid_mgr_list_t *cid_mgr_list =
-				&adapter->flow_ctxt.hw_res.fnav_cid_mgr_list;
+	struct sxe2_flow_cid_mgr_list_t *cid_mgr_list = NULL;
 	uint32_t stat_index;
 	uint32_t user_id;
 	uint32_t driver_id;
-	struct sxe2_fnav_cid_mgr *temp = NULL;
-	struct sxe2_fnav_cid_mgr *mgr = NULL;
+	struct sxe2_flow_cid_mgr *temp = NULL;
+	struct sxe2_flow_cid_mgr *mgr = NULL;
+	uint32_t count_type;
+
+	if (flow->engine_type == SXE2_FLOW_ENGINE_FNAV) {
+		cid_mgr_list = &adapter->flow_ctxt.fnav_hw_res.flow_cid_mgr_list;
+		count_type = adapter->flow_ctxt.fnav_hw_res.count_type;
+	} else if (flow->engine_type == SXE2_FLOW_ENGINE_ACL) {
+		cid_mgr_list = &adapter->flow_ctxt.acl_hw_res.flow_cid_mgr_list;
+		count_type = adapter->flow_ctxt.acl_hw_res.count_type;
+	} else {
+		goto l_end;
+	}
 
 	if (sxe2_test_bit(SXE2_FLOW_ACTION_COUNT, flow->action.act_types)) {
 		user_id = flow->action.count.user_id;
@@ -1112,7 +1122,7 @@ int32_t sxe2_fnav_get_filter_cid(struct sxe2_adapter *adapter, struct sxe2_flow
 		}
 		if (mgr == NULL) {
 			mgr = rte_zmalloc("sxe2_fnav_cid_mgr",
-				sizeof(struct sxe2_fnav_cid_mgr), 0);
+				sizeof(struct sxe2_flow_cid_mgr), 0);
 			if (!mgr) {
 				PMD_LOG_ERR(DRV,
 					"Failed to alloc sxe2vf_fnav_cid_mgr memory.");
@@ -1120,7 +1130,10 @@ int32_t sxe2_fnav_get_filter_cid(struct sxe2_adapter *adapter, struct sxe2_flow
 				goto l_end;
 			}
 
-			ret = sxe2_drv_flow_fnav_get_stat_id(adapter, &stat_index);
+			if (flow->engine_type == SXE2_FLOW_ENGINE_FNAV)
+				ret = sxe2_drv_flow_fnav_get_stat_id(adapter, &stat_index);
+			else if (flow->engine_type == SXE2_FLOW_ENGINE_ACL)
+				ret = sxe2_drv_flow_acl_get_stat_id(adapter, &stat_index);
 			if (ret) {
 				PMD_LOG_ERR(DRV, "Failed to alloc fw count id.");
 				rte_free(mgr);
@@ -1131,7 +1144,7 @@ int32_t sxe2_fnav_get_filter_cid(struct sxe2_adapter *adapter, struct sxe2_flow
 			mgr->user_id = user_id;
 			mgr->driver_id = driver_id;
 			mgr->stat_index = stat_index;
-			mgr->count_type = adapter->flow_ctxt.hw_res.count_type;
+			mgr->count_type = count_type;
 		}
 		flow->action.count.stat_index = mgr->stat_index;
 		flow->action.count.stat_ctrl = mgr->count_type;
@@ -1143,17 +1156,24 @@ int32_t sxe2_fnav_get_filter_cid(struct sxe2_adapter *adapter, struct sxe2_flow
 
 int32_t sxe2_flow_free_mgr(struct sxe2_adapter *adapter,
 		       struct sxe2_flow *flow,
-		       struct sxe2_fnav_cid_mgr **mgr_ptr,
+		       struct sxe2_flow_cid_mgr **mgr_ptr,
 		       struct rte_flow_error *error)
 {
 	int32_t ret = 0;
-	struct sxe2_fnav_cid_mgr_list_t *cid_mgr_list =
-				&adapter->flow_ctxt.hw_res.fnav_cid_mgr_list;
-	struct sxe2_fnav_cid_mgr *mgr = *mgr_ptr;
+	struct sxe2_flow_cid_mgr_list_t *cid_mgr_list = NULL;
+	struct sxe2_flow_cid_mgr *mgr = *mgr_ptr;
 	uint32_t user_id = flow->action.count.user_id;
-	if (user_id == 0) {
-		TAILQ_REMOVE(cid_mgr_list, mgr, next);
-		ret = sxe2_drv_flow_fnav_free_stat(adapter, mgr->stat_index);
+
+	if (user_id == 0 && mgr) {
+		if (flow->engine_type == SXE2_FLOW_ENGINE_ACL) {
+			cid_mgr_list = &adapter->flow_ctxt.acl_hw_res.flow_cid_mgr_list;
+			TAILQ_REMOVE(cid_mgr_list, mgr, next);
+			ret = sxe2_drv_flow_acl_free_stat(adapter, mgr->stat_index);
+		} else if (flow->engine_type == SXE2_FLOW_ENGINE_FNAV) {
+			cid_mgr_list = &adapter->flow_ctxt.fnav_hw_res.flow_cid_mgr_list;
+			TAILQ_REMOVE(cid_mgr_list, mgr, next);
+			ret = sxe2_drv_flow_fnav_free_stat(adapter, mgr->stat_index);
+		}
 		if (ret) {
 			rte_flow_error_set(error, EIO,
 				RTE_FLOW_ERROR_TYPE_ACTION, NULL,
@@ -1170,17 +1190,23 @@ int32_t sxe2_flow_free_mgr(struct sxe2_adapter *adapter,
 
 int32_t sxe2_flow_query_mgr(struct sxe2_adapter *adapter,
 			struct sxe2_flow *flow,
-			struct sxe2_fnav_cid_mgr **mgr_ptr,
+			struct sxe2_flow_cid_mgr **mgr_ptr,
 			struct rte_flow_error *error)
 {
 	int32_t ret = 0;
-	struct sxe2_fnav_cid_mgr_list_t *cid_mgr_list =
-				&adapter->flow_ctxt.hw_res.fnav_cid_mgr_list;
-	struct sxe2_fnav_cid_mgr *temp = NULL;
-	struct sxe2_fnav_cid_mgr *mgr = NULL;
+	struct sxe2_flow_cid_mgr_list_t *cid_mgr_list = NULL;
+	struct sxe2_flow_cid_mgr *temp = NULL;
+	struct sxe2_flow_cid_mgr *mgr = NULL;
 	uint32_t user_id = flow->action.count.user_id;
 	uint32_t driver_id = flow->action.count.driver_id;
 
+	if (flow->engine_type == SXE2_FLOW_ENGINE_ACL)
+		cid_mgr_list = &adapter->flow_ctxt.acl_hw_res.flow_cid_mgr_list;
+	else if (flow->engine_type == SXE2_FLOW_ENGINE_FNAV)
+		cid_mgr_list = &adapter->flow_ctxt.fnav_hw_res.flow_cid_mgr_list;
+	else
+		goto l_end;
+
 	TAILQ_FOREACH(temp, cid_mgr_list, next) {
 		if (temp->user_id == user_id &&
 			temp->driver_id == driver_id) {
@@ -1197,7 +1223,15 @@ int32_t sxe2_flow_query_mgr(struct sxe2_adapter *adapter,
 		ret = -EINVAL;
 		goto l_end;
 	}
-	ret = sxe2_drv_flow_fnav_query_stat(adapter, mgr);
+
+	if (flow->engine_type == SXE2_FLOW_ENGINE_ACL) {
+		ret = sxe2_drv_flow_acl_query_stat(adapter, mgr);
+	} else if (flow->engine_type == SXE2_FLOW_ENGINE_FNAV) {
+		ret = sxe2_drv_flow_fnav_query_stat(adapter, mgr);
+	} else {
+		PMD_LOG_ERR(DRV, "query flow engine neither FNAV nor ACL");
+		ret = -ENOTSUP;
+	}
 	if (ret) {
 		rte_flow_error_set(error, EINVAL,
 			RTE_FLOW_ERROR_TYPE_ITEM, NULL,
@@ -1218,7 +1252,7 @@ static int32_t sxe2_flow_query_count(struct sxe2_adapter *adapter,
 				 struct rte_flow_error *error)
 {
 	int32_t ret = 0;
-	struct sxe2_fnav_cid_mgr *mgr = NULL;
+	struct sxe2_flow_cid_mgr *mgr = NULL;
 	switch (flow->action.count.stat_ctrl) {
 	case SXE2_FNAV_STAT_ENA_NONE:
 		count->hits_set = 0;
@@ -1348,12 +1382,18 @@ int32_t sxe2_flow_init(struct rte_eth_dev *dev)
 	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
 	int32_t ret = 0;
 	TAILQ_INIT(&adapter->flow_ctxt.rte_flow_list);
-	TAILQ_INIT(&adapter->flow_ctxt.hw_res.fnav_cid_mgr_list);
+	TAILQ_INIT(&adapter->flow_ctxt.fnav_hw_res.flow_cid_mgr_list);
+	TAILQ_INIT(&adapter->flow_ctxt.acl_hw_res.flow_cid_mgr_list);
 	if (adapter->devargs.fnav_stat_type)
-		adapter->flow_ctxt.hw_res.count_type =
+		adapter->flow_ctxt.fnav_hw_res.count_type =
 			adapter->devargs.fnav_stat_type;
 	else
-		adapter->flow_ctxt.hw_res.count_type = SXE2_FNAV_STAT_ENA_ALL;
+		adapter->flow_ctxt.fnav_hw_res.count_type = SXE2_FNAV_STAT_ENA_ALL;
+
+	if (adapter->devargs.acl_stat_type)
+		adapter->flow_ctxt.acl_hw_res.count_type = adapter->devargs.acl_stat_type;
+	else
+		adapter->flow_ctxt.acl_hw_res.count_type = SXE2_FNAV_STAT_ENA_ALL;
 
 	adapter->flow_ctxt.fnav_inited = 1;
 	rte_spinlock_init(&adapter->flow_ctxt.flow_list_lock);
@@ -1370,15 +1410,15 @@ int32_t sxe2_flow_uninit(struct rte_eth_dev *dev)
 	int32_t ret = 0;
 	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
 	struct rte_flow_error error;
-	struct sxe2_fnav_cid_mgr *mgr = NULL;
-	struct sxe2_fnav_cid_mgr *temp = NULL;
-	struct sxe2_fnav_cid_mgr_list_t *cid_mgr_list =
-						&adapter->flow_ctxt.hw_res.fnav_cid_mgr_list;
+	struct sxe2_flow_cid_mgr *mgr = NULL;
+	struct sxe2_flow_cid_mgr *temp = NULL;
+	struct sxe2_flow_cid_mgr_list_t *cid_mgr_list = NULL;
 
 	ret = sxe2_flow_flush(dev, &error);
 	if (ret)
 		PMD_LOG_ERR(DRV, "Failed to flush flow, ret: %d.", ret);
 
+	cid_mgr_list = &adapter->flow_ctxt.fnav_hw_res.flow_cid_mgr_list;
 	TAILQ_FOREACH_SAFE(mgr, cid_mgr_list, next, temp) {
 		TAILQ_REMOVE(cid_mgr_list, mgr, next);
 		ret = sxe2_drv_flow_fnav_free_stat(adapter, mgr->stat_index);
@@ -1387,5 +1427,14 @@ int32_t sxe2_flow_uninit(struct rte_eth_dev *dev)
 				"Failed to free fnav stat id, ret: %d.", ret);
 		rte_free(mgr);
 	}
+
+	cid_mgr_list = &adapter->flow_ctxt.acl_hw_res.flow_cid_mgr_list;
+	TAILQ_FOREACH_SAFE(mgr, cid_mgr_list, next, temp) {
+		TAILQ_REMOVE(cid_mgr_list, mgr, next);
+		ret = sxe2_drv_flow_acl_free_stat(adapter, mgr->stat_index);
+		if (ret)
+			PMD_LOG_ERR(DRV, "Failed to free acl stat id, ret: %d.", ret);
+		rte_free(mgr);
+	}
 	return ret;
 }
diff --git a/drivers/net/sxe2/sxe2_flow.h b/drivers/net/sxe2/sxe2_flow.h
index daaeedd4dc..8d47b11ff4 100644
--- a/drivers/net/sxe2/sxe2_flow.h
+++ b/drivers/net/sxe2/sxe2_flow.h
@@ -14,16 +14,16 @@ int32_t sxe2_flow_init(struct rte_eth_dev *dev);
 
 int32_t sxe2_flow_uninit(struct rte_eth_dev *dev);
 
-int32_t sxe2_fnav_get_filter_cid(struct sxe2_adapter *adapter, struct sxe2_flow *flow);
+int32_t sxe2_flow_get_filter_cid(struct sxe2_adapter *adapter, struct sxe2_flow *flow);
 
 int32_t sxe2_flow_free_mgr(struct sxe2_adapter *adapter,
 		       struct sxe2_flow *flow,
-		       struct sxe2_fnav_cid_mgr **mgr_ptr,
+		       struct sxe2_flow_cid_mgr **mgr_ptr,
 		       struct rte_flow_error *error);
 
 int32_t sxe2_flow_query_mgr(struct sxe2_adapter *adapter,
 			struct sxe2_flow *flow,
-			struct sxe2_fnav_cid_mgr **mgr_ptr,
+			struct sxe2_flow_cid_mgr **mgr_ptr,
 			struct rte_flow_error *error);
 
 int32_t sxe2_flow_init_udp_tunnel_port(struct rte_eth_dev *dev);
diff --git a/drivers/net/sxe2/sxe2_flow_define.h b/drivers/net/sxe2/sxe2_flow_define.h
index 263a573f04..f56f687dc7 100644
--- a/drivers/net/sxe2/sxe2_flow_define.h
+++ b/drivers/net/sxe2/sxe2_flow_define.h
@@ -98,8 +98,8 @@ struct rte_flow {
 };
 TAILQ_HEAD(rte_flow_list_t, rte_flow);
 
-struct sxe2_fnav_cid_mgr {
-	TAILQ_ENTRY(sxe2_fnav_cid_mgr) next;
+struct sxe2_flow_cid_mgr {
+	TAILQ_ENTRY(sxe2_flow_cid_mgr) next;
 	uint16_t stat_index;
 	uint32_t user_id;
 	uint32_t driver_id;
@@ -107,18 +107,19 @@ struct sxe2_fnav_cid_mgr {
 	uint64_t hits;
 	uint64_t bytes;
 };
-TAILQ_HEAD(sxe2_fnav_cid_mgr_list_t, sxe2_fnav_cid_mgr);
+TAILQ_HEAD(sxe2_flow_cid_mgr_list_t, sxe2_flow_cid_mgr);
 
-struct sxe2_fnav_count_resource {
+struct sxe2_flow_count_resource {
 	uint32_t count_type;
 	uint32_t global_index;
-	struct sxe2_fnav_cid_mgr_list_t fnav_cid_mgr_list;
+	struct sxe2_flow_cid_mgr_list_t flow_cid_mgr_list;
 };
 
 struct sxe2_flow_context {
 	struct rte_flow_list_t rte_flow_list;
 	rte_spinlock_t flow_list_lock;
-	struct sxe2_fnav_count_resource hw_res;
+	struct sxe2_flow_count_resource fnav_hw_res;
+	struct sxe2_flow_count_resource acl_hw_res;
 	uint16_t tunnel_port_list[SXE2_FLOW_UDP_TUNNEL_MAX];
 	uint32_t fnav_inited;
 };
diff --git a/drivers/net/sxe2/sxe2_flow_parse_action.c b/drivers/net/sxe2/sxe2_flow_parse_action.c
index a9559e2d7e..cdd6fcfdcd 100644
--- a/drivers/net/sxe2/sxe2_flow_parse_action.c
+++ b/drivers/net/sxe2/sxe2_flow_parse_action.c
@@ -1037,11 +1037,24 @@ int32_t sxe2_flow_parse_action(struct rte_eth_dev *dev,
 			if (engine_type == SXE2_FLOW_ENGINE_FNAV) {
 				sxe2_set_bit(SXE2_FLOW_ACTION_COUNT, flow->action.act_types);
 				act_count = action->conf;
-				flow->action.count.user_id = act_count->id;
+				flow->action.count.user_id =
+					(act_count == NULL) ? 0 : act_count->id;
 				flow->action.count.driver_id = 0;
-				if (flow->action.count.user_id == 0)
+				if (flow->action.count.user_id == 0) {
 					flow->action.count.driver_id =
-						++adapter->flow_ctxt.hw_res.global_index;
+						++adapter->flow_ctxt.fnav_hw_res.global_index;
+				}
+				action_num[SXE2_FLOW_ACTION_COUNT]++;
+			} else if (engine_type == SXE2_FLOW_ENGINE_ACL) {
+				sxe2_set_bit(SXE2_FLOW_ACTION_COUNT, flow->action.act_types);
+				act_count = action->conf;
+				flow->action.count.user_id =
+					(act_count == NULL) ? 0 : act_count->id;
+				flow->action.count.driver_id = 0;
+				if (flow->action.count.user_id == 0) {
+					flow->action.count.driver_id =
+						++adapter->flow_ctxt.acl_hw_res.global_index;
+				}
 				action_num[SXE2_FLOW_ACTION_COUNT]++;
 			} else {
 				rte_flow_error_set(error, ENOTSUP,
diff --git a/drivers/net/sxe2/sxe2_queue.c b/drivers/net/sxe2/sxe2_queue.c
index afb2681b72..3aaa14c685 100644
--- a/drivers/net/sxe2/sxe2_queue.c
+++ b/drivers/net/sxe2/sxe2_queue.c
@@ -39,6 +39,8 @@ int32_t sxe2_queues_init(struct rte_eth_dev *dev)
 		rxq->rx_buf_len = RTE_MIN(rxq->rx_buf_len, SXE2_RX_MAX_DATA_BUF_SIZE);
 		if (frame_size > rxq->rx_buf_len)
 			dev->data->scattered_rx = 1;
+		if (adapter->flow_ctxt.fnav_inited)
+			rxq->fnav_enable = true;
 	}
 
 	adapter->ptp_ctxt.mbuf_rx_ts_offset = -1;
-- 
2.52.0

