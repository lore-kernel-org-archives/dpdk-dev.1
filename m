Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A32CCFA03
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 16:52:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1CC1E40B99;
	Mon,  3 Nov 2025 17:49:59 +0100 (CET)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mails.dpdk.org (Postfix) with ESMTP id B5CF340A6E
 for <dev@dpdk.org>; Mon,  3 Nov 2025 17:49:53 +0100 (CET)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-27d3540a43fso45233455ad.3
 for <dev@dpdk.org>; Mon, 03 Nov 2025 08:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762188593;
 x=1762793393; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zua+g8QAgFAwK+G9wGKW0x2VlaPBOBo88mwZVh7oQ/c=;
 b=u6eDXfADnn7IkzNgtFL3KpdqzvqoIUdKiyzog7aO3CGwKgWFWE5KiLA9cfRgKLt4Jw
 hhGebnXEA2t5F1PZPzmqkXq9G5UkyHs7dQalUo0tfysT9MuInWQA7zmdgWpct35j6OIw
 jLcVde1LQtDaNPCQfVa/kDBeqZoUxO/5yKvCm8u4BVMvuKXLQiaAO0AsNxbc6Jxs0pp9
 fQUUPQYuXaYqk3Z9gKsYjWAN7VSHROVqoiKR4I6T0zU40LsiOrr02AC1MWxtd+yQ1M1c
 fPrBGu9i2/MQhvLZRMzHz/iiO/ij5MAWPzSGw+PFFjOUEjz6Pq55KkFGQI/354Tm3JRv
 293A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762188593; x=1762793393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zua+g8QAgFAwK+G9wGKW0x2VlaPBOBo88mwZVh7oQ/c=;
 b=QcsebQKXmAm2yACEaBL2pf2l2Gy5L3ksE+aEHV7IoWQVnh3kyTug3ddL4jNRbOKxWP
 OY1sWXzB1jw5WHAHPa0I7EcRKGVNVTb95GYVchQnt1s0Tyqlh7C5SyPjO1ljPAoToQUx
 E+AILxjw9y7rF84BuIRsTi0/TWsCEW9JNXKTkwegIdQc4/4EGJGD3Zd/T9/SEkn3bYzM
 FfVt3BF33P9aDyTUuIHCtobh9MDfE7Mp6/xajKo60igLSTQLpDjPmJANWfu8eun9MNBV
 PTh0IW49at4cnqugv+ua0vvZ4Jah15DZSB4FZ6XyC/zRhf3BwYF+bNf+codaVxqHHDrk
 igcg==
X-Gm-Message-State: AOJu0YxoDSK6FdXM/bd5cPlt5Axk/VJ4IN4WCqFtIVltTHIyv06xPM5T
 WesEnZO7b+w73lS31kRwtHdY72z2DeZ4YmD1vdAbuMqhasBgO1pXFk0AT3DI5NOKw+hgBNUKWg7
 SZ3fM
X-Gm-Gg: ASbGncvAq0xX2I6e8Z8W+rVJPh/HlUP/QKzsdzPE1Fz+fBrzeCTLBemPnVo+vEPGxHz
 yZalAVB/WlyIiv04WbVGo9ONJlr2uAQ8GjeKGuD92jGE7cVNNkEAC/d7ZSXNwXZuV5zmPufIzlH
 WJXyiMWhMsOnQNkete8z9hwr0tkMu/WWGdEqqyqwrQ+lITXlZej5qsLzsauM2wKFfslCYhkFfIh
 fcPMqoCI68HUXWcoZFRoyfEhX2xlqxklNBSyRV71MWeyScxwrg7sIIQ5GmEsO4GVx/hkuHGFkma
 q8Lk7QwfRi8DzQCRi7tJuE4Td4xBG85ma5qNlL8aCuLbDPquh51OoXcC0kbgVvCcEkA4Ui7nXU7
 Tf6kEHECBPx0lXxeRs07Wflwjj5cwMfLIJ5DwRjAkDWKJp8F6Yxtgxz6oNxinqpoSMmPuO1QunN
 xRWi+v+wOzHo6xKn/UZ9wbvJrHsJL/46s8pB1er60=
X-Google-Smtp-Source: AGHT+IGRS2Eb7+V/sLqt3J7sNE91xBczp3TV+zw8fOMhCPcH/6mo/YDV3nV9rIp9On3HZsh+CaMBiQ==
X-Received: by 2002:a17:902:dac5:b0:295:70b1:edcf with SMTP id
 d9443c01a7336-29570b1f38amr95351695ad.36.1762188592882; 
 Mon, 03 Nov 2025 08:49:52 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3407f26e0a6sm6779040a91.5.2025.11.03.08.49.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 08:49:52 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Gaetan Rivet <grive@u256.net>
Subject: [PATCH v3 25/44] net/failsafe: replace use of sys/queue.h
Date: Mon,  3 Nov 2025 08:47:30 -0800
Message-ID: <20251103164915.101713-26-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103164915.101713-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20251103164915.101713-1-stephen@networkplumber.org>
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

Replace use of system sys/queue.h with DPDK rte_bsd_queue.h

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/failsafe/failsafe_flow.c    | 1 -
 drivers/net/failsafe/failsafe_private.h | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/failsafe/failsafe_flow.c b/drivers/net/failsafe/failsafe_flow.c
index 707e6c63b5..9f620443a4 100644
--- a/drivers/net/failsafe/failsafe_flow.c
+++ b/drivers/net/failsafe/failsafe_flow.c
@@ -5,7 +5,6 @@
 
 #include <stddef.h>
 #include <string.h>
-#include <sys/queue.h>
 
 #include <rte_errno.h>
 #include <rte_malloc.h>
diff --git a/drivers/net/failsafe/failsafe_private.h b/drivers/net/failsafe/failsafe_private.h
index babea6016e..94533a9a81 100644
--- a/drivers/net/failsafe/failsafe_private.h
+++ b/drivers/net/failsafe/failsafe_private.h
@@ -7,7 +7,7 @@
 #define _ETH_FAILSAFE_PRIVATE_H_
 
 #include <stdint.h>
-#include <sys/queue.h>
+#include <rte_bsd_queue.h>
 #include <pthread.h>
 
 #include <rte_atomic.h>
-- 
2.51.0

