Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D773E66880
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Dec 2025 17:28:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2B4EB40A87;
	Fri, 19 Dec 2025 18:26:40 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id B23F640A79
 for <dev@dpdk.org>; Fri, 19 Dec 2025 18:26:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1766165197; x=1797701197;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=cVEykvha6I/55/MMJLXYEX+2SoeCjKaTOGdCD7Ox3a8=;
 b=DjwRcAFvEqi6XVh4syR3fxeMVIc/9RUIFq1ZRJggPcpaZlH5z1bQOX1o
 A9ITY4FeZnuns6F+EOZSWWtDZ+x4KV4YrPdYhY0cFc0RPGgMmbYuAucGx
 IbcrCgGhxJbkeORUZCveXGdyiEWhuL6dX27VVfNqCTh9OWOpxumBxGiCk
 gimawTpGEUdgAnO4+U1NsGhtRyGw3NjH6UmOXrCJr3G6CR2crSVkp3R/u
 qLWkHHE3hrQGAqsElsWayI+D/CMXLUAlaLy4sFy9e7tjH7CTfZy+eTxTL
 9+UAB51qq4wba9w/vg9kamVZtD13rLYTL052m4MPx///hsqsHdCWML3d2 A==;
X-CSE-ConnectionGUID: 6kkLOdpeRim4PW/u/R955w==
X-CSE-MsgGUID: OdgaPqqWRg+rVOBoPMofcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11647"; a="71759509"
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; d="scan'208";a="71759509"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Dec 2025 09:26:37 -0800
X-CSE-ConnectionGUID: bXuK2GO0R7irla6u6q8oLQ==
X-CSE-MsgGUID: OyvBE0/4SGexdk+1XwV54g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; d="scan'208";a="198170507"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 19 Dec 2025 09:26:35 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 21/27] net/intel: remove unnecessary flag clearing
Date: Fri, 19 Dec 2025 17:25:38 +0000
Message-ID: <20251219172548.2660777-22-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251219172548.2660777-1-bruce.richardson@intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
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
index 95e9acbe60..cb45029bd7 100644
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

