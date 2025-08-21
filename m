Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6BFCA0EEB
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 Aug 2025 20:37:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C08E740664;
	Thu, 21 Aug 2025 22:37:02 +0200 (CEST)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46]) by mails.dpdk.org (Postfix) with ESMTP id 6D46F40664
 for <dev@dpdk.org>; Thu, 21 Aug 2025 22:37:01 +0200 (CEST)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-45a1b00e4a1so12191715e9.0
 for <dev@dpdk.org>; Thu, 21 Aug 2025 13:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755808621;
 x=1756413421; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1bd6GGNP/ZuBKkgmc39EltIqujMqA6Xip1wIA03zwiU=;
 b=247GGbkEhe2UtZ6wGQJaAYaF/1YypDyy6EipajFs9DhxCZ1zCwm2u/RgC6l/qO86w1
 kiv4akwtTU6rk81M/cJPLPiwrCbjnxB1bTCNnt1rDPEE9XQWEmykuW/ztE7yTB5ke1H2
 t+sCe5nyV6H7kuH9yYZMjJ5zJtwP2Uh8VJFp8weExWvDe3ttvLwxJ8br7ljYaDYGUJrj
 TWPSPb8MQ0H/rbouT30qYt0et2/qgkhdbaLnELcaEw3ZSJ1wWUXyZV8jvJYQvdt0ic6l
 XXvoDQ3QN/nEQQZI2RoFrvriKrI9K2bpigEKzl1g/Pk0hEs/38duQIhwvLyp7cXfur8O
 Eqvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755808621; x=1756413421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1bd6GGNP/ZuBKkgmc39EltIqujMqA6Xip1wIA03zwiU=;
 b=B8Ub++ST+vA3f6vYy1wrhDA9HIMapUNPYRb8zKoJwmtWRbigYthOZyKux1D2zZad2a
 qYOdmPLzBS07looZVVZJR3YfjQ0rBERNbeULmOe1kaL0d04r4YpQeOIEFGl1p3ZbibvP
 pGSZpsbCF6he/hyJwQcPaZs1hckKGFUJpa6ivDdDhy0VmGj/zfVZRI4HbLfYJg949KnC
 PF1h2wwm8Vaushikm8GH0fj8Hd0tYJyjm2Vy70k3XO0s/Sf95Lbb6M3dy48lGapjA35U
 1+n0NzU+4N0ZQgpw8vaZItBOzHuOF0nt59yiRVGamf7U/5+Mlz29xyGOzZXaEJNanB70
 moQg==
X-Gm-Message-State: AOJu0YyY9X+WCz9xj+ppGDQ3UGCX7yiDG62dXdPRulq1NCzKR0qhrMzx
 gqvKWyaILihXsRBIhE2ViLDrXJOYXINEVNDxJQhOK9cNWCfyfR7cG2pi2ZhddXllq6ta67/hGdb
 kD0Nf
X-Gm-Gg: ASbGncuW6ugVHaV8JuiHxi/9ZC1K2TpaqosCocD09mJLeL+bwTn5gweLFiow96S4Tby
 RzaNCF3bQTXPIGkI/Zm6OEoy65oYrCySXCKJ4CeJ9KopFolSAj6kh1zusCwmBQPWi9COn3nSin1
 uq6+NAv2A9RG3GjHRjVDq0w6a3doNQDNLnNfBtnhxPDvbS5K9slBxMN98BI1f5TpJYGrur2ij5x
 psCw6iXSzLOocyjmVJIRFmHTzwsuc0Z0wtFaIDXAz/GR5fTPCR9M/Flr8FZGYiZuKJzK8t5JUY/
 v26MOIbk30oYuUTtcR5Bst1lJQW4gqrqL+viM5EgHAcXEXneZznS0oAztifQ0jeKeADK1JmSfA5
 w46VGR6EzCcAvcC6SNP4Q95ddAMgKdenmfuTo1+LVx7KWv0Gn/S47+4MzIAWDTT5fV/3yP0i5
