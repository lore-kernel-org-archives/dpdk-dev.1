Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19ABEC79FA0
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Sep 2026 18:32:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4FF6E40B9C;
	Mon,  7 Sep 2026 20:32:55 +0200 (CEST)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id EE04540B9C
 for <dev@dpdk.org>; Mon,  7 Sep 2026 20:32:53 +0200 (CEST)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2d71d1cc8b2so28460785ad.1
 for <dev@dpdk.org>; Mon, 07 Sep 2026 11:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788805973;
 x=1789410773; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j/eahn6hczDXo9taPoDZCLRrq0vQYm4mh/sGEZCD694=;
 b=hCt0axCU/RundWrT4TkOk97OFWKqtRP7IehsHpUzRrSiZdlL/QXY09FVEuyXOG+8uX
 sfrp9KnxojEa6vKhDmtd1At8Xuycc/CJz3mgDyKHcnWgcMW6xT4Uarp9vfc12Umj6nR8
 Irr+JDEqOFdLBqQ2HIOKpS7uYOF/+M1tlGS7k8UKxSXcvUO4nI5QnANsZFS0PR4Wb1cm
 Y6ns62tqZMmvoQxF05LoGySKM5CZ77/6+T37rRlTXhoIKwh1yCwT0HmrcvfF985zMx8H
 PoKP2VXsO2XyDvHor6UGJq59jGobngnLiZ6CkRIMsRUHkzezSduBXKphs8lf94tn8Ugj
 KyRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788805973; x=1789410773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=j/eahn6hczDXo9taPoDZCLRrq0vQYm4mh/sGEZCD694=;
 b=o2XON8M7mESP1LZdvC4BaaQK5PUpZYeurut59gCtv/tcW8eGJviDgCDq5tpO9S1o7i
 6qQ8l5v3WFJTURQSSVMXB8wIy/X/AqfRquqRfgO4i+HeCDwx2VBfiUWz6O9kZQbP8Izd
 pIfeZn12oAOIfmTbrX+03klI+6vE/kNIx5XmaEUSOj6+CiGBZKbCylFl8SKxZm9LZXhm
 L5RT0NspwLqNm5bdjmbT19uOYVgmfjypv+2SdGqVnwIOv8t1A3OSsux+wGGA3oVdF5jA
 E/XuSJtyUS69YYIUg93zftLYq0M8dWDfE8T1w994xdFNG+jH5whj8inPClxkTTTpmEo5
 h+zA==
X-Gm-Message-State: AFuF++kt16qPXS1FXQRvmuXb8DJhGjWEC5QNHHioInokGaTgYsSSyYEN
 QJpN8FdpC7Lo74mMZBigYzwbuNtKKVg0sJbXZwIlGm8Q9yMF9pPJqzjdMOYuV3MOfPW/m/M8R/g
 ZEidc
X-Gm-Gg: AYBFou3LS+LAYXn3+GkPvvbJP23KHKCov6GI30ba6/CyObVYxvL/IScRaTzNhPV+8Df
 ByjtSasYc4tKiQNyN4PXot6VgN7mwN/+1iA2Q9a9ou0vveRiNN/30ErceQAeSma38xtsCb/mP/P
 Ia7crVuF43zu9puZ3QgJoFCYu/rW6hDE5a2wzcEnmwbfYJy6nAWGiPR8BubFzFYaG/kSlT+xHy1
 nmslyPTgmJM5pjViFlpeUcSSqMYY7YRd1EyJqde0MXr3X1xSZcfA2lX0fp4/Py9qBE5lyPF/FpL
 b8BCX78iTY1UftqGThqGQyqgpFknwfr2rAe0yP/tO7nIkHyzcmfEVLxIcETR3eRtreAefgZfEgA
 qBbNxfA5hnK5UPdhQ2BBTnNxPd8mpgtGpW2RoR8M2CNSJfPDkgrKe96WwPwYIsfae1IILymvk+x
 E5YSfQfI0qAmFDyvnRGiWY+DSWu7Wl5QT34vGqagtLLkRuvdp8jXf09z7p0P2MXNVARxK6mBqBn
 shaQeg2zSTwy23mWgVDqZPuFtg=
X-Received: by 2002:a17:903:3c47:b0:2db:eb5:47ea with SMTP id
 d9443c01a7336-2db12106896mr371956135ad.0.1788805972964; 
 Mon, 07 Sep 2026 11:32:52 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2db1495a0c0sm47590795ad.17.2026.09.07.11.32.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 11:32:52 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Cyril Chemparathy <cchemparathy@ezchip.com>,
 Olivier Matz <olivier.matz@6wind.com>
Subject: [PATCH v3 1/5] test: fix jhash 32 bit key type
Date: Mon,  7 Sep 2026 11:31:20 -0700
Message-ID: <20260907183239.629053-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907183239.629053-1-stephen@networkplumber.org>
References: <20260904220953.3105930-1-stephen@networkplumber.org>
 <20260907183239.629053-1-stephen@networkplumber.org>
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

