Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1C1CA0EFA
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 03:42:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 01DD640612;
	Mon, 25 Aug 2025 05:41:54 +0200 (CEST)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41]) by mails.dpdk.org (Postfix) with ESMTP id 0A56A402E8
 for <dev@dpdk.org>; Mon, 25 Aug 2025 05:41:48 +0200 (CEST)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-3c8b0f1b699so584930f8f.0
 for <dev@dpdk.org>; Sun, 24 Aug 2025 20:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756093307;
 x=1756698107; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZqfpBiVxLDwzQzDXtXn+5vVl7aW3fuHqgVf8Hao+KQA=;
 b=sE032MLei383aGN0PaSYLVzX68cRVrRENJEVcowFaHrYGlHZNrO4FE6WtacKxElwPv
 617S1GJsIk2lGpjKDIQQDPZ8rkEBn3WPQUOv0Lc4Wc4Zh6Hjm2ip9y9DW+2UuPfLG6p/
 CGJ9Q9kX11lG1XTX8SG2VQYfBYkiZKgZtcA95VAyesghSjHHC+iuxpvy2RucKsy2MyUg
 P/VLG+J2tKcSlp0aZTwo8wzrNgwzAakD32EYQ++2WS1smVw3HKXOnWhLhLeB1CR/9CEd
 OhGTwCarv81a0rZ6vQz8PDOlaKe2Or+BZb9nAs2SeqTout4h9WXDVPGT/NkGLGBYRhPH
 3DOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756093307; x=1756698107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZqfpBiVxLDwzQzDXtXn+5vVl7aW3fuHqgVf8Hao+KQA=;
 b=YLbOhdWbaLq8EI9qoLR5uNPGJ007mlMLxitcpB8vFxTQKymPrH7bT3Tb1keWqmHiwM
 WXTakAyZ4A0Z4UiBRN/91w7OB1/oKueyLCr5WRiaCAnzOku8hEaAcvjac/+bNs7cdZub
 zNhusfuGBUTUc/+i75xZZ4fo3y6ahHY5ixz70oak3Y7piH04bOKi4Uu7IaPNPzfbhGA2
 2p65u6I69B1M3KmsKP/UkzSgvWvTsCH/PVVmJifzQonxRNEpwBb0pA+PuN18ZtVsAaKZ
 g3EfpJqZr4MrzeUgs7mB1LTu31PXdTgGcJib2ARsdR4Lwr5GOHQejER1PnCNC2bTwaLR
 S9ag==
X-Gm-Message-State: AOJu0Ywt2qfrEMiO3xPhKMIlhMcBMnFCEONPbQ/6/C9tmfEpxyUTAiS/
 yupWymx6HqKgHuD/HZbYeI535hoh8HH2drD7wIVLHy7SnXavgsYoOgofVUiOAeiQHEHJOwau2tv
 0yKHW
X-Gm-Gg: ASbGncvzY9M74cHho1sZNQINwyukzqow7pi1UL2rjhjBl3fJLSIpY7j+UN4trxF7RHt
 P0xYW/cyHN+RkIoMM2nAlWUtbIFSw2Q6yjML5QnGHqvYBYk4KcjDT2SQqd4Qb4K2+x/dI4qHIca
 Uxupj4ncdPKnc4cjPvtpMniI68R/BRT0g0nYV7Juk5O1kSeunijh0Vr6HA1vp31O1zIUXjxSEYd
 gWUuFIUIrLpvRJCvARfKePgpzrU5T0Izr/0XPYBgH0wMDrBP+ykMGD5OD4tZeJtHCfK6VggD6m1
 5Ga13KkbrZvBQp5aZ94ilCHPaPvZiJo7oLfq3CRH18XGq9b3wG+1ZfqMBwTKIBEdKClUhrGZLLS
 oEj5GXWXDQllm/lRwSEOrKzoavZJdDyxuuJmFB9TU7nfpswNaR2EtZOy4cMqHSH5AoW2H/lct
X-Google-Smtp-Source: AGHT+IF8wK+QEZwE5L06Mj/y+HT0UntRfF8FLBr/sd3cygCJRIgjp/a2adCduIXQXKYC161ztzERTg==
X-Received: by 2002:a5d:5d87:0:b0:3c8:f348:7882 with SMTP id
 ffacd0b85a97d-3c8f34887d8mr1528387f8f.54.1756093307640; 
 Sun, 24 Aug 2025 20:41:47 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c711f8a0d6sm9609939f8f.66.2025.08.24.20.41.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Aug 2025 20:41:46 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jerin Jacob <jerinj@marvell.com>
Subject: [PATCH v2 05/43] test-eventdev: use rte_bsd_queue.h
Date: Sun, 24 Aug 2025 20:38:18 -0700
Message-ID: <20250825034126.12046-6-stephen@networkplumber.org>
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

Use the replacement rte_bsd_queue.h header instead

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test-eventdev/evt_test.c | 2 +-
 app/test-eventdev/evt_test.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/app/test-eventdev/evt_test.c b/app/test-eventdev/evt_test.c
index 72d6228bc3..04681e1e72 100644
--- a/app/test-eventdev/evt_test.c
+++ b/app/test-eventdev/evt_test.c
@@ -4,8 +4,8 @@
 
 #include <stdio.h>
 #include <unistd.h>
-#include <sys/queue.h>
 
+#include <rte_bsd_queue.h>
 #include "evt_test.h"
 
 static STAILQ_HEAD(, evt_test_entry) head = STAILQ_HEAD_INITIALIZER(head);
diff --git a/app/test-eventdev/evt_test.h b/app/test-eventdev/evt_test.h
index ad3f531dcf..30b248d5db 100644
--- a/app/test-eventdev/evt_test.h
+++ b/app/test-eventdev/evt_test.h
@@ -7,7 +7,6 @@
 
 #include <string.h>
 #include <stdbool.h>
-#include <sys/queue.h>
 
 #include <rte_eal.h>
 
-- 
2.47.2

