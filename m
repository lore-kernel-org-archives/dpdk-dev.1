Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9994C606A327
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 16:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MrlgyG0W
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8350740656;
	Thu, 26 Nov 2026 17:03:29 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTPS id 2B621402C9
 for <dev@dpdk.org>; Thu, 26 Nov 2026 17:03:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795709006; x=1827245006;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=cYs5Rwmwr1pqKPE+MT8+aI/8yDl3UJvKp5xkkhRhGCs=;
 b=MrlgyG0WY0EsevQKjiPUf+wDrHwCWmawoV5xv+SYiJNVQDZciPByKj8G
 4KAWAaOkuls3hldiWyh5vRthJTn00vHHPPOr/dloNb5U6ydGif4DAtlmS
 fjltXwhh2diZpO3MGXNpttp7f+z8rBB2eAxzGx5IYRQbTeat2Zc/EA3jo
 DAylVaWEYwwGLybGkD7DoLYmHkUCkzfOpI80Ng3IeHOXblg2yueciUFjy
 tAPZVDOkiiBw83bjBNxhw+bLVb/q4NlE405xdBnSODwHIflDrHyjosNeD
 j+XkGg3XSFIgNtBBm5iPo2uzzhgUz7t5Sk/IcQBb9CsQQaxKtG0D2u2ZY g==;
X-CSE-ConnectionGUID: yUtsrRIaSmeFp24w9wUgCQ==
X-CSE-MsgGUID: PiDM6BHuS6ed6As9LpUgIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4519733"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4519733"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 08:03:25 -0800
X-CSE-ConnectionGUID: 3cbVX5PqRn+HNsZtPkYtmw==
X-CSE-MsgGUID: ujlBUT6jQf2VXc5HqCbIUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; d="scan'208";a="12236605"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa002.jf.intel.com with ESMTP; 26 Nov 2026 08:03:25 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v1 03/11] bus/fslmc: fix unchecked device setup for MC portal
Date: Thu, 26 Nov 2026 16:03:09 +0000
Message-ID: <d8d3267392292556ed079b993c5dd81496c83274.1795708917.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1795708917.git.anatoly.burakov@intel.com>
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

