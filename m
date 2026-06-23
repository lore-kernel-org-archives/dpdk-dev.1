Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 371CDCDB471
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 16:52:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8E26D406B4;
	Tue, 23 Jun 2026 18:52:09 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id CAF9440667;
 Tue, 23 Jun 2026 18:52:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782233527; x=1813769527;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=krdXqTXFiIe3NzmfmU0sAu3zXbNycDuSTl5GlgJ2zzk=;
 b=ay+Dl0HGViPzmwO//9Bk1c604SCNyxarb6YAi2XUUrMp1kYV/UGBZRz+
 ++518So4OmZTfa4Q7VZGRyv8fcUYSm5hQwUIE9xX5+p7M+/LCYBcbDW6c
 IrSNnxvHS0k74shOuu7ztxVz+95I8DWoNbP9tFU+sSi095ioLiCE5Xidk
 fIsyg7/XeE9OWZXpn7dkSDNw5MDg7wNGLQlcMW+MhYZROok+TP8iOsPIi
 pVl5htTAUAKJh7zf8kPGyGbK1DgEzBlPP8jim8A5wupVuI7meP68a2+sU
 AAgRBORQ7yROfE1JY9VTICBimbs8DVkHMXmq3u6cePUHZ021gFnunecC3 A==;
X-CSE-ConnectionGUID: vqE2Z8ntRHGtY/C4UfU2Zw==
X-CSE-MsgGUID: 6RChUmK1QaGiwcpRs1CZmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="100534639"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; d="scan'208";a="100534639"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 09:52:07 -0700
X-CSE-ConnectionGUID: f2Fz8vY8SVWp1QmJIc3y6g==
X-CSE-MsgGUID: 3afdjNMdSbCQFrLP102OFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; d="scan'208";a="253928307"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.224.226])
 by orviesa004.jf.intel.com with ESMTP; 23 Jun 2026 09:52:05 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Shepard Siegel <shepard.siegel@atomicrules.com>,
 Ed Czeck <ed.czeck@atomicrules.com>,
 John Miller <john.miller@atomicrules.com>
Subject: [PATCH 06/17] net/ark: replace strncpy with strlcpy
Date: Tue, 23 Jun 2026 17:51:36 +0100
Message-ID: <20260623165150.765443-7-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260623165150.765443-1-bruce.richardson@intel.com>
References: <20260623165150.765443-1-bruce.richardson@intel.com>
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

