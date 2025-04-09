Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47667C369A2
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Apr 2025 01:21:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B01294064A;
	Wed,  9 Apr 2025 03:21:09 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id F22E8402D8
 for <dev@dpdk.org>; Wed,  9 Apr 2025 03:21:04 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 295352113E9B; Tue,  8 Apr 2025 18:21:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 295352113E9B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1744161664;
 bh=zvGG2SX/EehPpUdiBgs1fqfXcYPO+KbGlVdEzBfWjpU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TjeHdK2PA3kqmm+R/G/jDHhM5/3RwXkm9q0GD4png8R+aDwpZvfrZ/orLE4UIaykp
 T8zwJ556WGcDnUPJ0Hm1Mm3XuyDOOLTAFoQyUWNMwrzbdMgWCiG9HVeGmrSkez7IPB
 ZVOBkudj2WMSsakbKok3ulvJPniVTg50+LbXuC/w=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: bruce.richardson@intel.com, dev@dpdk.org, sameh.gobriel@intel.com,
 vladimir.medvedkin@intel.com, yipeng1.wang@intel.com
Subject: [PATCH v5 3/3] hash_readwrite_autotest: fix printf parameters
Date: Tue,  8 Apr 2025 18:20:58 -0700
Message-Id: <1744161658-7874-4-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1744161658-7874-1-git-send-email-andremue@linux.microsoft.com>
References: <1741291408-26509-1-git-send-email-andremue@linux.microsoft.com>
 <1744161658-7874-1-git-send-email-andremue@linux.microsoft.com>
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

Compiling with MSVC logs the warnings below, which result in
build error:

../app/test/test_hash_readwrite.c(73): warning C4476: 'printf' :
    unknown type field character ''' in format specifier
../app/test/test_hash_readwrite.c(75): warning C4474: 'printf' :
    too many arguments passed for format string
../app/test/test_hash_readwrite.c(75): note: placeholders and
    their parameters expect 2 variadic arguments, but 4 were provided

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 app/test/test_hash_readwrite.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/app/test/test_hash_readwrite.c b/app/test/test_hash_readwrite.c
index 1867376ade..82fe03cc5a 100644
--- a/app/test/test_hash_readwrite.c
+++ b/app/test/test_hash_readwrite.c
@@ -25,6 +25,8 @@
 #define NUM_TEST 3
 unsigned int core_cnt[NUM_TEST] = {2, 4, 8};
 
+#define OFFSET_STR_LEN 16
+
 unsigned int worker_core_ids[RTE_MAX_LCORE];
 struct perf {
 	uint32_t single_read;
@@ -57,10 +59,14 @@ static RTE_ATOMIC(uint64_t) gwrites;
 static int
 test_hash_readwrite_worker(__rte_unused void *arg)
 {
+	char offset_start[OFFSET_STR_LEN];
+	char offset_end[OFFSET_STR_LEN];
 	uint64_t i, offset;
 	uint32_t lcore_id = rte_lcore_id();
 	uint64_t begin, cycles;
 	int *ret;
+	const bool use_iec = true;
+	const char *unit = NULL;
 
 	ret = rte_malloc(NULL, sizeof(int) *
 				tbl_rw_test_param.num_insert, 0);
@@ -70,9 +76,13 @@ test_hash_readwrite_worker(__rte_unused void *arg)
 	}
 	offset = tbl_rw_test_param.num_insert * i;
 
-	printf("Core #%d inserting and reading %d: %'"PRId64" - %'"PRId64"\n",
+	rte_size_to_str(offset_start, RTE_DIM(offset_start), offset, use_iec, unit);
+	rte_size_to_str(offset_end, RTE_DIM(offset_end),
+			offset + tbl_rw_test_param.num_insert - 1, use_iec, unit);
+
+	printf("Core #%u inserting and reading %u: %s - %s\n",
 	       lcore_id, tbl_rw_test_param.num_insert,
-	       offset, offset + tbl_rw_test_param.num_insert - 1);
+	       offset_start, offset_end);
 
 	begin = rte_rdtsc_precise();
 
-- 
2.49.0.vfs.0.0

