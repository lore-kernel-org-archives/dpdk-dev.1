Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294DCC36010
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Apr 2025 01:21:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A8B4A402EA;
	Wed,  9 Apr 2025 03:21:07 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id C77B9402C5
 for <dev@dpdk.org>; Wed,  9 Apr 2025 03:21:04 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 1CCD92113E9A; Tue,  8 Apr 2025 18:21:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1CCD92113E9A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1744161664;
 bh=Oq6TZLKdefoxaYTih9b5mea4WyguLXInyHbA7dcv8Tc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TJ7oWLz6MCvjrl7GGKhEgzFnKm2R9xdlrTFAVQ0jt31YMmAXl4StnjSORT0KkOr11
 HEERZFDmordsc505qxLUGr1d/CpMmV1kOp77y4UgrVJFyNK/FcRhFIlcsw8hBREXN2
 9eMUlhhRex3JqDrnbRY35R1Fl/ZM/z3CHQeJp39g=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: bruce.richardson@intel.com, dev@dpdk.org, sameh.gobriel@intel.com,
 vladimir.medvedkin@intel.com, yipeng1.wang@intel.com
Subject: [PATCH v5 2/3] hash_multiwriter_autotest: fix printf parameters
Date: Tue,  8 Apr 2025 18:20:57 -0700
Message-Id: <1744161658-7874-3-git-send-email-andremue@linux.microsoft.com>
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

../app/test/test_hash_multiwriter.c(71): warning C4476: 'printf' :
    unknown type field character ''' in format specifier
../app/test/test_hash_multiwriter.c(73): warning C4474: 'printf' :
    too many arguments passed for format string
../app/test/test_hash_multiwriter.c(73): note: placeholders and their
    parameters expect 2 variadic arguments, but 4 were provided

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 app/test/test_hash_multiwriter.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/app/test/test_hash_multiwriter.c b/app/test/test_hash_multiwriter.c
index 33d3147bd8..0af3eb2c33 100644
--- a/app/test/test_hash_multiwriter.c
+++ b/app/test/test_hash_multiwriter.c
@@ -32,6 +32,8 @@
 
 #define RTE_APP_TEST_HASH_MULTIWRITER_FAILED 0
 
+#define OFFSET_STR_LEN 16
+
 struct {
 	uint32_t *keys;
 	uint32_t *found;
@@ -51,11 +53,15 @@ static int use_htm;
 static int
 test_hash_multiwriter_worker(void *arg)
 {
+	char offset_start[OFFSET_STR_LEN];
+	char offset_end[OFFSET_STR_LEN];
 	uint64_t i, offset;
 	uint16_t pos_core;
 	uint32_t lcore_id = rte_lcore_id();
 	uint64_t begin, cycles;
 	uint16_t *enabled_core_ids = (uint16_t *)arg;
+	const bool use_iec = true;
+	const char *unit = NULL;
 
 	for (pos_core = 0; pos_core < rte_lcore_count(); pos_core++) {
 		if (enabled_core_ids[pos_core] == lcore_id)
@@ -68,10 +74,12 @@ test_hash_multiwriter_worker(void *arg)
 	 */
 	offset = pos_core * tbl_multiwriter_test_params.nb_tsx_insertion;
 
-	printf("Core #%d inserting %d: %'"PRId64" - %'"PRId64"\n",
+	rte_size_to_str(offset_start, RTE_DIM(offset_start), offset, use_iec, unit);
+	rte_size_to_str(offset_end, RTE_DIM(offset_end),
+			offset + tbl_multiwriter_test_params.nb_tsx_insertion - 1, use_iec, unit);
+	printf("Core #%u inserting %u: %s - %s\n",
 	       lcore_id, tbl_multiwriter_test_params.nb_tsx_insertion,
-	       offset,
-	       offset + tbl_multiwriter_test_params.nb_tsx_insertion - 1);
+	       offset_start, offset_end);
 
 	begin = rte_rdtsc_precise();
 
-- 
2.49.0.vfs.0.0

