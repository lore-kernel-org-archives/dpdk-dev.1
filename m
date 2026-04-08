Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E3910F9953
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Apr 2026 15:48:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0BC114014F;
	Wed,  8 Apr 2026 17:48:11 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id D9C314013F
 for <dev@dpdk.org>; Wed,  8 Apr 2026 17:48:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775663289; x=1807199289;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=IT1C2KWxHCzvnQSdjI8RG1wdwOHsgoSUoiMjmd2zdsY=;
 b=XWNSy2r9anaybEPOAY08L6CW+Ig+wcB9rpEB7deoHUj4xMfYRj574bDG
 O6vLtDYqAgI79Ort+I2L/61Q9ZWDFj/txdn74Jau6e7pKOm3s2sWCovBu
 BSNnc/rcBtFP4grlih2beDa0Buexfmah3kIuS+WL3ybpNEZlaCqCqaVGk
 5aS6JrHdrRVj1pOfmnkjx6AIBeMXRGHZR7svfRKQdVhBkb7PT6WIH0IpQ
 XGQ4YoULYsMqAgHNhvjKdH6DXunQDEg7s91N+Z517goz3c8hARsrQUrum
 rN25DuMTW5ziBL0cTMjAqgc39YFdcur54PiIsik43gLqr/Dq8iK5GoV94 w==;
X-CSE-ConnectionGUID: OqFDNVA/QE2BKDhKyXIjpQ==
X-CSE-MsgGUID: MgUboVKURQ2CBcrgQe6xeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="76541223"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="76541223"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 08:48:08 -0700
X-CSE-ConnectionGUID: 194/vX6iTz+N9sZAGY/7BA==
X-CSE-MsgGUID: IuEgUGg0QkuJOoZEjXcdnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="228399496"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa009.jf.intel.com with ESMTP; 08 Apr 2026 08:48:07 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH] net/ixgbe: shrink size of context index
Date: Wed,  8 Apr 2026 16:48:04 +0100
Message-ID: <20260408154804.1596060-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
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

The ixgbe driver only supports two contexts, so using uint32_t for the
context index is excessive. Reducing this to uint8_t shrinks the ixgbe
part of the union from 32 bytes to 24. Although it does not in itself
shrink the space for the whole struct, it is worth doing as ixgbe is the
second-largest block in the union, so may become relevant if other
rework shrinks the idpf-specific block.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/common/tx.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
index f2123f069c..8cb281aa20 100644
--- a/drivers/net/intel/common/tx.h
+++ b/drivers/net/intel/common/tx.h
@@ -200,7 +200,7 @@ struct ci_tx_queue {
 		struct { /* ixgbe specific values */
 			const struct ixgbe_txq_ops *ops;
 			struct ixgbe_advctx_info *ctx_cache;
-			uint32_t ctx_curr;
+			uint8_t ctx_curr;
 			uint8_t pthresh;   /**< Prefetch threshold register. */
 			uint8_t hthresh;   /**< Host threshold register. */
 			uint8_t wthresh;   /**< Write-back threshold reg. */
-- 
2.51.0

