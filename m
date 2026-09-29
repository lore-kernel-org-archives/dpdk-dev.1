Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D10BCA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 16:38:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D9DCE42DE3;
	Tue, 29 Sep 2026 18:38:17 +0200 (CEST)
Received: from mail-pz2-f38.google.com (mail-pz2-f38.google.com
 [74.125.228.38]) by mails.dpdk.org (Postfix) with ESMTP id DF42042670
 for <dev@dpdk.org>; Tue, 29 Sep 2026 18:38:12 +0200 (CEST)
Received: by mail-pz2-f38.google.com with SMTP id
 d2e1a72fcca58-88379342f7fso1533874b3a.1
 for <dev@dpdk.org>; Tue, 29 Sep 2026 09:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790699892;
 x=1791304692; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2m/hqeh1sZBK8cMf0fJSMKGgjxAtZKr6n5MxOD2Fq68=;
 b=foyrSuvzj9MwtLk7egeumE4IBHvkMkf25xKjweAR4ctsmN6ztypYP/PG522yUfqwkt
 FvUdxZSXpa9v0xJTGOyaUBrq43u6aZb4vy3XLd715mXFfmUrf612Xx3xSQEBYsIlrmAW
 fBUKWRVCTA9aCiijyXvaOTdcEjgqu/wpVMr6jLOE2EMaD5lMIInePKuSaCegYFvl27Cu
 Y+lwuJrL+MownCelvYPPnj7pjodS+nPvYR67yBAK0Qc/53qqu9n6kHkrLyEHXfj1Yvoc
 btBjKhaOaA+eVrhPOk7WS+e4A8vyaTziGyxPH3LnNMhk9cbfXQeKHDCoDgIOrdaUG248
 nTCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790699892; x=1791304692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2m/hqeh1sZBK8cMf0fJSMKGgjxAtZKr6n5MxOD2Fq68=;
 b=hQLwjfIL7ARWzv29BH1YD01GhJn4QNMd21/c7rqyDT8empCT6ATfF191X1L46Je7CN
 VuCelN97sbIwQJvX+acNhGptUeJa1aXtxZxNoFEi8/Bq5I2o4zkaM/P+uaaHfoj4XvFr
 MAwh0LoO3dOmN276Q6d7KyAK39rJT98C77GUaWdna2E2vqNsj9ZqHm8us6rO+RfUc6ym
 JoBtSWlTSy/qpdLMW9I0DC6fFfeKTGVhbBaX0LvYykBkV+4JPhCOnkVAZTFquoMlBiRi
 AFJcCOfU31wFKOYVwPOMMrBECWWXFxYjLK50pzJurh9PoOpMYp9la6Mg6fKiv7rD/7SK
 Q7OQ==
X-Gm-Message-State: AFuF++ntSSsnVtsqYuld/WDY99sPvPe9rdPuqJ7JN0mugM42ZJuNJ5DA
 oi0WEC6ytraO1u4ECTwyOwwUzvdz/D36wDhoakO9nOqKuqIfUdI6bg6QvZW2WfhG/Iu5JzhNChp
 RiMZ4MBc=
X-Gm-Gg: AYBFou01MaL3sK71KHSignq3arPJz8WK0NC8KKfl/06eKxDnH70wi7XwYGqlC4kKGCu
 BXB+cZjSdK/YMCtXP4SRL+8Ja+TdRHuV64erlD2EThlkWsAdVQYMarlzk6v3u2GHjbys9RJYSKg
 AhK1x1SwZXvSOZIFIS+UOkvfYwzqsWOUZ88NhzPn4I7o05qHW2v2CZwMyVuUf9Mr/rDXocNTo2B
 wKBt+Cp6YE87WkiR5X7lVN50sLxpHNBEljtpObcLTqvLQCF/O4LkDHKKPm9mBT0cN5iG9w/kUYw
 7sVsG31smIATf/cQFRsICIHByMm0iNY8nTD6qv/aIy+lNkg0KIrLJx/XT6XqzNISfX9/16bRxOp
 AXozNYfRN4KDHHI97b24lAFJQjc3E47LZs1nBQN31sQ4rO0vKSSAA0mHwik0xlm04sjoC3T186R
 KMdHbwKsfoqNsJX2MgERQSdbB4o1N+LeGO+oq1lRptMVJSB86F4NXvtGmNRNCuRDVRq57e7pVuI
 p6HGI6yiLllOTYO9vOkuqDNsC2dsAAsHFJMxw==
