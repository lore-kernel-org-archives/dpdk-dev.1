Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBE1F34C65
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Apr 2026 16:47:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B7D944060C;
	Mon, 13 Apr 2026 18:47:03 +0200 (CEST)
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com
 [209.85.167.182])
 by mails.dpdk.org (Postfix) with ESMTP id CEA94402EA
 for <dev@dpdk.org>; Mon, 13 Apr 2026 18:46:58 +0200 (CEST)
Received: by mail-oi1-f182.google.com with SMTP id
 5614622812f47-471618e20a5so2384059b6e.1
 for <dev@dpdk.org>; Mon, 13 Apr 2026 09:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776098818;
 x=1776703618; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rTIhvZQ/q3bvf3pitvtUuhbbjVkm9gLr2DSWlfPY2B4=;
 b=x0YUVT3jhg/b0B3JfnjLZ25jD2LFd0aaROWSVsDzjsBCAJ+B+uF6r45HDysV0UqVQW
 6wxD1CEuUYntTMoa2ha4LAIrWiN48Tcc7UfeDZY3gSWk1kttkUBYZziQN0TnuxKz6cW4
 /pKFGbq3OufSnfD4sDoC9ySN39+R4vl5YGTEOwaCqSKg77cT/g24+Yjwl49K9L0Tzdfb
 G5I8qjSA7s5FGbO+iP9rEzRnuEKPk0mR9m9gEs54wVCDOnXsDg8JQyBs5RpZ02eh1BTv
 AjgICdpFm/8uB/Ni2fIXl7MYcEzpWhVtCCxcjd8p2m0o2eT1kmzoU1sVzPv49vISoLF6
 wTZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776098818; x=1776703618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rTIhvZQ/q3bvf3pitvtUuhbbjVkm9gLr2DSWlfPY2B4=;
 b=iIjCLf8jCr5YYxEphXhfAVK+vbD02jT+5jeG2bHtHLI3uFrVKIW+zoq7M+knqBB5fr
 UBEHcXuEDy2CCLSUN0IwpqdzZymVuXXGXMrujgeEi5Hn75r87JzkyrWnVjzsrWV2B6mK
 o2+pzgogy6dcEXit7hbliwLk5wep9x4+aOcfS++2mSq+9GMGyvcrI8eMyoBIPQgNmOzf
 LIv8Ek5DNbLpi4TKZ7F49PPSYIACti9Y9Xh4XRSwO0DswOL6a7yQ63AerY6uZNAewBB7
 GDKKDT1Vh2uER2oD+57zJtJpRpVgpDnMYi50M7Fr96l6xf2UUI/zkxWowHRSlPkQXFGf
 mYEQ==
X-Gm-Message-State: AOJu0YzP8g2+dUfbfbicgQN1iEKfdquOSi8ls/RohkYsYvFRzxbLFTTt
 eTcegItxxfLHkmMBVZWjJH+6+oUhVIC9UekADkT0EEvGxk8ddaf7oHpQWga0tSup2Jfpw3y2csL
 4e/0z
X-Gm-Gg: AeBDietzrYiDbRXbPruX7NobERM0yKD5t3aW893z5SbXehWLjAGk0q/47yQ3HqxnpEz
 lh6SnasMTn+dhh0Nwdcmofs+XTwvdtjFL5c3LmWjoFmZStD4Gnu2t51uGVRZwMHN4rTUgxBUTPB
 krSbldotusTjX8B7qux4fW8m4QDAyXrqoN+MkBDzsQTMtSiW2UIMDPpq8ET1XzkVni37IzCykDh
 7OcGeJX2Ph0+8vhWmdvtpImeugu4eufjjwDaG+QXhUr8wMwgESfeOHXYazwQnF55luycuxNnlOF
 lUiYUlVp6dzOqgCrVpE3Xz2O4Lz37wB4ff27ebDsOF4j1p7pRgdU1LX4V/HTn76U4uKIPG6ON0c
 7Zle9YOxLsVDbPQgvNzDh40OpeRufV0/Bdk44viuYtHow7Ao12yIooruM6/ub2itcP+GKB7MbgO
 tz5wUcl2SJ1BIFoyhYqosGQ+nQ9j+5vNl33MO3AKU9p+4=
X-Received: by 2002:a05:6808:169e:b0:467:281e:3d85 with SMTP id
 5614622812f47-4789e91ee1emr7467066b6e.29.1776098817995; 
 Mon, 13 Apr 2026 09:46:57 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc3959099fsm6218089a34.9.2026.04.13.09.46.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 09:46:57 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>,
 Shijith Thotton <sthotton@marvell.com>
Subject: [PATCH v2 2/3] event/cnxk: add pause to spinloops
Date: Mon, 13 Apr 2026 09:45:30 -0700
Message-ID: <20260413164652.33291-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413164652.33291-1-stephen@networkplumber.org>
References: <20260121180845.889190-1-stephen@networkplumber.org>
 <20260413164652.33291-1-stephen@networkplumber.org>
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
2.53.0

