Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D187CCA476
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Oct 2025 13:13:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5CEE240667;
	Fri, 10 Oct 2025 15:13:30 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 796044026F;
 Fri, 10 Oct 2025 15:13:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760102006; x=1791638006;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8QBIGsYeMgiMl/cEKv0nsftLs5botQOC11vDPshWAEs=;
 b=Kndgm8d/Bu3QkytUb+w0rEjJiH6rxlcWqXrToYr4I7QIBWifGlBurLb9
 FsfrH6LudfCIH1JggCTo9W/y1BKGj6Ij8ctQoxl8uJv9vNmNkXUkSqHCJ
 7JxcFJt5HfG5VfyVA22J3dp9tuuMjqdnGuA4//rW/IjRBFZGXVKxzIxz5
 JnVwKFbVyGS2FEDA9FyQxfvUgML9ocA10Mmw4A+jpzahDnRTte0khgrv+
 4DqTWG1hsluLDpVJKnnf+jGBNULktYkFZGRkvfqw4aeiM+S1qqnct+Jlb
 4NDPUn6E6vd9829CCuuAc5UqRN35UVxHGTL5kJ80cqSjUjSeRJfOJt3Fx Q==;
X-CSE-ConnectionGUID: p55Avde3R1mTzaxvvMNVXg==
X-CSE-MsgGUID: gBmVar3xTI6LU+YM7XOZqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11578"; a="62349157"
X-IronPort-AV: E=Sophos;i="6.19,219,1754982000"; d="scan'208";a="62349157"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2025 06:13:26 -0700
X-CSE-ConnectionGUID: zXIHR/qUS1qxkkn+UHImEQ==
X-CSE-MsgGUID: cV4vQMSWTaSQl/iCxF50Hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,219,1754982000"; d="scan'208";a="185005551"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 10 Oct 2025 06:13:25 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Junfeng Guo <junfengg@nvidia.com>, Ting Xu <ting.xu@intel.com>
Cc: vladimir.medvedkin@intel.com,
	stable@dpdk.org
Subject: [PATCH v3 2/2] net/ice: fix memory leak in raw pattern parse
Date: Fri, 10 Oct 2025 14:13:20 +0100
Message-ID: <90b43cc3ea3d614c7a8812e1a5ecb0d5fff3615e.1760101992.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2f0e588a6f838f4a641c1a23b22b9dfff6912264.1760101992.git.anatoly.burakov@intel.com>
References: 
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

Currently, when parsing rte_flow raw type items, we allocate some
internal structures, but if errors happen down the line we just quit and
never free the memory we just allocated. Fix this by adding an error
cleanup section.

Fixes: 848de9572c83 ("net/ice: fix raw flow input pattern parsing")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---

Notes:
    v3:
    - Removed unneeded NULL check
    - Fixed the Fixes: line
    
    v2:
    - Removed the filter profile allocation error handling as it's now directly
      embedded in the filter structure and not allocated dynamically.

 drivers/net/intel/ice/ice_fdir_filter.c | 28 ++++++++++++++++---------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/net/intel/ice/ice_fdir_filter.c b/drivers/net/intel/ice/ice_fdir_filter.c
index d593624792..9dfe5c02cb 100644
--- a/drivers/net/intel/ice/ice_fdir_filter.c
+++ b/drivers/net/intel/ice/ice_fdir_filter.c
@@ -1865,7 +1865,7 @@ ice_fdir_parse_pattern(__rte_unused struct ice_adapter *ad,
 			uint16_t tmp_val = 0;
 			uint16_t pkt_len = 0;
 			uint8_t tmp = 0;
-			int i, j;
+			int i, j, ret_val;
 
 			pkt_len = strlen((char *)(uintptr_t)raw_spec->pattern);
 			if (strlen((char *)(uintptr_t)raw_mask->pattern) !=
@@ -1920,19 +1920,22 @@ ice_fdir_parse_pattern(__rte_unused struct ice_adapter *ad,
 
 			pkt_len /= 2;
 
-			if (ice_parser_run(ad->psr, tmp_spec, pkt_len, &rslt))
-				return -rte_errno;
-
-			if (!tmp_mask)
-				return -rte_errno;
+			if (ice_parser_run(ad->psr, tmp_spec, pkt_len, &rslt)) {
+				ret_val = -rte_errno;
+				goto raw_error;
+			}
 
 			if (ice_parser_profile_init(&rslt, tmp_spec, tmp_mask,
-				pkt_len, ICE_BLK_FD, true, &filter->prof))
-				return -rte_errno;
+				pkt_len, ICE_BLK_FD, true, &filter->prof)) {
+				ret_val = -rte_errno;
+				goto raw_error;
+			}
 
 			u8 *pkt_buf = (u8 *)ice_malloc(&ad->hw, pkt_len + 1);
-			if (!pkt_buf)
-				return -ENOMEM;
+			if (!pkt_buf) {
+				ret_val = -ENOMEM;
+				goto raw_error;
+			}
 			rte_memcpy(pkt_buf, tmp_spec, pkt_len);
 			filter->pkt_buf = pkt_buf;
 
@@ -1943,6 +1946,11 @@ ice_fdir_parse_pattern(__rte_unused struct ice_adapter *ad,
 			rte_free(tmp_spec);
 			rte_free(tmp_mask);
 			break;
+
+raw_error:
+			rte_free(tmp_spec);
+			rte_free(tmp_mask);
+			return ret_val;
 		}
 
 		case RTE_FLOW_ITEM_TYPE_ETH:
-- 
2.47.3

