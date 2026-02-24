Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACE7E9B258
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Feb 2026 12:26:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D67140BA5;
	Tue, 24 Feb 2026 13:24:35 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id AC34D40650
 for <dev@dpdk.org>; Tue, 24 Feb 2026 13:24:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771935847; x=1803471847;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=2KksfkHA0DAXWnCDn1IXuN1q10KfWVpaO50I+sOtnjc=;
 b=fkiFvjb207801bqE3Qf6xNw6eIvAhveMW+8Izk/QnzfRqKApVSwJv9AV
 ilHnNOXPEycEilki2xXRroZ0X9Bw7BOfjbOpQRxOeW6EyfpSxjibDApDh
 lOeuNaNVDnJoWfIbR37GP/IuqzvS06IXrjpWsUX7XEt59knfC1hFOxJS9
 XkwucyTR/wD89xeKMALX99fDdueJqIWMlxfI9zUcsXz7yZ/nniiRhBLNQ
 mv7DeFY3tREK+sWNnLYaKH1afTt15coF/nUJGCE1J7pnAucMcJWwRP5Ue
 HM1nJoK9bryrbRwYsf3ex46VXL7Pg3WLtoN8kvyR6RVXpyBAn3awq+BAU w==;
X-CSE-ConnectionGUID: Dq4edGspRpi6O5CrQfY9fA==
X-CSE-MsgGUID: s0vPwARQSVCjinWESxWb0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="72158148"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; d="scan'208";a="72158148"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2026 04:24:07 -0800
X-CSE-ConnectionGUID: Oc8/ZOmMS+qZQgehg7W2AA==
X-CSE-MsgGUID: 4IhbE/r2RYifAF92nQNKSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; d="scan'208";a="243854495"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa001.fm.intel.com with ESMTP; 24 Feb 2026 04:24:06 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v8 25/26] net/ice: avoid rte malloc in raw pattern parsing
Date: Tue, 24 Feb 2026 12:23:34 +0000
Message-ID: <4a01a5b9f486410dff6d1c605e28a2b2cd557bac.1771935744.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1771935744.git.anatoly.burakov@intel.com>
 <cover.1771935744.git.anatoly.burakov@intel.com>
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
followed by an immediate rte_free. This memory does not need to be stored
in hugepage memory, so replace it with regular malloc/free.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/ice/ice_fdir_filter.c | 14 +++++++-------
 drivers/net/intel/ice/ice_hash.c        | 10 +++++-----
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/intel/ice/ice_fdir_filter.c b/drivers/net/intel/ice/ice_fdir_filter.c
index 1279823b12..0b92b9ab38 100644
--- a/drivers/net/intel/ice/ice_fdir_filter.c
+++ b/drivers/net/intel/ice/ice_fdir_filter.c
@@ -1970,13 +1970,13 @@ ice_fdir_parse_pattern(__rte_unused struct ice_adapter *ad,
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
 
@@ -2041,13 +2041,13 @@ ice_fdir_parse_pattern(__rte_unused struct ice_adapter *ad,
 
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
index b20103a452..f9db530504 100644
--- a/drivers/net/intel/ice/ice_hash.c
+++ b/drivers/net/intel/ice/ice_hash.c
@@ -696,13 +696,13 @@ ice_hash_parse_raw_pattern(struct ice_adapter *ad,
 
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
 
@@ -753,8 +753,8 @@ ice_hash_parse_raw_pattern(struct ice_adapter *ad,
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

