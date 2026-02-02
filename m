Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC63E73151
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 09:44:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AF10240BA5;
	Mon,  2 Feb 2026 10:44:10 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 20ECE40BA0
 for <dev@dpdk.org>; Mon,  2 Feb 2026 10:44:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770025449; x=1801561449;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RfH0UPla4hx7ce8lDxFVELFetAAWvwH1r0qWFHYzGuw=;
 b=FIUeauieobBPX99/9MsJzMjh+0m3GXZZPg0jnjySqKuPT1Et6ppsqqEn
 CTw63OFsmJJPE7HdfLdbS1VJv8PruHt7ojz7Hl2VI6k/5hRCGV0JhtOCl
 LvTh5EM+X9xOLSHfa6LKvfiIt1eXEQoQhDwxR+DVxuqhsHYjMiY67Uzp1
 2AjgzdJxdjGuka5P9BqkcGoBZloVAWJCwti1G6MQwDyTZrBI2krHfgn/V
 CLzyl8R5qpXfZpLpaXcYbNLgxOffTyw+VF+aKpaTvWIn1vlLb020zBTgY
 E/5EQMgI2IQXcFoNlYMg4UKnR6oeyX1ExqbDbAWjjLIZAGNIzylf49ozV g==;
X-CSE-ConnectionGUID: VT6ZBwWhTXmfK49fHRshaw==
X-CSE-MsgGUID: nmuVWmLvTGucRw9YRVKGZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11689"; a="81917715"
X-IronPort-AV: E=Sophos;i="6.21,268,1763452800"; d="scan'208";a="81917715"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Feb 2026 01:44:09 -0800
X-CSE-ConnectionGUID: bHLkCNLdQHKql8qytVySEA==
X-CSE-MsgGUID: aJ5+BmKPRC6ta9CTr9dcOQ==
X-ExtLoop1: 1
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by fmviesa003.fm.intel.com with ESMTP; 02 Feb 2026 01:44:07 -0800
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Cc: Jiale Song <songx.jiale@intel.com>
Subject: [PATCH 6/6] net/ice: add L2TPv2 RSS hash support
Date: Mon,  2 Feb 2026 15:12:44 +0530
Message-Id: <20260202094244.447966-7-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260202094244.447966-1-shaiq.wani@intel.com>
References: <20260202094244.447966-1-shaiq.wani@intel.com>
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
Tested-by: Jiale Song <songx.jiale@intel.com>
---
 drivers/net/intel/ice/ice_hash.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/net/intel/ice/ice_hash.c b/drivers/net/intel/ice/ice_hash.c
index aa6a21c055..02e15d0bdd 100644
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
@@ -917,6 +937,11 @@ ice_refine_hash_cfg_l234(struct ice_rss_hash_cfg *hash_cfg,
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

