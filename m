Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCF0C83F21
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Jul 2025 12:54:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 204A3402E2;
	Tue, 15 Jul 2025 14:54:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 266FD4021E
 for <dev@dpdk.org>; Tue, 15 Jul 2025 14:54:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752584045; x=1784120045;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Srrt8I8bK+v0NPjR/gDsfB70DVnNcvqzUu7Hx9GNV4Q=;
 b=AGX6X+ssuEz/4203iHGcvl773j7bMEDvRJbfx3XQb+V0//o4c0nj8P8n
 2QZ3z1a5LxPwh2Ne+G8Jbce5hq0voeO7Fs/5rYF6ipRxT69dotuDf4IPj
 WjRRuLeK7VdQuusFEJv5Mx/4lclEsnb1ftQACdpPt97aBvpZfofFuoY8u
 2zQ+qYnSehFPx/Tt8efTZ4Fsjbcw/9KUy08xZfB9hjaCTUNAQcJQOrTPh
 66GFsqeG+pVEZRW+A5qyS7Veqb8y8LM/KeYjBUhcyJ/I3fYYiLyXXDoqe
 WYJxttLBPRpB9IgZ+97nKAO24XnNoSBeagu6YaeeLIgxDVw35NUjWBKUz w==;
X-CSE-ConnectionGUID: tH5Olm2GTcKWnttJORG7zw==
X-CSE-MsgGUID: Qmz8KXCzQ2aiij/DuAzgdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="58609490"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; d="scan'208";a="58609490"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2025 05:53:43 -0700
X-CSE-ConnectionGUID: gksHPXh5QuGh1aNMWwd38A==
X-CSE-MsgGUID: b1a5dKbeRDK44iqlKuqkjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; d="scan'208";a="161530785"
Received: from silpixa00401874.ir.intel.com (HELO
 silpixa00401874.ger.corp.intel.com) ([10.55.129.54])
 by fmviesa005.fm.intel.com with ESMTP; 15 Jul 2025 05:53:42 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH] app/testpmd: add flag to enable RSS for single-queue
Date: Tue, 15 Jul 2025 12:53:30 +0000
Message-ID: <20250715125330.2127309-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
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

For testing purposes it can be desirable to enable RSS even when only a
single queue per port is in use. Add an "enable-rss" flag to testpmd to
match the existing "disable-rss" flag.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test-pmd/parameters.c | 13 +++++++++++++
 app/test-pmd/testpmd.c    |  3 ++-
 app/test-pmd/testpmd.h    |  1 +
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/app/test-pmd/parameters.c b/app/test-pmd/parameters.c
index 1132972913..80c6ecae54 100644
--- a/app/test-pmd/parameters.c
+++ b/app/test-pmd/parameters.c
@@ -121,6 +121,8 @@ enum {
 	TESTPMD_OPT_ENABLE_DROP_EN_NUM,
 #define TESTPMD_OPT_DISABLE_RSS "disable-rss"
 	TESTPMD_OPT_DISABLE_RSS_NUM,
+#define TESTPMD_OPT_ENABLE_RSS "enable-rss"
+	TESTPMD_OPT_ENABLE_RSS_NUM,
 #define TESTPMD_OPT_PORT_TOPOLOGY "port-topology"
 	TESTPMD_OPT_PORT_TOPOLOGY_NUM,
 #define TESTPMD_OPT_FORWARD_MODE "forward-mode"
@@ -310,6 +312,7 @@ static const struct option long_options[] = {
 	NO_ARG(TESTPMD_OPT_ENABLE_HW_QINQ_STRIP),
 	NO_ARG(TESTPMD_OPT_ENABLE_DROP_EN),
 	NO_ARG(TESTPMD_OPT_DISABLE_RSS),
+	NO_ARG(TESTPMD_OPT_ENABLE_RSS),
 	REQUIRED_ARG(TESTPMD_OPT_PORT_TOPOLOGY),
 	REQUIRED_ARG(TESTPMD_OPT_FORWARD_MODE),
 	NO_ARG(TESTPMD_OPT_RSS_IP),
@@ -454,6 +457,7 @@ usage(char* progname)
 	printf("  --enable-hw-qinq-strip: enable hardware qinq strip.\n");
 	printf("  --enable-drop-en: enable per queue packet drop.\n");
 	printf("  --disable-rss: disable rss.\n");
+	printf("  --enable-rss: Force rss even for single-queue operation.\n");
 	printf("  --port-topology=<paired|chained|loop>: set port topology (paired "
 	       "is default).\n");
 	printf("  --forward-mode=N: set forwarding mode (N: %s).\n",
@@ -1244,8 +1248,17 @@ launch_args_parse(int argc, char** argv)
 			rx_drop_en = 1;
 			break;
 		case TESTPMD_OPT_DISABLE_RSS_NUM:
+			if (force_rss)
+				rte_exit(EXIT_FAILURE, "Invalid option combination, %s and %s\n",
+						TESTPMD_OPT_DISABLE_RSS, TESTPMD_OPT_ENABLE_RSS);
 			rss_hf = 0;
 			break;
+		case TESTPMD_OPT_ENABLE_RSS_NUM:
+			if (rss_hf == 0)
+				rte_exit(EXIT_FAILURE, "Invalid option combination, %s and %s\n",
+						TESTPMD_OPT_DISABLE_RSS, TESTPMD_OPT_ENABLE_RSS);
+			force_rss = true;
+			break;
 		case TESTPMD_OPT_PORT_TOPOLOGY_NUM:
 			if (!strcmp(optarg, "paired"))
 				port_topology = PORT_TOPOLOGY_PAIRED;
diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index bb88555328..8bb4b1c762 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -382,6 +382,7 @@ uint64_t noisy_lkup_num_reads_writes;
  * Receive Side Scaling (RSS) configuration.
  */
 uint64_t rss_hf = RTE_ETH_RSS_IP; /* RSS IP by default. */
+bool force_rss;                   /* false == for single queue don't force rss */
 
 /*
  * Port topology configuration
@@ -4007,7 +4008,7 @@ init_port_config(void)
 		if (ret != 0)
 			return;
 
-		if (nb_rxq > 1) {
+		if (nb_rxq > 1 || force_rss) {
 			port->dev_conf.rx_adv_conf.rss_conf.rss_key = NULL;
 			port->dev_conf.rx_adv_conf.rss_conf.rss_hf =
 				rss_hf & port->dev_info.flow_type_rss_offloads;
diff --git a/app/test-pmd/testpmd.h b/app/test-pmd/testpmd.h
index e629edaa02..96ac88a29c 100644
--- a/app/test-pmd/testpmd.h
+++ b/app/test-pmd/testpmd.h
@@ -576,6 +576,7 @@ extern struct rte_eth_rxmode rx_mode;
 extern struct rte_eth_txmode tx_mode;
 
 extern uint64_t rss_hf;
+extern bool force_rss;
 
 extern queueid_t nb_hairpinq;
 extern queueid_t nb_rxq;
-- 
2.48.1

