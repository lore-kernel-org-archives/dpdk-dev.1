Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36547E81BA6
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 11:58:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A9BF40663;
	Mon,  9 Feb 2026 12:58:31 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 9D10740648
 for <dev@dpdk.org>; Mon,  9 Feb 2026 12:58:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770638306; x=1802174306;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6A+JqoeYJOFwfW7cLefrLc64AijPyfEa7mZkqN8Kp94=;
 b=GVPK1NEy0z8R0JFzDAbBLlrOyzdoaMX45XS4xBAl3rjOfcuCN3un8C2E
 6I+aDa/+rK2jfZ7hnZ8Pe/rA8D/zpXBA9TDC8pOuU1Vj98hKQThz7xl8K
 l4yKQwGCzgrx602ANDJd/s1A1JRtXk1fbr9EYl4uiUH6jBYpSsAjlDRax
 SrvQVzTFoba+lnzrnGMT9eVGlEvaqdOWBioHhnygJg95JHiOO2WZGXHTH
 6wsYyxeXdmg/YUPJv8LB/ebMJWYRnGfRWkQH12ojhZMbGr4Mmc4IDcj4c
 rZGP5BiphL7WAIubqWozfW9xl116G8/aVQwvHs9gxFQEK7zK8J896e0PP Q==;
X-CSE-ConnectionGUID: FRmTDD7ZQjGSV5LO9uVFuw==
X-CSE-MsgGUID: O0dCPxokTDmZDpOZ1hu6ZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="71640965"
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="71640965"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 03:58:25 -0800
X-CSE-ConnectionGUID: sJkx6Ak1ShyVn4yYTn2zwQ==
X-CSE-MsgGUID: qvK6IUsMSyymNIrHQ/SoKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="211627094"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by orviesa007.jf.intel.com with ESMTP; 09 Feb 2026 03:58:23 -0800
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Cc: Song Jiale <songx.jiale@intel.com>
Subject: [PATCH v2 3/7] net/ice: add L2TPv2 protocol and field definitions
Date: Mon,  9 Feb 2026 17:26:53 +0530
Message-Id: <20260209115657.636525-4-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260209115657.636525-1-shaiq.wani@intel.com>
References: <20260202094244.447966-1-shaiq.wani@intel.com>
 <20260209115657.636525-1-shaiq.wani@intel.com>
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

Add L2TPv2 protocol identifier (ICE_PROT_L2TPV2OIP) and session ID
field definition (ICE_L2TPV2OIP_SESSION_ID) to the generic flow header.

Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
Tested-by: Song Jiale <songx.jiale@intel.com>
---
 drivers/net/intel/ice/ice_generic_flow.h | 129 ++++++++++++++++-------
 1 file changed, 88 insertions(+), 41 deletions(-)

diff --git a/drivers/net/intel/ice/ice_generic_flow.h b/drivers/net/intel/ice/ice_generic_flow.h
index 54bbb47398..deaf7b66e5 100644
--- a/drivers/net/intel/ice/ice_generic_flow.h
+++ b/drivers/net/intel/ice/ice_generic_flow.h
@@ -9,15 +9,15 @@
 
 /* protocol */
 
-#define ICE_PROT_MAC			BIT_ULL(1)
-#define ICE_PROT_VLAN			BIT_ULL(2)
-#define ICE_PROT_IPV4			BIT_ULL(3)
-#define ICE_PROT_IPV6			BIT_ULL(4)
-#define ICE_PROT_TCP			BIT_ULL(5)
-#define ICE_PROT_UDP			BIT_ULL(6)
-#define ICE_PROT_SCTP			BIT_ULL(7)
-#define ICE_PROT_ICMP4			BIT_ULL(8)
-#define ICE_PROT_ICMP6			BIT_ULL(9)
+#define ICE_PROT_MAC_OUTER		BIT_ULL(1)
+#define ICE_PROT_VLAN_OUTER		BIT_ULL(2)
+#define ICE_PROT_IPV4_OUTER		BIT_ULL(3)
+#define ICE_PROT_IPV6_OUTER		BIT_ULL(4)
+#define ICE_PROT_TCP_OUTER		BIT_ULL(5)
+#define ICE_PROT_UDP_OUTER		BIT_ULL(6)
+#define ICE_PROT_SCTP_OUTER		BIT_ULL(7)
+#define ICE_PROT_ICMP4_OUTER		BIT_ULL(8)
+#define ICE_PROT_ICMP6_OUTER		BIT_ULL(9)
 #define ICE_PROT_VXLAN			BIT_ULL(10)
 #define ICE_PROT_NVGRE			BIT_ULL(11)
 #define ICE_PROT_GTPU			BIT_ULL(12)
