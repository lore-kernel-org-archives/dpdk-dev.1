Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839BFFD2D84
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 13:35:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 943C3402DC;
	Tue, 10 Mar 2026 14:35:36 +0100 (CET)
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com
 [209.85.210.195])
 by mails.dpdk.org (Postfix) with ESMTP id 71F15402BA
 for <dev@dpdk.org>; Tue, 10 Mar 2026 14:35:35 +0100 (CET)
Received: by mail-pf1-f195.google.com with SMTP id
 d2e1a72fcca58-82735a41920so4776314b3a.2
 for <dev@dpdk.org>; Tue, 10 Mar 2026 06:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773149734; x=1773754534; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YuboJcMiaty0c2AWsRuJtO+85mtUbcZjnZPsFtsh7L8=;
 b=lpGMqVxdeIVScWNpl96PqdzuUh5lLvVCH1XAgG90ZpBgfg7WsBqXKfJ12jrK5sunRO
 r7ELjVqf4bXDvMW28AEcSi+9SxU7nt6PfCljaHCRo3rl9N5XC4kTVF3nQgw3F75IyMua
 yc7irGNPVHgEbFwIsWOeisvnJbfl7VZhlwd8+xTHiKWeNktMu+8KTQYXFtrybEpJ7fwS
 pG+qQHqmXpRsRQcDy/nsFdLbvemvuDRzQG07U+5iMM6e+2hnhY4HZEKXRujWh0bQsHuy
 phL13tk1hDLA/mJNnXkYjYDOnjgZRcICdwNuNk35jRyQKtF+MnLDUrT21NEqIQQ1jEbZ
 75VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773149734; x=1773754534;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YuboJcMiaty0c2AWsRuJtO+85mtUbcZjnZPsFtsh7L8=;
 b=Tiqv7moXWE51nmSwShhLOfr7+CGd2s0v5uDb1XzPg8uhmAaUNyK4Kgv3oGbgR05MeK
 9oK2IcvjjAWKCO4HyxdKoPv3jebN/Gn8s8xV8rjgmZVIjKi44NoyJxAJ5b5Dkjj7z7id
 Oau5q/CCLbWjMySA/o4n9itV6nnDv5DCVi/JzQkjHrd9tIDM2gj/tAJIm1G5U4d5zs1Q
 9PEyg0z34xRLxmPQ0NAYmJmFlKtZFNXBr3SOqVBl7OAGY/q06Wzr22d8Tky92LRd5HAW
 nPSO5owfyoZWDXVLSHWWTgLOKhyugnmZbvknLJ+jw0KZXxBIh76XqlbeU3l+4D2yr/GM
 WW3Q==
X-Gm-Message-State: AOJu0YxWxoE1x86EOFp29GLz8lSUCzihWfjll1dgpz3U5GRNd9qxAPQz
 ZnMJMD8ALYTq8Aw2wIlC7YCvcBXmZE0d4c7yqkntWnbHj2/QLts4yCGpUZ21B1nejPWRpsLNp7o
 =
X-Gm-Gg: ATEYQzxrC5Z1Ic8V6q5RX6ZF9Z5eMELapGniywwWIJAs07xfxxD4rkOJwEERdoVzN+6
 cPWEnkepJzwGbyFX6TFy/LExOd1ZY1vBOA/00VxFDJOo58xoTLMZLbcsqXm7fcNzxrthZWr8iNV
 4dc11Lfuih1cxbASOoQsE3h2ZO11QRPHClf6NxmL6xwMA2nQGHAK1kUHprLJGeODvHl48fXtf5c
 aG15dY9Wa01gpj+C6DEu6p0afiqlZROoZmN6zg+rhEQuHeFSUnxbq8C1C7WA8nbZYCJmWsHN4sP
 nARdWR/4d0g0pc4lIdd3Petoyf+V9lFxbQOF+xdPv6tjuZpNDAfJZ1syTY6X+LQV/H8DN2vGLaw
 ySvuZoqfbBriVGMx/nFdZcqEQZXfZugqeMmgUmQnIKAItKf9zQZCZ2NBHLEQ7q9m4U3v4mK4kk1
 qJEI3OnKe+mCgIxQ5weNwgPBQCRibyNj1vPAtmtVOEQQXCQLD0Y145
X-Received: by 2002:a05:6a00:2d1e:b0:827:3845:921 with SMTP id
 d2e1a72fcca58-829a2e16119mr12023959b3a.27.1773149734212; 
 Tue, 10 Mar 2026 06:35:34 -0700 (PDT)
Received: from localhost.localdomain ([218.2.114.155])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-829a48a249bsm13747829b3a.44.2026.03.10.06.35.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 06:35:33 -0700 (PDT)
From: dangshiwei <1138222970gg@gmail.com>
To: dev@dpdk.org
Cc: stanislaw.kardach@gmail.com, sunyuechi@iscas.ac.cn,
 stephen@networkplumber.org, david.marchand@redhat.com,
 dangshiwei <1138222970gg@gmail.com>
Subject: [PATCH] eal/riscv: implement prefetch using __builtin_prefetch
Date: Tue, 10 Mar 2026 21:35:24 +0800
Message-ID: <20260310133524.28087-1-1138222970gg@gmail.com>
X-Mailer: git-send-email 2.43.0
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

RISC-V currently has no-op implementations of the rte_prefetch*
functions. Use __builtin_prefetch() to allow the compiler to emit
Zicbop prefetch instructions when the target supports them (GCC
13.1+, Clang 17.0.1+ with -march=rv*_zicbop).

The Zicbop extension has no cache-level hints, so rte_prefetch1()
and rte_prefetch2() fall back to rte_prefetch0(). The volatile
qualifier is stripped via uintptr_t cast to satisfy
__builtin_prefetch()'s const void * parameter without triggering
-Wdiscarded-qualifiers.

This replaces the abandoned v1 series by Daniel Gregory
(Message-ID: 20240530171948.19763-1-daniel.gregory@bytedance.com)
addressing reviewer feedback from Kardach and Hemminger.

Signed-off-by: dangshiwei <1138222970gg@gmail.com>
---
 lib/eal/riscv/include/rte_prefetch.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/lib/eal/riscv/include/rte_prefetch.h b/lib/eal/riscv/include/rte_prefetch.h
index 42146491ea..37b4787387 100644
--- a/lib/eal/riscv/include/rte_prefetch.h
+++ b/lib/eal/riscv/include/rte_prefetch.h
@@ -18,22 +18,24 @@ extern "C" {
 
 static inline void rte_prefetch0(const volatile void *p)
 {
-	RTE_SET_USED(p);
+	__builtin_prefetch((const void *)(uintptr_t)p);
 }
 
 static inline void rte_prefetch1(const volatile void *p)
 {
-	RTE_SET_USED(p);
+	/* Zicbop has no cache-level hints, fallback to rte_prefetch0 */
+	rte_prefetch0(p);
 }
 
 static inline void rte_prefetch2(const volatile void *p)
 {
-	RTE_SET_USED(p);
+	/* Zicbop has no cache-level hints, fallback to rte_prefetch0 */
+	rte_prefetch0(p);
 }
 
 static inline void rte_prefetch_non_temporal(const volatile void *p)
 {
-	/* non-temporal version not available, fallback to rte_prefetch0 */
+	/* Zicbop has no non-temporal hint, fallback to rte_prefetch0 */
 	rte_prefetch0(p);
 }
 
-- 
2.43.0

