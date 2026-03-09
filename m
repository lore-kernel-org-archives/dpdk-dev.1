Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029ACEA8542
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Mar 2026 02:33:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AF9CC40281;
	Mon,  9 Mar 2026 03:33:45 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 6F38D40261;
 Mon,  9 Mar 2026 03:33:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773023625; x=1804559625;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=6/mhUT1pZhyd3joQLZMWB3zCm9TUNydU/br9cHPpiDo=;
 b=CPZb+mtedSfGuF0V9hOlMDDURwRO6VuKPhmRNJSxApGXyKAZZg6LlWm+
 qpXkLi4HOBzrp/bL+BQ0tUfFYwsU5FxEuy66v/msq45cpX520XIlzbvkN
 BPDK7VQ0zdzDDqAxPzfcE8gU0CXnP+usHEi5yF6FN/Xm35Tcnkjq0QiS7
 xABZwUMFXya0cuhT5O/gYX9wOKGzjI5ssUyQ54P9caPFF4TLLeAvSwp4b
 QRDrJmD28YUROJRIBGOz92Z6f3Qek1X+KfWyuQlvIN5T1IqNFf25YD4Ny
 DVtrNtilu1Pkxi/Uee72KHbZ/r40th19dD9e53WB5rmKdccawjtAcsleM Q==;
X-CSE-ConnectionGUID: dHIh5m8kRtuFlf18qysBxw==
X-CSE-MsgGUID: A2+qUQW2SOylpJVE1RUWxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="85131411"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; d="scan'208";a="85131411"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Mar 2026 19:33:42 -0700
X-CSE-ConnectionGUID: CrykCd88QaifBiY9BOkLew==
X-CSE-MsgGUID: Z6AOkITAT/WKh702uK7/lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; d="scan'208";a="217693185"
Received: from pae-14.iind.intel.com ([10.190.203.153])
 by fmviesa008.fm.intel.com with ESMTP; 08 Mar 2026 19:33:39 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 alex.chapman@arm.com, Anurag Mandal <anurag.mandal@intel.com>,
 stable@dpdk.org
Subject: [PATCH] net/ice: fix rss simple_xor hash function
Date: Mon,  9 Mar 2026 02:32:55 +0000
Message-Id: <20260309023255.308526-1-anurag.mandal@intel.com>
X-Mailer: git-send-email 2.34.1
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

RSS Simple XOR hash function is supported by the NIC
as per datasheet & also in ICE Linux Ethernet kernel
driver but the same is not enabled in ICE PMD even
though code support is already present.

This patch fixes the issue by removing the simple_xor
check & adding proper error log for empty argument.

Bugzilla ID: 1518
Fixes: 0b952714e9c1 ("net/ice: refactor PF hash flow")
Cc: stable@dpdk.org

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
 drivers/net/intel/ice/ice_hash.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/intel/ice/ice_hash.c b/drivers/net/intel/ice/ice_hash.c
index 77829e607b..d57b5ee0e4 100644
--- a/drivers/net/intel/ice/ice_hash.c
+++ b/drivers/net/intel/ice/ice_hash.c
@@ -1109,12 +1109,11 @@ ice_hash_parse_action(struct ice_pattern_match_item *pattern_match_item,
 			rss_type = rss->types;
 
 			/* Check hash function and save it to rss_meta. */
-			if (pattern_match_item->pattern_list !=
-			    pattern_empty && rss->func ==
-			    RTE_ETH_HASH_FUNCTION_SIMPLE_XOR) {
-				return rte_flow_error_set(error, ENOTSUP,
+			if (pattern_match_item->pattern_list ==
+			    pattern_empty) {
+				return rte_flow_error_set(error, EINVAL,
 					RTE_FLOW_ERROR_TYPE_ACTION, action,
-					"Not supported flow");
+					"Invalid empty argument");
 			} else if (rss->func ==
 				   RTE_ETH_HASH_FUNCTION_SIMPLE_XOR){
 				rss_meta->hash_function =
-- 
2.34.1

