Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7E5C3600B
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Mar 2025 14:53:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E1D1640ED9;
	Thu, 27 Mar 2025 15:52:30 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 5E0EE40EAB
 for <dev@dpdk.org>; Thu, 27 Mar 2025 15:52:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743087149; x=1774623149;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ell4aqzGb8sclHsIxrYJMXIhfB3sIOUSfbftg5teMc4=;
 b=kD67yulf5Pk1ndQHiyD2rSR6xYtZh8sOiKcLjtLDE9vQ/MbX9lni8kvt
 i5cBWGmRv6EscGqBjodZNbQOlucPROR+tGv5ypxVtWgqYEPlw1AjAz469
 JpCM3H3ZlyW8ZZF7ac0MlYGN5H5kzMVsLFzxIZHFmlJRCNlTXDisN1XDE
 f6yTAEP9r+tLh3yNKbPbnFuYbhN0+lwUzyWze3yvLt3kjfAoF75St5CBg
 zAErg+n0/nleodaDHxWkNAWtZr5pkK6XJchCmMPWssFhtQjhfzDcRejHd
 sFGjMWfqnzyns7yV4OgOCu8YSsyZfavfuGiqA8mMvFcyBunUUe3Z3YQMm A==;
X-CSE-ConnectionGUID: wfi2zmjSRbOIUl18/y7PLg==
X-CSE-MsgGUID: m+WvYklbSP6NIkhTgFOEYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="48207085"
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="48207085"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2025 07:52:28 -0700
X-CSE-ConnectionGUID: tM1R0nkpQmaJS56PUf+waA==
X-CSE-MsgGUID: kCGdiaiqSgKlkMb5QRgnrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="162400062"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by orviesa001.jf.intel.com with ESMTP; 27 Mar 2025 07:52:27 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v3 8/9] net/ice/base: reduce warnings for unused variables
Date: Thu, 27 Mar 2025 14:52:00 +0000
Message-ID: <20250327145202.2220153-9-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250327145202.2220153-1-bruce.richardson@intel.com>
References: <20250326155230.1315056-1-bruce.richardson@intel.com>
 <20250327145202.2220153-1-bruce.richardson@intel.com>
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

