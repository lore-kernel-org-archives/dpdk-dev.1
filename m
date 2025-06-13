Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0697C71135
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Jun 2025 08:42:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E3D0C42EE2;
	Fri, 13 Jun 2025 10:42:33 +0200 (CEST)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
 by mails.dpdk.org (Postfix) with ESMTP id 531FF42ED3;
 Fri, 13 Jun 2025 10:42:30 +0200 (CEST)
X-QQ-mid: esmtpsz18t1749804147t68efe218
X-QQ-Originating-IP: 1Rnaz1Ydzr0sxWGzs8oiMmPfNE6lQkXfM1/4FqOH4o0=
Received: from lap-jiawenwu.trustnetic.com ( [36.20.60.58])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 13 Jun 2025 16:42:26 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3195868114446083931
EX-QQ-RecipientCnt: 4
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: dev@dpdk.org
Cc: zaiyuwang@trustnetic.com, Jiawen Wu <jiawenwu@trustnetic.com>,
 stable@dpdk.org
Subject: [PATCH v3 07/17] net/txgbe: fix to create FDIR filters for tunnel
 packets
Date: Fri, 13 Jun 2025 16:41:49 +0800
Message-Id: <20250613084159.22184-8-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250613084159.22184-1-jiawenwu@trustnetic.com>
References: <00DEAE896AFE0D2D+20250606080117.183198-1-jiawenwu@trustnetic.com>
 <20250613084159.22184-1-jiawenwu@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MB5+LsFw85NoUKDgiInt+d09BOb4N53zK9GlRTsGXdNathItzzN8tmoU
 lO1zdhUc2QvOy43aAKkSyLp2PZFfhNd6oHYuPQ+BwK3GiwFDftk9dJ4VXzfw1Mkyk9WQQXD
 1M+Mk6JOMbmH0F9i6WZHEWRf77BbOMzlC+19iqLvRP55EaExdgQo04wAzJyVdSNfFgAPego
 zqETgJDjm4uYIWwbz7HgHV4TDk5Cb8FHvqm1qXty96DYQQ5vtoBaRfBARRrkhch4ekQNDrO
 ijbxFSrB+utygr0FOxO1ANeDq7Mf/B0UsAIjpTJm6OouEP1ptdvQxNUv0xIvu3KmrmTdiZR
 NfPjY/WXL1EaONRDGJNZqdOKCnkjb6Cw8riObt1ymuAGagSRhzQ7JFRRVaL3ufEhgN27qaV
 yhiVfuSdZzpGCXBOCFcM4N/P3ZstChuySEBuggJ/5Q4rFR5QNaaHxLDdOeQ2copUGVszWUi
 CGrSWX2vAKQmY2WX2sLMRKeRxjlikC6+ySOZHyaaYe7IeUBY8vFq/RfcpuBUZ/qyDgDlLoV
 t1tuMsGR3D08yGzEkJRUvzkqH3OgNzpbwIg4TX3M6EJ6o0uVMZ/0OJVI0ffXKmhkSPqyyUV
 q7uomIhbT5nKkdm3MTA7ZjCRTNr7AqtNJsLvyO8tAuNyfqZyxig+CkawbBNjkZf22l/jD3H
 FD1Cd/R/TYnav5Y3YYW45jlu82O+0YEg3OiNNugYO3iAYEhYAVeYARP25xuD1EJCdg59k+b
 7zFNOTwi7HzcYyLquD/2b9nQ2ED08u0/4CUF7r7x/aHIncZ4CTXDqyk0vxVy+q/2LNSuiqn
 RkAHg9ehIBWp8VAxvsnMgFl/vs560kofU97A+frDua8NzfPTUcUwGwjGWlaRLdyQkETZdfc
 68MmAPSCnxGYkkP2fc7yl2QcV12vCDxrP/9ZafDCljrigilKcL0ZarNq4yLdSjAnPhCVxNE
 vx4m98+YOskuVpVdbYPKSTtfGUVmTn8EiOsCcuQjeCuS1EU/gc/NaHcQhZDph2b2zhXMcsn
 fp5702Txam+SJ2ioHe
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
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

Fix to create FDIR rules for VXLAN/GRE/NVGRE/GENEVE packets, they will
match the rules in the inner layers.

Fixes: b973ee26747a ("net/txgbe: parse flow director filter")
Cc: stable@dpdk.org

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 doc/guides/nics/features/txgbe.ini |   2 +
 drivers/net/txgbe/txgbe_ethdev.h   |   1 -
 drivers/net/txgbe/txgbe_flow.c     | 585 +++++++++++++++++++++++------
 3 files changed, 478 insertions(+), 110 deletions(-)

