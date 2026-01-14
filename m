Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD56DD37E56
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 15:46:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1B94340DD2;
	Wed, 14 Jan 2026 16:45:17 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id CEDFA40BA3;
 Wed, 14 Jan 2026 16:45:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768405517; x=1799941517;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fYeYCG5mt6l94wJgGOLrcEN3COoaXIlpKp3scsfWXCk=;
 b=oBR3b7+ygzyld/BW3YTZ8VxKl6SrfPwBGrJ0ofeMjvp5b26v6rA/fo0z
 uCAl9PejB+RGty7GmSX2gL5P+D1xmeonT/F7N7DbDq1RNtARhgGBG6fEG
 jk78mZzs7cLTE18MpsjFo1PBnoZI0f7ZkpKJ2a/hWQUTUWQoaCKX+5io6
 zwBmfc9q+Fg5EC7vr0MwDK26jjgY9c+BEEOqOc/aXjvfsQBaki5ScNFqS
 i89D63y71MUDi3nGweOcPt60g9VfMZkxRgfpvN3QdqSj86vC2tijKJNLf
 UNyIRdX9A/9xZmttAnSHfwi4CwLasAjCE+aZla/I5ZorjwqPUYsFKnNwc Q==;
X-CSE-ConnectionGUID: /TRIPMtjSreK8edQ1KuYzw==
X-CSE-MsgGUID: lcpPxrLISAO2vomuKoecaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="69870830"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; d="scan'208";a="69870830"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2026 07:45:16 -0800
X-CSE-ConnectionGUID: GrGTeeLWQceckkqgsl9rQw==
X-CSE-MsgGUID: 3HODrnP8Qm+CR5/jH10IlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; d="scan'208";a="203924989"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 14 Jan 2026 07:45:14 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v4 09/31] pcapng: rename variable to fix shadowing
Date: Wed, 14 Jan 2026 15:44:23 +0000
Message-ID: <20260114154450.2969716-10-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114154450.2969716-1-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20260114154450.2969716-1-bruce.richardson@intel.com>
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
Acked-by: Stephen Hemminger <stephen@networkplumber.org>
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
2.51.0

