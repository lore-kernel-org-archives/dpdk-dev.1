Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2361C44536
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Jan 2026 00:54:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 77D0440B8D;
	Thu, 22 Jan 2026 01:54:17 +0100 (CET)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44]) by mails.dpdk.org (Postfix) with ESMTP id 3E605406BC
 for <dev@dpdk.org>; Thu, 22 Jan 2026 01:54:14 +0100 (CET)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-432da746749so199429f8f.0
 for <dev@dpdk.org>; Wed, 21 Jan 2026 16:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769043254;
 x=1769648054; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gxeO6eY4SSwfwzvMzaf9gpifeSYr0BajndrlIpCekuA=;
 b=YJbWfIyu2Znt7cGYzLJa7AYKcAm+8Kn+ceRFGYthY+0M47upM8PE4rTfpMWz0NXbD6
 rJ4yTmSSyoG8F6riTaiXEIzP62On5IbZ/e9tUEPOU4SYAqRWROdvtZcgQT4vG406X9Xi
 qysWwdP4QUbpH8WbrFTbadq2KUBSWr+KzzSHW4eZmVZpkeGaVtWDzScYEF6YmYUOZQbu
 LTlcN70KpHpWDdAfdNlHid/6u2fubyxF+cTsRjZWmjEHD97oIit2ICaPIQggaoY3s3Mg
 u85HwIgPkXgz5blWzekeUybTlAspYedy8XT8vFU5LuIkWnQedH3taIDU5sJsbGh0RmNH
 zPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769043254; x=1769648054;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gxeO6eY4SSwfwzvMzaf9gpifeSYr0BajndrlIpCekuA=;
 b=Eg21Ot89V6eCdTi28xlKaclpgvTJZIgL/25RjZJRNj9SyU4SoyI/bRJtl/9FjELP1q
 VoX4+eIqxtGCKWeLwF8EgpvWVshhu/b+VPz4KqrMUZsotZVDK+8rAK5vOTbMGZ4wWpm/
 4CMyY9n1Wt8yiI+mk0elFi1q1TctctSB5kyyUBH2X8Rv1wI+ujUY60LLvX0pGy0oSpcW
 oqz9NoSzguZBIFKoTAzvkOwqiucezT6r6brXp05H4Yml18jEvNONoyadqUngINDEk6+4
 yDT0sHLVG+paFFoYRlGQDT+/YuGOi73umRUXIP7GilkCGST9DeiVUWlErhsqu4jDup9T
 PoXA==
X-Gm-Message-State: AOJu0Yy8+IDZP6XakNePtThowwWujHjmTNd/Xfu/4Dm6wGTsEHHf5jhW
 dWMOx1O3eu9dTCYs8D9zTVenGAUVMLNqSgdiV0qZudI9S28bwZ9lzbIAGTuiR7sPg4T60v5rMOg
 uBCOM
X-Gm-Gg: AZuq6aKXszbe/fcqrGczFqzv44JgXn/JMQ2OiG/nSR/YeJp/Rx5vpFUoHuvf+jDqKEm
 FGhuSOxHS+m2VJaJzI57A1sx6yZxax6k/7qocrpvmwSeM1eM6c7xS1L00uNpdNG7oPkYm6Z9PmG
 Elr9sKBWASMb/vCUeNyN6V8ihEBR6quN/XEBr6Up7/kx41O7hzp8LOsFrGBCJhltkMWLNibw7d0
 yvoNlzBUgt8J3MGGw3zKw2JdOLHuR4mvEanPmc546tH8n4v0djzTjFNBG/Gx+rLrbleYkwp0Dgc
 4Ry6Y20Pi00udS7UpKX8+g4sfYCEv+9s1e5pkf4IdhMogq/5s8hyzhsvYW0pwpYH9L5jLLB5dSO
 0Ff0Puw1JEwKQ2y62dZmMjDxUHntiXUK1QKcQZy48GbGYq+bSMebalnMhrZ7g7KlP5MxMdxaG/+
 FsIKucjyeJRUhaTDWnadt66G4m4MamX25pQa62ODKQqqp3SXD+Kw==
X-Received: by 2002:a5d:5f52:0:b0:432:aa61:a06e with SMTP id
 ffacd0b85a97d-43569bc1847mr29064064f8f.32.1769043253546; 
 Wed, 21 Jan 2026 16:54:13 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356997e6dasm41695104f8f.32.2026.01.21.16.54.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 16:54:13 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Erik Gabriel Carrillo <erik.g.carrillo@intel.com>
Subject: [PATCH v3 05/14] test/timer: scale test based on number of cores
Date: Wed, 21 Jan 2026 16:50:21 -0800
Message-ID: <20260122005356.1168221-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260122005356.1168221-1-stephen@networkplumber.org>
References: <20260118201223.323024-1-stephen@networkplumber.org>
 <20260122005356.1168221-1-stephen@networkplumber.org>
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

Fixes: 50247fe03fe0 ("test/timer: exercise new APIs in secondary process")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_timer_secondary.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/app/test/test_timer_secondary.c b/app/test/test_timer_secondary.c
index 8bff904ed4..003782b89c 100644
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
@@ -138,8 +140,10 @@ test_timer_secondary(void)
 				     "test data");
 		test_info = mz->addr;
 
+		test_info->num_timers = test_scale_iterations(NUM_TIMERS_MAX, NUM_TIMERS_MIN);
+
 		test_info->tim_mempool = rte_mempool_create("test_timer_mp",
-				NUM_TIMERS, sizeof(struct rte_timer), 0, 0,
+				test_info->num_timers, sizeof(struct rte_timer), 0, 0,
 				NULL, NULL, NULL, NULL, rte_socket_id(), 0);
 
 		ret = rte_timer_data_alloc(&test_info->timer_data_id);
@@ -178,14 +182,14 @@ test_timer_secondary(void)
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
+		for (i = 0; i < test_info->num_timers; i++) {
 			rte_mempool_get(test_info->tim_mempool, (void **)&tim);
 
 			rte_timer_init(tim);
-- 
2.51.0

