Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D088DC87FCE
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Jul 2025 12:51:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A79240649;
	Fri, 25 Jul 2025 14:50:17 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 3B9BE40616
 for <dev@dpdk.org>; Fri, 25 Jul 2025 14:50:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753447813; x=1784983813;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DQRzelnLO5jNU+AhkUP4e66fJEWnb26HjRkwjpSagvQ=;
 b=OM+XigRxPd73eoLz5jrhQa4d284AVyFu7TY8gzUB/Cn3GHZ/kzy+Jdvl
 bcIOTsTppxDoKEzA9RlLkB2waEEFd7Uld9bY8/sZDCMRB+AcA1s0c6VMk
 aU9IQOpXJQGw1794r+ShQR7NgTrLcbP+DbI6hzb6PbilPPfKevqM0CJ2b
 tLEc68w2t6wPbDbrz8LLmmt04GDaGsI1aleIN03oqwhy3s1K2zMG1KS8e
 TVVGpgj6WX4SU4FFIrY797VsM0Z6LyqlutF7HnyP61geIbBz+gRdRZRwQ
 SlvrKDipFL4gizQjSiEuBUKlwL3u3xLnOq4XxvJIdEmma1Jsyw3kRotXE Q==;
X-CSE-ConnectionGUID: hphDpad7QUiTqqia3u94hg==
X-CSE-MsgGUID: geOihTT9SlCBc+UFex0ohg==
X-IronPort-AV: E=McAfee;i="6800,10657,11503"; a="66480153"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; d="scan'208";a="66480153"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jul 2025 05:50:13 -0700
X-CSE-ConnectionGUID: Ja9EiClMTjWTWxeOa/QNBA==
X-CSE-MsgGUID: N6a3Rr8ZSfao4zDpoA43CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; d="scan'208";a="161152308"
Received: from silpixa00401177.ir.intel.com ([10.237.213.77])
 by orviesa007.jf.intel.com with ESMTP; 25 Jul 2025 05:50:12 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [RFC PATCH 07/14] net/iavf: use the new common vector capability
 function
Date: Fri, 25 Jul 2025 12:49:12 +0000
Message-Id: <20250725124919.3564890-8-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250725124919.3564890-1-ciara.loftus@intel.com>
References: <20250725124919.3564890-1-ciara.loftus@intel.com>
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

Use the new function for determining the maximum simd bitwidth in
the iavf driver.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/iavf/iavf_rxtx.c         | 27 +++++-----------------
 drivers/net/intel/iavf/iavf_rxtx.h         |  1 +
 drivers/net/intel/iavf/iavf_rxtx_vec_sse.c |  6 +++++
 3 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index 3329499e59..e36a07d5ac 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -3970,21 +3970,13 @@ iavf_set_rx_function(struct rte_eth_dev *dev)
 	int check_ret;
 	bool use_avx2 = false;
 	bool use_avx512 = false;
+	enum rte_vect_max_simd rx_simd_path = iavf_get_max_simd_bitwidth();
 
 	check_ret = iavf_rx_vec_dev_check(dev);
 	if (check_ret >= 0 &&
 	    rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_128) {
-		if ((rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX2) == 1 ||
-		     rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512F) == 1) &&
-		    rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_256)
-			use_avx2 = true;
-
-#ifdef CC_AVX512_SUPPORT
-		if (rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512F) == 1 &&
-		    rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512BW) == 1 &&
-		    rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_512)
-			use_avx512 = true;
-#endif
+		use_avx2 = rx_simd_path == RTE_VECT_SIMD_256;
+		use_avx512 = rx_simd_path == RTE_VECT_SIMD_512;
 
 		for (i = 0; i < dev->data->nb_rx_queues; i++) {
 			rxq = dev->data->rx_queues[i];
@@ -4129,6 +4121,7 @@ iavf_set_tx_function(struct rte_eth_dev *dev)
 	bool use_sse = false;
 	bool use_avx2 = false;
 	bool use_avx512 = false;
+	enum rte_vect_max_simd tx_simd_path = iavf_get_max_simd_bitwidth();
 
 	check_ret = iavf_tx_vec_dev_check(dev);
 
@@ -4138,16 +4131,8 @@ iavf_set_tx_function(struct rte_eth_dev *dev)
 		if (check_ret == IAVF_VECTOR_PATH) {
 			use_sse = true;
 		}
-		if ((rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX2) == 1 ||
-		     rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512F) == 1) &&
-		    rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_256)
-			use_avx2 = true;
-#ifdef CC_AVX512_SUPPORT
-		if (rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512F) == 1 &&
-		    rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512BW) == 1 &&
-		    rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_512)
-			use_avx512 = true;
-#endif
+		use_avx2 = tx_simd_path == RTE_VECT_SIMD_256;
+		use_avx512 = tx_simd_path == RTE_VECT_SIMD_512;
 
 		if (!use_sse && !use_avx2 && !use_avx512)
 			goto normal;
diff --git a/drivers/net/intel/iavf/iavf_rxtx.h b/drivers/net/intel/iavf/iavf_rxtx.h
index 1641bfe59a..36157003e3 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.h
+++ b/drivers/net/intel/iavf/iavf_rxtx.h
@@ -606,6 +606,7 @@ void iavf_tx_queue_release_mbufs_avx512(struct ci_tx_queue *txq);
 void iavf_rx_queue_release_mbufs_sse(struct ci_rx_queue *rxq);
 void iavf_tx_queue_release_mbufs_sse(struct ci_tx_queue *txq);
 void iavf_rx_queue_release_mbufs_neon(struct ci_rx_queue *rxq);
+enum rte_vect_max_simd iavf_get_max_simd_bitwidth(void);
 
 static inline
 void iavf_dump_rx_descriptor(struct ci_rx_queue *rxq,
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_sse.c b/drivers/net/intel/iavf/iavf_rxtx_vec_sse.c
index e4c1f9fc7b..9dae0a79bf 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_sse.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_sse.c
@@ -1387,3 +1387,9 @@ iavf_tx_vec_dev_check(struct rte_eth_dev *dev)
 {
 	return iavf_tx_vec_dev_check_default(dev);
 }
+
+enum rte_vect_max_simd
+iavf_get_max_simd_bitwidth(void)
+{
+	return ci_get_x86_max_simd_bitwidth();
+}
-- 
2.34.1

