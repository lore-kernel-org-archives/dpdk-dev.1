Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A5F5CAC598
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Sep 2025 15:03:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 31C9740696;
	Tue, 16 Sep 2025 17:02:39 +0200 (CEST)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com
 [209.85.160.173])
 by mails.dpdk.org (Postfix) with ESMTP id B5C6640677
 for <dev@dpdk.org>; Tue, 16 Sep 2025 17:02:37 +0200 (CEST)
Received: by mail-qt1-f173.google.com with SMTP id
 d75a77b69052e-4b7ae45a91cso9556471cf.2
 for <dev@dpdk.org>; Tue, 16 Sep 2025 08:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758034957;
 x=1758639757; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KKCihvnOrtetXNNO9zEzEWC7Yu5B0adghpblwmkOte8=;
 b=ixkPxoPxQw7nrZPbubCtPcPsjY93MTiX4b+z8RCs1bnsyWyb+TbPuAJNSykzY+oo5/
 t2BvXglVoXV2ArCYd9hTvwKBfVWM54rdY5Tqc2yN2O3kVSpCbnf0TFgTUXNZoys0Zs8V
 WUOv0hPDl74HehontKbj1RsP6nNOtogOYeZ4fs4ObbonBNQON3ymZBVSFaV1yFrmhOSO
 ic9slbnbq97OAA8v92HIYvmRMOfE9Qqr6rhNpXbtiIQxR8nGxCA9mGj1IyJ2JbPt/zGD
 bw0J7oidksvEsinPiQLIn0QShBw+P7iol8tH8cUhRBzXNuTDboLDBGiNMQKiGCq6SQj/
 ZlxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758034957; x=1758639757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KKCihvnOrtetXNNO9zEzEWC7Yu5B0adghpblwmkOte8=;
 b=lWluCIcBWe8pWDbsSao83xbEbhRK6YuzeelAZP3LAqz8vA9pUqdpnMakYYMo9WJZDl
 VB6vhYE73enzusN/DIbyCVxVnZ0VMgHqqGFR2LL22NCZOeOWEk0HCHAGATmStcUmIVqz
 I0s71+/lGMSjxZ/pdjLB3WsRgky1EK8u2eBDVWtRjnqymz6tNULA0Lp732+k6MQbcHWf
 xCia52/z/6RS+PGf62IfdBLou30stmxA0b2fag7CGS7OY+FSYLr8WKF+Pek8luV6v8Gx
 Ipebcj/GO8iN/d6NCOig9RSMxTZqIbL6oGx2xbD5hROF8YU5LzjS9FZHyFm5MN4UucON
 TH1Q==
X-Gm-Message-State: AOJu0YxI8gB9e4qF42i2x/2gDlyk1+BLqEEN1zR9bDVqpyMAW7dqjAF9
 SEJ4lU+CpKWvm0WbuxNqdhUl1AyqqR+6FArzZjacFXDNgl62chce/DN/h3J8R1aRBDP7IjUqvly
 rzTUX
X-Gm-Gg: ASbGncvgpIRsU1qyx4r4JX8C4VDQRgRkHxoAWd7LiFUlykOqEmb+aU5KJHV/YkthcGT
 t1VE560yaqI/hiWv8D/45NvOS6d9F7TrMm2+L7C2PItsGaJ+liVL+sgP1LR+UVjkn2Ufg8n6/lE
 P+zCpmd+Z4MGWwmV3+U5ev50slvk5HskZUw+CeY92MkPIgGgNyYFCBNX6w9MQKLREKqYRVwypC3
 oo9n6FO7PdxQm9sJgcw1X3pVoxNe4XkGtWoteXJuKngahE6ssVRFlhW/P6nxPqNe6yHncKDj19W
 oDAXNUf/cgpZTC5duqGgo+JJABBU5bGAV1JYpRzSTvg3Nd+ZOx5TRUlBIqVwSSr7KcSXZBMn6cR
 I1az+GuJT2I8wy7jW8gey97XsSzdhG8ihLaNaLu2DbIqD1kZFYkNUMwznK7fVnfIt7qFqJSOK
X-Google-Smtp-Source: AGHT+IEG4dcAT5CZPXbwsznS0s0iVtsWyfYvtlf92LiQud95zVsX+xK4rrQLSbv19h+SKTCN+5Fjlg==
X-Received: by 2002:a05:622a:612:b0:4b7:976e:8c48 with SMTP id
 d75a77b69052e-4b7976e96bcmr118985431cf.14.1758034956699; 
 Tue, 16 Sep 2025 08:02:36 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-763bee7c80dsm94324306d6.52.2025.09.16.08.02.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 08:02:36 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v4 4/4] hash: add support for common small key sizes
