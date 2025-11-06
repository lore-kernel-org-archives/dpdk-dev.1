Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE461CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 08:26:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 872DC40DD3;
	Thu,  6 Nov 2025 09:26:06 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id C3DDC4013F
 for <dev@dpdk.org>; Thu,  6 Nov 2025 09:26:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762417565; x=1793953565;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=HPuWn1JNuZcx+uqUEuB6izqBYOH+Exdjts0/dtMXa6Q=;
 b=aeomNGol5c06DqQ23fijN4cL1tyuyQJUGX5GaBaZhXqCZPpEfPHoEUiu
 S1WpssCdbzmiX+ij36SqYB3jed6ZpboYYi0hsBaflmPQQprz4FrPPV+jp
 zV9rOJ4/6v+83DrTm9e9BEYnT7zbMM10B+yhFTT5Fn+UQ2yTFj0EIH6Ab
 rVgXkVQG8TgKprXqyNJ5icCU+nmqberaVROZOPyb0rnnKAqLbj+VEbHE/
 3m916nSFp2ErbthfKSj1NbjWtsbkAt/e9csdYAwyaqA+1JY3drcXBJSaU
 mhhVY1iv1P3KFxNxLqQmI9EUwUNDMaMqtkpZHDJzFx7XFPCHN3feiIfFy Q==;
X-CSE-ConnectionGUID: tTvmnZn3R6aHJ4Sxog2Xkw==
X-CSE-MsgGUID: acWJTiDUSoaTSA8XH4jwbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="52115152"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="52115152"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2025 00:26:04 -0800
X-CSE-ConnectionGUID: Lj2qOpsVRE+eEPFGrwwHEw==
X-CSE-MsgGUID: vi8YPEUsR72FWdO3DS31BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="191977372"
Received: from unknown (HELO sprmax19..) ([10.138.182.140])
 by fmviesa005.fm.intel.com with ESMTP; 06 Nov 2025 00:26:02 -0800
From: Venkatesh Vemula <venkatesh.vemula@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: aman.deep.singh@dpdk.org, shaiq.wani@intel.com
Subject: [PATCH v1] net/intel: changes to avoid comma operator misuse warnings
Date: Thu,  6 Nov 2025 13:53:54 +0530
Message-Id: <20251106082354.1534181-1-venkatesh.vemula@intel.com>
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

fixed comma operator misuse warnings with clang compiler
for intel PMDs when -Wcomma enabled.

Bugzilla ID: 1809("net/intel: possible misuse of comma operator")
Signed-off-by: Venkatesh Vemula <venkatesh.vemula@intel.com>
---
 drivers/net/intel/i40e/i40e_ethdev.c             | 8 ++++----
 drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c      | 4 ++--
 drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c    | 2 +-
 drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c      | 4 ++--
 drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c    | 6 +++---
 drivers/net/intel/ice/ice_ethdev.c               | 8 ++++----
 drivers/net/intel/ice/ice_rxtx_vec_avx2.c        | 4 ++--
 drivers/net/intel/ice/ice_rxtx_vec_avx512.c      | 2 +-
 drivers/net/intel/idpf/idpf_common_rxtx_avx2.c   | 4 ++--
 drivers/net/intel/idpf/idpf_common_rxtx_avx512.c | 8 ++++----
 10 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index b8ce79061b..799e65ac8d 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -5099,15 +5099,15 @@ i40e_res_pool_destroy(struct i40e_res_pool_info *pool)
 		return;
 
 	for (entry = LIST_FIRST(&pool->alloc_list);
-			entry && (next_entry = LIST_NEXT(entry, next), 1);
-			entry = next_entry) {
+		 entry; entry = next_entry) {
+		next_entry = LIST_NEXT(entry, next);
 		LIST_REMOVE(entry, next);
 		rte_free(entry);
 	}
 
 	for (entry = LIST_FIRST(&pool->free_list);
-			entry && (next_entry = LIST_NEXT(entry, next), 1);
-			entry = next_entry) {
+		 entry; entry = next_entry) {
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
index d40a858413..530144181f 100644
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
 
@@ -2109,7 +2109,7 @@ ctx_vtx(volatile struct iavf_tx_desc *txdp,
 	/* if unaligned on 32-bit boundary, do one to align */
 	if (((uintptr_t)txdp & 0x1F) != 0 && nb_pkts != 0) {
 		ctx_vtx1(txdp, *pkt, flags, offload, vlan_flag);
-		nb_pkts--, txdp++, pkt++;
+		nb_pkts--; txdp++; pkt++;
 	}
 
 	for (; nb_pkts > 1; txdp += 4, pkt += 2, nb_pkts -= 2) {
diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 4669eba7c7..7ee0c98f3a 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -942,15 +942,15 @@ ice_res_pool_destroy(struct ice_res_pool_info *pool)
 		return;
 
 	for (entry = LIST_FIRST(&pool->alloc_list);
-	     entry && (next_entry = LIST_NEXT(entry, next), 1);
-	     entry = next_entry) {
+		 entry; entry = next_entry) {
+		next_entry = LIST_NEXT(entry, next);
 		LIST_REMOVE(entry, next);
 		rte_free(entry);
 	}
 
 	for (entry = LIST_FIRST(&pool->free_list);
-	     entry && (next_entry = LIST_NEXT(entry, next), 1);
-	     entry = next_entry) {
+		 entry; entry = next_entry) {
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
2.34.1

