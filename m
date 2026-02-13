Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DC3EDF150
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 10:29:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0741D40DFB;
	Fri, 13 Feb 2026 11:27:31 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 4DB5C40A4B
 for <dev@dpdk.org>; Fri, 13 Feb 2026 11:27:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770978442; x=1802514442;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=C32s7O/O5cImIKFW0KC6b8yA1LZbvLX/YrK3Sx1zuuw=;
 b=KJw19u0GqK2xZgswIrGp0QOCDKqfUL2Us0OjmcVUPVj3R9o/9WnV+o/+
 v/B3fRjN7LYiaAbyOZZQ+FoDdTZFZbp9P5IyIa6T1O078yx2YEfakNB/W
 J1bPk4WYvHdl4tv5/s6sndJs/uxU+P6RzmxqTwNO/BvWD+M5skDNZKEqc
 s4WQZ3ToestYyAjxKgre0n5Bi16GEk1Ekm88BDptSX6vIcK3SlTN0PORs
 01Yk4ugS7yoasTPhQQybryLTbG2cFNSJeP9kxFYofSk+nZaY2nsloX+Ze
 0/Pf8rdS5fAucBWv5Lud2dYsUZlOpDIDjpnasSO5IOl8lBXs8/TCb97zE w==;
X-CSE-ConnectionGUID: rijHTTBxRNyws8lhogYZ5A==
X-CSE-MsgGUID: FOkm1NFbRSCvjNZ8uRP8hQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="83603120"
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="83603120"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 02:27:22 -0800
X-CSE-ConnectionGUID: UxgbmS6dToGbib3X50fiJA==
X-CSE-MsgGUID: Y/W/44k2SLWJdcbsEHnAtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="217028155"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 13 Feb 2026 02:27:22 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 26/27] net/ice: avoid rte malloc in raw pattern parsing
Date: Fri, 13 Feb 2026 10:26:37 +0000
Message-ID: <57ad21a01563d1de714879d25f48dc89f7dc1273.1770978324.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770978324.git.anatoly.burakov@intel.com>
 <cover.1770978324.git.anatoly.burakov@intel.com>
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
index da22b65a77..5f44b5c818 100644
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

