Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC04C87FCA
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 Aug 2025 12:40:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4664040685;
	Thu,  7 Aug 2025 14:40:05 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 77EC740664
 for <dev@dpdk.org>; Thu,  7 Aug 2025 14:40:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754570402; x=1786106402;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DQRzelnLO5jNU+AhkUP4e66fJEWnb26HjRkwjpSagvQ=;
 b=aPeoFHrnSzqNejBG1ZL7Efs6AaSYqm0Wklz4D/C6xebSwqxdyB3yFHmP
 4tYvkhH5fhsItDkP2a/KVqbalrxSn5/y0hgzkUGLZiuxjleNKnZEdWCaU
 66NF2bGtrXAICFEkyTwQd/+4MRaqStl7H+YYz1j+EjkT1ag5eRDj0kNJI
 Ls9SK8smn8Y9tw+eFOedoYmnmtZHNBJ7hPDBrEC8fKs0f8SvFp8v2YrU4
 I+azoht32PKMvrCjPVGvNz6/gY8fTDlUc4LfLl0J9+pOxmml66rs9nYpB
 NAJvFi/h5pkZ020NKwlaZTa0hbb0gFpry1avdhNf2fiag5JKPKLNUH36p w==;
X-CSE-ConnectionGUID: WM6uvRUfQm2GrbkH43Dq+g==
X-CSE-MsgGUID: uyS7iNwjT9O4Ibs2q8ybcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="56981123"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="56981123"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2025 05:40:02 -0700
X-CSE-ConnectionGUID: 9H1fnx+MSZGMs7titMByBQ==
X-CSE-MsgGUID: eNjF4AGaQ36o4vsRShDVZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="195886740"
Received: from silpixa00401177.ir.intel.com ([10.237.213.77])
 by fmviesa001.fm.intel.com with ESMTP; 07 Aug 2025 05:40:01 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
	Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v2 07/15] net/iavf: use the new common vector capability
 function
Date: Thu,  7 Aug 2025 12:39:41 +0000
Message-Id: <20250807123949.4063416-8-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250807123949.4063416-1-ciara.loftus@intel.com>
References: <20250725124919.3564890-1-ciara.loftus@intel.com>
 <20250807123949.4063416-1-ciara.loftus@intel.com>
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

