Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91306C55ABA
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Aug 2026 13:47:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4AD3040B90;
	Wed,  5 Aug 2026 15:46:11 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 7D75A40695
 for <dev@dpdk.org>; Wed,  5 Aug 2026 15:46:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785937569; x=1817473569;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=e9IDAyO95mRxQotsuz6q+T0l/DZ4MU6ZHrtX8iFYhJo=;
 b=hF9zpWJUk43KagYhKDlKraI0Y36t8N5ajNCz8XcWEFkSrwSRZY93i2Gn
 3x4uDL7r6EU6aa1aeSAonQ8sdZj7Tiv/J+PJkQ623uVIRKMlgRhBymEPu
 6UJW74AJmFeFmsvs6y6l45ocmv1K/uxH/QrDqX0WgPB5jLWwBVa/2K4j6
 ogkB4TCmwchKbyHvS2aSZrg64vSBDj6pl63v5Pxp41vzf4ubo4TIyOPLy
 eLSB6Ii3VpY/7p829JWVabj+O/HDLe6LsMuZo8c+4uROu9XFJPGg1lfEr
 UZGTEnN/asIBwxSJ5WH6FGG2KZ9eH/cw0CJz33DRE1q4w63ZIBQPG50c/ A==;
X-CSE-ConnectionGUID: DqyJ8GmcSKiUWTN0/GSMzw==
X-CSE-MsgGUID: o+ZFQrLpSUWI06pz7UDDSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="86284099"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; d="scan'208";a="86284099"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 06:46:09 -0700
X-CSE-ConnectionGUID: tcZd65QkSLOgabyd20Lr9g==
X-CSE-MsgGUID: 9yxEfjsmQmGCq579na319Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; d="scan'208";a="258476672"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa007.fm.intel.com with ESMTP; 05 Aug 2026 06:46:08 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Matan Azrad <matan@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>
Subject: [PATCH v9 10/19] vdpa/mlx5: remove group-related API
Date: Wed,  5 Aug 2026 14:45:39 +0100
Message-ID: <8fb5d1f5c4112292f944f6fbf0580c9918b43a70.1785937061.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1785937060.git.anatoly.burakov@intel.com>
 <cover.1785937060.git.anatoly.burakov@intel.com>
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

