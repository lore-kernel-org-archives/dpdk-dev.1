Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FC0606A31A
	for <dpdk-dev@archiver.kernel.org>; Sat, 24 Oct 2026 12:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XdGkpHNo
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 694BF402DF;
	Sat, 24 Oct 2026 14:04:24 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 9FF12402B2
 for <dev@dpdk.org>; Sat, 24 Oct 2026 14:04:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792843463; x=1824379463;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=gaN8YLhkTlnR67zxHyGKBVBnHBSCKlFugBtjakFQHnw=;
 b=XdGkpHNoEtRpFaabLfAITjOyxifj4z/ZnwBjj0Zp2isPY/ijTWbSTawn
 +nEorS7kqSChb6tA2Hj1KdCxbSJSVqTzgT35bnI1yFlzZHvv8TsuCnHFo
 R2yS4tVdaHxHUp76A6tSVN+Z8B1V1mbpgPo/nCKJbS0QjS/o0hwPSNwob
 t4DKSHzOt5E12DD6roF14A8d8tasiHFn7PYlNjXTMT7v50uBK+IYg+lJL
 tBIyuzGGzRupxhOrbUO7hWXmvded4VQbwqvhQOqVlcTZrzW1X1pwMi0Si
 m9HE6iNW9o7pCl8tv/eyVAaaJkpvxIEkEq1FqiyDtvxfzG35zwzPgYigU Q==;
X-CSE-ConnectionGUID: j7REeVJIR2uLZYUjpxBFFQ==
X-CSE-MsgGUID: T/ckXwAcT+WXsKQ7rLiPeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11944"; a="1569161"
X-IronPort-AV: E=Sophos;i="6.27,176,1787036400"; 
   d="scan'208";a="1569161"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2026 05:04:22 -0700
X-CSE-ConnectionGUID: Ub/oMrHcTJqOSEZKR62/fw==
X-CSE-MsgGUID: tD4M9xbXRcKlqUzNclPtpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,176,1787036400"; 
   d="scan'208";a="4203824"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa008.fm.intel.com with ESMTP; 24 Oct 2026 05:04:20 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Ori Kam <orika@nvidia.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Andrey Vesnovaty <andreyv@nvidia.com>, Ray Kinsella <mdr@ashroe.eu>,
 Matan Azrad <matan@nvidia.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Haifei Luo <haifeil@nvidia.com>,
 Rakesh Kudurumalla <rkudurumalla@marvell.com>,
 Jerin Jacob <jerinj@marvell.com>
Subject: [PATCH v2 2/4] ethdev: fix missing flow action descriptors
Date: Sat, 24 Oct 2026 13:04:08 +0100
Message-ID: <dab5d3cd50a48be6f355a8c97dd4709333ac3ad6.1792843432.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <8ccaee11fc265b812abd75ef7defdfdd47e65c3d.1792843432.git.anatoly.burakov@intel.com>
References: 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

RTE_FLOW_ACTION_TYPE_SHARED, RTE_FLOW_ACTION_TYPE_METER_COLOR and
RTE_FLOW_ACTION_TYPE_SKIP_CMAN were never added to
rte_flow_desc_action[]. The table uses designated initializers, so
these slots are zero filled: their name is NULL and their size is
zero.

As a result, RTE_FLOW_CONV_OP_ACTION_NAME on any of them passes a
NULL source to strlcpy(), and rte_flow_copy() as well as the action
conversion operations reject any action list containing one of them
as an unknown action type.

Add the missing descriptor entries.

Fixes: 4d9fd85fb545 ("ethdev: add shared actions to flow API")
Fixes: 5f0d54f372f0 ("ethdev: add pre-defined meter policy API")
Fixes: 6807e8b52a18 ("ethdev: skip congestion management configuration")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 lib/ethdev/rte_flow.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/ethdev/rte_flow.c b/lib/ethdev/rte_flow.c
index eeab79aa5d9..8a4833695c0 100644
--- a/lib/ethdev/rte_flow.c
+++ b/lib/ethdev/rte_flow.c
@@ -324,6 +324,8 @@ static const struct rte_flow_desc_data rte_flow_desc_action[] = {
 	MK_FLOW_ACTION(SET_IPV6_DSCP, sizeof(struct rte_flow_action_set_dscp)),
 	MK_FLOW_ACTION(AGE, sizeof(struct rte_flow_action_age)),
 	MK_FLOW_ACTION(SAMPLE, sizeof(struct rte_flow_action_sample)),
+	/* Deprecated; handle stored in conf as for INDIRECT. */
+	MK_FLOW_ACTION(SHARED, 0),
 	MK_FLOW_ACTION(MODIFY_FIELD,
 		       sizeof(struct rte_flow_action_modify_field)),
 	/**
@@ -334,11 +336,13 @@ static const struct rte_flow_desc_data rte_flow_desc_action[] = {
 	 */
 	MK_FLOW_ACTION(INDIRECT, 0),
 	MK_FLOW_ACTION(CONNTRACK, sizeof(struct rte_flow_action_conntrack)),
+	MK_FLOW_ACTION(METER_COLOR, sizeof(struct rte_flow_action_meter_color)),
 	MK_FLOW_ACTION(PORT_REPRESENTOR, sizeof(struct rte_flow_action_ethdev)),
 	MK_FLOW_ACTION(REPRESENTED_PORT, sizeof(struct rte_flow_action_ethdev)),
 	MK_FLOW_ACTION(METER_MARK, sizeof(struct rte_flow_action_meter_mark)),
 	MK_FLOW_ACTION(SEND_TO_KERNEL, 0),
 	MK_FLOW_ACTION(QUOTA, sizeof(struct rte_flow_action_quota)),
+	MK_FLOW_ACTION(SKIP_CMAN, 0),
 	MK_FLOW_ACTION(IPV6_EXT_PUSH, sizeof(struct rte_flow_action_ipv6_ext_push)),
 	MK_FLOW_ACTION(IPV6_EXT_REMOVE, sizeof(struct rte_flow_action_ipv6_ext_remove)),
 	MK_FLOW_ACTION(INDIRECT_LIST,
-- 
2.52.0

