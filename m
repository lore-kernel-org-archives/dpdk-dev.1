Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD26D2ECF9
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 06:42:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F2901406A2;
	Tue, 20 Jan 2026 07:42:39 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 4E26340273;
 Tue, 20 Jan 2026 07:42:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768891359; x=1800427359;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XRmSZfIo9Zd3PuY6av1Q3wbBSuIfrUAZp4ClyZ0dv2I=;
 b=BDR3k9X+maD5eTFYxBwmsPGzGt53K1Gy1+xY8kSSsJ2wphXkubPJ85zf
 jFwiiE5Ec8ebbVx1Lr2HfS9YvbyuuZnwFRiptFhtgEtUsij+KNoE7qjKn
 ezUth7wcq8rsesUs8WpHXrZUWg0CWdsXA2XRJynud9+VhS1ImC7Xn2hOR
 FAqPA9F55hXE5LZiNnYgVQwmSCMOr9quByDkeMg2HbK81vLC35vfXlAgW
 O9soIR3IH/ueSCggjlYNC7E/ISUVBNaRZcthamgUnLyYw5PxUs6ycTwpU
 wr5coK3OQpVKeR8B3uR5zw/prjld0YmrsGMAcLPzqlo8VliAIvAcRk4e+ g==;
X-CSE-ConnectionGUID: h2j/muM8Th2MVOrLUcnuGQ==
X-CSE-MsgGUID: ZmJjFIXtTDS6NexfVbNGjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="70062858"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; d="scan'208";a="70062858"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jan 2026 22:42:38 -0800
X-CSE-ConnectionGUID: xySoUwu8RvSbWheZhjFWdw==
X-CSE-MsgGUID: AXFuWVixRnOFTr+j98gXAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; d="scan'208";a="210536921"
Received: from srv14.iind.intel.com ([10.190.212.243])
 by orviesa004.jf.intel.com with ESMTP; 19 Jan 2026 22:42:35 -0800
From: Venkatesh Vemula <venkatesh.vemula@intel.com>
To: dev@dpdk.org, aman.deep.singh@intel.com, shaiq.wani@intel.com,
 bruce.richardson@intel.com
Cc: stable@dpdk.org
Subject: [PATCH v2] net/intel: changes to avoid comma operator misuse warnings
Date: Tue, 20 Jan 2026 06:41:56 +0000
Message-ID: <20260120064156.420244-1-venkatesh.vemula@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106082354.1534181-1-venkatesh.vemula@intel.com>
References: <20251106082354.1534181-1-venkatesh.vemula@intel.com>
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

fixed comma operator misuse warnings with clang compiler
for intel PMDs when -Wcomma enabled.

Bugzilla ID: 1809
Fixes: b3fa893d84d6 ("i40e: fix using memory after free")
Fixes: aed68d5b0e81 ("net/i40e: add AVX2 Tx function")
Fixes: e6a6a138919f ("net/i40e: add AVX512 vector path")
Fixes: af0c246a3800 ("net/iavf: enable AVX2 for iavf")
Fixes: 9ab9514c150e ("net/iavf: enable AVX512 for Tx")
Fixes: f9cf4f864150 ("net/ice: support device initialization")
Fixes: 2d5f6953d56d ("net/ice: support vector AVX2 in Tx")
Fixes: 7f85d5ebcfe1 ("net/ice: add AVX512 vector path")
Fixes: afac6261461f ("common/idpf: enable AVX2 for single queue Tx")
Fixes: 5bf87b45b2c8 ("net/idpf: add AVX512 data path for single queue model")
Fixes: e528d7c74819 ("common/idpf: add AVX512 data path for split queue model")
Cc: stable@dpdk.org

Signed-off-by: Venkatesh Vemula <venkatesh.vemula@intel.com>
---
 drivers/net/intel/i40e/i40e_ethdev.c             | 10 ++++------
 drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c      |  4 ++--
 drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c    |  2 +-
 drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c      |  4 ++--
 drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c    |  6 +++---
 drivers/net/intel/ice/ice_ethdev.c               | 10 ++++------
 drivers/net/intel/ice/ice_rxtx_vec_avx2.c        |  4 ++--
 drivers/net/intel/ice/ice_rxtx_vec_avx512.c      |  2 +-
 drivers/net/intel/idpf/idpf_common_rxtx_avx2.c   |  4 ++--
 drivers/net/intel/idpf/idpf_common_rxtx_avx512.c |  8 ++++----
 10 files changed, 25 insertions(+), 29 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index b8ce79061b..1d88c89a7e 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -5098,16 +5098,14 @@ i40e_res_pool_destroy(struct i40e_res_pool_info *pool)
 	if (pool == NULL)
 		return;
 
