Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD244CDB47C
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 10:38:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B6F9940B9D;
	Wed, 24 Jun 2026 12:37:34 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id F18C840A6F;
 Wed, 24 Jun 2026 12:37:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782297447; x=1813833447;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3TaE8ZzRo3KZacor5xvOVSvxqZl4SZ05Garlbgq/sJ0=;
 b=P9vMBXLSQiqX73SG05OsjWff7TvjiLSDa2ZkrO4uEbkZaz1vnzJ+dzQo
 mb5VmXKq+YYy3IfwgYcsLsQ2MSLqiVCTWFDaqRps1GpwQgxKhFJ/tOLnN
 1ShyaFlK5f6UoSVfXvQQDje+Awynm+pSmrPcMNFhQAMvgIUUY0DFZ6uv+
 49CB/JvBa3opLZkeCXPeN8k5B5mVgG+a8YSBouYWcnxEF2R2dKNhE5Waq
 e1DEtxhYH/5M4+BCz8DdTZeDO6ICM0kr/wvHofje1xKTb4PCVsIHDgxIX
 NWnPOucKbnv//SYd5cnYZacuJjfp5th03iftuDhCbLHrEM0DDVRgzLWDV Q==;
X-CSE-ConnectionGUID: t/yVDbIJQyWMkdVLz2l22Q==
X-CSE-MsgGUID: LJBwHSDuRU+kC77p9jJPtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="93652386"
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="93652386"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2026 03:37:27 -0700
X-CSE-ConnectionGUID: pr3gRVvQT9u/Z2nl+rW3XA==
X-CSE-MsgGUID: QJ/ai2VDQMms9/iZjXMOIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="245460137"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.224.226])
 by fmviesa006.fm.intel.com with ESMTP; 24 Jun 2026 03:37:25 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Devendra Singh Rawat <dsinghrawat@marvell.com>,
 Alok Prasad <palok@marvell.com>, Harish Patil <harish.patil@cavium.com>,
 Rasesh Mody <rmody@marvell.com>, Sony Chacko <sony.chacko@qlogic.com>
Subject: [PATCH v2 14/17] net/qede: replace strncpy with strlcpy
Date: Wed, 24 Jun 2026 11:36:53 +0100
Message-ID: <20260624103658.792750-15-bruce.richardson@intel.com>
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

Fixes: 2ea6f76aff40 ("qede: add core driver")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/qede/qede_ethdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/qede/qede_ethdev.c b/drivers/net/qede/qede_ethdev.c
index 4efc2dd349..2f37f956cb 100644
--- a/drivers/net/qede/qede_ethdev.c
+++ b/drivers/net/qede/qede_ethdev.c
@@ -2596,7 +2596,7 @@ static int qede_common_dev_init(struct rte_eth_dev *eth_dev, bool is_vf)
 	params.drv_minor = QEDE_PMD_VERSION_MINOR;
 	params.drv_rev = QEDE_PMD_VERSION_REVISION;
 	params.drv_eng = QEDE_PMD_VERSION_PATCH;
-	strncpy((char *)params.name, QEDE_PMD_VER_PREFIX,
+	strlcpy((char *)params.name, QEDE_PMD_VER_PREFIX,
 		QEDE_PMD_DRV_VER_STR_SIZE);
 
 	qede_assign_rxtx_handlers(eth_dev, true);
-- 
2.53.0

