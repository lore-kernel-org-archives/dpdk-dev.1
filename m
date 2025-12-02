Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48577D1171E
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Dec 2025 17:27:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B70B40663;
	Tue,  2 Dec 2025 18:26:41 +0100 (CET)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com
 [209.85.222.172])
 by mails.dpdk.org (Postfix) with ESMTP id B54F54065F
 for <dev@dpdk.org>; Tue,  2 Dec 2025 18:26:39 +0100 (CET)
Received: by mail-qk1-f172.google.com with SMTP id
 af79cd13be357-8b25dd7ab33so358876085a.1
 for <dev@dpdk.org>; Tue, 02 Dec 2025 09:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764696399;
 x=1765301199; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Has/LETgEaz2HfP7weAN6J2O4AHKOmIiAYP/WLr1Ec=;
 b=wsBTbdgBveww22kj7i5vFIgacr8gytOlSY3f9K4CNQDseL42jeJybbn9xETLDf6gzA
 SE2yXNJFMusZQiVkb4gqAYWyTgaksRNh6V4aSHiNdf4GV6wuCqvaXjoS0ePZcWhgG4iP
 1GitzbcgEJ332RuTc21yCHksxlcPqT+Xo1zoJ3vt9J5XYRHcwauJXxaZaoedF3SWfrMQ
 KVCQNP1lpraLvEFWI5c0svEdWTr7snu1eRTVRl19CNtgfeLNryGn/ds2ILNgtiUK4R7e
 LYpyrt7RLkU4aMuo2XjaAk1qUcNnUKSKgSUlGOzonmr95vLD/N5ORHyR0ylWKlHf+zDm
 tM0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764696399; x=1765301199;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2Has/LETgEaz2HfP7weAN6J2O4AHKOmIiAYP/WLr1Ec=;
 b=mlMDBt3NdX2P/H0cLvn9Nv0Mz3rVzIU3otoW8xWcC83XO8zgTfTx5pXAokzBqKccWr
 ViaziIZkeOzNQi8cAPmq/xBMFPP7Mxs3y66H5YuuaJProrFBGqAR2PhsOe/JZ03aqRVt
 JlX7HiPdBQsa84Z7Y+6sfF32zgUbZ5JPC6Y42TiwZNT3cIMwuLEUXhyDvzyS/8wAgJAC
 2RAahP5P05x9qjQVNizUWp+pltJBfbKGyAw+lLh0rpzpsbmNJKd2T0qnFzbp2ZWG8FQ4
 Q/UXT8I5dtUbZ4T1o9Jg4TdEAiuCdKRIHMKLKaxOZKMTC7Wgw43qgsnxYsAj+FGRoQYQ
 TNRg==
X-Gm-Message-State: AOJu0Yy238SdRuR5nlr0oQhGfTv7yhN6XIp0ME4zdX36Oszaqp95dAMP
 aJdAU7Lql7H0IamuM3uO6OaI4JB2BvgcFw5j9lfKS2NgUw89TkbiQrkFTEUs6I6y56bSlDoHqtT
 1H1Pe
X-Gm-Gg: ASbGncvzcb3DmayIDxTdfSLLxSajtzXUgLPCXGXEMDxpXNrF0n47adeTzragUFsHp3K
 B61vnfY9zOUgPxAtEx4a1xtABoEV+ByjJtDRvxCq7LOoJUN3OuBSpgAr1iFN9bnm6KUdXBV8ouK
 6p3J2Py6DC0EOVbu+H4kf5CrURFKfj1nhdThq1n6yZmhY9HcHUcOopE16iUaYHKFPKO7VccalnV
 eo++XO3bu5mmoCSRw4CPUsAb6IY2eYOAJIe3VrboaplGj7wlR3IaZCUpbUSWeQXBPJL3RLfFBce
 RX8JsBozov0L2wQVKkVYUnW1YUulE+LqxNIaOGniV3Z2XJ9DLsBjRvP1jEtf4qskTqhDeYetqlK
 uSSvtmo8rs9rr1Z+e9eQqNN4gEfKY6ebAT40gQXpussT1Bej2CfhPUvESrkS4wtvTyUBryKFT28
 Y6yuWN0cmaJTiOQqOFNsNRtUAYFHFK7ZsbZWo6MUKp+9iwpw/Pvg==
X-Google-Smtp-Source: AGHT+IGInRhmtEfaZu9UTrLrKKNO0rhN/UuCQbZDGCG9VlwAavQWPUO7ZAVhQ8JxN3F6SX1uwE97Jw==
X-Received: by 2002:a05:620a:1a02:b0:8b3:83b:6e9c with SMTP id
 af79cd13be357-8b4ebdc1d5fmr4105944585a.90.1764696398928; 
 Tue, 02 Dec 2025 09:26:38 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b52a1c8405sm1113724885a.38.2025.12.02.09.26.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Dec 2025 09:26:38 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Byron Marohn <byron.marohn@intel.com>, Yipeng Wang <yipeng1.wang@intel.com>
Subject: [RFC 6/8] efd: avoid overflowing ring name
Date: Tue,  2 Dec 2025 09:24:32 -0800
Message-ID: <20251202172626.283094-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251202172626.283094-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
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

The efd library allowed table name to be longer than would be
safe when prefix was added for a ring name.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/efd/rte_efd.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/lib/efd/rte_efd.c b/lib/efd/rte_efd.c
index ebf1e0655f..61fd6a6646 100644
--- a/lib/efd/rte_efd.c
+++ b/lib/efd/rte_efd.c
@@ -36,6 +36,9 @@ RTE_LOG_REGISTER_DEFAULT(efd_logtype, INFO);
 #define EFD_LOG(level, ...) \
 	RTE_LOG_LINE(level, EFD, "" __VA_ARGS__)
 
+/** Prefix used on ring name for hash */
+#define EFD_HASH_PREFIX "HT_"
+
 #define EFD_KEY(key_idx, table) (table->keys + ((key_idx) * table->key_len))
 /** Hash function used to determine chunk_id and bin_id for a group */
 #define EFD_HASH(key, table) \
@@ -527,6 +530,15 @@ rte_efd_create(const char *name, uint32_t max_num_rules, uint32_t key_len,
 		return NULL;
 	}
 
+	/*
+	 * The name is turned into a ring name which has a limit of
+	 * RTE_RING_NAMESIZE.
+	 */
+	if (name == NULL || strnlen(name, RTE_RING_NAMESIZE) >= RTE_RING_NAMESIZE - sizeof(EFD_HASH_PREFIX)) {
+		EFD_LOG(ERR, "Invalid name '%s'", name);
+		return NULL;
+	}
+
 	/*
 	 * Compute the minimum number of chunks (smallest power of 2)
 	 * that can hold all of the rules
@@ -698,7 +710,13 @@ rte_efd_create(const char *name, uint32_t max_num_rules, uint32_t key_len,
 	TAILQ_INSERT_TAIL(efd_list, te, next);
 	rte_mcfg_tailq_write_unlock();
 
-	snprintf(ring_name, sizeof(ring_name), "HT_%s", table->name);
+	int cc = snprintf(ring_name, sizeof(ring_name),  EFD_HASH_PREFIX "%s", table->name);
+	if (cc >= sizeof(ring_name)) {
+		EFD_LOG(ERR, "ring name '%s%s' overflow", EFD_HASH_PREFIX, table->name);
+		rte_efd_free(table);
+		return NULL;
+	}
+
 	/* Create ring (Dummy slot index is not enqueued) */
 	r = rte_ring_create(ring_name, rte_align32pow2(table->max_num_rules),
 			offline_cpu_socket, 0);
-- 
2.51.0

