Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BA0CCD1A5
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 09:53:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 87F5040608;
	Fri, 24 Oct 2025 11:53:18 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id B49BD40156;
 Fri, 24 Oct 2025 11:53:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761299595; x=1792835595;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tbJCvtVcI9fWEf3ibsCaLLvla4boRXSpur7EcPhzNq8=;
 b=ABitfyU5EW9MwehkXUFQujTN0P+7cDcB+bW8STFMphDq70uK4GLK/WFW
 I1ErrF7E59mWqjIPkn/kbtkCVdkz399fhZV6p1GdjI2ggj0q5ZSRXj7YJ
 EhboexkNkRs1MWeFCEt6UxacniEvdEvwJS4EMOPW45L1Xh478Y6fmEvoH
 29Y6DkdPJxzrEE5lfaCIOLpHy7b4fD2GPwAHqasuEwTV+T+cOWsBoA7P3
 5AhnMXtkAungUK2vzxw9hNRCpPJ3pwVoRnxx4U4gCzbJonZhT5bxzXmZ7
 a8opP8JEzuY37mjUHAVeQDoyE2/d+kE5/Egth0JD+RALnKehmXdnHygWN A==;
X-CSE-ConnectionGUID: I4evAF50SOq9Ko43aRK0sQ==
X-CSE-MsgGUID: 3aRR0tzjT92qZW+1YzUwWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="66096024"
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; d="scan'208";a="66096024"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2025 02:53:14 -0700
X-CSE-ConnectionGUID: paML64h5To+nJ0MVYLsjIg==
X-CSE-MsgGUID: hbJDma6XTJ2o5wqYxz7TEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; d="scan'208";a="185166231"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa010.fm.intel.com with ESMTP; 24 Oct 2025 02:53:13 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Nipun Gupta <nipun.gupta@amd.com>,
 Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>
Cc: stable@dpdk.org
Subject: [PATCH v1 2/2] bus/cdx: fix incorrect device release on error
Date: Fri, 24 Oct 2025 10:53:10 +0100
Message-ID: <05ecc81aefbbe2073416c0e78aed926ec9ad54b5.1761299581.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <7e4985db2bbf29515f8cd6a4ab510d71f8a636a3.1761299581.git.anatoly.burakov@intel.com>
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

The variable cdx_addr is a stack-allocated zero-initialized char array, but
it is never used anywhere except in an error handler to stand it as a
device bus address for a VFIO device release call. This is incorrect, as it
should have been actual device address, so fix the code to reflect that.

Fixes: 45ef232af515 ("bus/cdx: introduce AMD CDX bus")
Cc: nipun.gupta@amd.com
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/bus/cdx/cdx_vfio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/bus/cdx/cdx_vfio.c b/drivers/bus/cdx/cdx_vfio.c
index a3cf53b6a6..11fe3265d2 100644
--- a/drivers/bus/cdx/cdx_vfio.c
+++ b/drivers/bus/cdx/cdx_vfio.c
@@ -485,7 +485,6 @@ static int
 cdx_vfio_map_resource_secondary(struct rte_cdx_device *dev)
 {
 	struct vfio_device_info device_info = { .argsz = sizeof(device_info) };
-	char cdx_addr[PATH_MAX] = {0};
 	int vfio_dev_fd;
 	int i, ret;
 	struct mapped_cdx_resource *vfio_res = NULL;
@@ -536,7 +535,7 @@ cdx_vfio_map_resource_secondary(struct rte_cdx_device *dev)
 
 	return 0;
 err_vfio_dev_fd:
-	rte_vfio_release_device(RTE_CDX_BUS_DEVICES_PATH, cdx_addr, vfio_dev_fd);
+	rte_vfio_release_device(RTE_CDX_BUS_DEVICES_PATH, dev_name, vfio_dev_fd);
 	return -1;
 }
 
-- 
2.47.3