diff --git a/doc/guides/nics/features/txgbe.ini b/doc/guides/nics/features/txgbe.ini
index be0af3dfad..20f7cb8db8 100644
--- a/doc/guides/nics/features/txgbe.ini
+++ b/doc/guides/nics/features/txgbe.ini
@@ -67,6 +67,8 @@ tcp                  = Y
 udp                  = Y
 vlan                 = P
 vxlan                = Y
+geneve               = Y
+gre                  = Y
 
 [rte_flow actions]
 drop                 = Y
diff --git a/drivers/net/txgbe/txgbe_ethdev.h b/drivers/net/txgbe/txgbe_ethdev.h
index 01e8a9fc05..c2d0950d2c 100644
--- a/drivers/net/txgbe/txgbe_ethdev.h
+++ b/drivers/net/txgbe/txgbe_ethdev.h
@@ -90,7 +90,6 @@ struct txgbe_hw_fdir_mask {
 	uint16_t src_port_mask;
 	uint16_t dst_port_mask;
 	uint16_t flex_bytes_mask;
-	uint8_t  mac_addr_byte_mask;
 	uint8_t  pkt_type_mask; /* reversed mask for hw */
 };
 
diff --git a/drivers/net/txgbe/txgbe_flow.c b/drivers/net/txgbe/txgbe_flow.c
index 145ee8a452..99a76daca0 100644
--- a/drivers/net/txgbe/txgbe_flow.c
+++ b/drivers/net/txgbe/txgbe_flow.c
@@ -2179,41 +2179,29 @@ txgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev __rte_unused,
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
@@ -2224,6 +2212,17 @@ txgbe_parse_fdir_filter_tunnel(const struct rte_flow_attr *attr,
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
@@ -2252,12 +2251,14 @@ txgbe_parse_fdir_filter_tunnel(const struct rte_flow_attr *attr,
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
@@ -2265,7 +2266,9 @@ txgbe_parse_fdir_filter_tunnel(const struct rte_flow_attr *attr,
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
@@ -2273,7 +2276,8 @@ txgbe_parse_fdir_filter_tunnel(const struct rte_flow_attr *attr,
 		return -rte_errno;
 	}
 
-	rule->mode = RTE_FDIR_MODE_PERFECT_TUNNEL;
+	rule->mode = RTE_FDIR_MODE_PERFECT;
+	ptid = TXGBE_PTID_PKT_TUN;
 
 	/* Skip MAC. */
 	if (item->type == RTE_FLOW_ITEM_TYPE_ETH) {
@@ -2295,6 +2299,8 @@ txgbe_parse_fdir_filter_tunnel(const struct rte_flow_attr *attr,
 
 		/* Check if the next not void item is IPv4 or IPv6. */
 		item = next_no_void_pattern(pattern, item);
+		if (item->type == RTE_FLOW_ITEM_TYPE_VLAN)
+			item = next_no_fuzzy_pattern(pattern, item);
 		if (item->type != RTE_FLOW_ITEM_TYPE_IPV4 &&
 		    item->type != RTE_FLOW_ITEM_TYPE_IPV6) {
 			memset(rule, 0, sizeof(struct txgbe_fdir_rule));
@@ -2308,6 +2314,8 @@ txgbe_parse_fdir_filter_tunnel(const struct rte_flow_attr *attr,
 	/* Skip IP. */
 	if (item->type == RTE_FLOW_ITEM_TYPE_IPV4 ||
 	    item->type == RTE_FLOW_ITEM_TYPE_IPV6) {
+		rule->mask.pkt_type_mask &= ~TXGBE_ATR_TYPE_MASK_TUN_OUTIP;
+
 		/* Only used to describe the protocol stack. */
 		if (item->spec || item->mask) {
 			memset(rule, 0, sizeof(struct txgbe_fdir_rule));
@@ -2324,10 +2332,17 @@ txgbe_parse_fdir_filter_tunnel(const struct rte_flow_attr *attr,
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
@@ -2338,6 +2353,31 @@ txgbe_parse_fdir_filter_tunnel(const struct rte_flow_attr *attr,
 
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
@@ -2354,9 +2394,15 @@ txgbe_parse_fdir_filter_tunnel(const struct rte_flow_attr *attr,
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
@@ -2365,100 +2411,421 @@ txgbe_parse_fdir_filter_tunnel(const struct rte_flow_attr *attr,
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
+			return -rte_errno;
+		}
+		rule->b_mask = TRUE;
+		udp_mask = item->mask;
+		if (udp_mask->hdr.dgram_len ||
+		    udp_mask->hdr.dgram_cksum) {
+			memset(rule, 0, sizeof(struct txgbe_fdir_rule));
+			rte_flow_error_set(error, EINVAL,
+					   RTE_FLOW_ERROR_TYPE_ITEM,
+					   item, "Not supported by fdir filter");
 			return -rte_errno;
 		}
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
-- 
2.48.1