X-Google-Smtp-Source: AGHT+IG01NQH5ycBHwWXw60Kzf7u5DqbAJKgFwDsQsWX5qFG7f7beVebXXoSBQy5i+Kx61U/SbkA6g==
X-Received: by 2002:a05:6000:2302:b0:3b8:fe01:cc29 with SMTP id
 ffacd0b85a97d-3c5dcb1154fmr194598f8f.45.1755808620518; 
 Thu, 21 Aug 2025 13:37:00 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b4e8de85bsm17962675e9.7.2025.08.21.13.36.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Aug 2025 13:37:00 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [RFC 3/3] hash: add support for common small key sizes
Date: Thu, 21 Aug 2025 13:35:10 -0700
Message-ID: <20250821203646.133506-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250821203646.133506-1-stephen@networkplumber.org>
References: <20250821203646.133506-1-stephen@networkplumber.org>
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
 lib/hash/rte_cuckoo_hash.c | 54 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/lib/hash/rte_cuckoo_hash.c b/lib/hash/rte_cuckoo_hash.c
index 3212695d92..825889c320 100644
--- a/lib/hash/rte_cuckoo_hash.c
+++ b/lib/hash/rte_cuckoo_hash.c
@@ -49,6 +49,11 @@ RTE_LOG_REGISTER_DEFAULT(hash_logtype, INFO);
  */
 enum cmp_jump_table_case {
 	KEY_CUSTOM = 0,
+	KEY_2_BYTES,
+	KEY_4_BYTES,
+	KEY_6_BYTES,
+	KEY_8_BYTES,
+	KEY_12_BYTES,
 	KEY_16_BYTES,
 	KEY_32_BYTES,
 	KEY_48_BYTES,
@@ -86,6 +91,50 @@ rte_hash_k32_cmp_eq(const void *key1, const void *key2, size_t key_len)
 }
 #endif
 
+static inline int
+rte_hash_k2_cmp_eq(const void *key1, const void *key2, size_t key_len __rte_unused)
+{
+	const uint16_t *k1 = key1;
+	const uint16_t *k2 = key2;
+
+	return k1[0] ^ k2[0];
+}
+
+static inline int
+rte_hash_k4_cmp_eq(const void *key1, const void *key2, size_t key_len __rte_unused)
+{
+	const uint32_t *k1 = key1;
+	const uint32_t *k2 = key2;
+
+	return k1[0] ^ k2[0];
+}
+
+static inline int
+rte_hash_k6_cmp_eq(const void *key1, const void *key2, size_t key_len __rte_unused)
+{
+	const uint16_t *k1 = key1;
+	const uint16_t *k2 = key2;
+
+	return (k1[0] ^ k2[0]) | (k1[1] ^ k2[1]) | (k1[2] ^ k2[2]);
+}
+
+static inline int
+rte_hash_k8_cmp_eq(const void *key1, const void *key2, size_t key_len __rte_unused)
+{
+	const uint64_t *k1 = key1;
+	const uint64_t *k2 = key2;
+
+	return k1[0] ^ k2[0];
+}
+
+static inline int
+rte_hash_k12_cmp_eq(const void *key1, const void *key2, size_t key_len __rte_unused)
+{
+	const uint32_t *k1 = key1;
+	const uint32_t *k2 = key2;
+
+	return (k1[0] ^ k2[0]) | (k1[1] ^ k2[1]) | (k1[2] ^ k2[2]);
+}
 
 static inline int
 rte_hash_k48_cmp_eq(const void *key1, const void *key2, size_t key_len)
@@ -228,6 +277,11 @@ void rte_hash_set_cmp_func(struct rte_hash *h, rte_hash_cmp_eq_t func)
  */
 static const rte_hash_cmp_eq_t cmp_jump_table[NUM_KEY_CMP_CASES] = {
 	[KEY_CUSTOM] = NULL,
+	[KEY_2_BYTES] = rte_hash_k2_cmp_eq,
+	[KEY_4_BYTES] = rte_hash_k4_cmp_eq,
+	[KEY_6_BYTES] = rte_hash_k6_cmp_eq,
+	[KEY_8_BYTES] = rte_hash_k8_cmp_eq,
+	[KEY_12_BYTES] = rte_hash_k12_cmp_eq,
 	[KEY_16_BYTES] = rte_hash_k16_cmp_eq,
 	[KEY_32_BYTES] = rte_hash_k32_cmp_eq,
 	[KEY_48_BYTES] = rte_hash_k48_cmp_eq,
-- 
2.47.2

