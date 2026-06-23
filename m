Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17B2CDB471
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 16:52:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 595DD4066E;
	Tue, 23 Jun 2026 18:52:04 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 0511740663;
 Tue, 23 Jun 2026 18:52:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782233523; x=1813769523;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mDYeNcC1YsLWgNVlck/wrwh1+znbkaBg4IhxPHriRDU=;
 b=JtWzi/ZUOpcx0xo4iuJny/kmBNz5KF47oY8nKzNe7EnY3iUEKV3pbMsa
 xhQNB7n2xk1gT1eQOFsLIIntvOUGhSEcc4XZHYw9UIdawTF/+2GUe8JDG
 ufTCco6QFTo92epunoYIWT6lSBSQf/otRUOZ60ExKBzjAX6GJ/kRyUe0d
 4o33pliaTw+H70BriNsOAFOw0oZHQrp98WOhsk4w1JcF86u8I/ZNKv5uq
 62XSMPH74sNN7Oey2wLK6lH/yxNCYD8QHGBB7MJHbUBd5GLa/1S60utdF
 rHzY+E71goA4ZlV9a23GEiX1WMC5qUt5gb5dbOznO1jhJxdwYTWZ5q5do Q==;
X-CSE-ConnectionGUID: LnrM+8fTQIKHBy+FQGZzQg==
X-CSE-MsgGUID: YY4J3hqlQN6Z2+XjsvOO4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="100534626"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; d="scan'208";a="100534626"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 09:52:02 -0700
X-CSE-ConnectionGUID: HXxQBMJpS4CSWKjMhdxeyg==
X-CSE-MsgGUID: k9NneOoMSNaHPle30TuyfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; d="scan'208";a="253928295"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.224.226])
 by orviesa004.jf.intel.com with ESMTP; 23 Jun 2026 09:52:00 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Michael Shamis <michaelsh@marvell.com>, Liron Himi <lironh@marvell.com>,
 Pablo de Lara <pablo.de.lara.guarch@intel.com>,
 Tomasz Duszynski <tduszynski@marvell.com>
Subject: [PATCH 03/17] crypto/mvsam: replace strncpy with strlcpy
Date: Tue, 23 Jun 2026 17:51:33 +0100
Message-ID: <20260623165150.765443-4-bruce.richardson@intel.com>
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

Fixes: 25b05a1c806b ("crypto/mvsam: parse max number of sessions")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/crypto/mvsam/rte_mrvl_pmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/mvsam/rte_mrvl_pmd.c b/drivers/crypto/mvsam/rte_mrvl_pmd.c
index a824719fb0..65a63c9d62 100644
--- a/drivers/crypto/mvsam/rte_mrvl_pmd.c
+++ b/drivers/crypto/mvsam/rte_mrvl_pmd.c
@@ -1146,7 +1146,7 @@ parse_name_arg(const char *key __rte_unused,
 		return -EINVAL;
 	}
 
-	strncpy(params->name, value, RTE_CRYPTODEV_NAME_MAX_LEN);
+	strlcpy(params->name, value, RTE_CRYPTODEV_NAME_MAX_LEN);
 
 	return 0;
 }
-- 
2.53.0