@@ -27,6 +27,16 @@
 #define ICE_PROT_L2TPV3OIP		BIT_ULL(16)
 #define ICE_PROT_PFCP			BIT_ULL(17)
 #define ICE_PROT_NAT_T_ESP		BIT_ULL(18)
+#define ICE_PROT_L2TPV2OIP		BIT_ULL(19)
+#define ICE_PROT_MAC_INNER		BIT_ULL(20)
+#define ICE_PROT_VLAN_INNER		BIT_ULL(21)
+#define ICE_PROT_IPV4_INNER		BIT_ULL(22)
+#define ICE_PROT_IPV6_INNER		BIT_ULL(23)
+#define ICE_PROT_TCP_INNER		BIT_ULL(24)
+#define ICE_PROT_UDP_INNER		BIT_ULL(25)
+#define ICE_PROT_SCTP_INNER		BIT_ULL(26)
+#define ICE_PROT_ICMP4_INNER		BIT_ULL(27)
+#define ICE_PROT_ICMP6_INNER		BIT_ULL(28)
 
 /* field */
 
@@ -53,8 +63,9 @@
 #define ICE_L2TPV3OIP_SESSION_ID	BIT_ULL(43)
 #define ICE_PFCP_SEID			BIT_ULL(42)
 #define ICE_PFCP_S_FIELD		BIT_ULL(41)
-#define ICE_IP_PK_ID		    BIT_ULL(40)
+#define ICE_IP_PK_ID			BIT_ULL(40)
 #define ICE_IP_FRAG_OFS			BIT_ULL(39)
+#define ICE_L2TPV2OIP_SESSION_ID	BIT_ULL(38)
 
 /* input set */
 
@@ -62,39 +73,39 @@
 
 #define ICE_INSET_SMAC			(ICE_SMAC)
 #define ICE_INSET_DMAC			(ICE_DMAC)
-#define ICE_INSET_VLAN			(ICE_PROT_VLAN)
-#define ICE_INSET_VLAN_INNER		(ICE_PROT_VLAN)
-#define ICE_INSET_VLAN_OUTER		(ICE_PROT_VLAN)
+#define ICE_INSET_VLAN			(ICE_PROT_VLAN_OUTER)
+#define ICE_INSET_VLAN_INNER		(ICE_PROT_VLAN_OUTER)
+#define ICE_INSET_VLAN_OUTER		(ICE_PROT_VLAN_OUTER)
 #define ICE_INSET_ETHERTYPE		(ICE_ETHERTYPE)
 
