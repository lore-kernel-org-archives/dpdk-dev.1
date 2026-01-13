Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3729D2F32A
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 15:18:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3C1BF40DFD;
	Tue, 13 Jan 2026 16:15:46 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 4786940DD1
 for <dev@dpdk.org>; Tue, 13 Jan 2026 16:15:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768317343; x=1799853343;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2dW7a3o0wkwJof5kcvfq/1l2U4DWRV6Wg63BXWrajdM=;
 b=KHEc6waX5Ey0wyLrNZ/T2jBinmzRPuQSI//fDHZY7R4Jw+erfxWbM7cM
 W9dq0J+/bbSnykXBVdeBT+n9R6qb/nrhi5ySJpcZ1ex/sC352nhByldeI
 EPCdo9u+LCcIm0qsdvYuv5rBapTc0cr8/+JXD7w8hyYBsD6M6Iti0Nir+
 PHIRKHOEAQhsEg+MHE1WXKfJk6HXPeoJDKG8dgd8M1SsncaPv8c5qiI3T
 Bk/QVk8MYSbmsWE9ec+9X9CC2bSEdpz8ICvL2FWyFKADbmDoaGIvJFSt1
 YDUyu6L/QacF1ApyOEBQrRImBMf/4Iw3dWNoLOdWU9z1PKo368273CMYq g==;
X-CSE-ConnectionGUID: xsg9SMPhSoeV0nZrnNoQHQ==
X-CSE-MsgGUID: jDHvdU9LQTq8qbvqMP7o2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="80969209"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; d="scan'208";a="80969209"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jan 2026 07:15:42 -0800
X-CSE-ConnectionGUID: iS+8/OPLSWyadrzY0Hmufw==
X-CSE-MsgGUID: 5eTgYEXQTM6vLBlUVtZT1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; d="scan'208";a="203556640"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa006.jf.intel.com with ESMTP; 13 Jan 2026 07:15:41 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 23/36] net/intel: mark mid-burst ring cleanup as unlikely
Date: Tue, 13 Jan 2026 15:14:47 +0000
Message-ID: <20260113151505.1871271-24-bruce.richardson@intel.com>
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

It should rarely be the case that we need to cleanup the descriptor ring
mid-burst, so mark as unlikely to help performance.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/common/tx_scalar_fns.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/common/tx_scalar_fns.h b/drivers/net/intel/common/tx_scalar_fns.h
index 68c05524b0..58196dc02a 100644
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

