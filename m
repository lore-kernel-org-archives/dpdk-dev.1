Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640B0FCA18E
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Mar 2026 21:18:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA3DC40669;
	Mon,  9 Mar 2026 22:18:56 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 1071B40261
 for <dev@dpdk.org>; Mon,  9 Mar 2026 22:18:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773091135; x=1804627135;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ukPweA/uI9FUqp0ySHFdIPOuYbkBVfgFCx9hxgdLQGM=;
 b=jiUD7HcsQtcwq3Ybem7yY73x79nXWklwmRxczgTfhIScor8ZIBB6CE2I
 GafWCPhLkxEd6PeG4/+lyYiq/WnRAj3tdjtB6GmCFdOuOQCJC2MM1UoXr
 s3s3wKw8lg6DLVgcMh7M47UM38c4jlMfB/hIqUIDpdc6/n65krgSr/OwO
 bW8NWoqfGO/LRY2PaQ82BSaTCZu7k1L+DNmUKGMRJbH0s1F/7/bpWMRO7
 Rx6V2buUtWeJBq2M5FUkYzI1fA/rv7VgJVWnHGxgusSqmEkayoKbVYfqa
 MHOEzHnB6WXJgwg34gZyE3etUHqQACOUjSkelo6XikbNeyTK7jrmi1jkk g==;
X-CSE-ConnectionGUID: JEzZFXPpSgiLLWJnAbeMOA==
X-CSE-MsgGUID: zR9njFScSKq0TMUY6VCBuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="74240983"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; d="scan'208";a="74240983"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Mar 2026 14:18:54 -0700
X-CSE-ConnectionGUID: zvPycsT6QaWdmkxwGWzuWA==
X-CSE-MsgGUID: x88nRyOtS1mK7ed8OlBS7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; d="scan'208";a="219015989"
Received: from fenlix-mobl.ccr.corp.intel.com ([10.239.252.5])
 by orviesa006.jf.intel.com with ESMTP; 09 Mar 2026 14:18:51 -0700
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: bruce.richardson@intel.com, manoj.kumar.subbarao@intel.com,
 aman.deep.singh@intel.com, dev@dpdk.org
Cc: Maciej Paczkowski <maciej.paczkowski@intel.com>
Subject: [PATCH v1 2/6] net/ice/base: resolve comparison-with-wider-type
 violations
Date: Tue, 10 Mar 2026 05:52:09 -0400
Message-ID: <20260310095218.703423-7-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260310095218.703423-1-soumyadeep.hore@intel.com>
References: <20260310095218.703423-1-soumyadeep.hore@intel.com>
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

From: Maciej Paczkowski <maciej.paczkowski@intel.com>

- This patch resolves violations raised by Windows CodeQL
  tool related to comparison-with-wider-type error.

- Added data type casting to resolve these errors.

Signed-off-by: Maciej Paczkowski <maciej.paczkowski@intel.com>
Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
---
 drivers/net/intel/ice/base/ice_acl_ctrl.c |  6 +++---
 drivers/net/intel/ice/base/ice_bitops.h   | 14 +++++++-------
 drivers/net/intel/ice/base/ice_dcb.c      |  8 ++++----
 drivers/net/intel/ice/base/ice_sched.c    |  3 ++-
 drivers/net/intel/ice/base/ice_switch.c   |  2 +-
 5 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/net/intel/ice/base/ice_acl_ctrl.c b/drivers/net/intel/ice/base/ice_acl_ctrl.c
index 6cee2c98ea..6ec9f7f754 100644
--- a/drivers/net/intel/ice/base/ice_acl_ctrl.c
+++ b/drivers/net/intel/ice/base/ice_acl_ctrl.c
@@ -494,7 +494,7 @@ ice_acl_alloc_partition(struct ice_hw *hw, struct ice_acl_scen *req)
 			 * is available.
 			 */
 			p = dir > 0 ? i : ICE_AQC_MAX_TCAM_ALLOC_UNITS - i - 1;
