Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F57E9A048
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 11:25:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C8204066A;
	Thu, 19 Feb 2026 12:25:07 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id B70DC40616
 for <dev@dpdk.org>; Thu, 19 Feb 2026 12:24:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771500296; x=1803036296;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=PjXtWDNJgfaUoUM/cd54IsWK+IG2IgpilMTdh4FuWKk=;
 b=UReh8D8La3BGvBc684oHtTvLm6Whcr8MVKN7WeQi7YOLBDuMQnnGAZKu
 rirDFc+8UuQ2SflkoWwQEHiEkXqlbIIn3Nz48sv5NwvdQeQJKp7WXPYSb
 GAk/BJM5j3ziX+ze6FLLTB/+LocPhuto49VSEPaJlo+SCGxRrJqARDRkX
 m4YSeJ9/KkPRi9/1tEC/cC8HV8Tzn8VqXIRLcSPCKJBnJsdRrSgg0LZrj
 QzG/no+nLUpb4jPO8oUi+XAiDQ6w4pNdj1v3/B0fkEDL1NABFdXxVp8zI
 JSgXytt1LoE85xeEY46dEYJFUpbha3GzU6DbNo1zPxkE4dDe/DRnqfyAN g==;
X-CSE-ConnectionGUID: W81bepesSN+XILwWHt9lPQ==
X-CSE-MsgGUID: 8J2pBTw2R5GxqmOMld9Ygg==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="76198681"
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; d="scan'208";a="76198681"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2026 03:24:55 -0800
X-CSE-ConnectionGUID: 1+gB0Sf9SGi0laISDPFCwQ==
X-CSE-MsgGUID: +dFO2yBMRj2hEV5oueJgAg==
X-ExtLoop1: 1
Received: from unknown (HELO sprmax15..) ([10.138.182.128])
 by fmviesa003.fm.intel.com with ESMTP; 19 Feb 2026 03:24:54 -0800
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Cc: Song Jiale <songx.jiale@intel.com>
Subject: [PATCH v7 7/7] net/ice: add L2TPv2 RSS hash support
Date: Thu, 19 Feb 2026 16:51:03 +0530
Message-Id: <20260219112103.2370766-8-shaiq.wani@intel.com>
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

Add RSS (Receive Side Scaling) hash support for L2TPv2 packets.
Add L2TPv2 over UDP support for ice PMD in the release notes.

Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
Tested-by: Song Jiale <songx.jiale@intel.com>
---
 doc/guides/rel_notes/release_26_03.rst |  4 ++++
 drivers/net/intel/ice/ice_hash.c       | 25 +++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index b4499ec066..8ae46e78e7 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -77,6 +77,10 @@ New Features
 
   * Added support for pre and post VF reset callbacks.
 
+* **Updated Intel ice driver.**
+
+  * Added rte_flow support for L2TPv2 over UDP.
+
 * **Updated Marvell cnxk net driver.**
 
   * Added out-of-place support for CN20K SoC.
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

