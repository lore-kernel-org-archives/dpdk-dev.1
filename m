Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E18FCA0EEB
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 Aug 2025 18:21:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 70FDF40E2A;
	Fri, 22 Aug 2025 20:21:27 +0200 (CEST)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53]) by mails.dpdk.org (Postfix) with ESMTP id 7F2FF40E2A
 for <dev@dpdk.org>; Fri, 22 Aug 2025 20:21:26 +0200 (CEST)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-3c6df24f128so228920f8f.3
 for <dev@dpdk.org>; Fri, 22 Aug 2025 11:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755886886;
 x=1756491686; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JIBgRCtyXT7kbDT60CFR48B8fpedFItX8rNTOSdwY6k=;
 b=2PfqjeIWPCkLe5wIsmU2l5VYTSua3f68vo4pSbF+95NhEoJeWp652CMcyC58yKl8Jw
 iFkudfvZ9dzCwaKDO8QE+o5VNrwSnsg45o3nvgX/zpHISWo/cnZrK03Pcry9SFR2SM9X
 2QvhQAzz5bOmFN2cLX6oCUAJTA0dgykEQeuy6mksZRZGP8l6+fRZwBj2XfXexQSvFI94
 QZxY/76v+eK/KMdXuNDTuu2VMYAAz0GBvVFjwzZBnTKp01EAcTmuBDNeHsWsWIRG/o2+
 4K2lgPRBoVgqDXG4/mEvx/CbQtsHBgtNCE2evlC8uyUYNnwbSF+oeu2PxTIRmBZAweVI
 FgUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755886886; x=1756491686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JIBgRCtyXT7kbDT60CFR48B8fpedFItX8rNTOSdwY6k=;
 b=iIq4W1G3vMDiQQIb8eplTVoizB1VYn97ipbL8RvLYnhFuWj9H6W+6MqGGzrLRMvYps
 DHLApShVxOM4tKjdL0in3AwpfPuyG7S0o1/riWJcRjItXYbtQX5YPT01b2J7Nf7PwHFr
 3cehWNfHBRr3LAPzb8rokK1gFn0JUvaOP9UQZZR0Wgo2MZStm3eUuaC9WV95RMqDYv0f
 KADBTG6TrBJs1d1AiYv2jo/10BA/GYWMFPxNEqY46eM5YCVwr5txxwfvMELvzTcCJp7R
 AKl4XYT5CaM3Kv22a+Rt6CwuhT6u6Dqz9qC3cAN7pCdhLOxNx7vm7kEKrdowaVVmURA2
 53ZA==
X-Gm-Message-State: AOJu0YwLizhbjpJc1PUiqizeeUHxHZD6lcLWmAG+QXBwNVmjQtLaz1qZ
 jJEN041BVnwEFxKZFFX7Kl3PNU7es1ZNQwVCONObXtYLyReIDMrB0EHLdocPEUNVGqAnRfYy6No
 829cq
X-Gm-Gg: ASbGnct4iOkRnfNESzzivi/tR+v6rVHlleDiWtgWlnpEnP5Uuhc9A4blHZiDGOuwvB2
 VMspK7zKp8BXznF5cKGmtiDIhow+oAMAwuhBrrVCnGrm5+97txOXuuJctGQTdtAhjel2z3wC0u7
 TWNMGyVbqNCI3ZomI3WkFMVUU/6tk6KK2gIaPNZPBbLAkizu6Zfac+Ir7wIN9JzqwHf8WHjOhgX
 U4QzWr++CblT+eDCYYbZWsbDLeBgS+IewIEFvgYO1U6r8BjIq8bVoETsedg3oe+1Va4ikzRzBBN
 VaCExL1AOwo+Be/8KRDB3bCwkwCAIfl4xWmtfuHm3INLkgM7AcZZR5GF+dQK4nl+iKrxXudzhy4
 ePY4g4zglIixdxlE0Fq7wF53ijWVUOicp96PU3VM0hVAMsRWhQ3tGSLXVE15Hpwx2jhLbldL6uk
 +K5nwcHvA=
