Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EFB606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Oct 2026 09:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FouWnNR8
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB19240299;
	Fri, 30 Oct 2026 10:40:49 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTPS id F21264027B
 for <dev@dpdk.org>; Fri, 30 Oct 2026 10:40:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793353248; x=1824889248;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=YUHoVISXDNesyq84KVySUxHl2c+MW+jg/cNIaoEhmnk=;
 b=FouWnNR8JlwRrLUvnYQ+O3ge5r+q9nMAwS0aY5KQTGY/61EakBvSdZ4x
 1vh2cZF3W7119F0Y1AbWnmIu3TZK04bwxWcn8BKkSmodGkpLosJDq83D6
 ooowA91jKYs7UvwmKVNCxrEqAPxUmlRBSeE3TYQVw4OGKBqL7qpwa/aq+
 mCtx3AQuOYOCkNVni9X+3OgBYm8/Shg6ZFbaiOTEtyHw5lZR1uODAH7Zi
 bDMmhZ3OjgWwCZCx8aLXPwa5aACHGpIYxdiBJxGDggYOVYrqknnBDkY7h
 AJIB52fGh/BXYWp6JcG+Qz10jN0+IV9gb5vCelH0ywNxis/mx+2bueoCD w==;
X-CSE-ConnectionGUID: NCtOMwrqSZOXM0xsteMVYw==
X-CSE-MsgGUID: yuv2OeEqR2aqIuzP4rdwtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2126035"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2126035"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 02:40:46 -0700
X-CSE-ConnectionGUID: cak79FA0TQWdIUENheR82g==
X-CSE-MsgGUID: N6hkAmj/QNGG39PpcbBs4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5299607"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 30 Oct 2026 02:40:47 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 1/9] net/i40e: skip FDIR flow engine when FDIR is
 unavailable
Date: Fri, 30 Oct 2026 09:40:14 +0000
Message-ID: <5e64cc416c8ab3b038eee6bb55836e0b8ed507ab.1793353214.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The FDIR flow engine was initialized even when flow director was not
usable. With no FDIR filter space, engine init failed and logged an
error. When FDIR was disabled because its queue could not be allocated,
the engine was initialized and FDIR flows only failed at install.

Return -ENOTSUP in both cases so that the engine is skipped.

Fixes: 05432a6e4676 ("net/i40e: reimplement FDIR parser")

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/i40e/i40e_flow_fdir.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/intel/i40e/i40e_flow_fdir.c b/drivers/net/intel/i40e/i40e_flow_fdir.c
index 55997295edb..197b93f3746 100644
--- a/drivers/net/intel/i40e/i40e_flow_fdir.c
+++ b/drivers/net/intel/i40e/i40e_flow_fdir.c
@@ -2010,6 +2010,9 @@ i40e_fdir_flow_engine_init(const struct ci_flow_engine *engine,
 	uint32_t i;
 	int ret;
 
+	if ((pf->flags & I40E_FLAG_FDIR) == 0 || fdir_info->fdir_space_size == 0)
+		return -ENOTSUP;
+
 	snprintf(fdir_hash_name, sizeof(fdir_hash_name), "fdir_%s", dev_data->name);
 
 	struct rte_hash_parameters fdir_hash_params = {
-- 
2.52.0

