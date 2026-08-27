Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB36C61DB9
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Aug 2026 15:16:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 71E1040B9B;
	Thu, 27 Aug 2026 17:15:13 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 667AE40A6D
 for <dev@dpdk.org>; Thu, 27 Aug 2026 17:15:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787843709; x=1819379709;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=e9IDAyO95mRxQotsuz6q+T0l/DZ4MU6ZHrtX8iFYhJo=;
 b=amhc9tFU8OlzSLckovhP34wTlh+Oos63LD7wsHrdLDq8KelXt5FIJPko
 r0EF05KF2Q9o13raQD/x9dBtwyetLmAKsZ66K4ZInDDAdAdUlDy+uvCFz
 b1yW8wRrmDoudqKaaLDE5+StHfc53J4VvMUhUAlSbCGJSioZJKRXgDlGc
 rKlmgwWWH77yDorO+Wp0jgASQvIdJkxncgyaNKxPVnqhs1p7JIYdvfNnC
 W7Xqtv8Foq7F8qtFGKkb3SAs+o34hrsmuPrJfKVLwrmnKrMd17YXA1JhL
 seF8bhsNGQTB6kK/YWk6rNBW0nPRxYwDHiD4S8X6ocrNTvjqvp212Hf7g g==;
X-CSE-ConnectionGUID: RRgeFDb8RRu2B1R4f5bTrA==
X-CSE-MsgGUID: bUjilFAJTXe0QjDLULWYKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="88371637"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; d="scan'208";a="88371637"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 08:15:09 -0700
X-CSE-ConnectionGUID: 8hNNe2oRTFmrNiEbdQP58A==
X-CSE-MsgGUID: Gj4/o08STu2iE3Xf7/FJ+Q==
X-ExtLoop1: 1
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa003.fm.intel.com with ESMTP; 27 Aug 2026 08:15:08 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Matan Azrad <matan@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>
Subject: [PATCH v13 15/24] vdpa/mlx5: remove group-related API
Date: Thu, 27 Aug 2026 16:14:18 +0100
Message-ID: <632e6860fa6dbf90f9d55979463b27b7de59e30f.1787843386.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1787843385.git.anatoly.burakov@intel.com>
 <cover.1787843385.git.anatoly.burakov@intel.com>
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

