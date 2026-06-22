Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1F5CDB470
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Jun 2026 11:18:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9DA414042F;
	Mon, 22 Jun 2026 13:18:46 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 87B524028B;
 Mon, 22 Jun 2026 13:18:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782127123; x=1813663123;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pyzCwC8qsII/dXcTzZiBdPF3oC+fnO2NjUW//KDXwjA=;
 b=JNLNzo6hlKT9f40FXJY8tL4V0eDsYcZxRn8CvZvYLRNGagY+EVyCkrBo
 teUaHmhn2dwNc7Y7x+Iq+/K/Gk1Y3UKa6sjq5tpbv4CzjUc/iUzsg1LM0
 0b0hSAyR/a/N9FDfhjSTc1XN9FKIwaVmXoFW5x7RzDvQsLEQPK7EN19uQ
 UO8tngVwxjrGZ0FfnD9OPB4VY6U99TO5IonjOI+mRu1gDi0DVI1gJGkdO
 7y3fi9E6hkdKJL+tmL9+PE9YYemcgSMW+EoFkzGZYT8AUjnLTCfbH0KAz
 2dQcMbCQWCpcuF4UkqhfNQkFw8Eu0oYy4Q9x2VHLl7+YwuR2ojW7n4b0a Q==;
X-CSE-ConnectionGUID: VEC3keYZQ+6USm0rr4q2mA==
X-CSE-MsgGUID: p5YOOyRIRCaIjqxNdwB2hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11824"; a="93219298"
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; d="scan'208";a="93219298"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2026 04:18:42 -0700
X-CSE-ConnectionGUID: 45Gz673wTlC9QH60LhICfg==
X-CSE-MsgGUID: P0RjXlStRryX6KTyuEpgEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; d="scan'208";a="246883933"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.224.226])
 by fmviesa008.fm.intel.com with ESMTP; 22 Jun 2026 04:18:41 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Akhil Goyal <gakhil@marvell.com>, Anoob Joseph <anoobj@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Fan Zhang <fanzhang.oss@gmail.com>
Subject: [PATCH 1/3] test/security_inline_proto: remove fast-free Tx flag
Date: Mon, 22 Jun 2026 12:18:32 +0100
Message-ID: <20260622111835.233554-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260622111835.233554-1-bruce.richardson@intel.com>
References: <20260622111835.233554-1-bruce.richardson@intel.com>
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

The FAST_FREE Tx offload flag is an optimization that may not be
supported by all drivers, but the test unconditionally sets this as part
of the Tx config. Since it's an optimization that should not affect test
correctness, and since this is a unit test, not perf test, just remove
the flag.

Fixes: 86e2487c5f2c ("test/security: add cases for inline IPsec offload")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/test_security_inline_proto.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/app/test/test_security_inline_proto.c b/app/test/test_security_inline_proto.c
index b0cce5ebd9..bc3ef54f71 100644
--- a/app/test/test_security_inline_proto.c
+++ b/app/test/test_security_inline_proto.c
@@ -94,8 +94,7 @@ static struct rte_eth_conf port_conf = {
 	},
 	.txmode = {
 		.mq_mode = RTE_ETH_MQ_TX_NONE,
-		.offloads = RTE_ETH_TX_OFFLOAD_SECURITY |
-			    RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE,
+		.offloads = RTE_ETH_TX_OFFLOAD_SECURITY,
 	},
 	.lpbk_mode = 1,  /* enable loopback */
 };
-- 
2.53.0

