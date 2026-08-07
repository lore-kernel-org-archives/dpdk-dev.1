Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6565EC2A09B
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Aug 2026 14:47:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 843E440E2E;
	Fri,  7 Aug 2026 16:46:53 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id D21AC40E18
 for <dev@dpdk.org>; Fri,  7 Aug 2026 16:46:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786114012; x=1817650012;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=e9IDAyO95mRxQotsuz6q+T0l/DZ4MU6ZHrtX8iFYhJo=;
 b=oJwkQnygq+niDrLLERw4EZjhVtzerKm/lV5i9QoPoGf/2uSbsaarL6Qy
 Lpi6PShcMpzAAEuLdnlfWtKII4N2A3oymDgSg7s3VOAFrPHmeYZN9JKy2
 EfyTjkO2eL1L1p4rYwSbhkaibFjK5h5QAI1OZ+eTIWyVHEjP6bY12sFZU
 s8z+aPNyhslGSIRvPkrTGq/3vg4g41+X7P3/V0jixMwmE9TqQra/3FfJl
 korY4FFdgOq/ZPz6i1bEjKG7++nPDdYNF4xuVlg+xAvc72uh3ACn5tU2q
 lJJPoKyifn9VsljSxMNr75iA/uyUUZBMoGnc2kJ/ox09JeBDFm3ip6pKi g==;
X-CSE-ConnectionGUID: kZx+ngwzTfOLYkGfEK5C8Q==
X-CSE-MsgGUID: ILRA6EVPRpOhodz8GY0o6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11868"; a="104257328"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; d="scan'208";a="104257328"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2026 07:46:51 -0700
X-CSE-ConnectionGUID: xwQ+9jn0SYCCVqyp1HvmLg==
X-CSE-MsgGUID: Z7nGtQ0+SJeT2AQsUUBKuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; d="scan'208";a="300623283"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa001.jf.intel.com with ESMTP; 07 Aug 2026 07:46:50 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Matan Azrad <matan@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>
Subject: [PATCH v11 11/20] vdpa/mlx5: remove group-related API
Date: Fri,  7 Aug 2026 15:46:20 +0100
Message-ID: <648bd21a85795e736e3654c6ac2d85fe7af2c49c.1786113800.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1786113799.git.anatoly.burakov@intel.com>
 <cover.1786113799.git.anatoly.burakov@intel.com>
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

