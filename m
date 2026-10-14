Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5B4C3DA7A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 18:39:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3318840A6F;
	Wed, 14 Oct 2026 20:39:31 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id BCC0940687;
 Wed, 14 Oct 2026 20:39:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792003170; x=1823539170;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CXSS4BGtJDo8e3pWbbr2+bqz0DYtkpm4CbGRG84m9vg=;
 b=SO31MUg+E/4cdSnb3IdcIWJ+hSZynJ6pIFiaZ7YXpEZ5z63MDl6HK/nr
 zOpKKvPPLGAT7jSqkFkZS/VVRofyrGcAwPgMUljsK7cJ03XxhEmrlXV6V
 E7dG5wTXgg5B3N2uycVT324nyhV7RPUJNmZF1NbpLjpGr+rUM2nU53umn
 XmcRLLaJRz+jB6UIu5NwbV2D5PBRqfhiOcRwSOpN1R2gBEGoQ4XIpVtKA
 Nw0fqaXsFuusrzcazPRRdMhMkYCP8yM/ws/82KAwfqF8l5xYE6FQv3tur
 UJUmEYNlcMSL+N4SaLWcrY5P7nhfNpLl1/LhUKYgkRzY50ADA11mTBczw w==;
X-CSE-ConnectionGUID: uGzma2vDQ4q43Ujx9a9YzQ==
X-CSE-MsgGUID: /vFnRtg0Td+AGQjzcoDyjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="753358"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="753358"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 11:39:29 -0700
X-CSE-ConnectionGUID: v3AOU1q7S0CjKNDV6LT1ug==
X-CSE-MsgGUID: tCt5Unh8S2WPOJuUb2vsug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1419862"
Received: from silpixa00401176.ir.intel.com ([10.20.224.212])
 by orviesa009.jf.intel.com with ESMTP; 14 Oct 2026 11:39:28 -0700
From: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
To: dev@dpdk.org
Cc: rjarry@redhat.com, mb@smartsharesystems.com, maxime@leroys.fr,
 konstantin.ananyev@huawei.com, stable@dpdk.org
Subject: [RFC PATCH v2 3/7] app/test-fib: fix size of the tables for large
 counts
Date: Wed, 14 Oct 2026 18:39:17 +0000
Message-ID: <20261014183921.495158-4-vladimir.medvedkin@intel.com>
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

The sizes of the routes and lookup tables are computed in 32 bits, so
more than 268M IPv6 addresses for lookup overflow the size passed to
rte_malloc() and the tables are written past their end.

Widen the multiplications to size_t.

Fixes: 103809d032cd ("app/test-fib: add test application for FIB")
Cc: stable@dpdk.org

Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 app/test-fib/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/app/test-fib/main.c b/app/test-fib/main.c
index d85d94fdd1..0bc8dd2aa4 100644
--- a/app/test-fib/main.c
+++ b/app/test-fib/main.c
@@ -1260,12 +1260,12 @@ main(int argc, char **argv)
 			BURST_SZ);
 
 	/* Alloc routes table*/
-	config.rt  = rte_malloc(NULL, rt_ent_sz * config.nb_routes, 0);
+	config.rt  = rte_malloc(NULL, (size_t)rt_ent_sz * config.nb_routes, 0);
 	if (config.rt == NULL)
 		rte_exit(-ENOMEM, "Can not alloc rt\n");
 
 	/* Alloc table with ip's for lookup*/
-	config.lookup_tbl  = rte_malloc(NULL, lookup_ent_sz *
+	config.lookup_tbl  = rte_malloc(NULL, (size_t)lookup_ent_sz *
 		config.nb_lookup_ips, 0);
 	if (config.lookup_tbl == NULL)
 		rte_exit(-ENOMEM, "Can not alloc lookup table\n");
-- 
2.43.0

