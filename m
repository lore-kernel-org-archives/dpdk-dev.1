Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E19CDB471
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 16:52:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C5855402AD;
	Tue, 23 Jun 2026 18:52:01 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 4BBC44065F;
 Tue, 23 Jun 2026 18:52:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782233521; x=1813769521;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VQXecjmkp7v/H3jK7M7jiMob2r4LVZTk0m9A8k1UNPM=;
 b=kmcQvcWvpLQo8gdIU8PWQ9+PpGcRhtwj9UJLBmm0/iPKqS8q6X81yA2g
 /lKaniIw/HUBmQ56nkE0d5mmmakUEycnT7MCeTfq78pc2SVelxPOE3yPc
 ouvXj2HMRmGp+BLbjrpYK7EhtZPxZrtTHDi94VZAnPyQcxynu6wHkCzMl
 t5k4TTfz0ACOYHkFsnsaUn+TMMWcUb36J+f91J967v61obJqmcPfueV3d
 r1tRoh+aTkRpsI2UBGfzzuSNKsR4Xo7v64CsZby3qpKFT3szpcRFXQuou
 Bv+RFP7bblnvVzUU/iuTCQbDzV6evBu44w6FGRKsgWExG/0bk5lOZrQGU g==;
X-CSE-ConnectionGUID: F5bOp9/qQx28S967xMxiZA==
X-CSE-MsgGUID: +LMpQLlbSzK1szI3R4tZrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="100534620"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; d="scan'208";a="100534620"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 09:52:00 -0700
X-CSE-ConnectionGUID: QqLz55Y7To2NPVJXghe3lg==
X-CSE-MsgGUID: TGjXDD4bRl+bArKkeRS6qA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; d="scan'208";a="253928284"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.224.226])
 by orviesa004.jf.intel.com with ESMTP; 23 Jun 2026 09:51:58 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [PATCH 02/17] common/mlx5: replace strncpy with strlcpy
Date: Tue, 23 Jun 2026 17:51:32 +0100
Message-ID: <20260623165150.765443-3-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260623165150.765443-1-bruce.richardson@intel.com>
References: <20260623165150.765443-1-bruce.richardson@intel.com>
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

