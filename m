Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EC7CCFA05
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 14:11:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5CE8340A7F;
	Thu,  6 Nov 2025 15:10:15 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 7554340667;
 Thu,  6 Nov 2025 15:10:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762438213; x=1793974213;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9VrZPuDd44MV9g38qiBY7ONs9cqxnNKw92NtTLyznD8=;
 b=WacTa3Ohtm4bZEEJt60n/xQq0yzH6pPf/abYz4lpdjuHWPLPq5l1DJpD
 FeRuEFI2dFaqqeaJ4JzhQpuVm1PPFYXzQ3/Jg0v94vgG02HRlt9h73HVi
 9oany+gqqoYlgBvYv2bGh2UB5fNckICCmhFK+Fdh8+CRwjwrhQWVLWLzY
 afvlvoduemyZXG8lD6JdIrN3hwykAeVaPMqIZQvB8PCDh+H5SZxJdkEtK
 bW+G7XH/qXh+v9LAnHXhaKzToyRSG8B8FBaK87G2sVTyf0k3O09HW5d4s
 le0uU7k31/d8kC127TDy47/oOyeGpY/coV4qMssz10gDWUj0traP5osz8 Q==;
X-CSE-ConnectionGUID: QqI4AP/BRmOp6TmyPPMgFw==
X-CSE-MsgGUID: 0dgdcnYbRH+qgJiSRApxsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="67185307"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="67185307"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2025 06:10:12 -0800
X-CSE-ConnectionGUID: h26e51doTtaS1Afh1PnJzQ==
X-CSE-MsgGUID: k+ZDJEynSjmpjaBK8Pkzng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="187054743"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 06 Nov 2025 06:10:11 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
	stable@dpdk.org
Subject: [RFC PATCH 09/19] pcapng: rename variable to fix shadowing
Date: Thu,  6 Nov 2025 14:09:38 +0000
Message-ID: <20251106140948.2894678-10-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251106140948.2894678-1-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
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

The "len" variable is shadowed within a function, so rename inner use to
the more descriptive "filter_len" to fix the issue.

Fixes: d1da6d0d04c7 ("pcapng: require per-interface information")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/pcapng/rte_pcapng.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c
index 21bc94cea1..2cc9e2040d 100644
--- a/lib/pcapng/rte_pcapng.c
+++ b/lib/pcapng/rte_pcapng.c
@@ -296,16 +296,15 @@ rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port, uint16_t link_type,
 		opt = pcapng_add_option(opt, PCAPNG_IFB_HARDWARE,
 					 ifhw, strlen(ifhw));
 	if (filter) {
-		size_t len;
+		const size_t filter_len = strlen(filter) + 1;
 
-		len = strlen(filter) + 1;
 		opt->code = PCAPNG_IFB_FILTER;
-		opt->length = len;
+		opt->length = filter_len;
 		/* Encoding is that the first octet indicates string vs BPF */
 		opt->data[0] = 0;
 		memcpy(opt->data + 1, filter, strlen(filter));
 
-		opt = (struct pcapng_option *)((uint8_t *)opt + pcapng_optlen(len));
+		opt = (struct pcapng_option *)((uint8_t *)opt + pcapng_optlen(filter_len));
 	}
 
 	opt = pcapng_add_option(opt, PCAPNG_OPT_END, NULL, 0);
-- 
2.48.1

