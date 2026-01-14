Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40472D37E44
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 15:48:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 024FD40EDD;
	Wed, 14 Jan 2026 16:45:52 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id B2C9E406B7
 for <dev@dpdk.org>; Wed, 14 Jan 2026 16:45:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768405550; x=1799941550;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IahgOJz7gfEVmDhoJEn1VjsMWHwF/krOA3JZZYLbcFc=;
 b=YcPMt/deqQkw4WABFBPh/1eE6KabgOXtaDlUkgAtKLHEOuHmSSAHy720
 ChJ3gtu/dLwMBm7OcDnP/3pbtpZ/e8m1ONF1hg4ZraUd4BQLF/fU45E+z
 jPjWH/f2tLn83WMsm/PhYci73IbPAqDMKxkivSN/OfIFiUypjB5CIAHBX
 dVK6hAVomO0Q30y2a1NiISnG3Z0mKljp+UzvqHzZuTFhHQfpMlTCsdZug
 H30chuqhKTmHjeEXNyIxCEEwDUtZUy1WCAPhzfPXvEXscMiQvbk8gJ4Sc
 Xlv//Af/AY6Hn2dV/JsEcQqU3eXAiNZDrZOOl+2AX+bD6xIFhAKXOWhh4 A==;
X-CSE-ConnectionGUID: Ef/HoMeHQgmlbOspVE7XXA==
X-CSE-MsgGUID: E2VGIJfOQdmu05qslkA7aQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="69870951"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; d="scan'208";a="69870951"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2026 07:45:45 -0800
X-CSE-ConnectionGUID: 600xUf3fRtW6hp2+hPzZCg==
X-CSE-MsgGUID: uVUrAH1ZSG247XK8u87eew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; d="scan'208";a="203925084"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 14 Jan 2026 07:45:43 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>
Subject: [PATCH v4 27/31] app/test-pipeline: remove unnecessary variable
Date: Wed, 14 Jan 2026 15:44:41 +0000
Message-ID: <20260114154450.2969716-28-bruce.richardson@intel.com>
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

The second definition of a variable called "ret" in the main function is
unnecessary and causes variable shadowing warnings, so just eliminate
it.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test-pipeline/main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/app/test-pipeline/main.c b/app/test-pipeline/main.c
index 4cc098d7ac..e5efafdf28 100644
--- a/app/test-pipeline/main.c
+++ b/app/test-pipeline/main.c
@@ -89,7 +89,6 @@ main(int argc, char **argv)
 	/* Close ports */
 	for (i = 0; i < app.n_ports; i++) {
 		uint16_t port;
-		int ret;
 
 		port = app.ports[i];
 		printf("Closing port %d...", port);
-- 
2.51.0

