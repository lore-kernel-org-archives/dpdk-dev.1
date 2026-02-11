Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2407BE9E301
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 13:04:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1D9DE40676;
	Wed, 11 Feb 2026 14:04:22 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id BB10A40677
 for <dev@dpdk.org>; Wed, 11 Feb 2026 14:04:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770815059; x=1802351059;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=e3MYBB209ngSa+pjG5v+yTdxRrAkaGP1V+br9e5Qj3A=;
 b=M/7VF2u4Mva04+wAxpcv8PGaslQVe5nKuShbbYf0q2aKuLbWAyZn0Inh
 CMVZXlWYpVVfRUAKSAMeNBdUZxIhX1nEmMzeLUURJdxWRpdbTv5vhLyHd
 36Az6RL94lQsEbMKWunyCMiIenkrgzK/UMpSUb/eqyU7yMd3HP0w6YJVr
 ctZz+No9wwTLg8yS9T6lo4jHsCKcXNia/44eQ3R4eJiGRLowXxe120hdh
 kWUZYs1Y5RJkgcAvVuul55ZjJg6ycyNScu0khPJWieT8/3q9A1p/CWjAm
 F7/fW+m1J2Qn02/S1smWYqlUvHjjTYKo+v+YuRp4BvKsm1XSt62ck6O5k Q==;
X-CSE-ConnectionGUID: urttXXSJTNmwG16AZj4meQ==
X-CSE-MsgGUID: U5IZnJ/HQJGZB/e/y5yN9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="59529085"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="59529085"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 05:04:18 -0800
X-CSE-ConnectionGUID: vaIFSBo2Q86Dxiv8H1FUFw==
X-CSE-MsgGUID: sIltvNEaToant/NVRoXT8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="217206452"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa005.jf.intel.com with ESMTP; 11 Feb 2026 05:04:17 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Qi Zhang <qi.z.zhang@intel.com>, Junfeng Guo <junfengg@nvidia.com>
Subject: [PATCH v3 8/8] net/ice: fix memory leak in FDIR flow parsing
Date: Wed, 11 Feb 2026 13:03:53 +0000
Message-ID: <72f60ba0d0583afb545d5feff07915e557dc7b82.1770814868.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770814868.git.anatoly.burakov@intel.com>
 <cover.1770814868.git.anatoly.burakov@intel.com>
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

Currently, RAW pattern parsing will cause a `pkt_buf` buffer to be
allocated to store parsed RAW pattern bytes. All error paths handle the
deallocation correctly, and the buffer will then be passed to FDIR filter
create function which also handles the presence of the buffer correctly,
and it is also freed correctly in destroy function.

However, rte_flow_validate will go through the same code path, but will not
call FDIR create/destroy nor even store the pointer, because `meta`
variable inside the flow parsing function will be set to NULL, which will
cause this memory to be leaked (and memset(0)-ed next time we try to
create/validate another flow).

Fix it by freeing the `pkt_buf` when `meta` is NULL.

Fixes: 25be39cc1760 ("net/ice: enable protocol agnostic flow offloading in FDIR")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ice/ice_fdir_filter.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/ice/ice_fdir_filter.c b/drivers/net/intel/ice/ice_fdir_filter.c
index f7730ec6ab..5abdcbac7f 100644
--- a/drivers/net/intel/ice/ice_fdir_filter.c
+++ b/drivers/net/intel/ice/ice_fdir_filter.c
@@ -2497,8 +2497,12 @@ ice_fdir_parse(struct ice_adapter *ad,
 	if (ret)
 		goto error;
 
-	if (meta)
+	/* if meta is NULL we're validating so the flow won't be stored */
+	if (meta) {
 		*meta = filter;
+	} else if (filter->pkt_buf != NULL) {
+		rte_free(filter->pkt_buf);
+	}
 
 	rte_free(item);
 	return ret;
-- 
2.47.3

