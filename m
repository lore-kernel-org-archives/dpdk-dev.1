Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218F1C79F9F
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Sep 2026 12:55:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 71E9E42D89;
	Thu, 10 Sep 2026 14:53:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id C4242427E0
 for <dev@dpdk.org>; Thu, 10 Sep 2026 14:53:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789044825; x=1820580825;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=e9IDAyO95mRxQotsuz6q+T0l/DZ4MU6ZHrtX8iFYhJo=;
 b=WqbdQ83gZYB9sdf/+jdlgE095LokF0enIFexWysJBXbkMZnDEm0zfmRc
 TEW9cUaemZgtbC5ZV7pZUXo0SPh8IuQsJGpoAxKcJvn+IyW88kNltloeV
 0SaJNPa0VuojFSKhPIhaN6JJmhhY3e2pgQv1ye35mVZi/fXDR0vwrg+II
 aG2ADEvDjJh2i68Em+CJDoYugV9DPGASRU8nvYKIal85cmnBOsKkc+8L8
 mQZspUUKlA/7YWLc0RCcu69nxgjkF/xwtsLY4d05YBY6lhgujcDFyLQcj
 6X9pnjxNQ+sW2G0uVr97mIfFa7nDk6h8ShGnpAYrhsaX5PoSM8yP2yIWB g==;
X-CSE-ConnectionGUID: LzxbJiasSQiEYEhy99mlbA==
X-CSE-MsgGUID: oSRxqAzETAiukLEogMb1lw==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="89334078"
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="89334078"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2026 05:53:44 -0700
X-CSE-ConnectionGUID: ZGXGyov2SF6/NGEDo0p4zQ==
X-CSE-MsgGUID: G3CVV7MJRDCMdhNPrcXDQw==
X-ExtLoop1: 1
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa003.fm.intel.com with ESMTP; 10 Sep 2026 05:53:44 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Matan Azrad <matan@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>
Subject: [PATCH v17 17/26] vdpa/mlx5: remove group-related API
Date: Thu, 10 Sep 2026 13:53:01 +0100
Message-ID: <c9decfe2323bea286e9e20de8e6d9811737d9b2c.1789044747.git.anatoly.burakov@intel.com>
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

