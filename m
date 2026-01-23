Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760AED6CFC1
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 04:30:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 05ACF4065A;
	Fri, 23 Jan 2026 05:30:12 +0100 (CET)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50]) by mails.dpdk.org (Postfix) with ESMTP id 35BC24064C
 for <dev@dpdk.org>; Fri, 23 Jan 2026 05:30:10 +0100 (CET)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-42fbbc3df8fso1105928f8f.2
 for <dev@dpdk.org>; Thu, 22 Jan 2026 20:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769142610;
 x=1769747410; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+kqCFItk0itE0KpgFMM192XBzrhr28QRY35s8pDKsiw=;
 b=13ZkFqhjcpQZ8kBiOzqAof7AzIsKif5gOHo5TUDQ7r/xV6FICMPGDudgTi1MvWEfEs
 UUPB4iuZeBhk5pVo33UZSVxU4WX8fnUUsgA7ikNX0wjeLnohGsfkNJwzDRCZv0vqEmfl
 ainf9DPo9XpEHJog4f+ucp1zCqX2ScIZs1JTdHOfmUcvNHxok+BpYk9AUz4q10aHC84+
 Wl3Oxd6BbiVNp32GuxYsRp7N89AcGhGrPwfKco44yoGu/PSY4+VLdzOyGu85hbrrcRQe
 8Z7a3dSRiP0C1crlhFOlMmTtTUFT4pHvEU6u27iJnFUSa/aiLkJ8CBERf4ItEA/qf/E6
 BIOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769142610; x=1769747410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+kqCFItk0itE0KpgFMM192XBzrhr28QRY35s8pDKsiw=;
 b=VWmWt0KkJLpKZ/SNyR8sEYRJdNLeDP26YCQAqxMLrf9q8ElCNHYphut6jwmkVHf7Sc
 JeCx2Ozt5IaH6l0qSO7LhCjt5mvOv7Qo5F/pRSonBlVXiSxO8SahiegU0FZKBXzaaExo
 yLUeMA/6chdkLjg5SiMqZyVeyoLq0+1QUkp+r6JaNNpCaRSuclsQwndwQVS2zd0aoypN
 eVO/zDBBKpr6WJ8cK5/HC2z5aOSIVpTsn2JmDXLemXnF/cip51cgD+6/isGHtXnu6WA8
 nAzeuK91ou+l/pGD3pIqQfF4eM2DeU/vO8jcK7JA3pGMWb5T5s8RGNGYgfUC2weVjQZ8
 xE0g==
X-Gm-Message-State: AOJu0Ywc6yGePWuO7tqQHBmV6tdzrmiMwPwVRJ3M33cVklwQuvZzH4LF
 mob1AvxMJsVr+9HN3t12ZS3JeqO25jWqITK49UDZNLYPDsXy4Dpfl7LaBqGDtOYWq17NS06MSG7
 zH1VR
X-Gm-Gg: AZuq6aJK3vvBmot5Wbzs8qGWrsnBH9hElrkzhySrN4CqOOQwbiFd1oSZYQGiJXMd8IS
 m6fSw//lL0WldD50S1AKSZv1SHfwQOGswR8VatvDln4QJ1MGssL99P7yGn4816WiRQkMMqPgW/C
 kRxI+AAC2J32f2NvxmaFEuqYiUoRcOgv3MyyK/xMmiGuzNH2VBOFpMwJ9C9srparv7KnULu9iAW
 if/FCJt0BZgo0lcqsKVUdL0vVLjf9XcFlN4QsZ+hNYw2YqkcQXowcxiyqJpHSsGnkPgTWUnd2w2
 DOrGu5e7bC5pXhAR+yK0I+Jn8mqzTrOmAIGNetXwhIQ1O2z+shktcq7vxAV1g4HLR59U8km4vt0
 JdHWbMFzgSsNDCBvUTIyIS+voUTWAQ4D3P6ew3uAkxeGEOOIyTy54xnnZAxyeTY+giGIpbcazH/
 X4M/K6CKXycsPDfjfahRoKvZXjsITgXGUtrJGh4tjfN3YyUvuQXQ==
X-Received: by 2002:a05:6000:1847:b0:435:9756:d4c4 with SMTP id
 ffacd0b85a97d-435b15d6927mr2752911f8f.17.1769142609745; 
 Thu, 22 Jan 2026 20:30:09 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f7b41asm3603771f8f.39.2026.01.22.20.30.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 20:30:09 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
Subject: [PATCH v11 08/18] eal: warn if thread name is truncated
Date: Thu, 22 Jan 2026 20:28:06 -0800
Message-ID: <20260123042945.159075-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260123042945.159075-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260123042945.159075-1-stephen@networkplumber.org>
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

Thread name is very short 16 characters and therefore the name
dpdk-worker-%d will overflow with more than 9999 worker cores.
Error should be non-fatal since name only matters for debug.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/freebsd/eal.c | 6 ++++--
 lib/eal/linux/eal.c   | 6 ++++--
 lib/eal/windows/eal.c | 6 ++++--
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index 6215245ad5..60f5e676a8 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -690,8 +690,10 @@ rte_eal_init(int argc, char **argv)
 			rte_panic("Cannot create thread\n");
 
 		/* Set thread_name for aid in debugging. */
-		snprintf(thread_name, sizeof(thread_name),
-				"dpdk-worker%d", i);
+		ret = snprintf(thread_name, sizeof(thread_name), "dpdk-worker%d", i);
+		if (ret >= RTE_THREAD_NAME_SIZE)
+			EAL_LOG(INFO, "Worker thread name %s truncated", thread_name);
+
 		rte_thread_set_name(lcore_config[i].thread_id, thread_name);
 
 		ret = rte_thread_set_affinity_by_id(lcore_config[i].thread_id,
diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index b12f325ddd..d848de03d8 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -863,8 +863,10 @@ rte_eal_init(int argc, char **argv)
 			rte_panic("Cannot create thread\n");
 
 		/* Set thread_name for aid in debugging. */
-		snprintf(thread_name, sizeof(thread_name),
-			"dpdk-worker%d", i);
+		ret = snprintf(thread_name, sizeof(thread_name), "dpdk-worker%d", i);
+		if (ret >= RTE_THREAD_NAME_SIZE)
+			EAL_LOG(INFO, "Worker thread name %s truncated", thread_name);
+
 		rte_thread_set_name(lcore_config[i].thread_id, thread_name);
 
 		ret = rte_thread_set_affinity_by_id(lcore_config[i].thread_id,
diff --git a/lib/eal/windows/eal.c b/lib/eal/windows/eal.c
index 21fe7cb1d9..f06375a624 100644
--- a/lib/eal/windows/eal.c
+++ b/lib/eal/windows/eal.c
@@ -378,8 +378,10 @@ rte_eal_init(int argc, char **argv)
 			rte_panic("Cannot create thread\n");
 
 		/* Set thread name for aid in debugging. */
-		snprintf(thread_name, sizeof(thread_name),
-			"dpdk-worker%d", i);
+		ret = snprintf(thread_name, sizeof(thread_name), "dpdk-worker%d", i);
+		if (ret >= RTE_THREAD_NAME_SIZE)
+			EAL_LOG(INFO, "Worker thread name %s truncated", thread_name);
+
 		rte_thread_set_name(lcore_config[i].thread_id, thread_name);
 
 		ret = rte_thread_set_affinity_by_id(lcore_config[i].thread_id,
-- 
2.51.0

