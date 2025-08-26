Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF7FCA0EFA
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 Aug 2025 14:49:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 556A940678;
	Tue, 26 Aug 2025 16:49:41 +0200 (CEST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id 987EC4066C
 for <dev@dpdk.org>; Tue, 26 Aug 2025 16:49:37 +0200 (CEST)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-45a1b05ac1eso31458575e9.1
 for <dev@dpdk.org>; Tue, 26 Aug 2025 07:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756219777;
 x=1756824577; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HyzSsbZ1JZ4RcYpw+rUes4Yw61LT4zIwG0gohClqABk=;
 b=0PaB3RvuKjoYrbg/szv9DcoyWJwc6nrzwsKMN89xH52JSb2wlf2pFIfmTrloJ80Roo
 FjaAb18X6E9IrdwkupsaBxUr7cF+/cUw5dQahggpSoV7VRKK4VSa8SZ8NXYKSPxvLK62
 kjnew1wVMtSWbJSMYh1MUN8/lQiCS/+sMrmwbMfI7n5hBwsWItwGFP10077y8HVhC3uf
 lBPEPKI845PbfOxj3p2yXyYzJqTb2AaBXXt4EiSEv3jq7L4Uph8HLrTT7dZhfi68MJyx
 XhbftP5Gwztpld/Nv/wM/5oN79Kpx34haOt6x4M81T4CbzhH6qNBU1CSWNh34YMhcWeJ
 LbWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756219777; x=1756824577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HyzSsbZ1JZ4RcYpw+rUes4Yw61LT4zIwG0gohClqABk=;
 b=cB12wdc5hWRydHF8qTs2Fs5CCJ1N0DHZnlt0LNqKfaLPXYUvbjNIep/a3QkDYyTjH2
 XZguceMOQJhse/44f/lMcP3wkkqY5VCk9ny98rbNsdV48X7GKn42rlKeQ4grWkkqPJ47
 GogrSnH4z6BrfatAZhT7WxNMN5yfQouM7x9D6d0RhOgMA0+bScZIJrn6bwKk4Wu1m6rF
 hF0JFdua+gO+BbvmgHpyiMuBA0mD3f6cacAdxK/kX77e3wclq9aIJHsUF3Jgm/bd7dDn
 MO7D4aPP9WM5qlAWLMISLsTgH2qOcBoFfQizeP0eOz05oRZ0G9ss8m4GIEwAqn+T00fk
 bkQg==
X-Gm-Message-State: AOJu0YzdV9q1ov3XfTg3cEzvRR0Q4yJR0kZYxneS070HrAfeE/a407LK
 8iLwfx7ra6Vn9gj8J+PLk96Klb6DEIwVNvcVwN3b6sYfwux+Pswfi+3e99jlDTEVlyGwtWPbu1k
 OjbRl
X-Gm-Gg: ASbGncsVlHWtavg4Tm28tLMILWWbnrVaIldAUPjQ8BaNTlA65/a7tTu00mKaSXS/Ynv
 yNez2PYVgd1mbQdYBrEZiUGfFdah7KsTOyu+rekA2482wp/Ot4ojYrRD0OHau47pIfap1xXidot
 JGiiS0tOXok8Hx3yXvErkV+V6J28wYy9JjRyOufCX/7/GQys34DyWVklQ26Ys99L1cNI5u22kUo
 xnJyPf4tB3OYA9IHcG5crwicPJqbzKYgERuk08ND7BpgbGKCmF1mo4JK1SRaTWhkRm/nF5R4ALl
 65VD8ZwlvsfWi9NBN+azH1vzNVBy7EePRUM+OOfoz77et9dsP2u6kQxj1jpW6YDzPVPS4E/rHhr
 oIVoVVTb+3zZJ5iICAICKLb+iDW9Hyjzv6Mu1QInHirUMxk4LXw8wcQeGjbwmuqdur0Ct/nif
X-Google-Smtp-Source: AGHT+IEfefxrfw6CnuBhl/W3DpgxZbXMo2vlqfxCYtWhOdNbDUW39trJ47WT0EY+oWL1LAzpZdInrw==
X-Received: by 2002:a05:600c:4f52:b0:458:bd31:2c27 with SMTP id
 5b1f17b1804b1-45b517cc0f9mr142116285e9.23.1756219777071; 
 Tue, 26 Aug 2025 07:49:37 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b57492459sm154566785e9.18.2025.08.26.07.49.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 07:49:36 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v3 4/4] hash: add support for common small key sizes
Date: Tue, 26 Aug 2025 07:48:31 -0700
Message-ID: <20250826144922.74010-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250826144922.74010-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20250826144922.74010-1-stephen@networkplumber.org>
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
index 608d79d33d..78398abb2d 100644
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
+	const unaligned_uint16_t *k1 = key1;
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
+	const unaligned_uint32_t *k1 = key1;
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
+	const unaligned_uint16_t *k1 = key1;
+	const unaligned_uint16_t *k2 = key2;
+
+	return (k1[0] ^ k2[0]) | (k1[1] ^ k2[1]) | (k1[2] ^ k2[2]);
+}
+
+static int
+rte_hash_k8_cmp_eq(const void *key1, const void *key2, size_t key_len __rte_unused)
+{
+#ifdef RTE_ARCH_64
+	const unaligned_uint64_t *k1 = key1;
+	const unaligned_uint64_t *k2 = key2;
+
+	return !!(k1[0] ^ k2[0]);
+#else
+	const unaligned_uint32_t *k1 = key1;
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
+	const unaligned_uint32_t *k1 = key1;
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