-#define ICE_INSET_IPV4_SRC		(ICE_PROT_IPV4 | ICE_IP_SRC)
-#define ICE_INSET_IPV4_DST		(ICE_PROT_IPV4 | ICE_IP_DST)
-#define ICE_INSET_IPV4_TOS		(ICE_PROT_IPV4 | ICE_IP_TOS)
-#define ICE_INSET_IPV4_PROTO		(ICE_PROT_IPV4 | ICE_IP_PROTO)
-#define ICE_INSET_IPV4_TTL		(ICE_PROT_IPV4 | ICE_IP_TTL)
-#define ICE_INSET_IPV4_PKID		(ICE_PROT_IPV4 | ICE_IP_PK_ID)
-#define ICE_INSET_IPV4_FRAG_OFS	(ICE_PROT_IPV4 | ICE_IP_FRAG_OFS)
-#define ICE_INSET_IPV6_SRC		(ICE_PROT_IPV6 | ICE_IP_SRC)
-#define ICE_INSET_IPV6_DST		(ICE_PROT_IPV6 | ICE_IP_DST)
-#define ICE_INSET_IPV6_NEXT_HDR		(ICE_PROT_IPV6 | ICE_IP_PROTO)
-#define ICE_INSET_IPV6_HOP_LIMIT	(ICE_PROT_IPV6 | ICE_IP_TTL)
-#define ICE_INSET_IPV6_TC		(ICE_PROT_IPV6 | ICE_IP_TOS)
-#define ICE_INSET_IPV6_PKID		(ICE_PROT_IPV6 | ICE_IP_PK_ID)
-
-#define ICE_INSET_TCP_SRC_PORT		(ICE_PROT_TCP | ICE_SPORT)
-#define ICE_INSET_TCP_DST_PORT		(ICE_PROT_TCP | ICE_DPORT)
-#define ICE_INSET_UDP_SRC_PORT		(ICE_PROT_UDP | ICE_SPORT)
-#define ICE_INSET_UDP_DST_PORT		(ICE_PROT_UDP | ICE_DPORT)
-#define ICE_INSET_SCTP_SRC_PORT		(ICE_PROT_SCTP | ICE_SPORT)
-#define ICE_INSET_SCTP_DST_PORT		(ICE_PROT_SCTP | ICE_DPORT)
-#define ICE_INSET_ICMP4_SRC_PORT	(ICE_PROT_ICMP4 | ICE_SPORT)
-#define ICE_INSET_ICMP4_DST_PORT	(ICE_PROT_ICMP4 | ICE_DPORT)
-#define ICE_INSET_ICMP6_SRC_PORT	(ICE_PROT_ICMP6 | ICE_SPORT)
-#define ICE_INSET_ICMP6_DST_PORT	(ICE_PROT_ICMP6 | ICE_DPORT)
-#define ICE_INSET_ICMP4_TYPE		(ICE_PROT_ICMP4 | ICE_ICMP_TYPE)
-#define ICE_INSET_ICMP4_CODE		(ICE_PROT_ICMP4 | ICE_ICMP_CODE)
-#define ICE_INSET_ICMP6_TYPE		(ICE_PROT_ICMP6 | ICE_ICMP_TYPE)
-#define ICE_INSET_ICMP6_CODE		(ICE_PROT_ICMP6 | ICE_ICMP_CODE)
+#define ICE_INSET_IPV4_SRC		(ICE_PROT_IPV4_OUTER | ICE_IP_SRC)
+#define ICE_INSET_IPV4_DST		(ICE_PROT_IPV4_OUTER | ICE_IP_DST)
+#define ICE_INSET_IPV4_TOS		(ICE_PROT_IPV4_OUTER | ICE_IP_TOS)
+#define ICE_INSET_IPV4_PROTO		(ICE_PROT_IPV4_OUTER | ICE_IP_PROTO)
+#define ICE_INSET_IPV4_TTL		(ICE_PROT_IPV4_OUTER | ICE_IP_TTL)
+#define ICE_INSET_IPV4_PKID		(ICE_PROT_IPV4_OUTER | ICE_IP_PK_ID)
+#define ICE_INSET_IPV4_FRAG_OFS	(ICE_PROT_IPV4_OUTER | ICE_IP_FRAG_OFS)
+#define ICE_INSET_IPV6_SRC		(ICE_PROT_IPV6_OUTER | ICE_IP_SRC)
+#define ICE_INSET_IPV6_DST		(ICE_PROT_IPV6_OUTER | ICE_IP_DST)
+#define ICE_INSET_IPV6_NEXT_HDR		(ICE_PROT_IPV6_OUTER | ICE_IP_PROTO)
+#define ICE_INSET_IPV6_HOP_LIMIT	(ICE_PROT_IPV6_OUTER | ICE_IP_TTL)
+#define ICE_INSET_IPV6_TC		(ICE_PROT_IPV6_OUTER | ICE_IP_TOS)
+#define ICE_INSET_IPV6_PKID		(ICE_PROT_IPV6_OUTER | ICE_IP_PK_ID)
+
+#define ICE_INSET_TCP_SRC_PORT		(ICE_PROT_TCP_OUTER | ICE_SPORT)
+#define ICE_INSET_TCP_DST_PORT		(ICE_PROT_TCP_OUTER | ICE_DPORT)
+#define ICE_INSET_UDP_SRC_PORT		(ICE_PROT_UDP_OUTER | ICE_SPORT)
+#define ICE_INSET_UDP_DST_PORT		(ICE_PROT_UDP_OUTER | ICE_DPORT)
+#define ICE_INSET_SCTP_SRC_PORT		(ICE_PROT_SCTP_OUTER | ICE_SPORT)
+#define ICE_INSET_SCTP_DST_PORT		(ICE_PROT_SCTP_OUTER | ICE_DPORT)
+#define ICE_INSET_ICMP4_SRC_PORT	(ICE_PROT_ICMP4_OUTER | ICE_SPORT)
+#define ICE_INSET_ICMP4_DST_PORT	(ICE_PROT_ICMP4_OUTER | ICE_DPORT)
+#define ICE_INSET_ICMP6_SRC_PORT	(ICE_PROT_ICMP6_OUTER | ICE_SPORT)
+#define ICE_INSET_ICMP6_DST_PORT	(ICE_PROT_ICMP6_OUTER | ICE_DPORT)
+#define ICE_INSET_ICMP4_TYPE		(ICE_PROT_ICMP4_OUTER | ICE_ICMP_TYPE)
+#define ICE_INSET_ICMP4_CODE		(ICE_PROT_ICMP4_OUTER | ICE_ICMP_CODE)
+#define ICE_INSET_ICMP6_TYPE		(ICE_PROT_ICMP6_OUTER | ICE_ICMP_TYPE)
+#define ICE_INSET_ICMP6_CODE		(ICE_PROT_ICMP6_OUTER | ICE_ICMP_CODE)
 
 /* tunnel */
 
