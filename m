Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBBAC61DD6
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Sep 2026 16:17:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C46140ED0;
	Tue,  1 Sep 2026 18:16:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id EF82540A8B
 for <dev@dpdk.org>; Tue,  1 Sep 2026 18:16:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788279365; x=1819815365;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=e9IDAyO95mRxQotsuz6q+T0l/DZ4MU6ZHrtX8iFYhJo=;
 b=WNjo1BZe6pwQDYwHKhcShASVRO3wA0jZ7ageChTJqCbs9ieiOQf3c3BZ
 dSw52K1uqEhPn6m50SNNwmfeXk1JSNubTRrB2EZd3XPyrq3F2lGHg4/AW
 Em3LgIrC0E923wergFlXHy1tGr4ASbvjgqq7lBlKNpa1uTiOCu+uNz2+p
 am82oJjjdVyV5jKnZYm2pNneg9tFIsBqADRS6JzjlLuI+X425usAkR4r2
 BqxKJJgQi6a7Cmfae6cOYQQBiE/X/euN7wPLNoZXfa+YgdNdJERjBHBWh
 BiSt/rwvbZNW4/nzayCoE/VKbjAPw/sP6Oo9wEBC1pUWW4rcetafVXxY0 w==;
X-CSE-ConnectionGUID: 0l8UYQEuTeihOWl6U93h8A==
X-CSE-MsgGUID: JJ2MwEJiT/i0N06/puTvJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="87656100"
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; d="scan'208";a="87656100"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 09:16:04 -0700
X-CSE-ConnectionGUID: nwXXHHwHS1KMVAcMjVA1qw==
X-CSE-MsgGUID: Sk1r91sVQQmWK8L8DS1q7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; d="scan'208";a="299032566"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa002.jf.intel.com with ESMTP; 01 Sep 2026 09:16:03 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Matan Azrad <matan@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>
Subject: [PATCH v15 16/25] vdpa/mlx5: remove group-related API
Date: Tue,  1 Sep 2026 17:15:22 +0100
Message-ID: <4276af99aff11d210a308f4d13a7e2be9b514d82.1788278992.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1788278991.git.anatoly.burakov@intel.com>
 <cover.1788278991.git.anatoly.burakov@intel.com>
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

