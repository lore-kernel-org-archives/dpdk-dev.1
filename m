Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753FDC5CFC1
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Aug 2026 12:23:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E532240A89;
	Fri, 14 Aug 2026 14:22:28 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 0EA6B4028D
 for <dev@dpdk.org>; Fri, 14 Aug 2026 14:22:16 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowACHjjxyCH9qF1pdBQ--.37690S8;
 Fri, 14 Aug 2026 20:22:13 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v1 06/13] net/sxe2: refactor flow tunnel port handling
Date: Fri, 14 Aug 2026 20:21:57 +0800
Message-ID: <20260814122204.2666045-7-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260814122204.2666045-1-liujie5@linkdatatechnology.com>
References: <20260814122204.2666045-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowACHjjxyCH9qF1pdBQ--.37690S8
X-Coremail-Antispam: 1UD129KBjvAXoW3KFWfKF15ury5JF13ZFWrKrg_yoW8Xw48Xo
 Z7Jr4UX3WSyry7Zw48XF18ZrZrtay5GwnaqF4Sgan8WanrZa4jyF4UGrZ8Zw4Dtw4SkF15
 C3Z7Za1DtrsrCF15n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UjIYCTnIWjp_UUUYM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
 j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s0DM28Irc
 Ia0xkI8VCY1x0267AKxVW8JVW5JwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l
 84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F
 4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_
 Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x
 IIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_
 Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4kE6xkIj40Ew7xC0w
 CF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j
 6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64
 vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_
 Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0x
 vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUwqXdUUUUU=
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

This patch refactors flow tunnel port handling and adds support for
PF bond devices:

- Refactor tunnel port functions from pattern module to flow module:
  * Move sxe2_flow_parse_pattern_ipip from sxe2_flow_parse_pattern.c
  * Move sxe2_flow_add_udp_tunnel_port from sxe2_flow_parse_pattern.c
  * Move sxe2_flow_add_tunnel_port from public API to static function
  * Remove public function declaration from header file
  * Keep functions internal to flow module for better encapsulation

- Add PF bond device support in flow source split processing:
  * Add bond_member_cnt field to sxe2_adapter structure
  * Handle SXE2_DEV_T_PF_BOND device type in sxe2_flow_src_split_proc
  * Populate flow_src_vsi for all bond members

- Enhance ACL engine support in flow actions:
  * Add ACL engine support in flow action checks
  * Allow PASSTHRU action for ACL engine

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/sxe2_ethdev.h             |   1 +
 drivers/net/sxe2/sxe2_flow.c               | 144 ++++++++++++++++++++-
 drivers/net/sxe2/sxe2_flow_parse_action.c  |  18 ++-
 drivers/net/sxe2/sxe2_flow_parse_pattern.c | 113 ----------------
 drivers/net/sxe2/sxe2_flow_parse_pattern.h |   7 -
 5 files changed, 151 insertions(+), 132 deletions(-)

diff --git a/drivers/net/sxe2/sxe2_ethdev.h b/drivers/net/sxe2/sxe2_ethdev.h
index d0a0f41ceb..36f4cc9353 100644
--- a/drivers/net/sxe2/sxe2_ethdev.h
+++ b/drivers/net/sxe2/sxe2_ethdev.h
@@ -340,6 +340,7 @@ struct sxe2_adapter {
 	bool                          flow_isolate_cfg;
 	uint16_t                      dev_port_id;
 	bool                          is_dev_repr;
+	uint16_t                      bond_member_cnt;
 	uint64_t                      cap_flags;
 	enum sxe2_dev_type            dev_type;
 	struct rte_ether_addr         mac_addr;
diff --git a/drivers/net/sxe2/sxe2_flow.c b/drivers/net/sxe2/sxe2_flow.c
index 3cf98dd294..af85cb0d2b 100644
--- a/drivers/net/sxe2/sxe2_flow.c
+++ b/drivers/net/sxe2/sxe2_flow.c
@@ -285,14 +285,16 @@ static int32_t sxe2_flow_meta_proc(struct rte_eth_dev *dev,
 					attr, "Only support priority 0.");
 			ret = -rte_errno;
 			goto l_end;
-		} else if (!adapter->switchdev_info.is_switchdev) {
-			PMD_LOG_ERR(DRV, "Legacy mode only support priority 0.");
-			rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ATTR_PRIORITY,
-					attr, "Legacy mode only priority 0.");
-			ret = -rte_errno;
-			goto l_end;
 		} else {
-			flow->meta.flow_prio = attr->priority;
+			if (!adapter->switchdev_info.is_switchdev) {
+				PMD_LOG_ERR(DRV, "Legacy mode only support priority 0.");
+				rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ATTR_PRIORITY,
+						attr, "Legacy mode only priority 0.");
+				ret = -rte_errno;
+				goto l_end;
+			} else {
+				flow->meta.flow_prio = attr->priority;
+			}
 		}
 	}
 
