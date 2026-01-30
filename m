Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81912E6BF04
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 11:44:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE92D40DD0;
	Fri, 30 Jan 2026 12:42:51 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id B179740678
 for <dev@dpdk.org>; Fri, 30 Jan 2026 12:42:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769773366; x=1801309366;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TdEWZSex0JHvUwQhdaXK522NPRyyFuXUDEHRY13saX4=;
 b=meuJ+xrd9DlnR9b0xzT3h/F2cSEPzaksU+/VVmrMlBWA4bFjVQJIjbaG
 RQrtJngnDek8ihbXpDlgAcKZp/NyzjXaSJS4C2kH3w9mAdRsLYy5YRM2m
 9xShSztoqqtrMYINm4EtP46x2+lMHzVik62px61KXUbL9lHNfApLcAWPW
 YLZKN+XYh8n/wqSLd+liXMZZegIw0fHfNApCgTaf7HBsfxk6tXxDu/765
 Ci3k+tJ4cuVHwgAkbHaf1k1jpb5WaETaGrrdSvse1ahDa+0Ior6cGWqu0
 a6elajJUuDHGpzztKT9ixFY5u0gbT1/sdMd64MhNMath91AVLJd4AHzb1 g==;
X-CSE-ConnectionGUID: dw0e1febTwqcKzhWseOGhw==
X-CSE-MsgGUID: JSosSr+DQm2kNyRMo/eBnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="82392319"
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; d="scan'208";a="82392319"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jan 2026 03:42:45 -0800
X-CSE-ConnectionGUID: X1SlU8PbQJ2qrp5ij3e8Ng==
X-CSE-MsgGUID: I8grgfdKT1CBPBHKVAdNqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; d="scan'208";a="209190535"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa010.fm.intel.com with ESMTP; 30 Jan 2026 03:42:44 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 22/36] net/intel: remove unnecessary flag clearing
Date: Fri, 30 Jan 2026 11:41:49 +0000
Message-ID: <20260130114207.1126032-23-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260130114207.1126032-1-bruce.richardson@intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260130114207.1126032-1-bruce.richardson@intel.com>
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

When cleaning the Tx ring, there is no need to zero out the done flag
from the completed entry. That flag will be automatically cleared when
the descriptor is next written. This gives a small performance benefit.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/common/tx_scalar_fns.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/net/intel/common/tx_scalar_fns.h b/drivers/net/intel/common/tx_scalar_fns.h
index ee93ce5811..90dc6ae423 100644
--- a/drivers/net/intel/common/tx_scalar_fns.h
+++ b/drivers/net/intel/common/tx_scalar_fns.h
@@ -51,13 +51,6 @@ ci_tx_xmit_cleanup(struct ci_tx_queue *txq)
 	else
 		nb_tx_to_clean = (uint16_t)(desc_to_clean_to - last_desc_cleaned);
 
-	/* The last descriptor to clean is done, so that means all the
-	 * descriptors from the last descriptor that was cleaned
-	 * up to the last descriptor with the RS bit set
-	 * are done. Only reset the threshold descriptor.
-	 */
-	txd[desc_to_clean_to].cmd_type_offset_bsz = 0;
-
 	/* Update the txq to reflect the last descriptor that was cleaned */
 	txq->last_desc_cleaned = desc_to_clean_to;
 	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free + nb_tx_to_clean);
-- 
2.51.0