Date: Tue, 16 Sep 2025 08:00:47 -0700
Message-ID: <20250916150219.104936-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250916150219.104936-1-stephen@networkplumber.org>
References: <0250818233102.180207-1-stephen@networkplumber.org>
 <20250916150219.104936-1-stephen@networkplumber.org>
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

Fill in more key sizes to ensure more complete coverage of
special cases.

Bugzilla ID: 1775
Suggested-by: Morten Brørup <mb@smartsharesystems.com>
Reported-by: Mattias Rönnblom <mattias.ronnblom@ericsson.com>

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Morten Brørup <mb@smartsharesystems.com>
---
 app/test/test_hash.c       |   7 ++-
 lib/hash/rte_cuckoo_hash.c | 124 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 126 insertions(+), 5 deletions(-)

diff --git a/app/test/test_hash.c b/app/test/test_hash.c
index 5791fd7f4c..fa6c254a23 100644
--- a/app/test/test_hash.c
+++ b/app/test/test_hash.c
@@ -35,8 +35,11 @@
  */
 static rte_hash_function hashtest_funcs[] = {rte_jhash, rte_hash_crc};
 static uint32_t hashtest_initvals[] = {0};
-static uint32_t hashtest_key_lens[] = {0, 2, 4, 5, 6, 7, 8, 10, 11, 15, 16, 21, 31, 32, 33, 63, 64};
-#define MAX_KEYSIZE 64
+static uint32_t hashtest_key_lens[] = {
+	0, 2, 3, 4, 5, 6, 7, 8, 10, 11, 12, 14, 15, 16, 18, 20,
+	21, 31, 32, 33, 36, 48, 63, 64, 80, 96, 112, 128, 254
+};
+#define MAX_KEYSIZE 256
 /******************************************************************************/
 #define LOCAL_FBK_HASH_ENTRIES_MAX (1 << 15)
 
diff --git a/lib/hash/rte_cuckoo_hash.c b/lib/hash/rte_cuckoo_hash.c
index 608d79d33d..982fa1deee 100644
--- a/lib/hash/rte_cuckoo_hash.c
+++ b/lib/hash/rte_cuckoo_hash.c
@@ -50,8 +50,19 @@ RTE_LOG_REGISTER_DEFAULT(hash_logtype, INFO);
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
+	KEY_20_BYTES,
 	KEY_32_BYTES,
+	KEY_36_BYTES,
 	KEY_48_BYTES,
 	KEY_64_BYTES,
 	KEY_80_BYTES,
@@ -85,12 +96,108 @@ enum cmp_jump_table_case {
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
 static int
-rte_hash_k48_cmp_eq(const void *key1, const void *key2, size_t key_len)
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
+static int
+rte_hash_k20_cmp_eq(const void *key1, const void *key2, size_t key_len __rte_unused)
 {
 	return rte_hash_k16_cmp_eq(key1, key2, key_len) |
-		rte_hash_k16_cmp_eq((const uint8_t *) key1 + 16,
-				    (const uint8_t *) key2 + 16, key_len) ||
+		rte_hash_k4_cmp_eq((const uint8_t *)key1 + 16,
+				   (const uint8_t *)key2 + 16, key_len);
+}
+
+static int
+rte_hash_k36_cmp_eq(const void *key1, const void *key2, size_t key_len __rte_unused)
+{
+	return rte_hash_k32_cmp_eq(key1, key2, key_len) ||
+		rte_hash_k4_cmp_eq((const uint8_t *)key1 + 32,
+				   (const uint8_t *)key2 + 32, key_len);
+}
+
+static int
+rte_hash_k48_cmp_eq(const void *key1, const void *key2, size_t key_len)
+{
+	return	rte_hash_k32_cmp_eq(key1, key2, key_len) ||
 		rte_hash_k16_cmp_eq((const uint8_t *) key1 + 32,
 				    (const uint8_t *) key2 + 32, key_len);
 }
@@ -226,8 +333,19 @@ void rte_hash_set_cmp_func(struct rte_hash *h, rte_hash_cmp_eq_t func)
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
+	[KEY_20_BYTES] = rte_hash_k20_cmp_eq,
 	[KEY_32_BYTES] = rte_hash_k32_cmp_eq,
+	[KEY_36_BYTES] = rte_hash_k36_cmp_eq,
 	[KEY_48_BYTES] = rte_hash_k48_cmp_eq,
 	[KEY_64_BYTES] = rte_hash_k64_cmp_eq,
 	[KEY_80_BYTES] = rte_hash_k80_cmp_eq,
-- 
2.47.3

