Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87228C19F32
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Mar 2025 16:25:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4EFCA40275;
	Wed,  5 Mar 2025 17:25:12 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 9B3494025F;
 Wed,  5 Mar 2025 17:25:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741191911; x=1772727911;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=82exrEojlsw1Uq6u9S6C+TDBhW9OaQuwNDhEky3LR9A=;
 b=BuFunLyOZc2g38JoKsK4Wqb64KABEVYNlhlNUAuXmfsabEUPOgAYCSCU
 KQxvdqeQKPa/AHsiA97Y+xqN2fd+XAyEK0HqGWefFoOskJa4ZXUvqC3w8
 +8R/RFkRhRIHU70WxX+MBvpoBtHbhFzvPPxipIRx3bFyL0123nG9Ppuxi
 fjps8RLpLUL/1vZJJUBabMiixEoQsCHvtqYSkxpfSU5luiEV+gQoKNgPg
 ajTk6mofzRWHAxF/FImKK1FCtxJT4HuJrIu+0TifR3uH6Ux0BGlgpcSdA
 +JKRmTnhc7ma+hU4bysmHPR2HKX9Jb97g0Jk2bRwH1x/phQhd4DmpfwBV A==;
X-CSE-ConnectionGUID: i3KI3BRoRQ+V0QKABWKQRg==
X-CSE-MsgGUID: xkw+7c8fTKKFkSGK8kuhiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="53563643"
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; d="scan'208";a="53563643"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2025 08:25:10 -0800
X-CSE-ConnectionGUID: mBgrx6GGTOe0oCDK+m4B2Q==
X-CSE-MsgGUID: Pjn9CWTRTTO4AoX2sM4Pxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; d="scan'208";a="119431809"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.43])
 by fmviesa009.fm.intel.com with ESMTP; 05 Mar 2025 08:25:08 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Anatoly Burakov <anatoly.burakov@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org
Subject: [PATCH v2] eal: fix undetected NUMA nodes
Date: Wed,  5 Mar 2025 16:24:58 +0000
Message-ID: <20250305162458.1059282-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250305134720.907347-1-bruce.richardson@intel.com>
References: <20250305134720.907347-1-bruce.richardson@intel.com>
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

In cases where the number of cores on a given socket is greater than
RTE_MAX_LCORES, then EAL will be unaware of all the sockets/numa nodes
on a system. Fix this limitation by having the EAL probe the NUMA node
for cores it isn't going to use, and recording that for completeness.

This is necessary as memory is tracked per node, and with the --lcores
parameters our app lcores may be on different sockets than the lcore ids
may imply. For example, lcore 0 is on socket zero, but if app is run
with --lcores=0@64, then DPDK lcore 0 may be on socket one, so DPDK
needs to be aware of that socket.

Fixes: 952b20777255 ("eal: provide API for querying valid socket ids")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

---
v2: handle case where RTE_MAX_LCORE > CPU_SETSIZE (i.e. >1024)
---
 lib/eal/common/eal_common_lcore.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/lib/eal/common/eal_common_lcore.c b/lib/eal/common/eal_common_lcore.c
index 2ff9252c52..820a6534b1 100644
--- a/lib/eal/common/eal_common_lcore.c
+++ b/lib/eal/common/eal_common_lcore.c
@@ -144,7 +144,11 @@ rte_eal_cpu_init(void)
 	unsigned lcore_id;
 	unsigned count = 0;
 	unsigned int socket_id, prev_socket_id;
-	int lcore_to_socket_id[RTE_MAX_LCORE];
+#if CPU_SETSIZE > RTE_MAX_LCORE
+	int lcore_to_socket_id[CPU_SETSIZE] = {0};
+#else
+	int lcore_to_socket_id[RTE_MAX_LCORE] = {0};
+#endif
 
 	/*
 	 * Parse the maximum set of logical cores, detect the subset of running
@@ -183,9 +187,11 @@ rte_eal_cpu_init(void)
 	for (; lcore_id < CPU_SETSIZE; lcore_id++) {
 		if (eal_cpu_detected(lcore_id) == 0)
 			continue;
+		socket_id = eal_cpu_socket_id(lcore_id);
+		lcore_to_socket_id[lcore_id] = socket_id;
 		EAL_LOG(DEBUG, "Skipped lcore %u as core %u on socket %u",
 			lcore_id, eal_cpu_core_id(lcore_id),
-			eal_cpu_socket_id(lcore_id));
+			socket_id);
 	}
 
 	/* Set the count of enabled logical cores of the EAL configuration */
@@ -201,12 +207,13 @@ rte_eal_cpu_init(void)
 
 	prev_socket_id = -1;
 	config->numa_node_count = 0;
-	for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
+	for (lcore_id = 0; lcore_id < RTE_DIM(lcore_to_socket_id); lcore_id++) {
 		socket_id = lcore_to_socket_id[lcore_id];
 		if (socket_id != prev_socket_id)
-			config->numa_nodes[config->numa_node_count++] =
-					socket_id;
+			config->numa_nodes[config->numa_node_count++] =	socket_id;
 		prev_socket_id = socket_id;
+		if (config->numa_node_count >= RTE_MAX_NUMA_NODES)
+			break;
 	}
 	EAL_LOG(INFO, "Detected NUMA nodes: %u", config->numa_node_count);
 
-- 
2.43.0

