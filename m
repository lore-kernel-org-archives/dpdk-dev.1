Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C385F606A319
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 12:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=d65syDh4
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4FE264069D;
	Tue, 20 Oct 2026 14:11:22 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 5E1EF4066C
 for <dev@dpdk.org>; Tue, 20 Oct 2026 14:11:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792498278; x=1824034278;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=dDlEfQ5ECtXdubJpvgEAAX7ngdp0ht/sSex3q8bgHNc=;
 b=d65syDh4haeO9R9r2Oc6uONvMVSKKFhJsPcKcYJ1zzb7pb2V+7uosIAe
 +Dk+SS3H2LawRaXqzVg2bbW4n8GIAZeuxGM8aFOZRxs8Grq5t3FvZkeoR
 3HrSMRpi3GHCfSVd2CwgQmESzJbMcVGqBUDVPLEOnHm0PR7/xO9Ww0VcM
 62BdoggvlZNVE/k17iICsWMKw0Hj/ZbZ3XexEUeZzv0ao8ze4BOXgN4XC
 1HOVr7edeOiyvQ2Et8axXLSnX900YAwyF55HvZrDhO7lQ6GVLk3M0STIe
 2n4qhznZONQ4HDRTEUCAHOUlO2yehxYdDG5S+OltyAB4hfvk7J5ObG9pm Q==;
X-CSE-ConnectionGUID: 9RUCkX9UQYy4PpfJCb9epQ==
X-CSE-MsgGUID: tEsWKzTOTOmrbZCkk5foug==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1101790"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1101790"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2026 05:11:18 -0700
X-CSE-ConnectionGUID: hlhz6r9BR5mfgkj0H6OQTQ==
X-CSE-MsgGUID: QRGVWspyQSOoYb3XAo/uVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="3253909"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa010.fm.intel.com with ESMTP; 20 Oct 2026 05:11:18 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v1 4/6] net/ice: remove temporary flow pattern buffer
Date: Tue, 20 Oct 2026 13:11:07 +0100
Message-ID: <51906e4e6f627746e057752ad7ea6b5f0f99fe08.1792498154.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1792498154.git.anatoly.burakov@intel.com>
References: 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Pattern lookup allocates a temporary copy of the flow pattern with
VOID items removed. Pattern matching and engine parsing now skip VOID
items directly, so this copy is no longer needed.

Match against the original pattern and remove the temporary buffer,
its allocation and cleanup paths, and the unused copying helpers.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ice/ice_generic_flow.c | 76 +-----------------------
 1 file changed, 1 insertion(+), 75 deletions(-)

diff --git a/drivers/net/intel/ice/ice_generic_flow.c b/drivers/net/intel/ice/ice_generic_flow.c
index fee048e456..ebe986c469 100644
--- a/drivers/net/intel/ice/ice_generic_flow.c
+++ b/drivers/net/intel/ice/ice_generic_flow.c
@@ -2052,58 +2052,6 @@ ice_flow_uninit(struct ice_adapter *ad)
 	}
 }
 
-/* Find the first VOID or non-VOID item pointer */
-static const struct rte_flow_item *
-ice_find_first_item(const struct rte_flow_item *item, bool is_void)
-{
-	bool is_find;
-
-	while (item->type != RTE_FLOW_ITEM_TYPE_END) {
-		if (is_void)
-			is_find = item->type == RTE_FLOW_ITEM_TYPE_VOID;
-		else
-			is_find = item->type != RTE_FLOW_ITEM_TYPE_VOID;
-		if (is_find)
-			break;
-		item++;
-	}
-	return item;
-}
-
-/* Skip all VOID items of the pattern */
-static void
-ice_pattern_skip_void_item(struct rte_flow_item *items,
-			const struct rte_flow_item *pattern)
-{
-	uint32_t cpy_count = 0;
-	const struct rte_flow_item *pb = pattern, *pe = pattern;
-
-	for (;;) {
-		/* Find a non-void item first */
-		pb = ice_find_first_item(pb, false);
-		if (pb->type == RTE_FLOW_ITEM_TYPE_END) {
-			pe = pb;
-			break;
-		}
-
-		/* Find a void item */
-		pe = ice_find_first_item(pb + 1, true);
-
-		cpy_count = pe - pb;
-		memcpy(items, pb, sizeof(struct rte_flow_item) * cpy_count);
-
-		items += cpy_count;
-
-		if (pe->type == RTE_FLOW_ITEM_TYPE_END) {
-			break;
-		}
-
-		pb = pe + 1;
-	}
-	/* Copy the END item. */
-	memcpy(items, pe, sizeof(struct rte_flow_item));
-}
-
 /* Check if the pattern matches a supported item type array */
 static bool
 ice_match_pattern(enum rte_flow_item_type *item_array,
@@ -2269,41 +2217,21 @@ ice_search_pattern_match_item(struct ice_adapter *ad,
 			      struct rte_flow_error *error)
 {
 	struct ice_pattern_match_item *pattern_match_item;
-	/* need free by each filter */
-	struct rte_flow_item *items; /* used for pattern without VOID items */
-	uint32_t item_num = 0; /* non-void item number */
 	uint16_t i = 0;
 
-	/* Get the non-void item number of pattern */
-	while ((pattern + i)->type != RTE_FLOW_ITEM_TYPE_END) {
-		if ((pattern + i)->type != RTE_FLOW_ITEM_TYPE_VOID)
-			item_num++;
-		i++;
-	}
-	item_num++;
-
-	items = calloc(item_num, sizeof(struct rte_flow_item));
-	if (!items) {
-		rte_flow_error_set(error, ENOMEM, RTE_FLOW_ERROR_TYPE_ITEM_NUM,
-				   NULL, "No memory for PMD internal items.");
-		return NULL;
-	}
 	pattern_match_item = calloc(1, sizeof(struct ice_pattern_match_item));
 	if (!pattern_match_item) {
 		rte_flow_error_set(error, ENOMEM, RTE_FLOW_ERROR_TYPE_HANDLE,
 				NULL, "Failed to allocate memory.");
-		free(items);
 		return NULL;
 	}
 
-	ice_pattern_skip_void_item(items, pattern);
-
 	if (!ice_pattern_is_supported(ad, pattern))
 		goto unsupported;
 
 	for (i = 0; i < array_len; i++) {
 		if (ice_match_pattern(array[i].pattern_list,
-				      items)) {
+				      pattern)) {
 			pattern_match_item->input_set_mask_o =
 				array[i].input_set_mask_o;
 			pattern_match_item->input_set_mask_i =
@@ -2311,7 +2239,6 @@ ice_search_pattern_match_item(struct ice_adapter *ad,
 			pattern_match_item->pattern_list =
 				array[i].pattern_list;
 			pattern_match_item->meta = array[i].meta;
-			free(items);
 			return pattern_match_item;
 		}
 	}
@@ -2319,7 +2246,6 @@ ice_search_pattern_match_item(struct ice_adapter *ad,
 unsupported:
 	rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ITEM,
 			   pattern, "Unsupported pattern");
-	free(items);
 	free(pattern_match_item);
 	return NULL;
 }
-- 
2.52.0

