Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C49C5CDB479
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 10:37:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF57440689;
	Wed, 24 Jun 2026 12:37:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 2706C40670;
 Wed, 24 Jun 2026 12:37:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782297434; x=1813833434;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=krdXqTXFiIe3NzmfmU0sAu3zXbNycDuSTl5GlgJ2zzk=;
 b=hxPSndwl2iPg8pfJrz/no/LAJwKGhflER2Z3urKT4wtzzWQwWtSNDCgi
 0aE5TemY/GDYt/cjbCS0epKs9Kn9JBY3QXi/fDEg8UdRiFz7VrAsgWkmX
 M4RbRH5AsqCrOAQEFea4oep60jjSE9xguPfZzC7LN2tnJYqRxyZJ3AU2D
 b5VJZbJAMexdUD4jlsiJ3ZurGGpRoLvryqVQLYc1gkX01qR3tzO+GHi0Y
 ccKi2V/kZXb3szNklPk544vwLwj3vxSwdP7K8ICizAZ0vb2N/wR9QoBJA
 bNssmMov+hY5xuy34LabHUNrGFVeE+gD8LAHdKsTSqD98GnCHzK99OLIY A==;
X-CSE-ConnectionGUID: 7uEr9mI0QOm9JvvC+tHf+Q==
X-CSE-MsgGUID: NSNc28I9RKOZVPkYgSTFcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="93652349"
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="93652349"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2026 03:37:14 -0700
X-CSE-ConnectionGUID: dsD/Rz26RqWJEcfiav9SZg==
X-CSE-MsgGUID: H1Ed2l5DR3+Gzx2z+hseJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="245460036"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.224.226])
 by fmviesa006.fm.intel.com with ESMTP; 24 Jun 2026 03:37:12 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Shepard Siegel <shepard.siegel@atomicrules.com>,
 Ed Czeck <ed.czeck@atomicrules.com>,
 John Miller <john.miller@atomicrules.com>
Subject: [PATCH v2 06/17] net/ark: replace strncpy with strlcpy
Date: Wed, 24 Jun 2026 11:36:45 +0100
Message-ID: <20260624103658.792750-7-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624103658.792750-1-bruce.richardson@intel.com>
References: <20260623165150.765443-1-bruce.richardson@intel.com>
 <20260624103658.792750-1-bruce.richardson@intel.com>
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

Replace strncpy() with safer strlcpy() which always null-terminates.

Fixes: 1131cbf0fb2b ("net/ark: stub PMD for Atomic Rules Arkville")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/ark/ark_ethdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ark/ark_ethdev.c b/drivers/net/ark/ark_ethdev.c
index 9272e271e6..d6b1abf383 100644
--- a/drivers/net/ark/ark_ethdev.c
+++ b/drivers/net/ark/ark_ethdev.c
@@ -929,7 +929,7 @@ process_file_args(const char *key, const char *value, void *extra_args)
 			return -1;
 		}
 		if (first) {
-			strncpy(args, line, ARK_MAX_ARG_LEN);
+			strlcpy(args, line, ARK_MAX_ARG_LEN);
 			first = 0;
 		} else {
 			strncat(args, line, ARK_MAX_ARG_LEN);
-- 
2.53.0

