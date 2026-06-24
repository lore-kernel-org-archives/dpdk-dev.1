Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C288CDB47C
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 10:38:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F99C40B8C;
	Wed, 24 Jun 2026 12:37:31 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id E132340616;
 Wed, 24 Jun 2026 12:37:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782297444; x=1813833444;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/kZaV6d4NLoYjeHum3mNuGHOkSjEA78CVWN1hYCcZxg=;
 b=DLL+0ryUIJREKlgktvwI/R+LzG4IcaHKYnzdCiCfTN6lVil+v8tr+A6i
 vPXu9G9ONm04vSu+7Kd0FcMmTRZW2wH8/0/5T1gcVYcZi+JWW+ycaGJo3
 eGlREPZrOBPQVSiKGdLAYDhdVOPRI+wK2/qATxOr+gDDhUDCE3TTIxqV9
 SCoyJOdWx7OQHNWBvh37u2fcGCEARmJ5dV8yqJ5IFKJEX4bQoNAxjzmFC
 tTP/y8SHhZwVnnNLWcar31t9HzoNfvfVYwQd1BojJSrnLjA6WwvZcICxQ
 wVemgUnWfso85SeC42yKiOr6cjcasj6dGDtZj3T1b+Y5HgHjQvDsv3Csf w==;
X-CSE-ConnectionGUID: lBCOBkAtTiOHYZeuvibd+w==
X-CSE-MsgGUID: Z89dr5OdTq2FXfNTR86E7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="93652375"
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="93652375"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2026 03:37:24 -0700
X-CSE-ConnectionGUID: CMBzpj/wQai8j9c9z/TZ3w==
X-CSE-MsgGUID: 2Vet+6eKRMGjE8VQxegPVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="245460098"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.224.226])
 by fmviesa006.fm.intel.com with ESMTP; 24 Jun 2026 03:37:21 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 Michael Baum <michaelba@nvidia.com>, Gregory Etelson <getelson@nvidia.com>
Subject: [PATCH v2 12/17] net/mlx5: replace strncpy with strlcpy
Date: Wed, 24 Jun 2026 11:36:51 +0100
Message-ID: <20260624103658.792750-13-bruce.richardson@intel.com>
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

