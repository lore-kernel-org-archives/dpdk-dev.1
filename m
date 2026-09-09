Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A193C79FAD
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Sep 2026 10:02:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F81540ED2;
	Wed,  9 Sep 2026 12:02:33 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 78C9940272
 for <dev@dpdk.org>; Wed,  9 Sep 2026 12:02:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788948151; x=1820484151;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=8W26rg87uxeNCSDrA2lcBznUL1pzHbtMzWOErvdM/7Q=;
 b=PShDtYRDRYQlqqpRnElrguNSGUY0k1YAIEOBw+7I4R/Yd4fmTqn5Ecpq
 LqExhQsgROgWqhuOhkKgQmpvTvxCb57k+i6sC6T5b8lYN/gksSaIqJ94R
 yzRdTeXQn9wj4RrbMdRAtLdxDZaLX5Qs1+d0whFqJf/AdD5kgQmCSJJ+g
 d+Pb7Y94/YKEwJRYjIJRK/olFstpuvHKJscO60INO4V2P3WmT6Ok/8smJ
 FtElPSJLng/VN/+aBko9Y2BRHXV85eUu11of4ViHCwBKJKS+cw6ttmLl6
 bFGb2CsnccNpxSOyQ2CvEcjuARqtlLRTQS0kBhVTFnP+WlnVW5ATBz1vy g==;
X-CSE-ConnectionGUID: BmI/OZktSZm59XS8G1AZrg==
X-CSE-MsgGUID: 33imDGCtT1GhYYjDi5kUXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="89492157"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; d="scan'208";a="89492157"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2026 03:02:30 -0700
X-CSE-ConnectionGUID: Sr35R0raQO2+z0DoCrjUpg==
X-CSE-MsgGUID: PbIWI3/HSlKP3JF3EtLEMA==
X-ExtLoop1: 1
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa003.fm.intel.com with ESMTP; 09 Sep 2026 03:02:29 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Dimon Zhao <dimon.zhao@nebula-matrix.com>,
 Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v16 01/26] net/nbl: fix use-after-free
Date: Wed,  9 Sep 2026 11:01:54 +0100
Message-ID: <75e8e3b8ff4d0647e2a5216dcde0d93f3856e821.1788947937.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1788947937.git.anatoly.burakov@intel.com>
 <cover.1788947937.git.anatoly.burakov@intel.com>
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

