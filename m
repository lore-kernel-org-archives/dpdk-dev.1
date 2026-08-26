Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9172C61DBD
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Aug 2026 12:05:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 663A540279;
	Wed, 26 Aug 2026 14:05:32 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id A1E3340278
 for <dev@dpdk.org>; Wed, 26 Aug 2026 14:05:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787745931; x=1819281931;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=tCUGv0YZneKQDxUTlPlrV1RRlPfmE01CO/uzsQNp71g=;
 b=iIXkRwHgfcsPoBU/XxT2UY1kKuNBbSAx+U3fx6sy1RjhwJ1WKCfAwLe0
 7YVZCmHSkLsHWlR+llmdGhfnhIqmI1+YTfns23/O9cMoXVNRxkgW78N7t
 SYXZJH7PYqQV+GrkOeoa03+TJiWkD3sgUgLfS1Xtvi29ztli+uU6alCf/
 irAwzNcKg3g3o0N4Rp/ACNNU94+SIYszaqBC3s9iRoGs5zNW5CuYe8Agi
 25XfH57YTK7bUovAkR1k7ZZhUcyaoph2ZiP85IZzLxOskcnp5ztoumbXy
 mrDARPWnweLz4E6Ie2eCZVI4XO9QxWmtHq5Bd22pW3EQZEh4ZcyJpEUUZ g==;
X-CSE-ConnectionGUID: WCm85usKT62m2y5c521znQ==
X-CSE-MsgGUID: 2RML+hzTQNyuksyv1W0dWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="98897294"
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; d="scan'208";a="98897294"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2026 05:05:29 -0700
X-CSE-ConnectionGUID: ZXtJ021NRYacKP+gckeTUQ==
X-CSE-MsgGUID: bb6wmO+BQTOtDDQzZyAWUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; d="scan'208";a="264960598"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa008.fm.intel.com with ESMTP; 26 Aug 2026 05:05:28 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Dimon Zhao <dimon.zhao@nebula-matrix.com>,
 Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v1 1/1] net/nbl: fix use-after-free
Date: Wed, 26 Aug 2026 13:05:27 +0100
Message-ID: <67906e589460e28a3f08d3a28c02d9ceeb72c2fd.1787745917.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
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

Remove the device from TAILQ on unmap to fix it.

Fixes: dc955cd24c8f ("net/nbl: add coexistence mode")
Cc: dimon.zhao@nebula-matrix.com
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---

Notes:
    This fix is AI generated, please review carefully. It looks reasonable to me,
    but this isn't a driver/use case I know well.

 drivers/net/nbl/nbl_common/nbl_userdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/nbl/nbl_common/nbl_userdev.c b/drivers/net/nbl/nbl_common/nbl_userdev.c
index 96f0d2e264..53f18fd00f 100644
--- a/drivers/net/nbl/nbl_common/nbl_userdev.c
+++ b/drivers/net/nbl/nbl_common/nbl_userdev.c
@@ -549,6 +549,7 @@ static int nbl_mdev_unmap_device(struct nbl_adapter *adapter)
 
 	close(common->devfd);
 	rte_mcfg_mem_read_lock();
+	TAILQ_REMOVE(&nbl_adapter_list, adapter, next);
 	vfio_group_fd = rte_vfio_container_group_bind(nbl_default_container,
 						      common->iommu_group_num);
 	NBL_LOG(DEBUG, "close vfio_group_fd %d", vfio_group_fd);
-- 
2.52.0