-	for (entry = LIST_FIRST(&pool->alloc_list);
-			entry && (next_entry = LIST_NEXT(entry, next), 1);
-			entry = next_entry) {
+	for (entry = LIST_FIRST(&pool->alloc_list); entry; entry = next_entry) {
+		next_entry = LIST_NEXT(entry, next);
 		LIST_REMOVE(entry, next);
 		rte_free(entry);
 	}
 
-	for (entry = LIST_FIRST(&pool->free_list);
-			entry && (next_entry = LIST_NEXT(entry, next), 1);
-			entry = next_entry) {
+	for (entry = LIST_FIRST(&pool->free_list); entry; entry = next_entry) {
+		next_entry = LIST_NEXT(entry, next);
 		LIST_REMOVE(entry, next);
 		rte_free(entry);
 	}
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c b/drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c
index aeb2756e7a..07b68ff3db 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c
@@ -703,7 +703,7 @@ vtx(volatile struct i40e_tx_desc *txdp,
 	/* if unaligned on 32-bit boundary, do one to align */
 	if (((uintptr_t)txdp & 0x1F) != 0 && nb_pkts != 0) {
 		vtx1(txdp, *pkt, flags);
-		nb_pkts--, txdp++, pkt++;
+		nb_pkts--; txdp++; pkt++;
 	}
 
 	/* do two at a time while possible, in bursts */
@@ -730,7 +730,7 @@ vtx(volatile struct i40e_tx_desc *txdp,
 	/* do any last ones */
 	while (nb_pkts) {
 		vtx1(txdp, *pkt, flags);
-		txdp++, pkt++, nb_pkts--;
+		txdp++; pkt++; nb_pkts--;
 	}
 }
 
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c b/drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c
index 571987d27a..8d1d3bd78e 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c
@@ -798,7 +798,7 @@ vtx(volatile struct i40e_tx_desc *txdp,
 	/* do any last ones */
 	while (nb_pkts) {
 		vtx1(txdp, *pkt, flags);
-		txdp++, pkt++, nb_pkts--;
+		txdp++; pkt++; nb_pkts--;
 	}
 }
 
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c b/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
index e417257086..ca4494d548 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
@@ -1655,7 +1655,7 @@ iavf_vtx(volatile struct iavf_tx_desc *txdp,
 	/* if unaligned on 32-bit boundary, do one to align */
 	if (((uintptr_t)txdp & 0x1F) != 0 && nb_pkts != 0) {
 		iavf_vtx1(txdp, *pkt, flags, offload, vlan_flag);
-		nb_pkts--, txdp++, pkt++;
+		nb_pkts--; txdp++; pkt++;
 	}
 
 	/* do two at a time while possible, in bursts */
@@ -1704,7 +1704,7 @@ iavf_vtx(volatile struct iavf_tx_desc *txdp,
 	/* do any last ones */
 	while (nb_pkts) {
 		iavf_vtx1(txdp, *pkt, flags, offload, vlan_flag);
-		txdp++, pkt++, nb_pkts--;
+		txdp++; pkt++; nb_pkts--;
 	}
 }
 
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
index 7c0907b7cf..3aced29784 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
@@ -1869,7 +1869,7 @@ iavf_vtx(volatile struct iavf_tx_desc *txdp,
 	/* if unaligned on 32-bit boundary, do one to align */
 	if (((uintptr_t)txdp & 0x1F) != 0 && nb_pkts != 0) {
 		iavf_vtx1(txdp, *pkt, flags, offload, vlan_flag);
-		nb_pkts--, txdp++, pkt++;
+		nb_pkts--; txdp++; pkt++;
 	}
 
 	/* do 4 at a time while possible, in bursts */
@@ -1913,7 +1913,7 @@ iavf_vtx(volatile struct iavf_tx_desc *txdp,
 	/* do any last ones */
 	while (nb_pkts) {
 		iavf_vtx1(txdp, *pkt, flags, offload, vlan_flag);
-		txdp++, pkt++, nb_pkts--;
+		txdp++; pkt++; nb_pkts--;
 	}
 }
 
@@ -2116,7 +2116,7 @@ ctx_vtx(volatile struct iavf_tx_desc *txdp,
 	/* if unaligned on 32-bit boundary, do one to align */
 	if (((uintptr_t)txdp & 0x1F) != 0 && nb_pkts != 0) {
 		ctx_vtx1(txdp, *pkt, flags, offload, vlan_flag);
-		nb_pkts--, txdp++, pkt++;
+		nb_pkts--; txdp++; pkt++;
 	}
 
 	for (; nb_pkts > 1; txdp += 4, pkt += 2, nb_pkts -= 2) {
diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index c721d135f5..db4fa37232 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -945,16 +945,14 @@ ice_res_pool_destroy(struct ice_res_pool_info *pool)
 	if (!pool)
 		return;
 
-	for (entry = LIST_FIRST(&pool->alloc_list);
-	     entry && (next_entry = LIST_NEXT(entry, next), 1);
-	     entry = next_entry) {
+	for (entry = LIST_FIRST(&pool->alloc_list); entry; entry = next_entry) {
+		next_entry = LIST_NEXT(entry, next);
 		LIST_REMOVE(entry, next);
 		rte_free(entry);
 	}
 
-	for (entry = LIST_FIRST(&pool->free_list);
-	     entry && (next_entry = LIST_NEXT(entry, next), 1);
-	     entry = next_entry) {
+	for (entry = LIST_FIRST(&pool->free_list); entry; entry = next_entry) {
+		next_entry = LIST_NEXT(entry, next);
 		LIST_REMOVE(entry, next);
 		rte_free(entry);
 	}
diff --git a/drivers/net/intel/ice/ice_rxtx_vec_avx2.c b/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
index b952b8dddc..b9a55d670f 100644
--- a/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
+++ b/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
@@ -798,7 +798,7 @@ ice_vtx(volatile struct ice_tx_desc *txdp,
 	/* if unaligned on 32-bit boundary, do one to align */
 	if (((uintptr_t)txdp & 0x1F) != 0 && nb_pkts != 0) {
 		ice_vtx1(txdp, *pkt, flags, offload);
-		nb_pkts--, txdp++, pkt++;
+		nb_pkts--; txdp++; pkt++;
 	}
 
 	/* do two at a time while possible, in bursts */
@@ -843,7 +843,7 @@ ice_vtx(volatile struct ice_tx_desc *txdp,
 	/* do any last ones */
 	while (nb_pkts) {
 		ice_vtx1(txdp, *pkt, flags, offload);
-		txdp++, pkt++, nb_pkts--;
+		txdp++; pkt++; nb_pkts--;
 	}
 }
 
diff --git a/drivers/net/intel/ice/ice_rxtx_vec_avx512.c b/drivers/net/intel/ice/ice_rxtx_vec_avx512.c
index 7c6fe82072..585d56122f 100644
--- a/drivers/net/intel/ice/ice_rxtx_vec_avx512.c
+++ b/drivers/net/intel/ice/ice_rxtx_vec_avx512.c
@@ -907,7 +907,7 @@ ice_vtx(volatile struct ice_tx_desc *txdp, struct rte_mbuf **pkt,
 	/* do any last ones */
 	while (nb_pkts) {
 		ice_vtx1(txdp, *pkt, flags, do_offload);
-		txdp++, pkt++, nb_pkts--;
+		txdp++; pkt++; nb_pkts--;
 	}
 }
 
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
index 21c8f79254..c86753fb43 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
@@ -506,7 +506,7 @@ idpf_singleq_vtx(volatile struct idpf_base_tx_desc *txdp,
 	/* if unaligned on 32-bit boundary, do one to align */
 	if (((uintptr_t)txdp & 0x1F) != 0 && nb_pkts != 0) {
 		idpf_singleq_vtx1(txdp, *pkt, flags);
-		nb_pkts--, txdp++, pkt++;
+		nb_pkts--; txdp++; pkt++;
 	}
 
 	/* do two at a time while possible, in bursts */
@@ -547,7 +547,7 @@ idpf_singleq_vtx(volatile struct idpf_base_tx_desc *txdp,
 	/* do any last ones */
 	while (nb_pkts) {
 		idpf_singleq_vtx1(txdp, *pkt, flags);
-		txdp++, pkt++, nb_pkts--;
+		txdp++; pkt++; nb_pkts--;
 	}
 }
 
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
index bc2cadd738..1d0516c755 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
@@ -1025,7 +1025,7 @@ idpf_singleq_vtx(volatile struct idpf_base_tx_desc *txdp,
 	/* if unaligned on 32-bit boundary, do one to align */
 	if (((uintptr_t)txdp & 0x1F) != 0 && nb_pkts != 0) {
 		idpf_singleq_vtx1(txdp, *pkt, flags);
-		nb_pkts--, txdp++, pkt++;
+		nb_pkts--; txdp++; pkt++;
 	}
 
 	/* do 4 at a time while possible, in bursts */
@@ -1063,7 +1063,7 @@ idpf_singleq_vtx(volatile struct idpf_base_tx_desc *txdp,
 	/* do any last ones */
 	while (nb_pkts) {
 		idpf_singleq_vtx1(txdp, *pkt, flags);
-		txdp++, pkt++, nb_pkts--;
+		txdp++; pkt++; nb_pkts--;
 	}
 }
 
@@ -1226,7 +1226,7 @@ idpf_splitq_vtx(volatile struct idpf_flex_tx_sched_desc *txdp,
 	/* if unaligned on 32-bit boundary, do one to align */
 	if (((uintptr_t)txdp & 0x1F) != 0 && nb_pkts != 0) {
 		idpf_splitq_vtx1(txdp, *pkt, flags);
-		nb_pkts--, txdp++, pkt++;
+		nb_pkts--; txdp++; pkt++;
 	}
 
 	/* do 4 at a time while possible, in bursts */
@@ -1264,7 +1264,7 @@ idpf_splitq_vtx(volatile struct idpf_flex_tx_sched_desc *txdp,
 	/* do any last ones */
 	while (nb_pkts) {
 		idpf_splitq_vtx1(txdp, *pkt, flags);
-		txdp++, pkt++, nb_pkts--;
+		txdp++; pkt++; nb_pkts--;
 	}
 }
 
-- 
2.43.0

