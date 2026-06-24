Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C22CDB47C
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 10:38:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BDF1640A6C;
	Wed, 24 Jun 2026 12:37:29 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id B24424069F;
 Wed, 24 Jun 2026 12:37:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782297442; x=1813833442;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OAQ+EebEgMhBTAahJuwCKxk+l0wanJE7AJ/8mozoFYE=;
 b=BLZq5CBLo+O7ILm8aGztJoIzT70kI8BJ3eRjhdDoiidtHlMAxOtG830m
 7+urZaYN5JCouxW5qBLbfI8HHSbBtdcLbAsTbpAyq82iUAxbQF6Dumm4y
 YU97WRefryACsESY5oMw4zDCDakboooUiUMYtA+9aesGLpA93/F+aVhG6
 tHqDm4rwUYsOLGDgL6Hc2DzkPX9EKXITQpeYeYHDIFTL4gIc14d/9XhhU
 lXIhfoa+OJA9ZWLqEyiNAVUYF5wrA4VByMjX0YZAChipMBb+BMxW/PP7C
 eKofnx9H1ESgVANtveuv70l8aMiqisVgA4fApTeLCzxVj/TDUoBzQ7Q2q w==;
X-CSE-ConnectionGUID: wAu8nZUcS12uqDy2CvdafQ==
X-CSE-MsgGUID: g3JdgnpWRR2gUWnIC5Pj8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="93652366"
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="93652366"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2026 03:37:21 -0700
X-CSE-ConnectionGUID: UaWMMxPET+eFMK8VCAHKeg==
X-CSE-MsgGUID: inmKqoFsQ6OFoeRlXaECfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="245460088"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.224.226])
 by fmviesa006.fm.intel.com with ESMTP; 24 Jun 2026 03:37:20 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Matan Azrad <matan@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Adrien Mazarguil <adrien.mazarguil@6wind.com>
Subject: [PATCH v2 11/17] net/mlx4: replace strncpy with strlcpy
Date: Wed, 24 Jun 2026 11:36:50 +0100
Message-ID: <20260624103658.792750-12-bruce.richardson@intel.com>
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

Fixes: 61cbdd419478 ("net/mlx4: separate device control functions")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/mlx4/mlx4_ethdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/mlx4/mlx4_ethdev.c b/drivers/net/mlx4/mlx4_ethdev.c
index efc6ee4577..ff353af224 100644
--- a/drivers/net/mlx4/mlx4_ethdev.c
+++ b/drivers/net/mlx4/mlx4_ethdev.c
@@ -127,7 +127,7 @@ mlx4_get_ifname(const struct mlx4_priv *priv, char (*ifname)[IF_NAMESIZE])
 		rte_errno = ENODEV;
 		return -rte_errno;
 	}
-	strncpy(*ifname, match, sizeof(*ifname));
+	strlcpy(*ifname, match, sizeof(*ifname));
 	return 0;
 }
 
-- 
2.53.0

