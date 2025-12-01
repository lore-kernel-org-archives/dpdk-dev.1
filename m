Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB608D116F1
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Dec 2025 11:47:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1FB3340E0C;
	Mon,  1 Dec 2025 12:45:37 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 1AE1840DCB
 for <dev@dpdk.org>; Mon,  1 Dec 2025 12:45:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764589530; x=1796125530;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2P4Iau/o1XBiW1+HzXcmy94YkEqZZaXBJJaJOTQDD5c=;
 b=Kl9SymxCGkCtlKO/dLv/EF42Cdpb07uBR7cGW8d1H8TCJtPpUEIZZHDR
 nIemPLMMLqspkbRGNivqeJIIhbXe3TdIN2pEl1pfHCJhVS5zB87Z5mv03
 6de4BaMryafxFJfbfr4ysq4/QIRWW4P/xT6FAej4hJNzoxFQj6WMrYe6W
 M9/yXli0fyO/unWrPV3A6AfIZPTjMVuZfC12Tg6X7GftUPzNDoML2e8Jl
 G2zugQZpi+3A2VIrX8vpLgWdDEduGT/DJMaKi7UElK6rsw7ytFnNsvXoW
 XvRCT+7acRtzfG/LUWm/yNq9frJHXG+5Qk/9gStOyObpuIDmLe0fcg8J6 A==;
X-CSE-ConnectionGUID: jWOtie2jSZO8qFI8WwzYuA==
X-CSE-MsgGUID: BMsdqiIMQX+hc2WYUFLupg==
X-IronPort-AV: E=McAfee;i="6800,10657,11629"; a="77991767"
X-IronPort-AV: E=Sophos;i="6.20,240,1758610800"; d="scan'208";a="77991767"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Dec 2025 03:45:29 -0800
X-CSE-ConnectionGUID: lG2uh0W5S0alE0NtxOSgeA==
X-CSE-MsgGUID: 3eFTBd+CQDybqvVJQG2trg==
X-ExtLoop1: 1
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa003.fm.intel.com with ESMTP; 01 Dec 2025 03:45:29 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 25/31] app/test-flow-perf: remove unneeded variable
Date: Mon,  1 Dec 2025 11:44:42 +0000
Message-ID: <20251201114448.1441377-26-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251201114448.1441377-1-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20251201114448.1441377-1-bruce.richardson@intel.com>
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

Remove an unnecessary second definition of a char * variable called
"token" when processing commandline args.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test-flow-perf/main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/app/test-flow-perf/main.c b/app/test-flow-perf/main.c
index a8876acf1f..6636d1517f 100644
--- a/app/test-flow-perf/main.c
+++ b/app/test-flow-perf/main.c
@@ -916,7 +916,6 @@ args_parse(int argc, char **argv)
 			if (strcmp(lgopts[opt_idx].name,
 					"port-id") == 0) {
 				uint16_t port_idx = 0;
-				char *token;
 
 				token = strtok(optarg, ",");
 				while (token != NULL) {
-- 
2.51.0