X-Received: by 2002:a05:6a00:124f:b0:881:be70:448e with SMTP id
 d2e1a72fcca58-881be704553mr7702491b3a.53.1790699891883; 
 Tue, 29 Sep 2026 09:38:11 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8868ba02d02sm232392b3a.21.2026.09.29.09.38.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:38:11 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 04/61] eal: validate memory size arguments
Date: Tue, 29 Sep 2026 09:36:07 -0700
Message-ID: <20260929163800.1108305-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929163800.1108305-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260929163800.1108305-1-stephen@networkplumber.org>
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

The -m, -n and -r options are converted with atoi(), which does not
detect any error: it returns zero for a string that is not a number at
all, and its behaviour on overflow is undefined.

So "-m foo" is silently taken as zero rather than rejected, and
"-m 99999999999999999999" is undefined. The -n and -r cases are partly
covered by their existing checks for zero, but only because a garbage
value happens to convert to zero; "-n 4x" is accepted as four.

The -m value is also scaled by 1024 * 1024 with no check, so a large
enough value wraps around and asks for a small amount of memory.

Use rte_kvargs_to_uint() for the three options, which converts the
whole string and checks it against a range. EAL already depends on
kvargs, so no new dependency is introduced. Note that this now bounds
-m so that the scaled value cannot overflow size_t, which on a 32-bit
build limits it to just under 4G; previously such a value was accepted
and wrapped.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/common/eal_common_options.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index 42cdef632f..519307bdc3 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -9,6 +9,7 @@
 #include <ctype.h>
 #include <limits.h>
 #include <errno.h>
+#include <stdint.h>
 #include <getopt.h>
 #include <sys/queue.h>
 #ifndef RTE_EXEC_ENV_WINDOWS
@@ -29,6 +30,7 @@
 #include <rte_tailq.h>
 #include <rte_version.h>
 #include <rte_devargs.h>
+#include <rte_kvargs.h>
 #include <rte_memcpy.h>
 #ifndef RTE_EXEC_ENV_WINDOWS
 #include <rte_telemetry.h>
@@ -2210,23 +2212,34 @@ eal_parse_args(void)
 
 	/* memory options */
 	if (args.memory_size != NULL) {
-		int_cfg->memory = atoi(args.memory_size);
-		int_cfg->memory *= 1024ULL;
-		int_cfg->memory *= 1024ULL;
+		uint64_t mem;
+
+		/* value is in megabytes, and must not overflow when scaled */
+		if (rte_kvargs_to_uint(args.memory_size, 0,
+				       SIZE_MAX / (1024 * 1024), &mem) < 0) {
+			EAL_LOG(ERR, "invalid memory size parameter");
+			return -1;
+		}
+		int_cfg->memory = (size_t)mem * 1024 * 1024;
 	}
 	if (args.memory_channels != NULL) {
-		int_cfg->force_nchannel = atoi(args.memory_channels);
-		if (int_cfg->force_nchannel == 0) {
+		uint64_t channels;
+
+		if (rte_kvargs_to_uint(args.memory_channels, 1, UINT_MAX,
+				       &channels) < 0) {
 			EAL_LOG(ERR, "invalid memory channel parameter");
 			return -1;
 		}
+		int_cfg->force_nchannel = channels;
 	}
 	if (args.memory_ranks != NULL) {
-		int_cfg->force_nrank = atoi(args.memory_ranks);
-		if (int_cfg->force_nrank == 0 || int_cfg->force_nrank > 16) {
+		uint64_t ranks;
+
+		if (rte_kvargs_to_uint(args.memory_ranks, 1, 16, &ranks) < 0) {
 			EAL_LOG(ERR, "invalid memory rank parameter");
 			return -1;
 		}
+		int_cfg->force_nrank = ranks;
 	}
 	if (args.no_huge) {
 		int_cfg->no_hugetlbfs = 1;
-- 
2.53.0

