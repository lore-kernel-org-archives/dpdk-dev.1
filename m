Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1FACCA470
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Oct 2025 12:42:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9BB3E402DD;
	Tue,  7 Oct 2025 14:42:18 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 4B79F4013F;
 Tue,  7 Oct 2025 14:42:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759840937; x=1791376937;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=f2hnhMy6+lnnJntW0DDWP11R6WTnpbVadbB+U5wZ0SM=;
 b=H4zvPlGj50jfX7xPHC4i1fqbNIIvT93e1NV8DawxHATrD1aBxHbpoitY
 rZgLRG8SpIjwzAKah3dbT6gLu02R6hHYgsftuJEnQfe0d5dCbdarRp9I8
 AvjtT9zj5VW7kf+4dXMZyUTg/sPHyHU6rg8ks0EAzWy1mi785/X4orAmU
 XfTLwm7e7fd1k5kgY5c0fZOSDA6kV15KH23/dfBkvC/lE5ZdjR1cs1n+h
 fAE3VxAcHSCMNUA7fcl3CfXa3mSBnp2XySyOrsKt0IdxCitEJH6WefCFv
 3n3NYfdQl5LKzKRebuW0aFob5qn2jpozEIblqrU/G0F3mmyaeibwfW0OG g==;
X-CSE-ConnectionGUID: BmXfsGNvQpyqX592fC8/3A==
X-CSE-MsgGUID: evToTZK2RrmyTOTDqXhZaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11575"; a="62053787"
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; d="scan'208";a="62053787"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2025 05:42:15 -0700
X-CSE-ConnectionGUID: QICpFC6SSlmmgUAY1j3QJg==
X-CSE-MsgGUID: xqR4WcKcTKSMtfhIAo0kVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; d="scan'208";a="185433537"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa004.fm.intel.com with ESMTP; 07 Oct 2025 05:42:14 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Qi Zhang <qi.z.zhang@intel.com>, Junfeng Guo <junfengg@nvidia.com>
Cc: vladimir.medvedkin@intel.com,
	stable@dpdk.org
Subject: [PATCH v2 1/2] net/ice: remove indirection for FDIR filters
Date: Tue,  7 Oct 2025 13:42:11 +0100
Message-ID: <ba0c86578b7c8101825fcd42d737670c3525ae59.1759840924.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <65bfe82e74867020982e2729f84a7c00a5690c5b.1759837052.git.anatoly.burakov@intel.com>
References: <65bfe82e74867020982e2729f84a7c00a5690c5b.1759837052.git.anatoly.burakov@intel.com>
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

Currently, when filters are created for FDIR, they are allocated
dynamically using `ice_malloc()`. Not only this is inconsistent with hash
filter code paths (hash uses embedded structures), this is also creating
unnecessary indirection and complexity, and creates a memory leak where,
if something fails during raw pattern parse, the profile memory isn't
deallocated.

Since there is no actual reason for why FDIR filter profile must use
indirection, instead of fixing the memory leak just avoid it altogether
by making the filter profile an embedded struct. When parsing begins, the
entire scratch filter structure is zeroed out anyway, so there is no need
to add any additional zero-initialization code.

Fixes: 25be39cc1760 ("net/ice: enable protocol agnostic flow offloading in FDIR")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---

Notes:
    v2:
    - Added this patch

 drivers/net/intel/ice/ice_ethdev.h      |  2 +-
 drivers/net/intel/ice/ice_fdir_filter.c | 30 +++++++++----------------
 2 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
