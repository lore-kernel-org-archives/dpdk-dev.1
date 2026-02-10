Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292D8EA3F22
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 16:17:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C0AC40E4D;
	Tue, 10 Feb 2026 17:14:42 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id CC87940E68
 for <dev@dpdk.org>; Tue, 10 Feb 2026 17:14:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770740079; x=1802276079;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Wm7KUMRCJ9cMp0ikFdWinyh8HTIhGT7+QhWCzQ1+ys0=;
 b=fsL/IU+bEM/NuByuv9ohIIbq2ejwj0sGtO9EbTjGrr0Ga7IA2WFykSQp
 MSMT8RI6QQqbXd/Vcz4kiD0LN9PlZ+GdOWLFd0J08lz46JJlcSY1qsi8v
 SqYeKJlflaecVXBskVi53ZipUFJzlJhhLA4RXiF6WaUio55hYPceu8Svs
 csCb68RAysTWR1RVF+z/g2y3AZy5SSCMmSPvnmWnauC7aLanM7Dch10LG
 5DvUq008cZIMBOTahJ9iVNA7OL/Q9wTzdXLEvhZhoyNny2emuXFGJGoMy
 GhtLf4lM29yrWrvCgnouUJ2g0LkdAComwgX1AMknUidDGsp9C5ytN1K1L Q==;
X-CSE-ConnectionGUID: roVAKNUrSw+KSSJLP/RE3Q==
X-CSE-MsgGUID: CbsClKG3Qqi6RXNoXEtNyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="89286319"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="89286319"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 08:14:39 -0800
X-CSE-ConnectionGUID: IDhPKNXESoGq6JbiHRMucQ==
X-CSE-MsgGUID: 1YCWUKT1QxmWMdX/LGSQ1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="216127867"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 10 Feb 2026 08:14:38 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 26/26] net/ice: avoid rte malloc in raw pattern parsing
Date: Tue, 10 Feb 2026 16:13:55 +0000
Message-ID: <4ed3fba3f33e966787ea3d19fcfaeaec3cd1ca7a.1770739925.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770739924.git.anatoly.burakov@intel.com>
 <cover.1770739924.git.anatoly.burakov@intel.com>
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
index f7730ec6ab..fcb613590e 100644
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

