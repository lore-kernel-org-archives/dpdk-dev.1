Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D61CDB471
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 16:53:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B000240A84;
	Tue, 23 Jun 2026 18:52:20 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id B0F004069D;
 Tue, 23 Jun 2026 18:52:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782233538; x=1813769538;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/kZaV6d4NLoYjeHum3mNuGHOkSjEA78CVWN1hYCcZxg=;
 b=PG3u6jALRcSmVtBdTl+AfWPjQC6ay9xJb2eyFISlhij45WHydMxjgbLn
 o1Naowpiu6Uc6EZ3yRFbwmjhFcQlFds0E2ZZ9i7F3BVO42Qxow5jkAdd8
 1ZyY1CRSuIwGp0xQVDAFD3inL6Ksfd0O1VQqGYxkaHSruJa93aVRmP1Gl
 fL17dDdghDL67apIlFtFkeIG8GmYbIR/UGB9IFaxhrY+fO3AlAVaUjk/C
 0HeaX8tLAiBczJvxKXbR4hPq4xhtYR4FBiYl46r/IYE2NoLd5TFsFDiNF
 Wr7kDeOjwsx2+3EAD3px8LN+oM+Jou8kXeJBAjOAw8Kcd+OerXXtvvGQf w==;
X-CSE-ConnectionGUID: VzIuN6mAR1q1ioUZ+NLMHA==
X-CSE-MsgGUID: yl1g6LwoQ36ad31BIKH+KA==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="100534669"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; d="scan'208";a="100534669"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 09:52:17 -0700
X-CSE-ConnectionGUID: iP40oCgsSNa6l8ZorytS9g==
X-CSE-MsgGUID: 5wChud7YTsSJy9d/lVVtUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; d="scan'208";a="253928361"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.224.226])
 by orviesa004.jf.intel.com with ESMTP; 23 Jun 2026 09:52:15 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 Michael Baum <michaelba@nvidia.com>, Gregory Etelson <getelson@nvidia.com>
Subject: [PATCH 12/17] net/mlx5: replace strncpy with strlcpy
Date: Tue, 23 Jun 2026 17:51:42 +0100
Message-ID: <20260623165150.765443-13-bruce.richardson@intel.com>
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

Fixes: ca1418ce3910 ("common/mlx5: share device context object")
Fixes: 9e58a50c059f ("net/mlx5: fix interface name parameter definition")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/mlx5/mlx5.c                   | 8 ++++----
 drivers/net/mlx5/windows/mlx5_ethdev_os.c | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/mlx5/mlx5.c b/drivers/net/mlx5/mlx5.c
index 61c26d1206..24fda18710 100644
--- a/drivers/net/mlx5/mlx5.c
+++ b/drivers/net/mlx5/mlx5.c
@@ -1916,10 +1916,10 @@ mlx5_alloc_shared_dev_ctx(const struct mlx5_dev_spawn_data *spawn,
 	sh->txpp.skew = sh->config.tx_skew;
 	sh->refcnt = 1;
 	sh->max_port = spawn->max_port;
-	strncpy(sh->ibdev_name, mlx5_os_get_ctx_device_name(sh->cdev->ctx),
-		sizeof(sh->ibdev_name) - 1);
-	strncpy(sh->ibdev_path, mlx5_os_get_ctx_device_path(sh->cdev->ctx),
-		sizeof(sh->ibdev_path) - 1);
+	strlcpy(sh->ibdev_name, mlx5_os_get_ctx_device_name(sh->cdev->ctx),
+		sizeof(sh->ibdev_name));
+	strlcpy(sh->ibdev_path, mlx5_os_get_ctx_device_path(sh->cdev->ctx),
+		sizeof(sh->ibdev_path));
 	sh->phdev = mlx5_get_physical_device(sh->cdev);
 	if (!sh->phdev)
 		goto error;
diff --git a/drivers/net/mlx5/windows/mlx5_ethdev_os.c b/drivers/net/mlx5/windows/mlx5_ethdev_os.c
index e24ff367af..ecb8914a65 100644
--- a/drivers/net/mlx5/windows/mlx5_ethdev_os.c
+++ b/drivers/net/mlx5/windows/mlx5_ethdev_os.c
@@ -67,7 +67,7 @@ mlx5_get_ifname(const struct rte_eth_dev *dev, char ifname[MLX5_NAMESIZE])
 	}
 	priv = dev->data->dev_private;
 	context_obj = (mlx5_context_st *)priv->sh->cdev->ctx;
-	strncpy(ifname, context_obj->mlx5_dev.name, MLX5_NAMESIZE);
+	strlcpy(ifname, context_obj->mlx5_dev.name, MLX5_NAMESIZE);
 	return 0;
 }
 
-- 
2.53.0

