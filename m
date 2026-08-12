Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874DBC5B572
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Aug 2026 14:39:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A1E6D40298;
	Wed, 12 Aug 2026 16:39:14 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 324384025F;
 Wed, 12 Aug 2026 16:39:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786545552; x=1818081552;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=yYTUHQuS9DaBOJ5TswMAahsYqhRz2Cxixd2uAcZlFTQ=;
 b=IaWUp8vA9JTIdp8fs7OnWRKNuafqe3cMmEGCwpKxqePf5TS+1QHNB+pA
 7t4iht65QE56qntREGpGrF9UipBFBopKlmZjV26YcwvKfIHaatT27SuBC
 lWrTJRCGydOBFHcja3j/OZ8fpilnoODS809woWgJUuPypVEvwoALBMCR0
 EJiQxg+ESgOKrI3LnTmXVqecvwJ2GPqXQXnuweu6aFCs3s30SFj94MBZb
 Iq27cREZab+YSjT9jNZLiNjE2UQKRsBaCrUrIcEOIRwbQS6bMGaSwwxcJ
 J88PJzcmMSnDIF9XdBDxEZ/Z8/7CaKwmwVobT0zGuST7BjyqhQoad+3fZ w==;
X-CSE-ConnectionGUID: FRTwF/hSQcOr3b3RE5eLcQ==
X-CSE-MsgGUID: v1ldrUToRBSVjnmpKn+b4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="104635983"
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; d="scan'208";a="104635983"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2026 07:39:11 -0700
X-CSE-ConnectionGUID: mZAwsCgmR8CUiCzZS8nbhQ==
X-CSE-MsgGUID: YCEy3YsmSYOvCdndl4nuSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; d="scan'208";a="257464929"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa009.fm.intel.com with ESMTP; 12 Aug 2026 07:39:10 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH 1/2] net/i40e: preserve RSS RETA across port stop and start
Date: Wed, 12 Aug 2026 14:38:43 +0000
Message-ID: <20260812143844.71339-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
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

Currently, updating the RSS redirection table and then stopping and
starting a port loses the update. The port comes back with the default
table. The ethdev API requires RSS settings to be retained across
stop/start.

The `rss_reta_updated` flag protects a user-provided RETA from being
overwritten by the default table when the device is started. However
`i40e_dev_stop()` clears this flag, so a subsequent `i40e_dev_start()`
treats the RETA as untouched and resets it to the default.

Fix it by clearing `rss_reta_updated` in `i40e_dev_configure()` instead of
`i40e_dev_stop()`. A reconfiguration still reverts to the default table,
while a plain stop/start now preserves the RETA.

Bugzilla ID: 1127

Fixes: 36c5dc8e5d3c ("net/i40e: fix overwriting RSS RETA")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/i40e/i40e_ethdev.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index b6b2d291ee..3de3423634 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -1992,6 +1992,9 @@ i40e_dev_configure(struct rte_eth_dev *dev)
 	if (dev->data->dev_conf.rxmode.mq_mode & RTE_ETH_MQ_RX_RSS_FLAG)
 		dev->data->dev_conf.rxmode.offloads |= RTE_ETH_RX_OFFLOAD_RSS_HASH;
 
+	/* A new configuration reverts the RETA to the driver default. */
+	pf->adapter->rss_reta_updated = 0;
+
 	ret = i40e_dev_init_vlan(dev);
 	if (ret < 0)
 		goto err;
@@ -2676,8 +2679,6 @@ i40e_dev_stop(struct rte_eth_dev *dev)
 	hw->adapter_stopped = 1;
 	dev->data->dev_started = 0;
 
-	pf->adapter->rss_reta_updated = 0;
-
 	return 0;
 }
 
-- 
2.43.0