-			for (w = row; w < row + width && avail; w++) {
+			for (w = row; w < (u16)(row + width) && avail; w++) {
 				u16 b;
 
 				b = (w * ICE_AQC_MAX_TCAM_ALLOC_UNITS) + p;
@@ -644,7 +644,7 @@ ice_acl_set_scen_chnk_msk(struct ice_aqc_acl_scen *scen_buf,
 		 * For each TCAM, there will be (ICE_AQC_ACL_TCAM_DEPTH
 		 * / ICE_ACL_ENTRY_ALLOC_UNIT) or 8 chunks.
 		 */
-		for (i = tcam_idx; i < tcam_idx + num_cscd; i++)
+		for (i = tcam_idx; i < (u16)(tcam_idx + num_cscd); i++)
 			scen_buf->tcam_cfg[i].chnk_msk |= BIT(chnk_offst);
 
 		chnk_offst = (chnk_offst + 1) % ICE_AQC_MAX_TCAM_ALLOC_UNITS;
@@ -799,7 +799,7 @@ ice_acl_create_scen(struct ice_hw *hw, u16 match_width, u16 num_entries,
 			ICE_AQC_ACL_ALLOC_SCE_START_CMP;
 
 		/* cascade TCAMs up to the width of the scenario */
-		for (i = k; i < cascade_cnt + k; i++) {
+		for (i = k; i < (u8)(cascade_cnt + k); i++) {
 			ice_acl_fill_tcam_select(&scen_buf, scen, i, i - k);
 			ice_acl_assign_act_mem_for_scen(hw->acl_tbl, scen,
 							&scen_buf,
diff --git a/drivers/net/intel/ice/base/ice_bitops.h b/drivers/net/intel/ice/base/ice_bitops.h
index 85e14a2358..829b2062c8 100644
--- a/drivers/net/intel/ice/base/ice_bitops.h
+++ b/drivers/net/intel/ice/base/ice_bitops.h
@@ -188,7 +188,7 @@ ice_and_bitmap(ice_bitmap_t *dst, const ice_bitmap_t *bmp1,
 	u16 i;
 
 	/* Handle all but the last chunk */
-	for (i = 0; i < BITS_TO_CHUNKS(size) - 1; i++) {
+	for (i = 0; i < (u16)(BITS_TO_CHUNKS(size) - 1); i++) {
 		dst[i] = bmp1[i] & bmp2[i];
 		res |= dst[i];
 	}
@@ -225,7 +225,7 @@ ice_or_bitmap(ice_bitmap_t *dst, const ice_bitmap_t *bmp1,
 	u16 i;
 
 	/* Handle all but last chunk */
-	for (i = 0; i < BITS_TO_CHUNKS(size) - 1; i++)
+	for (i = 0; i < (u16)(BITS_TO_CHUNKS(size) - 1); i++)
 		dst[i] = bmp1[i] | bmp2[i];
 
 	/* We want to only OR bits within the size. Furthermore, we also do
@@ -256,7 +256,7 @@ ice_xor_bitmap(ice_bitmap_t *dst, const ice_bitmap_t *bmp1,
 	u16 i;
 
 	/* Handle all but last chunk */
-	for (i = 0; i < BITS_TO_CHUNKS(size) - 1; i++)
+	for (i = 0; i < (u16)(BITS_TO_CHUNKS(size) - 1); i++)
 		dst[i] = bmp1[i] ^ bmp2[i];
 
 	/* We want to only XOR bits within the size. Furthermore, we also do
@@ -287,7 +287,7 @@ ice_andnot_bitmap(ice_bitmap_t *dst, const ice_bitmap_t *bmp1,
 	u16 i;
 
 	/* Handle all but last chunk */
-	for (i = 0; i < BITS_TO_CHUNKS(size) - 1; i++)
+	for (i = 0; i < (u16)(BITS_TO_CHUNKS(size) - 1); i++)
 		dst[i] = bmp1[i] & ~bmp2[i];
 
 	/* We want to only clear bits within the size. Furthermore, we also do
@@ -330,7 +330,7 @@ ice_find_next_bit(const ice_bitmap_t *bitmap, u16 size, u16 offset)
 	}
 
 	/* Now we handle the remaining chunks, if any */
-	for (i++; i < BITS_TO_CHUNKS(size); i++) {
+	for (i++; i < (u16)BITS_TO_CHUNKS(size); i++) {
 		if (bitmap[i] != 0) {
 			u16 off = i * BITS_PER_CHUNK;
 
@@ -405,7 +405,7 @@ ice_bitmap_set(ice_bitmap_t *dst, u16 pos, u16 num_bits)
 {
 	u16 i;
 
-	for (i = pos; i < pos + num_bits; i++)
+	for (i = pos; i < (u16)(pos + num_bits); i++)
 		ice_set_bit(i, dst);
 }
 
@@ -447,7 +447,7 @@ ice_cmp_bitmap(ice_bitmap_t *bmp1, ice_bitmap_t *bmp2, u16 size)
 	u16 i;
 
 	/* Handle all but last chunk */
-	for (i = 0; i < BITS_TO_CHUNKS(size) - 1; i++)
+	for (i = 0; i < (u16)(BITS_TO_CHUNKS(size) - 1); i++)
 		if (bmp1[i] != bmp2[i])
 			return false;
 
diff --git a/drivers/net/intel/ice/base/ice_dcb.c b/drivers/net/intel/ice/base/ice_dcb.c
index 607af03525..f5fbf535d5 100644
--- a/drivers/net/intel/ice/base/ice_dcb.c
+++ b/drivers/net/intel/ice/base/ice_dcb.c
@@ -465,7 +465,7 @@ ice_parse_cee_app_tlv(struct ice_cee_feat_tlv *tlv, struct ice_dcbx_cfg *dcbcfg)
 {
 	u16 len, typelen, offset = 0;
 	struct ice_cee_app_prio *app;
-	u8 i;
+	u32 i;
 
 	typelen = NTOHS(tlv->hdr.typelen);
 	len = ((typelen & ICE_LLDP_TLV_LEN_M) >> ICE_LLDP_TLV_LEN_S);
@@ -790,8 +790,8 @@ ice_cee_to_dcb_cfg(struct ice_aqc_get_cee_dcb_cfg_resp *cee_cfg,
 		   struct ice_port_info *pi)
 {
 	u32 status, tlv_status = LE32_TO_CPU(cee_cfg->tlv_status);
-	u32 ice_aqc_cee_status_mask, ice_aqc_cee_status_shift;
-	u8 i, j, err, sync, oper, app_index, ice_app_sel_type;
+	u32 j, ice_aqc_cee_status_mask, ice_aqc_cee_status_shift;
+	u8 i, err, sync, oper, app_index, ice_app_sel_type;
 	u16 app_prio = LE16_TO_CPU(cee_cfg->oper_app_prio);
 	u16 ice_aqc_cee_app_mask, ice_aqc_cee_app_shift;
 	struct ice_dcbx_cfg *cmp_dcbcfg, *dcbcfg;
@@ -1324,7 +1324,7 @@ ice_add_ieee_app_pri_tlv(struct ice_lldp_org_tlv *tlv,
 	 *   Bits:|23    21|20 19|18 16|15                0|
 	 *        -----------------------------------------
 	 */
-	while (i < dcbcfg->numapps) {
+	while (i < (u8)dcbcfg->numapps) {
 		priority = dcbcfg->app[i].priority & 0x7;
 		selector = dcbcfg->app[i].selector & 0x7;
 		buf[offset] = (priority << ICE_IEEE_APP_PRIO_S) | selector;
diff --git a/drivers/net/intel/ice/base/ice_sched.c b/drivers/net/intel/ice/base/ice_sched.c
index 3a0907eda7..2b867b74de 100644
--- a/drivers/net/intel/ice/base/ice_sched.c
+++ b/drivers/net/intel/ice/base/ice_sched.c
@@ -1257,7 +1257,8 @@ int ice_sched_init_port(struct ice_port_info *pi)
 	u8 num_branches;
 	u16 num_elems;
 	int status;
-	u8 i, j;
+	u8 i;
+	u16 j;
 
 	if (!pi)
 		return ICE_ERR_PARAM;
diff --git a/drivers/net/intel/ice/base/ice_switch.c b/drivers/net/intel/ice/base/ice_switch.c
index fff61b89d7..94099c5215 100644
--- a/drivers/net/intel/ice/base/ice_switch.c
+++ b/drivers/net/intel/ice/base/ice_switch.c
@@ -7437,7 +7437,7 @@ ice_fill_fv_word_index(struct ice_hw *hw, struct LIST_HEAD_TYPE *fv_list,
 			struct ice_fv_word *pr;
 			bool found = false;
 			u16 mask;
-			u8 j;
+			u16 j;
 
 			pr = &rg->r_group.pairs[i];
 			mask = rg->r_group.mask[i];
-- 
2.47.1

