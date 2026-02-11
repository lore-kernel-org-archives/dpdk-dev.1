Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18297E9E30B
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 13:50:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 59C30406B6;
	Wed, 11 Feb 2026 14:49:50 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 6EB3240613
 for <dev@dpdk.org>; Wed, 11 Feb 2026 14:49:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770817783; x=1802353783;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=e3MYBB209ngSa+pjG5v+yTdxRrAkaGP1V+br9e5Qj3A=;
 b=QVKRlmblbawiiJfMLizC7TvdzZX5QL0o78zxf+BaVbfMmNufS7d8h5ux
 vqC+C/g4ZmUiepokRoSHt0zu05VehfZSaJ5VqfhiTgFADzll/jzNCeTQw
 zazr2AWWf8Rk6NBxeCS+s+FmSNImsphfE9DNrxD6nidSM0SxiYjzFGeps
 ubTVK3fS7cA3OBpwfFb56v4PZRfolJUz4OPrCwmTPjEOtabI39t84xSnu
 UVZ9M69I4k8nhvYlERB3ZyCtEQfSFOK1JKdBWBpdCEtds8x0AZQWxJG87
 Zlt1RlaTbxA5o5EmXLUXiFzXLrYzU3MpgHlDud4Yp+HPMksBDo7Gy0o8Z g==;
X-CSE-ConnectionGUID: l/DuQ6dmSqS0aVFubFLySg==
X-CSE-MsgGUID: fO7QqoeDR9efetVxlPhZ+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="83332532"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="83332532"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 05:49:43 -0800
X-CSE-ConnectionGUID: FHRiGMnsQfuyQnbVx5928g==
X-CSE-MsgGUID: vSaC53dORoCbDXZcIE4xOQ==
X-ExtLoop1: 1
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa003.fm.intel.com with ESMTP; 11 Feb 2026 05:49:42 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Junfeng Guo <junfengg@nvidia.com>, Qi Zhang <qi.z.zhang@intel.com>
Subject: [PATCH v4 9/9] net/ice: fix memory leak in FDIR flow parsing
Date: Wed, 11 Feb 2026 13:49:16 +0000
Message-ID: <cefd2925e79387e684ddf08eb154f2fd7ad39b5b.1770817694.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770817694.git.anatoly.burakov@intel.com>
 <cover.1770817694.git.anatoly.burakov@intel.com>
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