X-Google-Smtp-Source: AGHT+IE2RvkqbwRZKYjlKr3/SaFpBkbfuR8Cem0qtL+VmtlMmB9b+kmmPCRDtk3D+YqsUtMsgttysg==
X-Received: by 2002:a05:6000:18a9:b0:3c5:374c:1265 with SMTP id
 ffacd0b85a97d-3c5db0ef49fmr3625239f8f.24.1755886886002; 
 Fri, 22 Aug 2025 11:21:26 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c711ca61d8sm376441f8f.61.2025.08.22.11.21.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Aug 2025 11:21:25 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v2 4/4] hash: add support for common small key sizes
Date: Fri, 22 Aug 2025 11:19:34 -0700
Message-ID: <20250822182110.27599-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250822182110.27599-1-stephen@networkplumber.org>
References: <20250821203646.133506-1-stephen@networkplumber.org>
 <20250822182110.27599-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add new compare functions for common small key sizes.

Bugzilla ID: 1775
Suggested-by: Morten Brørup <mb@smartsharesystems.com>
Reported-by: Mattias Rönnblom <mattias.ronnblom@ericsson.com>

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_hash.c       |   4 +-
 lib/hash/rte_cuckoo_hash.c | 100 +++++++++++++++++++++++++++++++++++++
 2 files changed, 103 insertions(+), 1 deletion(-)

diff --git a/app/test/test_hash.c b/app/test/test_hash.c
index 5791fd7f4c..24588a4a96 100644
--- a/app/test/test_hash.c
+++ b/app/test/test_hash.c
@@ -35,7 +35,9 @@
  */
 static rte_hash_function hashtest_funcs[] = {rte_jhash, rte_hash_crc};
 static uint32_t hashtest_initvals[] = {0};
-static uint32_t hashtest_key_lens[] = {0, 2, 4, 5, 6, 7, 8, 10, 11, 15, 16, 21, 31, 32, 33, 63, 64};
+static uint32_t hashtest_key_lens[] = {
+	0, 2, 3, 4, 5, 6, 7, 8, 10, 11, 12, 14, 15, 16, 21, 31, 32, 33, 63, 64
+};
 #define MAX_KEYSIZE 64
 /******************************************************************************/
 #define LOCAL_FBK_HASH_ENTRIES_MAX (1 << 15)
