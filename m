Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC62CC6B1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 18:39:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A97CE4060F;
	Wed, 14 Oct 2026 20:39:28 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id AD6394025A;
 Wed, 14 Oct 2026 20:39:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792003167; x=1823539167;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=MF1G/4kYKW4n+OX/DnIU6azE2GesgMRJxzGHNmxCVMk=;
 b=nC/2uNFh6MiywM1NS9pdp8OfeGoTRaK2GJkTvkrqxgPR81OMgffJOk2a
 VW9h5A9XbPluh7qOpDlBBZ91MrRJ5zuWZcPb2pGALLvnXsiBSGu3c3Nsj
 kqqtZyS7yeNlVtuf4bDd/eFBljy3oxAnIQjIEakcm8ImkIYjE5+Eh7VUe
 C0PiApJYxTKS69pC/6CvhhlMUcrXyIh6T3KxRfI7tjrcjGc/rG4js4XGY
 qACf04l45Wes7C1oZxRHj1Kg+3374Z6PIuPeu25Q/8ZOkGBa5sUJWybok
 zuA1r5MjFl1GzbhXIqvaTh8GjPEvamkcuU5nAo0N6xcyc8m/K0lO7/M/W A==;
X-CSE-ConnectionGUID: hX2XjJwqQrCGhlCl3YUSEA==
X-CSE-MsgGUID: 8diNkyBaQSSOkwzWfjietw==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="753346"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="753346"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 11:39:26 -0700
X-CSE-ConnectionGUID: 07iHtiy3Rzana4ICUD3P7Q==
X-CSE-MsgGUID: 02MTxrpHS2GCFKa6mHImCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1419847"
Received: from silpixa00401176.ir.intel.com ([10.20.224.212])
 by orviesa009.jf.intel.com with ESMTP; 14 Oct 2026 11:39:25 -0700
From: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
To: dev@dpdk.org
Cc: rjarry@redhat.com, mb@smartsharesystems.com, maxime@leroys.fr,
 konstantin.ananyev@huawei.com, stable@dpdk.org
Subject: [RFC PATCH v2 1/7] fib: fix return value of a nexthop update
Date: Wed, 14 Oct 2026 18:39:15 +0000
Message-ID: <20261014183921.495158-2-vladimir.medvedkin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014183921.495158-1-vladimir.medvedkin@intel.com>
References: <20260322154215.3686528-1-vladimir.medvedkin@intel.com>
 <20261014183921.495158-1-vladimir.medvedkin@intel.com>
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

When the nexthop of an existing route is changed, the error returned by
the dataplane update was discarded and success was reported even if the
DIR24_8 table could not be updated.

Return the actual status, as the IPv6 TRIE algorithm does.

Fixes: 7dc7868b200d ("fib: add DIR24-8 dataplane algorithm")
Cc: stable@dpdk.org

Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 lib/fib/dir24_8.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/fib/dir24_8.c b/lib/fib/dir24_8.c
index 489d2ef427..bb7975eca1 100644
--- a/lib/fib/dir24_8.c
+++ b/lib/fib/dir24_8.c
@@ -498,7 +498,7 @@ dir24_8_modify(struct rte_fib *fib, uint32_t ip, uint8_t depth,
 			ret = modify_fib(dp, rib, ip, depth, next_hop);
 			if (ret == 0)
 				rte_rib_set_nh(node, next_hop);
-			return 0;
+			return ret;
 		}
 		if (depth > 24) {
 			tmp = rte_rib_get_nxt(rib, ip, 24, NULL,
-- 
2.43.0

