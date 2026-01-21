Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E019C44506
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 18:09:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5844B42E5E;
	Wed, 21 Jan 2026 19:08:56 +0100 (CET)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51]) by mails.dpdk.org (Postfix) with ESMTP id 8FE1442E5A
 for <dev@dpdk.org>; Wed, 21 Jan 2026 19:08:54 +0100 (CET)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-47ee974e230so1131005e9.2
 for <dev@dpdk.org>; Wed, 21 Jan 2026 10:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769018934;
 x=1769623734; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nFMk4UXtJDtAShhrVaJ9sEqUaq/vltygYSIvOPtwH4M=;
 b=bAsjpD5TtQA3kGybGBZXphaeaqkPlyfA5a6IX5kEh6FZ06w4WXFEPoebKLiFpWms3P
 zKzXPxAwMbOPLX9/NB+BiOyA4EBFLcIsLK/tBGaNNu63ckB4tpb78txpZAy6uEFVATHm
 agV/X1Xqlk+pMcV27ApW0K0Yf8BdKiE+BPQUIuh1Udd3iMnsjxu16XtvGW2MuAN95fbm
 2lJ9mLy8pUA6D5W5oNX4JDgP1GrAmckoJAvD9qoRFgbCPwCRR0znGfBdQ7vKI6JYgHbe
 rzwzeg84VWz0RC2r/VwPGqHNI5xmw64Ez1G00Vnx2wvV2yQkmzuVVNkbuS7ZB6UlJLOo
 2t+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769018934; x=1769623734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nFMk4UXtJDtAShhrVaJ9sEqUaq/vltygYSIvOPtwH4M=;
 b=PyerZdJyA2aZmuZ1Jx9YIBF6/jCs7ZbpXcBMAMad0dQh5mruoI89E07RYfvb9GpOBa
 YY12JFfw2e1G3f/VQs18W78ll9AuAT8/j51XLe2MkNlNwDR00D3VjznJFzPIZfgpluIl
 PrHgtjHGel9tozXWQoS+ayyVDgMU6XASBOjXlQPk6HWPMDbmrxrCkkJTVwYFtFS730Wh
 ZRP1NEmnXnNGbG6sLxKQKHZ46ssxYsxYFbiW39X1Cp5RNIOFAXZVJ/3PxN/6z5+8gfPM
 2oEYv9a9uqpNT+yXUiqB7FLqQqZOdeJAyXGKixAL+4upkLjsDOWli3X6ySDlBO/czR90
 eqqw==
X-Gm-Message-State: AOJu0YxrUGJG7f1uvwV4oK56g7S4u53O7Ezs8vlvZ4cEYKTdqMTpEcN4
 +I0+hppkfbdZcjTAzH7notqHg8eq5/Pnyx0HKq9zlSJ7h1av3JOoJQyqzpxJ6uPZSmeCwul9YOZ
 YmscV
X-Gm-Gg: AZuq6aID0VGQQd/+UmfmrsI+OINQ33vE1yykjF5YDMuEOaA2iWahXXNMgUdiUg7otXT
 ZQ2DKecO0NVxNH8vbFfAtIdWzxKI1Z/nYt8786B/48qmqjmz48vwBejeTzGqzwRW2DQr2QtnQCV
 OK1OdahZIXKlbwj08op9/xm5dgB0z1/12Pw33KD9ntcveiD11gllmoXQuBR7PE4Vjw7dtXrP+oz
 MZu3eShZJBsSn53zb98NF4kGSxZs3rG/+WjQpLwWRgDF4Ug+GhtKh3CInzi0DMfuoulG5Rt5teg
 k1YdjKbvwnozT1piFir6NARcsn9Hz7PEW09y53kgR5X5lJXlPyn0QOiKcUc3W9IpMVbjVsgGoRu
 01aREp+4QZHJm884N3z3v1VD3IavChPr+RnNff8yhjch9/GvVz2ZwQFHkrQkD1IkdsytBKktbDM
 RQ3V8mZaHbM4eY2ZvO/De4WO1cO4w/JUTsPldzIX+31j1UTYOzWA==
X-Received: by 2002:a05:600c:6085:b0:477:7ab8:aba with SMTP id
 5b1f17b1804b1-4803e79b854mr92800075e9.1.1769018934190; 
 Wed, 21 Jan 2026 10:08:54 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48042c2ed5fsm29093565e9.8.2026.01.21.10.08.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 10:08:53 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>,
 Shijith Thotton <sthotton@marvell.com>
Subject: [RFC 2/3] event/cnxk: add pause to spinloops
Date: Wed, 21 Jan 2026 10:05:43 -0800
Message-ID: <20260121180845.889190-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260121180845.889190-1-stephen@networkplumber.org>
References: <20260121180845.889190-1-stephen@networkplumber.org>
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

On SMT systems when a spinloop is done without a pause
it may cause excessive latency. This problem was found
by the fix_empty_spinloops coccinelle script.

This is compile tested only! I don't have this hardware.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/event/cnxk/cn10k_worker.c    | 2 +-
 drivers/event/cnxk/cn20k_worker.c    | 2 +-
 drivers/event/cnxk/cnxk_tim_worker.h | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/event/cnxk/cn10k_worker.c b/drivers/event/cnxk/cn10k_worker.c
index 80077ec8a1..69ac67115a 100644
--- a/drivers/event/cnxk/cn10k_worker.c
+++ b/drivers/event/cnxk/cn10k_worker.c
@@ -93,7 +93,7 @@ sso_lmt_aw_wait_fc(struct cn10k_sso_hws *ws, int64_t req)
 
 retry:
 	while (rte_atomic_load_explicit(ws->fc_cache_space, rte_memory_order_relaxed) < 0)
-		;
+		rte_pause();
 
 	cached = rte_atomic_fetch_sub_explicit(ws->fc_cache_space, req, rte_memory_order_acquire) -
 		 req;
diff --git a/drivers/event/cnxk/cn20k_worker.c b/drivers/event/cnxk/cn20k_worker.c
index 53daf3b4b0..49dfb2a28c 100644
--- a/drivers/event/cnxk/cn20k_worker.c
+++ b/drivers/event/cnxk/cn20k_worker.c
@@ -93,7 +93,7 @@ sso_lmt_aw_wait_fc(struct cn20k_sso_hws *ws, int64_t req)
 
 retry:
 	while (rte_atomic_load_explicit(ws->fc_cache_space, rte_memory_order_relaxed) < 0)
-		;
+		rte_pause();
 
 	cached = rte_atomic_fetch_sub_explicit(ws->fc_cache_space, req, rte_memory_order_acquire) -
 		 req;
diff --git a/drivers/event/cnxk/cnxk_tim_worker.h b/drivers/event/cnxk/cnxk_tim_worker.h
index 09f84091ab..887c0800e2 100644
--- a/drivers/event/cnxk/cnxk_tim_worker.h
+++ b/drivers/event/cnxk/cnxk_tim_worker.h
@@ -405,9 +405,9 @@ cnxk_tim_add_entry_mp(struct cnxk_tim_ring *const tim_ring,
 			     : [crem] "r"(&bkt->w1)
 			     : "memory");
 #else
-		while (rte_atomic_load_explicit((int64_t __rte_atomic *)&bkt->w1,
+		while (rte_atomic_load_explicit((int64_t __rte_atomic  *)&bkt->w1,
 						rte_memory_order_relaxed) < 0)
-			;
+			rte_pause();
 #endif
 		goto __retry;
 	} else if (!rem) {
-- 
2.51.0

