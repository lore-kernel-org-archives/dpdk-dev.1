Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFA7C56208
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 14:12:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B7CB840DD2;
	Thu,  6 Aug 2026 16:11:46 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 378FB40697
 for <dev@dpdk.org>; Thu,  6 Aug 2026 16:11:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786025505; x=1817561505;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=e9IDAyO95mRxQotsuz6q+T0l/DZ4MU6ZHrtX8iFYhJo=;
 b=OLdf8x8xUQjMcCbNgIIw6GfC6Tu9Cw6LdVy/GFl4hK8SJXbN9uT8/nz6
 byHS2vGIjzUTP5JzJBwnAjKxYGVLON0BprvMmPwSBSpd0H9bCrKhkV7iy
 6INKJkxzfDtGNw9/al1I9VdQBFee6fTZBlxeP79XpnNkltj5Xs78ltuBq
 3h8c8id52o09J7qC6eURVOfQEuDuGwcEWFiSeO/dFzIEPrL1rh+GwR6sf
 z8Od0kmDMxOhbvhZRUOPupW4JLIryzLce5roSNJo2hBE33fYebtDvBA8h
 oREygq2lso+RrIp0w2I4fM1G0JA1TIKntnV8c9+LiqUpINP15D2heWb5h g==;
X-CSE-ConnectionGUID: 9be2bUxSSw6kys9pLnb9+A==
X-CSE-MsgGUID: qKhV/qFHTXior0vRByuHWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="85590002"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; d="scan'208";a="85590002"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 07:11:43 -0700
X-CSE-ConnectionGUID: vMbcFj+kQMCrNEUwzzQ/jA==
X-CSE-MsgGUID: TEvTJpzdRgaHhjxKrFqQcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; d="scan'208";a="292015179"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa002.jf.intel.com with ESMTP; 06 Aug 2026 07:11:42 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Matan Azrad <matan@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>
Subject: [PATCH v10 11/20] vdpa/mlx5: remove group-related API
Date: Thu,  6 Aug 2026 15:11:11 +0100
Message-ID: <382c77e70fe9c9e2dce9a9506cf4773c8ed80ae8.1786025388.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1786025387.git.anatoly.burakov@intel.com>
 <cover.1786025387.git.anatoly.burakov@intel.com>
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