diff --git a/lib/hash/rte_cuckoo_hash.c b/lib/hash/rte_cuckoo_hash.c
index 199cb62bf0..04a2623cba 100644
--- a/lib/hash/rte_cuckoo_hash.c
+++ b/lib/hash/rte_cuckoo_hash.c
@@ -50,6 +50,15 @@ RTE_LOG_REGISTER_DEFAULT(hash_logtype, INFO);
  */
 enum cmp_jump_table_case {
 	KEY_CUSTOM = 0,
+	KEY_2_BYTES,
+	KEY_3_BYTES,
+	KEY_4_BYTES,
+	KEY_5_BYTES,
+	KEY_6_BYTES,
+	KEY_8_BYTES,
+	KEY_10_BYTES,
+	KEY_12_BYTES,
+	KEY_14_BYTES,
 	KEY_16_BYTES,
 	KEY_32_BYTES,
 	KEY_48_BYTES,
@@ -85,6 +94,88 @@ enum cmp_jump_table_case {
 #include "rte_cmp_generic.h"
 #endif
 
+static inline int
+rte_hash_k2_cmp_eq(const void *key1, const void *key2, size_t key_len __rte_unused)
+{
+	const uint16_t *k1 = key1;
+	const unaligned_uint16_t *k2 = key2;
+
+	return k1[0] ^ k2[0];
+}
+
+static int
+rte_hash_k3_cmp_eq(const void *key1, const void *key2, size_t key_len)
+{
+	return rte_hash_k2_cmp_eq(key1, key2, key_len)
+		| (((const uint8_t *)key1)[2] ^ ((const uint8_t *)key2)[2]);
+}
+
+static int
+rte_hash_k4_cmp_eq(const void *key1, const void *key2, size_t key_len __rte_unused)
+{
+	const uint32_t *k1 = key1;
+	const unaligned_uint32_t *k2 = key2;
+
+	return k1[0] ^ k2[0];
+}
+
+static int
+rte_hash_k5_cmp_eq(const void *key1, const void *key2, size_t key_len)
+{
+	return rte_hash_k4_cmp_eq(key1, key2, key_len) |
+		(((const uint8_t *)key1)[4] ^ ((const uint8_t *)key2)[4]);
+}
+
+static int
+rte_hash_k6_cmp_eq(const void *key1, const void *key2, size_t key_len __rte_unused)
+{
+	const uint16_t *k1 = key1;
+	const unaligned_uint16_t *k2 = key2;
+
+	return (k1[0] ^ k2[0]) | (k1[1] ^ k2[1]) | (k1[2] ^ k2[2]);
+}
+
+static int
+rte_hash_k8_cmp_eq(const void *key1, const void *key2, size_t key_len __rte_unused)
+{
+#ifdef RTE_ARCH_64
+	const uint64_t *k1 = key1;
+	const unaligned_uint64_t *k2 = key2;
+
+	return !!(k1[0] ^ k2[0]);
+#else
+	const uint32_t *k1 = key1;
+	const unaligned_uint32_t *k2 = key2;
+
+	return (k1[0] ^ k2[0]) | (k1[1] ^ k2[1]);
+#endif
+}
+
+static int
+rte_hash_k10_cmp_eq(const void *key1, const void *key2, size_t key_len)
+{
+	return rte_hash_k8_cmp_eq(key1, key2, key_len) |
+		rte_hash_k2_cmp_eq((const uint8_t *)key1 + 8,
+				   (const uint8_t *)key2 + 8, key_len);
+}
+
+static int
+rte_hash_k12_cmp_eq(const void *key1, const void *key2, size_t key_len __rte_unused)
+{
+	const uint32_t *k1 = key1;
+	const unaligned_uint32_t *k2 = key2;
+
+	return (k1[0] ^ k2[0]) | (k1[1] ^ k2[1]) | (k1[2] ^ k2[2]);
+}
+
+static int
+rte_hash_k14_cmp_eq(const void *key1, const void *key2, size_t key_len __rte_unused)
+{
+	return rte_hash_k8_cmp_eq(key1, key2, key_len) |
+		rte_hash_k6_cmp_eq((const uint8_t *)key1 + 8,
+				   (const uint8_t *)key2 + 8, key_len);
+}
+
 static int
 rte_hash_k48_cmp_eq(const void *key1, const void *key2, size_t key_len)
 {
@@ -226,6 +317,15 @@ void rte_hash_set_cmp_func(struct rte_hash *h, rte_hash_cmp_eq_t func)
  */
 static const rte_hash_cmp_eq_t cmp_jump_table[NUM_KEY_CMP_CASES] = {
 	[KEY_CUSTOM] = NULL,
+	[KEY_2_BYTES] = rte_hash_k2_cmp_eq,
+	[KEY_3_BYTES] = rte_hash_k3_cmp_eq,
+	[KEY_4_BYTES] = rte_hash_k4_cmp_eq,
+	[KEY_5_BYTES] = rte_hash_k5_cmp_eq,
+	[KEY_6_BYTES] = rte_hash_k6_cmp_eq,
+	[KEY_8_BYTES] = rte_hash_k8_cmp_eq,
+	[KEY_10_BYTES] = rte_hash_k10_cmp_eq,
+	[KEY_12_BYTES] = rte_hash_k12_cmp_eq,
+	[KEY_14_BYTES] = rte_hash_k14_cmp_eq,
 	[KEY_16_BYTES] = rte_hash_k16_cmp_eq,
 	[KEY_32_BYTES] = rte_hash_k32_cmp_eq,
 	[KEY_48_BYTES] = rte_hash_k48_cmp_eq,
-- 
2.47.2

