Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC88CC6B1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 18:39:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B119406B8;
	Wed, 14 Oct 2026 20:39:30 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 2A0C340395;
 Wed, 14 Oct 2026 20:39:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792003168; x=1823539168;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WGU9gZJ/nXxkryKPFyonUQo47u/+aTdRzifnk+4N9UM=;
 b=htRN6VQPXYYNhyGE7ecUAZuaE+pC9OZFpRg5DtufVUjp2IDccKEF35Ia
 gl8aqLS7XCDRnQdQFTxFocQS+4YbkGGy5Yxu06+dv1WU/GZWZfnB+urp1
 yUVn6pUXY4dZuppjEEDNK7RFp54gwFMn6lTYklHj406cdJOqmpRBpiF+c
 PLR7eV0zhO0M1jYd6wTR0m4Wp/GdGVYZT35w9Os6h5tEvSwh5wiaJSkES
 UN9I8XQYXEwRCWu7Ll4wIEokbD7fw/602TQmKDuxa+tnnx+NiM3mo7qL7
 6SbYU4sVWVjDePwbFvbu8dVlVlzfXAIYn3lrdsIHssRslO0YsvT6Rd4ga A==;
X-CSE-ConnectionGUID: HVc60xB+Roef9pBfzpGqKA==
X-CSE-MsgGUID: bwApQSPPQ9O09mahW9mlOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="753353"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="753353"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 11:39:27 -0700
X-CSE-ConnectionGUID: fBIn9JukRV6xM0qh0TItqw==
X-CSE-MsgGUID: UnF+AgucR4qQLbxhxKPGbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1419853"
Received: from silpixa00401176.ir.intel.com ([10.20.224.212])
 by orviesa009.jf.intel.com with ESMTP; 14 Oct 2026 11:39:27 -0700
From: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
To: dev@dpdk.org
Cc: rjarry@redhat.com, mb@smartsharesystems.com, maxime@leroys.fr,
 konstantin.ananyev@huawei.com, stable@dpdk.org
Subject: [RFC PATCH v2 2/7] app/test-fib: fix lookup of the last burst
Date: Wed, 14 Oct 2026 18:39:16 +0000
Message-ID: <20261014183921.495158-3-vladimir.medvedkin@intel.com>
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

The lookup loops process the lookup table in bursts of 64 addresses and
always pass a full burst, reading and comparing past the end of the table
when the number of addresses is not a multiple of the burst size.

Round the number of addresses down to a multiple of the burst size once
they are counted, so that the timed loops keep passing full bursts, and
read only that many addresses from the lookup file.

Fixes: 103809d032cd ("app/test-fib: add test application for FIB")
Cc: stable@dpdk.org

Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 app/test-fib/main.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/app/test-fib/main.c b/app/test-fib/main.c
index dd1a6d7297..d85d94fdd1 100644
--- a/app/test-fib/main.c
+++ b/app/test-fib/main.c
@@ -523,19 +523,21 @@ parse_rt_6(FILE *f)
 static int
 parse_lookup(FILE *f, int af)
 {
-	int ret, i = 0;
+	int ret;
+	uint32_t i;
 	uint8_t *tbl = (uint8_t *)config.lookup_tbl;
 	int step = (af == AF_INET) ? 4 : 16;
 	char *s;
 
-	while (fgets(line, sizeof(line), f) != NULL) {
+	/* Only the addresses of the full bursts are read. */
+	for (i = 0; i < config.nb_lookup_ips &&
+			fgets(line, sizeof(line), f) != NULL; i++) {
 		s = strtok(line, " \t\n");
 		if (s == NULL)
 			return -EINVAL;
-		ret = inet_pton(af, s, &tbl[i]);
+		ret = inet_pton(af, s, &tbl[(size_t)i * step]);
 		if (ret != 1)
 			return -EINVAL;
-		i += step;
 	}
 	return 0;
 }
@@ -1251,6 +1253,12 @@ main(int argc, char **argv)
 		rewind(fl);
 	}
 
+	/* Lookups are done in full bursts, the leftovers are dropped. */
+	config.nb_lookup_ips = RTE_ALIGN_FLOOR(config.nb_lookup_ips, BURST_SZ);
+	if (config.nb_lookup_ips == 0)
+		rte_exit(-EINVAL, "At least %u ip's for lookup are needed\n",
+			BURST_SZ);
+
 	/* Alloc routes table*/
 	config.rt  = rte_malloc(NULL, rt_ent_sz * config.nb_routes, 0);
 	if (config.rt == NULL)
-- 
2.43.0

