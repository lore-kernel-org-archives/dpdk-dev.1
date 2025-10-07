Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD433CCA470
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Oct 2025 12:42:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C18AA40661;
	Tue,  7 Oct 2025 14:42:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 27D5F4013F;
 Tue,  7 Oct 2025 14:42:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759840938; x=1791376938;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QWW5z/NEOoq7Z36DrhpDAUJkSqdqz8XRNBSLnGN6HwI=;
 b=NO688MMctV8cTYUfKCb5daoq3uBDBZYaNBW8JIdCXwlAmUVXW7jm99gT
 QtCh/wg8jbIrg8NWeoaBCNiTu8LlG4KRLxgAbjj8wyubAhv83VQJA9S7C
 jRBPdYGIjZlLhPmo7pTEejy6bUOp/oqjNIm1ehM1ZKxzuRzYwAGIPduZt
 8jZBhbCESsitsnHJLrTdBPxpZqBUNLpeSqHHlYZ6SWnmmMEBnDzC06usM
 xR/gpNlnpZkK4HCB0/bCUIFqfrP4GOX8izoEt5DP5mKS2dMTYEOTazLT3
 shWT9Xjkrq4PqXb8nJCDSjIhuhzJ55CUlOCw+nyKBTT0Cja49/DuwDT/4 A==;
X-CSE-ConnectionGUID: WzFa/4+BQ9mCtCKtG4yP/w==
X-CSE-MsgGUID: ZE1ceW3YTp+hAOrDRVtsUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11575"; a="62053789"
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; d="scan'208";a="62053789"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2025 05:42:17 -0700
X-CSE-ConnectionGUID: itXodeFTTs6pqh6l1gs4Mg==
X-CSE-MsgGUID: rIEYt9LiSDmz2doSNzFC7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; d="scan'208";a="185433542"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa004.fm.intel.com with ESMTP; 07 Oct 2025 05:42:15 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Qi Zhang <qi.z.zhang@intel.com>, Junfeng Guo <junfengg@nvidia.com>
Cc: vladimir.medvedkin@intel.com,
	stable@dpdk.org
Subject: [PATCH v2 2/2] net/ice: fix memory leak in raw pattern parse
Date: Tue,  7 Oct 2025 13:42:12 +0100
Message-ID: <200ebf9129483347f6263f130e167ff7fa42e7c3.1759840924.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <ba0c86578b7c8101825fcd42d737670c3525ae59.1759840924.git.anatoly.burakov@intel.com>
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

Currently, when parsing rte_flow raw type items, we allocate a bunch of
internal structures, but if errors happen down the line we just quit and
never free the memory we just allocated. Fix this by adding an error
cleanup section.

Fixes: 25be39cc1760 ("net/ice: enable protocol agnostic flow offloading in FDIR")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---

Notes:
    v2:
    - Removed the filter profile allocation error
      handling as it's now directly embedded in the
      filter structure and not allocated dynamically.

 drivers/net/intel/ice/ice_fdir_filter.c | 31 ++++++++++++++++++-------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/net/intel/ice/ice_fdir_filter.c b/drivers/net/intel/ice/ice_fdir_filter.c
index d593624792..3090a5d13c 100644
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
@@ -1920,19 +1920,27 @@ ice_fdir_parse_pattern(__rte_unused struct ice_adapter *ad,
 
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
 
@@ -1943,6 +1951,11 @@ ice_fdir_parse_pattern(__rte_unused struct ice_adapter *ad,
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

