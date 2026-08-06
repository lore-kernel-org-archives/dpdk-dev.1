Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6FEC55838
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 03:27:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0DD9940DCD;
	Thu,  6 Aug 2026 05:26:10 +0200 (CEST)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTP id 0B0C140B98
 for <dev@dpdk.org>; Thu,  6 Aug 2026 05:26:07 +0200 (CEST)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2caf228a910so14022395ad.2
 for <dev@dpdk.org>; Wed, 05 Aug 2026 20:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785986766;
 x=1786591566; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6PRy5DSZWrUEm1puapX/kApNyr9qmMUE0sk+z5fe17g=;
 b=TjogWiEfyASNKA4ej67xeZaa8+6OckT7cWQEc4uegsaAeGtShNOoSsNmnWgSsJzmGo
 GnuixCCTRkOa0+uUXiBT3GziQJHXpEoEwK9sSm0qk4qtR0XF9pkEtBwNkp5Qr2oLJTXC
 k0xdCwOqnWPWBc5mRzG29Otfw8tbt4QMhMHjwEBr7z05GzOhU7vBJE68PZh60idurNUS
 jkQ70meQHayEOqohFH552vJSkdkZKYTPYE+/td68iuazGI43qQhLXcGPDV2SLMmB6Rw1
 PnyG8BOP3pzYm81t5noNA+InhBsOBGtZQ2MukJ81LYBYhncix7SmXhCTSxyPGnqqWT2Y
 VJzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785986766; x=1786591566;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6PRy5DSZWrUEm1puapX/kApNyr9qmMUE0sk+z5fe17g=;
 b=Jjvx84gxWFIACpzojOG5jb/6HgseuXQzniqJeGm/3TsHDLy3399vF3rQYqO7G514ER
 HpFJyj5DpAzewiHnEZw3qEcmPvgm8xZ2caxzFlP0RTnZcWEs1IDxPGnXdV4RMSaRJvu6
 P4AthpKAndmxjBPw4hNXrx9UCZNw5+zOpw8unQTGt8BtAVbnCk1Vj2Z5a7CU6tIndYih
 vyv7Ieaq1jnbNsGF57DrPapOsyNCOZNpAMewl2PP996WgetUFresfJNKn7zNRsmVJTgz
 NDMq12SXnwG/6jVvvLgjDP76gXIjTePydOnX6hwfT/I35sKCKnEtLQLaU+cDieddhbtW
 COlA==
X-Gm-Message-State: AOJu0YwxA+fPKRWheQYZBoCRoh9qcq4IMwqLiFhNr8ZPNvWcMAAUPI2h
 spYTh2tOLrAvWJkYVpBtD5nxPhoImz+NFqkOB6qv5QdCFkDjm6qtTIKD+3D6+RW5M9W5q2D4iVk
 SnpP4DtA=
X-Gm-Gg: AR+sD102XAloaPGJ72IuIG13l6BVp99nY0HmXnqsJq99ynl4ol7I9CvkqVgT1mGj7ie
 llyQndLr2gtYrqHfzd251C0QiiDWpWBRIaSL7Ly1rDogjCN+K4KW89VwF7EVgQBFVGu1PxoR8jK
 UK+wSP89WgSuNZE3fV7WGdyOdidzumpEe8651msr2NnJmH7UIzEtsudSsgEM7lGHRVYqQhZ8zAt
 elP2JgnR34Q3BsXzyEEafZ+BC8Gi3Mi85AtNAdPLo7nFJD8FOh8YCQjMyysuRKyA5tTeCJAXVe8
 w8v+ia12D3wYs/sy+v6hd0vhsoH7kHcsJukSfnBHYjhbwsAQUzIbL16UWATQCNanDPX6NymRx9j
 wGP7A/8JPnKss8S18PfYSYTMVlEXdSr2xQrNiT3VKHUg3oHSFVDxfG04jJmiV76COJ+2IOSCUaH
 yx4yH/FtNUeRV8GYuITJI3WUuAFV/TW772gzbQ80eMw0CKVGJGMWcANIX0OATyBYY6F+h62PkIA
 d6DZGRJSxDBdpASGFsSOiFJ5YE=
X-Received: by 2002:a05:6a20:da12:b0:3b4:75c0:3ec0 with SMTP id
 adf61e73a8af0-3cb85ea6f79mr13372082637.30.1785986766233; 
 Wed, 05 Aug 2026 20:26:06 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315863b0c61sm23301631eec.6.2026.08.05.20.26.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 20:26:05 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v7 17/24] bus/fslmc: replace rte_atomic32 with stdatomic
Date: Wed,  5 Aug 2026 20:23:09 -0700
Message-ID: <20260806032544.21337-18-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806032544.21337-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260806032544.21337-1-stephen@networkplumber.org>
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

The atomic wrappers here are easily converted to stdatomic.
Drop any unused macros.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/bus/fslmc/qbman/include/compat.h | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/bus/fslmc/qbman/include/compat.h b/drivers/bus/fslmc/qbman/include/compat.h
index 5a57bd8ed1..8f372996cc 100644
--- a/drivers/bus/fslmc/qbman/include/compat.h
+++ b/drivers/bus/fslmc/qbman/include/compat.h
@@ -81,18 +81,10 @@ do { \
 
 #define dma_wmb()		rte_io_wmb()
 
-#define atomic_t                rte_atomic32_t
-#define atomic_read(v)          rte_atomic32_read(v)
-#define atomic_set(v, i)        rte_atomic32_set(v, i)
+typedef RTE_ATOMIC(uint32_t) atomic_t;
 
-#define atomic_inc(v)           rte_atomic32_add(v, 1)
-#define atomic_dec(v)           rte_atomic32_sub(v, 1)
-
-#define atomic_inc_and_test(v)  rte_atomic32_inc_and_test(v)
-#define atomic_dec_and_test(v)  rte_atomic32_dec_and_test(v)
-
-#define atomic_inc_return(v)    rte_atomic32_add_return(v, 1)
-#define atomic_dec_return(v)    rte_atomic32_sub_return(v, 1)
-#define atomic_sub_and_test(i, v) (rte_atomic32_sub_return(v, i) == 0)
+#define atomic_set(v, i)        rte_atomic_store_explicit((v), (i), rte_memory_order_relaxed)
+#define atomic_inc(v)           ((void)rte_atomic_fetch_add_explicit((v), 1, rte_memory_order_seq_cst))
+#define atomic_dec_and_test(v)  (rte_atomic_fetch_sub_explicit((v), 1, rte_memory_order_seq_cst) == 1)
 
 #endif /* HEADER_COMPAT_H */
-- 
2.53.0

