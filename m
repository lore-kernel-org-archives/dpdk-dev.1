Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C76E7E0BC
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 16:48:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8EAA240E0F;
	Mon,  9 Feb 2026 17:46:11 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 8BA2A40DD7
 for <dev@dpdk.org>; Mon,  9 Feb 2026 17:46:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770655567; x=1802191567;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=PULBKB1F51xgrpJY68HRsnZ7Irj3+fcjrn+V1mUBcGA=;
 b=H1luNutdPEJUTZjRfzcJlOczwPXL4PzfUpbwD9KeoLuQhHling2sXcI5
 sNxUnH7slPfVNSAhlZNL/rp2ujjRomI6HztIiYkqzh00UyNF566k6WHcl
 HrnCyBXXWW89vF2+UF5SGckQ0C5dzccXGL+cbSk+wRIHlv7qO/4ZTzz/S
 9t4JWqekbHTgHXWA5HlZjRUBTMSvPhyxZmNrwJctEPMjMLp/c/+LarEyZ
 CgSolKx9smRsXe0uS7bXQukmhxli4H1DiverRYcl9Pad7D4tW/3ctOaaq
 4U1FIE1sgYxGMB5DtOFFXWls70bGd9W+WkxMbY9rb3DSrJC6yThPxMf/A w==;
X-CSE-ConnectionGUID: +p7gc1xaQRC2EVmW+QfsVg==
X-CSE-MsgGUID: uXN0zA3/Qqq1IziFA0xrbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="71663471"
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="71663471"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 08:46:06 -0800
X-CSE-ConnectionGUID: xLdHDK1TRburNYfOZha38A==
X-CSE-MsgGUID: 7/CTJXLaSyi2sk0q3pxa6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="210789168"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa006.fm.intel.com with ESMTP; 09 Feb 2026 08:46:05 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 21/35] net/intel: remove unnecessary flag clearing
Date: Mon,  9 Feb 2026 16:45:19 +0000
Message-ID: <20260209164538.1428499-22-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209164538.1428499-1-bruce.richardson@intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260209164538.1428499-1-bruce.richardson@intel.com>
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
 drivers/net/intel/common/tx_scalar.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/net/intel/common/tx_scalar.h b/drivers/net/intel/common/tx_scalar.h
index 71f96349c3..3e54cd7607 100644
--- a/drivers/net/intel/common/tx_scalar.h
+++ b/drivers/net/intel/common/tx_scalar.h
@@ -46,13 +46,6 @@ ci_tx_xmit_cleanup(struct ci_tx_queue *txq)
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

