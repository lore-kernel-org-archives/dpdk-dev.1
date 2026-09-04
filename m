Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F15EAC61DD6
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Sep 2026 13:38:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B2E6140A77;
	Fri,  4 Sep 2026 15:38:52 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 680944021F;
 Fri,  4 Sep 2026 15:38:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788529132; x=1820065132;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=OM0ElBsQ3BfodEdwR7goQK73TDKXXQxDtdBlAm9uOPA=;
 b=clQ633wX9mEPpwJrY+ghO6lEtlwqJW4mO/Y7ekthkSm0wDWJTXd2h7oR
 M5zNVpueIEblslyhsRP8oCFi0DqyWvMqa76AbxrL9IjNoDMDhDKnJeYNH
 8SUb1S/mPBeebN4sNjX31/K9T1NwECOw+VaNxTOvukaBRjqa2YJiaAxAh
 BeQOmbcQrpJW2dEU+TElaHYrd4DUgCCLk4t9EGOtWivhxT79cUrgSU/X2
 k3dHXuqATYyv76h9gfeJvT2D8dm0StoTlhTBDVNJdaSgbnl3tHMBB6pxJ
 g8Fg+xfVMo1ocSrBvFrtr4k9QS7HyZptpAsPISDz5vXKeZ1ZhdDIdnokq A==;
X-CSE-ConnectionGUID: TEo8zsSLTBOUw9D2irnTDQ==
X-CSE-MsgGUID: OcfbivIeQT2tJ82greHtfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="89239212"
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; d="scan'208";a="89239212"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2026 06:38:50 -0700
X-CSE-ConnectionGUID: 4Yy8n9d3TJyQyv5IKq3E2g==
X-CSE-MsgGUID: R7ppzbxTRP+P1D01YgPIiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; d="scan'208";a="293553739"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa002.fm.intel.com with ESMTP; 04 Sep 2026 06:38:49 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH] app/testpmd: fix stale queue-count check order
Date: Fri,  4 Sep 2026 13:38:42 +0000
Message-ID: <20260904133842.3155785-1-ciara.loftus@intel.com>
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

Currently, when setting the number of queues via `port config all txq/rxq`,
testpmd validates the requested queue count against a device's current
queue-count limits, then rebuilds the forwarding stream configuration
before refreshing each port's cached device information. The forwarding
stream setup step re-checks the requested queue count against that cache,
so it can still reject a value that was just accepted if the cached
limits are older than the freshly queried ones.

This is not observable while a port's queue-count limits stay fixed
for its lifetime. It becomes visible whenever a PMD's reported
`max_rx_queues`/`max_tx_queues` change after the port was first probed,
for example when a driver recomputes queue capacity in response to a
traffic management (`rte_tm`) hierarchy commit. The stale cached values
then no longer match what the device currently reports, so a queue count
that is actually valid can be wrongly rejected.

Fix it by refreshing the cached device information before rebuilding
the forwarding stream configuration, so both checks operate on the same,
current queue-count limits.

Fixes: 0c0db76f42ed ("app/testpmd: separate forward config setup from display")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 app/test-pmd/cmdline.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index 10ee7c5179..95a4ebfb96 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -2010,10 +2010,10 @@ cmd_config_rx_tx_parsed(void *parsed_result,
 		return;
 	}
 
-	fwd_config_setup();
-
 	init_port_config();
 
+	fwd_config_setup();
+
 	cmd_reconfig_device_queue(RTE_PORT_ALL, 1, 1);
 }
 
-- 
2.43.0