@@ -347,6 +349,21 @@ static int32_t sxe2_flow_src_split_proc(struct rte_eth_dev *dev,
 		flow_src_vsi[SXE2_MAX_DRV_TYPE_KERNEL][idx] = UINT16_MAX;
 	}
 
+	if (adapter->dev_type == SXE2_DEV_T_PF_BOND) {
+		flow_bond_num = adapter->bond_member_cnt;
+		for (idx = 0; idx < flow_bond_num; idx++) {
+			flow_src_vsi[SXE2_MAX_DRV_TYPE_DPDK][idx] =
+				adapter->vsi_ctxt.bond_member_dpdk_vsi_id[idx];
+			flow_src_vsi[SXE2_MAX_DRV_TYPE_KERNEL][idx] =
+				adapter->vsi_ctxt.bond_member_kernel_vsi_id[idx];
+		}
+	} else {
+		flow_src_vsi[SXE2_MAX_DRV_TYPE_DPDK][0] =
+				adapter->vsi_ctxt.dpdk_vsi_id;
+		flow_src_vsi[SXE2_MAX_DRV_TYPE_KERNEL][0] =
+				adapter->vsi_ctxt.kernel_vsi_id;
+	}
+
 	flow_src_vsi[SXE2_MAX_DRV_TYPE_DPDK][0] = adapter->vsi_ctxt.dpdk_vsi_id;
 	flow_src_vsi[SXE2_MAX_DRV_TYPE_KERNEL][0] = adapter->vsi_ctxt.kernel_vsi_id;
 	if (flow->engine_type == SXE2_FLOW_ENGINE_FNAV ||
@@ -550,6 +567,119 @@ int32_t sxe2_flow_init_udp_tunnel_port(struct rte_eth_dev *dev)
 	return ret;
 }
 
