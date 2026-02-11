Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE441E9E30C
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 13:56:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB5BD40E39;
	Wed, 11 Feb 2026 14:54:07 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 0312C40E0F
 for <dev@dpdk.org>; Wed, 11 Feb 2026 14:54:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770818044; x=1802354044;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=d0rISkCDYEWKKd5fs4fBhpJ94duUIKfis0doRJv9lbY=;
 b=SabBZeS2fcrFTjiS6ztEKu6ZYzmRfnhMPVh8bNqGAIq442r1y14SKnk8
 dSbZ5Gtrk+1aZinsUKmaj5UAP1KC14L4Cy4JMaMLi1PDirl72kdRPnVxA
 wZWTEfjTd0dXM1SnXo9N8mb3hA/dXM/QctDGHKN68oHO8UU/K2Hv1BVhN
 LNIzCn70tyzVMIgZ4KPwQU/T1zbxq8XTI6RSNzU2+r82QPSgT7VC6oz4v
 +eppwz5/TF3cLhc30MzlJHYApx4JTmgBXHN24pMC+lzb2MMketAdYVQdv
 Jb8mxQlkgbUsO2ed5wE4gzRp0pC78C322vE3WVECriHQ5jyLcPEXgEogU Q==;
X-CSE-ConnectionGUID: E4WUWRavSUaie114j71s6A==
X-CSE-MsgGUID: iRM4ciXzRGCevykJSewvSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="75808287"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="75808287"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 05:54:03 -0800
X-CSE-ConnectionGUID: 5WEh1mboRUiPt3mATOYLJg==
X-CSE-MsgGUID: WVgWWqOuSlmfylNi9c/8GA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="212359709"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa007.jf.intel.com with ESMTP; 11 Feb 2026 05:54:02 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 26/27] net/ice: avoid rte malloc in raw pattern parsing
Date: Wed, 11 Feb 2026 13:53:08 +0000
Message-ID: <308ead53d8b5faf116ef6c8dd1241be43ceee88d.1770817884.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770817884.git.anatoly.burakov@intel.com>
 <cover.1770817884.git.anatoly.burakov@intel.com>
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

Currently, when parsing raw flow patterns, we are using rte_zmalloc
followed by an immediate rte_free. This is not needed as this memory is
not being stored anywhere, so replace it with regular malloc/free.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ice/ice_fdir_filter.c | 14 +++++++-------
 drivers/net/intel/ice/ice_hash.c        | 10 +++++-----
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/intel/ice/ice_fdir_filter.c b/drivers/net/intel/ice/ice_fdir_filter.c
index 5abdcbac7f..3db13dba96 100644
--- a/drivers/net/intel/ice/ice_fdir_filter.c
+++ b/drivers/net/intel/ice/ice_fdir_filter.c
@@ -1879,13 +1879,13 @@ ice_fdir_parse_pattern(__rte_unused struct ice_adapter *ad,
 				pkt_len)
 				return -rte_errno;
 
-			tmp_spec = rte_zmalloc(NULL, pkt_len / 2, 0);
+			tmp_spec = calloc(1, pkt_len / 2);
 			if (!tmp_spec)
 				return -rte_errno;
 
-			tmp_mask = rte_zmalloc(NULL, pkt_len / 2, 0);
+			tmp_mask = calloc(1, pkt_len / 2);
 			if (!tmp_mask) {
-				rte_free(tmp_spec);
+				free(tmp_spec);
 				return -rte_errno;
 			}
 
@@ -1950,13 +1950,13 @@ ice_fdir_parse_pattern(__rte_unused struct ice_adapter *ad,
 
 			filter->parser_ena = true;
 
-			rte_free(tmp_spec);
-			rte_free(tmp_mask);
+			free(tmp_spec);
+			free(tmp_mask);
 			break;
 
 raw_error:
-			rte_free(tmp_spec);
-			rte_free(tmp_mask);
+			free(tmp_spec);
+			free(tmp_mask);
 			return ret_val;
 		}
 
diff --git a/drivers/net/intel/ice/ice_hash.c b/drivers/net/intel/ice/ice_hash.c
index afdc8f220a..854c6e8dca 100644
--- a/drivers/net/intel/ice/ice_hash.c
+++ b/drivers/net/intel/ice/ice_hash.c
@@ -676,13 +676,13 @@ ice_hash_parse_raw_pattern(struct ice_adapter *ad,
 
 	pkt_len = spec_len / 2;
 
-	pkt_buf = rte_zmalloc(NULL, pkt_len, 0);
+	pkt_buf = calloc(1, pkt_len);
 	if (!pkt_buf)
 		return -ENOMEM;
 
-	msk_buf = rte_zmalloc(NULL, pkt_len, 0);
+	msk_buf = calloc(1, pkt_len);
 	if (!msk_buf) {
-		rte_free(pkt_buf);
+		free(pkt_buf);
 		return -ENOMEM;
 	}
 
@@ -733,8 +733,8 @@ ice_hash_parse_raw_pattern(struct ice_adapter *ad,
 	rte_memcpy(&meta->raw.prof, &prof, sizeof(prof));
 
 free_mem:
-	rte_free(pkt_buf);
-	rte_free(msk_buf);
+	free(pkt_buf);
+	free(msk_buf);
 
 	return ret;
 }
-- 
2.47.3

