Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0FDE81BA5
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 11:59:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9784D40679;
	Mon,  9 Feb 2026 12:58:36 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id DC92240661
 for <dev@dpdk.org>; Mon,  9 Feb 2026 12:58:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770638311; x=1802174311;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=i6v0b7by4iAX06rjbgGwcE0R5PaDv0XDBSneMm+LwiQ=;
 b=Ifs5i+tO8Lej3/woQCfBMvKXGbxAsWMHUvxNovNi4u6Fr2mIsk5tGNmk
 vseXvQyd/I9sAJfABNHeNy9EXW2exCrJf4bi6zXnaREbtO/0MC/4qDg4n
 k0te/08phDjTd1CG1rijjDVd+ka2sQLkV0YvAXN9uyl76g3gCp6u3dMMC
 rx1oBHlIXXUKNGN4KFw3fSZv9s7ifPjrjwWn4abz/mtCBgkjGHj2FUVfd
 u8YfLC9xwNcUolMcQ2WDGWAME/PQYYATtXRpbFE3YeCvcqwQqkNjYmbZE
 3FUTbce5IIe1bIupvi1x6NM3pj8Nlj+EFqm/UadiBRLLQNwqBjM2wJZv2 Q==;
X-CSE-ConnectionGUID: U38HhgaYSAaIRmv9rYCKaA==
X-CSE-MsgGUID: PU32f+FrSHCu4ubqIqCATw==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="71640977"
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="71640977"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 03:58:31 -0800
X-CSE-ConnectionGUID: Y/ySYWpbSc2eAItyGRhGMA==
X-CSE-MsgGUID: 5ljJy453RAK1QKNEJLAyEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="211627110"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by orviesa007.jf.intel.com with ESMTP; 09 Feb 2026 03:58:29 -0800
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Cc: Song Jiale <songx.jiale@intel.com>
Subject: [PATCH v2 6/7] net/ice: add L2TPv2 RSS hash support
Date: Mon,  9 Feb 2026 17:26:56 +0530
Message-Id: <20260209115657.636525-7-shaiq.wani@intel.com>
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

Add RSS (Receive Side Scaling) hash support for L2TPv2 packets.
define hash templates and patterns for distributing L2TPv2 traffic
across multiple receive queues based on session IDs and inner headers.

Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
Tested-by: Song Jiale <songx.jiale@intel.com>
---
 drivers/net/intel/ice/ice_hash.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/net/intel/ice/ice_hash.c b/drivers/net/intel/ice/ice_hash.c
index afdc8f220a..b20103a452 100644
--- a/drivers/net/intel/ice/ice_hash.c
+++ b/drivers/net/intel/ice/ice_hash.c
@@ -305,6 +305,22 @@ struct ice_rss_hash_cfg eth_ipv4_l2tpv3_tmplt = {
 	0
 };
 
+struct ice_rss_hash_cfg eth_ipv4_l2tpv2_tmplt = {
+	ICE_FLOW_SEG_HDR_IPV4 | ICE_FLOW_SEG_HDR_IPV_OTHER |
+	ICE_FLOW_SEG_HDR_L2TPV2,
+	ICE_FLOW_HASH_L2TPV2_SESS_ID,
+	ICE_RSS_OUTER_HEADERS,
+	0
+};
+
+struct ice_rss_hash_cfg eth_ipv6_l2tpv2_tmplt = {
+	ICE_FLOW_SEG_HDR_IPV6 | ICE_FLOW_SEG_HDR_IPV_OTHER |
+	ICE_FLOW_SEG_HDR_L2TPV2,
+	ICE_FLOW_HASH_L2TPV2_SESS_ID,
+	ICE_RSS_OUTER_HEADERS,
+	0
+};
+
 struct ice_rss_hash_cfg eth_ipv4_pfcp_tmplt = {
 	ICE_FLOW_SEG_HDR_IPV4 | ICE_FLOW_SEG_HDR_IPV_OTHER |
 	ICE_FLOW_SEG_HDR_PFCP_SESSION,
@@ -480,6 +496,8 @@ struct ice_rss_hash_cfg eth_tmplt = {
 #define ICE_RSS_TYPE_IPV6_AH		(RTE_ETH_RSS_AH | RTE_ETH_RSS_IPV6)
 #define ICE_RSS_TYPE_IPV4_L2TPV3	(RTE_ETH_RSS_L2TPV3 | RTE_ETH_RSS_IPV4)
 #define ICE_RSS_TYPE_IPV6_L2TPV3	(RTE_ETH_RSS_L2TPV3 | RTE_ETH_RSS_IPV6)
+#define ICE_RSS_TYPE_IPV4_L2TPV2	(RTE_ETH_RSS_L2TPV2 | RTE_ETH_RSS_IPV4)
+#define ICE_RSS_TYPE_IPV6_L2TPV2	(RTE_ETH_RSS_L2TPV2 | RTE_ETH_RSS_IPV6)
 #define ICE_RSS_TYPE_IPV4_PFCP		(RTE_ETH_RSS_PFCP | RTE_ETH_RSS_IPV4)
 #define ICE_RSS_TYPE_IPV6_PFCP		(RTE_ETH_RSS_PFCP | RTE_ETH_RSS_IPV6)
 
@@ -522,6 +540,8 @@ static struct ice_pattern_match_item ice_hash_pattern_list[] = {
 	{pattern_eth_ipv4_udp_esp,		ICE_RSS_TYPE_IPV4_ESP,		ICE_INSET_NONE,	&eth_ipv4_udp_esp_tmplt},
 	{pattern_eth_ipv4_ah,			ICE_RSS_TYPE_IPV4_AH,		ICE_INSET_NONE,	&eth_ipv4_ah_tmplt},
 	{pattern_eth_ipv4_l2tp,			ICE_RSS_TYPE_IPV4_L2TPV3,	ICE_INSET_NONE,	&eth_ipv4_l2tpv3_tmplt},
+	{pattern_eth_ipv4_l2tpv2,		ICE_RSS_TYPE_IPV4_L2TPV2,	ICE_INSET_NONE,	&eth_ipv4_l2tpv2_tmplt},
+	{pattern_eth_ipv6_l2tpv2,		ICE_RSS_TYPE_IPV6_L2TPV2,	ICE_INSET_NONE,	&eth_ipv6_l2tpv2_tmplt},
 	{pattern_eth_ipv4_pfcp,			ICE_RSS_TYPE_IPV4_PFCP,		ICE_INSET_NONE,	&eth_ipv4_pfcp_tmplt},
 	/* IPV6 */
 	{pattern_eth_ipv6,			ICE_RSS_TYPE_ETH_IPV6,		ICE_INSET_NONE,	&ipv6_tmplt},
@@ -925,6 +945,11 @@ ice_refine_hash_cfg_l234(struct ice_rss_hash_cfg *hash_cfg,
 			*hash_flds &= ~ICE_FLOW_HASH_L2TPV3_SESS_ID;
 	}
 
+	if (*addl_hdrs & ICE_FLOW_SEG_HDR_L2TPV2) {
+		if (!(rss_type & RTE_ETH_RSS_L2TPV2))
+			*hash_flds &= ~ICE_FLOW_HASH_L2TPV2_SESS_ID;
+	}
+
 	if (*addl_hdrs & ICE_FLOW_SEG_HDR_ESP) {
 		if (!(rss_type & RTE_ETH_RSS_ESP))
 			*hash_flds &= ~ICE_FLOW_HASH_ESP_SPI;
-- 
2.34.1