+static int32_t sxe2_flow_add_udp_tunnel_port(struct sxe2_adapter *adapter,
+					 enum sxe2_flow_udp_tunnel_protocol proto,
+					 struct sxe2_flow *flow,
+					 BITMAP_TYPE *flow_type)
+{
+	int32_t ret = 0;
+	uint16_t tun_port;
+
+	tun_port = adapter->flow_ctxt.tunnel_port_list[proto];
+	if (tun_port == 0xffff || tun_port == 0) {
+		ret = -EINVAL;
+		PMD_LOG_ERR(DRV, "UDP tunnel port not initialized, proto: %d", proto);
+		goto l_end;
+	}
+	if (!sxe2_test_bit(SXE2_EXPANSION_OUTER_UDP, flow_type)) {
+		ret = -EINVAL;
+		PMD_LOG_ERR(DRV, "UDP must be over tunnel");
+		goto l_end;
+	}
+	sxe2_set_bit(SXE2_FLOW_FLD_ID_UDP_DST_PORT, flow->pattern_outer.map_spec);
+	flow->pattern_outer.item_spec.udp.dest = rte_cpu_to_be_16(tun_port);
+l_end:
+	return ret;
+}
+
+static int32_t sxe2_flow_parse_pattern_ipip(struct sxe2_flow *flow, BITMAP_TYPE *flow_type)
+{
+	sxe2_set_bit(SXE2_EXPANSION_IPIP, flow_type);
+	if (sxe2_test_bit(SXE2_EXPANSION_OUTER_IPV4, flow_type)) {
+		sxe2_set_bit(SXE2_FLOW_FLD_ID_IPV4_PROT, flow->pattern_outer.map_spec);
+		if (sxe2_test_bit(SXE2_EXPANSION_IPV4, flow_type))
+			flow->pattern_outer.item_spec.ipv4.protocol = SXE2_FLOW_IP_PROTOCOL_IPV4;
+		if (sxe2_test_bit(SXE2_EXPANSION_IPV6, flow_type))
+			flow->pattern_outer.item_spec.ipv4.protocol = SXE2_FLOW_IP_PROTOCOL_IPV6;
+	}
+	if (sxe2_test_bit(SXE2_EXPANSION_OUTER_IPV6, flow_type)) {
+		sxe2_set_bit(SXE2_FLOW_FLD_ID_IPV6_PROT, flow->pattern_outer.map_spec);
+		if (sxe2_test_bit(SXE2_EXPANSION_ETH, flow_type)) {
+			flow->pattern_outer.item_spec.ipv6.nexthdr = SXE2_FLOW_IP_PROTOCOL_ETH;
+		} else {
+			if (sxe2_test_bit(SXE2_EXPANSION_IPV4, flow_type))
+				flow->pattern_outer.item_spec.ipv6.nexthdr =
+					SXE2_FLOW_IP_PROTOCOL_IPV4;
+			if (sxe2_test_bit(SXE2_EXPANSION_IPV6, flow_type))
+				flow->pattern_outer.item_spec.ipv6.nexthdr =
+					SXE2_FLOW_IP_PROTOCOL_IPV6;
+		}
+	}
+	return 0;
+}
+
+static int32_t sxe2_flow_add_tunnel_port(struct rte_eth_dev *dev,
+			struct rte_flow_error *error,
+			struct sxe2_flow *flow, BITMAP_TYPE *flow_type,
+			enum sxe2_flow_tunnel_type tunnel_type)
+{
+	int32_t ret = 0;
+	enum sxe2_flow_udp_tunnel_protocol proto = SXE2_FLOW_UDP_TUNNEL_MAX;
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct sxe2_flow_pattern *pattern = &flow->pattern_outer;
+	switch (tunnel_type) {
+	case SXE2_FLOW_TUNNEL_TYPE_VXLAN:
+		if (sxe2_test_bit(SXE2_EXPANSION_ETH, flow_type)) {
+			proto = SXE2_FLOW_UDP_TUNNEL_PROTOCOL_VXLAN;
+		} else if (sxe2_test_bit(SXE2_EXPANSION_IPV4, flow_type) ||
+			sxe2_test_bit(SXE2_EXPANSION_IPV6, flow_type)) {
+			proto = SXE2_FLOW_UDP_TUNNEL_PROTOCOL_VXLAN_GPE;
+		}
+		break;
+	case SXE2_FLOW_TUNNEL_TYPE_GTPU:
+		proto = SXE2_FLOW_UDP_TUNNEL_PROTOCOL_GTP_U;
+		break;
+	case SXE2_FLOW_TUNNEL_TYPE_GENEVE:
+		proto = SXE2_FLOW_UDP_TUNNEL_PROTOCOL_GENEVE;
+		break;
+	case SXE2_FLOW_TUNNEL_TYPE_GRE:
+		if (sxe2_test_bit(SXE2_EXPANSION_OUTER_UDP, flow_type)) {
+			proto = SXE2_FLOW_UDP_TUNNEL_PROTOCOL_NVGRE;
+		} else {
+			if (sxe2_test_bit(SXE2_EXPANSION_OUTER_IPV4, flow_type)) {
+				pattern->item_spec.ipv4.protocol = SXE2_FLOW_IP_PROTOCOL_GRE;
+				sxe2_set_bit(SXE2_FLOW_FLD_ID_IPV4_PROT, pattern->map_spec);
+			}
+			if (sxe2_test_bit(SXE2_EXPANSION_OUTER_IPV6, flow_type)) {
+				pattern->item_spec.ipv6.nexthdr = SXE2_FLOW_IP_PROTOCOL_GRE;
+				sxe2_set_bit(SXE2_FLOW_FLD_ID_IPV6_PROT, pattern->map_spec);
+			}
+		}
+		break;
+	case SXE2_FLOW_TUNNEL_TYPE_IPIP:
+		ret = sxe2_flow_parse_pattern_ipip(flow, flow_type);
+		break;
+	default:
+		break;
+	}
+	if (proto != SXE2_FLOW_UDP_TUNNEL_MAX) {
+		ret = sxe2_flow_add_udp_tunnel_port(adapter, proto, flow, flow_type);
+		if (ret != 0) {
+			rte_flow_error_set(error, EINVAL,
+					RTE_FLOW_ERROR_TYPE_ITEM,
+					NULL, "Failed to add udp port for tunnel.");
+			PMD_LOG_ERR(DRV, "Failed to add udp port for tunnel, ret %d.", ret);
+			goto l_end;
+		}
+	}
+	if (tunnel_type != SXE2_FLOW_TUNNEL_TYPE_NONE) {
+		if (!sxe2_test_bit(SXE2_EXPANSION_OUTER_UDP, flow_type))
+			sxe2_set_bit(SXE2_FLOW_HDR_IPV_OTHER, pattern->hdrs);
+	}
+l_end:
+	return ret;
+}
+
 static int32_t sxe2_flowlist_add_tunnel_port(struct rte_eth_dev *dev,
 			struct rte_flow *flow_list,
 			struct rte_flow_error *error)
