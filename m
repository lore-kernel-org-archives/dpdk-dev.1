Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C5E606A31C
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 16:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lu5xBgYT
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DE48B4067C;
	Thu, 26 Nov 2026 17:03:32 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTPS id 2CC8D40663
 for <dev@dpdk.org>; Thu, 26 Nov 2026 17:03:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795709010; x=1827245010;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=PtX9w+IJsTm9OJD+qW9Be4YgKTG0mid0Cn31iIUuGko=;
 b=lu5xBgYTy1LjY8UrBDPlYcWaSaEs+zqqydycVrLkqqFrCHOaL7kmP+U1
 Lv0KsNlzydqvA5NVX/6u46zFFsF5CYGTECHWxZBV4b7UtBRusZstMwO3g
 bPMvf2j9JXaC7gQght0MLszwPY1OIkFNRjt666mJEP++TeSXqwbblh8dc
 CXZn2mtcfGfizKAVgCmdSzb46lFh/YSOIlRONo/DIQ1MyWkQhKInOFvKk
 eVuOMxWLga3t8v/Yxf0uuvjlRh2Z0+3wzaOzFkjZXeHnAA3txobTKlwo6
 rerH4pCY84hy95h19oMQbEcDS4DC1eiiXNCFt+ubBrsd6nhO3N+O74XMG w==;
X-CSE-ConnectionGUID: ZyEXFUsgQauCLVZKvUh64g==
X-CSE-MsgGUID: TOqT4Uy0ScamcS+v+SNTlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4519750"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4519750"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 08:03:29 -0800
X-CSE-ConnectionGUID: 3iRhachyT0K1dz1TqXRfYg==
X-CSE-MsgGUID: 1xKWDIgrT0WzDaFL2Hrp9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; d="scan'208";a="12236627"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa002.jf.intel.com with ESMTP; 26 Nov 2026 08:03:29 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>,
 Shreyansh Jain <shreyansh.jain@nxp.com>, Rohit Raj <rohit.raj@nxp.com>
Subject: [PATCH v1 06/11] bus/fslmc: fix DPIO portal mapping leak on close
Date: Thu, 26 Nov 2026 16:03:12 +0000
Message-ID: <4b169dfd04dc9e25bca9e17e2fc689b610f65d5d.1795708917.git.anatoly.burakov@intel.com>
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

Currently, when a DPIO device is closed, or when a failed DPIO probe
tears down the devices already on the list, we release the device but
never unmap its QBMan software portal regions. This leaks two mappings
per device.

Fix it by unmapping the portal regions in both places.

Fixes: e55d0494ab98 ("bus/fslmc: support secondary process")
Fixes: 274fd921ff7f ("bus/fslmc: support close operation")
Cc: shreyansh.jain@nxp.com
Cc: rohit.raj@nxp.com
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
index 67740601e6b..e7d72eac368 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
@@ -489,6 +489,7 @@ dpaa2_close_dpio_device(int object_id)
 			rte_free(dpio_dev->dpio);
 		}
 		TAILQ_REMOVE(&dpio_dev_list, dpio_dev, next);
+		dpaa2_unmap_dpio_portal(dpio_dev);
 		rte_intr_fd_close(dpio_dev->intr_handle);
 		/* dev_fd is closed by caller, clear reference here. */
 		rte_intr_dev_fd_set(dpio_dev->intr_handle, -1);
@@ -710,6 +711,7 @@ dpaa2_create_dpio_device(int vdev_fd,
 				dpio_dev->token);
 			rte_free(dpio_dev->dpio);
 		}
+		dpaa2_unmap_dpio_portal(dpio_dev);
 		rte_intr_fd_close(dpio_dev->intr_handle);
 		/* dev_fd is closed by caller, clear reference here. */
 		rte_intr_dev_fd_set(dpio_dev->intr_handle, -1);
-- 
2.52.0

