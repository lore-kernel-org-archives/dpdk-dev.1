Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA296D3B7E2
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Dec 2025 11:53:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5DFE0406B7;
	Mon,  8 Dec 2025 12:53:00 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 8AB8940673
 for <dev@dpdk.org>; Mon,  8 Dec 2025 12:52:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765194777; x=1796730777;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=w/7zeUoZ7mCFB1NxfN987xebHZYmo2YGUzh06uRCiPs=;
 b=FjMP9hHkSE5dTwZkjqH38+sBlvlkS3R55rQNvF7ugvP0j3wjc5knGjhA
 LZZflIpnNTGXTALMMlZewxg6P2VZoNbJ+gsOxe//rtGIYH6l6qw/HbYsy
 Rw00sB6Bg/XJ8/jHBLdbLxrVzSVbIXLFxBObtDY5Hsdj5JPIDu/w8SKRA
 isehXU6fwxlD7Fsxq/jA9POIzoF2iO5wqq4cZg9zqG35nWuggG/soLR1U
 Kvop5fgu8hGYxzkAy1Xyluu12zoCAPeaMH4/hgSq4ssq22hc5+HVjSV5+
 WbMu4Bb2izucjEGIfJPrJbsaEnuAk52TvKCX5ekiFw/NBqDDGaY9iiJe4 Q==;
X-CSE-ConnectionGUID: 0Z9KWAa+RdSFmi2BPhEhlQ==
X-CSE-MsgGUID: 8p6ih8u6SWOxqfhP6oYSrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="67096057"
X-IronPort-AV: E=Sophos;i="6.20,258,1758610800"; d="scan'208";a="67096057"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Dec 2025 03:52:56 -0800
X-CSE-ConnectionGUID: NHQzTvmXQti1dynwtDSoCQ==
X-CSE-MsgGUID: cGTbvxI0T7agnTb2RL4Fww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,258,1758610800"; d="scan'208";a="195970669"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa008.jf.intel.com with ESMTP; 08 Dec 2025 03:52:56 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 07/11] app/test: skip power capabilities test if unsupported
Date: Mon,  8 Dec 2025 11:52:41 +0000
Message-ID: <20251208115245.3809624-8-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251208115245.3809624-1-bruce.richardson@intel.com>
References: <20251202154948.1757169-1-bruce.richardson@intel.com>
 <20251208115245.3809624-1-bruce.richardson@intel.com>
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

If the power subsystem cannot be initialized e.g. due to not being root,
skip the capabilities test, rather than failing it.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/test_power_cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/app/test/test_power_cpufreq.c b/app/test/test_power_cpufreq.c
index 96de255f27..1d37b18fed 100644
--- a/app/test/test_power_cpufreq.c
+++ b/app/test/test_power_cpufreq.c
@@ -661,7 +661,7 @@ test_power_caps(void)
 			"correctly(APCI cpufreq) or operating in another valid "
 			"Power management environment\n", TEST_POWER_LCORE_ID);
 		rte_power_unset_env();
-		return -1;
+		return TEST_SKIPPED;
 	}
 
 	ret = rte_power_get_capabilities(TEST_POWER_LCORE_ID, &caps);
-- 
2.51.0

