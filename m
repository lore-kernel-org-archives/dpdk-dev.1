Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C3B4ECD6D3
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 18:15:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DE65C40E38;
	Wed, 11 Feb 2026 19:13:59 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 8207A40E2C
 for <dev@dpdk.org>; Wed, 11 Feb 2026 19:13:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770833635; x=1802369635;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vS31N3HQtzkJ4DbfjTafCADJFvluSYKJozksqXl2624=;
 b=b/yltGfXtOhsECISda7ZJB5So8U40Qb/A300s6PQ3nm9PexakjISOfnZ
 ifWA304FsvNYngcLziJis4kbspKW3t05h98Lasj1wtwXSP1pGPIIptdtx
 Nc0YNk0/laJJ2PpRAHOoEOyXgJlEHs3r4M3iWagu7Fkdol5fhBgi+gKTd
 /WQDKVOPjcxxG3EidRdua6v4KM0n2E/d7HZnrvj37QZ9XVrGXf5h4xpNp
 B+vHU16ZBDUQlFZLop9OJ5oJvBDQyh+jTVKofzJP/jRNXPYqj0rS4+1tR
 Qvv8vQzdAFFMkvEkTYwisRHdRx6M9rsOtTOBTriXe/w6d29o52tYdcBtT A==;
X-CSE-ConnectionGUID: lTNrLGXtTsWwhJ3800k28Q==
X-CSE-MsgGUID: E0lacXmKRIuQjfHmE0eF4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="75834689"
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; d="scan'208";a="75834689"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 10:13:54 -0800
X-CSE-ConnectionGUID: u/u00eYASRqnui0I/qRBVQ==
X-CSE-MsgGUID: PUdCRYodTLK0UmhUpn755g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; d="scan'208";a="249986367"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa001.jf.intel.com with ESMTP; 11 Feb 2026 10:13:53 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v5 21/35] net/intel: remove unnecessary flag clearing
Date: Wed, 11 Feb 2026 18:12:50 +0000
Message-ID: <20260211181309.2838042-22-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260211181309.2838042-1-bruce.richardson@intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260211181309.2838042-1-bruce.richardson@intel.com>
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
Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/common/tx_scalar.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/net/intel/common/tx_scalar.h b/drivers/net/intel/common/tx_scalar.h
index 00771402f8..56c2dd526f 100644
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

