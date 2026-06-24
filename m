Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524E4CDB47C
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 10:37:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 10A194066B;
	Wed, 24 Jun 2026 12:37:10 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 6B8FC40659;
 Wed, 24 Jun 2026 12:37:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782297429; x=1813833429;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VQXecjmkp7v/H3jK7M7jiMob2r4LVZTk0m9A8k1UNPM=;
 b=BfTV6MV1ub0rvOADuT6YAs35LIxX46bfIi/WE7/4g2ofAhSJkXhtcEOw
 XTTZwRUjkTJ5e2+Js45squeG3+mllFuQA/tQOjbXhjP7xWhv84f/dI2OF
 ZET2cwSxQqxE30SRg5HvmH8hLOZceyKIsay0OvUKpzUys1zL8EcKX6O+z
 nP6iQ7dMPSFI7+vMYnDXWzUlDPC6yO9OC1t6ahtjS5QaekdNjcOuS3Obm
 wlCcWLS1Njr8kKRChDXDsN+j919gmilsLtPSXygMkd4tF7Ud9l0TeUJul
 4vww1R2N85AI5pzyxKm+A+htCJhLkbd/9aEdYtS0qYapVbtYwFfaRsa1x g==;
X-CSE-ConnectionGUID: Y7l24SKBSCyt8C0vkSqesA==
X-CSE-MsgGUID: RLrcT7PrQ+6078rsiUUJxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="93652336"
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="93652336"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2026 03:37:08 -0700
X-CSE-ConnectionGUID: zv9BWB4OQ7OpMI5zUKxrnQ==
X-CSE-MsgGUID: MCTrvpcXTXyEwyNlQxKkTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="245459991"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.224.226])
 by fmviesa006.fm.intel.com with ESMTP; 24 Jun 2026 03:37:06 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [PATCH v2 02/17] common/mlx5: replace strncpy with strlcpy
Date: Wed, 24 Jun 2026 11:36:41 +0100
Message-ID: <20260624103658.792750-3-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624103658.792750-1-bruce.richardson@intel.com>
References: <20260623165150.765443-1-bruce.richardson@intel.com>
 <20260624103658.792750-1-bruce.richardson@intel.com>
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

Replace strncpy() with safer strlcpy() which always null-terminates.

Fixes: aec086c9f1c8 ("common/mlx5: share kernel interface name getter")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/common/mlx5/linux/mlx5_common_os.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/common/mlx5/linux/mlx5_common_os.c b/drivers/common/mlx5/linux/mlx5_common_os.c
index e3db6c4124..53bcc9b844 100644
--- a/drivers/common/mlx5/linux/mlx5_common_os.c
+++ b/drivers/common/mlx5/linux/mlx5_common_os.c
@@ -231,7 +231,7 @@ mlx5_get_ifname_sysfs(const char *ibdev_path, char *ifname)
 		rte_errno = ENOENT;
 		return -rte_errno;
 	}
-	strncpy(ifname, match, IF_NAMESIZE);
+	strlcpy(ifname, match, IF_NAMESIZE);
 	return 0;
 }
 
-- 
2.53.0

