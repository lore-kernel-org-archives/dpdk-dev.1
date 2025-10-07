Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FC8CCA472
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Oct 2025 11:37:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B55E9402B6;
	Tue,  7 Oct 2025 13:37:45 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id CE45F402B1;
 Tue,  7 Oct 2025 13:37:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759837064; x=1791373064;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=hmisthO/0+oLzDQ+oHkNlKXks/y0Tl5QJyx5W0vLWqM=;
 b=PrE2Z/Y0bSn+ZvslpLvIUdqkh3dnZ2JSQCdLSXGSv3LY4A5jjsChhufS
 jy/KKhvSu+fvAEDXVvnzp8UXTCFpjFA7QeCk8qhaJTdXAJ5U4q9/Tx9OC
 Y5H/qsEmKzo3cwxOS1FcFwFguL/KrOSXpKAztE8uTOodxZQ4XOG8ZT9pO
 0923muLdiQsy5aeGBHEWfDWp5JvuPGhga30SXU61GNNeZGf9Mcsa0X7Ua
 3G4nnXVXNpwB39KwjC0SUZEINO2jk44fXf74YE7DeoTlUtzLc3cTqiO+n
 mTAxZgr2sr0fiRbKqoC/docWmtEbLUtzBUK1MMxeueMIgtjcEATKK8Wbl w==;
X-CSE-ConnectionGUID: D6oXt7emQmid66FKa7LKuA==
X-CSE-MsgGUID: mHf8tNp0TCqX2nAI07HyLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="65847221"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="65847221"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2025 04:37:43 -0700
X-CSE-ConnectionGUID: HKeRmS6tSkmT2GcSWwNz6Q==
X-CSE-MsgGUID: /vE17dMrRWKEJ0GfQhrRmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; d="scan'208";a="179713645"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa009.jf.intel.com with ESMTP; 07 Oct 2025 04:37:41 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Qi Zhang <qi.z.zhang@intel.com>, Junfeng Guo <junfengg@nvidia.com>
Cc: vladimir.medvedkin@intel.com,
	stable@dpdk.org
Subject: [PATCH v1 1/1] net/ice: fix memory leak in raw pattern parse
Date: Tue,  7 Oct 2025 12:37:40 +0100
Message-ID: <65bfe82e74867020982e2729f84a7c00a5690c5b.1759837052.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
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

Currently, when parsing rte_flow raw type items, we allocate a bunch of
internal structures, but if errors happen down the line we just quit and
never free the memory we just allocated. Fix this by adding an error
cleanup section.

Fixes: 25be39cc1760 ("net/ice: enable protocol agnostic flow offloading in FDIR")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ice/ice_fdir_filter.c | 40 ++++++++++++++++++-------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/drivers/net/intel/ice/ice_fdir_filter.c b/drivers/net/intel/ice/ice_fdir_filter.c
index d41d223d52..7aa8fc3994 100644
--- a/drivers/net/intel/ice/ice_fdir_filter.c
+++ b/drivers/net/intel/ice/ice_fdir_filter.c
@@ -1867,7 +1867,7 @@ ice_fdir_parse_pattern(__rte_unused struct ice_adapter *ad,
 			uint16_t tmp_val = 0;
 			uint16_t pkt_len = 0;
 			uint8_t tmp = 0;
-			int i, j;
+			int i, j, ret_val;
 
 			pkt_len = strlen((char *)(uintptr_t)raw_spec->pattern);
 			if (strlen((char *)(uintptr_t)raw_mask->pattern) !=
@@ -1922,24 +1922,34 @@ ice_fdir_parse_pattern(__rte_unused struct ice_adapter *ad,
 
 			pkt_len /= 2;
 
-			if (ice_parser_run(ad->psr, tmp_spec, pkt_len, &rslt))
-				return -rte_errno;
+			if (ice_parser_run(ad->psr, tmp_spec, pkt_len, &rslt)) {
+				ret_val = -rte_errno;
+				goto raw_error;
+			}
 
-			if (!tmp_mask)
-				return -rte_errno;
+			if (!tmp_mask) {
+				ret_val = -rte_errno;
+				goto raw_error;
+			}
 
 			filter->prof = (struct ice_parser_profile *)
 				ice_malloc(&ad->hw, sizeof(*filter->prof));
-			if (!filter->prof)
-				return -ENOMEM;
+			if (!filter->prof) {
+				ret_val = -ENOMEM;
+				goto raw_error;
+			}
 
 			if (ice_parser_profile_init(&rslt, tmp_spec, tmp_mask,
-				pkt_len, ICE_BLK_FD, true, filter->prof))
-				return -rte_errno;
+				pkt_len, ICE_BLK_FD, true, filter->prof)) {
+				ret_val = -rte_errno;
+				goto raw_error_prof;
+			}
 
 			u8 *pkt_buf = (u8 *)ice_malloc(&ad->hw, pkt_len + 1);
-			if (!pkt_buf)
-				return -ENOMEM;
+			if (!pkt_buf) {
+				ret_val = -ENOMEM;
+				goto raw_error_prof;
+			}
 			rte_memcpy(pkt_buf, tmp_spec, pkt_len);
 			filter->pkt_buf = pkt_buf;
 
@@ -1950,6 +1960,14 @@ ice_fdir_parse_pattern(__rte_unused struct ice_adapter *ad,
 			rte_free(tmp_spec);
 			rte_free(tmp_mask);
 			break;
+
+raw_error_prof:
+			rte_free(filter->prof);
+			filter->prof = NULL;
+raw_error:
+			rte_free(tmp_spec);
+			rte_free(tmp_mask);
+			return ret_val;
 		}
 
 		case RTE_FLOW_ITEM_TYPE_ETH:
-- 
2.47.3

