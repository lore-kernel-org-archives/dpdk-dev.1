Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7452606A31C
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Nov 2026 13:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ewl1NaFj
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 816B4406B7;
	Fri, 27 Nov 2026 14:14:32 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTPS id CCDF84065A
 for <dev@dpdk.org>; Fri, 27 Nov 2026 14:14:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795785268; x=1827321268;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=JVoZGhKT5SnIbORsSL574Z0AGc2/vC1vPx6kLc4HJ8A=;
 b=ewl1NaFjpiARK8j/wxIsSolDsB1n2990TmX7k4K7Ex6h1Spvt2w3fajE
 703E+WzjM8Z/TJeAx6hyCaW+k4J4kOLDHy9ixKUz6cvC1LJu7jmh39V3u
 QLgcfbConSPi8ApIhbbbpiIAReZBklQq260LIt5HdXMrwm2GY21xjG9f9
 dE9Tjt4gj9W8A0O9vMaFFRSyV/3eA6n30RIgkKzrdlhVNyUHMzD44OgAA
 Z0REmTT5oy7sJgEM4VW9gYMn37sexCq++LS7N343xgOliMqQUJSbEos85
 TrCo/SSreTEX1JjeT5MuPCiqgRr4NHM7ggDLPES9WXtryyYEaec2akQz3 w==;
X-CSE-ConnectionGUID: w39Zv41uR6qjsPd0ZCozlw==
X-CSE-MsgGUID: QgMA7O/vRfGhws6cPhPhPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11979"; a="4787524"
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="4787524"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 05:14:28 -0800
X-CSE-ConnectionGUID: YOoM43bUQdKA0H3DxCjp/w==
X-CSE-MsgGUID: K+2p0ZdeQ1eeNZG8yoLwEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; d="scan'208";a="12655991"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa002.fm.intel.com with ESMTP; 27 Nov 2026 05:14:26 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v2 08/13] bus/fslmc: fix unchecked DPIO portal mapping
Date: Fri, 27 Nov 2026 13:14:08 +0000
Message-ID: <e282f61ace2a8f81211a705bb7b913f1635093ca.1795785194.git.anatoly.burakov@intel.com>
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

Currently, when we create a DPIO device, we map the QBMan software
portal's cache-enabled and cache-inhibited regions, but we do not check
whether either mapping succeeded. In addition, the mappings are never
undone on the error path, so a failed probe leaks the mappings even if they
were successful.

Fix it by checking each mapping and bailing out if it failed, recording
the address only on success, and unmapping whatever was mapped on the
error path.

Fixes: 5374e50f10dc ("bus/fslmc: add dpio portal driver")
Cc: hemant.agrawal@nxp.com
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c | 35 ++++++++++++++++++++----
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
index 2e8c660acfe..67740601e6b 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
@@ -460,6 +460,19 @@ static void dpaa2_portal_finish(void *arg)
 	pthread_setspecific(dpaa2_portal_key, NULL);
 }
 
+static void
+dpaa2_unmap_dpio_portal(struct dpaa2_dpio_dev *dpio_dev)
+{
+	if (dpio_dev->qbman_portal_ce_paddr != 0) {
+		munmap((void *)dpio_dev->qbman_portal_ce_paddr, dpio_dev->ce_size);
+		dpio_dev->qbman_portal_ce_paddr = 0;
+	}
+	if (dpio_dev->qbman_portal_ci_paddr != 0) {
+		munmap((void *)dpio_dev->qbman_portal_ci_paddr, dpio_dev->ci_size);
+		dpio_dev->qbman_portal_ci_paddr = 0;
+	}
+}
+
 static void
 dpaa2_close_dpio_device(int object_id)
 {
@@ -495,6 +508,7 @@ dpaa2_create_dpio_device(int vdev_fd,
 	struct qbman_swp_desc p_des;
 	struct dpio_attr attr;
 	int ret, object_id = obj->object_id;
+	void *addr;
 
 	if (obj_info->num_regions < NUM_DPIO_REGIONS) {
 		DPAA2_BUS_ERR("Not sufficient number of DPIO regions");
@@ -589,10 +603,14 @@ dpaa2_create_dpio_device(int vdev_fd,
 		goto err;
 	}
 
+	addr = mmap(NULL, reg_info.size, PROT_WRITE | PROT_READ, MAP_SHARED,
+			vdev_fd, reg_info.offset);
+	if (addr == MAP_FAILED) {
+		DPAA2_BUS_ERR("Failed to map DPIO CENA region: %s", strerror(errno));
+		goto err;
+	}
 	dpio_dev->ce_size = reg_info.size;
-	dpio_dev->qbman_portal_ce_paddr = (size_t)mmap(NULL, reg_info.size,
-				PROT_WRITE | PROT_READ, MAP_SHARED,
-				vdev_fd, reg_info.offset);
+	dpio_dev->qbman_portal_ce_paddr = (size_t)addr;
 
 	reg_info.index = DPAA2_SWP_CINH_REGION;
 	if (ioctl(vdev_fd, VFIO_DEVICE_GET_REGION_INFO, &reg_info)) {
@@ -600,10 +618,14 @@ dpaa2_create_dpio_device(int vdev_fd,
 		goto err;
 	}
 
+	addr = mmap(NULL, reg_info.size, PROT_WRITE | PROT_READ, MAP_SHARED,
+			vdev_fd, reg_info.offset);
+	if (addr == MAP_FAILED) {
+		DPAA2_BUS_ERR("Failed to map DPIO CINH region: %s", strerror(errno));
+		goto err;
+	}
 	dpio_dev->ci_size = reg_info.size;
-	dpio_dev->qbman_portal_ci_paddr = (size_t)mmap(NULL, reg_info.size,
-				PROT_WRITE | PROT_READ, MAP_SHARED,
-				vdev_fd, reg_info.offset);
+	dpio_dev->qbman_portal_ci_paddr = (size_t)addr;
 
 	/* Configure & setup SW portal */
 	p_des.block = NULL;
@@ -672,6 +694,7 @@ dpaa2_create_dpio_device(int vdev_fd,
 		rte_free(dpio_dev->dpio);
 	}
 
+	dpaa2_unmap_dpio_portal(dpio_dev);
 	rte_intr_fd_close(dpio_dev->intr_handle);
 	/* dev_fd is closed by caller, clear reference here. */
 	rte_intr_dev_fd_set(dpio_dev->intr_handle, -1);
-- 
2.52.0

