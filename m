Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F722E66880
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Dec 2025 17:28:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3BD0B40B99;
	Fri, 19 Dec 2025 18:26:41 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id A721040A79
 for <dev@dpdk.org>; Fri, 19 Dec 2025 18:26:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1766165198; x=1797701198;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TVLcy4FnvBFVVL/SGeqWMexXEyMJGqNYuDYx8WxToE0=;
 b=SzX7xU0C5cJy1HMzrPM3kRysSo1Gdg1qsrig/abeXmUjNKuzCE8aP9r/
 r5Hx3qOJinkwdIqkyBxqpbiZvigzthTR68qWOwluyq1bfjmQspVnA4wbI
 4qgQfa62Os4Lq1+VrQtjNruBjtZ692q9WK4DAXJS+Xs4RpHz61nl5svya
 0rNcBV4mprgjjHGACI17gy6YsCZO9U79Rye3j7MIHOFZHxX1P2CdxVRm0
 tl4cLrctLlGDoT1tv9G7nNczg5S1MCA0YMGyyq44TQTV9tWiGkIakXwlB
 hUP3fO67QWa0bMBVM/mCVCz6ZZxpuF3DgRty6iL7q+Rpmxd8ngSfTBBov A==;
X-CSE-ConnectionGUID: 6iQAXaoBQuKPqBf5Ri5+mw==
X-CSE-MsgGUID: KidftRCtR724gmAJxOs1Nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11647"; a="71759514"
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; d="scan'208";a="71759514"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Dec 2025 09:26:38 -0800
X-CSE-ConnectionGUID: P2/w9bdwRKiP4gcRzIZfhA==
X-CSE-MsgGUID: nLtw7IjUQBmXWm8/db5hDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; d="scan'208";a="198170512"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 19 Dec 2025 09:26:36 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 22/27] net/intel: mark mid-burst ring cleanup as unlikely
Date: Fri, 19 Dec 2025 17:25:39 +0000
Message-ID: <20251219172548.2660777-23-bruce.richardson@intel.com>
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

It should rarely be the case that we need to cleanup the descriptor ring
mid-burst, so mark as unlikely to help performance.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/common/tx_scalar_fns.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/common/tx_scalar_fns.h b/drivers/net/intel/common/tx_scalar_fns.h
index cb45029bd7..27791cf138 100644
--- a/drivers/net/intel/common/tx_scalar_fns.h
+++ b/drivers/net/intel/common/tx_scalar_fns.h
@@ -272,7 +272,7 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
 		if (tx_last >= txq->nb_tx_desc)
 			tx_last = (uint16_t)(tx_last - txq->nb_tx_desc);
 
-		if (nb_used > txq->nb_tx_free) {
+		if (unlikely(nb_used > txq->nb_tx_free)) {
 			if (ci_tx_xmit_cleanup(txq) != 0) {
 				if (nb_tx == 0)
 					return 0;
-- 
2.51.0

