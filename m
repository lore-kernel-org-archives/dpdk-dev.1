Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BF5C79F8C
	for <dpdk-dev@archiver.kernel.org>; Sun,  6 Sep 2026 17:12:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D7F6E402B9;
	Sun,  6 Sep 2026 19:11:58 +0200 (CEST)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by mails.dpdk.org (Postfix) with ESMTP id E24CE4026D
 for <dev@dpdk.org>; Sun,  6 Sep 2026 19:11:56 +0200 (CEST)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-85339ed040aso2053813b3a.1
 for <dev@dpdk.org>; Sun, 06 Sep 2026 10:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788714716;
 x=1789319516; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j/eahn6hczDXo9taPoDZCLRrq0vQYm4mh/sGEZCD694=;
 b=PADAhigGQQKjniOAwm+PQ7pljIEoihg0yU2o5wcx6B4bkx04JIyX+zgeQtetZgd6Wj
 oWQ+FNaTeJjcVwkqTjsCDUeyAOmSS1KHccGBHZd46bUtCBaKEgyhjHag9j6nm/sY/Kz0
 zijO/HMJLyrlTbEX9K+7OE7aPLjGdztPwgnK2GmnOzhMb3B3sBQEWn2CAquM8Td07BjT
 5nmGQrKGPnE2wLLOrvO3ZF74aCZ+lR+Qmn/rABHQaY8Ui2NJVB4QyziLEL8+OP/N6l6V
 dFtZHfUmmc6sMaW55ZEOJC62dTmqWW+1k8KbRh4CspeNXVPhmGFPMwljCQi14sLSISAL
 rSWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788714716; x=1789319516;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=j/eahn6hczDXo9taPoDZCLRrq0vQYm4mh/sGEZCD694=;
 b=drfFSCk/TQQCCElyKiayhkeG5ZbuUpgMW4CzY4CYGlvb0jlNmDY9atgjLaQpq4PgLE
 2eeISDTeLafBfeSnPtAk/k6EEmQSeC4Fsua/Rp2/UEp083/+ZDpP/xT+C+JSAE5QnlD9
 rV1qEZOiwCSgzn1SQaUYhlU5cbkuUMlHCAS0p0fd0FIOFOg3QYE8Us1rk6Q7Umyxnz1a
 HWB4W0UaoxW9chkucUO2SC8CxIUoS5cokVPeARAIE9WJOXUO+yRWKu4i4wJbUfgX5YNi
 MaA4fPPx/hyx/kjC9wVarasLZpTCLFfJuGT2+IhshL8KpUQ0Th5xG4a6ZUHJiRuGwY00
 j1OA==
X-Gm-Message-State: AFuF++llOPMzBOinxKAGYUl2itReqDVheXPTab3NkiFSFzAYBThaRRlG
 2GdFN8j8/Fcm7DjtX5ZYVLgTUvKrf3AxMZypUwd+tcu7mVAwMwNtvJYh2h1n7OYgPSXhem/JH4u
 HFLnn
X-Gm-Gg: AYBFou2fqZ4dzU3NZbkHtMjirh+gloCiUiAybest9jz7Fbdo8zwMB6w8sJIVsk+hUo0
 gkogQIrkhqDGttwPrb2aILtTwo9/4RkoERRSiLWRx+IVqYuIDHVHcLwKXkPCFjDq1CWYYVUjbu/
 ghES5GaunEmY/soEdk3hXJKelNuX0zk5dw4CwR1namwjzh4D62SZ67+X/JN2wAkwoKoAwoZ7heB
 vrvEAO6OlS0bNCABQZ2KJqJA5NTnE+gKdJ6Ht/Fa4vsc3W9ud4YNoS7GxwZIOrjSmo0Paj3KaBG
 nTAJZgDTt4K/JwBI68kug4oN6GGH0QICYrySEGwmONVPehlqoqxS6S0Yp3SX1lGOzUt/LJIJGnq
 Cn7tfghMXpFqMgc1/Odo0iT61fXXYk8ZLbF3ESfJbWGAisFY96TMzkScF7533ESooySH3ajfQSP
 Qk+BB4JzgJQESklb6xmbj2Kz9EzsPGiLFkyQn4I7PZqPJcb18FlApS8R3qsK8c7CiZiHVX+xDFL
 /GwUZcFGqrFx7S0+B6jE4zLVKQ=
X-Received: by 2002:a05:6a00:32cf:b0:85f:ae00:9e68 with SMTP id
 d2e1a72fcca58-8616a065c6cmr27961660b3a.26.1788714715999; 
 Sun, 06 Sep 2026 10:11:55 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-86152f32447sm3309910b3a.38.2026.09.06.10.11.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 10:11:55 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Olivier Matz <olivier.matz@6wind.com>,
 Cyril Chemparathy <cchemparathy@ezchip.com>
Subject: [PATCH v2 1/5] test: fix jhash 32 bit key type
Date: Sun,  6 Sep 2026 10:09:54 -0700
Message-ID: <20260906171142.3503868-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260906171142.3503868-1-stephen@networkplumber.org>
References: <20260904220953.3105930-1-stephen@networkplumber.org>
 <20260906171142.3503868-1-stephen@networkplumber.org>
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

verify_jhash_32bits() declares the key as an array of bytes, then
casts it to unaligned_uint32_t * to pass to rte_jhash_32b(), which
takes a const uint32_t *. Clang reports:

  passing 1-byte aligned argument to 4-byte aligned parameter 1 of
  'rte_jhash_32b' may result in an unaligned pointer access
  [-Walign-mismatch]

This already happens on armv8 aarch32, where unaligned types have
alignment 1, and will happen everywhere once that is true on all
architectures.

Declare the key as an array of uint32_t and drop the cast.

Fixes: 7621d6a8d0bd ("eal: add and use unaligned integer types")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_hash_functions.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/app/test/test_hash_functions.c b/app/test/test_hash_functions.c
index 70820d1f19..fdff304d2b 100644
--- a/app/test/test_hash_functions.c
+++ b/app/test/test_hash_functions.c
@@ -185,12 +185,12 @@ verify_precalculated_hash_func_tests(void)
 static int
 verify_jhash_32bits(void)
 {
-	unsigned i, j;
-	uint8_t key[64];
+	unsigned int i, j;
+	uint32_t key[16];
 	uint32_t hash, hash32;
 
-	for (i = 0; i < 64; i++)
-		key[i] = rand() & 0xff;
+	for (i = 0; i < RTE_DIM(key); i++)
+		key[i] = (uint32_t) rte_rand();
 
 	for (i = 0; i < RTE_DIM(hashtest_key_lens); i++) {
 		for (j = 0; j < RTE_DIM(hashtest_initvals); j++) {
@@ -199,9 +199,9 @@ verify_jhash_32bits(void)
 				hash = rte_jhash(key, hashtest_key_lens[i],
 						hashtest_initvals[j]);
 				/* Divide key length by 4 in rte_jhash for 32 bits */
-				hash32 = rte_jhash_32b((const unaligned_uint32_t *)key,
-						hashtest_key_lens[i] >> 2,
-						hashtest_initvals[j]);
+				hash32 = rte_jhash_32b(key,
+						       hashtest_key_lens[i] / sizeof(uint32_t),
+						       hashtest_initvals[j]);
 				if (hash != hash32) {
 					printf("rte_jhash returns different value (0x%x)"
 					       "than rte_jhash_32b (0x%x)\n",
-- 
2.53.0

