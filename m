Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43967D2F32A
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 15:18:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1438940DDD;
	Tue, 13 Jan 2026 16:15:45 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 50B0E40DCB
 for <dev@dpdk.org>; Tue, 13 Jan 2026 16:15:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768317342; x=1799853342;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QfwzrYiZzWMyqCe7lzgi1ja/xaqwWJcpmvae+dQ7pd8=;
 b=LZzHvcR8/HuJChnFfJhKD7OU1TrouNA5h89+DdfhdEIsHQJMXWdZG0Ke
 C0BGZXFLULGOobTTUlZtDc0/5ETp9D9TF4s2TLpO76oxBlFiLg2qBpjtx
 1xBc0ewFRAjqtUeKoScHxAvQFsIPOBv2r/EhqbYMj+9PLlAzbdLQDmOSH
 anR4MvfPo6TOu4EGZX0TmBqjmfG4Rzf2yfFywPhLNP5F61RbzCgMzU0Zm
 EnWPF8nCEmdKdMndqI0Dz5g81o8WG0yhT40D3iWEKk3FS1O3+UI0yhkJA
 92gIAnZxEo57b841fAJz6bOJPSVrplTwBS4CLvZ/EpSvutIVlI1Tnfdbn g==;
X-CSE-ConnectionGUID: 7yEIdbuXRUCqV1jYSVEb1A==
X-CSE-MsgGUID: Emr9B7CgSYy+dPSUH46VqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="80969208"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; d="scan'208";a="80969208"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jan 2026 07:15:41 -0800
X-CSE-ConnectionGUID: 9Ph94wYtTy+RbPCp5UDsig==
X-CSE-MsgGUID: NkLUTJZYSd2++IpyeClJSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; d="scan'208";a="203556634"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa006.jf.intel.com with ESMTP; 13 Jan 2026 07:15:40 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 22/36] net/intel: remove unnecessary flag clearing
Date: Tue, 13 Jan 2026 15:14:46 +0000
Message-ID: <20260113151505.1871271-23-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260113151505.1871271-1-bruce.richardson@intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260113151505.1871271-1-bruce.richardson@intel.com>
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
index 7cb4d3efb9..68c05524b0 100644
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

