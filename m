Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63288D5B16E
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Dec 2025 14:08:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B5D34065C;
	Mon, 15 Dec 2025 15:08:06 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id DAA1A4026F;
 Mon, 15 Dec 2025 15:08:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765807684; x=1797343684;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=lvc3U9KCIZZma4gIiWBhsLd1zgqe/0AHVKnJS8D8b6M=;
 b=PIFgMWLnK1fTdHWit+1BESe2vbpZCS9+3LhyUfDXHOQDaO9eLLl5/zTt
 UErm7LL6ZtLVGj8b5/HeQiHNDp8IZvcynLqYvAaVvCdt4gewZx6iHWj3j
 7k/vLOsf/Bdfr0YDAboI7P6df6KkGVtsGD+yqgZO5Q50gJFaAwfCnMZYP
 UReN7yyIYQLbwKcrCvrH7SMxOklFtRfzz/MFtexMKUQ9PqBS0hx1hB5jR
 ruSbfe+3E6AYqxLbKruzRH6Hxb76piKAg330xDVhl1yjjt9at39Jmtwtn
 n+wqJegELanBJGhvwjZFTNgIQgk3r5WKzGHXJ1llTrIA0igKmmow84oYG A==;
X-CSE-ConnectionGUID: zK8uI1BWREmtRmmsIpJT4w==
X-CSE-MsgGUID: FFMMB0blTCqgRqou0TnN5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="79078701"
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; d="scan'208";a="79078701"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Dec 2025 06:07:54 -0800
X-CSE-ConnectionGUID: G8Qg63Q/R3y0ANM06ujVGA==
X-CSE-MsgGUID: NS91mPJEQHqdg2H4D4/TGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; d="scan'208";a="196996423"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa010.jf.intel.com with ESMTP; 15 Dec 2025 06:07:53 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH 8/8] net/idpf: ensure all Rx paths are selectable
Date: Mon, 15 Dec 2025 14:05:53 +0000
Message-ID: <20251215140553.2283531-9-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251215140553.2283531-1-ciara.loftus@intel.com>
References: <20251215140553.2283531-1-ciara.loftus@intel.com>
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

Depending on the underlying architecture and CPU flags available, a
different set of Rx paths are defined. The Rx path selection function
iterates sequentially from zero to num_paths where num_paths is the size
of the array as determined by the RTE_DIM macro. However, depending on
the platform, some of these entries may be empty, and valid entries at
the end of the array may never be considered in the selection function.
Fix this by editing the idpf_rx_func_type enum and only defining a value
for the Rx path if it is implemented in the idpf_rx_path_infos array.

Fixes: 12b1c2901761 ("net/idpf: use common Rx path selection infrastructure")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/idpf/idpf_common_device.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/intel/idpf/idpf_common_device.h b/drivers/net/intel/idpf/idpf_common_device.h
index 9d3f35176d..487ca9d93c 100644
--- a/drivers/net/intel/idpf/idpf_common_device.h
+++ b/drivers/net/intel/idpf/idpf_common_device.h
@@ -69,9 +69,13 @@ enum idpf_rx_func_type {
 	IDPF_RX_DEFAULT,
 	IDPF_RX_SINGLEQ,
 	IDPF_RX_SINGLEQ_SCATTERED,
+#ifdef RTE_ARCH_X86
 	IDPF_RX_SINGLEQ_AVX2,
+#ifdef CC_AVX512_SUPPORT
 	IDPF_RX_AVX512,
 	IDPF_RX_SINGLEQ_AVX512,
+#endif
+#endif
 	IDPF_RX_MAX
 };
 
-- 
2.43.0

