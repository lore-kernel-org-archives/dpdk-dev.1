Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC75D37E56
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 15:47:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D4E4740DD6;
	Wed, 14 Jan 2026 16:45:49 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 570B0406B7
 for <dev@dpdk.org>; Wed, 14 Jan 2026 16:45:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768405549; x=1799941549;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2P4Iau/o1XBiW1+HzXcmy94YkEqZZaXBJJaJOTQDD5c=;
 b=EA3YGeWS3T1MbOAAZg2sHdTI1+U00xQSD2fQR6r5P9zLnuTnCi9hxPi5
 6xpcuKLLKYKlxCCG+Abvy4GSRj+770tjfqfnyhEwbWauwhA0AmGlwR7iR
 KSr+OkQVx3qzrr5TkPAvPAvYgmD6o7xgU3v4PqWRw+BMmjhrMKopcQUnH
 ry6Kq7nJ89uHZlrZRxu+3Lf+3Yar8Bc1Kd1bn80Ml3SL/U4u8gyxW5W+0
 Mqv/gyNieXjvE7Ne1yjgOlz0Iv8pdwfZ7d7jQO4Kj0S0DmyFsDU5VmViY
 lvjTffsSGDf8RtnOu+2My86EXur4DHan+3cR4uCQk1Cu/myukUcXJmmfW A==;
X-CSE-ConnectionGUID: BpGUfbIpRjWVg8t1gcOWFA==
X-CSE-MsgGUID: iWI3OdyYS02ljDVP83bl7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="69870938"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; d="scan'208";a="69870938"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2026 07:45:43 -0800
X-CSE-ConnectionGUID: Mdr1Yu80SaKTTsHitmIAwg==
X-CSE-MsgGUID: JKdOWA+MQxqtYTDywisBzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; d="scan'208";a="203925064"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 14 Jan 2026 07:45:41 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Wisam Jaddo <wisamm@nvidia.com>
Subject: [PATCH v4 25/31] app/test-flow-perf: remove unneeded variable
Date: Wed, 14 Jan 2026 15:44:39 +0000
Message-ID: <20260114154450.2969716-26-bruce.richardson@intel.com>
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

