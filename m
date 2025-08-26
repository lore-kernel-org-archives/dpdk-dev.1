Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD6BDEDF040
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 05:32:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3833A40689;
	Thu, 12 Feb 2026 06:31:45 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id B590640656
 for <dev@dpdk.org>; Thu, 12 Feb 2026 06:31:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770874300; x=1802410300;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=i6v0b7by4iAX06rjbgGwcE0R5PaDv0XDBSneMm+LwiQ=;
 b=Nzs/Q6LJ5ADnF+XND434q4NUb7ZraiM3LTkHDHWVpTdiI/HJ700kit3o
 X/lX1mmTbfFZBlPwU/eGx8M10wYXpAAJUYauoBfqtpYfTWER7dx5PbWue
 oILD9DvwEizADtSKLFr/v1W3NbHmKVZtdSCcpBmE28WnAfZd9CrrVR5MC
 gMN14gfeioadLVM92Kc4fJ9FjVEzSWhMivx/2yyt4GujEDYI+xhIjzkwr
 atVK/TC9zQOuAUepLY6sVDdkGE7C/CeinHNHB0erbogpmF9z8fPh0kUX5
 DyolEresb+NY4DvCUdmQncMaWZ3C+i7+LAt7x+k1NaMaKAXo4lh0f1+Xr Q==;
X-CSE-ConnectionGUID: nnfIwfQIRwGKfQgpiVZ57Q==
X-CSE-MsgGUID: J+ut8BljTBC7OEPtDPgvXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="83405356"
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="83405356"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 21:31:39 -0800
X-CSE-ConnectionGUID: ti5MbEjDT1KPZnb62loRXg==
X-CSE-MsgGUID: IqHOQdqyTlq+JGAOn7Sz7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="212581416"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by orviesa007.jf.intel.com with ESMTP; 11 Feb 2026 21:31:38 -0800
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Cc: Song Jiale <songx.jiale@intel.com>
Subject: [PATCH v5 6/7] net/ice: add L2TPv2 RSS hash support
Date: Tue, 26 Aug 2025 22:35:40 +0530
Message-Id: <20250826170541.5010-7-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250826170541.5010-1-shaiq.wani@intel.com>
References: <20260202094244.447966-1-shaiq.wani@intel.com>
 <20250826170541.5010-1-shaiq.wani@intel.com>
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

