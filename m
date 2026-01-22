Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCDCC44536
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Jan 2026 00:54:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3DEF1406A2;
	Thu, 22 Jan 2026 01:54:11 +0100 (CET)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48]) by mails.dpdk.org (Postfix) with ESMTP id 26ED94068A
 for <dev@dpdk.org>; Thu, 22 Jan 2026 01:54:10 +0100 (CET)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-47ee0291921so3519395e9.3
 for <dev@dpdk.org>; Wed, 21 Jan 2026 16:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769043250;
 x=1769648050; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MT0Nx6ezQYKvnIRN9g+SmqUUhb3O8EFOkdEYJV8BRfk=;
 b=OG6Kp9wRH3KHS9IzUcr63o1UHnyC5uB47o8srI2VmHEkTKPxS0e4qEH2BTj1FgV/9h
 ALOzV3UhCfA9ZR2oKG16Lw+7ZCbitcTz505AtvobXMUowHjVh03BVkhA39CGO9SrsWLH
 aIUGprHw65SyMH9PtEbH/PsMw//WdAT7r+TZFjPkp0Mm5mSqcweRf3hJz1ONmIrGBBfJ
 FrFaL656togp+d0FV1yjbxMsSj2xinvMH7AzDz6iufbGCQR4zngn1h2pkqNMWr5Ux5sU
 wbsQ5hPb3zISFH7Q8RUSY0lc5WczzIHYydMGV16iGClL3GBXUN4z/WxBJcPHjMLtNNhL
 TRrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769043250; x=1769648050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MT0Nx6ezQYKvnIRN9g+SmqUUhb3O8EFOkdEYJV8BRfk=;
 b=DwGWBzsgYQjKAZB8GrQP4PNxNIBGaPh/PM8ppUnE7j32f0MIOodMgLii7o8K1GHIVp
 inotc/zAlKaAMUMehnORsRqzDurOeROSTwZ8no9QMOgBwKO3XzD/nbjfO4amwvrzvDCb
 uiXkWysj+AYg+Z+G65Zn1JUnCxXnMsjNCcZjTZfoM+KMc5DPaO4gxiGWslWRTVRx6cNd
 tNgFaBX8Mhow/UImYAc/o+1/OYl0hG7H/Dia32EBbKCeBsawOJH5I8rPktLUWGc7xF6+
 /Dmqjyfo5VGLntuPi/A/3sppzgeZfTaVbXu4g4TnrSvfgMsHb9fqjDRz6v8O+XAL13WT
 lVEA==
X-Gm-Message-State: AOJu0YyLP/Yf36kYMAbBFND9XxD8KRgE0d8wVC0x1QO4xXOkp7/AEHXW
 S/mJdy81R7VNk10BwttPb2mq/Gx3fyxv+uEW9qnDz4zyWRU1I2OhVOGqG7h/tMv5lkRqfN94kXF
 3cWap
X-Gm-Gg: AZuq6aJH2olyTqau7kYs0+6wS4S49UQLV7Lj1h3hf1TSJbH4xulJOc9NzQYluTh0GFf
 o1961HdWfMvitQ3SFtAVU8/mF7/op6ahZG4PDCXkgUrWi5cJHG7Zkd24PllPd01Bvs2km7x4TAW
 SEe8RMX9mr3GgdvVWep6RGIo5Dd/WjfBEX6C9LnqpU2IZ3BuBeoYwg4LS3rHVnktHI8yLdJjzFl
 L8qyLuwGLlz/kHOQVkM+eJbRcqS74BUI5x093kGAe6pM4lSniDQj8CrHCxi360tcoA+l/Lj+Qy3
 K5z6BO35RbN99hnm24SrWZj8UVIWyrPrRrOE3pEHk0wUTIfgA/x9FCPdgBaO9qII9Kx+ztGEKvU
 ZzchQCvj4MgBfnxOLoI/0zwPOFlI5RWIMaTBTMtWzv83wa9EjeR6MSzlEFS5aQYnPrYYF5ZovcB
 j8QmuWkCPFs3cEJIAszi9QhJWG+RIYrKZxJyexZvnNfVc3TSt2B3D7bJCX+JmK
X-Received: by 2002:a05:600c:5250:b0:477:9cdb:e336 with SMTP id
 5b1f17b1804b1-4801eb04f1amr283917625e9.21.1769043249724; 
 Wed, 21 Jan 2026 16:54:09 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356997e6dasm41695104f8f.32.2026.01.21.16.54.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 16:54:08 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>,
 Phil Yang <phil.yang@arm.com>, Gavin Hu <gahu@nvidia.com>
Subject: [PATCH v3 03/14] test/mcslock: scale test based on number of cores
Date: Wed, 21 Jan 2026 16:50:19 -0800
Message-ID: <20260122005356.1168221-4-stephen@networkplumber.org>
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

This test uses loops to synchronize but has problems on systems
with high number of cores. Scale iterations to the number of
cores.

Fixes: 32dcb9fd2a22 ("test/mcslock: add MCS queued lock unit test")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_mcslock.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/app/test/test_mcslock.c b/app/test/test_mcslock.c
index 245df99a5d..b182da72f1 100644
--- a/app/test/test_mcslock.c
+++ b/app/test/test_mcslock.c
@@ -42,6 +42,10 @@ RTE_ATOMIC(rte_mcslock_t *) p_ml_perf;
 
 static unsigned int count;
 
+#define MAX_LOOP_BASE  1000000u
+#define MAX_LOOP_MIN   10000u
+static unsigned int max_loop;
+
 static RTE_ATOMIC(uint32_t) synchro;
 
 static int
@@ -60,8 +64,6 @@ test_mcslock_per_core(__rte_unused void *arg)
 
 static uint64_t time_count[RTE_MAX_LCORE] = {0};
 
-#define MAX_LOOP 1000000
-
 static int
 load_loop_fn(void *func_param)
 {
@@ -78,7 +80,7 @@ load_loop_fn(void *func_param)
 	rte_wait_until_equal_32((uint32_t *)(uintptr_t)&synchro, 1, rte_memory_order_relaxed);
 
 	begin = rte_get_timer_cycles();
-	while (lcount < MAX_LOOP) {
+	while (lcount < max_loop) {
 		if (use_lock)
 			rte_mcslock_lock(&p_ml_perf, &ml_perf_me);
 
@@ -175,6 +177,8 @@ test_mcslock(void)
 	rte_mcslock_t ml_me;
 	rte_mcslock_t ml_try_me;
 
+	max_loop = test_scale_iterations(MAX_LOOP_BASE, MAX_LOOP_MIN);
+
 	/*
 	 * Test mcs lock & unlock on each core
 	 */
-- 
2.51.0

