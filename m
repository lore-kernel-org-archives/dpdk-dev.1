Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBF2F47CA4
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Mar 2026 17:54:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8703642799;
	Thu,  5 Mar 2026 18:53:39 +0100 (CET)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com
 [209.85.219.49]) by mails.dpdk.org (Postfix) with ESMTP id D91DA4161A
 for <dev@dpdk.org>; Thu,  5 Mar 2026 18:53:36 +0100 (CET)
Received: by mail-qv1-f49.google.com with SMTP id
 6a1803df08f44-89a018cbbf8so53787646d6.0
 for <dev@dpdk.org>; Thu, 05 Mar 2026 09:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772733216;
 x=1773338016; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Atpkl4TkxDMFQA6crCiBRVUUNoVBkPUFlCvPi9/50YQ=;
 b=IsvZjG68JuXK/VJtq6k5foeSn6vm7RaF+UdPi1+524HZeF+C5Ogd0NvP/Z76LTEZg2
 t9yuQa9meyUaLYVVXyWd6t/e1NB42ua9NVDwCoduvD7flvn5whAfCenMq0b5EdwNndJY
 qA9LSNsHxpqgVtS6ptfrSOhug9MkPKfHCduzD9TIof1l9/aPy1GZbUvNfFfGgUfeENfQ
 CUQz8qbg+YS9uKFIMpMwaCSOOUT4YiSNSFi/Mn7psIOGHFG0SNWoVRrI21OWvEPV48vt
 1StXicI74Nbbzl7iwoKqyLw9mHVxQ6ze1V5Xy9gVtAjzUdOFOCJXml5fRie3Ld7pxD7x
 4nJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772733216; x=1773338016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Atpkl4TkxDMFQA6crCiBRVUUNoVBkPUFlCvPi9/50YQ=;
 b=aWf1fPMWSUIHWjGnHCAwlVp+MlMB4V/vBjY9ZzOj9L3axAVqKeh5ftI15mAQGEUzA5
 tJsNbZQfVDJC/e8HQP1KgbDXsTnJvxGmYt+nclqlYnDdwDyjFZZilEz0h1ULkRrs8Q0Y
 pnoIoebxAhq9ns+N4RP582wigo4bS+IKKlaiwy/ntmTzvTBo7dTOHlJ+QZPbzieEISKb
 c8Faarhp11SNYj5e1Yqh1twsMa3Err4D+VGYgConpbr8RuzNDcSJby3l0Tnwlgq8fHk9
 NaD/axvGfgPzZ3FULP7UhGFGT35hXEjdK0BVrncUedD9tHe8zSuSZKHrLbDdpw5lODUk
 JQew==
X-Gm-Message-State: AOJu0Yw4txvh1Ob4Ri8vXZpsmXCmNq8K6i7ln96HgjzAclR2eq0i8Uv9
 +IO3FQLJ03qFU+fSRAAf7lehoTnkReYN1KaD2ct/7EE5UZtTbktznCwJXGjCj/IhdNOim/JNOc3
 1Ys5W
X-Gm-Gg: ATEYQzzaXtGHKq0DC1E3eCrIOQH4RVFtlS2gm/C1W0cOLxru6dQrysi1tcAF/4y0NAT
 RYYjk+Xaim06ll6QWZeM2Bb/JOGR/CT2BPcNN1fyI643QCC8T7/FVrnQ6W8VCm1PQyXevWDIRli
 wXpicWNl0NOkFXcQYzPLzyIxiVMlZvcq7E0u/kfD+EfzqEoFvN4OxVj2Wn865JSm/jBgB9/NzsE
 8gFwcTNAeHWAwZ9iSuBpBJMA6HXVbFpsuYIV2DEr6RSG2LDU/iM/ZR5h7TMdHFu5LJQAvuk9g8L
 /geEQ6sydG8RzXwfGWWmRprvLu3vgv50FzPB2ArW27+X0qSRNUbditl1U9xGp84+3v77u/rMCd+
 W/J1PuA+3JSiMCEB+uN5W3BUc/mwu1Lcm8RwytRIAdSvUhiCAecduY7mJBLhXElgCkSI7ebLd7z
 5yRrLr224v2ekFkFRlJEOhdgyfzV0i7AI7cxrkDKRlTdAmvdCUWI7xTjaNjep6sw==
