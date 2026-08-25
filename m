Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78204C61DB9
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Aug 2026 13:22:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0FF4A40A89;
	Tue, 25 Aug 2026 15:21:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id D09DE406B7
 for <dev@dpdk.org>; Tue, 25 Aug 2026 15:21:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787664101; x=1819200101;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=e9IDAyO95mRxQotsuz6q+T0l/DZ4MU6ZHrtX8iFYhJo=;
 b=PPCun7Ld6l4Ji/HpvEWZ82o+LBKmzF3TxxusCXap6St1z+B208huSZrq
 G8xYe4xxatCZHAYxWRuehli5ab8wrWzBQ1qODi5A/SGaOPjJ3sfvLeRXH
 5eQooKnJb4gHIyDli+PfhDH4zvt4HpHj3EV5+RJr1Hh3lvWG8X4Q5wWjm
 lPAVBUfWagkE4d8ZVWXm4jSKWCLBcitqpY7T6U/1Q4Uilh4SHLl7DrJg7
 113mh/Z4iLKw0CnmimW3sQ6exRADRIcE04KJ1E67hK6aZb9BCDHTMR34q
 /taJTVTztvPdxPOzqEh7xcQSvUofI/NSP8lAGSmsmHJqQUlYGF0D7uv86 w==;
X-CSE-ConnectionGUID: yIIotL0eSlW/+KuYgQa5nA==
X-CSE-MsgGUID: ZOF5YSojQYG4jNpL7jE6dQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="88332715"
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; d="scan'208";a="88332715"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2026 06:21:40 -0700
X-CSE-ConnectionGUID: KyWA2uaBTyiduneHf660Ew==
X-CSE-MsgGUID: KlnOLclbSTa8/bAneS28pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; d="scan'208";a="264660892"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa008.fm.intel.com with ESMTP; 25 Aug 2026 06:21:40 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Matan Azrad <matan@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>
Subject: [PATCH v12 11/20] vdpa/mlx5: remove group-related API
Date: Tue, 25 Aug 2026 14:21:08 +0100
Message-ID: <4580bd1155d2c700ac2c83b6b70973ead695ac2c.1787663787.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1787663786.git.anatoly.burakov@intel.com>
 <cover.1787663786.git.anatoly.burakov@intel.com>
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

