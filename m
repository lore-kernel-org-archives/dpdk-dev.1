Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAFE606A31F
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Nov 2026 13:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EbuetuO8
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D06564067B;
	Fri, 27 Nov 2026 14:14:30 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTPS id 697AD40653
 for <dev@dpdk.org>; Fri, 27 Nov 2026 14:14:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795785266; x=1827321266;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=cYs5Rwmwr1pqKPE+MT8+aI/8yDl3UJvKp5xkkhRhGCs=;
 b=EbuetuO8dI9FnAopJtB69E86loR1HWybDIbKima5qjKEYC2BC49p+6z5
 ot89lLxJm+T04FottcNB2RehooLc3wNpbj1iETz3NX2rr8Ba55Bbmh/QL
 LJ5lzP69g+Wmv6rqHsOJEe1FoSf1v38H5du41aHZrN2OLXoO8ppjITB8N
 zA/cpkURelK4xLRMg9DvSI1Gh+gEwfgFx8EfXeyeaM5ByWJuXmzz0fACM
 NxYgqTwSdS4CW+wD53copkMQNMhnLrvKry1qx85wc9pUjlAAZGt7JutWM
 cEF1KdbPxxexxvVn6rvExrhpdoeq4QYUdH8E6Lu3TP7tWc5XPb0CtNESx A==;
X-CSE-ConnectionGUID: ERCLC+ZyT2y+zH8IMOVYMQ==
X-CSE-MsgGUID: ld0fV+BgTRW/SeBb0SJMtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11979"; a="4787517"
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="4787517"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 05:14:25 -0800
X-CSE-ConnectionGUID: ece406N7Q2e4LGl3wpvQ2g==
X-CSE-MsgGUID: +UWATZHHT8ynfIj1+V0Fsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; d="scan'208";a="12655989"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa002.fm.intel.com with ESMTP; 27 Nov 2026 05:14:24 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v2 06/13] bus/fslmc: fix unchecked device setup for MC portal
Date: Fri, 27 Nov 2026 13:14:06 +0000
Message-ID: <8f55bc3a36f1c181f3bcca1265dd54ec2b8c8560.1795785194.git.anatoly.burakov@intel.com>
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

Currently, when we map the MC portal object, we call into VFIO device
setup to get a device fd, but we do not check whether that succeeded. If
device setup fails before a device fd was obtained (for example, when
the group fd cannot be found), the fd variable is left uninitialized, and
we go on to issue a region info ioctl on it and then close it.

Fix it by checking the return value and bailing out early.

Fixes: a69f79300262 ("bus/fslmc: support multi VFIO group")
Cc: hemant.agrawal@nxp.com
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/bus/fslmc/fslmc_vfio.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/fslmc/fslmc_vfio.c b/drivers/bus/fslmc/fslmc_vfio.c
index 5ffa869e6fc..e8c6948bebb 100644
--- a/drivers/bus/fslmc/fslmc_vfio.c
+++ b/drivers/bus/fslmc/fslmc_vfio.c
@@ -1322,7 +1322,9 @@ static intptr_t vfio_map_mcp_obj(const char *mcp_obj)
 	struct vfio_device_info d_info = { .argsz = sizeof(d_info) };
 	struct vfio_region_info reg_info = { .argsz = sizeof(reg_info) };
 
-	fslmc_vfio_setup_device(mcp_obj, &mc_fd, &d_info);
+	ret = fslmc_vfio_setup_device(mcp_obj, &mc_fd, &d_info);
+	if (ret != 0)
+		return v_addr;
 
 	/* getting device region info*/
 	ret = ioctl(mc_fd, VFIO_DEVICE_GET_REGION_INFO, &reg_info);
-- 
2.52.0

