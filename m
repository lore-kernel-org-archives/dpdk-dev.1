Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC51C61DB9
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Aug 2026 08:48:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC60840150;
	Thu, 27 Aug 2026 10:48:00 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 3C7DD4003C
 for <dev@dpdk.org>; Thu, 27 Aug 2026 10:47:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787820479; x=1819356479;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=8W26rg87uxeNCSDrA2lcBznUL1pzHbtMzWOErvdM/7Q=;
 b=CJ/jyrOTItyD/vuOlG1HN6Al7DIGG5RqPY0WV8MOVJdjY00f6JymtwAY
 eq15B9DxK9Yj5xcnvd75WzXCTsVpMnWiXVvosfrxRPTvoKA2bR5r0Dtmd
 NGv9IK7daXtf1zqLuaQAvdF5kErHQIVDTA+QPV1kaV81xFPsfFxWruIIF
 T3mqVH2WSrgXAhMZjVrgrjSPiiDpJLSDfS3J1g6ZMyIuMRSOjayc2Wi2M
 aLylD/4aVcHiEuY+IeviRrfXNvpRmF8HdqBdxRjUDY2tNL3pxKHDZERhu
 KlEX6m+AOzKHc9AWbP44mbrPhntc5gFFDgYpRFICb+yn5UIEwwZT6EHgH g==;
X-CSE-ConnectionGUID: xpLVibe2TtO9HXRfioFceA==
X-CSE-MsgGUID: vDSuNm09SMmf315Pta+vZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="88333381"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; d="scan'208";a="88333381"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 01:47:58 -0700
X-CSE-ConnectionGUID: zqgBz2siRU2j0aziTF9xAQ==
X-CSE-MsgGUID: LdIbpAZfQAy4yprDMWvomA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; d="scan'208";a="267848916"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa007.jf.intel.com with ESMTP; 27 Aug 2026 01:47:57 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Dimon Zhao <dimon.zhao@nebula-matrix.com>,
 Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v2 1/1] net/nbl: fix use-after-free
Date: Thu, 27 Aug 2026 09:47:55 +0100
Message-ID: <75e8e3b8ff4d0647e2a5216dcde0d93f3856e821.1787820465.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <67906e589460e28a3f08d3a28c02d9ceeb72c2fd.1787745917.git.anatoly.burakov@intel.com>
References: <67906e589460e28a3f08d3a28c02d9ceeb72c2fd.1787745917.git.anatoly.burakov@intel.com>
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

When unmapping a device, the device is not removed from TAILQ, which may
result in attempting to access this devices' data during subsequent mem
event callbacks (as they are only disabled once all devices are removed).

Remove the device from TAILQ on unmap to fix it, and move the device fd
close under the memcfg lock to avoid race between a mem event and fd close.

Fixes: dc955cd24c8f ("net/nbl: add coexistence mode")
Cc: dimon.zhao@nebula-matrix.com
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---

Notes:
    This fix is AI generated, please review carefully. It looks reasonable to me,
    but this isn't a driver/use case I know well.

 drivers/net/nbl/nbl_common/nbl_userdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/nbl/nbl_common/nbl_userdev.c b/drivers/net/nbl/nbl_common/nbl_userdev.c
index 96f0d2e264..ec6840d60e 100644
--- a/drivers/net/nbl/nbl_common/nbl_userdev.c
+++ b/drivers/net/nbl/nbl_common/nbl_userdev.c
@@ -547,8 +547,9 @@ static int nbl_mdev_unmap_device(struct nbl_adapter *adapter)
 	struct nbl_common_info *common = &adapter->common;
 	int vfio_group_fd, ret;
 
-	close(common->devfd);
 	rte_mcfg_mem_read_lock();
+	TAILQ_REMOVE(&nbl_adapter_list, adapter, next);
+	close(common->devfd);
 	vfio_group_fd = rte_vfio_container_group_bind(nbl_default_container,
 						      common->iommu_group_num);
 	NBL_LOG(DEBUG, "close vfio_group_fd %d", vfio_group_fd);
-- 
2.52.0

