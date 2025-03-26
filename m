Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFECC3600B
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Mar 2025 16:06:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BAD3340A6D;
	Wed, 26 Mar 2025 17:05:59 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 513EB4069D
 for <dev@dpdk.org>; Wed, 26 Mar 2025 17:05:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743005158; x=1774541158;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ell4aqzGb8sclHsIxrYJMXIhfB3sIOUSfbftg5teMc4=;
 b=mlIPZqEU6dohOV0MqGLiG2BqUiWlp3/cIFYL1UdebJ7rVOP5rqHIjg0s
 l61UH1/5wJFTVROQF7t0T0A1mDNRjuXL8jIiRgGmz1eRDCg6Ryi1T1hdm
 dE1UezK99tTRD+geFijFULA9M6WWDNQwZChoabqKauvft0TRyh7C8jgz9
 Urcj/1Edxmo4kYMJ7Dby0DLog3xEhJYww3m2a7+RXOXYeWYg+R7eluCXi
 2mFXWJuB6qbob9+WO8IIRuCW099V8Qst/ghSx3VbH7nnp0df2ePDPzx9c
 CCGfp7XUBZS7eNjcwRem+f7n/xCbOSDsVd4CLT9LfLauqxgvZ1B4+MkGB A==;
X-CSE-ConnectionGUID: bJBfpQtmT72LaXu0JaU5LQ==
X-CSE-MsgGUID: xsyteAdcRGW4LM0S59G9KA==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="54955001"
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; d="scan'208";a="54955001"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2025 09:05:57 -0700
X-CSE-ConnectionGUID: Q9AG7loSSQ6ecffs8DKBvg==
X-CSE-MsgGUID: ViPfemR+QvWy5T5T6flw6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; d="scan'208";a="125280793"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by fmviesa010.fm.intel.com with ESMTP; 26 Mar 2025 09:05:56 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v2 7/8] net/ice/base: reduce warnings for unused variables
Date: Wed, 26 Mar 2025 16:05:37 +0000
Message-ID: <20250326160539.1316499-8-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250326160539.1316499-1-bruce.richardson@intel.com>
References: <20250326155230.1315056-1-bruce.richardson@intel.com>
 <20250326160539.1316499-1-bruce.richardson@intel.com>
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

Improve base code macros to reduce the number of issues with unused
variables in the code. Issues still remain with unused-but-set
variables, but completely unused variable warnings are eliminated.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/ice/base/ice_osdep.h  | 6 +++---
 drivers/net/intel/ice/base/ice_switch.c | 2 --
 drivers/net/intel/ice/base/ice_type.h   | 2 +-
 drivers/net/intel/ice/base/meson.build  | 1 -
 drivers/net/intel/ice/ice_fdir_filter.c | 2 +-
 5 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/net/intel/ice/base/ice_osdep.h b/drivers/net/intel/ice/base/ice_osdep.h
index 7b96fcde03..ad6cde9896 100644
--- a/drivers/net/intel/ice/base/ice_osdep.h
+++ b/drivers/net/intel/ice/base/ice_osdep.h
@@ -196,9 +196,9 @@ struct __rte_packed_begin ice_virt_mem {
 	u32 size;
 } __rte_packed_end;
 
-#define ice_malloc(h, s)    rte_zmalloc(NULL, s, 0)
-#define ice_calloc(h, c, s) rte_calloc(NULL, c, s, 0)
-#define ice_free(h, m)         rte_free(m)
+#define ice_malloc(h, s)    ((void)h, rte_zmalloc(NULL, s, 0))
+#define ice_calloc(h, c, s) ((void)h, rte_calloc(NULL, c, s, 0))
+#define ice_free(h, m)      ((void)h, rte_free(m))
 
 #define ice_memset(a, b, c, d) memset((a), (b), (c))
 #define ice_memcpy(a, b, c, d) rte_memcpy((a), (b), (c))
diff --git a/drivers/net/intel/ice/base/ice_switch.c b/drivers/net/intel/ice/base/ice_switch.c
index a3786961e6..468a9f055d 100644
--- a/drivers/net/intel/ice/base/ice_switch.c
+++ b/drivers/net/intel/ice/base/ice_switch.c
@@ -8190,7 +8190,6 @@ ice_add_adv_recipe(struct ice_hw *hw, struct ice_adv_lkup_elem *lkups,
 	struct ice_sw_recipe *rm;
 	u8 i;
 	int status = ICE_SUCCESS;
-	u16 cnt;
 
 	if (!ice_is_prof_rule(rinfo->tun_type) && !lkups_cnt)
 		return ICE_ERR_PARAM;
@@ -9795,7 +9794,6 @@ ice_rem_adv_rule(struct ice_hw *hw, struct ice_adv_lkup_elem *lkups,
 	bool remove_rule = false;
 	struct ice_lock *rule_lock; /* Lock to protect filter rule list */
 	u16 i, rid, vsi_handle;
-	bool is_add = false;
 	int status = ICE_SUCCESS;
 
 	ice_memset(&lkup_exts, 0, sizeof(lkup_exts), ICE_NONDMA_MEM);
diff --git a/drivers/net/intel/ice/base/ice_type.h b/drivers/net/intel/ice/base/ice_type.h
index 35f832eb9f..297a5ea890 100644
--- a/drivers/net/intel/ice/base/ice_type.h
+++ b/drivers/net/intel/ice/base/ice_type.h
@@ -153,7 +153,7 @@ static inline u32 ice_round_to_num(u32 N, u32 R)
 #define ICE_DBG_USER		BIT_ULL(31)
 #define ICE_DBG_ALL		0xFFFFFFFFFFFFFFFFULL
 
-#define __ALWAYS_UNUSED
+#define __ALWAYS_UNUSED __rte_unused
 
 #define IS_ETHER_ADDR_EQUAL(addr1, addr2) \
 	(((bool)((((u16 *)(addr1))[0] == ((u16 *)(addr2))[0]))) && \
diff --git a/drivers/net/intel/ice/base/meson.build b/drivers/net/intel/ice/base/meson.build
index 38d092c370..e7ba9c34bc 100644
--- a/drivers/net/intel/ice/base/meson.build
+++ b/drivers/net/intel/ice/base/meson.build
@@ -39,7 +39,6 @@ if is_ms_compiler
 else
     error_cflags = [
             '-Wno-unused-but-set-variable',
-            '-Wno-unused-variable',
             '-Wno-unused-parameter',
     ]
 endif
diff --git a/drivers/net/intel/ice/ice_fdir_filter.c b/drivers/net/intel/ice/ice_fdir_filter.c
index 940fe171b6..2ff0090aca 100644
--- a/drivers/net/intel/ice/ice_fdir_filter.c
+++ b/drivers/net/intel/ice/ice_fdir_filter.c
@@ -1090,7 +1090,7 @@ ice_fdir_input_set_conf(struct ice_pf *pf, enum ice_fltr_ptype flow,
 		return -EINVAL;
 
 	seg_tun = (struct ice_flow_seg_info *)
-		ice_malloc(hw, sizeof(*seg_tun) * ICE_FD_HW_SEG_MAX);
+		ice_malloc(pf->adapter->hw, sizeof(*seg_tun) * ICE_FD_HW_SEG_MAX);
 	if (!seg_tun) {
 		PMD_DRV_LOG(ERR, "No memory can be allocated");
 		return -ENOMEM;
-- 
2.45.2

