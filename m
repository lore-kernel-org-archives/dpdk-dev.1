Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF84C61DE4
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 02:43:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A991340DCB;
	Mon, 31 Aug 2026 04:43:33 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 5B938402AB
 for <dev@dpdk.org>; Mon, 31 Aug 2026 04:43:31 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowADHyzlQ6pRqvtajBg--.24204S2;
 Mon, 31 Aug 2026 10:43:28 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v7 25/47] net/sxe2: move tunnel port helpers into flow module
Date: Mon, 31 Aug 2026 10:43:28 +0800
Message-ID: <20260831024328.3230904-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260828074056.2250222-1-liujie5@linkdatatechnology.com>
References: <20260828074056.2250222-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowADHyzlQ6pRqvtajBg--.24204S2
X-Coremail-Antispam: 1UD129KBjvJXoW3urWDZw45uF48JF4ftr15XFb_yoWkGr4Dpa
 1UGr1YyFW7XF1akr45Zr43W3Wq9ry8ta98CFZYk34Fk3WavFn7Cr18Way3Kws8KFWxZryS
 yF4Yy3WDG3WxA37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkC14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
 JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
 1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
 7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r
 1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0
 F24l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
 WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI
 7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Ar0_tr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
 4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4U
 MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfU8KsjUU
 UUU
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

Move sxe2_flow_parse_pattern_ipip, sxe2_flow_add_udp_tunnel_port and
sxe2_flow_add_tunnel_port from sxe2_flow_parse_pattern.c into
sxe2_flow.c as static helpers, and drop the public declaration of
sxe2_flow_add_tunnel_port from the header, keeping the tunnel port
handling internal to the flow module.

Cc: stephen@networkplumber.org
Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/sxe2_flow.c               | 113 +++++++++++++++++++++
 drivers/net/sxe2/sxe2_flow_parse_pattern.c | 113 ---------------------
 drivers/net/sxe2/sxe2_flow_parse_pattern.h |   6 --
 3 files changed, 113 insertions(+), 119 deletions(-)

diff --git a/drivers/net/sxe2/sxe2_flow.c b/drivers/net/sxe2/sxe2_flow.c
index a33b8606df..cd39385340 100644
--- a/drivers/net/sxe2/sxe2_flow.c
+++ b/drivers/net/sxe2/sxe2_flow.c
@@ -550,6 +550,119 @@ int32_t sxe2_flow_init_udp_tunnel_port(struct rte_eth_dev *dev)
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
index 8442c35cae..69d83a6ea6 100644
--- a/drivers/net/sxe2/sxe2_flow_parse_pattern.h
+++ b/drivers/net/sxe2/sxe2_flow_parse_pattern.h
@@ -37,10 +37,4 @@ int32_t sxe2_flow_parse_pattern(struct rte_eth_dev *dev,
 			    struct rte_flow_error *error,
 			    struct sxe2_flow *flow);
 
-int32_t sxe2_flow_add_tunnel_port(struct rte_eth_dev *dev,
-			      struct rte_flow_error *error,
-			      struct sxe2_flow *flow,
-			      BITMAP_TYPE *flow_type,
-			      enum sxe2_flow_tunnel_type tunnel_type);
-
 #endif /* SXE2_FLOW_PARSE_PATTERN_H_ */
-- 
2.52.0

