Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B0AC79F9F
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Sep 2026 12:53:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A6F0427B3;
	Thu, 10 Sep 2026 14:53:25 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id A2D1040F1A
 for <dev@dpdk.org>; Thu, 10 Sep 2026 14:53:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789044804; x=1820580804;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Q2fx5bcScgUsTDMvxvUvrG2vrkx8O0vPv8ZtJp+rKaU=;
 b=LmMVLvOgRveLOxLVeiHEgTQ4tRnWXKuey84VlDZoHSQxn0ox1DoUTMM/
 w8obx3dwbAoVsQmRlC6s94ZI6Q2dPc2JUXK4vbEYXALGf0xt8CI6H7P8d
 /yNeRw7fI9RPqYtsKEsm1Kh3KEQO+FoXOXSjQikV6NI/jlz4w0IezbttW
 bihkiqb2O9G9kAcgl0MPZjBWWRz8rNSCHavWyHinQLa0RuwQMRIxD98un
 8B1E7JpkHBGgDfz9AO2+1r8dmNJIe0/D4eYiaEjiLhp4HA3OpJ4dDAxxD
 s3/kYyFeQ9cQ9sROTV94r3vNSlDYiPntB/w8DkaAvBB4lhPZL7ae6wPk2 w==;
X-CSE-ConnectionGUID: 28LSBQbLS62Ccycn3Kt7WQ==
X-CSE-MsgGUID: UwLgLT70Qjeh2GzwfcDzsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="89334007"
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="89334007"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2026 05:53:21 -0700
X-CSE-ConnectionGUID: NHHEgGaQRtCHP7fg48vyJw==
X-CSE-MsgGUID: LoSG1dRNR6OZJmHiwBW+Iw==
X-ExtLoop1: 1
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa003.fm.intel.com with ESMTP; 10 Sep 2026 05:53:20 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Dimon Zhao <dimon.zhao@nebula-matrix.com>,
 Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v17 01/26] net/nbl: fix use-after-free
Date: Thu, 10 Sep 2026 13:52:45 +0100
Message-ID: <75e8e3b8ff4d0647e2a5216dcde0d93f3856e821.1789044747.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1789044746.git.anatoly.burakov@intel.com>
 <cover.1789044746.git.anatoly.burakov@intel.com>
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