index a0d2082206..6478d6dfbd 100644
--- a/drivers/net/intel/ice/ice_ethdev.h
+++ b/drivers/net/intel/ice/ice_ethdev.h
@@ -379,7 +379,7 @@ struct ice_fdir_filter_conf {
 	uint64_t input_set_i; /* only for tunnel inner fields */
 	uint32_t mark_flag;
 
-	struct ice_parser_profile *prof;
+	struct ice_parser_profile prof;
 	bool parser_ena;
 	u8 *pkt_buf;
 	u8 pkt_len;
diff --git a/drivers/net/intel/ice/ice_fdir_filter.c b/drivers/net/intel/ice/ice_fdir_filter.c
index d41d223d52..d593624792 100644
--- a/drivers/net/intel/ice/ice_fdir_filter.c
+++ b/drivers/net/intel/ice/ice_fdir_filter.c
@@ -1314,7 +1314,7 @@ ice_fdir_create_filter(struct ice_adapter *ad,
 	if (filter->parser_ena) {
 		struct ice_hw *hw = ICE_PF_TO_HW(pf);
 
-		int id = ice_find_first_bit(filter->prof->ptypes, UINT16_MAX);
+		int id = ice_find_first_bit(filter->prof.ptypes, UINT16_MAX);
 		int ptg = hw->blk[ICE_BLK_FD].xlt1.t[id];
 		u16 ctrl_vsi = pf->fdir.fdir_vsi->idx;
 		u16 main_vsi = pf->main_vsi->idx;
@@ -1324,11 +1324,11 @@ ice_fdir_create_filter(struct ice_adapter *ad,
 		if (pi->fdir_actived_cnt != 0) {
 			for (i = 0; i < ICE_MAX_FV_WORDS; i++)
 				if (pi->prof.fv[i].proto_id !=
-				    filter->prof->fv[i].proto_id ||
+				    filter->prof.fv[i].proto_id ||
 				    pi->prof.fv[i].offset !=
-				    filter->prof->fv[i].offset ||
+				    filter->prof.fv[i].offset ||
 				    pi->prof.fv[i].msk !=
-				    filter->prof->fv[i].msk)
+				    filter->prof.fv[i].msk)
 					break;
 			if (i == ICE_MAX_FV_WORDS) {
 				fv_found = true;
@@ -1338,7 +1338,7 @@ ice_fdir_create_filter(struct ice_adapter *ad,
 
 		if (!fv_found) {
 			ret = ice_flow_set_hw_prof(hw, main_vsi, ctrl_vsi,
-						   filter->prof, ICE_BLK_FD);
+						   &filter->prof, ICE_BLK_FD);
 			if (ret)
 				goto error;
 		}
@@ -1348,12 +1348,12 @@ ice_fdir_create_filter(struct ice_adapter *ad,
 			goto error;
 
 		if (!fv_found) {
-			for (i = 0; i < filter->prof->fv_num; i++) {
+			for (i = 0; i < filter->prof.fv_num; i++) {
 				pi->prof.fv[i].proto_id =
-					filter->prof->fv[i].proto_id;
+					filter->prof.fv[i].proto_id;
 				pi->prof.fv[i].offset =
-					filter->prof->fv[i].offset;
-				pi->prof.fv[i].msk = filter->prof->fv[i].msk;
+					filter->prof.fv[i].offset;
+				pi->prof.fv[i].msk = filter->prof.fv[i].msk;
 			}
 			pi->fdir_actived_cnt = 1;
 		}
@@ -1451,7 +1451,6 @@ ice_fdir_create_filter(struct ice_adapter *ad,
 	return -rte_errno;
 
 error:
-	rte_free(filter->prof);
 	rte_free(filter->pkt_buf);
 	return -rte_errno;
 }
@@ -1473,7 +1472,7 @@ ice_fdir_destroy_filter(struct ice_adapter *ad,
 	if (filter->parser_ena) {
 		struct ice_hw *hw = ICE_PF_TO_HW(pf);
 
-		int id = ice_find_first_bit(filter->prof->ptypes, UINT16_MAX);
+		int id = ice_find_first_bit(filter->prof.ptypes, UINT16_MAX);
 		int ptg = hw->blk[ICE_BLK_FD].xlt1.t[id];
 		u16 ctrl_vsi = pf->fdir.fdir_vsi->idx;
 		u16 main_vsi = pf->main_vsi->idx;
@@ -1501,7 +1500,6 @@ ice_fdir_destroy_filter(struct ice_adapter *ad,
 
 		flow->rule = NULL;
 
-		rte_free(filter->prof);
 		rte_free(filter->pkt_buf);
 		rte_free(filter);
 
@@ -1928,13 +1926,8 @@ ice_fdir_parse_pattern(__rte_unused struct ice_adapter *ad,
 			if (!tmp_mask)
 				return -rte_errno;
 
-			filter->prof = (struct ice_parser_profile *)
-				ice_malloc(&ad->hw, sizeof(*filter->prof));
-			if (!filter->prof)
-				return -ENOMEM;
-
 			if (ice_parser_profile_init(&rslt, tmp_spec, tmp_mask,
-				pkt_len, ICE_BLK_FD, true, filter->prof))
+				pkt_len, ICE_BLK_FD, true, &filter->prof))
 				return -rte_errno;
 
 			u8 *pkt_buf = (u8 *)ice_malloc(&ad->hw, pkt_len + 1);
@@ -2495,7 +2488,6 @@ ice_fdir_parse(struct ice_adapter *ad,
 	rte_free(item);
 	return ret;
 error:
-	rte_free(filter->prof);
 	rte_free(filter->pkt_buf);
 	rte_free(item);
 	return ret;
-- 
2.47.3

