Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80D3C5B56A
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Aug 2026 14:39:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A5A0F40BA0;
	Wed, 12 Aug 2026 16:39:15 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id E9AE74025F;
 Wed, 12 Aug 2026 16:39:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786545553; x=1818081553;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OhHnRWe2mP7nm/0wYuA3gyoL4nPF43VsRDTaS+H9F8U=;
 b=VIn/hj4BtZUvLuOR9WrhuxbE5r/zuABp8BnV1j+ujHw5fvtreCoj2ord
 2dGaSI4aBcaKEKJXY8BUrpNEZ+KKR4cdKFXWUKMn1IZ0ewaMt/5Vb93L+
 kn1V+50cZHhCcz1y4GzPUVjc6Iz7uDHopXt+DqQARhLLqjOHz5R6OeH0W
 ho1duLQYEohC/LDSKyurSTX6vQSp8EpPSLu0sMsupEcIOawILBhTZHhOu
 9pSW66GeRXJvaf/0ZZ2+uPr9nXp/epZ2EdZColWpma+CfD4Kwvl7Ii7oa
 z/jSlwJ54GPCmeISK/0u0sH4mLWAZ2hYXhs0xRcPgnjT/+Kk+GbNX8q4w w==;
X-CSE-ConnectionGUID: GrfoaC7sQQyR0mQIqH9p2A==
X-CSE-MsgGUID: 6zmQvSA4Q+WZlIs16c6cNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="104635987"
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; d="scan'208";a="104635987"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2026 07:39:12 -0700
X-CSE-ConnectionGUID: YUVaDqNNT8auvOmzFXrw7g==
X-CSE-MsgGUID: 22mMRsZcTMSXdqAvMyKNEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; d="scan'208";a="257464934"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa009.fm.intel.com with ESMTP; 12 Aug 2026 07:39:11 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH 2/2] net/i40e: program default RSS RETA at port configure
Date: Wed, 12 Aug 2026 14:38:44 +0000
Message-ID: <20260812143844.71339-2-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812143844.71339-1-ciara.loftus@intel.com>
References: <20260812143844.71339-1-ciara.loftus@intel.com>
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

Currently the default RSS redirection table is only programmed
when the port is started, in `i40e_dev_rx_init()`. Between
`rte_eth_dev_configure()` and `rte_eth_dev_start()` the table holds a
stale value, so querying it with `rte_eth_dev_rss_reta_query()` reports
entries spread over the hardware default queue count instead of the
number of Rx queues the port was just configured with.

Program the default table in `i40e_dev_configure()`, where the Rx queue
count is already known, so a query before start reflects the configured
queues. VMDQ queue counts aren't known until queue setup, so that case is
still handled at start.

Fixes: 4861cde46116 ("i40e: new poll mode driver")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/i40e/i40e_ethdev.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index 3de3423634..e84c9ea857 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -1995,6 +1995,13 @@ i40e_dev_configure(struct rte_eth_dev *dev)
 	/* A new configuration reverts the RETA to the driver default. */
 	pf->adapter->rss_reta_updated = 0;
 
+	/* Program the default RETA now while the Rx queue count is known, so that
+	 * a query before the port is started reflects the configured queues.
+	 */
+	ret = i40e_pf_reset_rss_reta(pf);
+	if (ret)
+		return ret;
+
 	ret = i40e_dev_init_vlan(dev);
 	if (ret < 0)
 		goto err;
-- 
2.43.0

