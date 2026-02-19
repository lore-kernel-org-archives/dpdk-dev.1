Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BF2E9A048
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 11:25:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C8C240657;
	Thu, 19 Feb 2026 12:24:57 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 04CEC402E4
 for <dev@dpdk.org>; Thu, 19 Feb 2026 12:24:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771500291; x=1803036291;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=a8jwt8O704MN9H8eJMSHGz1ega0jdb+0QxnUwq22U3w=;
 b=PTKujx9PEAIJPr3h6K5c1tQIBrdIlNAZ/ExPhxM1dAMzxmeLS9Jq+VeG
 uF+Ftvk3o0V3p4Al5RluqnJxQ/ZAaLVbtnWPcMV6chCPHHtsc9j7jtSh4
 Dy/wrNmZi9p4tclNlPV5t1eZGztdQ5MT4a0zWSMuY0WUNblHcgURZXN7H
 G+GBT19rIEby0C1+4w1tyqSZFzp7RaHrXvfmRW87JPiCKvictpFBObbbc
 wec8DUNzADREcfOVOWcEahXsJypvma3BVnHhIEizyBEx7jOjRx8eVgJqt
 Q6f10sFfwDf6Zve17Spw7fqecW02eafwzOe5ecSoUwi8qSZISxMqXWIBw w==;
X-CSE-ConnectionGUID: KhAyvfcxRtKIbTawQs5cgw==
X-CSE-MsgGUID: d5m5CcjDSSqBDBfoNQ3usQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="76198678"
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; d="scan'208";a="76198678"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2026 03:24:51 -0800
X-CSE-ConnectionGUID: CenW15yYSJmc7toCzBqDng==
X-CSE-MsgGUID: NyJN4z1hRkuq9tseUhGstQ==
X-ExtLoop1: 1
Received: from unknown (HELO sprmax15..) ([10.138.182.128])
 by fmviesa003.fm.intel.com with ESMTP; 19 Feb 2026 03:24:49 -0800
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Cc: Song Jiale <songx.jiale@intel.com>
Subject: [PATCH v7 4/7] net/ice: add L2TPv2 protocol support
Date: Thu, 19 Feb 2026 16:51:00 +0530
Message-Id: <20260219112103.2370766-5-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260219112103.2370766-1-shaiq.wani@intel.com>
References: <20260202094244.447966-2-shaiq.wani@intel.com>
 <20260219112103.2370766-1-shaiq.wani@intel.com>
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

Add L2TPv2 protocol identifier and session ID field definition
to enable flow classification and filtering for L2TPv2 tunneled
traffic.

Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
Tested-by: Song Jiale <songx.jiale@intel.com>
---
 drivers/net/intel/ice/ice_generic_flow.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/net/intel/ice/ice_generic_flow.h b/drivers/net/intel/ice/ice_generic_flow.h
index 0b282d4ee5..1b5514d5df 100644
--- a/drivers/net/intel/ice/ice_generic_flow.h
+++ b/drivers/net/intel/ice/ice_generic_flow.h
@@ -27,6 +27,7 @@
 #define ICE_PROT_L2TPV3OIP		BIT_ULL(16)
 #define ICE_PROT_PFCP			BIT_ULL(17)
 #define ICE_PROT_NAT_T_ESP		BIT_ULL(18)
+#define ICE_PROT_L2TPV2OIP		BIT_ULL(19)
 #define ICE_PROT_MAC_INNER		BIT_ULL(20)
 #define ICE_PROT_VLAN_INNER		BIT_ULL(21)
 #define ICE_PROT_IPV4_INNER		BIT_ULL(22)
@@ -64,6 +65,7 @@
 #define ICE_PFCP_S_FIELD		BIT_ULL(41)
 #define ICE_IP_PK_ID			BIT_ULL(40)
 #define ICE_IP_FRAG_OFS			BIT_ULL(39)
+#define ICE_L2TPV2OIP_SESSION_ID	BIT_ULL(38)
 
 /* input set */
 
@@ -131,6 +133,8 @@
 	(ICE_PROT_PFCP | ICE_PFCP_S_FIELD | ICE_PFCP_SEID)
 #define ICE_INSET_NAT_T_ESP_SPI \
 	(ICE_PROT_NAT_T_ESP | ICE_ESP_SPI)
+#define ICE_INSET_L2TPV2OIP_SESSION_ID \
+	(ICE_PROT_L2TPV2OIP | ICE_L2TPV2OIP_SESSION_ID)
 #define ICE_INSET_TUN_IPV4_SRC \
 	(ICE_PROT_IPV4_INNER | ICE_IP_SRC)
 #define ICE_INSET_TUN_IPV4_DST \
@@ -425,6 +429,24 @@ extern enum rte_flow_item_type pattern_eth_ipv6_udp_ah[];
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

