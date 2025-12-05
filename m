Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DAF1D37497
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Dec 2025 20:16:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CEF5540611;
	Fri,  5 Dec 2025 21:15:50 +0100 (CET)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50]) by mails.dpdk.org (Postfix) with ESMTP id 27F19402E7
 for <dev@dpdk.org>; Fri,  5 Dec 2025 21:15:49 +0100 (CET)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-47755de027eso19349175e9.0
 for <dev@dpdk.org>; Fri, 05 Dec 2025 12:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764965749;
 x=1765570549; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oJo368/UQzn00lezaTkcU4584LL8nl6sWNn8Tc1vDYE=;
 b=axWdglqWTZOgU64Kb03ejopMY8w1NdvdRNuq2+jqpolap/D7GAbUmZWN9qocF7kPoY
 CHgb8y17NA+/E8gukIDE3TrweP3eWAZC7Ka3XgffiJUUFgwmOFoI3HLgtC5IQNV+7hSI
 p8JktD6bkMGT/mPQRwBz+0cTCIUWdUWU24GvZsuphIQVA+4dWpfG8jKTo1paX67WMCax
 UFiKAryUezurzDmLzTaPv4Y0QsFnYvmFAEh7YJvrK4F26gaLsS7GEaDiZNJJ2hzNCQXf
 pcLchY/9a2eOyi6ZAkdGYxzQMcXlVn88gJQoRrNyVm7uel1U9CvOzChapagFqso1e7Qr
 UptA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764965749; x=1765570549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oJo368/UQzn00lezaTkcU4584LL8nl6sWNn8Tc1vDYE=;
 b=qr0941vVUGLc/V+mMq+CdkHvNNyoTBe7n4LZpctBDp2bS4WgPondQ4fIux/tHD622s
 4pH3FG4WX64xFJhMVxRTx4JrHGpAVcTTGS1sWvPSZR61BaoAGvr9fRqJltsmigOR4io+
 14FsUUuDRZZZ7NjUWmJ4zOOoN/HNpxlM9q2d7jcZlzT3jWytkr+uy7jxS6JEazNsHHC0
 ENwTo18XtJqsMgrErPKVA4GimSuKbo5ylLKhkSM8e714R15zUU22SiPMk4CQmdpJFPG5
 7T7+3p3e4wv3w9omP7G4/VfGJWNmxCrIcc+ZLFKyRAMXtJR499B2FE4lR5walj5FJtE0
 9eUQ==
X-Gm-Message-State: AOJu0Yw/+rs+IZ9K1UDQ+NkPrgFV8/FH65Q6VrF+vVC4GZTsR4qsrvay
 yQUDxTEb6TTZpeoNl25hcQQ2EozGHzboCVIbG9bxoKzT8qcUJM5dPNJIrChnRl1cO1VmJKP0iSJ
 GRMr2
X-Gm-Gg: ASbGncvkE/2pHNb4R8s+DLtzK7dD77Jvfyzp94DYXIfNiET9AC4ZDxB1ugvmWFr86P/
 fF7gyyFKC76dGTEpwecx8vV03F5jb/OVGzQ+HCSi5Yk2tMKhmbgyFHBQ07lRWPCX4lgvGtulh0G
 tRhWBhdRLI69GEoX9tRwV81Fk5D5sqQKXmqYxRZooqYRXDeISqxTD69wf0wma5dJ5FEnpZ5M1dT
 /Gf+ke0oBnGJte6HB/zE5qzwQ2HbhQJFNuXzlpN0D0hRSF0e9NSv9vJ/M6p3NqHgJJ32efBQvvy
 RBBhNbo2A7Q2Swos10t5dSdo/JwvM5t7fk1pG5vXZryqulYbTNMccT9bx9uI43J2weihO718mVr
 571CPhAqYpjZ2/8xUpkY3zhUcage4wo/sGDBU1FJYPgLe9Z6RCk8sA5H/hhTWETHsKcmECjJpz5
 gvPDU6/D1lqdt0M8qpBgWX2Nz9hJE+2lm2/37W/H5GufZ0rgdiW7g0bUkMh8sR
