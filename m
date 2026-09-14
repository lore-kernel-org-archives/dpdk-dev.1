Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1217BC88E50
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 05:50:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5706440A7D;
	Mon, 14 Sep 2026 07:49:39 +0200 (CEST)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id CE67E40A70
 for <dev@dpdk.org>; Mon, 14 Sep 2026 07:49:37 +0200 (CEST)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2cfbbdfa60bso29915955ad.3
 for <dev@dpdk.org>; Sun, 13 Sep 2026 22:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789364977;
 x=1789969777; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2m/hqeh1sZBK8cMf0fJSMKGgjxAtZKr6n5MxOD2Fq68=;
 b=DVI9fd3nceFzboGHbqcEFbFborc9kJ4qWjm8qmf/CHuFW0DPNQvKzz93uPOlGjODhC
 KxZPTI5VIm8+ATLD0jMAjbvBl1DUrYQWs4GCm36+LIBQPTLbJIDC70LciQGDOqLQ0K2U
 5mK+KEBeY0fnKwhR2YSILJ0Ujrs+whHqG0qoqN88Dk6w3pwH9eX0CAPF7r+/yxlTqV08
 I1U1dRGDJ/S33tPf/Ak8LzihPPgty4poTYLpbtSlKPce7ofq4gldnPezoJzLajkZ34rz
 b+Pub0pb909b4sh3aZgpdM0+7txqKdtsgjl2tnWsMDHmphXqomlzN97kL2hgopVSfLgX
 thCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789364977; x=1789969777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2m/hqeh1sZBK8cMf0fJSMKGgjxAtZKr6n5MxOD2Fq68=;
 b=gDdNzwSZOmWcBXXiCQlADf33NgJrx9yJdvlalN9hajEg6JhvwKIm//u17ytSXWO53E
 r1SFe7ExCJ/lk1wCdgKpRIKdEWsTBKQR+1v9JgDDN5H+u1PMWT5tNvUIy6pnHkK3qxlf
 D2QpkEsHOWDtkCYAOU0qYmrw3B3kEudg6aCZwpQjmTXNIAwvcEZmz7ovYwnEMEpisdLy
 wYRdfPX/Gv0DOO2LDyS82KFzYYGNDMiK01A9tRGAl6hYxfXeekUTEgULaq0WdBM/2HkW
 liyj0CbLl1Q6sYTJefqA4HwPhl/zh9tGFgkk41c9JRBOjGgHk/ZjwLqcXMljM8BJuOAb
 9oVA==
X-Gm-Message-State: AFuF++l6vkoRslaWItp7El0eUdeGfcQejJpMZmw7O8voAy+wASNlI5iD
 eGOg4E2C9TSZiOAR8o0p8Cb6j8RDv/TdGk2kT8SdyCh7QSVKsSZiHXVu4od4LOGn+ZQsNJPs1VX
 2bfvz
X-Gm-Gg: AYBFou1qOvfgMpZV9b7Lf4rxLga+2ptntvElYFW19N1Vv5DWLP5ifMcgiXSLvlZ7Ds+
 7/wMEKOEMpgNBqnRnsubaRDpfxgAXybc7Id1foYVUijWkpCizK7Y+c0WNU2Wtdtd0lhhrZRGC5i
 Q8AdEr2GqZJwydidXNmqewppwHBjZsL4h5I9NH1nckAmObp8njF8Wgx5Xa7lyLHBTxEI9IGNUXM
 crJyJa+Xl8OGeWeTlb7Bbu1UmTU41iBmbRZEBvSwYjckyFTTS0kD/imt1luw05h+6XEb+6bUz/6
 A+JGx1X+qaQkJ+fMnf50WHe0KRdHEZVoBAC4r/3yMptmHtnMnd3xBv0MQKqaBPvbyxxDl7pQjex
 DgZoWDfTz8X42JRkdyebuAeFvyigd+av0KynsmD+2O+fwFzSMPOvXTei5fAOO9/mb81JjC5AL91
 oOZhs3GtzjlDGyJIbilcDskOyF9CChHeJljW11zU81U4YWbsThsPRxMJEPv/f/pQjfIbbOnq/7W
 2vRhiZDjWGHmc/VHkzltSRfAXS+XpObwvURvg==
X-Received: by 2002:a17:90b:2586:b0:398:e86b:ce14 with SMTP id
 98e67ed59e1d1-39dec0bedb2mr2751138a91.20.1789364976888; 
 Sun, 13 Sep 2026 22:49:36 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95864b4fsm19794492a91.15.2026.09.13.22.49.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 22:49:36 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 05/62] eal: validate memory size arguments
Date: Sun, 13 Sep 2026 22:46:36 -0700
Message-ID: <20260914054912.755403-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914054912.755403-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
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