diff --git a/drivers/net/sxe2/sxe2_flow_parse_action.c b/drivers/net/sxe2/sxe2_flow_parse_action.c
index cdd6fcfdcd..867d90ae1d 100644
--- a/drivers/net/sxe2/sxe2_flow_parse_action.c
+++ b/drivers/net/sxe2/sxe2_flow_parse_action.c
@@ -25,15 +25,21 @@ static int32_t sxe2_flow_check_rss_action_attr(const struct rte_flow_action_rss
 		goto l_end;
 	}
 
-	if (rss->level > 2)
+	if (rss->level > 2) {
 		rte_flow_error_set(error, ENOTSUP, RTE_FLOW_ERROR_TYPE_ACTION, NULL,
 			"RSS  level is could not be greater than 2");
-	if (rss->key_len)
+		goto l_end;
+	}
+	if (rss->key_len) {
 		rte_flow_error_set(error, ENOTSUP, RTE_FLOW_ERROR_TYPE_ACTION, NULL,
 			"a nonzero RSS key_len is not supported");
-	if (rss->queue_num)
+		goto l_end;
+	}
+	if (rss->queue_num) {
 		rte_flow_error_set(error, ENOTSUP, RTE_FLOW_ERROR_TYPE_ACTION, NULL,
 			"a non-NULL RSS queue is not supported");
+		goto l_end;
+	}
 	ret = 0;
 l_end:
 	return ret;
@@ -953,7 +959,8 @@ static int32_t sxe2_flow_check_actions(struct rte_eth_dev *dev __rte_unused, str
 		}
 	}
 
