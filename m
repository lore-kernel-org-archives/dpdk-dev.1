Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BB2C36010
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Apr 2025 02:07:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BBF084042C;
	Wed,  9 Apr 2025 04:07:56 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 4D49F40265;
 Wed,  9 Apr 2025 04:07:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744164475; x=1775700475;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=rdXfOZCd9jK0Ap7hS03VWJtYhw7SaASs5ghddFPORwM=;
 b=W3w/CJ6d5g4Y2ZjIfBKYTbtMrlJxNiV8bP/RN/tZnpPrI1Si0ELEG92N
 vtAQ1ojpEceLAmSsCPBViQPB+vR1/9JmFSRQgwR7Y7jbs9qaownETTNRT
 mp/kALAjO1GPDKosTbRMFXbA/n6fnuhj6PTQsdvo3/EnuKqs8nX0RjGbL
 r8fa5/Uk6wN1vx5AgBMgcPyjs8Y+GQH/R8k/y6E4XA3iLU2hQS0U8RVkm
 NxKmrMUb1s8DsUgqVuRao4+Ma+H9XrlE4lhUpZ9wAG9LzshdSw6g49Rbs
 SqRsM5L6ybC/+dTWyB7SjRpIoSWY62h/8aVU6HZtll9RUSM+CMXcPW+9C A==;
X-CSE-ConnectionGUID: LJgljuhDRtytfYH6HCLQdQ==
X-CSE-MsgGUID: x5svBHhLR5ymdA177BCitA==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="45509376"
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; d="scan'208";a="45509376"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2025 19:07:54 -0700
X-CSE-ConnectionGUID: HgH37V0yQHaff20bW0j97A==
X-CSE-MsgGUID: v+A3DfpGTb2zRykV9Dn5vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; d="scan'208";a="133423609"
Received: from shwdenpg561.ccr.corp.intel.com (HELO dpdk..) ([10.239.252.3])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2025 19:07:52 -0700
From: Kaiwen Deng <kaiwenx.deng@intel.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Kaiwen Deng <kaiwenx.deng@intel.com>,
 Maryam Tahhan <mtahhan@redhat.com>,
 Harry van Haaren <harry.van.haaren@intel.com>
Subject: [PATCH] net/igb: fix xstats name
Date: Wed,  9 Apr 2025 09:06:41 +0800
Message-Id: <20250409010641.760884-1-kaiwenx.deng@intel.com>
X-Mailer: git-send-email 2.34.1
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

The xstats name needs to be changed correctly.
tx_size_1023_to_max_packets should be tx_size_1024_to_max_packets.

Fixes: 38552317dcef ("igb: add extended stats")
Cc: stable@dpdk.org

Signed-off-by: Kaiwen Deng <kaiwenx.deng@intel.com>
---
 drivers/net/intel/e1000/igb_ethdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/e1000/igb_ethdev.c b/drivers/net/intel/e1000/igb_ethdev.c
index cbd2f15f5f..40f453c8d9 100644
--- a/drivers/net/intel/e1000/igb_ethdev.c
+++ b/drivers/net/intel/e1000/igb_ethdev.c
@@ -486,7 +486,7 @@ static const struct rte_igb_xstats_name_off rte_igb_stats_strings[] = {
 	{"tx_size_256_to_511_packets", offsetof(struct e1000_hw_stats, ptc511)},
 	{"tx_size_512_to_1023_packets", offsetof(struct e1000_hw_stats,
 		ptc1023)},
-	{"tx_size_1023_to_max_packets", offsetof(struct e1000_hw_stats,
+	{"tx_size_1024_to_max_packets", offsetof(struct e1000_hw_stats,
 		ptc1522)},
 	{"tx_multicast_packets", offsetof(struct e1000_hw_stats, mptc)},
 	{"tx_broadcast_packets", offsetof(struct e1000_hw_stats, bptc)},
-- 
2.34.1

