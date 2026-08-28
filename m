Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E1DC61DBD
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 13:08:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 577BD40BA6;
	Fri, 28 Aug 2026 15:07:32 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 40CDF40B9B
 for <dev@dpdk.org>; Fri, 28 Aug 2026 15:07:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787922449; x=1819458449;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=e9IDAyO95mRxQotsuz6q+T0l/DZ4MU6ZHrtX8iFYhJo=;
 b=Jy2fAlpfX1pu5f0evRxwS7UYSGguR1GGw6fvp+CmuG8N69BqehhU+GzQ
 njdlqQusxyuCG6vzITpAoy0H9epLy2lfF8EtE0RCkLeiw05lXPEzT4A6W
 gRu94JPaHKoBx4VB53Ybd9vB2MCsA96Qr+2V4ko9N2caJ5rwlOpLgrlis
 WiXcFBhQN1kKPqEqgivUBwi2fxzgHV+PiSGGACVcV9Xk9Mbt6WrTR5qsz
 NfpaLamNWwOUkv1F+IvkTPuTZXpdu/fZcCBSrGA9aPpsJIWTmu7ZQ/Qa4
 84QB/23SFzhsTixUnFkkZYiWXcOjmZX+xjIx5lmSlVUbUM8UPuIIPGn6+ w==;
X-CSE-ConnectionGUID: 7+WwMvg/RWKu56y5cWKAUQ==
X-CSE-MsgGUID: 7I5YAMjUQNGUlpx+16KTsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="113964605"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="113964605"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2026 06:07:29 -0700
X-CSE-ConnectionGUID: /Uj4AfXJRlOZ9oX0SIbrEg==
X-CSE-MsgGUID: DyTkx7BaTKubhoOW15NIrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="271959988"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa004.jf.intel.com with ESMTP; 28 Aug 2026 06:07:28 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Matan Azrad <matan@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>
Subject: [PATCH v14 16/25] vdpa/mlx5: remove group-related API
Date: Fri, 28 Aug 2026 14:06:44 +0100
Message-ID: <4276af99aff11d210a308f4d13a7e2be9b514d82.1787922363.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1787922362.git.anatoly.burakov@intel.com>
 <cover.1787922362.git.anatoly.burakov@intel.com>
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

