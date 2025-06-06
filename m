Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CDCCC5B549
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Jun 2025 08:02:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A48C40662;
	Fri,  6 Jun 2025 10:01:56 +0200 (CEST)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
 by mails.dpdk.org (Postfix) with ESMTP id 7375140611
 for <dev@dpdk.org>; Fri,  6 Jun 2025 10:01:53 +0200 (CEST)
X-QQ-mid: zesmtpsz2t1749196907t051b2285
X-QQ-Originating-IP: TCxNeApSKy3skQvANbyKoDl7Fxwgji4P5v3C/2U95iY=
Received: from w-MS-7E16.trustnetic.com ( [220.184.249.46])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 06 Jun 2025 16:01:45 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12444513759166034830
EX-QQ-RecipientCnt: 3
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: dev@dpdk.org
Cc: zaiyuwang@trustnetic.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH 02/12] net/txgbe: refactor FDIR filter to improve functionality
Date: Fri,  6 Jun 2025 16:01:07 +0800
Message-ID: <2430F12A7223B66B+20250606080117.183198-3-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250606080117.183198-1-jiawenwu@trustnetic.com>
References: <20250606080117.183198-1-jiawenwu@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OFWsfmE1GYcumoUQ04DpCAhryH3wSWbgjfQPSyt0h5a/ebijzu9vGvRY
 iR0c7n59zQq+vAmADlZkVAZK2BDGLYSVCTeAyGfXWIJz3k547ZsAasCsRhVME7Nm89dAMp8
 v91/HU4diZOzB/mBDIP5VJyGTT+ViP9BzUyPBZSaaEnhm2Ksl9OHyIhPepSu2+sFF63+5Ry
 RTtvfo2a9EuLGcCqEabi8aDvFldS+/hG1lSz8fWFtTvGNHoULmk9z6ZUAWTkoqoVAupWqFj
 ChuQvOcmIOjTkhJdk41SI7lmvrddzzedggn/Af6Iv1cWzGrCL2q1EReiOAVXKg+EjIb/FLE
 7NcTZ59uFwWCtE47qg+WEkowcxBkDDuiRYLgJGTMVH3vQByvAJnueF4m3LBEUDjAHE/2o6Z
 GOjDfT30sDy8RRmfAlSCCYL1WjJ9leMuMfjdbBJNvpuYSfv6k8MSBXYyw8C/wFb1UKZvjgo
 nplHbisd5z8X8YbRcsrH9xpkoj9ptlB8EpkDey99H9UURe4KVMhO6vQBRqS3jW80prAvirF
 3uBOTUD04uugLu6eiCEoPXmemYJz1ciSPmzqYCowo0c+DPZ5JCbEFD8L0DztIeZmyJhLlJU
 8Z4fhf0sqzhn0cmamTFk4UIrKnNdeJBF+vimTCYCHtDTm6ozVSqSW27iPLUnNs7S32JwILW
 xxLzU4E86zy3hUsvJ09p++FQT1n5ZEMU+fir6xlFR4yWEJjeUBnsVlJah5qgbql3//x3BK6
 9hN0mCOnCvbMDDu2yiqE6Gb0Pes3FgHRzkzmCkTH1up55Mkaj51CBQlkKu4bFLW31Xb0T9M
 QVsccGVec3yIQPuhqSVpLqIUC10UwLX0YeNPujS1Kr/GF57LvqYnYy0YzTx0tSONFKctngV
 FOjo/QMgKji60p5iHd6M7GHTFsiWWOEmC9MiR2YQT6cm9ArPkYT3GSxd3jXl+c28jamXjYu
 0L850HY+l+qYr/+TFKwMAKYY6Zem/W7WnNRFDVQmBprYSe2xPX9Gd5zjGGQthapIIovp88i
 PbsEiQLU8w6IjhaHr1
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
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

There were some defects in the original configuration for flow director
filter. Now make the following improvements:

1) Fix incorrect parsing to ntuple filter when set the pattern likes:
   flow create ... ipv4 / udp dst is ... / raw ... / end actions ... / end
2) Fix flex offset base to set item RAW relative = 1, and convert RAW
   pattern string to hex bytes to match the hardware identification.
3) Fix to create FDIR rules for VXLAN/GRE/NVGRE/GENEVE packets, they will
   match the rules in the inner layers.
4) Support IPv6 perfect mode.
5) Add packet type mask to match more types of packets if the pattern is
   default.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_type.h |  20 +-
 drivers/net/txgbe/txgbe_ethdev.h    |   9 +-
 drivers/net/txgbe/txgbe_fdir.c      |  62 +-
 drivers/net/txgbe/txgbe_flow.c      | 847 ++++++++++++++++++++--------
 4 files changed, 669 insertions(+), 269 deletions(-)

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
index 36d51fcbb8..c2d0950d2c 100644
--- a/drivers/net/txgbe/txgbe_ethdev.h
+++ b/drivers/net/txgbe/txgbe_ethdev.h
@@ -90,9 +90,7 @@ struct txgbe_hw_fdir_mask {
 	uint16_t src_port_mask;
 	uint16_t dst_port_mask;
 	uint16_t flex_bytes_mask;
-	uint8_t  mac_addr_byte_mask;
-	uint32_t tunnel_id_mask;
-	uint8_t  tunnel_type_mask;
+	uint8_t  pkt_type_mask; /* reversed mask for hw */
 };
 
 struct txgbe_fdir_filter {
@@ -116,11 +114,13 @@ struct txgbe_fdir_rule {
 	uint32_t soft_id; /* an unique value for this rule */
 	uint8_t queue; /* assigned rx queue */
 	uint8_t flex_bytes_offset;
+	bool flex_relative;
 };
 
 struct txgbe_hw_fdir_info {
 	struct txgbe_hw_fdir_mask mask;
 	uint8_t     flex_bytes_offset;
+	bool        flex_relative;
 	uint16_t    collision;
 	uint16_t    free;
 	uint16_t    maxhash;
@@ -561,8 +561,9 @@ void txgbe_set_ivar_map(struct txgbe_hw *hw, int8_t direction,
  */
 int txgbe_fdir_configure(struct rte_eth_dev *dev);
 int txgbe_fdir_set_input_mask(struct rte_eth_dev *dev);
+uint16_t txgbe_fdir_get_flex_base(struct txgbe_fdir_rule *rule);
 int txgbe_fdir_set_flexbytes_offset(struct rte_eth_dev *dev,
-				    uint16_t offset);
+				    uint16_t offset, uint16_t flex_base);
 int txgbe_fdir_filter_program(struct rte_eth_dev *dev,
 			      struct txgbe_fdir_rule *rule,
 			      bool del, bool update);
diff --git a/drivers/net/txgbe/txgbe_fdir.c b/drivers/net/txgbe/txgbe_fdir.c
index f627ab681d..0efd43b59a 100644
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
@@ -216,15 +210,12 @@ txgbe_fdir_set_input_mask(struct rte_eth_dev *dev)
 	wr32(hw, TXGBE_FDIRSIP4MSK, ~info->mask.src_ipv4_mask);
 	wr32(hw, TXGBE_FDIRDIP4MSK, ~info->mask.dst_ipv4_mask);
 
-	if (mode == RTE_FDIR_MODE_SIGNATURE) {
-		/*
-		 * Store source and destination IPv6 masks (bit reversed)
-		 */
-		fdiripv6m = TXGBE_FDIRIP6MSK_DST(info->mask.dst_ipv6_mask) |
-			    TXGBE_FDIRIP6MSK_SRC(info->mask.src_ipv6_mask);
-
-		wr32(hw, TXGBE_FDIRIP6MSK, ~fdiripv6m);
-	}
+	/*
+	 * Store source and destination IPv6 masks (bit reversed)
+	 */
+	fdiripv6m = TXGBE_FDIRIP6MSK_DST(info->mask.dst_ipv6_mask) |
+		    TXGBE_FDIRIP6MSK_SRC(info->mask.src_ipv6_mask);
+	wr32(hw, TXGBE_FDIRIP6MSK, ~fdiripv6m);
 
 	return 0;
 }
@@ -258,9 +249,24 @@ txgbe_fdir_store_input_mask(struct rte_eth_dev *dev)
 	return 0;
 }
 