@@ -122,6 +133,24 @@
 	(ICE_PROT_PFCP | ICE_PFCP_S_FIELD | ICE_PFCP_SEID)
 #define ICE_INSET_NAT_T_ESP_SPI \
 	(ICE_PROT_NAT_T_ESP | ICE_ESP_SPI)
+#define ICE_INSET_L2TPV2OIP_SESSION_ID \
+	(ICE_PROT_L2TPV2OIP | ICE_L2TPV2OIP_SESSION_ID)
+#define ICE_INSET_TUN_IPV4_SRC \
+	(ICE_PROT_IPV4_INNER | ICE_IP_SRC)
+#define ICE_INSET_TUN_IPV4_DST \
+	(ICE_PROT_IPV4_INNER | ICE_IP_DST)
+#define ICE_INSET_TUN_UDP_SRC_PORT \
+	(ICE_PROT_UDP_INNER | ICE_SPORT)
+#define ICE_INSET_TUN_UDP_DST_PORT \
+	(ICE_PROT_UDP_INNER | ICE_DPORT)
+#define ICE_INSET_TUN_TCP_SRC_PORT \
+	(ICE_PROT_TCP_INNER | ICE_SPORT)
+#define ICE_INSET_TUN_TCP_DST_PORT \
+	(ICE_PROT_TCP_INNER | ICE_DPORT)
+#define ICE_INSET_TUN_IPV6_SRC \
+	(ICE_PROT_IPV6_INNER | ICE_IP_SRC)
+#define ICE_INSET_TUN_IPV6_DST \
+	(ICE_PROT_IPV6_INNER | ICE_IP_DST)
 
 /* empty pattern */
 extern enum rte_flow_item_type pattern_empty[];
@@ -400,6 +429,24 @@ extern enum rte_flow_item_type pattern_eth_ipv6_udp_ah[];
 /* L2TP */
 extern enum rte_flow_item_type pattern_eth_ipv4_l2tp[];
 extern enum rte_flow_item_type pattern_eth_ipv6_l2tp[];
+extern enum rte_flow_item_type pattern_eth_ipv4_l2tpv2[];
+extern enum rte_flow_item_type pattern_eth_ipv6_l2tpv2[];
+extern enum rte_flow_item_type pattern_eth_ipv4_udp_l2tpv2[];
+extern enum rte_flow_item_type pattern_eth_ipv4_udp_l2tpv2_ppp[];
+extern enum rte_flow_item_type pattern_eth_ipv6_udp_l2tpv2[];
+extern enum rte_flow_item_type pattern_eth_ipv6_udp_l2tpv2_ppp[];
+extern enum rte_flow_item_type pattern_eth_ipv4_udp_l2tpv2_ppp_ipv4[];
+extern enum rte_flow_item_type pattern_eth_ipv4_udp_l2tpv2_ppp_ipv4_udp[];
+extern enum rte_flow_item_type pattern_eth_ipv4_udp_l2tpv2_ppp_ipv4_tcp[];
+extern enum rte_flow_item_type pattern_eth_ipv6_udp_l2tpv2_ppp_ipv4[];
+extern enum rte_flow_item_type pattern_eth_ipv6_udp_l2tpv2_ppp_ipv4_udp[];
+extern enum rte_flow_item_type pattern_eth_ipv6_udp_l2tpv2_ppp_ipv4_tcp[];
+extern enum rte_flow_item_type pattern_eth_ipv4_udp_l2tpv2_ppp_ipv6[];
+extern enum rte_flow_item_type pattern_eth_ipv4_udp_l2tpv2_ppp_ipv6_udp[];
+extern enum rte_flow_item_type pattern_eth_ipv4_udp_l2tpv2_ppp_ipv6_tcp[];
+extern enum rte_flow_item_type pattern_eth_ipv6_udp_l2tpv2_ppp_ipv6[];
+extern enum rte_flow_item_type pattern_eth_ipv6_udp_l2tpv2_ppp_ipv6_udp[];
+extern enum rte_flow_item_type pattern_eth_ipv6_udp_l2tpv2_ppp_ipv6_tcp[];
 
 /* PFCP */
 extern enum rte_flow_item_type pattern_eth_ipv4_pfcp[];
-- 
2.34.1

