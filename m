Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FC2CD37B5
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 May 2026 09:18:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4768A4065A;
	Mon, 11 May 2026 11:17:56 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id F0FDC40609
 for <dev@dpdk.org>; Mon, 11 May 2026 11:17:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778491074; x=1810027074;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Tqg2gFguJaaVLaWNi6ZS6APSji9ha1iEfWKbhppdQGg=;
 b=bZfEOjbqoGxplHh5CzJ0xww7wpMcygCtba6sx4mr4bEMlyj9+A0LOSPd
 PPe14EVcZMWxn+2KGCs/PWH0kf0gri95qeDYA5KcVOSLhF0yAydT0QA2H
 Z54xSnsKGORK0yuNBCf3W4ls3YK9D68n5O2yfwoyfetfOG99NGkWW7JCg
 K+Hs8Yywd32+N84LlWA7C4tO1EFmGPicp9Rgt8zV4E7Z/3JQblVy/FTHe
 TtyIeVFE65UhpWmdLKOkZau2hKsKBOvON0XwGuX4X8KrYiJl5ydEh1wMy
 EHtbA1LhXsSqWk/m/JPPFot+6GGQzS9OKWnCzqGyh0nrd24I/3e9ls8Rk A==;
X-CSE-ConnectionGUID: Imx5gJb8Rv6EHydBurPbRw==
X-CSE-MsgGUID: qbXRH/5GQ6eHscrTdr7pqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="96937066"
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; d="scan'208";a="96937066"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2026 02:17:54 -0700
X-CSE-ConnectionGUID: ypkpaXTkRi6RkoyodhEUgg==
X-CSE-MsgGUID: 2CZxR+QbRD61Dx/tb5jlww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; d="scan'208";a="234739682"
Received: from unknown (HELO sprmax15..) ([10.138.182.128])
 by fmviesa008.fm.intel.com with ESMTP; 11 May 2026 02:17:52 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: aman.deep.singh@intel.com
Subject: [PATCH 3/6] net/idpf: fix mbuf initializer source in split queue AVX2
 Rx
Date: Mon, 11 May 2026 14:39:32 +0530
Message-ID: <20260511090935.2288837-4-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260511090935.2288837-1-shaiq.wani@intel.com>
References: <20260511090935.2288837-1-shaiq.wani@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

In split queue mode the completion queue (rxq) does not own the mbuf
pool — the buffer queue (bufq2) does.  The mbuf initializer encodes
the mempool pointer, refcount and other per-pool mbuf metadata that
is stamped into every received mbuf during rearm.

Using queue->mbuf initializer reads an uninitialised or zero value
from the completion queue, corrupting every mbuf rearm.  Use
queue->bufq2->mbuf initializer to get the correct value from the
buffer queue that actually owns the mbufs.

Fixes: 1f065f9d75ff ("net/idpf: add AVX2 Rx path for split queue config")
Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
---
 drivers/net/intel/idpf/idpf_common_rxtx_avx2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
index 28d4246134..d3a8e17778 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
@@ -491,7 +491,7 @@ idpf_dp_splitq_recv_pkts_avx2(void *rxq, struct rte_mbuf **rx_pkts, uint16_t nb_
 	struct rte_mbuf **sw_ring = &queue->bufq2->sw_ring[queue->rx_tail];
 	volatile union virtchnl2_rx_desc *rxdp =
 		(volatile union virtchnl2_rx_desc *)queue->rx_ring + queue->rx_tail;
-	const __m256i mbuf_init = _mm256_set_epi64x(0, 0, 0, queue->mbuf_initializer);
+	const __m256i mbuf_init = _mm256_set_epi64x(0, 0, 0, queue->bufq2->mbuf_initializer);
 	uint64_t head_gen;
 	uint16_t received = 0;
 	int i;
-- 
2.34.1

