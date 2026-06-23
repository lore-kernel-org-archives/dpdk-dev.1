Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3A1CDB471
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 16:53:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 178EC40A76;
	Tue, 23 Jun 2026 18:52:18 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 3AFEC40A71;
 Tue, 23 Jun 2026 18:52:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782233536; x=1813769536;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OAQ+EebEgMhBTAahJuwCKxk+l0wanJE7AJ/8mozoFYE=;
 b=CZiqu50XB7MUFOqzNAg3Hp89bP0N9KgLB1WCKPfSl8tS0trJm5YgsCSx
 gaDEXHuq5DPvnES8ia8W8+Lkx8dE1Dm/coZQQusZ/2bg5ciQgL82p7kAT
 bcfpHBemDzrnfovV8JTuGNh59xhWbxQnm0GAuCs0Aw4KP2k1fdQDAEX9W
 bVu3ULNEhe6UDOBnrA498sfybbTKHFz8Nw5CPq7nuuwGOXv78ljdYOFsL
 C0774sBVX4nQ9Iwk7Aw2rhRHU8tjGjCffW+L3s2UXGtYGLlfRoLiwUNIi
 mzh3aq9X8KBGsK2zjFQpAikLp79ozihUx74xZJkeOeRi/Mxl7JVAmukwF g==;
X-CSE-ConnectionGUID: 1yBh+OrGTzmzL4MjyzOXnw==
X-CSE-MsgGUID: F2mY7I4GTnC6sG4MibTmCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="100534659"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; d="scan'208";a="100534659"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 09:52:15 -0700
X-CSE-ConnectionGUID: 2OT00XTQSsaYIgMbmNjOzA==
X-CSE-MsgGUID: Kyx//1l/RHac3Uw4h4AjBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; d="scan'208";a="253928351"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.224.226])
 by orviesa004.jf.intel.com with ESMTP; 23 Jun 2026 09:52:13 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Matan Azrad <matan@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Adrien Mazarguil <adrien.mazarguil@6wind.com>
Subject: [PATCH 11/17] net/mlx4: replace strncpy with strlcpy
Date: Tue, 23 Jun 2026 17:51:41 +0100
Message-ID: <20260623165150.765443-12-bruce.richardson@intel.com>
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

