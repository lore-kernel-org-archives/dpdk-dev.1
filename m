Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5237EDF023
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 09:11:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ABD8340666;
	Fri, 13 Feb 2026 10:10:43 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id A412340689
 for <dev@dpdk.org>; Fri, 13 Feb 2026 10:10:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770973841; x=1802509841;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=HOicDmIeZdCch+ekc2J9DqJX8gLJTfCaRmIK6YsdF2U=;
 b=EsaWE2VzNmodoxuHACxD0qFder3usryNHhhufjgqtOeGkrsNvrOutIRu
 37eXvw6ZnP0SITn5P6D8XRI5a1+vJO2mKku6FdkQoIyeolgpNxOPgGwYk
 1HXyBnEYc3a7I+VmgYhKQKz/mI/1uzx7e6KttB0g/mOdrk2AcsbmlBB+u
 JRXk2vhfAnMjBgVJEypt1Brvjfkicpu/Czbq9aLPxRIOmWaR7H5dbC0q6
 fC1z6TUkRKgD4PKKr18LKGv5udrgZ7ce1iJesHKeNAUVHg0ERUvAy10Qm
 HjHpYWIlefhxNT25ryomfxbU7FvMYlXLBYZ57MOCKdbDD83sj4ovx4TSH A==;
X-CSE-ConnectionGUID: A/VCuiYeQHOrMMrZEZQE3Q==
X-CSE-MsgGUID: Z7OP3s2dRtyHAYw+rVA2Dw==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="89567899"
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="89567899"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 01:10:40 -0800
X-CSE-ConnectionGUID: 6/Mx1O/NTPeLab2M61D34g==
X-CSE-MsgGUID: SsOMh1uhT4WU9srvrVYYHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="211966109"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa006.jf.intel.com with ESMTP; 13 Feb 2026 01:10:39 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Junfeng Guo <junfengg@nvidia.com>, Qi Zhang <qi.z.zhang@intel.com>
Subject: [PATCH v6 12/12] net/ice: fix memory leak in FDIR flow parsing
Date: Fri, 13 Feb 2026 09:10:14 +0000
Message-ID: <14bb803f9e3f9cc1a18fb3a52d32e4d52ebce61f.1770973745.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770973745.git.anatoly.burakov@intel.com>
 <cover.1770973745.git.anatoly.burakov@intel.com>
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

Additionally, the initial allocation was done using `ice_malloc` macro. It
does not affect anything as `ice_malloc` translates to `rte_zmalloc` anyway
but for consistency, change the allocation to `rte_zmalloc` as well.

Fixes: 25be39cc1760 ("net/ice: enable protocol agnostic flow offloading in FDIR")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 drivers/net/intel/ice/ice_fdir_filter.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/ice/ice_fdir_filter.c b/drivers/net/intel/ice/ice_fdir_filter.c
index f7730ec6ab..da22b65a77 100644
--- a/drivers/net/intel/ice/ice_fdir_filter.c
+++ b/drivers/net/intel/ice/ice_fdir_filter.c
@@ -1938,7 +1938,7 @@ ice_fdir_parse_pattern(__rte_unused struct ice_adapter *ad,
 				goto raw_error;
 			}
 
-			u8 *pkt_buf = (u8 *)ice_malloc(&ad->hw, pkt_len + 1);
+			u8 *pkt_buf = (u8 *)rte_zmalloc("raw pkt buf", pkt_len + 1, 0);
 			if (!pkt_buf) {
 				ret_val = -ENOMEM;
 				goto raw_error;
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

