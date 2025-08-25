Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08564CA0EED
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 03:45:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F91D4066C;
	Mon, 25 Aug 2025 05:43:24 +0200 (CEST)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49]) by mails.dpdk.org (Postfix) with ESMTP id 0916B40A70
 for <dev@dpdk.org>; Mon, 25 Aug 2025 05:43:18 +0200 (CEST)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-45a1b0cbbbaso32974385e9.3
 for <dev@dpdk.org>; Sun, 24 Aug 2025 20:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756093397;
 x=1756698197; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kSlLO+fbx0tYvizXmDE0iTJFaCrR0Z8HB79gCLdlIAw=;
 b=uZVpJwjWG95IogFvxJ8J0IJjPGXCulZSsdeYMpL2AlOnecazGxbCr0PQfNrhb2RF3l
 Xh5f3mQP8ZcYylDGl4gKaXJr13FRO+rPJkXIGkKSmdJgo6XOHO2Pk0kRSWYK1xbufnYb
 rNNEUgC4d1891bktNt7ZrG2qu8zEFMXxy5+x1bEZsm05WQjlBG0LMD4ZBt6nmaZYNLYK
 +royTss1osBjMTUsLxZ6NgKOlMkFxkJjSkknit8YLpbzSPgMBguMU3K4ed34JEiPCPhA
 0ikhJ68a5OAfuNyPp64UebXpKiUQYgd4IaBI1l4tX04sVaysP7mVS27TgvSzujp4VhnA
 MBDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756093397; x=1756698197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kSlLO+fbx0tYvizXmDE0iTJFaCrR0Z8HB79gCLdlIAw=;
 b=WybIPPbHxJJGbqGslmYucr7e0Us3SKMMXB/z/E2Eg1h2/2M8uVwV/aViIL+BI0SQh4
 +rsk+C7Mo46DELgmpknYIGojqxo8ySCxfREnjdNzD87KWQUpLASLMdR66n4K5yguRvdu
 EbwO4HeqTv4nrpuQ0T4ELl5AMN9fCG+JLg47htyTWVkYPtQBDGvvxHbf2rBBOnFnj3cN
 wA0tHQHHrlCZk3f2LBAMuE6QhqiL3nep05wR29nYnzcYvhgoyU9qWGB2Wezzmr6FBXOY
 udBL2vj7oqJe4ZOY4LS2Le64No2zd11IxY6R+gHOPyu2d3HU9SCDCrlAKZ8AyBz9l8Yi
 l/1Q==
X-Gm-Message-State: AOJu0Ywmsgy9CVK1/8PsZ9SnMx7k6RoicJI54BIC3n0Br9Gc8ouh6C/v
 3UqpvCGXqXV7Mf0wYD+tpLOOTPGNjcN+FjL3LLxMTmvaqjy3Fp2MfTClz/HHcVU5d9MhBTS0Tlx
 fMmiX2WE=
X-Gm-Gg: ASbGncv3AFVY5OGLcMrFPz9odBLwO2E41xQoT+v8aLCMvt6dynY7Op9Nt95vZiooLjm
 p5vdklfjK6dIiVkxN3V2g3lwS6i8lsMqQIkTTUtr5TjPNW3PlIvHviIC4q4+UQu8DOUW2rGLSGn
 Jj5GqXci6uwS77GoW1vK5AvW5/k4RzDudOSwSCQTZ4QnfK3/VE2UFt8xzlqr+c+IkIx6omxxEmt
 ghVMu4/Xld/yyniJitMaL7KOfNqIs3eafJVHf2kb5TgWupbx4rBum5ututU9cBEQ05CK+CYOae3
 mv7mopccuvyL9ng+cIQT+5ozk+bXbR2no5l3yPo+CpJ/h+7rHxqsNopqE+WJ8/v4Xn9CFhz2OHX
 ci9J3EykEcvNTgvAP3KKbafKYsOBpcHd9gy6WucpAM6pX6iGvRZta4ZYJGmulErfxpyIXoKID
X-Google-Smtp-Source: AGHT+IE8IuxhT+9qbXMIPM6WXffP0JbpaZhjaJnqrE8hPAsWbYw32pueEmsE0fo1+PL9adttYt2cYw==
X-Received: by 2002:a05:6000:400b:b0:3c9:8e80:da00 with SMTP id
 ffacd0b85a97d-3c98e80ddd9mr844867f8f.19.1756093397660; 
 Sun, 24 Aug 2025 20:43:17 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c711f8a0d6sm9609939f8f.66.2025.08.24.20.43.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Aug 2025 20:43:17 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Tirthendu Sarkar <tirthendu.sarkar@intel.com>,
 Liang Ma <liangma@bytedance.com>,
 Peter Mccarthy <peter.mccarthy@intel.com>,
 Harry van Haaren <harry.van.haaren@intel.com>
Subject: [PATCH v2 42/43] drivers/event: remove include of sys/queue.h
Date: Sun, 24 Aug 2025 20:38:55 -0700
Message-ID: <20250825034126.12046-43-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250825034126.12046-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20250825034126.12046-1-stephen@networkplumber.org>
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

The system version of queue.h is no longer used.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/event/dlb2/dlb2_selftest.c   | 1 -
 drivers/event/opdl/opdl_test.c       | 1 -
 drivers/event/sw/sw_evdev_selftest.c | 1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/event/dlb2/dlb2_selftest.c b/drivers/event/dlb2/dlb2_selftest.c
index 87d98700c9..b085a3407d 100644
--- a/drivers/event/dlb2/dlb2_selftest.c
+++ b/drivers/event/dlb2/dlb2_selftest.c
@@ -7,7 +7,6 @@
 #include <stdint.h>
 #include <errno.h>
 #include <unistd.h>
-#include <sys/queue.h>
 
 #include <rte_memory.h>
 #include <rte_memzone.h>
diff --git a/drivers/event/opdl/opdl_test.c b/drivers/event/opdl/opdl_test.c
index 9b0c4db5ce..b6fe99fbcc 100644
--- a/drivers/event/opdl/opdl_test.c
+++ b/drivers/event/opdl/opdl_test.c
@@ -8,7 +8,6 @@
 #include <stdlib.h>
 #include <errno.h>
 #include <unistd.h>
-#include <sys/queue.h>
 
 #include <rte_memory.h>
 #include <rte_memzone.h>
diff --git a/drivers/event/sw/sw_evdev_selftest.c b/drivers/event/sw/sw_evdev_selftest.c
index a2ce14051c..18ef5f13a8 100644
--- a/drivers/event/sw/sw_evdev_selftest.c
+++ b/drivers/event/sw/sw_evdev_selftest.c
@@ -9,7 +9,6 @@
 #include <stdlib.h>
 #include <errno.h>
 #include <unistd.h>
-#include <sys/queue.h>
 
 #include <rte_memory.h>
 #include <rte_launch.h>
-- 
2.47.2

