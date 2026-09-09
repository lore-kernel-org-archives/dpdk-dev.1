Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2900C79F8C
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Sep 2026 10:04:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB707427C4;
	Wed,  9 Sep 2026 12:02:56 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id CD6ED427B4
 for <dev@dpdk.org>; Wed,  9 Sep 2026 12:02:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788948174; x=1820484174;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=e9IDAyO95mRxQotsuz6q+T0l/DZ4MU6ZHrtX8iFYhJo=;
 b=j204UZ+MruLvC9RWwM4aDb6Eeuj6tIsMEgMgpQRpPY59NxS7jWl+7zWG
 71bsNqbUnYOh0/DaqHBDy0DqUUpLY4uyOO4Jf4C2tyBZBN2W0zzdeFN8W
 Kclyt46hcCLsmrzUo+YHzxtqMC2V2aqPqYSIcz7KrPinP4eqxkjHsympR
 sdHKpLiQ3uY+CkF8PNDBknoKFQKLlkQrwstl2fDMyXwrSNE8gA3CMw4wr
 fQmIpena3Lhil7eFX0Y5QBcDJdX/70kyFymuOwwkbO8z0XuB7u52EZF2F
 JtA+Wpmkxn4pxVhb1oLHdPMhAb/WrEHwPto7ul+TMymEs6Fv1i0kuiyvf Q==;
X-CSE-ConnectionGUID: Xa7SIPRLTn2AG+FONrzi/g==
X-CSE-MsgGUID: /3Brs9OCShSvK+plfS3faQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="89492254"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; d="scan'208";a="89492254"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2026 03:02:54 -0700
X-CSE-ConnectionGUID: wNtSvtv+TtCEcNm4I/nCFQ==
X-CSE-MsgGUID: R/nQ1noEQ5eqowAJWpVDQA==
X-ExtLoop1: 1
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa003.fm.intel.com with ESMTP; 09 Sep 2026 03:02:52 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Matan Azrad <matan@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>
Subject: [PATCH v16 17/26] vdpa/mlx5: remove group-related API
Date: Wed,  9 Sep 2026 11:02:10 +0100
Message-ID: <4276af99aff11d210a308f4d13a7e2be9b514d82.1788947938.git.anatoly.burakov@intel.com>
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

The mlx5 driver does not use the `get_group_fd` API provided by vDPA. This
API is about to be removed, so remove its mention from mlx5.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/vdpa/mlx5/mlx5_vdpa.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/vdpa/mlx5/mlx5_vdpa.c b/drivers/vdpa/mlx5/mlx5_vdpa.c
index 11708e2005..1bb5de51b6 100644
--- a/drivers/vdpa/mlx5/mlx5_vdpa.c
+++ b/drivers/vdpa/mlx5/mlx5_vdpa.c
@@ -523,7 +523,6 @@ static struct rte_vdpa_dev_ops mlx5_vdpa_ops = {
 	.set_vring_state = mlx5_vdpa_set_vring_state,
 	.set_features = mlx5_vdpa_features_set,
 	.migration_done = NULL,
-	.get_vfio_group_fd = NULL,
 	.get_vfio_device_fd = mlx5_vdpa_get_device_fd,
 	.get_notify_area = mlx5_vdpa_get_notify_area,
 	.get_stats_names = mlx5_vdpa_get_stats_names,
-- 
2.52.0

