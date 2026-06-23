Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A51CDB471
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 16:53:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 180A040697;
	Tue, 23 Jun 2026 18:52:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 5B5F940B95;
 Tue, 23 Jun 2026 18:52:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782233544; x=1813769544;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NHZjYBtDXRL9rH2bqsUlB9gwcnJzCHEPEjdaWJcX46Y=;
 b=WlcKl//kQx15YfKYDRkx+4LZYoP4tJ+521XZ+ggnhFFPvwvlrJ1a6j4D
 lejwHDN1AWgVNv68govB37hYL0bLq9m3CWfiteUYR4IA4ZKRTGj2gQwmc
 JUAzYjBKZ51+ncIGjBEn8NqUIR6kDv+LUcxsX+FwunEQ8iCnLKpt7Qi3C
 eY3bA+SE8N8fi71zs+g35j6gIhsDNPlE6PBZOU8ABPyDWCEf9QztDU7f1
 m1Fu1hoYB7XUcTCvr31LBzLigbSYUEzNHQOz/rgCzBKS/wlhwdUj1R6VP
 AEOn8YR25WIenUfDCCQcFos23wo7W9i2XZbVtj6LCMosAK/RPNmHLcShS A==;
X-CSE-ConnectionGUID: v4VoHULuQ++6ud6lOAjF7w==
X-CSE-MsgGUID: 2MKhXx5LTlm6VMTelw3wog==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="100534684"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; d="scan'208";a="100534684"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 09:52:23 -0700
X-CSE-ConnectionGUID: 287cXyZbRL+KKxbyMx8bxA==
X-CSE-MsgGUID: xi0b9mZ3TIenE/ULgUeIlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; d="scan'208";a="253928392"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.224.226])
 by orviesa004.jf.intel.com with ESMTP; 23 Jun 2026 09:52:21 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH 16/17] net/vhost: replace strncpy with strlcpy
Date: Tue, 23 Jun 2026 17:51:46 +0100
Message-ID: <20260623165150.765443-17-bruce.richardson@intel.com>
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

Fixes: 2e16597c4bda ("net/vhost: move to vhost library statistics API")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/vhost/rte_eth_vhost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/vhost/rte_eth_vhost.c b/drivers/net/vhost/rte_eth_vhost.c
index 05940f2461..82e9fc929a 100644
--- a/drivers/net/vhost/rte_eth_vhost.c
+++ b/drivers/net/vhost/rte_eth_vhost.c
@@ -209,7 +209,7 @@ vhost_dev_xstats_get_names(struct rte_eth_dev *dev,
 	}
 
 	for (i = 0; i < count; i++)
-		strncpy(xstats_names[i].name, name[i].name, RTE_ETH_XSTATS_NAME_SIZE);
+		strlcpy(xstats_names[i].name, name[i].name, RTE_ETH_XSTATS_NAME_SIZE);
 
 	free(name);
 
-- 
2.53.0

