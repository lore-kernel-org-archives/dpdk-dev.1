Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63750606A324
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Nov 2026 13:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=J200qyZU
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B46DA4069D;
	Fri, 27 Nov 2026 14:14:31 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTPS id 9CBDB40653
 for <dev@dpdk.org>; Fri, 27 Nov 2026 14:14:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795785267; x=1827321267;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=pliXdoZZysJaIkomDqHQS9XPx3cNOfTTG2OcAaMu2oI=;
 b=J200qyZUruEPJ0ru3sLT9poVQU+vzrE9MD+YNqRBVBu2jfT1HZTMGowE
 /Mf7d/M1hL/UZVZaBjaEirdlV3IsKLyNZx/VCvNTegX01roCn7lWpnCty
 hmqUW/uJjCpmpkKwRk0y8hcKKnrXaUFpFZITR8t7XmXz0MD4so0xfdXd/
 FNQaqsBjfnt+AZWQbeOTDVQkCSeU5CxldYXVAVc60ktcRawLNTfNBOXGa
 KiwmsMLefAPzBawKK52BFq1QdA2b2tSdcJMupJHu/hB44lqKo7goo26Jn
 p5opkFdIcLgi8MiJ0fVC7k7FCp8kwnvfAynX5VA9HOCQpcRiBjDNDEiI8 Q==;
X-CSE-ConnectionGUID: uRPCWUjhQ9WXt7iLxGNSqA==
X-CSE-MsgGUID: aK1MGYXdR/iERNc2NrXA+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11979"; a="4787521"
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="4787521"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 05:14:27 -0800
X-CSE-ConnectionGUID: aETsT/cMQWm8r0a2jg/t+A==
X-CSE-MsgGUID: c2hDpJxMSM6HGkQ3HZHD/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; d="scan'208";a="12655990"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa002.fm.intel.com with ESMTP; 27 Nov 2026 05:14:25 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>,
 David Marchand <david.marchand@redhat.com>
Subject: [PATCH v2 07/13] bus/fslmc: fix double close of MC portal device FD
Date: Fri, 27 Nov 2026 13:14:07 +0000
Message-ID: <dd9b3af15722aea20c3a85749583d1a4c9368d10.1795785194.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1795785194.git.anatoly.burakov@intel.com>
 <cover.1795785194.git.anatoly.burakov@intel.com>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Currently, when we map the MC portal object, the device fd we get from
VFIO device setup is also recorded in the device list of its group. Once
the region is mapped we no longer need the fd, so we close it directly,
but its entry stays in the list. Since group teardown now closes every
device fd it tracks, the stale entry causes the same fd number to be
closed a second time.

Fix it by removing the device from the group instead of closing the fd
directly, which both closes the fd and drops the tracking entry.

Fixes: ba19fbe3894e ("bus/fslmc: fix some VFIO device FD and memory leaks")
Cc: david.marchand@redhat.com
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/bus/fslmc/fslmc_vfio.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/fslmc/fslmc_vfio.c b/drivers/bus/fslmc/fslmc_vfio.c
index e8c6948bebb..5d20b92af15 100644
--- a/drivers/bus/fslmc/fslmc_vfio.c
+++ b/drivers/bus/fslmc/fslmc_vfio.c
@@ -1317,6 +1317,7 @@ static intptr_t vfio_map_mcp_obj(const char *mcp_obj)
 {
 	intptr_t v_addr = (intptr_t)MAP_FAILED;
 	int32_t ret, mc_fd;
+	int vfio_group_fd;
 	struct vfio_group_status status = { .argsz = sizeof(status) };
 
 	struct vfio_device_info d_info = { .argsz = sizeof(d_info) };
@@ -1338,7 +1339,10 @@ static intptr_t vfio_map_mcp_obj(const char *mcp_obj)
 		mc_fd, reg_info.offset);
 
 MC_FAILURE:
-	close(mc_fd);
+	/* the group tracks this fd, removing the device also closes it */
+	vfio_group_fd = fslmc_vfio_group_fd_by_name(fslmc_vfio_get_group_name());
+	if (fslmc_vfio_group_remove_dev(vfio_group_fd, mcp_obj) != 0)
+		DPAA2_BUS_ERR("Failed to remove %s from vfio", mcp_obj);
 
 	return v_addr;
 }
-- 
2.52.0

