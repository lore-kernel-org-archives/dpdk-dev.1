Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B049E9A047
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 16:42:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A4864065E;
	Wed, 18 Feb 2026 17:41:52 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 603B240659
 for <dev@dpdk.org>; Wed, 18 Feb 2026 17:41:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771432906; x=1802968906;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hE4BqUwyrUsxe44fwmT9WSS00Gc6qkjbcHPjJ58k1gE=;
 b=fWCFZoEwWVx7t9GMMCaMGdCZc+Fy5Js2ta7HgOom7u7OIjRPNWROVPBM
 PeXPZ58liKpzqagy0Avwr9VtwqmFMBV3eEXCeUvwlMAksd9NLAGbh2K4w
 toSHYiyCgpSL7x1MAx1H1A8xfVzjDvdHqWGM0wIzdPkHwbRVwEXusHHjv
 7QyO8ecXIopHNSMLQixIcVYwxsb1SjjCYU0pJ+9UTccUGUjm7nvgGOkuF
 /6PTEbvAomK/TNYmMcpBktFzXM54DfbdS/krrCrVDk8OlQaZ52O7BS3KD
 ov9cOqx4XzZP0ZXIIBuRut9EK4+UIjFoFe9MjKpL/LOKao1HSsdMSjRIQ w==;
X-CSE-ConnectionGUID: s19I57ZTTp2Dv1GuvT5BuA==
X-CSE-MsgGUID: kStnluIpTMGcPLlmvKayOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="72601858"
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; d="scan'208";a="72601858"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2026 08:41:45 -0800
X-CSE-ConnectionGUID: KLYzzGF8QdmC5TEYWEgHmw==
X-CSE-MsgGUID: Lt+1JbbFQdukEyikewg1lg==
X-ExtLoop1: 1
Received: from unknown (HELO sprmax15..) ([10.138.182.128])
 by fmviesa003.fm.intel.com with ESMTP; 18 Feb 2026 08:41:43 -0800
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Cc: Song Jiale <songx.jiale@intel.com>
Subject: [PATCH v6 3/8] net/ice: rename protocol identifiers
Date: Wed, 18 Feb 2026 22:07:45 +0530
Message-Id: <20260218163750.1408973-4-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260218163750.1408973-1-shaiq.wani@intel.com>
References: <20260202094244.447966-2-shaiq.wani@intel.com>
 <20260218163750.1408973-1-shaiq.wani@intel.com>
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

Rename existing protocol identifiers to use _OUTER suffix and add
corresponding _INNER variants to support tunneled packet parsing.

Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
Tested-by: Song Jiale <songx.jiale@intel.com>
---
 drivers/net/intel/ice/ice_generic_flow.h | 107 ++++++++++++++---------
 1 file changed, 66 insertions(+), 41 deletions(-)

diff --git a/drivers/net/intel/ice/ice_generic_flow.h b/drivers/net/intel/ice/ice_generic_flow.h
index 54bbb47398..0b282d4ee5 100644
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
@@ -27,6 +27,15 @@
 #define ICE_PROT_L2TPV3OIP		BIT_ULL(16)
 #define ICE_PROT_PFCP			BIT_ULL(17)
 #define ICE_PROT_NAT_T_ESP		BIT_ULL(18)
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
 
@@ -53,7 +62,7 @@
 #define ICE_L2TPV3OIP_SESSION_ID	BIT_ULL(43)
 #define ICE_PFCP_SEID			BIT_ULL(42)
 #define ICE_PFCP_S_FIELD		BIT_ULL(41)
-#define ICE_IP_PK_ID		    BIT_ULL(40)
+#define ICE_IP_PK_ID			BIT_ULL(40)
 #define ICE_IP_FRAG_OFS			BIT_ULL(39)
 
 /* input set */
@@ -62,39 +71,39 @@
 
 #define ICE_INSET_SMAC			(ICE_SMAC)
 #define ICE_INSET_DMAC			(ICE_DMAC)
-#define ICE_INSET_VLAN			(ICE_PROT_VLAN)
-#define ICE_INSET_VLAN_INNER		(ICE_PROT_VLAN)
-#define ICE_INSET_VLAN_OUTER		(ICE_PROT_VLAN)
+#define ICE_INSET_VLAN			(ICE_PROT_VLAN_OUTER)
+#define ICE_INSET_VLAN_INNER		(ICE_PROT_VLAN_INNER)
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
 
@@ -122,6 +131,22 @@
 	(ICE_PROT_PFCP | ICE_PFCP_S_FIELD | ICE_PFCP_SEID)
 #define ICE_INSET_NAT_T_ESP_SPI \
 	(ICE_PROT_NAT_T_ESP | ICE_ESP_SPI)
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
-- 
2.34.1

