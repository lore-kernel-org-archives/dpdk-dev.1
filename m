Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E8CCAC582
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Sep 2025 16:02:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 486894066E;
	Fri, 12 Sep 2025 18:02:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id F1B6C4065E
 for <dev@dpdk.org>; Fri, 12 Sep 2025 18:02:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757692937; x=1789228937;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=2CsvYzT7hIfdUyRXHc8C1Z+Ry6pTeJHBV6rRCfoH99U=;
 b=JxEv09GJY2gxW0Yd1N/9VomBz5KsZcSaYf5EqzEGgijh9JqV0ekCJBdo
 DwY/jY6Bb+cNVtTaMKtpfs8gD2srv9sjoUCXM8UOewkkuRBBGbpuYV/fR
 RAA/obF99gNf3LepJLLhIkT4h5InX86ECGggauiJ+tXTwHealjgpj/sa4
 vI4AJ4JyboawUo4d+WMuD9vh+EcVhDgg7xqQQaJrNIn+FzsdzFxSacvJ+
 v2zQf7ITHcSLvUVYpKiAq/u80lCl1ag24g1CLtZJ9GBhCmJdDedNPVBeo
 EuFc1OSdX0OwTbGXAYW03FK6inByHFbbAgQFRMyvZ1t6VPltAKqUuT0KW g==;
X-CSE-ConnectionGUID: CvipfLobR4CqOx11CeGjDg==
X-CSE-MsgGUID: QBO68CQXRyOPvxSv8bwCaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11551"; a="62669348"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; d="scan'208";a="62669348"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Sep 2025 09:02:16 -0700
X-CSE-ConnectionGUID: V4hFwmFtQ9+I4nHA7P5cEw==
X-CSE-MsgGUID: lo8sTlbmSwSfU9r1yHRjbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; d="scan'208";a="178319085"
Received: from silpixa00401385.ir.intel.com ([10.237.214.33])
 by orviesa004.jf.intel.com with ESMTP; 12 Sep 2025 09:02:15 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH] app/testpmd: enable warnings for possibly invalid config
Date: Fri, 12 Sep 2025 17:02:10 +0100
Message-ID: <20250912160210.388290-1-bruce.richardson@intel.com>
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

When dealing with multi-segment packets, there are separate offload
flags which should be enabled on Rx (scattered flag) and on Tx
(multi-segment flag). Print warnings on testpmd startup if we detect a
situation where we suspect the user is missing these flags, e.g. we
allow scattered packets on Rx, but not on Tx.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test-pmd/parameters.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/app/test-pmd/parameters.c b/app/test-pmd/parameters.c
index f7601df0bf..058e3c6826 100644
--- a/app/test-pmd/parameters.c
+++ b/app/test-pmd/parameters.c
@@ -1770,6 +1770,27 @@ launch_args_parse(int argc, char** argv)
 			TESTPMD_OPT_PROC_ID, proc_id,
 			TESTPMD_OPT_NUM_PROCS, num_procs);
 
+	/* check for multiple segments without scattered flag enabled */
+	if (mbuf_data_size_n > 1 && (rx_offloads & RTE_ETH_RX_OFFLOAD_SCATTER) == 0)
+		TESTPMD_LOG(WARNING, "Warning: multiple mbuf sizes specified but scattered Rx not enabled\n");
+
+	/* check for max packet size greater than mbuf size, without scatter or multi-seg flags */
+	if (max_rx_pkt_len > mbuf_data_size[0]) {
+		if ((rx_offloads & RTE_ETH_RX_OFFLOAD_SCATTER) == 0)
+			TESTPMD_LOG(WARNING, "Warning: max-pkt-len (%u) is greater than mbuf size (%u) without scattered Rx enabled\n",
+					max_rx_pkt_len, mbuf_data_size[0]);
+		if ((tx_offloads & RTE_ETH_TX_OFFLOAD_MULTI_SEGS) == 0)
+			TESTPMD_LOG(WARNING, "Warning: max-pkt-len (%u) is greater than mbuf size (%u) without multi-segment Tx enabled\n",
+					max_rx_pkt_len, mbuf_data_size[0]);
+	}
+
+	/* check for scattered Rx enabled without also having multi-segment Tx */
+	if ((rx_offloads & RTE_ETH_RX_OFFLOAD_SCATTER) != 0 &&
+			(tx_offloads & RTE_ETH_TX_OFFLOAD_MULTI_SEGS) == 0) {
+		TESTPMD_LOG(WARNING, "Warning: Scattered RX offload enabled, but TX multi-segment support not enabled.\n");
+		TESTPMD_LOG(WARNING, "         Multi-segment packets can be received but not transmitted.\n");
+	}
+
 	/* Set offload configuration from command line parameters. */
 	rx_mode.offloads = rx_offloads;
 	tx_mode.offloads = tx_offloads;
-- 
2.48.1

