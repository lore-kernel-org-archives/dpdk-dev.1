Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E7D9C4451B
	for <dpdk-dev@archiver.kernel.org>; Sun, 19 Jul 2026 17:32:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2DAC6402AB;
	Sun, 19 Jul 2026 19:32:22 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 7596E40297;
 Sun, 19 Jul 2026 19:32:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784482340; x=1816018340;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=otkkHlSnN4PFDo19xWJDTLtZ0YWEJvOx3IwxmtcrOZM=;
 b=MV2BavKd39PnhcjXY/t8F1v7gQCzwYMIWQ/j8nIr0cMvjhV8iP/vWbe1
 WvyYGG3jrheZTRWNF8u94XGuGVWLm5VfgdFsKsVtPFVft28EgP7Iwl/JE
 TJhR/HJyPq3g+AaX4l1Xyn7wAYMlB9kSX0fAGc2YxKzJBvn+QUhx1sEgt
 dDoSPdPxv+VtjOsj2lC4tP7Xq/rxtHRN2lcW7Gf4ssJOFKYnTbjUh0+Tw
 Ne71cRCqNPSJbQA6EYJ0TjfxunBESmcpvs5KsrZLD/sNbv1XpwH0GJ9PO
 nK4L5jiNtTVQbs4PowGKC8IsT2YX0xUj7KF/T3RySQJueTVKP5lEsVir+ A==;
X-CSE-ConnectionGUID: yTz8lDqbQDm7rN0tIsya3A==
X-CSE-MsgGUID: jzQMwqjtTpaKox6BGkiHLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="72614346"
X-IronPort-AV: E=Sophos;i="6.25,173,1779174000"; d="scan'208";a="72614346"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jul 2026 10:32:18 -0700
X-CSE-ConnectionGUID: iq6UqlFFQ6WsfHeuTloP9g==
X-CSE-MsgGUID: gpS+mSZ4T4OiHJDkBfuxIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,173,1779174000"; d="scan'208";a="257326094"
Received: from unknown (HELO localhost.localdomain.iind.intel.com)
 ([10.49.105.104])
 by orviesa007.jf.intel.com with ESMTP; 19 Jul 2026 10:32:16 -0700
From: sandeep.penigalapati@intel.com
To: dev@dpdk.org
Cc: vladimir.medvedkin@intel.com, bruce.richardson@intel.com, stable@dpdk.org,
 Sandeep Penigalapati <sandeep.penigalapati@intel.com>
Subject: [PATCH] net/iavf: fix null pointer dereference in eCPRI FDIR pattern
Date: Sun, 19 Jul 2026 20:34:12 -0400
Message-Id: <20260720003412.60292-1-sandeep.penigalapati@intel.com>
X-Mailer: git-send-email 2.27.0
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

From: Sandeep Penigalapati <sandeep.penigalapati@intel.com>

In iavf_fdir_parse_pattern(), the RTE_FLOW_ITEM_TYPE_ECPRI case reads
ecpri_spec->hdr.common.u32 before checking that ecpri_spec is non-null.
A wildcard eCPRI flow item (no spec) with a queue or drop action, which
routes the rule to the FDIR engine, leaves item->spec as null, so the
unconditional dereference crashes the application at rule creation.

Move the ecpri_common read inside the existing
"if (ecpri_spec && ecpri_mask)" guard, mirroring the other pattern items
and the RSS-hash parser in iavf_hash.c which already handles a null
eCPRI spec. The rule is then rejected cleanly with -EINVAL.

Fixes: 6c37927479be ("net/iavf: support eCPRI message type 0 for flow director")
Cc: stable@dpdk.org
Signed-off-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
---
 drivers/net/intel/iavf/iavf_fdir.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_fdir.c b/drivers/net/intel/iavf/iavf_fdir.c
index ea620863ca..67003183bb 100644
--- a/drivers/net/intel/iavf/iavf_fdir.c
+++ b/drivers/net/intel/iavf/iavf_fdir.c
@@ -1271,13 +1271,13 @@ iavf_fdir_parse_pattern(__rte_unused struct iavf_adapter *ad,
 			ecpri_spec = item->spec;
 			ecpri_mask = item->mask;
 
-			ecpri_common.u32 = rte_be_to_cpu_32(ecpri_spec->hdr.common.u32);
-
 			hdr = &hdrs->proto_hdr[layer];
 
 			VIRTCHNL_SET_PROTO_HDR_TYPE(hdr, ECPRI);
 
 			if (ecpri_spec && ecpri_mask) {
+				ecpri_common.u32 = rte_be_to_cpu_32(ecpri_spec->hdr.common.u32);
+
 				if (ecpri_common.type == RTE_ECPRI_MSG_TYPE_IQ_DATA &&
 						ecpri_mask->hdr.type0.pc_id == UINT16_MAX) {
 					input_set |= IAVF_ECPRI_PC_RTC_ID;
-- 
2.27.0