X-Received: by 2002:ad4:5c4a:0:b0:899:ea4f:12f2 with SMTP id
 6a1803df08f44-89a2459cff4mr49293436d6.4.1772733216123; 
 Thu, 05 Mar 2026 09:53:36 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a05b72186sm80667766d6.50.2026.03.05.09.53.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 09:53:35 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v4 05/11] test/timer: scale test based on number of cores
Date: Thu,  5 Mar 2026 09:50:59 -0800
Message-ID: <20260305175326.279891-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260305175326.279891-1-stephen@networkplumber.org>
References: <20260118201223.323024-1-stephen@networkplumber.org>
 <20260305175326.279891-1-stephen@networkplumber.org>
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

With large core system this would end up taking too long and
test would time out. Scale the number of timers based on
the number lcores available.

Add a check that mempool_get succeeds.

Fixes: 50247fe03fe0 ("test/timer: exercise new APIs in secondary process")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_timer_secondary.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/app/test/test_timer_secondary.c b/app/test/test_timer_secondary.c
index 0fc07dcbad..c80dee9c6c 100644
--- a/app/test/test_timer_secondary.c
+++ b/app/test/test_timer_secondary.c
@@ -27,7 +27,8 @@ test_timer_secondary(void)
 
 #include "process.h"
 
-#define NUM_TIMERS		(1 << 20) /* ~1M timers */
+#define NUM_TIMERS_MAX		(1 << 20) /* ~1M timers */
+#define NUM_TIMERS_MIN		(1 << 14) /* 16K minimum */
 #define NUM_LCORES_NEEDED	3
 #define TEST_INFO_MZ_NAME	"test_timer_info_mz"
 #define MSECPERSEC		1E3
@@ -38,11 +39,12 @@ struct test_info {
 	unsigned int main_lcore;
 	unsigned int mgr_lcore;
 	unsigned int sec_lcore;
+	unsigned int num_timers;
 	uint32_t timer_data_id;
 	volatile int expected_count;
 	volatile int expired_count;
 	struct rte_mempool *tim_mempool;
-	struct rte_timer *expired_timers[NUM_TIMERS];
+	struct rte_timer *expired_timers[NUM_TIMERS_MAX];
 	int expired_timers_idx;
 	volatile int exit_flag;
 };
@@ -134,8 +136,10 @@ test_timer_secondary(void)
 				     "test data");
 		test_info = mz->addr;
 
+		test_info->num_timers = test_scale_iterations(NUM_TIMERS_MAX, NUM_TIMERS_MIN);
+
 		test_info->tim_mempool = rte_mempool_create("test_timer_mp",
-				NUM_TIMERS, sizeof(struct rte_timer), 0, 0,
+				test_info->num_timers, sizeof(struct rte_timer), 0, 0,
 				NULL, NULL, NULL, NULL, rte_socket_id(), 0);
 
 		ret = rte_timer_data_alloc(&test_info->timer_data_id);
@@ -174,15 +178,16 @@ test_timer_secondary(void)
 	} else if (proc_type == RTE_PROC_SECONDARY) {
 		uint64_t ticks, timeout_ms;
 		struct rte_timer *tim;
-		int i;
+		unsigned int i;
 
 		mz = rte_memzone_lookup(TEST_INFO_MZ_NAME);
 		TEST_ASSERT_NOT_NULL(mz, "Couldn't lookup memzone for "
 				     "test info");
 		test_info = mz->addr;
 
-		for (i = 0; i < NUM_TIMERS; i++) {
-			rte_mempool_get(test_info->tim_mempool, (void **)&tim);
+		for (i = 0; i < test_info->num_timers; i++) {
+			ret = rte_mempool_get(test_info->tim_mempool, (void **)&tim);
+			TEST_ASSERT_SUCCESS(ret, "Couldn't get timer from mempool");
 
 			rte_timer_init(tim);
 
-- 
2.51.0

