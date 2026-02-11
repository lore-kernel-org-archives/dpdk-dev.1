Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 744ACECD6D3
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 18:13:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 45A7C4068E;
	Wed, 11 Feb 2026 19:13:33 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id B205F40655;
 Wed, 11 Feb 2026 19:13:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770833611; x=1802369611;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wux5c4H4oFRD2Y5Dy45gy9XtrbawGaTkAB/k0TbHVws=;
 b=kUDNl69+wAWyT094D1QUgqP7cY//jxB7iD6dRCysyhNhc0K6AJcW9Bqe
 Qa6W6LIWkNRNq1v7le3Ser1VcbhK1UHjDD5DviN4hQdHgekkEx1KLqDLb
 y4cbIN1mXlHdll2IFHCV+/P6PzBvq9+kcbBMAREQSlQB70lkh0d60U0k4
 vkwYk+z/dSHSydn4vGHxjjX+pUUjeJi9e7TwZczypegKfVFA4lSzGobeZ
 lg++70GIuo65jq0H6En6jjdeARmgE5jheEoUKIzXZJ1bQwNfN4ERZjvU8
 Vwu2FavJTWHPqsb6mU1Pb28Lfz3/2UeJwEqDhsKtYHN7lVbo2UUl3TwA2 w==;
X-CSE-ConnectionGUID: p0qEwZ05QOmVc61hBrWDoA==
X-CSE-MsgGUID: sADg89TgQlm5y6YUz4agtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="75834648"
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; d="scan'208";a="75834648"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 10:13:30 -0800
X-CSE-ConnectionGUID: /Ha3BayxSYu5l3f1iqTbLA==
X-CSE-MsgGUID: MMvZK6Q0QzW7eCIk/zfRyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; d="scan'208";a="249986244"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa001.jf.intel.com with ESMTP; 11 Feb 2026 10:13:29 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Praveen Shetty <praveen.shetty@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>, Mingxia Liu <mingxia.liu@intel.com>,
 Beilei Xing <beilei.xing@intel.com>, Qi Zhang <qi.z.zhang@intel.com>
Subject: [PATCH v5 02/35] net/intel: fix memory leak on TX queue setup failure
Date: Wed, 11 Feb 2026 18:12:31 +0000
Message-ID: <20260211181309.2838042-3-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260211181309.2838042-1-bruce.richardson@intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260211181309.2838042-1-bruce.richardson@intel.com>
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

When TX queue setup fails after sw_ring allocation but during
completion queue setup, the allocated sw_ring memory is not freed,
causing a memory leak.

This patch adds the missing rte_free() call in the error path for
both cpfl and idpf drivers to properly clean up sw_ring before
returning from the function.

Fixes: 6c2d333cd418 ("net/cpfl: support Tx queue setup")
Fixes: c008a5e740bd ("common/idpf: add queue setup/release")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/cpfl/cpfl_rxtx.c | 1 +
 drivers/net/intel/idpf/idpf_rxtx.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/intel/cpfl/cpfl_rxtx.c b/drivers/net/intel/cpfl/cpfl_rxtx.c
index 78bc3e9b49..392a7fcc98 100644
--- a/drivers/net/intel/cpfl/cpfl_rxtx.c
+++ b/drivers/net/intel/cpfl/cpfl_rxtx.c
@@ -628,6 +628,7 @@ cpfl_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	return 0;
 
 err_complq_setup:
+	rte_free(txq->sw_ring);
 err_sw_ring_alloc:
 	cpfl_dma_zone_release(mz);
 err_mz_reserve:
diff --git a/drivers/net/intel/idpf/idpf_rxtx.c b/drivers/net/intel/idpf/idpf_rxtx.c
index 8aa44585fe..9317c8b175 100644
--- a/drivers/net/intel/idpf/idpf_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_rxtx.c
@@ -502,6 +502,7 @@ idpf_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	return 0;
 
 err_complq_setup:
+	rte_free(txq->sw_ring);
 err_sw_ring_alloc:
 	idpf_dma_zone_release(mz);
 err_mz_reserve:
-- 
2.51.0

