Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE9C8F01821
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Mar 2026 10:59:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2475541141;
	Fri,  6 Mar 2026 11:58:39 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 840C540E15
 for <dev@dpdk.org>; Fri,  6 Mar 2026 11:58:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772794716; x=1804330716;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=E42FPMbWzooDaE15l/vE10i6J+zsjX5nmDWwTTOmS9w=;
 b=jkahyk4YIUhspCxpe1IKAd3e3bmNMJTlTbSx03YIuUnegTU33hTwTV7t
 VZJKRF76xM6LFv9aRR8PXDc62W1qQktFK61FNzUvrsOnLx+uF2nvNFeCP
 UJeNdIH/Uh4Fh4RLcqMq+a4gZFSCp4FRdjBb+55eR5K3oNaxyr+V8Opxt
 MNYxS9cSfgxhrsqjwQ+k+t3FYMLprVOcaE893WLqkxaiAOtCGpF9I4aK9
 sq1XQSHcTEwuDG2WPg4NliHOBmK9Nc7R1RIrLu6vl5GQfEtiTMluu8QGl
 CFH3e1tOP0mzl3v51Iu6eFv+V3nR8LRL85qqn7i7oQtqI0T9ThTnAGkZU A==;
X-CSE-ConnectionGUID: qiR9VrO+R/iLvn8ErkS8aA==
X-CSE-MsgGUID: LJWcbH6wT7up1qMOGsOPcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="84984558"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="84984558"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2026 02:58:35 -0800
X-CSE-ConnectionGUID: Y0OVbbMtRD6ykf+zJYQurg==
X-CSE-MsgGUID: wPrPxRkgS+OfW7PF1SkEZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="215678408"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa006.fm.intel.com with ESMTP; 06 Mar 2026 02:58:34 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v3 7/8] net/iavf: do not use global virtchnl buffer
Date: Fri,  6 Mar 2026 10:58:23 +0000
Message-ID: <9707d07db39235f40cfac7cf7ec7bec96506ec14.1772794442.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1772794442.git.anatoly.burakov@intel.com>
 <cover.1772794442.git.anatoly.burakov@intel.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Currently, a lot of virtchnl requests will use global virtchnl output
buffer as their `out_buffer` for VF requests. This was originally done this
way because most requests were done asynchronously and the response was not
written directly into the `out_buffer`. This is no longer the case, so the
per-command buffers can be safely replaced with stack allocated buffers.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/iavf/iavf_vchnl.c | 147 +++++++++++++++++-----------
 1 file changed, 89 insertions(+), 58 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index 250816c24a..1e98503b31 100644
