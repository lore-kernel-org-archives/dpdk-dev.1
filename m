Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4A9CA9ED2
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Oct 2026 21:10:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3C3854064C;
	Mon, 12 Oct 2026 23:10:08 +0200 (CEST)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51]) by mails.dpdk.org (Postfix) with ESMTP id A32E6402D0
 for <dev@dpdk.org>; Mon, 12 Oct 2026 23:10:07 +0200 (CEST)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a020e65269so14319635e9.2
 for <dev@dpdk.org>; Mon, 12 Oct 2026 14:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791839407; x=1792444207; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5leK+Iu4DMI2MhsCWnZ5O6QAwAKJAqyu3FrTzKNo1rg=;
 b=G8Z9apEYr8jAU2nxejo+ndMUJTZzu/0fTEe+78Om5cIhb79xzLTSlwa+L/n1yycW5t
 w37X9C3ympCFVDU2OjEXid+hmDlBCPanNNgFLNH60kzBnlYSevNySdCi63DJSTyM57UW
 MrEIQvCBQ3BgpkWoh4SlXeB8ChTpRFwIEvZ3cMD6EVifDUf5Zp35gqykzX4HtjYQPnTu
 ntaHX9VQl92piMfGDZYK1fJBM8OrlbBDhZiIRyz0k5X8JS0OL0DbA5+n7VoB/jN/54xb
 O6j5IH1AmyegQZlKqqcs+rsJplqakTRwIfeC0SzqzYj8J+gCIOd5R8K89GO0VqQDlHSc
 YnZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791839407; x=1792444207;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5leK+Iu4DMI2MhsCWnZ5O6QAwAKJAqyu3FrTzKNo1rg=;
 b=Ats7tE2XCNiNvSkCG/E4Sxk/d4H1KyU7hg/Yt28JMZS7A0ckIBQOKHroD1eNVfkoCN
 4yhmC2Hz1odgHt1S54WFgas677R/y8gCwqWNB0NVL1+x16VCx1bSZjtYZCznULvL2Ypt
 kasnrL2NrnYoM1bYHzTm50MEhNUv1ZeGp+PcdLfl23SEKBMYR4hagTawplDKJ18TJUIF
 HOjkcHFk93kxD+UIuMH9/v+nGz2E2zWnzIMZjJoU3GIz4CFxfVGNlmOgi/6JlEFqzapq
 kaOs9Sc7Cf99Vhk4fg4xjMW/FbrPy8eMBL2kBVpyxROd9wWe1JaJW1sYPifchY1cyU7G
 BaFw==
X-Gm-Message-State: AFq9FYJeWEW7mzwXDCQyYy/PHYH1dGy1CFAo3maaoimGC88R4L4pbRe7
 k72cvSXcHESGqgadq2H8aYvk784GFC17kC21I52JyL6iKHi4QJrNtLS9
X-Gm-Gg: AYBFou3Q40vDabx7LHkR9wjFN+sa7mFFQH7WmReRmMbWk0i4YHEHJeUAhEUUNTXKlax
 8XknIJzG6NvbZ8MqgTF2TCfFoptzh5vCL6TMgItbJHnE2AWMXTUA+Ao+kwcWq8ZQ+d9lpimtSMh
 AQlVy/juusRP3NepuS1fl1U8fapQ7Opv1loQHDo1JDeKtVewyaEqDPu2a/mSDYUCLyEJE4vt9GQ
 XQ1ftYHm9Ad07LV2bEcW1AJ99Oei7t3Cj+xTGialujMih6Pv5LIjjsqcChJPvXUOpsIfHrAqjsm
 jCmYDN9U5hl9ae6U2FTyZ5EasJv9HawDvDUuEG6jMY40mIdvTv9HSXuK1mhYfoHMFFxgwaC5wXH
 6zG+ITX+PlLw4BL15dJYi39eCu2EIvzmPook8IdmOG1Ao+wdixURJO+97TY8G9HzqZ3bNWv5cl/
 yxAHSGn5XrAYmKU/goKeNuaLO6uL4XBxMS+01rMm5ePbuTvEU+RHX3mU9TPBlcdTENq8DAKg==
X-Received: by 2002:a05:600c:19ca:b0:4a1:7e76:d02f with SMTP id
 5b1f17b1804b1-4a18e4ac650mr203011225e9.14.1791839407182; 
 Mon, 12 Oct 2026 14:10:07 -0700 (PDT)
Received: from dpdk.lxd ([80.233.57.229]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf2caf4sm342208725e9.10.2026.10.12.14.10.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 14:10:05 -0700 (PDT)
From: Marat Khalili <qm2k21@gmail.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <qm2k21@gmail.com>
Cc: dev@dpdk.org,
	stephen@networkplumber.org
Subject: [PATCH v2 7/9] bpf: use relaxed accesses for callback inuse tracking
Date: Mon, 12 Oct 2026 21:09:14 +0000
Message-ID: <20261012210917.161343-8-qm2k21@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012210917.161343-1-qm2k21@gmail.com>
References: <20261011182158.124246-1-qm2k21@gmail.com>
 <20261012210917.161343-1-qm2k21@gmail.com>
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

From: Stephen Hemminger <stephen@networkplumber.org>

Direct assignment to or reading from an atomic variable defaults to
sequentially consistent memory order in C11. Since cross-thread memory
ordering for packet callback execution and unload is already explicitly
enforced by memory barriers, sequentially consistent accesses are
unnecessary and may emit redundant barrier or locked instructions on
weakly ordered architectures.

Update bpf_eth_cbi_inuse() and bpf_eth_cbi_unuse() to use
rte_atomic_store_explicit() with rte_memory_order_relaxed, and update
bpf_eth_cbi_wait() to use rte_atomic_load_explicit() with
rte_memory_order_relaxed.

Originally proposed by Stephen Hemminger as part of a series replacing
deprecated SMP barriers with C11 fences.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Marat Khalili <qm2k21@gmail.com>
---
 lib/bpf/bpf_pkt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bpf/bpf_pkt.c b/lib/bpf/bpf_pkt.c
index 55f5947460..c5fa85bf84 100644
--- a/lib/bpf/bpf_pkt.c
+++ b/lib/bpf/bpf_pkt.c
@@ -132,7 +132,7 @@ static struct bpf_eth_cbh tx_cbh = {
 static __rte_always_inline void
 bpf_eth_cbi_inuse(struct bpf_eth_cbi *cbi)
 {
-	cbi->use = true;
+	rte_atomic_store_explicit(&cbi->use, true, rte_memory_order_relaxed);
 	/* make sure no store/load reordering could happen */
 	rte_smp_mb();
 }
@@ -145,7 +145,7 @@ bpf_eth_cbi_unuse(struct bpf_eth_cbi *cbi)
 {
 	/* make sure all previous loads are completed */
 	rte_smp_rmb();
-	cbi->use = false;
+	rte_atomic_store_explicit(&cbi->use, false, rte_memory_order_relaxed);
 }
 
 /*
@@ -158,7 +158,7 @@ bpf_eth_cbi_wait(const struct bpf_eth_cbi *cbi)
 	rte_smp_mb();
 
 	/* in use, busy wait till current RX/TX iteration is finished */
-	while (cbi->use)
+	while (rte_atomic_load_explicit(&cbi->use, rte_memory_order_relaxed))
 		rte_pause();
 }
 
-- 
2.43.0