+uint16_t
+txgbe_fdir_get_flex_base(struct txgbe_fdir_rule *rule)
+{
+	if (!rule->flex_relative)
+		return TXGBE_FDIRFLEXCFG_BASE_MAC;
+
+	if (rule->input.flow_type & TXGBE_ATR_L4TYPE_MASK)
+		return TXGBE_FDIRFLEXCFG_BASE_PAY;
+
+	if (rule->input.flow_type & TXGBE_ATR_L3TYPE_MASK)
+		return TXGBE_FDIRFLEXCFG_BASE_L3;
+
+	return TXGBE_FDIRFLEXCFG_BASE_L2;
+}
+
 int
 txgbe_fdir_set_flexbytes_offset(struct rte_eth_dev *dev,
-				uint16_t offset)
+				uint16_t offset, uint16_t flex_base)
 {
 	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
 	int i;
@@ -268,7 +274,7 @@ txgbe_fdir_set_flexbytes_offset(struct rte_eth_dev *dev,
 	for (i = 0; i < 64; i++) {
 		uint32_t flexreg, flex;
 		flexreg = rd32(hw, TXGBE_FDIRFLEXCFG(i / 4));
-		flex = TXGBE_FDIRFLEXCFG_BASE_MAC;
+		flex = flex_base;
 		flex |= TXGBE_FDIRFLEXCFG_OFST(offset / 2);
 		flexreg &= ~(TXGBE_FDIRFLEXCFG_ALL(~0UL, i % 4));
 		flexreg |= TXGBE_FDIRFLEXCFG_ALL(flex, i % 4);
@@ -633,6 +639,8 @@ fdir_write_perfect_filter(struct txgbe_hw *hw,
 	fdircmd |= TXGBE_FDIRPICMD_QP(queue);
 	fdircmd |= TXGBE_FDIRPICMD_POOL(input->vm_pool);
 
+	if (input->flow_type & TXGBE_ATR_L3TYPE_IPV6)
+		fdircmd |= TXGBE_FDIRPICMD_IP6;
 	wr32(hw, TXGBE_FDIRPICMD, fdircmd);
 
 	PMD_DRV_LOG(DEBUG, "Rx Queue=%x hash=%x", queue, fdirhash);
@@ -801,11 +809,6 @@ txgbe_fdir_filter_program(struct rte_eth_dev *dev,
 		is_perfect = TRUE;
 
 	if (is_perfect) {
-		if (rule->input.flow_type & TXGBE_ATR_L3TYPE_IPV6) {
-			PMD_DRV_LOG(ERR, "IPv6 is not supported in"
-				    " perfect mode!");
-			return -ENOTSUP;
-		}
 		fdirhash = atr_compute_perfect_hash(&rule->input,
 				TXGBE_DEV_FDIR_CONF(dev)->pballoc);
 		fdirhash |= TXGBE_FDIRPIHASH_IDX(rule->soft_id);
@@ -910,6 +913,11 @@ txgbe_fdir_flush(struct rte_eth_dev *dev)
 	info->add = 0;
 	info->remove = 0;
 
+	memset(&info->mask, 0, sizeof(struct txgbe_hw_fdir_mask));
+	info->mask_added = false;
+	info->flex_relative = false;
+	info->flex_bytes_offset = 0;
+
 	return ret;
 }
 
diff --git a/drivers/net/txgbe/txgbe_flow.c b/drivers/net/txgbe/txgbe_flow.c
index 0fc2cb1d3b..82d0599d9a 100644
--- a/drivers/net/txgbe/txgbe_flow.c
+++ b/drivers/net/txgbe/txgbe_flow.c
@@ -361,7 +361,7 @@ cons_parse_ntuple_filter(const struct rte_flow_attr *attr,
 
 	if (item->type != RTE_FLOW_ITEM_TYPE_END &&
 		(!item->spec && !item->mask)) {
-		goto action;
+		goto item_end;
 	}
 
 	/* get the TCP/UDP/SCTP info */
@@ -490,6 +490,7 @@ cons_parse_ntuple_filter(const struct rte_flow_attr *attr,
 		goto action;
 	}
 
+item_end:
 	/* check if the next not void item is END */
 	item = next_no_void_pattern(pattern, item);
 	if (item->type != RTE_FLOW_ITEM_TYPE_END) {
@@ -1486,8 +1487,41 @@ static inline uint8_t signature_match(const struct rte_flow_item pattern[])
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
@@ -1554,7 +1588,6 @@ txgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev __rte_unused,
 	const struct rte_flow_item_sctp *sctp_mask;
 	const struct rte_flow_item_raw *raw_mask;
 	const struct rte_flow_item_raw *raw_spec;
-	u32 ptype = 0;
 	uint8_t j;
 
 	if (!pattern) {
@@ -1584,6 +1617,9 @@ txgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev __rte_unused,
 	 */
 	memset(rule, 0, sizeof(struct txgbe_fdir_rule));
 	memset(&rule->mask, 0, sizeof(struct txgbe_hw_fdir_mask));
+	rule->mask.pkt_type_mask = TXGBE_ATR_TYPE_MASK_L3P |
+				   TXGBE_ATR_TYPE_MASK_L4P;
+	memset(&rule->input, 0, sizeof(struct txgbe_atr_input));
 
 	/**
 	 * The first not void item should be
@@ -1686,7 +1722,9 @@ txgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev __rte_unused,
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
@@ -1694,6 +1732,8 @@ txgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev __rte_unused,
 				return -rte_errno;
 			}
 		}
+		if (item->type == RTE_FLOW_ITEM_TYPE_VLAN)
+			item = next_no_fuzzy_pattern(pattern, item);
 	}
 
 	/* Get the IPV4 info. */
@@ -1703,7 +1743,7 @@ txgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev __rte_unused,
 		 * as we must have a flow type.
 		 */
 		rule->input.flow_type = TXGBE_ATR_FLOW_TYPE_IPV4;
-		ptype = txgbe_ptype_table[TXGBE_PT_IPV4];
+		rule->mask.pkt_type_mask &= ~TXGBE_ATR_TYPE_MASK_L3P;
 		/*Not supported last point for range*/
 		if (item->last) {
 			rte_flow_error_set(error, EINVAL,
@@ -1715,31 +1755,26 @@ txgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev __rte_unused,
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
@@ -1775,16 +1810,9 @@ txgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev __rte_unused,
 		 * as we must have a flow type.
 		 */
 		rule->input.flow_type = TXGBE_ATR_FLOW_TYPE_IPV6;
-		ptype = txgbe_ptype_table[TXGBE_PT_IPV6];
+		rule->mask.pkt_type_mask &= ~TXGBE_ATR_TYPE_MASK_L3P;
 
-		/**
-		 * 1. must signature match
-		 * 2. not support last
-		 * 3. mask must not null
-		 */
-		if (rule->mode != RTE_FDIR_MODE_SIGNATURE ||
-		    item->last ||
-		    !item->mask) {
+		if (item->last) {
 			memset(rule, 0, sizeof(struct txgbe_fdir_rule));
 			rte_flow_error_set(error, EINVAL,
 				RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
@@ -1792,42 +1820,44 @@ txgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev __rte_unused,
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
 
@@ -1865,10 +1895,8 @@ txgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev __rte_unused,
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
@@ -1932,10 +1960,8 @@ txgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev __rte_unused,
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
@@ -1994,10 +2020,8 @@ txgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev __rte_unused,
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
@@ -2038,19 +2062,6 @@ txgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev __rte_unused,
 			rule->input.dst_port =
 				sctp_spec->hdr.dst_port;
 		}
-		/* others even sctp port is not supported */
-		sctp_mask = item->mask;
-		if (sctp_mask &&
-			(sctp_mask->hdr.src_port ||
-			 sctp_mask->hdr.dst_port ||
-			 sctp_mask->hdr.tag ||
-			 sctp_mask->hdr.cksum)) {
-			memset(rule, 0, sizeof(struct txgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
 
 		item = next_no_fuzzy_pattern(pattern, item);
 		if (item->type != RTE_FLOW_ITEM_TYPE_RAW &&
@@ -2065,6 +2076,8 @@ txgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev __rte_unused,
 
 	/* Get the flex byte info */
 	if (item->type == RTE_FLOW_ITEM_TYPE_RAW) {
+		uint16_t pattern = 0;
+
 		/* Not supported last point for range*/
 		if (item->last) {
 			rte_flow_error_set(error, EINVAL,
@@ -2081,6 +2094,7 @@ txgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev __rte_unused,
 			return -rte_errno;
 		}
 
+		rule->b_mask = TRUE;
 		raw_mask = item->mask;
 
 		/* check mask */
@@ -2097,19 +2111,21 @@ txgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev __rte_unused,
 			return -rte_errno;
 		}
 
+		rule->b_spec = TRUE;
 		raw_spec = item->spec;
 
 		/* check spec */
-		if (raw_spec->relative != 0 ||
-		    raw_spec->search != 0 ||
+		if (raw_spec->search != 0 ||
 		    raw_spec->reserved != 0 ||
 		    raw_spec->offset > TXGBE_MAX_FLX_SOURCE_OFF ||
 		    raw_spec->offset % 2 ||
 		    raw_spec->limit != 0 ||
-		    raw_spec->length != 2 ||
+		    raw_spec->length != 4 ||
 		    /* pattern can't be 0xffff */
 		    (raw_spec->pattern[0] == 0xff &&
-		     raw_spec->pattern[1] == 0xff)) {
+		     raw_spec->pattern[1] == 0xff &&
+		     raw_spec->pattern[2] == 0xff &&
+		     raw_spec->pattern[3] == 0xff)) {
 			memset(rule, 0, sizeof(struct txgbe_fdir_rule));
 			rte_flow_error_set(error, EINVAL,
 				RTE_FLOW_ERROR_TYPE_ITEM,
@@ -2119,7 +2135,9 @@ txgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev __rte_unused,
 
 		/* check pattern mask */
 		if (raw_mask->pattern[0] != 0xff ||
-		    raw_mask->pattern[1] != 0xff) {
+		    raw_mask->pattern[1] != 0xff ||
+		    raw_mask->pattern[2] != 0xff ||
+		    raw_mask->pattern[3] != 0xff) {
 			memset(rule, 0, sizeof(struct txgbe_fdir_rule));
 			rte_flow_error_set(error, EINVAL,
 				RTE_FLOW_ERROR_TYPE_ITEM,
@@ -2128,10 +2146,19 @@ txgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev __rte_unused,
 		}
 
 		rule->mask.flex_bytes_mask = 0xffff;
-		rule->input.flex_bytes =
-			(((uint16_t)raw_spec->pattern[1]) << 8) |
-			raw_spec->pattern[0];
+		/* Convert pattern string to hex bytes */
+		if (sscanf((const char *)raw_spec->pattern, "%hx", &pattern) != 1) {
+			memset(rule, 0, sizeof(struct txgbe_fdir_rule));
+			rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM,
+				item, "Failed to parse raw pattern");
+			return -rte_errno;
+		}
+		rule->input.flex_bytes = (pattern & 0x00FF) << 8;
+		rule->input.flex_bytes |= (pattern & 0xFF00) >> 8;
+
 		rule->flex_bytes_offset = raw_spec->offset;
+		rule->flex_relative = raw_spec->relative;
 	}
 
 	if (item->type != RTE_FLOW_ITEM_TYPE_END) {
@@ -2146,57 +2173,35 @@ txgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev __rte_unused,
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
 
 /**
- * Parse the rule to see if it is a VxLAN or NVGRE flow director rule.
+ * Parse the rule to see if it is a IP tunnel flow director rule.
  * And get the flow director filter info BTW.
- * VxLAN PATTERN:
- * The first not void item must be ETH.
- * The second not void item must be IPV4/ IPV6.
- * The third not void item must be NVGRE.
- * The next not void item must be END.
- * NVGRE PATTERN:
- * The first not void item must be ETH.
- * The second not void item must be IPV4/ IPV6.
- * The third not void item must be NVGRE.
+ * PATTERN:
+ * The first not void item can be ETH or IPV4 or IPV6 or UDP or tunnel type.
+ * The second not void item must be IPV4 or IPV6 if the first one is ETH.
+ * The next not void item could be UDP or tunnel type.
+ * The next not void item could be a certain inner layer.
  * The next not void item must be END.
  * ACTION:
- * The first not void action should be QUEUE or DROP.
- * The second not void optional action should be MARK,
- * mark_id is a uint32_t number.
+ * The first not void action should be QUEUE.
  * The next not void action should be END.
- * VxLAN pattern example:
+ * pattern example:
  * ITEM		Spec			Mask
  * ETH		NULL			NULL
- * IPV4/IPV6	NULL			NULL
+ * IPV4		NULL			NULL
  * UDP		NULL			NULL
- * VxLAN	vni{0x00, 0x32, 0x54}	{0xFF, 0xFF, 0xFF}
- * MAC VLAN	tci	0x2016		0xEFFF
- * END
- * NEGRV pattern example:
- * ITEM		Spec			Mask
+ * VXLAN	NULL			NULL
  * ETH		NULL			NULL
- * IPV4/IPV6	NULL			NULL
- * NVGRE	protocol	0x6558	0xFFFF
- *		tni{0x00, 0x32, 0x54}	{0xFF, 0xFF, 0xFF}
- * MAC VLAN	tci	0x2016		0xEFFF
+ * IPV4		src_addr 192.168.1.20	0xFFFFFFFF
+ *		dst_addr 192.167.3.50	0xFFFFFFFF
+ * UDP/TCP/SCTP	src_port	80	0xFFFF
+ *		dst_port	80	0xFFFF
  * END
- * other members in mask and spec should set to 0x00.
- * item->last should be NULL.
  */
 static int
 txgbe_parse_fdir_filter_tunnel(const struct rte_flow_attr *attr,
@@ -2207,6 +2212,17 @@ txgbe_parse_fdir_filter_tunnel(const struct rte_flow_attr *attr,
 {
 	const struct rte_flow_item *item;
 	const struct rte_flow_item_eth *eth_mask;
+	const struct rte_flow_item_ipv4 *ipv4_spec;
+	const struct rte_flow_item_ipv4 *ipv4_mask;
+	const struct rte_flow_item_ipv6 *ipv6_spec;
+	const struct rte_flow_item_ipv6 *ipv6_mask;
+	const struct rte_flow_item_tcp *tcp_spec;
+	const struct rte_flow_item_tcp *tcp_mask;
+	const struct rte_flow_item_udp *udp_spec;
+	const struct rte_flow_item_udp *udp_mask;
+	const struct rte_flow_item_sctp *sctp_spec;
+	const struct rte_flow_item_sctp *sctp_mask;
+	u8 ptid = 0;
 	uint32_t j;
 
 	if (!pattern) {
@@ -2235,12 +2251,14 @@ txgbe_parse_fdir_filter_tunnel(const struct rte_flow_attr *attr,
 	 * value. So, we need not do anything for the not provided fields later.
 	 */
 	memset(rule, 0, sizeof(struct txgbe_fdir_rule));
-	memset(&rule->mask, 0xFF, sizeof(struct txgbe_hw_fdir_mask));
-	rule->mask.vlan_tci_mask = 0;
+	memset(&rule->mask, 0, sizeof(struct txgbe_hw_fdir_mask));
+	rule->mask.pkt_type_mask = TXGBE_ATR_TYPE_MASK_TUN_OUTIP |
+				   TXGBE_ATR_TYPE_MASK_L3P |
+				   TXGBE_ATR_TYPE_MASK_L4P;
 
 	/**
 	 * The first not void item should be
-	 * MAC or IPv4 or IPv6 or UDP or VxLAN.
+	 * MAC or IPv4 or IPv6 or UDP or tunnel.
 	 */
 	item = next_no_void_pattern(pattern, NULL);
 	if (item->type != RTE_FLOW_ITEM_TYPE_ETH &&
@@ -2248,7 +2266,9 @@ txgbe_parse_fdir_filter_tunnel(const struct rte_flow_attr *attr,
 	    item->type != RTE_FLOW_ITEM_TYPE_IPV6 &&
 	    item->type != RTE_FLOW_ITEM_TYPE_UDP &&
 	    item->type != RTE_FLOW_ITEM_TYPE_VXLAN &&
-	    item->type != RTE_FLOW_ITEM_TYPE_NVGRE) {
+	    item->type != RTE_FLOW_ITEM_TYPE_NVGRE &&
+	    item->type != RTE_FLOW_ITEM_TYPE_GRE &&
+	    item->type != RTE_FLOW_ITEM_TYPE_GENEVE) {
 		memset(rule, 0, sizeof(struct txgbe_fdir_rule));
 		rte_flow_error_set(error, EINVAL,
 			RTE_FLOW_ERROR_TYPE_ITEM,
@@ -2256,7 +2276,8 @@ txgbe_parse_fdir_filter_tunnel(const struct rte_flow_attr *attr,
 		return -rte_errno;
 	}
 
-	rule->mode = RTE_FDIR_MODE_PERFECT_TUNNEL;
+	rule->mode = RTE_FDIR_MODE_PERFECT;
+	ptid = TXGBE_PTID_PKT_TUN;
 
 	/* Skip MAC. */
 	if (item->type == RTE_FLOW_ITEM_TYPE_ETH) {
@@ -2278,6 +2299,8 @@ txgbe_parse_fdir_filter_tunnel(const struct rte_flow_attr *attr,
 
 		/* Check if the next not void item is IPv4 or IPv6. */
 		item = next_no_void_pattern(pattern, item);
+		if (item->type == RTE_FLOW_ITEM_TYPE_VLAN)
+			item = next_no_fuzzy_pattern(pattern, item);
 		if (item->type != RTE_FLOW_ITEM_TYPE_IPV4 &&
 		    item->type != RTE_FLOW_ITEM_TYPE_IPV6) {
 			memset(rule, 0, sizeof(struct txgbe_fdir_rule));
@@ -2291,6 +2314,8 @@ txgbe_parse_fdir_filter_tunnel(const struct rte_flow_attr *attr,
 	/* Skip IP. */
 	if (item->type == RTE_FLOW_ITEM_TYPE_IPV4 ||
 	    item->type == RTE_FLOW_ITEM_TYPE_IPV6) {
+		rule->mask.pkt_type_mask &= ~TXGBE_ATR_TYPE_MASK_TUN_OUTIP;
+
 		/* Only used to describe the protocol stack. */
 		if (item->spec || item->mask) {
 			memset(rule, 0, sizeof(struct txgbe_fdir_rule));
@@ -2307,10 +2332,17 @@ txgbe_parse_fdir_filter_tunnel(const struct rte_flow_attr *attr,
 			return -rte_errno;
 		}
 
-		/* Check if the next not void item is UDP or NVGRE. */
+		if (item->type == RTE_FLOW_ITEM_TYPE_IPV6)
+			ptid |= TXGBE_PTID_TUN_IPV6;
+
 		item = next_no_void_pattern(pattern, item);
-		if (item->type != RTE_FLOW_ITEM_TYPE_UDP &&
-		    item->type != RTE_FLOW_ITEM_TYPE_NVGRE) {
+		if (item->type != RTE_FLOW_ITEM_TYPE_IPV4 &&
+		    item->type != RTE_FLOW_ITEM_TYPE_IPV6 &&
+		    item->type != RTE_FLOW_ITEM_TYPE_UDP &&
+		    item->type != RTE_FLOW_ITEM_TYPE_VXLAN &&
+		    item->type != RTE_FLOW_ITEM_TYPE_GRE &&
+		    item->type != RTE_FLOW_ITEM_TYPE_NVGRE &&
+		    item->type != RTE_FLOW_ITEM_TYPE_GENEVE) {
 			memset(rule, 0, sizeof(struct txgbe_fdir_rule));
 			rte_flow_error_set(error, EINVAL,
 				RTE_FLOW_ERROR_TYPE_ITEM,
@@ -2321,6 +2353,31 @@ txgbe_parse_fdir_filter_tunnel(const struct rte_flow_attr *attr,
 
 	/* Skip UDP. */
 	if (item->type == RTE_FLOW_ITEM_TYPE_UDP) {
+		/*Not supported last point for range*/
+		if (item->last) {
+			rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
+				item, "Not supported last point for range");
+			return -rte_errno;
+		}
+
+		/* Check if the next not void item is VxLAN or GENEVE. */
+		item = next_no_void_pattern(pattern, item);
+		if (item->type != RTE_FLOW_ITEM_TYPE_VXLAN &&
+		    item->type != RTE_FLOW_ITEM_TYPE_GENEVE) {
+			memset(rule, 0, sizeof(struct txgbe_fdir_rule));
+			rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM,
+				item, "Not supported by fdir filter");
+			return -rte_errno;
+		}
+	}
+
+	/* Skip tunnel. */
+	if (item->type == RTE_FLOW_ITEM_TYPE_VXLAN ||
+	    item->type == RTE_FLOW_ITEM_TYPE_GRE ||
+	    item->type == RTE_FLOW_ITEM_TYPE_NVGRE ||
+	    item->type == RTE_FLOW_ITEM_TYPE_GENEVE) {
 		/* Only used to describe the protocol stack. */
 		if (item->spec || item->mask) {
 			memset(rule, 0, sizeof(struct txgbe_fdir_rule));
@@ -2337,9 +2394,15 @@ txgbe_parse_fdir_filter_tunnel(const struct rte_flow_attr *attr,
 			return -rte_errno;
 		}
 
-		/* Check if the next not void item is VxLAN. */
+		if (item->type == RTE_FLOW_ITEM_TYPE_GRE)
+			ptid |= TXGBE_PTID_TUN_EIG;
+		else
+			ptid |= TXGBE_PTID_TUN_EIGM;
+
 		item = next_no_void_pattern(pattern, item);
-		if (item->type != RTE_FLOW_ITEM_TYPE_VXLAN) {
+		if (item->type != RTE_FLOW_ITEM_TYPE_ETH &&
+		    item->type != RTE_FLOW_ITEM_TYPE_IPV4 &&
+		    item->type != RTE_FLOW_ITEM_TYPE_IPV6) {
 			memset(rule, 0, sizeof(struct txgbe_fdir_rule));
 			rte_flow_error_set(error, EINVAL,
 				RTE_FLOW_ERROR_TYPE_ITEM,
@@ -2348,100 +2411,421 @@ txgbe_parse_fdir_filter_tunnel(const struct rte_flow_attr *attr,
 		}
 	}
 
-	/* check if the next not void item is MAC */
-	item = next_no_void_pattern(pattern, item);
-	if (item->type != RTE_FLOW_ITEM_TYPE_ETH) {
-		memset(rule, 0, sizeof(struct txgbe_fdir_rule));
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ITEM,
-			item, "Not supported by fdir filter");
-		return -rte_errno;
-	}
+	/* Get the MAC info. */
+	if (item->type == RTE_FLOW_ITEM_TYPE_ETH) {
+		/**
+		 * Only support vlan and dst MAC address,
+		 * others should be masked.
+		 */
+		if (item->spec && !item->mask) {
+			memset(rule, 0, sizeof(struct txgbe_fdir_rule));
+			rte_flow_error_set(error, EINVAL,
+					   RTE_FLOW_ERROR_TYPE_ITEM,
+					   item, "Not supported by fdir filter");
+			return -rte_errno;
+		}
 
-	/**
-	 * Only support vlan and dst MAC address,
-	 * others should be masked.
-	 */
+		if (item->mask) {
+			rule->b_mask = TRUE;
+			eth_mask = item->mask;
 
-	if (!item->mask) {
-		memset(rule, 0, sizeof(struct txgbe_fdir_rule));
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ITEM,
-			item, "Not supported by fdir filter");
-		return -rte_errno;
+			/* Ether type should be masked. */
+			if (eth_mask->hdr.ether_type) {
+				memset(rule, 0, sizeof(struct txgbe_fdir_rule));
+				rte_flow_error_set(error, EINVAL,
+						   RTE_FLOW_ERROR_TYPE_ITEM,
+						   item, "Not supported by fdir filter");
+				return -rte_errno;
+			}
+
+			/**
+			 * src MAC address must be masked,
+			 * and don't support dst MAC address mask.
+			 */
+			for (j = 0; j < RTE_ETHER_ADDR_LEN; j++) {
+				if (eth_mask->hdr.src_addr.addr_bytes[j] ||
+				    eth_mask->hdr.dst_addr.addr_bytes[j] != 0xFF) {
+					memset(rule, 0,
+					       sizeof(struct txgbe_fdir_rule));
+					rte_flow_error_set(error, EINVAL,
+							   RTE_FLOW_ERROR_TYPE_ITEM,
+							   item, "Not supported by fdir filter");
+					return -rte_errno;
+				}
+			}
+
+			/* When no VLAN, considered as full mask. */
+			rule->mask.vlan_tci_mask = rte_cpu_to_be_16(0xEFFF);
+		}
+
+		item = next_no_fuzzy_pattern(pattern, item);
+		if (rule->mask.vlan_tci_mask) {
+			if (item->type != RTE_FLOW_ITEM_TYPE_VLAN) {
+				memset(rule, 0, sizeof(struct txgbe_fdir_rule));
+				rte_flow_error_set(error, EINVAL,
+						   RTE_FLOW_ERROR_TYPE_ITEM,
+						   item, "Not supported by fdir filter");
+				return -rte_errno;
+			}
+		} else {
+			if (item->type != RTE_FLOW_ITEM_TYPE_IPV4 &&
+			    item->type != RTE_FLOW_ITEM_TYPE_IPV6 &&
+			    item->type != RTE_FLOW_ITEM_TYPE_VLAN) {
+				memset(rule, 0, sizeof(struct txgbe_fdir_rule));
+				rte_flow_error_set(error, EINVAL,
+						   RTE_FLOW_ERROR_TYPE_ITEM,
+						   item, "Not supported by fdir filter");
+				return -rte_errno;
+			}
+		}
+		if (item->type == RTE_FLOW_ITEM_TYPE_VLAN) {
+			ptid |= TXGBE_PTID_TUN_EIGMV;
+			item = next_no_fuzzy_pattern(pattern, item);
+		}
 	}
-	/*Not supported last point for range*/
-	if (item->last) {
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-			item, "Not supported last point for range");
-		return -rte_errno;
+
+	/* Get the IPV4 info. */
+	if (item->type == RTE_FLOW_ITEM_TYPE_IPV4) {
+		/**
+		 * Set the flow type even if there's no content
+		 * as we must have a flow type.
+		 */
+		rule->input.flow_type = TXGBE_ATR_FLOW_TYPE_IPV4;
+		rule->mask.pkt_type_mask &= ~TXGBE_ATR_TYPE_MASK_L3P;
+
+		/*Not supported last point for range*/
+		if (item->last) {
+			rte_flow_error_set(error, EINVAL,
+					   RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
+					   item, "Not supported last point for range");
+			return -rte_errno;
+		}
+		/**
+		 * Only care about src & dst addresses,
+		 * others should be masked.
+		 */
+		if (item->spec && !item->mask) {
+			memset(rule, 0, sizeof(struct txgbe_fdir_rule));
+			rte_flow_error_set(error, EINVAL,
+					   RTE_FLOW_ERROR_TYPE_ITEM,
+					   item, "Not supported by fdir filter");
+			return -rte_errno;
+		}
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
+						   RTE_FLOW_ERROR_TYPE_ITEM,
+						   item, "Not supported by fdir filter");
+				return -rte_errno;
+			}
+			rule->mask.dst_ipv4_mask = ipv4_mask->hdr.dst_addr;
+			rule->mask.src_ipv4_mask = ipv4_mask->hdr.src_addr;
+		}
+		if (item->spec) {
+			rule->b_spec = TRUE;
+			ipv4_spec = item->spec;
+			rule->input.dst_ip[0] =
+				ipv4_spec->hdr.dst_addr;
+			rule->input.src_ip[0] =
+				ipv4_spec->hdr.src_addr;
+		}
+
+		/**
+		 * Check if the next not void item is
+		 * TCP or UDP or SCTP or END.
+		 */
+		item = next_no_fuzzy_pattern(pattern, item);
+		if (item->type != RTE_FLOW_ITEM_TYPE_TCP &&
+		    item->type != RTE_FLOW_ITEM_TYPE_UDP &&
+		    item->type != RTE_FLOW_ITEM_TYPE_SCTP &&
+		    item->type != RTE_FLOW_ITEM_TYPE_END) {
+			memset(rule, 0, sizeof(struct txgbe_fdir_rule));
+			rte_flow_error_set(error, EINVAL,
+					   RTE_FLOW_ERROR_TYPE_ITEM,
+					   item, "Not supported by fdir filter");
+			return -rte_errno;
+		}
 	}
-	rule->b_mask = TRUE;
-	eth_mask = item->mask;
 
-	/* Ether type should be masked. */
-	if (eth_mask->hdr.ether_type) {
-		memset(rule, 0, sizeof(struct txgbe_fdir_rule));
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ITEM,
-			item, "Not supported by fdir filter");
-		return -rte_errno;
+	/* Get the IPV6 info. */
+	if (item->type == RTE_FLOW_ITEM_TYPE_IPV6) {
+		/**
+		 * Set the flow type even if there's no content
+		 * as we must have a flow type.
+		 */
+		rule->input.flow_type = TXGBE_ATR_FLOW_TYPE_IPV6;
+		rule->mask.pkt_type_mask &= ~TXGBE_ATR_TYPE_MASK_L3P;
+
+		if (item->last) {
+			memset(rule, 0, sizeof(struct txgbe_fdir_rule));
+			rte_flow_error_set(error, EINVAL,
+					   RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
+					   item, "Not supported last point for range");
+			return -rte_errno;
+		}
+		if (item->spec && !item->mask) {
+			memset(rule, 0, sizeof(struct txgbe_fdir_rule));
+			rte_flow_error_set(error, EINVAL,
+					   RTE_FLOW_ERROR_TYPE_ITEM,
+					   item, "Not supported by fdir filter");
+			return -rte_errno;
+		}
+		if (item->mask) {
+			rule->b_mask = TRUE;
+			ipv6_mask = item->mask;
+			if (ipv6_mask->hdr.vtc_flow ||
+			    ipv6_mask->hdr.payload_len ||
+			    ipv6_mask->hdr.proto ||
+			    ipv6_mask->hdr.hop_limits) {
+				memset(rule, 0, sizeof(struct txgbe_fdir_rule));
+				rte_flow_error_set(error, EINVAL,
+						   RTE_FLOW_ERROR_TYPE_ITEM,
+						   item, "Not supported by fdir filter");
+				return -rte_errno;
+			}
+
+			/* check src addr mask */
+			for (j = 0; j < 16; j++) {
+				if (ipv6_mask->hdr.src_addr.a[j] == UINT8_MAX) {
+					rule->mask.src_ipv6_mask |= 1 << j;
+				} else if (ipv6_mask->hdr.src_addr.a[j] != 0) {
+					memset(rule, 0, sizeof(struct txgbe_fdir_rule));
+					rte_flow_error_set(error, EINVAL,
+							   RTE_FLOW_ERROR_TYPE_ITEM,
+							   item, "Not supported by fdir filter");
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
+							   RTE_FLOW_ERROR_TYPE_ITEM,
+							   item, "Not supported by fdir filter");
+					return -rte_errno;
+				}
+			}
+		}
+		if (item->spec) {
+			rule->b_spec = TRUE;
+			ipv6_spec = item->spec;
+			rte_memcpy(rule->input.src_ip,
+				   &ipv6_spec->hdr.src_addr, 16);
+			rte_memcpy(rule->input.dst_ip,
+				   &ipv6_spec->hdr.dst_addr, 16);
+		}
+
+		/**
+		 * Check if the next not void item is
+		 * TCP or UDP or SCTP or END.
+		 */
+		item = next_no_fuzzy_pattern(pattern, item);
+		if (item->type != RTE_FLOW_ITEM_TYPE_TCP &&
+		    item->type != RTE_FLOW_ITEM_TYPE_UDP &&
+		    item->type != RTE_FLOW_ITEM_TYPE_SCTP &&
+		    item->type != RTE_FLOW_ITEM_TYPE_END) {
+			memset(rule, 0, sizeof(struct txgbe_fdir_rule));
+			rte_flow_error_set(error, EINVAL,
+					   RTE_FLOW_ERROR_TYPE_ITEM,
+					   item, "Not supported by fdir filter");
+			return -rte_errno;
+		}
 	}
 
-	/* src MAC address should be masked. */
-	for (j = 0; j < RTE_ETHER_ADDR_LEN; j++) {
-		if (eth_mask->hdr.src_addr.addr_bytes[j]) {
-			memset(rule, 0,
-			       sizeof(struct txgbe_fdir_rule));
+	/* Get the TCP info. */
+	if (item->type == RTE_FLOW_ITEM_TYPE_TCP) {
+		/**
+		 * Set the flow type even if there's no content
+		 * as we must have a flow type.
+		 */
+		rule->input.flow_type |= TXGBE_ATR_L4TYPE_TCP;
+		rule->mask.pkt_type_mask &= ~TXGBE_ATR_TYPE_MASK_L4P;
+
+		/*Not supported last point for range*/
+		if (item->last) {
 			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
+					   RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
+					   item, "Not supported last point for range");
+			return -rte_errno;
+		}
+		/**
+		 * Only care about src & dst ports,
+		 * others should be masked.
+		 */
+		if (!item->mask) {
+			memset(rule, 0, sizeof(struct txgbe_fdir_rule));
+			rte_flow_error_set(error, EINVAL,
+					   RTE_FLOW_ERROR_TYPE_ITEM,
+					   item, "Not supported by fdir filter");
+			return -rte_errno;
+		}
+		rule->b_mask = TRUE;
+		tcp_mask = item->mask;
+		if (tcp_mask->hdr.sent_seq ||
+		    tcp_mask->hdr.recv_ack ||
+		    tcp_mask->hdr.data_off ||
+		    tcp_mask->hdr.tcp_flags ||
+		    tcp_mask->hdr.rx_win ||
+		    tcp_mask->hdr.cksum ||
+		    tcp_mask->hdr.tcp_urp) {
+			memset(rule, 0, sizeof(struct txgbe_fdir_rule));
+			rte_flow_error_set(error, EINVAL,
+					   RTE_FLOW_ERROR_TYPE_ITEM,
+					   item, "Not supported by fdir filter");
 			return -rte_errno;
 		}
+		rule->mask.src_port_mask = tcp_mask->hdr.src_port;
+		rule->mask.dst_port_mask = tcp_mask->hdr.dst_port;
+
+		if (item->spec) {
+			rule->b_spec = TRUE;
+			tcp_spec = item->spec;
+			rule->input.src_port =
+				tcp_spec->hdr.src_port;
+			rule->input.dst_port =
+				tcp_spec->hdr.dst_port;
+		}
 	}
-	rule->mask.mac_addr_byte_mask = 0;
-	for (j = 0; j < ETH_ADDR_LEN; j++) {
-		/* It's a per byte mask. */
-		if (eth_mask->hdr.dst_addr.addr_bytes[j] == 0xFF) {
-			rule->mask.mac_addr_byte_mask |= 0x1 << j;
-		} else if (eth_mask->hdr.dst_addr.addr_bytes[j]) {
+
+	/* Get the UDP info */
+	if (item->type == RTE_FLOW_ITEM_TYPE_UDP) {
+		/**
+		 * Set the flow type even if there's no content
+		 * as we must have a flow type.
+		 */
+		rule->input.flow_type |= TXGBE_ATR_L4TYPE_UDP;
+		rule->mask.pkt_type_mask &= ~TXGBE_ATR_TYPE_MASK_L4P;
+		/*Not supported last point for range*/
+		if (item->last) {
+			rte_flow_error_set(error, EINVAL,
+					   RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
+					   item, "Not supported last point for range");
+			return -rte_errno;
+		}
+		/**
+		 * Only care about src & dst ports,
+		 * others should be masked.
+		 */
+		if (!item->mask) {
 			memset(rule, 0, sizeof(struct txgbe_fdir_rule));
 			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
+					   RTE_FLOW_ERROR_TYPE_ITEM,
+					   item, "Not supported by fdir filter");
 			return -rte_errno;
 		}
+		rule->b_mask = TRUE;
+		udp_mask = item->mask;
+		if (udp_mask->hdr.dgram_len ||
+		    udp_mask->hdr.dgram_cksum) {
+			memset(rule, 0, sizeof(struct txgbe_fdir_rule));
+			rte_flow_error_set(error, EINVAL,
+					   RTE_FLOW_ERROR_TYPE_ITEM,
+					   item, "Not supported by fdir filter");
+			return -rte_errno;
+		}
+		rule->mask.src_port_mask = udp_mask->hdr.src_port;
+		rule->mask.dst_port_mask = udp_mask->hdr.dst_port;
+
+		if (item->spec) {
+			rule->b_spec = TRUE;
+			udp_spec = item->spec;
+			rule->input.src_port =
+				udp_spec->hdr.src_port;
+			rule->input.dst_port =
+				udp_spec->hdr.dst_port;
+		}
 	}
 
-	/* When no vlan, considered as full mask. */
-	rule->mask.vlan_tci_mask = rte_cpu_to_be_16(0xEFFF);
+	/* Get the SCTP info */
+	if (item->type == RTE_FLOW_ITEM_TYPE_SCTP) {
+		/**
+		 * Set the flow type even if there's no content
+		 * as we must have a flow type.
+		 */
+		rule->input.flow_type |= TXGBE_ATR_L4TYPE_SCTP;
+		rule->mask.pkt_type_mask &= ~TXGBE_ATR_TYPE_MASK_L4P;
 
-	/**
-	 * Check if the next not void item is vlan or ipv4.
-	 * IPv6 is not supported.
-	 */
-	item = next_no_void_pattern(pattern, item);
-	if (item->type != RTE_FLOW_ITEM_TYPE_VLAN &&
-		item->type != RTE_FLOW_ITEM_TYPE_IPV4) {
-		memset(rule, 0, sizeof(struct txgbe_fdir_rule));
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ITEM,
-			item, "Not supported by fdir filter");
-		return -rte_errno;
+		/*Not supported last point for range*/
+		if (item->last) {
+			rte_flow_error_set(error, EINVAL,
+					   RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
+					   item, "Not supported last point for range");
+			return -rte_errno;
+		}
+
+		/**
+		 * Only care about src & dst ports,
+		 * others should be masked.
+		 */
+		if (!item->mask) {
+			memset(rule, 0, sizeof(struct txgbe_fdir_rule));
+			rte_flow_error_set(error, EINVAL,
+					   RTE_FLOW_ERROR_TYPE_ITEM,
+					   item, "Not supported by fdir filter");
+			return -rte_errno;
+		}
+		rule->b_mask = TRUE;
+		sctp_mask = item->mask;
+		if (sctp_mask->hdr.tag || sctp_mask->hdr.cksum) {
+			memset(rule, 0, sizeof(struct txgbe_fdir_rule));
+			rte_flow_error_set(error, EINVAL,
+					   RTE_FLOW_ERROR_TYPE_ITEM,
+					   item, "Not supported by fdir filter");
+			return -rte_errno;
+		}
+		rule->mask.src_port_mask = sctp_mask->hdr.src_port;
+		rule->mask.dst_port_mask = sctp_mask->hdr.dst_port;
+
+		if (item->spec) {
+			rule->b_spec = TRUE;
+			sctp_spec = item->spec;
+			rule->input.src_port =
+				sctp_spec->hdr.src_port;
+			rule->input.dst_port =
+				sctp_spec->hdr.dst_port;
+		}
+		/* others even sctp port is not supported */
+		sctp_mask = item->mask;
+		if (sctp_mask &&
+		    (sctp_mask->hdr.src_port ||
+		     sctp_mask->hdr.dst_port ||
+		     sctp_mask->hdr.tag ||
+		     sctp_mask->hdr.cksum)) {
+			memset(rule, 0, sizeof(struct txgbe_fdir_rule));
+			rte_flow_error_set(error, EINVAL,
+					   RTE_FLOW_ERROR_TYPE_ITEM,
+					   item, "Not supported by fdir filter");
+			return -rte_errno;
+		}
 	}
-	/*Not supported last point for range*/
-	if (item->last) {
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-			item, "Not supported last point for range");
-		return -rte_errno;
+
+	if (item->type != RTE_FLOW_ITEM_TYPE_END) {
+		/* check if the next not void item is END */
+		item = next_no_fuzzy_pattern(pattern, item);
+		if (item->type != RTE_FLOW_ITEM_TYPE_END) {
+			memset(rule, 0, sizeof(struct txgbe_fdir_rule));
+			rte_flow_error_set(error, EINVAL,
+					   RTE_FLOW_ERROR_TYPE_ITEM,
+					   item, "Not supported by fdir filter");
+			return -rte_errno;
+		}
 	}
 
-	/**
-	 * If the tags is 0, it means don't care about the VLAN.
-	 * Do nothing.
-	 */
+	txgbe_fdir_parse_flow_type(&rule->input, ptid, true);
 
 	return txgbe_parse_fdir_act_attr(attr, actions, rule, error);
 }
@@ -2837,11 +3221,19 @@ txgbe_flow_create(struct rte_eth_dev *dev,
 					sizeof(struct txgbe_hw_fdir_mask));
 				fdir_info->flex_bytes_offset =
 					fdir_rule.flex_bytes_offset;
+				fdir_info->flex_relative = fdir_rule.flex_relative;
+
+				if (fdir_rule.mask.flex_bytes_mask) {
+					uint16_t flex_base;
 
-				if (fdir_rule.mask.flex_bytes_mask)
+					flex_base = txgbe_fdir_get_flex_base(&fdir_rule);
 					txgbe_fdir_set_flexbytes_offset(dev,
-						fdir_rule.flex_bytes_offset);
+									fdir_rule.flex_bytes_offset,
+									flex_base);
+				}
 
+				fdir_info->mask.pkt_type_mask =
+					fdir_rule.mask.pkt_type_mask;
 				ret = txgbe_fdir_set_input_mask(dev);
 				if (ret)
 					goto out;
@@ -2862,7 +3254,9 @@ txgbe_flow_create(struct rte_eth_dev *dev,
 				}
 
 				if (fdir_info->flex_bytes_offset !=
-						fdir_rule.flex_bytes_offset)
+				    fdir_rule.flex_bytes_offset ||
+				    fdir_info->flex_relative !=
+				    fdir_rule.flex_relative)
 					goto out;
 			}
 		}
@@ -3090,8 +3484,13 @@ txgbe_flow_destroy(struct rte_eth_dev *dev,
 			TAILQ_REMOVE(&filter_fdir_list,
 				fdir_rule_ptr, entries);
 			rte_free(fdir_rule_ptr);
-			if (TAILQ_EMPTY(&filter_fdir_list))
+			if (TAILQ_EMPTY(&filter_fdir_list)) {
+				memset(&fdir_info->mask, 0,
+					sizeof(struct txgbe_hw_fdir_mask));
 				fdir_info->mask_added = false;
+				fdir_info->flex_relative = false;
+				fdir_info->flex_bytes_offset = 0;
+			}
 		}
 		break;
 	case RTE_ETH_FILTER_L2_TUNNEL:
-- 
2.48.1