--- a/drivers/net/intel/iavf/iavf_vchnl.c
+++ b/drivers/net/intel/iavf/iavf_vchnl.c
@@ -650,7 +650,7 @@ iavf_handle_virtchnl_msg(struct rte_eth_dev *dev)
 int
 iavf_enable_vlan_strip(struct iavf_adapter *adapter)
 {
-	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	struct iavf_cmd_info args;
 	int ret;
 
@@ -658,7 +658,7 @@ iavf_enable_vlan_strip(struct iavf_adapter *adapter)
 	args.ops = VIRTCHNL_OP_ENABLE_VLAN_STRIPPING;
 	args.in_args = NULL;
 	args.in_args_size = 0;
-	args.out_buffer = vf->aq_resp;
+	args.out_buffer = msg_buf;
 	args.out_size = IAVF_AQ_BUF_SZ;
 	ret = iavf_execute_vf_cmd_safe(adapter, &args);
 	if (ret)
@@ -671,7 +671,7 @@ iavf_enable_vlan_strip(struct iavf_adapter *adapter)
 int
 iavf_disable_vlan_strip(struct iavf_adapter *adapter)
 {
-	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	struct iavf_cmd_info args;
 	int ret;
 
@@ -679,7 +679,7 @@ iavf_disable_vlan_strip(struct iavf_adapter *adapter)
 	args.ops = VIRTCHNL_OP_DISABLE_VLAN_STRIPPING;
 	args.in_args = NULL;
 	args.in_args_size = 0;
-	args.out_buffer = vf->aq_resp;
+	args.out_buffer = msg_buf;
 	args.out_size = IAVF_AQ_BUF_SZ;
 	ret = iavf_execute_vf_cmd_safe(adapter, &args);
 	if (ret)
@@ -698,6 +698,7 @@ iavf_check_api_version(struct iavf_adapter *adapter)
 {
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
 	struct virtchnl_version_info version, *pver;
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	struct iavf_cmd_info args;
 	int err;
 
@@ -707,7 +708,7 @@ iavf_check_api_version(struct iavf_adapter *adapter)
 	args.ops = VIRTCHNL_OP_VERSION;
 	args.in_args = (uint8_t *)&version;
 	args.in_args_size = sizeof(version);
-	args.out_buffer = vf->aq_resp;
+	args.out_buffer = msg_buf;
 	args.out_size = IAVF_AQ_BUF_SZ;
 
 	err = iavf_execute_vf_cmd_safe(adapter, &args);
@@ -747,12 +748,13 @@ iavf_get_vf_resource(struct iavf_adapter *adapter)
 {
 	struct iavf_hw *hw = IAVF_DEV_PRIVATE_TO_HW(adapter);
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	struct iavf_cmd_info args;
 	uint32_t caps, len;
 	int err, i;
 
 	args.ops = VIRTCHNL_OP_GET_VF_RESOURCES;
-	args.out_buffer = vf->aq_resp;
+	args.out_buffer = msg_buf;
 	args.out_size = IAVF_AQ_BUF_SZ;
 
 	caps = IAVF_BASIC_OFFLOAD_CAPS | VIRTCHNL_VF_CAP_ADV_LINK_SPEED |
@@ -808,13 +810,14 @@ int
 iavf_get_supported_rxdid(struct iavf_adapter *adapter)
 {
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	struct iavf_cmd_info args;
 	int ret;
 
 	args.ops = VIRTCHNL_OP_GET_SUPPORTED_RXDIDS;
 	args.in_args = NULL;
 	args.in_args_size = 0;
-	args.out_buffer = vf->aq_resp;
+	args.out_buffer = msg_buf;
 	args.out_size = IAVF_AQ_BUF_SZ;
 
 	ret = iavf_execute_vf_cmd_safe(adapter, &args);
@@ -836,6 +839,7 @@ iavf_config_vlan_strip_v2(struct iavf_adapter *adapter, bool enable)
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
 	struct virtchnl_vlan_supported_caps *stripping_caps;
 	struct virtchnl_vlan_setting vlan_strip;
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	struct iavf_cmd_info args;
 	uint32_t *ethertype;
 	int ret;
@@ -859,7 +863,7 @@ iavf_config_vlan_strip_v2(struct iavf_adapter *adapter, bool enable)
 			    VIRTCHNL_OP_DISABLE_VLAN_STRIPPING_V2;
 	args.in_args = (uint8_t *)&vlan_strip;
 	args.in_args_size = sizeof(vlan_strip);
-	args.out_buffer = vf->aq_resp;
+	args.out_buffer = msg_buf;
 	args.out_size = IAVF_AQ_BUF_SZ;
 	ret = iavf_execute_vf_cmd_safe(adapter, &args);
 	if (ret)
@@ -876,6 +880,7 @@ iavf_config_vlan_insert_v2(struct iavf_adapter *adapter, bool enable)
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
 	struct virtchnl_vlan_supported_caps *insertion_caps;
 	struct virtchnl_vlan_setting vlan_insert;
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	struct iavf_cmd_info args;
 	uint32_t *ethertype;
 	int ret;
@@ -899,7 +904,7 @@ iavf_config_vlan_insert_v2(struct iavf_adapter *adapter, bool enable)
 			    VIRTCHNL_OP_DISABLE_VLAN_INSERTION_V2;
 	args.in_args = (uint8_t *)&vlan_insert;
 	args.in_args_size = sizeof(vlan_insert);
-	args.out_buffer = vf->aq_resp;
+	args.out_buffer = msg_buf;
 	args.out_size = IAVF_AQ_BUF_SZ;
 	ret = iavf_execute_vf_cmd_safe(adapter, &args);
 	if (ret)
@@ -916,6 +921,7 @@ iavf_add_del_vlan_v2(struct iavf_adapter *adapter, uint16_t vlanid, bool add)
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
 	struct virtchnl_vlan_supported_caps *supported_caps;
 	struct virtchnl_vlan_filter_list_v2 vlan_filter;
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	struct virtchnl_vlan *vlan_setting;
 	struct iavf_cmd_info args;
 	uint32_t filtering_caps;
@@ -942,7 +948,7 @@ iavf_add_del_vlan_v2(struct iavf_adapter *adapter, uint16_t vlanid, bool add)
 	args.ops = add ? VIRTCHNL_OP_ADD_VLAN_V2 : VIRTCHNL_OP_DEL_VLAN_V2;
 	args.in_args = (uint8_t *)&vlan_filter;
 	args.in_args_size = sizeof(vlan_filter);
-	args.out_buffer = vf->aq_resp;
+	args.out_buffer = msg_buf;
 	args.out_size = IAVF_AQ_BUF_SZ;
 	err = iavf_execute_vf_cmd_safe(adapter, &args);
 	if (err)
@@ -956,13 +962,14 @@ int
 iavf_get_vlan_offload_caps_v2(struct iavf_adapter *adapter)
 {
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	struct iavf_cmd_info args;
 	int ret;
 
 	args.ops = VIRTCHNL_OP_GET_OFFLOAD_VLAN_V2_CAPS;
 	args.in_args = NULL;
 	args.in_args_size = 0;
-	args.out_buffer = vf->aq_resp;
+	args.out_buffer = msg_buf;
 	args.out_size = IAVF_AQ_BUF_SZ;
 
 	ret = iavf_execute_vf_cmd_safe(adapter, &args);
@@ -972,7 +979,7 @@ iavf_get_vlan_offload_caps_v2(struct iavf_adapter *adapter)
 		return ret;
 	}
 
-	rte_memcpy(&vf->vlan_v2_caps, vf->aq_resp, sizeof(vf->vlan_v2_caps));
+	rte_memcpy(&vf->vlan_v2_caps, args.out_buffer, sizeof(vf->vlan_v2_caps));
 
 	return 0;
 }
@@ -982,6 +989,7 @@ iavf_enable_queues(struct iavf_adapter *adapter)
 {
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
 	struct virtchnl_queue_select queue_select;
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	struct iavf_cmd_info args;
 	int err;
 
@@ -994,7 +1002,7 @@ iavf_enable_queues(struct iavf_adapter *adapter)
 	args.ops = VIRTCHNL_OP_ENABLE_QUEUES;
 	args.in_args = (u8 *)&queue_select;
 	args.in_args_size = sizeof(queue_select);
-	args.out_buffer = vf->aq_resp;
+	args.out_buffer = msg_buf;
 	args.out_size = IAVF_AQ_BUF_SZ;
 	err = iavf_execute_vf_cmd_safe(adapter, &args);
 	if (err) {
@@ -1010,6 +1018,7 @@ iavf_disable_queues(struct iavf_adapter *adapter)
 {
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
 	struct virtchnl_queue_select queue_select;
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	struct iavf_cmd_info args;
 	int err;
 
@@ -1022,7 +1031,7 @@ iavf_disable_queues(struct iavf_adapter *adapter)
 	args.ops = VIRTCHNL_OP_DISABLE_QUEUES;
 	args.in_args = (u8 *)&queue_select;
 	args.in_args_size = sizeof(queue_select);
-	args.out_buffer = vf->aq_resp;
+	args.out_buffer = msg_buf;
 	args.out_size = IAVF_AQ_BUF_SZ;
 	err = iavf_execute_vf_cmd_safe(adapter, &args);
 	if (err) {
@@ -1039,6 +1048,7 @@ iavf_switch_queue(struct iavf_adapter *adapter, uint16_t qid,
 {
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
 	struct virtchnl_queue_select queue_select;
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	struct iavf_cmd_info args;
 	int err;
 
@@ -1058,7 +1068,7 @@ iavf_switch_queue(struct iavf_adapter *adapter, uint16_t qid,
 		args.ops = VIRTCHNL_OP_DISABLE_QUEUES;
 	args.in_args = (u8 *)&queue_select;
 	args.in_args_size = sizeof(queue_select);
-	args.out_buffer = vf->aq_resp;
+	args.out_buffer = msg_buf;
 	args.out_size = IAVF_AQ_BUF_SZ;
 	err = iavf_execute_vf_cmd_safe(adapter, &args);
 	if (err)
@@ -1071,6 +1081,7 @@ int
 iavf_enable_queues_lv(struct iavf_adapter *adapter)
 {
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	struct {
 		struct virtchnl_del_ena_dis_queues msg;
 		struct virtchnl_queue_chunk chunks[IAVF_RXTX_QUEUE_CHUNKS_NUM - 1];
@@ -1096,7 +1107,7 @@ iavf_enable_queues_lv(struct iavf_adapter *adapter)
 	args.ops = VIRTCHNL_OP_ENABLE_QUEUES_V2;
 	args.in_args = (u8 *)queue_select;
 	args.in_args_size = sizeof(queue_req);
-	args.out_buffer = vf->aq_resp;
+	args.out_buffer = msg_buf;
 	args.out_size = IAVF_AQ_BUF_SZ;
 	err = iavf_execute_vf_cmd_safe(adapter, &args);
 	if (err)
@@ -1110,6 +1121,7 @@ int
 iavf_disable_queues_lv(struct iavf_adapter *adapter)
 {
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	struct {
 		struct virtchnl_del_ena_dis_queues msg;
 		struct virtchnl_queue_chunk chunks[IAVF_RXTX_QUEUE_CHUNKS_NUM - 1];
@@ -1135,7 +1147,7 @@ iavf_disable_queues_lv(struct iavf_adapter *adapter)
 	args.ops = VIRTCHNL_OP_DISABLE_QUEUES_V2;
 	args.in_args = (u8 *)queue_select;
 	args.in_args_size = sizeof(queue_req);
-	args.out_buffer = vf->aq_resp;
+	args.out_buffer = msg_buf;
 	args.out_size = IAVF_AQ_BUF_SZ;
 	err = iavf_execute_vf_cmd_safe(adapter, &args);
 	if (err)
@@ -1150,6 +1162,7 @@ iavf_switch_queue_lv(struct iavf_adapter *adapter, uint16_t qid,
 		 bool rx, bool on)
 {
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	struct {
 		struct virtchnl_del_ena_dis_queues msg;
 	} queue_req = {0};
@@ -1177,7 +1190,7 @@ iavf_switch_queue_lv(struct iavf_adapter *adapter, uint16_t qid,
 		args.ops = VIRTCHNL_OP_DISABLE_QUEUES_V2;
 	args.in_args = (u8 *)queue_select;
 	args.in_args_size = sizeof(queue_req);
-	args.out_buffer = vf->aq_resp;
+	args.out_buffer = msg_buf;
 	args.out_size = IAVF_AQ_BUF_SZ;
 	err = iavf_execute_vf_cmd_safe(adapter, &args);
 	if (err)
@@ -1191,6 +1204,7 @@ int
 iavf_configure_rss_lut(struct iavf_adapter *adapter)
 {
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	struct virtchnl_rss_lut *rss_lut;
 	struct iavf_cmd_info args;
 	int len, err = 0;
@@ -1207,7 +1221,7 @@ iavf_configure_rss_lut(struct iavf_adapter *adapter)
 	args.ops = VIRTCHNL_OP_CONFIG_RSS_LUT;
 	args.in_args = (u8 *)rss_lut;
 	args.in_args_size = len;
-	args.out_buffer = vf->aq_resp;
+	args.out_buffer = msg_buf;
 	args.out_size = IAVF_AQ_BUF_SZ;
 
 	err = iavf_execute_vf_cmd_safe(adapter, &args);
@@ -1223,6 +1237,7 @@ int
 iavf_configure_rss_key(struct iavf_adapter *adapter)
 {
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	struct virtchnl_rss_key *rss_key;
 	struct iavf_cmd_info args;
 	int len, err = 0;
@@ -1239,7 +1254,7 @@ iavf_configure_rss_key(struct iavf_adapter *adapter)
 	args.ops = VIRTCHNL_OP_CONFIG_RSS_KEY;
 	args.in_args = (u8 *)rss_key;
 	args.in_args_size = len;
-	args.out_buffer = vf->aq_resp;
+	args.out_buffer = msg_buf;
 	args.out_size = IAVF_AQ_BUF_SZ;
 
 	err = iavf_execute_vf_cmd_safe(adapter, &args);
@@ -1307,6 +1322,7 @@ iavf_configure_queue_chunk(struct iavf_adapter *adapter,
 		uint16_t chunk_start)
 {
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	struct {
 		struct virtchnl_vsi_queue_config_info config;
 		struct virtchnl_queue_pair_info qp[IAVF_CFG_Q_NUM_PER_BUF];
@@ -1335,7 +1351,7 @@ iavf_configure_queue_chunk(struct iavf_adapter *adapter,
 	args.ops = VIRTCHNL_OP_CONFIG_VSI_QUEUES;
 	args.in_args = (uint8_t *)vc_config;
 	args.in_args_size = buf_len;
-	args.out_buffer = vf->aq_resp;
+	args.out_buffer = msg_buf;
 	args.out_size = IAVF_AQ_BUF_SZ;
 
 	err = iavf_execute_vf_cmd_safe(adapter, &args);
@@ -1370,6 +1386,7 @@ int
 iavf_config_irq_map(struct iavf_adapter *adapter)
 {
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	struct {
 		struct virtchnl_irq_map_info map_info;
 		struct virtchnl_vector_map vecmap[IAVF_MAX_NUM_QUEUES_DFLT];
@@ -1419,7 +1436,7 @@ iavf_config_irq_map(struct iavf_adapter *adapter)
 	args.ops = VIRTCHNL_OP_CONFIG_IRQ_MAP;
 	args.in_args = (u8 *)map_info;
 	args.in_args_size = buf_len;
-	args.out_buffer = vf->aq_resp;
+	args.out_buffer = msg_buf;
 	args.out_size = IAVF_AQ_BUF_SZ;
 	err = iavf_execute_vf_cmd_safe(adapter, &args);
 	if (err)
@@ -1438,6 +1455,7 @@ iavf_config_irq_map_lv_chunk(struct iavf_adapter *adapter,
 		struct virtchnl_queue_vector qv_maps[IAVF_CFG_Q_NUM_PER_BUF];
 	} chunk_req = {0};
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	struct iavf_cmd_info args = {0};
 	struct virtchnl_queue_vector_maps *map_info = &chunk_req.map_info;
 	struct virtchnl_queue_vector *qv_maps = chunk_req.qv_maps;
@@ -1464,7 +1482,7 @@ iavf_config_irq_map_lv_chunk(struct iavf_adapter *adapter,
 	args.ops = VIRTCHNL_OP_MAP_QUEUE_VECTOR;
 	args.in_args = (u8 *)map_info;
 	args.in_args_size = buf_len;
-	args.out_buffer = vf->aq_resp;
+	args.out_buffer = msg_buf;
 	args.out_size = IAVF_AQ_BUF_SZ;
 
 	return iavf_execute_vf_cmd_safe(adapter, &args);
@@ -1497,6 +1515,7 @@ iavf_add_del_all_mac_addr(struct iavf_adapter *adapter, bool add)
 	} list_req = {0};
 	struct virtchnl_ether_addr_list *list = &list_req.list;
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	struct iavf_cmd_info args = {0};
 	int err, i;
 	size_t buf_len;
@@ -1524,7 +1543,7 @@ iavf_add_del_all_mac_addr(struct iavf_adapter *adapter, bool add)
 	args.ops = add ? VIRTCHNL_OP_ADD_ETH_ADDR : VIRTCHNL_OP_DEL_ETH_ADDR;
 	args.in_args = (uint8_t *)list;
 	args.in_args_size = buf_len;
-	args.out_buffer = vf->aq_resp;
+	args.out_buffer = msg_buf;
 	args.out_size = IAVF_AQ_BUF_SZ;
 	err = iavf_execute_vf_cmd_safe(adapter, &args);
 	if (err)
@@ -1537,6 +1556,7 @@ iavf_query_stats(struct iavf_adapter *adapter,
 		struct virtchnl_eth_stats *pstats)
 {
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	struct virtchnl_queue_select q_stats;
 	struct iavf_cmd_info args;
 	int err;
@@ -1549,7 +1569,7 @@ iavf_query_stats(struct iavf_adapter *adapter,
 	args.ops = VIRTCHNL_OP_GET_STATS;
 	args.in_args = (uint8_t *)&q_stats;
 	args.in_args_size = sizeof(q_stats);
-	args.out_buffer = vf->aq_resp;
+	args.out_buffer = msg_buf;
 	args.out_size = IAVF_AQ_BUF_SZ;
 
 	err = iavf_execute_vf_cmd_safe(adapter, &args);
@@ -1567,6 +1587,7 @@ iavf_config_promisc(struct iavf_adapter *adapter,
 		   bool enable_multicast)
 {
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	struct virtchnl_promisc_info promisc;
 	struct iavf_cmd_info args;
 	int err;
@@ -1586,7 +1607,7 @@ iavf_config_promisc(struct iavf_adapter *adapter,
 	args.ops = VIRTCHNL_OP_CONFIG_PROMISCUOUS_MODE;
 	args.in_args = (uint8_t *)&promisc;
 	args.in_args_size = sizeof(promisc);
-	args.out_buffer = vf->aq_resp;
+	args.out_buffer = msg_buf;
 	args.out_size = IAVF_AQ_BUF_SZ;
 
 	err = iavf_execute_vf_cmd_safe(adapter, &args);
@@ -1612,6 +1633,7 @@ iavf_add_del_eth_addr(struct iavf_adapter *adapter, struct rte_ether_addr *addr,
 {
 	struct virtchnl_ether_addr_list *list;
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	uint8_t cmd_buffer[sizeof(struct virtchnl_ether_addr_list) +
 			   sizeof(struct virtchnl_ether_addr)];
 	struct iavf_cmd_info args;
@@ -1630,7 +1652,7 @@ iavf_add_del_eth_addr(struct iavf_adapter *adapter, struct rte_ether_addr *addr,
 	args.ops = add ? VIRTCHNL_OP_ADD_ETH_ADDR : VIRTCHNL_OP_DEL_ETH_ADDR;
 	args.in_args = cmd_buffer;
 	args.in_args_size = sizeof(cmd_buffer);
-	args.out_buffer = vf->aq_resp;
+	args.out_buffer = msg_buf;
 	args.out_size = IAVF_AQ_BUF_SZ;
 	err = iavf_execute_vf_cmd_safe(adapter, &args);
 	if (err)
@@ -1644,6 +1666,7 @@ iavf_add_del_vlan(struct iavf_adapter *adapter, uint16_t vlanid, bool add)
 {
 	struct virtchnl_vlan_filter_list *vlan_list;
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	uint8_t cmd_buffer[sizeof(struct virtchnl_vlan_filter_list) +
 							sizeof(uint16_t)];
 	struct iavf_cmd_info args;
@@ -1657,7 +1680,7 @@ iavf_add_del_vlan(struct iavf_adapter *adapter, uint16_t vlanid, bool add)
 	args.ops = add ? VIRTCHNL_OP_ADD_VLAN : VIRTCHNL_OP_DEL_VLAN;
 	args.in_args = cmd_buffer;
 	args.in_args_size = sizeof(cmd_buffer);
-	args.out_buffer = vf->aq_resp;
+	args.out_buffer = msg_buf;
 	args.out_size = IAVF_AQ_BUF_SZ;
 	err = iavf_execute_vf_cmd_safe(adapter, &args);
 	if (err)
@@ -1673,7 +1696,7 @@ iavf_fdir_add(struct iavf_adapter *adapter,
 {
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
 	struct virtchnl_fdir_add *fdir_ret;
-
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	struct iavf_cmd_info args;
 	int err;
 
@@ -1683,7 +1706,7 @@ iavf_fdir_add(struct iavf_adapter *adapter,
 	args.ops = VIRTCHNL_OP_ADD_FDIR_FILTER;
 	args.in_args = (uint8_t *)(&filter->add_fltr);
 	args.in_args_size = sizeof(*(&filter->add_fltr));
-	args.out_buffer = vf->aq_resp;
+	args.out_buffer = msg_buf;
 	args.out_size = IAVF_AQ_BUF_SZ;
 
 	err = iavf_execute_vf_cmd_safe(adapter, &args);
@@ -1733,7 +1756,7 @@ iavf_fdir_del(struct iavf_adapter *adapter,
 {
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
 	struct virtchnl_fdir_del *fdir_ret;
-
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	struct iavf_cmd_info args;
 	int err;
 
@@ -1743,7 +1766,7 @@ iavf_fdir_del(struct iavf_adapter *adapter,
 	args.ops = VIRTCHNL_OP_DEL_FDIR_FILTER;
 	args.in_args = (uint8_t *)(&filter->del_fltr);
 	args.in_args_size = sizeof(filter->del_fltr);
-	args.out_buffer = vf->aq_resp;
+	args.out_buffer = msg_buf;
 	args.out_size = IAVF_AQ_BUF_SZ;
 
 	err = iavf_execute_vf_cmd_safe(adapter, &args);
@@ -1780,7 +1803,7 @@ iavf_fdir_check(struct iavf_adapter *adapter,
 {
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
 	struct virtchnl_fdir_add *fdir_ret;
-
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	struct iavf_cmd_info args;
 	int err;
 
@@ -1790,7 +1813,7 @@ iavf_fdir_check(struct iavf_adapter *adapter,
 	args.ops = VIRTCHNL_OP_ADD_FDIR_FILTER;
 	args.in_args = (uint8_t *)(&filter->add_fltr);
 	args.in_args_size = sizeof(*(&filter->add_fltr));
-	args.out_buffer = vf->aq_resp;
+	args.out_buffer = msg_buf;
 	args.out_size = IAVF_AQ_BUF_SZ;
 
 	err = iavf_execute_vf_cmd_safe(adapter, &args);
@@ -1822,6 +1845,7 @@ int
 iavf_flow_sub(struct iavf_adapter *adapter, struct iavf_fsub_conf *filter)
 {
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	struct virtchnl_flow_sub *fsub_cfg;
 	struct iavf_cmd_info args;
 	int err;
@@ -1833,7 +1857,7 @@ iavf_flow_sub(struct iavf_adapter *adapter, struct iavf_fsub_conf *filter)
 	args.ops = VIRTCHNL_OP_FLOW_SUBSCRIBE;
 	args.in_args = (uint8_t *)(&filter->sub_fltr);
 	args.in_args_size = sizeof(*(&filter->sub_fltr));
-	args.out_buffer = vf->aq_resp;
+	args.out_buffer = msg_buf;
 	args.out_size = IAVF_AQ_BUF_SZ;
 
 	err = iavf_execute_vf_cmd_safe(adapter, &args);
@@ -1874,6 +1898,7 @@ iavf_flow_unsub(struct iavf_adapter *adapter, struct iavf_fsub_conf *filter)
 {
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
 	struct virtchnl_flow_unsub *unsub_cfg;
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	struct iavf_cmd_info args;
 	int err;
 
@@ -1884,7 +1909,7 @@ iavf_flow_unsub(struct iavf_adapter *adapter, struct iavf_fsub_conf *filter)
 	args.ops = VIRTCHNL_OP_FLOW_UNSUBSCRIBE;
 	args.in_args = (uint8_t *)(&filter->unsub_fltr);
 	args.in_args_size = sizeof(filter->unsub_fltr);
-	args.out_buffer = vf->aq_resp;
+	args.out_buffer = msg_buf;
 	args.out_size = IAVF_AQ_BUF_SZ;
 
 	err = iavf_execute_vf_cmd_safe(adapter, &args);
@@ -1917,7 +1942,7 @@ iavf_flow_sub_check(struct iavf_adapter *adapter,
 {
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
 	struct virtchnl_flow_sub *fsub_cfg;
-
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	struct iavf_cmd_info args;
 	int err;
 
@@ -1927,7 +1952,7 @@ iavf_flow_sub_check(struct iavf_adapter *adapter,
 	args.ops = VIRTCHNL_OP_FLOW_SUBSCRIBE;
 	args.in_args = (uint8_t *)(&filter->sub_fltr);
 	args.in_args_size = sizeof(*(&filter->sub_fltr));
-	args.out_buffer = vf->aq_resp;
+	args.out_buffer = msg_buf;
 	args.out_size = IAVF_AQ_BUF_SZ;
 
 	err = iavf_execute_vf_cmd_safe(adapter, &args);
@@ -1958,7 +1983,7 @@ int
 iavf_add_del_rss_cfg(struct iavf_adapter *adapter,
 		     struct virtchnl_rss_cfg *rss_cfg, bool add)
 {
-	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	struct iavf_cmd_info args;
 	int err;
 
@@ -1967,7 +1992,7 @@ iavf_add_del_rss_cfg(struct iavf_adapter *adapter,
 		VIRTCHNL_OP_DEL_RSS_CFG;
 	args.in_args = (u8 *)rss_cfg;
 	args.in_args_size = sizeof(*rss_cfg);
-	args.out_buffer = vf->aq_resp;
+	args.out_buffer = msg_buf;
 	args.out_size = IAVF_AQ_BUF_SZ;
 
 	err = iavf_execute_vf_cmd_safe(adapter, &args);
@@ -1983,7 +2008,7 @@ iavf_add_del_rss_cfg(struct iavf_adapter *adapter,
 int
 iavf_get_hena_caps(struct iavf_adapter *adapter, uint64_t *caps)
 {
-	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	struct virtchnl_rss_hena *hena;
 	struct iavf_cmd_info args;
 	int err;
@@ -1991,7 +2016,7 @@ iavf_get_hena_caps(struct iavf_adapter *adapter, uint64_t *caps)
 	args.ops = VIRTCHNL_OP_GET_RSS_HENA_CAPS;
 	args.in_args = NULL;
 	args.in_args_size = 0;
-	args.out_buffer = vf->aq_resp;
+	args.out_buffer = msg_buf;
 	args.out_size = IAVF_AQ_BUF_SZ;
 
 	err = iavf_execute_vf_cmd_safe(adapter, &args);
@@ -2009,7 +2034,7 @@ iavf_get_hena_caps(struct iavf_adapter *adapter, uint64_t *caps)
 int
 iavf_set_hena(struct iavf_adapter *adapter, uint64_t hena)
 {
-	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	struct virtchnl_rss_hena vrh;
 	struct iavf_cmd_info args;
 	int err;
@@ -2018,7 +2043,7 @@ iavf_set_hena(struct iavf_adapter *adapter, uint64_t hena)
 	args.ops = VIRTCHNL_OP_SET_RSS_HENA;
 	args.in_args = (u8 *)&vrh;
 	args.in_args_size = sizeof(vrh);
-	args.out_buffer = vf->aq_resp;
+	args.out_buffer = msg_buf;
 	args.out_size = IAVF_AQ_BUF_SZ;
 
 	err = iavf_execute_vf_cmd_safe(adapter, &args);
@@ -2033,6 +2058,7 @@ int
 iavf_get_qos_cap(struct iavf_adapter *adapter)
 {
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	struct iavf_cmd_info args;
 	uint32_t len;
 	int err;
@@ -2040,7 +2066,7 @@ iavf_get_qos_cap(struct iavf_adapter *adapter)
 	args.ops = VIRTCHNL_OP_GET_QOS_CAPS;
 	args.in_args = NULL;
 	args.in_args_size = 0;
-	args.out_buffer = vf->aq_resp;
+	args.out_buffer = msg_buf;
 	args.out_size = IAVF_AQ_BUF_SZ;
 	err = iavf_execute_vf_cmd_safe(adapter, &args);
 
@@ -2064,7 +2090,7 @@ int iavf_set_q_tc_map(struct rte_eth_dev *dev,
 {
 	struct iavf_adapter *adapter =
 			IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
-	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(dev->data->dev_private);
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	struct iavf_cmd_info args;
 	int err;
 
@@ -2072,7 +2098,7 @@ int iavf_set_q_tc_map(struct rte_eth_dev *dev,
 	args.ops = VIRTCHNL_OP_CONFIG_QUEUE_TC_MAP;
 	args.in_args = (uint8_t *)q_tc_mapping;
 	args.in_args_size = size;
-	args.out_buffer = vf->aq_resp;
+	args.out_buffer = msg_buf;
 	args.out_size = IAVF_AQ_BUF_SZ;
 
 	err = iavf_execute_vf_cmd_safe(adapter, &args);
@@ -2087,7 +2113,7 @@ int iavf_set_q_bw(struct rte_eth_dev *dev,
 {
 	struct iavf_adapter *adapter =
 			IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
-	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(dev->data->dev_private);
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	struct iavf_cmd_info args;
 	int err;
 
@@ -2095,7 +2121,7 @@ int iavf_set_q_bw(struct rte_eth_dev *dev,
 	args.ops = VIRTCHNL_OP_CONFIG_QUEUE_BW;
 	args.in_args = (uint8_t *)q_bw;
 	args.in_args_size = size;
-	args.out_buffer = vf->aq_resp;
+	args.out_buffer = msg_buf;
 	args.out_size = IAVF_AQ_BUF_SZ;
 
 	err = iavf_execute_vf_cmd_safe(adapter, &args);
@@ -2111,6 +2137,7 @@ iavf_add_del_mc_addr_list(struct iavf_adapter *adapter,
 			uint32_t mc_addrs_num, bool add)
 {
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	uint8_t cmd_buffer[sizeof(struct virtchnl_ether_addr_list) +
 		(IAVF_NUM_MACADDR_MAX * sizeof(struct virtchnl_ether_addr))];
 	struct virtchnl_ether_addr_list *list;
@@ -2141,7 +2168,7 @@ iavf_add_del_mc_addr_list(struct iavf_adapter *adapter,
 	args.in_args = cmd_buffer;
 	args.in_args_size = sizeof(struct virtchnl_ether_addr_list) +
 		i * sizeof(struct virtchnl_ether_addr);
-	args.out_buffer = vf->aq_resp;
+	args.out_buffer = msg_buf;
 	args.out_size = IAVF_AQ_BUF_SZ;
 	err = iavf_execute_vf_cmd_safe(adapter, &args);
 
@@ -2160,6 +2187,7 @@ iavf_request_queues(struct rte_eth_dev *dev, uint16_t num)
 	struct iavf_adapter *adapter =
 		IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	struct iavf_info *vf =  IAVF_DEV_PRIVATE_TO_VF(adapter);
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	struct virtchnl_vf_res_request vfres;
 	struct iavf_cmd_info args;
 	uint16_t num_queue_pairs;
@@ -2181,7 +2209,7 @@ iavf_request_queues(struct rte_eth_dev *dev, uint16_t num)
 	args.ops = VIRTCHNL_OP_REQUEST_QUEUES;
 	args.in_args = (u8 *)&vfres;
 	args.in_args_size = sizeof(vfres);
-	args.out_buffer = vf->aq_resp;
+	args.out_buffer = msg_buf;
 	args.out_size = IAVF_AQ_BUF_SZ;
 
 	if (vf->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_WB_ON_ITR) {
@@ -2224,6 +2252,7 @@ int
 iavf_get_max_rss_queue_region(struct iavf_adapter *adapter)
 {
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	struct iavf_cmd_info args;
 	uint16_t qregion_width;
 	int err;
@@ -2231,7 +2260,7 @@ iavf_get_max_rss_queue_region(struct iavf_adapter *adapter)
 	args.ops = VIRTCHNL_OP_GET_MAX_RSS_QREGION;
 	args.in_args = NULL;
 	args.in_args_size = 0;
-	args.out_buffer = vf->aq_resp;
+	args.out_buffer = msg_buf;
 	args.out_size = IAVF_AQ_BUF_SZ;
 
 	err = iavf_execute_vf_cmd_safe(adapter, &args);
@@ -2255,14 +2284,14 @@ iavf_ipsec_crypto_request(struct iavf_adapter *adapter,
 		uint8_t *msg, size_t msg_len,
 		uint8_t *resp_msg, size_t resp_msg_len)
 {
-	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	struct iavf_cmd_info args;
 	int err;
 
 	args.ops = VIRTCHNL_OP_INLINE_IPSEC_CRYPTO;
 	args.in_args = msg;
 	args.in_args_size = msg_len;
-	args.out_buffer = vf->aq_resp;
+	args.out_buffer = msg_buf;
 	args.out_size = IAVF_AQ_BUF_SZ;
 
 	err = iavf_execute_vf_cmd_safe(adapter, &args);
@@ -2280,7 +2309,7 @@ iavf_ipsec_crypto_request(struct iavf_adapter *adapter,
 int
 iavf_set_vf_quanta_size(struct iavf_adapter *adapter, u16 start_queue_id, u16 num_queues)
 {
-	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	struct iavf_cmd_info args;
 	struct virtchnl_quanta_cfg q_quanta;
 	int err;
@@ -2296,7 +2325,7 @@ iavf_set_vf_quanta_size(struct iavf_adapter *adapter, u16 start_queue_id, u16 nu
 	args.ops = VIRTCHNL_OP_CONFIG_QUANTA;
 	args.in_args = (uint8_t *)&q_quanta;
 	args.in_args_size = sizeof(q_quanta);
-	args.out_buffer = vf->aq_resp;
+	args.out_buffer = msg_buf;
 	args.out_size = IAVF_AQ_BUF_SZ;
 
 	err = iavf_execute_vf_cmd_safe(adapter, &args);
@@ -2312,6 +2341,7 @@ int
 iavf_get_ptp_cap(struct iavf_adapter *adapter)
 {
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	struct virtchnl_ptp_caps ptp_caps;
 	struct iavf_cmd_info args;
 	int err;
@@ -2322,7 +2352,7 @@ iavf_get_ptp_cap(struct iavf_adapter *adapter)
 	args.ops = VIRTCHNL_OP_1588_PTP_GET_CAPS;
 	args.in_args = (uint8_t *)&ptp_caps;
 	args.in_args_size = sizeof(ptp_caps);
-	args.out_buffer = vf->aq_resp;
+	args.out_buffer = msg_buf;
 	args.out_size = IAVF_AQ_BUF_SZ;
 
 	err = iavf_execute_vf_cmd_safe(adapter, &args);
@@ -2342,6 +2372,7 @@ iavf_get_phc_time(struct ci_rx_queue *rxq)
 {
 	struct iavf_adapter *adapter = rxq->iavf_vsi->adapter;
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	struct virtchnl_phc_time phc_time;
 	struct iavf_cmd_info args;
 	int err = 0;
@@ -2349,7 +2380,7 @@ iavf_get_phc_time(struct ci_rx_queue *rxq)
 	args.ops = VIRTCHNL_OP_1588_PTP_GET_TIME;
 	args.in_args = (uint8_t *)&phc_time;
 	args.in_args_size = sizeof(phc_time);
-	args.out_buffer = vf->aq_resp;
+	args.out_buffer = msg_buf;
 	args.out_size = IAVF_AQ_BUF_SZ;
 
 	rte_spinlock_lock(&vf->phc_time_aq_lock);
-- 
2.47.3

