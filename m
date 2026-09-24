Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B317AC98318
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Sep 2026 16:16:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 092B6432EE;
	Thu, 24 Sep 2026 18:14:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id D249142FEF
 for <dev@dpdk.org>; Thu, 24 Sep 2026 18:14:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790266454; x=1821802454;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=MkRH0sWO0u6iFatYxVVg8o/aFG9CfWF4QwRVdVVupV4=;
 b=TYCxuzdeBH9bGvorEUcKGniQzr2CdTng7NWtRa/KK2tNYVM1xWMr6ufk
 7EoseqDN7XWSEOt+CGDe73kBJGPKeyiqnyAhmdDJH0pfBEZPwZ1gVZG+1
 5T7z/VODym8A+vlDJ4bKC4IaMdmBth0/kcShP3cEXnXeSwtK4kUMp2Fa+
 e5km7UcuBaQ+/kIoQhxS4hzlh+rpH/IHDuBXLwci4hM2ORHFRxA6ZPlpO
 ZODe+rfqbuI74R61QTEZZlDKXRz+pWyclnQdi4DlqDdWlWF56iQO5nwhY
 VXH2iS+ilCM3Oao6mJZu2k3DU9BaSBF5BAN0ggLw7cvJO3wKF9V1z6rx3 Q==;
X-CSE-ConnectionGUID: 7WkMOGeNSZekL7UCsOthrw==
X-CSE-MsgGUID: tfHsoQnVSomBED+5kkf6Tg==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="90000722"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="90000722"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 09:14:14 -0700
X-CSE-ConnectionGUID: Fn6sx7exQ06qXCc5vXmclw==
X-CSE-MsgGUID: aEnC2fn0Tpq+EJpfqEkWGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="277830092"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa005.jf.intel.com with ESMTP; 24 Sep 2026 09:14:13 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Matan Azrad <matan@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>
Subject: [PATCH v18 20/29] vdpa/mlx5: remove group-related API
Date: Thu, 24 Sep 2026 17:13:27 +0100
Message-ID: <7ea22920cb9e9ba79f355dbf28e6fe2e6c2bdfc6.1790266166.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1790266165.git.anatoly.burakov@intel.com>
 <cover.1790266165.git.anatoly.burakov@intel.com>
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
index 11708e2005f..1bb5de51b64 100644
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

