Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2ED4C61DB2
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Jun 2025 08:43:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9003342F0B;
	Fri, 13 Jun 2025 10:42:38 +0200 (CEST)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
 by mails.dpdk.org (Postfix) with ESMTP id 01B7A42EA3;
 Fri, 13 Jun 2025 10:42:33 +0200 (CEST)
X-QQ-mid: esmtpsz18t1749804141t910fe6af
X-QQ-Originating-IP: 0ZOMFu8x8Id6Fu01EfnWsX5luYH+UGONw5l+pXzes2k=
Received: from lap-jiawenwu.trustnetic.com ( [36.20.60.58])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 13 Jun 2025 16:42:20 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4358581436444097350
EX-QQ-RecipientCnt: 4
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: dev@dpdk.org
Cc: zaiyuwang@trustnetic.com, Jiawen Wu <jiawenwu@trustnetic.com>,
 stable@dpdk.org
Subject: [PATCH v3 04/17] net/txgbe: fix packet type for FDIR filters
Date: Fri, 13 Jun 2025 16:41:46 +0800
Message-Id: <20250613084159.22184-5-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250613084159.22184-1-jiawenwu@trustnetic.com>
References: <00DEAE896AFE0D2D+20250606080117.183198-1-jiawenwu@trustnetic.com>
 <20250613084159.22184-1-jiawenwu@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OdKM2jcE40T2yGAAxe2UIp2a3+GpEwdZln8fTot9cUb2RsH7Mu1YKPLs
 q/+pMzQyfThS1tP6T2iCjqXmiwzJR6tPbSfVBRY5yXkPmHhXOjpIzYvE59ES5+yiCG3dxGB
 YAENj4jXAdJEMqSEq+lkuXivx8f1d+Wx5q3X3CqCK9WghFiSSDV0xgNVdbKLIaZNpJNWAiu
 X96guqdAkMukuagTrG0VmLJgrKptuxRGyg4QyFEfyACod4Dytq4vKNoN5w0g8h6litGb6uo
 hmw07lCCSxlRk9Ns4fZjdWWkoHr8ym8hPoOEfLCuboyXLUUssjMmLn8L5oMJIleTshj2ila
 TRzv9332daUJouec6WAoJyheHYD5hB2YfnIcbOIpitkkQBgmT7FV/29vYu2MrfnRFUWEm50
 vg/wsO/F2xr1FHeF1UVFmpOHeaG51Stt8Ux95kRAoeSpZ6urgkwElCHDiEU8lwTL2KnmcX4
 TmBaBLb3al8IS0Mg+2swFn/8DicL0ePUU63mhZQQgq/z+arlJQshALcI1jPH+BuUq20PCRs
 G9cONDoRE9Sq9v7lpSfSxNEI2iezMJwN8F40BgXrex2LI5CUFPIHvkgyYX+T6iM7P3+OMGH
 oImb2aisfi2KtetxJFt72nVx/NtuKAhqmArOd+mtZI/FM+z4C+ev2v2jMW9OlGl0iq5Qxxv
 gwf2sySA5mozmV34FXni2dzXa5//5kR4RvmG+ibBwCx75mUJ6qge1Gi3gb3gJZnJhR+gFtQ
 +Kj2S1V//e9CypuP4rtubZMc7XQKYetvmFkH1R3DhPmXXGZpeOUCbJ0YiCUIX1wzm0sZ3Hs
 SYzVckvrK5rSsvELw7fNgfAoi65KPXlxqKNXmfcoi6NRBcbYB9LuBwsRo+KLUiNtEGF1LXf
 YuOPLtJYf7rXDtvVByw5XXDb1OrjqInWdXeU5UqhI42Ah1C/uj5efDamd3nE4Uhhj7mDIgz
 4K9nd4xQgMnkQzS7C/H/Hc6uNN7Tos2X40phC40DYwhP10mptWBBrvC1ogzPqjwC21eb/vV
 c8IE035nEaVdqFg5SwlmI5pkRPb/nBjL15HM/lL3ws4knYcKE6
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0
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

