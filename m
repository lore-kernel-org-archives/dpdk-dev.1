Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AAA606A320
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 09:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ElOxVdvM
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D9B7A40687;
	Tue, 27 Oct 2026 10:50:42 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTPS id D368840608
 for <dev@dpdk.org>; Tue, 27 Oct 2026 10:50:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793094639; x=1824630639;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=tOavQAajWYpqMHyQmGiyirZKPh1OZiq9ZTHqAaQU6/A=;
 b=ElOxVdvMh6dvisdUby4iPE2ZyZFMedyPgm/3KpF7UT6DwoYHB4N6UCA5
 /vwRCV0oWnGzNl+251Ogh9pV9IdOUKksNaQ4lzz5I/EbNOcZBnCj3wzC2
 D6C0fFgwbE2O7p5lCLcBRwghkkJ+DN85+evBHE1HxYs2+pmrGwHEIUhub
 /1d/Xj6vOiPG6vhzev/hBs2g4l3rHx8uyhl+a+4eQBXGkfaBMO5EGwm9b
 dC6B+AEbDLI4ilmCY6/dZjJSmA46jNuvuSb6BkRv0AAeiFZEzBdsKJI14
 VIPu347ZmUcT3XyRSiRETb9bOTAgu1arFyCkdfyiZNYMsjZVOy8iwM2Bk g==;
X-CSE-ConnectionGUID: rKmUYI6EQTip0zstheVT4w==
X-CSE-MsgGUID: s5NTS70qS+usohI3K5BDow==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1674922"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1674922"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 02:50:35 -0700
X-CSE-ConnectionGUID: VdUDGu/aQOSo2XasLVZYTw==
X-CSE-MsgGUID: fT3iBBsFRLySBnGulwnzgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="6250976"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa012.fm.intel.com with ESMTP; 27 Oct 2026 02:50:19 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Ori Kam <orika@nvidia.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Andrey Vesnovaty <andreyv@nvidia.com>, Ray Kinsella <mdr@ashroe.eu>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Jiawei Wang <jiaweiw@nvidia.com>, Haifei Luo <haifeil@nvidia.com>,
 Rakesh Kudurumalla <rkudurumalla@marvell.com>,
 Jerin Jacob <jerinj@marvell.com>
Subject: [PATCH v4 3/6] ethdev: fix missing flow action descriptors
Date: Tue, 27 Oct 2026 09:50:10 +0000
Message-ID: <0830b411294b86d984626eb4b974a2fcb5a1d4be.1793094529.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <5698ccb3daeebd1d50346d5a3bd8471468056463.1793094528.git.anatoly.burakov@intel.com>
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

Add the missing descriptor entries. Preserve the deprecated SHARED
action handle directly, as for INDIRECT, instead of treating it as
configuration data to copy into the destination buffer.

Fixes: 4d9fd85fb545 ("ethdev: add shared actions to flow API")
Fixes: 5f0d54f372f0 ("ethdev: add pre-defined meter policy API")
Fixes: 6807e8b52a18 ("ethdev: skip congestion management configuration")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 lib/ethdev/rte_flow.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/ethdev/rte_flow.c b/lib/ethdev/rte_flow.c
index 6e544f4bc91..e29bcefab0e 100644
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
@@ -1043,7 +1047,8 @@ rte_flow_conv_actions(struct rte_flow_action *dst,
 	num = i;
 	src -= num;
 	for (i = 0; i != num; ++i, ++src) {
-		if (src->type == RTE_FLOW_ACTION_TYPE_INDIRECT) {
+		if (src->type == RTE_FLOW_ACTION_TYPE_INDIRECT ||
+		    src->type == RTE_FLOW_ACTION_TYPE_SHARED) {
 			/*
 			 * Indirect action conf fills the indirect action
 			 * handler. Copy the action handle directly instead
-- 
2.52.0