-	if (engine_type == SXE2_FLOW_ENGINE_FNAV) {
+	if (engine_type == SXE2_FLOW_ENGINE_FNAV ||
+		engine_type == SXE2_FLOW_ENGINE_ACL) {
 		if (vsi_num) {
 			flow->action.q_region.q_index = 0;
 			flow->action.q_region.region = 7;
@@ -988,7 +995,8 @@ int32_t sxe2_flow_parse_action(struct rte_eth_dev *dev,
 		case RTE_FLOW_ACTION_TYPE_VOID:
 			break;
 		case RTE_FLOW_ACTION_TYPE_PASSTHRU:
-			if (engine_type == SXE2_FLOW_ENGINE_FNAV) {
+			if (engine_type == SXE2_FLOW_ENGINE_FNAV ||
+				engine_type == SXE2_FLOW_ENGINE_ACL) {
 				sxe2_set_bit(SXE2_FLOW_ACTION_PASSTHRU, flow->action.act_types);
 				action_num[SXE2_FLOW_ACTION_PASSTHRU]++;
 			} else {
diff --git a/drivers/net/sxe2/sxe2_flow_parse_pattern.c b/drivers/net/sxe2/sxe2_flow_parse_pattern.c
index f5bf8922c6..189abb1a33 100644
--- a/drivers/net/sxe2/sxe2_flow_parse_pattern.c
+++ b/drivers/net/sxe2/sxe2_flow_parse_pattern.c
@@ -1637,119 +1637,6 @@ static int32_t sxe2_flow_parse_pattern_vxlan_gpe(const struct rte_flow_item *ite
 	return ret;
 }
 
-static int32_t sxe2_flow_parse_pattern_ipip(struct sxe2_flow *flow, BITMAP_TYPE *flow_type)
-{
-	sxe2_set_bit(SXE2_EXPANSION_IPIP, flow_type);
-	if (sxe2_test_bit(SXE2_EXPANSION_OUTER_IPV4, flow_type)) {
-		sxe2_set_bit(SXE2_FLOW_FLD_ID_IPV4_PROT, flow->pattern_outer.map_spec);
-		if (sxe2_test_bit(SXE2_EXPANSION_IPV4, flow_type))
-			flow->pattern_outer.item_spec.ipv4.protocol = SXE2_FLOW_IP_PROTOCOL_IPV4;
-		if (sxe2_test_bit(SXE2_EXPANSION_IPV6, flow_type))
-			flow->pattern_outer.item_spec.ipv4.protocol = SXE2_FLOW_IP_PROTOCOL_IPV6;
-	}
-	if (sxe2_test_bit(SXE2_EXPANSION_OUTER_IPV6, flow_type)) {
-		sxe2_set_bit(SXE2_FLOW_FLD_ID_IPV6_PROT, flow->pattern_outer.map_spec);
-		if (sxe2_test_bit(SXE2_EXPANSION_ETH, flow_type)) {
-			flow->pattern_outer.item_spec.ipv6.nexthdr = SXE2_FLOW_IP_PROTOCOL_ETH;
-		} else {
-			if (sxe2_test_bit(SXE2_EXPANSION_IPV4, flow_type))
-				flow->pattern_outer.item_spec.ipv6.nexthdr =
-					SXE2_FLOW_IP_PROTOCOL_IPV4;
-			if (sxe2_test_bit(SXE2_EXPANSION_IPV6, flow_type))
-				flow->pattern_outer.item_spec.ipv6.nexthdr =
-					SXE2_FLOW_IP_PROTOCOL_IPV6;
-		}
-	}
-	return 0;
-}
-
-static int32_t sxe2_flow_add_udp_tunnel_port(struct sxe2_adapter *adapter,
-					 enum sxe2_flow_udp_tunnel_protocol proto,
-					 struct sxe2_flow *flow,
-					 BITMAP_TYPE *flow_type)
-{
-	int32_t ret = 0;
-	uint16_t tun_port;
-
-	tun_port = adapter->flow_ctxt.tunnel_port_list[proto];
-	if (tun_port == 0xffff || tun_port == 0) {
-		ret = -EINVAL;
-		PMD_LOG_ERR(DRV, "UDP tunnel port not initialized, proto: %d", proto);
-		goto l_end;
-	}
-	if (!sxe2_test_bit(SXE2_EXPANSION_OUTER_UDP, flow_type)) {
-		ret = -EINVAL;
-		PMD_LOG_ERR(DRV, "UDP must be over tunnel");
-		goto l_end;
-	}
-	sxe2_set_bit(SXE2_FLOW_FLD_ID_UDP_DST_PORT, flow->pattern_outer.map_spec);
-	flow->pattern_outer.item_spec.udp.dest = rte_cpu_to_be_16(tun_port);
-l_end:
-	return ret;
-}
-
-int32_t sxe2_flow_add_tunnel_port(struct rte_eth_dev *dev,
-			struct rte_flow_error *error,
-			struct sxe2_flow *flow, BITMAP_TYPE *flow_type,
-			enum sxe2_flow_tunnel_type tunnel_type)
-{
-	int32_t ret = 0;
-	enum sxe2_flow_udp_tunnel_protocol proto = SXE2_FLOW_UDP_TUNNEL_MAX;
-	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
-	struct sxe2_flow_pattern *pattern = &flow->pattern_outer;
-	switch (tunnel_type) {
-	case SXE2_FLOW_TUNNEL_TYPE_VXLAN:
-		if (sxe2_test_bit(SXE2_EXPANSION_ETH, flow_type)) {
-			proto = SXE2_FLOW_UDP_TUNNEL_PROTOCOL_VXLAN;
-		} else if (sxe2_test_bit(SXE2_EXPANSION_IPV4, flow_type) ||
-			sxe2_test_bit(SXE2_EXPANSION_IPV6, flow_type)) {
-			proto = SXE2_FLOW_UDP_TUNNEL_PROTOCOL_VXLAN_GPE;
-		}
-		break;
-	case SXE2_FLOW_TUNNEL_TYPE_GTPU:
-		proto = SXE2_FLOW_UDP_TUNNEL_PROTOCOL_GTP_U;
-		break;
-	case SXE2_FLOW_TUNNEL_TYPE_GENEVE:
-		proto = SXE2_FLOW_UDP_TUNNEL_PROTOCOL_GENEVE;
-		break;
-	case SXE2_FLOW_TUNNEL_TYPE_GRE:
-		if (sxe2_test_bit(SXE2_EXPANSION_OUTER_UDP, flow_type)) {
-			proto = SXE2_FLOW_UDP_TUNNEL_PROTOCOL_NVGRE;
-		} else {
-			if (sxe2_test_bit(SXE2_EXPANSION_OUTER_IPV4, flow_type)) {
-				pattern->item_spec.ipv4.protocol = SXE2_FLOW_IP_PROTOCOL_GRE;
-				sxe2_set_bit(SXE2_FLOW_FLD_ID_IPV4_PROT, pattern->map_spec);
-			}
-			if (sxe2_test_bit(SXE2_EXPANSION_OUTER_IPV6, flow_type)) {
-				pattern->item_spec.ipv6.nexthdr = SXE2_FLOW_IP_PROTOCOL_GRE;
-				sxe2_set_bit(SXE2_FLOW_FLD_ID_IPV6_PROT, pattern->map_spec);
-			}
-		}
-		break;
-	case SXE2_FLOW_TUNNEL_TYPE_IPIP:
-		ret = sxe2_flow_parse_pattern_ipip(flow, flow_type);
-		break;
-	default:
-		break;
-	}
-	if (proto != SXE2_FLOW_UDP_TUNNEL_MAX) {
-		ret = sxe2_flow_add_udp_tunnel_port(adapter, proto, flow, flow_type);
-		if (ret != 0) {
-			rte_flow_error_set(error, EINVAL,
-					RTE_FLOW_ERROR_TYPE_ITEM,
-					NULL, "Failed to add udp port for tunnel.");
-			PMD_LOG_ERR(DRV, "Failed to add udp port for tunnel, ret %d.", ret);
-			goto l_end;
-		}
-	}
-	if (tunnel_type != SXE2_FLOW_TUNNEL_TYPE_NONE) {
-		if (!sxe2_test_bit(SXE2_EXPANSION_OUTER_UDP, flow_type))
-			sxe2_set_bit(SXE2_FLOW_HDR_IPV_OTHER, pattern->hdrs);
-	}
-l_end:
-	return ret;
-}
-
 struct sxe2_flow_parse_pattern_ops sxe2_flow_parse_pattern_list[] = {
 	[SXE2_EXPANSION_OUTER_ETH] = {
 		.is_inner = false,
diff --git a/drivers/net/sxe2/sxe2_flow_parse_pattern.h b/drivers/net/sxe2/sxe2_flow_parse_pattern.h
index 8442c35cae..6872a767dd 100644
--- a/drivers/net/sxe2/sxe2_flow_parse_pattern.h
+++ b/drivers/net/sxe2/sxe2_flow_parse_pattern.h
@@ -36,11 +36,4 @@ int32_t sxe2_flow_parse_pattern(struct rte_eth_dev *dev,
 			    const struct rte_flow_item patterns[],
 			    struct rte_flow_error *error,
 			    struct sxe2_flow *flow);
-
-int32_t sxe2_flow_add_tunnel_port(struct rte_eth_dev *dev,
-			      struct rte_flow_error *error,
-			      struct sxe2_flow *flow,
-			      BITMAP_TYPE *flow_type,
-			      enum sxe2_flow_tunnel_type tunnel_type);
-
 #endif /* SXE2_FLOW_PARSE_PATTERN_H_ */
-- 
2.52.0