To match the packet type more flexibly when the pattern is default, add
packet type mask for FDIR filters.

Fixes: b973ee26747a ("net/txgbe: parse flow director filter")
Cc: stable@dpdk.org

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_type.h |  20 +--
 drivers/net/txgbe/txgbe_ethdev.h    |   3 +-
 drivers/net/txgbe/txgbe_fdir.c      |  16 +--
 drivers/net/txgbe/txgbe_flow.c      | 188 +++++++++++++++-------------
 4 files changed, 116 insertions(+), 111 deletions(-)

diff --git a/drivers/net/txgbe/base/txgbe_type.h b/drivers/net/txgbe/base/txgbe_type.h
index 4371876649..383438ea3c 100644
--- a/drivers/net/txgbe/base/txgbe_type.h
+++ b/drivers/net/txgbe/base/txgbe_type.h
@@ -88,8 +88,11 @@ enum {
 #define TXGBE_ATR_L4TYPE_UDP			0x1
 #define TXGBE_ATR_L4TYPE_TCP			0x2
 #define TXGBE_ATR_L4TYPE_SCTP			0x3
-#define TXGBE_ATR_TUNNEL_MASK			0x10
-#define TXGBE_ATR_TUNNEL_ANY			0x10
+#define TXGBE_ATR_TYPE_MASK_TUN			0x80
+#define TXGBE_ATR_TYPE_MASK_TUN_OUTIP		0x40
+#define TXGBE_ATR_TYPE_MASK_TUN_TYPE		0x20
+#define TXGBE_ATR_TYPE_MASK_L3P			0x10
+#define TXGBE_ATR_TYPE_MASK_L4P			0x08
 enum txgbe_atr_flow_type {
 	TXGBE_ATR_FLOW_TYPE_IPV4		= 0x0,
 	TXGBE_ATR_FLOW_TYPE_UDPV4		= 0x1,
@@ -99,14 +102,6 @@ enum txgbe_atr_flow_type {
 	TXGBE_ATR_FLOW_TYPE_UDPV6		= 0x5,
 	TXGBE_ATR_FLOW_TYPE_TCPV6		= 0x6,
 	TXGBE_ATR_FLOW_TYPE_SCTPV6		= 0x7,
-	TXGBE_ATR_FLOW_TYPE_TUNNELED_IPV4	= 0x10,
-	TXGBE_ATR_FLOW_TYPE_TUNNELED_UDPV4	= 0x11,
-	TXGBE_ATR_FLOW_TYPE_TUNNELED_TCPV4	= 0x12,
-	TXGBE_ATR_FLOW_TYPE_TUNNELED_SCTPV4	= 0x13,
-	TXGBE_ATR_FLOW_TYPE_TUNNELED_IPV6	= 0x14,
-	TXGBE_ATR_FLOW_TYPE_TUNNELED_UDPV6	= 0x15,
-	TXGBE_ATR_FLOW_TYPE_TUNNELED_TCPV6	= 0x16,
-	TXGBE_ATR_FLOW_TYPE_TUNNELED_SCTPV6	= 0x17,
 };
 
 /* Flow Director ATR input struct. */
@@ -116,11 +111,8 @@ struct txgbe_atr_input {
 	 *
 	 * vm_pool	- 1 byte
 	 * flow_type	- 1 byte
-	 * vlan_id	- 2 bytes
+	 * pkt_type	- 2 bytes
 	 * src_ip	- 16 bytes
-	 * inner_mac	- 6 bytes
-	 * cloud_mode	- 2 bytes
-	 * tni_vni	- 4 bytes
 	 * dst_ip	- 16 bytes
 	 * src_port	- 2 bytes
 	 * dst_port	- 2 bytes
diff --git a/drivers/net/txgbe/txgbe_ethdev.h b/drivers/net/txgbe/txgbe_ethdev.h
index 0a3c634937..01e8a9fc05 100644
--- a/drivers/net/txgbe/txgbe_ethdev.h
+++ b/drivers/net/txgbe/txgbe_ethdev.h
@@ -91,8 +91,7 @@ struct txgbe_hw_fdir_mask {
 	uint16_t dst_port_mask;
 	uint16_t flex_bytes_mask;
 	uint8_t  mac_addr_byte_mask;
-	uint32_t tunnel_id_mask;
-	uint8_t  tunnel_type_mask;
+	uint8_t  pkt_type_mask; /* reversed mask for hw */
 };
 
 struct txgbe_fdir_filter {
diff --git a/drivers/net/txgbe/txgbe_fdir.c b/drivers/net/txgbe/txgbe_fdir.c
index 75bf30c00c..0d12fb9a11 100644
--- a/drivers/net/txgbe/txgbe_fdir.c
+++ b/drivers/net/txgbe/txgbe_fdir.c
@@ -187,18 +187,12 @@ txgbe_fdir_set_input_mask(struct rte_eth_dev *dev)
 		return -ENOTSUP;
 	}
 
-	/*
-	 * Program the relevant mask registers.  If src/dst_port or src/dst_addr
-	 * are zero, then assume a full mask for that field. Also assume that
-	 * a VLAN of 0 is unspecified, so mask that out as well.  L4type
-	 * cannot be masked out in this implementation.
-	 */
-	if (info->mask.dst_port_mask == 0 && info->mask.src_port_mask == 0) {
-		/* use the L4 protocol mask for raw IPv4/IPv6 traffic */
-		fdirm |= TXGBE_FDIRMSK_L4P;
-	}
+	/* use the L4 protocol mask for raw IPv4/IPv6 traffic */
+	if (info->mask.pkt_type_mask == 0 && info->mask.dst_port_mask == 0 &&
+	    info->mask.src_port_mask == 0)
+		info->mask.pkt_type_mask |= TXGBE_FDIRMSK_L4P;
 
-	/* TBD: don't support encapsulation yet */
+	fdirm |= info->mask.pkt_type_mask;
 	wr32(hw, TXGBE_FDIRMSK, fdirm);
 
 	/* store the TCP/UDP port masks */
diff --git a/drivers/net/txgbe/txgbe_flow.c b/drivers/net/txgbe/txgbe_flow.c
index 8670c3e1d7..bce88aebd3 100644
--- a/drivers/net/txgbe/txgbe_flow.c
+++ b/drivers/net/txgbe/txgbe_flow.c
@@ -1487,8 +1487,41 @@ static inline uint8_t signature_match(const struct rte_flow_item pattern[])
 	return 0;
 }
 
+static void
+txgbe_fdir_parse_flow_type(struct txgbe_atr_input *input, u8 ptid, bool tun)
+{
+	if (!tun)
+		ptid = TXGBE_PTID_PKT_IP;
+
+	switch (input->flow_type & TXGBE_ATR_L4TYPE_MASK) {
+	case TXGBE_ATR_L4TYPE_UDP:
+		ptid |= TXGBE_PTID_TYP_UDP;
+		break;
+	case TXGBE_ATR_L4TYPE_TCP:
+		ptid |= TXGBE_PTID_TYP_TCP;
+		break;
+	case TXGBE_ATR_L4TYPE_SCTP:
+		ptid |= TXGBE_PTID_TYP_SCTP;
+		break;
+	default:
+		break;
+	}
+
+	switch (input->flow_type & TXGBE_ATR_L3TYPE_MASK) {
+	case TXGBE_ATR_L3TYPE_IPV4:
+		break;
+	case TXGBE_ATR_L3TYPE_IPV6:
+		ptid |= TXGBE_PTID_PKT_IPV6;
+		break;
+	default:
+		break;
+	}
+
+	input->pkt_type = cpu_to_be16(ptid);
+}
+
 /**
- * Parse the rule to see if it is a IP or MAC VLAN flow director rule.
+ * Parse the rule to see if it is a IP flow director rule.
  * And get the flow director filter info BTW.
  * UDP/TCP/SCTP PATTERN:
  * The first not void item can be ETH or IPV4 or IPV6
@@ -1555,7 +1588,6 @@ txgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev __rte_unused,
 	const struct rte_flow_item_sctp *sctp_mask;
 	const struct rte_flow_item_raw *raw_mask;
 	const struct rte_flow_item_raw *raw_spec;
-	u32 ptype = 0;
 	uint8_t j;
 
 	if (!pattern) {
@@ -1585,6 +1617,9 @@ txgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev __rte_unused,
 	 */
 	memset(rule, 0, sizeof(struct txgbe_fdir_rule));
 	memset(&rule->mask, 0, sizeof(struct txgbe_hw_fdir_mask));
+	rule->mask.pkt_type_mask = TXGBE_ATR_TYPE_MASK_L3P |
+				   TXGBE_ATR_TYPE_MASK_L4P;
+	memset(&rule->input, 0, sizeof(struct txgbe_atr_input));
 
 	/**
 	 * The first not void item should be
@@ -1687,7 +1722,9 @@ txgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev __rte_unused,
 			}
 		} else {
 			if (item->type != RTE_FLOW_ITEM_TYPE_IPV4 &&
-					item->type != RTE_FLOW_ITEM_TYPE_VLAN) {
+			    item->type != RTE_FLOW_ITEM_TYPE_VLAN &&
+			    item->type != RTE_FLOW_ITEM_TYPE_IPV6 &&
+			    item->type != RTE_FLOW_ITEM_TYPE_RAW) {
 				memset(rule, 0, sizeof(struct txgbe_fdir_rule));
 				rte_flow_error_set(error, EINVAL,
 					RTE_FLOW_ERROR_TYPE_ITEM,
@@ -1695,6 +1732,8 @@ txgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev __rte_unused,
 				return -rte_errno;
 			}
 		}
+		if (item->type == RTE_FLOW_ITEM_TYPE_VLAN)
+			item = next_no_fuzzy_pattern(pattern, item);
 	}
 
 	/* Get the IPV4 info. */
@@ -1704,7 +1743,7 @@ txgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev __rte_unused,
 		 * as we must have a flow type.
 		 */
 		rule->input.flow_type = TXGBE_ATR_FLOW_TYPE_IPV4;
-		ptype = txgbe_ptype_table[TXGBE_PT_IPV4];
+		rule->mask.pkt_type_mask &= ~TXGBE_ATR_TYPE_MASK_L3P;
 		/*Not supported last point for range*/
 		if (item->last) {
 			rte_flow_error_set(error, EINVAL,
@@ -1716,31 +1755,26 @@ txgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev __rte_unused,
 		 * Only care about src & dst addresses,
 		 * others should be masked.
 		 */
-		if (!item->mask) {
-			memset(rule, 0, sizeof(struct txgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-		rule->b_mask = TRUE;
-		ipv4_mask = item->mask;
-		if (ipv4_mask->hdr.version_ihl ||
-		    ipv4_mask->hdr.type_of_service ||
-		    ipv4_mask->hdr.total_length ||
-		    ipv4_mask->hdr.packet_id ||
-		    ipv4_mask->hdr.fragment_offset ||
-		    ipv4_mask->hdr.time_to_live ||
-		    ipv4_mask->hdr.next_proto_id ||
-		    ipv4_mask->hdr.hdr_checksum) {
-			memset(rule, 0, sizeof(struct txgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
+		if (item->mask) {
+			rule->b_mask = TRUE;
+			ipv4_mask = item->mask;
+			if (ipv4_mask->hdr.version_ihl ||
+			    ipv4_mask->hdr.type_of_service ||
+			    ipv4_mask->hdr.total_length ||
+			    ipv4_mask->hdr.packet_id ||
+			    ipv4_mask->hdr.fragment_offset ||
+			    ipv4_mask->hdr.time_to_live ||
+			    ipv4_mask->hdr.next_proto_id ||
+			    ipv4_mask->hdr.hdr_checksum) {
+				memset(rule, 0, sizeof(struct txgbe_fdir_rule));
+				rte_flow_error_set(error, EINVAL,
+					RTE_FLOW_ERROR_TYPE_ITEM,
+					item, "Not supported by fdir filter");
+				return -rte_errno;
+			}
+			rule->mask.dst_ipv4_mask = ipv4_mask->hdr.dst_addr;
+			rule->mask.src_ipv4_mask = ipv4_mask->hdr.src_addr;
 		}
-		rule->mask.dst_ipv4_mask = ipv4_mask->hdr.dst_addr;
-		rule->mask.src_ipv4_mask = ipv4_mask->hdr.src_addr;
 
 		if (item->spec) {
 			rule->b_spec = TRUE;
@@ -1776,16 +1810,14 @@ txgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev __rte_unused,
 		 * as we must have a flow type.
 		 */
 		rule->input.flow_type = TXGBE_ATR_FLOW_TYPE_IPV6;
-		ptype = txgbe_ptype_table[TXGBE_PT_IPV6];
+		rule->mask.pkt_type_mask &= ~TXGBE_ATR_TYPE_MASK_L3P;
 
 		/**
 		 * 1. must signature match
 		 * 2. not support last
-		 * 3. mask must not null
 		 */
 		if (rule->mode != RTE_FDIR_MODE_SIGNATURE ||
-		    item->last ||
-		    !item->mask) {
+		    item->last) {
 			memset(rule, 0, sizeof(struct txgbe_fdir_rule));
 			rte_flow_error_set(error, EINVAL,
 				RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
@@ -1793,42 +1825,44 @@ txgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev __rte_unused,
 			return -rte_errno;
 		}
 
-		rule->b_mask = TRUE;
-		ipv6_mask = item->mask;
-		if (ipv6_mask->hdr.vtc_flow ||
-		    ipv6_mask->hdr.payload_len ||
-		    ipv6_mask->hdr.proto ||
-		    ipv6_mask->hdr.hop_limits) {
-			memset(rule, 0, sizeof(struct txgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-
-		/* check src addr mask */
-		for (j = 0; j < 16; j++) {
-			if (ipv6_mask->hdr.src_addr.a[j] == UINT8_MAX) {
-				rule->mask.src_ipv6_mask |= 1 << j;
-			} else if (ipv6_mask->hdr.src_addr.a[j] != 0) {
+		if (item->mask) {
+			rule->b_mask = TRUE;
+			ipv6_mask = item->mask;
+			if (ipv6_mask->hdr.vtc_flow ||
+			    ipv6_mask->hdr.payload_len ||
+			    ipv6_mask->hdr.proto ||
+			    ipv6_mask->hdr.hop_limits) {
 				memset(rule, 0, sizeof(struct txgbe_fdir_rule));
 				rte_flow_error_set(error, EINVAL,
 					RTE_FLOW_ERROR_TYPE_ITEM,
 					item, "Not supported by fdir filter");
 				return -rte_errno;
 			}
-		}
 
-		/* check dst addr mask */
-		for (j = 0; j < 16; j++) {
-			if (ipv6_mask->hdr.dst_addr.a[j] == UINT8_MAX) {
-				rule->mask.dst_ipv6_mask |= 1 << j;
-			} else if (ipv6_mask->hdr.dst_addr.a[j] != 0) {
-				memset(rule, 0, sizeof(struct txgbe_fdir_rule));
-				rte_flow_error_set(error, EINVAL,
-					RTE_FLOW_ERROR_TYPE_ITEM,
-					item, "Not supported by fdir filter");
-				return -rte_errno;
+			/* check src addr mask */
+			for (j = 0; j < 16; j++) {
+				if (ipv6_mask->hdr.src_addr.a[j] == UINT8_MAX) {
+					rule->mask.src_ipv6_mask |= 1 << j;
+				} else if (ipv6_mask->hdr.src_addr.a[j] != 0) {
+					memset(rule, 0, sizeof(struct txgbe_fdir_rule));
+					rte_flow_error_set(error, EINVAL,
+						RTE_FLOW_ERROR_TYPE_ITEM,
+						item, "Not supported by fdir filter");
+					return -rte_errno;
+				}
+			}
+
+			/* check dst addr mask */
+			for (j = 0; j < 16; j++) {
+				if (ipv6_mask->hdr.dst_addr.a[j] == UINT8_MAX) {
+					rule->mask.dst_ipv6_mask |= 1 << j;
+				} else if (ipv6_mask->hdr.dst_addr.a[j] != 0) {
+					memset(rule, 0, sizeof(struct txgbe_fdir_rule));
+					rte_flow_error_set(error, EINVAL,
+						RTE_FLOW_ERROR_TYPE_ITEM,
+						item, "Not supported by fdir filter");
+					return -rte_errno;
+				}
 			}
 		}
 
@@ -1866,10 +1900,8 @@ txgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev __rte_unused,
 		 * as we must have a flow type.
 		 */
 		rule->input.flow_type |= TXGBE_ATR_L4TYPE_TCP;
-		if (rule->input.flow_type & TXGBE_ATR_FLOW_TYPE_IPV6)
-			ptype = txgbe_ptype_table[TXGBE_PT_IPV6_TCP];
-		else
-			ptype = txgbe_ptype_table[TXGBE_PT_IPV4_TCP];
+		rule->mask.pkt_type_mask &= ~TXGBE_ATR_TYPE_MASK_L4P;
+
 		/*Not supported last point for range*/
 		if (item->last) {
 			rte_flow_error_set(error, EINVAL,
@@ -1933,10 +1965,8 @@ txgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev __rte_unused,
 		 * as we must have a flow type.
 		 */
 		rule->input.flow_type |= TXGBE_ATR_L4TYPE_UDP;
-		if (rule->input.flow_type & TXGBE_ATR_FLOW_TYPE_IPV6)
-			ptype = txgbe_ptype_table[TXGBE_PT_IPV6_UDP];
-		else
-			ptype = txgbe_ptype_table[TXGBE_PT_IPV4_UDP];
+		rule->mask.pkt_type_mask &= ~TXGBE_ATR_TYPE_MASK_L4P;
+
 		/*Not supported last point for range*/
 		if (item->last) {
 			rte_flow_error_set(error, EINVAL,
@@ -1995,10 +2025,8 @@ txgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev __rte_unused,
 		 * as we must have a flow type.
 		 */
 		rule->input.flow_type |= TXGBE_ATR_L4TYPE_SCTP;
-		if (rule->input.flow_type & TXGBE_ATR_FLOW_TYPE_IPV6)
-			ptype = txgbe_ptype_table[TXGBE_PT_IPV6_SCTP];
-		else
-			ptype = txgbe_ptype_table[TXGBE_PT_IPV4_SCTP];
+		rule->mask.pkt_type_mask &= ~TXGBE_ATR_TYPE_MASK_L4P;
+
 		/*Not supported last point for range*/
 		if (item->last) {
 			rte_flow_error_set(error, EINVAL,
@@ -2163,17 +2191,7 @@ txgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev __rte_unused,
 		}
 	}
 
-	rule->input.pkt_type = cpu_to_be16(txgbe_encode_ptype(ptype));
-
-	if (rule->input.flow_type & TXGBE_ATR_FLOW_TYPE_IPV6) {
-		if (rule->input.flow_type & TXGBE_ATR_L4TYPE_MASK)
-			rule->input.pkt_type &= 0xFFFF;
-		else
-			rule->input.pkt_type &= 0xF8FF;
-
-		rule->input.flow_type &= TXGBE_ATR_L3TYPE_MASK |
-					TXGBE_ATR_L4TYPE_MASK;
-	}
+	txgbe_fdir_parse_flow_type(&rule->input, 0, false);
 
 	return txgbe_parse_fdir_act_attr(attr, actions, rule, error);
 }
@@ -2863,6 +2881,8 @@ txgbe_flow_create(struct rte_eth_dev *dev,
 									flex_base);
 				}
 
+				fdir_info->mask.pkt_type_mask =
+					fdir_rule.mask.pkt_type_mask;
 				ret = txgbe_fdir_set_input_mask(dev);
 				if (ret)
 					goto out;
-- 
2.48.1