X-Google-Smtp-Source: AGHT+IHg1BaiOsRZgk1gpxum7x4u7BjYsUrMoZHS0J9cwklV8oJdetymE4GD5F0TFG4kUJ8WkwQY+w==
X-Received: by 2002:a05:600c:314e:b0:46e:4a30:2b0f with SMTP id
 5b1f17b1804b1-47939e49126mr4685435e9.29.1764965748659; 
 Fri, 05 Dec 2025 12:15:48 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47935fce542sm45344875e9.0.2025.12.05.12.15.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Dec 2025 12:15:48 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v3 03/16] hash: add checks for hash name length
Date: Fri,  5 Dec 2025 12:11:32 -0800
Message-ID: <20251205201537.251131-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251205201537.251131-1-stephen@networkplumber.org>
References: <20251205022948.327743-1-stephen@networkplumber.org>
 <20251205201537.251131-1-stephen@networkplumber.org>
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

Add a missing check to the API that the name is within the current
defined maximum name size. This name is then used internally to
create ring names, those names could get truncated; if a name
is truncated add message to log.

If ring creation fails it might be because of name conflict,
so change the log message to decode error value.

Add additional tests as well.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_hash.c                   | 21 +++++++++++++
 doc/guides/rel_notes/release_26_03.rst |  3 ++
 lib/hash/rte_cuckoo_hash.c             | 41 ++++++++++++++++++--------
 lib/hash/rte_fbk_hash.c                | 13 ++++++--
 4 files changed, 64 insertions(+), 14 deletions(-)

diff --git a/app/test/test_hash.c b/app/test/test_hash.c
index 5791fd7f4c..0b608a3d74 100644
--- a/app/test/test_hash.c
+++ b/app/test/test_hash.c
@@ -1120,6 +1120,14 @@ fbk_hash_unit_test(void)
 		.socket_id = RTE_MAX_NUMA_NODES + 1, /* invalid socket */
 	};
 
+	/* try and create hash with an excessively long name */
+	struct rte_fbk_hash_params invalid_params_long_name = {
+		.name = "four_byte_key_hash_name_length_32",
+		.entries = 4,
+		.entries_per_bucket = 2,
+		.socket_id = 0,
+	};
+
 	/* try to create two hashes with identical names
 	 * in this case, trying to create a second one will not
 	 * fail but will simply return pointer to the existing
@@ -1201,6 +1209,9 @@ fbk_hash_unit_test(void)
 	handle = rte_fbk_hash_create(&invalid_params_7);
 	RETURN_IF_ERROR_FBK(handle != NULL, "fbk hash creation should have failed");
 
+	handle = rte_fbk_hash_create(&invalid_params_long_name);
+	RETURN_IF_ERROR_FBK(handle != NULL, "fbk hash creation should have failed");
+
 	if (rte_eal_has_hugepages()) {
 		handle = rte_fbk_hash_create(&invalid_params_8);
 		RETURN_IF_ERROR_FBK(handle != NULL,
@@ -1439,6 +1450,16 @@ static int test_hash_creation_with_bad_parameters(void)
 		return -1;
 	}
 
+	memcpy(&params, &ut_params, sizeof(params));
+	params.name = "hash_creation_with_too_long_name";
+	params.socket_id = RTE_MAX_NUMA_NODES + 1;
+	handle = rte_hash_create(&params);
+	if (handle != NULL) {
+		rte_hash_free(handle);
+		printf("Impossible creating hash successfully with long name\n");
+		return -1;
+	}
+
 	/* test with same name should fail */
 	memcpy(&params, &ut_params, sizeof(params));
 	params.name = "same_name";
diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index 15dabee7a1..a12bd41e86 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -84,6 +84,9 @@ API Changes
    Also, make sure to start the actual text at the margin.
    =======================================================
 
+* hash: Added name length validation to hash creation.
+  The hash name in hash parameters is now checked against RTE_HASH_NAMESIZE.
+
 
 ABI Changes
 -----------
diff --git a/lib/hash/rte_cuckoo_hash.c b/lib/hash/rte_cuckoo_hash.c
index 2c92c51624..f9c4a0e302 100644
--- a/lib/hash/rte_cuckoo_hash.c
+++ b/lib/hash/rte_cuckoo_hash.c
@@ -170,7 +170,6 @@ rte_hash_create(const struct rte_hash_parameters *params)
 	void *buckets = NULL;
 	void *buckets_ext = NULL;
 	char ring_name[RTE_RING_NAMESIZE];
-	char ext_ring_name[RTE_RING_NAMESIZE];
 	unsigned num_key_slots;
 	unsigned int hw_trans_mem_support = 0, use_local_cache = 0;
 	unsigned int ext_table_support = 0;
@@ -222,6 +221,13 @@ rte_hash_create(const struct rte_hash_parameters *params)
 		return NULL;
 	}
 
+	if (strlen(params->name) >= RTE_HASH_NAMESIZE) {
+		rte_errno = ENAMETOOLONG;
+		HASH_LOG(ERR, "%s() name '%s' exceeds maximum length %d",
+			 __func__, params->name, RTE_HASH_NAMESIZE);
+		return NULL;
+	}
+
 	/* Validate correct usage of extra options */
 	if ((params->extra_flag & RTE_HASH_EXTRA_FLAGS_RW_CONCURRENCY) &&
 	    (params->extra_flag & RTE_HASH_EXTRA_FLAGS_RW_CONCURRENCY_LF)) {
@@ -272,12 +278,16 @@ rte_hash_create(const struct rte_hash_parameters *params)
 	else
 		num_key_slots = params->entries + 1;
 
-	snprintf(ring_name, sizeof(ring_name), "HT_%s", params->name);
+	/* Ring name may get truncated, conflict detected on ring creation */
+	if (snprintf(ring_name, sizeof(ring_name), "HT_%s", params->name)
+	    >= (int)sizeof(ring_name))
+		HASH_LOG(NOTICE, "ring name truncated to '%s'", ring_name);
+
 	/* Create ring (Dummy slot index is not enqueued) */
 	r = rte_ring_create_elem(ring_name, sizeof(uint32_t),
 			rte_align32pow2(num_key_slots), params->socket_id, 0);
 	if (r == NULL) {
-		HASH_LOG(ERR, "memory allocation failed");
+		HASH_LOG(ERR, "ring creation failed: %s", rte_strerror(rte_errno));
 		goto err;
 	}
 
@@ -286,20 +296,25 @@ rte_hash_create(const struct rte_hash_parameters *params)
 
 	/* Create ring for extendable buckets. */
 	if (ext_table_support) {
-		snprintf(ext_ring_name, sizeof(ext_ring_name), "HT_EXT_%s",
-								params->name);
+		char ext_ring_name[RTE_RING_NAMESIZE];
+
+		if (snprintf(ext_ring_name, sizeof(ext_ring_name),
+			     "HT_EXT_%s", params->name) >= (int)sizeof(ext_ring_name))
+			HASH_LOG(NOTICE, "external ring name truncated to '%s'", ext_ring_name);
+
 		r_ext = rte_ring_create_elem(ext_ring_name, sizeof(uint32_t),
 				rte_align32pow2(num_buckets + 1),
 				params->socket_id, 0);
-
 		if (r_ext == NULL) {
-			HASH_LOG(ERR, "ext buckets memory allocation "
-								"failed");
+			HASH_LOG(ERR, "ext buckets ring create failed: %s",
+				 rte_strerror(rte_errno));
 			goto err;
 		}
 	}
 
-	snprintf(hash_name, sizeof(hash_name), "HT_%s", params->name);
+	if (snprintf(hash_name, sizeof(hash_name), "HT_%s", params->name)
+	    >= (int)sizeof(hash_name))
+		HASH_LOG(NOTICE, "%s() hash name truncated to '%s'", __func__, hash_name);
 
 	rte_mcfg_tailq_write_lock();
 
@@ -1606,8 +1621,9 @@ rte_hash_rcu_qsbr_add(struct rte_hash *h, struct rte_hash_rcu_config *cfg)
 		/* No other things to do. */
 	} else if (cfg->mode == RTE_HASH_QSBR_MODE_DQ) {
 		/* Init QSBR defer queue. */
-		snprintf(rcu_dq_name, sizeof(rcu_dq_name),
-					"HASH_RCU_%s", h->name);
+		if (snprintf(rcu_dq_name, sizeof(rcu_dq_name),
+			     "HASH_RCU_%s", h->name) >= (int)sizeof(rcu_dq_name))
+			HASH_LOG(NOTICE, "HASH defer queue name truncated to: %s", rcu_dq_name);
 		params.name = rcu_dq_name;
 		params.size = cfg->dq_size;
 		if (params.size == 0)
@@ -1623,7 +1639,8 @@ rte_hash_rcu_qsbr_add(struct rte_hash *h, struct rte_hash_rcu_config *cfg)
 		h->dq = rte_rcu_qsbr_dq_create(&params);
 		if (h->dq == NULL) {
 			rte_free(hash_rcu_cfg);
-			HASH_LOG(ERR, "HASH defer queue creation failed");
+			HASH_LOG(ERR, "HASH defer queue creation failed: %s",
+				 rte_strerror(rte_errno));
 			return 1;
 		}
 	} else {
diff --git a/lib/hash/rte_fbk_hash.c b/lib/hash/rte_fbk_hash.c
index 38b15a14d1..f60fad3caa 100644
--- a/lib/hash/rte_fbk_hash.c
+++ b/lib/hash/rte_fbk_hash.c
@@ -83,7 +83,7 @@ rte_fbk_hash_create(const struct rte_fbk_hash_params *params)
 {
 	struct rte_fbk_hash_table *ht = NULL;
 	struct rte_tailq_entry *te;
-	char hash_name[RTE_FBK_HASH_NAMESIZE];
+	char *hash_name = NULL;
 	const uint32_t mem_size =
 			sizeof(*ht) + (sizeof(ht->t[0]) * params->entries);
 	uint32_t i;
@@ -96,6 +96,7 @@ rte_fbk_hash_create(const struct rte_fbk_hash_params *params)
 	/* Error checking of parameters. */
 	if ((!rte_is_power_of_2(params->entries)) ||
 			(!rte_is_power_of_2(params->entries_per_bucket)) ||
+			(params->name == NULL) ||
 			(params->entries == 0) ||
 			(params->entries_per_bucket == 0) ||
 			(params->entries_per_bucket > params->entries) ||
@@ -105,7 +106,14 @@ rte_fbk_hash_create(const struct rte_fbk_hash_params *params)
 		return NULL;
 	}
 
-	snprintf(hash_name, sizeof(hash_name), "FBK_%s", params->name);
+	if (strlen(params->name) >= RTE_FBK_HASH_NAMESIZE) {
+		rte_errno = ENAMETOOLONG;
+		return NULL;
+	}
+
+	/* don't care if hash_name is NULL */
+	int unused __rte_unused;
+	unused = asprintf(&hash_name, "FBK_%s", params->name);
 
 	rte_mcfg_tailq_write_lock();
 
@@ -170,6 +178,7 @@ rte_fbk_hash_create(const struct rte_fbk_hash_params *params)
 
 exit:
 	rte_mcfg_tailq_write_unlock();
+	free(hash_name);
 
 	return ht;
 }
-- 
2.51.0

