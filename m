Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C21ADCCFA05
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 15:54:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A070040E7C;
	Fri,  7 Nov 2025 16:51:38 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 9B99240E0C
 for <dev@dpdk.org>; Fri,  7 Nov 2025 16:51:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762530697; x=1794066697;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fxpFw8tb3RPyieBTqEsl9tyUm6XwF+82ijWSU8ZBFPE=;
 b=N9tgML2sFfvVhDIPPMdLge3//gqyyoQ4LHoKM5PM9NAZNtVb/wknfcUS
 POQWIRBXthpmGm/hrJRUZPt4aK2VCRq+gZb34XBndb12XoN09m5OVffy6
 bh6W6Dv3oBptVPS/RtGQ+JRnoryZHzwRkgq+/m+OsC19mi/kZvaCl+WB3
 JvOt3Y+ZtGvM6X9KpkVdKbg9J8rcRvisPg6+eSqc5QM/cPCscnI40t/fq
 edkR/oLguBGzuuyzM6X3Vn7tZGVLM/AkktwvGliSsHKiRDS9GgRAZtab4
 vENe0GBeR+VAWyvNBnUgOgu4a3svGLGEit6Eq8bCxwsCE7f6ufneQiaxB w==;
X-CSE-ConnectionGUID: d10AYjijR52eVDy26Y/X3g==
X-CSE-MsgGUID: MUyshHcrR7y/Jhq5NoLjpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11606"; a="90151878"
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; d="scan'208";a="90151878"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2025 07:51:36 -0800
X-CSE-ConnectionGUID: 96df0Oi/QpKcVmfUJQDr5w==
X-CSE-MsgGUID: abFSCn0iQZWWinfyLd24iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; d="scan'208";a="187321769"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa006.jf.intel.com with ESMTP; 07 Nov 2025 07:51:36 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Cheng Jiang <honest.jiang@foxmail.com>,
 Chengwen Feng <fengchengwen@huawei.com>
Subject: [RFC PATCH v2 25/33] app/test-dma-perf: renamed shadowed variable
Date: Fri,  7 Nov 2025 15:50:21 +0000
Message-ID: <20251107155034.436809-26-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251107155034.436809-1-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20251107155034.436809-1-bruce.richardson@intel.com>
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

Rename second instance of variable named "i" in load_configs() to avoid
shadowing warnings.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test-dma-perf/main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/app/test-dma-perf/main.c b/app/test-dma-perf/main.c
index 4201cc02a0..64baa255f3 100644
--- a/app/test-dma-perf/main.c
+++ b/app/test-dma-perf/main.c
@@ -436,9 +436,9 @@ load_configs(const char *path)
 				nb_vp++;
 
 			char lc_dma[RTE_DEV_NAME_MAX_LEN];
-			int i = 0;
+			int dma_id = 0;
 			while (1) {
-				snprintf(lc_dma, RTE_DEV_NAME_MAX_LEN, "lcore_dma%d", i);
+				snprintf(lc_dma, RTE_DEV_NAME_MAX_LEN, "lcore_dma%d", dma_id);
 				lcore_dma = rte_cfgfile_get_entry(cfgfile, section_name, lc_dma);
 				if (lcore_dma == NULL)
 					break;
@@ -451,13 +451,13 @@ load_configs(const char *path)
 				}
 
 				if (rte_kvargs_process(kvlist, NULL, populate_dma_dev_config,
-						       (void *)&test_case->dma_config[i]) < 0) {
+						       (void *)&test_case->dma_config[dma_id]) < 0) {
 					printf("rte_kvargs_process() error\n");
 					rte_kvargs_free(kvlist);
 					test_case->is_valid = false;
 					break;
 				}
-				i++;
+				dma_id++;
 				test_case->num_worker++;
 				rte_kvargs_free(kvlist);
 			}
-- 
2.48.1

